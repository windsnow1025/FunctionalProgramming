-- | Option and market parameters shared by every pricer.
module Option (OptionType (..), Params (..), payoff) where

data OptionType = Call | Put

data Params = Params
  { spot     :: Double  -- ^ today's stock price S0
  , strike   :: Double  -- ^ strike price K
  , rate     :: Double  -- ^ risk-free interest rate r, per year
  , vol      :: Double  -- ^ volatility sigma, per year
  , maturity :: Double  -- ^ maturity T, in years
  }

-- | Immediate payoff g(S) of exercising at stock price s.
payoff :: OptionType -> Params -> Double -> Double
payoff Call params s = max (s - strike params) 0
payoff Put  params s = max (strike params - s) 0
