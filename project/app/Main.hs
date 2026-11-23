module Main (main) where

import Control.Monad (forM_)
import System.Environment (getArgs)
import System.Random (mkStdGen)

import BinomialTree
import BlackScholes
import LSM
import Option

main :: IO ()
main = do
  args <- getArgs
  let names = if null args then ["blackScholes", "binomialTree", "lsm"] else args
  forM_ names (\name -> putStrLn (name ++ ": " ++ price name))
  where
    price "blackScholes" = show (blackScholes Put params)
    price "binomialTree" = show (binomialTree Put params exerciseDates stepsPerDate)
    price "lsm" = show (lsm Put params exerciseDates paths (mkStdGen seed))
    price name = error ("unknown algorithm: " ++ name)

    params = Params 36 40 0.06 0.2 1
    exerciseDates = 50
    stepsPerDate = 40
    paths = 100000
    seed = 1
