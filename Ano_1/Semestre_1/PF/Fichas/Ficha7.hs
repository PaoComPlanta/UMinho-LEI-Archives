module Ficha7 where

-- 1) 
data ExpInt = Const Int
            | Simetrico ExpInt
            | Mais ExpInt ExpInt
            | Menos ExpInt ExpInt
            | Mult ExpInt ExpInt

-- 3 + (2-5)
exp1 = Mais (Const 3) (Menos (Const 2) (Const 5))

-- (2-3) * -(5+20)
exp2 = Mult (Menos (Const 2) (Const 3))
            (Simetrico (Mais (Const 5) (Const 20)))

-- a)
calcula :: ExpInt -> Int
calcula (Const n) = n
calcula (Simetrico e) = -(calcula e)
calcula (Mais e1 e2) = calcula e1 + calcula e2
calcula (Menos e1 e2) = calcula e1 - calcula e2
calcula (Mult e1 e2) = calcula e1 * calcula e2

-- b)
infixa :: ExpInt -> String
infixa (Const n) = show n
infixa (Simetrico e) = "(-(" ++ infixa e ++ "))"
infixa (Mais e1 e2) = "(" ++ infixa e1 ++ "+" ++ infixa e2 ++ ")"
infixa (Menos e1 e2) = "(" ++ infixa e1 ++ "-" ++ infixa e2 ++ ")"
infixa (Mult e1 e2) = "(" ++ infixa e1 ++ "*" ++ infixa e2 ++ ")"

-- c)
posfixa :: ExpInt -> String
posfixa (Const n) = show n
posfixa (Simetrico e) = posfixa e ++ " ~"
posfixa (Mais e1 e2) = posfixa e1 ++ " " ++ posfixa e2 ++ " +"
posfixa (Menos e1 e2) = posfixa e1 ++ " " ++ posfixa e2 ++ " -"
posfixa (Mult e1 e2) = posfixa e1 ++ " " ++ posfixa e2 ++ " *"

-- 2)
data RTree a = R a [RTree a]
            deriving Show

rtree1 = R 5 [ R 4 [ R 3 [R 17 []], R 2 [], R 7 []],
          R 10 [],
          R 1 [ R 8 [ R 0 [], R 20 [], R 15 [], R 39 [] ],
                R 12 [] ]
        ]

-- a) 
soma :: Num a => RTree a -> a
soma (R x lista) = x + sum (map soma lista)

-- b) 
altura :: RTree a -> Int
altura (R x []) = 1
altura (R x lista) = 1 + maximum (map altura lista)

-- c)
prune :: Int -> RTree a -> RTree a
prune n (R x list)
    | n == 1 = R x []
    | n>1 = R x (map (prune (n-1)) list)

-- d)
mirror :: RTree a -> RTree a
mirror (R x []) = R x []
mirror (R x lista) = R x (reverse (map mirror lista))

-- e) 
postorder :: RTree a -> [a]
postorder (R x []) = [x]
postorder (R x lista) = concatMap postorder lista ++ [x]

-- 3) 
data BTree a = Empty 
             | Node a (BTree a) (BTree a)

data LTree a = Tip a 
             | Fork (LTree a) (LTree a)

arvore = Fork (Fork (Tip 5)
                    (Fork (Tip 6)
                          (Tip 4)))
              (Fork (Fork (Tip 3)
                          (Tip 7))
                    (Tip 5))

-- a) 
ltSum :: Num a => LTree a -> a
ltSum (Tip a) = a
ltSum (Fork e d) = ltSum e + ltSum d

-- b) 
listaLT :: LTree a -> [a]
listaLT (Tip a) = [a]
listaLT (Fork e d) = listaLT e ++ listaLT d

-- c) 
ltHeight :: LTree a -> Int
ltHeight (Tip _) = 0
ltHeight (Fork e d) = 1 + max (ltHeight e) (ltHeight d)

-- 4)
data FTree a b = Leaf b 
               | No a (FTree a b) (FTree a b)
            deriving Show


arvore1 = No 8 (No 1 (Leaf 5)
                    (No 2 (Leaf 6)
                          (Leaf 4)))
              (No 9 (No 10 (Leaf 3)
                           (Leaf 7))
                    (Leaf 5))

-- a)
splitFTree :: FTree a b -> (BTree a, LTree b)
splitFTree (Leaf b) = (Empty,Tip b)
splitFTree (No a e d) = (Node a be bd, Fork le ld)
    where (be,le) = splitFTree e
          (bd,ld) = splitFTree d

joinTrees :: BTree a -> LTree b -> Maybe (FTree a b)
joinTrees Empty (Tip x) = Just (Leaf x) 
joinTrees (Node x e d) (Fork le ld) = 
    case joinTrees e le of 
        Nothing -> Nothing
        Just fte -> case joinTrees d ld of
                           Nothing -> Nothing
                           Just ftd -> Just (No x fte ftd)
joinTrees _ _ = Nothing