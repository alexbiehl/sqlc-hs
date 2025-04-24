module Test.Sqlc.Hs.Golden where

import Data.ByteString qualified
import Data.ProtoLens qualified
import Data.ProtoLens.Labels ()
import Proto.Protos.Codegen qualified
import System.Directory qualified
import System.Exit (ExitCode (..))
import System.FilePath (dropExtension, (</>))
import System.IO qualified
import System.IO.Error qualified
import System.IO.Temp qualified
import System.Process qualified
import System.Process.ByteString qualified
import Test.Tasty (TestTree, withResource)
import Test.Tasty.Golden (createDirectoriesAndWriteFile, findByExtension)
import Test.Tasty.Golden.Advanced (goldenTest)

test_golden :: IO [TestTree]
test_golden = do
  inputs <- findByExtension [".input"] "test/golden"
  pure $
    inputs <&> \input ->
      withResource
        ( do
            tmpdir <- System.IO.Temp.getCanonicalTemporaryDirectory
            System.IO.Temp.createTempDirectory tmpdir "sqlc-hs-test"
        )
        ( \tmpdir ->
            System.IO.Error.catchIOError
              (System.Directory.removeDirectoryRecursive tmpdir)
              (\_ -> pure ())
        )
        $ \createTestDirectory ->
          let goldenDirectory :: FilePath
              goldenDirectory =
                dropExtension input
           in goldenTest
                input
                ( do
                    -- Listing a non-existing directory throws an exception such
                    -- that tasty-golden registers the test as new and just accepts
                    -- the output.
                    _ <- System.Directory.listDirectory goldenDirectory
                    pure goldenDirectory
                )
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
                      error "sqlc-hs failed with an non-zero exit-code"

                    message <-
                      case Data.ProtoLens.decodeMessage @Proto.Protos.Codegen.GenerateResponse stdout of
                        Left errorMessage ->
                          error (toText errorMessage)
                        Right message ->
                          pure message

                    testDirectory <- createTestDirectory

                    -- To ease debugging we write out the files as proper files too.
                    for_ (message ^. #files) $ \file -> do
                      let outputFile = testDirectory </> toString (file ^. #name)
                      createDirectoriesAndWriteFile outputFile (toLazy (file ^. #contents))

                    pure testDirectory
                )
                ( \a b -> do
                    (_exitCode, stdout, _stderr) <-
                      System.Process.readProcessWithExitCode "diff" ["--recursive", a, b] ""
                    case stdout of
                      "" ->
                        pure Nothing
                      stdout ->
                        pure (Just stdout)
                )
                ( \testDirectory -> do
                    -- Delete the goldenDirectory first to avoid any leftover dangling files.
                    System.IO.Error.catchIOError
                      (System.Directory.removeDirectoryRecursive goldenDirectory)
                      (\_ -> pure ())

                    System.Directory.renameDirectory testDirectory goldenDirectory
                )
