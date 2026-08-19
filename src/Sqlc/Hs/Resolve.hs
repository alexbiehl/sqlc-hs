module Sqlc.Hs.Resolve
  ( ResolveType,
    resolveType,
    newOverrideResolver,
    newBuiltinResolver,
    newEnumResolver,
    findOverride,
    -- | How to resolve names to Haskell modules and files
    ResolveName,
    ResolvedNames (..),
    resolveQueryName,
    -- | Misc. modules
    determineTopLevelModule,
    determineInternalModule,
    determineTypesModule,
    -- | Query mangling
    mangleQuery,
    queryParamBindings,
    rewriteSlices,
    -- | hasql codecs
    hasqlColumnCodec,
  )
where

import Data.Char qualified
import Data.List qualified
import Data.ProtoLens.Labels ()
import Data.Text qualified
import Data.Vector (Vector)
import Proto.Protos.Codegen qualified
import Sqlc.Hs.Backend (Backend (..))
import Sqlc.Hs.Config (Config (..), HaskellType (..), Naming (..), Override (..), defaultConfig)
import Sqlc.Hs.NameTemplate qualified
import System.FilePath ((<.>))

determineTopLevelModule ::
  -- | Haskell module prefix. E.g. "Data.Queries".
  Maybe Text ->
  ResolvedNames
determineTopLevelModule haskellModulePrefix =
  resolveQueryName
    mempty
    Nothing
    (fromMaybe "Queries" (haskellModulePrefix <|> defaultConfig.haskellModulePrefix))

determineInternalModule ::
  -- | Haskell module prefix. E.g. "Data.Queries".
  Maybe Text ->
  ResolvedNames
determineInternalModule haskellModulePrefix =
  resolveQueryName
    mempty
    (haskellModulePrefix <|> defaultConfig.haskellModulePrefix <|> Just "Queries")
    "Internal"

determineTypesModule ::
  -- | Haskell module prefix. E.g. "Data.Queries".
  Maybe Text ->
  ResolvedNames
determineTypesModule haskellModulePrefix =
  resolveQueryName
    mempty
    (haskellModulePrefix <|> defaultConfig.haskellModulePrefix <|> Just "Queries")
    "Types"

data ResolvedNames = ResolvedNames
  { toQueryDeclarationName :: Text,
    toParamsConstructorDeclarationName :: Text,
    toResultConstructorDeclarationName :: Text,
    toHaskellFileName :: Text,
    toHaskellModuleName :: Text,
    toFieldName :: Proto.Protos.Codegen.Column -> Text,
    toEnumConstructorName :: Text -> Text
  }

type ResolveName = Text -> ResolvedNames

resolveQueryName ::
  -- | Name templates. 'mempty' renders the historical names.
  Naming ->
  -- | Haskell module prefix. E.g. "Data.Queries".
  Maybe Text ->
  -- | Name to resolve
  Text ->
  ResolvedNames
resolveQueryName naming haskellModulePrefix name =
  ResolvedNames
    { toQueryDeclarationName =
        -- This generates
        --
        -- query_GetAuthors :: ...
        --
        -- in the query modules.
        asVariableName $
          renderName naming.query "query_{{query}}" [("query", name)],
      toParamsConstructorDeclarationName =
        asConstructorName $
          renderName naming.paramsConstructor "Params_{{query}}" [("query", name)],
      toResultConstructorDeclarationName =
        asConstructorName $
          renderName naming.resultConstructor "Result_{{query}}" [("query", name)],
      toEnumConstructorName = \typename ->
        asConstructorName $
          renderName
            naming.enumConstructor
            "Enum_{{enum}}_{{value}}"
            [("enum", typename), ("value", name)],
      toFieldName,
      toHaskellFileName =
        toText $
          toString (haskellModuleToPath (applyHaskellModulePrefix nameToHaskellModuleName)) <.> "hs",
      toHaskellModuleName =
        applyHaskellModulePrefix nameToHaskellModuleName
    }
  where
    nameToHaskellModuleName =
      sanitizedModuleName

    haskellModuleToPath :: Text -> Text
    haskellModuleToPath =
      Data.Text.intercalate "/" . Data.Text.splitOn "."

    applyHaskellModulePrefix :: Text -> Text
    applyHaskellModulePrefix =
      case haskellModulePrefix of
        Just prefix ->
          \suffix ->
            Data.Text.intercalate "." $
              Data.Text.splitOn "." prefix <> Data.Text.splitOn "." suffix
        Nothing ->
          identity

    -- Render a name template against its context: the configured template if
    -- present, the default (historical) template otherwise.
    renderName :: Maybe Text -> Text -> [(Text, Text)] -> Text
    renderName template fallback context =
      Sqlc.Hs.NameTemplate.render context (fromMaybe fallback template)

    -- Rendered names must come out as valid Haskell identifiers regardless of
    -- the template: sanitize the characters, then fix up the first character
    -- for the identifier flavour. Both are identities on the names the
    -- default templates render.
    asVariableName :: Text -> Text
    asVariableName rendered =
      case Data.Text.uncons (sanitizeHaskellIdentifier rendered) of
        Nothing ->
          "_"
        Just (c, rest)
          | Data.Char.isDigit c ->
              "_" <> Data.Text.cons c rest
          | Data.Char.isUpper c ->
              Data.Char.toLower c `Data.Text.cons` rest
          | otherwise ->
              Data.Text.cons c rest

    asConstructorName :: Text -> Text
    asConstructorName rendered =
      case Data.Text.uncons (sanitizeHaskellIdentifier rendered) of
        Nothing ->
          "C"
        Just (c, rest)
          | Data.Char.isLower c ->
              Data.Char.toUpper c `Data.Text.cons` rest
          | Data.Char.isUpper c ->
              Data.Text.cons c rest
          | otherwise ->
              -- Digits and underscores cannot start a constructor.
              "C" <> Data.Text.cons c rest

    -- A version of the name suitable for use as a Haskell module name.
    sanitizedModuleName :: Text
    sanitizedModuleName =
      Data.Text.intercalate "." $
        map sanitizeModuleComponent (Data.Text.splitOn "." name)
      where
        sanitizeModuleComponent module' =
          sanitizeHaskellIdentifier $
            case Data.Text.uncons module' of
              Just (c, rest) ->
                Data.Char.toUpper c `Data.Text.cons` rest
              Nothing ->
                module'

    sanitizeHaskellIdentifier :: Text -> Text
    sanitizeHaskellIdentifier =
      Data.Text.map
        ( \c ->
            case c of
              c
                | Data.Char.isLetter c ->
                    c
                | Data.Char.isDigit c ->
                    c
                | otherwise ->
                    '_'
        )

    toFieldName :: Proto.Protos.Codegen.Column -> Text
    toFieldName column =
      escapeHaskellKeyword $
        case rendered of
          name
            | Just (c, _rest) <- Data.Text.uncons name,
              Data.Char.isDigit c ->
                -- Prepend _ if the first letter is a digit
                "_" <> name
            | Just (c, rest) <- Data.Text.uncons name,
              Data.Char.isUpper c ->
                -- Ensure first letter is lower cased
                Data.Char.toLower c `Data.Text.cons` rest
            | otherwise ->
                name
      where
        rendered =
          renderName
            naming.field
            "{{prefix}}{{column}}"
            [ ("column", name),
              ("table", column ^. #table . #name),
              ("table_alias", column ^. #tableAlias),
              ("schema", column ^. #table . #schema),
              ("prefix", prefix)
            ]

        -- The historical namespacing, precomputed so the default template
        -- needs no conditionals: table alias or table name plus "_", empty
        -- for table-less (expression) outputs.
        prefix
          | column ^. #tableAlias /= "" =
              column ^. #tableAlias <> "_"
          | column ^. #table . #name /= "" =
              column ^. #table . #name <> "_"
          | otherwise =
              ""

    escapeHaskellKeyword x =
      case x of
        "type" -> "type'"
        "module" -> "module'"
        "case" -> "case'"
        "of" -> "of'"
        x -> x

-- | Resolves a possibly fully qualified type to a suitable Haskell type.
--
-- 'ResolveType' may wrap the underlying type into a 'Vector' or 'Maybe', or others depending on whether
-- the column nullable or an array. In this case it might return multiple HaskellTypes of the form
--
--   [ Maybe (Vector Text), base:Data.Maybe.Maybe, vector:Data.Vector.Vector ]
--
-- The first type is the one you want use for code generation while the rest is only info for dependency
-- and import management.
newtype ResolveType = ResolveType (Proto.Protos.Codegen.Column -> Maybe (Proto.Protos.Codegen.Column, NonEmpty HaskellType))

instance Semigroup ResolveType where
  ResolveType resolve1 <> ResolveType resolve2 =
    ResolveType $ \column ->
      resolve1 column <|> resolve2 column

newtype Overrides a = Overrides [Vector a]
  deriving stock (Functor, Foldable, Traversable)

resolveType :: ResolveType -> Proto.Protos.Codegen.Column -> Maybe (Proto.Protos.Codegen.Column, NonEmpty HaskellType)
resolveType = coerce

-- | The user's @overrides@, in configuration order.
newOverrideResolver ::
  Config ->
  -- | Engine, if defined
  Text ->
  ResolveType
newOverrideResolver config engine =
  fromMatchers engine (map overrideToMatcher (configOverrides config))

-- | The type mappings sqlc-hs knows out of the box.
newBuiltinResolver ::
  Maybe Backend ->
  -- | Engine, if defined
  Text ->
  ResolveType
newBuiltinResolver backend engine =
  fromMatchers engine (builtins backend)

-- | The first override matching a column, if any. 'newOverrideResolver' tells
-- you /that/ an override matched; this tells you /which/ one, which is what
-- carries the hasql codecs.
findOverride ::
  Config ->
  -- | Engine, if defined
  Text ->
  Proto.Protos.Codegen.Column ->
  Maybe Override
findOverride config engine column =
  find
    (\override -> matchesEngine engine override.engine && overrideMatches override column)
    (configOverrides config)

configOverrides :: Config -> [Override]
configOverrides config =
  toList (Overrides config.overrides)

fromMatchers :: Text -> [Matcher] -> ResolveType
fromMatchers engine allMatchers = ResolveType $ \column ->
  case mapMaybe (\matcher -> matcher.matcher column) matchers of
    haskellTypes : _ ->
      Just (column, haskellTypes)
    _ ->
      Nothing
  where
    matchers :: [Matcher]
    matchers =
      filter (matchesEngine engine . (.engine)) allMatchers

matchesEngine ::
  -- | The requested engine, if defined
  Text ->
  -- | The engine a matcher is restricted to, if any
  Maybe Text ->
  Bool
matchesEngine engine matcherEngine =
  -- In case the GenerateRequest didn't specify an engine.
  engine == mempty
    -- In case the matcher is engine generic
    || isNothing matcherEngine
    -- In case matcher engine and requested engine match
    || matcherEngine == Just engine

newEnumResolver ::
  HaskellType ->
  [Proto.Protos.Codegen.Enum] ->
  ResolveType
newEnumResolver typeTemplate enums = ResolveType $ \column ->
  case (enumMatcher typeTemplate enums).matcher column of
    Just haskellTypes ->
      Just (column, haskellTypes)
    _ ->
      Nothing

columnDataType :: Proto.Protos.Codegen.Identifier -> Text
columnDataType identifier
  | (identifier ^. #schema) /= mempty =
      (identifier ^. #schema) <> "." <> (identifier ^. #name)
  | otherwise =
      identifier ^. #name

overrideToMatcher :: Override -> Matcher
overrideToMatcher override =
  Matcher
    { engine = override.engine,
      matcher = \column ->
        applyArrayLike
          column
          (if column ^. #notNull then identity else wrapMaybe)
          $ wrap
          $ matchType column
    }
  where
    wrap :: Maybe (NonEmpty HaskellType) -> Maybe (NonEmpty HaskellType)
    wrap haskellTypes =
      haskellTypes <&> \(haskellType :| haskellTypes) ->
        haskellType {name = fmap wrapParenthesis haskellType.name}
          :| haskellTypes

    matchType column
      | overrideMatches override column =
          Just override.haskellType
      | otherwise =
          Nothing

-- | Every constraint present on the override must hold: db_type (if given) and
-- column (if given). The FromJSON instance guarantees at least one of the two
-- is set, so this can never match unconditionally.
overrideMatches :: Override -> Proto.Protos.Codegen.Column -> Bool
overrideMatches override column =
  and
    [ fromMaybe False override.nullable == not (column ^. #notNull),
      matchesDatabaseType,
      matchesColumn
    ]
  where
    matchesDatabaseType =
      case override.databaseType of
        Nothing -> True
        Just databaseType -> columnDataType (column ^. #type') == databaseType

    matchesColumn =
      case override.column of
        Nothing -> True
        Just name -> columnMatches name column

-- | Match a column against a possibly qualified override name: @column@,
-- @table.column@ or @schema.table.column@. The table part matches the table's
-- name or its query alias. A bare @column@ also matches aliased expression
-- outputs (e.g. @CAST(... AS TEXT) AS created_at@), which carry no table.
columnMatches :: Text -> Proto.Protos.Codegen.Column -> Bool
columnMatches qualified column =
  case reverse (Data.Text.splitOn "." qualified) of
    [name] ->
      nameMatches name
    [name, table] ->
      nameMatches name && tableMatches table
    [name, table, schema] ->
      nameMatches name && tableMatches table && column ^. #table . #schema == schema
    _ ->
      False
  where
    nameMatches name =
      column ^. #name == name

    tableMatches table =
      column ^. #table . #name == table || column ^. #tableAlias == table

enumMatcher ::
  -- | HaskellType pointing to the types module.
  HaskellType ->
  [Proto.Protos.Codegen.Enum] ->
  Matcher
enumMatcher typeTemplate enums =
  Matcher
    { engine = Nothing,
      matcher = \column ->
        applyNullable column $
          applyArrayLike column identity $
            case find
              (\enum -> (enum ^. #name) == columnDataType (column ^. #type'))
              enums of
              Just enum ->
                Just $
                  pure
                    typeTemplate
                      { name =
                          typeTemplate.module' <&> \module' ->
                            "(" <> module' <> "." <> "Enum " <> show @Text (enum ^. #name) <> ")"
                      }
              Nothing ->
                Nothing
    }

builtins :: Maybe Backend -> [Matcher]
builtins backend =
  [ Matcher {engine = Just "postgresql", matcher = postgresBuiltin backend},
    Matcher {engine = Just "mysql", matcher = mysqlBuiltin},
    Matcher {engine = Just "sqlite", matcher = sqliteBuiltin}
  ]

data Matcher = Matcher
  { engine :: Maybe Text,
    matcher :: Proto.Protos.Codegen.Column -> Maybe (NonEmpty HaskellType)
  }

mysqlBuiltin :: Proto.Protos.Codegen.Column -> Maybe (NonEmpty HaskellType)
mysqlBuiltin column =
  applyNullable column $
    asum
      [ typ ["varchar", "text", "char", "tinytext", "mediumtext", "longtext"] "text" "Data.Text.Text",
        do
          guard $
            columnType == "tinyint"

          if column ^. #length == 1
            then
              Just $
                pure
                  HaskellType
                    { package = Just "ghc-prim",
                      module' = Just "GHC.Types",
                      name = Just "GHC.Types.Bool"
                    }
            else
              if column ^. #unsigned
                then
                  Just $
                    pure
                      HaskellType
                        { package = Just "base",
                          module' = Just "Data.Word",
                          name = Just "Data.Word.Word8"
                        }
                else
                  Just $
                    pure
                      HaskellType
                        { package = Just "base",
                          module' = Just "Data.Int",
                          name = Just "Data.Int.Int8"
                        },
        do
          guard $
            columnType == "smallint"
          if column ^. #unsigned
            then
              Just $
                pure
                  HaskellType
                    { package = Just "base",
                      module' = Just "Data.Word",
                      name = Just "Data.Word.Word16"
                    }
            else
              Just $
                pure
                  HaskellType
                    { package = Just "base",
                      module' = Just "Data.Int",
                      name = Just "Data.Int.Int16"
                    },
        do
          guard $
            columnType `elem` ["int", "integer", "mediumint"]
          if column ^. #unsigned
            then
              Just $
                pure
                  HaskellType
                    { package = Just "base",
                      module' = Just "Data.Word",
                      name = Just "Data.Word.Word32"
                    }
            else
              Just $
                pure
                  HaskellType
                    { package = Just "base",
                      module' = Just "Data.Int",
                      name = Just "Data.Int.Int32"
                    },
        do
          guard $
            columnType == "bigint"
          if column ^. #unsigned
            then
              Just $
                pure
                  HaskellType
                    { package = Just "base",
                      module' = Just "Data.Word",
                      name = Just "Data.Word.Word64"
                    }
            else
              Just $
                pure
                  HaskellType
                    { package = Just "base",
                      module' = Just "Data.Int",
                      name = Just "Data.Int.Int64"
                    },
        typ ["blob", "binary", "varbinary", "tinyblob", "mediumblob", "longblob"] "bytestring" "Data.ByteString.Short.ShortByteString",
        typ ["double", "double precision", "real", "float"] "ghc-prim" "GHC.Types.Double",
        typ ["decimal", "dec", "fixed"] "scientific" "Data.Scientific.Scientific",
        typ ["enum"] "text" "Data.Text.Text",
        typ ["boolean", "bool"] "ghc-prim" "GHC.Types.Bool",
        typ ["json"] "aeson" "Data.Aeson.Value",
        typ ["date"] "time" "Data.Time.Day",
        typ ["timestamp", "datetime", "time"] "time" "Data.Time.UTCTime"
      ]
  where
    columnType :: Text
    columnType =
      columnDataType (column ^. #type')

    typ mysqlTypes package qualifiedType
      | columnType `elem` mysqlTypes =
          pure $
            pure
              HaskellType
                { package =
                    Just package,
                  module' =
                    Just
                      (Data.Text.intercalate "." (Data.List.init (Data.Text.splitOn "." qualifiedType))),
                  name =
                    Just qualifiedType
                }
      | otherwise =
          Nothing

applyNullable :: Proto.Protos.Codegen.Column -> Maybe (NonEmpty HaskellType) -> Maybe (NonEmpty HaskellType)
applyNullable column types
  | not (column ^. #notNull) =
      fmap wrapMaybe types
  | otherwise =
      types

applyArrayLike ::
  Proto.Protos.Codegen.Column ->
  (NonEmpty HaskellType -> NonEmpty HaskellType) ->
  Maybe (NonEmpty HaskellType) ->
  Maybe (NonEmpty HaskellType)
applyArrayLike column wrapArrayLike haskellTypes
  | Just haskellTypes <- haskellTypes,
    column ^. #isArray =
      Just (wrapArrayLike (wrapVector haskellTypes))
  | Just haskellTypes <- haskellTypes,
    column ^. #isSqlcSlice =
      Just (wrapList haskellTypes)
  | otherwise = haskellTypes

wrapVector :: NonEmpty HaskellType -> NonEmpty HaskellType
wrapVector (haskellType :| rest) =
  haskellType
    { name =
        haskellType.name <&> \name ->
          "Data.Vector.Vector " <> wrapParenthesis name
    }
    :| (vectorType : rest)
  where
    vectorType =
      HaskellType
        { name = Just "Data.Vector.Vector",
          module' = Just "Data.Vector",
          package = Just "vector"
        }

wrapList :: NonEmpty HaskellType -> NonEmpty HaskellType
wrapList (haskellType :| rest) =
  haskellType
    { name =
        haskellType.name <&> \name ->
          Data.Text.singleton '[' <> name <> Data.Text.singleton ']'
    }
    :| rest

wrapMaybe :: NonEmpty HaskellType -> NonEmpty HaskellType
wrapMaybe (haskellType :| rest) =
  HaskellType
    { package = Nothing,
      module' = Nothing,
      name =
        haskellType.name <&> \name ->
          "GHC.Base.Maybe " <> wrapParenthesis name
    }
    :| haskellType
    : HaskellType
      { package = Just "base",
        module' = Just "GHC.Base",
        name = Nothing
      }
    : rest

wrapParenthesis :: Text -> Text
wrapParenthesis input
  | ' ' `Data.Text.elem` input =
      Data.Text.singleton '(' <> input <> Data.Text.singleton ')'
  | otherwise =
      input

sqliteBuiltin :: Proto.Protos.Codegen.Column -> Maybe (NonEmpty HaskellType)
sqliteBuiltin column =
  applyNullable column $
    asum
      [ do
          guard $
            columnType `elem` ["int", "integer", "tinyint", "smallint", "mediumint", "bigint", "unsignedbigint", "int2", "int8"]
          if column ^. #unsigned
            then
              Just $
                pure
                  HaskellType
                    { package = Just "base",
                      module' = Just "Data.Word",
                      name = Just "Data.Word.Word64"
                    }
            else
              Just $
                pure
                  HaskellType
                    { package = Just "base",
                      module' = Just "Data.Int",
                      name = Just "Data.Int.Int64"
                    },
        sqliteType ["blob"] "bytestring" "Data.ByteString.ByteString",
        sqliteType ["real", "double", "doubleprecision", "float"] "ghc-prim" "GHC.Types.Double",
        sqliteType ["bool", "boolean"] "ghc-prim" "GHC.Types.Bool",
        sqliteType ["date", "datetime", "timestamp"] "time" "Data.Time.UTCTime",
        do
          guard $
            or
              [ "character" `Data.Text.isPrefixOf` columnType,
                "varchar" `Data.Text.isPrefixOf` columnType,
                "varyingcharacter" `Data.Text.isPrefixOf` columnType,
                "nchar" `Data.Text.isPrefixOf` columnType,
                "nativecharacter" `Data.Text.isPrefixOf` columnType,
                "nvarchar" `Data.Text.isPrefixOf` columnType,
                columnType
                  `elem` [ "text",
                           "clob"
                         ]
              ]
          Just $
            pure
              HaskellType
                { package = Just "text",
                  module' = Just "Data.Text",
                  name = Just "Data.Text.Text"
                },
        do
          guard $
            or
              [ "decimal" `Data.Text.isPrefixOf` columnType,
                columnType == "numeric"
              ]
          Just $
            pure
              HaskellType
                { package = Just "ghc-prim",
                  module' = Just "GHC.Types",
                  name = Just "GHC.Types.Double"
                }
      ]
  where
    -- SQLite preserves the column type's casing exactly as written in the DDL
    -- (e.g. @TEXT@, @Integer@), whereas the builtin matchers above compare
    -- against lowercase names. Normalise to lowercase so type affinity is
    -- recognised regardless of how the schema spells the type.
    columnType :: Text
    columnType =
      Data.Text.toLower (columnDataType (column ^. #type'))

    sqliteType dbType package qualifiedType
      | columnType `elem` dbType =
          pure $
            pure
              HaskellType
                { package =
                    Just package,
                  module' =
                    Just
                      (Data.Text.intercalate "." (Data.List.init (Data.Text.splitOn "." qualifiedType))),
                  name =
                    Just qualifiedType
                }
      | otherwise =
          Nothing

postgresBuiltin :: Maybe Backend -> Proto.Protos.Codegen.Column -> Maybe (NonEmpty HaskellType)
postgresBuiltin backend column =
  applyNullable column $
    applyArrayLike column identity $
      asum
        [ pgType ["serial", "serial4", "pg_catalog.serial4"] "base" "Data.Int.Int32",
          pgType ["bigserial", "serial8", "pg_catalog.serial8"] "base" "Data.Int.Int64",
          pgType ["smallserial", "serial2", "pg_catalog.serial2"] "base" "Data.Int.Int16",
          pgType ["integer", "int", "int4", "pg_catalog.int4"] "base" "Data.Int.Int32",
          pgType ["bigint", "int8", "pg_catalog.int8"] "base" "Data.Int.Int64",
          pgType ["smallint", "int2", "pg_catalog.int2"] "base" "Data.Int.Int16",
          pgType ["float", "double precision", "float8", "pg_catalog.float8"] "ghc-prim" "GHC.Types.Double",
          pgType ["real", "float4", "pg_catalog.float4"] "ghc-prim" "GHC.Types.Float",
          -- hasql has no codec for "money", so leave it unresolved there: the
          -- user gets a "could not resolve type" error pointing at the column
          -- instead of a decoder that fails at runtime. Same for "name" below.
          pgType (["numeric", "pg_catalog.numeric"] <> unlessHasql ["money"]) "scientific" "Data.Scientific.Scientific",
          pgType ["boolean", "bool", "pg_catalog.bool"] "ghc-prim" "GHC.Types.Bool",
          pgType ["json", "pg_catalog.json"] "aeson" "Data.Aeson.Value",
          pgType ["jsonb", "pg_catalog.jsonb"] "aeson" "Data.Aeson.Value",
          pgBinary ["bytea", "blob", "pg_catalog.bytea"],
          pgType
            (["text", "pg_catalog.varchar", "pg_catalog.bpchar", "string", "citext"] <> unlessHasql ["name"])
            "text"
            "Data.Text.Text"
        ]
  where
    unlessHasql types =
      case backend of
        Just Hasql -> []
        _ -> types

    columnType :: Text
    columnType =
      columnDataType (column ^. #type')

    pgType pgTypes package qualifiedType
      | columnType `elem` pgTypes =
          pure $
            pure
              HaskellType
                { package =
                    Just package,
                  module' =
                    Just
                      (Data.Text.intercalate "." (Data.List.init (Data.Text.splitOn "." qualifiedType))),
                  name =
                    Just qualifiedType
                }
      | otherwise =
          Nothing

    -- postgresql-simple needs the Binary wrapper to send/receive bytea in the
    -- binary format; hasql's bytea codec works on a plain ByteString.
    pgBinary pgTypes
      | columnType `elem` pgTypes,
        Just Hasql <- backend =
          Just $
            pure
              HaskellType
                { package = Just "bytestring",
                  module' = Just "Data.ByteString",
                  name = Just "Data.ByteString.ByteString"
                }
      | columnType `elem` pgTypes =
          Just $
            HaskellType
              { package = Nothing,
                module' = Nothing,
                name = Just "Database.PostgreSQL.Simple.Binary Data.ByteString.ByteString"
              }
              :| [ HaskellType
                     { package = Just "bytestring",
                       module' = Just "Data.ByteString",
                       name = Nothing
                     },
                   HaskellType
                     { package = Just "postgresql-simple",
                       module' = Just "Database.PostgreSQL.Simple",
                       name = Nothing
                     }
                 ]
      | otherwise =
          Nothing

-- | Swaps every occurrence of "$x" with ? as that's what the *-simple libraries
-- understand only.
mangleQuery :: Text -> Text
mangleQuery =
  unQuestionmark . numberedQuestionmarksToQuestionmark . dollarsToQuestionmark
  where
    -- Replace '$x' with '?'
    dollarsToQuestionmark =
      Data.Text.intercalate "?"
        . map (Data.Text.dropWhile Data.Char.isDigit)
        . Data.Text.splitOn "$"

    -- Normalize numbered '?x' placeholders to a bare '?'. sqlc emits these for
    -- @sqlc.arg@ (e.g. @?1@, @?2@) but sqlite-simple only understands the
    -- positional '?' and fails to parse the numbered form. Only the digits
    -- immediately following a '?' are dropped; the text before the first '?'
    -- is left untouched.
    numberedQuestionmarksToQuestionmark input =
      case Data.Text.splitOn "?" input of
        (x : xs) ->
          Data.Text.intercalate "?"
            (x : map (Data.Text.dropWhile Data.Char.isDigit) xs)
        [] ->
          input

    -- Replace '(?)' with '?'
    -- Due to pretty printing and formatting it could look like
    --
    --   (
    --     ?
    --   )
    --
    unQuestionmark =
      Data.Text.intercalate "?" . go . Data.Text.splitOn "?"
      where
        go [] = []
        go [x] = [x]
        go (left : right : rest)
          | Just left <- Data.Text.stripSuffix "(" (Data.Text.stripEnd left),
            Just right <- Data.Text.stripPrefix ")" (Data.Text.stripStart right) =
              go (left : right : rest)
          | otherwise =
              left : go (right : rest)

-- | The 1-based parameter indices referenced by a query's SQL text, in order.
--
-- PostgreSQL uses numbered placeholders (@$1@, @$2@) which may repeat or appear
-- out of order, so we read the explicit numbers. SQLite uses positional @?@
-- placeholders, but sqlc emits numbered @?N@ placeholders for @sqlc.arg@ (which
-- may likewise repeat or be reordered); when present we read those numbers.
-- For bare positional @?@ placeholders we fall back to sequential indices
-- @[1..n]@ matching the parameter list order.
--
-- The @?@ handling is deliberately scoped to SQLite: PostgreSQL always uses
-- @$n@, and the MySQL path is left on the numbered behaviour to avoid changing
-- it here. Only SQLite needs (and gets) the positional-@?@ handling.
queryParamBindings :: Text -> Text -> [Int]
queryParamBindings engine query =
  case numbered of
    [] | engine == "sqlite" ->
      case questionmarkNumbered of
        Just bindings -> bindings
        Nothing -> [1 .. Data.Text.count "?" query]
    bindings -> bindings
  where
    numbered =
      catMaybes
        [ readMaybe (toString (Data.Text.takeWhile Data.Char.isDigit x))
          | x <- Data.Text.splitOn "$" query
        ]

    -- One segment per '?' occurrence (dropping the text before the first '?').
    -- If any occurrence carries an explicit number (@?N@), read the numbers,
    -- using the positional index as a fallback for any bare '?'. If none are
    -- numbered, return 'Nothing' so the caller uses the sequential default.
    questionmarkNumbered =
      case drop 1 (Data.Text.splitOn "?" query) of
        segments
          | any (not . Data.Text.null . takeDigits) segments ->
              Just (zipWith bindingFor [1 ..] segments)
          | otherwise ->
              Nothing
      where
        takeDigits = Data.Text.takeWhile Data.Char.isDigit
        bindingFor index segment =
          fromMaybe index (readMaybe (toString (takeDigits segment)))

-- | The hasql @(encoder, decoder)@ pair to use for a column.
--
-- An override that carries @hasql_encoder@ / @hasql_decoder@ decides the codec
-- outright. Failing that, an override that chose the column's Haskell type also
-- decides its codec, so we go through the generated @ToField@ / @FromField@
-- classes, which the user can instantiate for whatever type they picked. Only
-- when sqlc-hs typed the column itself do we know the codec, and then we take
-- it from the SQL type.
hasqlColumnCodec ::
  -- | The override that matched the column, if any
  Maybe Override ->
  Proto.Protos.Codegen.Column ->
  (Text, Text)
hasqlColumnCodec override column =
  ( wrapHasqlEncoder column encoder,
    wrapHasqlDecoder column decoder
  )
  where
    (encoder, decoder) =
      case override of
        Just Override {hasqlEncoder = Just encoder, hasqlDecoder = Just decoder} ->
          (encoder, decoder)
        Just _ ->
          classCodec
        Nothing ->
          fromMaybe classCodec (hasqlValueCodec (columnDataType (column ^. #type')))

    classCodec =
      ("toField", "fromField")

-- | hasql's codec for a PostgreSQL type, as @(encoder, decoder)@ expressions.
--
-- Unlike postgresql-simple, hasql picks a codec per SQL type rather than per
-- Haskell type, and from 1.10 on it rejects a result whose column OID doesn't
-- match the decoder. @text@, @varchar@ and @bpchar@ all map to 'Text' but need
-- three different decoders, so the choice has to be made here, from the type
-- sqlc reported, and not from a class keyed on the Haskell type.
hasqlValueCodec ::
  -- | Database type, as 'columnDataType' renders it
  Text ->
  Maybe (Text, Text)
hasqlValueCodec databaseType =
  fmap codec $
    find
      (\(databaseTypes, _codec) -> databaseType `elem` databaseTypes)
      [ (["serial", "serial4", "pg_catalog.serial4", "integer", "int", "int4", "pg_catalog.int4"], "int4"),
        (["bigserial", "serial8", "pg_catalog.serial8", "bigint", "int8", "pg_catalog.int8"], "int8"),
        (["smallserial", "serial2", "pg_catalog.serial2", "smallint", "int2", "pg_catalog.int2"], "int2"),
        (["float", "double precision", "float8", "pg_catalog.float8"], "float8"),
        (["real", "float4", "pg_catalog.float4"], "float4"),
        (["numeric", "pg_catalog.numeric"], "numeric"),
        (["boolean", "bool", "pg_catalog.bool"], "bool"),
        (["json", "pg_catalog.json"], "json"),
        (["jsonb", "pg_catalog.jsonb"], "jsonb"),
        (["bytea", "blob", "pg_catalog.bytea"], "bytea"),
        (["text", "string", "pg_catalog.text"], "text"),
        (["varchar", "pg_catalog.varchar"], "varchar"),
        (["bpchar", "pg_catalog.bpchar"], "bpchar"),
        (["citext"], "citext")
      ]
  where
    codec (_databaseTypes, name) =
      ("Hasql.Encoders." <> name, "Hasql.Decoders." <> name)

-- | Lift a hasql value encoder to the parameter encoder for a column, applying
-- the same nullability and array wrapping that 'applyNullable' and
-- 'applyArrayLike' applied to the column's Haskell type.
wrapHasqlEncoder :: Proto.Protos.Codegen.Column -> Text -> Text
wrapHasqlEncoder =
  wrapHasqlValue "Hasql.Encoders" "foldableArray"

-- | 'wrapHasqlEncoder' for decoders. Array columns decode into a 'Vector', which
-- is what 'wrapVector' gave them as a Haskell type.
wrapHasqlDecoder :: Proto.Protos.Codegen.Column -> Text -> Text
wrapHasqlDecoder =
  wrapHasqlValue "Hasql.Decoders" "vectorArray"

wrapHasqlValue :: Text -> Text -> Proto.Protos.Codegen.Column -> Text -> Text
wrapHasqlValue module' arrayCodec column value =
  qualified nullability <> " " <> wrapParenthesis arrayed
  where
    qualified name =
      module' <> "." <> name

    nullability
      | column ^. #notNull = "nonNullable"
      | otherwise = "nullable"

    arrayed
      | column ^. #isArray || column ^. #isSqlcSlice =
          qualified arrayCodec
            <> " "
            <> wrapParenthesis (qualified "nonNullable" <> " " <> wrapParenthesis value)
      | otherwise =
          value

-- | Rewrite the @IN@ / @NOT IN@ operators over @sqlc.slice@ parameters into
-- their array equivalents.
--
-- PostgreSQL's @IN@ takes a syntactic list of values, not an array, which is
-- why postgresql-simple expands a slice into as many placeholders as there are
-- elements. hasql binds one parameter per placeholder and cannot do that, so
-- the array operators have to be used instead:
--
--   * @x IN ($1)@ becomes @x = ANY ($1)@
--   * @x NOT IN ($1)@ becomes @x <> ALL ($1)@
--
-- Returns 'Left' when a slice parameter isn't in a shape we recognise, rather
-- than emitting SQL that only fails once it reaches the server.
rewriteSlices ::
  -- | The numbers of the parameters that are slices
  [Int] ->
  Text ->
  Either Text Text
rewriteSlices slices sql
  | null slices =
      Right sql
  | otherwise =
      go mempty sql
  where
    go acc input =
      case Data.Text.breakOn "$" input of
        (before, rest)
          | Just rest <- Data.Text.stripPrefix "$" rest,
            (digits, after) <- Data.Text.span Data.Char.isDigit rest,
            Just number <- readMaybe (toString digits),
            number `elem` slices ->
              case rewriteSlice (acc <> before) digits after of
                Left errorMessage ->
                  Left errorMessage
                Right (acc, after) ->
                  go acc after
          | Just rest <- Data.Text.stripPrefix "$" rest,
            (digits, after) <- Data.Text.span Data.Char.isDigit rest ->
              go (acc <> before <> "$" <> digits) after
          | otherwise ->
              Right (acc <> before)

    -- 'before' is everything preceding the placeholder, 'after' everything
    -- following it. Both get rewritten: the operator sits in front of the
    -- placeholder, the closing parenthesis (if any) behind it.
    rewriteSlice before digits after = do
      let placeholder = "$" <> digits

          -- sqlc marks slices with a comment for the engines that use
          -- positional placeholders. Drop it, it has served its purpose.
          withoutMarker = stripSliceMarker before

          (withoutParenthesis, parenthesised) =
            case Data.Text.stripSuffix "(" (Data.Text.stripEnd withoutMarker) of
              Just before -> (before, True)
              Nothing -> (withoutMarker, False)

      after <-
        if parenthesised
          then
            whenNothing
              (Data.Text.stripPrefix ")" (Data.Text.stripStart after))
              (Left (unsupported placeholder))
          else pure after

      beforeIn <-
        whenNothing
          (stripKeywordSuffix "IN" (Data.Text.stripEnd withoutParenthesis))
          (Left (unsupported placeholder))

      pure $
        case stripKeywordSuffix "NOT" (Data.Text.stripEnd beforeIn) of
          Just beforeNot ->
            (Data.Text.stripEnd beforeNot <> " <> ALL (" <> placeholder <> ")", after)
          Nothing ->
            (Data.Text.stripEnd beforeIn <> " = ANY (" <> placeholder <> ")", after)

    unsupported placeholder =
      "The slice parameter "
        <> placeholder
        <> " is not used with IN or NOT IN. hasql binds a slice as a single\
           \ array parameter, which PostgreSQL only accepts with the array\
           \ operators; write the comparison as \"= ANY(sqlc.arg(...)::type[])\"\
           \ in your SQL instead of using sqlc.slice."

-- | Strip a @/*SLICE:name*/@ marker off the end of the text, if there is one.
stripSliceMarker :: Text -> Text
stripSliceMarker input = fromMaybe input $ do
  comment <- Data.Text.stripSuffix "*/" (Data.Text.stripEnd input)
  let (before, marker) = Data.Text.breakOnEnd "/*" comment
  guard ("SLICE:" `Data.Text.isPrefixOf` marker)
  Data.Text.stripSuffix "/*" before

-- | Strip a keyword off the end of the text, case insensitively, requiring it
-- to be a word of its own rather than the tail of an identifier.
stripKeywordSuffix :: Text -> Text -> Maybe Text
stripKeywordSuffix keyword input = do
  guard (Data.Text.length input >= Data.Text.length keyword)
  let (before, suffix) =
        Data.Text.splitAt (Data.Text.length input - Data.Text.length keyword) input
  guard (Data.Text.toUpper suffix == keyword)
  guard (maybe True (not . isIdentifierChar . snd) (Data.Text.unsnoc before))
  pure before
  where
    isIdentifierChar c =
      Data.Char.isAlphaNum c || c == '_'
