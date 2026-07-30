{- This file was auto-generated from query/users.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.FindUsers where

import Queries.Internal (Query(..), Enum, Params, Result)
import qualified Database.SQLite.Simple.FromRow
import qualified Database.SQLite.Simple.ToField
import qualified Database.SQLite.Simple.ToRow

import qualified Data.Text
import qualified Data.Int
import qualified Data.Foldable

query_FindUsers :: Query "FindUsers" "SELECT"
query_FindUsers = Query "SELECT * FROM users WHERE name = ? OR nickname = ? OR age > ?;"

data instance Params "FindUsers" = Params_FindUsers
  {
    name :: Data.Text.Text,
    min_age :: Data.Int.Int64
  }

data instance Result "FindUsers" = Result_FindUsers
  {
    id :: !(Data.Int.Int64),
    name :: !(Data.Text.Text)
  }


instance Database.SQLite.Simple.ToRow.ToRow (Params "FindUsers") where
  toRow Params_FindUsers{..} =
    [ 
      Database.SQLite.Simple.ToField.toField name, 

      Database.SQLite.Simple.ToField.toField name, 

      Database.SQLite.Simple.ToField.toField min_age
    ]

instance Database.SQLite.Simple.FromRow.FromRow (Result "FindUsers") where
  fromRow =
    pure Result_FindUsers
      <*> Database.SQLite.Simple.FromRow.field
      <*> Database.SQLite.Simple.FromRow.field

