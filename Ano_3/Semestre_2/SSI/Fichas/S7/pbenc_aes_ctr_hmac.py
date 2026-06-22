import sys
import os
import getpass
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives import hashes, hmac
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC

def derivar_chaves(password, salt):
    kdf = PBKDF2HMAC(
        algorithm=hashes.SHA256(),
        length=64,
        salt=salt,
        iterations=390000,
    )
    chaves = kdf.derive(password)
    return chaves[:32], chaves[32:]

def enc(fich):
    with open(fich, 'rb') as f:
        plaintext = f.read()

    pass_phrase = getpass.getpass("Pass-phrase: ").encode('utf-8')

    salt = os.urandom(16)
    nonce = os.urandom(16)
    key_enc, key_mac = derivar_chaves(pass_phrase, salt)

    cipher = Cipher(algorithms.AES(key_enc), modes.CTR(nonce))
    encryptor = cipher.encryptor()
    ciphertext = encryptor.update(plaintext) + encryptor.finalize()

    h = hmac.HMAC(key_mac, hashes.SHA256())
    h.update(ciphertext)
    mac_tag = h.finalize()

    with open(fich + ".enc", 'wb') as f:
        f.write(salt + nonce + mac_tag + ciphertext)

def dec(fich):
    with open(fich, 'rb') as f:
        conteudo = f.read()

    salt = conteudo[:16]
    nonce = conteudo[16:32]
    mac_tag_esperado = conteudo[32:64]
    ciphertext = conteudo[64:]

    pass_phrase = getpass.getpass("Pass-phrase: ").encode('utf-8')
    key_enc, key_mac = derivar_chaves(pass_phrase, salt)

    h = hmac.HMAC(key_mac, hashes.SHA256())
    h.update(ciphertext)
    h.verify(mac_tag_esperado)

    cipher = Cipher(algorithms.AES(key_enc), modes.CTR(nonce))
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
