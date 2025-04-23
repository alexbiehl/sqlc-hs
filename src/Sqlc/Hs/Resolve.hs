module Sqlc.Hs.Resolve
  ( ResolveType,
    newResolveType,
    -- | How to resolve names to Haskell modules and files
    ResolveName,
    ResolvedNames (..),
    resolveQueryName,
    -- | Misc. modules
    determineTopLevelModule,
    determineInternalModule,
  )
where

import Data.Char qualified
import Data.List qualified
import Data.ProtoLens.Labels ()
import Data.Text qualified
import Data.Vector (Vector)
import Proto.Protos.Codegen qualified
import Sqlc.Hs.Config (Config (..), HaskellType (..), Override (..), defaultConfig)
import System.FilePath ((<.>), (</>))

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

data ResolvedNames = ResolvedNames
  { toQueryDeclarationName :: Text,
    toParamsConstructorDeclarationName :: Text,
    toResultConstructorDeclarationName :: Text,
    toHaskellFileName :: Text,
    toHaskellModuleName :: Text,
    toFieldName :: Text
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
      toFieldName,
      toHaskellFileName =
        applyHaskellModulePrefix (toText ((toString nameToHaskellModuleName <.> "hs"))),
      toHaskellModuleName =
        case haskellModulePrefix of
          Just prefix ->
            prefix <> "." <> nameToHaskellModuleName
          Nothing ->
            nameToHaskellModuleName
    }
  where
    nameToHaskellModuleName =
      case Data.Text.uncons sanitizedName of
        Just (c, name) ->
          Data.Char.toUpper c `Data.Text.cons` name
        Nothing ->
          name

    applyHaskellModulePrefix =
      case haskellModulePrefix of
        Just prefix ->
          \suffix ->
            toText $
              toString (Data.Text.replace "." "/" prefix) </> (toString suffix)
        Nothing ->
          identity

    -- A version of the name suitable for consumption as a Haskell identifier.
    sanitizedName :: Text
    sanitizedName =
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
        name

    toFieldName :: Text
    toFieldName =
      case name of
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

-- | Resolves a possibly fully qualified type to a suitable Haskell type.
--
-- 'ResolveType' may wrap the underlying type into a 'Vector' or 'Maybe', or others depending on whether
-- the column nullable or an array. In this case it might return multiple HaskellTypes of the form
--
--   [ Maybe (Vector Text), base:Data.Maybe.Maybe, vector:Data.Vector.Vector ]
--
-- The first type is the one you want use for code generation while the rest is only info for dependency
-- and import management.
type ResolveType = Proto.Protos.Codegen.Column -> Maybe (Proto.Protos.Codegen.Column, NonEmpty HaskellType)

newtype Overrides a = Overrides [Vector a]
  deriving stock (Functor, Foldable, Traversable)

newResolveType ::
  Config ->
  -- | Engine, if defined
  Text ->
  ResolveType
newResolveType config engine = \column ->
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
      matcher
    }
  where
    -- TODO extend the matching to support overriding individual columns
    matcher column
      | columnDataType (column ^. #type') == override.databaseType =
          Just (pure override.haskellType)
      | otherwise =
          Nothing

builtins :: [Matcher]
builtins =
  [ Matcher {engine = Just "postgresql", matcher = postgresBuiltin},
    Matcher {engine = Just "mysql", matcher = mysqlBuiltin}
  ]

data Matcher = Matcher
  { engine :: Maybe Text,
    matcher :: Proto.Protos.Codegen.Column -> Maybe (NonEmpty HaskellType)
  }

mysqlBuiltin :: Proto.Protos.Codegen.Column -> Maybe (NonEmpty HaskellType)
mysqlBuiltin column =
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
                  { package = Just "base",
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
      typ ["double", "double precision", "real", "float"] "base" "GHC.Types.Double",
      typ ["decimal", "dec", "fixed"] "scientific" "Data.Scientific.Scientific",
      typ ["enum"] "text" "Data.Text.Text",
      typ ["boolean", "bool"] "base" "GHC.Types.Bool",
      typ ["json"] "aeson" "Data.Aeson.Value"
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

postgresBuiltin :: Proto.Protos.Codegen.Column -> Maybe (NonEmpty HaskellType)
postgresBuiltin column =
  asum
    [ pgType ["serial", "serial4", "pg_catalog.serial4"] "base" "Data.Int.Int32",
      pgType ["bigserial", "serial8", "pg_catalog.serial8"] "base" "Data.Int.Int64",
      pgType ["smallserial", "serial2", "pg_catalog.serial2"] "base" "Data.Int.Int16",
      pgType ["integer", "int", "int4", "pg_catalog.int4"] "base" "Data.Int.Int32",
      pgType ["bigint", "int8", "pg_catalog.int8"] "base" "Data.Int.Int64",
      pgType ["smallint", "int2", "pg_catalog.int2"] "base" "Data.Int.Int16",
      pgType ["float", "double precision", "float8", "pg_catalog.float8"] "base" "GHC.Types.Double",
      pgType ["real", "float4", "pg_catalog.float4"] "base" "GHC.Types.Float",
      pgType ["numeric", "pg_catalog.numeric", "money"] "scientific" "Data.Scientific.Scientific",
      pgType ["boolean", "bool", "pg_catalog.bool"] "base" "GHC.Types.Bool",
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
