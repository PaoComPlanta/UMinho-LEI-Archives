# Semana 6 — Cifras Modernas (Respostas)

---

## Q1 — Impacto de usar um NONCE fixo

Usar um **NONCE fixo** (por exemplo, tudo a zeros) com a mesma chave faz com que a cifra gere sempre a **mesma keystream**. Na prática, isto significa que se um atacante intercetar dois criptogramas cifrados com o mesmo par chave+NONCE, basta fazer o XOR entre eles para obter o XOR dos textos-limpos originais — o que anula completamente a proteção da cifra.

Basicamente, perde-se toda a **confidencialidade**, porque a keystream deixa de ser única para cada mensagem. É por isso que o NONCE tem de ser sempre diferente a cada utilização.

---

## Q2 — Quantos bits são afetados ao alterar 1 bit no texto-limpo

Afeta **apenas 1 bit** no criptograma. O ChaCha20 é uma cifra sequencial síncrona, ou seja, não promove difusão. A cifra funciona byte a byte (ou bit a bit) fazendo XOR com a keystream, portanto alterar um bit no input altera apenas o bit correspondente no output.

---

## Q3 — Bit flips nos modos CTR e CBC

- **Modo CTR:** Comporta-se como uma cifra sequencial, tal como o ChaCha20. Alterar **1 bit** no criptograma afeta exatamente **1 bit** na mesma posição do texto-limpo decifrado.

- **Modo CBC:** Aqui a história é diferente. Se alterarmos 1 bit num bloco do criptograma, ao decifrar, o **bloco atual fica completamente corrompido** (lixo) e o **bit correspondente no bloco seguinte** é invertido. Ou seja, a alteração propaga-se de forma diferente por causa do encadeamento entre blocos.

---

## Q4 — Usar o chacha20_int_attck.py nos criptogramas de AES-CTR e AES-CBC

O ataque do `chacha20_int_attck.py` explora a falta de difusão das cifras sequenciais para manipular bytes específicos do criptograma de forma controlada.

- **Em AES-CTR:** O ataque **funciona perfeitamente**, porque o modo CTR transforma o AES numa cifra sequencial. O atacante consegue inverter exatamente os bits que quer, sem precisar da chave, e o texto-limpo decifrado terá a alteração pretendida.

- **Em AES-CBC:** O ataque **não funciona como esperado**. Devido ao encadeamento de blocos do CBC, alterar bits num bloco do criptograma corrompe por completo o bloco atual (16 bytes viram lixo) e só afeta cirurgicamente o bloco seguinte. Logo, o atacante não consegue fazer uma manipulação limpa sem destruir dados adjacentes.

---

## Q5 — Função do Salt e do NONCE no password-based encryption

Sim, **ambos são necessários**, mas servem para coisas diferentes:

- **Salt:** É usado na KDF (neste caso, o PBKDF2) para garantir que, mesmo que duas pessoas usem a mesma pass-phrase, as chaves derivadas sejam completamente diferentes. Protege contra ataques de dicionário e rainbow tables. Tem de ser guardado junto com o criptograma para poder derivar a mesma chave na decifragem.

- **NONCE:** É usado pela cifra ChaCha20 para gerar uma keystream única em cada invocação, mesmo que a chave derivada seja a mesma. Também tem de ser armazenado com o criptograma, pois é necessário para decifrar.