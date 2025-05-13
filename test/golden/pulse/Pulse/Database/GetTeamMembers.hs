{- This file was auto-generated from queries.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Pulse.Database.GetTeamMembers where

import Pulse.Database.Internal (Query(..), Enum, Params, Result)
import qualified Database.PostgreSQL.Simple.FromRow
import qualified Database.PostgreSQL.Simple.ToField
import qualified Database.PostgreSQL.Simple.ToRow

import qualified Data.Int
import qualified Data.Text
import qualified GHC.Base
import qualified GHC.Types
import qualified Data.Time

query_getTeamMembers :: Query "getTeamMembers" ":many"
query_getTeamMembers = Query "SELECT id, organization_id, display_name, login_name, password_bcrypt, is_deleted, logins.created_at, logins.updated_at, team_id, login_id, team_members.created_at, team_members.updated_at FROM logins JOIN team_members ON logins.id = team_members.login_id WHERE team_id = ?"

data instance Params "getTeamMembers" = Params_getTeamMembers
  {
    team_members_team_id :: Data.Int.Int32
  }

data instance Result "getTeamMembers" = Result_getTeamMembers
  {
    logins_id :: !Data.Int.Int32,
    logins_organization_id :: !Data.Int.Int32,
    logins_display_name :: !(GHC.Base.Maybe Data.Text.Text),
    logins_login_name :: !Data.Text.Text,
    logins_password_bcrypt :: !Data.Text.Text,
    logins_is_deleted :: !(GHC.Base.Maybe GHC.Types.Bool),
    logins_created_at :: !Data.Time.UTCTime,
    logins_updated_at :: !Data.Time.UTCTime,
    team_members_team_id :: !Data.Int.Int32,
    team_members_login_id :: !Data.Int.Int32,
    team_members_created_at :: !Data.Time.UTCTime,
    team_members_updated_at :: !Data.Time.UTCTime
  }

instance Database.PostgreSQL.Simple.ToRow.ToRow (Params "getTeamMembers") where
  toRow Params_getTeamMembers{..} =
    [ 
      Database.PostgreSQL.Simple.ToField.toField team_members_team_id
    ]

instance Database.PostgreSQL.Simple.FromRow.FromRow (Result "getTeamMembers") where
  fromRow =
    pure Result_getTeamMembers
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field


