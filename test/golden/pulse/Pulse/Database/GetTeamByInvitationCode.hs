{- This file was auto-generated from queries.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Pulse.Database.GetTeamByInvitationCode where

import Pulse.Database.Internal (Query(..), Enum, Params, Result)
import qualified Database.PostgreSQL.Simple
import qualified Database.PostgreSQL.Simple.FromRow
import qualified Database.PostgreSQL.Simple.ToField
import qualified Database.PostgreSQL.Simple.ToRow

import qualified Data.Text
import qualified Data.Int
import qualified GHC.Types
import qualified GHC.Base
import qualified Data.Time
import qualified Data.Foldable

query_getTeamByInvitationCode :: Query "getTeamByInvitationCode" ":one"
query_getTeamByInvitationCode = Query "SELECT teams.id, organization_id, teams.display_name, invitation_code, is_deleted, teams.created_at, teams.updated_at, organizations.id, organizations.display_name, organizations.created_at, organizations.updated_at FROM teams JOIN organizations ON teams.organization_id = organizations.id WHERE invitation_code = ? AND NOT is_deleted"

data instance Params "getTeamByInvitationCode" = Params_getTeamByInvitationCode
  {
    teams_invitation_code :: Data.Text.Text
  }

data instance Result "getTeamByInvitationCode" = Result_getTeamByInvitationCode
  {
    teams_id :: !Data.Int.Int32,
    teams_organization_id :: !Data.Int.Int32,
    teams_display_name :: !Data.Text.Text,
    teams_invitation_code :: !Data.Text.Text,
    teams_is_deleted :: !(GHC.Base.Maybe GHC.Types.Bool),
    teams_created_at :: !Data.Time.UTCTime,
    teams_updated_at :: !Data.Time.UTCTime,
    organizations_id :: !Data.Int.Int32,
    organizations_display_name :: !Data.Text.Text,
    organizations_created_at :: !Data.Time.UTCTime,
    organizations_updated_at :: !Data.Time.UTCTime
  }

instance Database.PostgreSQL.Simple.ToRow.ToRow (Params "getTeamByInvitationCode") where
  toRow Params_getTeamByInvitationCode{..} =
    [ 
      Database.PostgreSQL.Simple.ToField.toField teams_invitation_code
    ]

instance Database.PostgreSQL.Simple.FromRow.FromRow (Result "getTeamByInvitationCode") where
  fromRow =
    pure Result_getTeamByInvitationCode
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


