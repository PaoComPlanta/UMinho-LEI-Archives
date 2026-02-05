{-|
Module      : Tarefa3
Description : Movimenta personagens no jogo
Copyright   : Francisco Miguel Fernandes Soares <a106901@alunos.uminho.pt>
              Simão Pedro Pacheco Mendes <a106928@alunos.uminho.pt>

Módulo para a realização da Tarefa 3 de LI1 em 2023/24.
-}
module Tarefa3 where

import LI12324
import Tarefa1
import Tarefa2



{-|

A função __movimenta__ deve animar todas as personagens, i.e. calcular as suas novas posições e respectivas consequências.
Para isso, a função tem de testar uma lista __não recursiva__ de acontecimentos e condições a que os personagens estão sujeitos. Para concretizar o que dissemos anteriormente, aplicamos algumas funções auxiliares que têm como objetivo verificar determinadas condições e realizar certas mudanças no jogo, como é o caso das seguintes funções:

* @inPerdeVida@: Função que retira as vidas aos inimigos que colidem com a hitbox de dano de um jogador (martelo).
* @filtraInimigos@: Função que filtra os inimigos com 1 vida numa lista de inimigos.
* @pisaAlcapao@: Função que atualiza a matriz do mapa do jogo quando um alçapão é pisado.
* @gravPersonagem@: Função que faz os personagens cair (mudar a velocidade) quando não estão numa plataforma.
* @jogLevaDano@: Função que tira uma vida ao jogador se ele entrar em colisão com um inimigo.
* @apanhaColec@: Função que atualiza o jogo quando o jogador obtém um colecionável (aumentando a pontuação ou permitindo dar dano).
* @naoAtravessa@: Função que impede o personagem de sair do mapa e de atravessar blocos de plataforma (diminui a velocidade do personagem para 0).

== Propriedades:
=== Função principal "movimenta":
prop> movimenta :: Semente -> Tempo -> Jogo -> Jogo
prop> movimenta s t j@(Jogo m@(Mapa c1 c2 c3) i c p) = apanhaColec $ Jogo mn (filtraInimigos (inPerdeVida i p)) c (jogLevaDano i (naoAtravessa m (gravPersonagem mn p)))
prop>    where mn = (Mapa c1 c2 (pisaAlcapao m p))

=== Função auxiliar "inPerdeVida":
prop> inPerdeVida:: [Personagem] -> Personagem -> [Personagem]
prop> inPerdeVida [] _ = []
prop> inPerdeVida ((Personagem c1 c2 c3 c4 c5 c6 c7 v c9 (a,t)):ls) p
prop>   | hitboxPersonagem (Personagem c1 c2 c3 c4 c5 c6 c7 v c9 (a,t)) == hitboxDanoJ p && (pDaDano p == True) = ((Personagem c1 c2 c3 c4 c5 c6 c7 (v - 1) c9 (a,t))) : inPerdeVida ls p
prop>   | otherwise = (Personagem c1 c2 c3 c4 c5 c6 c7 v c9 (a,t)) : inPerdeVida ls p

==== Função "pDaDano":
prop> pDaDano :: Personagem -> Bool
prop> pDaDano (Personagem _ _ _ _ _ _ _ v _ (a, t))
prop>       | v > 0 && a == True = True
prop>       | otherwise          = False

==== Função "hitboxDanoJ":
prop> hitboxDanoJ :: Personagem -> Hitbox
prop> hitboxDanoJ p@(Personagem _ _ _ d (l, a) _ _ v _ (ad, t))
prop>  | pDaDano p && d == Este  = ((x2,y1), (x2+1,y2))
prop>  | pDaDano p && d == Oeste = ((x1-1,y1), (x1,y2))
prop>  | otherwise = ((0,0),(0,0))
prop>  where ((x1,y1), (x2,y2)) = hitboxPersonagem p

=== Função auxiliar "filtraInimigos":
prop> filtraInimigos :: [Personagem] -> [Personagem]
prop> filtraInimigos l = filter (\(Personagem _ _ _ _ _ _ _ v _ _) -> v == 1) l

=== Função auxiliar "pisaAlcapao":
prop> pisaAlcapao :: Mapa -> Personagem -> [[Bloco]]
prop> pisaAlcapao (Mapa _ _ m) p@(Personagem _ t (x, y) _ _ _ _ _ _ _)
prop>         | t == Jogador && any (==(fst (hitboxPersonagem p))) (posAlcapao m) = substituiBMatriz m (xp,yp) Vazio
prop>         | otherwise = m 
prop>        where (xp,yp) = fst (hitboxPersonagem p)

==== Função "substituiBMatriz":
prop> substituiBMatriz :: [[Bloco]] -> Posicao -> Bloco -> [[Bloco]]
prop> substituiBMatriz [] _ _ = []
prop> substituiBMatriz (h:t) (0,y) b = (substituiBloco h y b) : t
prop> substituiBMatriz (h:t) (x,y) b = h : substituiBMatriz t (x-1,y) b

==== Função "substituiBloco":
prop> substituiBloco :: [Bloco] -> Double -> Bloco -> [Bloco]
prop> substituiBloco [] _ _= []
prop> substituiBloco (h:t) 0 b = b:t
prop> substituiBloco (h:t) n b = h : substituiBloco t (n-1) b

==== Função "posAlcapao":
prop> posAlcapao :: [[Bloco]] -> [Posicao]
prop> posAlcapao [] = []
prop> posAlcapao m =  concatMap (\(l, bs) -> [(fromIntegral c, fromIntegral l) | (b, c) <- zip bs [0..], b == Alcapao]) $ zip [0..] m

=== Função auxiliar "gravPersonagem":
prop> gravPersonagem :: Mapa -> Personagem -> Personagem
prop> gravPersonagem (Mapa _ _ m) (Personagem (vx, vy) c2 (x, y) c4 c5 c6 c7 c8 c9 c10)
prop>     | any (==(fst (hitboxPersonagem p))) (posPlataforma m) = p
prop>     | otherwise = (Personagem (vx, vy + 10) c2 (x, y) c4 c5 c6 c7 c8 c9 c10)
prop>     where p = (Personagem (vx, vy) c2 (x, y) c4 c5 c6 c7 c8 c9 c10)

===Função auxiliar "jogLevaDano":
prop> jogLevaDano :: [Personagem] -> Personagem -> Personagem
prop> jogLevaDano [] p = p
prop> jogLevaDano l p@(Personagem _ _ _ _ _ _ _ v _ _) 
prop>    | any (==True) (colisaoInJog l p) = p {vida = (v-1)}
prop>    | otherwise = p

==== Função "colisaoInJog":
prop> colisaoInJog :: [Personagem] -> Personagem -> [Bool]
prop> colisaoInJog [] p = [False]
prop> colisaoInJog (h:t) p = colisoesPersonagens h p : colisaoInJog t p

=== Função auxiliar "apanhaColec":
prop> apanhaColec :: Jogo -> Jogo
prop> apanhaColec (Jogo m i ((colec,pos):r) p@(Personagem _ _ _ _ _ _ _ _ pontuacao _))
prop>   | colisaoHitbox (hitboxPersonagem p) (hitboxColecionavel pos) && colec == Moeda   = (Jogo m i r p {pontos = pontuacao + 100})
prop>   | colisaoHitbox (hitboxPersonagem p) (hitboxColecionavel pos) && colec == Martelo = (Jogo m i r p {aplicaDano = (True,10)}) 
prop>   | otherwise = (Jogo m i ((colec,pos):r) p)

==== Função "hitboxColecionavel":
prop> hitboxColecionavel :: Posicao -> Hitbox 
prop> hitboxColecionavel (x,y) = ((x1,y1),(x2,y2)))
prop>      where 
prop>         x1 = x - (1/2)
prop>         y1 = y + (1/2)
prop>         x2 = x + (1/2)
prop>         y2 = y - (1/2)

=== Função principal "naoAtravessa":
prop> naoAtravessa :: Mapa -> Personagem -> Personagem
prop> naoAtravessa m@(Mapa _ _ mb) p@(Personagem (vx,vy) _ (x,y) _ (l,a) _ _ _ _ _)  
prop>     | c1        = p {velocidade = (0, vy)}
prop>     | c2        = p {velocidade = (vx, 0)}  
prop>     | c1 && c2  = p {velocidade = (0,0)} 
prop>     | otherwise = p
prop>   where c1 = colisoesParede m p 
prop>     c2 = any (==(fst (hitboxPersonagem p))) (posPlataforma mb)

== Exemplos de utilização:
>>> movimenta (fromIntegral 1) 2 (Jogo (Mapa ((2.5, 1.5), Este) (5, 5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma], [Vazio, Vazio, Vazio, Vazio, Vazio], [Vazio, Alcapao, Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio, Vazio, Vazio], [Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]]) ([(Personagem (1, 0) Fantasma (2.5, 1.5) Oeste (1, 1) False True 1 0 (False, 0))]) ([(Moeda, (1.5,1.5)), (Martelo,(4.5,4.5))]) (Personagem (0, 0) Jogador (1.5, 1.5) Este (1, 1) False True 3 0 (True, 5)))
Jogo Mapa ((2.5, 1.5), Este) (5, 5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma], [Vazio, Vazio, Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio, Vazio, Vazio], [Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]] [] [(Martelo,(4.5,4.5))] Personagem (0, 10) Jogador (1.5, 1.5) Este (1, 1) False True 2 1 (True, 5)

>>> movimenta (fromIntegral 1) 2 (Jogo (Mapa ((2.5, 1.5), Este) (5, 5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma], [Vazio, Vazio, Vazio, Vazio, Vazio], [Vazio, Plataforma, Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio, Vazio, Vazio], [Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]]) ([(Personagem (1, 0) Fantasma (3.5, 3.5) Oeste (1, 1) False True 1 0 (False, 0))]) ([(Martelo,(4.5,4.5))]) (Personagem (0, 0) Jogador (1.5, 1.5) Este (1, 1) False True 3 0 (False, 0)))
Jogo Mapa ((2.5, 1.5), Este) (5, 5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma], [Vazio, Vazio, Vazio, Vazio, Vazio], [Vazio, Plataforma, Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio, Vazio, Vazio], [Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]] [(Personagem (1, 0) Fantasma (3.5, 3.5) Oeste (1, 1) False True 1 0 (False, 0))] [(Martelo,(4.5,4.5))] Personagem (0, 0) Jogador (1.5, 1.5) Este (1, 1) False True 3 0 (False, 0)

-}

movimenta :: Semente -- ^ Semente do Jogo.
          -> Tempo -- ^ Tempo do Jogo.
          -> Jogo -- ^ Jogo.
          -> Jogo -- ^ Jogo após atualização.
movimenta s t j@(Jogo m@(Mapa c1 c2 mb) i c p) =
    apanhaColec $ Jogo ma (filtraInimigos (inPerdeVida ia p)) c (movimentoJ (jogLevaDano i (naoAtravessa m (gravPersonagem m p))))
    where
      ma = Mapa c1 c2 (pisaAlcapao m p)
      ia = movimentoI (aleatorioTodos m s i)

-- ^ Função que irá animar todas as personagens, i.e. calcular as suas novas posições e respectivas consequências.


movimentoJ :: Personagem -- ^ Personagem do Jogador
           -> Personagem -- ^ Personagem do Jogador atualizado
movimentoJ p@(Personagem (vx,vy) _ (x, y) _ d _ _ _ _ _) = p {velocidade = (0,0), posicao = (x+vx,y-vy)}



movimentoI :: [Personagem] -- ^ Lista de inimigos do Jogo
           -> [Personagem] -- ^ Lista atualizadas dos inimigos do Jogo
movimentoI = map movimentoJ







inPerdeVida :: [Personagem] -- ^ Lista de Inimigos do mapa.
            -> Personagem -- ^  Jogador.
            -> [Personagem] -- ^ Lista de inimigos do mapa que perderam vidas.
inPerdeVida [] _ = []
inPerdeVida ((Personagem c1 c2 c3 c4 c5 c6 c7 v c9 (a,t)):ls) p
 | hitboxPersonagem (Personagem c1 c2 c3 c4 c5 c6 c7 v c9 (a,t)) == hitboxDanoJ p && (pDaDano p == True) = ((Personagem c1 c2 c3 c4 c5 c6 c7 (v - 1) c9 (a,t))) : inPerdeVida ls p
 | otherwise = (Personagem c1 c2 c3 c4 c5 c6 c7 v c9 (a,t)) : inPerdeVida ls p

-- ^ Função que retira as vidas aos inimigos que colidem com a hitbox de dano de um jogador (martelo).

pDaDano :: Personagem -- ^ Personagem do Jogador.
        -> Bool -- ^ Valor lógico da propriedade "aplicaDano" estar ativa.
pDaDano (Personagem _ _ _ _ _ _ _ v _ (a, t))
   | v > 0 && a == True = True
   | otherwise          = False

-- ^ Função que verifica se um personagem pode dar dano.

hitboxDanoJ :: Personagem -- ^ Jogador.
            -> Hitbox -- ^ Hitbox de Dano (Martelo).
hitboxDanoJ p@(Personagem _ _ _ d (l, a) _ _ v _ (ad, t))
  | pDaDano p && d == Este  = ((x2,y1), (x2+1,y2))
  | pDaDano p && d == Oeste = ((x1-1,y1), (x1,y2))
  | otherwise = ((0,0),(0,0))
  where ((x1,y1), (x2,y2)) = hitboxPersonagem p

-- ^ Função que determina a hitbox de dano do Jogador (Martelo).

filtraInimigos :: [Personagem] -- ^ Lista de inimigos
               -> [Personagem] -- ^ Lista de inimigos com uma vida
filtraInimigos = filter (\(Personagem _ _ _ _ _ _ _ v _ _) -> v == 1)

-- ^ Função que filtra os inimigos com 1 vida numa determinada lista de inimigos.

pisaAlcapao :: Mapa -- ^ Mapa do Jogo. 
            -> Personagem -- ^ Jogador.
            -> [[Bloco]] -- ^ Matriz do Mapa com os alçapões atualizados (após serem pisados).
pisaAlcapao (Mapa _ _ m) p@(Personagem _ t (x, y) _ _ _ _ _ _ _)
   | t == Jogador && any (==(fst (hitboxPersonagem p))) (posAlcapao m) = substituiBMatriz m (xp,yp) Vazio
   | otherwise = m
 where (xp,yp) = fst (hitboxPersonagem p)

-- ^ Função que atualiza a matriz do mapa quando um jogador pisa um alçapão.

substituiBMatriz :: [[Bloco]] -- ^ Matriz do Mapa.
                 -> Posicao -- ^ Posição de um bloco no Mapa.
                 -> Bloco -- ^ Bloco.
                 -> [[Bloco]] -- ^ Matriz com o bloco atualizado.
substituiBMatriz [] _ _ = []
substituiBMatriz (h:t) (0,y) b = (substituiBloco h y b) : t
substituiBMatriz (h:t) (x,y) b = h : substituiBMatriz t (x-1,y) b

-- ^ Função que substitui um bloco por outro numa matriz (mapa).

substituiBloco :: [Bloco] -- ^ Lista de Blocos.
               -> Double -- ^ Posição na lista de blocos.
               -> Bloco -- ^ Bloco.
               -> [Bloco] -- ^ Lista de Blocos atualizada.
substituiBloco [] _ _= []
substituiBloco (h:t) 0 b = b:t
substituiBloco (h:t) n b = h : substituiBloco t (n-1) b

-- ^ Função que substitui um bloco por outro numa lista de blocos (linha na matriz do mapa). 

posAlcapao :: [[Bloco]] -- ^ Matriz do Mapa.
           -> [Posicao] -- ^ Posição dos blocos do tipo __Alcapao__.
posAlcapao [] = []
posAlcapao m =  concatMap (\(l, bs) -> [(fromIntegral c, fromIntegral l) | (b, c) <- zip bs [0..], b == Alcapao]) $ zip [0..] m

-- ^ Função que calcula a posição de todos os blocos de alçapão no Mapa.

gravPersonagem :: Mapa -- ^ Mapa do Jogo.
               -> Personagem -- ^ Jogador.
               -> Personagem -- ^ Jogador com a velocidade atualizada.
gravPersonagem (Mapa _ _ m) (Personagem (vx, vy) c2 (x, y) c4 c5 c6 c7 c8 c9 c10)
    | any (==(fst (hitboxPersonagem p))) (posPlataforma m) = p
    | otherwise = (Personagem (vx, vy + 10) c2 (x, y) c4 c5 c6 c7 c8 c9 c10)
    where p = (Personagem (vx, vy) c2 (x, y) c4 c5 c6 c7 c8 c9 c10)

-- ^ Função que faz os personagens cair (mudar a velocidade) quando não estão numa plataforma.

jogLevaDano :: [Personagem] -- ^ Lista de inimigos.
               -> Personagem -- ^ Jogador.
               -> Personagem -- ^ Jogador com a vida atualizada.
jogLevaDano [] p = p
jogLevaDano l p@(Personagem _ _ _ _ _ _ _ v _ _)
   | True `elem` colisaoInJog l p = p {vida = (v-1)}
   | otherwise = p

-- ^ Função que tira uma vida ao jogador se ele entrar em colisão com um inimigo.

colisaoInJog :: [Personagem] -- ^ Lista de inimigos.
             -> Personagem -- ^ Jogador.
             -> [Bool] -- ^ Lista dos valores lógicos dos inimigos estarem ou não em contato com o Jogador.
colisaoInJog [] p = [False]
colisaoInJog (h:t) p = colisoesPersonagens h p : colisaoInJog t p

-- ^ Função que verifica se algum inimigo se encontra em colisão com o jogador.

apanhaColec :: Jogo -- ^ Jpgo. 
            -> Jogo -- ^ Jogo após os colecionáveis serem colectados (atualizado).
apanhaColec (Jogo m i ((colec,pos):r) p@(Personagem _ _ _ _ _ _ _ _ pontuacao _))
      | colisaoHitbox (hitboxPersonagem p) (hitboxColecionavel pos) && colec == Moeda   = (Jogo m i r p {pontos = pontuacao + 100})
      | colisaoHitbox (hitboxPersonagem p) (hitboxColecionavel pos) && colec == Martelo = (Jogo m i r p {aplicaDano = (True,10)})
      | otherwise = (Jogo m i ((colec,pos):r) p)
-- ^ Função que atualiza o jogo quando o jogador obtém um colecionável (aumentando a pontuação ou permitindo dar dano).

hitboxColecionavel :: Posicao -- ^ Posição de um colecionável no Mapa.
                   -> Hitbox -- ^ Hitbox do colecionável dado.
hitboxColecionavel (x,y) = ((x1,y1),(x2,y2))
   where x1 = x - (1/2)
         y1 = y + (1/2)
         x2 = x + (1/2)
         y2 = y - (1/2)

-- ^ Função que calcula a hitbox de um colécionável.

naoAtravessa :: Mapa -- ^ Mapa do Jogo.
             -> Personagem -- ^ Jogador.
             -> Personagem -- ^ Jogador com a velocidade atualizada.
naoAtravessa m@(Mapa _ _ mb) p@(Personagem (vx,vy) _ (x,y) _ (l,a) _ _ _ _ _)
   | c1        = p {velocidade = (0, vy)}
   | c2        = p {velocidade = (vx, 0)}
   | c1 && c2  = p {velocidade = (0,0)}
   | otherwise = p
 where c1 = colisoesParede m p
       c2 = any (==(fst (hitboxPersonagem p))) (posPlataforma mb)

-- ^ Função que impede o personagem de sair do mapa e de atravessar blocos de plataforma (diminui a velocidade do personagem para 0).



{-|
função eu gera movimento aleatório a uma lista de inimigos
-}

aleatorioTodos :: Mapa -- ^ Mapa do Jogo
             -> Semente -- ^ Semente Aleatória
             -> [Personagem] -- ^ Lista de Inimigos
             -> [Personagem] -- ^ Lista de Inimigos atualizada
aleatorioTodos m s [] = []
aleatorioTodos m s (i:t) = aleatorioUm m i (last l) : aleatorioTodos m s t
        where
          l = geraAleatorios s (length (i:t))




aleatorioUm   ::   Mapa -- ^ Mapa do Jogo
                -> Personagem -- ^ Inimigo qualquer
                -> Int -- ^ Número de 19 dígitos 
                -> Personagem -- ^ Inimigo atualizado
aleatorioUm m@(Mapa _ _ mb) i@(Personagem (vx,vy) _ _ _ _ _ _ _ _ _) n =
  case n `mod` 3 of
    0 -> if naoAndaDireita2 mb i then i {velocidade = (vx-1,vy), direcao = Oeste} else i {velocidade = (vx+1, vy), direcao = Este}
    1 -> if naoAndaEsquerda2 mb i then i {velocidade = (vx+1, vy), direcao = Este} else i {velocidade = (vx+1, vy), direcao = Este}
    2 -> if numaEscada2 m i then i {velocidade = (vx,vy-1)} else i
    3 -> if numaEscada2 m i then i {velocidade = (vx,vy+1)} else i
    _ -> i



naoAndaDireita2 :: [[Bloco]] -- ^ Matriz que define o Mapa do Jogo.
               -> Personagem -- ^ Personagem.
               -> Bool -- ^ Valor lógico de o personagem não se poder deslocar para a direita.
naoAndaDireita2 m p@(Personagem _ _ (x,y) d _ _ r _ _ _)
    | (`elem` posPlataforma m) (snd (hitboxPersonagem p)) = True
    | r == True && (`elem` posVazio2 m) (fst (fst (hitboxPersonagem p)) + 1, snd (fst (hitboxPersonagem p))) = True
    | otherwise = False

{-|
Função que verifica se um personagem não se pode deslocar para a esquerda.
-}

naoAndaEsquerda2 :: [[Bloco]] -- ^ Matriz que define o Mapa do Jogo.
                -> Personagem -- ^ Personagem.
                -> Bool -- ^ Valor lógico de o personagem não se poder deslocar para a esquerda.
naoAndaEsquerda2 m p@(Personagem _ _ (x,y) d _ _ r _ _ _)
    | (`elem` posPlataforma m) (fst (snd (hitboxPersonagem p)) - 2, snd (snd (hitboxPersonagem p))) = True
    | r == True && (`elem` posVazio2 m) (fst (fst (hitboxPersonagem p)) - 1, snd (fst (hitboxPersonagem p))) = True
    | otherwise = False



posVazio2 :: [[Bloco]] -- ^ Matriz que define o Mapa do Jogo.
         -> [Posicao] -- ^ Lista de posições de todos os blocos vazios na matriz que define o Mapa do Jogo.
posVazio2 m = concatMap (\(l, bs) -> [(fromIntegral c, fromIntegral l) | (b, c) <- zip bs [0..], b == Vazio]) $ zip [0..] m



numaEscada2 :: Mapa -- ^ Mapa do Jogo.
           -> Personagem -- ^ Personagem.
           -> Bool -- ^ Valor lógico de o personagem estar em colisão com um bloco de Escada (pode subir ou descer).
numaEscada2 m p
  | colisaoBlocos (hitboxBlocos (posEscada m)) (hitboxPersonagem p) = True
  | otherwise = False