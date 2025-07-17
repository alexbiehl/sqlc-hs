{- This file was auto-generated from queries.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Pulse.Database.GetLoginByName where

import Pulse.Database.Internal (Query(..), Enum, Params, Result)
import qualified Database.PostgreSQL.Simple
import qualified Database.PostgreSQL.Simple.FromRow
import qualified Database.PostgreSQL.Simple.ToField
import qualified Database.PostgreSQL.Simple.ToRow

import qualified Data.Text
import qualified Data.Int
import qualified GHC.Base
import qualified GHC.Types
import qualified Data.Time
import qualified Data.Foldable

query_getLoginByName :: Query "getLoginByName" ":one"
query_getLoginByName = Query "SELECT id, organization_id, display_name, login_name, password_bcrypt, is_deleted, created_at, updated_at FROM logins WHERE login_name = ? AND NOT is_deleted"

data instance Params "getLoginByName" = Params_getLoginByName
  {
    logins_login_name :: Data.Text.Text
  }

data instance Result "getLoginByName" = Result_getLoginByName
  {
    logins_id :: !(Data.Int.Int32),
    logins_organization_id :: !(Data.Int.Int32),
    logins_display_name :: !(GHC.Base.Maybe Data.Text.Text),
    logins_login_name :: !(Data.Text.Text),
    logins_password_bcrypt :: !(Data.Text.Text),
    logins_is_deleted :: !(GHC.Base.Maybe GHC.Types.Bool),
    logins_created_at :: !((Maybe Data.Time.UTCTime)),
    logins_updated_at :: !((Maybe Data.Time.UTCTime))
  }

instance Database.PostgreSQL.Simple.ToRow.ToRow (Params "getLoginByName") where
  toRow Params_getLoginByName{..} =
    [ 
      Database.PostgreSQL.Simple.ToField.toField logins_login_name
    ]

instance Database.PostgreSQL.Simple.FromRow.FromRow (Result "getLoginByName") where
  fromRow =
    pure Result_getLoginByName
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field


