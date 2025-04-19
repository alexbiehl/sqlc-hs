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
    newResolveType,
    resolveQueryName,
  )
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
  modules <-
    traverse
      (codegenQuery internalName resolveName resolveType)
      (toList (generateRequest ^. #queries))

  toplevelModule <-
    codegenToplevel toplevelName internalName modules

  internalModule <-
    codegenInternal (generateRequest ^. #settings . #engine) internalName

  let generatedModules =
        toplevelModule : internalModule : modules

  cabalPackageFile <-
    codegenCabalFile config generatedModules

  pure (cabalPackageFile <> map moduleToFile generatedModules)
  where
    resolveType =
      newResolveType config (generateRequest ^. #settings . #engine)

    resolveName =
      resolveQueryName config.haskellModulePrefix

    toplevelName =
      determineTopLevelModule config.haskellModulePrefix

    internalName =
      determineInternalModule config.haskellModulePrefix

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
  [Module] ->
  IO Module
codegenToplevel toplevel internal modulesToReexport = do
  let context =
        Text.EDE.fromPairs
          [ "moduleName" Text.EDE..= toplevel.toHaskellModuleName,
            "internalModuleName" Text.EDE..= internal.toHaskellModuleName,
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
        importedTypes = dependencies,
        contents = contents context
      }
  where
    (template, dependencies) =
      case engine of
        "sqlite" ->
          ( internalSqliteTemplate,
            [ HaskellType {package = "sqlite-simple", module' = "Database.SQLite.Simple", name = "ToRow"},
              HaskellType {package = "sqlite-simple", module' = "Database.SQLite.Simple", name = "FromRow"}
            ]
          )
        "mysql" ->
          ( internalMysqlTemplate,
            [ HaskellType {package = "mysql-simple", module' = "Database.MySQL.Simple", name = "ToRow"},
              HaskellType {package = "mysql-simple", module' = "Database.MySQL.Simple", name = "FromRow"}
            ]
          )
        _ ->
          ( internalPostgresTemplate,
            [ HaskellType {package = "postgresql-simple", module' = "Database.PostgreSQL.Simple", name = "ToRow"},
              HaskellType {package = "postgresql-simple", module' = "Database.PostgreSQL.Simple", name = "FromRow"},
              HaskellType {package = "vector", module' = "Data.Vector", name = "Vector"}
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
                "exposedModules" Text.EDE..= exposedModules
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
          map
            (.package)
            (concatMap (.importedTypes) generatedModules)

    exposedModules :: [Text]
    exposedModules =
      sort $
        map
          (.name)
          generatedModules

-- | Generate a file for a single query. This returns the resolved 'HaskellType's so
-- that we can generate the necessary build-depends for the cabal file.
codegenQuery ::
  -- | ResolvedName of the internal module name
  ResolvedNames ->
  ResolveName ->
  ResolveType ->
  Proto.Protos.Codegen.Query ->
  IO Module
codegenQuery internalModule resolveName resolveType query = do
  let resolvedName =
        resolveName (query ^. #name)

  parameterColumns <-
    forM (query ^. #params) $ \parameter -> do
      whenNothing (resolveType (parameter ^. #column)) $
        error "TODO"

  resultColumns <-
    forM (query ^. #columns) $ \column -> do
      whenNothing (resolveType column) $
        error "TODO"

  let importedTypes :: [HaskellType]
      importedTypes =
        fmap snd (toList parameterColumns) <> fmap snd (toList resultColumns)

      -- Modules that the query module needs to import.
      imports :: [Text]
      imports =
        ordNub $
          fmap (.module') importedTypes

      context =
        Text.EDE.fromPairs
          [ "sourceFile" Text.EDE..= (query ^. #filename),
            "moduleName" Text.EDE..= resolvedName.toHaskellModuleName,
            "moduleImports" Text.EDE..= imports,
            "internalModuleName" Text.EDE..= internalModule.toHaskellModuleName,
            "command" Text.EDE..= (query ^. #cmd),
            "haskellQueryName" Text.EDE..= resolvedName.toQueryDeclarationName,
            "haskellParamsName" Text.EDE..= resolvedName.toParamsConstructorDeclarationName,
            "haskellResultName" Text.EDE..= resolvedName.toResultConstructorDeclarationName,
            "escapedQueryName" Text.EDE..= show @Text (query ^. #name),
            "escapedCommand" Text.EDE..= show @Text (query ^. #cmd),
            "escapedSql" Text.EDE..= show @Text (query ^. #text),
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
    contents context =
      case Text.EDE.render queryTemplate context of
        Text.EDE.Success output ->
          encodeUtf8 (toStrict @LText @Text output)
        Text.EDE.Failure errorDoc ->
          error (show errorDoc)

    toParameterColumn (column, haskellType) =
      Text.EDE.fromPairs
        [ "name" Text.EDE..= (column ^. #name),
          "type" Text.EDE..= encodeColumnType haskellType
        ]

    toResultColumn (column, haskellType) =
      Text.EDE.fromPairs
        [ "name" Text.EDE..= (column ^. #name),
          "type" Text.EDE..= encodeColumnType haskellType
        ]

    encodeColumnType haskellType =
      haskellType.name

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
