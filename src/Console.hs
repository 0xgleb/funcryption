module Console (console) where

import           Control.Monad.Except
import qualified Data.Text            as T
import           Safe
import           System.IO

import           Engine

prompt :: String -> ExceptT Error IO String
prompt str = liftIO $ do
    putStr str
    hFlush stdout
    getLine

data Action = Encrypt | Decrypt deriving (Show, Read)

newtype Error = Error { unError :: String }

validate :: Read a => Error -> String -> ExceptT Error IO a
validate error input = maybe (throwError error) return $ readMay input

app :: ExceptT Error IO ()
app = do
    action <- validate (Error "Invalid action!")
              =<< prompt ( "Enter an action ("
                        ++ show Encrypt
                        ++ " or "
                        ++ show Decrypt
                        ++ "): "
                         )

    input <- T.pack <$> prompt ("Enter text: ")
    n <- validate (Error "Invalid integer!")
         =<< prompt ("Enter how many times you want to run the algorithm: ")
    case action of
      Encrypt -> liftIO $ putStrLn $ T.unpack $ encrypt input n
      Decrypt -> liftIO $ putStrLn $ T.unpack $ decrypt input n

console :: IO ()
console = either (putStrLn . unError) return =<< runExceptT app

