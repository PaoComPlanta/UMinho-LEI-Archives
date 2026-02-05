import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game 

main :: IO ()
main = do
  -- Carregue a imagem bitmap usando a função `loadBMP`
  -- Certifique-se de substituir "caminho/para/sua/imagem.bmp" pelo caminho real do seu arquivo de imagem.
  bitmap <- loadBMP "Downloads/Donkey_Kong_(new_design).bmp"

  -- Crie a janela do Gloss
  display
    (InWindow "Imagem Bitmap Test" (800, 600) (10, 10))
    white
    (bitmapTranslate bitmap)

-- Função para exibir a imagem bitmap no centro da janela
bitmapTranslate :: Picture -> Picture
bitmapTranslate bitmap = translate (-200) (-150) bitmap

