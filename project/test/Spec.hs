import Test.Hspec

import qualified BinomialTreeSpec
import qualified BlackScholesSpec

main :: IO ()
main = hspec $ do
  BinomialTreeSpec.spec
  BlackScholesSpec.spec
