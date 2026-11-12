module Within (within) where

within :: Double -> Double -> Double -> Bool
within tolerance reference price = abs (price - reference) <= tolerance
