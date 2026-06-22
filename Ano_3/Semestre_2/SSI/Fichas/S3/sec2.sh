#!/bin/bash

# Exercício 0
cat /etc/passwd
cat /etc/group

# Exercício 1
id -u user1 &>/dev/null || useradd -m -s /bin/bash user1
id -u user2 &>/dev/null || useradd -m -s /bin/bash user2

# Exercício 2
getent group grupo-ssi || groupadd grupo-ssi
getent group par-ssi || groupadd par-ssi

# Adicionar utilizadores aos grupos, havendo a exclução do user2 do grupo par-ssi
usermod -aG grupo-ssi user1
usermod -aG grupo-ssi user2
usermod -aG par-ssi user1


# Exercício 3
# Comentário: Novos utilizadores aparecem no final de passwd e novos grupos em group.
tail -n 4 /etc/passwd
tail -n 5 /etc/group

# Exercício 4
sudo su
chown user1 braga.txt

# Exercício 5
cat braga.txt

# Exercício 6
sudo -u user1 bash

# Exercício 7
sudo su
echo "user1:password" | chpasswd
echo "user2:password" | chpasswd
exit
sudo -u user1 bash -c '
    echo "Comando id:"
    id
    echo "Comando groups:"
    groups
'
# Comentário: O comando id mostra o UID (user ID), GID (group ID) e todos os grupos 
# aos quais o utilizador pertence. O comando groups lista apenas os nomes dos grupos.
# Para user1, vemos que pertence ao grupo principal user1 e aos grupos secundários 
# grupo-ssi e par-ssi.

# Exercício 8
sudo -u user1 bash -c '
    cat braga.txt
'
# Comentário: Inicialmente, mesmo sendo user1 o dono do ficheiro braga.txt (alterado no 
# exercício 4) e o ficheiro tendo permissões 400 (leitura para o dono), user1 NÃO 
# consegue ler o conteúdo. Isto acontece porque para aceder a um ficheiro, é necessário 
# ter permissão de EXECUÇÃO em todas as diretorias do caminho até ao ficheiro. 
# Como braga.txt está em /home/user e user1 não tem permissão de execução nessa diretoria, 
# o acesso é negado mesmo tendo permissão no ficheiro. Por isso executamos 
# "sudo chmod o+x /home/user" para dar permissão de execução (travessia) aos outros 
# utilizadores, permitindo a user1 atravessar a diretoria e aceder ao ficheiro.

# Exercício 9
sudo -u user2 bash -c '
    cd dir2 2>/dev/null && echo "Entrei na dir2" || echo "ERRO: Não foi possível entrar na dir2"
'
# Comentário: A diretoria dir2 foi configurada no sec1.sh sem permissão de execução 
# para group e others (chmod go-x dir2). Sem permissão de execução numa diretoria, 
# não é possível fazer 'cd' para ela, mesmo que se tenha permissão de leitura. 
# A permissão de execução em diretorias permite atravessar/aceder à diretoria.