# 📐 Cálculo de Programas

<div align="center">

**Programação Funcional Rigorosa através da Álgebra de Programas**

*Universidade do Minho • Licenciatura em Engenharia Informática*

</div>

---

## 🎯 Visão Geral

Esta pasta contém o projeto prático desenvolvido no âmbito da unidade curricular **Cálculo de Programas**, que aborda a programação de computadores como uma área científica rigorosa. Utilizando a **Álgebra de Programação**, o projeto demonstra a derivação formal de programas a partir de especificações matemáticas.

O trabalho foi desenvolvido em **Literate Haskell**, combinando elegantemente código executável com documentação matemática detalhada.

## 🔬 Problemas Explorados

### 🌳 Pesquisa em Largura (BFS)
Implementação de travessia de árvores por níveis através de um **catamorfismo** para estratificação da estrutura e um **anamorfismo** baseado em filas de estado.

### 📊 Séries de Taylor (sinh x)
Derivação de uma função mutuamente recursiva para calcular aproximações eficientes da série do **seno hiperbólico**, utilizando diferenças finitas para atualização de coeficientes polinomiais.

### ∞ Fluxos Infinitos (Fair Merge)
Implementação de um algoritmo de fusão equitativa para sequências infinitas que garante ausência de bloqueio, derivado através da **lei dual de recursão mútua de Fokkinga**.

### 📡 Telégrafo Probabilístico
Modelação de um sistema de comunicação com falhas usando uma **Mónada Probabilística** e um catamorfismo probabilístico personalizado para análise de taxas de sucesso na transmissão.

---

## 🚀 Como Executar

O projeto foi concebido para ser executado num contentor Docker, assegurando que todas as dependências (Haskell GHC, LaTeX, lhs2TeX) estão corretamente configuradas.

### 🐳 1. Configuração do Docker

Construa a imagem Docker e execute o contentor:

```bash
docker build -t cp2526t .
docker run -v ${PWD}:/cp2526t -it cp2526t
```

### 💻 2. Execução do Código

Carregue o módulo Haskell no interpretador GHC:

```bash
ghci cp2526t.lhs
```

### 📄 3. Geração do Relatório em PDF

**Utilizando Make:**
```bash
make full
```

**Compilação Manual:**
```bash
lhs2TeX cp2526t.lhs > cp2526t.tex
pdflatex cp2526t
bibtex cp2526t.aux
makeindex cp2526t.idx
pdflatex cp2526t
```

---

## 🙏 Agradecimentos

Um agradecimento especial ao **Professor José Nuno Oliveira** e a toda a equipa docente pela disponibilização das bibliotecas de suporte essenciais—incluindo `Cp`, `BTree` e `Probability`—utilizadas ao longo deste projeto.

---

## 👥 Autores

<table>
<tr>
<td align="center">
<a href="https://github.com/josedasilva11">
<img src="https://github.com/josedasilva11.png" width="100px;" alt="josedasilva11"/><br />
<sub><b>josedasilva11</b></sub>
</a>
</td>
<td align="center">
<a href="https://github.com/PaoComPlanta">
<img src="https://github.com/PaoComPlanta.png" width="100px;" alt="PaoComPlanta"/><br />
<sub><b>PaoComPlanta</b></sub>
</a>
</td>
<td align="center">
<a href="https://github.com/DelgadoDevT">
<img src="https://github.com/DelgadoDevT.png" width="100px;" alt="DelgadoDevT"/><br />
<sub><b>DelgadoDevT</b></sub>
</a>
</td>
</tr>
</table>

---

<div align="center">

*Desenvolvido com ❤️ usando Haskell e Álgebra de Programação*

</div>
