{- This file was auto-generated from query/users.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.ListUsers where

import Queries.Internal (Query(..), Params, Result)
import qualified Database.SQLite.Simple.FromRow
import qualified Database.SQLite.Simple.ToField
import qualified Database.SQLite.Simple.ToRow

import qualified Data.Int
import qualified Data.Text

query_ListUsers :: Query "ListUsers" "SELECT"
query_ListUsers = Query "SELECT * FROM users WHERE ? > 42;"

data instance Params "ListUsers" = Params_ListUsers
  {
    age :: Data.Int.Int64
  }

data instance Result "ListUsers" = Result_ListUsers
  {
    id :: !Data.Int.Int64,
    name :: !Data.Text.Text
  }


instance Database.SQLite.Simple.ToRow.ToRow (Params "ListUsers") where
  toRow Params_ListUsers{..} =
    [ 
      Database.SQLite.Simple.ToField.toField age
    ]

instance Database.SQLite.Simple.FromRow.FromRow (Result "ListUsers") where
  fromRow =
    Result_ListUsers
      <$> Database.SQLite.Simple.FromRow.field
      <*> Database.SQLite.Simple.FromRow.field

