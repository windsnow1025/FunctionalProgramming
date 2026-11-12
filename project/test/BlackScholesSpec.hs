module BlackScholesSpec (spec) where

import Control.Monad (forM_)
import Test.Hspec

import BlackScholes
import Option
import Table1
import Within

spec :: Spec
spec =
  describe "blackScholes Put" $
    forM_ table1 $ \row ->
      it ("matches Table 1 for " ++ describeParams (params row)) $
        blackScholes Put (params row) `shouldSatisfy` within 0.0005 (european row)
