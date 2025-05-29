module Sqlc.Hs.Resolve
  ( ResolveType,
    resolveType,
    newResolveType,
    newEnumResolver,
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
  )
where

import Data.Char qualified
import Data.List qualified
import Data.ProtoLens.Labels ()
import Data.Text qualified
import Data.Vector (Vector)
import Proto.Protos.Codegen qualified
import Sqlc.Hs.Config (Config (..), HaskellType (..), Override (..), defaultConfig)
import System.FilePath ((<.>))

determineTopLevelModule ::
  -- | Haskell module prefix. E.g. "Data.Queries".
  Maybe Text ->
  ResolvedNames
determineTopLevelModule haskellModulePrefix =
  resolveQueryName
    Nothing
    (fromMaybe "Queries" (haskellModulePrefix <|> defaultConfig.haskellModulePrefix))

determineInternalModule ::
  -- | Haskell module prefix. E.g. "Data.Queries".
  Maybe Text ->
  ResolvedNames
determineInternalModule haskellModulePrefix =
  resolveQueryName
    (haskellModulePrefix <|> defaultConfig.haskellModulePrefix <|> Just "Queries")
    "Internal"

determineTypesModule ::
  -- | Haskell module prefix. E.g. "Data.Queries".
  Maybe Text ->
  ResolvedNames
determineTypesModule haskellModulePrefix =
  resolveQueryName
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
  -- | Haskell module prefix. E.g. "Data.Queries".
  Maybe Text ->
  -- | Name to resolve
  Text ->
  ResolvedNames
resolveQueryName haskellModulePrefix name =
  ResolvedNames
    { toQueryDeclarationName =
        -- This generates
        --
        -- query_GetAuthors :: ...
        --
        -- in the query modules.
        --
        -- We could some more sophisticated things to make the query name a valid haskell function
        -- declaration identifier.
        "query_" <> sanitizedName,
      toParamsConstructorDeclarationName =
        "Params_" <> sanitizedName,
      toResultConstructorDeclarationName =
        "Result_" <> sanitizedName,
      toEnumConstructorName = \typename ->
        "Enum_" <> sanitizeHaskellIdentifier typename <> "_" <> sanitizedName,
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

    -- A version of the name suitable for consumption as a Haskell identifier.
    sanitizedName :: Text
    sanitizedName = sanitizeHaskellIdentifier name

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
        case namespaced name of
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
        namespaced x
          | column ^. #tableAlias /= "" =
              column ^. #tableAlias <> "_" <> x
          | column ^. #table . #name /= "" =
              column ^. #table . #name <> "_" <> x
          | otherwise =
              x

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

newResolveType ::
  Config ->
  -- | Engine, if defined
  Text ->
  ResolveType
newResolveType config engine = ResolveType $ \column ->
  case mapMaybe (\matcher -> matcher.matcher column) matchers of
    haskellTypes : _ ->
      Just (column, haskellTypes)
    _ ->
      Nothing
  where
    matchers :: [Matcher]
    matchers =
      [ matcher
        | matcher <-
            concat
              [ map overrideToMatcher (toList (Overrides config.overrides)),
                builtins
              ],
          -- In case the GenerateRequest didn't specify an engine.
          engine == mempty
            -- In case the matcher is engine generic
            || isNothing matcher.engine
            -- In case matcher engine and requested engine match
            || matcher.engine == Just engine
      ]

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

    -- TODO extend the matching to support overriding individual columns
    matchType column
      | fromMaybe False override.nullable /= not (column ^. #notNull) =
          Nothing
      | columnDataType (column ^. #type') == override.databaseType =
          Just (pure override.haskellType)
      | otherwise =
          Nothing

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

builtins :: [Matcher]
builtins =
  [ Matcher {engine = Just "postgresql", matcher = postgresBuiltin},
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
    columnType :: Text
    columnType =
      columnDataType (column ^. #type')

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

postgresBuiltin :: Proto.Protos.Codegen.Column -> Maybe (NonEmpty HaskellType)
postgresBuiltin column =
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
          pgType ["numeric", "pg_catalog.numeric", "money"] "scientific" "Data.Scientific.Scientific",
          pgType ["boolean", "bool", "pg_catalog.bool"] "ghc-prim" "GHC.Types.Bool",
          pgType ["json", "pg_catalog.json"] "aeson" "Data.Aeson.Value",
          pgType ["jsonb", "pg_catalog.jsonb"] "aeson" "Data.Aeson.Value",
          pgType ["bytea", "blob", "pg_catalog.bytea"] "bytestring" "Data.ByteString.Short.ShortByteString",
          pgType ["text", "pg_catalog.varchar", "pg_catalog.bpchar", "string", "citext", "name"] "text" "Data.Text.Text"
        ]
  where
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

-- | Swaps every occurrence of "$x" with ? as that's what the *-simple libraries
-- understand only.
mangleQuery :: Text -> Text
mangleQuery =
  unQuestionmark . dollarsToQuestionmark
  where
    -- Replace '$x' with '?'
    dollarsToQuestionmark =
      Data.Text.intercalate "?"
        . map (Data.Text.dropWhile Data.Char.isDigit)
        . Data.Text.splitOn "$"

    -- Replace '(?)' with '?'
    unQuestionmark =
      Data.Text.intercalate "?" . Data.Text.splitOn "(?)"

queryParamBindings :: Text -> [Int]
queryParamBindings query =
  catMaybes
    [ readMaybe (toString (Data.Text.takeWhile Data.Char.isDigit x))
      | x <- Data.Text.splitOn "$" query
    ]
