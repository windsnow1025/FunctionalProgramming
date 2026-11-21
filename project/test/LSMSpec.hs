module LSMSpec (spec) where

import Control.Monad (forM_)
import qualified Data.Vector.Unboxed as V
import System.Random (mkStdGen)
import Test.Hspec

import BlackScholes
import LSM
import Option
import Table1
import Within

spec :: Spec
spec = do
  describe "lsm Put with 10000 paths" $
    forM_ table1 $ \row -> do
      let optionParams = params row
      it ("is within 3 standard errors of blackScholes with 1 exercise date for " ++ describeParams optionParams) $ do
        let (price, standardError) = lsm Put optionParams 1 10000 (mkStdGen 1)
        price `shouldSatisfy` within (3 * standardError) (blackScholes Put optionParams)
  describe "estimatedOptionPrice Put" $
    it "matches the numerical example of Longstaff and Schwartz (2001)" $ do
      let (price, _) = estimatedOptionPrice Put (Params 1 1.1 0.06 undefined 3) 1 8 exampleStockPrices
      price `shouldSatisfy` within 0.00005 0.1144

-- | Stock prices of the 8 paths at times 1, 2, and 3.
exampleStockPrices :: [V.Vector Double]
exampleStockPrices =
  [ V.fromList [1.09, 1.16, 1.22, 0.93, 1.11, 0.76, 0.92, 0.88]
  , V.fromList [1.08, 1.26, 1.07, 0.97, 1.56, 0.77, 0.84, 1.22]
  , V.fromList [1.34, 1.54, 1.03, 0.92, 1.52, 0.90, 1.01, 1.34]
  ]
