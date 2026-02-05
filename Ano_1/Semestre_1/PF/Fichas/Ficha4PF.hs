module Ficha4PF where
import Data.Char
import Data.List


-- 1)
digitAlpha :: String -> (String,String)
digitAlpha "" = ("","")
digitAlpha (x:xs) 
    | isDigit x = (x:a, b)
    | isAlpha x = (a,x:b)
    | otherwise = (a,b)
    where (a,b) = digitAlpha xs 

-- 2)
myDivMod :: Integral a => a -> a -> (a,a)
myDivMod x y  
    | x >= y = (1+q,r) 
    | x < y = (0,x)
    where (q,r) = myDivMod (x-y) y

-- 5)
maxSumInit :: (Num a, Ord a) => [a] -> a
-- maxSumInit l = maximum [sum m | m <- inits l] 
maxSumInit l = aux l 0 0

aux [] s m = m
aux (h:t) s m = aux t (h+s) (max (h+s) m) 

-- 6)
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

fibonacci :: Integer -> Integer
fibonacci n = fibAC n (0,1)
 
fibAC :: Integer -> (Integer,Integer) -> Integer
fibAC 0 (a,b) = a
-- fibAC 1 (a,b) = b
fibAC n (a,b) = fibAC (n-1) (b,a+b)
