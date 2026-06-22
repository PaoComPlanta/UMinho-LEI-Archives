import sys
import random

def bad_otp_attack(tamanho_chave, ficheiro_cripto, palavras_alvo):

    with open(ficheiro_cripto, 'rb') as f:
        criptograma = f.read()

    tamanho_analise = min(tamanho_chave, len(criptograma))

    for i in range(65536):
        semente = i.to_bytes(2, byteorder='big')

        random.seed(semente)
        chave_teste = random.randbytes(tamanho_chave)

        texto_limpo_bytes = bytes([b_c ^ b_k for b_c, b_k in zip(criptograma[:tamanho_analise], chave_teste[:tamanho_analise])])

        try:
            
            texto_limpo_str = texto_limpo_bytes.decode('utf-8')

            encontrou = False
            for palavra in palavras_alvo:
                if palavra in texto_limpo_str:
                    encontrou = True
                    break
                    
            if encontrou:
                print(texto_limpo_str.strip())
                return
                
        except UnicodeDecodeError:
            continue

    print("")

if __name__ == "__main__":
        
    tamanho_chave = int(sys.argv[1])
    ficheiro_cripto = sys.argv[2]
    palavras_alvo = sys.argv[3:]
    
    bad_otp_attack(tamanho_chave, ficheiro_cripto, palavras_alvo)