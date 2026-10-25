{-

Problem 1: Word Frequency Counter

Write a program that prints the 40 most common words and the number of
times they appear in the given text file.  Compile this into a
standalone executable that takes a single filename as a command-line
argument.  Print a usage message if the user does not supply exactly
one argument.

To find words, discard all non-alphabetic characters aside from
whitespace and treat what's left as lowercase.  E.g., treat "Stephen's
humor-challenged" as two words: "stephens" and "humorchallenged"

You may use any of the System or Data modules.  Ask permission from
the instructor on Ed before you use any other modules.  You may not
use the Data.Text.WordCount module.

In my 32-line reference solution, I used Data.Map.fromListWith,
Data.List.sortBy, readFile, System.Exit.die,
System.Environment.getArgs, and System.Environment.getProgName.

In addition to making your solution correct and readable, try to make
your solution go fast, but leave it single-threaded.

My reference solution took about 1.3s on the Shakespeare example
running on a 3 GHz Intel i7-9700.

E.g., on the Complete Works of Shakespeare

$ stack --resolver lts-24.57 ghc -- --make -Wall -O wordFreq
$ ./wordFreq
Usage: wordFreq <filename>
$ wget https://www.cs.columbia.edu/~sedwards/classes/2024/4995-fall/shakespeare.txt
$ ./wordFreq shakespeare.txt
30550 the
28487 and
22134 i
21035 to
18860 of
16373 a
14435 you
13186 my
12450 in
11805 that
9750 is
9073 not
8553 with
8252 me
8202 it
8192 for
7600 his
7373 be
7154 this
7066 your
6938 he
6741 but
6269 have
6193 as
5856 thou
5554 him
5442 so
5297 will
4744 what
4632 her
4353 thy
4269 all
4103 by
4078 no
4017 do
3851 shall
3815 if
3726 are
3563 we
3416 thee

-}

import System.Environment
import Data.Char
import qualified Data.Map as Map
import Data.List

main :: IO ()
main = do
  [filename] <- getArgs
  contents <- readFile filename
  putStr $ unlines $ map formatLine $ take 40 $ sortByCount $ wordCounts $ toWords contents

toWords = words . map toLower . filter (\c -> isAlpha c || isSpace c)

wordCounts :: [String] -> Map.Map String Int
wordCounts = Map.fromListWith (+) . map (\w -> (w, 1))

sortByCount :: Map.Map String Int -> [(String, Int)]
sortByCount = sortBy (\(_, a) (_, b) -> compare b a) . Map.toList

formatLine (w, n) = show n ++ " " ++ w
