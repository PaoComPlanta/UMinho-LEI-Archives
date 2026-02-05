module Main where

import Test.HUnit
import Tarefa1

test_suite_01 :: Test
test_suite_01 = test [
    "testscolisoesParede" ~: testscolisoesParede
    "testscolisoesPersonagens" ~: testscolisoesPersonagens
    ]

-- Definições de alguns mapas 
mapa1 = Mapa ((0, 0), Este) (5, 5) [[Plataforma, Plataforma, Plataforma], [Plataforma, Vazio, Plataforma], [Plataforma, Plataforma, Plataforma]]
mapa2 = Mapa ((0, 0), Este) (5, 5) [[Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio]]

-- Definições de algumas Entidades
entidade1 = Personagem (1, 0) Jogador (1, 1) Este (1, 1) False False 3 0 (False, 0)
entidade2 = Personagem (1, 0) Jogador (1.5, 1.5) Este (1.5, 1.5) False False 3 0 (False, 0)
entidade3 = Personagem (1, 0) Jogador (0.5, 0.5) Este (1, 1) False False 3 0 (False, 0)
entidade4 = Personagem (1, 0) Jogador (1, 1) Este (1, 1) False False 3 0 (False, 0)
entidade5 = Personagem (1, 0) Jogador (2.5, 2.5) Este (1.5, 1.5) False False 3 0 (False, 0)

testscolisoesParede :: Test
testscolisoesParede = test [
    "testColisaoPlataforma1" ~: True ~=? colisoesParede mapa1 entidade1,
    "testColisaoPlataforma2" ~: False ~=? colisoesParede mapa2 entidade2,
    "testColisaoLimitesMapa1" ~: True ~=? colisoesParede mapa2 entidade3
    "testColisaoLimitesMapa2" ~: False ~=? colisoesParede mapa2 entidade4
    ]

testscolisoesPersonagens :: Test
testscolisoesPersonagens = test [
    "testPersonagensColidem" ~: True ~=? colisoesPersonagens entidade2 entidade3
    "testPersonagensNaoColidem" ~: False ~=? colisoesPersonagens entidade3 entidade5
    ]

main :: IO ()
main = runTestTTAndExit $ test [test_suite_01]