module ExerciciosAulas where
import System.Random (randomRIO)

-- Teste de PF 2022/2023 (alguns)

type Mat = [[Int]]

stringToMat :: String -> Mat
stringToMat s = map stringToVector (lines s)

stringToVector :: String -> [Int]
stringToVector l = read ("[" ++ l ++ "]")

-- 3) 
data Lista a = Esq a (Lista a) 
             | Dir (Lista a) a 
             | Nula
            
lista1 = Esq 5 (Dir (Dir (Esq 2 Nula) 3) 10)

semUltimo :: Lista a -> Lista a 
semUltimo (Esq x Nula) = Nula
semUltimo (Esq x l) = Esq x (semUltimo l)
semUltimo (Dir l x) = semUltimo l 
{-
instance Show a => Show (Lista a) where
    show :: Lista a -> String 
    show l = show (conv l)
-}
conv :: Lista a -> [a]
conv Nula = []
conv (Esq x l) = x : conv l
conv (Dir l x) = conv l ++ [x]

-- 4)
data BTree a = Empty 
             | Node a (BTree a) (BTree a)
            deriving Show


numera :: BTree a -> BTree (a,Int)
numera arv = snd (numeraAux 1 arv)

numeraAux :: Int -> BTree a -> (Int, BTree (a,Int))
numeraAux n Empty = (0,Empty)
numeraAux n (Node x e d) = let  (ne,e1) = numeraAux n e 
                                (nd,d1) = numeraAux (n + ne + 1) d 
                           in   (ne+nd+1, Node (x,n+ne) e1 d1)

inorder :: BTree a -> [a]
inorder Empty = []
inorder (Node r e d) = (inorder e) ++ (r:inorder d)

unInorder :: [a] -> [BTree a]
unInorder [] = [Empty]
unInorder l = [Node x e d | (l1,x,l2) <- parte l,
                             e <- unInorder l1,
                             d <- unInorder l2]

parte :: [a] -> [([a],a,[a])]
parte [] = []
parte (h:t) = ([],h,t) : [(h:a,b,c) | (a,b,c) <- parte t]

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Dúvidas 
type Nome = String
type Telefone = Integer
data Agenda = Vazia 
            | Nodo (Nome,[Telefone]) Agenda Agenda


ag1 = Nodo ("Maria", [965432323, 253253253])
           (Nodo ("Ana", [123123123, 456456456]) Vazia Vazia)
           (Nodo ("Joao", [876876876, 987987987]) Vazia Vazia)

instance Show Agenda where
    show Vazia = ""
    show (Nodo (nome, lista) e d) = show e ++ nome ++ " " ++ aux lista ++ show d

aux :: [Integer] -> String
aux [] = "\n"
aux [x] = show x ++ "\n"
aux (x:xs) = show x ++ " / " ++ aux xs 

-- Não está a dar ns porquê (acima)

randomSel :: Int -> [a] -> IO [a]
randomSel 0 lista = return []
randomSel n [] = return []
randomSel n l = do p <- randomRIO (0, (length l) -1)
                   let (l1, x:l2) = splitAt p l 
                   r <- randomSel (n-1) (l1++l2)
                   return (x:r)
{-
organiza :: Eq a => [a] -> [(a,[Int])]
organiza l = organizaAux l [] 0 

organizaAux :: Eq a => [a] -> [a] -> [(a,[Int])]
organizaAux [] ac _  = ac
organizaAux (x:xs) ac p
    | esta x ac = organizaAux xs ac (p+1)
    | otherwise = organizaAux ((x,ocx):ac) (p+1)
    where ocx = listaPos x (x:xs) p

esta :: Eq a => a -> [(a,[Int])] -> Bool
esta x [] = False 
esta x ((y,_):t) = x == y || esta x t

listaPos :: Eq a => a -> [a] -> Int -> [Int]
listaPos x (h:t) p
    | x == h = p : listaPos x t (p+1)
    | otherwise = listaPos x t (p+1)
listaPos _ [] _ = []
-}

-- Corrigir depois: tentar fazer do 0.

organiza :: Eq a => [a] -> [(a,[Int])]
organiza l = organizaAux l [] 0 

organizaAux :: Eq a => [a] -> [a] -> Int -> [(a,[Int])]
organizaAux [] _ _ = []
organizaAux (x:xs) s p
    | elem x s = organizaAux xs s (p+1)
    | otherwise = (x,ocx) : organizaAux xs (x:s) (p+1)
    where ocx = listaPos x (x:xs) p

listaPos :: Eq a => a -> [a] -> Int -> [Int]
listaPos x (h:t) p
    | x == h = p : listaPos x t (p+1)
    | otherwise = listaPos x t (p+1)
listaPos _ [] _ = []