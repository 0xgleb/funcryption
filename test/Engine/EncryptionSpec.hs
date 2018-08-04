{-# LANGUAGE OverloadedStrings #-}

module Engine.EncryptionSpec (main, spec) where

import           Data.Text
import           Data.Text.Arbitrary
import           Test.Hspec
import           Test.QuickCheck

import           Engine.Encryption

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
    describe "encryptStep" $ do
        it "takes every second character from a text, then the other characters and concats them as a new text" $ do
            encryptStep "This is a test!" `shouldBe` "hsi  etTi sats!"
            encryptStep "" `shouldBe` ""
            encryptStep "1234" `shouldBe` "2413"
            encryptStep "12345" `shouldBe` "24135"
    describe "encrypt" $ do
        context "if the given integer is less than or equal to 0" $ do
            it "returns the given text" $ do
                property $ \t n -> encrypt t (- abs n) === t
        context "otherwise" $ do
            it "performs encryptStep the given number of times" $ do
                property $ \t i -> let n = abs i in encrypt t (n + 1) === encryptStep (encrypt t n)
            it "applies the encryption algorithm the given number of times" $ do
                encrypt "This is a test!" 2 `shouldBe` "s eT ashi tist!"
                encrypt "" 10 `shouldBe` ""
                encrypt "1234" 2 `shouldBe` "4321"
                encrypt "12345" 3 `shouldBe` "31425"
