{- This file was auto-generated from protos/codegen.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Protos.Codegen (
        CodegenService(..), Catalog(), Codegen(), Codegen'Process(),
        Codegen'WASM(), Column(), CompositeType(), Enum(), File(),
        GenerateRequest(), GenerateResponse(), Identifier(), Parameter(),
        Query(), Schema(), Settings(), Table()
    ) where
import qualified Data.ProtoLens.Runtime.Control.DeepSeq as Control.DeepSeq
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Prism as Data.ProtoLens.Prism
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
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.comment' @:: Lens' Catalog Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.defaultSchema' @:: Lens' Catalog Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.name' @:: Lens' Catalog Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.schemas' @:: Lens' Catalog [Schema]@
         * 'Proto.Protos.Codegen_Fields.vec'schemas' @:: Lens' Catalog (Data.Vector.Vector Schema)@ -}
data Catalog
  = Catalog'_constructor {_Catalog'comment :: !Data.Text.Text,
                          _Catalog'defaultSchema :: !Data.Text.Text,
                          _Catalog'name :: !Data.Text.Text,
                          _Catalog'schemas :: !(Data.Vector.Vector Schema),
                          _Catalog'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Catalog where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Catalog "comment" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Catalog'comment (\ x__ y__ -> x__ {_Catalog'comment = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Catalog "defaultSchema" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Catalog'defaultSchema
           (\ x__ y__ -> x__ {_Catalog'defaultSchema = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Catalog "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Catalog'name (\ x__ y__ -> x__ {_Catalog'name = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Catalog "schemas" [Schema] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Catalog'schemas (\ x__ y__ -> x__ {_Catalog'schemas = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Catalog "vec'schemas" (Data.Vector.Vector Schema) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Catalog'schemas (\ x__ y__ -> x__ {_Catalog'schemas = y__}))
        Prelude.id
instance Data.ProtoLens.Message Catalog where
  messageName _ = Data.Text.pack "plugin.Catalog"
  packedMessageDescriptor _
    = "\n\
      \\aCatalog\DC2\CAN\n\
      \\acomment\CAN\SOH \SOH(\tR\acomment\DC2%\n\
      \\SOdefault_schema\CAN\STX \SOH(\tR\rdefaultSchema\DC2\DC2\n\
      \\EOTname\CAN\ETX \SOH(\tR\EOTname\DC2(\n\
      \\aschemas\CAN\EOT \ETX(\v2\SO.plugin.SchemaR\aschemas"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        comment__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "comment"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"comment")) ::
              Data.ProtoLens.FieldDescriptor Catalog
        defaultSchema__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "default_schema"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"defaultSchema")) ::
              Data.ProtoLens.FieldDescriptor Catalog
        name__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"name")) ::
              Data.ProtoLens.FieldDescriptor Catalog
        schemas__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "schemas"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Schema)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"schemas")) ::
              Data.ProtoLens.FieldDescriptor Catalog
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, comment__field_descriptor),
           (Data.ProtoLens.Tag 2, defaultSchema__field_descriptor),
           (Data.ProtoLens.Tag 3, name__field_descriptor),
           (Data.ProtoLens.Tag 4, schemas__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Catalog'_unknownFields
        (\ x__ y__ -> x__ {_Catalog'_unknownFields = y__})
  defMessage
    = Catalog'_constructor
        {_Catalog'comment = Data.ProtoLens.fieldDefault,
         _Catalog'defaultSchema = Data.ProtoLens.fieldDefault,
         _Catalog'name = Data.ProtoLens.fieldDefault,
         _Catalog'schemas = Data.Vector.Generic.empty,
         _Catalog'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Catalog
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Schema
             -> Data.ProtoLens.Encoding.Bytes.Parser Catalog
        loop x mutable'schemas
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'schemas <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                          (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                             mutable'schemas)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'schemas") frozen'schemas x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "comment"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"comment") y x)
                                  mutable'schemas
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "default_schema"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"defaultSchema") y x)
                                  mutable'schemas
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "name"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"name") y x)
                                  mutable'schemas
                        34
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "schemas"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'schemas y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'schemas
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'schemas <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                   Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'schemas)
          "Catalog"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"comment") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let
                   _v
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"defaultSchema") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                ((Data.Monoid.<>)
                   (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"name") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                            ((Prelude..)
                               (\ bs
                                  -> (Data.Monoid.<>)
                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                          (Prelude.fromIntegral (Data.ByteString.length bs)))
                                       (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                               Data.Text.Encoding.encodeUtf8 _v))
                   ((Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                         (\ _v
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                                 ((Prelude..)
                                    (\ bs
                                       -> (Data.Monoid.<>)
                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                               (Prelude.fromIntegral (Data.ByteString.length bs)))
                                            (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                    Data.ProtoLens.encodeMessage _v))
                         (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'schemas") _x))
                      (Data.ProtoLens.Encoding.Wire.buildFieldSet
                         (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))
instance Control.DeepSeq.NFData Catalog where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Catalog'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Catalog'comment x__)
                (Control.DeepSeq.deepseq
                   (_Catalog'defaultSchema x__)
                   (Control.DeepSeq.deepseq
                      (_Catalog'name x__)
                      (Control.DeepSeq.deepseq (_Catalog'schemas x__) ()))))
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.out' @:: Lens' Codegen Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.plugin' @:: Lens' Codegen Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.options' @:: Lens' Codegen Data.ByteString.ByteString@
         * 'Proto.Protos.Codegen_Fields.env' @:: Lens' Codegen [Data.Text.Text]@
         * 'Proto.Protos.Codegen_Fields.vec'env' @:: Lens' Codegen (Data.Vector.Vector Data.Text.Text)@
         * 'Proto.Protos.Codegen_Fields.process' @:: Lens' Codegen Codegen'Process@
         * 'Proto.Protos.Codegen_Fields.maybe'process' @:: Lens' Codegen (Prelude.Maybe Codegen'Process)@
         * 'Proto.Protos.Codegen_Fields.wasm' @:: Lens' Codegen Codegen'WASM@
         * 'Proto.Protos.Codegen_Fields.maybe'wasm' @:: Lens' Codegen (Prelude.Maybe Codegen'WASM)@ -}
data Codegen
  = Codegen'_constructor {_Codegen'out :: !Data.Text.Text,
                          _Codegen'plugin :: !Data.Text.Text,
                          _Codegen'options :: !Data.ByteString.ByteString,
                          _Codegen'env :: !(Data.Vector.Vector Data.Text.Text),
                          _Codegen'process :: !(Prelude.Maybe Codegen'Process),
                          _Codegen'wasm :: !(Prelude.Maybe Codegen'WASM),
                          _Codegen'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Codegen where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Codegen "out" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Codegen'out (\ x__ y__ -> x__ {_Codegen'out = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Codegen "plugin" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Codegen'plugin (\ x__ y__ -> x__ {_Codegen'plugin = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Codegen "options" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Codegen'options (\ x__ y__ -> x__ {_Codegen'options = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Codegen "env" [Data.Text.Text] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Codegen'env (\ x__ y__ -> x__ {_Codegen'env = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Codegen "vec'env" (Data.Vector.Vector Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Codegen'env (\ x__ y__ -> x__ {_Codegen'env = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Codegen "process" Codegen'Process where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Codegen'process (\ x__ y__ -> x__ {_Codegen'process = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Codegen "maybe'process" (Prelude.Maybe Codegen'Process) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Codegen'process (\ x__ y__ -> x__ {_Codegen'process = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Codegen "wasm" Codegen'WASM where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Codegen'wasm (\ x__ y__ -> x__ {_Codegen'wasm = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Codegen "maybe'wasm" (Prelude.Maybe Codegen'WASM) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Codegen'wasm (\ x__ y__ -> x__ {_Codegen'wasm = y__}))
        Prelude.id
instance Data.ProtoLens.Message Codegen where
  messageName _ = Data.Text.pack "plugin.Codegen"
  packedMessageDescriptor _
    = "\n\
      \\aCodegen\DC2\DLE\n\
      \\ETXout\CAN\SOH \SOH(\tR\ETXout\DC2\SYN\n\
      \\ACKplugin\CAN\STX \SOH(\tR\ACKplugin\DC2\CAN\n\
      \\aoptions\CAN\ETX \SOH(\fR\aoptions\DC2\DLE\n\
      \\ETXenv\CAN\EOT \ETX(\tR\ETXenv\DC21\n\
      \\aprocess\CAN\ENQ \SOH(\v2\ETB.plugin.Codegen.ProcessR\aprocess\DC2(\n\
      \\EOTwasm\CAN\ACK \SOH(\v2\DC4.plugin.Codegen.WASMR\EOTwasm\SUB\ESC\n\
      \\aProcess\DC2\DLE\n\
      \\ETXcmd\CAN\SOH \SOH(\tR\ETXcmd\SUB0\n\
      \\EOTWASM\DC2\DLE\n\
      \\ETXurl\CAN\SOH \SOH(\tR\ETXurl\DC2\SYN\n\
      \\ACKsha256\CAN\STX \SOH(\tR\ACKsha256"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        out__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "out"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"out")) ::
              Data.ProtoLens.FieldDescriptor Codegen
        plugin__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "plugin"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"plugin")) ::
              Data.ProtoLens.FieldDescriptor Codegen
        options__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "options"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"options")) ::
              Data.ProtoLens.FieldDescriptor Codegen
        env__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "env"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"env")) ::
              Data.ProtoLens.FieldDescriptor Codegen
        process__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "process"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Codegen'Process)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'process")) ::
              Data.ProtoLens.FieldDescriptor Codegen
        wasm__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "wasm"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Codegen'WASM)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'wasm")) ::
              Data.ProtoLens.FieldDescriptor Codegen
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, out__field_descriptor),
           (Data.ProtoLens.Tag 2, plugin__field_descriptor),
           (Data.ProtoLens.Tag 3, options__field_descriptor),
           (Data.ProtoLens.Tag 4, env__field_descriptor),
           (Data.ProtoLens.Tag 5, process__field_descriptor),
           (Data.ProtoLens.Tag 6, wasm__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Codegen'_unknownFields
        (\ x__ y__ -> x__ {_Codegen'_unknownFields = y__})
  defMessage
    = Codegen'_constructor
        {_Codegen'out = Data.ProtoLens.fieldDefault,
         _Codegen'plugin = Data.ProtoLens.fieldDefault,
         _Codegen'options = Data.ProtoLens.fieldDefault,
         _Codegen'env = Data.Vector.Generic.empty,
         _Codegen'process = Prelude.Nothing,
         _Codegen'wasm = Prelude.Nothing, _Codegen'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Codegen
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Data.Text.Text
             -> Data.ProtoLens.Encoding.Bytes.Parser Codegen
        loop x mutable'env
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'env <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                      (Data.ProtoLens.Encoding.Growing.unsafeFreeze mutable'env)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'env") frozen'env x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "out"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"out") y x)
                                  mutable'env
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "plugin"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"plugin") y x)
                                  mutable'env
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getBytes
                                             (Prelude.fromIntegral len))
                                       "options"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"options") y x)
                                  mutable'env
                        34
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.getText
                                              (Prelude.fromIntegral len))
                                        "env"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'env y)
                                loop x v
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "process"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"process") y x)
                                  mutable'env
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "wasm"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"wasm") y x)
                                  mutable'env
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'env
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'env <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                               Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'env)
          "Codegen"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"out") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"plugin") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                ((Data.Monoid.<>)
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"options") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                            ((\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                               _v))
                   ((Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                         (\ _v
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                                 ((Prelude..)
                                    (\ bs
                                       -> (Data.Monoid.<>)
                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                               (Prelude.fromIntegral (Data.ByteString.length bs)))
                                            (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                    Data.Text.Encoding.encodeUtf8 _v))
                         (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'env") _x))
                      ((Data.Monoid.<>)
                         (case
                              Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'process") _x
                          of
                            Prelude.Nothing -> Data.Monoid.mempty
                            (Prelude.Just _v)
                              -> (Data.Monoid.<>)
                                   (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                   ((Prelude..)
                                      (\ bs
                                         -> (Data.Monoid.<>)
                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                 (Prelude.fromIntegral (Data.ByteString.length bs)))
                                              (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                      Data.ProtoLens.encodeMessage _v))
                         ((Data.Monoid.<>)
                            (case
                                 Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'wasm") _x
                             of
                               Prelude.Nothing -> Data.Monoid.mempty
                               (Prelude.Just _v)
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                      ((Prelude..)
                                         (\ bs
                                            -> (Data.Monoid.<>)
                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                    (Prelude.fromIntegral
                                                       (Data.ByteString.length bs)))
                                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                         Data.ProtoLens.encodeMessage _v))
                            (Data.ProtoLens.Encoding.Wire.buildFieldSet
                               (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))))
instance Control.DeepSeq.NFData Codegen where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Codegen'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Codegen'out x__)
                (Control.DeepSeq.deepseq
                   (_Codegen'plugin x__)
                   (Control.DeepSeq.deepseq
                      (_Codegen'options x__)
                      (Control.DeepSeq.deepseq
                         (_Codegen'env x__)
                         (Control.DeepSeq.deepseq
                            (_Codegen'process x__)
                            (Control.DeepSeq.deepseq (_Codegen'wasm x__) ()))))))
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.cmd' @:: Lens' Codegen'Process Data.Text.Text@ -}
data Codegen'Process
  = Codegen'Process'_constructor {_Codegen'Process'cmd :: !Data.Text.Text,
                                  _Codegen'Process'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Codegen'Process where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Codegen'Process "cmd" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Codegen'Process'cmd
           (\ x__ y__ -> x__ {_Codegen'Process'cmd = y__}))
        Prelude.id
instance Data.ProtoLens.Message Codegen'Process where
  messageName _ = Data.Text.pack "plugin.Codegen.Process"
  packedMessageDescriptor _
    = "\n\
      \\aProcess\DC2\DLE\n\
      \\ETXcmd\CAN\SOH \SOH(\tR\ETXcmd"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        cmd__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cmd"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"cmd")) ::
              Data.ProtoLens.FieldDescriptor Codegen'Process
      in
        Data.Map.fromList [(Data.ProtoLens.Tag 1, cmd__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Codegen'Process'_unknownFields
        (\ x__ y__ -> x__ {_Codegen'Process'_unknownFields = y__})
  defMessage
    = Codegen'Process'_constructor
        {_Codegen'Process'cmd = Data.ProtoLens.fieldDefault,
         _Codegen'Process'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Codegen'Process
          -> Data.ProtoLens.Encoding.Bytes.Parser Codegen'Process
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "cmd"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"cmd") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Process"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"cmd") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData Codegen'Process where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Codegen'Process'_unknownFields x__)
             (Control.DeepSeq.deepseq (_Codegen'Process'cmd x__) ())
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.url' @:: Lens' Codegen'WASM Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.sha256' @:: Lens' Codegen'WASM Data.Text.Text@ -}
data Codegen'WASM
  = Codegen'WASM'_constructor {_Codegen'WASM'url :: !Data.Text.Text,
                               _Codegen'WASM'sha256 :: !Data.Text.Text,
                               _Codegen'WASM'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Codegen'WASM where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Codegen'WASM "url" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Codegen'WASM'url (\ x__ y__ -> x__ {_Codegen'WASM'url = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Codegen'WASM "sha256" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Codegen'WASM'sha256
           (\ x__ y__ -> x__ {_Codegen'WASM'sha256 = y__}))
        Prelude.id
instance Data.ProtoLens.Message Codegen'WASM where
  messageName _ = Data.Text.pack "plugin.Codegen.WASM"
  packedMessageDescriptor _
    = "\n\
      \\EOTWASM\DC2\DLE\n\
      \\ETXurl\CAN\SOH \SOH(\tR\ETXurl\DC2\SYN\n\
      \\ACKsha256\CAN\STX \SOH(\tR\ACKsha256"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        url__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "url"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"url")) ::
              Data.ProtoLens.FieldDescriptor Codegen'WASM
        sha256__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "sha256"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"sha256")) ::
              Data.ProtoLens.FieldDescriptor Codegen'WASM
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, url__field_descriptor),
           (Data.ProtoLens.Tag 2, sha256__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Codegen'WASM'_unknownFields
        (\ x__ y__ -> x__ {_Codegen'WASM'_unknownFields = y__})
  defMessage
    = Codegen'WASM'_constructor
        {_Codegen'WASM'url = Data.ProtoLens.fieldDefault,
         _Codegen'WASM'sha256 = Data.ProtoLens.fieldDefault,
         _Codegen'WASM'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Codegen'WASM -> Data.ProtoLens.Encoding.Bytes.Parser Codegen'WASM
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "url"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"url") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "sha256"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"sha256") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WASM"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"url") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"sha256") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData Codegen'WASM where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Codegen'WASM'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Codegen'WASM'url x__)
                (Control.DeepSeq.deepseq (_Codegen'WASM'sha256 x__) ()))
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.name' @:: Lens' Column Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.notNull' @:: Lens' Column Prelude.Bool@
         * 'Proto.Protos.Codegen_Fields.isArray' @:: Lens' Column Prelude.Bool@
         * 'Proto.Protos.Codegen_Fields.comment' @:: Lens' Column Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.length' @:: Lens' Column Data.Int.Int32@
         * 'Proto.Protos.Codegen_Fields.isNamedParam' @:: Lens' Column Prelude.Bool@
         * 'Proto.Protos.Codegen_Fields.isFuncCall' @:: Lens' Column Prelude.Bool@
         * 'Proto.Protos.Codegen_Fields.scope' @:: Lens' Column Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.table' @:: Lens' Column Identifier@
         * 'Proto.Protos.Codegen_Fields.maybe'table' @:: Lens' Column (Prelude.Maybe Identifier)@
         * 'Proto.Protos.Codegen_Fields.tableAlias' @:: Lens' Column Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.type'' @:: Lens' Column Identifier@
         * 'Proto.Protos.Codegen_Fields.maybe'type'' @:: Lens' Column (Prelude.Maybe Identifier)@
         * 'Proto.Protos.Codegen_Fields.isSqlcSlice' @:: Lens' Column Prelude.Bool@
         * 'Proto.Protos.Codegen_Fields.embedTable' @:: Lens' Column Identifier@
         * 'Proto.Protos.Codegen_Fields.maybe'embedTable' @:: Lens' Column (Prelude.Maybe Identifier)@
         * 'Proto.Protos.Codegen_Fields.originalName' @:: Lens' Column Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.unsigned' @:: Lens' Column Prelude.Bool@
         * 'Proto.Protos.Codegen_Fields.arrayDims' @:: Lens' Column Data.Int.Int32@ -}
data Column
  = Column'_constructor {_Column'name :: !Data.Text.Text,
                         _Column'notNull :: !Prelude.Bool,
                         _Column'isArray :: !Prelude.Bool,
                         _Column'comment :: !Data.Text.Text,
                         _Column'length :: !Data.Int.Int32,
                         _Column'isNamedParam :: !Prelude.Bool,
                         _Column'isFuncCall :: !Prelude.Bool,
                         _Column'scope :: !Data.Text.Text,
                         _Column'table :: !(Prelude.Maybe Identifier),
                         _Column'tableAlias :: !Data.Text.Text,
                         _Column'type' :: !(Prelude.Maybe Identifier),
                         _Column'isSqlcSlice :: !Prelude.Bool,
                         _Column'embedTable :: !(Prelude.Maybe Identifier),
                         _Column'originalName :: !Data.Text.Text,
                         _Column'unsigned :: !Prelude.Bool,
                         _Column'arrayDims :: !Data.Int.Int32,
                         _Column'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Column where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Column "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'name (\ x__ y__ -> x__ {_Column'name = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Column "notNull" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'notNull (\ x__ y__ -> x__ {_Column'notNull = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Column "isArray" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'isArray (\ x__ y__ -> x__ {_Column'isArray = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Column "comment" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'comment (\ x__ y__ -> x__ {_Column'comment = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Column "length" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'length (\ x__ y__ -> x__ {_Column'length = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Column "isNamedParam" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'isNamedParam
           (\ x__ y__ -> x__ {_Column'isNamedParam = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Column "isFuncCall" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'isFuncCall (\ x__ y__ -> x__ {_Column'isFuncCall = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Column "scope" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'scope (\ x__ y__ -> x__ {_Column'scope = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Column "table" Identifier where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'table (\ x__ y__ -> x__ {_Column'table = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Column "maybe'table" (Prelude.Maybe Identifier) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'table (\ x__ y__ -> x__ {_Column'table = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Column "tableAlias" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'tableAlias (\ x__ y__ -> x__ {_Column'tableAlias = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Column "type'" Identifier where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'type' (\ x__ y__ -> x__ {_Column'type' = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Column "maybe'type'" (Prelude.Maybe Identifier) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'type' (\ x__ y__ -> x__ {_Column'type' = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Column "isSqlcSlice" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'isSqlcSlice (\ x__ y__ -> x__ {_Column'isSqlcSlice = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Column "embedTable" Identifier where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'embedTable (\ x__ y__ -> x__ {_Column'embedTable = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Column "maybe'embedTable" (Prelude.Maybe Identifier) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'embedTable (\ x__ y__ -> x__ {_Column'embedTable = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Column "originalName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'originalName
           (\ x__ y__ -> x__ {_Column'originalName = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Column "unsigned" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'unsigned (\ x__ y__ -> x__ {_Column'unsigned = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Column "arrayDims" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Column'arrayDims (\ x__ y__ -> x__ {_Column'arrayDims = y__}))
        Prelude.id
instance Data.ProtoLens.Message Column where
  messageName _ = Data.Text.pack "plugin.Column"
  packedMessageDescriptor _
    = "\n\
      \\ACKColumn\DC2\DC2\n\
      \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2\EM\n\
      \\bnot_null\CAN\ETX \SOH(\bR\anotNull\DC2\EM\n\
      \\bis_array\CAN\EOT \SOH(\bR\aisArray\DC2\CAN\n\
      \\acomment\CAN\ENQ \SOH(\tR\acomment\DC2\SYN\n\
      \\ACKlength\CAN\ACK \SOH(\ENQR\ACKlength\DC2$\n\
      \\SOis_named_param\CAN\a \SOH(\bR\fisNamedParam\DC2 \n\
      \\fis_func_call\CAN\b \SOH(\bR\n\
      \isFuncCall\DC2\DC4\n\
      \\ENQscope\CAN\t \SOH(\tR\ENQscope\DC2(\n\
      \\ENQtable\CAN\n\
      \ \SOH(\v2\DC2.plugin.IdentifierR\ENQtable\DC2\US\n\
      \\vtable_alias\CAN\v \SOH(\tR\n\
      \tableAlias\DC2&\n\
      \\EOTtype\CAN\f \SOH(\v2\DC2.plugin.IdentifierR\EOTtype\DC2\"\n\
      \\ris_sqlc_slice\CAN\r \SOH(\bR\visSqlcSlice\DC23\n\
      \\vembed_table\CAN\SO \SOH(\v2\DC2.plugin.IdentifierR\n\
      \embedTable\DC2#\n\
      \\roriginal_name\CAN\SI \SOH(\tR\foriginalName\DC2\SUB\n\
      \\bunsigned\CAN\DLE \SOH(\bR\bunsigned\DC2\GS\n\
      \\n\
      \array_dims\CAN\DC1 \SOH(\ENQR\tarrayDims"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        name__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"name")) ::
              Data.ProtoLens.FieldDescriptor Column
        notNull__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "not_null"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"notNull")) ::
              Data.ProtoLens.FieldDescriptor Column
        isArray__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "is_array"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"isArray")) ::
              Data.ProtoLens.FieldDescriptor Column
        comment__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "comment"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"comment")) ::
              Data.ProtoLens.FieldDescriptor Column
        length__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "length"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"length")) ::
              Data.ProtoLens.FieldDescriptor Column
        isNamedParam__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "is_named_param"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"isNamedParam")) ::
              Data.ProtoLens.FieldDescriptor Column
        isFuncCall__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "is_func_call"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"isFuncCall")) ::
              Data.ProtoLens.FieldDescriptor Column
        scope__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "scope"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"scope")) ::
              Data.ProtoLens.FieldDescriptor Column
        table__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "table"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Identifier)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'table")) ::
              Data.ProtoLens.FieldDescriptor Column
        tableAlias__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "table_alias"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"tableAlias")) ::
              Data.ProtoLens.FieldDescriptor Column
        type'__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "type"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Identifier)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'type'")) ::
              Data.ProtoLens.FieldDescriptor Column
        isSqlcSlice__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "is_sqlc_slice"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"isSqlcSlice")) ::
              Data.ProtoLens.FieldDescriptor Column
        embedTable__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "embed_table"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Identifier)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'embedTable")) ::
              Data.ProtoLens.FieldDescriptor Column
        originalName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "original_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"originalName")) ::
              Data.ProtoLens.FieldDescriptor Column
        unsigned__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "unsigned"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"unsigned")) ::
              Data.ProtoLens.FieldDescriptor Column
        arrayDims__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "array_dims"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"arrayDims")) ::
              Data.ProtoLens.FieldDescriptor Column
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, name__field_descriptor),
           (Data.ProtoLens.Tag 3, notNull__field_descriptor),
           (Data.ProtoLens.Tag 4, isArray__field_descriptor),
           (Data.ProtoLens.Tag 5, comment__field_descriptor),
           (Data.ProtoLens.Tag 6, length__field_descriptor),
           (Data.ProtoLens.Tag 7, isNamedParam__field_descriptor),
           (Data.ProtoLens.Tag 8, isFuncCall__field_descriptor),
           (Data.ProtoLens.Tag 9, scope__field_descriptor),
           (Data.ProtoLens.Tag 10, table__field_descriptor),
           (Data.ProtoLens.Tag 11, tableAlias__field_descriptor),
           (Data.ProtoLens.Tag 12, type'__field_descriptor),
           (Data.ProtoLens.Tag 13, isSqlcSlice__field_descriptor),
           (Data.ProtoLens.Tag 14, embedTable__field_descriptor),
           (Data.ProtoLens.Tag 15, originalName__field_descriptor),
           (Data.ProtoLens.Tag 16, unsigned__field_descriptor),
           (Data.ProtoLens.Tag 17, arrayDims__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Column'_unknownFields
        (\ x__ y__ -> x__ {_Column'_unknownFields = y__})
  defMessage
    = Column'_constructor
        {_Column'name = Data.ProtoLens.fieldDefault,
         _Column'notNull = Data.ProtoLens.fieldDefault,
         _Column'isArray = Data.ProtoLens.fieldDefault,
         _Column'comment = Data.ProtoLens.fieldDefault,
         _Column'length = Data.ProtoLens.fieldDefault,
         _Column'isNamedParam = Data.ProtoLens.fieldDefault,
         _Column'isFuncCall = Data.ProtoLens.fieldDefault,
         _Column'scope = Data.ProtoLens.fieldDefault,
         _Column'table = Prelude.Nothing,
         _Column'tableAlias = Data.ProtoLens.fieldDefault,
         _Column'type' = Prelude.Nothing,
         _Column'isSqlcSlice = Data.ProtoLens.fieldDefault,
         _Column'embedTable = Prelude.Nothing,
         _Column'originalName = Data.ProtoLens.fieldDefault,
         _Column'unsigned = Data.ProtoLens.fieldDefault,
         _Column'arrayDims = Data.ProtoLens.fieldDefault,
         _Column'_unknownFields = []}
  parseMessage
    = let
        loop :: Column -> Data.ProtoLens.Encoding.Bytes.Parser Column
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "name"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"name") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "not_null"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"notNull") y x)
                        32
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "is_array"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"isArray") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "comment"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"comment") y x)
                        48
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "length"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"length") y x)
                        56
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "is_named_param"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"isNamedParam") y x)
                        64
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "is_func_call"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"isFuncCall") y x)
                        74
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "scope"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"scope") y x)
                        82
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "table"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"table") y x)
                        90
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "table_alias"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"tableAlias") y x)
                        98
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "type"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"type'") y x)
                        104
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "is_sqlc_slice"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"isSqlcSlice") y x)
                        114
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "embed_table"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"embedTable") y x)
                        122
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "original_name"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"originalName") y x)
                        128
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "unsigned"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"unsigned") y x)
                        136
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "array_dims"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"arrayDims") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Column"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"name") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"notNull") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                         ((Prelude..)
                            Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                            _v))
                ((Data.Monoid.<>)
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"isArray") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 32)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                               _v))
                   ((Data.Monoid.<>)
                      (let
                         _v = Lens.Family2.view (Data.ProtoLens.Field.field @"comment") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                               ((Prelude..)
                                  (\ bs
                                     -> (Data.Monoid.<>)
                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                             (Prelude.fromIntegral (Data.ByteString.length bs)))
                                          (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                  Data.Text.Encoding.encodeUtf8 _v))
                      ((Data.Monoid.<>)
                         (let
                            _v = Lens.Family2.view (Data.ProtoLens.Field.field @"length") _x
                          in
                            if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                Data.Monoid.mempty
                            else
                                (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 48)
                                  ((Prelude..)
                                     Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral
                                     _v))
                         ((Data.Monoid.<>)
                            (let
                               _v
                                 = Lens.Family2.view (Data.ProtoLens.Field.field @"isNamedParam") _x
                             in
                               if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                   Data.Monoid.mempty
                               else
                                   (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 56)
                                     ((Prelude..)
                                        Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (\ b -> if b then 1 else 0) _v))
                            ((Data.Monoid.<>)
                               (let
                                  _v
                                    = Lens.Family2.view
                                        (Data.ProtoLens.Field.field @"isFuncCall") _x
                                in
                                  if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                      Data.Monoid.mempty
                                  else
                                      (Data.Monoid.<>)
                                        (Data.ProtoLens.Encoding.Bytes.putVarInt 64)
                                        ((Prelude..)
                                           Data.ProtoLens.Encoding.Bytes.putVarInt
                                           (\ b -> if b then 1 else 0) _v))
                               ((Data.Monoid.<>)
                                  (let
                                     _v = Lens.Family2.view (Data.ProtoLens.Field.field @"scope") _x
                                   in
                                     if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                         Data.Monoid.mempty
                                     else
                                         (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt 74)
                                           ((Prelude..)
                                              (\ bs
                                                 -> (Data.Monoid.<>)
                                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                         (Prelude.fromIntegral
                                                            (Data.ByteString.length bs)))
                                                      (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                              Data.Text.Encoding.encodeUtf8 _v))
                                  ((Data.Monoid.<>)
                                     (case
                                          Lens.Family2.view
                                            (Data.ProtoLens.Field.field @"maybe'table") _x
                                      of
                                        Prelude.Nothing -> Data.Monoid.mempty
                                        (Prelude.Just _v)
                                          -> (Data.Monoid.<>)
                                               (Data.ProtoLens.Encoding.Bytes.putVarInt 82)
                                               ((Prelude..)
                                                  (\ bs
                                                     -> (Data.Monoid.<>)
                                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                             (Prelude.fromIntegral
                                                                (Data.ByteString.length bs)))
                                                          (Data.ProtoLens.Encoding.Bytes.putBytes
                                                             bs))
                                                  Data.ProtoLens.encodeMessage _v))
                                     ((Data.Monoid.<>)
                                        (let
                                           _v
                                             = Lens.Family2.view
                                                 (Data.ProtoLens.Field.field @"tableAlias") _x
                                         in
                                           if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                               Data.Monoid.mempty
                                           else
                                               (Data.Monoid.<>)
                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt 90)
                                                 ((Prelude..)
                                                    (\ bs
                                                       -> (Data.Monoid.<>)
                                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                               (Prelude.fromIntegral
                                                                  (Data.ByteString.length bs)))
                                                            (Data.ProtoLens.Encoding.Bytes.putBytes
                                                               bs))
                                                    Data.Text.Encoding.encodeUtf8 _v))
                                        ((Data.Monoid.<>)
                                           (case
                                                Lens.Family2.view
                                                  (Data.ProtoLens.Field.field @"maybe'type'") _x
                                            of
                                              Prelude.Nothing -> Data.Monoid.mempty
                                              (Prelude.Just _v)
                                                -> (Data.Monoid.<>)
                                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 98)
                                                     ((Prelude..)
                                                        (\ bs
                                                           -> (Data.Monoid.<>)
                                                                (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                   (Prelude.fromIntegral
                                                                      (Data.ByteString.length bs)))
                                                                (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                   bs))
                                                        Data.ProtoLens.encodeMessage _v))
                                           ((Data.Monoid.<>)
                                              (let
                                                 _v
                                                   = Lens.Family2.view
                                                       (Data.ProtoLens.Field.field @"isSqlcSlice")
                                                       _x
                                               in
                                                 if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                                     Data.Monoid.mempty
                                                 else
                                                     (Data.Monoid.<>)
                                                       (Data.ProtoLens.Encoding.Bytes.putVarInt 104)
                                                       ((Prelude..)
                                                          Data.ProtoLens.Encoding.Bytes.putVarInt
                                                          (\ b -> if b then 1 else 0) _v))
                                              ((Data.Monoid.<>)
                                                 (case
                                                      Lens.Family2.view
                                                        (Data.ProtoLens.Field.field
                                                           @"maybe'embedTable")
                                                        _x
                                                  of
                                                    Prelude.Nothing -> Data.Monoid.mempty
                                                    (Prelude.Just _v)
                                                      -> (Data.Monoid.<>)
                                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                              114)
                                                           ((Prelude..)
                                                              (\ bs
                                                                 -> (Data.Monoid.<>)
                                                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                         (Prelude.fromIntegral
                                                                            (Data.ByteString.length
                                                                               bs)))
                                                                      (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                         bs))
                                                              Data.ProtoLens.encodeMessage _v))
                                                 ((Data.Monoid.<>)
                                                    (let
                                                       _v
                                                         = Lens.Family2.view
                                                             (Data.ProtoLens.Field.field
                                                                @"originalName")
                                                             _x
                                                     in
                                                       if (Prelude.==)
                                                            _v Data.ProtoLens.fieldDefault then
                                                           Data.Monoid.mempty
                                                       else
                                                           (Data.Monoid.<>)
                                                             (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                122)
                                                             ((Prelude..)
                                                                (\ bs
                                                                   -> (Data.Monoid.<>)
                                                                        (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                           (Prelude.fromIntegral
                                                                              (Data.ByteString.length
                                                                                 bs)))
                                                                        (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                           bs))
                                                                Data.Text.Encoding.encodeUtf8 _v))
                                                    ((Data.Monoid.<>)
                                                       (let
                                                          _v
                                                            = Lens.Family2.view
                                                                (Data.ProtoLens.Field.field
                                                                   @"unsigned")
                                                                _x
                                                        in
                                                          if (Prelude.==)
                                                               _v Data.ProtoLens.fieldDefault then
                                                              Data.Monoid.mempty
                                                          else
                                                              (Data.Monoid.<>)
                                                                (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                   128)
                                                                ((Prelude..)
                                                                   Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                   (\ b -> if b then 1 else 0) _v))
                                                       ((Data.Monoid.<>)
                                                          (let
                                                             _v
                                                               = Lens.Family2.view
                                                                   (Data.ProtoLens.Field.field
                                                                      @"arrayDims")
                                                                   _x
                                                           in
                                                             if (Prelude.==)
                                                                  _v
                                                                  Data.ProtoLens.fieldDefault then
                                                                 Data.Monoid.mempty
                                                             else
                                                                 (Data.Monoid.<>)
                                                                   (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                      136)
                                                                   ((Prelude..)
                                                                      Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                      Prelude.fromIntegral _v))
                                                          (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                                             (Lens.Family2.view
                                                                Data.ProtoLens.unknownFields
                                                                _x)))))))))))))))))
instance Control.DeepSeq.NFData Column where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Column'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Column'name x__)
                (Control.DeepSeq.deepseq
                   (_Column'notNull x__)
                   (Control.DeepSeq.deepseq
                      (_Column'isArray x__)
                      (Control.DeepSeq.deepseq
                         (_Column'comment x__)
                         (Control.DeepSeq.deepseq
                            (_Column'length x__)
                            (Control.DeepSeq.deepseq
                               (_Column'isNamedParam x__)
                               (Control.DeepSeq.deepseq
                                  (_Column'isFuncCall x__)
                                  (Control.DeepSeq.deepseq
                                     (_Column'scope x__)
                                     (Control.DeepSeq.deepseq
                                        (_Column'table x__)
                                        (Control.DeepSeq.deepseq
                                           (_Column'tableAlias x__)
                                           (Control.DeepSeq.deepseq
                                              (_Column'type' x__)
                                              (Control.DeepSeq.deepseq
                                                 (_Column'isSqlcSlice x__)
                                                 (Control.DeepSeq.deepseq
                                                    (_Column'embedTable x__)
                                                    (Control.DeepSeq.deepseq
                                                       (_Column'originalName x__)
                                                       (Control.DeepSeq.deepseq
                                                          (_Column'unsigned x__)
                                                          (Control.DeepSeq.deepseq
                                                             (_Column'arrayDims x__)
                                                             ()))))))))))))))))
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.name' @:: Lens' CompositeType Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.comment' @:: Lens' CompositeType Data.Text.Text@ -}
data CompositeType
  = CompositeType'_constructor {_CompositeType'name :: !Data.Text.Text,
                                _CompositeType'comment :: !Data.Text.Text,
                                _CompositeType'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CompositeType where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField CompositeType "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CompositeType'name (\ x__ y__ -> x__ {_CompositeType'name = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField CompositeType "comment" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CompositeType'comment
           (\ x__ y__ -> x__ {_CompositeType'comment = y__}))
        Prelude.id
instance Data.ProtoLens.Message CompositeType where
  messageName _ = Data.Text.pack "plugin.CompositeType"
  packedMessageDescriptor _
    = "\n\
      \\rCompositeType\DC2\DC2\n\
      \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2\CAN\n\
      \\acomment\CAN\STX \SOH(\tR\acomment"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        name__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"name")) ::
              Data.ProtoLens.FieldDescriptor CompositeType
        comment__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "comment"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"comment")) ::
              Data.ProtoLens.FieldDescriptor CompositeType
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, name__field_descriptor),
           (Data.ProtoLens.Tag 2, comment__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CompositeType'_unknownFields
        (\ x__ y__ -> x__ {_CompositeType'_unknownFields = y__})
  defMessage
    = CompositeType'_constructor
        {_CompositeType'name = Data.ProtoLens.fieldDefault,
         _CompositeType'comment = Data.ProtoLens.fieldDefault,
         _CompositeType'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CompositeType -> Data.ProtoLens.Encoding.Bytes.Parser CompositeType
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "name"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"name") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "comment"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"comment") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "CompositeType"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"name") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"comment") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData CompositeType where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CompositeType'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_CompositeType'name x__)
                (Control.DeepSeq.deepseq (_CompositeType'comment x__) ()))
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.name' @:: Lens' Enum Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.vals' @:: Lens' Enum [Data.Text.Text]@
         * 'Proto.Protos.Codegen_Fields.vec'vals' @:: Lens' Enum (Data.Vector.Vector Data.Text.Text)@
         * 'Proto.Protos.Codegen_Fields.comment' @:: Lens' Enum Data.Text.Text@ -}
data Enum
  = Enum'_constructor {_Enum'name :: !Data.Text.Text,
                       _Enum'vals :: !(Data.Vector.Vector Data.Text.Text),
                       _Enum'comment :: !Data.Text.Text,
                       _Enum'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Enum where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Enum "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Enum'name (\ x__ y__ -> x__ {_Enum'name = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Enum "vals" [Data.Text.Text] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Enum'vals (\ x__ y__ -> x__ {_Enum'vals = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Enum "vec'vals" (Data.Vector.Vector Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Enum'vals (\ x__ y__ -> x__ {_Enum'vals = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Enum "comment" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Enum'comment (\ x__ y__ -> x__ {_Enum'comment = y__}))
        Prelude.id
instance Data.ProtoLens.Message Enum where
  messageName _ = Data.Text.pack "plugin.Enum"
  packedMessageDescriptor _
    = "\n\
      \\EOTEnum\DC2\DC2\n\
      \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2\DC2\n\
      \\EOTvals\CAN\STX \ETX(\tR\EOTvals\DC2\CAN\n\
      \\acomment\CAN\ETX \SOH(\tR\acomment"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        name__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"name")) ::
              Data.ProtoLens.FieldDescriptor Enum
        vals__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "vals"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"vals")) ::
              Data.ProtoLens.FieldDescriptor Enum
        comment__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "comment"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"comment")) ::
              Data.ProtoLens.FieldDescriptor Enum
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, name__field_descriptor),
           (Data.ProtoLens.Tag 2, vals__field_descriptor),
           (Data.ProtoLens.Tag 3, comment__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Enum'_unknownFields
        (\ x__ y__ -> x__ {_Enum'_unknownFields = y__})
  defMessage
    = Enum'_constructor
        {_Enum'name = Data.ProtoLens.fieldDefault,
         _Enum'vals = Data.Vector.Generic.empty,
         _Enum'comment = Data.ProtoLens.fieldDefault,
         _Enum'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Enum
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Data.Text.Text
             -> Data.ProtoLens.Encoding.Bytes.Parser Enum
        loop x mutable'vals
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'vals <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.unsafeFreeze mutable'vals)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'vals") frozen'vals x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "name"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"name") y x)
                                  mutable'vals
                        18
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.getText
                                              (Prelude.fromIntegral len))
                                        "vals"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'vals y)
                                loop x v
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "comment"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"comment") y x)
                                  mutable'vals
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'vals
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'vals <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'vals)
          "Enum"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"name") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                   (\ _v
                      -> (Data.Monoid.<>)
                           (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                           ((Prelude..)
                              (\ bs
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                         (Prelude.fromIntegral (Data.ByteString.length bs)))
                                      (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                              Data.Text.Encoding.encodeUtf8 _v))
                   (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'vals") _x))
                ((Data.Monoid.<>)
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"comment") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                            ((Prelude..)
                               (\ bs
                                  -> (Data.Monoid.<>)
                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                          (Prelude.fromIntegral (Data.ByteString.length bs)))
                                       (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                               Data.Text.Encoding.encodeUtf8 _v))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData Enum where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Enum'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Enum'name x__)
                (Control.DeepSeq.deepseq
                   (_Enum'vals x__) (Control.DeepSeq.deepseq (_Enum'comment x__) ())))
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.name' @:: Lens' File Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.contents' @:: Lens' File Data.ByteString.ByteString@ -}
data File
  = File'_constructor {_File'name :: !Data.Text.Text,
                       _File'contents :: !Data.ByteString.ByteString,
                       _File'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show File where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField File "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _File'name (\ x__ y__ -> x__ {_File'name = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField File "contents" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _File'contents (\ x__ y__ -> x__ {_File'contents = y__}))
        Prelude.id
instance Data.ProtoLens.Message File where
  messageName _ = Data.Text.pack "plugin.File"
  packedMessageDescriptor _
    = "\n\
      \\EOTFile\DC2\DC2\n\
      \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2\SUB\n\
      \\bcontents\CAN\STX \SOH(\fR\bcontents"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        name__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"name")) ::
              Data.ProtoLens.FieldDescriptor File
        contents__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "contents"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"contents")) ::
              Data.ProtoLens.FieldDescriptor File
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, name__field_descriptor),
           (Data.ProtoLens.Tag 2, contents__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _File'_unknownFields
        (\ x__ y__ -> x__ {_File'_unknownFields = y__})
  defMessage
    = File'_constructor
        {_File'name = Data.ProtoLens.fieldDefault,
         _File'contents = Data.ProtoLens.fieldDefault,
         _File'_unknownFields = []}
  parseMessage
    = let
        loop :: File -> Data.ProtoLens.Encoding.Bytes.Parser File
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "name"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"name") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getBytes
                                             (Prelude.fromIntegral len))
                                       "contents"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"contents") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "File"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"name") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"contents") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData File where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_File'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_File'name x__) (Control.DeepSeq.deepseq (_File'contents x__) ()))
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.settings' @:: Lens' GenerateRequest Settings@
         * 'Proto.Protos.Codegen_Fields.maybe'settings' @:: Lens' GenerateRequest (Prelude.Maybe Settings)@
         * 'Proto.Protos.Codegen_Fields.catalog' @:: Lens' GenerateRequest Catalog@
         * 'Proto.Protos.Codegen_Fields.maybe'catalog' @:: Lens' GenerateRequest (Prelude.Maybe Catalog)@
         * 'Proto.Protos.Codegen_Fields.queries' @:: Lens' GenerateRequest [Query]@
         * 'Proto.Protos.Codegen_Fields.vec'queries' @:: Lens' GenerateRequest (Data.Vector.Vector Query)@
         * 'Proto.Protos.Codegen_Fields.sqlcVersion' @:: Lens' GenerateRequest Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.pluginOptions' @:: Lens' GenerateRequest Data.ByteString.ByteString@
         * 'Proto.Protos.Codegen_Fields.globalOptions' @:: Lens' GenerateRequest Data.ByteString.ByteString@ -}
data GenerateRequest
  = GenerateRequest'_constructor {_GenerateRequest'settings :: !(Prelude.Maybe Settings),
                                  _GenerateRequest'catalog :: !(Prelude.Maybe Catalog),
                                  _GenerateRequest'queries :: !(Data.Vector.Vector Query),
                                  _GenerateRequest'sqlcVersion :: !Data.Text.Text,
                                  _GenerateRequest'pluginOptions :: !Data.ByteString.ByteString,
                                  _GenerateRequest'globalOptions :: !Data.ByteString.ByteString,
                                  _GenerateRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show GenerateRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField GenerateRequest "settings" Settings where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GenerateRequest'settings
           (\ x__ y__ -> x__ {_GenerateRequest'settings = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField GenerateRequest "maybe'settings" (Prelude.Maybe Settings) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GenerateRequest'settings
           (\ x__ y__ -> x__ {_GenerateRequest'settings = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField GenerateRequest "catalog" Catalog where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GenerateRequest'catalog
           (\ x__ y__ -> x__ {_GenerateRequest'catalog = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField GenerateRequest "maybe'catalog" (Prelude.Maybe Catalog) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GenerateRequest'catalog
           (\ x__ y__ -> x__ {_GenerateRequest'catalog = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField GenerateRequest "queries" [Query] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GenerateRequest'queries
           (\ x__ y__ -> x__ {_GenerateRequest'queries = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField GenerateRequest "vec'queries" (Data.Vector.Vector Query) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GenerateRequest'queries
           (\ x__ y__ -> x__ {_GenerateRequest'queries = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField GenerateRequest "sqlcVersion" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GenerateRequest'sqlcVersion
           (\ x__ y__ -> x__ {_GenerateRequest'sqlcVersion = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField GenerateRequest "pluginOptions" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GenerateRequest'pluginOptions
           (\ x__ y__ -> x__ {_GenerateRequest'pluginOptions = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField GenerateRequest "globalOptions" Data.ByteString.ByteString where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GenerateRequest'globalOptions
           (\ x__ y__ -> x__ {_GenerateRequest'globalOptions = y__}))
        Prelude.id
instance Data.ProtoLens.Message GenerateRequest where
  messageName _ = Data.Text.pack "plugin.GenerateRequest"
  packedMessageDescriptor _
    = "\n\
      \\SIGenerateRequest\DC2,\n\
      \\bsettings\CAN\SOH \SOH(\v2\DLE.plugin.SettingsR\bsettings\DC2)\n\
      \\acatalog\CAN\STX \SOH(\v2\SI.plugin.CatalogR\acatalog\DC2'\n\
      \\aqueries\CAN\ETX \ETX(\v2\r.plugin.QueryR\aqueries\DC2\"\n\
      \\fsqlc_version\CAN\EOT \SOH(\tR\fsqlc_version\DC2&\n\
      \\SOplugin_options\CAN\ENQ \SOH(\fR\SOplugin_options\DC2&\n\
      \\SOglobal_options\CAN\ACK \SOH(\fR\SOglobal_options"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        settings__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "settings"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Settings)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'settings")) ::
              Data.ProtoLens.FieldDescriptor GenerateRequest
        catalog__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "catalog"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Catalog)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'catalog")) ::
              Data.ProtoLens.FieldDescriptor GenerateRequest
        queries__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "queries"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Query)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"queries")) ::
              Data.ProtoLens.FieldDescriptor GenerateRequest
        sqlcVersion__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "sqlc_version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"sqlcVersion")) ::
              Data.ProtoLens.FieldDescriptor GenerateRequest
        pluginOptions__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "plugin_options"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"pluginOptions")) ::
              Data.ProtoLens.FieldDescriptor GenerateRequest
        globalOptions__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "global_options"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"globalOptions")) ::
              Data.ProtoLens.FieldDescriptor GenerateRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, settings__field_descriptor),
           (Data.ProtoLens.Tag 2, catalog__field_descriptor),
           (Data.ProtoLens.Tag 3, queries__field_descriptor),
           (Data.ProtoLens.Tag 4, sqlcVersion__field_descriptor),
           (Data.ProtoLens.Tag 5, pluginOptions__field_descriptor),
           (Data.ProtoLens.Tag 6, globalOptions__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _GenerateRequest'_unknownFields
        (\ x__ y__ -> x__ {_GenerateRequest'_unknownFields = y__})
  defMessage
    = GenerateRequest'_constructor
        {_GenerateRequest'settings = Prelude.Nothing,
         _GenerateRequest'catalog = Prelude.Nothing,
         _GenerateRequest'queries = Data.Vector.Generic.empty,
         _GenerateRequest'sqlcVersion = Data.ProtoLens.fieldDefault,
         _GenerateRequest'pluginOptions = Data.ProtoLens.fieldDefault,
         _GenerateRequest'globalOptions = Data.ProtoLens.fieldDefault,
         _GenerateRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          GenerateRequest
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Query
             -> Data.ProtoLens.Encoding.Bytes.Parser GenerateRequest
        loop x mutable'queries
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'queries <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                          (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                             mutable'queries)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'queries") frozen'queries x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "settings"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"settings") y x)
                                  mutable'queries
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "catalog"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"catalog") y x)
                                  mutable'queries
                        26
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "queries"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'queries y)
                                loop x v
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "sqlc_version"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"sqlcVersion") y x)
                                  mutable'queries
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getBytes
                                             (Prelude.fromIntegral len))
                                       "plugin_options"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"pluginOptions") y x)
                                  mutable'queries
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getBytes
                                             (Prelude.fromIntegral len))
                                       "global_options"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"globalOptions") y x)
                                  mutable'queries
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'queries
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'queries <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                   Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'queries)
          "GenerateRequest"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'settings") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just _v)
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'catalog") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just _v)
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage _v))
                ((Data.Monoid.<>)
                   (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                      (\ _v
                         -> (Data.Monoid.<>)
                              (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                              ((Prelude..)
                                 (\ bs
                                    -> (Data.Monoid.<>)
                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                            (Prelude.fromIntegral (Data.ByteString.length bs)))
                                         (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                 Data.ProtoLens.encodeMessage _v))
                      (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'queries") _x))
                   ((Data.Monoid.<>)
                      (let
                         _v
                           = Lens.Family2.view (Data.ProtoLens.Field.field @"sqlcVersion") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                               ((Prelude..)
                                  (\ bs
                                     -> (Data.Monoid.<>)
                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                             (Prelude.fromIntegral (Data.ByteString.length bs)))
                                          (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                  Data.Text.Encoding.encodeUtf8 _v))
                      ((Data.Monoid.<>)
                         (let
                            _v
                              = Lens.Family2.view
                                  (Data.ProtoLens.Field.field @"pluginOptions") _x
                          in
                            if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                Data.Monoid.mempty
                            else
                                (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                  ((\ bs
                                      -> (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                              (Prelude.fromIntegral (Data.ByteString.length bs)))
                                           (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                     _v))
                         ((Data.Monoid.<>)
                            (let
                               _v
                                 = Lens.Family2.view
                                     (Data.ProtoLens.Field.field @"globalOptions") _x
                             in
                               if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                   Data.Monoid.mempty
                               else
                                   (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                     ((\ bs
                                         -> (Data.Monoid.<>)
                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                 (Prelude.fromIntegral (Data.ByteString.length bs)))
                                              (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                        _v))
                            (Data.ProtoLens.Encoding.Wire.buildFieldSet
                               (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))))
instance Control.DeepSeq.NFData GenerateRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_GenerateRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_GenerateRequest'settings x__)
                (Control.DeepSeq.deepseq
                   (_GenerateRequest'catalog x__)
                   (Control.DeepSeq.deepseq
                      (_GenerateRequest'queries x__)
                      (Control.DeepSeq.deepseq
                         (_GenerateRequest'sqlcVersion x__)
                         (Control.DeepSeq.deepseq
                            (_GenerateRequest'pluginOptions x__)
                            (Control.DeepSeq.deepseq
                               (_GenerateRequest'globalOptions x__) ()))))))
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.files' @:: Lens' GenerateResponse [File]@
         * 'Proto.Protos.Codegen_Fields.vec'files' @:: Lens' GenerateResponse (Data.Vector.Vector File)@ -}
data GenerateResponse
  = GenerateResponse'_constructor {_GenerateResponse'files :: !(Data.Vector.Vector File),
                                   _GenerateResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show GenerateResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField GenerateResponse "files" [File] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GenerateResponse'files
           (\ x__ y__ -> x__ {_GenerateResponse'files = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField GenerateResponse "vec'files" (Data.Vector.Vector File) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GenerateResponse'files
           (\ x__ y__ -> x__ {_GenerateResponse'files = y__}))
        Prelude.id
instance Data.ProtoLens.Message GenerateResponse where
  messageName _ = Data.Text.pack "plugin.GenerateResponse"
  packedMessageDescriptor _
    = "\n\
      \\DLEGenerateResponse\DC2\"\n\
      \\ENQfiles\CAN\SOH \ETX(\v2\f.plugin.FileR\ENQfiles"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        files__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "files"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor File)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"files")) ::
              Data.ProtoLens.FieldDescriptor GenerateResponse
      in
        Data.Map.fromList [(Data.ProtoLens.Tag 1, files__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _GenerateResponse'_unknownFields
        (\ x__ y__ -> x__ {_GenerateResponse'_unknownFields = y__})
  defMessage
    = GenerateResponse'_constructor
        {_GenerateResponse'files = Data.Vector.Generic.empty,
         _GenerateResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          GenerateResponse
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld File
             -> Data.ProtoLens.Encoding.Bytes.Parser GenerateResponse
        loop x mutable'files
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'files <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                        (Data.ProtoLens.Encoding.Growing.unsafeFreeze mutable'files)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'files") frozen'files x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "files"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'files y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'files
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'files <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                 Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'files)
          "GenerateResponse"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                (\ _v
                   -> (Data.Monoid.<>)
                        (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                        ((Prelude..)
                           (\ bs
                              -> (Data.Monoid.<>)
                                   (Data.ProtoLens.Encoding.Bytes.putVarInt
                                      (Prelude.fromIntegral (Data.ByteString.length bs)))
                                   (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                           Data.ProtoLens.encodeMessage _v))
                (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'files") _x))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData GenerateResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_GenerateResponse'_unknownFields x__)
             (Control.DeepSeq.deepseq (_GenerateResponse'files x__) ())
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.catalog' @:: Lens' Identifier Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.schema' @:: Lens' Identifier Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.name' @:: Lens' Identifier Data.Text.Text@ -}
data Identifier
  = Identifier'_constructor {_Identifier'catalog :: !Data.Text.Text,
                             _Identifier'schema :: !Data.Text.Text,
                             _Identifier'name :: !Data.Text.Text,
                             _Identifier'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Identifier where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Identifier "catalog" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Identifier'catalog (\ x__ y__ -> x__ {_Identifier'catalog = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Identifier "schema" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Identifier'schema (\ x__ y__ -> x__ {_Identifier'schema = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Identifier "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Identifier'name (\ x__ y__ -> x__ {_Identifier'name = y__}))
        Prelude.id
instance Data.ProtoLens.Message Identifier where
  messageName _ = Data.Text.pack "plugin.Identifier"
  packedMessageDescriptor _
    = "\n\
      \\n\
      \Identifier\DC2\CAN\n\
      \\acatalog\CAN\SOH \SOH(\tR\acatalog\DC2\SYN\n\
      \\ACKschema\CAN\STX \SOH(\tR\ACKschema\DC2\DC2\n\
      \\EOTname\CAN\ETX \SOH(\tR\EOTname"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        catalog__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "catalog"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"catalog")) ::
              Data.ProtoLens.FieldDescriptor Identifier
        schema__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "schema"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"schema")) ::
              Data.ProtoLens.FieldDescriptor Identifier
        name__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"name")) ::
              Data.ProtoLens.FieldDescriptor Identifier
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, catalog__field_descriptor),
           (Data.ProtoLens.Tag 2, schema__field_descriptor),
           (Data.ProtoLens.Tag 3, name__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Identifier'_unknownFields
        (\ x__ y__ -> x__ {_Identifier'_unknownFields = y__})
  defMessage
    = Identifier'_constructor
        {_Identifier'catalog = Data.ProtoLens.fieldDefault,
         _Identifier'schema = Data.ProtoLens.fieldDefault,
         _Identifier'name = Data.ProtoLens.fieldDefault,
         _Identifier'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Identifier -> Data.ProtoLens.Encoding.Bytes.Parser Identifier
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "catalog"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"catalog") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "schema"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"schema") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "name"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"name") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Identifier"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"catalog") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"schema") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                ((Data.Monoid.<>)
                   (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"name") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                            ((Prelude..)
                               (\ bs
                                  -> (Data.Monoid.<>)
                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                          (Prelude.fromIntegral (Data.ByteString.length bs)))
                                       (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                               Data.Text.Encoding.encodeUtf8 _v))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData Identifier where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Identifier'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Identifier'catalog x__)
                (Control.DeepSeq.deepseq
                   (_Identifier'schema x__)
                   (Control.DeepSeq.deepseq (_Identifier'name x__) ())))
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.number' @:: Lens' Parameter Data.Int.Int32@
         * 'Proto.Protos.Codegen_Fields.column' @:: Lens' Parameter Column@
         * 'Proto.Protos.Codegen_Fields.maybe'column' @:: Lens' Parameter (Prelude.Maybe Column)@ -}
data Parameter
  = Parameter'_constructor {_Parameter'number :: !Data.Int.Int32,
                            _Parameter'column :: !(Prelude.Maybe Column),
                            _Parameter'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Parameter where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Parameter "number" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Parameter'number (\ x__ y__ -> x__ {_Parameter'number = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Parameter "column" Column where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Parameter'column (\ x__ y__ -> x__ {_Parameter'column = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Parameter "maybe'column" (Prelude.Maybe Column) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Parameter'column (\ x__ y__ -> x__ {_Parameter'column = y__}))
        Prelude.id
instance Data.ProtoLens.Message Parameter where
  messageName _ = Data.Text.pack "plugin.Parameter"
  packedMessageDescriptor _
    = "\n\
      \\tParameter\DC2\SYN\n\
      \\ACKnumber\CAN\SOH \SOH(\ENQR\ACKnumber\DC2&\n\
      \\ACKcolumn\CAN\STX \SOH(\v2\SO.plugin.ColumnR\ACKcolumn"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        number__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "number"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"number")) ::
              Data.ProtoLens.FieldDescriptor Parameter
        column__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "column"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Column)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'column")) ::
              Data.ProtoLens.FieldDescriptor Parameter
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, number__field_descriptor),
           (Data.ProtoLens.Tag 2, column__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Parameter'_unknownFields
        (\ x__ y__ -> x__ {_Parameter'_unknownFields = y__})
  defMessage
    = Parameter'_constructor
        {_Parameter'number = Data.ProtoLens.fieldDefault,
         _Parameter'column = Prelude.Nothing,
         _Parameter'_unknownFields = []}
  parseMessage
    = let
        loop :: Parameter -> Data.ProtoLens.Encoding.Bytes.Parser Parameter
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        8 -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "number"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"number") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "column"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"column") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Parameter"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"number") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'column") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just _v)
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData Parameter where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Parameter'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Parameter'number x__)
                (Control.DeepSeq.deepseq (_Parameter'column x__) ()))
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.text' @:: Lens' Query Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.name' @:: Lens' Query Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.cmd' @:: Lens' Query Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.columns' @:: Lens' Query [Column]@
         * 'Proto.Protos.Codegen_Fields.vec'columns' @:: Lens' Query (Data.Vector.Vector Column)@
         * 'Proto.Protos.Codegen_Fields.params' @:: Lens' Query [Parameter]@
         * 'Proto.Protos.Codegen_Fields.vec'params' @:: Lens' Query (Data.Vector.Vector Parameter)@
         * 'Proto.Protos.Codegen_Fields.comments' @:: Lens' Query [Data.Text.Text]@
         * 'Proto.Protos.Codegen_Fields.vec'comments' @:: Lens' Query (Data.Vector.Vector Data.Text.Text)@
         * 'Proto.Protos.Codegen_Fields.filename' @:: Lens' Query Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.insertIntoTable' @:: Lens' Query Identifier@
         * 'Proto.Protos.Codegen_Fields.maybe'insertIntoTable' @:: Lens' Query (Prelude.Maybe Identifier)@ -}
data Query
  = Query'_constructor {_Query'text :: !Data.Text.Text,
                        _Query'name :: !Data.Text.Text,
                        _Query'cmd :: !Data.Text.Text,
                        _Query'columns :: !(Data.Vector.Vector Column),
                        _Query'params :: !(Data.Vector.Vector Parameter),
                        _Query'comments :: !(Data.Vector.Vector Data.Text.Text),
                        _Query'filename :: !Data.Text.Text,
                        _Query'insertIntoTable :: !(Prelude.Maybe Identifier),
                        _Query'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Query where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Query "text" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Query'text (\ x__ y__ -> x__ {_Query'text = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Query "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Query'name (\ x__ y__ -> x__ {_Query'name = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Query "cmd" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Query'cmd (\ x__ y__ -> x__ {_Query'cmd = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Query "columns" [Column] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Query'columns (\ x__ y__ -> x__ {_Query'columns = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Query "vec'columns" (Data.Vector.Vector Column) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Query'columns (\ x__ y__ -> x__ {_Query'columns = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Query "params" [Parameter] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Query'params (\ x__ y__ -> x__ {_Query'params = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Query "vec'params" (Data.Vector.Vector Parameter) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Query'params (\ x__ y__ -> x__ {_Query'params = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Query "comments" [Data.Text.Text] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Query'comments (\ x__ y__ -> x__ {_Query'comments = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Query "vec'comments" (Data.Vector.Vector Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Query'comments (\ x__ y__ -> x__ {_Query'comments = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Query "filename" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Query'filename (\ x__ y__ -> x__ {_Query'filename = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Query "insertIntoTable" Identifier where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Query'insertIntoTable
           (\ x__ y__ -> x__ {_Query'insertIntoTable = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Query "maybe'insertIntoTable" (Prelude.Maybe Identifier) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Query'insertIntoTable
           (\ x__ y__ -> x__ {_Query'insertIntoTable = y__}))
        Prelude.id
instance Data.ProtoLens.Message Query where
  messageName _ = Data.Text.pack "plugin.Query"
  packedMessageDescriptor _
    = "\n\
      \\ENQQuery\DC2\DC2\n\
      \\EOTtext\CAN\SOH \SOH(\tR\EOTtext\DC2\DC2\n\
      \\EOTname\CAN\STX \SOH(\tR\EOTname\DC2\DLE\n\
      \\ETXcmd\CAN\ETX \SOH(\tR\ETXcmd\DC2(\n\
      \\acolumns\CAN\EOT \ETX(\v2\SO.plugin.ColumnR\acolumns\DC2-\n\
      \\ACKparams\CAN\ENQ \ETX(\v2\DC1.plugin.ParameterR\n\
      \parameters\DC2\SUB\n\
      \\bcomments\CAN\ACK \ETX(\tR\bcomments\DC2\SUB\n\
      \\bfilename\CAN\a \SOH(\tR\bfilename\DC2@\n\
      \\DC1insert_into_table\CAN\b \SOH(\v2\DC2.plugin.IdentifierR\DC1insert_into_table"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        text__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "text"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"text")) ::
              Data.ProtoLens.FieldDescriptor Query
        name__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"name")) ::
              Data.ProtoLens.FieldDescriptor Query
        cmd__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cmd"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"cmd")) ::
              Data.ProtoLens.FieldDescriptor Query
        columns__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "columns"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Column)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"columns")) ::
              Data.ProtoLens.FieldDescriptor Query
        params__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "params"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Parameter)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"params")) ::
              Data.ProtoLens.FieldDescriptor Query
        comments__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "comments"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"comments")) ::
              Data.ProtoLens.FieldDescriptor Query
        filename__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "filename"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"filename")) ::
              Data.ProtoLens.FieldDescriptor Query
        insertIntoTable__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "insert_into_table"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Identifier)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'insertIntoTable")) ::
              Data.ProtoLens.FieldDescriptor Query
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, text__field_descriptor),
           (Data.ProtoLens.Tag 2, name__field_descriptor),
           (Data.ProtoLens.Tag 3, cmd__field_descriptor),
           (Data.ProtoLens.Tag 4, columns__field_descriptor),
           (Data.ProtoLens.Tag 5, params__field_descriptor),
           (Data.ProtoLens.Tag 6, comments__field_descriptor),
           (Data.ProtoLens.Tag 7, filename__field_descriptor),
           (Data.ProtoLens.Tag 8, insertIntoTable__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Query'_unknownFields
        (\ x__ y__ -> x__ {_Query'_unknownFields = y__})
  defMessage
    = Query'_constructor
        {_Query'text = Data.ProtoLens.fieldDefault,
         _Query'name = Data.ProtoLens.fieldDefault,
         _Query'cmd = Data.ProtoLens.fieldDefault,
         _Query'columns = Data.Vector.Generic.empty,
         _Query'params = Data.Vector.Generic.empty,
         _Query'comments = Data.Vector.Generic.empty,
         _Query'filename = Data.ProtoLens.fieldDefault,
         _Query'insertIntoTable = Prelude.Nothing,
         _Query'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Query
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Column
             -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Data.Text.Text
                -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Parameter
                   -> Data.ProtoLens.Encoding.Bytes.Parser Query
        loop x mutable'columns mutable'comments mutable'params
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'columns <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                          (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                             mutable'columns)
                      frozen'comments <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                           (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                              mutable'comments)
                      frozen'params <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                         (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                            mutable'params)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'columns") frozen'columns
                              (Lens.Family2.set
                                 (Data.ProtoLens.Field.field @"vec'comments") frozen'comments
                                 (Lens.Family2.set
                                    (Data.ProtoLens.Field.field @"vec'params") frozen'params x))))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "text"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"text") y x)
                                  mutable'columns mutable'comments mutable'params
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "name"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"name") y x)
                                  mutable'columns mutable'comments mutable'params
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "cmd"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"cmd") y x)
                                  mutable'columns mutable'comments mutable'params
                        34
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "columns"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'columns y)
                                loop x v mutable'comments mutable'params
                        42
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "params"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'params y)
                                loop x mutable'columns mutable'comments v
                        50
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.getText
                                              (Prelude.fromIntegral len))
                                        "comments"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'comments y)
                                loop x mutable'columns v mutable'params
                        58
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "filename"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"filename") y x)
                                  mutable'columns mutable'comments mutable'params
                        66
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "insert_into_table"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"insertIntoTable") y x)
                                  mutable'columns mutable'comments mutable'params
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'columns mutable'comments mutable'params
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'columns <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                   Data.ProtoLens.Encoding.Growing.new
              mutable'comments <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                    Data.ProtoLens.Encoding.Growing.new
              mutable'params <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                  Data.ProtoLens.Encoding.Growing.new
              loop
                Data.ProtoLens.defMessage mutable'columns mutable'comments
                mutable'params)
          "Query"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"text") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"name") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                ((Data.Monoid.<>)
                   (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"cmd") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                            ((Prelude..)
                               (\ bs
                                  -> (Data.Monoid.<>)
                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                          (Prelude.fromIntegral (Data.ByteString.length bs)))
                                       (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                               Data.Text.Encoding.encodeUtf8 _v))
                   ((Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                         (\ _v
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                                 ((Prelude..)
                                    (\ bs
                                       -> (Data.Monoid.<>)
                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                               (Prelude.fromIntegral (Data.ByteString.length bs)))
                                            (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                    Data.ProtoLens.encodeMessage _v))
                         (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'columns") _x))
                      ((Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                            (\ _v
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                    ((Prelude..)
                                       (\ bs
                                          -> (Data.Monoid.<>)
                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                  (Prelude.fromIntegral
                                                     (Data.ByteString.length bs)))
                                               (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                       Data.ProtoLens.encodeMessage _v))
                            (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'params") _x))
                         ((Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                               (\ _v
                                  -> (Data.Monoid.<>)
                                       (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                       ((Prelude..)
                                          (\ bs
                                             -> (Data.Monoid.<>)
                                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                     (Prelude.fromIntegral
                                                        (Data.ByteString.length bs)))
                                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                          Data.Text.Encoding.encodeUtf8 _v))
                               (Lens.Family2.view
                                  (Data.ProtoLens.Field.field @"vec'comments") _x))
                            ((Data.Monoid.<>)
                               (let
                                  _v = Lens.Family2.view (Data.ProtoLens.Field.field @"filename") _x
                                in
                                  if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                      Data.Monoid.mempty
                                  else
                                      (Data.Monoid.<>)
                                        (Data.ProtoLens.Encoding.Bytes.putVarInt 58)
                                        ((Prelude..)
                                           (\ bs
                                              -> (Data.Monoid.<>)
                                                   (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                      (Prelude.fromIntegral
                                                         (Data.ByteString.length bs)))
                                                   (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                           Data.Text.Encoding.encodeUtf8 _v))
                               ((Data.Monoid.<>)
                                  (case
                                       Lens.Family2.view
                                         (Data.ProtoLens.Field.field @"maybe'insertIntoTable") _x
                                   of
                                     Prelude.Nothing -> Data.Monoid.mempty
                                     (Prelude.Just _v)
                                       -> (Data.Monoid.<>)
                                            (Data.ProtoLens.Encoding.Bytes.putVarInt 66)
                                            ((Prelude..)
                                               (\ bs
                                                  -> (Data.Monoid.<>)
                                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                          (Prelude.fromIntegral
                                                             (Data.ByteString.length bs)))
                                                       (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                               Data.ProtoLens.encodeMessage _v))
                                  (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                     (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))))))
instance Control.DeepSeq.NFData Query where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Query'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Query'text x__)
                (Control.DeepSeq.deepseq
                   (_Query'name x__)
                   (Control.DeepSeq.deepseq
                      (_Query'cmd x__)
                      (Control.DeepSeq.deepseq
                         (_Query'columns x__)
                         (Control.DeepSeq.deepseq
                            (_Query'params x__)
                            (Control.DeepSeq.deepseq
                               (_Query'comments x__)
                               (Control.DeepSeq.deepseq
                                  (_Query'filename x__)
                                  (Control.DeepSeq.deepseq (_Query'insertIntoTable x__) ()))))))))
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.comment' @:: Lens' Schema Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.name' @:: Lens' Schema Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.tables' @:: Lens' Schema [Table]@
         * 'Proto.Protos.Codegen_Fields.vec'tables' @:: Lens' Schema (Data.Vector.Vector Table)@
         * 'Proto.Protos.Codegen_Fields.enums' @:: Lens' Schema [Enum]@
         * 'Proto.Protos.Codegen_Fields.vec'enums' @:: Lens' Schema (Data.Vector.Vector Enum)@
         * 'Proto.Protos.Codegen_Fields.compositeTypes' @:: Lens' Schema [CompositeType]@
         * 'Proto.Protos.Codegen_Fields.vec'compositeTypes' @:: Lens' Schema (Data.Vector.Vector CompositeType)@ -}
data Schema
  = Schema'_constructor {_Schema'comment :: !Data.Text.Text,
                         _Schema'name :: !Data.Text.Text,
                         _Schema'tables :: !(Data.Vector.Vector Table),
                         _Schema'enums :: !(Data.Vector.Vector Enum),
                         _Schema'compositeTypes :: !(Data.Vector.Vector CompositeType),
                         _Schema'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Schema where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Schema "comment" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Schema'comment (\ x__ y__ -> x__ {_Schema'comment = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Schema "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Schema'name (\ x__ y__ -> x__ {_Schema'name = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Schema "tables" [Table] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Schema'tables (\ x__ y__ -> x__ {_Schema'tables = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Schema "vec'tables" (Data.Vector.Vector Table) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Schema'tables (\ x__ y__ -> x__ {_Schema'tables = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Schema "enums" [Enum] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Schema'enums (\ x__ y__ -> x__ {_Schema'enums = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Schema "vec'enums" (Data.Vector.Vector Enum) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Schema'enums (\ x__ y__ -> x__ {_Schema'enums = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Schema "compositeTypes" [CompositeType] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Schema'compositeTypes
           (\ x__ y__ -> x__ {_Schema'compositeTypes = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Schema "vec'compositeTypes" (Data.Vector.Vector CompositeType) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Schema'compositeTypes
           (\ x__ y__ -> x__ {_Schema'compositeTypes = y__}))
        Prelude.id
instance Data.ProtoLens.Message Schema where
  messageName _ = Data.Text.pack "plugin.Schema"
  packedMessageDescriptor _
    = "\n\
      \\ACKSchema\DC2\CAN\n\
      \\acomment\CAN\SOH \SOH(\tR\acomment\DC2\DC2\n\
      \\EOTname\CAN\STX \SOH(\tR\EOTname\DC2%\n\
      \\ACKtables\CAN\ETX \ETX(\v2\r.plugin.TableR\ACKtables\DC2\"\n\
      \\ENQenums\CAN\EOT \ETX(\v2\f.plugin.EnumR\ENQenums\DC2>\n\
      \\SIcomposite_types\CAN\ENQ \ETX(\v2\NAK.plugin.CompositeTypeR\SOcompositeTypes"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        comment__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "comment"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"comment")) ::
              Data.ProtoLens.FieldDescriptor Schema
        name__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"name")) ::
              Data.ProtoLens.FieldDescriptor Schema
        tables__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "tables"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Table)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"tables")) ::
              Data.ProtoLens.FieldDescriptor Schema
        enums__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "enums"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Enum)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"enums")) ::
              Data.ProtoLens.FieldDescriptor Schema
        compositeTypes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "composite_types"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor CompositeType)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"compositeTypes")) ::
              Data.ProtoLens.FieldDescriptor Schema
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, comment__field_descriptor),
           (Data.ProtoLens.Tag 2, name__field_descriptor),
           (Data.ProtoLens.Tag 3, tables__field_descriptor),
           (Data.ProtoLens.Tag 4, enums__field_descriptor),
           (Data.ProtoLens.Tag 5, compositeTypes__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Schema'_unknownFields
        (\ x__ y__ -> x__ {_Schema'_unknownFields = y__})
  defMessage
    = Schema'_constructor
        {_Schema'comment = Data.ProtoLens.fieldDefault,
         _Schema'name = Data.ProtoLens.fieldDefault,
         _Schema'tables = Data.Vector.Generic.empty,
         _Schema'enums = Data.Vector.Generic.empty,
         _Schema'compositeTypes = Data.Vector.Generic.empty,
         _Schema'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Schema
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld CompositeType
             -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Enum
                -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Table
                   -> Data.ProtoLens.Encoding.Bytes.Parser Schema
        loop x mutable'compositeTypes mutable'enums mutable'tables
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'compositeTypes <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                 (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                                    mutable'compositeTypes)
                      frozen'enums <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                        (Data.ProtoLens.Encoding.Growing.unsafeFreeze mutable'enums)
                      frozen'tables <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                         (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                            mutable'tables)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'compositeTypes")
                              frozen'compositeTypes
                              (Lens.Family2.set
                                 (Data.ProtoLens.Field.field @"vec'enums") frozen'enums
                                 (Lens.Family2.set
                                    (Data.ProtoLens.Field.field @"vec'tables") frozen'tables x))))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "comment"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"comment") y x)
                                  mutable'compositeTypes mutable'enums mutable'tables
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "name"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"name") y x)
                                  mutable'compositeTypes mutable'enums mutable'tables
                        26
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "tables"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'tables y)
                                loop x mutable'compositeTypes mutable'enums v
                        34
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "enums"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'enums y)
                                loop x mutable'compositeTypes v mutable'tables
                        42
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "composite_types"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append
                                          mutable'compositeTypes y)
                                loop x v mutable'enums mutable'tables
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'compositeTypes mutable'enums mutable'tables
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'compositeTypes <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                          Data.ProtoLens.Encoding.Growing.new
              mutable'enums <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                 Data.ProtoLens.Encoding.Growing.new
              mutable'tables <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                  Data.ProtoLens.Encoding.Growing.new
              loop
                Data.ProtoLens.defMessage mutable'compositeTypes mutable'enums
                mutable'tables)
          "Schema"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"comment") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"name") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                ((Data.Monoid.<>)
                   (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                      (\ _v
                         -> (Data.Monoid.<>)
                              (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                              ((Prelude..)
                                 (\ bs
                                    -> (Data.Monoid.<>)
                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                            (Prelude.fromIntegral (Data.ByteString.length bs)))
                                         (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                 Data.ProtoLens.encodeMessage _v))
                      (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'tables") _x))
                   ((Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                         (\ _v
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                                 ((Prelude..)
                                    (\ bs
                                       -> (Data.Monoid.<>)
                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                               (Prelude.fromIntegral (Data.ByteString.length bs)))
                                            (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                    Data.ProtoLens.encodeMessage _v))
                         (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'enums") _x))
                      ((Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                            (\ _v
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                    ((Prelude..)
                                       (\ bs
                                          -> (Data.Monoid.<>)
                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                  (Prelude.fromIntegral
                                                     (Data.ByteString.length bs)))
                                               (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                       Data.ProtoLens.encodeMessage _v))
                            (Lens.Family2.view
                               (Data.ProtoLens.Field.field @"vec'compositeTypes") _x))
                         (Data.ProtoLens.Encoding.Wire.buildFieldSet
                            (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))
instance Control.DeepSeq.NFData Schema where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Schema'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Schema'comment x__)
                (Control.DeepSeq.deepseq
                   (_Schema'name x__)
                   (Control.DeepSeq.deepseq
                      (_Schema'tables x__)
                      (Control.DeepSeq.deepseq
                         (_Schema'enums x__)
                         (Control.DeepSeq.deepseq (_Schema'compositeTypes x__) ())))))
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.version' @:: Lens' Settings Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.engine' @:: Lens' Settings Data.Text.Text@
         * 'Proto.Protos.Codegen_Fields.schema' @:: Lens' Settings [Data.Text.Text]@
         * 'Proto.Protos.Codegen_Fields.vec'schema' @:: Lens' Settings (Data.Vector.Vector Data.Text.Text)@
         * 'Proto.Protos.Codegen_Fields.queries' @:: Lens' Settings [Data.Text.Text]@
         * 'Proto.Protos.Codegen_Fields.vec'queries' @:: Lens' Settings (Data.Vector.Vector Data.Text.Text)@
         * 'Proto.Protos.Codegen_Fields.codegen' @:: Lens' Settings Codegen@
         * 'Proto.Protos.Codegen_Fields.maybe'codegen' @:: Lens' Settings (Prelude.Maybe Codegen)@ -}
data Settings
  = Settings'_constructor {_Settings'version :: !Data.Text.Text,
                           _Settings'engine :: !Data.Text.Text,
                           _Settings'schema :: !(Data.Vector.Vector Data.Text.Text),
                           _Settings'queries :: !(Data.Vector.Vector Data.Text.Text),
                           _Settings'codegen :: !(Prelude.Maybe Codegen),
                           _Settings'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Settings where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Settings "version" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Settings'version (\ x__ y__ -> x__ {_Settings'version = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Settings "engine" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Settings'engine (\ x__ y__ -> x__ {_Settings'engine = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Settings "schema" [Data.Text.Text] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Settings'schema (\ x__ y__ -> x__ {_Settings'schema = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Settings "vec'schema" (Data.Vector.Vector Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Settings'schema (\ x__ y__ -> x__ {_Settings'schema = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Settings "queries" [Data.Text.Text] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Settings'queries (\ x__ y__ -> x__ {_Settings'queries = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Settings "vec'queries" (Data.Vector.Vector Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Settings'queries (\ x__ y__ -> x__ {_Settings'queries = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Settings "codegen" Codegen where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Settings'codegen (\ x__ y__ -> x__ {_Settings'codegen = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Settings "maybe'codegen" (Prelude.Maybe Codegen) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Settings'codegen (\ x__ y__ -> x__ {_Settings'codegen = y__}))
        Prelude.id
instance Data.ProtoLens.Message Settings where
  messageName _ = Data.Text.pack "plugin.Settings"
  packedMessageDescriptor _
    = "\n\
      \\bSettings\DC2\CAN\n\
      \\aversion\CAN\SOH \SOH(\tR\aversion\DC2\SYN\n\
      \\ACKengine\CAN\STX \SOH(\tR\ACKengine\DC2\SYN\n\
      \\ACKschema\CAN\ETX \ETX(\tR\ACKschema\DC2\CAN\n\
      \\aqueries\CAN\EOT \ETX(\tR\aqueries\DC2)\n\
      \\acodegen\CAN\f \SOH(\v2\SI.plugin.CodegenR\acodegenJ\EOT\b\ENQ\DLE\ACKJ\EOT\b\b\DLE\tJ\EOT\b\t\DLE\n\
      \J\EOT\b\n\
      \\DLE\vJ\EOT\b\v\DLE\f"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        version__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"version")) ::
              Data.ProtoLens.FieldDescriptor Settings
        engine__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "engine"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"engine")) ::
              Data.ProtoLens.FieldDescriptor Settings
        schema__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "schema"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"schema")) ::
              Data.ProtoLens.FieldDescriptor Settings
        queries__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "queries"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"queries")) ::
              Data.ProtoLens.FieldDescriptor Settings
        codegen__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "codegen"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Codegen)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'codegen")) ::
              Data.ProtoLens.FieldDescriptor Settings
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, version__field_descriptor),
           (Data.ProtoLens.Tag 2, engine__field_descriptor),
           (Data.ProtoLens.Tag 3, schema__field_descriptor),
           (Data.ProtoLens.Tag 4, queries__field_descriptor),
           (Data.ProtoLens.Tag 12, codegen__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Settings'_unknownFields
        (\ x__ y__ -> x__ {_Settings'_unknownFields = y__})
  defMessage
    = Settings'_constructor
        {_Settings'version = Data.ProtoLens.fieldDefault,
         _Settings'engine = Data.ProtoLens.fieldDefault,
         _Settings'schema = Data.Vector.Generic.empty,
         _Settings'queries = Data.Vector.Generic.empty,
         _Settings'codegen = Prelude.Nothing, _Settings'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Settings
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Data.Text.Text
             -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Data.Text.Text
                -> Data.ProtoLens.Encoding.Bytes.Parser Settings
        loop x mutable'queries mutable'schema
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'queries <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                          (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                             mutable'queries)
                      frozen'schema <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                         (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                            mutable'schema)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'queries") frozen'queries
                              (Lens.Family2.set
                                 (Data.ProtoLens.Field.field @"vec'schema") frozen'schema x)))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "version"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"version") y x)
                                  mutable'queries mutable'schema
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "engine"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"engine") y x)
                                  mutable'queries mutable'schema
                        26
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.getText
                                              (Prelude.fromIntegral len))
                                        "schema"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'schema y)
                                loop x mutable'queries v
                        34
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.getText
                                              (Prelude.fromIntegral len))
                                        "queries"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'queries y)
                                loop x v mutable'schema
                        98
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "codegen"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"codegen") y x)
                                  mutable'queries mutable'schema
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'queries mutable'schema
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'queries <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                   Data.ProtoLens.Encoding.Growing.new
              mutable'schema <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                  Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'queries mutable'schema)
          "Settings"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"version") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"engine") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                ((Data.Monoid.<>)
                   (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                      (\ _v
                         -> (Data.Monoid.<>)
                              (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                              ((Prelude..)
                                 (\ bs
                                    -> (Data.Monoid.<>)
                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                            (Prelude.fromIntegral (Data.ByteString.length bs)))
                                         (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                 Data.Text.Encoding.encodeUtf8 _v))
                      (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'schema") _x))
                   ((Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                         (\ _v
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                                 ((Prelude..)
                                    (\ bs
                                       -> (Data.Monoid.<>)
                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                               (Prelude.fromIntegral (Data.ByteString.length bs)))
                                            (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                    Data.Text.Encoding.encodeUtf8 _v))
                         (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'queries") _x))
                      ((Data.Monoid.<>)
                         (case
                              Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'codegen") _x
                          of
                            Prelude.Nothing -> Data.Monoid.mempty
                            (Prelude.Just _v)
                              -> (Data.Monoid.<>)
                                   (Data.ProtoLens.Encoding.Bytes.putVarInt 98)
                                   ((Prelude..)
                                      (\ bs
                                         -> (Data.Monoid.<>)
                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                 (Prelude.fromIntegral (Data.ByteString.length bs)))
                                              (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                      Data.ProtoLens.encodeMessage _v))
                         (Data.ProtoLens.Encoding.Wire.buildFieldSet
                            (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))
instance Control.DeepSeq.NFData Settings where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Settings'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Settings'version x__)
                (Control.DeepSeq.deepseq
                   (_Settings'engine x__)
                   (Control.DeepSeq.deepseq
                      (_Settings'schema x__)
                      (Control.DeepSeq.deepseq
                         (_Settings'queries x__)
                         (Control.DeepSeq.deepseq (_Settings'codegen x__) ())))))
{- | Fields :
     
         * 'Proto.Protos.Codegen_Fields.rel' @:: Lens' Table Identifier@
         * 'Proto.Protos.Codegen_Fields.maybe'rel' @:: Lens' Table (Prelude.Maybe Identifier)@
         * 'Proto.Protos.Codegen_Fields.columns' @:: Lens' Table [Column]@
         * 'Proto.Protos.Codegen_Fields.vec'columns' @:: Lens' Table (Data.Vector.Vector Column)@
         * 'Proto.Protos.Codegen_Fields.comment' @:: Lens' Table Data.Text.Text@ -}
data Table
  = Table'_constructor {_Table'rel :: !(Prelude.Maybe Identifier),
                        _Table'columns :: !(Data.Vector.Vector Column),
                        _Table'comment :: !Data.Text.Text,
                        _Table'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Table where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Table "rel" Identifier where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Table'rel (\ x__ y__ -> x__ {_Table'rel = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Table "maybe'rel" (Prelude.Maybe Identifier) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Table'rel (\ x__ y__ -> x__ {_Table'rel = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Table "columns" [Column] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Table'columns (\ x__ y__ -> x__ {_Table'columns = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Table "vec'columns" (Data.Vector.Vector Column) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Table'columns (\ x__ y__ -> x__ {_Table'columns = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Table "comment" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Table'comment (\ x__ y__ -> x__ {_Table'comment = y__}))
        Prelude.id
instance Data.ProtoLens.Message Table where
  messageName _ = Data.Text.pack "plugin.Table"
  packedMessageDescriptor _
    = "\n\
      \\ENQTable\DC2$\n\
      \\ETXrel\CAN\SOH \SOH(\v2\DC2.plugin.IdentifierR\ETXrel\DC2(\n\
      \\acolumns\CAN\STX \ETX(\v2\SO.plugin.ColumnR\acolumns\DC2\CAN\n\
      \\acomment\CAN\ETX \SOH(\tR\acomment"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        rel__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "rel"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Identifier)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'rel")) ::
              Data.ProtoLens.FieldDescriptor Table
        columns__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "columns"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Column)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"columns")) ::
              Data.ProtoLens.FieldDescriptor Table
        comment__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "comment"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"comment")) ::
              Data.ProtoLens.FieldDescriptor Table
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, rel__field_descriptor),
           (Data.ProtoLens.Tag 2, columns__field_descriptor),
           (Data.ProtoLens.Tag 3, comment__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Table'_unknownFields
        (\ x__ y__ -> x__ {_Table'_unknownFields = y__})
  defMessage
    = Table'_constructor
        {_Table'rel = Prelude.Nothing,
         _Table'columns = Data.Vector.Generic.empty,
         _Table'comment = Data.ProtoLens.fieldDefault,
         _Table'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Table
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Column
             -> Data.ProtoLens.Encoding.Bytes.Parser Table
        loop x mutable'columns
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'columns <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                          (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                             mutable'columns)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'columns") frozen'columns x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "rel"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"rel") y x)
                                  mutable'columns
                        18
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "columns"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'columns y)
                                loop x v
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "comment"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"comment") y x)
                                  mutable'columns
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'columns
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'columns <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                   Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'columns)
          "Table"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'rel") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just _v)
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage _v))
             ((Data.Monoid.<>)
                (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                   (\ _v
                      -> (Data.Monoid.<>)
                           (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                           ((Prelude..)
                              (\ bs
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                         (Prelude.fromIntegral (Data.ByteString.length bs)))
                                      (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                              Data.ProtoLens.encodeMessage _v))
                   (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'columns") _x))
                ((Data.Monoid.<>)
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"comment") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                            ((Prelude..)
                               (\ bs
                                  -> (Data.Monoid.<>)
                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                          (Prelude.fromIntegral (Data.ByteString.length bs)))
                                       (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                               Data.Text.Encoding.encodeUtf8 _v))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData Table where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Table'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Table'rel x__)
                (Control.DeepSeq.deepseq
                   (_Table'columns x__)
                   (Control.DeepSeq.deepseq (_Table'comment x__) ())))
data CodegenService = CodegenService {}
instance Data.ProtoLens.Service.Types.Service CodegenService where
  type ServiceName CodegenService = "CodegenService"
  type ServicePackage CodegenService = "plugin"
  type ServiceMethods CodegenService = '["generate"]
  packedServiceDescriptor _
    = "\n\
      \\SOCodegenService\DC2=\n\
      \\bGenerate\DC2\ETB.plugin.GenerateRequest\SUB\CAN.plugin.GenerateResponse"
instance Data.ProtoLens.Service.Types.HasMethodImpl CodegenService "generate" where
  type MethodName CodegenService "generate" = "Generate"
  type MethodInput CodegenService "generate" = GenerateRequest
  type MethodOutput CodegenService "generate" = GenerateResponse
  type MethodStreamingType CodegenService "generate" = 'Data.ProtoLens.Service.Types.NonStreaming
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \\DC4protos/codegen.proto\DC2\ACKplugin\"6\n\
    \\EOTFile\DC2\DC2\n\
    \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2\SUB\n\
    \\bcontents\CAN\STX \SOH(\fR\bcontents\"\183\SOH\n\
    \\bSettings\DC2\CAN\n\
    \\aversion\CAN\SOH \SOH(\tR\aversion\DC2\SYN\n\
    \\ACKengine\CAN\STX \SOH(\tR\ACKengine\DC2\SYN\n\
    \\ACKschema\CAN\ETX \ETX(\tR\ACKschema\DC2\CAN\n\
    \\aqueries\CAN\EOT \ETX(\tR\aqueries\DC2)\n\
    \\acodegen\CAN\f \SOH(\v2\SI.plugin.CodegenR\acodegenJ\EOT\b\ENQ\DLE\ACKJ\EOT\b\b\DLE\tJ\EOT\b\t\DLE\n\
    \J\EOT\b\n\
    \\DLE\vJ\EOT\b\v\DLE\f\"\139\STX\n\
    \\aCodegen\DC2\DLE\n\
    \\ETXout\CAN\SOH \SOH(\tR\ETXout\DC2\SYN\n\
    \\ACKplugin\CAN\STX \SOH(\tR\ACKplugin\DC2\CAN\n\
    \\aoptions\CAN\ETX \SOH(\fR\aoptions\DC2\DLE\n\
    \\ETXenv\CAN\EOT \ETX(\tR\ETXenv\DC21\n\
    \\aprocess\CAN\ENQ \SOH(\v2\ETB.plugin.Codegen.ProcessR\aprocess\DC2(\n\
    \\EOTwasm\CAN\ACK \SOH(\v2\DC4.plugin.Codegen.WASMR\EOTwasm\SUB\ESC\n\
    \\aProcess\DC2\DLE\n\
    \\ETXcmd\CAN\SOH \SOH(\tR\ETXcmd\SUB0\n\
    \\EOTWASM\DC2\DLE\n\
    \\ETXurl\CAN\SOH \SOH(\tR\ETXurl\DC2\SYN\n\
    \\ACKsha256\CAN\STX \SOH(\tR\ACKsha256\"\136\SOH\n\
    \\aCatalog\DC2\CAN\n\
    \\acomment\CAN\SOH \SOH(\tR\acomment\DC2%\n\
    \\SOdefault_schema\CAN\STX \SOH(\tR\rdefaultSchema\DC2\DC2\n\
    \\EOTname\CAN\ETX \SOH(\tR\EOTname\DC2(\n\
    \\aschemas\CAN\EOT \ETX(\v2\SO.plugin.SchemaR\aschemas\"\193\SOH\n\
    \\ACKSchema\DC2\CAN\n\
    \\acomment\CAN\SOH \SOH(\tR\acomment\DC2\DC2\n\
    \\EOTname\CAN\STX \SOH(\tR\EOTname\DC2%\n\
    \\ACKtables\CAN\ETX \ETX(\v2\r.plugin.TableR\ACKtables\DC2\"\n\
    \\ENQenums\CAN\EOT \ETX(\v2\f.plugin.EnumR\ENQenums\DC2>\n\
    \\SIcomposite_types\CAN\ENQ \ETX(\v2\NAK.plugin.CompositeTypeR\SOcompositeTypes\"=\n\
    \\rCompositeType\DC2\DC2\n\
    \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2\CAN\n\
    \\acomment\CAN\STX \SOH(\tR\acomment\"H\n\
    \\EOTEnum\DC2\DC2\n\
    \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2\DC2\n\
    \\EOTvals\CAN\STX \ETX(\tR\EOTvals\DC2\CAN\n\
    \\acomment\CAN\ETX \SOH(\tR\acomment\"q\n\
    \\ENQTable\DC2$\n\
    \\ETXrel\CAN\SOH \SOH(\v2\DC2.plugin.IdentifierR\ETXrel\DC2(\n\
    \\acolumns\CAN\STX \ETX(\v2\SO.plugin.ColumnR\acolumns\DC2\CAN\n\
    \\acomment\CAN\ETX \SOH(\tR\acomment\"R\n\
    \\n\
    \Identifier\DC2\CAN\n\
    \\acatalog\CAN\SOH \SOH(\tR\acatalog\DC2\SYN\n\
    \\ACKschema\CAN\STX \SOH(\tR\ACKschema\DC2\DC2\n\
    \\EOTname\CAN\ETX \SOH(\tR\EOTname\"\142\EOT\n\
    \\ACKColumn\DC2\DC2\n\
    \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2\EM\n\
    \\bnot_null\CAN\ETX \SOH(\bR\anotNull\DC2\EM\n\
    \\bis_array\CAN\EOT \SOH(\bR\aisArray\DC2\CAN\n\
    \\acomment\CAN\ENQ \SOH(\tR\acomment\DC2\SYN\n\
    \\ACKlength\CAN\ACK \SOH(\ENQR\ACKlength\DC2$\n\
    \\SOis_named_param\CAN\a \SOH(\bR\fisNamedParam\DC2 \n\
    \\fis_func_call\CAN\b \SOH(\bR\n\
    \isFuncCall\DC2\DC4\n\
    \\ENQscope\CAN\t \SOH(\tR\ENQscope\DC2(\n\
    \\ENQtable\CAN\n\
    \ \SOH(\v2\DC2.plugin.IdentifierR\ENQtable\DC2\US\n\
    \\vtable_alias\CAN\v \SOH(\tR\n\
    \tableAlias\DC2&\n\
    \\EOTtype\CAN\f \SOH(\v2\DC2.plugin.IdentifierR\EOTtype\DC2\"\n\
    \\ris_sqlc_slice\CAN\r \SOH(\bR\visSqlcSlice\DC23\n\
    \\vembed_table\CAN\SO \SOH(\v2\DC2.plugin.IdentifierR\n\
    \embedTable\DC2#\n\
    \\roriginal_name\CAN\SI \SOH(\tR\foriginalName\DC2\SUB\n\
    \\bunsigned\CAN\DLE \SOH(\bR\bunsigned\DC2\GS\n\
    \\n\
    \array_dims\CAN\DC1 \SOH(\ENQR\tarrayDims\"\148\STX\n\
    \\ENQQuery\DC2\DC2\n\
    \\EOTtext\CAN\SOH \SOH(\tR\EOTtext\DC2\DC2\n\
    \\EOTname\CAN\STX \SOH(\tR\EOTname\DC2\DLE\n\
    \\ETXcmd\CAN\ETX \SOH(\tR\ETXcmd\DC2(\n\
    \\acolumns\CAN\EOT \ETX(\v2\SO.plugin.ColumnR\acolumns\DC2-\n\
    \\ACKparams\CAN\ENQ \ETX(\v2\DC1.plugin.ParameterR\n\
    \parameters\DC2\SUB\n\
    \\bcomments\CAN\ACK \ETX(\tR\bcomments\DC2\SUB\n\
    \\bfilename\CAN\a \SOH(\tR\bfilename\DC2@\n\
    \\DC1insert_into_table\CAN\b \SOH(\v2\DC2.plugin.IdentifierR\DC1insert_into_table\"K\n\
    \\tParameter\DC2\SYN\n\
    \\ACKnumber\CAN\SOH \SOH(\ENQR\ACKnumber\DC2&\n\
    \\ACKcolumn\CAN\STX \SOH(\v2\SO.plugin.ColumnR\ACKcolumn\"\135\STX\n\
    \\SIGenerateRequest\DC2,\n\
    \\bsettings\CAN\SOH \SOH(\v2\DLE.plugin.SettingsR\bsettings\DC2)\n\
    \\acatalog\CAN\STX \SOH(\v2\SI.plugin.CatalogR\acatalog\DC2'\n\
    \\aqueries\CAN\ETX \ETX(\v2\r.plugin.QueryR\aqueries\DC2\"\n\
    \\fsqlc_version\CAN\EOT \SOH(\tR\fsqlc_version\DC2&\n\
    \\SOplugin_options\CAN\ENQ \SOH(\fR\SOplugin_options\DC2&\n\
    \\SOglobal_options\CAN\ACK \SOH(\fR\SOglobal_options\"6\n\
    \\DLEGenerateResponse\DC2\"\n\
    \\ENQfiles\CAN\SOH \ETX(\v2\f.plugin.FileR\ENQfiles2O\n\
    \\SOCodegenService\DC2=\n\
    \\bGenerate\DC2\ETB.plugin.GenerateRequest\SUB\CAN.plugin.GenerateResponseJ\225\&0\n\
    \\a\DC2\ENQ\NUL\NUL\131\SOH\SOH\n\
    \\b\n\
    \\SOH\f\DC2\ETX\NUL\NUL\DC2\n\
    \\b\n\
    \\SOH\STX\DC2\ETX\STX\NUL\SI\n\
    \\n\
    \\n\
    \\STX\ACK\NUL\DC2\EOT\EOT\NUL\ACK\SOH\n\
    \\n\
    \\n\
    \\ETX\ACK\NUL\SOH\DC2\ETX\EOT\b\SYN\n\
    \\v\n\
    \\EOT\ACK\NUL\STX\NUL\DC2\ETX\ENQ\STX<\n\
    \\f\n\
    \\ENQ\ACK\NUL\STX\NUL\SOH\DC2\ETX\ENQ\ACK\SO\n\
    \\f\n\
    \\ENQ\ACK\NUL\STX\NUL\STX\DC2\ETX\ENQ\DLE\US\n\
    \\f\n\
    \\ENQ\ACK\NUL\STX\NUL\ETX\DC2\ETX\ENQ*:\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT\b\NUL\v\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX\b\b\f\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX\t\STX'\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX\t\STX\b\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX\t\t\r\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX\t\DLE\DC1\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\b\DC2\ETX\t\DC2&\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\n\
    \\DC2\ETX\t\DC3%\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\n\
    \\DC2\ETX\t\US%\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX\n\
    \\STX.\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ENQ\DC2\ETX\n\
    \\STX\a\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX\n\
    \\b\DLE\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX\n\
    \\DC3\DC4\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\b\DC2\ETX\n\
    \\NAK-\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\n\
    \\DC2\ETX\n\
    \\SYN,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\n\
    \\DC2\ETX\n\
    \\",\n\
    \\n\
    \\n\
    \\STX\EOT\SOH\DC2\EOT\r\NUL\ESC\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX\r\b\DLE\n\
    \\197\SOH\n\
    \\ETX\EOT\SOH\t\DC2\ETX\DC4\STX\ESC\SUB\184\SOH Rename message was field 5\n\
    \ Overides message was field 6\n\
    \ PythonCode message was field 8\n\
    \ KotlinCode message was field 9\n\
    \ GoCode message was field 10;\n\
    \ JSONCode message was field 11;\n\
    \\n\
    \\v\n\
    \\EOT\EOT\SOH\t\NUL\DC2\ETX\DC4\v\f\n\
    \\f\n\
    \\ENQ\EOT\SOH\t\NUL\SOH\DC2\ETX\DC4\v\f\n\
    \\f\n\
    \\ENQ\EOT\SOH\t\NUL\STX\DC2\ETX\DC4\v\f\n\
    \\v\n\
    \\EOT\EOT\SOH\t\SOH\DC2\ETX\DC4\SO\SI\n\
    \\f\n\
    \\ENQ\EOT\SOH\t\SOH\SOH\DC2\ETX\DC4\SO\SI\n\
    \\f\n\
    \\ENQ\EOT\SOH\t\SOH\STX\DC2\ETX\DC4\SO\SI\n\
    \\v\n\
    \\EOT\EOT\SOH\t\STX\DC2\ETX\DC4\DC1\DC2\n\
    \\f\n\
    \\ENQ\EOT\SOH\t\STX\SOH\DC2\ETX\DC4\DC1\DC2\n\
    \\f\n\
    \\ENQ\EOT\SOH\t\STX\STX\DC2\ETX\DC4\DC1\DC2\n\
    \\v\n\
    \\EOT\EOT\SOH\t\ETX\DC2\ETX\DC4\DC4\SYN\n\
    \\f\n\
    \\ENQ\EOT\SOH\t\ETX\SOH\DC2\ETX\DC4\DC4\SYN\n\
    \\f\n\
    \\ENQ\EOT\SOH\t\ETX\STX\DC2\ETX\DC4\DC4\SYN\n\
    \\v\n\
    \\EOT\EOT\SOH\t\EOT\DC2\ETX\DC4\CAN\SUB\n\
    \\f\n\
    \\ENQ\EOT\SOH\t\EOT\SOH\DC2\ETX\DC4\CAN\SUB\n\
    \\f\n\
    \\ENQ\EOT\SOH\t\EOT\STX\DC2\ETX\DC4\CAN\SUB\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX\SYN\STX-\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ENQ\DC2\ETX\SYN\STX\b\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX\SYN\t\DLE\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX\SYN\DC3\DC4\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\b\DC2\ETX\SYN\NAK,\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\n\
    \\DC2\ETX\SYN\SYN+\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\n\
    \\DC2\ETX\SYN\"+\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX\ETB\STX+\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ENQ\DC2\ETX\ETB\STX\b\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX\ETB\t\SI\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX\ETB\DC2\DC3\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\b\DC2\ETX\ETB\DC4*\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\n\
    \\DC2\ETX\ETB\NAK)\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\n\
    \\DC2\ETX\ETB!)\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\STX\DC2\ETX\CAN\STX4\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\EOT\DC2\ETX\CAN\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ENQ\DC2\ETX\CAN\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\SOH\DC2\ETX\CAN\DC2\CAN\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ETX\DC2\ETX\CAN\ESC\FS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\b\DC2\ETX\CAN\GS3\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\n\
    \\DC2\ETX\CAN\RS2\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\n\
    \\DC2\ETX\CAN*2\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\ETX\DC2\ETX\EM\STX6\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\EOT\DC2\ETX\EM\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ENQ\DC2\ETX\EM\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\SOH\DC2\ETX\EM\DC2\EM\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ETX\DC2\ETX\EM\FS\GS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\b\DC2\ETX\EM\RS5\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\n\
    \\DC2\ETX\EM\US4\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\n\
    \\DC2\ETX\EM+4\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\EOT\DC2\ETX\SUB\STX/\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\ACK\DC2\ETX\SUB\STX\t\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\SOH\DC2\ETX\SUB\n\
    \\DC1\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\ETX\DC2\ETX\SUB\DC4\SYN\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\b\DC2\ETX\SUB\ETB.\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\n\
    \\DC2\ETX\SUB\CAN-\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\n\
    \\DC2\ETX\SUB$-\n\
    \\n\
    \\n\
    \\STX\EOT\STX\DC2\EOT\GS\NUL+\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX\GS\b\SI\n\
    \\f\n\
    \\EOT\EOT\STX\ETX\NUL\DC2\EOT\RS\STX \ETX\n\
    \\f\n\
    \\ENQ\EOT\STX\ETX\NUL\SOH\DC2\ETX\RS\n\
    \\DC1\n\
    \\r\n\
    \\ACK\EOT\STX\ETX\NUL\STX\NUL\DC2\ETX\US\EOT\DC3\n\
    \\SO\n\
    \\a\EOT\STX\ETX\NUL\STX\NUL\ENQ\DC2\ETX\US\EOT\n\
    \\n\
    \\SO\n\
    \\a\EOT\STX\ETX\NUL\STX\NUL\SOH\DC2\ETX\US\v\SO\n\
    \\SO\n\
    \\a\EOT\STX\ETX\NUL\STX\NUL\ETX\DC2\ETX\US\DC1\DC2\n\
    \\f\n\
    \\EOT\EOT\STX\ETX\SOH\DC2\EOT!\STX$\ETX\n\
    \\f\n\
    \\ENQ\EOT\STX\ETX\SOH\SOH\DC2\ETX!\n\
    \\SO\n\
    \\r\n\
    \\ACK\EOT\STX\ETX\SOH\STX\NUL\DC2\ETX\"\EOT\DC3\n\
    \\SO\n\
    \\a\EOT\STX\ETX\SOH\STX\NUL\ENQ\DC2\ETX\"\EOT\n\
    \\n\
    \\SO\n\
    \\a\EOT\STX\ETX\SOH\STX\NUL\SOH\DC2\ETX\"\v\SO\n\
    \\SO\n\
    \\a\EOT\STX\ETX\SOH\STX\NUL\ETX\DC2\ETX\"\DC1\DC2\n\
    \\r\n\
    \\ACK\EOT\STX\ETX\SOH\STX\SOH\DC2\ETX#\EOT\SYN\n\
    \\SO\n\
    \\a\EOT\STX\ETX\SOH\STX\SOH\ENQ\DC2\ETX#\EOT\n\
    \\n\
    \\SO\n\
    \\a\EOT\STX\ETX\SOH\STX\SOH\SOH\DC2\ETX#\v\DC1\n\
    \\SO\n\
    \\a\EOT\STX\ETX\SOH\STX\SOH\ETX\DC2\ETX#\DC4\NAK\n\
    \\v\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX%\STX%\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ENQ\DC2\ETX%\STX\b\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX%\t\f\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX%\SI\DLE\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\b\DC2\ETX%\DC1$\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\n\
    \\DC2\ETX%\DC2#\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\n\
    \\DC2\ETX%\RS#\n\
    \\v\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX&\STX+\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ENQ\DC2\ETX&\STX\b\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX&\t\SI\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX&\DC2\DC3\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\b\DC2\ETX&\DC4*\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\n\
    \\DC2\ETX&\NAK)\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\n\
    \\DC2\ETX&!)\n\
    \\v\n\
    \\EOT\EOT\STX\STX\STX\DC2\ETX'\STX,\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ENQ\DC2\ETX'\STX\a\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\SOH\DC2\ETX'\b\SI\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ETX\DC2\ETX'\DC2\DC3\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\b\DC2\ETX'\DC4+\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\n\
    \\DC2\ETX'\NAK*\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\n\
    \\DC2\ETX'!*\n\
    \\v\n\
    \\EOT\EOT\STX\STX\ETX\DC2\ETX(\STX.\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\EOT\DC2\ETX(\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\ENQ\DC2\ETX(\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\SOH\DC2\ETX(\DC2\NAK\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\ETX\DC2\ETX(\CAN\EM\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\b\DC2\ETX(\SUB-\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\n\
    \\DC2\ETX(\ESC,\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\n\
    \\DC2\ETX(',\n\
    \\v\n\
    \\EOT\EOT\STX\STX\EOT\DC2\ETX)\STX.\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\ACK\DC2\ETX)\STX\t\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\SOH\DC2\ETX)\n\
    \\DC1\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\ETX\DC2\ETX)\DC4\NAK\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\b\DC2\ETX)\SYN-\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\n\
    \\DC2\ETX)\ETB,\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\n\
    \\DC2\ETX)#,\n\
    \\v\n\
    \\EOT\EOT\STX\STX\ENQ\DC2\ETX*\STX%\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ENQ\ACK\DC2\ETX*\STX\ACK\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ENQ\SOH\DC2\ETX*\a\v\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ENQ\ETX\DC2\ETX*\SO\SI\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ENQ\b\DC2\ETX*\DLE$\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ENQ\n\
    \\DC2\ETX*\DC1#\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ENQ\n\
    \\DC2\ETX*\GS#\n\
    \\n\
    \\n\
    \\STX\EOT\ETX\DC2\EOT-\NUL2\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETX-\b\SI\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETX.\STX\NAK\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ENQ\DC2\ETX.\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETX.\t\DLE\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETX.\DC3\DC4\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\SOH\DC2\ETX/\STX\FS\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ENQ\DC2\ETX/\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\SOH\DC2\ETX/\t\ETB\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ETX\DC2\ETX/\SUB\ESC\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\STX\DC2\ETX0\STX\DC2\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ENQ\DC2\ETX0\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\SOH\DC2\ETX0\t\r\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ETX\DC2\ETX0\DLE\DC1\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\ETX\DC2\ETX1\STX\RS\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\EOT\DC2\ETX1\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\ACK\DC2\ETX1\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\SOH\DC2\ETX1\DC2\EM\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\ETX\DC2\ETX1\FS\GS\n\
    \\n\
    \\n\
    \\STX\EOT\EOT\DC2\EOT4\NUL:\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETX4\b\SO\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETX5\STX\NAK\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ENQ\DC2\ETX5\STX\b\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETX5\t\DLE\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETX5\DC3\DC4\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\SOH\DC2\ETX6\STX\DC2\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\ENQ\DC2\ETX6\STX\b\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\SOH\DC2\ETX6\t\r\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\ETX\DC2\ETX6\DLE\DC1\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\STX\DC2\ETX7\STX\FS\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\EOT\DC2\ETX7\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\ACK\DC2\ETX7\v\DLE\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\SOH\DC2\ETX7\DC1\ETB\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\ETX\DC2\ETX7\SUB\ESC\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\ETX\DC2\ETX8\STX\SUB\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ETX\EOT\DC2\ETX8\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ETX\ACK\DC2\ETX8\v\SI\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ETX\SOH\DC2\ETX8\DLE\NAK\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ETX\ETX\DC2\ETX8\CAN\EM\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\EOT\DC2\ETX9\STX-\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\EOT\EOT\DC2\ETX9\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\EOT\ACK\DC2\ETX9\v\CAN\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\EOT\SOH\DC2\ETX9\EM(\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\EOT\ETX\DC2\ETX9+,\n\
    \\n\
    \\n\
    \\STX\EOT\ENQ\DC2\EOT<\NUL?\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETX<\b\NAK\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETX=\STX\DC2\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ENQ\DC2\ETX=\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETX=\t\r\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETX=\DLE\DC1\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\SOH\DC2\ETX>\STX\NAK\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ENQ\DC2\ETX>\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\SOH\DC2\ETX>\t\DLE\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ETX\DC2\ETX>\DC3\DC4\n\
    \\n\
    \\n\
    \\STX\EOT\ACK\DC2\EOTA\NULE\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ACK\SOH\DC2\ETXA\b\f\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\ETXB\STX\DC2\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ENQ\DC2\ETXB\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\ETXB\t\r\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\ETXB\DLE\DC1\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\SOH\DC2\ETXC\STX\ESC\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\EOT\DC2\ETXC\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ENQ\DC2\ETXC\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\SOH\DC2\ETXC\DC2\SYN\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ETX\DC2\ETXC\EM\SUB\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\STX\DC2\ETXD\STX\NAK\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\ENQ\DC2\ETXD\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\SOH\DC2\ETXD\t\DLE\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\ETX\DC2\ETXD\DC3\DC4\n\
    \\n\
    \\n\
    \\STX\EOT\a\DC2\EOTG\NULK\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\a\SOH\DC2\ETXG\b\r\n\
    \\v\n\
    \\EOT\EOT\a\STX\NUL\DC2\ETXH\STX\NAK\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ACK\DC2\ETXH\STX\f\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\SOH\DC2\ETXH\r\DLE\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ETX\DC2\ETXH\DC3\DC4\n\
    \\v\n\
    \\EOT\EOT\a\STX\SOH\DC2\ETXI\STX\RS\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\EOT\DC2\ETXI\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\ACK\DC2\ETXI\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\SOH\DC2\ETXI\DC2\EM\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\ETX\DC2\ETXI\FS\GS\n\
    \\v\n\
    \\EOT\EOT\a\STX\STX\DC2\ETXJ\STX\NAK\n\
    \\f\n\
    \\ENQ\EOT\a\STX\STX\ENQ\DC2\ETXJ\STX\b\n\
    \\f\n\
    \\ENQ\EOT\a\STX\STX\SOH\DC2\ETXJ\t\DLE\n\
    \\f\n\
    \\ENQ\EOT\a\STX\STX\ETX\DC2\ETXJ\DC3\DC4\n\
    \\n\
    \\n\
    \\STX\EOT\b\DC2\EOTM\NULQ\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\b\SOH\DC2\ETXM\b\DC2\n\
    \\v\n\
    \\EOT\EOT\b\STX\NUL\DC2\ETXN\STX\NAK\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ENQ\DC2\ETXN\STX\b\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\SOH\DC2\ETXN\t\DLE\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ETX\DC2\ETXN\DC3\DC4\n\
    \\v\n\
    \\EOT\EOT\b\STX\SOH\DC2\ETXO\STX\DC4\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\ENQ\DC2\ETXO\STX\b\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\SOH\DC2\ETXO\t\SI\n\
    \\f\n\
    \\ENQ\EOT\b\STX\SOH\ETX\DC2\ETXO\DC2\DC3\n\
    \\v\n\
    \\EOT\EOT\b\STX\STX\DC2\ETXP\STX\DC2\n\
    \\f\n\
    \\ENQ\EOT\b\STX\STX\ENQ\DC2\ETXP\STX\b\n\
    \\f\n\
    \\ENQ\EOT\b\STX\STX\SOH\DC2\ETXP\t\r\n\
    \\f\n\
    \\ENQ\EOT\b\STX\STX\ETX\DC2\ETXP\DLE\DC1\n\
    \\n\
    \\n\
    \\STX\EOT\t\DC2\EOTS\NULf\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\t\SOH\DC2\ETXS\b\SO\n\
    \\v\n\
    \\EOT\EOT\t\STX\NUL\DC2\ETXT\STX\DC2\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\ENQ\DC2\ETXT\STX\b\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\SOH\DC2\ETXT\t\r\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\ETX\DC2\ETXT\DLE\DC1\n\
    \\v\n\
    \\EOT\EOT\t\STX\SOH\DC2\ETXU\STX\DC4\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\ENQ\DC2\ETXU\STX\ACK\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\SOH\DC2\ETXU\a\SI\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\ETX\DC2\ETXU\DC2\DC3\n\
    \\v\n\
    \\EOT\EOT\t\STX\STX\DC2\ETXV\STX\DC4\n\
    \\f\n\
    \\ENQ\EOT\t\STX\STX\ENQ\DC2\ETXV\STX\ACK\n\
    \\f\n\
    \\ENQ\EOT\t\STX\STX\SOH\DC2\ETXV\a\SI\n\
    \\f\n\
    \\ENQ\EOT\t\STX\STX\ETX\DC2\ETXV\DC2\DC3\n\
    \\v\n\
    \\EOT\EOT\t\STX\ETX\DC2\ETXW\STX\NAK\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ETX\ENQ\DC2\ETXW\STX\b\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ETX\SOH\DC2\ETXW\t\DLE\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ETX\ETX\DC2\ETXW\DC3\DC4\n\
    \\v\n\
    \\EOT\EOT\t\STX\EOT\DC2\ETXX\STX\DC3\n\
    \\f\n\
    \\ENQ\EOT\t\STX\EOT\ENQ\DC2\ETXX\STX\a\n\
    \\f\n\
    \\ENQ\EOT\t\STX\EOT\SOH\DC2\ETXX\b\SO\n\
    \\f\n\
    \\ENQ\EOT\t\STX\EOT\ETX\DC2\ETXX\DC1\DC2\n\
    \\v\n\
    \\EOT\EOT\t\STX\ENQ\DC2\ETXY\STX\SUB\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ENQ\ENQ\DC2\ETXY\STX\ACK\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ENQ\SOH\DC2\ETXY\a\NAK\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ENQ\ETX\DC2\ETXY\CAN\EM\n\
    \\v\n\
    \\EOT\EOT\t\STX\ACK\DC2\ETXZ\STX\CAN\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ACK\ENQ\DC2\ETXZ\STX\ACK\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ACK\SOH\DC2\ETXZ\a\DC3\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ACK\ETX\DC2\ETXZ\SYN\ETB\n\
    \=\n\
    \\EOT\EOT\t\STX\a\DC2\ETX]\STX\DC3\SUB0 XXX: Figure out what PostgreSQL calls `foo.id`\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\t\STX\a\ENQ\DC2\ETX]\STX\b\n\
    \\f\n\
    \\ENQ\EOT\t\STX\a\SOH\DC2\ETX]\t\SO\n\
    \\f\n\
    \\ENQ\EOT\t\STX\a\ETX\DC2\ETX]\DC1\DC2\n\
    \\v\n\
    \\EOT\EOT\t\STX\b\DC2\ETX^\STX\CAN\n\
    \\f\n\
    \\ENQ\EOT\t\STX\b\ACK\DC2\ETX^\STX\f\n\
    \\f\n\
    \\ENQ\EOT\t\STX\b\SOH\DC2\ETX^\r\DC2\n\
    \\f\n\
    \\ENQ\EOT\t\STX\b\ETX\DC2\ETX^\NAK\ETB\n\
    \\v\n\
    \\EOT\EOT\t\STX\t\DC2\ETX_\STX\SUB\n\
    \\f\n\
    \\ENQ\EOT\t\STX\t\ENQ\DC2\ETX_\STX\b\n\
    \\f\n\
    \\ENQ\EOT\t\STX\t\SOH\DC2\ETX_\t\DC4\n\
    \\f\n\
    \\ENQ\EOT\t\STX\t\ETX\DC2\ETX_\ETB\EM\n\
    \\v\n\
    \\EOT\EOT\t\STX\n\
    \\DC2\ETX`\STX\ETB\n\
    \\f\n\
    \\ENQ\EOT\t\STX\n\
    \\ACK\DC2\ETX`\STX\f\n\
    \\f\n\
    \\ENQ\EOT\t\STX\n\
    \\SOH\DC2\ETX`\r\DC1\n\
    \\f\n\
    \\ENQ\EOT\t\STX\n\
    \\ETX\DC2\ETX`\DC4\SYN\n\
    \\v\n\
    \\EOT\EOT\t\STX\v\DC2\ETXa\STX\SUB\n\
    \\f\n\
    \\ENQ\EOT\t\STX\v\ENQ\DC2\ETXa\STX\ACK\n\
    \\f\n\
    \\ENQ\EOT\t\STX\v\SOH\DC2\ETXa\a\DC4\n\
    \\f\n\
    \\ENQ\EOT\t\STX\v\ETX\DC2\ETXa\ETB\EM\n\
    \\v\n\
    \\EOT\EOT\t\STX\f\DC2\ETXb\STX\RS\n\
    \\f\n\
    \\ENQ\EOT\t\STX\f\ACK\DC2\ETXb\STX\f\n\
    \\f\n\
    \\ENQ\EOT\t\STX\f\SOH\DC2\ETXb\r\CAN\n\
    \\f\n\
    \\ENQ\EOT\t\STX\f\ETX\DC2\ETXb\ESC\GS\n\
    \\v\n\
    \\EOT\EOT\t\STX\r\DC2\ETXc\STX\FS\n\
    \\f\n\
    \\ENQ\EOT\t\STX\r\ENQ\DC2\ETXc\STX\b\n\
    \\f\n\
    \\ENQ\EOT\t\STX\r\SOH\DC2\ETXc\t\SYN\n\
    \\f\n\
    \\ENQ\EOT\t\STX\r\ETX\DC2\ETXc\EM\ESC\n\
    \\v\n\
    \\EOT\EOT\t\STX\SO\DC2\ETXd\STX\NAK\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SO\ENQ\DC2\ETXd\STX\ACK\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SO\SOH\DC2\ETXd\a\SI\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SO\ETX\DC2\ETXd\DC2\DC4\n\
    \\v\n\
    \\EOT\EOT\t\STX\SI\DC2\ETXe\STX\CAN\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SI\ENQ\DC2\ETXe\STX\a\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SI\SOH\DC2\ETXe\b\DC2\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SI\ETX\DC2\ETXe\NAK\ETB\n\
    \\n\
    \\n\
    \\STX\EOT\n\
    \\DC2\EOTh\NULq\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\n\
    \\SOH\DC2\ETXh\b\r\n\
    \\v\n\
    \\EOT\EOT\n\
    \\STX\NUL\DC2\ETXi\STX'\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ENQ\DC2\ETXi\STX\b\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\SOH\DC2\ETXi\t\r\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ETX\DC2\ETXi\DLE\DC1\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\b\DC2\ETXi\DC2&\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\n\
    \\DC2\ETXi\DC3%\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\n\
    \\DC2\ETXi\US%\n\
    \\v\n\
    \\EOT\EOT\n\
    \\STX\SOH\DC2\ETXj\STX'\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\SOH\ENQ\DC2\ETXj\STX\b\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\SOH\SOH\DC2\ETXj\t\r\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\SOH\ETX\DC2\ETXj\DLE\DC1\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\SOH\b\DC2\ETXj\DC2&\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\SOH\n\
    \\DC2\ETXj\DC3%\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\SOH\n\
    \\DC2\ETXj\US%\n\
    \\v\n\
    \\EOT\EOT\n\
    \\STX\STX\DC2\ETXk\STX%\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\STX\ENQ\DC2\ETXk\STX\b\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\STX\SOH\DC2\ETXk\t\f\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\STX\ETX\DC2\ETXk\SI\DLE\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\STX\b\DC2\ETXk\DC1$\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\STX\n\
    \\DC2\ETXk\DC2#\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\STX\n\
    \\DC2\ETXk\RS#\n\
    \\v\n\
    \\EOT\EOT\n\
    \\STX\ETX\DC2\ETXl\STX6\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ETX\EOT\DC2\ETXl\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ETX\ACK\DC2\ETXl\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ETX\SOH\DC2\ETXl\DC2\EM\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ETX\ETX\DC2\ETXl\FS\GS\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ETX\b\DC2\ETXl\RS5\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ETX\n\
    \\DC2\ETXl\US4\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ETX\n\
    \\DC2\ETXl+4\n\
    \\v\n\
    \\EOT\EOT\n\
    \\STX\EOT\DC2\ETXm\STX;\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\EOT\EOT\DC2\ETXm\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\EOT\ACK\DC2\ETXm\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\EOT\SOH\DC2\ETXm\NAK\ESC\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\EOT\ETX\DC2\ETXm\RS\US\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\EOT\b\DC2\ETXm :\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\EOT\n\
    \\DC2\ETXm!9\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\EOT\n\
    \\DC2\ETXm-9\n\
    \\v\n\
    \\EOT\EOT\n\
    \\STX\ENQ\DC2\ETXn\STX8\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ENQ\EOT\DC2\ETXn\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ENQ\ENQ\DC2\ETXn\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ENQ\SOH\DC2\ETXn\DC2\SUB\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ENQ\ETX\DC2\ETXn\GS\RS\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ENQ\b\DC2\ETXn\US7\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ENQ\n\
    \\DC2\ETXn 6\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ENQ\n\
    \\DC2\ETXn,6\n\
    \\v\n\
    \\EOT\EOT\n\
    \\STX\ACK\DC2\ETXo\STX/\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ACK\ENQ\DC2\ETXo\STX\b\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ACK\SOH\DC2\ETXo\t\DC1\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ACK\ETX\DC2\ETXo\DC4\NAK\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ACK\b\DC2\ETXo\SYN.\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ACK\n\
    \\DC2\ETXo\ETB-\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\ACK\n\
    \\DC2\ETXo#-\n\
    \\v\n\
    \\EOT\EOT\n\
    \\STX\a\DC2\ETXp\STXE\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\a\ACK\DC2\ETXp\STX\f\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\a\SOH\DC2\ETXp\r\RS\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\a\ETX\DC2\ETXp!\"\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\a\b\DC2\ETXp#D\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\a\n\
    \\DC2\ETXp$C\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\a\n\
    \\DC2\ETXp0C\n\
    \\n\
    \\n\
    \\STX\EOT\v\DC2\EOTs\NULv\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\v\SOH\DC2\ETXs\b\DC1\n\
    \\v\n\
    \\EOT\EOT\v\STX\NUL\DC2\ETXt\STX*\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\ENQ\DC2\ETXt\STX\a\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\SOH\DC2\ETXt\b\SO\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\ETX\DC2\ETXt\DC1\DC2\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\b\DC2\ETXt\DC3)\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\n\
    \\DC2\ETXt\DC4(\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\n\
    \\DC2\ETXt (\n\
    \\v\n\
    \\EOT\EOT\v\STX\SOH\DC2\ETXu\STX+\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\ACK\DC2\ETXu\STX\b\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\SOH\DC2\ETXu\t\SI\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\ETX\DC2\ETXu\DC2\DC3\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\b\DC2\ETXu\DC4*\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\n\
    \\DC2\ETXu\NAK)\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\n\
    \\DC2\ETXu!)\n\
    \\n\
    \\n\
    \\STX\EOT\f\DC2\EOTx\NUL\DEL\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\f\SOH\DC2\ETXx\b\ETB\n\
    \\v\n\
    \\EOT\EOT\f\STX\NUL\DC2\ETXy\STX1\n\
    \\f\n\
    \\ENQ\EOT\f\STX\NUL\ACK\DC2\ETXy\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\f\STX\NUL\SOH\DC2\ETXy\v\DC3\n\
    \\f\n\
    \\ENQ\EOT\f\STX\NUL\ETX\DC2\ETXy\SYN\ETB\n\
    \\f\n\
    \\ENQ\EOT\f\STX\NUL\b\DC2\ETXy\CAN0\n\
    \\f\n\
    \\ENQ\EOT\f\STX\NUL\n\
    \\DC2\ETXy\EM/\n\
    \\f\n\
    \\ENQ\EOT\f\STX\NUL\n\
    \\DC2\ETXy%/\n\
    \\v\n\
    \\EOT\EOT\f\STX\SOH\DC2\ETXz\STX.\n\
    \\f\n\
    \\ENQ\EOT\f\STX\SOH\ACK\DC2\ETXz\STX\t\n\
    \\f\n\
    \\ENQ\EOT\f\STX\SOH\SOH\DC2\ETXz\n\
    \\DC1\n\
    \\f\n\
    \\ENQ\EOT\f\STX\SOH\ETX\DC2\ETXz\DC4\NAK\n\
    \\f\n\
    \\ENQ\EOT\f\STX\SOH\b\DC2\ETXz\SYN-\n\
    \\f\n\
    \\ENQ\EOT\f\STX\SOH\n\
    \\DC2\ETXz\ETB,\n\
    \\f\n\
    \\ENQ\EOT\f\STX\SOH\n\
    \\DC2\ETXz#,\n\
    \\v\n\
    \\EOT\EOT\f\STX\STX\DC2\ETX{\STX5\n\
    \\f\n\
    \\ENQ\EOT\f\STX\STX\EOT\DC2\ETX{\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\f\STX\STX\ACK\DC2\ETX{\v\DLE\n\
    \\f\n\
    \\ENQ\EOT\f\STX\STX\SOH\DC2\ETX{\DC1\CAN\n\
    \\f\n\
    \\ENQ\EOT\f\STX\STX\ETX\DC2\ETX{\ESC\FS\n\
    \\f\n\
    \\ENQ\EOT\f\STX\STX\b\DC2\ETX{\GS4\n\
    \\f\n\
    \\ENQ\EOT\f\STX\STX\n\
    \\DC2\ETX{\RS3\n\
    \\f\n\
    \\ENQ\EOT\f\STX\STX\n\
    \\DC2\ETX{*3\n\
    \\v\n\
    \\EOT\EOT\f\STX\ETX\DC2\ETX|\STX7\n\
    \\f\n\
    \\ENQ\EOT\f\STX\ETX\ENQ\DC2\ETX|\STX\b\n\
    \\f\n\
    \\ENQ\EOT\f\STX\ETX\SOH\DC2\ETX|\t\NAK\n\
    \\f\n\
    \\ENQ\EOT\f\STX\ETX\ETX\DC2\ETX|\CAN\EM\n\
    \\f\n\
    \\ENQ\EOT\f\STX\ETX\b\DC2\ETX|\SUB6\n\
    \\f\n\
    \\ENQ\EOT\f\STX\ETX\n\
    \\DC2\ETX|\ESC5\n\
    \\f\n\
    \\ENQ\EOT\f\STX\ETX\n\
    \\DC2\ETX|'5\n\
    \\v\n\
    \\EOT\EOT\f\STX\EOT\DC2\ETX}\STX:\n\
    \\f\n\
    \\ENQ\EOT\f\STX\EOT\ENQ\DC2\ETX}\STX\a\n\
    \\f\n\
    \\ENQ\EOT\f\STX\EOT\SOH\DC2\ETX}\b\SYN\n\
    \\f\n\
    \\ENQ\EOT\f\STX\EOT\ETX\DC2\ETX}\EM\SUB\n\
    \\f\n\
    \\ENQ\EOT\f\STX\EOT\b\DC2\ETX}\ESC9\n\
    \\f\n\
    \\ENQ\EOT\f\STX\EOT\n\
    \\DC2\ETX}\FS8\n\
    \\f\n\
    \\ENQ\EOT\f\STX\EOT\n\
    \\DC2\ETX}(8\n\
    \\v\n\
    \\EOT\EOT\f\STX\ENQ\DC2\ETX~\STX:\n\
    \\f\n\
    \\ENQ\EOT\f\STX\ENQ\ENQ\DC2\ETX~\STX\a\n\
    \\f\n\
    \\ENQ\EOT\f\STX\ENQ\SOH\DC2\ETX~\b\SYN\n\
    \\f\n\
    \\ENQ\EOT\f\STX\ENQ\ETX\DC2\ETX~\EM\SUB\n\
    \\f\n\
    \\ENQ\EOT\f\STX\ENQ\b\DC2\ETX~\ESC9\n\
    \\f\n\
    \\ENQ\EOT\f\STX\ENQ\n\
    \\DC2\ETX~\FS8\n\
    \\f\n\
    \\ENQ\EOT\f\STX\ENQ\n\
    \\DC2\ETX~(8\n\
    \\f\n\
    \\STX\EOT\r\DC2\ACK\129\SOH\NUL\131\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\r\SOH\DC2\EOT\129\SOH\b\CAN\n\
    \\f\n\
    \\EOT\EOT\r\STX\NUL\DC2\EOT\130\SOH\STX0\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\EOT\DC2\EOT\130\SOH\STX\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\ACK\DC2\EOT\130\SOH\v\SI\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\SOH\DC2\EOT\130\SOH\DLE\NAK\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\ETX\DC2\EOT\130\SOH\CAN\EM\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\b\DC2\EOT\130\SOH\SUB/\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\n\
    \\DC2\EOT\130\SOH\ESC.\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\n\
    \\DC2\EOT\130\SOH'.b\ACKproto3"