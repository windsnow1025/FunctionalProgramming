-- | Least-squares Monte Carlo method of Longstaff and Schwartz.
module LSM
  ( nextStockPrice
  , standardNormalRows
  , stockPrices
  , regressionCoefficients
  , estimatedContinuationValue
  , decide
  , stepBack
  , estimatedOptionPrice
  , lsm
  ) where

import Control.Monad (replicateM)
import Data.List (scanl')
import qualified Data.Vector.Unboxed as V
import Linear (V3 (..), inv33, (!*))
import System.Random (StdGen)
import System.Random.MWC.Distributions (standard)
import System.Random.Stateful (runStateGen_)

import Option

nextStockPrice :: Params -> Double -> Double -> Double -> Double
-- S(t + Δt) = S(t) e^((r - σ² / 2) Δt + σ √Δt Z)
nextStockPrice (Params _ _ r sigma _) dt s z = s * exp ((r - sigma * sigma / 2) * dt + sigma * sqrt dt * z)

standardNormalRows :: Int -> Int -> StdGen -> [V.Vector Double]
-- Z for every step and path
standardNormalRows steps paths gen = runStateGen_ gen (\stateGen -> replicateM steps (V.replicateM paths (standard stateGen)))

stockPrices :: Params -> Double -> Int -> [V.Vector Double] -> [V.Vector Double]
-- Sᵢ(t) for t = Δt, ..., T
stockPrices params dt paths zRows = drop 1 (scanl' nextStockPrices initialStockPrices zRows)
  where
    -- Sᵢ(0) = S(0)
    initialStockPrices = V.replicate paths (spot params)
    -- Sᵢ(t + Δt) from Sᵢ(t)
    nextStockPrices sRow zRow = V.zipWith (\s z -> nextStockPrice params dt s z) sRow zRow

regressionCoefficients :: V.Vector Double -> V.Vector Double -> V3 Double
-- [ |I|   Σxᵢ   Σxᵢ² ] [ θ̂₀ ]   [ ΣVᵢ     ]
-- [ Σxᵢ   Σxᵢ²  Σxᵢ³ ] [ θ̂₁ ] = [ Σxᵢ Vᵢ  ]
-- [ Σxᵢ²  Σxᵢ³  Σxᵢ⁴ ] [ θ̂₂ ]   [ Σxᵢ² Vᵢ ]
regressionCoefficients xs vs = inv33 matrix !* rightSide
  where
    matrix =
      V3
        (V3 (sumX 0) (sumX 1) (sumX 2))
        (V3 (sumX 1) (sumX 2) (sumX 3))
        (V3 (sumX 2) (sumX 3) (sumX 4))
    rightSide = V3 (sumXV 0) (sumXV 1) (sumXV 2)
    sumX :: Int -> Double
    sumX power = V.sum (V.map (\x -> x ^ power) xs)
    sumXV :: Int -> Double
    sumXV power = V.sum (V.zipWith (\x v -> x ^ power * v) xs vs)

estimatedContinuationValue :: Params -> V3 Double -> Double -> Double
-- Ĉ(S) = θ̂₀ + θ̂₁ x + θ̂₂ x², x = S / K
estimatedContinuationValue params (V3 theta0 theta1 theta2) s = theta0 + theta1 * x + theta2 * x * x
  where
    x = s / strike params

decide :: OptionType -> Params -> V3 Double -> Double -> Double -> Double
-- Vᵢ ← g(Sᵢ(t)) if i ∈ I and g(Sᵢ(t)) > Ĉ(Sᵢ(t))
decide optionType params coefficients s v
  | g > 0 && g > estimatedContinuationValue params coefficients s = g
  | otherwise = v
  where
    g = payoff optionType params s

stepBack :: OptionType -> Params -> Double -> V.Vector Double -> V.Vector Double -> V.Vector Double
-- Vᵢ at time t from Vᵢ at time t + Δt
stepBack optionType params dt vRow sRow
  | V.length inTheMoney < 3 = discountedVRow
  | otherwise = V.zipWith (\s v -> decide optionType params coefficients s v) sRow discountedVRow
  where
    -- Vᵢ ← e^(-rΔt) Vᵢ
    discountedVRow = V.map (\v -> exp (-rate params * dt) * v) vRow
    -- I = {i : g(Sᵢ(t)) > 0}
    inTheMoney = V.filter (\(s, _) -> payoff optionType params s > 0) (V.zip sRow discountedVRow)
    -- xᵢ = Sᵢ(t) / K
    xs = V.map (\(s, _) -> s / strike params) inTheMoney
    vs = V.map (\(_, v) -> v) inTheMoney
    coefficients = regressionCoefficients xs vs

estimatedOptionPrice :: OptionType -> Params -> Double -> Int -> [V.Vector Double] -> (Double, Double)
-- (Ŵ(S(0)), SE)
estimatedOptionPrice optionType params dt paths sRows = (price, standardError)
  where
    -- Vᵢ = g(Sᵢ(T))
    maturityVRow = V.map (\s -> payoff optionType params s) (last sRows)
    -- Vᵢ at time Δt
    firstVRow = foldl' (\vRow sRow -> stepBack optionType params dt vRow sRow) maturityVRow (reverse (init sRows))
    -- Yᵢ = e^(-rΔt) Vᵢ
    yRow = V.map (\v -> exp (-rate params * dt) * v) firstVRow
    -- Ŵ(S(0)) = (1 / N) ΣYᵢ
    price = V.sum yRow / fromIntegral paths
    -- SE = (1 / √N) √((1 / (N - 1)) Σ(Yᵢ - Ŵ(S(0)))²)
    standardError = sqrt (V.sum (V.map (\y -> (y - price) * (y - price)) yRow) / fromIntegral (paths - 1)) / sqrt (fromIntegral paths)

lsm :: OptionType -> Params -> Int -> Int -> StdGen -> (Double, Double)
lsm optionType params exerciseDates paths gen = estimatedOptionPrice optionType params dt paths sRows
  where
    -- n = M
    n = exerciseDates
    -- Δt = T / n
    dt = maturity params / fromIntegral n
    zRows = standardNormalRows n paths gen
    sRows = stockPrices params dt paths zRows
