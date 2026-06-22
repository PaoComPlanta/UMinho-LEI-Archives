import sys
import os
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes

def setup(fkey):
    key = os.urandom(32)
    with open(fkey, 'wb') as f:
        f.write(key)

def enc(fich, fkey):
    with open(fkey, 'rb') as f:
        key = f.read()
    with open(fich, 'rb') as f:
        plaintext = f.read()

    nonce = os.urandom(16)

    cipher = Cipher(algorithms.AES(key), modes.CTR(nonce))
    encryptor = cipher.encryptor()
    ciphertext = encryptor.update(plaintext) + encryptor.finalize()

    with open(fich + ".enc", 'wb') as f:
        f.write(nonce + ciphertext)

def dec(fich, fkey):
    with open(fkey, 'rb') as f:
        key = f.read()
    with open(fich, 'rb') as f:
        conteudo = f.read()

    nonce = conteudo[:16]
    ciphertext = conteudo[16:]

    cipher = Cipher(algorithms.AES(key), modes.CTR(nonce))
    decryptor = cipher.decryptor()
    plaintext = decryptor.update(ciphertext) + decryptor.finalize()

    with open(fich.replace('.enc', '') + ".dec", 'wb') as f:
        f.write(plaintext)

if __name__ == "__main__":
    op = sys.argv[1]
    if op == "setup":
        setup(sys.argv[2])
    elif op == "enc":
        enc(sys.argv[2], sys.argv[3])
    elif op == "dec":
        dec(sys.argv[2], sys.argv[3])