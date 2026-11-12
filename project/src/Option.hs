-- | Option and market parameters shared by every pricer.
module Option (OptionType (..), Params (..), payoff) where

data OptionType = Call | Put

data Params = Params
  { spot     :: Double  -- ^ today's stock price S(0)
  , strike   :: Double  -- ^ strike price K
  , rate     :: Double  -- ^ risk-free interest rate r, per year
  , vol      :: Double  -- ^ volatility σ, per year
  , maturity :: Double  -- ^ maturity T, in years
  }

-- | Immediate payoff g(S) of exercising at stock price S.
payoff :: OptionType -> Params -> Double -> Double
-- g(S) = max(S - K, 0)
payoff Call params s = max (s - strike params) 0
-- g(S) = max(K - S, 0)
payoff Put  params s = max (strike params - s) 0
