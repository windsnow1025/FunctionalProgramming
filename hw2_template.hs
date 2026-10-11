import Data.Word

-- You may import other libraries for this assignment; do so here

{-

 Name:
 Uni:

 ------------------------------

 COMS 4995 001 Parallel Function Programming

 Homework 2

 Due at 11:59 PM Sunday, October 11, 2026

 Modify this file with your solutions and submit it on Courseworks.
 If you used AI for this assignment, save your chat logs in PDF form
 and upload them, too.

 You may use functions, etc. from the Standard Prelude or other
 external libraries with the exception of those that operate on the
 Integer type (details below)

 Do not modify the type signatures for any of the provided functions.

 Above, include your name and UNI

 Please do not delete or modify any of the block comments below (i.e.,
 {- -} comments) as we use them to identify where your solutions begin and end.

 Feel free to add and delete single-line comments (i.e., --)

 Please don't write any separate top-level helper functions.  If you need an
 additional function, make it local to the function or value of the
 problem in a let or where clause.

 -----

 Use lts-24.57 as the "resolver" for the Haskell Tool Stack.
 E.g., stack --resolver lts-24.57 ghci

 Your code should load under GHCi 9.10.3 with no warnings under -Wall, e.g.
 :set -Wall
 :l hw2

 ==============================

 In the first nine problems of this assignment, you will implement an
 infinite precision integer arithemtic class called "Int100" that uses
 lists of Word8 (unsigned bytes) to represent integers in base 100 (to
 simplify decimal printing)

 Each list of Word8 digits consists of at least one digit and the last
 element -- the most significant digit -- must be non-zero.

 E.g.,

 IntP [0,2] represents 200
 IntN [5]   represents -5
 IntZ       represents 0
 IntP []    is illegal (must have at least one digit)
 IntN [0]   is illegal (last element most be non-zero)
 IntP [1,0] is illegal (last element must be non-zero)
 IntP [100] is illegal (digits must be in [0..99])

 Because this is close to the functionality of the Integer type supplied
 with Haskell, you may only use functions that use the Integer type
 in the first problem, which converts a number supplied as an Integer
 into an Int100.

-}

data Int100 = IntP [Word8]
            | IntN [Word8]
            | IntZ
    deriving Eq

{- 1) Write the toInt100 function, which converts an
      Integer to an Int100

      E.g.,

      toInt100 0 = IntZ
      toInt100 (-1) = IntN [1]
      toInt100 99 = IntP [99]
      toInt100 100 = IntP [0,1]
      toInt100 (-199) = IntN [99,1]

   For this problem only, you may use standard library functions
   that operate on the Integer type.
-}


toInt100 :: Integer -> Int100
toInt100 _ = IntZ -- Change this

{- 2) Write an instance of Show (just the show function)
      for the Int100 type.  You may assume the Int100 object
      is not illegal (e.g., normalized).

      E.g., 

      show IntZ         = "0"
      show (IntP [3,4]) = "403"
      show (IntN [42])  = "-42

      Do not use any standard library functions that operate on
      the Integer type in your solution.
-}

instance Show Int100 where
  show IntZ = "IntZ"                -- Change this
  show (IntP l) = "IntP " ++ show l -- Change this
  show (IntN l) = "IntN " ++ show l -- Change this
         
{- 3) Write a function addDigits that adds two positive integers
      represented as lists in base-100 form, LSD first (e.g., as in an Int100).
      Assume every list element is in [0..99] and that the last element, if
      any, is non-zero.

      Your function should produce a list whose last element is non-zero
      or the empty list.

      E.g.,

      addDigits [] [] = []
      addDigits [] [1,2,3]  = [1,2,3]
      addDigits [99,1] [1]  = [0,2]
      addDigits [99,99] [1] = [0,0,1]
      addDigits [99,99,99] [99,99] = [98,99,0,1]

      Do not use any standard library functions that operate on
      the Integer type in your solution.
-}
addDigits :: [Word8] -> [Word8] -> [Word8]
addDigits _ _ = [] -- Change this

{- 4) Write a function subDigits that subtracts the second positive
      integer from the first.  Assume both numbers are in base-100 form,
      the last element, if any, is non-zero, and that the
      first number is greater or equal to the second (i.e., that the result
      is non-negative)

      Your function should produce a list in base-100 form, i.e.,
      each list element is in [0..99] and the last list element, if any,
      is non-zero.

      E.g.,

      subDigits [] [] = []
      subDigits [1,2,3,4] [1,2,3,4] = []
      subDigits [1,2,3,4] [0,2,3,4] = [1]
      subDigits [0,0,0,0,1] [1] = [99,99,99,99]
      subDigits [0,0,0,1] [0,1] = [0,99,99]
      subDigits [99,99,0,99] [1,10,1,1] = [98,89,99,97]

      Do not use any standard library functions that operate on
      the Integer type in your solution.
-}
subDigits :: [Word8] -> [Word8] -> [Word8]
subDigits _ _ = [] -- Change this

{- 5) Write a function multDigit that multiplies a positive base-100 integer
      by an integer in the range [0..99].  Assume the last element of the
      base-100 list is non-zero and that the input integer is in the range
      [0..99]    

      E.g.,

      multDigit 0 [42] = []
      multDigit 1 [1,2,3] = [1,2,3]
      multDigit 2 [1,2,3] = [2,4,6]
      multDigit 99 [99,99,99] = [1,99,99,98]

      The core multiplcation operation in your solution may use
      Int, Word8, Word16, or similar standard number types but not Integer.

      Do not use any standard library functions that operate on
      the Integer type in your solution.
-}
multDigit :: Word8 -> [Word8] -> [Word8]
multDigit _ _ = [] -- Change this

{- 6) Write a function multDigits that multiplies two positive base-100
      integers.  You may use multDigit and addDigits.

      E.g.,

      multDigits [] [1,2,3] = []
      multDigits [1,2,3] [] = []
      multDigits [1] [99,98,97] = [99,98,97]
      multDigits [0,1] [99,98,97] = [0,99,98,97]
      multDigits [0,2] [99,98,97] = [0,98,97,95,1]
      multDigits [99,99,99] [99,99,99] = [1,0,0,98,99,99]

      Do not use any standard library functions that operate on
      the Integer type in your solution.
-}
multDigits :: [Word8] -> [Word8] -> [Word8]
multDigits _ _ = [] -- Change this

{- 7) Write a function compare100 that compares the magnitude of the
      two base-100 numbers given to it.
      Assume both input lists have non-zero last elements, but
      that they may be of different lengths.

      E.g.,

      compare100 [] [] = EQ
      compare100 [1] [] = GT
      compare100 [] [1] = LT
      compare100 [55,1] [55,1] = EQ
      compare100 [0,56] [1,55] = GT
      compare100 [0,0,0,2] [99,99,99,1] = GT
      compare100 [98,99,5] [99,98,5] = GT
      compare100 [99,98,5] [98,99,5] = LT

      Do not use any standard library functions that operate on
      the Integer type in your solution.
-}
compare100 :: [Word8] -> [Word8] -> Ordering
compare100 _ _ = EQ
                 
{- 8) Write an instance of the Num type class for Int100.
      Include implementations of fromInteger, +, *, signum, abs,
      and negate. Use your toInt100, addDigits, subDigits, multDigits,
      and compare100 functions.

      E.g.,

     (fromInteger (-1234567)) :: Int100 = -1234567
     fromInteger 0 :: Int100 = 0
     fromInteger 42 :: Int100 = 42

     signum ((-5) :: Int100) = -1
     signum (0 :: Int100) = 0
     signum (421 :: Int100) = 1

     negate ((-123) :: Int100) = 123
     negate (0 :: Int100) = 0
     negate (453 :: Int100) = -453

     abs ((-123) :: Int100) = 123
     abs (123 :: Int100) = 123
     abs (0 :: Int100) = 0
 
     1234 + (4567 :: Int100) = 5801
     1234 + ((-1233) :: Int100) = 1
     1232 + ((-1233) :: Int100) = -1
     1234 - (1234 :: Int100) = 0
         
     99 * ((-99) :: Int100) = -9801
     (-998801) * (200 :: Int100) = -199760200
     (-16) * ((-32) :: Int100) = 512

      Do not use any standard library functions that operate on
      the Integer type in your solution.
-}
instance Num Int100 where
   fromInteger = toInt100
   _ + _ = IntZ -- Change this
   _ * _ = IntZ -- Change this
   signum _ = IntZ -- Change this
   negate _ = IntZ -- Change this
   abs _ = IntZ -- Change this

{- 9) Write an instance of the Ord type class for Int100.
      in particular, write an implementation of the compare
      function; Haskell will infer the rest.  Use your
      compare100 function.

      E.g.,

     (0 :: Int100) `compare` 0 = EQ
     (0 :: Int100) `compare` 1 = LT
     (1 :: Int100) `compare` 0 = GT
     (1 :: Int100) `compare` 1 = EQ
     ((-1) :: Int100) `compare` 1 = LT
     (1 :: Int100) `compare` (-1) = GT

      Do not use any standard library functions that operate on
      the Integer type in your solution.
-}
instance Ord Int100 where
    _ `compare` _ = EQ -- Change this

{- 10) Implement the Functor type classes for the BHeap and BTree types.

     Your solution should satisfy the functor properties:
     fmap id = id
     fmap ( f . g ) = fmap f . fmap g
-}
data BHeap a = BHeap [BTree a] deriving (Eq, Show, Read)
data BTree a = BNode Int a (BHeap a) deriving (Eq, Show, Read)

instance Functor BHeap where
  fmap _ _ = error "" -- Change this

instance Functor BTree where
  fmap _ _ = error "" -- Change this

{- 11) PLEASE DO NOT DELETE THIS LINE -}
