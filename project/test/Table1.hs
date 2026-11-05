-- | Table 1 of Longstaff and Schwartz (2001).
module Table1 (table1) where

import Option

-- | Parameters and closed-form European put value.
table1 :: [(Params, Double)]
table1 =
  [ (Params 36 40 0.06 0.2 1, 3.844)
  , (Params 36 40 0.06 0.2 2, 3.763)
  , (Params 36 40 0.06 0.4 1, 6.711)
  , (Params 36 40 0.06 0.4 2, 7.700)
  , (Params 38 40 0.06 0.2 1, 2.852)
  , (Params 38 40 0.06 0.2 2, 2.991)
  , (Params 38 40 0.06 0.4 1, 5.834)
  , (Params 38 40 0.06 0.4 2, 6.979)
  , (Params 40 40 0.06 0.2 1, 2.066)
  , (Params 40 40 0.06 0.2 2, 2.356)
  , (Params 40 40 0.06 0.4 1, 5.060)
  , (Params 40 40 0.06 0.4 2, 6.326)
  , (Params 42 40 0.06 0.2 1, 1.465)
  , (Params 42 40 0.06 0.2 2, 1.841)
  , (Params 42 40 0.06 0.4 1, 4.379)
  , (Params 42 40 0.06 0.4 2, 5.736)
  , (Params 44 40 0.06 0.2 1, 1.017)
  , (Params 44 40 0.06 0.2 2, 1.429)
  , (Params 44 40 0.06 0.4 1, 3.783)
  , (Params 44 40 0.06 0.4 2, 5.202)
  ]
