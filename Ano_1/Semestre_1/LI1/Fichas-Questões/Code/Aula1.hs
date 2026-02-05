module Aula1 where

areaQ :: Int -> Int
areaQ lado = lado*lado

perimetro :: Float -> Float -> Float
perimetro comp larg = 2*(comp+ larg)

exp1 :: [Int] -> (Int , [Int])
exp1 l= (head l , tail l)

pertenceS :: Char -> String -> Bool
pertenceS x lista = elem x lista


-- d) ---
removeLista :: [a] -> [a]
removeLista l = if (mod (length l) 2) == 0
                    then tail l
                    else init l

primUlt :: [a] -> (a,a)
primUlt lista =(head lista, last lista)

parlistas :: ([a],[a]) -> (a,[a])
parlistas (xs, ys) = (head xs, ys)

parlistas' :: ([a],[a]) -> (a,[a])
parlistas' par = (head (fst par), snd par)

somapar :: Hora -> Hora ->Hora
somapar (x,y) (w,z) = (x+w, y+z)

somapar' :: Hora -> Hora ->Hora
somapar' (x,y) (w,z) = if mod(x+w) 2 == 0 then (0,y+z)
                        else (x+w,y+z)
