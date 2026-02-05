{-|
Module      : Tarefa4
Description : Atualiza as velocidades das personagens no jogo
Copyright   : Francisco Miguel Fernandes Soares <a106901@alunos.uminho.pt>
              Simão Pedro Pacheco Mendes <a106928@alunos.uminho.pt>

Módulo para a realização da Tarefa 4 de LI1 em 2023/24.
-}
module Tarefa4 where

import Data.Maybe

import LI12324

import Tarefa1
import Tarefa2
import Tarefa3

{-|

O objetivo desta tarefa é implementar a função __atualiza__. A função __atualiza__ deve validar as novas direções e velocidades das personagens (inimigos e jogador) de acordo com as ações dadas.

Para a definir, precisamos de construir as seguintes funções auxiliares:

* @atualizaJogador@: Função que atualiza os dados do jogador de acordo com a ação a efetuar.
* @atualizaInimigo@: Função que atualiza os dados dos inimigos de acordo com a lista de ações a realizar.

Para construirmos estas duas funções auxiliares acima, tivemos de definir outras funções auxiliares que serão utilizadas pelas funções acima, como por exemplo:

* @atualizaPersonagem@: Função que atualiza os dados de uma personagem dependendo da ação a efetuar.
* @numaEscada@: Função que verifica se um personagem está em colisão com um bloco do tipo __Escada__ (pode subir ou descer).
* @naoAndaDireita@: Função que verifica se um personagem não se pode deslocar para a direita.
* @naoAndaEsquerda@: Função que verifica se um personagem não se pode deslocar para a esquerda.
* @paraPer@: Função que verifica se um personagem pode ficar parado (se tem plataforma em baixo).
* @posVazio@: Função que recebe a matriz de blocos do mapa e dá as posições de todos os blocos vazios.

== Propriedades:
=== Função Principal "atualiza":
prop> atualiza :: [Maybe Acao] -> Maybe Acao -> Jogo -> Jogo
prop> atualiza ai aj (Jogo m i c j) = (Jogo m (atualizaInimigo m ai i) c (atualizaJogador m aj j))

==== Função auxiliar "atualizaJogador":
prop> atualizaJogador :: Mapa -> Maybe Acao -> Personagem -> Personagem
prop> atualizaJogador m maybeacao p =
prop>   case maybeacao of
prop>    Just acao -> atualizaPersonagem m acao p
prop>    Nothing   -> p

==== Função auxiliar "atualizaInimigo":
prop> atualizaInimigo :: Mapa -> [Maybe Acao] -> [Personagem] -> [Personagem]
prop> atualizaInimigo _ [] inimigos = inimigos
prop> atualizaInimigo m (acao:resto) inimigos =
prop>   case acao of
prop>     Just acao -> atualizaInimigo m resto (map (atualizaPersonagem m acao) inimigos)
prop>     Nothing   -> inimigos

==== Função auxiliar "atualizaPersonagem":
prop> atualizaPersonagem :: Mapa -> Acao -> Personagem -> Personagem
prop> atualizaPersonagem m@(Mapa _ _ b) acao p@(Personagem (vx, vy) _ _ d _ e _ _ _ _) =
prop>    case acao of
prop>      Subir         -> if numaEscada m p then p {velocidade = (0, vy-1)} else p
prop>      Descer        -> if numaEscada m p then p {velocidade = (0, vy+1)} else p
prop>      AndarDireita  -> if naoAndaDireita b p then p {velocidade = (vx-1,vy)} else p {velocidade = (vx+1, vy)}
prop>      AndarEsquerda -> if naoAndaEsquerda b p then p {velocidade = (vx+1, vy)} else p {velocidade = (vx-1,vy)}
prop>      Saltar        -> if e == False && paraPer b p then p {velocidade = (vx, vy-1)} else p
prop>      Parar         -> if paraPer b p then p {velocidade = (0,0)} else p

==== Função auxiliar "numaEscada":
prop> numaEscada :: Mapa -> Personagem -> Bool
prop> numaEscada m p
prop>  | colisaoBlocos (hitboxBlocos (posEscada m)) (hitboxPersonagem p) = True
prop>  | otherwise = False

==== Função auxiliar "naoAndaDireita":
prop> naoAndaDireita :: [[Bloco]] -> Personagem -> Bool
prop> naoAndaDireita m p@(Personagem _ _ (x,y) d _ _ r _ _ _)
prop>    | (`elem` posPlataforma m) (snd (hitboxPersonagem p)) = True
prop>    | r == True && (`elem` posVazio m) (fst (fst (hitboxPersonagem p)) + 1, snd (fst (hitboxPersonagem p))) = True
prop>    | otherwise = False

==== Função auxiliar "naoAndaEsquerda":
prop> naoAndaEsquerda :: [[Bloco]] -> Personagem -> Bool
prop> naoAndaEsquerda m p@(Personagem _ _ (x,y) d _ _ r _ _ _)
prop>    | (`elem` posPlataforma m) (fst (snd (hitboxPersonagem p)) - 2, snd (snd (hitboxPersonagem p))) = True
prop>    | r == True && (`elem` posVazio m) (fst (fst (hitboxPersonagem p)) - 1, snd (fst (hitboxPersonagem p))) = True
prop>    | otherwise = False

==== Função auxiliar "paraPer":
prop> paraPer :: [[Bloco]] -> Personagem -> Bool
prop> paraPer m p
prop>  | (`elem` posPlataforma m) (fst (hitboxPersonagem p)) = True
prop>  | otherwise = False

==== Função auxiliar "posVazio":
prop> posVazio :: [[Bloco]] -> [Posicao]
prop> posVazio m = concatMap (\(l, bs) -> [(fromIntegral c, fromIntegral l) | (b, c) <- zip bs [0..], b == Vazio]) $ zip [0..] m

== Exemplos de utiilização:
>>> atualiza ([Just AndarDireita, Just AndarDireita]) ((Just Subir)) (Jogo (Mapa ((1.5, 1.5), Este) (5, 5) [[Escada, Vazio, Vazio], [Vazio, Vazio, Plataforma], [Plataforma, Plataforma, Plataforma]]) ([(Personagem (0, 0) Fantasma (1.5, 1.5) Este (1, 1) False True 1 0 (False, 0)),(Personagem (0, 0) Fantasma (0.5, 1.5) Oeste (1, 1) False False 1 0 (False, 0))]) ([(Moeda,(1.5,1.5)),(Martelo,(1.5,1.5))]) (Personagem (5, 0) Jogador (0.5, 0.5) Oeste (1, 1) True True 2 0 (True, 5)))
Jogo (Mapa ((1.5, 1.5), Este) (5, 5) [[Escada, Vazio, Vazio], [Vazio, Vazio, Plataforma], [Plataforma, Plataforma, Plataforma]]) ([(Personagem (-2, 0) Fantasma (1.5, 1.5) Oeste (1, 1) False True 1 0 (False, 0)),(Personagem (2, 0) Fantasma (0.5, 1.5) Este (1, 1) False False 1 0 (False, 0))]) ([(Moeda,(1.5,1.5)),(Martelo,(1.5,1.5))]) (Personagem (5, -1) Jogador (0.5, 0.5) Oeste (1, 1) True True 2 0 (True, 5))

>>> atualiza ([Nothing]) (Nothing) Jogo (Mapa ((2.5, 1.5), Este) (5, 5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma], [Vazio, Vazio, Vazio, Vazio, Vazio], [Vazio, Alcapao, Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio, Vazio, Vazio], [Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]]) ([(Personagem (1, 0) Fantasma (3.0, 1.5) Oeste (1, 1) False True 1 0 (False, 0)),(Personagem (1, 0) Fantasma (0.5, 1.5) Oeste (1, 1) False True 1 0 (False, 0)),(Personagem (1, 0) Fantasma (2.5, 2.5) Oeste (1, 1) False True 0 0 (False, 0))]) ([(Martelo,(4.5,4.5))]) (Personagem (0, 0) Jogador (0.5, 1.5) Oeste (1, 1) False True 2 0 (True, 5))
Jogo (Mapa ((2.5, 1.5), Este) (5, 5) [[Plataforma, Plataforma, Plataforma, Plataforma, Plataforma], [Vazio, Vazio, Vazio, Vazio, Vazio], [Vazio, Alcapao, Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio, Vazio, Vazio], [Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]]) ([(Personagem (1, 0) Fantasma (3.0, 1.5) Oeste (1, 1) False True 1 0 (False, 0)),(Personagem (1, 0) Fantasma (0.5, 1.5) Oeste (1, 1) False True 1 0 (False, 0)),(Personagem (1, 0) Fantasma (2.5, 2.5) Oeste (1, 1) False True 0 0 (False, 0))]) ([(Martelo,(4.5,4.5))]) (Personagem (0, 0) Jogador (0.5, 1.5) Oeste (1, 1) False True 2 0 (True, 5))

-}

atualiza :: [Maybe Acao] -- ^ Lista de ações a aplicar nos inimigos.
         -> Maybe Acao -- ^ Ação a aplicar no jogador.
         -> Jogo -- ^ Jogo.
         -> Jogo -- ^ Jogo atualizado (após a aplicação das ações aos inimigos/jogador).
atualiza ai aj (Jogo m i c j) = (Jogo m (atualizaInimigo m ai i) c (atualizaJogador m aj j))

{-|
Função que atualiza os dados do jogador de acordo com a ação a efetuar.
-}

atualizaJogador :: Mapa -- ^ Mapa do Jogo.
            -> Maybe Acao -- ^ Ação a aplicar no jogador.
            -> Personagem -- ^ Jogador.
            -> Personagem -- ^ Jogador atualizado após a ação.
atualizaJogador m maybeacao p =
   case maybeacao of
    Just acao -> atualizaPersonagem m acao p
    Nothing   -> p

{-|
Função que atualiza os dados dos inimigos de acordo com a lista de ações a realizar
-}

atualizaInimigo :: Mapa -- ^ Mapa do Jogo.
            -> [Maybe Acao] -- ^ Lista de Ações a aplicar nos Inimigos.
            -> [Personagem] -- ^ Lista de Inimigos.
            -> [Personagem] -- ^ Lista de Inimigos atualizada (após aplicar as ações).
atualizaInimigo _ [] inimigos = inimigos
atualizaInimigo m (acao:resto) inimigos =
  case acao of
    Just acao -> atualizaInimigo m resto (map (atualizaPersonagem m acao) inimigos)
    Nothing   -> inimigos

{-| 
Função que atualiza os dados de uma personagem dependendo da ação a efetuar.
-}

atualizaPersonagem :: Mapa -- ^ Mapa do Jogo.
                   -> Acao -- ^ Ação a ser aplicada.
                   -> Personagem -- ^ Personagem.
                   -> Personagem -- ^ Personagem atualizado (após a ação ser aplicada).
atualizaPersonagem m@(Mapa _ _ b) acao p@(Personagem (vx, vy) _ _ d _ e _ _ _ _) =
 case acao of
    Subir         -> if numaEscada m p then p {velocidade = (0, vy-1)} else p
    Descer        -> if numaEscada m p then p {velocidade = (0, vy+1)} else p
    AndarDireita  -> if naoAndaDireita b p then p {velocidade = (vx-1,vy)} else p {velocidade = (vx+1, vy)}
    AndarEsquerda -> if naoAndaEsquerda b p then p {velocidade = (vx+1, vy)} else p {velocidade = (vx-1,vy)}
    Saltar        -> if e == False && paraPer b p then p {velocidade = (vx, vy-1)} else p
    Parar         -> if paraPer b p then p {velocidade = (0,0)} else p

{-| 
Função que verifica se um personagem está em colisão com um bloco de Escada (pode subir ou descer).
-}

numaEscada :: Mapa -- ^ Mapa do Jogo.
           -> Personagem -- ^ Personagem.
           -> Bool -- ^ Valor lógico de o personagem estar em colisão com um bloco de Escada (pode subir ou descer).
numaEscada m p
  | colisaoBlocos (hitboxBlocos (posEscada m)) (hitboxPersonagem p) = True
  | otherwise = False

{-| 
Função que verifica se um personagem não se pode deslocar para a direita.
-}

naoAndaDireita :: [[Bloco]] -- ^ Matriz que define o Mapa do Jogo.
               -> Personagem -- ^ Personagem.
               -> Bool -- ^ Valor lógico de o personagem não se poder deslocar para a direita.
naoAndaDireita m p@(Personagem _ _ (x,y) d _ _ r _ _ _)
    | (`elem` posPlataforma m) (snd (hitboxPersonagem p)) = True
    | r == True && (`elem` posVazio m) (fst (fst (hitboxPersonagem p)) + 1, snd (fst (hitboxPersonagem p))) = True
    | otherwise = False

{-|
Função que verifica se um personagem não se pode deslocar para a esquerda.
-}

naoAndaEsquerda :: [[Bloco]] -- ^ Matriz que define o Mapa do Jogo.
                -> Personagem -- ^ Personagem.
                -> Bool -- ^ Valor lógico de o personagem não se poder deslocar para a esquerda.
naoAndaEsquerda m p@(Personagem _ _ (x,y) d _ _ r _ _ _)
    | (`elem` posPlataforma m) (fst (snd (hitboxPersonagem p)) - 2, snd (snd (hitboxPersonagem p))) = True
    | r == True && (`elem` posVazio m) (fst (fst (hitboxPersonagem p)) - 1, snd (fst (hitboxPersonagem p))) = True
    | otherwise = False

{-|
Função que verifica se um personagem pode ficar parado (se tem plataforma em baixo).
-}

paraPer :: [[Bloco]] -- ^ Matriz que define o Mapa do Jogo.
        -> Personagem -- ^ Personagem.
        -> Bool -- ^ Valor lógico de o personagem poder ficar parado.
paraPer m p
  | (`elem` posPlataforma m) (fst (hitboxPersonagem p)) = True
  | otherwise = False

{-|
Função que recebe a matriz de blocos do mapa e dá as posições de todos os blocos vazios.
-}

posVazio :: [[Bloco]] -- ^ Matriz que define o Mapa do Jogo.
         -> [Posicao] -- ^ Lista de posições de todos os blocos vazios na matriz que define o Mapa do Jogo.
posVazio m = concatMap (\(l, bs) -> [(fromIntegral c, fromIntegral l) | (b, c) <- zip bs [0..], b == Vazio]) $ zip [0..] m