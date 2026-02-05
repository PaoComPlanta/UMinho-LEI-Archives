{-|
Module      : Aula9

Exemplo pacman com records.
-}

module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

type Coordenadas =  (Float, Float)

type Estado = Coordenadas

data EstadoGloss = EstadoGloss
  { coordenadas :: Estado
  , comida :: [Coordenadas]
  , imagens :: [Picture]
  , tempo :: Float
  , teclas:: [Key]
  }

estadoInicial :: Estado
estadoInicial = (0,0)

listaComida :: [Coordenadas]
listaComida = [(50, 50), (-150, -100), (-100, -50)]

estadoGlossInicial :: [Picture] -> EstadoGloss
estadoGlossInicial listaImagens = EstadoGloss estadoInicial listaComida listaImagens 0.0 []

-- altera imagem a cada 100 milisseconds
desenhaEstado :: EstadoGloss -> Picture
desenhaEstado (EstadoGloss _ [] _  _ _) = Color red $ Translate (-100) 0 $ Text "FIM"
desenhaEstado (EstadoGloss (x,y) lc [p1,p2]  t _) = Pictures [pacman,comidas,time]
    where pacman = Translate x y pac
          pac = if mod (round (t*1000)) 200 < 100 then p1 else p2
          time = Translate 150 180 $ Scale 0.1 0.1 $ Text (show t)
          comidas = Pictures $ map (\(x,y) -> Translate x y $ Color orange $ circleSolid 5) lc
           
reageEvento :: Event -> EstadoGloss -> EstadoGloss
reageEvento (EventKey (Char 's') Down _ _) estado = estado {comida=[]}
reageEvento (EventKey k Down _ _) estado = estado {teclas=[k]}
reageEvento (EventKey k Up _ _) estado = estado {teclas=[]}
reageEvento _ s = s  -- ignora qualquer outro evento

reageTempo :: Float -> EstadoGloss -> EstadoGloss
reageTempo n estado = estado {coordenadas=(x',y'), tempo=t+n, comida = lc}
   where (x,y) = coordenadas estado
         t = tempo estado
         (x',y') = case (teclas estado) of
                    [] -> (x,y)
                    [k] -> case k of
                             (SpecialKey KeyDown) -> (x, max (y-2) (-190))
                             (SpecialKey KeyUp) -> (x, min (y+2) 190)
                             (SpecialKey KeyLeft) -> (max (x-2) (-190), y)
                             (SpecialKey KeyRight) -> (min (x+2) 190, y)
                             _ -> (x,y)
         lc = filter outsidePacman (comida estado)
         outsidePacman (x1,y1) = x1>(x'+ 6) || x1<(x'- 6) || y1>(y'+ 6) || y1<(y'- 6)  
        
fr :: Int
fr = 50

dm :: Display
dm = InWindow
       "Novo Jogo"  -- título da janela
       (400, 400)   -- dimensão da janela
       (0,0)        -- posição no ecran


get_images :: IO [Picture]
get_images = do
               pac_open <- loadBMP "pac_open.bmp"
               pac_closed <- loadBMP "pac_closed.bmp"
               let images = [scale 1.5 1.5 pac_open, scale 1.5 1.5 pac_closed]
               return images

main :: IO ()
main = do 
        imagens <- get_images
        play  dm                          -- janela onde irá decorrer o jogo
              (greyN 0.5)                 -- cor do fundo da janela
              fr                          -- frame rate
              (estadoGlossInicial imagens)  -- define estado inicial do jogo
              desenhaEstado               -- desenha o estado do jogo
              reageEvento                 -- reage a um evento
              reageTempo                  -- reage ao passar do tempo