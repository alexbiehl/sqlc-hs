{- This file was auto-generated from query.sql by sqlc-hs. -}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Queries.DeleteAuthor where

import Queries.Internal (Query(..), Params, Result, ToRow, FromRow)
import GHC.Generics (Generic)

import qualified Data.Int

query_DeleteAuthor :: Query "DeleteAuthor" ":exec"
query_DeleteAuthor = Query "DELETE FROM authors\nWHERE id = $1"

data instance Params "DeleteAuthor" = Params_DeleteAuthor
  {
    id :: Data.Int.Int64
  }
  deriving stock (Generic)
  deriving anyclass (ToRow)

