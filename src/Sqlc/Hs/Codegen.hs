{-# LANGUAGE TemplateHaskell #-}

module Sqlc.Hs.Codegen
  ( File (..),
    codegen,
  )
where

import Data.FileEmbed qualified
import Data.ProtoLens.Labels ()
import Proto.Protos.Codegen qualified
import Sqlc.Hs.Config (Config (..), HaskellType (..))
import Sqlc.Hs.Resolve
  ( ResolveName,
    ResolveType,
    ResolvedNames (..),
    determineInternalModule,
    determineTopLevelModule,
    determineTypesModule,
    mangleQuery,
    newEnumResolver,
    newResolveType,
    resolveQueryName,
    resolveType,
  )
import System.Exit qualified
import System.IO qualified
import Text.EDE qualified

-- | 'File' represents a logical file in the file in the files
-- we generate.
data File = File
  { name :: Text,
    contents :: ByteString
  }

-- | Similar to a file but representing exactly one Haskell module.
data Module = Module
  { -- | Module name, e.g. Sqlc.Hs.Codegen
    name :: Text,
    -- | File name, e.g. Sqlc/Hs/Codegen.hs
    fileName :: Text,
    -- | The types that this module imports.
    importedTypes :: [HaskellType],
    -- | The contents in bytes. This is valid Haskell code.
    contents :: ByteString
  }

codegen :: Config -> Proto.Protos.Codegen.GenerateRequest -> IO [File]
codegen config generateRequest = do
  typesModule <-
    codegenTypes
      (generateRequest ^. #settings . #engine)
      internalName
      typesName
      resolveName
      (generateRequest ^. #catalog . #schemas)

  let resolveType =
        newResolveType config (generateRequest ^. #settings . #engine)
          <> newEnumResolver
            ( HaskellType
                { module' = Just typesModule.name,
                  package = Nothing,
                  name = Nothing
                }
            )
            [ enum
              | schema <- generateRequest ^. #catalog . #schemas,
                enum <- schema ^. #enums
            ]

  modules <-
    traverse
      ( codegenQuery
          (generateRequest ^. #settings . #engine)
          internalName
          resolveName
          resolveType
      )
      (toList (generateRequest ^. #queries))

  toplevelModule <-
    codegenToplevel toplevelName internalName typesName modules

  internalModule <-
    codegenInternal (generateRequest ^. #settings . #engine) internalName

  let generatedModules =
        toplevelModule : typesModule : internalModule : modules

  cabalPackageFile <-
    codegenCabalFile config generatedModules

  pure (cabalPackageFile <> map moduleToFile generatedModules)
  where
    resolveName =
      resolveQueryName config.haskellModulePrefix

    toplevelName =
      determineTopLevelModule config.haskellModulePrefix

    internalName =
      determineInternalModule config.haskellModulePrefix

    typesName =
      determineTypesModule config.haskellModulePrefix

moduleToFile :: Module -> File
moduleToFile module_ =
  File
    { name = module_.fileName,
      contents = module_.contents
    }

codegenToplevel ::
  -- | ResolvedName of the toplevel module name
  ResolvedNames ->
  -- | ResolvedName of the internal module name
  ResolvedNames ->
  -- | ResolvedName of the types module name
  ResolvedNames ->
  [Module] ->
  IO Module
codegenToplevel toplevel internal types modulesToReexport = do
  let context =
        Text.EDE.fromPairs
          [ "moduleName" Text.EDE..= toplevel.toHaskellModuleName,
            "internalModuleName" Text.EDE..= internal.toHaskellModuleName,
            "typesModuleName" Text.EDE..= types.toHaskellModuleName,
            "modules" Text.EDE..= fmap (.name) modulesToReexport
          ]

  pure
    Module
      { name = toplevel.toHaskellModuleName,
        fileName = toplevel.toHaskellFileName,
        importedTypes = [],
        contents = contents context
      }
  where
    contents context =
      case Text.EDE.render toplevelTemplate context of
        Text.EDE.Success output ->
          encodeUtf8 (toStrict @LText @Text output)
        Text.EDE.Failure errorDoc ->
          error (show errorDoc)

codegenInternal ::
  Text ->
  -- | ResolvedName of the internal module name
  ResolvedNames ->
  IO Module
codegenInternal engine internal = do
  let context =
        Text.EDE.fromPairs
          [ "moduleName" Text.EDE..= internal.toHaskellModuleName
          ]

  pure
    Module
      { name = internal.toHaskellModuleName,
        fileName = internal.toHaskellFileName,
        importedTypes =
          [ HaskellType {package = Just "base", module' = Nothing, name = Nothing},
            HaskellType {package = Just "bytestring", module' = Nothing, name = Nothing},
            HaskellType {package = Just "text", module' = Nothing, name = Nothing}
          ]
            <> dependencies,
        contents = contents context
      }
  where
    (template, dependencies) =
      case engine of
        "sqlite" ->
          ( internalSqliteTemplate,
            [ HaskellType {package = Just "sqlite-simple", module' = Just "Database.SQLite.Simple", name = Just "ToRow"},
              HaskellType {package = Just "sqlite-simple", module' = Just "Database.SQLite.Simple", name = Just "FromRow"},
              HaskellType {package = Just "vector", module' = Just "Data.Vector", name = Just "Vector"}
            ]
          )
        "mysql" ->
          ( internalMysqlTemplate,
            [ HaskellType {package = Just "mysql-simple", module' = Just "Database.MySQL.Simple", name = Just "ToRow"},
              HaskellType {package = Just "mysql-simple", module' = Just "Database.MySQL.Simple", name = Just "FromRow"}
            ]
          )
        _ ->
          ( internalPostgresTemplate,
            [ HaskellType {package = Just "postgresql-simple", module' = Just "Database.PostgreSQL.Simple", name = Just "ToRow"},
              HaskellType {package = Just "postgresql-simple", module' = Just "Database.PostgreSQL.Simple", name = Just "FromRow"},
              HaskellType {package = Just "vector", module' = Just "Data.Vector", name = Just "Vector"}
            ]
          )

    contents context =
      case Text.EDE.render template context of
        Text.EDE.Success output ->
          encodeUtf8 (toStrict @LText @Text output)
        Text.EDE.Failure errorDoc ->
          error (show errorDoc)

codegenCabalFile ::
  Config ->
  [Module] ->
  IO [File]
codegenCabalFile config generatedModules
  | Just packageName <- config.cabalPackageName = do
      let context =
            Text.EDE.fromPairs
              [ "packageName" Text.EDE..= packageName,
                "packageVersion" Text.EDE..= config.cabalPackageVersion,
                "buildDepends" Text.EDE..= buildDepends,
                "exposedModules" Text.EDE..= exposedModules,
                "defaultExtensions" Text.EDE..= defaultExtensions
              ]
      pure
        [ File
            { name = packageName <> ".cabal",
              contents = contents context
            }
        ]
  | otherwise =
      -- No cabal file requested
      pure []
  where
    contents context =
      case Text.EDE.render cabalTemplate context of
        Text.EDE.Success output ->
          encodeUtf8 (toStrict @LText @Text output)
        Text.EDE.Failure errorDoc ->
          error (show errorDoc)

    buildDepends :: [Text]
    buildDepends =
      sort $
        ordNub $
          mapMaybe
            (.package)
            (concatMap (.importedTypes) generatedModules)

    exposedModules :: [Text]
    exposedModules =
      sort $
        map
          (.name)
          generatedModules

    defaultExtensions :: [Text]
    defaultExtensions =
      sort (ordNub config.cabalDefaultExtensions)

codegenTypes ::
  -- | Engine, if defined
  Text ->
  -- | ResolvedName of the internal module
  ResolvedNames ->
  -- | ResolvedName of the types module
  ResolvedNames ->
  ResolveName ->
  [Proto.Protos.Codegen.Schema] ->
  IO Module
codegenTypes engine internalModule typesModule resolveName schemas = do
  let context =
        Text.EDE.fromPairs
          [ "generatePostgresql" Text.EDE..= (engine == "postgresql"),
            "generateSqlite" Text.EDE..= (engine == "sqlite"),
            "generateMysql" Text.EDE..= (engine == "mysql"),
            "moduleName" Text.EDE..= typesModule.toHaskellModuleName,
            "internalModuleName" Text.EDE..= internalModule.toHaskellModuleName,
            "enums"
              Text.EDE..= [ Text.EDE.fromPairs
                              [ "escapedEnumName" Text.EDE..= show @Text (enum ^. #name),
                                "values"
                                  Text.EDE..= [ Text.EDE.fromPairs
                                                  [ "escapedEnumValue" Text.EDE..= show @Text value,
                                                    "haskellConstructorName" Text.EDE..= (resolveName value).toEnumConstructorName (enum ^. #name)
                                                  ]
                                                | value <- toList (enum ^. #vals)
                                              ]
                              ]
                            | schema <-
                                schemas,
                              enum <-
                                schema ^. #enums,
                              (schema ^. #name) `notElem` ["pg_catalog", "information_schema"]
                          ]
          ]

  pure
    Module
      { name = typesModule.toHaskellModuleName,
        fileName = typesModule.toHaskellFileName,
        importedTypes = [],
        contents = contents context
      }
  where
    contents context =
      case Text.EDE.render typesTemplate context of
        Text.EDE.Success output ->
          encodeUtf8 (toStrict @LText @Text output)
        Text.EDE.Failure errorDoc ->
          error (show errorDoc)

-- | Generate a file for a single query. This returns the resolved 'HaskellType's so
-- that we can generate the necessary build-depends for the cabal file.
codegenQuery ::
  -- | Engine, if defined
  Text ->
  -- | ResolvedName of the internal module name
  ResolvedNames ->
  ResolveName ->
  ResolveType ->
  Proto.Protos.Codegen.Query ->
  IO Module
codegenQuery engine internalModule resolveName resolver query = do
  let resolvedName =
        resolveName (query ^. #name)

  parameterColumns <-
    forM (query ^. #params) $ \parameter -> do
      whenNothing (resolveType resolver (parameter ^. #column)) $
        couldNotResolveType (parameter ^. #column)

  resultColumns <-
    forM (query ^. #columns) $ \column -> do
      whenNothing (resolveType resolver column) $
        couldNotResolveType column

  let importedTypes :: [HaskellType]
      importedTypes =
        foldMap (toList . snd) parameterColumns
          <> foldMap (toList . snd) resultColumns
          <> [ HaskellType {package = Just "base", module' = Just "Data.Foldable", name = Nothing}
             ]

      -- Modules that the query module needs to import.
      imports :: [Text]
      imports =
        ordNub $
          mapMaybe (.module') importedTypes

      context =
        Text.EDE.fromPairs
          [ "generatePostgresql" Text.EDE..= (engine == "postgresql"),
            "generateSqlite" Text.EDE..= (engine == "sqlite"),
            "generateMysql" Text.EDE..= (engine == "mysql"),
            "sourceFile" Text.EDE..= (query ^. #filename),
            "moduleName" Text.EDE..= resolvedName.toHaskellModuleName,
            "moduleImports" Text.EDE..= imports,
            "internalModuleName" Text.EDE..= internalModule.toHaskellModuleName,
            "command" Text.EDE..= (query ^. #cmd),
            "haskellQueryName" Text.EDE..= resolvedName.toQueryDeclarationName,
            "haskellParamsName" Text.EDE..= resolvedName.toParamsConstructorDeclarationName,
            "haskellResultName" Text.EDE..= resolvedName.toResultConstructorDeclarationName,
            "escapedQueryName" Text.EDE..= show @Text (query ^. #name),
            "escapedCommand" Text.EDE..= show @Text (query ^. #cmd),
            "escapedSql" Text.EDE..= show @Text mangledQuery,
            "parameterColumns" Text.EDE..= fmap toParameterColumn parameterColumns,
            "resultColumns" Text.EDE..= fmap toResultColumn resultColumns
          ]

  pure
    Module
      { name = resolvedName.toHaskellModuleName,
        fileName = resolvedName.toHaskellFileName,
        importedTypes,
        contents = contents context
      }
  where
    mangledQuery =
      mangleQuery (query ^. #text)

    contents context =
      case Text.EDE.render queryTemplate context of
        Text.EDE.Success output ->
          encodeUtf8 (toStrict @LText @Text output)
        Text.EDE.Failure errorDoc ->
          error (show errorDoc)

    toParameterColumn (column, haskellType :| _) =
      Text.EDE.fromPairs
        [ "name" Text.EDE..= (resolveName (column ^. #name)).toFieldName column,
          "type" Text.EDE..= encodeColumnType haskellType,
          "notNull" Text.EDE..= (column ^. #notNull),
          "slice"
            Text.EDE..= if column ^. #isSqlcSlice
              then Just (show @Text ("/*SLICE:" <> column ^. #name <> "*/?"))
              else Nothing
        ]

    toResultColumn (column, haskellType :| _) =
      Text.EDE.fromPairs
        [ "name" Text.EDE..= (resolveName (column ^. #name)).toFieldName column,
          "type" Text.EDE..= encodeColumnType haskellType
        ]

    encodeColumnType haskellType =
      haskellType.name

    couldNotResolveType column = do
      System.IO.hPutStrLn System.IO.stderr $
        "Could not resolve type "
          <> show (column ^. #type')
          <> " for column "
          <> show (column ^. #name)
      System.Exit.exitWith (System.Exit.ExitFailure 1)

toplevelTemplate :: Text.EDE.Template
toplevelTemplate =
  case Text.EDE.parse template of
    Text.EDE.Success template ->
      template
    Text.EDE.Failure errorDoc ->
      error (show errorDoc)
  where
    template :: ByteString
    template =
      $(Data.FileEmbed.embedFile "templates/toplevel.hs.jinja")

queryTemplate :: Text.EDE.Template
queryTemplate =
  case Text.EDE.parse template of
    Text.EDE.Success template ->
      template
    Text.EDE.Failure errorDoc ->
      error (show errorDoc)
  where
    template :: ByteString
    template =
      $(Data.FileEmbed.embedFile "templates/query.hs.jinja")

typesTemplate :: Text.EDE.Template
typesTemplate =
  case Text.EDE.parse template of
    Text.EDE.Success template ->
      template
    Text.EDE.Failure errorDoc ->
      error (show errorDoc)
  where
    template :: ByteString
    template =
      $(Data.FileEmbed.embedFile "templates/types.hs.jinja")

internalPostgresTemplate :: Text.EDE.Template
internalPostgresTemplate =
  case Text.EDE.parse template of
    Text.EDE.Success template ->
      template
    Text.EDE.Failure errorDoc ->
      error (show errorDoc)
  where
    template :: ByteString
    template =
      $(Data.FileEmbed.embedFile "templates/internal.postgresql.hs.jinja")

internalMysqlTemplate :: Text.EDE.Template
internalMysqlTemplate =
  case Text.EDE.parse template of
    Text.EDE.Success template ->
      template
    Text.EDE.Failure errorDoc ->
      error (show errorDoc)
  where
    template :: ByteString
    template =
      $(Data.FileEmbed.embedFile "templates/internal.mysql.hs.jinja")

internalSqliteTemplate :: Text.EDE.Template
internalSqliteTemplate =
  case Text.EDE.parse template of
    Text.EDE.Success template ->
      template
    Text.EDE.Failure errorDoc ->
      error (show errorDoc)
  where
    template :: ByteString
    template =
      $(Data.FileEmbed.embedFile "templates/internal.sqlite.hs.jinja")

cabalTemplate :: Text.EDE.Template
cabalTemplate =
  case Text.EDE.parse template of
    Text.EDE.Success template ->
      template
    Text.EDE.Failure errorDoc ->
      error (show errorDoc)
  where
    template :: ByteString
    template =
      $(Data.FileEmbed.embedFile "templates/package.cabal.jinja")
