{- This file was auto-generated from query/members.sql by sqlc-hs. -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.FindMembers where

import Queries.Internal (Query(..), Enum, Params)
import qualified Queries.Internal
import qualified Data.Int
import qualified Data.Vector
import qualified Hasql.Decoders
import qualified Hasql.Encoders
import qualified Hasql.Mapping.IsScalar
import qualified Hasql.Mapping.IsStatement
import qualified Hasql.Statement

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

data instance Queries.Internal.Result "FindMembers" = Result_FindMembers
  {
    role :: !((Queries.Types.Enum "organization_role")),
    previous_role :: !(GHC.Base.Maybe ((Queries.Types.Enum "organization_role")))
  }

instance Hasql.Mapping.IsStatement.IsStatement (Params "FindMembers") where
  type Result (Params "FindMembers") = Data.Vector.Vector (Queries.Internal.Result "FindMembers")
  statement =
    Hasql.Statement.preparable sql paramsEncoder (Hasql.Decoders.rowVector rowDecoder)
    where
      Query sql = query_FindMembers

      paramsEncoder :: Hasql.Encoders.Params (Params "FindMembers")
      paramsEncoder =
        mconcat
          [ 
          Data.Functor.Contravariant.contramap (\Params_FindMembers{..} -> role) (Hasql.Encoders.param (Hasql.Encoders.nonNullable Hasql.Mapping.IsScalar.encoder))
          ]
      {-# INLINE paramsEncoder #-}
      rowDecoder :: Hasql.Decoders.Row (Queries.Internal.Result "FindMembers")
      rowDecoder =
        pure Result_FindMembers
          <*> Hasql.Decoders.column (Hasql.Decoders.nonNullable Hasql.Mapping.IsScalar.decoder)
          <*> Hasql.Decoders.column (Hasql.Decoders.nullable Hasql.Mapping.IsScalar.decoder)
      {-# INLINE rowDecoder #-}


