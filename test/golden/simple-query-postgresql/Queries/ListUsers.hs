{- This file was auto-generated from query/users.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.ListUsers where

import Queries.Internal (Query(..), Params, Result)
import GHC.Generics (Generic)
import qualified Database.PostgreSQL.Simple

import qualified Data.Int
import qualified Data.Text

query_ListUsers :: Query "ListUsers" "SELECT"
query_ListUsers = Query "SELECT * FROM users;"

data instance Params "ListUsers" = Params_ListUsers
  {
  }

data instance Result "ListUsers" = Result_ListUsers
  {
    id :: !Data.Int.Int32,
    name :: !Data.Text.Text
  }

deriving stock instance Generic (Params "ListUsers")
deriving anyclass instance Database.PostgreSQL.Simple.ToRow (Params "ListUsers")

deriving stock instance Generic (Result "ListUsers")
deriving anyclass instance Database.PostgreSQL.Simple.FromRow (Result "ListUsers")

