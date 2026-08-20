{- This file was auto-generated from query/posts.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.FindPosts where

import Queries.Internal (Query(..), Enum, Params, Result, ToRow(..), FromRow(..), ToField(..), FromField(..))
import qualified Hasql.Decoders
import qualified Hasql.Encoders

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

data instance Result "FindPosts" = Result_FindPosts
  {
    tags :: !(Data.Vector.Vector Data.Text.Text),
    labels :: !(GHC.Base.Maybe (Data.Vector.Vector Data.Text.Text))
  }

instance ToRow (Params "FindPosts") where
  {-# INLINE toRow #-}
  toRow =
    mconcat
      [ 
      Data.Functor.Contravariant.contramap (\Params_FindPosts{..} -> tags) (Hasql.Encoders.param (Hasql.Encoders.nonNullable (Hasql.Encoders.foldableArray (Hasql.Encoders.nonNullable Hasql.Encoders.text))))
      ]

instance FromRow (Result "FindPosts") where
  {-# INLINE fromRow #-}
  fromRow =
    pure Result_FindPosts
      <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable (Hasql.Decoders.vectorArray (Hasql.Decoders.nonNullable Hasql.Decoders.text)))
      <*> Hasql.Decoders.column (Hasql.Decoders.nullable (Hasql.Decoders.vectorArray (Hasql.Decoders.nonNullable Hasql.Decoders.varchar)))


