{- This file was auto-generated from query/members.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.FindMembers where

import Queries.Internal (Query(..), Enum, Params, Result, ToRow(..), FromRow(..), ToField(..), FromField(..))
import qualified Hasql.Decoders
import qualified Hasql.Encoders

import qualified Queries.Types
import qualified GHC.Base
import qualified Data.Foldable
import qualified Data.Functor.Contravariant

query_FindMembers :: Query "FindMembers" ":many"
query_FindMembers = Query "SELECT role, previous_role FROM members WHERE role = $1;"

data instance Params "FindMembers" = Params_FindMembers
  {
    role :: (Queries.Types.Enum "organization_role")
  }

data instance Result "FindMembers" = Result_FindMembers
  {
    role :: !((Queries.Types.Enum "organization_role")),
    previous_role :: !(GHC.Base.Maybe ((Queries.Types.Enum "organization_role")))
  }

instance ToRow (Params "FindMembers") where
  {-# INLINE toRow #-}
  toRow =
    mconcat
      [ 
      Data.Functor.Contravariant.contramap (\Params_FindMembers{..} -> role) (Hasql.Encoders.param (Hasql.Encoders.nonNullable toField))
      ]

instance FromRow (Result "FindMembers") where
  {-# INLINE fromRow #-}
  fromRow =
    pure Result_FindMembers
      <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable fromField)
      <*> Hasql.Decoders.column (Hasql.Decoders.nullable fromField)


