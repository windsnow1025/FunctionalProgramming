module Main (main) where

import System.Random (mkStdGen)

import BinomialTree
import BlackScholes
import LSM
import Option

main :: IO ()
main = do
  putStrLn ("blackScholes: " ++ show (blackScholes Put params))
  putStrLn ("binomialTree: " ++ show (binomialTree Put params exerciseDates stepsPerDate))
  putStrLn ("lsm: " ++ show (lsm Put params exerciseDates paths (mkStdGen seed)))
  where
    params = Params 36 40 0.06 0.2 1
    exerciseDates = 50
    stepsPerDate = 40
    paths = 100000
    seed = 1
