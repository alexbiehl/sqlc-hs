{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.Internal (
    Query(..),
    Params,
    Result,

    exec,
    queryOne,
    queryMany,

    -- * Reexports
    Database.PostgreSQL.Simple.Connection,
    Database.PostgreSQL.Simple.ToRow,
    Database.PostgreSQL.Simple.FromRow,
  ) where

import Data.Vector (Vector)
import Database.PostgreSQL.Simple (Connection, FromRow, ToRow)
import qualified Database.PostgreSQL.Simple
import qualified Database.PostgreSQL.Simple.Vector
import GHC.TypeLits (Symbol)

newtype Query (name :: Symbol) (command :: Symbol)
  = Query Database.PostgreSQL.Simple.Query

data family Params (name :: Symbol)

data family Result (name :: Symbol)

exec :: Connection -> Query name ":exec" -> Params name -> IO ()
exec = undefined

queryOne ::
  (ToRow (Params name), FromRow (Result name)) =>
  Connection ->
  Query name ":one" ->
  Params name ->
  IO (Maybe (Result name))
queryOne connection (Query sql) params = do
  result <- Database.PostgreSQL.Simple.query connection sql params
  case result of
    [] -> pure Nothing
    x : _ -> pure (Just x)

queryMany ::
  (ToRow (Params name), FromRow (Result name)) =>
  Connection ->
  Query name ":many" ->
  Params name ->
  IO (Vector (Result name))
queryMany connection (Query sql) =
  Database.PostgreSQL.Simple.Vector.query connection sql
