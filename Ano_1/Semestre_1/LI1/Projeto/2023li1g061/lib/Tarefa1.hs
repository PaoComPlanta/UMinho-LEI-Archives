{-|
Module      : Tarefa1
Description : Verifica colisões
Copyright   : Francisco Miguel Fernandes Soares <a106901@alunos.uminho.pt>
              Simão Pedro Pacheco Mendes <a106928@alunos.uminho.pt>

Módulo para a realização da Tarefa 1 de LI1 em 2023/24.
-}
module Tarefa1 where

import LI12324



------------------------------------------------------------------------------------------------------------------------------------
{-|
A função __colisoesParede__ testa se uma personagem se encontra em colisão com algum dos limites do mapa (topo ou laterais), ou com algum bloco de plataforma.
Para nos auxiliar nesta tarefa utilizamos algumas funções que realizam tarefas mais específicas, como por exemplo : 

* @colisaoMapa@: Testa se uma personagem colide com algum dos limites do mapa 
* @colisaoBlocos@: Testa se uma personagem colide com um bloco de plataforma
* @hitboxPersonagem@: Calcula a hitbox de uma personagem, definifida por um par de posições, sendo estas o canto inferior esquerdo e superior direito
* @hitboxBlocos@: Calcula a hitbox de uma lista de plataformas
* @posPlataforma@: Recebe a matriz de definição do mapa e devolve uma lista com as coordenadas do canto superior esquerdo de cada bloco

== Propriedades:

=== Função principal "colisoesParede":
prop> colisoesParede :: Mapa -> Personagem -> Bool
prop> colisoesParede (Mapa _ _ m) p
prop> | colisoesParede m p || colisaoBlocos (hitboxBlocos $ posPlataforma m) (hitboxPersonagem p) = True
prop> | otherwise = False


=== Função auxiliar "colisaoMapa":
prop> colisaoMapa :: [[Bloco]] -> Personagem -> Bool
prop> colisaoMapa m (Personagem _ _ (x, y) _ (g, c) _ _ _ _ _) 
prop> | x - (g / 2) <= 0 || x + (g / 2) >= th || y - (c / 2) <= 0 || y + (c / 2) >= tv = True
prop> | otherwise = False
prop> where
prop> th = fromIntegral $ length $ head m
prop> tv = fromIntegral $ length m


=== Função auxiliar "colisaoBlocos":
prop> colisaoBlocos:: [Hitbox] -> Hitbox -> Bool
prop> colisaoBlocos [] _ = False
prop> colisaoBlocos (((xi1, yi1), (xi2, yi2)):xs) ((xe1, yd1), (xe2, yd2)) =
prop> elem True [x >= min xe1 xe2 && x <= max xe1 xe2 && y >= min yd1 yd2 && y <= max yd1 yd2 | (x, y) <- v] || colisaoBlocos xs ((xe1, yd1), (xe2, yd2))
prop> where
prop> v = [(x, y) | x <- [xi1, xi2], y <- [yi1, yi2]]


=== Função auxiliar "posPlataforma":
prop> posPlataforma :: [[Bloco]] -> [Posicao]
prop> posPlataforma [] = [] 
prop> posPlataforma m =
prop> concatMap (\(l, bs) -> [(fromIntegral c, fromIntegral l) | (b, c) <- zip bs [0..], b == Plataforma]) $ zip [0..] m


=== Função auxiliar "hitboxBlocos":
prop> hitboxBlocos :: [Posicao] -> [Hitbox]
prop> hitboxBlocos = map (\(x, y) -> ((x, y + 1), (x + 1, y)))


===Função auxiliar "hitboxPersonagem":
prop> hitboxPersonagem :: Personagem -> Hitbox
prop> hitboxPersonagem (Personagem _ _ (x,y) _ (g,c) _ _ _ _ _) 
prop> = ((xe1,yd1),(xe2,yd2))
prop> where 
prop> xe1 = x - (g / 2)
prop> yd1 = y + (c / 2)
prop> xe2 = x + (g / 2)
prop> yd2 = y - (c / 2)


== Exemplos de utilização:
>>> colisoesParedes (Mapa ((0, 0), Este) (4, 4) [[Plataforma, Plataforma, Plataforma], [Plataforma, Vazio, Plataforma], [Plataforma, Plataforma, Plataforma]]) (Personagem (2, 0) Jogador (1, 1) Este (1, 1) False False 5 0 (False, 0))
True

>>> colisoesParedes (Mapa ((0, 0), Este) (4, 3) [[Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio]]) (Personagem (2, 0) Jogador (1, 1) Este (1, 1) False False 5 0 (False, 0))
False
-}

colisoesParede :: Mapa -- ^ Mapa do Jogo.
                  -> Personagem -- ^ Personagem em causa.
                  -> Bool -- ^ Valor lógico da colisão entre os limites do mapa / plataformas e o personagem.
colisoesParede (Mapa _ _ m) p
    | colisaoMapa m p || colisaoBlocos (hitboxBlocos $ posPlataforma m) (hitboxPersonagem p) = True
    | otherwise = False
{-|
Função que verifica se um personagem colide com os limites do mapa.
-}

colisaoMapa :: [[Bloco]] -- ^ Matriz que define o mapa.
               -> Personagem -- ^ Personagem em causa.
               -> Bool -- ^ Valor lógico da colisão do personagem com os limites do mapa.
colisaoMapa m (Personagem _ _ (x, y) _ (l, a) _ _ _ _ _ )
    | x - (l/2) <= 0 || x + (l/2) >= fromIntegral (length (head m)) = True
    | y - (a/2) <= 0 || y + (a/2) >= fromIntegral (length m) = True
    | otherwise = False

{-|
Função que calcula a hitbox de uma lista de plataformas.
-}
hitboxBlocos :: [Posicao] -- ^ Lista de posições de plataformas.
                -> [Hitbox] -- ^ Lista de hitboxes dos blocos de plataforma.
hitboxBlocos = map (\(x,y) -> ((x,y+1),(x+1,y)))

{-| 
Função que testa se um personagem colide com um bloco do tipo plataforma.
-}

colisaoBlocos :: [Hitbox] -- ^ Lista das hitboxes de cada bloco do tipo plataforma.
                 -> Hitbox -- ^ Hitbox do Personagem.
                 -> Bool -- ^ Valor lógico da colisão dos blocos do tipo plataforma com o personagem.
colisaoBlocos [] _ = False
colisaoBlocos (((x,y), (x1,y1)):xs) ((xp1,yp1),(xp2,yp2))
    | (x >= xp1 && x <= xp2) || (x1 >= xp1 && x1 <= xp2) = True
    | (y >= yp1 && y <= yp2) || (y1 >= yp1 && y1 <= yp2) = True
    | otherwise = colisaoBlocos xs ((xp1,yp1),(xp2,yp2))

{-|
Função que recebe a matriz de definição do mapa e devolve uma lista com as coordenadas do canto superior esquerdo de cada bloco de plataforma.
-}

posPlataforma :: [[Bloco]] -- ^ Matriz que define o Mapa.
                 -> [Posicao] -- ^ Lista das cooordenadas do canto superior esquerdo do bloco.
posPlataforma [] = [] 
posPlataforma m = concatMap (\(l, bs) -> [(fromIntegral c, fromIntegral l) | (b, c) <- zip bs [0..], b == Plataforma]) $ zip [0..] m

{-| 
Função que calcula a hitbox de uma personagem, definifida por um par de posições, sendo estas o canto inferior esquerdo e superior direito, respetivamente
-}

hitboxPersonagem :: Personagem -- ^ Personagem em causa.
                    -> Hitbox -- ^ Hitbox gerada.
hitboxPersonagem (Personagem _ _ (x,y) _ (l,a) _ _ _ _ _ ) = ((x1,y1), (x2,y2))
    where x1 = x - (l/2)
          y1 = y + (a/2)
          x2 = x + (l/2)
          y2 = y - (a/2)



--------------------------------------------------------------------------------------------------------------------------------

{-|

A função __colisoesPersonagens__ testa se dois personagens se encontram em colisão, ou seja, testa se a hitbox de um dos personagens interceta de alguma forma a hitbox do outro
Para definir esta função, utilizamos a função __hitboxPersonagem__ a também uma outra função auxiliar :

* @colisaoHitbox@: Verifica se duas hitboxes se intercetam


== Propriedades:

=== Função Principal "colisoesPersonagens":
prop> colisoesPersonagens :: Personagem -> Personagem -> Bool
prop> colisoesPersonagens p1 p2 = colPersona (hitPersona p1) (hitPersona p2) 


===Função auxiliar "colisaoHitbox"
prop> colisaoHitbox :: Hitbox -> Hitbox -> Bool
prop> colisaoHitbox ((xi1, yi1), (xi2, yi2)) ((xe1, yd1), (xe2, yd2)) =
prop> elem True [x >= min xe1 xe2 && x <= max xe1 xe2 && y >= min yd1 yd2 && y <= max yd1 yd2 | (x, y) <- v] 
prop> where
prop> v = [(x, y) | x <- [xi1, xi2], y <- [yi1, yi2]]


== Exemplos de utiilização:
>>> colisoesPersonagens (Personagem (2,1) Jogador (1,1) Este (2,2) False False 3 0 (False, 0)) (Personagem (2,1) Jogador (0.5, 0.5) Este (2,2) False False 3 0 (False, 0))
True

>>> colisoesPersonagens (Personagem (2,1) Jogador (1,1) Este (2,2) False False 3 0 (False, 0)) (Personagem (2,1) Jogador (4, 4) Este (2,2) False False 3 0 (False, 0))
False

-}

colisoesPersonagens :: Personagem -- ^ Personagem 1.
                       -> Personagem -- ^ Personagem 2.
                       -> Bool -- ^ Valor lógico da colisão entre a Personagem 1 e a Personagem 2.
colisoesPersonagens p1 p2 = colisaoHitbox (hitboxPersonagem p1) (hitboxPersonagem p2)

{-| 
Função que verifica se duas hitboxes se intersetam.
-}

colisaoHitbox :: Hitbox -- ^ Hitbox de um personagem.
                 -> Hitbox -- ^ Hitbox de um outro personagem.
                 -> Bool -- ^  Valor lógico da colisão entre as duas hitboxes.
colisaoHitbox ((x1, y1), (x2, y2)) ((x3, y3), (x4, y4)) = (x1 <= x4 && x3 <= x2) && (y1 >= y4 && y3 >= y2)

