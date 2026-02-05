module Ficha3PF where

data Hora = H Int Int
        deriving Show
type Etapa = (Hora,Hora)
type Viagem = [Etapa]

valida :: Hora -> Bool
valida (H h m) = h>=0 && h<24 && m>=0 && m<60

depois :: Hora -> Hora -> Bool
depois (H h1 m1) (H h2 m2) = if h1>h2 then True
                              else if h1==h2 then m1>m2
                                    else False

minutos1 :: Hora -> Int
minutos1 (H x y) = 60*x + y

horas1 :: Int -> Hora
horas1 x = H (div x 60) (mod x 60)


--a) --b)
viagem1 = [(H 9 30, H 10 25), (H 11 20, H 12 45), (H 13 30, H 14 45)]
viagem2 = [(H 9 30, H 10 25), (H 10 20, H 12 45), (H 13 30, H 14 45)]
etapaVal :: Etapa -> Bool
etapaVal (p,c) = valida p && valida c && depois c p

viagemVal :: Viagem -> Bool
viagemVal [] = False
viagemVal ((p1,c1):(p2,c2):t) = etapaVal (p1,c1) &&
                        depois p2 c1 &&
                        viagemVal ((p2,c2):t)

viagemVal [e] = etapaVal e

-- e) 

totalEspera :: Viagem -> Hora
totalEspera v = horas1 (espera v)

diferenca :: Hora -> Hora -> Int
diferenca (H h1 m1) (H h2 m2) = (h1*60 + m2) - (h2*60 + m1)

espera :: Viagem -> Int
espera ((p1,c1):(p2,c2):t) = (diferenca p2 c1) + espera ((p2,c2):t)
espera _ = 0

-- Checar a função diferença

--3)
data Contacto = Casa Integer
            | Trab Integer
            | Tlm Integer
            | Email String
            deriving Show
type Nome = String
type Agenda = [(Nome, [Contacto])]

--a) 
ag1 :: Agenda
ag1 = [("Ana",[Casa 253123123, Tlm 9121123123, Email "ana@uminho.pt"]),
       ("Nuno", [Tlm 931123123, Tlm 961123123]),
       ("Joao", [Trab 222222222, Email "joao@gmail.com"])
       ]

ag2 = acrescEmail "Maria" "mary@gmail.com" ag1

acrescEmail :: Nome -> String -> Agenda -> Agenda
acrescEmail n s ((x,l):t)
    | n == x = (x, Email s:l):t
    | otherwise = (x,l) : acrescEmail n s t
acrescEmail n s [] = [(n, [Email s])]

-- b) 
verEmails :: Nome -> Agenda -> Maybe [String]
verEmails n [] = Nothing
verEmails n ((x,l) : t)
    | n == x = Just (procEmails l) 
    | otherwise = verEmails n t

procEmails :: [Contacto] -> [String]
procEmails ((Email s):t) = s : procEmails t
procEmails (h:t) = procEmails t
procEmails [] = []

{-
consTelefs :: [Contacto] -> [Integer]
consTelefs ((Casa c): (Tlm t1): (Trab t2): t) =  c:t1:t2: consTelefs t
consTelefs (h:t) = consTelefs t
consTelefs [] = []
-}

consTelefs :: [Contacto] -> [Integer]
consTelefs [] = []
consTelefs ((Casa n):t) = n:consTelefs t
consTelefs ((Tlm n):t) = n:consTelefs t
consTelefs ((Trab n):t) = n:consTelefs t
consTelefs (_:t) = consTelefs t

-- 4)
type Dia = Int
type Mes = Int
type Ano = Int
type Nome1 = String

data Data = D Dia Mes Ano
        deriving Show

type TabDN = [(Nome,Data)]

-- a) 
agDN :: TabDN
agDN = [("Marcelo", D 13 3 1998), ("Marco", D 30 7 2005), ("Filipa", D 28 06 2004)]

procura :: Nome -> TabDN -> Maybe Data
procura _ [] = Nothing
procura x ((n,d):t)
    | x == n = Just d
    | otherwise = procura x t

idade :: Data -> Nome -> TabDN -> Maybe Int
idade d n tab = case (procura n tab) of
                    Nothing -> Nothing
                    Just x -> Just (calcula d x)

calcula :: Data -> Data -> Int
calcula (D d m a) (D dn mn an)
    | (m > mn) || (m == mn && d<dn) = a -an
    | (m == mn && d<dn) || m<mn = a - an -1


anterior :: Data -> Data -> Bool
anterior (D d1 m1 a1) (D d2 m2 a2) 
    | a1 < a2 = True 
    | a1 == a2 && m1<m2 = True
    | a1 == a2 && m1 == m2 && d1<d2 = True
    | otherwise = False

ordena :: TabDN -> TabDN
ordena [] = []
ordena (h:t) = insere h (ordena t)

insere :: (Nome,Data) -> TabDN -> TabDN
insere (x,D d m a) [] = [(x,D d m a)]
insere (x,D d m a) ((y, D d1 m1 a1):t)
    | anterior (D d m a) (D d1 m1 a1) == True = (x,D d m a) : (y, D d1 m1 a1) : t
    | otherwise = (y, D d1 m1 a1): insere (x, D d m a) t

porIdade:: Data -> TabDN -> [(Nome,Int)]
porIdade d tab = aux d (reverse (ordena tab))

aux :: Data -> TabDN -> [(Nome,Int)]
aux _ [] = []
aux d ((n,x):t) = (n,calcula d x) : aux d t 