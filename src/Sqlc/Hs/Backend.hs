-- | The database library the generated code is written against.
--
-- sqlc tells us the /engine/ (@postgresql@, @mysql@, @sqlite@); the @driver@
-- configuration option picks between the libraries available for it. Only
-- PostgreSQL currently has more than one.
module Sqlc.Hs.Backend
  ( Backend (..),
    resolveBackend,
  )
where

import Data.List (lookup)
import Data.Text qualified

data Backend
  = -- | <https://hackage.haskell.org/package/postgresql-simple postgresql-simple>
    PostgresqlSimple
  | -- | <https://hackage.haskell.org/package/hasql hasql>
    Hasql
  | -- | <https://hackage.haskell.org/package/sqlite-simple sqlite-simple>
    Sqlite
  | -- | <https://hackage.haskell.org/package/mysql-simple mysql-simple>
    Mysql
  deriving stock (Eq, Show)

-- | Pick the backend for an engine and a configured driver.
--
-- The engine comes from the 'GenerateRequest' settings. sqlc always reports one;
-- 'Nothing' stands for a request that didn't, where there is nothing to pick
-- from and we keep to what sqlc-hs has always generated for it: the
-- postgresql-simple internal module, and no per-query instances.
resolveBackend ::
  -- | Engine, e.g. @postgresql@. May be empty.
  Text ->
  -- | The @driver@ option, if configured.
  Maybe Text ->
  Either Text (Maybe Backend)
resolveBackend engine driver =
  case driver of
    Nothing
      | engine == mempty ->
          Right Nothing
      | otherwise ->
          Right (Just defaultBackend)
    Just driver
      | Just backend <- lookup driver drivers ->
          Right (Just backend)
      | otherwise ->
          Left $
            "Unknown driver "
              <> show driver
              <> " for engine "
              <> show engine
              <> ". Valid drivers are: "
              <> Data.Text.intercalate ", " (map fst drivers)
              <> "."
  where
    -- The drivers available for this engine, the default one first.
    (defaultBackend, drivers) =
      case engine of
        "sqlite" ->
          (Sqlite, [("sqlite-simple", Sqlite)])
        "mysql" ->
          (Mysql, [("mysql-simple", Mysql)])
        _ ->
          ( PostgresqlSimple,
            [ ("postgresql-simple", PostgresqlSimple),
              ("hasql", Hasql)
            ]
          )
