module Questão8 where

type Equipa = String
type Golos = Int 
type Jogo = ((Equipa,Golos),(Equipa,Golos))
type Jornada = [Jogo]

{-| A função f recebe os jogos de uma jornada e calcula o nome das equipas perdedoras através de funções de ordem superior, ignorando as equipas que empataram.

== Exemplos de utilização

>>> f [(("Benfica",2),("Sporting",1)),(("Braga",1), ("Vitória",2))]
["Sporting","Braga"]

>>> f [(("Benfica",2),("Sporting",1)),(("Braga",1), ("Vitória",1))]
["Sporting"]
-}



-- f :: Jornada -> [Equipa]
f jornada = map (\((eq1, g1), (eq2, g2)) -> if g1 < g2 then eq1 else eq2) $ filter (\((_, g1), (_, g2)) -> g1 /= g2) jornada
