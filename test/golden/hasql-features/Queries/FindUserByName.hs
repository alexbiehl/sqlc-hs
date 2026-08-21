{- This file was auto-generated from query/users.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.FindUserByName where

import Queries.Internal (Query(..), Enum, Params)
import qualified Queries.Internal
import qualified Data.Int
import qualified Data.Vector
import qualified Hasql.Decoders
import qualified Hasql.Encoders
import qualified Hasql.Mapping.IsScalar
import qualified Hasql.Mapping.IsStatement
import qualified Hasql.Statement

import qualified Data.Text
import qualified Data.Int
import qualified Data.Foldable
import qualified Data.Functor.Contravariant

query_FindUserByName :: Query "FindUserByName" ":many"
query_FindUserByName = Query "SELECT id FROM users WHERE $1::TEXT IS NULL OR $1::TEXT = users.name;"

data instance Params "FindUserByName" = Params_FindUserByName
  {
    name :: Data.Text.Text
  }

data instance Queries.Internal.Result "FindUserByName" = Result_FindUserByName
  {
    id :: !(Data.Int.Int32)
  }

paramsEncoder :: Hasql.Encoders.Params (Params "FindUserByName")
paramsEncoder =
  mconcat
    [ 
    Data.Functor.Contravariant.contramap (\Params_FindUserByName{..} -> name) (Hasql.Encoders.param (Hasql.Encoders.nonNullable Hasql.Encoders.text))
    ]
{-# INLINE paramsEncoder #-}

rowDecoder :: Hasql.Decoders.Row (Queries.Internal.Result "FindUserByName")
rowDecoder =
  pure Result_FindUserByName
    <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable Hasql.Decoders.int4)
{-# INLINE rowDecoder #-}

instance Hasql.Mapping.IsStatement.IsStatement (Params "FindUserByName") where
  type Result (Params "FindUserByName") = Data.Vector.Vector (Queries.Internal.Result "FindUserByName")
  statement =
    Hasql.Statement.preparable sql paramsEncoder (Hasql.Decoders.rowVector rowDecoder)
    where
      Query sql = query_FindUserByName


