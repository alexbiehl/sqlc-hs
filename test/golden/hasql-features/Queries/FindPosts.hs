{- This file was auto-generated from query/posts.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.FindPosts where

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
import qualified Data.Vector
import qualified GHC.Base
import qualified Data.Foldable
import qualified Data.Functor.Contravariant

query_FindPosts :: Query "FindPosts" ":many"
query_FindPosts = Query "SELECT tags, labels FROM posts WHERE tags && $1;"

data instance Params "FindPosts" = Params_FindPosts
  {
    tags :: Data.Vector.Vector Data.Text.Text
  }

data instance Queries.Internal.Result "FindPosts" = Result_FindPosts
  {
    tags :: !(Data.Vector.Vector Data.Text.Text),
    labels :: !(GHC.Base.Maybe (Data.Vector.Vector Data.Text.Text))
  }

paramsEncoder :: Hasql.Encoders.Params (Params "FindPosts")
paramsEncoder =
  mconcat
    [ 
    Data.Functor.Contravariant.contramap (\Params_FindPosts{..} -> tags) (Hasql.Encoders.param (Hasql.Encoders.nonNullable (Hasql.Encoders.foldableArray (Hasql.Encoders.nonNullable Hasql.Encoders.text))))
    ]
{-# INLINE paramsEncoder #-}

rowDecoder :: Hasql.Decoders.Row (Queries.Internal.Result "FindPosts")
rowDecoder =
  pure Result_FindPosts
    <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable (Hasql.Decoders.vectorArray (Hasql.Decoders.nonNullable Hasql.Decoders.text)))
    <*> Hasql.Decoders.column (Hasql.Decoders.nullable (Hasql.Decoders.vectorArray (Hasql.Decoders.nonNullable Hasql.Decoders.varchar)))
{-# INLINE rowDecoder #-}

instance Hasql.Mapping.IsStatement.IsStatement (Params "FindPosts") where
  type Result (Params "FindPosts") = Data.Vector.Vector (Queries.Internal.Result "FindPosts")
  statement =
    Hasql.Statement.preparable sql paramsEncoder (Hasql.Decoders.rowVector rowDecoder)
    where
      Query sql = query_FindPosts


