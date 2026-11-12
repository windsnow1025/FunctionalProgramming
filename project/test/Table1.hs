-- | Table 1 of Longstaff and Schwartz (2001).
module Table1 (Row (..), table1, describeParams) where

import Option

data Row = Row
  { params   :: Params
  , european :: Double  -- ^ closed-form European put value
  , american :: Double  -- ^ finite-difference American put value
  }

table1 :: [Row]
table1 =
  [ Row (Params 36 40 0.06 0.2 1) 3.844 4.478
  , Row (Params 36 40 0.06 0.2 2) 3.763 4.840
  , Row (Params 36 40 0.06 0.4 1) 6.711 7.101
  , Row (Params 36 40 0.06 0.4 2) 7.700 8.508
  , Row (Params 38 40 0.06 0.2 1) 2.852 3.250
  , Row (Params 38 40 0.06 0.2 2) 2.991 3.745
  , Row (Params 38 40 0.06 0.4 1) 5.834 6.148
  , Row (Params 38 40 0.06 0.4 2) 6.979 7.670
  , Row (Params 40 40 0.06 0.2 1) 2.066 2.314
  , Row (Params 40 40 0.06 0.2 2) 2.356 2.885
  , Row (Params 40 40 0.06 0.4 1) 5.060 5.312
  , Row (Params 40 40 0.06 0.4 2) 6.326 6.920
  , Row (Params 42 40 0.06 0.2 1) 1.465 1.617
  , Row (Params 42 40 0.06 0.2 2) 1.841 2.212
  , Row (Params 42 40 0.06 0.4 1) 4.379 4.582
  , Row (Params 42 40 0.06 0.4 2) 5.736 6.248
  , Row (Params 44 40 0.06 0.2 1) 1.017 1.110
  , Row (Params 44 40 0.06 0.2 2) 1.429 1.690
  , Row (Params 44 40 0.06 0.4 1) 3.783 3.948
  , Row (Params 44 40 0.06 0.4 2) 5.202 5.647
  ]

describeParams :: Params -> String
describeParams optionParams =
  "S0 = " ++ show (spot optionParams) ++
  ", sigma = " ++ show (vol optionParams) ++
  ", T = " ++ show (maturity optionParams)
