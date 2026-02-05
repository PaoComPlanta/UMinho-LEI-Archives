module Ficha5PF where


sortOn :: Ord b => (a->b) -> [a] -> [a]
sortOn f [] = []
sortOn f (x:xs) = insert f x (sortOn f xs)

insert :: Ord b => (a->b) -> a -> [a] -> [a]
insert f x [] = [x]
insert f x (y:ys)
    | f x <= f y = x:y:ys
    | otherwise = y: insert f x ys

type Polinomio = [Monomio]
type Monomio = (Float,Int)

selgrau :: Int -> Polinomio -> Polinomio
selgrau _ [] = []
-- selgrau n pol = filter aux pol -- 1ª maneira
    -- where aux (c,e) = e == n

-- selgrau n pol = filter (\(c,e)->e == n) pol -- 2ª maneira

-- selgrau n pol = filter (\x -> snd x == n) pol -- 3ª maneira 

selgrau n pol = filter ((==n).snd) pol -- 4ª maneira 

deriv :: Polinomio -> Polinomio
deriv pol = map (\(c,e) -> (c*(fromIntegral e),e-1)) pol

deriv1 :: Polinomio -> Polinomio
deriv1 pol = foldr (\(c,e) r -> (c*(fromIntegral e),e-1):r) [] pol

conta :: Int -> Polinomio -> Int
conta n pol = foldr aux 0 pol
    where aux (c,e) r = if e == n then 1 + r else r

calcula :: Float -> Polinomio -> Float
calcula _ [] = 0
calcula x ((c,e):t) = c*(x^e) + calcula x t

calcula1 :: Float -> Polinomio -> Float
calcula1 x pol = foldr (\(c,e) r -> c*(x^e) + r) 0 pol

calcula2 :: Float -> Polinomio -> Float
calcula2 x pol = sum (map (\(c,e) -> c*x^e) pol)

{- -- Fazer a insere de polinomios normalizados
normaliza :: Polinomio -> Polinomio
normaliza [] = []
normaliza (m:p) = insere m (normaliza p)

normaliza1 :: Polinomio -> Polinomio
normaliza1 
-}

-- 3) 
type Mat a = [[a]]

mat1 = [[1,2,3], [0,4,5], [0,0,6]]
-- a)
dimOK :: Mat a -> Bool
dimOK [] = False
dimOK m = let (x:xs) = map length m
          in x/= 0 && (filter (/= x) xs) == []

-- b) Fazer em casa

-- c) 
addMat :: Num a => Mat a -> Mat a -> Mat a
addMat (la:las) (lb:lbs) = (zipWith (+) la lb) : addMat las lbs
addMat [] [] = []

-- d)
transpose :: Mat a -> Mat a
transpose ([]:t) = []
transpose m = (map head m) : transpose (map tail m)

-- e)
multMat :: Num a => Mat a -> Mat a -> Mat a
multMat (l:ls) m = linha l m: multMat ls m
multMat [] m = []

linha :: Num a => [a] -> Mat a -> [a]
linha l ([]:_) = []
linha l m = sum (zipWith (*) l (map head m)) : linha l (map tail m)

