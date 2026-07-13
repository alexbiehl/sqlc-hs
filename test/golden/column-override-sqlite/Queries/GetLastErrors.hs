{- This file was auto-generated from query/fetch_state.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.GetLastErrors where

import Queries.Internal (Query(..), Enum, Params, Result)
import qualified Database.SQLite.Simple.FromRow
import qualified Database.SQLite.Simple.ToField
import qualified Database.SQLite.Simple.ToRow

import qualified Data.Text
import qualified Data.Time
import qualified Data.Foldable

query_GetLastErrors :: Query "GetLastErrors" ":many"
query_GetLastErrors = Query "SELECT provider, CAST(COALESCE(strftime('%Y-%m-%dT%H:%M:%SZ', last_attempt_at), '') AS TEXT) AS last_error_at FROM fetch_state;"

data instance Params "GetLastErrors" = Params_GetLastErrors
  {
  }

data instance Result "GetLastErrors" = Result_GetLastErrors
  {
    fetch_state_provider :: !(Data.Text.Text),
    last_error_at :: !(Data.Time.UTCTime)
  }


instance Database.SQLite.Simple.ToRow.ToRow (Params "GetLastErrors") where
  toRow Params_GetLastErrors{} =
    [     ]

instance Database.SQLite.Simple.FromRow.FromRow (Result "GetLastErrors") where
  fromRow =
    pure Result_GetLastErrors
      <*> Database.SQLite.Simple.FromRow.field
      <*> Database.SQLite.Simple.FromRow.field

