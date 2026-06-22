import sys
import os
from cryptography.hazmat.primitives import hashes

def setup(fkey):
    key = os.urandom(32)
    with open(fkey, 'wb') as f:
        f.write(key)

def mac(fich, fkey):
    with open(fkey, 'rb') as f:
        key = f.read()
    with open(fich, 'rb') as f:
        msg = f.read()

    digest = hashes.Hash(hashes.SHA256())
    digest.update(key)
    digest.update(msg)
    mac_value = digest.finalize()

    with open(fich + ".mac", 'wb') as f:
        f.write(mac_value)

def ver(fich, fkey):
    with open(fkey, 'rb') as f:
        key = f.read()
    with open(fich, 'rb') as f:
        msg = f.read()
    with open(fich + ".mac", 'rb') as f:
        mac_esperado = f.read()

    digest = hashes.Hash(hashes.SHA256())
    digest.update(key)
    digest.update(msg)
    mac_calculado = digest.finalize()

    print(mac_calculado == mac_esperado)

if __name__ == "__main__":
    op = sys.argv[1]
    if op == "setup":
        setup(sys.argv[2])
    elif op == "mac":
        mac(sys.argv[2], sys.argv[3])
    elif op == "ver":
        ver(sys.argv[2], sys.argv[3])
