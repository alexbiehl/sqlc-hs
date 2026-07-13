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
  { haskellType :: NonEmpty HaskellType,
    -- | Database type to match, e.g. @text@. Optional when 'column' is given.
    databaseType :: Maybe Text,
    -- | Column to match: @column@, @table.column@ or @schema.table.column@.
    -- A bare @column@ also matches aliased expression outputs, which carry no
    -- table. Optional when 'databaseType' is given; when both are given, both
    -- must match.
    column :: Maybe Text,
    -- | For global overrides only when two different engines are in use.
    engine :: Maybe Text,
    -- | True if the haskellType should override if the matching type is nullable
    nullable :: Maybe Bool
  }

instance FromJSON Override where
  parseJSON = withObject "Override" $ \o -> do
    override <-
      Override
        <$> ( -- We allow multiple haskell-types per database type
              -- to support composite types and their dependencies.
              fmap pure (o .: "haskell_type")
                <|> o
                .: "haskell_type"
            )
        <*> o .:? "db_type"
        <*> o .:? "column"
        <*> o .:? "engine"
        <*> o .:? "nullable"
    when (isNothing override.databaseType && isNothing override.column) $
      fail "override requires at least one of \"db_type\" or \"column\""
    pure override

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
      <$> o .:? "package"
      <*> o .:? "module"
      <*> o .:? "type"

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
