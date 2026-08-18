{- This file was auto-generated from query/events.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.GetEvent where

import Queries.Internal (Query(..), Enum, Params, Result, ToRow(..), FromRow(..), ToField(..), FromField(..))
import qualified Hasql.Decoders
import qualified Hasql.Encoders

import qualified Data.UUID
import qualified Data.Time
import qualified Data.Foldable
import qualified Data.Functor.Contravariant

query_GetEvent :: Query "GetEvent" ":one"
query_GetEvent = Query "SELECT id, created_at, updated_at, legacy_at FROM events WHERE id = $1 AND legacy_at > $2;"

data instance Params "GetEvent" = Params_GetEvent
  {
    id :: Data.UUID.UUID,
    since :: Data.Time.UTCTime
  }

data instance Result "GetEvent" = Result_GetEvent
  {
    id :: !(Data.UUID.UUID),
    created_at :: !(Data.Time.UTCTime),
    updated_at :: !((Maybe Data.Time.UTCTime)),
    legacy_at :: !(Data.Time.UTCTime)
  }

instance ToRow (Params "GetEvent") where
  toRow =
    mconcat
      [ 
      Data.Functor.Contravariant.contramap (\Params_GetEvent{..} -> id) (Hasql.Encoders.param (Hasql.Encoders.nonNullable toField)), 

      Data.Functor.Contravariant.contramap (\Params_GetEvent{..} -> since) (Hasql.Encoders.param (Hasql.Encoders.nonNullable (Data.Functor.Contravariant.contramap (Data.Time.utcToLocalTime Data.Time.utc) Hasql.Encoders.timestamp)))
      ]

instance FromRow (Result "GetEvent") where
  fromRow =
    pure Result_GetEvent
      <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable fromField)
      <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable fromField)
      <*> Hasql.Decoders.column (Hasql.Decoders.nullable fromField)
      <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable (fmap (Data.Time.localTimeToUTC Data.Time.utc) Hasql.Decoders.timestamp))


