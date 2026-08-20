# Revision history for sqlc-haskell

## 0.3.0.0 -- 2026-08-20

* A hasql backend for PostgreSQL, selected with the new `driver` option
  (`driver: hasql`). The default stays `postgresql-simple`, so existing
  configurations generate the same code as before. Requires hasql >= 1.10.
  The generated internal module declares the `ToRow`/`FromRow` and
  `ToField`/`FromField` classes hasql does not ship, and overrides can name
  their codecs with the new `hasql_encoder` and `hasql_decoder` keys.
* Normalise numbered `?N` placeholders (emitted by sqlc for `sqlc.arg`)
  to positional `?` so sqlite-simple can parse the query (SQLite).
* The hasql runners' error type is named through a `RunnerError` alias
  that CPP picks per hasql version, so the generated module compiles
  against both hasql 2.0 (`SessionError`) and hasql 2.1, which replaced
  it with `UseError` (hasql).
* The generated hasql `ToRow`/`FromRow` instances carry `INLINE`. A row
  decoder is a chain of `<$>` and `<*>`, and without an unfolding at the
  instance that chain cannot collapse at its definition site, so every
  column of every row pays for the closures it is made of. Pairs with
  nikita-volkov/hasql#340, which fixes the same problem inside hasql;
  together they cut allocation for a 1001-row two-column decode by
  10.2% (hasql).

## 0.2.0.1 -- 2026-07-14

* Mustache-style naming templates for generated declarations.
* Per-column type overrides via the `overrides` option.
* The plugin is now also published as a WASM module, so it can be
  used without installing the `sqlc-hs` executable locally.
* Support for `:copyfrom` queries.
* Binary type support for PostgreSQL (`bytea`).
* Fix binding of positional `?` parameters in generated `toRow`
  instances (SQLite).
* Normalise column types to lowercase before builtin matching (SQLite).
* PVP-compliant upper bounds on all library dependencies.

## 0.1.0.0 -- YYYY-mm-dd

* First version. Released on an unsuspecting world.
