import sys
import itertools

def decifrar_vigenere(criptograma, chave):

    resultado = []
    tam_chave = len(chave)
    
    for i, letra_msg in enumerate(criptograma):
        letra_chave = chave[i % tam_chave]
        deslocamento = ord(letra_chave) - ord('A')
        posicao_letra = ord(letra_msg) - ord('A')
        
        nova_posicao = (posicao_letra - deslocamento) % 26
        resultado.append(chr(nova_posicao + ord('A')))
        
    return "".join(resultado)

def pontuar_fatia(fatia_decifrada):

    pesos = {'A': 14.6, 'E': 12.5, 'O': 10.7, 'S': 7.8, 'R': 6.5,
             'I': 6.1, 'N': 5.0, 'D': 4.9, 'M': 4.7, 'U': 4.6}
    score = 0
    for letra in fatia_decifrada:
        score += pesos.get(letra, 0)
    return score

if __name__ == "__main__":
        
    tamanho_chave = int(sys.argv[1])
    criptograma = sys.argv[2].upper()
    palavras_alvo = [p.upper() for p in sys.argv[3:]]

    fatias = [criptograma[i::tamanho_chave] for i in range(tamanho_chave)]
    
    candidatos_por_posicao = []

    for fatia in fatias:
        pontuacoes_deslocamento = []
        
        for i in range(26):
            letra_teste = chr(i + ord('A'))
            fatia_decifrada = decifrar_vigenere(fatia, letra_teste)
            score = pontuar_fatia(fatia_decifrada)
            pontuacoes_deslocamento.append((score, letra_teste))

        pontuacoes_deslocamento.sort(reverse=True, key=lambda x: x[0])

        melhores_letras = [letra for score, letra in pontuacoes_deslocamento[:5]]
        candidatos_por_posicao.append(melhores_letras)
        
    for chave_tuplo in itertools.product(*candidatos_por_posicao):
        chave_teste = "".join(chave_tuplo)
        texto_decifrado = decifrar_vigenere(criptograma, chave_teste)
        
        encontrou = False
        for palavra in palavras_alvo:
            if palavra in texto_decifrado:
                encontrou = True
                break
                
        if encontrou:
            print(chave_teste)
            print(texto_decifrado)
            sys.exit(0)