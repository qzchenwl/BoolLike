module Main where

import Prelude hiding ((&&), (||), not)
import BoolLike

main :: IO ()
main = do
  putStrLn "hello world"
  print $ (1 and 2 or 3) `belongs` [1]
