{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
module Foo.Bar.Internal (
    Query(..),
    Params,
    Result,
    Foo.Bar.Internal.Enum,

    -- * :execResult
    ExecResult(..),
    execResult,

    -- * :exec
    exec,

    -- * :execrows
    execRows,

    -- * :execlastid
    execLastId,

    -- * :one
    queryOne,

    -- * :many
    queryMany,
    fold,

    -- * Reexports
    Database.MySQL.Simple.Connection,
    Database.MySQL.Simple.QueryParams.QueryParams,
    Database.MySQL.Simple.QueryResults.QueryResults,
  ) where

import Database.MySQL.Simple (Connection)
import GHC.TypeLits (Symbol)
import qualified Data.Int
import qualified Database.MySQL.Simple
import qualified Database.MySQL.Simple.QueryParams
import qualified Database.MySQL.Simple.QueryResults

newtype Query (name :: Symbol) (command :: Symbol)
  = Query Database.MySQL.Simple.Query

data family Params (name :: Symbol)

data family Result (name :: Symbol)

data family Enum (name :: Symbol)

data ExecResult = ExecResult
  { lastInsertId :: !Data.Int.Int64,
    rowsAffected :: !Data.Int.Int64
  }

exec ::
  Database.MySQL.Simple.QueryParams.QueryParams (Params name) =>
  Connection ->
  Query name ":exec" ->
  Params name ->
  IO ()
exec connection (Query sql) params = do
  _rowsAffected <- Database.MySQL.Simple.execute connection sql params
  pure ()

execRows ::
  Database.MySQL.Simple.QueryParams.QueryParams (Params name) =>
  Connection ->
  Query name ":execrows" ->
  Params name ->
  IO Data.Int.Int64
execRows connection (Query sql) =
  Database.MySQL.Simple.execute connection sql

execLastId ::
  Database.MySQL.Simple.QueryParams.QueryParams (Params name) =>
  Connection ->
  Query name ":execlastid" ->
  Params name ->
  IO Data.Int.Int64
execLastId connection (Query sql) params = do
  _rowsAffected <- Database.MySQL.Simple.execute connection sql params
  lastInsertId <- Database.MySQL.Simple.insertID connection
  pure (fromIntegral lastInsertId)

execResult ::
  Database.MySQL.Simple.QueryParams.QueryParams (Params name) =>
  Connection ->
  Query name ":execresult" ->
  Params name ->
  IO ExecResult
execResult connection (Query sql) params = do
  rowsAffected <- Database.MySQL.Simple.execute connection sql params
  lastInsertId <- Database.MySQL.Simple.insertID connection
  pure ExecResult {
    lastInsertId = fromIntegral lastInsertId,
    rowsAffected = rowsAffected
  }

queryOne ::
  ( Database.MySQL.Simple.QueryParams.QueryParams (Params name),
    Database.MySQL.Simple.QueryResults.QueryResults (Result name)
  ) =>
  Connection ->
  Query name ":one" ->
  Params name ->
  IO (Maybe (Result name))
queryOne connection (Query sql) params = do
  result <- Database.MySQL.Simple.query connection sql params
  case result of
    [] -> pure Nothing
    x : _ -> pure (Just x)

queryMany ::
  ( Database.MySQL.Simple.QueryParams.QueryParams (Params name),
    Database.MySQL.Simple.QueryResults.QueryResults (Result name)
  ) =>
  Connection ->
  Query name ":many" ->
  Params name ->
  IO [Result name]
queryMany connection (Query sql) =
  Database.MySQL.Simple.query connection sql

fold ::
  ( Database.MySQL.Simple.QueryParams.QueryParams (Params name),
    Database.MySQL.Simple.QueryResults.QueryResults (Result name)
  ) =>
  Connection ->
  Query name ":many" ->
  Params name ->
  a ->
  (a -> Result name -> IO a) ->
  IO a
fold connection (Query sql) =
  Database.MySQL.Simple.fold connection sql
{-# INLINABLE fold #-}