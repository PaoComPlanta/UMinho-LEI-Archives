module Aula27nov where

import System.Random

geraN :: Int -> Int -> [Int]
geraN n seed = take n $ randoms (mkStdGen seed)

geraRangeN :: Int -> Int -> Int -> [Int]
geraRangeN n limite seed =
    let listaAleatorios = take n $ randoms (mkStdGen seed)
    in map (\k -> mod k limite) listaAleatorios

-- seed pode ser o tempo ou um fator que depende do tempo
geraRangeN2 :: Int -> Int -> Int -> [Int]
geraRangeN2 n limite tempo = 
    let listaAleatorios = take n $ randoms (mkStdGen tempo)
        listaAleatorios2 = map (\x -> head $ randoms (mkStdGen x)) listaAleatorios
    in map (\k -> mod k limite) listaAleatorios2

-- escolher um elemento de uma lista de forma aleatória

escolheLista :: [Int] -> Float -> Int
escolheLista [] _ = 0
escolheLista l tempo = head $ geraRangeN2 (length l) (length l-1) (round tempo)