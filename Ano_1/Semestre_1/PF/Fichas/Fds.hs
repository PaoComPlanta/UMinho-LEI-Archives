module Fds where

-- 1ª Questão --
enumFromTo1 :: Int -> Int -> [Int]
enumFromTo1 start end
    | start > end = []
    | otherwise = start : enumFromTo1 (start + 1) end

-- 2ª Questão --
enumFromThenTo :: Int -> Int -> Int -> [Int]
enumFromThenTo inicio seguinte fim
    | inicio < fim && seguinte < inicio || inicio > fim && seguinte >= inicio = []
    | otherwise = inicio : Prelude.enumFromThenTo seguinte (2*seguinte - inicio) fim

-- 3ª Questão --
(+++) :: [a] -> [a] -> [a]
(+++) [] l = l
(+++) (x:xs) l = x: (+++) xs l

-- 4ª Questão --
(!!!) :: [a] -> Int -> a
(!!!) (x:xs) 0 = x
(!!!) (x:xs) n = (!!!) xs (n-1)

-- 5ª Questão --
myreverse1 :: [a] -> [a]
myreverse1 [] = []
myreverse1 (x:xs) = myreverse1 xs ++ [x]

-- Ou --
myreverse :: [a] -> [a]
myreverse [] = []
myreverse [x] = [x]
myreverse (x:xs) = myreverse xs ++ [x]

-- 6ª Questão -- 
mytake :: Int -> [a] -> [a]
mytake _ [] = []
mytake n (x:xs)
    | n <= 0 = []
    | n == 1 = [x]
    | n > 1 =  x:(mytake (n-1) xs)

-- 7ª Questão
mydrop :: Int -> [a] -> [a]
mydrop _ [] = []
mydrop n (x:xs)
    | n<=0 = (x:xs)
    | otherwise = mydrop (n-1) xs

-- 8ª Questão

myzip :: [a] -> [b] -> [(a,b)]
myzip _ [] = []
myzip [] _ = []
myzip (x:xs) (y:ys) = (x,y) : myzip xs ys

-- 9ª Questão
myreplicate :: Int -> a -> [a]
myreplicate n a
    | n<=0 = []
    | otherwise = a:myreplicate (n-1) a

-- 10ª Questão
myintersperse :: a -> [a] -> [a]
myintersperse _ [] = []
myintersperse _ [x] = [x]
myintersperse c (x:xs) = x:c:myintersperse c xs

-- 11ª Questão
mygroup :: Eq a => [a] -> [[a]]
mygroup [] = []
mygroup [x] = [[x]]
mygroup (x:xs)
    | elem x (head r) = (x : (head r)) : tail r
    | otherwise = [x] : r
    where r = mygroup xs

-- 12ª Questão
myconcat :: [[a]] -> [a]
myconcat [] = []
myconcat [[x]] = [x] -- Não é necessário :)
myconcat (x:xs) = x ++ myconcat xs

-- 13ª Questão
myinits :: [a] -> [[a]]
myinits [] = [[]]
myinits [x] = [[x]] -- Não é necessário :)
myinits l = myinits (init l) ++ [l]

-- 14ª Questão
mytails :: [a] -> [[a]]
mytails [] = [[]]
mytails l = [l] ++ mytails (tail l)

-- 15ª Questão
myheads :: [[a]] -> [a]
myheads [] = []
myheads ([]:xs) = myheads xs
myheads (x:xs) = head x : myheads xs

-- 16ª Questão
total :: [[a]] -> Int
total [] = 0
total (x:xs) = length x + total xs

-- 17ª Questão
fun :: [(a,b,c)] -> [(a,c)]
fun [] = []
fun ((a,b,c):t) = (a,c):fun t

-- 18ª Questão
cola :: [(String,b,c)] -> String
cola [] = []
cola ((s,b,c):t) = s ++ cola t

-- 19ª Questão
idade :: Int -> Int -> [(String,Int)] -> [String]
idade _ _ [] = []
idade a i ((s,n):t)
    | a-n >= i = s:idade a i t
    | otherwise = idade a i t

-- 20ª Questão
myPowerEnumfrom :: Int -> Int -> [Int]
myPowerEnumfrom n 1 = [1]
myPowerEnumfrom n m
    | m > 1 = myPowerEnumfrom n (m-1) ++ [n^(m-1)]
    | otherwise = []

-- 21ª Questão
{- 
myIsPrime :: Int -> Bool
myIsPrime x
    | x < 2 = False
    | otherwise 
-}

isPrime :: Int -> Bool
isPrime n = n >= 2 && primeCheck n 2

primeCheck :: Int -> Int -> Bool
primeCheck n m
    | m * m > n = True
    | mod n m == 0 = False
    | otherwise = primeCheck n (m + 1)

-- 22ª Questão
myIsPrefixOf :: Eq a => [a] -> [a] -> Bool
myIsPrefixOf [] _ = True
myIsPrefixOf _ [] = False
myIsPrefixOf (x:xs) (y:ys) = x == y && myIsPrefixOf xs ys

-- 23ª Questão 
myIsSuffixOf :: Eq a => [a] -> [a] -> Bool
myIsSuffixOf [] _ = True
myIsSuffixOf _ [] = False
myIsSuffixOf (x:xs) (y:ys) = (x:xs) == (y:ys) || myIsSuffixOf (x:xs) ys

-- 24ª Questão
myIsSubsquenceOf :: Eq a => [a] -> [a] -> Bool
myIsSubsquenceOf [] _ = True
myIsSubsquenceOf _ [] = False
myIsSubsquenceOf (x:xs) (y:ys) = x == y && myIsSubsquenceOf xs ys || myIsSubsquenceOf (x:xs) ys

-- 25ª Questão
myElemIndices :: Eq a => a -> [a] -> [Int]
myElemIndices _ [] = []
myElemIndices n l = elemIndicesAux n l 0

elemIndicesAux :: Eq a => a -> [a] -> Int -> [Int]
elemIndicesAux _ [] _ = []
elemIndicesAux n (x:xs) i
    | n == x = i: elemIndicesAux n xs (i+1)
    | otherwise = elemIndicesAux n xs (i+1)

-- 26ª Questão
mynub :: Eq a => [a] -> [a]
mynub [] = []
mynub (x:xs)
    | elem x xs = mynub xs
    | otherwise = x:mynub xs

-- OU --
mynub1 :: Eq a => [a] -> [a]
mynub1 [] = []
mynub1 (x:xs) = x : mynub1 (removeDuplicates x xs)
  where
    removeDuplicates _ [] = []
    removeDuplicates n (y:ys)
      | n == y    = removeDuplicates n ys
      | otherwise = y : removeDuplicates n ys

-- 27ª Questão
mydelete :: Eq a => a -> [a] -> [a]
mydelete _ [] = []
mydelete c (x:xs)
    | c == x = xs
    | otherwise = x:mydelete c xs

-- 28ª Questão
remove :: Eq a => [a] -> [a] -> [a]
remove l [] = l
remove [] _ = []
remove l (h:t) = remove (mydelete h l) t

-- 29ª Questão
myunion :: Eq a => [a] -> [a] -> [a]
myunion l [] = l
myunion l (h:t)
    | h `elem` l = myunion l t
    | otherwise = myunion (l ++ [h]) t

-- 30ª Questão
myIntersect :: Eq a => [a] -> [a] -> [a]
myIntersect l [] = []
myIntersect [] _ = []
myIntersect (x:xs) (y:ys)
    | x `elem` (y:ys) = x : myIntersect xs (y:ys)
    | otherwise = myIntersect xs (y:ys)

-- 31ª Questão
myinsert :: Ord a => a -> [a] -> [a]
myinsert x [] = [x]
myinsert x (a:xs)
    | x < a = x:a:xs
    | x > a = a:myinsert x xs
    | otherwise = a:xs

-- 32ª Questão
myunwords :: [String] -> String
myunwords [] = ""
myunwords [s] = s
myunwords (w:ws) = w ++ " " ++ myunwords ws

-- 33ª Questão
myunlines :: [String] -> String
myunlines [] = ""
myunlines (w:ws) = w ++ "\n" ++ myunlines ws

-- 34ª Questão
pMaior :: Ord a => [a] -> Int
pMaior [_] = 0
pMaior (x:xs)
    | x >= (xs !! y) = 0
    | otherwise = 1 + y
    where y = pMaior xs

-- 35ª Questão
mylookup :: Eq a => a -> [(a,b)] -> Maybe b
mylookup _ [] = Nothing
mylookup c ((x,y):xs)
    | c == x = Just y
    | otherwise = mylookup c xs

-- 36ª Questão
preCrescente :: Ord a => [a] -> [a]
preCrescente [] = []
preCrescente [x] = [x]
preCrescente (x:y:xs)
    | x >= y = [x]
    | otherwise = x:preCrescente (y:xs)

-- 37ª Questão
iSort :: Ord a => [a] -> [a]
iSort [] = []
iSort [x] = [x] -- Não é necessário
iSort (x:xs) = myinsert x (iSort xs)

-- 38ª Questão
menor :: String -> String -> Bool
menor "" _ = True
menor _ "" = False
menor (x:xs) (y:ys)
    | x < y = True
    | x == y = menor xs ys
    | otherwise = False

-- 39ª Questão
elemMSet :: Eq a => a -> [(a,Int)] -> Bool
elemMSet _ [] = False
elemMSet c ((x,n):xs)
    | c == x = True
    | otherwise = elemMSet c xs

-- 40ª Questão
converteMSet :: [(a,Int)] -> [a]
converteMSet [] = []
converteMSet ((x,1):xs) = x:converteMSet xs
converteMSet ((x,n):xs) = x:converteMSet ((x,n-1):xs)

-- 41ª Questão
insereMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
insereMSet a [] = [(a,1)]
insereMSet a ((x,n):xs)
    | a == x = (x,n+1):xs
    | otherwise = (x,n):insereMSet a xs

-- 42ª Questão
removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet _ [] = []
removeMSet a ((x,n):xs)
    | a == x = if n > 1 then (x,n-1):xs else xs
    | otherwise = (x,n):removeMSet a xs

-- 43ª Questão -- Chat GPT Não faço ideia de como se faz :(
{-
constroiMSet :: Ord a => [a] -> [(a,Int)]
constroiMSet [] = []
constroiMSet (x:y:xs)
    | x == y = (x,2+count xs):constroiMSet xs
    | otherwise = (x,1):constroiMSet (y:xs)
    where
        count :: Eq a => [a] -> Int
        count (x:xs)
            | x == head xs = 2 + count xs
            | otherwise = 1
-}

constroiMSet :: Ord a => [a] -> [(a, Int)]
constroiMSet [] = []  -- Caso base: Uma lista vazia resulta em um multiconjunto vazio.
constroiMSet (x:xs) = go x 1 xs
  where
    go y n [] = [(y, n)]  -- Quando a lista é vazia, retornamos o último elemento e sua contagem.
    go y n (z:zs)
      | y == z = go y (n + 1) zs  -- Se encontrarmos o mesmo elemento, incrementamos a contagem e continuamos a verificar o restante da lista.
      | otherwise = (y, n) : go z 1 zs  -- Quando encontramos um elemento diferente, adicionamos o par atual e começamos a contar o novo elemento.

-- OU --
constroiMSet1 [] = []                             
constroiMSet1 (h:t) = constroiMSetAux t [h]       

constroiMSetAux [] acc = [(head acc, length acc)]
constroiMSetAux (h:t) acc
    | h `elem` acc = constroiMSetAux t (h:acc)
    | otherwise = (head acc, length acc) : constroiMSetAux t [h]  

-- 44ª Questão -- decorar pq não sei como fazer
myPartitionEithers :: [Either a b] -> ([a],[b])
myPartitionEithers [] = ([],[])
myPartitionEithers ((Left a):t) = (a:as,bs)
    where (as,bs) = myPartitionEithers t
myPartitionEithers ((Right b):t) = (as,b:bs)
    where (as,bs) = myPartitionEithers t

-- 45ª Questão
myCatMaybes :: [Maybe a] -> [a]
myCatMaybes [] = []
myCatMaybes (Just x:xs) = x:myCatMaybes xs
myCatMaybes (Nothing:xs) = myCatMaybes xs

-- 46ª Questão
data Movimento = Norte | Sul | Este | Oeste
                deriving Show

caminho :: (Int,Int) -> (Int,Int) -> [Movimento]
caminho (x,y) (w,z)
    | x > w = Oeste: caminho (x-1,y) (w,z)
    | x < w = Este: caminho (x+1,y) (w,z)
    | y > z = Sul: caminho (x,y-1) (w,z)
    | y < z = Norte: caminho (x,y+1) (w,z)
    | otherwise = []

-- 47ª Questão
posicao :: (Int,Int) -> [Movimento] -> (Int,Int)
posicao p [] = p
posicao (x,y) (Norte:xs) = posicao (x,y+1) xs
posicao (x,y) (Sul:xs) = posicao (x,y-1) xs
posicao (x,y) (Este:xs) = posicao (x+1,y) xs
posicao (x,y) (Oeste:xs) = posicao (x-1,y) xs

hasLoops :: (Int,Int) -> [Movimento] -> Bool
hasLoops _ [] = False
hasLoops posi movs = posicao posi movs == posi || hasLoops posi (init movs)

-- 48ª Questão 
type Ponto = (Float,Float)
data Rectangulo = Rect Ponto Ponto

contaQuadrados :: [Rectangulo] -> Int
contaQuadrados [] = 0
contaQuadrados (Rect (x,y) (w,z):t)
    | abs (x-w) == abs (y-z) = 1 + contaQuadrados t
    | otherwise = contaQuadrados t

-- 49ª Questão 
areaTotal :: [Rectangulo] -> Float
areaTotal [] = 0
areaTotal (Rect (x,y) (w,z):t) = abs (x-w) * abs (y-z) + areaTotal t

-- 50ª Questão
data Equipamento = Bom | Razoavel | Avariado
                deriving Show

naoReparar :: [Equipamento] -> Int
naoReparar [] = 0
naoReparar (Bom:t) = 1 + naoReparar t
naoReparar (Razoavel:t) = 1 + naoReparar t
naoReparar (Avariado:t) = naoReparar t

-----------------------------------------------------------------------------------

corno:: String -> String
corno "Analisar Vítor" = "O rei dos Cornos"