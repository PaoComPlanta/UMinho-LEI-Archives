module Aula6PF where
{-
-- Ficha 3
data Movimento = Credito Float | Debito Float
            deriving Show
data Data = D Int Int Int
            deriving Show
data Extracto = Ext Float [(Data, String, Movimento)]
            deriving Show

extValor :: Extracto -> Float -> [Movimento]
extValor Ext
-}

-- Ficha 4

-- 2)
nzp :: [Int] -> (Int,Int,Int)
nzp [] = (0,0,0)
nzp (x:xs)
    | x < 0 = (1+a,b,c)
    | x == 0 = (a,1+b,c)
    | x > 0 = (a,b,1+c)
    where (a,b,c) = nzp xs

nzp1 :: [Int] -> (Int,Int,Int)
nzp1 l = nzpAC l (0,0,0)

nzpAC :: [Int] -> (Int,Int,Int) -> (Int,Int,Int)
nzpAC [] (a,b,c) = (a,b,c)
nzpAC (x:xs) (a,b,c)
    | x < 0 = nzpAC xs (1+a,b,c)
    | x == 0 = nzpAC xs (a,1+b,c)
    | x > 0 = nzpAC xs (a,b,1+c)

-- 3)
-- myDivMod :: Integral a => a -> a -> (a,a)
