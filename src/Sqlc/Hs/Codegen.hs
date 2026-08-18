{-# LANGUAGE TemplateHaskell #-}

module Sqlc.Hs.Codegen
  ( File (..),
    codegen,
  )
where

import Data.FileEmbed qualified
import Data.List (lookup)
import Data.ProtoLens.Labels ()
import Proto.Protos.Codegen qualified
import Sqlc.Hs.Backend (Backend (..), resolveBackend)
import Sqlc.Hs.Config (Config (..), HaskellType (..), Override (..))
import Sqlc.Hs.Resolve
  ( ResolveName,
    ResolveType,
    ResolvedNames (..),
    determineInternalModule,
    determineTopLevelModule,
    determineTypesModule,
    findOverride,
    hasqlColumnCodec,
    mangleQuery,
    newBuiltinResolver,
    newEnumResolver,
    newOverrideResolver,
    queryParamBindings,
    resolveQueryName,
    resolveType,
    rewriteSlices,
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
  backend <-
    case resolveBackend engine config.driver of
      Left errorMessage -> do
        System.IO.hPutStrLn System.IO.stderr (toString errorMessage)
        System.Exit.exitWith (System.Exit.ExitFailure 1)
      Right backend ->
        pure backend

  typesModule <-
    codegenTypes
      backend
      internalName
      typesName
      resolveName
      (generateRequest ^. #catalog . #defaultSchema)
      (generateRequest ^. #catalog . #schemas)

  let resolveType =
        newOverrideResolver config engine
          <> newBuiltinResolver backend engine
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
          backend
          engine
          (findOverride config engine)
          internalName
          resolveName
          resolveType
      )
      (toList (generateRequest ^. #queries))

  toplevelModule <-
    codegenToplevel toplevelName internalName typesName modules

  internalModule <-
    codegenInternal backend internalName

  let generatedModules =
        toplevelModule : typesModule : internalModule : modules

  cabalPackageFile <-
    codegenCabalFile config generatedModules

  pure (cabalPackageFile <> map moduleToFile generatedModules)
  where
    engine =
      generateRequest ^. #settings . #engine

    resolveName =
      resolveQueryName config.naming config.haskellModulePrefix

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
  Maybe Backend ->
  -- | ResolvedName of the internal module name
  ResolvedNames ->
  IO Module
codegenInternal backend internal = do
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
      case backend of
        Just Sqlite ->
          ( internalSqliteTemplate,
            [ HaskellType {package = Just "sqlite-simple", module' = Just "Database.SQLite.Simple", name = Just "ToRow"},
              HaskellType {package = Just "sqlite-simple", module' = Just "Database.SQLite.Simple", name = Just "FromRow"},
              HaskellType {package = Just "vector", module' = Just "Data.Vector", name = Just "Vector"}
            ]
          )
        Just Mysql ->
          ( internalMysqlTemplate,
            [ HaskellType {package = Just "mysql-simple", module' = Just "Database.MySQL.Simple", name = Just "ToRow"},
              HaskellType {package = Just "mysql-simple", module' = Just "Database.MySQL.Simple", name = Just "FromRow"}
            ]
          )
        Just Hasql ->
          ( internalHasqlTemplate,
            -- The ToField/FromField instances the internal module ships cover
            -- the types the built-in mappings and the common overrides use.
            -- Every one of these packages is already in hasql's own dependency
            -- closure, so none of them costs an extra build.
            [ HaskellType {package = Just "hasql", module' = Just "Hasql.Session", name = Just "Session"},
              HaskellType {package = Just "aeson", module' = Just "Data.Aeson", name = Just "Value"},
              HaskellType {package = Just "scientific", module' = Just "Data.Scientific", name = Just "Scientific"},
              HaskellType {package = Just "time", module' = Just "Data.Time", name = Just "UTCTime"},
              HaskellType {package = Just "uuid", module' = Just "Data.UUID", name = Just "UUID"},
              HaskellType {package = Just "vector", module' = Just "Data.Vector", name = Just "Vector"}
            ]
          )
        -- Also the fallback for a request that reported no engine at all.
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
  Maybe Backend ->
  -- | ResolvedName of the internal module
  ResolvedNames ->
  -- | ResolvedName of the types module
  ResolvedNames ->
  ResolveName ->
  -- | The catalog's default schema, if reported
  Text ->
  [Proto.Protos.Codegen.Schema] ->
  IO Module
codegenTypes backend internalModule typesModule resolveName defaultSchema schemas = do
  let context =
        Text.EDE.fromPairs
          [ "generatePostgresql" Text.EDE..= (backend == Just PostgresqlSimple),
            "generateHasql" Text.EDE..= (backend == Just Hasql),
            "generateSqlite" Text.EDE..= (backend == Just Sqlite),
            "generateMysql" Text.EDE..= (backend == Just Mysql),
            "moduleName" Text.EDE..= typesModule.toHaskellModuleName,
            "internalModuleName" Text.EDE..= internalModule.toHaskellModuleName,
            "enums"
              Text.EDE..= [ Text.EDE.fromPairs
                              [ "escapedEnumName" Text.EDE..= show @Text (enum ^. #name),
                                "escapedEnumSchema" Text.EDE..= enumSchema (schema ^. #name),
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
    -- hasql resolves an enum's OID by name at runtime. An unqualified name is
    -- looked up through the search path, which is what we want for the default
    -- schema; anything else has to be qualified.
    enumSchema :: Text -> Text
    enumSchema schema
      | schema == mempty || schema == defaultSchemaName =
          "Prelude.Nothing"
      | otherwise =
          "(Prelude.Just " <> show @Text schema <> ")"

    defaultSchemaName
      | defaultSchema == mempty = "public"
      | otherwise = defaultSchema

    contents context =
      case Text.EDE.render typesTemplate context of
        Text.EDE.Success output ->
          encodeUtf8 (toStrict @LText @Text output)
        Text.EDE.Failure errorDoc ->
          error (show errorDoc)

-- | Generate a file for a single query. This returns the resolved 'HaskellType's so
-- that we can generate the necessary build-depends for the cabal file.
codegenQuery ::
  Maybe Backend ->
  -- | Engine, if defined
  Text ->
  -- | The override that matched a column, if any. Determines the hasql codec.
  (Proto.Protos.Codegen.Column -> Maybe Override) ->
  -- | ResolvedName of the internal module name
  ResolvedNames ->
  ResolveName ->
  ResolveType ->
  Proto.Protos.Codegen.Query ->
  IO Module
codegenQuery backend engine resolveOverride internalModule resolveName resolver query = do
  let resolvedName =
        resolveName (query ^. #name)

  parameterColumns :: [(Int32, (Proto.Protos.Codegen.Column, NonEmpty HaskellType))] <-
    forM (query ^. #params) $ \parameter -> do
      parameterColumn <-
        whenNothing (resolveType resolver (parameter ^. #column)) $
          couldNotResolveType (parameter ^. #column)
      pure (parameter ^. #number, parameterColumn)

  resultColumns <-
    forM (query ^. #columns) $ \column -> do
      whenNothing (resolveType resolver column) $
        couldNotResolveType column

  sql <-
    case backend of
      -- hasql speaks PostgreSQL's own numbered placeholders, so the SQL is
      -- passed through as sqlc emitted it. Slices are the exception: they
      -- become a single array parameter and need the array operators.
      Just Hasql ->
        case rewriteSlices (sliceNumbers parameterColumns) (query ^. #text) of
          Left errorMessage -> do
            System.IO.hPutStrLn System.IO.stderr $
              "In query "
                <> show (query ^. #name)
                <> ": "
                <> toString errorMessage
            System.Exit.exitWith (System.Exit.ExitFailure 1)
          Right sql ->
            pure sql
      _ ->
        pure (mangleQuery (query ^. #text))

  let importedTypes :: [HaskellType]
      importedTypes =
        foldMap (toList . snd . snd) parameterColumns
          <> foldMap (toList . snd) resultColumns
          <> [ HaskellType {package = Just "base", module' = Just "Data.Foldable", name = Nothing}
             ]
          <> case backend of
            -- The parameter encoders are assembled contravariantly.
            Just Hasql ->
              [HaskellType {package = Just "base", module' = Just "Data.Functor.Contravariant", name = Nothing}]
            _ ->
              []

      -- Modules that the query module needs to import.
      imports :: [Text]
      imports =
        ordNub $
          mapMaybe (.module') importedTypes

      context =
        Text.EDE.fromPairs
          [ "generatePostgresql" Text.EDE..= (backend == Just PostgresqlSimple),
            "generateHasql" Text.EDE..= (backend == Just Hasql),
            "generateSqlite" Text.EDE..= (backend == Just Sqlite),
            "generateMysql" Text.EDE..= (backend == Just Mysql),
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
            "escapedSql" Text.EDE..= show @Text sql,
            "parameterColumns" Text.EDE..= fmap (toParameterColumn . snd) parameterColumns,
            "queryColumns" Text.EDE..= fmap toParameterColumn (toQueryColumns parameterColumns),
            "encoderColumns" Text.EDE..= fmap (toParameterColumn . snd) (sortOn fst parameterColumns),
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
    sliceNumbers parameterColumns =
      [ fromIntegral number
        | (number, (column, _haskellTypes)) <- parameterColumns,
          column ^. #isSqlcSlice
      ]

    -- It's possible for parametes to appear in a query more than once.
    -- This function "zips" the occurrences in the query with the actual
    -- parameters.
    toQueryColumns :: [(Int32, parameterColumn)] -> [parameterColumn]
    toQueryColumns parameterColumns =
      mapMaybe
        ( \number ->
            lookup (fromIntegral number) parameterColumns
        )
        (queryParamBindings engine (query ^. #text))

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
          "encoder" Text.EDE..= fst (hasqlCodec column),
          "slice"
            Text.EDE..= if column ^. #isSqlcSlice
              then Just (show @Text ("/*SLICE:" <> column ^. #name <> "*/?"))
              else Nothing
        ]

    toResultColumn (column, haskellType :| _) =
      Text.EDE.fromPairs
        [ "name" Text.EDE..= (resolveName (column ^. #name)).toFieldName column,
          "type" Text.EDE..= encodeColumnType haskellType,
          "decoder" Text.EDE..= snd (hasqlCodec column)
        ]

    -- Only the hasql templates read the "encoder" and "decoder" fields.
    hasqlCodec column =
      case backend of
        Just Hasql -> hasqlColumnCodec (resolveOverride column) column
        _ -> (mempty, mempty)

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
  toTemplate $(Data.FileEmbed.embedFile "templates/toplevel.hs.jinja")

queryTemplate :: Text.EDE.Template
queryTemplate =
  toTemplate $(Data.FileEmbed.embedFile "templates/query.hs.jinja")

typesTemplate :: Text.EDE.Template
typesTemplate =
  toTemplate $(Data.FileEmbed.embedFile "templates/types.hs.jinja")

internalPostgresTemplate :: Text.EDE.Template
internalPostgresTemplate =
  toTemplate $(Data.FileEmbed.embedFile "templates/internal.postgresql.hs.jinja")

internalMysqlTemplate :: Text.EDE.Template
internalMysqlTemplate =
  toTemplate $(Data.FileEmbed.embedFile "templates/internal.mysql.hs.jinja")

internalSqliteTemplate :: Text.EDE.Template
internalSqliteTemplate =
  toTemplate $(Data.FileEmbed.embedFile "templates/internal.sqlite.hs.jinja")

internalHasqlTemplate :: Text.EDE.Template
internalHasqlTemplate =
  toTemplate $(Data.FileEmbed.embedFile "templates/internal.hasql.hs.jinja")

cabalTemplate :: Text.EDE.Template
cabalTemplate =
  toTemplate $(Data.FileEmbed.embedFile "templates/package.cabal.jinja")

toTemplate :: ByteString -> Text.EDE.Template
toTemplate template = do
  case Text.EDE.parse template of
    Text.EDE.Success template ->
      template
    Text.EDE.Failure errorDoc ->
      error (show errorDoc)
