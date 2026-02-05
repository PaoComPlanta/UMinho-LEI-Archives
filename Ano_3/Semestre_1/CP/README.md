# 📐 Program Calculation

<div align="center">

**Rigorous Functional Programming through Program Algebra**

*University of Minho • Bachelor's Degree in Computer Engineering*

</div>

---

## 🎯 Overview

This folder contains the practical project developed within the scope of the **Program Calculation** course, which approaches computer programming as a rigorous scientific field. Using **Programming Algebra**, the project demonstrates the formal derivation of programs from mathematical specifications.

The work was developed in **Literate Haskell**, elegantly combining executable code with detailed mathematical documentation.

## 🔬 Problems Explored

### 🌳 Breadth-First Search (BFS)
Implementation of level-order tree traversal through a **catamorphism** for structure stratification and a queue-based state **anamorphism**.

### 📊 Taylor Series (sinh x)
Derivation of a mutually recursive function to compute efficient approximations of the **hyperbolic sine** series, using finite differences for polynomial coefficient updates.

### ∞ Infinite Streams (Fair Merge)
Implementation of a fair merge algorithm for infinite sequences that guarantees deadlock freedom, derived through **Fokkinga's mutual recursion dual law**.

### 📡 Probabilistic Telegraph
Modeling of a communication system with failures using a **Probability Monad** and a custom probabilistic catamorphism for analyzing transmission success rates.

---

## 🚀 How to Run

The project was designed to run in a Docker container, ensuring that all dependencies (Haskell GHC, LaTeX, lhs2TeX) are correctly configured.

### 🐳 1. Docker Setup

Build the Docker image and run the container:

```bash
docker build -t cp2526t .
docker run -v ${PWD}:/cp2526t -it cp2526t
```

### 💻 2. Code Execution

Load the Haskell module in the GHC interpreter:

```bash
ghci cp2526t.lhs
```

### 📄 3. PDF Report Generation

**Using Make:**
```bash
make full
```

**Manual Compilation:**
```bash
lhs2TeX cp2526t.lhs > cp2526t.tex
pdflatex cp2526t
bibtex cp2526t.aux
makeindex cp2526t.idx
pdflatex cp2526t
```

---

## 🙏 Acknowledgments

Special thanks to **Professor José Nuno Oliveira** and the entire teaching team for providing the essential support libraries—including `Cp`, `BTree`, and `Probability`—used throughout this project.

---

## 👥 Authors

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

*Developed with ❤️ using Haskell and Program Algebra*

</div>
