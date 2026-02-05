module Aleatorios where

-- Ficha 8

-- 1)
data Frac = F Integer Integer

-- a)
normaliza :: Frac -> Frac
normaliza (F x y) = F (a*signum (x*y)) b
    where d = mdc (abs x) (abs y)
          a = div (abs x) d
          b = div (abs y) d

mdc :: Integer -> Integer -> Integer
mdc a b
    | a > b = mdc (a-b) b
    | b > a = mdc a (b-a)
    | a == b = a

-- b)
instance Eq Frac where
    (==) :: Frac -> Frac -> Bool
    (==) (F x y) (F w z) = x*z == y*w

-- c) 
instance Ord Frac where
    f1 <= f2 = let (F x y) = normaliza f1
                   (F w z) = normaliza f2
                in x*z <= y*w

-- d)
instance Show Frac where
    show :: Frac -> String
    show (F x y) = "(" ++ show x ++ "/" ++ show y ++ ")"

-- e) 
instance Num Frac where
    (+) :: Frac -> Frac -> Frac
    (+) (F x y) (F w z) = F (x*z + w*y) (y*z)
    (-) :: Frac -> Frac -> Frac
    (-) (F x y) (F w z) = F (x*z - w*y) (y*z)
    (*) :: Frac -> Frac -> Frac
    (*) (F x y) (F w z) = F (x*w) (y*z)
    abs, signum :: Frac -> Frac
    abs (F x y) = F (abs x) (abs y)
    signum (F x y) = F (signum (x*y)) 1
    fromInteger :: Integer -> Frac
    fromInteger x = F x 1 

-- f)
fun :: Frac -> [Frac] -> [Frac]
fun f (frac:fs)
    | frac > 2*f = frac : fun f fs
    | otherwise = fun f fs