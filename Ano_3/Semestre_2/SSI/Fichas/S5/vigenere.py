import sys

def preproc(texto):
    l = []
    for c in texto:
        if c.isalpha():
            l.append(c.upper())
    return "".join(l)

def vigenere(operacao, chave, mensagem):
    mensagem_limpa = preproc(mensagem)
    chave_limpa = preproc(chave)
    
    if not chave_limpa:
        return ""
        
    resultado = []
    tamanho_chave = len(chave_limpa)
    
    for i, letra_msg in enumerate(mensagem_limpa):
        letra_chave = chave_limpa[i % tamanho_chave]
        
        deslocamento = ord(letra_chave) - ord('A')
        
        if operacao == 'dec':
            deslocamento = -deslocamento

        posicao_letra = ord(letra_msg) - ord('A')

        nova_posicao = (posicao_letra + deslocamento) % 26
        nova_letra = chr(nova_posicao + ord('A'))
        
        resultado.append(nova_letra)
        
    return "".join(resultado)

if __name__ == "__main__":
        
    operacao = sys.argv[1]
    chave = sys.argv[2]
    mensagem = sys.argv[3]
        
    print(vigenere(operacao, chave, mensagem))