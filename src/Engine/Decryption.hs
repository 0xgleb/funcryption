module Engine.Decryption where

import           Data.List (foldl')
import           Data.Text (Text)
import qualified Data.Text as T

-- | inverse function of encryptStep
decryptStep :: Text -> Text
decryptStep text =
  ifOdd T.init
    $ foldl' (\p (l, r) -> p `T.snoc` r `T.snoc` l) T.empty
    $ T.zip (ifOdd (flip T.snoc ' ') $ T.take half text) (T.drop half text)
  where len = T.length text
        odd = len `mod` 2 == 1
        half = len `div` 2
        ifOdd f x = if odd then f x else x

-- | call @decryptStep@ n times to decrypt text
-- that was encrypted with the encryption algorithm n times
decrypt :: Text -> Integer -> Text
decrypt text n
  | n <= 0 = text
  | otherwise = decrypt (decryptStep text) (n - 1)
