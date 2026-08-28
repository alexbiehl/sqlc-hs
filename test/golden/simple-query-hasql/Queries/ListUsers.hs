{- This file was auto-generated from query/users.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.ListUsers where

import Queries.Internal (Query(..), Enum, Params)
import qualified Queries.Internal
import qualified Data.Int
import qualified Data.Vector
import qualified Hasql.Decoders
import qualified Hasql.Encoders
import qualified Hasql.Mapping.IsScalar
import qualified Hasql.Mapping.IsStatement
import qualified Hasql.Statement

import qualified Data.Int
import qualified Data.Text
import qualified GHC.Base
import qualified GHC.Types
import qualified Data.Scientific
import qualified Data.Aeson
import qualified Data.ByteString
import qualified Data.Foldable
import qualified Data.Functor.Contravariant

query_ListUsers :: Query "ListUsers" ":many"
query_ListUsers = Query "SELECT * FROM users WHERE $1 > 42;"

data instance Params "ListUsers" = Params_ListUsers
  {
    age :: Data.Int.Int32
  }

data instance Queries.Internal.Result "ListUsers" = Result_ListUsers
  {
    id :: !(Data.Int.Int32),
    name :: !(Data.Text.Text),
    nickname :: !(GHC.Base.Maybe Data.Text.Text),
    initial :: !(Data.Text.Text),
    is_admin :: !(GHC.Types.Bool),
    balance :: !(Data.Scientific.Scientific),
    ratio :: !(GHC.Base.Maybe GHC.Types.Double),
    meta :: !(Data.Aeson.Value),
    avatar :: !(GHC.Base.Maybe Data.ByteString.ByteString)
  }

instance Hasql.Mapping.IsStatement.IsStatement (Params "ListUsers") where
  type Result (Params "ListUsers") = Data.Vector.Vector (Queries.Internal.Result "ListUsers")
  statement =
    Hasql.Statement.preparable sql paramsEncoder (Hasql.Decoders.rowVector rowDecoder)
    where
      Query sql = query_ListUsers

      paramsEncoder :: Hasql.Encoders.Params (Params "ListUsers")
      paramsEncoder =
        mconcat
          [ 
          Data.Functor.Contravariant.contramap (\Params_ListUsers{..} -> age) (Hasql.Encoders.param (Hasql.Encoders.nonNullable Hasql.Encoders.int4))
          ]
      {-# INLINE paramsEncoder #-}
      rowDecoder :: Hasql.Decoders.Row (Queries.Internal.Result "ListUsers")
      rowDecoder =
        pure Result_ListUsers
          <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable Hasql.Decoders.int4)
          <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable Hasql.Decoders.varchar)
          <*> Hasql.Decoders.column (Hasql.Decoders.nullable Hasql.Decoders.text)
          <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable Hasql.Decoders.bpchar)
          <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable Hasql.Decoders.bool)
          <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable Hasql.Decoders.numeric)
          <*> Hasql.Decoders.column (Hasql.Decoders.nullable Hasql.Decoders.float8)
          <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable Hasql.Decoders.jsonb)
          <*> Hasql.Decoders.column (Hasql.Decoders.nullable Hasql.Decoders.bytea)
      {-# INLINE rowDecoder #-}


