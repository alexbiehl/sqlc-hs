{- This file was auto-generated from queries.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Pulse.Database.InsertTeamMember where

import Pulse.Database.Internal (Query(..), Enum, Params, Result)
import qualified Database.PostgreSQL.Simple
import qualified Database.PostgreSQL.Simple.FromRow
import qualified Database.PostgreSQL.Simple.ToField
import qualified Database.PostgreSQL.Simple.ToRow

import qualified Data.Int
import qualified Data.Foldable

query_insertTeamMember :: Query "insertTeamMember" ":exec"
query_insertTeamMember = Query "INSERT INTO team_members (team_id, login_id) VALUES (?, ?) ON CONFLICT (team_id, login_id) DO NOTHING"

data instance Params "insertTeamMember" = Params_insertTeamMember
  {
    team_members_team_id :: Data.Int.Int32,
    team_members_login_id :: Data.Int.Int32
  }

data instance Result "insertTeamMember" = Result_insertTeamMember
  {
  }

instance Database.PostgreSQL.Simple.ToRow.ToRow (Params "insertTeamMember") where
  toRow Params_insertTeamMember{..} =
    [ 
      Database.PostgreSQL.Simple.ToField.toField team_members_team_id, 

      Database.PostgreSQL.Simple.ToField.toField team_members_login_id
    ]

instance Database.PostgreSQL.Simple.FromRow.FromRow (Result "insertTeamMember") where
  fromRow =
    pure Result_insertTeamMember


