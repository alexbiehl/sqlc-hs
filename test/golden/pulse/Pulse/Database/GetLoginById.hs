{- This file was auto-generated from queries.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Pulse.Database.GetLoginById where

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

query_getLoginById :: Query "getLoginById" ":one"
query_getLoginById = Query "SELECT id, organization_id, display_name, login_name, password_bcrypt, is_deleted, created_at, updated_at FROM logins WHERE id = ? AND NOT is_deleted"

data instance Params "getLoginById" = Params_getLoginById
  {
    logins_id :: Data.Int.Int32
  }

data instance Result "getLoginById" = Result_getLoginById
  {
    logins_id :: !Data.Int.Int32,
    logins_organization_id :: !Data.Int.Int32,
    logins_display_name :: !(GHC.Base.Maybe Data.Text.Text),
    logins_login_name :: !Data.Text.Text,
    logins_password_bcrypt :: !Data.Text.Text,
    logins_is_deleted :: !(GHC.Base.Maybe GHC.Types.Bool),
    logins_created_at :: !Data.Time.UTCTime,
    logins_updated_at :: !Data.Time.UTCTime
  }

instance Database.PostgreSQL.Simple.ToRow.ToRow (Params "getLoginById") where
  toRow Params_getLoginById{..} =
    [ 
      Database.PostgreSQL.Simple.ToField.toField logins_id
    ]

instance Database.PostgreSQL.Simple.FromRow.FromRow (Result "getLoginById") where
  fromRow =
    pure Result_getLoginById
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field


