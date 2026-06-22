import sys

def main():
    fctxt = sys.argv[1]
    pos = int(sys.argv[2])
    ptxtAtPos = sys.argv[3].encode('utf-8')
    newPtxtAtPos = sys.argv[4].encode('utf-8')

    with open(fctxt, 'rb') as f:
        conteudo = bytearray(f.read())

    offset_nonce = 16
    tamanho = min(len(ptxtAtPos), len(newPtxtAtPos))

    for i in range(tamanho):
        conteudo[offset_nonce + pos + i] ^= ptxtAtPos[i] ^ newPtxtAtPos[i]

    with open(fctxt + ".attck", 'wb') as f:
        f.write(conteudo)

if __name__ == "__main__":
    main()