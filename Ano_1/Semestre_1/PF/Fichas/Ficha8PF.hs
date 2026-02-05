module Ficha8PF where
import Data.List

data Frac = F Integer Integer
--    deriving (Show)

frac1 = F (-33) (-51)
frac2 = F 50 (-5)

-- 1)
-- a) Também dava para fazer por casos. Foi só para usarmos o signum.
normaliza :: Frac -> Frac
normaliza (F x y) = F (a*signum (x*y)) b
    where d = mdc (abs x) (abs y)
          a = div (abs x) d
          b = div (abs y) d

mdc :: Integer -> Integer -> Integer
mdc a b
    | a > b = mdc (a-b) b
    | b > a = mdc a (b-a)
    | a == b = a

-- b)
instance Eq Frac where
    (F a b) == (F c d) = a*d == c*b

-- c)
instance Ord Frac where
    f1 <= f2 = let (F a b) = normaliza f1
                   (F c d) = normaliza f2
                in a*d <= c*b

-- d)
instance Show Frac where
    show :: Frac -> String
    show (F a b) = "("++show a++"/"++show b++")"

-- e)
instance Num Frac where
    (+), (*), (-) :: Frac -> Frac -> Frac
    (F a b) + (F c d) = F (a*d + c*b) (b*d)
    (F a b) * (F c d) = F (a*c) (b*d)
    (F a b) - (F c d) = F (a*d - c*b) (b*d)
    negate, abs, signum :: Frac -> Frac
    negate (F a b) = F (-a) b
    abs (F a b) = F (abs a) (abs b)
    signum (F a b) = F (signum (a*b)) 1
    fromInteger :: Integer -> Frac
    fromInteger x = F x 1

-- f)
fun :: Frac -> [Frac] -> [Frac]
fun f l = filter (>2*f) l

-- 2)
data Exp a = Const a
           | Simetrico (Exp a)
           | Mais (Exp a) (Exp a)
           | Menos (Exp a) (Exp a)
           | Mult (Exp a) (Exp a)

-- 3 + (2-5)
exp1 = Mais (Const 3) (Menos (Const 2) (Const 5))

-- (2-3) * -(5+20)
exp2 = Mult (Menos (Const 2) (Const 3))
            (Simetrico (Mais (Const 5) (Const 20)))

-- a)
instance (Show a) => Show (Exp a) where
    show :: Exp a -> String
    show (Const x) = show x
    show (Mais e1 e2) = "(" ++ show e1 ++ "+" ++ show e2 ++ ")"
    show (Menos e1 e2) = "(" ++ show e1 ++ "-" ++ show e2 ++ ")"
    show (Mult e1 e2) = "(" ++ show e1 ++ "*" ++ show e2 ++ ")"
    show (Simetrico e) = "-" ++ show e

-- b)
calcula :: Num a => Exp a -> a
calcula (Const x) = x
calcula (Simetrico e) = - (calcula e)
calcula (Mais e1 e2) = calcula e1 + calcula e2
calcula (Menos e1 e2) = calcula e1 - calcula e2
calcula (Mult e1 e2) = calcula e1 * calcula e2

instance (Eq a, Num a) => Eq (Exp a) where
    e1 == e2 = (calcula e1) == (calcula e2)

-- c) 
instance (Eq a, Num a) => Num (Exp a) where
    (+), (*), (-) :: Exp a -> Exp a -> Exp a
    e1 + e2 = Mais e1 e2
    e1 * e2 = Mult e1 e2
    e1 - e2 = Menos e1 e2
    abs :: Exp a -> Exp a
    abs e = if signum e == (-1)
            then Simetrico e
            else e
    signum :: Exp a -> Exp a
    signum e = Const (signum (calcula e))
    fromInteger :: Integer -> Exp a 
    fromInteger x = Const (fromInteger x)

-- 3) 
data Movimento = Credito Float | Debito Float
data Data = D Int Int Int
data Extracto = Ext Float [(Data, String, Movimento)]

-- a) 
instance Eq Data where
    (D d1 m1 a1) == (D d2 m2 a2) = d1 == d2 && m1 == m2 && a1 == a2

instance Ord Data where
    compare :: Data -> Data -> Ordering
    compare (D d1 m1 a1) (D d2 m2 a2) 
        | a1 > a2 || a1 == a2 && (m1 > m2 || m1 == m2 && d1 > d2) = GT
        | a1 == a2 && m1 == m2 && d1 == d2 = EQ
        | otherwise = LT

-- b) 
instance Show Data where
    show (D d m a) = show d ++ "/" ++ show m ++ "/" ++ show a

-- c) 
ordena :: Extracto -> Extracto
ordena (Ext saldo movimentos) = Ext saldo (sortBy (\(data1, _, _) (data2, _, _) -> compare data1 data2) movimentos)

-- d) 

ext1 = Ext 300 [
        (D 2010 4 5, "DEPOSITO", Credito 2000),
        (D 2010 8 10, "COMPRA", Debito 37.5),
        (D 2010 9 1, "LEV", Debito 60),
        (D 2011 1 7, "JUROS", Credito 100),
        (D 2011 1 22, "ANUIDADE", Debito 8)
    ]
{-
instance Show Extracto where
    show :: Extracto -> String
    show (Ext n l)   = "Saldo anterior :" ++ show n 
                ++ "\n----------------------------------------"
                ++ "\nData       Descrição   Credito   Debito"
                ++ "\n" ++ show  

instance Show Extracto where
    show :: Extracto -> String
    show ext = "Saldo anterior: " ++ show n ++
               "\n---------------------------------------" ++
               "\nData       Descricao" ++ replicate (desc_max - 9) ' ' ++ "Credito" ++ replicate (cred_max - 7) ' ' ++ "Debito" ++
               "\n---------------------------------------\n" ++
               unlines (map (\(dat,desc,mov) -> 
                    show dat ++ replicate (data_max - length (show dat)) ' ' 
                    ++ map toUpper desc ++ replicate (desc_max - length desc) ' ' 
                    ++ case mov of Credito quant -> show quant ++ replicate (cred_max - length (show quant)) ' '; Debito _ -> replicate cred_max ' '
                    ++ case mov of Debito quant -> show quant; Credito _ -> ""
               ) movs) ++
               "---------------------------------------" ++
               "\nSaldo actual: " ++ show (saldo ext)
        where (Ext n movs) = ordena ext
              data_max = 11
              desc_max = max (length "Descricao   ") (maximum $ map (\(_,desc,_) -> length desc) movs)
              cred_max = max (length "Credito   ") (maximum $ map (\(_,_,mov) -> case mov of Credito x -> length (show x); _ -> 0) movs)

-}


instance Show Extracto where
    show (Ext saldo movimentos) =
        "Saldo anterior: " ++ show saldo ++ "\n" ++
        "---------------------------------------\n" ++
        "Data       Descrição   Credito   Debito\n" ++
        "---------------------------------------\n" ++
        concatMap formatMovimento (sortOn (\(data', _, _) -> data') movimentos) ++
        "---------------------------------------\n" ++
        "Saldo atual: " ++ show (saldo + sumMovimentos movimentos)
      where
        sumMovimentos = sum . map (\(_, _, mov) -> case mov of
                                                      Credito x -> x
                                                      Debito x -> -x)
        formatMovimento (data', descricao, mov) =
            show data' ++ "   " ++ padRight 11 descricao ++
            case mov of
                Credito x -> padLeft 10 (show x) ++ "\n"
                Debito x -> padLeft 10 "" ++ padLeft 10 (show x) ++ "\n"

        padLeft n str = replicate (n - length str) ' ' ++ str
        padRight n str = str ++ replicate (n - length str) ' '


{-
-- d) 
instance Show Extracto where
    show ext = let (Ext s l) = ordena ext
               in "Saldo anterior: " ++ (show s) ++ 
               "\n-----------------\n" ++ "Data \t Descirção \t ... \n"
               ++ "\n-----------------\n" ++ (listaMov l)
               ++ "\n-----------------\n" ++ (show ...)

listaMov :: [(Data, String, Movimento)] -> String
listaMov ((d,s,Credito f):t) = (show d) ++ "\t" ++s++ "\t" ++ (show f) ++ "\n" ++ listaMov t
listaMov ((d,s,Debito f):t) = (show d) ++ "\t" ++s++ "\t\t\t\t" ++ (show f) ++ "\n" ++ listaMov t
listaMov [] = []
-}