{-|
Module : Aula3.hs
Description : Módulo Haskell contendo exemplos de funções recursivas
Copyright : (c) Alguém <a106836.uminho.pt>;

Este módulo contém definições Haskell para o cálculo de funções
recursivas simples
-}

module Aula3 where

import Data.Char

{-| A função ´adicionarValor´ é uma função recursiva que recebe uma lista de inteiros e adiciona um valor dado
a cada elemento da lista.

== Exemplo de utilização:
>>> adicionarValor 5 [1, 2, 3, 4]
[6, 7, 8, 9]


== Propriedades:
prop> adicionarValor _ []     = []
prop> adicionarValor valor (x:xs) = (x + valor) : adicionarValor valor xs 
-}

adicionarValor :: Int   -- ^ Valor a ser adicionado a cada elemento.
               -> [Int] -- ^ Lista de inteiros.
               -> [Int] -- ^ Lista resultante após adicionar o valor.
adicionarValor _ []     = []      -- Caso base: lista vazia
adicionarValor valor (x:xs) = (x + valor) : adicionarValor valor xs 

{-| A função ´removercaracter´ é uma função recursiva que recebe uma lista de strings e remove todas as strings iniciadas
por um dado carácter 

== Exemplo de utilização:
>>> removercaracter 'A' ["António","José","Maria"]
["José","Maria"]

== Propriedades:
prop> removercaracter _ [] = []
prop> removercaracter char (str:resto)
prop> | head str == char = removercaracter char resto
prop> | otherwise = str : removercaracter char resto  
-}

removercaracter :: Char ->      -- ^ Carácter a ser removido
                   [String] ->  -- ^ Lista de Strings
                   [String]     -- ^ Lista de Strings após remoção de strings iniciadas pelo carácter escolhido
removercaracter _ [] = []  -- Caso base: lista vazia
removercaracter char (str:resto)
    | head str == char = removercaracter char resto  -- Remove a string
    | otherwise = str : removercaracter char resto  -- Mantém a string


{-| A função ´adicionarPares´ é uma função que recebe uma lista de pares de inteiros e adiciona um
valor dado à primeira componente de cada par

== Exemplo de utilização:
>>> adicionarPares 2 [(1,2),(7,5),(3,4)]
[(4,2),(9,5),(5,4)

== Propriedades:
prop> adicionarPares _ [] = []  -- Caso base: lista vazia
prop> adicionarPares n ((a, b):resto) = (n + a, b) : adicionarPares n resto
-}

adicionarPares :: Int -- ^ Valor Inteiro a ser adicionado
                  ->  [(Int,Int)]  -- ^ Lista de pares inteiros
                  -> [(Int,Int)] -- ^ Lista de pares após adição do inteiro à sua primeira componente
adicionarPares _ [] = []  -- Caso base: lista vazia
adicionarPares n ((a, b):resto) = (n + a, b) : adicionarPares n resto

{-| A função ´maiorsecomp´ é uma função que recebe uma lista, não vazia, de pares de inteiros e
calcula qual o maior valor da segunda componente

== Exemplo de utilização:
>>> maiorsecomp [(1,2),(7,5),(3,4)]
5

== Propriedades:
prop> maiorsecomp [(a,b)] = b
prop> maiorsecomp ((a,b):resto)
prop> | b > maiorsecomp resto = b
prop> | otherwise = maiorsecomp resto
-}

maiorsecomp :: [(Int,Int)] -- ^ Lista de par de inteiros
               -> Int -- ^ Maior valor da segunda componente de uma list de par de inteiros
maiorsecomp [(a,b)] = b
maiorsecomp ((a,b):resto)
    | b > maiorsecomp resto = b
    | otherwise = maiorsecomp resto

{-| A função ´proxdig´ é uma função que recebe um digíto e calcula o próximo dígito

== Exemplo de utilização:
>>> proxdig 2
3

== Propriedades:
prop> proxdig a
prop> | ord a == 57 = '0'
prop> | otherwise = chr (ord a + 1)
-}

proxdig :: Char -- ^ Digíto
           -> Char -- ^ Digíto seguinte 
proxdig a
    | ord a == 57 = '0'
    | otherwise = chr (ord a + 1)

{-| A função ´proxdigl´ é uma função que recebe uma lista de digítos e substitui
cada um deles pelo seu sucessor, usando a função anterior

== Exemplo de utilização:
>>> proxdigl ['1','2','3']
"234"

== Propriedades:
prop> proxdigl [] = []
prop> proxdigl (a:as) = (proxdig (head a)) : proxdigl as
-}

proxdigl :: [Char] -- ^ Lista de digítos
            -> [Char] -- ^ Lista de dígitos transformada
proxdigl [] = []  -- Caso base: lista vazia
proxdigl (a:as) = (proxdig a) : proxdigl as

{-| A função ´nvogal´ é uma função que recebe uma lista de vogais e substitui cada uma delas pela vogal
seguinte

== Exemplo de utilização:
>>> proxdigl ['a','e','i']
"eio"

== Propriedades:
prop> nvogal [] = []
prop> nvogal (c:cs)
prop> |c == 'a' = 'e' : nvogal cs
prop> | c == 'e' = 'i' : nvogal cs
prop> | c == 'i' = 'o' : nvogal cs
prop> | c == 'o' = 'u' : nvogal cs
prop> | c == 'u' = 'a' : nvogal cs
-}

nvogal :: String -- ^ Lista de vogais
          -> String -- ^ Lista de vogais tranformada
nvogal [] = []  -- Caso base: string vazia
nvogal (c:cs)
    | c == 'a' = 'e' : nvogal cs
    | c == 'e' = 'i' : nvogal cs
    | c == 'i' = 'o' : nvogal cs
    | c == 'o' = 'u' : nvogal cs
    | c == 'u' = 'a' : nvogal cs

type Nome = String
type Coordenada = (Int, Int)
data Movimento= N | S | E | W
     deriving (Show,Eq) -- norte, sul, este, oeste
type Movimentos = [Movimento]
data PosicaoPessoa = Pos Nome Coordenada
     deriving (Show,Eq)

{-| A função posicao é uma função que calcula a posição de uma pessoa depois de executar uma
sequência de movimentos:

== Exemplo de utilização:
>>> posicao (Pos "Joel" (0,0)) [N,E]
Pos "Joel" (1,1)

== Propriedades:
prop> posicao (Pos n (x, y)) [] = Pos n (x, y)
prop> posicao (Pos n (x, y)) (m:rm) =
prop> case m of
prop> N -> posicao (Pos n (x, y + 1)) rm  -- Norte (aumenta y)
prop> S -> posicao (Pos n (x, y - 1)) rm  -- Sul (diminui y)
prop> E -> posicao (Pos n (x + 1, y)) rm  -- Leste (aumenta x)
prop> W -> posicao (Pos n (x - 1, y)) rm  -- Oeste (diminui x)
-}

posicao :: PosicaoPessoa -- ^ Posição inicial
           -> Movimentos -- ^ Sentido de movimento
           -> PosicaoPessoa -- ^ Posição após movimento
posicao (Pos n (x, y)) [] = Pos n (x, y) -- Caso Base posição não muda
posicao (Pos n (x, y)) (m:rm) =
    case m of
        N -> posicao (Pos n (x, y + 1)) rm  -- Norte (aumenta y)
        S -> posicao (Pos n (x, y - 1)) rm  -- Sul (diminui y)
        E -> posicao (Pos n (x + 1, y)) rm  -- Leste (aumenta x)
        W -> posicao (Pos n (x - 1, y)) rm  -- Oeste (diminui x)

{-| A função posicao é uma função que dada uma lista de posições de pessoas, actualiza essa lista depois de 
todas executar um movimento dado:

== Exemplo de utilização:
>>> posicoesM [Pos "Joel" (0,0),Pos "Ellie" (3,2),Pos "Abby" (2,6)] N
[Pos "Joel" (0,1),Pos "Ellie" (3,3),Pos "Abby" (2,7)]

== Propriedades:
prop> posicoesM [] _ = []
prop> posicoesM (Pos n (x, y):rn) m =
prop> case m of
prop> N -> Pos n (x, y + 1) : posicoesM rn m -- Norte (aumenta y)
prop> S -> Pos n (x, y - 1) : posicoesM rn m -- Sul (diminui y)
prop> E -> Pos n (x + 1, y) : posicoesM rn m -- Leste (aumenta x)
prop> W -> Pos n (x - 1, y) : posicoesM rn m -- Oeste (diminui x)
-}

posicoesM :: [PosicaoPessoa] -- ^ Lista de Posições de pessoas
             -> Movimento -- ^ Movimento a realizar
             -> [PosicaoPessoa] -- ^ Lista de Posições de pessoas após movimento
posicoesM [] _ = [] -- Caso Base posição não muda
posicoesM (Pos n (x, y):rn) m =
    case m of
        N -> Pos n (x, y + 1) : posicoesM rn m -- Norte (aumenta y)
        S -> Pos n (x, y - 1) : posicoesM rn m -- Sul (diminui y)
        E -> Pos n (x + 1, y) : posicoesM rn m -- Leste (aumenta x)
        W -> Pos n (x - 1, y) : posicoesM rn m -- Oeste (diminui x)

{-| A função posicoesMs é uma função que dada uma lista de posições de pessoas, actualiza essa lista depois de todas as pessoas
executarem uma mesma sequência de movimentos. Esta função usa as funções anteriormente
definidas.

== Exemplo de utilização:
>>> posicoesMs [Pos "Joel" (0,0),Pos "Ellie" (3,2),Pos "Abby" (2,6)] [N,E]
[Pos "Joel" (1,1),Pos "Ellie" (4,3),Pos "Abby" (3,7)]

== Propriedades:
prop> posicoesMs [] _ = []
prop> posicoesMs (p:ps) m =
prop> let pa = posicao p m
prop> in  pa : posicoesMs ps m
-}

posicoesMs :: [PosicaoPessoa] -- ^ Lista de Posições de pessoas inicial
           -> Movimentos -- ^ Sequência de movimentos a ser executada por todas as pessoas
           -> [PosicaoPessoa] -- ^ Lista de Posições de pessoas após os movimentos
posicoesMs [] _ = []  -- Caso base: lista vazia, não há posições para atualizar
posicoesMs (p:ps) m =
    let pa = posicao p m
    in  pa : posicoesMs ps m

{-| A função pessoasNorte é uma função que calcula quais são as pessoas posicionadas mais a norte.

== Exemplo de utilização:
>>> pessoasNorte [Pos "Joel" (0,0),Pos "Ellie" (3,2),Pos "Abby" (2,6)]
"Abby"

== Propriedades:
prop> pessoasNorte [] = []
prop> pessoasNorte posicoes = aux posicoes [] maxCoordY
prop> where
prop> aux :: [PosicaoPessoa] -> [Nome] -> Int -> [Nome]
prop> aux [] nomes _ = nomes
prop> aux ((Pos nome (x, y)):resto) nomes maxY
prop> | y > maxY = aux resto [nome] y
prop> | y == maxY = aux resto (nome : nomes) maxY
prop> | otherwise = aux resto nomes maxY
prop> maxCoordY :: Int
prop> maxCoordY = maximum [y | (Pos _ (_, y)) <- posicoes]
-}

pessoasNorte :: [PosicaoPessoa] -- ^ Lista de pessoas e respetivas posições
                -> [Nome] -- ^ Nome(s) de pessoa(s) mais a Norte
pessoasNorte [] = []
pessoasNorte posicoes = aux posicoes [] maxCoordY
  where
    aux :: [PosicaoPessoa] -> [Nome] -> Int -> [Nome]
    aux [] nomes _ = nomes
    aux ((Pos nome (x, y)):resto) nomes maxY
        | y > maxY = aux resto [nome] y
        | y == maxY = aux resto (nome : nomes) maxY
        | otherwise = aux resto nomes maxY
    maxCoordY :: Int
    maxCoordY = maximum [y | (Pos _ (_, y)) <- posicoes]

{-| A função dlista é uma função que recebe uma lista e desloca cada elemento da lista, n posições
para a direita. 

== Exemplo de utilização:
>>> dlista 2 [1,2,3,4,5] 
[4,5,1,2,3]

== Propriedades:
prop> dlista _ [] = []
prop> dlista n lista =
prop> let tamanho = length lista
prop> deslocamento = n `mod` tamanho
prop> (inicio, fim) = splitAt (tamanho - deslocamento) lista
prop> in fim ++ inicio
-}

dlista :: Int -- ^ Numero de posições a serem deslocadas
          -> [a] -- ^ Lista inicial
          -> [a] -- ^ Lista após deslocamento
dlista _ [] = []  -- Caso base: lista vazia
dlista n lista =
    let tamanho = length lista
        deslocamento = n `mod` tamanho  -- Garante que o deslocamento seja dentro do tamanho da lista
        (inicio, fim) = splitAt (tamanho - deslocamento) lista
    in fim ++ inicio

{-| A função elista é uma função que recebe uma lista e desloca cada elemento da lista, n posições
para a esquerda. 

== Exemplo de utilização:
>>> dlista 2 [1,2,3,4,5] 
[3,4,5,1,2]

== Propriedades:
prop> dlista _ [] = []
prop> dlista n lista =
prop> let tamanho = length lista
prop> deslocamento = n `mod` tamanho
prop> (inicio, fim) = splitAt deslocamento lista 
prop> in fim ++ inicio
-}

elista :: Int -- ^ Número de posições a serem deslocadas para a esquerda
       -> [a] -- ^ Lista inicial
       -> [a] -- ^ Lista após o deslocamento
elista _ [] = []  -- Caso base: lista vazia
elista n lista =
    let tamanho = length lista
        deslocamento = n `mod` tamanho  -- Garante que o deslocamento seja dentro do tamanho da lista
        (inicio, fim) = splitAt deslocamento lista  -- Divide a lista em duas partes
    in fim ++ inicio









