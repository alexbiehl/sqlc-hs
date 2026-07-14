# sqlc-hs

A Haskell code generator plugin for [sqlc](https://github.com/kyleconroy/sqlc), allowing you to generate idiomatic Haskell types and functions directly from your SQL queries.

It leverages [postgresql-simple](https://hackage.haskell.org/package/postgresql-simple), [mysql-simple](https://hackage.haskell.org/package/mysql-simple), and [sqlite-simple](https://hackage.haskell.org/package/sqlite-simple), generating a thin layer on top of these well-known libraries.

## Installation

sqlc-hs can be used as a WASM plugin or as a process plugin. Refer to the
[sqlc documentation](https://docs.sqlc.dev/en/latest/guides/plugins.html)
for more information.

### WASM plugin (recommended)

Every [release](https://github.com/alexbiehl/sqlc-hs/releases) ships a
`sqlc-hs-<version>.wasm` module. sqlc downloads and runs it for you — no
local installation required. Point your sqlc.yaml at the release asset and
its sha256:

```yaml
version: '2'
plugins:
  - name: haskell
    wasm:
      url: https://github.com/alexbiehl/sqlc-hs/releases/download/v0.2.0.0/sqlc-hs-v0.2.0.0.wasm
      sha256: <sha256 of the .wasm file>
```

The release notes of each release contain this snippet with the correct
sha256 filled in — copy it from there.

### Process plugin

Alternatively, install the `sqlc-hs` executable (e.g. via
`cabal install sqlc-hs`), ensure it is on your PATH when invoking sqlc, and
configure it as a process plugin:

```yaml
version: '2'
plugins:
  - name: haskell
    process:
      cmd: sqlc-hs
```

## Usage

Use the plugin for your schemas like so

```yaml
sql:
  - engine: postgresql
    queries: query.sql
    schema: schema.sql
    codegen:
      - out: gen
        plugin: haskell
        options:
          cabal_package_name: your-package
          cabal_package_version: 0.1.0.0
          haskell_module_prefix: Database.Queries
          overrides:
            - db_type: bytea
              haskell_type:
                package: bytestring
                module: Data.ByteString
                type: Data.ByteString.ByteString
```

## Overrides

`overrides` is a **list** of mappings — each entry tells sqlc-hs to map a
database type (or a specific column) to a Haskell type of your choosing. They
take precedence over the built-in type mappings for the relevant engine.

### Fields

Each override accepts the following keys:

| Key            | Required | Description                                                                                                                                                  |
| -------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `db_type`      | no*      | The fully qualified database type to match, e.g. `bytea`, `pg_catalog.int4`, `text`. Matched against the column type sqlc reports.                            |
| `haskell_type` | yes      | The Haskell type to use. Either a single mapping (see below) or a list of mappings — additional entries declare extra package/module dependencies to import. |
| `column`       | no*      | Match a specific column: `column`, `table.column` or `schema.table.column`. The table part matches the table name or its query alias; a bare `column` also matches aliased expression outputs (e.g. `CAST(... AS TEXT) AS created_at`), which carry no table. |
| `engine`       | no       | Restrict the override to a specific engine (`postgresql`, `mysql`, or `sqlite`). Useful when one configuration targets multiple engines.                      |
| `nullable`     | no       | If `true`, only match columns that are nullable. If `false` or omitted, only match columns that are `NOT NULL`.                                              |

\* At least one of `db_type` or `column` must be given. When both are given,
both must match.

A `haskell_type` mapping has three fields, all of which must be fully
qualified:

| Key       | Description                                                                  |
| --------- | ---------------------------------------------------------------------------- |
| `package` | The cabal package providing the type, e.g. `bytestring`. Added as a dependency in the generated cabal file. |
| `module`  | The module to import, e.g. `Data.ByteString`.                                |
| `type`    | The fully qualified type name, e.g. `Data.ByteString.ByteString`. May be a composed type like `Data.Vector.Vector Data.Text.Text`. |

### Examples

Map every `bytea` column to a strict `ByteString`:

```yaml
overrides:
  - db_type: bytea
    haskell_type:
      package: bytestring
      module: Data.ByteString
      type: Data.ByteString.ByteString
```

Give `haskell_type` as a **list** when the type is composed from more than
one module: the first entry's `type` is what gets rendered, and every
entry's `package`/`module` is added as a cabal dependency and import. Here a
custom `x509_certificate` domain maps to `Binary ByteString`, which needs
both `postgresql-simple` and `bytestring`:

```yaml
overrides:
  - db_type: x509_certificate
    haskell_type:
      - type: Database.PostgreSQL.Simple.Binary Data.ByteString.ByteString
      - package: postgresql-simple
        module: Database.PostgreSQL.Simple
      - package: bytestring
        module: Data.ByteString
```

Map a single column (`accounts.id`) to a custom `UserId` newtype:

```yaml
overrides:
  - column: accounts.id
    haskell_type:
      package: your-package
      module: Your.Types
      type: Your.Types.UserId
```

Type a computed/aliased query output that the engine can only describe as
`TEXT` — e.g. a normalized timestamp — as a proper `UTCTime` (the runtime
`FromField`/`FromRow` instances of your driver do the decoding):

```yaml
overrides:
  - column: last_error_at
    haskell_type:
      package: time
      module: Data.Time
      type: Data.Time.UTCTime
```

Apply different mappings depending on the engine:

```yaml
overrides:
  - db_type: jsonb
    engine: postgresql
    haskell_type:
      package: aeson
      module: Data.Aeson
      type: Data.Aeson.Value
  - db_type: json
    engine: mysql
    haskell_type:
      package: aeson
      module: Data.Aeson
      type: Data.Aeson.Value
```

Override only nullable columns of a given type:

```yaml
overrides:
  - db_type: text
    nullable: true
    haskell_type:
      package: text
      module: Data.Text
      type: GHC.Base.Maybe Data.Text.Text
```

## Naming

`naming` customizes how the names of generated declarations are rendered,
using mustache-style `{{variable}}` templates. Every key is optional — an
omitted template falls back to the default, which reproduces sqlc-hs's
historical naming, so existing configurations keep generating byte-identical
code.

```yaml
codegen:
  - plugin: haskell
    out: queries
    options:
      naming:
        query: "run{{query}}"
        params_constructor: "Mk{{query}}Args"
        result_constructor: "{{query}}Row"
        enum_constructor: "Enum_{{enum}}_{{value}}"
        field: "{{column}}_of_{{table}}"
```

| Key                  | Default                    | Context variables                                                    |
| -------------------- | -------------------------- | -------------------------------------------------------------------- |
| `query`              | `query_{{query}}`          | `query` — the query's name                                            |
| `params_constructor` | `Params_{{query}}`         | `query`                                                               |
| `result_constructor` | `Result_{{query}}`         | `query`                                                               |
| `enum_constructor`   | `Enum_{{enum}}_{{value}}`  | `enum` — the database type name; `value` — the enum value             |
| `field`              | `{{prefix}}{{column}}`     | `column`, `table`, `table_alias`, `schema`, `prefix` (see below)      |

With that configuration, a `ListUsers` query over a `users` table renders as

```haskell
runListUsers :: Query "ListUsers" "SELECT"

data instance Params "ListUsers" = MkListUsersArgs
  { age_of_ :: Data.Int.Int32
  }

data instance Result "ListUsers" = ListUsersRow
  { id_of_users :: !Data.Int.Int32,
    name_of_users :: !Data.Text.Text
  }
```

instead of the default `query_ListUsers` / `Params_ListUsers` /
`Result_ListUsers` with `users_id` / `users_name` fields. (Note `age_of_`:
the parameter has no table, so `{{table}}` rendered empty — see the
`naming-templates` golden test for the full output.)

`prefix` is the historical field namespacing, precomputed so the default
template needs no conditionals: the query's table alias (or, failing that,
the table name) followed by `_` — and empty for table-less outputs such as
computed/aliased expressions.

Templates support plain `{{variable}}` interpolation only (whitespace inside
the braces is ignored); unknown variables render as the empty string, like in
mustache. Rendered names are always fixed up to be valid Haskell identifiers:
characters that cannot appear in an identifier become `_`, functions and
fields get a lower-case first letter (or a leading `_` for digits),
constructors an upper-case one, and Haskell keywords used as field names are
suffixed with `'`.

# (Re-)Generate proto files with proto-lens

```
$ protoc --plugin=protoc-gen-haskell=`cabal exec which proto-lens-protoc` --haskell_out=sqlc-hs-protos/ protos/codegen.proto
```