{- This file was auto-generated from query.sql by sqlc-hs. -}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Queries.ListAuthors where

import Queries.Internal (Query(..), Params, Result, ToRow, FromRow)
import GHC.Generics (Generic)

import qualified Data.Int
import qualified Data.Text

query_ListAuthors :: Query "ListAuthors" ":many"
query_ListAuthors = Query "SELECT id, name, bio FROM authors\nORDER BY name"

data instance Params "ListAuthors" = Params_ListAuthors
  {
  }
  deriving stock (Generic)
  deriving anyclass (ToRow)

data instance Result "ListAuthors" = Result_ListAuthors
  {
    id :: !Data.Int.Int64,
    name :: !Data.Text.Text,
    bio :: !Data.Text.Text
  }
  deriving stock (Generic)
  deriving anyclass (FromRow)
