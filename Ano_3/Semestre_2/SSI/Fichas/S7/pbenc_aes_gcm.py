import sys
import os
import getpass
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives import hashes

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
    nonce = os.urandom(12)
    key = derivar_chave(pass_phrase, salt)

    cipher = Cipher(algorithms.AES(key), modes.GCM(nonce))
    encryptor = cipher.encryptor()
    ciphertext = encryptor.update(plaintext) + encryptor.finalize()
    tag = encryptor.tag

    with open(fich + ".enc", 'wb') as f:
        f.write(salt + nonce + tag + ciphertext)

def dec(fich):
    with open(fich, 'rb') as f:
        conteudo = f.read()

    salt = conteudo[:16]
    nonce = conteudo[16:28]
    tag = conteudo[28:44]
    ciphertext = conteudo[44:]

    pass_phrase = getpass.getpass("Pass-phrase: ").encode('utf-8')
    key = derivar_chave(pass_phrase, salt)

    cipher = Cipher(algorithms.AES(key), modes.GCM(nonce, tag))
    decryptor = cipher.decryptor()
    plaintext = decryptor.update(ciphertext) + decryptor.finalize()

    with open(fich.replace('.enc', '') + ".dec", 'wb') as f:
        f.write(plaintext)

if __name__ == "__main__":
    op = sys.argv[1]
    fich = sys.argv[2]
    if op == "enc":
        enc(fich)
    elif op == "dec":
        dec(fich)
