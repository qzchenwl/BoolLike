module Main where

import Prelude hiding ((&&), (||), not)
import BoolLike

a, b, c :: Char
a = 'a'
b = 'b'
c = 'c'
d = 'd'

data Color = R | G | B deriving (Eq, Ord, Show)

main :: IO ()
main = do
  print $ (a && b || c) `belongs` [a]
  print $ (a && b || c) `belongs` [b]
  print $ (a && b || c) `belongs` [a, b]
  print $ (a && b || c) `belongs` [c]
  print $ (a && b || c) `belongs` []
  print $ (R && G || B) `belongs` [R]
  -- print $ (1 && 2 || 3) `belongs` [1, 2]
