import sys
import os
import getpass
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC

def derivar_chave(password, salt):
    kdf = PBKDF2HMAC(
        algorithm=hashes.SHA256(),
        length=32,
        salt=salt,
        iterations=390000,
    )
    return kdf.derive(password)

def enc(fich):
    with open(fich, 'rb') as f:
        plaintext = f.read()

    pass_phrase = getpass.getpass("Pass-phrase: ").encode('utf-8')

    salt = os.urandom(16)
    nonce = os.urandom(16)
    key = derivar_chave(pass_phrase, salt)

    cipher = Cipher(algorithms.ChaCha20(key, nonce), mode=None)
    ciphertext = cipher.encryptor().update(plaintext)

    with open(fich + ".enc", 'wb') as f:
        f.write(salt + nonce + ciphertext)

def dec(fich):
    with open(fich, 'rb') as f:
        conteudo = f.read()

    salt = conteudo[:16]
    nonce = conteudo[16:32]
    ciphertext = conteudo[32:]

    pass_phrase = getpass.getpass("Pass-phrase: ").encode('utf-8')
    key = derivar_chave(pass_phrase, salt)

    cipher = Cipher(algorithms.ChaCha20(key, nonce), mode=None)
    plaintext = cipher.decryptor().update(ciphertext)

    with open(fich.replace('.enc', '') + ".dec", 'wb') as f:
        f.write(plaintext)

if __name__ == "__main__":
    op = sys.argv[1]
    fich = sys.argv[2]
    if op == "enc":
        enc(fich)
    elif op == "dec":
        dec(fich)