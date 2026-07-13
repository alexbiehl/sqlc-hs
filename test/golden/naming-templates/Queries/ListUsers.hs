{- This file was auto-generated from query/users.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.ListUsers where

import Queries.Internal (Query(..), Enum, Params, Result)
import qualified Database.PostgreSQL.Simple
import qualified Database.PostgreSQL.Simple.FromRow
import qualified Database.PostgreSQL.Simple.ToField
import qualified Database.PostgreSQL.Simple.ToRow

import qualified Data.Int
import qualified Data.Text
import qualified Data.Foldable

runListUsers :: Query "ListUsers" "SELECT"
runListUsers = Query "SELECT id, name, CAST(now() AS TEXT) AS fetched_at FROM users WHERE ? > 42;"

data instance Params "ListUsers" = MkListUsersArgs
  {
    age_of_ :: Data.Int.Int32
  }

data instance Result "ListUsers" = ListUsersRow
  {
    id_of_users :: !(Data.Int.Int32),
    name_of_users :: !(Data.Text.Text),
    fetched_at_of_ :: !(Data.Text.Text)
  }

instance Database.PostgreSQL.Simple.ToRow.ToRow (Params "ListUsers") where
  toRow MkListUsersArgs{..} =
    [     ]

instance Database.PostgreSQL.Simple.FromRow.FromRow (Result "ListUsers") where
  fromRow =
    pure ListUsersRow
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field


