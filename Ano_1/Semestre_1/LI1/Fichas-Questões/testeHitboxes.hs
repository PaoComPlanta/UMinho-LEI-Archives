module Main where

type Point = (Float, Float)
type Hitbox = (Point, Point)

-- Check if two hitboxes collide
collides :: Hitbox -> Hitbox -> Bool
collides ((x1, y1), (x2, y2)) ((x3, y3), (x4, y4)) =
    not (x2 < x3 || x4 < x1 || y2 < y3 || y4 < y1)

-- Example usage:
hitbox1 :: Hitbox
hitbox1 = ((0, 0), (3, 3))

hitbox2 :: Hitbox
hitbox2 = ((2, 2), (5, 5))

main :: IO ()
main = do
    putStrLn $ "Do hitboxes collide? " ++ show (collides hitbox1 hitbox2)
