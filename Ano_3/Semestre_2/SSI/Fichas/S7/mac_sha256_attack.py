import sys
import hashpumpy

def attack(fich, ext):
    with open(fich, 'rb') as f:
        msg_original = f.read()
        
    with open(fich + ".mac", 'rb') as f:
        mac_original_hex = f.read().hex()

    ext_bytes = ext.encode('utf-8')
    key_length = 32

    novo_mac_hex, nova_msg = hashpumpy.hashpump(mac_original_hex, msg_original, ext_bytes, key_length)

    with open(fich + ".ext", 'wb') as f:
        f.write(nova_msg)
        
    with open(fich + ".ext.mac", 'wb') as f:
        f.write(bytes.fromhex(novo_mac_hex))

if __name__ == "__main__":
    fich = sys.argv[1]
    ext = sys.argv[2]
    attack(fich, ext)
