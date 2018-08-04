{-# LANGUAGE OverloadedStrings #-}

module Engine.DecryptionSpec (main, spec) where

import           Data.Text
import           Data.Text.Arbitrary
import           Test.Hspec
import           Test.QuickCheck

import           Engine.Decryption

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
    describe "decryptStep" $ do
        it "splits the given text in half and then combines them, making characters from the first half even characters and characters from the second odd" $ do
            decryptStep "hsi  etTi sats!" `shouldBe` "This is a test!"
            decryptStep "" `shouldBe` ""
            decryptStep "2413" `shouldBe` "1234"
            decryptStep "24135" `shouldBe` "12345"
    describe "decrypt" $ do
        context "if the given integer is less than or equal to 0" $ do
            it "returns the given text" $ do
                property $ \t n -> decrypt t (- abs n) === t
        context "otherwise" $ do
            it "performs decryptStep the given number of times" $ do
                property $ \t i -> let n = abs i in decrypt t (n + 1) === decryptStep (decrypt t n)
            it "applies the decryption algorithm the given number of times" $ do
                decrypt "s eT ashi tist!" 2 `shouldBe` "This is a test!"
                decrypt "" 10 `shouldBe` ""
                decrypt "4321" 2 `shouldBe` "1234"
                decrypt "31425" 3 `shouldBe` "12345"
