module FichasLI where

rotate :: [a] -> Int -> [a]
rotate [] _ = []
rotate l n = 
   let t = length l
       lf = take (t-n) l
       li = drop (t-n) l
   in li ++ lf

-- Faltaria tratar os casos limite, por exemplo: [1,2,3,4,5] 6 dá mal.

mydiv :: Int -> Int -> Maybe Int
mydiv x y
    | x>0 && y>0 = Just (div x y)
    | otherwise = Nothing

-- Ficha 4 ex 5
substitui :: [a] -> Int -> a -> [a]
substitui l n a = take n l ++ [a] ++ drop (n+1) l

substitui1 :: [a] -> Int -> a -> [a]
substitui1 s p c = 
    let (s1,s2) = splitAt p s
    in s1 ++ c:tail s2