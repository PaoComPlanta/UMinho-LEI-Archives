{-|
Module      : Tarefa2
Description : Valida jogo
Copyright   : Francisco Miguel Fernandes Soares <a106901@alunos.uminho.pt>
              Simão Pedro Pacheco Mendes <a106928@alunos.uminho.pt>

Módulo para a realização da Tarefa 2 de LI1 em 2023/24.
-}
module Tarefa2 where

import LI12324
import Tarefa1


{-|

O objetivo desta tarefa é implementar a função __valida__, cujo objetivo é verificar se um dado jogo não viola nenhuma das seguintes restrições:

1. O mapa tem “chão”, i.e. uma plataforma que impede que o jogador ou outro personagem caia fora do mapa.
2. Todos os inimigos tẽm a propriedade __ressalta__ a @True@, enquanto que o jogador a tem a @False@.
3. A posição inicial de um jogador não pode colidir com a posição inicial de um outro personagem. Note que as posições iniciais de inimigos podem colidir entre estes.
4. Número mínimo de inimigos: 2 (dois).
5. Inimigos __Fantasma__ têm exatamente 1 (uma) vida.
6. Escadas não podem começar/terminar em alçapões, e pelo menos uma das suas extremidades tem que ser do tipo __Plataforma__.
7. Alçapões não podem ser menos largos que o jogador.
8. Não podem existir personagens nem colecionãveis “dentro” de plataformas ou alçapões, isto é. o bloco (na matriz do mapa) correspendente à posição de um personagem ou objeto tem que ser __Vazio__.

Na definição da função __valida__, utilizamos __funções__ __auxiliares__ que verificam o valor lógico (__True__ ou __False__) de cada uma das restrições acima enumeradas, como se verifica em:

* Função @temChao@, que verifica se um determinado mapa "tem chão", ou seja, uma plataforma que impede que o jogador caia fora do mapa.
* Função @testeRessalta@, que verifica se todos os inimigos têm a propriedade ressalta a @True@ e o jogador a @False@.
* Função @colisaoInicial@, que verifica se a posição inicial do jogador não colide com a posição inicial de um outro personagem.
* Função @minInimigos@, que verifica se a condição do número mínimo de inimigos no mapa ser 2 (dois) se verifica.
* Função @verificaVidas@, que verifica se todos os inimigos do tipo @Fantasma@ tem exatamente 1 (uma) vida.
* Função @verificaCB@, que verifica se todas as escadas do mapa não começam nem terminam em alçapões e se pelo menos uma das suas extremidades é do tipo @Plataforma@.
* Função @verificaAlcapao@, que verifica se um jogador é menos largo que um alçapão.
* Função @posColecPerson@, que verifica se algum personagem ou colecionável está "dentro" de um bloco do tipo @Vazio@ do mapa.

No caso da função __testeRessalta__, utilizamos:

* A função @retiraRessalta@, que retira o valor lógico da propriedade __Ressalta__ de um personagem.

No caso da função __colisaoInicial__, utilizamos:

* A função @posicaoPersonagem@, que retira a posição de um personagem.

No caso da função __verificaVidas__, utilizamos:

* A função auxiliar __verificaVidas__, que verifica se todos os inimigos do tipo fantasma têm exatamente 1 (uma) vida. A função principal (__verificaVidas__) apenas verifica se todos os casos são do tipo @True@.

No caso da função __verificaCB__, utilizamos funções auxiliares como:

* A função __cimaBEscada__, que recebe a matriz que define o mapa e a lista das posições de blocos de escada no mapa e devolve uma lista de pares que correspondem ao bloco acima e a baixo da escada.
* A função __posEscada__, que calcula a lista de posições de blocos de escada.

No caso da função __posColecPerson__, utilizamos as seguintes funções auxiliares:

* A função __verPosColec__, verifica se uma posição dada é válida para um objeto colecionável no mapa.
* A função __blocoVazio__, verifica se um bloco na posição especificada está vazio.
* A função __dentroPlataformaOuAlcapao__, verifica se um bloco na posição especificada é uma plataforma ou alçapão.

== Propriedades:
=== Função principal "valida":
prop> valida :: Jogo -> Bool
prop> valida (Jogo m i c p)
prop>    = (all (==True) [f1,f2,f3,f4,f5,f6,f7,f8])
prop>    where
prop>     f1 = temchao m
prop>     f2 = testeRessalta i j
prop>     f3 = not (colisaoInicial m i)
prop>     f4 = minInimigos i
prop>     f5 = verificaVidas (verificaVidasAux i)
prop>     f6 = verificaCB (cimaBEscada m (posEscada m))
prop>     f7 = verificaAlcapao j
prop>     f8 = posColecPerson m i c

=== Função auxiliar "temChao":
prop> temChao :: Mapa -> Bool
prop> temChao (Mapa _ _ map)
prop>     | all (\x -> x == Plataforma) lastRow = True
prop>     | otherwise = False
prop>     where lastRow = last map

=== Função auxiliar "testeRessalta":
prop> testeRessalta :: [Personagem] -> Personagem -> Bool
prop> testeRessalta l (Personagem {tipo = j, ressalta = f} = (j == Jogador) && all (==True) (map retiraRessalta l)
prop>    where
prop>        retiraRessalta :: Personagem -> Bool
prop>        retiraRessalta (Personagem _ _ p2 _ _ _ _ _ _ _) = p2

=== Função auxiliar "colisaoInicial":
prop> colisaoInicial :: Mapa -> [Personagem] -> Bool
prop> colisaoInicial _ [] = False
prop> colisaoInicial (Mapa (pi,_ ) _ _) (p:ps) = if pi == posicaoPersonagem p then True else colisaoInicial  (Mapa (pi, undefined) undefined undefined) ps
prop>    where
prop>        posicaoPersonagem :: Personagem -> Posicao
prop>        posicaoPersonagem (Personagem _ _ p _ _ _ _ _ _ _) = p

=== Função auxiliar "minInimigos":
prop> minInimigos :: [Personagem] -> Bool
prop> minInimigos li = length li >= 2

=== Função auxiliar "verificaVidas":
prop> verificaVidas :: [Bool] -> [Bool]
prop> verificaVidas = all (==True)

==== Função "verificaVidasAux":
prop> verificaVidasAux [] = []
prop> verificaVidasAux ((Personagem _ t _ _ _ _ _ v _ _):ps)
prop>    | t == Jogador || t == MacacoMalvado = True: verificaVidasAux ps
prop>    | t == Fantasma && v == 1 = True : verificaVidasAux ps
prop>    | otherwise = False :verificaVidasAux ps

=== Função auxiliar "verificaCB":
prop> verificaCB :: [(Bloco, Bloco)] -> Bool 
prop> verificaCB [] = True
prop>    | x == Plataforma && (y == Plataforma || y == Vazio || y == Escada) = verificaCB r 
prop>    | (x == Plataforma || x == Vazio || x == Escada) && y == Plataforma = verificaCB r
prop>    | otherwise = False

==== Função auxiliar "cimaBEscada":
prop> cimaBEscada :: Mapa -> [Posicao] -> [(Bloco, Bloco)]
prop> cimaBEscada _ [] = []
prop> cimaBEscada (Mapa (pi, d) pf m) ((x, y) : r) =
prop>     let e = cimaBEscada (Mapa (pi, d) pf m) r
prop>         cima = if x > 0 then m !! floor (x - 1) !! floor y else Vazio
prop>         baixo = if x < (fromIntegral (length m)) -1 then m !! floor (x + 1) !! floor y else Vazio
prop>         extremidades = (cima, baixo)
prop>     in if cima /= Alcapao && baixo /= Alcapao && (cima == Plataforma || baixo == Plataforma)
prop>         then extremidades : e
prop>         else e

==== Função auxiliar "posEscada":
prop> posEscada :: Mapa -> [Posicao]
prop> posEscada (Mapa _ _ m) = concatMap (\(l, bs) -> [(fromIntegral c, fromIntegral l) | (b, c) <- zip bs [0..], b == Escada]) $ zip [0..] m

=== Função auxiliar "verificaAlcapao":
prop> verificaAlcapao :: Personagem -> Bool
prop> verificaAlcapao (Personagem _ _ _ _ (l,a) _ _ _ _ _) = l <= 1

=== Função auxiliar "posColecPerson": 
prop> posColecPerson :: Mapa -> [Personagem] -> [(Colecionavel, Posicao)] -> Bool
prop> posColecPerson (Mapa _ _ m) personagens colecionaveis =
prop>    all (\(colec, pos) -> verPosColec m colec pos) colecionaveis
prop>    where
prop>        verPosColec :: [[Bloco]] -> Colecionavel -> Posicao -> Bool
prop>        verPosColec m Moeda (x, y) =
prop>            blocoVazio m (floor x) (floor y) && not (dentroPlatformaOuAlcapao m (floor x) (floor y))
prop>        verPosColec m Martelo (x, y) =
prop>            blocoVazio m (floor x) (floor y) && not (dentroPlatformaOuAlcapao m (floor x) (floor y))
prop>                                                                                                                   
prop>        blocoVazio :: [[Bloco]] -> Int -> Int -> Bool
prop>        blocoVazio m x y = m !! x !! y == Vazio
prop>                                                                                                                      
prop>        dentroPlatformaOuAlcapao :: [[Bloco]] -> Int -> Int -> Bool
prop>        dentroPlatformaOuAlcapao m x y =
prop>            case m !! x !! y of
prop>                Plataforma -> True
prop>                Alcapao -> True
prop>                _ -> False

-}

valida :: Jogo -- ^ Definição do Jogo.
          -> Bool -- ^ Valor lógico da função. Se for __True__, o Jogo é válido.
valida (Jogo m i c j)
    = all (==True) [f1, f2, f3, f4, f5, f6, f7, f8]
    where
        f1 = temChao m
        f2 = testeRessalta i j
        f3 = not (colisaoInicial m i)
        f4 = minInimigos i
        f5 = verificaVidas (verificaVidasAux i)
        f6 = verificaCB (cimaBEscada m (posEscada m))
        f7 = verificaAlcapao j
        f8 = posColecPerson m i c

{-
valida2 :: Jogo -- ^ Definição do Jogo 
       -> Bool -- ^ Valor lógico da verificação de todas as cnodições pedidas
valida2 (Jogo m@(Mapa _ _ mb) i c p)
   = (all (==True) [f1,f2,f3,f4,f5,f6,f7,f8])
   where
    f1 = temChao m
    f2 = testeRessalta i p
    f3 = not (nascInicial m i) 
    f4 = minInimigos i
    f5 = verificaVidas (verificaVidasAux i)
    f6 = verificaCB (cimaBEscada2 m (posEscada m)) -- 
    f7 = passaAlcapao p 
    f8 = colisaoCoisas2 i p c m

nascInicial :: Mapa -> [Personagem] -> Bool
nascInicial (Mapa (pi,_) _ _) i = posM `elem` map posMi i
    where
        posM = cantoCentro pi
        posMi (Personagem _ _ p2 _ _ _ _ _ _ _) = cantoCentro p2

passaAlcapao :: Personagem -> Bool
passaAlcapao (Personagem _ _ _ _ (l,_) _ _ _ _ _) = l <= 30

colisaoCoisas2 :: [Personagem] -> Personagem -> [(Colecionavel, Posicao)] -> Mapa -> Bool
colisaoCoisas2 li p c m@(Mapa _ _ b) = all (`elem` (posVazios b ++ posEscadas b)) (posInicialTudo li p c)

-- | Canto superior esquerdo do mapa para centro da matriz.
cantoCentro :: Posicao -> Posicao
cantoCentro (x, y) = ((x + 390) / 30, ((-y + 475) / 30))

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

posInicialTudo :: [Personagem] -> Personagem -> [(Colecionavel, Posicao)]-> [Posicao]
posInicialTudo li (Personagem _ _ (xp, yp) _ _ _ _ _ _ _) lc =
  map cantoCentro (map (\(Personagem _ _ (x1, y1) _ _ _ _ _ _ _) -> (x1, y1)) li ++ [(xp, yp)] ++ map snd lc)

cimaBEscada2 :: Mapa -> [Posicao] -> [(Bloco, Bloco)]
cimaBEscada2 _ [] = []
cimaBEscada2' (Mapa i1 i2 m) ((l, c):re)
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

-}

{-| Verifica se o mapa tem chão válido. Um mapa é considerado válido se a última linha consistir apenas em blocos do tipo @Plataforma@.

== Exemplos de Utilização:
>>> temChao (Mapa (1,1) (2,2) [[Vazio, Vazio, Plataforma], [Plataforma, Plataforma, Plataforma], [Vazio, Vazio, Vazio]])
True
>>> temChao (Mapa (1,1) (2,2) [[Vazio, Vazio, Plataforma], [Plataforma, Plataforma, Escada], [Vazio, Vazio, Vazio]])
False
-}

temChao :: Mapa -- ^ Mapa do Jogo.
           -> Bool -- ^ Valor lógico do chão do Mapa ser todo feito por blocos do tipo "Plataforma".
temChao (Mapa _ _ map)
    | all (== Plataforma) ultimaLinha = True
    | otherwise = False
    where ultimaLinha = last map
{-|
Verifica se os inimingos têm a propriedade ressalta a __True__, enquanto que o jogador tem a __False__.
-}

testeRessalta :: [Personagem] -- ^ Lista de inimigos.
                 -> Personagem -- ^ Jogador.
                 -> Bool -- ^ Se todos os inimigos têm a propriedade __ressalta__ a __True__, enquanto que o jogador a tem a __False__, fornecerá o valor lógico __True__. Se não forem cumpridas estas condições dará __False__.
testeRessalta l (Personagem {tipo = j, ressalta = False}) = (j == Jogador) && all (==True) (map retiraRessalta l)
    where
        retiraRessalta :: Personagem -> Bool
        retiraRessalta (Personagem _ _ _ _ _ _ r _ _ _) = r

{-| 
Verifica se o jogador começa com colisão.
-}

colisaoInicial :: Mapa -- ^ Mapa do Jogo.
                  -> [Personagem] -- ^ Lista de inimigos.
                  -> Bool -- ^ Valor lógico do local de nascimento dos inimigos não ser igual ao local de "spawn" do Jogador.
colisaoInicial _ [] = False
colisaoInicial (Mapa (pi,_ ) _ _) (p:ps) = if pi == posicaoPersonagem p then True else colisaoInicial  (Mapa (pi, undefined) undefined undefined) ps
    where posicaoPersonagem :: Personagem -> Posicao
          posicaoPersonagem (Personagem _ _ p _ _ _ _ _ _ _) = p

{-| 
Verifica se o nº mínimo de inimigos é igual ou superior ao definido (2).
-}

minInimigos :: [Personagem] -- ^ Lista de inimigos.
               -> Bool -- ^ Valor lógico da lista de inimigos ser maior ou igual a 2.
minInimigos li = length li >= 2

{-| 
Função que verifica se todos os casos estudados na função __verificaVidasAux__ são verdade.
-}

verificaVidas :: [Bool] -- ^ Lista de Valores lógicos obtidos da função __verificaVidasAux__.
                 -> Bool -- ^ Valor lógico que verifica se a condição imposta se observa.
verificaVidas = all (==True)

{-|
Função que verifica se todos os inimigos do tipo @Fantasma@ têm exatamente __uma__ vida.
-}

verificaVidasAux :: [Personagem] -- ^ Lista de inimigos.
                    -> [Bool] -- ^ Lista dos valores lógicos de se verificar (um a um) a condição de a vida dos inimigos do tipo "Fantasma" ser igual 1.
verificaVidasAux [] = []
verificaVidasAux ((Personagem _ t _ _ _ _ _ v _ _):ps)
    | t == Jogador || t == MacacoMalvado = True: verificaVidasAux ps
    | t == Fantasma && v == 1 = True : verificaVidasAux ps
    | otherwise = False :verificaVidasAux ps

{-| 
Função que calcula a lista de posições de blocos de escada.
-}

posEscada :: Mapa -- ^ Mapa do Jogo.
             -> [Posicao] -- ^ Lista de posições de blocos de escada.
posEscada (Mapa _ _ m) = concatMap (\(l, bs) -> [(fromIntegral c, fromIntegral l) | (b, c) <- zip bs [0..], b == Escada]) $ zip [0..] m

{-|
Função que recebe a matriz que define o mapa e a lista das posições de blocos de escada no mapa e devolve uma lista de pares que correspondem ao bloco acima e a baixo da escada.
-}

cimaBEscada :: Mapa -- ^ Mapa do Jogo.
               -> [Posicao] -- ^ Lista de posições de blocos de escada.
               -> [(Bloco, Bloco)] -- ^ Lista de pares que correspondem ao bloco acima e a baixo da escada.
cimaBEscada _ [] = []
cimaBEscada (Mapa (pi, d) pf m) ((x, y) : r) =
    let e = cimaBEscada (Mapa (pi, d) pf m) r
        cima = if x > 0 then m !! floor (x - 1) !! floor y else Vazio
        baixo = if x < (fromIntegral (length m)) -1 then m !! floor (x + 1) !! floor y else Vazio
        extremidades = (cima, baixo)
    in if cima /= Alcapao && baixo /= Alcapao && (cima == Plataforma || baixo == Plataforma)
        then extremidades : e
        else e

{-| 
Função que verifica se as escadas não começam nem terminam em alçapões e se pelo menos uma das suas extremidades tem uma Plataforma.
-}

verificaCB :: [(Bloco, Bloco)] -- ^ lista de pares que correspondem ao bloco acima e em baixo das escada
             -> Bool -- ^ Valor Lógico de se verificarem as duas condições
verificaCB [] = True
verificaCB ((x,y):r)
   | x == Plataforma && (y == Plataforma || y == Vazio || y == Escada) = verificaCB r
   | (x == Plataforma || x == Vazio || x == Escada) && y == Plataforma = verificaCB r
   | otherwise = False




{-|
Função que verifica se um jogador é menos largo que um bloco de Alçapão do mapa.
-}

verificaAlcapao :: Personagem -- ^ Jogador
                 -> Bool -- ^ Valor lógico do Personagem do Jogador ser menor que um bloco de Alçapão do mapa
verificaAlcapao (Personagem _ _ _ _ (l,a) _ _ _ _ _) = l <= 1

{-|
Função que verifica se algum personagem ou colecionável está "dentro" de um bloco do tipo @Vazio@ do mapa.
-}

posColecPerson :: Mapa -- ^ Mapa do Jogo.
                  -> [Personagem] -- ^ Lista de personagens.
                  -> [(Colecionavel, Posicao)] -- ^ Lista de colecionáveis e suas posições.
                  -> Bool -- ^ True se todos estiverem em blocos vazios e fora de plataformas ou alçapões, False caso contrário.
posColecPerson (Mapa _ _ m) personagens colecionaveis =
    all (\(colec, pos) -> verPosColec m colec pos) colecionaveis

{-| Verifica se um colecionável está "dentro" de um bloco do tipo @Vazio@ do mapa.
Para colecionáveis do tipo "Moeda", a posição é considerada válida se o bloco correspondente estiver vazio e não dentro de uma plataforma ou alçapão.
Para colecionáveis do tipo "Martelo", as mesmas condições se aplicam como para "Moeda".
        
== Exemplos de utilização:
        
>>> verPosColec [[]] Moeda (0, 0)
False
        
>>> verPosColec [[Vazio, Plataforma], [Vazio, Vazio]] Martelo (1, 0)
False
-}
verPosColec :: [[Bloco]] -- ^ Matriz do mapa. 
               -> Colecionavel -- ^ Tipo de colecionável.
               -> Posicao -- ^ Posição do colecionável.
               -> Bool -- ^ True se a posição é válida, False caso contrário.
verPosColec m Moeda (x, y) =
    blocoVazio m (floor x) (floor y) && not (dentroPlatformaOuAlcapao m (floor x) (floor y))
verPosColec m Martelo (x, y) =
    blocoVazio m (floor x) (floor y) && not (dentroPlatformaOuAlcapao m (floor x) (floor y))
{-| Verifica se um bloco na posição especificada está vazio.
        
== Exemplo de utilização:
        
>>> blocoVazio [[Vazio, Plataforma], [Vazio, Vazio]] 0 0
True
-}

blocoVazio :: [[Bloco]] -- ^ Matriz do mapa.
              -> Int -- ^ Coordenada x da posição.
              -> Int  -- ^ Coordenada y da posição.
              -> Bool -- ^ True se o bloco está vazio, False caso contrário.
blocoVazio m x y = m !! x !! y == Vazio
{-| Verifica se um bloco na posição especificada é uma plataforma ou alçapão.

== Exemplo de utilização:
        
>>> dentroPlatformaOuAlcapao [[Vazio, Plataforma], [Vazio, Vazio]] 0 1
True
-}

dentroPlatformaOuAlcapao :: [[Bloco]] -- ^ Matriz do mapa.
                            -> Int -- ^ Coordenada x da posição.
                            -> Int -- ^ Coordenada y da posição.
                            -> Bool -- ^ True se o bloco é uma plataforma ou alçapão, False caso contrário.
dentroPlatformaOuAlcapao m x y =
    case m !! x !! y of
        Plataforma -> True
        Alcapao -> True
        _ -> False




-------------------------------------------------------------------------------------------------------------------

testColecionaveis :: [(Colecionavel, Posicao)]
testColecionaveis = [(Moeda, (1, 2)), (Martelo, (2, 2))]

jogadorTeste :: Personagem
jogadorTeste = Personagem
      { velocidade = (2, 0)
      , tipo = Jogador
      , posicao = (1, 2)
      , direcao = Este
      , tamanho = (1, 1)
      , emEscada = False
      , ressalta = False
      , vida = 3
      , pontos = 0
      , aplicaDano = (False, 0)
      }

inimigoTeste :: Personagem
inimigoTeste = Personagem
    { velocidade = (-1, 0)
    , tipo = Fantasma
    , posicao = (6, 2)
    , direcao = Oeste
    , tamanho = (1, 1)
    , emEscada = False
    , ressalta = False
    , vida = 1
    , pontos = 5
    , aplicaDano = (False, 0)
    }

personagensTeste :: [Personagem]
personagensTeste =
  [ Personagem
      { velocidade = (0, 0)
      , tipo = MacacoMalvado
      , posicao = (5, 3)
      , direcao = Oeste
      , tamanho = (1, 1)
      , emEscada = False
      , ressalta = True
      , vida = 1
      , pontos = 10
      , aplicaDano = (True, 5)
      }
  , Personagem
      { velocidade = (-1, 0)
      , tipo = Fantasma
      , posicao = (8, 1)
      , direcao = Oeste
      , tamanho = (1, 1)
      , emEscada = True
      , ressalta = True
      , vida = 1
      , pontos = 5
      , aplicaDano = (False, 0)
      }
  , Personagem
    { velocidade = (-1, 0)
    , tipo = Fantasma
    , posicao = (0, 0)
    , direcao = Oeste
    , tamanho = (1, 1)
    , emEscada = False
    , ressalta = True
    , vida = 1
    , pontos = 5
    , aplicaDano = (False, 0)
    }
  ]

personagensTeste1 :: [Personagem]
personagensTeste1 =
  [
   Personagem
      { velocidade = (0, 0)
      , tipo = MacacoMalvado
      , posicao = (5, 3)
      , direcao = Oeste
      , tamanho = (1, 1)
      , emEscada = False
      , ressalta = True
      , vida = 1
      , pontos = 10
      , aplicaDano = (True, 5)
      }
  , Personagem
      { velocidade = (-1, 0)
      , tipo = Fantasma
      , posicao = (8, 1)
      , direcao = Oeste
      , tamanho = (1, 1)
      , emEscada = True
      , ressalta = False
      , vida = 1
      , pontos = 5
      , aplicaDano = (False, 0)
      }
  , Personagem
    { velocidade = (-1, 0)
    , tipo = Fantasma
    , posicao = (6, 2)
    , direcao = Oeste
    , tamanho = (1, 1)
    , emEscada = False
    , ressalta = False
    , vida = 1
    , pontos = 5
    , aplicaDano = (False, 0)
    }
  ]

exemploMapaDiferente :: Mapa
exemploMapaDiferente = Mapa ((0,0), Este) (1,0)
 [ [Plataforma, Escada, Plataforma, Escada, Vazio]
 , [Plataforma, Escada, Vazio, Escada, Vazio]
 , [Plataforma, Escada, Vazio, Escada, Vazio]
 , [Plataforma, Escada, Vazio, Escada, Vazio]
 , [Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
 ]


exemploMapaTrue :: Mapa
exemploMapaTrue = Mapa ((0,0), Este) (1,0)
 [ [Plataforma, Escada, Plataforma, Escada, Vazio]
 , [Plataforma, Escada, Vazio, Escada, Vazio]
 , [Plataforma, Escada, Vazio, Escada, Vazio]
 , [Plataforma, Escada, Vazio, Escada, Vazio]
 , [Plataforma, Plataforma, Plataforma, Plataforma, Plataforma]
 ]

exemploMapaFalse :: Mapa
exemploMapaFalse = Mapa ((0,0), Este) (1,0)
 [ [Plataforma, Escada, Plataforma, Escada, Vazio]
 , [Plataforma, Escada, Vazio, Escada, Vazio]
 , [Plataforma, Escada, Vazio, Escada, Vazio]
 , [Plataforma, Escada, Vazio, Escada, Vazio]
 , [Plataforma, Plataforma, Plataforma, Plataforma, Vazio]
 ]