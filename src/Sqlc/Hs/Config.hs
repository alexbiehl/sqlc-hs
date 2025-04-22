module Sqlc.Hs.Config
  ( Config (..),
    Override (..),
    HaskellType (..),
    parseConfig,
    defaultConfig,
  )
where

import Data.Aeson
  ( FromJSON (..),
    eitherDecodeStrict,
    withObject,
    (.!=),
    (.:),
    (.:?),
  )
import Data.Vector (Vector)

-- | Serves as both, global and per query configuration. Multiple 'Config's can be
-- merged through the use of the 'Semigroup' instance.
data Config = Config
  { -- | If requested, a cabal file with this package name will be generated.
    cabalPackageName :: Maybe Text,
    -- | Package version to be used with the cabal package.
    cabalPackageVersion :: Maybe Text,
    -- | Module prefix, e.g. Data.Queries
    haskellModulePrefix :: Maybe Text,
    -- | List of lists of overrides. Nesting is list of allowing cheap
    -- concatenation. No need to create a one big vector.
    overrides :: [Vector Override]
  }

instance Semigroup Config where
  config1 <> config2 =
    Config
      { cabalPackageName =
          getFirst $ First config1.cabalPackageName <> First config2.cabalPackageName,
        cabalPackageVersion =
          getFirst $ First config1.cabalPackageVersion <> First config2.cabalPackageVersion,
        haskellModulePrefix =
          getFirst $ First config1.haskellModulePrefix <> First config2.haskellModulePrefix,
        overrides =
          config1.overrides <> config2.overrides
      }

instance Monoid Config where
  mempty =
    Config
      { overrides = [],
        haskellModulePrefix = Nothing,
        cabalPackageName = Nothing,
        cabalPackageVersion = Nothing
      }

instance FromJSON Config where
  parseJSON = withObject "Config" $ \o ->
    Config
      <$> o .:? "cabal_package_name"
      <*> o .:? "cabal_package_version"
      <*> o .:? "haskell_module_prefix"
      <*> fmap pure (o .:? "overrides" .!= mempty)

data Override = Override
  { haskellType :: HaskellType,
    databaseType :: Text,
    -- Fully qualified name of the column, e.g. `accounts.id`
    column :: Maybe Text,
    -- | For global overrides only when two different engines are in use.
    engine :: Maybe Text,
    -- | True if the haskellType should override if the matching type is nullable
    nullable :: Maybe Bool
  }

instance FromJSON Override where
  parseJSON = withObject "Override" $ \o ->
    Override
      <$> o .: "haskell_type"
      <*> o .: "db_type"
      <*> o .:? "column"
      <*> o .:? "engine"
      <*> o .:? "nullable"

data HaskellType = HaskellType
  { package :: Text,
    module' :: Text,
    name :: Text
  }

instance FromJSON HaskellType where
  parseJSON = withObject "HaskellType" $ \o ->
    HaskellType
      <$> o .: "package"
      <*> o .: "module"
      <*> o .: "type"

parseConfig :: ByteString -> Either String Config
parseConfig input =
  case input of
    "" -> Right mempty
    input -> eitherDecodeStrict input

defaultConfig :: Config
defaultConfig =
  mempty
    { cabalPackageName = Just "queries",
      cabalPackageVersion = Just "0.1.0.0",
      haskellModulePrefix = Just "Queries",
      overrides =
        [ fromList
            [ pgType "serial" "base" "Data.Int" "Int32",
              pgType "serial4" "base" "Data.Int" "Int32",
              pgType "pg_catalog.serial4" "base" "Data.Int" "Int32",

              pgType "bigserial" "base" "Data.Int" "Int64",
              pgType "serial8" "base" "Data.Int" "Int64",
              pgType "pg_catalog.serial8" "base" "Data.Int" "Int64",

              pgType "smallserial" "base" "Data.Int" "Int16",
              pgType "serial2" "base" "Data.Int" "Int16",
              pgType "pg_catalog.serial2" "base" "Data.Int" "Int16",

              pgType "integer" "base" "Data.Int" "Int32",
              pgType "int" "base" "Data.Int" "Int32",
              pgType "int4" "base" "Data.Int" "Int32",

              pgType "bigint" "base" "Data.Int" "Int64",
              pgType "int8" "base" "Data.Int" "Int64",
              pgType "pg_catalog.int8" "base" "Data.Int" "Int64",

              pgType "smallint" "base" "Data.Int" "Int16",
              pgType "int2" "base" "Data.Int" "Int16",
              pgType "pg_catalog.int2" "base" "Data.Int" "Int16",

              pgType "float" "base" "GHC.Types" "Double",
              pgType "double precision" "base" "GHC.Types" "Double",
              pgType "float8" "base" "GHC.Types" "Double",
              pgType "pg_catalog.float8" "base" "GHC.Types" "Double",

              pgType "real" "base" "GHC.Types" "Float",
              pgType "float4" "base" "GHC.Types" "Float",
              pgType "pg_catalog.float4" "base" "GHC.Types" "Float",

              pgType "numeric" "scientific" "Data.Scientific" "Scientific",
              pgType "pg_catalog.numeric" "scientific" "Data.Scientific" "Scientific",
              pgType "money" "scientific" "Data.Scientific" "Scientific",

              pgType "boolean" "base" "GHC.Types" "Bool",
              pgType "bool" "base" "GHC.Types" "Bool",
              pgType "pg_catalog.bool" "base" "GHC.Types" "Bool",

              pgType "json" "aeson" "Data.Aeson" "Value",
              pgType "pg_catalog.json" "aeson" "Data.Aeson" "Value",

              pgType "jsonb" "aeson" "Data.Aeson" "Value",
              pgType "pg_catalog.jsonb" "aeson" "Data.Aeson" "Value",

              pgType "bytea" "bytestring" "Data.ByteString.Short" "ShortByteString",
              pgType "blob" "bytestring" "Data.ByteString.Short" "ShortByteString",
              pgType "pg_catalog.bytea" "bytestring" "Data.ByteString.Short" "ShortByteString",

              pgType "date" "time" "Data.Time" "Day",

              pgType "pg_catalog.time" "time" "Data.Time" "UTCTime",
              pgType "pg_catalog.timetz" "time" "Data.Time" "LocalTime",

              pgType "text" "text" "Data.Text" "Text",
              pgType "pg_catalog.varchar" "text" "Data.Text" "Text",
              pgType "pg_catalog.bpchar" "text" "Data.Text" "Text",
              pgType "string" "text" "Data.Text" "Text",
              pgType "citext" "text" "Data.Text" "Text",
              pgType "name" "text" "Data.Text" "Text",

              pgType "uuid" "uuid" "Data.UUID" "UUID"
            ]
        ]
    }
  where
    pgType databaseType package module' type_ =
      Override
        { databaseType,
          haskellType =
            HaskellType
              { package,
                module',
                name = module' <> "." <> type_
              },
          column = Nothing,
          engine = Just "postgresql",
          nullable = Nothing
        }
