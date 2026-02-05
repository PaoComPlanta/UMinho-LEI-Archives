module Ficha1PF where
import Data.Time.Format.ISO8601 (yearFormat)
import Data.Complex

perimetro :: Float -> Float
perimetro r = 2*pi*r

dist :: (Double, Double) -> (Double, Double) -> Double
dist (x, y) (w, z) = sqrt ((w - x)^2 + (z - y)^2)

primUltimo :: [a] -> (a,a)
primUltimo lista = (head lista, last lista)

multiplo :: Int -> Int -> Bool
multiplo m n =  mod m n == 0

truncaImpar :: [a] -> [a]
truncaImpar l = if mod (length l) 2 == 0 then l
                else tail l

max2 :: Int -> Int -> Int
max2 x y = if (div x y > 0) then x
            else y

max3 :: Int -> Int -> Int -> Int
max3 x y z = max2 x (max2 y z)

--2)---
nRaizes :: Float -> Float -> Float -> Float
nRaizes x y z
  | y^2 - 4*x*z > 0 = 2
  | y^2 - 4*x*z == 0 = 1
  | otherwise = 0

nRaizes1 :: (Float,Float,Float) -> Float
nRaizes1 (a,b,c) = if delta < 0
                    then 0
                    else if delta == 0
                          then 1
                          else 2

            where delta = b^2 -4*a*c
{-raizes :: (Float,Float,Float) -> [Float]
raizes (a,b,c) = if n == 0 then []
                  else if n == 1 then [-b /(2*a)]
                        else [(-b + sqrt b) / (2*a) , (-b - sqrt b) / (2*a) ]
        where n = nRaizes      
              d = b^2 -4*a*c  
-}
--3)---
type Hora = (Int, Int)

diaVal :: Hora -> Bool
diaVal (x,y) = x<24 && y<60

-- testa se o primeiro argumento é depois (no tempo) so segundo

horaMaior :: Hora -> Hora -> Bool
horaMaior (x,y) (w,z) = if (x>w) then True
                        else if (x == w) then if (y>z) then True
                                              else False
                              else False

horaMin :: Hora -> Int
horaMin (h,m) = h*60 + m

minHoras :: Hora -> Float
minHoras (h,m) = fromIntegral h + fromIntegral m/60

--4)----

data HORA = H Int Int deriving (Show,Eq)
valida :: HORA -> Bool
valida (H h m) = h>=0 && h<24 && m>=0 && m<60

depois :: HORA -> HORA -> Bool
depois (H h1 m1) (H h2 m2) = if h1>h2 then True
                              else if h1==h2 then m1>m2
                                    else False

minutos1 :: HORA -> Int
minutos1 (H x y) = 60*x + y

horas1 :: Int -> HORA
horas1 x = (H (div x 60) (mod x 60))

{- 
horas1 x = let h = div x 60
               m = mod x 60
            in (H h m)
-}

--5)---
data Semaforo = Verde | Amarelo | Vermelho deriving (Show, Eq)
--a)---
next :: Semaforo -> Semaforo
next Verde = Amarelo
next Amarelo = Vermelho
next Vermelho = Verde

stop :: Semaforo -> Bool
stop x = x == Vermelho

{-safe :: Semaforo -> Semaforo -> Bool
safe x y = if x == Vermelho && y == Vermelho then True
            else if x == Verde && y == Vermelho then True
                  else if x == y && x/=Vermelho then False
                        else if x == Vermelho && y == Verde then True
                              else False
-}

safe :: Semaforo -> Semaforo -> Bool
safe x y = if x == Vermelho && y == Vermelho then True
            else if x == Vermelho && (y == Verde || y == Amarelo) then True
                  else if (x == Verde || x == Amarelo) && y == Vermelho then True 
                        else False


safe1 :: Semaforo -> Semaforo -> Bool
safe1 Vermelho _ = True
safe1 _ Vermelho = True
safe1 _ _ = False

--6)---
data Ponto = Cartesiano Double Double | Polar Double Double
             deriving (Show,Eq)




