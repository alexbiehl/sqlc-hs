{- This file was auto-generated from query/users.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.FindUserByName where

import Queries.Internal (Query(..), Enum, Params, Result, ToRow(..), FromRow(..), ToField(..), FromField(..))
import qualified Hasql.Decoders
import qualified Hasql.Encoders

import qualified Data.Text
import qualified Data.Int
import qualified Data.Foldable
import qualified Data.Functor.Contravariant

query_FindUserByName :: Query "FindUserByName" ":many"
query_FindUserByName = Query "SELECT id FROM users WHERE $1::TEXT IS NULL OR $1::TEXT = users.name;"

data instance Params "FindUserByName" = Params_FindUserByName
  {
    name :: Data.Text.Text
  }

data instance Result "FindUserByName" = Result_FindUserByName
  {
    id :: !(Data.Int.Int32)
  }

instance ToRow (Params "FindUserByName") where
  {-# INLINE toRow #-}
  toRow =
    mconcat
      [ 
      Data.Functor.Contravariant.contramap (\Params_FindUserByName{..} -> name) (Hasql.Encoders.param (Hasql.Encoders.nonNullable Hasql.Encoders.text))
      ]

instance FromRow (Result "FindUserByName") where
  {-# INLINE fromRow #-}
  fromRow =
    pure Result_FindUserByName
      <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable Hasql.Decoders.int4)


