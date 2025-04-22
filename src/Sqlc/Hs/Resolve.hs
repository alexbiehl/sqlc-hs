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

-- | Resolves a possibly fully qualified type to a suitable Haskell type. It may return multiple 'HaskellType'
-- where the very first is the type to use in the generated code.
type ResolveType = Proto.Protos.Codegen.Column -> Maybe (Proto.Protos.Codegen.Column, HaskellType)

newtype Overrides a = Overrides [Vector a]
  deriving stock (Functor, Foldable, Traversable)

newResolveType ::
  Config ->
  -- | Engine, if defined
  Text ->
  ResolveType
newResolveType config engine = \column ->
  case find (matches column) (Overrides overrides) of
    Just override ->
      Just (column, override.haskellType)
    Nothing ->
      Nothing
  where
    -- We only want to search through engine specific or
    -- generic overrides.
    overrides =
      config.overrides <&> \overrides -> do
        override <- overrides
        guard $
          engine == mempty
            || isNothing override.engine
            || override.engine == Just engine
        pure override

    -- TODO extend the matching to support overriding individual columns
    matches :: Proto.Protos.Codegen.Column -> Override -> Bool
    matches column typeMapping
      | dataType (column ^. #type') == typeMapping.databaseType =
          True
      | otherwise =
          False

    dataType :: Proto.Protos.Codegen.Identifier -> Text
    dataType identifier
      | (identifier ^. #schema) /= mempty =
          (identifier ^. #schema) <> "." <> (identifier ^. #name)
      | otherwise =
          identifier ^. #name
