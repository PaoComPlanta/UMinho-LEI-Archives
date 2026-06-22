#!/bin/bash

# Exercício 1
# Crie um programa binário executável que imprima o conteúdo de um ficheiro de texto
# cujo nome é passado como único argumento da sua linha de comando
# 
# Código do ficheiro leitor.c:
# int main(int argc, char *argv[]) {
#     if (argc != 2) {
#         printf("Uso: %s <ficheiro>\n", argv[0]);
#         return 1;
#     }
# 
#     // Imprime UIDs reais e efetivos para debug
#     printf("Real UID: %d | Effective UID: %d\n", getuid(), geteuid());
# 
#     FILE *f = fopen(argv[1], "r");
#     if (f == NULL) {
#         perror("Erro ao abrir ficheiro");
#         return 1;
#     }
# 
#     int c;
#     while ((c = fgetc(f)) != EOF) {
#         putchar(c);
#     }
#     fclose(f);
#     return 0;
# }
gcc leitor.c -o leitor


# Exercício 2
id -u userssi &>/dev/null || useradd -m userssi

# Exercício 3
chown userssi leitor
chown userssi braga.txt
chmod 400 braga.txt

# Exercício 4
sudo -u user1 ./leitor braga.txt

# Exercício 5
chmod u+s leitor
ls -l leitor

# Exercício 6
sudo -u user1 ./leitor braga.txt

# Comentário: Desta vez deve funcionar. O SetUID faz com que, durante a execução,
# o Utilizador Efetivo (EUID) do processo seja o dono do ficheiro (userssi),
# e não quem o executou (user1). Como o userssi tem permissão de leitura no braga.txt, o acesso é permitido.