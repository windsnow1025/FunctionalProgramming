module Main (main) where

import System.Random (mkStdGen)

import LSM
import Option

main :: IO ()
main = print (lsm Put params exerciseDates paths (mkStdGen seed))
  where
    params = Params 36 40 0.06 0.2 1
    exerciseDates = 50
    paths = 100000
    seed = 1
