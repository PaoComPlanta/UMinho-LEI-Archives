module Ficha6PF where

data BTree a = Empty
             | Node a (BTree a ) (BTree a)
         deriving Show

-- 1)
arv1 = Node 10 arv2 arv3
arv2 = Node 7 (Node 3 Empty Empty) Empty
arv3 = Node 16 (Node 13 Empty Empty) (Node 20 (Node 18 Empty Empty) Empty) 

-- c) 
folhas :: BTree a -> Int 
folhas Empty = 0
folhas (Node x Empty Empty) = 1
folhas (Node x e d) = folhas e + folhas d

listaFolhas :: BTree a -> [a]
listaFolhas Empty = []
listaFolhas (Node x Empty Empty) = [x]
listaFolhas (Node x e d) = listaFolhas e ++ listaFolhas d

-- d)
prune :: Int -> BTree a -> BTree a
prune n Empty = Empty
prune n (Node x e d)
    | n<=0 = Empty
    | n>0 = Node x (prune (n-1) e) (prune (n-1) d)

-- e)
path :: [Bool] -> BTree a -> [a]
path _ Empty = []
path [] (Node x e d) = [x]
path (p:ps) (Node x e d) = if p then x : path ps d else x : path ps e  

-- f) 
mirror :: BTree a -> BTree a 
mirror Empty = Empty
mirror (Node x e d) = Node x (mirror d) (mirror e)

-- g)
zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c
zipWithBT f (Node x1 e1 d1) (Node x2 e2 d2) = Node (f x1 x2) (zipWithBT f e1 e2) (zipWithBT f d1 d2)
zipWithBT _ _ _ = Empty

-- 2) Árvores de procura (pesquisa)

-- a) Árvores não vazias
minimo :: Ord a => BTree a -> a
minimo (Node x Empty d) = x
minimo (Node x e d) = minimo e

-- b) Árvores não vazias
semMinimo :: Ord a => BTree a -> BTree a
semMinimo (Node x Empty d) = d 
semMinimo (Node x e d) = Node x (semMinimo e) d

-- c)
minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin (Node x Empty d) = (x,d)
minSmin (Node x e d) = (m, Node x a d)
    where (m,a) = minSmin e

-- d)
remove :: Ord a => a -> BTree a -> BTree a
remove x Empty = Empty
remove x (Node z e d)
    | x<z = Node z (remove x e) d 
    | x>z = Node z e (remove x d)
    | x == z = case d of 
                Empty -> e
                _     -> let (y,d') = minSmin d
                            in Node y e d' 