{- This file was auto-generated from protos/codegen.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Protos.Codegen_Fields where
import qualified Data.ProtoLens.Runtime.Prelude as Prelude
import qualified Data.ProtoLens.Runtime.Data.Int as Data.Int
import qualified Data.ProtoLens.Runtime.Data.Monoid as Data.Monoid
import qualified Data.ProtoLens.Runtime.Data.Word as Data.Word
import qualified Data.ProtoLens.Runtime.Data.ProtoLens as Data.ProtoLens
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Bytes as Data.ProtoLens.Encoding.Bytes
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Growing as Data.ProtoLens.Encoding.Growing
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Parser.Unsafe as Data.ProtoLens.Encoding.Parser.Unsafe
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Wire as Data.ProtoLens.Encoding.Wire
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Field as Data.ProtoLens.Field
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Message.Enum as Data.ProtoLens.Message.Enum
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Service.Types as Data.ProtoLens.Service.Types
import qualified Data.ProtoLens.Runtime.Lens.Family2 as Lens.Family2
import qualified Data.ProtoLens.Runtime.Lens.Family2.Unchecked as Lens.Family2.Unchecked
import qualified Data.ProtoLens.Runtime.Data.Text as Data.Text
import qualified Data.ProtoLens.Runtime.Data.Map as Data.Map
import qualified Data.ProtoLens.Runtime.Data.ByteString as Data.ByteString
import qualified Data.ProtoLens.Runtime.Data.ByteString.Char8 as Data.ByteString.Char8
import qualified Data.ProtoLens.Runtime.Data.Text.Encoding as Data.Text.Encoding
import qualified Data.ProtoLens.Runtime.Data.Vector as Data.Vector
import qualified Data.ProtoLens.Runtime.Data.Vector.Generic as Data.Vector.Generic
import qualified Data.ProtoLens.Runtime.Data.Vector.Unboxed as Data.Vector.Unboxed
import qualified Data.ProtoLens.Runtime.Text.Read as Text.Read
arrayDims ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "arrayDims" a) =>
  Lens.Family2.LensLike' f s a
arrayDims = Data.ProtoLens.Field.field @"arrayDims"
catalog ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "catalog" a) =>
  Lens.Family2.LensLike' f s a
catalog = Data.ProtoLens.Field.field @"catalog"
cmd ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "cmd" a) =>
  Lens.Family2.LensLike' f s a
cmd = Data.ProtoLens.Field.field @"cmd"
codegen ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "codegen" a) =>
  Lens.Family2.LensLike' f s a
codegen = Data.ProtoLens.Field.field @"codegen"
column ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "column" a) =>
  Lens.Family2.LensLike' f s a
column = Data.ProtoLens.Field.field @"column"
columns ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "columns" a) =>
  Lens.Family2.LensLike' f s a
columns = Data.ProtoLens.Field.field @"columns"
comment ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "comment" a) =>
  Lens.Family2.LensLike' f s a
comment = Data.ProtoLens.Field.field @"comment"
comments ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "comments" a) =>
  Lens.Family2.LensLike' f s a
comments = Data.ProtoLens.Field.field @"comments"
compositeTypes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "compositeTypes" a) =>
  Lens.Family2.LensLike' f s a
compositeTypes = Data.ProtoLens.Field.field @"compositeTypes"
contents ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "contents" a) =>
  Lens.Family2.LensLike' f s a
contents = Data.ProtoLens.Field.field @"contents"
defaultSchema ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "defaultSchema" a) =>
  Lens.Family2.LensLike' f s a
defaultSchema = Data.ProtoLens.Field.field @"defaultSchema"
embedTable ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "embedTable" a) =>
  Lens.Family2.LensLike' f s a
embedTable = Data.ProtoLens.Field.field @"embedTable"
engine ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "engine" a) =>
  Lens.Family2.LensLike' f s a
engine = Data.ProtoLens.Field.field @"engine"
enums ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "enums" a) =>
  Lens.Family2.LensLike' f s a
enums = Data.ProtoLens.Field.field @"enums"
env ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "env" a) =>
  Lens.Family2.LensLike' f s a
env = Data.ProtoLens.Field.field @"env"
filename ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "filename" a) =>
  Lens.Family2.LensLike' f s a
filename = Data.ProtoLens.Field.field @"filename"
files ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "files" a) =>
  Lens.Family2.LensLike' f s a
files = Data.ProtoLens.Field.field @"files"
globalOptions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "globalOptions" a) =>
  Lens.Family2.LensLike' f s a
globalOptions = Data.ProtoLens.Field.field @"globalOptions"
insertIntoTable ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "insertIntoTable" a) =>
  Lens.Family2.LensLike' f s a
insertIntoTable = Data.ProtoLens.Field.field @"insertIntoTable"
isArray ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "isArray" a) =>
  Lens.Family2.LensLike' f s a
isArray = Data.ProtoLens.Field.field @"isArray"
isFuncCall ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "isFuncCall" a) =>
  Lens.Family2.LensLike' f s a
isFuncCall = Data.ProtoLens.Field.field @"isFuncCall"
isNamedParam ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "isNamedParam" a) =>
  Lens.Family2.LensLike' f s a
isNamedParam = Data.ProtoLens.Field.field @"isNamedParam"
isSqlcSlice ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "isSqlcSlice" a) =>
  Lens.Family2.LensLike' f s a
isSqlcSlice = Data.ProtoLens.Field.field @"isSqlcSlice"
length ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "length" a) =>
  Lens.Family2.LensLike' f s a
length = Data.ProtoLens.Field.field @"length"
maybe'catalog ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'catalog" a) =>
  Lens.Family2.LensLike' f s a
maybe'catalog = Data.ProtoLens.Field.field @"maybe'catalog"
maybe'codegen ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'codegen" a) =>
  Lens.Family2.LensLike' f s a
maybe'codegen = Data.ProtoLens.Field.field @"maybe'codegen"
maybe'column ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'column" a) =>
  Lens.Family2.LensLike' f s a
maybe'column = Data.ProtoLens.Field.field @"maybe'column"
maybe'embedTable ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'embedTable" a) =>
  Lens.Family2.LensLike' f s a
maybe'embedTable = Data.ProtoLens.Field.field @"maybe'embedTable"
maybe'insertIntoTable ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'insertIntoTable" a) =>
  Lens.Family2.LensLike' f s a
maybe'insertIntoTable
  = Data.ProtoLens.Field.field @"maybe'insertIntoTable"
maybe'process ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'process" a) =>
  Lens.Family2.LensLike' f s a
maybe'process = Data.ProtoLens.Field.field @"maybe'process"
maybe'rel ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'rel" a) =>
  Lens.Family2.LensLike' f s a
maybe'rel = Data.ProtoLens.Field.field @"maybe'rel"
maybe'settings ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'settings" a) =>
  Lens.Family2.LensLike' f s a
maybe'settings = Data.ProtoLens.Field.field @"maybe'settings"
maybe'table ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'table" a) =>
  Lens.Family2.LensLike' f s a
maybe'table = Data.ProtoLens.Field.field @"maybe'table"
maybe'type' ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'type'" a) =>
  Lens.Family2.LensLike' f s a
maybe'type' = Data.ProtoLens.Field.field @"maybe'type'"
maybe'wasm ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "maybe'wasm" a) =>
  Lens.Family2.LensLike' f s a
maybe'wasm = Data.ProtoLens.Field.field @"maybe'wasm"
name ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "name" a) =>
  Lens.Family2.LensLike' f s a
name = Data.ProtoLens.Field.field @"name"
notNull ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "notNull" a) =>
  Lens.Family2.LensLike' f s a
notNull = Data.ProtoLens.Field.field @"notNull"
number ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "number" a) =>
  Lens.Family2.LensLike' f s a
number = Data.ProtoLens.Field.field @"number"
options ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "options" a) =>
  Lens.Family2.LensLike' f s a
options = Data.ProtoLens.Field.field @"options"
originalName ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "originalName" a) =>
  Lens.Family2.LensLike' f s a
originalName = Data.ProtoLens.Field.field @"originalName"
out ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "out" a) =>
  Lens.Family2.LensLike' f s a
out = Data.ProtoLens.Field.field @"out"
params ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "params" a) =>
  Lens.Family2.LensLike' f s a
params = Data.ProtoLens.Field.field @"params"
plugin ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "plugin" a) =>
  Lens.Family2.LensLike' f s a
plugin = Data.ProtoLens.Field.field @"plugin"
pluginOptions ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "pluginOptions" a) =>
  Lens.Family2.LensLike' f s a
pluginOptions = Data.ProtoLens.Field.field @"pluginOptions"
process ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "process" a) =>
  Lens.Family2.LensLike' f s a
process = Data.ProtoLens.Field.field @"process"
queries ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "queries" a) =>
  Lens.Family2.LensLike' f s a
queries = Data.ProtoLens.Field.field @"queries"
rel ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "rel" a) =>
  Lens.Family2.LensLike' f s a
rel = Data.ProtoLens.Field.field @"rel"
schema ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "schema" a) =>
  Lens.Family2.LensLike' f s a
schema = Data.ProtoLens.Field.field @"schema"
schemas ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "schemas" a) =>
  Lens.Family2.LensLike' f s a
schemas = Data.ProtoLens.Field.field @"schemas"
scope ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "scope" a) =>
  Lens.Family2.LensLike' f s a
scope = Data.ProtoLens.Field.field @"scope"
settings ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "settings" a) =>
  Lens.Family2.LensLike' f s a
settings = Data.ProtoLens.Field.field @"settings"
sha256 ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "sha256" a) =>
  Lens.Family2.LensLike' f s a
sha256 = Data.ProtoLens.Field.field @"sha256"
sqlcVersion ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "sqlcVersion" a) =>
  Lens.Family2.LensLike' f s a
sqlcVersion = Data.ProtoLens.Field.field @"sqlcVersion"
table ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "table" a) =>
  Lens.Family2.LensLike' f s a
table = Data.ProtoLens.Field.field @"table"
tableAlias ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "tableAlias" a) =>
  Lens.Family2.LensLike' f s a
tableAlias = Data.ProtoLens.Field.field @"tableAlias"
tables ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "tables" a) =>
  Lens.Family2.LensLike' f s a
tables = Data.ProtoLens.Field.field @"tables"
text ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "text" a) =>
  Lens.Family2.LensLike' f s a
text = Data.ProtoLens.Field.field @"text"
type' ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "type'" a) =>
  Lens.Family2.LensLike' f s a
type' = Data.ProtoLens.Field.field @"type'"
unsigned ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "unsigned" a) =>
  Lens.Family2.LensLike' f s a
unsigned = Data.ProtoLens.Field.field @"unsigned"
url ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "url" a) =>
  Lens.Family2.LensLike' f s a
url = Data.ProtoLens.Field.field @"url"
vals ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "vals" a) =>
  Lens.Family2.LensLike' f s a
vals = Data.ProtoLens.Field.field @"vals"
vec'columns ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'columns" a) =>
  Lens.Family2.LensLike' f s a
vec'columns = Data.ProtoLens.Field.field @"vec'columns"
vec'comments ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'comments" a) =>
  Lens.Family2.LensLike' f s a
vec'comments = Data.ProtoLens.Field.field @"vec'comments"
vec'compositeTypes ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'compositeTypes" a) =>
  Lens.Family2.LensLike' f s a
vec'compositeTypes
  = Data.ProtoLens.Field.field @"vec'compositeTypes"
vec'enums ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'enums" a) =>
  Lens.Family2.LensLike' f s a
vec'enums = Data.ProtoLens.Field.field @"vec'enums"
vec'env ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "vec'env" a) =>
  Lens.Family2.LensLike' f s a
vec'env = Data.ProtoLens.Field.field @"vec'env"
vec'files ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'files" a) =>
  Lens.Family2.LensLike' f s a
vec'files = Data.ProtoLens.Field.field @"vec'files"
vec'params ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'params" a) =>
  Lens.Family2.LensLike' f s a
vec'params = Data.ProtoLens.Field.field @"vec'params"
vec'queries ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'queries" a) =>
  Lens.Family2.LensLike' f s a
vec'queries = Data.ProtoLens.Field.field @"vec'queries"
vec'schema ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'schema" a) =>
  Lens.Family2.LensLike' f s a
vec'schema = Data.ProtoLens.Field.field @"vec'schema"
vec'schemas ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'schemas" a) =>
  Lens.Family2.LensLike' f s a
vec'schemas = Data.ProtoLens.Field.field @"vec'schemas"
vec'tables ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'tables" a) =>
  Lens.Family2.LensLike' f s a
vec'tables = Data.ProtoLens.Field.field @"vec'tables"
vec'vals ::
  forall f s a.
  (Prelude.Functor f,
   Data.ProtoLens.Field.HasField s "vec'vals" a) =>
  Lens.Family2.LensLike' f s a
vec'vals = Data.ProtoLens.Field.field @"vec'vals"
version ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "version" a) =>
  Lens.Family2.LensLike' f s a
version = Data.ProtoLens.Field.field @"version"
wasm ::
  forall f s a.
  (Prelude.Functor f, Data.ProtoLens.Field.HasField s "wasm" a) =>
  Lens.Family2.LensLike' f s a
wasm = Data.ProtoLens.Field.field @"wasm"