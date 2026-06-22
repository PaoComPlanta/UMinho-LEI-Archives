# Respostas ao Laboratório: Cross-Site Scripting (XSS) - SEED Labs

Neste documento, exploro de forma conceptual a vulnerabilidade de Cross-Site Scripting (XSS) no sistema Elgg. Abordarei a criação do "Samy Worm", a sua propagação e as formas de mitigação, como as políticas de segurança de conteúdo (CSP).

---

### Questões Q1 & Q2 (Task 4) - O Mecanismo do Worm e a Limitação do Editor de Texto

**Q1: Para que servem as variáveis `__elgg_ts` e `__elgg_token` que o código extrai?**

Essas variáveis são, no fundo, um segredo temporário que o Elgg cria para cada utilizador. Funcionam como um passe de segurança para garantir que as ações, como adicionar um amigo ou editar o perfil, são legítimas e vêm realmente do utilizador, e não de um atacante.

O meu worm precisa de "roubar" este passe da página da vítima para se fazer passar por ela. Ao incluir o `timestamp` (`__elgg_ts`) e o `token` (`__elgg_token`) no seu pedido malicioso, o worm consegue enganar o servidor, que acredita estar a receber uma ordem genuína. Sem eles, o Elgg simplesmente recusaria o pedido, protegendo o utilizador de um ataque de falsificação (CSRF).

**Q2: Se o Elgg só permitisse usar o editor visual (WYSIWYG), sem acesso ao modo de texto/HTML, o ataque funcionaria?**

Não, o ataque falharia. Editores de texto como o que vemos no Elgg (chamados de "ricos" ou WYSIWYG) são programados para desarmar código perigoso.

Quando tentei inserir o meu script, o editor converteu os caracteres especiais, como `<` e `>`, nas suas versões inofensivas em HTML (`&lt;` e `&gt;`). O resultado é que, em vez de o navegador executar o meu código, ele apenas o exibe como texto simples na tela. A opção de "modo texto" é a porta que me permite contornar essa proteção e injetar o código malicioso diretamente.

---

### Questão Q3 - Classificação do Ataque

**Em qual das categorias de XSS (Reflected, Stored ou DOM-based) este ataque se enquadra?**

Este é um exemplo clássico de **Stored XSS** (ou XSS Persistente).

A razão é simples: o meu código malicioso (o *payload*) é guardado permanentemente na base de dados do servidor. Ele fica lá, à espera, no meu perfil.

A grande diferença para outros tipos de XSS é que a vítima não precisa de clicar num link suspeito. Basta que ela visite uma página legítima — neste caso, o meu perfil — para que o servidor lhe entregue a página já infetada, executando o meu código no navegador dela sem que ela perceba.

*(Curiosidade: na Task 6, usei técnicas de manipulação do DOM para conseguir que o worm se lesse e se propagasse, mas a vulnerabilidade original que permitiu a infeção é, sem dúvida, do tipo Stored).*

---

### Questão Q4 (Task 7) - Mitigação com Content Security Policy (CSP)

**Quais as diferenças de comportamento entre os três websites e como a CSP explica isso?**

A Content Security Policy (CSP) é como uma lista de permissões que o servidor envia ao navegador, dizendo-lhe quais fontes de código são seguras. Os três sites demonstram o poder desta política na prática:

*   **www.example32a.com (Sem Defesa):**
    *   **Comportamento:** Tudo funciona. Todos os scripts, internos e externos, são executados.
    *   **Explicação:** Este site não envia nenhuma política CSP. Na ausência de regras, o navegador assume que tudo é seguro e executa qualquer código que encontra. É um convite aberto a ataques XSS.

*   **www.example32b.com (Defesa Restrita):**
    *   **Comportamento:** Quase nada funciona. Apenas o script carregado de um ficheiro no próprio servidor (Área 4) é executado.
    *   **Explicação:** A política aqui é `script-src 'self'`. Isto diz ao navegador: "Só podes executar scripts que venham de ficheiros alojados no mesmo domínio que a página". Como resultado, qualquer código escrito diretamente no HTML (*inline*) ou vindo de outros domínios é bloqueado.

*   **www.example32c.com (Defesa Granular e Inteligente):**
    *   **Comportamento:** O script *inline* da Área 1 e o script externo da Área 4 funcionam. O resto é bloqueado.
    *   **Explicação:** A política é `script-src 'self' 'nonce-111-111-111'`. Além de permitir scripts do próprio domínio (`'self'`), ela introduz um "nonce" — um código único e imprevisível. O servidor gera este código e insere-o tanto na política CSP como no script *inline* que ele confia (Área 1). Quando o navegador vê que o "nonce" do script corresponde ao da política, ele executa-o, mesmo sendo *inline*. É uma forma de abrir exceções seguras sem desproteger o site inteiro.