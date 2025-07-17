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
import qualified Database.MySQL.Simple.Param
import qualified Database.MySQL.Simple.QueryParams
import qualified Database.MySQL.Simple.QueryResults
import qualified Database.MySQL.Simple.Result

import qualified Data.Int
import qualified Data.Text
import qualified Data.Foldable

query_ListUsers :: Query "ListUsers" "SELECT"
query_ListUsers = Query "SELECT * FROM users WHERE ? > 42;"

data instance Params "ListUsers" = Params_ListUsers
  {
    age :: Data.Int.Int32
  }

data instance Result "ListUsers" = Result_ListUsers
  {
    id :: !(Data.Int.Int32),
    name :: !(Data.Text.Text)
  }



instance Database.MySQL.Simple.QueryParams.QueryParams (Params "ListUsers") where
  renderParams Params_ListUsers{..} =
    [ 
      Database.MySQL.Simple.Param.render age
    ]

instance Database.MySQL.Simple.QueryResults.QueryResults (Result "ListUsers") where
  convertResults [a_1, a_2] [b_1, b_2] = Result_ListUsers{..}
    where
      !id = Database.MySQL.Simple.Result.convert a_1 b_1
      !name = Database.MySQL.Simple.Result.convert a_2 b_2
  convertResults a b =
    Database.MySQL.Simple.QueryResults.convertError a b 2
