-- | Price of an option on a Cox-Ross-Rubinstein binomial tree.
module BinomialTree (binomialTree) where

import qualified Data.Vector.Unboxed as V

import Option

binomialTree :: OptionType -> Params -> Int -> Int -> Double
binomialTree optionType params@(Params s0 _ r sigma t) exerciseDates stepsPerDate =
  -- W₀(S(0)), from Wₙ(S) = g(S)
  V.head (foldl' stepBack (exerciseValues n) [n - 1, n - 2 .. 0])
  where
    -- n = M m
    n = exerciseDates * stepsPerDate
    -- Δt = T / n
    dt = t / fromIntegral n
    -- u = e^(σ √Δt)
    u = exp (sigma * sqrt dt)
    -- d = 1 / u
    d = 1 / u
    -- p = (e^(rΔt) - d) / (u - d)
    p = (exp (r * dt) - d) / (u - d)
    -- e^(-rΔt)
    discount = exp (-r * dt)

    -- g(S(kΔt)) for j = 0, ..., k, S(kΔt) = S(0) u^(2j - k)
    exerciseValues k = V.generate (k + 1) $ \j -> payoff optionType params (s0 * u ^^ (2 * j - k))

    -- Wₖ(S) = max(g(S), Cₖ(S)) if k > 0 and m divides k
    -- Wₖ(S) = Cₖ(S)            otherwise
    stepBack values k
      | k > 0 && k `mod` stepsPerDate == 0 = V.zipWith max (exerciseValues k) continuationValues
      | otherwise = continuationValues
      where
        continuationValues = V.zipWith continuationValue (V.tail values) values

    -- Cₖ(S) = e^(-rΔt) (p Wₖ₊₁(Su) + (1 - p) Wₖ₊₁(Sd))
    continuationValue upValue downValue = discount * (p * upValue + (1 - p) * downValue)
