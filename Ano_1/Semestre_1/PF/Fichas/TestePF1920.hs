module TestePF1920 where

import Data.List (groupBy)
-- 1)
-- a)
intersect :: Eq a => [a] -> [a] -> [a]
intersect [] _ = []
intersect (x:xs) l
    | x `elem` l = x : intersect xs l
    | otherwise = intersect xs l

-- b)
tails :: [a] -> [[a]]
tails [] = [[]]
tails (x:xs) = (x:xs) : tails xs

-- 2)
type ConjInt = [Intervalo]
type Intervalo = (Int,Int)

-- a)
elems :: ConjInt -> [Int]
elems [] = []
elems ((x,y):xs) = [x..y] ++ elems xs

-- b)
geraconj :: [Int] -> ConjInt
geraconj [] = []
---

-- 3)
data Contacto = Casa Integer
              | Trab Integer
              | Tlm Integer
              | Email String
        deriving (Show)
type Nome = String
type Agenda = [(Nome, [Contacto])]

-- a)
acrescEmail :: Nome -> String -> Agenda -> Agenda
acrescEmail n e [] = [(n, [Email e])]
acrescEmail n e ((nome,lc):t)
    | n == nome = (nome, lc ++ [Email e]):t
    | otherwise = (nome,lc) : acrescEmail n e t

-- b)
verEmails :: Nome -> Agenda -> Maybe [String]
verEmails _ [] = Nothing
verEmails n ((nome,lc):t)
    | n == nome = Just (map (\(Email e) -> e) $ filter isEmail lc)
    | otherwise = verEmails n t
    where isEmail (Email _) = True
          isEmail _ = False

-- c)
consulta :: [Contacto] -> ([Integer],[String])
consulta =
    foldr (\c (tlfs, emails) ->
        case c of 
            Tlm n -> (n:tlfs, emails)
            Casa n -> (n:tlfs, emails)
            Trab n -> (n:tlfs, emails)
            Email e -> (tlfs, e:emails)
        ) ([],[])

-- d)
consultaIO :: Agenda -> IO ()
consultaIO a = 
    getLine >>= 
        print 
        . maybe ([],[]) consulta 
        . flip lookup a

-- 4)
data RTree a = R a [RTree a] deriving (Show, Eq)

-- a)
paths :: RTree a -> [[a]]
paths (R a []) = [[a]]
paths (R a t) = map (a:) $ concatMap paths t

-- b)

unpaths :: Eq a => [[a]] -> RTree a
unpaths [[x]] = R x []
unpaths l = R root (map unpaths $ groupBy (\a b -> head a == head b) $ map tail l)
    where root = head $ head l


