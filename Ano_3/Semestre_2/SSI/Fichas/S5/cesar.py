import sys

def preproc(texto):
    l = []
    for c in texto:
        if c.isalpha():
            l.append(c.upper())
    return "".join(l)

def cifrar_decifrar(operacao, chave, mensagem):
    mensagem_limpa = preproc(mensagem)
    
    chave = chave.upper()
    
    deslocamento = ord(chave) - ord('A')
    
    if operacao == 'dec':
        deslocamento = -deslocamento
        
    resultado = []
    
    for letra in mensagem_limpa:
        posicao_letra = ord(letra) - ord('A')
        
        nova_posicao = (posicao_letra + deslocamento) % 26
        
        nova_letra = chr(nova_posicao + ord('A'))
        resultado.append(nova_letra)
        
    return "".join(resultado)

if __name__ == "__main__":

    operacao = sys.argv[1]
    chave = sys.argv[2]
    mensagem = sys.argv[3]
        
    criptograma_final = cifrar_decifrar(operacao, chave, mensagem)
    print(criptograma_final)