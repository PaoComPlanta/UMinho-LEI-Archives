#!/bin/bash

# --- Exercício 1 ---
capsh --print

gcc webserver.c -o webserver

# --- Exercício 2 ---
# Execute o programa na porta 4050 (porta alta > 1024, qualquer user pode) [cite: 136]
./webserver 4050

# --- Exercício 3 ---
./webserver 80
# Resultado: Error on bind: Permission denied 
# Motivo: Portas abaixo de 1024 requerem privilégios de root.

sudo setcap cap_net_bind_service=+ep webserver
    
./webserver 80
# Resultado esperado: Sucesso.
# Como usar capabilities: Através do 'setcap', atribuímos apenas a permissão 
# de fazer bind a portas baixas ao executável, sem precisar de o tornar setuid root.
