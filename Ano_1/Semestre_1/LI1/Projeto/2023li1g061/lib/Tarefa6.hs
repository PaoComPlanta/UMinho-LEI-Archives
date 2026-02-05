{-|
Module      : TarefaComplementar
Description : Alterações necesssárias em algumas funções para correr o Jogo.
Copyright   : Francisco Miguel Fernandes Soares <a106901@alunos.uminho.pt>
              Simão Pedro Pacheco Mendes <a106928@alunos.uminho.pt>

Módulo para a realização da Tarefa 6 de LI1 em 2023/24.
-}

module TarefaComplementar where


import LI12324
import Tarefa1
import Tarefa2
import Tarefa3
import Tarefa4
import Data.Maybe
import Data.List
import Graphics.Gloss.Interface.IO.Game


data CarregaTecla = Car {  acarregar :: Bool,
                           acao      :: Maybe Acao,
                           teclaa    :: Bool,
                           teclad    :: Bool,
                           teclaw    :: Bool }
                           deriving (Eq, Show)

type ParidadeT = Bool

-- | Movimento tecla.
movimentoTecla :: Jogo -> CarregaTecla -> Jogo
movimentoTecla j@(Jogo m i c p@(Personagem (vx, vy) _ _ _ _ _ _ _ _ _)) ct
    | acarregar ct && (podeSaltar2 m p || (acao ct == Just Subir) || (acao ct == Just Descer)) =
        atualiza2 [] (acao ct) j
    | acao ct == Just Saltar && not (teclaa ct || teclad ct) =
        atualiza2 [] (acao ct) j
    | acao ct == Just Saltar && teclad ct =
        atualiza2 [] (Just Saltar) (j { jogador = p { velocidade = (vx+3, vy) } })
    | acao ct == Just Saltar && teclaa ct =
        atualiza2 [] (Just Saltar) (j { jogador = p { velocidade = (vx-3, vy) } })
    | acao ct == Just Parar =
        atualiza2 [] (acao ct) j
    | otherwise = j

-- | Verifica se o personagem pode saltar.
podeSaltar2 :: Mapa -> Personagem -> Bool
podeSaltar2 (Mapa _ _ m) p@(Personagem _ _ pos _ _ _ _ _ _ _)
   | posp `elem` lp = True
   | otherwise = False
     where
       posp = mudaTipo $ arredonda pos
       lp = concatMap (\(x, y) -> [(a, b) | a <- [x .. x + 32], b <- [y]]) (map (\(x,y) -> (x-15,y+30)) (map matrizPMapa (posPlataformas m)))

-- | Função que atualiza as personagens.
atualizaPersonagem2 :: Mapa -> Acao -> Personagem -> Personagem 
atualizaPersonagem2 m@(Mapa _ _ b) acao p@(Personagem (vx, vy) _ _ d _ e _ _ _ _) =
 case acao of
    Subir         -> if e then p {velocidade = (0, vy+3)} else p
    Descer        -> if e then p {velocidade = (0, vy-3)} else p
    AndarDireita  -> if podeSaltar2 m p then p {velocidade = (vx+3,vy)} else p
    AndarEsquerda -> if podeSaltar2 m p then p {velocidade = (vx-3, vy)} else p
    Saltar        -> if e == False && podeSaltar2 m p then p {velocidade = (vx, vy-34)} else p
    Parar         -> if podeSaltar2 m p then p {velocidade = (0,0)} else p


-- | Função que atualiza o Jogador.
atualizaJogador2 :: Mapa -> Maybe Acao -> Personagem -> Personagem
atualizaJogador2 m mac p =
    case mac of
        Just ac -> atualizaPersonagem2 m ac p
        Nothing -> p

-- Atualiza versão 2.
atualiza2 :: [Maybe Acao] -> Maybe Acao -> Jogo -> Jogo 
atualiza2 ai aj (Jogo m i c j) = (Jogo m (atualizaInimigo m ai i) c (atualizaJogador2 m aj j))



-- | Função que verifica se o jogador perde o Jogo.
perderJogo :: Jogo -> Bool
perderJogo j@(Jogo m i c p@(Personagem _ _ _ _ _ _ _ v _ _)) =  if v > 0 then False else True

-- | Posição de um personagem. 
posPer :: Personagem -> Posicao
posPer p@(Personagem _ _ (x,y) _ _ _ _ _ _ _) = (x,y)

-- | Arredonda para o Integer mais próximo.
arredonda :: Posicao -> (Int,Int)
arredonda (x,y) = (round x, round y)

-- | Muda de Pares de Int para posição.
mudaTipo :: (Int, Int) -> Posicao
mudaTipo (x,y) = (fromIntegral x, fromIntegral y)

-- | Função que passa de coordenadas dentro da matriz para o mapa real
matrizPMapa :: Posicao -> Posicao
matrizPMapa (x, y) = (26 * x - 340, 450 - 32 * y)

-- | Função que passa das coordenadas do canto superior esquerdo do mapa para as coordenadas do centro da matriz
cantoCentro :: Posicao -> Posicao
cantoCentro (x, y) = ((x + 340) / 26, ((-y + 450) / 32))

-- | Posição das plataformas.
posPlataformas :: [[Bloco]] -> [Posicao]
posPlataformas [] = []
posPlataformas m =
  concatMap (\(l, bs) -> [(fromIntegral c + 0.5, fromIntegral l + 0.5) | (b, c) <- zip bs [0..], b == Plataforma]) $ zip [0..] m


-- | Posição dos vazios.
posVazios :: [[Bloco]] -> [Posicao]
posVazios  [] = []
posVazios  m =
  concatMap (\(l, bs) -> [(fromIntegral c + 0.5, fromIntegral l + 0.5) | (b, c) <- zip bs [0..], b == Vazio]) $ zip [0..] m


-- | Posicao das escadas.
posEscadas :: [[Bloco]] -> [Posicao]
posEscadas  [] = []
posEscadas  m =
  concatMap (\(l, bs) -> [(fromIntegral c + 0.5, fromIntegral l + 0.5) | (b, c) <- zip bs [0..], b == Escada]) $ zip [0..] m


-- | Posição dos alcapoes.
posAlcapoes :: [[Bloco]] -> [Posicao]
posAlcapoes[] = []
posAlcapoes m =
  concatMap (\(l, bs) -> [(fromIntegral c + 0.5, fromIntegral l + 0.5) | (b, c) <- zip bs [0..], b == Alcapao]) $ zip [0..] m


-- | Colisão lateral 
colisaoLado :: Mapa -> Personagem -> Personagem
colisaoLado (Mapa _ _ m) p@(Personagem (vx, vy) _ (x, y) _ _ _ _ _ _ _)
  | colDir = p { velocidade = (min 0 vx, vy) , posicao = (x-3,y) }
  | colEsq = p { velocidade = (max 0 vx, vy) }
  | otherwise = p
  where
      colEsq = (x, y) `elem` concatMap (\ (x, y) -> [(i, j) | i <- [x], j <- [y .. y + 32]]) (map (\ (x, y) -> (x + 26, y - 26)) (map matrizPMapa pp))
      colDir = (x, y) `elem` concatMap (\ (x, y) -> [(i, j) | i <- [x], j <- [y .. y + 32]]) (map (\ (x, y) -> (x - 26, y - 26)) (map matrizPMapa pp))
      pp = posPlataformas m

-- | Colisão lateral inimigos
colisaoLadoI :: Mapa -> [Personagem] -> [Personagem] 
colisaoLadoI m i = map (colisaoLado m) i

-- | Função que altera o tempo de duração do Martelo até este acabar.
acabaMartelo :: Personagem -> Personagem
acabaMartelo p@(Personagem _ _ _ _ _ _ _ _ _ (da,t))
  | t > 0 = p {aplicaDano = (da, t-(1/30))}
  | otherwise = p {aplicaDano = (False, 0)}

-- | Adiciona colecionáveis
maisColecionavel :: (Colecionavel, Posicao) -> Jogo -> Jogo
maisColecionavel c (Jogo m i r p) = (Jogo m i (c:r) p)

-- | Posição do Jogador e do colecionável intersetam-se.
posJogColec :: Posicao -> Posicao -> Bool
posJogColec j c = any (`elem` [j]) ac
  where
   ac = concatMap (\(x, y) -> [(i, j) | i <- [x .. x + 32], j <- [y]]) (map (\(x, y) -> (x - 15, y)) [c])

-- | Função que verifica se os colecionáveis são coletados e aplica os seus respetivos efeitos.
apanhaColec2 :: Jogo -> Jogo
apanhaColec2 j@(Jogo m i [] p) = j  -- Nao há colecionaveis
apanhaColec2 (Jogo m i (colec@(c, posc):r) p@(Personagem _ _ posp _ _ _ _ _ pt _))
   | posJogColec posp posc && c == Martelo = apanhaColec2 (Jogo m i r p { aplicaDano = (True, 10) })
   | posJogColec posp posc && c == Moeda   = apanhaColec2 (Jogo m i r p { pontos = (pt + 100) })
   | posJogColec posp posc && c == Estrela = apanhaColec2 (Jogo m i r p { pontos = (pt + 1000)})
   | otherwise = maisColecionavel colec (apanhaColec2 (Jogo m i r p))

-- | Função que verifica se o jogador apanhou a estrela.
apanhaEstrela :: Jogo -> Bool
apanhaEstrela j@(Jogo m i [] p ) = False -- Nao ha estrela
apanhaEstrela (Jogo m i (colec@(c, posc):r) p@(Personagem _ _ posp _ _ _ _ _ pt _))
    | posJogColec posp posc && c == Estrela = True
    | otherwise = False

-- | Função que trata de aplicar a gravidade ao jogador.
gravidadeJ2 :: Mapa -> Personagem -> Personagem
gravidadeJ2 (Mapa _ _ m) p@(Personagem (vx, vy) _ pos _ _ e _ _ _ _)
  | e = p
  | not (pos2 `elem` mp) = p { velocidade = (vx, vy - 10) }
  | otherwise = p
    where
        pos2 = mudaTipo $ arredonda pos
        mp = concatMap (\(x, y) -> [(i, j) | i <- [x .. x + 60], j <- [y]]) (map (\(x,y) -> (x-26,y+32)) (map matrizPMapa (posPlataformas m))) 

-- | Função que trata de aplicar a gravidade aos inimigos fantasmas.
gravidadeI2 :: Mapa -> Personagem -> Personagem
gravidadeI2 (Mapa _ _ m) p@(Personagem (vx, vy) t pos _ _ _ _ _ _ _)
  | numaEscadaI m p = p
  | not (any (==pos2) mpe) && t == Fantasma = p { velocidade = (vx, vy + 10) }
  | otherwise = p
    where
        pos2 = mudaTipo $ arredonda pos
        mpe = concatMap (\(x, y) -> [(i, j) | i <- [x .. x + 45], j <- [y]]) (map (\(x,y) -> (x-22.5,y+30)) (map matrizPMapa (posPlataformas m ++ posAlcapoes m))) 

-- | Gravidade aplicada à lista de inimigos.
gravidadeI2T :: Mapa -> [Personagem] -> [Personagem]
gravidadeI2T m i = map (gravidadeI2 m) i

{- Tentamos fazer esta implementação da gravidade para tentar corrigir a de cima, mas o jogador ficava simplemente parado no ar e passado algum tempo, o jogo crashava.
ordLinha :: (Double, Double) -> Int
ordLinha (x,y) = ordLinhaAux (x, y) (-950) 0

ordLinhaAux :: (Double,Double) -> Double -> Int -> Int
ordLinhaAux (x,y) a b
    | x >= a && x <= (a + 30) = b
    | otherwise = ordLinhaAux (x,y) (a + 30) (b + 1)


ordColuna :: (Double, Double) -> Int
ordColuna (x,y) = ordColunaAux (x,y) 780 0

ordColunaAux :: (Double, Double) -> Double -> Int -> Int
ordColunaAux (x,y) a b
    | y <= a && y >= (a - 30) = b
    | otherwise = ordLinhaAux (x,y) (a-30) (b+1)

qualBloco :: Mapa -> Posicao -> Bloco
qualBloco (Mapa   m) (x,y) = (m !! ordLinha (x,y)) !! ordColuna (x,y)

podeGrav :: Mapa -> Personagem -> Bool
podeGrav m p@(Personagem (vx,vy)  (x,y)  (a,l)     _) =
  qualBloco m (x,y-(a/2)-2) == Vazio
-}

-- | Função que verifica se um personagem se encontra numa escada.
numaEscadaI :: [[Bloco]] -> Personagem -> Bool
numaEscadaI m p@(Personagem _ _ pos _ _ _ _ _ _ _)
   | any (`elem` [pos]) me = True
   | otherwise = False
   where
    me = concatMap (\(x, y) -> [(i, j) | i <- [x], j <- [y .. y + 30]]) (map (\(x,y) -> (x,y-30)) (map matrizPMapa (posAlcapoes m)))

-- | Movimento do Jogador
movimentoJ2 :: Personagem -> Personagem
movimentoJ2 (Personagem (vx,vy) c2 (x, y) c4 c5 c6 c7 c8 c9 c10) = (Personagem (0,0) c2 (x + vx, y + vy) c4 c5 c6 c7 c8 c9 c10)

-- | Movimento dos inimigos
movimentoI2 :: [Personagem] -> [Personagem]
movimentoI2 i = map movimentoJ i

-- | Arredonda os valores das posições.
arredondaPos :: Posicao -> [Posicao] -> Posicao
arredondaPos _ [] = error "Lista vazia"
arredondaPos pi p = foldl1' (\p1 p2 -> if distancia pi p1 < distancia pi p2 then p1 else p2) p

-- | Verifica a distância entre dois pontos.
distancia :: Posicao -> Posicao-> Double
distancia (x1, y1) (x2, y2) = sqrt ((x2 - x1)^2 + (y2 - y1)^2)

-- | O movimento dos inimigos é aleatório.
movAleatorioIni :: Mapa -> Semente -> [Personagem] -> [Personagem]
movAleatorioIni m s [] = []
movAleatorioIni m s (p@(Personagem c1 t c3 c4 c5 c6 c7 c8 c9 c10):r)
  | t == Fantasma = proMovimento m p : movAleatorioIni m s r
  | otherwise = p : movAleatorioIni m s r

 
-- | Função que calcula o próximo movimento do inimigo
proMovimento :: Mapa -> Personagem -> Personagem
proMovimento m@(Mapa _ _ mb) p@(Personagem (vx,vy) _ _ d _ _ r _ _ _)
     | numaEscadaI mb p = p {velocidade = (vx, vy+3)}
     | colisaoLadosI m p == (True,False) && r = p {velocidade = (vx-4,vy), direcao = Oeste}
     | colisaoLadosI m p == (True,True)  && r = p {velocidade = (vx+4,vy), direcao = Este }
     | otherwise = if d == Este then p {velocidade = (vx+4,vy), direcao = Este} else p {velocidade = (vx-4,vy), direcao = Oeste}

-- | Colisão com os lados dos inimigos
colisaoLadosI :: Mapa -> Personagem -> (Bool,Bool)
colisaoLadosI (Mapa _ _ m) j@(Personagem (vx, vy) _ pos _ _ _ _ _ _ _)
   | colisaoD = (True,False)
   | colisaoE = (True,True)
   | otherwise = (False, False)
  where
    colisaoE = pos `elem` concatMap (\(x, y) -> [(i, j) | i <- [x], j <- [y .. y + 32]]) (map (\(x,y) -> (x+30,y-15)) (map matrizPMapa lP ))
    colisaoD = pos `elem` concatMap (\(x, y) -> [(i, j) | i <- [x], j <- [y .. y + 32]]) (map (\(x,y) -> (x-30,y-15)) (map matrizPMapa lP))
    lP = posPlataformas m

-- | Inimigos perdem vida.
inPerdeVida2 :: [Personagem] -> Personagem -> [Personagem]
inPerdeVida2 [] _ = []
inPerdeVida2 (i@(Personagem c1 ti c3@(x,y) c4 c5 c6 c7 v c9 (d,id2)):r) p@(Personagem a1 a2 (a,b) a4 a5 a6 a7 a8 a9 (da,t))
 | any (`elem` iNP) (hitboxDano2 p) && da && ti == Fantasma = ((Personagem c1 ti c3 c4 c5 c6 c7 (v - 1) c9 (d,id2))) : inPerdeVida2 r p
 | otherwise = (Personagem c1 ti c3 c4 c5 c6 c7 v c9 (da,t)) : inPerdeVida2 r p
  where
    iNP = concatMap (\(x, y) -> [(i, j) | i <- [x .. x + 14 ], j <- [y .. y + 14]]) (map (\(x,y) -> (x-7.5,y-7.5)) [(x,y)])

-- | Hitboxes do dano.
hitboxDano2 :: Personagem -> [Posicao]
hitboxDano2 (Personagem _ _ (x, y) d (g, c) _ _ _ _ _)
    | d == Este   = concatMap (\(x, y) -> [(i, j) | i <- [x .. x + 14 ], j <- [y .. y + 14]]) (map (\(x,y) -> (x+22.5,y-7.5)) [(x,y)])
    | d == Oeste  = concatMap (\(x, y) -> [(i, j) | i <- [x .. x + 14 ], j <- [y .. y + 14]]) (map (\(x,y) -> (x-37.5,y-7.5)) [(x,y)])
    | otherwise   = [(x,y)]

-- | Jogador leva dano.
jogadorLevaD2 :: [Personagem] -> Personagem -> Personagem
jogadorLevaD2 [] p = p
jogadorLevaD2 i p@(Personagem _ _ _ _ _ _ _ v _ _)
   | any (==True) (colisoesDano2 i p) = p { vida = (v - 1) }
   | otherwise = p

-- | Colisões com dano.
colisoesDano2 :: [Personagem] -> Personagem -> [Bool]
colisoesDano2 [] p = [False]
colisoesDano2 (h:t) p = colisoesPersonagens2 h p : colisoesDano2 t p

-- | Colisões entre personagens.
colisoesPersonagens2 :: Personagem -> Personagem -> Bool
colisoesPersonagens2 (Personagem c1 c2 (x1,y1) c4 c5 c6 c7 v c9 (d,id2)) (Personagem a1 a2 (x2,y2) a4 a5 a6 a7 a8 a9 a10)
    | any (`elem` hitI) hitJ = True
    | otherwise = False
    where
      hitI = concatMap (\(x, y) -> [(i, j) | i <- [x .. x + 14], j <- [y .. y + 14]]) (map (\(x,y) -> (x-7.5,y-7.5)) [(x1,y1)])
      hitJ = concatMap (\(x, y) -> [(i, j) | i <- [x .. x + 14], j <- [y .. y + 14]]) (map (\(x,y) -> (x-7.5,y-7.5)) [(x2,y2)])

-- | Função movimenta versão 3
movimenta3 :: Semente -> Tempo -> Jogo -> Jogo 
movimenta3 s t j@(Jogo m@(Mapa pos d mb) i c p) =
     apanhaColec2 $ Jogo ma (colisaoLadoI m (corEscadaI mb (gravidadeI2T m (filtraInimigos (inPerdeVida2 ia p))))) c (acabaMartelo (movimentoJ2 (jogadorLevaD2 i (corEscada mb (colisaoLado m (gravidadeJ2 m (numaEscada3 mb p)))))))
     where
       ma = (Mapa pos d (pisaAlcapao2 m p))
       ia = movimentoI (movAleatorioIni m s i)

-- | Verifica se um alçapão foi pisado.
pisaAlcapao2 :: Mapa -> Personagem -> [[Bloco]]
pisaAlcapao2 mp@(Mapa _ _ m) p@(Personagem _ t (x, y) _ _ _ _ _ _ _)
        | t == Jogador && any (==(x, y)) pa = substituiBMatriz m (yf-0.5,xf-0.5) Vazio
        | otherwise = m
      where
        (xf,yf) = arredondaPos (cantoCentro (x,y)) (posAlcapoes m)
        pa = concatMap (\(x, y) -> [(i, j) | i <- [x .. x + 32], j <- [y]]) (map (\(x,y) -> (x - 15,y + 30)) (map matrizPMapa (posAlcapoes m)))

-- | Verifica se está numa escada versão 3
numaEscada3 :: [[Bloco]]-> Personagem -> Personagem
numaEscada3 m p@(Personagem _ _ pos _ _ _ _ _ _ _)
   | any (`elem` [pos]) me = p { emEscada = True }
   | otherwise = p { emEscada = False}
   where
    me = concatMap (\(x, y) -> [(i, j) | i <- [x .. x + 32], j <- [y .. y + 31]]) (map (\(x,y) -> (x-15,y)) (map matrizPMapa (posEscadas m)))

-- | Verifa se um inimigo está numa escada.
corEscada :: [[Bloco]] -> Personagem -> Personagem
corEscada m p@(Personagem (vx,vy) c2 (x,y) c4 c5 c6 c7 c8 c9 c10)
  | any (`elem` [(x,y)]) es = p {posicao = (x, y+60)}
  | otherwise = p
  where
    es = concatMap (\(x, y) -> [(i, j) | i <- [x .. x + 32], j <- [y]]) (map (\(x,y) -> (x-15,y-30)) (corEscadaAux m))

-- | Auxiliar da função acima.
corEscadaAux :: [[Bloco]] -> [Posicao]
corEscadaAux m =
     let p = posPlataformas m
         pb = map (\(x, y) -> (x, y - 1)) (posEscadas m)
     in map matrizPMapa (nub [(x, y) | (x, y) <- p, (x, y) `elem` pb])

-- | Aplica a função corEscada à lista de inimigos.
corEscadaI :: [[Bloco]] -> [Personagem] -> [Personagem]
corEscadaI m i = map (corEscada m) i

-- | Verifica se numa posição dada é vazio.
vazioEmBaixo :: [[Bloco]] -> Personagem -> Bool
vazioEmBaixo m p@(Personagem _ _ (x,y) _ _ _ _ _ _ _)
   | any (`elem` [pos]) mv = True
   | otherwise = False
   where
    mv = concatMap (\(x, y) -> [(i, j) | i <- [x .. x + 32], j <- [y .. y + 30]]) (map (\(x,y) -> (x-15,y)) (map matrizPMapa (posEscadas m)))
    pos = (x,y)

-- | Verifica onde as personagens dão spawn.
nascInicial :: Mapa -> [Personagem] -> Bool
nascInicial (Mapa (pi,_) _ _) i = posM `elem` map posMi i
    where
        posM = cantoCentro pi
        posMi (Personagem _ _ p2 _ _ _ _ _ _ _) = cantoCentro p2

-- | verifica se o jogador passa pelo alçapão.
passaAlcapao :: Personagem -> Bool
passaAlcapao (Personagem _ _ _ _ (l,_) _ _ _ _ _) = l <= 30

-- | Verifica se algum colecionavel colide com algum bloco.
colisaoCoisas2 :: [Personagem] -> Personagem -> [(Colecionavel, Posicao)] -> Mapa -> Bool
colisaoCoisas2 li p c m@(Mapa _ _ b) = all (`elem` (posVazios b ++ posEscadas b)) (posInicialTudo li p c)

-- | Posição inicial dos personagens e dos colecionáveis.
posInicialTudo :: [Personagem] -> Personagem -> [(Colecionavel, Posicao)]-> [Posicao]
posInicialTudo li (Personagem _ _ (xp, yp) _ _ _ _ _ _ _) lc =
  map cantoCentro (map (\(Personagem _ _ (x1, y1) _ _ _ _ _ _ _) -> (x1, y1)) li ++ [(xp, yp)] ++ map snd lc)

-- | Faz o mesmo que a função cimaBEscada da Tarefa2.
cimaBEscada2 :: Mapa -> [Posicao] -> [(Bloco, Bloco)]
cimaBEscada2 _ [] = []
cimaBEscada2 (Mapa i1 i2 m) ((l, c):re)
    | l > 0 && l < fromIntegral (length m) - 1 && c >= 0 && c < fromIntegral (length (head m)) =
        let lAn = floor (l - 1)
            lAt = floor l
            lS = floor (l + 1)
            cA = floor c

            cima = m !! lAn !! cA
            baixo = m !! lS !! cA

            ext = (cima, baixo)
            r = cimaBEscada2 (Mapa i1 i2 m) re
        in if cima /= Alcapao && baixo /= Alcapao && (cima == Plataforma || baixo == Plataforma)
            then ext : r
            else r
    | otherwise = cimaBEscada2 (Mapa i1 i2 m) re

-- | Função valida versão 2.
valida2 :: Jogo -> Bool
valida2 (Jogo m@(Mapa _ _ mb) i c p)
   = all (==True) [f1,f2,f3,f4,f5,f6,f7,f8]
   where
    f1 = temChao m
    f2 = testeRessalta i p
    f3 = not (nascInicial m i)
    f4 = minInimigos i
    f5 = verificaVidas (verificaVidasAux i)
    f6 = verificaCB (cimaBEscada2 m (posEscada m)) -- 
    f7 = passaAlcapao p
    f8 = colisaoCoisas2 i p c m

-- | Verifica se o tempo é par ou ímpar (isto entra na movimentação do macaco).
verificaParidade :: Tempo -> ParidadeT
verificaParidade t = if odd (ceiling t) then True else False

{-| Nota: Algumas das funções em cima não conseguimos utilizar de maneira efetiva, de tal maneira que o jogo tem um bug que faz o jogador e os inimigos cair para o vazio. Bug esse que não conseguimos resolver, apesar de diversas tentativas.-}