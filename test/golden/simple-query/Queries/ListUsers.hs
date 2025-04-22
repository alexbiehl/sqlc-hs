{- This file was auto-generated from query/users.sql by sqlc-hs. -}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Queries.ListUsers where

import Queries.Internal (Query(..), Params, Result, ToRow, FromRow)
import GHC.Generics (Generic)

import qualified Data.Int
import qualified Data.Text

query_ListUsers :: Query "ListUsers" "SELECT"
query_ListUsers = Query "SELECT * FROM users;"

data instance Params "ListUsers" = Params_ListUsers
  {
  }
  deriving stock (Generic)
  deriving anyclass (ToRow)

data instance Result "ListUsers" = Result_ListUsers
  {
    id :: !Data.Int.Int32,
    name :: !Data.Text.Text
  }
  deriving stock (Generic)
  deriving anyclass (FromRow)
