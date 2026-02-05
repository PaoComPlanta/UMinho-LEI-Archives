{-|
Module : Aula3
Description : Módulo Haskell contendo exemplos de funções recursivas
Copyright : (c) Simão Mendes <a106928@alunos.uminho.pt>

Este módulo contém definições Haskell para o cálculo de funções
recursivas simples (obs: isto é apenas uma descrição mais
longa do módulo para efeitos de documentação...).
-}

module Aula3 where
import Data.Char
{-| A função 'adicionaLista' recebe uma lista de inteiros e um número inteiro 'n',
e retorna uma nova lista onde cada elemento da lista original foi somado a 'n'.

== Exemplos de utilização:
>>> adicionaLista [1, 2, 3, 4] 5
[6,7,8,9]
>>> adicionaLista [] 10
[]
-}

adicionaLista :: [Int] -- ^ Lista de Inteiros.
                  -> Int -- ^ Valor a ser adicionado a cada elemento.
                  -> [Int] -- ^ Lista resultante após adicionar o valor.
adicionaLista [] _ = []  -- ^ Caso base: Lista vazia, retorna lista vazia.
adicionaLista (x:xs) n = (x + n) : adicionaLista xs n  -- ^ Adiciona 'n' ao primeiro elemento e recursivamente ao restante da lista.

{-| A função 'removeString' recebe uma lista de strings e um caractere.
Ela retorna uma nova lista de strings onde todas as strings que começam com o
caractere dado foram removidas.

== Exemplos de utilização:
>>> removeString ["abc", "def", "ghi", "jkl"] 'd'
["abc","ghi","jkl"]
>>> removeString ["abacaxi", "banana", "pessego", "maracuja"] 'a'
["banana","pessego","maracuja"]
-}

removeString :: [String] -- ^ Lista de Strings.
                -> Char -- ^ Caracter a verificar e a remover no caso da String começar por esse caractere.
                -> [String] -- ^ Lista resultante da remoção das strings iniciadas pelo caratere anterior.
removeString [] _ = [] -- ^ Caso base: Lista vazia, retorna lista vazia.
removeString (h:t) c
    | h == [] = h : removeString t c -- ^ Mantém a string se o primeiro elemento é lista vazia.
    | c == head h = removeString t c -- ^ Remove a string se começa com o caractere. 
    | otherwise = h : removeString t c -- ^ Mantém a string se não começa com o caractere.

{-| A função 'somaPar' recebe uma lista de pares de inteiros e um valor 'n'.
Ela retorna uma nova lista de pares onde 'n' foi adicionado à primeira componente de cada par.

== Exemplos de utilização:
>>> somaPar [(1, 2), (3, 4), (5, 6)] 10
[(11,2),(13,4),(15,6)]
>>> somaPar [] 5
[]
-}

somaPar :: [(Int, Int)] -- ^ Lista de pares de inteiros.
            -> Int -- ^ Valor inteiro a adicionar à primeira componente de cada par de inteiros. 
            -> [(Int, Int)] -- ^ Lista de pares de inteiros resultante da adição do Inteiro à primeira componente de cada par.
somaPar [] _ = [] -- ^ Caso base: Lista vazia e qualquer número inteiro retorna lista vazia.
somaPar ((x,y):xs) n = (x+n, y) : somaPar xs n -- ^ Soma do número inteiro à primeira componente de cada par de inteiro, não se verificando o caso base.

{-| A função 'maiorSegundaComponente' recebe uma lista não vazia de pares de inteiros.
Ela retorna o maior valor encontrado na segunda componente dos pares.

== Exemplos de utilização:
>>> maiorSegundaComponente [(1, 5), (3, 9), (2, 7)]
9
-}

-- A lista é não vazia
maiorSegundaComponente :: [(Int,Int)] -- ^ Lista de Pares de Inteiros
                            -> Int -- ^ Valor inteiro que corresponde ao maior valor encontrado na segunda componente dos pares.
maiorSegundaComponente [(x,y)] = y -- ^ Caso Base:  Se a lista (que é não vazia) tem apenas um par de Inteiros, retorna a segunda componente desse par de inteiros.
maiorSegundaComponente ((x,y):xs)
    |y > maiorSegundaComponente xs = y
    |otherwise = maiorSegundaComponente xs

-- recebe digitos
{-| A função ´proxdig´ é uma função que recebe um digíto e calcula o próximo dígito

== Exemplo de utilização:
>>> proxdig 2
3

== Propriedades:
prop> proxdig a
prop> | ord a == 57 = '0'
prop> | otherwise = chr (ord a + 1)
-}

nextDigit :: Char -- ^ Dígito.
             -> Char -- ^ Dígito seguinte.
nextDigit '9' = '0'
nextDigit c = chr ((ord c) + 1)
{-
nextVogal :: Char -> Char
nextVogal c  -- | elem c  "aeiou"
    |'a' = 'e'
    |'e' = 'i'
-}
-- ........
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
proxdigl (a:as) = (nextDigit a) : proxdigl as

{-| A função 'nextVogal' recebe um caractere e retorna a próxima vogal após esse caractere,
considerando que a próxima vogal após 'u' é 'a'.
Caso o caractere não seja uma vogal ('aeiou'), a função mantém o caractere original.

==== Exemplo de Uso
>>> nextVogal 'e'
'i'
>>> nextVogal 'i'
'o'

== Propriedades
prop> nextVogal 'a' = 'e'
prop> nextVogal 'e' = 'i'
-}
nextVogal :: Char -> Char
nextVogal c = aux c "aeiou"
    where aux :: Char -> String -> Char
          aux c s
            | c == head s = head (tail s)
            |otherwise = aux c (tail s)

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

---------------------- " ------------ " -----------------------"-------------------------"-------------------------------   
type Nome = String
type Coordenada = (Int, Int)
data Movimento= N | S | E | W deriving (Show,Eq) -- norte, sul, este, oeste
type Movimentos = [Movimento]
data PosicaoPessoa = Pos Nome Coordenada deriving (Show,Eq)

{-| A função 'posicao' calcula a posição de uma pessoa depois de 
executar uma sequência de movimentos:

@
posicao :: PosicaoPessoa
             -> Movimentos
             -> PosicaoPessoa
posicao (Pos n (x,y)) [] = Pos n (x,y)
posicao (Pos n (x,y)) (m:ms) =
    case m of
        N -> posicao (Pos n (x,y+1)) ms
        S -> posicao (Pos n (x, y-1)) ms
        E -> posicao (Pos n (x+1,y)) ms 
        W -> posicao (Pos n (x-1,y)) ms
@ 

== Exemplos de utilização:
>>> posicao (Pos "Josuke" (1,2)) [N,E]-}

posicao :: PosicaoPessoa -- ^ Posição inicial. 
             -> Movimentos -- ^ Sentido dos movimentos
             -> PosicaoPessoa -- ^ Posição após ocorrer movimento
posicao (Pos n (x,y)) [] = Pos n (x,y) -- ^ Caso base: Não existe movimento (Posição inicial não muda)
posicao (Pos n (x,y)) (m:ms) =
    case m of
        N -> posicao (Pos n (x,y+1)) ms -- ^ Norte (aumenta y uma unidade)
        S -> posicao (Pos n (x, y-1)) ms -- ^ Sul (diminui y uma unidade)
        E -> posicao (Pos n (x+1,y)) ms -- ^ Este (aumenta x uma unidade)
        W -> posicao (Pos n (x-1,y)) ms -- ^ Oeste (diminui x uma unidade)

-- Dava para fazer também com Guardas --

{-| A função 'posicoesM' é uma função que dada uma lista de posições de pessoas, actualiza essa lista depois de 
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

-- forma alternativa --

posicoesM' :: [PosicaoPessoa] -- ^ Lista de Posições de pessoas
             -> Movimento -- ^ Movimento a realizar
             -> [PosicaoPessoa] -- ^ Lista de Posições de pessoas após movimento
posicoesM' [] _ = [] -- Caso Base posição não muda
posicoesM' (p:lp) m = posicao p [m] : posicoesM' lp m


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

-- Fazer outra maneira em casa

posicoesMs' :: [PosicaoPessoa] -> Movimentos -> [PosicaoPessoa]
posicoesMs' lposicoes [] = lposicoes
posicoesMs' lposicoes (m:lm) = posicoesMs' (posicoesM lposicoes m) lm

posicoesMs'' :: [PosicaoPessoa] -> Movimentos -> [PosicaoPessoa]
posicoesMs'' [] _ = []
posicoesMs'' (p:ps) lm = posicao p lm : posicoesMs'' ps lm 

-- Estudar estes dois casos.

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
---------------"------------------"-------------------"-------------------"------
deslocaEsquerda :: [a] -> [a]
deslocaEsquerda [] =[]
deslocaEsquerda (x:xs) = xs ++ [x]

deslocaEsquerdaN :: [a] -> Int -> [a]
deslocaEsquerdaN [] _ = []
deslocaEsquerdaN l 0 = l
deslocaEsquerdaN l n = deslocaEsquerdaN (deslocaEsquerda l) (n-1)
-- | Desloca uma posição para a direita
deslocaDireita :: [a] -> [a]
deslocaDireita [] = []
deslocaDireita l = last l: init l
{-|
== Exemplos de utilização:
>>> deslocaDireitaN [1,2,3,4] 2 
[3,4,1,2]
-}
deslocaDireitaN :: [a] -> Int -> [a]
deslocaDireitaN [] _ = []
deslocaDireitaN l 0 = l
deslocaDireitaN l n = deslocaDireitaN (deslocaDireita l) (n-1) 

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

-- Rever a partir da função posição -- 

-- | Lista não vazia.
coordenadaNorte ::  [PosicaoPessoa] -> Coordenada
coordenadaNorte [Pos n (x,y)] = (x,y)
coordenadaNorte ((Pos n (x,y)):lp) = 
    let (xn,yn) = coordenadaNorte lp
    in if y >= yn then (x,y) else (xn,yn)

coordenadaNorte' ::  [PosicaoPessoa] -> Coordenada
coordenadaNorte' [Pos n (x,y)] = (x,y)
coordenadaNorte' ((Pos n (x,y)):(Pos n1 (x1,y1)):lp)
    | y>y1 = coordenadaNorte' ((Pos n (x,y)):lp)
    | otherwise  = coordenadaNorte' ((Pos n1 (x1,y1)):lp)

