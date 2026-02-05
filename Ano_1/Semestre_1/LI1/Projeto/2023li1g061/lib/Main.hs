{-|
Module      : Main
Description : Tarefa onde utlizamos o Gloss para construir o Jogo graficamente.
Copyright   : Francisco Miguel Fernandes Soares <a106901@alunos.uminho.pt>
              Simão Pedro Pacheco Mendes <a106928@alunos.uminho.pt>

Módulo para a realização da Tarefa 6 de LI1 em 2023/24.
-}

module Main where


import LI12324
import Tarefa1
import Tarefa2
import Tarefa3
import Tarefa4
import TarefaComplementar
import Graphics.Gloss
import Graphics.Gloss.Juicy
import Graphics.Gloss.Interface.Pure.Game
import System.Random
import Data.Maybe
import System.Exit

{-| Neste módulo realizamos as funções necessárias para pôr a parte gáfica a funcionar. Para isso, tivemos de definir alguns data Types novos:
-}
-- | Menu.
data Menu = InGame
          | MenuInicial
          | MenuCreditos
          | MenuPausa
          | Win
          | Lose
          | Options
          deriving Eq

-- | Opcoes.
data Opcoes = Default
            | Jogar
            | Sair
            | Creditos
            | Voltar
            | Continuar
            | Opcoes
    deriving (Eq, Show)

-- | Pictures.
type Pictures = [Picture]

-- | Tipo de imagens.
data TipoImagens = ImageBloc 
                 | ImagePer 
                 | ImageIni

type ImagensB = [(Bloco, Picture)]
type ImagensP = [(Temas, [(Entidade, Pictures)])]
type ImagensC = [(Colecionavel,Picture)]
type ImagensM = [(Menu, Pictures)]

data Imagens = Imagens {
           blocos :: ImagensB
          ,personagens :: ImagensP
          ,colecionaveis :: ImagensC
          ,menus :: ImagensM
                     }
-- | Temas
data Temas = Escuro | Claro deriving (Show, Eq)

-- | Data type do Jogo.
data PrimateKong = PK { jogo    :: Jogo
                      , menu    :: Menu
                      , opcoes  :: Opcoes
                      , imagens :: Imagens
                      , tema :: Temas
                      , tempo :: Tempo
                      , semente :: Semente
                      , paridadet :: ParidadeT
                      , carteclas :: CarregaTecla
                               }

{-|
Definições da janela do jogo.
-}

mainDisplay :: Display
mainDisplay = InWindow "PrimateKong" (780,950) (0,0)

-- | Cor do fundo.
corfundo :: Color
corfundo = black


{-|
O framerate do jogo.
-}

fr :: Int
fr = 30

-- | Seed do jogo.
geraSeed :: IO Int
geraSeed = randomRIO (1, 1000000)

-- | Estado inicial do jogo.
estadoInicial :: IO PrimateKong
estadoInicial = do
    imagensB <- gImageBloco
    imagensP <- gImagePersonagem
    imagensC <- gImageColec
    imagensM <- gImageMenu
    seed <- geraSeed
    let jogador = Personagem (0, 0) Jogador (70.0, -200.0) Este (30,30) False False 3 0 (False, 0)
        inimigos = [Personagem (1, 1) Fantasma (250.0,-340.0) Oeste (30, 30) False True 1 0 (False, 0), Personagem (0, 0) Fantasma (250.0,-340.0) Oeste (30, 30) False True 1 0 (False, 0), Personagem (0, 0) MacacoMalvado (-250.0,375.0) Oeste (30, 30) False False 1 0 (False, 0)]
        colecionaveis = [(Moeda, (-100.0,-170.0)), (Moeda, (115.0,-75.0)), (Moeda, (-100.0,25.0)), (Moeda, (40.0,125.0)), (Moeda, (150.0,225.0)), (Martelo, (50.0, -165.0)), (Estrela, (10.0,170.0 )), (Martelo, (100.0, 35.0)) ]
        mapa = Mapa ((0.0,-500.0), Este) (1,0) nivel1
        jogo = Jogo mapa inimigos colecionaveis jogador
        tempo = 0
        press = Car False Nothing False False False
        paridade = False
    return $ PK jogo MenuInicial Default (Imagens imagensB imagensP imagensC imagensM) Escuro tempo seed paridade press

-- | Agrupa as imagens dos blocos nas suas diferentes categorias.
gImageBloco :: IO ImagensB
gImageBloco = do
      Just imageplataforma <- loadJuicyPNG "Resources/Plataforma.png"
      Just imagealcapao    <- loadJuicyPNG "Resources/Alcapaov2.png"
      Just imageescada     <- loadJuicyPNG "Resources/Escada.png"
      return [(Plataforma, imageplataforma), (Alcapao, imagealcapao), (Escada, imageescada)]


-- | Agrupa as imagens dos Personagens nas suas diferentes categorias.
gImagePersonagem :: IO ImagensP
gImagePersonagem = do
      Just p   <-  loadJuicyPNG "Resources/JogadorParado.png"
      Just cd  <- loadJuicyPNG "Resources/JogadorAndarDireita.png"
      Just ce  <- loadJuicyPNG "Resources/JogadorAndarEsquerda.png"
      Just se  <- loadJuicyPNG "Resources/JogadorSaltarEsquerda.png"
      Just sd  <- loadJuicyPNG "Resources/JogadorSaltarDireita.png"
      Just mse  <- loadJuicyPNG "Resources/JogadorMarteloEsquerda.png"
      Just msd  <- loadJuicyPNG "Resources/JogadorMarteloDireita.png"
      Just md <- loadJuicyPNG "Resources/JogadorMarteloD.png"
      Just me <- loadJuicyPNG "Resources/JogadorMarteloE.png"
      Just su1 <- loadJuicyPNG "Resources/JogadorSubir1.png"
      Just su2 <- loadJuicyPNG "Resources/JogadorSubir2.png"
      Just g1d <- loadJuicyPNG "Resources/Fantasma2f2.png"
      Just g1e <- loadJuicyPNG "Resources/Fantasma2f1Esquerda.png"
      Just g2d <- loadJuicyPNG "Resources/Fantasma1f1.png"
      Just g2e <- loadJuicyPNG "Resources/Fantasma1f2Esquerda.png"
      Just mac1 <- loadJuicyPNG "Resources/Macaco1.png"
      Just mac2 <- loadJuicyPNG "Resources/Macaco2.png"
      return [(Escuro, [(Jogador, [p, cd, ce, se, sd, mse, msd, md, me, su1, su2]), (Fantasma, [g1d, g1e, g2d, g2e]),(MacacoMalvado, [mac1, mac2])])]

-- | Agrupa as imagens dos colecionaveis nas suas diferentes categorias.
gImageColec :: IO ImagensC
gImageColec = do
      Just mo <- loadJuicyPNG "Resources/Moeda.png"
      Just ma <- loadJuicyPNG "Resources/Martelo.png"
      Just es <- loadJuicyPNG "Resources/Estrela.png"
      return [(Moeda, mo), (Martelo, ma), (Estrela, es)]

-- | Agrupa as imagens dos menus nas suas diferentes categorias.
gImageMenu :: IO ImagensM
gImageMenu = do
    Just mi1 <- loadJuicyPNG "Resources/MenuInicial1.png"
    Just mi2 <- loadJuicyPNG "Resources/MenuInicial2.png"
    Just mi3 <- loadJuicyPNG "Resources/MenuInicial3.png"
    Just mi4 <- loadJuicyPNG "Resources/MenuInicial4.png"
    Just mi5 <- loadJuicyPNG "Resources/MenuInicial5.png"
    Just cr0 <- loadJuicyPNG "Resources/Creditos1.png"
    Just cr1 <- loadJuicyPNG "Resources/Creditos.png"
    Just mp0 <- loadJuicyPNG "Resources/MenuPausa0.png"
    Just mp1 <- loadJuicyPNG "Resources/MenuPausa1.png"
    Just mp2 <- loadJuicyPNG "Resources/MenuPausa2.png"
    Just mp3 <- loadJuicyPNG "Resources/MenuPausa3.png"
    Just mp4 <- loadJuicyPNG "Resources/MenuPausa4.png"
    Just win1 <- loadJuicyPNG "Resources/MenuVitoria.png"
    Just win2 <- loadJuicyPNG "Resources/MenuVitoria1.png"
    Just win3 <- loadJuicyPNG "Resources/MenuVitoria2.png"
    Just los1 <- loadJuicyPNG "Resources/MenuDerrota.png"
    Just los2 <- loadJuicyPNG "Resources/MenuDerrota1.png"
    Just los3 <- loadJuicyPNG "Resources/MenuDerrota2.png"
    Just opt1 <- loadJuicyPNG "Resources/Controlos1.png"
    Just opt2 <- loadJuicyPNG "Resources/Controlos2.png"
    return [(MenuInicial, [mi1, mi2, mi3, mi4, mi5]),(MenuCreditos, [cr0, cr1]),(MenuPausa, [mp0, mp1, mp2, mp3, mp4]),(Win, [win1, win2, win3]),(Lose, [los1, los2, los3]),(Options, [opt1, opt2])]

-- | Desenha Estado do Jogo.
desenhaEstado :: PrimateKong -> Picture
desenhaEstado (PK j@(Jogo mapa@(Mapa (pos, dir) pos2 bloco) ini col jog) menu opcoes (Imagens blocos personagens colecionaveis menus) tema tempo seed par press) =
    case menu of
        MenuInicial -> desenhaMenu menu opcoes menus
        MenuCreditos -> desenhaMenu menu opcoes menus
        MenuPausa -> desenhaMenu menu opcoes menus
        Win -> desenhaMenu menu opcoes menus
        Lose -> desenhaMenu menu opcoes menus
        Options -> desenhaMenu menu opcoes menus
        InGame -> pictures $ concat [desenhaMapa (-384) 480 bloco blocos, desenhaEntidadeAux1 ini jog personagens press par , desenhaColecionavel col colecionaveis]

-- | Desenha os menus.
desenhaMenu :: Menu -> Opcoes -> ImagensM -> Picture
desenhaMenu menu op img = case (lookup MenuInicial img, lookup MenuCreditos img, lookup MenuPausa img, lookup Win img, lookup Lose img, lookup Options img) of
            (Just miimg, Just cimg, Just mpimg, Just winimg, Just loseimg, Just optimg) ->
                case menu of
                    MenuInicial -> case op of
                                    Default  -> translate 0 0 (head miimg)
                                    Jogar    -> translate 0 0 (miimg !! 1)
                                    Opcoes   -> translate 0 0 (miimg !! 2)
                                    Creditos -> translate 0 0 (miimg !! 3)
                                    Sair     -> translate 0 0 (miimg !! 4)
                                    _        -> Blank

                    MenuCreditos -> case op of
                                Default    -> translate 0 0 (head cimg)
                                Voltar     -> translate 0 0 (cimg !! 1)
                                _          -> Blank

                    MenuPausa -> case op of
                                Default    -> translate 0 0 (head mpimg)
                                Continuar  -> translate 0 0 (mpimg !! 1)
                                Opcoes     -> translate 0 0 (mpimg !! 2)
                                Creditos   -> translate 0 0 (mpimg !! 3)
                                Sair       -> translate 0 0 (mpimg !! 4)
                                _          -> Blank

                    Win       -> case op of
                                Default   -> translate 0 0 (head winimg)
                                Creditos  -> translate 0 0 (winimg !! 1)
                                Voltar    -> translate 0 0 (winimg !! 2)
                                _         -> Blank

                    Lose      -> case op of
                                Default   -> translate 0 0 (head loseimg)
                                Creditos  -> translate 0 0 (loseimg !! 1)
                                Voltar    -> translate 0 0 (loseimg !! 2)
                                _         -> Blank

                    Options   -> case op of
                                Default -> translate 0 0 (head optimg)
                                Voltar  -> translate 0 0 (optimg !! 1)

-- | Desenha os colecionáveis.
desenhaColecionavel :: [(Colecionavel, Posicao)] -> ImagensC -> [Picture]
desenhaColecionavel [] _ = []
desenhaColecionavel ((Estrela, (x, y)) : rest) iC =
    scale 2 2 (translate (realToFrac x) (realToFrac y) (fromMaybe Blank (lookup Estrela iC))) : desenhaColecionavel rest iC
desenhaColecionavel ((Moeda, (x, y)) : rest) iC =
    scale 1.5 1.5 (translate (realToFrac x) (realToFrac y) (fromMaybe Blank (lookup Moeda iC))) : desenhaColecionavel rest iC
desenhaColecionavel ((Martelo, (x, y)) : rest) iC =
    scale 1.5 1.5 (translate (realToFrac x) (realToFrac y) (fromMaybe Blank (lookup Martelo iC))) : desenhaColecionavel rest iC

-- | Desenha o mapa.
desenhaMapa :: Float -> Float -> [[Bloco]] -> ImagensB -> Pictures
desenhaMapa x y mapa i = concatMap (\(l, y') -> desenhaLinha x y' l i) lC
  where
    lC = zip mapa [y, y - vert ..]
    vert = 30.0

-- | Desenha uma linha da matriz que define o mapa.
desenhaLinha :: Float -> Float -> [Bloco] -> ImagensB -> Pictures
desenhaLinha x y li i = concatMap (\(b, x1) -> desenhaBloco x1 y b i) bC
  where
    horiz = 30.0
    bC = zip li [x, x + horiz ..]

-- | Desenha cada bloco.
desenhaBloco :: Float -> Float -> Bloco -> ImagensB -> Pictures
desenhaBloco x y bloco imagensB =
    case lookup bloco imagensB of
        Just img -> [translate (realToFrac x) (realToFrac y) img]
        Nothing -> [Blank]

-- | Auxiliar nº1 da desenhaEntidade.
desenhaEntidadeAux1 :: [Personagem] -> Personagem -> ImagensP -> CarregaTecla -> ParidadeT -> Pictures
desenhaEntidadeAux1 e p = desenhaEntidadeAux2 (e ++ [p])

-- | Auxiliar nº2 da desenhaEntidade.
desenhaEntidadeAux2 :: [Personagem] -> ImagensP -> CarregaTecla -> ParidadeT -> Pictures
desenhaEntidadeAux2 [] _ _ _ = []
desenhaEntidadeAux2 (x:xs) i t p = desenhaEntidade x i t p : desenhaEntidadeAux2 xs i t p

-- | Desenha as Entidades.
desenhaEntidade :: Personagem -> ImagensP -> CarregaTecla -> ParidadeT -> Picture
desenhaEntidade p@(Personagem _ tipo (x, y) dir _ esc _ _ _ dano) li tecla par =
    case li of
        [(t, lImagens)] ->
            case t of
                Escuro ->
                    case (lookup Jogador lImagens, lookup Fantasma lImagens, lookup MacacoMalvado lImagens) of
                        (Just jimg, Just fimg, Just macimg) ->
                            case tipo of
                                Jogador ->
                                    case dano of
                                        (True, _) ->
                                            (if acarregar tecla then (if esc then scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 9)) else (case dir of
                                                  Este -> scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 7))
                                                  Oeste -> scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 8)))) else (if esc then scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 9)) else (if teclaw tecla then (case dir of
                                                  Este -> scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 6))
                                                  Oeste -> scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 5))) else (case dir of
                                                  Este  -> scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 7))
                                                  Oeste -> scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 8))))))
                                        (False, _) ->
                                            (if acarregar tecla then (if esc then scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 9)) else (case dir of
                                                  Este -> scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 1))
                                                  Oeste -> scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 2)))) else (if esc then scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 9)) else (if teclaw tecla then (case dir of
                                                  Este -> scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 4))
                                                  Oeste -> scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 3))) else (case dir of
                                                  Este  -> scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 1))
                                                  Oeste -> scale 1 1 (translate (realToFrac x) (realToFrac y) (jimg !! 2))))))
                                Fantasma ->
                                    case dir of
                                                  Este -> scale 1 1 (translate (realToFrac x) (realToFrac y) (head fimg))
                                                  Oeste -> scale 1 1 (translate (realToFrac x) (realToFrac y) (fimg !! 1))
                                                  _ -> Blank
                                MacacoMalvado ->
                                    (if par then translate (realToFrac x) (realToFrac y) $ scale 2 2 (head macimg) else translate (realToFrac x) (realToFrac y) $ scale 2 2 (macimg !! 1))
                        _ -> Blank
                _ -> Blank
        _ -> Blank

-- | Função que faz alterações no estado consoante alguns eventos vão acontecendo (clicar em teclas por exemplo).
reageEvento :: Event -> PrimateKong -> PrimateKong
reageEvento e pk@(PK j@(Jogo m@(Mapa _ _ mb) i c p) mn op im ta te s par tc) =
    case mn of
        InGame -> case e of
                    EventKey (Char 'p') Down _ _ -> pk { menu = MenuPausa , opcoes = Default}
                    EventKey (Char 'w') Down _ _ ->
                        if vazioEmBaixo mb p
                        then pk { carteclas = tc { acarregar = True , acao = Just Subir , teclaw = False } }
                        else  if podeSaltar2 m p
                              then pk { carteclas = tc { acarregar = False , acao = Just Saltar , teclaw = True } }
                              else pk
                    EventKey (Char 'w') Up _ _ ->
                        pk { carteclas = tc { acarregar = False , acao = Just Parar , teclaw = False } }
                    EventKey (Char 'a') Down _ _ ->
                        pk { carteclas = tc { acarregar = True , acao = Just AndarEsquerda , teclaa = True , teclaw = False } }
                    EventKey (Char 'a') Up _ _ ->
                        pk { carteclas = tc { acarregar = False , acao = Just Parar , teclaa = False , teclaw = False } }
                    EventKey (Char 's') Down _ _ ->
                        pk { carteclas = tc { acarregar = True , acao = Just Descer , teclaw = False } }
                    EventKey (Char 's') Up _ _ ->
                        pk { carteclas = tc { acarregar = False , acao = Just Parar , teclaw = False } }
                    EventKey (Char 'd') Down _ _ ->
                        pk { carteclas = tc { acarregar = True , acao = Just AndarDireita , teclad = True , teclaw = False }  }
                    EventKey (Char 'd') Up _ _ ->
                        pk { carteclas = tc { acarregar = False , acao = Just Parar , teclad = False , teclaw = False } }
                    _ -> pk

        MenuInicial -> case op of
                    Default       -> case e of
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk {opcoes = Jogar}
                                       EventKey (SpecialKey KeyDown) Down _ _ -> pk {opcoes = Jogar}
                                       EventKey (SpecialKey KeyLeft) Down _ _ -> pk {opcoes = Jogar}
                                       EventKey (SpecialKey KeyRight) Down _ _ -> pk {opcoes = Jogar}
                                       _ -> pk


                    Jogar         -> case e of
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk {opcoes = Sair}
                                       EventKey (SpecialKey KeyDown) Down _ _ -> pk {opcoes = Opcoes}
                                       EventKey (SpecialKey KeyEnter) Down _ _ -> pk {menu = InGame , opcoes = Default}
                                       _ -> pk


                    Opcoes       -> case e of
                                       EventKey (SpecialKey KeyEnter) Down _ _ -> pk {menu = Options, opcoes = Default}
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk {opcoes = Jogar}
                                       EventKey (SpecialKey KeyDown) Down _ _ -> pk {opcoes = Creditos}
                                       _ -> pk


                    Creditos      -> case e of
                                       EventKey (SpecialKey KeyEnter) Down _ _ -> pk {menu = MenuCreditos , opcoes = Default}
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk {opcoes = Opcoes}
                                       EventKey (SpecialKey KeyDown) Down _ _   -> pk {opcoes = Sair}
                                       _ -> pk


                    Sair          -> case e of
                                       EventKey (SpecialKey KeyEnter) Down _ _ -> error "A fechar o jogo..."
                                       EventKey (SpecialKey KeyUp) Down _ _  -> pk {opcoes = Creditos}
                                       EventKey (SpecialKey KeyDown) Down _ _    -> pk { opcoes = Jogar}
                                       _ -> pk
                    _             -> pk


        MenuPausa   -> case op of
                    Default       -> case e of
                                       EventKey (SpecialKey KeyDown) Down _ _ -> pk {opcoes = Continuar}
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk {opcoes = Continuar}
                                       EventKey (SpecialKey KeyLeft) Down _ _ -> pk {opcoes = Continuar}
                                       EventKey (SpecialKey KeyRight) Down _ _ -> pk {opcoes = Continuar}
                                       _ -> pk


                    Continuar     -> case e of
                                       EventKey (SpecialKey KeyEnter) Down _ _ -> pk {menu = InGame , opcoes = Default}
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk { opcoes = Sair}
                                       EventKey (SpecialKey KeyDown) Down _ _ -> pk { opcoes = Opcoes}
                                       _ -> pk


                    Opcoes        -> case e of
                                       EventKey (SpecialKey KeyEnter) Down _ _ -> pk {menu = Options , opcoes = Default}
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk { opcoes = Continuar}
                                       EventKey (SpecialKey KeyDown) Down _ _ -> pk { opcoes = Creditos}
                                       _ -> pk


                    Creditos      -> case e of
                                       EventKey (SpecialKey KeyEnter) Down _ _ -> pk {menu = MenuCreditos , opcoes = Default}
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk {opcoes = Opcoes}
                                       EventKey (SpecialKey KeyDown) Down _ _   -> pk {opcoes = Sair}
                                       _ -> pk


                    Sair          -> case e of
                                       EventKey (SpecialKey KeyEnter) Down _ _ -> pk {menu = MenuInicial , opcoes = Default}
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk {opcoes = Creditos}
                                       EventKey (SpecialKey KeyDown) Down _ _   -> pk {opcoes = Continuar}
                                       _ -> pk


        MenuCreditos -> case op of
                    Default       -> case e of
                                       EventKey (SpecialKey KeyDown) Down _ _ -> pk {opcoes = Voltar}
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk {opcoes = Voltar}
                                       EventKey (SpecialKey KeyLeft) Down _ _ -> pk {opcoes = Voltar}
                                       EventKey (SpecialKey KeyRight) Down _ _ -> pk {opcoes = Voltar}
                                       _ -> pk


                    Voltar        -> case e of
                                       EventKey (SpecialKey KeyEnter) Down _ _ -> pk {menu = MenuInicial , opcoes = Default}
                                       _ -> pk
                    _                  -> pk


        Options     -> case op of
                    Default       -> case e of
                                       EventKey (SpecialKey KeyDown) Down _ _ -> pk {opcoes = Voltar}
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk {opcoes = Voltar}
                                       EventKey (SpecialKey KeyLeft) Down _ _ -> pk {opcoes = Voltar}
                                       EventKey (SpecialKey KeyRight) Down _ _ -> pk {opcoes = Voltar}
                                       _ -> pk
                    Voltar        -> case e of
                                       EventKey (SpecialKey KeyEnter) Down _ _ -> pk {menu = MenuInicial , opcoes = Default}
                                       _ -> pk
                    _                  -> pk


        Win -> case op of
                    Default       -> case e of
                                       EventKey (SpecialKey KeyDown) Down _ _ -> pk {opcoes = Creditos}
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk {opcoes = Creditos}
                                       EventKey (SpecialKey KeyLeft) Down _ _ -> pk {opcoes = Creditos}
                                       EventKey (SpecialKey KeyRight) Down _ _ -> pk {opcoes = Creditos}
                                       _ -> pk


                    Creditos      -> case e of
                                       EventKey (SpecialKey KeyDown) Down _ _ -> pk {opcoes = Voltar}
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk {opcoes = Voltar}
                                       EventKey (SpecialKey KeyEnter) Down _ _ -> pk {menu = MenuCreditos, opcoes = Default}
                                       _ -> pk


                    Voltar        -> case e of
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk {opcoes = Creditos}
                                       EventKey (SpecialKey KeyDown) Down _ _ -> pk {opcoes = Creditos}
                                       EventKey (SpecialKey KeyEnter) Down _ _ -> pk {menu = MenuInicial , opcoes = Default}
                                       _ -> pk


        Lose -> case op of
                    Default       -> case e of
                                       EventKey (SpecialKey KeyDown) Down _ _ -> pk {opcoes = Jogar}
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk {opcoes = Jogar}
                                       EventKey (SpecialKey KeyLeft) Down _ _ -> pk {opcoes = Jogar}
                                       EventKey (SpecialKey KeyRight) Down _ _ -> pk {opcoes = Jogar}
                                       _ -> pk


                    Jogar         -> case e of
                                       EventKey (SpecialKey KeyDown) Down _ _ -> pk {opcoes = Voltar}
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk {opcoes = Voltar}
                                       EventKey (SpecialKey KeyEnter) Down _ _ -> PK j InGame Default im ta te s par tc
                                       _ -> pk

                    Voltar        -> case e of
                                       EventKey (SpecialKey KeyUp) Down _ _ -> pk {opcoes = Jogar}
                                       EventKey (SpecialKey KeyDown) Down _ _ -> pk {opcoes = Jogar}
                                       EventKey (SpecialKey KeyEnter) Down _ _ -> pk {menu = MenuInicial , opcoes = Default}
                                       _ -> pk



-- | Função que faz alterações no estado consoante o tempo vai passando.
reageTempo :: Float -> PrimateKong -> PrimateKong
reageTempo tempo (PK j@(Jogo m i c p) mn op im te t s par car) =
    case mn of
        InGame ->
            let tA     = realToFrac tempo + t
                jA     = movimenta3 s tA (movimentoTecla (Jogo m i c p) car)
                pA     = verificaParidade (realToFrac tA)
                mA = perdeOuGanha j
            in  PK jA mn op im te tA s pA car
        _ -> PK j mn op im te (realToFrac tempo + t) s par car
        where
         perdeOuGanha :: Jogo -> Menu
         perdeOuGanha j
           | apanhaEstrela j = Win
           | perderJogo j = Lose
           | otherwise = InGame

-- | Função Main (O que faz o jogo funcionar).         
main :: IO ()
main = do
    eI <- estadoInicial
    if valida (jogo eI)
        then do
            putStrLn "A iniciar jogo ..."
            play mainDisplay corfundo fr eI desenhaEstado reageEvento reageTempo
        else do
            putStrLn "Erro, o jogo não é válido!"
            play mainDisplay corfundo fr eI desenhaEstado reageEvento reageTempo

-- | Mapa do Jogo.
nivel1 :: [[Bloco]]
nivel1 = [[Plataforma,  Plataforma,  Plataforma,  Plataforma,  Plataforma, Plataforma,  Plataforma,  Plataforma,  Plataforma,  Plataforma, Plataforma,  Plataforma,  Plataforma,  Plataforma,  Plataforma, Plataforma,  Plataforma,  Plataforma,  Plataforma,  Plataforma, Plataforma,  Plataforma,  Plataforma,  Plataforma,  Plataforma, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Plataforma,  Plataforma,  Plataforma,  Plataforma,  Plataforma, Escada, Vazio, Plataforma, Plataforma, Vazio, Plataforma, Plataforma, Vazio, Plataforma, Vazio, Escada, Plataforma, Plataforma, Plataforma, Plataforma, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Escada, Plataforma, Plataforma, Alcapao, Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Plataforma, Plataforma, Escada, Plataforma, Plataforma, Alcapao, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Vazio, Plataforma],
          [Plataforma, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Plataforma, Plataforma, Plataforma, Escada, Plataforma, Plataforma, Plataforma, Plataforma, Vazio, Plataforma, Plataforma, Plataforma,Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Plataforma, Plataforma, Escada, Plataforma, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Plataforma, Plataforma, Plataforma, Plataforma,Plataforma, Plataforma, Alcapao, Plataforma, Plataforma, Plataforma, Escada, Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Plataforma, Plataforma, Plataforma, Plataforma, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Plataforma, Plataforma, Plataforma, Plataforma, Plataforma, Alcapao, Plataforma, Plataforma,Plataforma, Plataforma,Plataforma, Plataforma,Plataforma, Plataforma, Alcapao, Plataforma, Plataforma,Plataforma, Plataforma, Escada, Plataforma, Plataforma,Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio,Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio,Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio,Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Plataforma],
          [Plataforma, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio,Vazio, Vazio, Vazio,Vazio, Vazio, Vazio,Vazio, Vazio, Vazio, Escada, Vazio, Vazio, Plataforma],
          [Plataforma,  Plataforma,  Plataforma,  Plataforma,  Plataforma, Plataforma,  Plataforma,  Plataforma,  Plataforma,  Plataforma, Plataforma,  Plataforma,  Plataforma,  Plataforma,  Plataforma, Plataforma,  Plataforma,  Plataforma,  Plataforma,  Plataforma, Plataforma,  Plataforma,  Plataforma,  Plataforma,  Plataforma, Plataforma]]