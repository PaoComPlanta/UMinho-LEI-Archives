module DonkeyKongMap where

data Tile = Empty | Ladder | Platform | Barrel | Player | DonkeyKong deriving (Show, Eq)

type Row = [Tile]
type Mapa = [Row]

donkeyKongMap :: Mapa
donkeyKongMap =
  [ [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Ladder, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Platform, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Platform, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Platform, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Platform, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Barrel, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  , [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]
  ]

printMap :: Mapa -> IO ()
printMap mapa = mapM_ printRow mapa
  where
    printRow :: Row -> IO ()
    printRow = putStrLn . concatMap show

main :: IO ()
main = printMap donkeyKongMap

