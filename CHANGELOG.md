# Revision history for sqlc-haskell

## 0.2.0.0 -- 2026-07-14

* Mustache-style naming templates for generated declarations.
* Per-column type overrides via the `overrides` option.
* The plugin is now also published as a WASM module, so it can be
  used without installing the `sqlc-hs` executable locally.
* Support for `:copyfrom` queries.
* Binary type support for PostgreSQL (`bytea`).
* Fix binding of positional `?` parameters in generated `toRow`
  instances (SQLite).
* Normalise column types to lowercase before builtin matching (SQLite).

## 0.1.0.0 -- YYYY-mm-dd

* First version. Released on an unsuspecting world.
