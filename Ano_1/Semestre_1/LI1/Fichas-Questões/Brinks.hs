import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

data GameState = Game
  { playerY     :: Float
  , playerSpeed :: Float
  , obstacleX   :: Float
  , gameOver    :: Bool
  }

window :: Display
window = InWindow "Jump the Obstacle" (800, 600) (10, 10)

background :: Color
background = white

playerColor :: Color
playerColor = blue

obstacleColor :: Color
obstacleColor = red

initialState :: GameState
initialState = Game 0 0 300 False

updateGame :: Float -> GameState -> GameState
updateGame _ game
  | gameOver game = game
  | otherwise = newGame
  where
    newPlayerY = playerY game + playerSpeed game
    newObstacleX = obstacleX game - 5
    hitObstacle = abs (newPlayerY - 150) < 20 && newObstacleX < 20
    newGame
      | hitObstacle = game { gameOver = True }
      | newPlayerY < -200 = game { playerY = 0, obstacleX = 300 }
      | otherwise = game { playerY = newPlayerY, obstacleX = newObstacleX }

handleInput :: Event -> GameState -> GameState
handleInput (EventKey (Char ' ') Down _ _) game
  | gameOver game = initialState
  | otherwise = game { playerSpeed = 5 }
handleInput _ game = game

drawGame :: GameState -> Picture
drawGame game = pictures
  [ translate 0 (playerY game) $ color playerColor $ rectangleSolid 50 50
  , translate (obstacleX game) 0 $ color obstacleColor $ rectangleSolid 50 200
  ]

main :: IO ()
main = play window background 30 initialState drawGame handleInput updateGame
