{- This file was auto-generated from queries.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Pulse.Database.InsertTeam where

import Pulse.Database.Internal (Query(..), Enum, Params, Result)
import qualified Database.PostgreSQL.Simple.FromRow
import qualified Database.PostgreSQL.Simple.ToField
import qualified Database.PostgreSQL.Simple.ToRow

import qualified Data.Int
import qualified Data.Text
import qualified GHC.Types
import qualified GHC.Base
import qualified Data.Time

query_insertTeam :: Query "insertTeam" ":one"
query_insertTeam = Query "INSERT INTO teams (organization_id, display_name, invitation_code, is_deleted) VALUES (?, ?, ?, false) RETURNING id, organization_id, display_name, invitation_code, is_deleted, created_at, updated_at"

data instance Params "insertTeam" = Params_insertTeam
  {
    teams_organization_id :: Data.Int.Int32,
    teams_display_name :: Data.Text.Text,
    teams_invitation_code :: Data.Text.Text
  }

data instance Result "insertTeam" = Result_insertTeam
  {
    teams_id :: !Data.Int.Int32,
    teams_organization_id :: !Data.Int.Int32,
    teams_display_name :: !Data.Text.Text,
    teams_invitation_code :: !Data.Text.Text,
    teams_is_deleted :: !(GHC.Base.Maybe GHC.Types.Bool),
    teams_created_at :: !Data.Time.UTCTime,
    teams_updated_at :: !Data.Time.UTCTime
  }

instance Database.PostgreSQL.Simple.ToRow.ToRow (Params "insertTeam") where
  toRow Params_insertTeam{..} =
    [ 
      Database.PostgreSQL.Simple.ToField.toField teams_organization_id, 

      Database.PostgreSQL.Simple.ToField.toField teams_display_name, 

      Database.PostgreSQL.Simple.ToField.toField teams_invitation_code
    ]

instance Database.PostgreSQL.Simple.FromRow.FromRow (Result "insertTeam") where
  fromRow =
    pure Result_insertTeam
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field


