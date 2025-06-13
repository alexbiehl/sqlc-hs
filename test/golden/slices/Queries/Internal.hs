{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE TypeFamilies #-}
module Queries.Internal (
    Query(..),
    Params,
    Result,
    Queries.Internal.Enum,

    -- * :execResult
    ExecResult(..),
    execResult,

    -- * :exec
    exec,

    -- * :execrows
    execRows,

    -- * :one
    queryOne,

    -- * :many
    queryMany,
    fold,

    -- * :copyfrom
    execMany,

    -- * Reexports
    Database.PostgreSQL.Simple.Connection,
    Database.PostgreSQL.Simple.ToRow,
    Database.PostgreSQL.Simple.FromRow,
  ) where

import Data.Foldable (Foldable)
import qualified Data.Foldable
import Data.Vector (Vector)
import Database.PostgreSQL.Simple (Connection, FromRow, ToRow)
import GHC.TypeLits (Symbol)
import qualified Data.ByteString.Char8
import qualified Data.Int
import qualified Database.PostgreSQL.Simple
import qualified Database.PostgreSQL.Simple.Types
import qualified Database.PostgreSQL.Simple.Vector

newtype Query (name :: Symbol) (command :: Symbol)
  = Query Database.PostgreSQL.Simple.Query

data family Params (name :: Symbol)

data family Result (name :: Symbol)

data family Enum (name :: Symbol)

data ExecResult = ExecResult
  { rowsAffected :: !Data.Int.Int64
  }

exec ::
  (ToRow (Params name)) =>
  Connection ->
  Query name ":exec" ->
  Params name ->
  IO ()
exec connection (Query sql) params = do
  _rowsAffected <- Database.PostgreSQL.Simple.execute connection sql params
  pure ()

execRows ::
  (ToRow (Params name)) =>
  Connection ->
  Query name ":execrows" ->
  Params name ->
  IO Data.Int.Int64
execRows connection (Query sql) params = do
  Database.PostgreSQL.Simple.execute connection sql params

execResult ::
  (ToRow (Params name)) =>
  Connection ->
  Query name ":execresult" ->
  Params name ->
  IO ExecResult
execResult connection (Query sql) params = do
  rowsAffected <- Database.PostgreSQL.Simple.execute connection sql params
  pure ExecResult {
    rowsAffected
  }

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
queryMany connection (Query sql) params =
  Database.PostgreSQL.Simple.Vector.query connection sql params

execMany ::
  (ToRow (Params name), FromRow (Result name), Foldable f) =>
  Connection ->
  Query name ":copyfrom" ->
  f (Params name) ->
  IO Data.Int.Int64
execMany connection (Query sql) params =
  Database.PostgreSQL.Simple.executeMany connection sql (Data.Foldable.toList params)

fold ::
  (ToRow (Params name), FromRow (Result name)) =>
  Connection ->
  Query name ":many" ->
  Params name ->
  a ->
  (a -> Result name -> IO a) ->
  IO a
fold connection (Query sql) params = do
  Database.PostgreSQL.Simple.fold connection sql params
{-# INLINABLE fold #-}