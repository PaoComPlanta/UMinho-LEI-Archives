module Ficha6 where
import GHC.CmmToAsm.AArch64.Instr (d0)

data BTree a = Empty
             | Node a (BTree a) (BTree a)
        deriving Show

-- 1)
arv1 = Node 10 arv2 arv3
arv2 = Node 7 (Node 3 Empty Empty) Empty
arv3 = Node 16 (Node 13 Empty Empty) (Node 20 (Node 18 Empty Empty) Empty)

-- a)
altura :: BTree a -> Int
altura Empty = 0
altura (Node x e d) = 1 + max  (altura e) (altura d)

-- b)
contaNodos :: BTree a -> Int
contaNodos Empty = 0
contaNodos (Node x e d) = 1 + contaNodos e + contaNodos d

-- c) 
folhas :: BTree a -> Int
folhas Empty = 0
folhas (Node _ Empty Empty) = 1
folhas (Node x e d) = folhas e + folhas d

-- d)
prune :: Int -> BTree a -> BTree a
prune _ Empty = Empty
prune 0 _ = Empty
prune n (Node x e d) = Node x (prune (n-1) e) (prune (n-1) d)

-- e) 
path :: [Bool] -> BTree a -> [a]
path _ Empty = []
path [] (Node e _ _) = [e]
path (h:t) (Node e l r) = e : path t (if h == True then r else l)

-- f) 
mirror :: BTree a -> BTree a
mirror Empty = Empty
mirror (Node x e d) = Node x (mirror d) (mirror e)

-- g)
zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c
zipWithBT f (Node e l r) (Node e' l' r') = Node (f e e') (zipWithBT f l l') (zipWithBT f r r')
zipWithBT _ _ _ = Empty

-- h)
unzipBT :: BTree (a,b,c) -> (BTree a,BTree b,BTree c)
unzipBT Empty = (Empty, Empty, Empty)
unzipBT (Node (a,b,c) l r) = (Node a unzipL1 unzipR1, Node b unzipL2 unzipR2, Node c unzipL3 unzipR3)
    where (unzipL1,unzipL2,unzipL3) = unzipBT l
          (unzipR1,unzipR2,unzipR3) = unzipBT r

-- 2)
-- a)
minimo :: Ord a => BTree a -> a
minimo (Node x Empty _) = x
minimo (Node x e d) = minimo e

-- b)
semMinimo :: Ord a => BTree a -> BTree a
semMinimo (Node x Empty d) = d
semMinimo (Node x e d) = Node x (semMinimo e) d

-- c)
minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin (Node x Empty d) = (x,d)
minSmin (Node x e d) = (a, Node x b d)
    where (a,b) = minSmin e

-- d) 
remove :: Ord a => a -> BTree a -> BTree a
remove _ Empty = Empty
remove x (Node e l r)
    | x < e = Node e (remove x l) r
    | x > e = Node e l (remove x r)
    | otherwise = case r of Empty -> l
                            _ -> let (g,h) = minSmin r in Node g l h

-- Nesta função, depois de remover o elemento, temos de formar uma nova árvore, pois não podemos ter um nodo vazio. Para isso, removemos o menor elemento do ramo da direita e colocamos esse elemento onde estava o elemento removido. Desta forma, a árvore mantém a sua ordem, já que todos os elementos à esquerda continuam a ser mais pequenos e todos os elementos à direita continuam a ser maiores do que o elemento no nodo.

-- 3)

type Aluno = (Numero,Nome,Regime,Classificacao)
type Numero = Int
type Nome = String
data Regime = ORD | TE | MEL deriving Show
data Classificacao = Aprov Int
                   | Rep
                   | Faltou
    deriving Show

type Turma = BTree Aluno -- árvore binária de procura (ordenada por número)

turma :: Turma
turma = (Node (15,"Luís",ORD,Aprov 14) (Node (12,"Joana",MEL,Faltou) (Node (7,"Diogo",TE,Rep) Empty Empty) (Node (14,"Lara",ORD,Aprov 19) Empty Empty)) (Node (20,"Pedro",TE,Aprov 10) Empty (Node (25,"Sofia",ORD,Aprov 20) (Node (23,"Rita",ORD,Aprov 17) Empty Empty) (Node (28,"Vasco",MEL,Rep) Empty Empty))))

-- a)
inscNum :: Numero -> Turma -> Bool
inscNum _ Empty = False
inscNum n (Node (numero,nome,regime,clas) e d)
    | n == numero = True
    | n < numero = inscNum n e
    | otherwise = inscNum n d

-- b) 
inscNome :: Nome -> Turma -> Bool
inscNome _ Empty = False
inscNome n (Node (numero,nome,regime,clas) e d)
    | n == nome = True
    | otherwise = inscNome n e || inscNome n d

-- c)
trabEst :: Turma -> [(Numero,Nome)]
trabEst Empty = []
trabEst (Node (numero,nome,TE,clas) e d) = [(numero,nome)] ++ trabEst e ++ trabEst d
trabEst (Node _ e d) = trabEst e ++ trabEst d

-- d)
nota :: Numero -> Turma -> Maybe Classificacao
nota n Empty = Nothing
nota n (Node (numero,nome,regime,clas) e d)
    | n == numero = Just clas
    | n < numero = nota n e
    | otherwise = nota n d

-- e)
percFaltas :: Turma -> Float
percFaltas Empty = 0
percFaltas t = (numFaltas t/numAlunos t)*100

numFaltas :: Turma -> Float
numFaltas Empty = 0
numFaltas (Node (numero,nome,regime,Faltou) e d) = 1 + numFaltas e + numFaltas d
numFaltas (Node _ e d) = numFaltas e + numFaltas d

numAlunos :: Turma -> Float
numAlunos = fromIntegral.contaNodos

-- f)
mediaAprov :: Turma -> Float
mediaAprov t = (sum (recolheNotas t))/contaPassaram t 

recolheNotas :: Turma -> [Float]
recolheNotas Empty = []
recolheNotas (Node (numero,nome,regime, Aprov x) e d) = [fromIntegral x] ++ recolheNotas e ++ recolheNotas d
recolheNotas (Node _ e d) = recolheNotas e ++ recolheNotas d

contaPassaram :: Turma -> Float
contaPassaram Empty = 0
contaPassaram (Node (numero,nome,regime, Aprov _) e d) = 1 + contaPassaram e + contaPassaram d
contaPassaram (Node _ e d) = contaPassaram e + contaPassaram d 

-- g)
aprovAv :: Turma -> Float
aprovAv t = contaPassaram t / (contaPassaram t + contaReprovaram t)

contaReprovaram :: Turma -> Float
contaReprovaram Empty = 0
contaReprovaram (Node (numero,nome,regime,Rep) e d) = 1 + contaReprovaram e + contaReprovaram d
contaReprovaram (Node _ e d) = contaReprovaram e + contaReprovaram d 

{-
mediaAprov :: Turma -> Float
mediaAprov Empty = 0
mediaAprov turma = uncurry (/) (sumNumNotas turma)
    where sumNumNotas :: Turma -> (Float, Float)
          sumNumNotas Empty = (0,0)
          sumNumNotas (Node (_,_,_,Aprov nota) l r) = addPairs (fromIntegral nota, 1) (addPairs (sumNumNotas l) (sumNumNotas r))
          sumNumNotas (Node _ l r) = addPairs (sumNumNotas l) (sumNumNotas r)
          addPairs (a,b) (c,d) = (a+c,b+d)

aprovAv :: Turma -> Float
aprovAv Empty = 0
aprovAv turma = uncurry (/) (sumAprovAv turma)
          
sumAprovAv :: Turma -> (Float, Float)
sumAprovAv Empty = (0,0)
sumAprovAv (Node (_,_,_,clas) l r) = case clas of Aprov nota -> (ap+1,av+1) 
                                                  Rep -> (ap,av+1)
                                                  _ -> (ap,av)
    where (ap,av) = addPairs (sumAprovAv l) (sumAprovAv r)
          addPairs (a,b) (c,d) = (a+c,b+d)
-}

-- Implementação da Sofia. (Apenas com uma travessia na árvore, funciona igual, mas se pedir apenas uma travessia da árvore, devo fazer como ela).

-- :)
