{- This file was auto-generated from queries.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Pulse.Database.GetTeamById where

import Pulse.Database.Internal (Query(..), Enum, Params, Result)
import qualified Database.PostgreSQL.Simple
import qualified Database.PostgreSQL.Simple.FromRow
import qualified Database.PostgreSQL.Simple.ToField
import qualified Database.PostgreSQL.Simple.ToRow

import qualified Data.Int
import qualified Data.Text
import qualified GHC.Types
import qualified GHC.Base
import qualified Data.Time
import qualified Data.Foldable

query_getTeamById :: Query "getTeamById" ":one"
query_getTeamById = Query "SELECT id, organization_id, display_name, invitation_code, is_deleted, created_at, updated_at FROM teams WHERE organization_id = ? AND id = ? AND NOT is_deleted"

data instance Params "getTeamById" = Params_getTeamById
  {
    teams_organization_id :: Data.Int.Int32,
    teams_id :: Data.Int.Int32
  }

data instance Result "getTeamById" = Result_getTeamById
  {
    teams_id :: !Data.Int.Int32,
    teams_organization_id :: !Data.Int.Int32,
    teams_display_name :: !Data.Text.Text,
    teams_invitation_code :: !Data.Text.Text,
    teams_is_deleted :: !(GHC.Base.Maybe GHC.Types.Bool),
    teams_created_at :: !Data.Time.UTCTime,
    teams_updated_at :: !Data.Time.UTCTime
  }

instance Database.PostgreSQL.Simple.ToRow.ToRow (Params "getTeamById") where
  toRow Params_getTeamById{..} =
    [ 
      Database.PostgreSQL.Simple.ToField.toField teams_organization_id, 

      Database.PostgreSQL.Simple.ToField.toField teams_id
    ]

instance Database.PostgreSQL.Simple.FromRow.FromRow (Result "getTeamById") where
  fromRow =
    pure Result_getTeamById
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field


