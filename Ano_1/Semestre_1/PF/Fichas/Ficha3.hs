module Ficha3 where
import GHC.CmmToAsm.AArch64.Instr (x0)

data Hora = H Int Int
    deriving Show

type Etapa = (Hora,Hora)

type Viagem = [Etapa]

-- a) 
valida :: Hora -> Bool
valida (H h m) = h >= 0 && h <= 23 && m >= 0 && m <= 59

etapaValida :: Etapa -> Bool
etapaValida (H h m, H h1 m1)
    | valida (H h m) == False || valida (H h1 m1) == False = False
    | otherwise = if h1 < h then False else
                    if h1 == h && m1 <= m then False
                        else True

-- b)
viagemVal :: Viagem -> Bool
viagemVal [] = False
viagemVal [e] = etapaValida e
viagemVal (e:es)
    | etapaValida e == False = False
    | otherwise = viagemVal es

-- c)
partCheg :: Viagem -> (Hora,Hora)
partCheg [] = error "Não é válida a viagem"
partCheg [e] = e
partCheg (e:es) = (fst e, snd (last es))

-- d)
tempoViagem :: Viagem -> Hora
tempoViagem [] = H 0 0
tempoViagem ((h1,h2):t) = adicionaHoras (horas1 (diferencaHoras' h2 h1)) (tempoViagem t)

adicionaHoras :: Hora -> Hora -> Hora
adicionaHoras (H h1 m1) (H h2 m2) = H (h1+h2+he) mr
    where he = div (m1+m2) 60
          mr = mod (m1+m2) 60

diferencaHoras' :: Hora -> Hora -> Int
diferencaHoras' h1 h2 = horaParaMinutos h1 - horaParaMinutos h2

horaParaMinutos :: Hora -> Int
horaParaMinutos (H h m) = 60 * h + m

-- e)
totalEspera :: Viagem -> Hora
totalEspera v = horas1 (espera v)

diferenca :: Hora -> Hora -> Int
diferenca (H h1 m1) (H h2 m2) = (h1 - h2) * 60 + (m1 - m2)

espera :: Viagem -> Int
espera ((p1,c1):(p2,c2):t) = (diferenca p2 c1) + espera ((p2,c2):t)
espera _ = 0

horas1 :: Int -> Hora
horas1 x = H (div x 60) (mod x 60)

-- f) 
tempoTotalViagem :: Viagem -> Hora
tempoTotalViagem v = horas1 (diferenca hf hi)
    where (hi,hf) = partCheg v

-- 2)

data Ponto = Cartesiano Double Double
           | Polar Double Double
    deriving (Show,Eq)

data Figura = Circulo Ponto Double
            | Rectangulo Ponto Ponto
            | Triangulo Ponto Ponto Ponto
        deriving (Show,Eq)

type Poligonal = [Ponto]

-- a) 
comprimento :: Ponto -> Ponto -> Double
comprimento (Cartesiano x y) (Cartesiano x1 y1) = sqrt ((x-x1)^2 + (y-y1)^2)

-- b)
linhaFechada :: Poligonal -> Bool
linhaFechada p = length p >= 3 && head p == last p

-- c)
triangula :: Poligonal -> [Figura]
triangula (p1:p2:p3:ps)
    | p1 == p3 = []
    | otherwise = Triangulo p1 p2 p3 : triangula (p1:p3:ps)
triangula _ = []

-- d)
-- Feitas na tarefa 1 (Auxiliares necessárias).
area :: Figura -> Double
area (Triangulo p1 p2 p3) =
    let a = dist p1 p2
        b = dist p2 p3
        c = dist p3 p1
        s = (a+b+c) / 2 -- semi-perimetro
    in sqrt (s*(s-a)*(s-b)*(s-c)) -- formula de Heron
area (Rectangulo p1 p2) = abs (posx p2 - posx p1) * abs (posy p2 - posy p1)
area (Circulo _ r) = pi * (r ^ 2)

posx :: Ponto -> Double
posx (Cartesiano x y) = x
posx (Polar r a) = r * cos a

posy :: Ponto -> Double
posy (Cartesiano x y) = y
posy (Polar r a) = r * sin a

raio :: Ponto -> Double
raio (Cartesiano x y) = sqrt (x ^ 2 + y ^ 2)
raio (Polar r a) = r

angulo :: Ponto -> Double
angulo (Cartesiano x y) = atan (y/x)
angulo (Polar r a) = a

dist :: Ponto -> Ponto -> Double
dist p1 p2 = sqrt ((x' - x) ^ 2 + (y' - y) ^ 2)
    where x = posx p1
          y = posy p1
          x' = posx p2
          y' = posy p2

-------------------------------------------------------------------------------------

areaPol :: Poligonal -> Double
areaPol p  = areaTris (triangula p)

areaTris :: [Figura] -> Double
areaTris [] = 0
areaTris (h:t) = area h + areaTris t

-- e)
mover :: Poligonal -> Ponto -> Poligonal
mover pol p = p:pol

-- f)
zoom :: Double -> Poligonal -> Poligonal
zoom z (h:t) = mover (doZoom z h t) h

doZoom :: Double -> Ponto -> Poligonal -> Poligonal
doZoom z p [] = []
doZoom z p (h:t) = Cartesiano ((x - xp) * z + xp) ((y - yp) * z + yp) : doZoom z p t
    where x = posx h
          y = posy h
          xp = posx p
          yp = posy p

-- 3)
data Contacto = Casa Integer
              | Trab Integer
              | Tlm Integer
              | Email String
            deriving Show

type Nome = String

type Agenda = [(Nome, [Contacto])]

ag1 :: Agenda
ag1 = [("Ana",[Casa 253123123, Tlm 9121123123, Email "ana@uminho.pt"]),
       ("Nuno", [Tlm 931123123, Tlm 961123123]),
       ("Joao", [Trab 222222222, Email "joao@gmail.com"])
       ]

ag2 = acrescEmail "Maria" "mary@gmail.com" ag1

-- a)
acrescEmail :: Nome -> String -> Agenda -> Agenda
acrescEmail n e [] = [(n, [Email e])]
acrescEmail n e ((nome, contatos):t)
    | n == nome = (nome, contatos ++ [Email e]) : t
    | otherwise = (nome, contatos) : acrescEmail n e t

-- b) 
verEmails :: Nome -> Agenda -> Maybe [String]
verEmails n [] = Nothing
verEmails n ((nome, contactos):t)
    | n == nome = Just (findEmail contactos)
    | otherwise = verEmails n t

findEmail :: [Contacto] -> [String]
findEmail [] = []
findEmail (Email e:t) = e : findEmail t
findEmail (_:t) = findEmail t

-- c) 
consTelefs :: [Contacto] -> [Integer]
consTelefs [] = []
consTelefs (Casa n:t) = n : consTelefs t
consTelefs (Trab n:t) = n : consTelefs t
consTelefs (Tlm n:t) = n : consTelefs t
consTelefs (_:t) = consTelefs t

-- d)
casa :: Nome -> Agenda -> Maybe Integer
casa n [] = Nothing
casa n ((nome,contactos):t)
    | n == nome = findCasa contactos
    | otherwise = casa n t


findCasa :: [Contacto] -> Maybe Integer
findCasa [] = Nothing
findCasa (Casa n:t) = Just n
findCasa (_:t) = findCasa t 

-- 4)
type Dia = Int

type Mes = Int

type Ano = Int

data Data = D Dia Mes Ano
    deriving Show

type TabDN = [(Nome,Data)]

agDN :: TabDN
agDN = [("Marcelo", D 13 3 1998), ("Marco", D 30 7 2005), ("Filipa", D 28 06 2004)]

-- a)
procura :: Nome -> TabDN -> Maybe Data
procura nome [] = Nothing
procura nome ((n,d):ts)
    | nome == n = Just d
    | otherwise = procura nome ts

-- b)
idade :: Data -> Nome -> TabDN -> Maybe Int
idade _ _ [] = Nothing
idade (D d m a) n ((nome,D d1 m1 a1):t)
    | nome == n = Just (calcularIdade (D d1 m1 a1) (D d m a))
    | otherwise = idade (D d m a) n t

calcularIdade :: Data -> Data -> Int
calcularIdade (D d m a) (D dn mn an)
    | (m > mn) || (m == mn && d<dn) = a -an
    | (m == mn && d<dn) || m<mn = a - an -1

-- c)
anterior :: Data -> Data -> Bool
anterior (D d1 m1 a1) (D d2 m2 a2) 
    | a1 < a2 = True 
    | a1 == a2 && m1<m2 = True
    | a1 == a2 && m1 == m2 && d1<d2 = True
    | otherwise = False

-- d)
ordena :: TabDN -> TabDN
ordena [] = []
ordena (h:t) = insere h (ordena t)

insere :: (Nome,Data) -> TabDN -> TabDN
insere (x,D d m a) [] = [(x,D d m a)]
insere (x,D d m a) ((y, D d1 m1 a1):t)
    | anterior (D d m a) (D d1 m1 a1) == True = (x,D d m a) : (y, D d1 m1 a1) : t
    | otherwise = (y, D d1 m1 a1): insere (x, D d m a) t

-- e)
porIdade:: Data -> TabDN -> [(Nome,Int)]
porIdade d tab = aux d (reverse (ordena tab))

aux :: Data -> TabDN -> [(Nome,Int)]
aux _ [] = []
aux d ((n,x):t) = (n,calcularIdade d x) : aux d t 

-- 5)
data Movimento = Credito Float 
               | Debito Float
            deriving Show

data Extracto = Ext Float [(Data, String, Movimento)]
        deriving Show

-- a) 
extValor :: Extracto -> Float -> [Movimento]
extValor (Ext si ((_,_,mov):t)) valor
    | getValor mov > valor = mov: extValor (Ext si t) valor
    | otherwise = extValor (Ext si t) valor

getValor :: Movimento -> Float
getValor (Credito x) = x
getValor (Debito x) = x

-- b)
filtro :: Extracto -> [String] -> [(Data,Movimento)]
filtro (Ext si ((d,desc,mov):t)) s
    | desc `elem` s = (d,mov):filtro (Ext si t) s
    | otherwise = filtro (Ext si t) s

-- c)
creDeb :: Extracto -> (Float,Float)
creDeb (Ext _ movimentos) = (getCreditoL movimentos, getDebitoL movimentos)

getCreditoL :: [(Data, String, Movimento)] -> Float
getCreditoL movimentos = sum [getCredito mov | (_, _, mov) <- movimentos]

getDebitoL :: [(Data, String, Movimento)] -> Float
getDebitoL movimentos = sum [getDebito mov | (_, _, mov) <- movimentos]

getCredito :: Movimento -> Float
getCredito (Credito x) = x
getCredito _ = 0

getDebito :: Movimento -> Float
getDebito (Debito x) = x
getDebito _ = 0    

-- d)
saldo :: Extracto -> Float
saldo (Ext si []) = si
saldo (Ext si ((_,_,Debito x):t)) = saldo (Ext (si - x) t)
saldo (Ext si ((_,_,Credito x):t)) = saldo (Ext (si + x) t)
