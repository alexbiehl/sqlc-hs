# sqlc-hs

A Haskell code generator plugin for [sqlc](https://github.com/kyleconroy/sqlc), allowing you to generate idiomatic Haskell types and functions directly from your SQL queries.

It leverages [postgresql-simple](https://hackage.haskell.org/package/postgresql-simple), [mysql-simple](https://hackage.haskell.org/package/mysql-simple), and [sqlite-simple](https://hackage.haskell.org/package/sqlite-simple), generating a thin layer on top of these well-known libraries.

Use below configuation in your sqlc.yaml to use sqlc-hs. Refer to the [sqlc documentation](
https://docs.sqlc.dev/en/latest/guides/plugins.html) for more information

```yaml
version: '2'
plugins:
  - name: haskell
    process:
      cmd: sqlc-hs
```

Use the plugin for your schemas like so

```yaml
  codegen:
  - out: gen
    plugin: haskell
    options:
      cabal_package_name: your-package
      cabal_package_version: 0.1.0.0
      haskell_module_prefix: Database.Queries
      overrides:
        db_type: bytea
        haskell_type:
          package: bytestring
          module: Data.ByteString
          type: Data.ByteString.ByteString
```

Ensure that the sqlc-hs executable is on your PATH when invoking sqlc.

# (Re-)Generate proto files with proto-lens

```
$ protoc --plugin=protoc-gen-haskell=`cabal exec which proto-lens-protoc` --haskell_out=sqlc-hs-protos/ protos/codegen.proto
```