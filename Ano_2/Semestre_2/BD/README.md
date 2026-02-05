# 🏎️ JBVMotors | Database System

O **JBVMotors** é uma solução completa de base de dados desenvolvida para a gestão operacional de uma empresa de aluguer de veículos com três sucursais distintas. Este projeto abrange todo o ciclo de vida de desenvolvimento de dados, desde a análise conceptual e modelação até à implementação física e migração técnica.

## 📊 Arquitetura e Modelação
O sistema foi desenhado para garantir a integridade e escalabilidade dos dados, focando-se em:

* **Modelação Conceptual:** Diagramas Entidade-Associação (ER) detalhados.
* **Modelação Lógica:** Esquema relacional normalizado para eliminar redundâncias.
* **Álgebra Relacional:** Formalização matemática das operações de consulta.
* **Implementação Física:** Scripts SQL otimizados para **MySQL**.

## 🛠️ Stack Tecnológica
* **Base de Dados Principal:** MySQL
* **Scripting e Automação:** Python 3.7+
* **Interoperabilidade:** PostgreSQL, CSV e JSON (fontes de dados).

## ⚙️ Ferramentas de Dados (Python)
Para facilitar o teste e a integração do sistema, foram desenvolvidos scripts automatizados localizados na diretoria `scripts_python/`:

* **`populate.py`**: Motor de geração de dados fictícios (*fake data*) com exportação multiformato (SQL, CSV e JSON).
* **`migrate.py`**: Pipeline de ETL para migrar informação de diversas fontes diretamente para o motor MySQL.

### Comandos de Utilização
```bash
# Gerar massa de dados completa
python populate.py --all

# Executar migração total para MySQL
python migrate.py all
```

## 👥 Autores

* [DelgadoDevT](https://github.com/DelgadoDevT)
* [PaoComPlanta](https://github.com/paocomplanta)
* [xfn14](https://github.com/xfn14)
* [inesferribeiro](https://github.com/inesferribeiro)