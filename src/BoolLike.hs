{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ViewPatterns #-}

module BoolLike where

import Prelude hiding ((&&), (||), not)
import qualified Prelude as P

newtype BoolLike a = BoolLike ((a -> Bool) -> Bool)

toBoolLike :: a -> BoolLike a
toBoolLike x = BoolLike $ \k -> k x

(toBool -> BoolLike f) && (toBool -> BoolLike g) = BoolLike $ \k -> f k P.&& g k
(toBool -> BoolLike f) || (toBool -> BoolLike g) = BoolLike $ \k -> f k P.|| g k
not (toBool -> BoolLike f) = BoolLike $ \k -> P.not (f k)

infixr 3 &&
infixr 2 ||

belongs (toBool -> BoolLike f) xs = f (\x -> x `elem` xs)
contains (toBool -> BoolLike f) x = f (\xs -> x `elem` xs)

type family BoolItem a where
  BoolItem (BoolLike a) = BoolLike a
  BoolItem a = BoolLike a

class IsBool a where
  toBool :: a -> BoolItem a

instance IsBool (BoolLike a) where
  toBool = id

instance {-# OVERLAPPABLE #-} (BoolItem a ~ BoolLike a) => IsBool a where
  toBool = toBoolLike
