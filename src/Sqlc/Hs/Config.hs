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
    -- | Default extensions that will be placed in the default-extension stanza
    cabalDefaultExtensions :: [Text],
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
        cabalDefaultExtensions =
          config1.cabalDefaultExtensions <> config2.cabalDefaultExtensions,
        overrides =
          config1.overrides <> config2.overrides
      }

instance Monoid Config where
  mempty =
    Config
      { overrides = [],
        haskellModulePrefix = Nothing,
        cabalPackageName = Nothing,
        cabalPackageVersion = Nothing,
        cabalDefaultExtensions = []
      }

instance FromJSON Config where
  parseJSON = withObject "Config" $ \o ->
    Config
      <$> o .:? "cabal_package_name"
      <*> o .:? "cabal_package_version"
      <*> o .:? "cabal_default_extensions" .!= []
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

-- | A haskell type denotes a fully qualified data type with module
-- and import and all.
--
-- Haskellers hate this definition as it's very indefinite. Here's some
-- perspective:
--
-- We force people to fully qualify (<=> all fields "Just") when specifying
-- overrides. No indefiniteness here. Check `FromJSON HaskellType`.
--
-- Internally we refer to fully specified types as well, exclusively.
-- No indefiniteness here either.
--
-- But: When resolving types we want to be able to express composed types
-- like "Maybe (Vector Text)". We do not want to specify module and package
-- but really only the name.
data HaskellType = HaskellType
  { package :: Maybe Text,
    module' :: Maybe Text,
    name :: Maybe Text
  }

instance FromJSON HaskellType where
  parseJSON = withObject "HaskellType" $ \o ->
    HaskellType
      <$> fmap Just (o .: "package")
      <*> fmap Just (o .: "module")
      <*> fmap Just (o .: "type")

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
      cabalDefaultExtensions = [],
      haskellModulePrefix = Just "Queries",
      overrides = []
    }
