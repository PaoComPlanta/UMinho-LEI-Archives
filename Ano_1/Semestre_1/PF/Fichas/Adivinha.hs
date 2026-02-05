module Adivinha where

import System.Random

adivinha :: Int -> IO ()
adivinha n = do
    x <- randomRIO (1, n)
    putStrLn "Qual é o número?"
    tentativas <- joga x 0
    putStrLn ("Gastou " ++ show tentativas ++ " tentativas")

joga :: Int -> Int -> IO Int
joga x n = do
    s <- getLine
    let y = read s
    if x == y
        then return (n + 1)
        else do
            putStrLn $ if x > y then "É baixo..." else "É alto..."
            joga x (n + 1)

