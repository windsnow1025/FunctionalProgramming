{-

 Name:
 Uni:

 ------------------------------

 COMS 4995 001 Parallel Function Programming

 Homework 1

 Due at 11:59 PM Sunday, September 20, 2026

 Modify this file with your solutions and submit it on Courseworks.
 If you used AI for this assignment, save your chat logs in PDF form
 and upload them, too.

 You may use functions, etc. from the Standard Prelude, but no
 other libraries

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
 :l hw1

-}

{- 1) Write a function eleminc x xs that returns true if x is an element of the
      list xs.  Assume the list xs is in increasing order but may be infinite.

      E.g,

      ghci> eleminc (1::Int) []
      False
      ghci> eleminc (57::Int) [1..]
      True
      ghci> eleminc (57::Int) [1,3..]
      True
      ghci> eleminc (57::Int) [1..100]
      True
      ghci> eleminc (58::Int) [1,3..]
      False

-}
eleminc :: Ord a => a -> [a] -> Bool
eleminc _ _ = False -- Change this

{- 2) Write a function for testing the Goldbach conjecture, i.e., that
      every even integer greater than 2 can be written as a sum of two
      primes.  Write a function goldbach n that returns a pair of
      primes (p1, p2) such that p1 + p2 = n.  Use the list primes and
      the eleminc function in your solution.  Assume n is in [4,6,...].
      Note: the solution often isn't unique.

      Hint: my solution was mostly a one-line list comprehension.
      Think about generating candidate solutions and filtering them.

      Example:

      ghci> take 10 [ goldbach n | n <- [4,6..] ]
      [(2,2),(3,3),(3,5),(3,7),(5,7),(3,11),(3,13),(5,13),(3,17),(3,19)]
      ghci> goldbach 2642
      (103,2539)
      ghci> goldbach 65536
      (17,65519)

-}
goldbach :: Integer -> (Integer, Integer)
goldbach n = (n,n) -- Change this

-- An infinite list of primes; do not modify
primes :: [Integer]
primes = f [2..] where f (p:xs) = p : f [ x | x <- xs, x `mod` p /= 0 ]
                       f [] = []

{- 3) Write a function "maxrun" that reports the length of the longest
      contiguous run of equal values in a list.

      E.g.,

      ghci> maxrun []
      0
      ghci> maxrun [1]
      1
      ghci> maxrun [1,1]
      2
      ghci> maxrun "aabbbcdd"
      3
-}
maxrun :: Eq a => [a] -> Int
maxrun _ = 0 -- Change this

{- 4) Write the infinite list of Pell numbers in which the next number is
      twice the previous number plus the the number before that.

      Hint: declare the list recursively in terms of itself.  My solution is
      a single line.

      Example:

      ghci> take 10 pell
      [0,1,2,5,12,29,70,169,408,985]
-}
pell :: [Integer]
pell = [0,1,2] -- Change this

{- 5) Write a function revmap that applies a function to each element of
      the given list and returns the resulting list in reverse order,
      i.e., has the same behavior as applying reverse to the result of
      map.  Do not use any library functions in your solution and make
      sure it is O(n) (linear in the length of the input list) if
      applying the function is constant cost.  Hint: use a local helper
      function.

      E.g.,

      ghci> revmap (+10) [] :: [Int]
      []
      ghci> revmap (+10) [1..3] :: [Int]
      [13,12,11]
-}
revmap :: (a -> b) -> [a] -> [b]
revmap _ _ = [] -- Change this

{- 6) Write a function sequencef that takes a list of functions
      and returns the function that applies them left-to-right.

      E.g.,

      ghci> (sequencef [(+5),(*2)]) 5 :: Int
      20

-}
sequencef :: [a -> a] -> a -> a
sequencef _ = id -- Change this

{- 7) Generate the rows of Pascal's triangle as an infinite list of lists.

      Hint: use zipWith, tail, and list comprenensions.  As an intermediate
      step, try writing a function that takes one line of the triangle
      and produces the next.  My final solution is a single line.

    Example:
    ghci> take 7 pascal
    [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1],[1,5,10,10,5,1],[1,6,15,20,15,6,1]]

-}
pascal :: Num a => [[a]]
pascal =  [] -- Change this

{- 8) PLEASE DO NOT DELETE THIS LINE -}
