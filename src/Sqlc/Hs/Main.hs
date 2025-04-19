module Sqlc.Hs.Main (main) where

import Data.ByteString qualified
import Data.ProtoLens qualified
import Data.ProtoLens.Labels ()
import Proto.Protos.Codegen qualified
import Sqlc.Hs.Codegen qualified
import Sqlc.Hs.Config qualified
import System.Directory qualified
import System.Exit qualified
import System.FilePath qualified
import System.IO qualified

main :: IO ()
main = do
  contents <- Data.ByteString.getContents

  args <- getArgs

  let testMode :: Maybe FilePath
      testMode =
        case args of
          "--out" : out : _ -> Just out
          _ -> Nothing

  generateRequest <-
    case Data.ProtoLens.decodeMessage @Proto.Protos.Codegen.GenerateRequest contents of
      Left errorMessage -> do
        System.IO.hPutStrLn System.IO.stderr errorMessage
        System.Exit.exitWith (System.Exit.ExitFailure 1)
      Right generateRequest ->
        pure generateRequest

  -- System.IO.hPutStrLn System.IO.stdout (show $ generateRequest)

  pluginOptions <-
    case Sqlc.Hs.Config.parseConfig (generateRequest ^. #pluginOptions) of
      Left errorMessage -> do
        System.IO.hPutStrLn System.IO.stderr errorMessage
        System.Exit.exitWith (System.Exit.ExitFailure 1)
      Right config ->
        pure config

  globalOptions <-
    case Sqlc.Hs.Config.parseConfig (generateRequest ^. #globalOptions) of
      Left errorMessage -> do
        System.IO.hPutStrLn System.IO.stderr errorMessage
        System.Exit.exitWith (System.Exit.ExitFailure 1)
      Right config ->
        pure config

  let -- Rule: Plugin config > Global config > Default config
      mergedConfig =
        pluginOptions <> globalOptions <> Sqlc.Hs.Config.defaultConfig

  files <-
    Sqlc.Hs.Codegen.codegen mergedConfig generateRequest

  whenJust testMode $ \outDirectory -> do
    for_ files $ \file -> do
      let filepath = outDirectory <> "/" <> toString file.name
      System.Directory.createDirectoryIfMissing True (System.FilePath.takeDirectory filepath)
      Data.ByteString.writeFile filepath file.contents

  whenNothing_ testMode $ do
    let generateResponse :: Proto.Protos.Codegen.GenerateResponse
        generateResponse =
          Data.ProtoLens.defMessage
            & #files
            .~ fromList
              [ Data.ProtoLens.defMessage
                  & (#name .~ file.name)
                  & (#contents .~ file.contents)
                | file <- files
              ]

    Data.ByteString.putStr
      (Data.ProtoLens.encodeMessage generateResponse)
