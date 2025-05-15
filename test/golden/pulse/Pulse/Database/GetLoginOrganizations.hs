{- This file was auto-generated from queries.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Pulse.Database.GetLoginOrganizations where

import Pulse.Database.Internal (Query(..), Enum, Params, Result)
import qualified Database.PostgreSQL.Simple
import qualified Database.PostgreSQL.Simple.FromRow
import qualified Database.PostgreSQL.Simple.ToField
import qualified Database.PostgreSQL.Simple.ToRow

import qualified Data.Int
import qualified Data.Text
import qualified GHC.Base
import qualified GHC.Types
import qualified Data.Time
import qualified Data.Foldable

query_getLoginOrganizations :: Query "getLoginOrganizations" ":many"
query_getLoginOrganizations = Query "SELECT logins.id, logins.organization_id, logins.display_name, logins.login_name, logins.password_bcrypt, logins.is_deleted, logins.created_at, logins.updated_at, organizations.id, organizations.display_name, organizations.created_at, organizations.updated_at\n  FROM logins\n  JOIN organization_logins ON logins.id = organization_logins.login_id\n  JOIN organizations ON organizations.id = organization_logins.organization_id\n  WHERE\n    logins.id = ? AND NOT logins.is_deleted"

data instance Params "getLoginOrganizations" = Params_getLoginOrganizations
  {
    logins_id :: Data.Int.Int32
  }

data instance Result "getLoginOrganizations" = Result_getLoginOrganizations
  {
    logins_id :: !Data.Int.Int32,
    logins_organization_id :: !Data.Int.Int32,
    logins_display_name :: !(GHC.Base.Maybe Data.Text.Text),
    logins_login_name :: !Data.Text.Text,
    logins_password_bcrypt :: !Data.Text.Text,
    logins_is_deleted :: !(GHC.Base.Maybe GHC.Types.Bool),
    logins_created_at :: !Data.Time.UTCTime,
    logins_updated_at :: !Data.Time.UTCTime,
    organizations_id :: !Data.Int.Int32,
    organizations_display_name :: !Data.Text.Text,
    organizations_created_at :: !Data.Time.UTCTime,
    organizations_updated_at :: !Data.Time.UTCTime
  }

instance Database.PostgreSQL.Simple.ToRow.ToRow (Params "getLoginOrganizations") where
  toRow Params_getLoginOrganizations{..} =
    [ 
      Database.PostgreSQL.Simple.ToField.toField logins_id
    ]

instance Database.PostgreSQL.Simple.FromRow.FromRow (Result "getLoginOrganizations") where
  fromRow =
    pure Result_getLoginOrganizations
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


