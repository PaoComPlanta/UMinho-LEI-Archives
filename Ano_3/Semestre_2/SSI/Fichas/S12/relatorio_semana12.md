# Relatório - Semana 12: Injeção SQL e de Comandos

Neste laboratório, explorámos vulnerabilidades de injeção em aplicações Python, especificamente Injeção SQL e Injeção de Comandos, analisando como estas falhas permitem o acesso indevido a dados e o controlo do sistema.

## Exercício 1: Identificação de SQL Injection

Ao analisar a função `search_notes` no `noteapp.py`, percebemos que a query SQL é construída através de concatenação direta de strings. Isto é perigoso porque o interpretador da base de dados não consegue distinguir o que é código do que são apenas dados introduzidos pelo utilizador.

### Testes e Resultados

Começámos por uma pesquisa normal pelo termo "Welcome", que funcionou sem problemas. No entanto, ao introduzir entradas maliciosas, conseguimos manipular o comportamento da aplicação:

1. **Acesso total aos dados:** Ao usarmos `' OR '1'='1`, conseguimos fechar a aspa da string original e adicionar uma condição que é sempre verdadeira. Como resultado, a aplicação ignorou o filtro e mostrou todas as notas da base de dados, incluindo a nota "Secret" que contém a palavra-passe do administrador.

2. **Extração do esquema da base de dados:** Utilizando o comando `UNION SELECT`, conseguimos "colar" resultados de outras tabelas. Com o payload `' UNION SELECT 1, sql, '' FROM sqlite_master --`, forçámos a base de dados a revelar o seu próprio esquema (tabelas e colunas). Isto dá a um atacante o "mapa" completo do sistema.

3. **Exposição de dados sensíveis:** Já conhecendo a estrutura, usámos `' UNION SELECT 1, title, body FROM notes --` para listar todo o conteúdo da tabela de notas. O uso do `--` no final é crucial, pois comenta o resto da query original, evitando erros de sintaxe.

---

## Exercício 2: Injeção de Comandos (Command Injection)

A vulnerabilidade de injeção de comandos foi encontrada na funcionalidade de exportação de notas. O programa utiliza `os.system()` para invocar o comando `echo` do sistema operativo, passando o nome do ficheiro fornecido pelo utilizador sem qualquer validação.

### Como a exploração funciona

Como o comando é executado num shell, caracteres especiais como `;`, `|` ou `` ` `` podem ser usados para encadear comandos adicionais.

- **Fuga de informação:** Ao introduzir `note.txt; cat /etc/passwd`, o sistema cria o ficheiro e, logo de seguida, imprime o conteúdo do ficheiro de utilizadores do Linux.
- **Identificação do processo:** Com `note.txt; id; whoami`, conseguimos saber exatamente com que privilégios a aplicação está a correr.
- **Substituição de comandos:** Usando backticks (`` `ls -la` ``), o shell executa primeiro o comando dentro das aspas e tenta usar o resultado como nome de ficheiro, o que acaba por revelar o conteúdo do diretório atual.

---

## Exercício 3: Correção de SQL Injection

Para corrigir a falha de SQL Injection no `noteapp_fixed.py`, substituímos a concatenação por **queries parametrizadas**. 

```python
sql = "SELECT id, title, body FROM notes WHERE title LIKE ?"
search_term = f"%{query}%"
cursor = conn.execute(sql, (search_term,))
```

Desta forma, o driver do SQLite trata o input do utilizador estritamente como um valor (literal) e nunca como parte do comando SQL. Quando voltámos a testar os payloads do Exercício 1, a aplicação simplesmente não devolveu resultados, pois estava a procurar textualmente por essas strings em vez de as executar.

---

## Exercício 4: Correção de Injeção de Comandos

A remediação da injeção de comandos seguiu dois princípios fundamentais:

1. **Evitar o Shell:** Em vez de chamar comandos do sistema operativo com `os.system()`, passámos a escrever o ficheiro diretamente em Python usando `with open(...)`. Sem shell, não há interpretação de caracteres especiais.
2. **Validação Estrita:** Implementámos uma expressão regular que apenas permite caracteres seguros (letras, números, pontos e traços) no nome do ficheiro.

Com estas alterações, qualquer tentativa de incluir comandos extra ou fazer ataques de "path traversal" (como `../../../etc/passwd`) é bloqueada logo à partida pela validação do nome.

---

## Exercício 5: Reflexão e Conclusões

**Causa comum entre injeções e corrupção de memória:**
A raiz do problema é a confusão entre **dados** e **instruções**. Quer seja um buffer overflow que sobrescreve o fluxo de execução na stack, ou um SQL injection que altera a lógica de uma base de dados, a falha reside em tratar input não fidedigno como algo que o sistema deve executar.

**Insuficiência da validação de input:**
Validar entradas (através de listas negras, por exemplo) é muitas vezes insuficiente porque os atacantes encontram formas criativas de contornar os filtros (ex: diferentes encodings). A defesa deve ser estrutural: usar APIs que separem inerentemente os dados do código (como a parametrização).

**Princípios de Segurança:**
A **parametrização** garante a integridade da estrutura do comando, enquanto o **privilégio mínimo** limita os danos caso uma vulnerabilidade seja explorada. Se a aplicação não correr como `root`, um atacante que consiga executar um comando terá o seu alcance severamente limitado.

**Diferença entre Buffer Overflow e Format String:**
Enquanto o buffer overflow é um ataque de "força bruta" onde se tenta inundar a memória para alterar o endereço de retorno, a vulnerabilidade de format string é mais cirúrgica. Ela aproveita-se de como funções como o `printf` interpretam especificadores (como `%n` para escrita ou `%p` para leitura) para manipular a memória de forma muito mais precisa e direta.
