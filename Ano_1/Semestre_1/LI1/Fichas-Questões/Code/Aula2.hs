module Aula2 where

--1)---
data Movimento = Norte | Sul | Este | Oeste  deriving (Show,Eq)
type Ponto = (Double, Double)

--2)---
move :: Ponto -> Movimento -> Ponto
move (x,y) Norte = (x, y+1)
move (x,y) Sul = (x, y-1)
move (x,y) Este = (x+1, y)
move (x,y) Oeste = (x-1, y)

move' :: Ponto -> Movimento -> Ponto
move' (x,y) m
     |m==Norte = (x,y+1)
     |m==Sul = (x,y-1)
     |m==Este = (x+1,y)
     |otherwise = (x-1,y)

--3)---
dist :: Ponto -> Ponto -> Double
dist (x,y) (w,z) = sqrt ((w-x)^2 + (z-y)^2)

--4)---

--a)---
origem :: Ponto -> Double -> Ponto
origem (x,y) z = (x,(y-z))

--b)---
origemCentro :: Ponto -> Double -> Ponto
origemCentro (x, y) z = (x - z/2, y - z/2)

--5)---
type Velocidade = Double
type Tempo = Double

move2 :: Ponto -> Velocidade -> Tempo -> Ponto
move2 (x,y) velocidade tempo = (x + velocidade*tempo, y)

--6)---
move3 :: Ponto -> Velocidade -> Tempo -> Ponto
move3 (x,y) velocidade tempo = (x, y + velocidade*tempo)

--7)---
type Velocidade1 = (Double, Double)

move4 :: Ponto -> Velocidade1 -> Tempo -> Ponto
move4 (x,y) (vx,vy) tempo = (x + (vx*tempo), y + (vy*tempo))

--8)---
data Figura = Circulo Ponto Double
             | Rectangulo Ponto Ponto
             | Triangulo Ponto Ponto Ponto
               deriving (Show,Eq)

poligono :: Figura -> Bool
poligono (Circulo _ _) = False
poligono (Rectangulo p1 p2) 
poligono _ = True

vertices :: Figura -> [Ponto]
vertices (Circulo _ _) = []
vertices (Triangulo a b c) = [a,b,c]
vertices (Rectangulo d e) =

dentro :: Figura -> Ponto -> Bool
dentro (Circulo (cx,cy) raio) (x,y) = sqrt ((x-cx)^2 +(y-cy)^2)<= raio
dentro (Rectangulo (x1,y1) (x2,y2)) (x,y) = x>=x1 && x<=x2 && y>=y1 && y<=y2

dentro' :: Figura -> Ponto -> Bool
dentro' (Circulo (cx,cy) raio) (x,y) = sqrt ((x-cx)^2 +(y-cy)^2)<= raio
dentro' (Rectangulo (x1,y1) (x2,y2)) (x,y) =
          let maxx= max x1 x2
              maxy =max y1 y2
              minx = min x1 x2
              miny = min y1 y2
          in  x>=minx && x<=maxx && y>=miny && y<=maxy

--9)---
data Ponto2 = Cartesiano Double Double | Polar Double Double
     deriving (Show,Eq)

posx :: Ponto2 -> Double
posx (Cartesiano x _) = x
posx (Polar distancia angulo) = distancia*cos angulo

posy:: Ponto2 -> Double
posy (Cartesiano _ y) = y
posy (Polar distancia angulo) = distancia*sin angulo

raio :: Ponto2 -> Double
raio (Cartesiano x y) = sqrt (x^2 + y^2)
raio (Polar distancia _) = distancia

angulo :: Ponto2 -> Double
angulo (Cartesiano x y) = atan2 y x
angulo (Polar _ angulo) = angulo

dist9 :: Ponto2 -> Ponto2 -> Double
dist9 p1 p2 = sqrt ((posx p1 - posx p2)^2 + (posy p1 - posy p2)^2)

--2)---

type Nome = String
type Coordenada = (Double, Double)
data Movimento1 = N | S | E | W deriving (Show,Eq) -- norte, sul, este, oeste
type Movimentos = [Movimento1]
data PosicaoPessoa = Pos Nome Coordenada deriving (Show,Eq)


