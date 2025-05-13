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
import qualified Database.PostgreSQL.Simple.FromRow
import qualified Database.PostgreSQL.Simple.ToField
import qualified Database.PostgreSQL.Simple.ToRow

import qualified Data.Int
import qualified Data.Text

query_ListUsers :: Query "ListUsers" "SELECT"
query_ListUsers = Query "SELECT * FROM users WHERE ? > 42;"

data instance Params "ListUsers" = Params_ListUsers
  {
    age :: Data.Int.Int32
  }

data instance Result "ListUsers" = Result_ListUsers
  {
    id :: !Data.Int.Int32,
    name :: !Data.Text.Text
  }

instance Database.PostgreSQL.Simple.ToRow.ToRow (Params "ListUsers") where
  toRow Params_ListUsers{..} =
    [ 
      Database.PostgreSQL.Simple.ToField.toField age
    ]

instance Database.PostgreSQL.Simple.FromRow.FromRow (Result "ListUsers") where
  fromRow =
    pure Result_ListUsers
      <*> Database.PostgreSQL.Simple.FromRow.field
      <*> Database.PostgreSQL.Simple.FromRow.field


