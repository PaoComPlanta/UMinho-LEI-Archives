module Questao9e10 where
import Test.HUnit (runTestTT)

type Coordenada = (Int,Int)
type Comprimento = Int
type Largura = Int
data Movimento = E | W | N | S deriving (Show, Eq)
type Mapa = (Comprimento, Largura)

movimentos :: Coordenada -> Coordenada -> [Movimento]
movimentos (x,y) (w,z) 
    | x == w && y == z = []
    | x < w  = [E] ++ movimentos (x+1,y) (w,z) 
    | x > w  = [W] ++ movimentos (x-1,y) (w,z) 
    | y < z  = [N] ++ movimentos (x,y+1) (w,z) 
    | y > z  = [S] ++ movimentos (x,y-1) (w,z) 

test1 = "Teste1" ~: [E,E,E] ~=? movimentos (0,0) (3,0)

test2 = "Teste2" ~: [N,N,N] ~=? movimentos (0,0) (0,3)

{-| A função dentroJanela recebe um mapa, a posição de um personagem e uma lista de movimentos e verifica se o personagem permanece dentro dos limites da janela.Acao

== Exemplos de utilização:

>>> dentroJanela (5,2) (0,0) [E,S]
True

>>> dentroJanela (5,2) (0,0) [W,N]
False

-}
dentroJanela :: Mapa -> Coordenada -> [Movimento] -> Bool
dentroJanela (c,l) (x,y) m
    | x' >= 0 && x' < c && y' >= 0 && y' < l = True
    | otherwise = False
    where
        (x', y') = posFinalAux (x, y) m



posFinalAux :: Coordenada -> [Movimento] -> Coordenada
posFinalAux (x,y) [] = (x,y)
posFinalAux (x,y) (E:t) = posFinalAux (x+1,y) t
posFinalAux (x,y) (W:t) = posFinalAux (x-1,y) t
posFinalAux (x,y) (N:t) = posFinalAux (x,y+1) t
posFinalAux (x,y) (S:t) = posFinalAux (x,y-1) t