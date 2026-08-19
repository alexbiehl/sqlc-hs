{- This file was auto-generated from query/users.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.DeleteUsers where

import Queries.Internal (Query(..), Enum, Params, Result, ToRow(..), FromRow(..), ToField(..), FromField(..))
import qualified Hasql.Decoders
import qualified Hasql.Encoders

import qualified Data.Foldable
import qualified Data.Functor.Contravariant

query_DeleteUsers :: Query "DeleteUsers" ":exec"
query_DeleteUsers = Query "DELETE FROM users;"

data instance Params "DeleteUsers" = Params_DeleteUsers
  {
  }

data instance Result "DeleteUsers" = Result_DeleteUsers
  {
  }

instance ToRow (Params "DeleteUsers") where
  toRow =
    mconcat
      [       ]

instance FromRow (Result "DeleteUsers") where
  fromRow =
    pure Result_DeleteUsers


