# Respostas às Questões Teóricas - Semana 7

## Questão Q1

A mensagem original a ser processada pelo MAC é a concatenação da chave (com 32 bytes) e da mensagem propriamente dita (com 70 bytes), resultando num total de 102 bytes.

O SHA-256 processa dados em blocos de 64 bytes. Para que a mensagem se ajuste ao tamanho dos blocos, é necessário adicionar um preenchimento (padding). O padding é calculado da seguinte forma:

1.  Adiciona-se um byte `0x80` no final da mensagem. A mensagem passa a ter 103 bytes.
2.  Adicionam-se bytes de valor zero (`0x00`) até que o comprimento total da mensagem fique a 8 bytes de ser um múltiplo de 64. Neste caso, adiciona-se 17 bytes de zeros, e a mensagem fica com `103 + 17 = 120` bytes.
3.  Nos últimos 8 bytes, guarda-se o comprimento original da mensagem (os 102 bytes) em bits. `102 bytes * 8 = 816 bits`.

O padding acrescentado é, então, a sequência do byte `0x80`, seguido de 17 bytes nulos (`0x00`), e dos 8 bytes que representam o tamanho.

No total, o padding tem **26 bytes**.

## Questão Q2

A diferença de tamanho entre um ficheiro cifrado com `pbenc_aes_ctr_hmac.py` e outro com `pbenc_aes_gcm.py` deve-se aos metadados (cabeçalho) que cada um armazena juntamente com o criptograma.

Como ambos os métodos usam internamente um modo de cifra de fluxo (CTR), o tamanho do criptograma resultante é igual ao do texto original. A diferença está no que é guardado adicionalmente:

*   **`pbenc_aes_ctr_hmac.py`**: Guarda `salt (16 bytes) + nonce (16 bytes) + tag HMAC-SHA256 (32 bytes)`. Total do cabeçalho: **64 bytes**.
*   **`pbenc_aes_gcm.py`**: Guarda `salt (16 bytes) + nonce (12 bytes) + tag GCM (16 bytes)`. Total do cabeçalho: **44 bytes**.

O ficheiro gerado pelo `pbenc_aes_ctr_hmac.py` é **20 bytes maior** que o gerado pelo `pbenc_aes_gcm.py`.

A justificação para esta diferença de 20 bytes é:
1.  A tag de autenticação do HMAC-SHA256 é de 32 bytes, enquanto a do GCM é de 16 bytes (diferença de 16 bytes).
2.  O nonce usado no exemplo CTR é de 16 bytes, enquanto que o recomendado e usado para GCM é de 12 bytes (diferença de 4 bytes).
A soma destas diferenças (`16 + 4`) resulta nos 20 bytes.
