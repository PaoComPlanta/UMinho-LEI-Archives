module Ficha2PF where

import Data.Char
-- 2) 
-- a)

dobros :: [Float] -> [Float]
dobros [] = []
dobros (x:xs) = (2*x) : dobros xs

-- b)
numOcorre :: Char -> String -> Int
numOcorre c [] = 0 -- ^ Caso base: Lista vazia não contém o caractere.
numOcorre c (x:xs)
    | c == x = 1 + numOcorre  c xs
    | otherwise = numOcorre c xs

-- c)
positivos :: [Int] -> Bool
positivos (x:xs) = if x>0 then positivos xs
                    else False
positivos [] = True

-- d)
soPos :: [Int] -> [Int]
soPos [] = []
soPos (x:xs)
    | x < 0 = soPos xs
    | otherwise = x : soPos xs

-- e)
somaNeg :: [Int] -> Int
somaNeg [] = 0
somaNeg (x:xs)
    | x < 0 = x + somaNeg xs
    | otherwise = somaNeg xs

-- f)
-- Apenas com recursividade e patern matching
tresUlt1 :: [a] -> [a]
tresUlt1 (a:b:c:d:t) = tresUlt1 (b:c:d:t)
tresUlt1 l = l

-- g)
segundos :: [(a,b)] -> [b]
segundos [(a,b)] = [b]
segundos ((a,b):xs) = b : segundos xs

-- h)
nosPrimeiros :: (Eq a) => a -> [(a,b)] -> Bool
nosPrimeiros _ [] = False
nosPrimeiros x ((a,_):xs)
    |x == a = True
    |x /= a = nosPrimeiros x xs

-- i)
{- 
sumTriplos :: (Num a, Num b, Num c) => [(a,b,c)] -> (a,b,c)
sumTriplos [] = (0,0,0)
sumTriplos ((a,b,c) : (d,e,f) : xs)
    |
-}
-- Acabar em casa

-- 3)
nums :: String -> [Int]
nums [] = []
nums (x:xs) = 

-- 4)
type Polinomio = [Monomio]
type Monomio = (Float,Int)

pol1, pol2 :: Polinomio
pol1 = [(2,3), (3,4), (5,3), (4,5)]
pol2 = [(2.7,2), (5,3), (4,0)]

-- a) 
conta :: Int -> Polinomio -> Int
conta n ((c,e):t) = if e == n then 1 + conta n t
                        else conta n t
conta n [] = 0

-- b)
{-grau :: Polinomio -> Int 
grau [(_,b)] = b
grau ((_,b):t) = 
-}
-- d) 
deriv :: Polinomio -> Polinomio
deriv ((a,b):t) = (a*fromIntegral b,b-1) : deriv t
deriv [] = []