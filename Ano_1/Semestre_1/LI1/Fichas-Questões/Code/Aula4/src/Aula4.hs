{-|
Module : Aula4
Description : Módulo Haskell contendo exemplos de funções recursivas
Copyright : (c) Simão Mendes <a106928@alunos.uminho.pt>

Este módulo contém definições Haskell para o cálculo de funções
recursivas simples (obs: isto é apenas uma descrição mais
longa do módulo para efeitos de documentação...).
-}
module Aula4 where
import Test.HUnit
{-| A função 'nota' recebe uma lista de Floats (notasAvaliacao) e um número Float 'notaProjeto',
e retorna um número Float 'notafinal'. A função permite calcular a nota final de um aluno a uma unidade curricular, sabendo que
a avaliação contínua vale 40% da nota final e que a avaliação do projeto vale 60%. A
avaliação contínua obtém-se somando uma lista de 10 momentos de avaliação, valendo
cada um 2 valores. 

== Exemplos de utilização:
>>> nota [2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0] 20.0
20.0
>>> nota [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0] 10.0
10.0
-}
nota :: [Float] -- ^ Lista de Floats que corresponde à Avaliação contínua (10 momentos - 10 elementos).
        -> Float -- ^ Valor da nota do projeto.
        -> Float -- ^ Valor da nota Final.
nota notasAvaliacao notaProjeto =
    let 
        somaListas :: [Float] -- ^ Lista de Floats.
                      -> Float -- ^ Soma dos elementos da lista de Floats.
        somaListas [] = 0.0 -- ^ A soma dos elementos de uma lista vazia é igual a 0.
        somaListas (x:xs) = x + somaListas xs 

        somaAvaliacao = somaListas notasAvaliacao  -- ^ Calcula a soma das notas de avaliação contínua
        notaFinal = (0.4 * somaAvaliacao) + (0.6 * notaProjeto)  -- ^ Calcula a nota final
    in 
        notaFinal

{-| A função 'trocarLinhasRecursivamentre' recebe uma matriz e retorna outra matriz que é resultado da troca da
primeira linha com a última. 

== Exemplos de utilização:
>>> trocarLinhasRecursivamente [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
[[7, 8, 9], [4, 5, 6], [1, 2, 3]]
>>> trocarLinhasRecursivamente []
[]
-}

trocarLinhasRecursivamente :: [[a]] -- ^ Matriz inicial. 
                              -> [[a]] -- ^ Matriz final (troca da primeira com a última linha).
trocarLinhasRecursivamente matriz
    | null matriz = []  -- ^ Matriz vazia, retorna matriz vazia.
    | length matriz == 1 = matriz  -- ^ Matriz com apenas uma linha, não há o que trocar.
    | otherwise = (last matriz) : (init (tail matriz)) ++ [head matriz]

{-| A função 'tradeColunasRecursivamentre' recebe uma matriz e retorna outra matriz que é resultado da troca da
primeira coluna com a última. 

== Exemplos de utilização:
>>> tradeColunasRecursivamente [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
[[3, 2, 1], [6, 5, 4], [9, 8, 7]]
>>> tradeColunasRecursivamente []
[]
-}

tradeColunasRecursivamente :: [[a]] -- ^ Matriz inicial. 
                              -> [[a]] -- ^ Matriz final (troca da primeira com a última coluna).
tradeColunasRecursivamente [] = []  -- ^ Matriz vazia, retorna matriz vazia.
tradeColunasRecursivamente matriz = [trocarColunasLinha linha | linha <- matriz]
    where
        trocarColunasLinha :: [a] -- ^ Linha da matriz.
                              -> [a] -- ^ Linha da matriz com o primeiro e o último elemento trocados.
        trocarColunasLinha [] = []  -- ^ Linha vazia, retorna linha vazia.
        trocarColunasLinha (x:xs) = (last xs : init xs) ++ [x]

{-| A função 'posicao' procura a posição de um elemento numa lista (posição
da primeira ocorrência). Devolve (-1) caso o elemento não ocorra na lista. O índice de
posições começa em zero.

== Exemplos de utilização:
>>> posicao [1, 2, 3, 4, 5] 3
2
>>> tradeColunasRecursivamente [] 5
-1
-}

posicao :: [a] -- ^ Lista onde se vai procurar o elemento.
            -> (Eq a) => a -- ^ Elemento a ser procurado.
            -> Int -- ^ Posição de primeira ocorrência do elemento procurado na lista.
posicao [] _ = -1 -- ^ Caso base: Lista vazia, retorna -1.
posicao (x:xs) c 
    |x == c = 0 -- ^ Elemento a ser procurado é igual ao primeiro elemento da lista.
    |otherwise = if posicao xs c /= -1 then posicao xs c +1 else -1

{-| A função 'substituir' psubstitui um elemento de uma posição numa lista, por
outro valor dado.

== Exemplos de utilização:
>>> substituir "abcdefg" 3 'X'
"abcXefg"
>>> substituir [] 5 'X'
-1
-}

substituir :: [a] -- ^ Lista inicial de elementos.
              -> Int -- ^ Posição do elemento que se pretende substituir.
              -> (Eq a) => a -- ^  Elemento que se pretende inserir na lista no lugar do que vai ser substituido.
              -> [a] -- ^ Lista final com a substituição de elementos efetuada.
substituir [] _ _ = [] -- ^ Caso base: Lista vazia, retorna lista vazia.
substituir (x:xs) n c
    | n == 0 = c : xs  -- ^ Quando n é 0, substitui o elemento atual por 'c'.
    | otherwise = x : substituir xs (n - 1) c  -- ^ Continua recursivamente para a próxima posição.

-- A professora fez sem recursividade -- 