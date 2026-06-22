#!/bin/bash

# Exercício 1
getfacl porto.txt

# Exercício 2
setfacl -m g:grupo-ssi:w porto.txt

# Exercício 3
getfacl porto.txt
# Comentário: Aparece uma linha 'group:grupo-ssi:--w' e uma linha 'mask'. 
# O grupo normal do ficheiro não foi alterado, mas o grupo-ssi agora tem acesso específico.

# Exercício 4
sudo -u user1 bash -c '
    echo "User1 a escrever..." >> porto.txt && echo "Escrita com sucesso."
    echo "User1 a tentar ler..."
    cat porto.txt || echo "Leitura falhou."
'
# Comentário: Se a ACL deu apenas 'w' (escrita), o utilizador pode escrever, 
# mas não pode ler o que escreveu se não tiver permissão de leitura ('r').