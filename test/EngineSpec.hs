{-# LANGUAGE OverloadedStrings #-}

module EngineSpec (main, spec) where

import           Data.Text
import           Data.Text.Arbitrary
import           Test.Hspec
import           Test.QuickCheck

import           Engine

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
    describe "Engine.Encryption.encrypt and Engine.Decryption.decrypt" $ do
        it "has property `decrypt (encrypt t n) n == t`" $ do
            property $ \t n -> decrypt (encrypt t n) n === t
        it "has property `encrypt (decrypt t n) n == t`" $ do
            property $ \t n -> encrypt (decrypt t n) n === t
