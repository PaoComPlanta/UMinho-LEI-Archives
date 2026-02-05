<div align="center">

# 📘 PF - Functional Programming

![Haskell](https://img.shields.io/badge/Haskell-5D4F85?style=for-the-badge&logo=haskell&logoColor=white)
![Year](https://img.shields.io/badge/Year-1st-brightgreen?style=for-the-badge)
![ECTS](https://img.shields.io/badge/ECTS-5-blue?style=for-the-badge)

*Core functional programming concepts using Haskell*

</div>

---

## 📖 About

**PF (Programação Funcional)** introduces fundamental functional programming concepts through Haskell. This course covers recursion, higher-order functions, algebraic data types, and functional problem-solving techniques.

### 🎯 Learning Goals

- Master **recursion** and **pattern matching**
- Understand **higher-order functions** (`map`, `filter`, `fold`)
- Work with **algebraic data types** and **type classes**
- Apply **functional thinking** to problem-solving
- Write **pure, composable functions**

---

## 🗂️ Structure

```
PF/
├── Fichas/              # Weekly worksheets (Ficha1-9)
│   ├── Ficha1PF.hs      # Basic functions & recursion
│   ├── Ficha2PF.hs      # Lists & tuples
│   ├── Ficha3PF.hs      # Higher-order functions
│   ├── Ficha4PF.hs      # List comprehensions
│   ├── Ficha5PF.hs      # Algebraic data types
│   ├── Ficha6PF.hs      # Type classes
│   ├── Ficha7PF.hs      # Trees & recursive structures
│   ├── Ficha8PF.hs      # I/O & monads
│   ├── Ficha9PF.hs      # Advanced topics
│   └── Teste*.hs        # Past exams
└── 50_Questões/         # 50 Practice Problems
    ├── Codigo/          # Solutions
    └── Perguntas/       # Problem statements
```

---

## 📚 Core Topics

### Functions & Recursion
```haskell
-- Pattern matching
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n-1)

-- Guards
absolute :: Int -> Int
absolute x | x < 0     = -x
           | otherwise = x
```

### Lists & Higher-Order Functions
```haskell
-- List comprehensions
squares = [x^2 | x <- [1..10]]

-- Higher-order functions
doubleAll = map (*2)
evens = filter even
sum' = foldr (+) 0
```

### Algebraic Data Types
```haskell
-- Custom types
data Tree a = Empty 
            | Node a (Tree a) (Tree a)

-- Pattern matching on ADTs
height :: Tree a -> Int
height Empty = 0
height (Node _ l r) = 1 + max (height l) (height r)
```

### Type Classes
```haskell
-- Custom instances
instance Eq a => Eq (Tree a) where
  Empty == Empty = True
  (Node x l1 r1) == (Node y l2 r2) = 
    x == y && l1 == l2 && r1 == r2
  _ == _ = False
```

---

## 🚀 Quick Start

### Prerequisites
```bash
# Install Haskell Platform
sudo apt install haskell-platform  # Linux
brew install ghc cabal-install     # macOS
```

### Running Exercises
```bash
# Interactive mode
ghci Ficha1PF.hs

# Load and test functions
> factorial 5
120

# Compile
ghc -o ficha1 Ficha1PF.hs
./ficha1
```

---

## 📊 Worksheets Overview

| Worksheet | Topics |
|-----------|--------|
| **Ficha 1** | Basic functions, recursion, types |
| **Ficha 2** | Lists, tuples, pattern matching |
| **Ficha 3** | `map`, `filter`, `foldr`, lambdas |
| **Ficha 4** | List comprehensions, generators |
| **Ficha 5** | Algebraic data types, `Maybe`, `Either` |
| **Ficha 6** | Type classes, `Eq`, `Ord`, `Show` |
| **Ficha 7** | Binary trees, recursive structures |
| **Ficha 8** | I/O operations, `do` notation, monads |
| **Ficha 9** | Advanced patterns, performance |

---

## 💡 Key Concepts

<table>
<tr>
<td width="50%">

**Pure Functions**
- No side effects
- Same input → same output
- Referential transparency
- Easy to test & reason

</td>
<td width="50%">

**Immutability**
- No mutable state
- Create new values
- Thread-safe by default
- Persistent data structures

</td>
</tr>
</table>

**Lazy Evaluation**
- Expressions evaluated when needed
- Infinite data structures possible
- Efficient with large datasets

**Strong Static Typing**
- Type inference
- Compile-time guarantees
- Expressive type system

---

## 🎯 Skills Acquired

✅ Functional problem decomposition  
✅ Recursive thinking  
✅ Type-driven development  
✅ Higher-order function composition  
✅ Algebraic data type design  
✅ Pattern matching mastery  

---

## 🔗 Resources

- 📖 [Learn You a Haskell](http://learnyouahaskell.com/)
- 📚 [Haskell Documentation](https://www.haskell.org/documentation/)
- 🔍 [Hoogle - API Search](https://hoogle.haskell.org/)
- 📦 [Hackage - Packages](https://hackage.haskell.org/)

---

## 📜 License

Part of UMinho Software Engineering Archives - [Educational Use License](../../../LICENSE)

<div align="center">

**Developed in:** 2023/2024  
**University of Minho** - Informatics Engineering

[⬆️ Back to Top](#-pf---functional-programming)

</div>
