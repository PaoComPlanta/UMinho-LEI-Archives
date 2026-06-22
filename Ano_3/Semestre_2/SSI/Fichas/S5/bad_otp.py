import sys
import random

def bad_prng(n):

    random.seed(random.randbytes(2))
    return random.randbytes(n)

def gerar_chave(num_bytes, nome_ficheiro):

    chave = bad_prng(num_bytes)
    with open(nome_ficheiro, 'wb') as f:
        f.write(chave)

def aplicar_xor_ficheiros(ficheiro_entrada, ficheiro_chave, ficheiro_saida):

    with open(ficheiro_entrada, 'rb') as f_in:
        dados = f_in.read()
        
    with open(ficheiro_chave, 'rb') as f_key:
        chave = f_key.read()
        
    resultado_bytes = bytes([b_dado ^ b_chave for b_dado, b_chave in zip(dados, chave)])
    
    with open(ficheiro_saida, 'wb') as f_out:
        f_out.write(resultado_bytes)

if __name__ == "__main__":
        
    operacao = sys.argv[1]
    
    if operacao == 'setup':
        num_bytes = int(sys.argv[2])
        nome_ficheiro = sys.argv[3]
        gerar_chave(num_bytes, nome_ficheiro)
        
    elif operacao == 'enc':
        ficheiro_mensagem = sys.argv[2]
        ficheiro_chave = sys.argv[3]
        ficheiro_saida = ficheiro_mensagem + '.enc' 
        aplicar_xor_ficheiros(ficheiro_mensagem, ficheiro_chave, ficheiro_saida)
        
    elif operacao == 'dec':
        ficheiro_cripto = sys.argv[2]
        ficheiro_chave = sys.argv[3]
        ficheiro_saida = ficheiro_cripto + '.dec'
        aplicar_xor_ficheiros(ficheiro_cripto, ficheiro_chave, ficheiro_saida)
