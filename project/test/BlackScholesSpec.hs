module BlackScholesSpec (spec) where

import Control.Monad (forM_)
import Test.Hspec

import BlackScholes
import Option
import Table1

spec :: Spec
spec =
  describe "blackScholes Put" $
    forM_ table1 $ \(params, european) ->
      it ("matches Table 1 for " ++ describeParams params) $
        blackScholes Put params `shouldSatisfy` roundsTo european

describeParams :: Params -> String
describeParams params =
  "S0 = " ++ show (spot params) ++
  ", sigma = " ++ show (vol params) ++
  ", T = " ++ show (maturity params)

roundsTo :: Double -> Double -> Bool
roundsTo published price = abs (price - published) <= 0.0005
