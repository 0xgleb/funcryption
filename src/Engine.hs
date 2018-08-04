module Engine where

import           Data.Text (Text)
import qualified Data.Text as T

encryptStep :: Text -> Text
encryptStep = (\(_, left, right) -> left `T.append` right) . T.foldl' op (True, T.empty, T.empty)
  where op (cond, left, right) x =
          if cond then (not cond, left, right `T.snoc` x)
                  else (not cond, left `T.snoc` x, right)

encrypt :: Text -> Integer -> Text
encrypt l n
  | n <= 0 = l
  | otherwise = encrypt (encryptStep l) (n - 1)