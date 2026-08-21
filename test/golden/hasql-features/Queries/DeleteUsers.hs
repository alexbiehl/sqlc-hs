{- This file was auto-generated from query/users.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.DeleteUsers where

import Queries.Internal (Query(..), Enum, Params)
import qualified Queries.Internal
import qualified Data.Int
import qualified Data.Vector
import qualified Hasql.Decoders
import qualified Hasql.Encoders
import qualified Hasql.Mapping.IsScalar
import qualified Hasql.Mapping.IsStatement
import qualified Hasql.Statement

import qualified Data.Foldable
import qualified Data.Functor.Contravariant

query_DeleteUsers :: Query "DeleteUsers" ":exec"
query_DeleteUsers = Query "DELETE FROM users;"

data instance Params "DeleteUsers" = Params_DeleteUsers
  {
  }

data instance Queries.Internal.Result "DeleteUsers" = Result_DeleteUsers
  {
  }

instance Hasql.Mapping.IsStatement.IsStatement (Params "DeleteUsers") where
  type Result (Params "DeleteUsers") = ()
  statement =
    Hasql.Statement.preparable sql paramsEncoder (Hasql.Decoders.noResult)
    where
      Query sql = query_DeleteUsers

      paramsEncoder :: Hasql.Encoders.Params (Params "DeleteUsers")
      paramsEncoder =
        mconcat
          [           ]
      {-# INLINE paramsEncoder #-}


