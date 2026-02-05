raizes :: Float -> Float -> Float -> [Float]
raizes x y z
  | numRaizes == 2 = [raiz1,raiz2]
  | numRaizes == 1 = [raiz1]
  | otherwise = []
  where
    numRaizes = nRaizes x y z
    raiz1 = (-y + sqrt(y^2 +4*x*z)) / (2*x)
    raiz2 = (-y - sqrt(y^2 +4*x*z)) / (2*x) 

raizes1 :: Float -> Float -> Float -> [Float]
raizes1 x y z
  | numRaizes == 2 = [raiz1,raiz2]
  | numRaizes == 1 = [raiz1]
  | otherwise = []
  where
    numRaizes = nRaizes x y z
    raiz1 = (-y + sqrt(y^2 +4*x*z)) / (2*x)
    raiz2 = (-y - sqrt(y^2 +4*x*z)) / (2*x) 
