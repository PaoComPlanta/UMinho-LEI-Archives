{-|
Module      : Aula9-menu

Exemplo pacman com menu
-}

module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

data Jogo = Jogo Jogador [(Int, Int)]

type Jogador = (Int, Int)

data Opcao = Jogar
            | Sair

data Menu = Opcoes Opcao
          | ModoJogo 
          | VenceuJogo

data World = World {  menu :: Menu
                    , jogo :: Jogo
                    , imagens :: Images
                    , tempo :: Time}

type Time = Float

type Images = [Picture]

window :: Display
window = InWindow "Pacman" (700, 700) (0,0)

fr :: Int
fr = 50

-- inicializa jogo
posJogador = (0, (-300))

listaBolas = [(210, 50), (-220, -100), (-100, -50)]

initialState :: Images -> World
initialState images = World (Opcoes Jogar)
                            (Jogo posJogador listaBolas)
                            images
                            0
-- desenha estado do Gloss
drawState :: World -> Picture
drawState (World VenceuJogo _ _ t) = drawWinMessage t
drawState (World (Opcoes op) _ _ _) = drawOptions op
drawState (World ModoJogo  (Jogo (x, y) l) images n) =
 Pictures $ circulos ++ [pacman]
  where
      circulos = map drawSmallCircles l
      i = fromIntegral x
      j = fromIntegral y
      pacman = Translate i j $ pac
      pac = if (mod (round (n*1000)) 200) < 100 then (head images)
                                                else (last images)
                                                
drawOptions op =   case op of
    Jogar -> Pictures [Translate (-50) 10 $ Color blue $ drawOption "Jogar",
                       Translate (-50) (-70) $ drawOption "Sair"]
    Sair ->  Pictures [Translate (-50) 10 $ drawOption "Jogar",
                       Color blue $ Translate (-50) (-70) $ drawOption "Sair"]
                       
drawOption option =  Scale (0.5) (0.5) $ Text option

drawWinMessage :: Float -> Picture 
drawWinMessage n = Pictures [
   Translate (-200) 0 $ Color red $ scale 0.2 0.2 $ Text ("Ganhou em "++ show (round n) ++ " segundos"),
   Translate 100 (-160) $ scale 0.1 0.1 $ Text "Press Enter para continuar"]

drawSmallCircles :: (Int, Int) -> Picture
drawSmallCircles (x, y) = Translate i j $ Circle 5
    where
      i = fromIntegral x
      j = fromIntegral y

-- | calcula novo estado em modo de jogo 
newStateGame :: Key -> Jogo -> Jogo
newStateGame k (Jogo (x,y) l) =
   let p = (x', y')
       x' = max (min (x+dx) 340) (-340)
       y' =  max (min (y+dy) 340) (-340)
       (dx,dy)= case k of
                     (SpecialKey KeyUp) -> (0,10)
                     (SpecialKey KeyDown) -> (0,(-10))
                     (SpecialKey KeyLeft) -> (-10,0)
                     (SpecialKey KeyRight) -> (10,0)
   in Jogo p (filter (p/=) l)


-- | muda de opção no menu
mudaOP :: Opcao -> Opcao
mudaOP op = case op of
               Jogar -> Sair
               Sair -> Jogar

event :: Event -> World -> World
event (EventKey k Down _ _) w = newStateGloss k w
event _ w = w    -- não fazer nada em outros casos  

{-
newStateGloss :: Key -> World -> World
newStateGloss k w =
  case w of
    World {menu=ModoJogo} -> let (Jogo (x,y) l) = jogo w
                             in if l==[] then w {menu=VenceuJogo}
                                  else w {jogo = newStateGame k (jogo w) }
    World {menu=VenceuJogo} ->
       case k of
              (SpecialKey KeyEnter) -> initialState (imagens w)
              _ -> w
    World {menu= (Opcoes op)} ->
      case k of
       (SpecialKey KeyEnter) -> case op of
                                 Jogar -> w {menu=ModoJogo}
                                 Sair -> error "Fim de Jogo"
       (SpecialKey KeyDown) -> w {menu = Opcoes (mudaOP op)}                          
       (SpecialKey KeyUp)   -> w {menu = Opcoes (mudaOP op)}   
       _ -> w
-}
newStateGloss :: Key -> World -> World
newStateGloss k w = case menu w of
  ModoJogo -> let (Jogo (x,y) l) = jogo w
              in if l==[] then w {menu=VenceuJogo}
                          else w {jogo = newStateGame k (jogo w) }
  VenceuJogo ->  case k of
                  (SpecialKey KeyEnter) -> initialState (imagens w)
                  _ -> w
  (Opcoes op) ->
    case k of
       (SpecialKey KeyEnter) -> case op of
                                 Jogar -> w {menu=ModoJogo}
                                 Sair -> error "Fim de Jogo"
       (SpecialKey KeyDown) -> w {menu = Opcoes (mudaOP op)}                          
       (SpecialKey KeyUp)   -> w {menu = Opcoes (mudaOP op)}   
       _ -> w


time :: Float -> World -> World
time t (World VenceuJogo j i n) = World VenceuJogo j i n
time t w = w {tempo=t + tempo w}

get_images :: IO [Picture]
get_images = do
               pac_open <- loadBMP "pac_open.bmp"
               pac_closed <- loadBMP "pac_closed.bmp"
               let images = [scale 1.5 1.5 pac_open, scale 1.5 1.5 pac_closed]
               return images

main :: IO ()
main = do
  images <- get_images
  play window (greyN 0.8) fr (initialState images) drawState event time
