import os
from multiprocessing import Process, Pipe
from cryptography.hazmat.primitives.asymmetric import dh, padding
from cryptography.hazmat.primitives import serialization, hashes
from cryptography.hazmat.primitives.kdf.hkdf import HKDF
from cryptography.hazmat.primitives.ciphers.aead import AESGCM
from cryptography import x509

p = 0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE45B3DC2007CB8A163BF0598DA48361C55D39A69163FA8FD24CF5F83655D23DCA3AD961C62F356208552BB9ED529077096966D670C354E4ABC9804F1746C08CA18217C32905E462E36CE3BE39E772C180E86039B2783A2EC07A28FB5C55DF06F4C52C9DE2BCBF6955817183995497CEA956AE515D2261898FA051015728E5A8AACAA68FFFFFFFFFFFFFFFF
g = 2

def mkpair(x, y):
    len_x = len(x)
    len_x_bytes = len_x.to_bytes(2, "little")
    return len_x_bytes + x + y

def unpair(xy):
    len_x = int.from_bytes(xy[:2], "little")
    x = xy[2:len_x+2]
    y = xy[len_x+2:]
    return x, y

def load_private_key(filename):
    with open(filename, "rb") as key_file:
        return serialization.load_pem_private_key(key_file.read(), password=None)

def load_cert(filename):
    with open(filename, "rb") as cert_file:
        return x509.load_pem_x509_certificate(cert_file.read())

def alice_process(conn):
    pn = dh.DHParameterNumbers(p, g)
    parameters = pn.parameters()
    
    alice_rsa_priv = load_private_key("Alice.key")
    alice_cert = load_cert("Alice.crt")
    
    dh_priv = parameters.generate_private_key()
    gx = dh_priv.public_key().public_bytes(
        serialization.Encoding.PEM, serialization.PublicFormat.SubjectPublicKeyInfo
    )
    
    conn.send(gx)
    
    msg2 = conn.recv()
    gy, sig_b_and_cert = unpair(msg2)
    sig_b, cert_b_bytes = unpair(sig_b_and_cert)
    
    bob_cert = x509.load_pem_x509_certificate(cert_b_bytes)
    bob_rsa_pub = bob_cert.public_key()
    
    bob_rsa_pub.verify(
        sig_b,
        gy + gx,
        padding.PSS(mgf=padding.MGF1(hashes.SHA256()), salt_length=padding.PSS.MAX_LENGTH),
        hashes.SHA256()
    )
    
    sig_a = alice_rsa_priv.sign(
        gx + gy,
        padding.PSS(mgf=padding.MGF1(hashes.SHA256()), salt_length=padding.PSS.MAX_LENGTH),
        hashes.SHA256()
    )
    
    cert_a_bytes = alice_cert.public_bytes(serialization.Encoding.PEM)
    msg3 = mkpair(sig_a, cert_a_bytes)
    conn.send(msg3)
    
    bob_dh_pub = serialization.load_pem_public_key(gy)
    shared_key = dh_priv.exchange(bob_dh_pub)
    
    derived_key = HKDF(hashes.SHA256(), 32, None, b'sts data').derive(shared_key)
    aesgcm = AESGCM(derived_key)
    nonce = os.urandom(12)
    ciphertext = aesgcm.encrypt(nonce, b"Ola Bob, STS concluido!", None)
    
    conn.send(nonce + ciphertext)
    print("Alice: Mensagem enviada com sucesso.")

def bob_process(conn):
    pn = dh.DHParameterNumbers(p, g)
    parameters = pn.parameters()
    
    bob_rsa_priv = load_private_key("Bob.key")
    bob_cert = load_cert("Bob.crt")
    
    gx = conn.recv()
    alice_dh_pub = serialization.load_pem_public_key(gx)
    
    dh_priv = parameters.generate_private_key()
    gy = dh_priv.public_key().public_bytes(
        serialization.Encoding.PEM, serialization.PublicFormat.SubjectPublicKeyInfo
    )
    
    sig_b = bob_rsa_priv.sign(
        gy + gx,
        padding.PSS(mgf=padding.MGF1(hashes.SHA256()), salt_length=padding.PSS.MAX_LENGTH),
        hashes.SHA256()
    )
    
    cert_b_bytes = bob_cert.public_bytes(serialization.Encoding.PEM)
    sig_and_cert = mkpair(sig_b, cert_b_bytes)
    msg2 = mkpair(gy, sig_and_cert)
    conn.send(msg2)
    
    msg3 = conn.recv()
    sig_a, cert_a_bytes = unpair(msg3)
    
    alice_cert = x509.load_pem_x509_certificate(cert_a_bytes)
    alice_rsa_pub = alice_cert.public_key()
    
    alice_rsa_pub.verify(
        sig_a,
        gx + gy,
        padding.PSS(mgf=padding.MGF1(hashes.SHA256()), salt_length=padding.PSS.MAX_LENGTH),
        hashes.SHA256()
    )
    
    shared_key = dh_priv.exchange(alice_dh_pub)
    derived_key = HKDF(hashes.SHA256(), 32, None, b'sts data').derive(shared_key)
    
    encrypted_data = conn.recv()
    nonce = encrypted_data[:12]
    ciphertext = encrypted_data[12:]
    
    aesgcm = AESGCM(derived_key)
    plaintext = aesgcm.decrypt(nonce, ciphertext, None)
    print(f"Bob: Recebi -> {plaintext.decode()}")

if __name__ == '__main__':
    parent_conn, child_conn = Pipe()
    
    p1 = Process(target=alice_process, args=(parent_conn,))
    p2 = Process(target=bob_process, args=(child_conn,))
    
    p1.start()
    p2.start()
    p1.join()
    p2.join()