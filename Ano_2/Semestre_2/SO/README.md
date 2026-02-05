
# 📚 Sistema de Indexação de Documentos

## 📋 Descrição Geral

Este projeto, criado no âmbito da disciplina de **Sistemas Operativos** da Universidade do Minho, implementa um **Sistema de Indexação de Documentos** através de uma **arquitetura cliente-servidor** desenvolvida em C. Permite aos utilizadores indexar, pesquisar e gerir metadados de documentos de texto armazenados localmente. O sistema inclui armazenamento persistente, um mecanismo de cache personalizado e suporte para operações concorrentes através de processos filhos.

A comunicação entre o `dclient` (cliente) e o `dserver` (servidor) é realizada através de **named pipes (FIFOs)**, garantindo interações assíncronas, isoladas e escaláveis.

---

## 👥 Autores

- [DelgadoDevT](https://github.com/DelgadoDevT)
- [PaoComPlanta](https://github.com/PaoComPlanta)
- [TiagoBrito5](https://github.com/TiagoBrito5)

---

## ⚡ Funcionalidades

### 📝 Indexação (`-a`)
Adiciona metadados de um documento (título, autores, ano, caminho) ao sistema. Os metadados são anexados ou inseridos no primeiro espaço livre disponível.

```bash
./bin/dclient -a "titulo" "autores" "ano" "caminho"
```

### 🔍 Consulta de Metadados (`-c`)
Obtém os metadados de um documento específico através da sua chave. Operação otimizada pelo sistema de cache.

```bash
./bin/dclient -c "chave"
```

### 🗑️ Remover Entrada (`-d`)
Marca os metadados como inválidos e adiciona a sua posição à fila de espaços livres para reutilização futura.

```bash
./bin/dclient -d "chave"
```

### 📊 Contagem de Linhas por Palavra-chave (`-l`)
Conta o número de linhas que contêm uma determinada palavra-chave num documento.

```bash
./bin/dclient -l "chave" "palavra-chave"
```

### 🔎 Pesquisa Global (`-s`)
Executa uma pesquisa paralela em todos os documentos utilizando múltiplos processos (controlado pelo utilizador).

```bash
./bin/dclient -s "palavra-chave" "num_processos"
```

### 🛑 Encerrar Servidor (`-f`)
Encerra o servidor de forma segura, persistindo o estado atual e libertando recursos.

```bash
./bin/dclient -f
```

---

## 🏗️ Arquitetura

- **🔌 Comunicação Cliente-Servidor**: através de named pipes (`/tmp/serverChannel` e `/tmp/clientChannel<PID>`)
- **💾 Armazenamento de Metadados**: ficheiros binários (`metadata.bin`, `freeQueue.bin`, `identifier.bin`) garantem a persistência de dados
- **⚙️ Concorrência**: o servidor gere pesquisas paralelas de palavras-chave usando `fork()` e limita processos ativos conforme especificado pelo utilizador
- **🚀 Cache**: cache em memória com tamanho fixo (definido no arranque do servidor) melhora o desempenho de leitura, utilizando o **Algoritmo do Relógio** para substituição
- **♻️ Fila de Espaços Livres**: armazena posições reutilizáveis no ficheiro de metadados para reduzir fragmentação
- **🧹 Coletor de Lixo**: compacta o armazenamento de metadados periodicamente ou quando limites são atingidos

---

## 🚀 Como Executar

### 1️⃣ Compilar o projeto
```bash
make
```

### 2️⃣ Gerar documentação com Doxygen (opcional)
```bash
make doc
```

### 3️⃣ Iniciar o servidor
```bash
./bin/dserver dataset/ 36000
```
> **Nota:** O segundo argumento define o tamanho da cache (opcional)

### 4️⃣ Executar comandos do cliente
Utilize a sintaxe apresentada na secção de **Funcionalidades**

### 5️⃣ Encerrar o servidor
```bash
./bin/dclient -f
```

---

## 💾 Ficheiros de Persistência

| Ficheiro | Descrição |
|----------|-----------|
| `metadata.bin` | Armazena todos os metadados dos documentos |
| `freeQueue.bin` | Regista posições reutilizáveis no ficheiro de metadados |
| `identifier.bin` | Regista o próximo ID único a atribuir |

> Estes ficheiros são carregados no arranque do servidor e guardados no encerramento.

---

## 📝 Notas

- ⚠️ O sistema foi concebido para **ambientes baseados em UNIX** (ex.: Linux)
- 📦 Todos os binários encontram-se na pasta `bin/`
- 🔧 Os named pipes são criados em `/tmp/`

