{- This file was auto-generated from query/users.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.FindUsers where

import Queries.Internal (Query(..), Enum, Params, Result, ToRow(..), FromRow(..), ToField(..), FromField(..))
import qualified Hasql.Decoders
import qualified Hasql.Encoders

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

data instance Result "FindUsers" = Result_FindUsers
  {
    id :: !(Data.Int.Int32)
  }

instance ToRow (Params "FindUsers") where
  toRow =
    mconcat
      [ 
      Data.Functor.Contravariant.contramap (\Params_FindUsers{..} -> names) (Hasql.Encoders.param (Hasql.Encoders.nonNullable (Hasql.Encoders.foldableArray (Hasql.Encoders.nonNullable Hasql.Encoders.text)))), 

      Data.Functor.Contravariant.contramap (\Params_FindUsers{..} -> emails) (Hasql.Encoders.param (Hasql.Encoders.nonNullable (Hasql.Encoders.foldableArray (Hasql.Encoders.nonNullable Hasql.Encoders.text)))), 

      Data.Functor.Contravariant.contramap (\Params_FindUsers{..} -> age) (Hasql.Encoders.param (Hasql.Encoders.nonNullable Hasql.Encoders.int4))
      ]

instance FromRow (Result "FindUsers") where
  fromRow =
    pure Result_FindUsers
      <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable Hasql.Decoders.int4)


