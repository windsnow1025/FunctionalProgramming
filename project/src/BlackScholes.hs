-- | Closed-form price of a European option under the Black-Scholes model.
module BlackScholes (blackScholes) where

import Data.Number.Erf (normcdf)

import Option

blackScholes :: OptionType -> Params -> Double
blackScholes optionType (Params s0 k r sigma t) = case optionType of
  -- W(S(0)) = S(0) Φ(d₁) - K e^(-rT) Φ(d₂)
  Call -> s0 * normcdf d1 - discountedStrike * normcdf d2
  -- W(S(0)) = K e^(-rT) Φ(-d₂) - S(0) Φ(-d₁)
  Put  -> discountedStrike * normcdf (-d2) - s0 * normcdf (-d1)
  where
    -- d₁ = (ln(S(0) / K) + (r + σ² / 2) T) / (σ √T)
    d1 = (log (s0 / k) + (r + sigma * sigma / 2) * t) / (sigma * sqrt t)
    -- d₂ = d₁ - σ √T
    d2 = d1 - sigma * sqrt t
    -- K e^(-rT)
    discountedStrike = k * exp (-r * t)
