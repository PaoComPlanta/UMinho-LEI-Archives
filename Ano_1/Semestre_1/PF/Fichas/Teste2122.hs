module Teste2122 where

import Data.List (intercalate)
import System.Random (randomRIO)

-- 1)
myzip :: [a] -> [b] -> [(a,b)]
myzip [] _ = []
myzip _ [] = []
myzip (x:xs) (y:ys) = (x,y): myzip xs ys

-- 2)
preCrescente :: Ord a => [a] -> [a]
preCrescente [] = []
preCrescente (x:y:xs)
    | x > y = [x]
    | otherwise = x : preCrescente (y:xs)

-- 3)
amplitude :: [Int] -> Int
amplitude [] = 0
amplitude l = maximum l - minimum l 

-- 4)
type Mat a = [[a]]

soma :: Num a => Mat a -> Mat a -> Mat a
soma = zipWith . zipWith $ (+)

-- 5) 
type Nome = String
type Telefone = Integer
data Agenda = Vazia 
            | Nodo (Nome,[Telefone]) Agenda Agenda

instance Show Agenda where
    show :: Agenda -> String
    show Vazia = "Vazia"
    show (Nodo (n,t) age agd) = show age ++ n ++ " " ++ intercalate "/" (map show t) ++ "\n" ++ show agd

-- 6) 
randomSel :: Show a => Int -> [a] -> IO [a]
randomSel _ [] = return []
randomSel 0 _ = return []
randomSel n l = randomRIO (1, length l) >>= (\randomN -> 
        fmap (l !! (randomN - 1) :) (randomSel (n - 1) (take (randomN - 1) l ++ drop randomN l))
    )

-- Não faço ideia de como se faz a de cima.

-- 7)
organiza :: Eq a => [a] -> [(a,[Int])]
organiza = foldr (\a -> insert a . map (\(c,is) -> (c,map (+1) is))) []

insert :: Eq a => a -> [(a,[Int])] -> [(a,[Int])]
insert x [] = [(x,[0])]
insert x ((c,is):t)
    | x == c = (c, 0 : is) : t
    | otherwise = (c,is) : insert x t

-- Tbm ns

-- 8)
func :: [[Int]] -> [Int]
func [] = []
func (x:xs)
    | sum x > 10 = x ++ func xs
    | otherwise = func xs 

-- 9)
data RTree a = R a [RTree a]

type Dictionary = [ RTree (Char, Maybe String) ]

insere :: String -> String -> Dictionary -> Dictionary
insere [x] desc dict = insereFim x desc dict
insere (h:t) desc [] = [ R (h,Nothing) (insere t desc [])]
insere (h:t) desc (R (a,b) l:d)
    | h == a = R (a,b) (insere t desc l) : d
    | otherwise = R (a,b) l : insere (h:t) desc d

insereFim :: Char -> String -> Dictionary -> Dictionary
insereFim x desc [] = [ R (x,Just desc) [] ]
insereFim x desc (R (a,b) l:t) 
    | x == a = R (a,Just desc) l : t
    | otherwise = R (a,b) l : insereFim x desc t
