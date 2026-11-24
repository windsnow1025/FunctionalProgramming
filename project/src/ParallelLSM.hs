-- | Parallel least-squares Monte Carlo method of Longstaff and Schwartz.
module ParallelLSM
  ( chunkGens
  ) where

import Data.List (unfoldr)
import System.Random (StdGen, split)

chunkGens :: Int -> StdGen -> [StdGen]
chunkGens chunks gen = take chunks (unfoldr (\g -> Just (split g)) gen)
