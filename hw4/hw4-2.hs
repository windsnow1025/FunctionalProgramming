import Control.Parallel(par, pseq)
import System.Environment(getArgs)

nfib4 :: Int -> Int -> Integer
nfib4 0 n = nfib n
nfib4 _ n | n < 2 = 1
nfib4 d n = nf1 `par` nf2 `pseq` nf1 + nf2 + 1
  where nf1 = nfib4 (d-1) (n-1)
        nf2 = nfib4 (d-1) (n-2)

nfib :: Int -> Integer
nfib n | n < 2 = 1
nfib n = nfib (n-1) + nfib (n-2) + 1

main :: IO ()
main = do
  [d] <- getArgs
  print (nfib4 (read d) 40)
