module BinomialTreeSpec (spec) where

import Control.Monad (forM_)
import Test.Hspec

import BinomialTree
import BlackScholes
import Option
import Table1
import Within

spec :: Spec
spec =
  describe "binomialTree Put with 2000 steps per year" $
    forM_ table1 $ \row -> do
      let optionParams = params row
          years = round (maturity optionParams) :: Int
      it ("matches blackScholes with 1 exercise date for " ++ describeParams optionParams) $
        binomialTree Put optionParams 1 (2000 * years)
          `shouldSatisfy` within 0.001 (blackScholes Put optionParams)
      it ("matches Table 1 with 50 exercise dates per year for " ++ describeParams optionParams) $
        binomialTree Put optionParams (50 * years) 40
          `shouldSatisfy` within 0.01 (american row)
