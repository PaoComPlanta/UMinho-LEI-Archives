<div align="center">

# 💻 PL - Language Processing

### Fortran 77 Compiler targeting EWVM Bytecode

![Python](https://img.shields.io/badge/Python-%E2%89%A5%203.14-blue?style=for-the-badge&logo=python&logoColor=white)
![PLY](https://img.shields.io/badge/PLY-%E2%89%A5%203.11-green?style=for-the-badge)
![Poetry](https://img.shields.io/badge/Poetry-Package_Manager-cyan?style=for-the-badge&logo=poetry&logoColor=white)
![Year](https://img.shields.io/badge/Year-3rd-brightgreen?style=for-the-badge)
![Semester](https://img.shields.io/badge/Semester-2-blue?style=for-the-badge)

*A robust compiler that translates Fortran 77 source code into EWVM virtual machine bytecode*

[📂 Repository](../..) • [🎓 Course Info](#-about) • [🚀 Quick Start](#-installation--usage)

</div>

---

## 📖 About

**PL (Processamento de Linguagens)** covers compiler construction and language processing techniques. Students design and implement a complete compiler pipeline — from lexical analysis through code generation — applying formal language theory, parsing algorithms, and optimization strategies to a real-world target language.

This project implements a robust compiler capable of processing source code written in **Fortran 77** (ANSI X3.9-1978 standard, fixed 72-column format) and translating it entirely into executable bytecode for the **EWVM** Virtual Machine.

---

## ⚙️ Compilation Pipeline

The compiler operates through a well-defined sequential pipeline, spanning from source text analysis to final code generation, incorporating an intermediate fixed-point optimization phase:

```text
[ Source Code ] (Fortran 77)
       │
       ▼
╭───────────────╮
│     Lexer     │── Token extraction, fixed format (72 col.), continuation lines
╰───────────────╯
       │
       ▼
╭───────────────╮
│    Parser     │── LALR grammar, AST construction, subprogram & array support
╰───────────────╯
       │
       ▼
╭───────────────╮
│   Semantics   │── Type checking, scope management & Symbol Tables
╰───────────────╯
       │
       ▼
╭───────────────╮
│ Optimization  │── Constant folding, algebraic simplifications, dead code elimination
╰───────────────╯
       │
       ▼
╭───────────────╮
│  Code Gen     │── EWVM instruction generation, stack management, 1-based indexing
╰───────────────╯
       │
       ▼
[ EWVM Bytecode ]
```

---

## 📊 Project Status

The current version (`dev` branch) is fully functional. All proposed phases have been completed successfully:

- [x] **Lexical Analysis**
- [x] **Syntactic Analysis (AST)**
- [x] **Semantic Analysis & Symbol Tables**
- [x] **Code Optimization**
- [x] **EWVM Code Generation**

---

## 🗂️ Repository Structure

The project is organized as follows:

- **`src/`** — Core compiler modules.
  - `lexer.py`: Lexical analysis.
  - `parser.py`: LALR grammar (PLY) and Abstract Syntax Tree (AST) construction.
  - `ast_nodes.py`: AST node data structure definitions.
  - `semantic.py`: Semantic and type checking verification.
  - `symbol_table.py`: Symbol management logic organized by scopes.
  - `optimizer.py`: Advanced optimization pipeline.
  - `codegen.py`: Responsible for emitting final EWVM instructions.
  - `main.py`: Compiler CLI entry point.
- **`tests/`** — Test cases and validation.
  - `exemplo1_ola.f` to `exemplo8_arrays.f`: Demonstration Fortran programs.
  - `test.py`: Automation script to run and evaluate test results.
  - `expected_outputs/`: Directory containing reference bytecodes for comparison.
- **`docs/`** — Project documentation.
  - `grammar.txt`: Formal specification of the adopted grammar.
  - `optimization.md`: Details on optimization rules and approach.

---

## 📦 Installation & Usage

The project uses **Poetry** for easy and isolated dependency management.

```bash
# 1. Install project dependencies
poetry install

# 2. Compile a specific Fortran file
poetry run python src/main.py tests/exemplo2_fatorial.f
```

---

## ⚡ Quick Example

Here is a concise example of the transformation performed by the compiler:

**Input Fortran 77 code (`exemplo.f`):**
```fortran
      PROGRAM OLA
      PRINT *, 'OLA MUNDO'
      END
```

**Corresponding generated EWVM bytecode:**
```text
START
PUSHS "OLA MUNDO"
WRITES
WRITELN
STOP
```

---

## 🧪 Tests

The test suite includes 8 carefully designed programs to test the compiler's various features: arithmetic operations, strings, loops, arrays, and subroutines.

To run the entire test battery automatically:

```bash
poetry run python tests/test.py
```

---

## 📚 Documentation

The project includes detailed documentation auto-generated via [Sphinx](https://www.sphinx-doc.org/). To build and view the documentation locally:

```bash
# 1. Generate documentation in HTML format
poetry run sphinx-build -b html docs docs/_build/html

# 2. Start a local web server to view the documentation
python3 -m http.server -d docs/_build/html 8000
```

After starting the server, open your browser at: [http://localhost:8000](http://localhost:8000)

---

## 🎯 Skills Acquired

✅ Compiler pipeline design and implementation  
✅ Lexical analysis and tokenization  
✅ LALR parsing and AST construction  
✅ Semantic analysis and type systems  
✅ Code optimization techniques (constant folding, dead code elimination)  
✅ Virtual machine bytecode generation  
✅ Formal grammar specification  
✅ Automated testing for compiler correctness  

---

## 👥 Authors

<table>
<tr>
<td align="center">
<a href="https://github.com/DelgadoDevT">
<img src="https://github.com/DelgadoDevT.png" width="100px;" alt="DelgadoDevT"/><br />
<sub><b>DelgadoDevT</b></sub>
</a>
</td>
<td align="center">
<a href="https://github.com/a106799">
<img src="https://github.com/a106799.png" width="100px;" alt="Jorge Barbosa"/><br />
<sub><b>Jorge Barbosa</b></sub>
</a>
</td>
<td align="center">
<a href="https://github.com/PaoComPlanta">
<img src="https://github.com/PaoComPlanta.png" width="100px;" alt="PaoComPlanta"/><br />
<sub><b>PaoComPlanta</b></sub>
</a>
</td>
</tr>
</table>

---

## 📜 License

Part of UMinho Software Engineering Archives — [Educational Use License](../../../LICENSE)

---

<div align="center">

**Developed in:** 2025/2026  
**Course Code:** PL  
**University of Minho** — Informatics Engineering

[⬆️ Back to Top](#-pl---language-processing)

</div>
