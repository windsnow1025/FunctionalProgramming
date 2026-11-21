import Test.Hspec

import qualified BinomialTreeSpec
import qualified BlackScholesSpec
import qualified LSMSpec

main :: IO ()
main = hspec $ do
  BinomialTreeSpec.spec
  BlackScholesSpec.spec
  LSMSpec.spec
