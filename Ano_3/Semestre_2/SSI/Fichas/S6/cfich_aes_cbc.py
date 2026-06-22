import sys
import os
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives import padding

def setup(fkey):
    key = os.urandom(32)
    with open(fkey, 'wb') as f:
        f.write(key)

def enc(fich, fkey):
    with open(fkey, 'rb') as f:
        key = f.read()
    with open(fich, 'rb') as f:
        plaintext = f.read()

    iv = os.urandom(16)

    padder = padding.PKCS7(algorithms.AES.block_size).padder()
    padded_data = padder.update(plaintext) + padder.finalize()

    cipher = Cipher(algorithms.AES(key), modes.CBC(iv))
    encryptor = cipher.encryptor()
    ciphertext = encryptor.update(padded_data) + encryptor.finalize()

    with open(fich + ".enc", 'wb') as f:
        f.write(iv + ciphertext)

def dec(fich, fkey):
    with open(fkey, 'rb') as f:
        key = f.read()
    with open(fich, 'rb') as f:
        conteudo = f.read()

    iv = conteudo[:16]
    ciphertext = conteudo[16:]

    cipher = Cipher(algorithms.AES(key), modes.CBC(iv))
    decryptor = cipher.decryptor()
    padded_plaintext = decryptor.update(ciphertext) + decryptor.finalize()

    unpadder = padding.PKCS7(algorithms.AES.block_size).unpadder()
    plaintext = unpadder.update(padded_plaintext) + unpadder.finalize()

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