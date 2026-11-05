-- | Closed-form price of a European option under the Black-Scholes model.
module BlackScholes (blackScholes) where

import Data.Number.Erf (normcdf)
import Option

blackScholes :: OptionType -> Params -> Double
blackScholes optionType (Params s0 k r sigma t) = case optionType of
  Call -> s0 * normcdf d1 - discountedStrike * normcdf d2
  Put  -> discountedStrike * normcdf (-d2) - s0 * normcdf (-d1)
  where
    d1 = (log (s0 / k) + (r + sigma * sigma / 2) * t) / (sigma * sqrt t)
    d2 = d1 - sigma * sqrt t
    discountedStrike = k * exp (-r * t)
