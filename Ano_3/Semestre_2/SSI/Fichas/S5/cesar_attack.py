import sys

def decifrar(criptograma, chave):
    deslocamento = ord(chave.upper()) - ord('A')
    resultado = []
    
    for letra in criptograma:
        if letra.isalpha():
            posicao_letra = ord(letra.upper()) - ord('A')
            nova_posicao = (posicao_letra - deslocamento) % 26
            nova_letra = chr(nova_posicao + ord('A'))
            resultado.append(nova_letra)
            
    return "".join(resultado)

if __name__ == "__main__":
    
    criptograma = sys.argv[1]
    palavras_alvo = [palavra.upper() for palavra in sys.argv[2:]]
    
    for i in range(26):
        chave_teste = chr(i + ord('A'))
        texto_limpo_teste = decifrar(criptograma, chave_teste)
        
        encontrou_match = False
        for palavra in palavras_alvo:
            if palavra in texto_limpo_teste:
                encontrou_match = True
                break
                
        if encontrou_match:
            print(chave_teste)
            print(texto_limpo_teste)
            sys.exit(0)