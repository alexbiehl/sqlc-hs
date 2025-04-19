{- This file was auto-generated from query.sql by sqlc-hs. -}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Queries.GetAuthor where

import Queries.Internal (Query(..), Params, Result, ToRow, FromRow)
import GHC.Generics (Generic)

import qualified Data.Int
import qualified Data.Text

query_GetAuthor :: Query "GetAuthor" ":one"
query_GetAuthor = Query "SELECT id, name, bio FROM authors\nWHERE id = $1 LIMIT 1"

data instance Params "GetAuthor" = Params_GetAuthor
  {
    id :: Data.Int.Int64
  }
  deriving stock (Generic)
  deriving anyclass (ToRow)

data instance Result "GetAuthor" = Result_GetAuthor
  {
    id :: !Data.Int.Int64,
    name :: !Data.Text.Text,
    bio :: !Data.Text.Text
  }
  deriving stock (Generic)
  deriving anyclass (FromRow)
