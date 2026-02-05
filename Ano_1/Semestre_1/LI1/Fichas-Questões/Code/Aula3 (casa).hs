-- Checkar o manual do Haddock
{-|
Module : Aula3
Description : Módulo Haskell contendo exemplos de funções recursivas
Copyright : (c) Alguém <alguem@algures.com>;
Outro alguém <outro@algures.com>
Este módulo contém definições Haskell para o cálculo de funções
recursivas simples (obs: isto é apenas uma descrição mais
longa do módulo para efeitos de documentação...).
-}
module Aula3 where

{-| A função 'lista' recebe uma lista de inteiros e um número inteiro 'n',
e retorna uma nova lista onde cada elemento da lista original foi somado a 'n'.

== Exemplos de utilização:
>>> lista [1, 2, 3, 4] 5
[6,7,8,9]
>>> lista [] 10
[]
|-}

lista :: [Int] -> Int -> [Int]
lista [] _ = []  -- Caso base: Lista vazia, retorna lista vazia.
lista (x:xs) n = (x + n) : lista xs n  -- Adiciona 'n' ao primeiro elemento e recursivamente ao restante da lista.

{-| A função 'removeStringsIniciadasPor' recebe uma lista de strings e um caractere.
--   Ela retorna uma nova lista de strings onde todas as strings que começam com o
--   caractere dado foram removidas.
--
--   == Exemplos de utilização:
--   >>> removeStringsIniciadasPor ["abc", "def", "ghi", "jkl"] 'd'
--   ["abc","ghi","jkl"]
--   >>> removeStringsIniciadasPor ["abacaxi", "banana", "pessego", "maracuja"] 'a'
--   ["banana","pessego","maracuja"]
|-}

removeString :: [String] -> Char ->[String]
removeString [] _ = []  -- Caso base: Lista vazia, retorna lista vazia.
removeString (x:xs) c
    | head x == c = removeString xs c  -- Remove a string se começa com o caractere.
    | otherwise = x : removeString xs c  -- Mantém a string se não começa com o caractere.


{-| A função 'somaPar' recebe uma lista de pares de inteiros e um valor 'n'.
--   Ela retorna uma nova lista de pares onde 'n' foi adicionado à primeira componente de cada par.
--
--   == Exemplos de utilização:
--   >>> adicionarValor [(1, 2), (3, 4), (5, 6)] 10
--   [(11,2),(13,4),(15,6)]
--   >>> adicionarValor [] 5
--   []
|-}

somaPar :: [(Int, Int)] -> Int -> [(Int, Int)]
somaPar [] _ = []  -- Caso base: Lista vazia, retorna lista vazia.
somaPar ((x, y):xs) n = (x + n, y) : somaPar xs n -- Adiciona 'n' à primeira componente e recursão na lista restante.

{-| A função 'maiorSegundaComponente' recebe uma lista não vazia de pares de inteiros.
--   Ela retorna o maior valor encontrado na segunda componente dos pares.
--
--   == Exemplos de utilização:
--   >>> maiorSegundaComponente [(1, 5), (3, 9), (2, 7)]
--   9
|-}

maiorSegundaComponente :: [(Int, Int)] -> Int
maiorSegundaComponente [(x, y)] = y  -- Caso base: Lista com um único par.
maiorSegundaComponente ((x, y):xs)
    | y > maiorSegundaComponente xs = y  -- Se a segunda componente é maior que o maior do resto.
    | otherwise = maiorSegundaComponente xs -- Caso contrário, mantém o maior do resto.



