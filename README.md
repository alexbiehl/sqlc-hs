# (Re-)Generate proto files with proto-lens

```
$ protoc --plugin=protoc-gen-haskell=`cabal exec which proto-lens-protoc` --haskell_out=sqlc-hs-protos/ protos/codegen.proto
```