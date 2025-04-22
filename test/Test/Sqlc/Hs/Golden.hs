module Test.Sqlc.Hs.Golden where

import Control.Exception (throwIO)
import Data.ByteString qualified
import Data.ProtoLens qualified
import Data.ProtoLens.Labels ()
import Proto.Protos.Codegen qualified
import System.Exit (ExitCode (..))
import System.FilePath (dropExtension, replaceExtension, (</>))
import System.IO qualified
import System.Process.ByteString qualified
import Test.Tasty (TestTree)
import Test.Tasty.Golden (createDirectoriesAndWriteFile, findByExtension, goldenVsString)

test_golden :: IO [TestTree]
test_golden = do
  inputs <- findByExtension [".input"] "test/golden"
  pure $
    inputs <&> \input -> do
      goldenVsString
        input
        (input `replaceExtension` ".output")
        ( do
            message <-
              Data.ByteString.readFile input

            message <-
              case Data.ProtoLens.readMessage @Proto.Protos.Codegen.GenerateRequest (toLazy (decodeUtf8 message)) of
                Left errorMessage ->
                  error (toText errorMessage)
                Right message ->
                  pure message

            (exitCode, stdout, stderr) <-
              System.Process.ByteString.readProcessWithExitCode
                "sqlc-hs"
                []
                (Data.ProtoLens.encodeMessage message)

            Data.ByteString.hPut System.IO.stderr stderr

            unless (exitCode == ExitSuccess) $
              throwIO exitCode

            message <-
              case Data.ProtoLens.decodeMessage @Proto.Protos.Codegen.GenerateResponse stdout of
                Left errorMessage ->
                  error (toText errorMessage)
                Right message ->
                  pure message

            -- To ease debugging we write out the files as proper files too.
            for_ (message ^. #files) $ \file -> do
              let outputFile = dropExtension input </> toString (file ^. #name)
              createDirectoriesAndWriteFile outputFile (toLazy (file ^. #contents))

            pure $
              encodeUtf8 $
                unlines $
                  concat
                    [ [ file ^. #name,
                        "",
                        decodeUtf8 (file ^. #contents),
                        ""
                      ]
                      | file <- message ^. #files
                    ]
        )
