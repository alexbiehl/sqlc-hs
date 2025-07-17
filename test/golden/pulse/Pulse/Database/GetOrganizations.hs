{- This file was auto-generated from queries.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Pulse.Database.GetOrganizations where

import Pulse.Database.Internal (Query(..), Enum, Params, Result)
import qualified Database.PostgreSQL.Simple
import qualified Database.PostgreSQL.Simple.FromRow
import qualified Database.PostgreSQL.Simple.ToField
import qualified Database.PostgreSQL.Simple.ToRow

import qualified Data.Int
import qualified Data.Text
import qualified Data.Time
import qualified Data.Foldable

query_getOrganizations :: Query "getOrganizations" ":many"
query_getOrganizations = Query "SELECT id, display_name, created_at, updated_at FROM organizations LIMIT 100"

data instance Params "getOrganizations" = Params_getOrganizations
  {
  }

data instance Result "getOrganizations" = Result_getOrganizations
  {
    organizations_id :: !(Data.Int.Int32),
    organizations_display_name :: !(Data.Text.Text),
    organizations_created_at :: !((Maybe Data.Time.UTCTime)),
    organizations_updated_at :: !((Maybe Data.Time.UTCTime))
  }

instance Database.PostgreSQL.Simple.ToRow.ToRow (Params "getOrganizations") where
  toRow Params_getOrganizations{} =
    [     ]

instance Database.PostgreSQL.Simple.FromRow.FromRow (Result "getOrganizations") where
  fromRow =
    pure Result_getOrganizations
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field


