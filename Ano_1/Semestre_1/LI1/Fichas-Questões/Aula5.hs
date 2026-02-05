module Aula5 where

type Nome = String
type Coordenada = (Int, Int)
data Movimento = N | S | E | W deriving (Show,Eq) -- norte, sul, este, oeste
type Movimentos = [Movimento]
data PosicaoPessoa = Pos Nome Coordenada deriving (Show,Eq)

-- ficha 3 alínea d)
pessoaNorte :: [PosicaoPessoa] -> Int
pessoaNorte [Pos nome (x,y)] = y
pessoaNorte ((Pos nome (x,y)):t) =
    let yn = pessoaNorte t
    in max y yn

pessoasNorte :: [PosicaoPessoa] -> [Nome]
pessoasNorte []= []
pessoasNorte l =
    let yn = pessoaNorte l
    in getPessoas l yn

getPessoas :: [PosicaoPessoa] -> Int -> [Nome]
getPessoas [] _ = []
getPessoas (Pos nome (x,y):t) yn
    | y == yn = nome:getPessoas t yn
    | otherwise = getPessoas t yn

-- OU --

pessoasNorte' :: [PosicaoPessoa] -> [Nome]
pessoasNorte' [] = []
pessoasNorte' ((Pos nome (x,y)):t) = pessoasNAux t y [nome]

pessoasNAux :: [PosicaoPessoa] -> Int -> [Nome] -> [Nome]
pessoasNAux [] yn ln = ln
pessoasNAux ((Pos nome1 (x1,y1)):t) yn ln
    | y1<yn = pessoasNAux t yn ln 
    | y1 == yn = pessoasNAux t yn (nome1:ln)
    | y1 > yn = pessoasNAux t y1 [nome1]

-- Ficha 4 
-- Matriz em haskell: Lista de Listas.

-- 2)
trocaPrimUlt :: [a] -> [a]
trocaPrimUlt [] = []
trocaPrimUlt [x] = [x]
trocaPrimUlt (x:xs) = (last xs : init xs) ++ [x]

-- 2)
trocaPrimUltMat :: [[a]] -> [[a]]
trocaPrimUltMat m = trocaPrimUlt m

-- 3)
trocaPrimUltCol :: [[a]] -> [[a]]
trocaPrimUltCol [] = []
trocaPrimUltCol (l:m) = trocaPrimUlt l : trocaPrimUltCol m

somal :: [Int] -> [Int] -> [Int]
somal l [] = []
somal [] l = []
somal (x:xs) (y:ys) = (x+y):somal xs ys

-- 4) 
{- find :: Eq a => [a] -> a -> Int
find [] _ = -1
find l = posAux l 0
-}
posAux :: Eq a => [a] -> a -> Int -> Int
posAux (x:xs) y p
    | x == y = p
    | otherwise = posAux xs y (p+1)

posicao :: [a] -> Eq a => a -> Int
posicao [] _ = -1
posicao (x:xs) c 
    | x == c = 0
    | otherwise = if posicao xs c /= -1 then posicao xs c + 1 else -1