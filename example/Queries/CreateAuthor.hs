{- This file was auto-generated from query.sql by sqlc-hs. -}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Queries.CreateAuthor where

import Queries.Internal (Query(..), Params, Result, ToRow, FromRow)
import GHC.Generics (Generic)

import qualified Data.Text
import qualified Data.Int

query_CreateAuthor :: Query "CreateAuthor" ":one"
query_CreateAuthor = Query "INSERT INTO authors (\n          name, bio\n) VALUES (\n  $1, $2\n)\nRETURNING id, name, bio"

data instance Params "CreateAuthor" = Params_CreateAuthor
  {
    name :: Data.Text.Text,
    bio :: Data.Text.Text
  }
  deriving stock (Generic)
  deriving anyclass (ToRow)

data instance Result "CreateAuthor" = Result_CreateAuthor
  {
    id :: !Data.Int.Int64,
    name :: !Data.Text.Text,
    bio :: !Data.Text.Text
  }
  deriving stock (Generic)
  deriving anyclass (FromRow)
