{-

Problem 2: Word Ladder

Write a program that takes the name of a dictionary file and starting
and ending words and constructs the shortest "word ladder," i.e., a
sequence of dictionary words that differ by exactly one changed
character that transforms the starting word into the ending word.
Unlike some word ladder puzzles, your program should not consider
adding or removing letters.

Your program should read a Unix-style /usr/dict/words file (i.e., a
sorted, newline-separated list of valid words), and only consider
lowercase-only words (i.e., no capitalized proper nouns).  You may
also ignore words with punctuation, e.g., abase is fine, but ignore
aardvark's, ASCII, and Abby.

The user must supply a valid dictionary file and start and end words
that are the same length, all lowercase, and both in the dictionary.
Your program should print an error message and terminate with a
non-zero error code if supplied with erroneous arguments.

Search for ladders of at most 20 words, returning an error message if
one cannot be found with the given dictionary.  For a given pair of
words and dictionary, there is often more than one minimum-length
ladder; you may return any of them.

Here is an example run; your program should work with other
dictionaries, too.

$ wget https://raw.githubusercontent.com/eneko/data-repository/master/data/words.txt
$ stack --resolver lts-24.57 ghc -- --make -Wall -O wordLadder.hs
$ ./wordLadder words.txt fool sage
fool
foot
fort
fore
fare
fage
sage
$ ./wordLadder words.txt computer solution
Unable to find a ladder in 20
$ ./wordLadder
Usage: wordLadder <dictionary-filename> <from-word> <to-word>
$ ./wordLadder foo
Usage: wordLadder <dictionary-filename> <from-word> <to-word>
$ ./wordLadder foo bar
Usage: wordLadder <dictionary-filename> <from-word> <to-word>
$ ./wordLadder foo bar baz
wordLadder: foo: openFile: does not exist (No such file or directory)
$ ./wordLadder words.txt fooa barb
"fooa" not in dictionary
$ ./wordLadder words.txt barb fooa
"fooa" not in dictionary
$ ./wordLadder words.txt bar none
"bar" and "none" must be the same length

As for the wordFreq problem, make your solution correct, readable, and
fast (in order of importance).

Our 68-line reference solution uses a BFS-style search implemented
with functions from System.IO, System.Exit, Data.Char,
System.Environment, Data.Set, Control.Monad, and Data.List.

For reference, the fool->sage example above took about 142 ms on my 3
GHz Intel i7-9700 desktop machine.  Our solution uses one fairly
straightforward trick to improve its performance, but is otherwise
untuned.

-}

import System.Environment
import Data.Char
import qualified Data.Set as Set
import qualified Data.Map as Map
import Control.Monad
import System.Exit

main :: IO ()
main = do
  args <- getArgs
  case args of
    [dictionary_filename, from_word, to_word] -> do
      contents <- readFile dictionary_filename
      let dict = Set.fromList $ filter (\w -> length w == length from_word) $ filter isValidWord $ lines contents
      when (length from_word /= length to_word) $
        die $ show from_word ++ " and " ++ show to_word ++ " must be the same length"
      when (not $ Set.member from_word dict) $
        die $ show from_word ++ " not in dictionary"
      when (not $ Set.member to_word dict) $
        die $ show to_word ++ " not in dictionary"
      case ladder dict from_word to_word of
        Just path -> putStr $ unlines path
        Nothing -> die "Unable to find a ladder in 20"
    _ -> do
      pn <- getProgName
      die $ "Usage: " ++ pn ++ " <dictionary-filename> <from-word> <to-word>"

isValidWord :: String -> Bool
isValidWord = all isLower

neighbors :: Set.Set [Char] -> [Char] -> [[Char]]
neighbors dict w =
  [ w' |
    i <- [0 .. length w - 1],
    (before, old: after) <- [splitAt i w],
    c <- ['a' .. 'z'],
    c /= old,
    let w' = before ++ [c] ++ after,
    Set.member w' dict
  ]

ladder :: Set.Set [Char] -> [Char] -> [Char] -> Maybe [[Char]]
ladder dict from_word to_word = bfs [[from_word]] (Set.singleton from_word) 1
  where
    bfs :: [[String]] -> Set.Set String -> Int -> Maybe [String]
    bfs [] _ _ = Nothing
    bfs paths visited n =
      case [ w : rest | (w : rest) <- paths, w == to_word ] of
        (p : _) -> Just (reverse p)
        [] -> if n >= 20 then Nothing else bfs (Map.elems layer) visited' (n + 1)
          where
            layer =
              Map.fromList [ (w', w' : w : rest) |
                (w : rest) <- paths,
                w' <- neighbors dict w,
                not $ Set.member w' visited
              ]
            visited' = Set.union visited (Set.fromList $ Map.keys layer)
