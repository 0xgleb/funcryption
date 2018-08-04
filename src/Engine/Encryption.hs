module Engine.Encryption where

import           Data.Text (Text)
import qualified Data.Text as T

-- | perform the encryption algorithm once
encryptStep :: Text -> Text
encryptStep = (\(_, left, right) -> left `T.append` right) . T.foldl' op (True, T.empty, T.empty)
  where op (cond, left, right) x =
          if cond then (not cond, left, right `T.snoc` x)
                  else (not cond, left `T.snoc` x, right)

-- | perform the encryption algorithm n times by calling @encryptStep@ n times
encrypt :: Text -> Integer -> Text
encrypt text n
  | n <= 0 = text
  | otherwise = encrypt (encryptStep text) (n - 1)
