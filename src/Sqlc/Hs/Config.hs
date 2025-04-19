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
            [ override "bigserial" "base" "Data.Int" "Int64",
              override "text" "text" "Data.Text" "Text",
              override "smallint" "base" "Data.Int" "Int16",
              override "integer" "base" "Data.Int" "Int32",
              override "bigint" "base" "Data.Int" "Int64",
              override "serial" "base" "Data.Int" "Int32",
              override "bigserial" "base" "Data.Int" "Int64",
              override "decimal" "base" "Prelude." "Double",
              override "numeric" "base" "Prelude" "Double",
              override "real" "base" "Prelude" "Float",
              override "double precision" "base" "Prelude" "Double",
              override "bytea" "bytestring" "Data.ByteString.Short" "ShortByteString"
            ]
        ]
    }
  where
    override databaseType package module' type_ =
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
