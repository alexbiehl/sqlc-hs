{- This file was auto-generated from query/events.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.GetEvent where

import Queries.Internal (Query(..), Enum, Params)
import qualified Queries.Internal
import qualified Data.Int
import qualified Data.Vector
import qualified Hasql.Decoders
import qualified Hasql.Encoders
import qualified Hasql.Mapping.IsScalar
import qualified Hasql.Mapping.IsStatement
import qualified Hasql.Statement

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

data instance Queries.Internal.Result "GetEvent" = Result_GetEvent
  {
    id :: !(Data.UUID.UUID),
    created_at :: !(Data.Time.UTCTime),
    updated_at :: !((Maybe Data.Time.UTCTime)),
    legacy_at :: !(Data.Time.UTCTime)
  }

instance Hasql.Mapping.IsStatement.IsStatement (Params "GetEvent") where
  type Result (Params "GetEvent") = Prelude.Maybe (Queries.Internal.Result "GetEvent")
  statement =
    Hasql.Statement.preparable sql paramsEncoder (Hasql.Decoders.rowMaybe rowDecoder)
    where
      Query sql = query_GetEvent

      paramsEncoder :: Hasql.Encoders.Params (Params "GetEvent")
      paramsEncoder =
        mconcat
          [ 
          Data.Functor.Contravariant.contramap (\Params_GetEvent{..} -> id) (Hasql.Encoders.param (Hasql.Encoders.nonNullable Hasql.Mapping.IsScalar.encoder)), 

          Data.Functor.Contravariant.contramap (\Params_GetEvent{..} -> since) (Hasql.Encoders.param (Hasql.Encoders.nonNullable (Data.Functor.Contravariant.contramap (Data.Time.utcToLocalTime Data.Time.utc) Hasql.Encoders.timestamp)))
          ]
      {-# INLINE paramsEncoder #-}
      rowDecoder :: Hasql.Decoders.Row (Queries.Internal.Result "GetEvent")
      rowDecoder =
        pure Result_GetEvent
          <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable Hasql.Mapping.IsScalar.decoder)
          <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable Hasql.Mapping.IsScalar.decoder)
          <*> Hasql.Decoders.column (Hasql.Decoders.nullable Hasql.Mapping.IsScalar.decoder)
          <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable (fmap (Data.Time.localTimeToUTC Data.Time.utc) Hasql.Decoders.timestamp))
      {-# INLINE rowDecoder #-}


