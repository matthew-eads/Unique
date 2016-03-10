-----------------------------------------------------------------------------
-- |
-- Module      :  Data.List.Unique
-- Copyright   :  (c) Volodymyr Yaschenko
-- License     :  BSD3
--
-- Maintainer  :  ualinuxcn@gmail.com
-- Stability   :  Unstable
-- Portability :  portable
--
-- Library provides the functions to find unique and duplicate elements in the list

module Data.List.Unique
   (
     sortUniq
   , repeated
   , repeatedBy
   , unique
   , count
   , count_
   , countElem
   )
   where


import           Data.List           (group, groupBy, sort, sortBy)

import           Control.Applicative (liftA2)
import           Data.Function       (on)
import           Data.List.Extra     (nubOrd)
import           Data.Tuple          (swap)

-- | 'sortUniq' sorts the list and removes the duplicates of elements. Example:
--
-- > sortUniq "foo bar" == " abfor"

sortUniq :: Ord a => [a] -> [a]
sortUniq = sort . nubOrd

sg :: Ord a => [a] -> [[a]]
sg = group . sort

filterByLength :: Ord a => (Int -> Bool) -> [a] -> [[a]]
filterByLength p = filter (p . length) . sg

-- | 'repeated' finds only the elements that are present more than once in the list. Example:
--
-- > repeated  "foo bar" == "o"

repeated :: Ord a => [a] -> [a]
repeated = repeatedBy (>1)

-- | The repeatedBy function behaves just like repeated, except it uses a user-supplied equality predicate.
--
-- > repeatedBy (>2) "This is the test line" == " eist"

repeatedBy :: Ord a => (Int -> Bool) -> [a] -> [a]
repeatedBy p = map head . filterByLength p

-- | 'unique' gets only unique elements, that do not have duplicates.
-- It sorts them. Example:
--
-- > unique  "foo bar" == " abfr"

unique :: Ord a => [a] -> [a]
unique = concat . filterByLength (==1)

lh :: [a] -> (a, Int)
lh = liftA2 (,) head length

-- | 'count' of each element in the list, it sorts by keys (elements). Example:
--
-- > count "foo bar" == [(' ',1),('a',1),('b',1),('f',1),('o',2),('r',1)]

count :: Ord a => [a] -> [(a, Int)]
count = map lh . sg

-- | 'count_' of each elements in the list, it sorts by their number. Example:
--
-- > count_ "foo bar" == [(' ',1),('a',1),('b',1),('f',1),('r',1),('o',2)]

count_ :: Ord a => [a] -> [(a, Int)]
count_ = sortBy (compare `on` snd) . count

-- | 'occurrences' finds all elements of each occurrences.

-- occurrences :: Ord a => [a] -> [(1,a)]
-- occurrences =

-- | 'countElem' gets the number of occurrences of the specified element. Example:
--
-- > countElem 'o' "foo bar" == 2

countElem :: Eq a => a -> [a] -> Int
countElem x = length . filter (== x)
