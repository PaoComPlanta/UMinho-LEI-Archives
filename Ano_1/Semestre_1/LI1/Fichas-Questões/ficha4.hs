module Ficha4 where

import Test.HUnit

-- 1 

notan :: [Double] -> Double -> Double
notan [] x = x * 0.6
notan [y] 0 = sum [y] * 0.4
notan [y] x = sum [y] * 0.4 + x * 0.6

-- 2 

trocalinha :: [[Double]] -> [[Double]]
trocalinha (m:ms) = last ms : init ms ++ [m]

-- 3

tradeColunasRecursivamente :: [[a]] 
                              -> [[a]] 
tradeColunasRecursivamente [] = [] 
tradeColunasRecursivamente matriz = [trocarColunasLinha linha | linha <- matriz]
    where
        trocarColunasLinha :: [a]
                              -> [a] 
        trocarColunasLinha [] = []  
        trocarColunasLinha (x:xs) = (last xs : init xs) ++ [x]

-- 4 

findPosition :: (Eq a) => a -> [a] -> Int
findPosition _ [] = -1  
findPosition x (l:ls) | x == l = 0
                      | otherwise = 1 + findPosition x ls
                     
-- 5 

subPosition :: (Eq a) => a -> a -> [a] -> [a]
subPosition _ _ [] = []  
subPosition old new (x:xs) | old == x = new : subPosition old new xs
                           | otherwise = x : subPosition old new xs

-- 6 