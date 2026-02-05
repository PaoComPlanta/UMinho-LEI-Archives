module Questoes where

import Prelude hiding (enumFromTo, enumFromThenTo, (++), (!!), reverse, take, drop, zip, replicate, lookup, unlines, unwords, concat)

-- 1. enumFromTo
-- Constrói a lista dos números inteiros compreendidos entre dois limites.
enumFromTo :: Int -> Int -> [Int]
enumFromTo start end
    | start > end = []
    | otherwise   = start : enumFromTo (start + 1) end

-- 2. enumFromThenTo
-- Constrói a lista dos números inteiros compreendidos entre dois limites e espaçados de um valor constante.
enumFromThenTo :: Int -> Int -> Int -> [Int]
enumFromThenTo start next end
    | start > end && next >= start = [] -- Passo positivo mas start > end
    | start < end && next <= start = [] -- Passo negativo mas start < end
    | otherwise = start : enumFromThenTo next (2 * next - start) end

-- 3. (++)
-- Concatena duas listas.
(++) :: [a] -> [a] -> [a]
(++) [] l = l
(++) (h:t) l = h : (++) t l

-- 4. (!!)
-- Calcula o elemento da lista que se encontra numa posição (índice 0).
(!!) :: [a] -> Int -> a
(!!) (h:t) 0 = h
(!!) (h:t) n = (!!) t (n - 1)

-- 5. reverse
-- Calcula uma lista com os elementos pela ordem inversa.
reverse :: [a] -> [a]
reverse [] = []
reverse (h:t) = reverse t ++ [h]

-- 6. take
-- Calcula a lista com os (no máximo) n primeiros elementos.
take :: Int -> [a] -> [a]
take n _ | n <= 0 = []
take _ [] = []
take n (h:t) = h : take (n - 1) t

-- 7. drop
-- Calcula a lista sem os (no máximo) n primeiros elementos.
drop :: Int -> [a] -> [a]
drop n l | n <= 0 = l
drop _ [] = []
drop n (h:t) = drop (n - 1) t

-- 8. zip
-- Constrói uma lista de pares a partir de duas listas.
zip :: [a] -> [b] -> [(a,b)]
zip (x:xs) (y:ys) = (x,y) : zip xs ys
zip _ _ = []

-- 9. replicate
-- Constrói uma lista com n elementos, todos iguais a x.
replicate :: Int -> a -> [a]
replicate 0 _ = []
replicate n x | n > 0 = x : replicate (n - 1) x
replicate _ _ = []

-- 10. intersperse
-- Intercala um elemento entre os elementos da lista.
intersperse :: a -> [a] -> [a]
intersperse _ [] = []
intersperse _ [x] = [x]
intersperse v (h:t) = h : v : intersperse v t

-- 11. group
-- Agrupa elementos iguais e consecutivos de uma lista.
group :: Eq a => [a] -> [[a]]
group [] = []
group (h:t) = (h : takeWhile (== h) t) : group (dropWhile (== h) t)
    where
        takeWhile _ [] = []
        takeWhile p (x:xs) = if p x then x : takeWhile p xs else []
        dropWhile _ [] = []
        dropWhile p (x:xs) = if p x then dropWhile p xs else x:xs

-- 12. concat
-- Concatena as listas de uma lista.
concat :: [[a]] -> [a]
concat [] = []
concat (h:t) = h ++ concat t

-- 13. inits
-- Calcula a lista dos prefixos de uma lista.
inits :: [a] -> [[a]]
inits [] = [[]]
inits l = inits (init l) ++ [l]
    where init [x] = []
          init (x:xs) = x : init xs

-- 14. tails
-- Calcula a lista dos sufixos de uma lista.
tails :: [a] -> [[a]]
tails [] = [[]]
tails l@(_:t) = l : tails t

-- 15. heads
-- Recebe uma lista de listas e produz a lista com o primeiro elemento de cada lista.
heads :: [[a]] -> [a]
heads [] = []
heads ([]:t) = heads t
heads ((x:xs):t) = x : heads t

-- 16. total
-- Conta o total de elementos (de todas as listas).
total :: [[a]] -> Int
total [] = 0
total (h:t) = length h + total t
    where length [] = 0
          length (_:xs) = 1 + length xs

-- 17. fun
-- Recebe lista de triplos e produz lista de pares com o 1º e 3º elemento.
fun :: [(a,b,c)] -> [(a,c)]
fun [] = []
fun ((a,_,c):t) = (a,c) : fun t

-- 18. cola
-- Recebe lista de triplos e concatena as strings da 1ª componente.
cola :: [(String,b,c)] -> String
cola [] = ""
cola ((s,_,_):t) = s ++ cola t

-- 19. idade
-- Devolve nomes das pessoas que num dado ano atingirão ou ultrapassarão uma idade.
idade :: Int -> Int -> [(String, Int)] -> [String]
idade _ _ [] = []
idade ano ref ((nome, nasc):t)
    | (ano - nasc) >= ref = nome : idade ano ref t
    | otherwise = idade ano ref t

-- 20. powerEnumFrom
-- Constrói a lista [n^0, ..., n^(m-1)].
powerEnumFrom :: Int -> Int -> [Int]
powerEnumFrom n m = aux n m 0
    where aux _ 0 _ = [] -- Se m=0 lista vazia? O enunciado diz m-1, assumimos m elementos
          aux base limit exp
            | exp >= limit = []
            | otherwise = (base ^ exp) : aux base limit (exp + 1)

-- 21. isPrime
-- Determina se um número inteiro >= 2 é primo.
isPrime :: Int -> Bool
isPrime n
    | n < 2 = False
    | otherwise = not (temDivisores n 2)
    where temDivisores val div
            | div * div > val = False
            | mod val div == 0 = True
            | otherwise = temDivisores val (div + 1)

-- 22. isPrefixOf
-- Testa se uma lista é prefixo de outra.
isPrefixOf :: Eq a => [a] -> [a] -> Bool
isPrefixOf [] _ = True
isPrefixOf _ [] = False
isPrefixOf (x:xs) (y:ys) = x == y && isPrefixOf xs ys

-- 23. isSuffixOf
-- Testa se uma lista é sufixo de outra.
isSuffixOf :: Eq a => [a] -> [a] -> Bool
isSuffixOf [] _ = True
isSuffixOf _ [] = False
isSuffixOf l1 l2@(y:ys)
    | l1 == l2 = True
    | otherwise = isSuffixOf l1 ys

-- 24. isSubsequenceOf
-- Testa se os elementos de uma lista ocorrem noutra pela mesma ordem relativa.
isSubsequenceOf :: Eq a => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True
isSubsequenceOf _ [] = False
isSubsequenceOf (x:xs) (y:ys)
    | x == y    = isSubsequenceOf xs ys
    | otherwise = isSubsequenceOf (x:xs) ys

-- 25. elemIndices
-- Calcula a lista de posições em que um dado elemento ocorre numa lista.
elemIndices :: Eq a => a -> [a] -> [Int]
elemIndices x l = aux x l 0
    where aux _ [] _ = []
          aux v (h:t) i
            | v == h    = i : aux v t (i+1)
            | otherwise = aux v t (i+1)

-- 26. nub
-- Calcula uma lista sem repetições.
nub :: Eq a => [a] -> [a]
nub [] = []
nub (h:t)
    | h `elem` t = nub t -- Nota: O nub do Data.List preserva a primeira ocorrência.
                         -- Esta implementação simplificada preserva a última se fizermos assim.
                         -- Para preservar a primeira como no exemplo [1,2,1,2,3,1,2] -> [1,2,3]:
    | otherwise  = h : nub t
    where elem _ [] = False
          elem x (y:ys) = x == y || elem x ys
-- Correção para o nub funcionar como standard (preservar primeira):
nub' :: Eq a => [a] -> [a]
nub' [] = []
nub' (h:t) = h : nub' (filter (/= h) t)
    where filter _ [] = []
          filter p (x:xs) = if p x then x : filter p xs else filter p xs

-- 27. delete
-- Remove a primeira ocorrência de um dado elemento.
delete :: Eq a => a -> [a] -> [a]
delete _ [] = []
delete x (h:t)
    | x == h    = t
    | otherwise = h : delete x t

-- 28. (\\)
-- Remove (as primeiras ocorrências) dos elementos da segunda lista da primeira.
(\\) :: Eq a => [a] -> [a] -> [a]
(\\) l [] = l
(\\) l (h:t) = (\\) (delete h l) t

-- 29. union
-- Acrescenta à primeira lista os elementos da segunda que não ocorrem na primeira.
union :: Eq a => [a] -> [a] -> [a]
union l [] = l
union l (h:t)
    | h `elem` l = union l t
    | otherwise  = union (l ++ [h]) t
    where elem _ [] = False
          elem x (y:ys) = x == y || elem x ys

-- 30. intersect
-- Retorna a lista resultante de remover da 1ª lista os elementos que não pertencem à 2ª.
intersect :: Eq a => [a] -> [a] -> [a]
intersect [] _ = []
intersect (h:t) l2
    | h `elem` l2 = h : intersect t l2
    | otherwise   = intersect t l2
    where elem _ [] = False
          elem x (y:ys) = x == y || elem x ys

-- 31. insert
-- Insere ordenadamente um elemento numa lista ordenada.
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (h:t)
    | x <= h    = x : h : t
    | otherwise = h : insert x t

-- 32. unwords
-- Junta strings separando por espaço.
unwords :: [String] -> String
unwords [] = ""
unwords [x] = x
unwords (h:t) = h ++ " " ++ unwords t

-- 33. unlines
-- Junta strings separando por '\n'.
unlines :: [String] -> String
unlines [] = ""
unlines (h:t) = h ++ "\n" ++ unlines t

-- 34. pMaior
-- Retorna a posição do maior elemento (lista não vazia).
pMaior :: Ord a => [a] -> Int
pMaior [_] = 0
pMaior (h:t)
    | h >= (t !! p) = 0
    | otherwise     = 1 + p
    where p = pMaior t

-- 35. lookup
-- Retorna elemento associado a uma chave (Maybe).
lookup :: Eq a => a -> [(a,b)] -> Maybe b
lookup _ [] = Nothing
lookup key ((k,v):t)
    | key == k  = Just v
    | otherwise = lookup key t

-- 36. preCrescente
-- Calcula o maior prefixo crescente de uma lista.
preCrescente :: Ord a => [a] -> [a]
preCrescente [] = []
preCrescente [x] = [x]
preCrescente (x:y:t)
    | y >= x    = x : preCrescente (y:t)
    | otherwise = [x]

-- 37. iSort
-- Ordena uma lista (Insertion Sort). usa a função insert definida em 31.
iSort :: Ord a => [a] -> [a]
iSort [] = []
iSort (h:t) = insert h (iSort t)

-- 38. menor
-- Retorna True se a primeira string for menor (lexicograficamente) que a segunda.
menor :: String -> String -> Bool
menor "" "" = False
menor "" _ = True
menor _ "" = False
menor (x:xs) (y:ys)
    | x < y = True
    | x > y = False
    | otherwise = menor xs ys

-- 39. elemMSet
-- Testa se um elemento pertence a um multi-conjunto.
elemMSet :: Eq a => a -> [(a,Int)] -> Bool
elemMSet _ [] = False
elemMSet x ((a,_):t) = x == a || elemMSet x t

-- 40. converteMSet
-- Converte um multi-conjunto na lista dos seus elementos.
converteMSet :: [(a,Int)] -> [a]
converteMSet [] = []
converteMSet ((x,n):t) = replicate n x ++ converteMSet t

-- 41. insereMSet
-- Acrescenta um elemento a um multi-conjunto.
insereMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
insereMSet x [] = [(x,1)]
insereMSet x ((a,n):t)
    | x == a    = (a,n+1) : t
    | otherwise = (a,n) : insereMSet x t

-- 42. removeMSet
-- Remove um elemento do multi-conjunto.
removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet _ [] = []
removeMSet x ((a,n):t)
    | x == a = if n > 1 then (a,n-1):t else t
    | otherwise = (a,n) : removeMSet x t

-- 43. constroiMSet
-- Dada uma lista ordenada, calcula o multi-conjunto.
constroiMSet :: Ord a => [a] -> [(a,Int)]
constroiMSet [] = []
constroiMSet (h:t) = (h, 1 + length (takeWhile (== h) t)) : constroiMSet (dropWhile (== h) t)
    where
        takeWhile _ [] = []
        takeWhile p (x:xs) = if p x then x : takeWhile p xs else []
        dropWhile _ [] = []
        dropWhile p (x:xs) = if p x then dropWhile p xs else x:xs

-- 44. partitionEithers
-- Divide uma lista de Eithers em duas listas.
partitionEithers :: [Either a b] -> ([a], [b])
partitionEithers [] = ([],[])
partitionEithers (h:t) = case h of
    Left a  -> (a:l1, l2)
    Right b -> (l1, b:l2)
    where (l1,l2) = partitionEithers t

-- 45. catMaybes
-- Colecciona os elementos do tipo a de uma lista [Maybe a].
catMaybes :: [Maybe a] -> [a]
catMaybes [] = []
catMaybes (Just x : t) = x : catMaybes t
catMaybes (Nothing : t) = catMaybes t

-- 46. caminho
data Movimento = Norte | Sul | Este | Oeste deriving Show

caminho :: (Int, Int) -> (Int, Int) -> [Movimento]
caminho (xi, yi) (xf, yf)
    | yi < yf = Norte : caminho (xi, yi+1) (xf, yf)
    | yi > yf = Sul   : caminho (xi, yi-1) (xf, yf)
    | xi < xf = Este  : caminho (xi+1, yi) (xf, yf)
    | xi > xf = Oeste : caminho (xi-1, yi) (xf, yf)
    | otherwise = []

-- 47. hasLoops
-- Verifica se o robot volta a passar pela posição inicial.
-- Auxiliar para calcular nova posição
posicao :: (Int, Int) -> Movimento -> (Int, Int)
posicao (x,y) Norte = (x, y+1)
posicao (x,y) Sul   = (x, y-1)
posicao (x,y) Este  = (x+1, y)
posicao (x,y) Oeste = (x-1, y)

hasLoops :: (Int, Int) -> [Movimento] -> Bool
hasLoops _ [] = False
hasLoops start (m:ms) = (pos == start) || hasLoops start ms
    where pos = posicao start m 
          -- Nota: O enunciado sugere verificar ao longo do percurso. 
          -- A lógica acima testa apenas se o PRIMEIRO passo volta ao início (o que é impossível num passo só se forem diferentes)
          -- A lógica correta requer rastrear o estado acumulado:
hasLoops' :: (Int, Int) -> [Movimento] -> Bool
hasLoops' _ [] = False
hasLoops' start ms = aux start ms start
    where aux _ [] _ = False
          aux curr (m:ms) origin
            | next == origin = True
            | otherwise      = aux next ms origin
            where next = posicao curr m

-- 48. contaQuadrados
type Ponto = (Float, Float)
data Rectangulo = Rect Ponto Ponto

contaQuadrados :: [Rectangulo] -> Int
contaQuadrados [] = 0
contaQuadrados ((Rect (x1,y1) (x2,y2)):t)
    | abs (x2 - x1) == abs (y2 - y1) = 1 + contaQuadrados t
    | otherwise = contaQuadrados t

-- 49. areaTotal
areaTotal :: [Rectangulo] -> Float
areaTotal [] = 0
areaTotal ((Rect (x1,y1) (x2,y2)):t) = abs (x2 - x1) * abs (y2 - y1) + areaTotal t

-- 50. naoReparar
data Equipamento = Bom | Razoavel | Avariado deriving Show

naoReparar :: [Equipamento] -> Int
naoReparar [] = 0
naoReparar (Avariado:t) = naoReparar t
naoReparar (_:t) = 1 + naoReparar t