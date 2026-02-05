module Ficha1 where

import Data.Char

perimetro :: Float -> Float
perimetro r = 2*pi*r

dist :: (Double,Double) -> (Double,Double) -> Double
dist (x,y) (x1,y1) = sqrt ((x1-x)^2 + (y1-y)^2)

primUlt :: [a] -> (a,a)
primUlt l = (head l, last l)

multiplo :: Int -> Int -> Bool
multiplo m n = mod m n == 0

truncaImpar :: [a] -> [a]
truncaImpar l
    | mod (length l) 2 == 0 = l
    | otherwise = tail l

max2 :: Int -> Int -> Int
max2 x y = if div x y > 0 then x else y

max3 :: Int -> Int -> Int -> Int
max3 x y z = if div (max2 x y) z > 0 then max2 x y else z

nRaizes :: Float -> Float -> Float -> Int
nRaizes a b c
    | b^2 - 4*a*c > 0 = 2
    | b^2 - 4*a*c == 0 = 1
    | otherwise = 0

raizes :: Float -> Float -> Float -> [Float]
raizes a b c
    | nRaizes a b c == 2 = [r1,r2]
    | nRaizes a b c == 1 = [r1]
    | otherwise = []
    where r1 = (-b + sqrt (b^2 - 4*a*c))/2*a
          r2 = (-b - sqrt (b^2 - 4*a*c))/2*a

type Hora = (Int, Int)

horaValida :: Hora -> Bool
horaValida (x,y) = x <= 23 && x >= 0 && y >= 0 && y <= 59

horaDepois :: Hora -> Hora -> Bool
horaDepois (h,m) (h1,m1)
    | h > h1 = True
    | h < h1 = False
    | h == h1 = m > m1

horasToMinutos :: Hora -> Int
horasToMinutos (x,y) = x*60 + y

minutosToHoras :: Hora -> Float
minutosToHoras (x,y) = fromIntegral x + fromIntegral y/60

difHoras :: Hora -> Hora -> Int
difHoras (x,y) (w,z) = horasToMinutos (x-w,y-z)

adicionaMinutos :: (Int, Int) -> Int -> (Int, Int)
adicionaMinutos (h, m) n = (h + horas, mod (m + minutos) 60)
  where
    horas = div (m + n) 60
    minutos = mod (m + n) 60

data Semaforo = Verde 
                | Amarelo 
                | Vermelho 
              deriving (Show,Eq)

next :: Semaforo -> Semaforo
next c
    | c == Verde = Amarelo
    | c == Amarelo = Vermelho
    | c == Vermelho = Verde

stop :: Semaforo -> Bool
stop c 
    | c == Vermelho = True 
    | otherwise = False

safe :: Semaforo -> Semaforo -> Bool
safe Vermelho _ = True
safe _ Vermelho = True
safe _ _ = False

data Ponto = Cartesiano Double Double 
           | Polar Double Double
    deriving (Show,Eq)

posx :: Ponto -> Double
posx (Cartesiano x y) = x
posx (Polar r a) = r * cos a

posy :: Ponto -> Double
posy (Cartesiano x y) = y
posy (Polar r a) = r * sin a

raio :: Ponto -> Double
raio (Cartesiano x y) = sqrt (x ^ 2 + y ^ 2)
raio (Polar r a) = r

angulo :: Ponto -> Double
angulo (Cartesiano x y) = atan (y/x)
angulo (Polar r a) = a

dist1 :: Ponto -> Ponto -> Double
dist1 p1 p2 = sqrt ((x' - x) ^ 2 + (y' - y) ^ 2)
    where x = posx p1
          y = posy p1
          x' = posx p2
          y' = posy p2

data Figura = Circulo Ponto Double
            | Rectangulo Ponto Ponto
            | Triangulo Ponto Ponto Ponto
        deriving (Show,Eq)

poligono :: Figura -> Bool
poligono (Circulo _ _) = False
poligono (Rectangulo p1 p2)
    | posx p1 == posx p2 = False
    | posy p1 == posy p2 = False
    | otherwise = True
poligono (Triangulo p1 p2 p3) = (posx p1 /= posx p2 || 
                                posx p2 /= posx p3 ||
                                posx p1 /= posx p3)
                                && 
                                (posy p1 /= posy p2 || 
                                posy p2 /= posy p3 ||
                                posy p1 /= posy p3 )

vertices :: Figura -> [Ponto]
vertices (Circulo _ _) = []
vertices (Triangulo p1 p2 p3) = [p1,p2,p3]
vertices (Rectangulo p1 p2) = [p1,p2, Cartesiano (posx p1) (posy p2), Cartesiano (posx p2) (posy p1)]

{-
area :: Figura -> Double
area (Triangulo p1 p2 p3) =
        let a = dist p1 p2
            b = dist p2 p3
            c = dist p3 p1
            s = (a+b+c) / 2 -- semi-perimetro
        in sqrt (s*(s-a)*(s-b)*(s-c))
area (Circulo c r) = pi*(r^2)
area (Rectangulo p1 p2) = abs (posx p2 - posx p1) * abs (posy p2 - posy p1)
-}

perimetro1 :: Figura -> Double
perimetro1 (Circulo c r) = 2*pi*r
perimetro1 (Rectangulo p1 p2) = 2*abs (posx p1 - posx p1) + 2*abs (posy p1 - posy p2)

isLower1 :: Char -> Bool
isLower1 c = ord c >= ord 'a' && ord c <= ord 'z'

isDigit1 :: Char -> Bool
isDigit1 d = ord d >= ord '0' && ord d <= ord '9'

isAlpha1 :: Char -> Bool
isAlpha1 ch = isLower ch || isUpper ch
    where isUpper ch = ord ch >= ord 'A' && ord ch <= ord 'Z'

toUpper1 :: Char -> Char
toUpper1 ch = if isLower ch then chr (ord ch - 32) else ch

intToDigit1 :: Int -> Char
intToDigit1 n = chr (n + 48)

digitToInt1 :: Char -> Int 
digitToInt1 ch = ord ch - 48

