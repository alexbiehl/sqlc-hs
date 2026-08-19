# Revision history for sqlc-haskell

## Unreleased

* A hasql backend for PostgreSQL, selected with the new `driver` option
  (`driver: hasql`). The default stays `postgresql-simple`, so existing
  configurations generate the same code as before. Requires hasql >= 1.10.
  The generated internal module declares the `ToRow`/`FromRow` and
  `ToField`/`FromField` classes hasql does not ship, and overrides can name
  their codecs with the new `hasql_encoder` and `hasql_decoder` keys.
* Normalise numbered `?N` placeholders (emitted by sqlc for `sqlc.arg`)
  to positional `?` so sqlite-simple can parse the query (SQLite).

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
