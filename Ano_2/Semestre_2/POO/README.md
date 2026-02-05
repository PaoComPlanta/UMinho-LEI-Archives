# 🎵 SpotifUM

O **SpotifUM** é um ecossistema de gestão musical desenvolvido em **Java**, inspirado na experiência do Spotify. Criado no contexto da disciplina de Programação Orientada a Objetos (POO), este projeto utiliza uma interface de linha de comandos (CLI) para simular fluxos complexos de interação entre utilizadores e conteúdos multimédia.

## 🛠️ Arquitetura e Funcionalidades

A aplicação foi desenhada focando-se nos princípios de **encapsulamento, herança e polimorfismo**:

* **Gestão de Identidades:** Sistema de autenticação com distinção entre utilizadores comuns e administradores.
* **Ecossistema Musical:** Organização de faixas, álbuns e playlists, incluindo algoritmos de geração automática baseados em preferências.
* **Modelos de Negócio:** Implementação de planos de subscrição que desbloqueiam funcionalidades premium.
* **Persistência de Dados:** Mecanismo de *Save/Load* para manter o estado da aplicação entre sessões.
* **Garantia de Qualidade:** Suite de testes unitários com **JUnit** e documentação técnica via **Javadoc**.



## 👥 Autores
Trabalho desenvolvido por:
* [DelgadoDevT](https://github.com/DelgadoDevT)
* [PaoComPlanta](https://github.com/paocomplanta)
* [SirLordNelson](https://github.com/sirlordnelson)

## 🚀 Como Explorar

O projeto utiliza **Gradle** para simplificar a gestão do ciclo de vida:

| Objetivo | Comando |
| :--- | :--- |
| **Executar App** | `./gradlew run` |
| **Correr Testes** | `./gradlew test` |
| **Gerar Docs** | `./gradlew javadoc` |

---

> 💾 **Nota:** Existe um estado pré-carregado na pasta `save/` com dados de teste para exploração imediata do sistema.