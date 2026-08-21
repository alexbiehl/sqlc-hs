{- This file was auto-generated from query/users.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.FindUsers where

import Queries.Internal (Query(..), Enum, Params)
-- The row type is named `Result`, and so is IsStatement's associated type. GHC
-- rejects a qualified name on the left of an associated type instance, so it is
-- the row family that gets qualified here instead.
import qualified Queries.Internal
import qualified Data.Int
import qualified Data.Vector
import qualified Hasql.Decoders
import qualified Hasql.Encoders
import qualified Hasql.Mapping.IsScalar
import qualified Hasql.Mapping.IsStatement
import qualified Hasql.Statement

import qualified Data.Text
import qualified Data.Int
import qualified Data.Foldable
import qualified Data.Functor.Contravariant

query_FindUsers :: Query "FindUsers" ":many"
query_FindUsers = Query "SELECT id FROM users WHERE name = ANY ($1) AND email <> ALL ($2) AND age > $3;"

data instance Params "FindUsers" = Params_FindUsers
  {
    names :: [Data.Text.Text],
    emails :: [Data.Text.Text],
    age :: Data.Int.Int32
  }

data instance Queries.Internal.Result "FindUsers" = Result_FindUsers
  {
    id :: !(Data.Int.Int32)
  }

paramsEncoder :: Hasql.Encoders.Params (Params "FindUsers")
paramsEncoder =
  mconcat
    [ 
    Data.Functor.Contravariant.contramap (\Params_FindUsers{..} -> names) (Hasql.Encoders.param (Hasql.Encoders.nonNullable (Hasql.Encoders.foldableArray (Hasql.Encoders.nonNullable Hasql.Encoders.text)))), 

    Data.Functor.Contravariant.contramap (\Params_FindUsers{..} -> emails) (Hasql.Encoders.param (Hasql.Encoders.nonNullable (Hasql.Encoders.foldableArray (Hasql.Encoders.nonNullable Hasql.Encoders.text)))), 

    Data.Functor.Contravariant.contramap (\Params_FindUsers{..} -> age) (Hasql.Encoders.param (Hasql.Encoders.nonNullable Hasql.Encoders.int4))
    ]
{-# INLINE paramsEncoder #-}

rowDecoder :: Hasql.Decoders.Row (Queries.Internal.Result "FindUsers")
rowDecoder =
  pure Result_FindUsers
    <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable Hasql.Decoders.int4)
{-# INLINE rowDecoder #-}

instance Hasql.Mapping.IsStatement.IsStatement (Params "FindUsers") where
  type Result (Params "FindUsers") = Data.Vector.Vector (Queries.Internal.Result "FindUsers")
  statement =
    Hasql.Statement.preparable sql paramsEncoder (Hasql.Decoders.rowVector rowDecoder)
    where
      Query sql = query_FindUsers


