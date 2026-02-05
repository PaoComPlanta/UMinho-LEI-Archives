module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

type Estado = (Float, Float)

type EstadoGloss = (Time, Figuras, Estado)
type Time = Float
type Figuras = [Picture]


estadoInicial :: Picture -> Picture -> EstadoGloss
estadoInicial p1 p2 = (0, [p1, p2], (0, 0))




desenhaEstado :: EstadoGloss -> Picture
desenhaEstado (t,[p1,p2],(x,y)) = translate x y imagem
   where imagem :: Picture
         imagem = if mod (round (t*1000)) 200 < 100 then p1 else p2

reageEvento :: Event -> EstadoGloss -> EstadoGloss
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) (t,li,(x,y)) = 
       if (y+5) >= 200 then (t,li,(x, 200)) else (t,li,(x, y+5))
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) (t,li,(x,y)) = 
       if (y-5) <= (-200) then (t,li,(x, -200)) else (t,li,(x, y-5))
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) (t,li,(x,y)) = (t,li,(x-5, y))
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) (t,li,(x,y)) = (t,li,(x+5, y))
reageEvento _ s = s  -- ignora qualquer outro evento

reageTempo :: Float -> EstadoGloss -> EstadoGloss
reageTempo n (t,li,(x,y)) = if (y-0.3) <= (-200) then (t,li,(x, -200)) else (t+n,li,(x, y-0.3))   -- diminui o valor do y


fr:: Int
fr = 50

dm :: Display
dm = InWindow
       "Novo Jogo"  -- título da janela
       (400, 400)   -- dimensão da janela
       (200,200)    -- posição no ecran

corFundo :: Color
corFundo = (greyN 0.5) 

main :: IO ()
main = do 
            let p1 = color green $ rectangleSolid 20 10
            let p2 = color green $ rectangleSolid 40 10
            play dm             -- janela onde irá decorrer o jogo
               corFundo       -- cor do fundo da janela
               fr             -- frame rate
               (estadoInicial p1 p2)  -- define estado inicial do jogo
               desenhaEstado  -- desenha o estado do jogo
               reageEvento    -- reage a um evento
               reageTempo     -- reage ao passar do tempo
               
