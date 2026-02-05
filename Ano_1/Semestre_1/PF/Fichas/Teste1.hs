module Teste1 where
data Ponto = Cartesiano (Double, Double) | Polar (Double, Double)
    deriving (Show, Eq)

data Figura = Circulo Ponto Double | Rectangulo Ponto Ponto
    deriving (Show, Eq)


dentro :: Figura -> Ponto -> Bool
dentro (Circulo (cx, cy) raio) (x, y) = sqrt ((x - cx)^2 + (y - cy)^2) <= raio
dentro (Rectangulo (x1, y1) (x2, y2)) (x, y) = x >= x1 && x <= x2 && y >= y1 && y <= y2

dentro' :: Figura -> Ponto -> Bool
dentro' (Circulo (cx, cy) raio) (x, y) = sqrt ((x - cx)^2 + (y - cy)^2) <= raio
dentro' (Rectangulo (x1, y1) (x2, y2)) (x, y) = 
    let maxx = max x1 x2
        maxy = max y1 y2
        minx = min x1 x2 
        miny = min y1 y2
    in  x >= minx && x <= maxx && y >= miny && y <= maxy

--a)---
{-data Figura = Circulo Ponto Double | Rectangulo Ponto Ponto
                      deriving (Show,Eq)

data Ponto = Cartesiano Double Double | Polar Double Double deriving (Show,Eq)

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
          
data Ponto = Cartesiano Double Double | Polar Double Double
    deriving (Show, Eq)

data Figura = Circulo Ponto Double | Rectangulo Ponto Ponto
    deriving (Show, Eq)


dentro :: Figura -> Ponto -> Bool
dentro (Circulo (cx, cy) raio) (x, y) = sqrt ((x - cx)^2 + (y - cy)^2) <= raio
dentro (Rectangulo (x1, y1) (x2, y2)) (x, y) = x >= x1 && x <= x2 && y >= y1 && y <= y2

dentro' :: Figura -> Ponto -> Bool
dentro' (Circulo (cx, cy) raio) (x, y) = sqrt ((x - cx)^2 + (y - cy)^2) <= raio
dentro' (Rectangulo (x1, y1) (x2, y2)) (x, y) = 
    let maxx = max x1 x2
        maxy = max y1 y2
        minx = min x1 x2 
        miny = min y1 y2
    in  x >= minx && x <= maxx && y >= miny && y <= maxy
-}
