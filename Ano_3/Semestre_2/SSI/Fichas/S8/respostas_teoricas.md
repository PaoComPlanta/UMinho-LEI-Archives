# Respostas Teóricas - Semana 8

### QUESTÃO: Q1
**Resposta:** Não. A Perfect Forward Secrecy (PFS) não é garantida pelo simples uso de uma KDF. A PFS é garantida pela natureza efémera das chaves Diffie-Hellman geradas (DHE - Diffie-Hellman Ephemeral). Se o segredo `K` de uma sessão específica for comprometido, todas as mensagens dessa sessão em particular ficam expostas. A garantia da PFS é que, se as chaves privadas de longo prazo (como as chaves RSA usadas para os certificados) forem comprometidas no futuro, o segredo `K` gerado no passado permanece seguro, pois as chaves DH `x` e `y` são geradas aleatoriamente em cada sessão e descartadas a seguir.

### QUESTÃO: Q2
**Resposta:** A informação das chaves públicas de cada participante está armazenada dentro dos respetivos Certificados X.509 (por exemplo, nos ficheiros `Alice.crt` e `Bob.crt`). O certificado liga criptograficamente a chave pública à identidade do seu dono, sendo esta ligação atestada pela assinatura da Autoridade de Certificação (CA).

### QUESTÃO: Q3
**Resposta:** Não, deixa de ser imune a ataques Man-in-the-Middle (MitM). Se a Alice não validar o certificado do Bob contra a Autoridade de Certificação (CA) de confiança, um atacante (Eve) pode intercetar a comunicação, gerar um certificado falso em nome do Bob e usar a sua própria chave privada para assinar os parâmetros Diffie-Hellman. A Alice irá verificar a assinatura com sucesso contra a chave pública contida no certificado falso da Eve, acreditando erradamente que está a estabelecer um canal seguro com o Bob.