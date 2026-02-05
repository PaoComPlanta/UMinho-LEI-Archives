module Ficha9PF where

import System.Random
import System.IO

-- 1)
-- a) 

aposta1 = Ap [3,50,23,7,11] (3,7)
aposta2 = Ap [33,5,31,7,1] (4,2)

bingo :: IO ()
bingo = tiraNum 90 [1..90]

tiraNum :: Int -> [Int] -> IO ()
tiraNum 0 l = do putStrLn "--- FIM ---"
                 return ()
tiraNum n s = do putStrLn "Prima uma tecla..."
                 hSetEcho stdin False
                 getChar
                 hSetEcho stdin True
                 p <- randomRIO (0,n-1)
                 let (s1,x:s2) = splitAt p s
                 print x
                 tiraNum (n - 1) (s1 ++ s2)


-- b) Fazer em casa

-- 2)

data Aposta = Ap [Int] (Int,Int)
    deriving (Show)

-- a)  

valida :: Aposta -> Bool
valida (Ap lnums (a,b)) = a/=b && 1<=a && a<=9 && 1<=b && b <=9
                           && length lnums == 5 && valNums lnums

valNums :: [Int] -> Bool
valNums [] = True
valNums (x:xs) = 1 <= x && x<=50 && notElem x xs && valNums xs
-- valNums = all (\x -> 1<=x && x<=50)

comuns :: Aposta -> Aposta -> (Int, Int)
comuns (Ap l1 (a,b)) (Ap l2 (c,d)) = (numComuns l1 l2, numComuns [a,b] [c,d])

numComuns :: [Int] -> [Int] -> Int
numComuns [] l = 0
numComuns (x:xs) l = if (elem x l)
                        then 1 + numComuns xs l
                        else 1 + numComuns xs l

instance Eq Aposta where
    (==) :: Aposta -> Aposta -> Bool
    ap1 == ap2 = (comuns ap1 ap2) == (5,2)

premio :: Aposta -> Aposta -> Maybe Int
premio ap ch = case (comuns ap ch) of
                (5,2) -> Just 1
                (5,1) -> Just 2
                (5,0) -> Just 3
                (4,2) -> Just 4
                (4,1) -> Just 5
                (4,0) -> Just 6
                (3,2) -> Just 7
                (3,1) -> Just 8
                (3,0) -> Just 9
                (1,2) -> Just 10
                (2,2) -> Just 11
                (2,1) -> Just 12
                (2,0) -> Just 13
                _ -> Nothing

leAposta :: IO Aposta
leAposta = do putStrLn "Escreva a lista de 5 números (1-50):"
              l <- getLine
              putStrLn "Escreva o par de estrelas (1-9):"
              e <- getLine
              let ap = (Ap (read l) (read e))
              if (valida ap) 
                then return ap
                else do putStrLn "A aposta não é válida, seus burros."
                        leAposta

joga :: Aposta -> IO ()
joga ch = do ap <- leAposta
             case (premio ap ch) of 
                Just n -> putStrLn ("Tem o " ++ show n ++ "º prémio!")
                Nothing -> putStrLn "Foste com os porcos :("