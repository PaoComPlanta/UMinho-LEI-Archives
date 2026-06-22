<div align="center">

# 🔐 SSI - Information Systems Security

### Cryptography, Network Security & Secure Development

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![C](https://img.shields.io/badge/C-00599C?style=for-the-badge&logo=c&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Year](https://img.shields.io/badge/Year-3rd-orange?style=for-the-badge)
![Semester](https://img.shields.io/badge/Semester-2-blue?style=for-the-badge)

*Hands-on exploration of cryptographic primitives, secure protocols, and vulnerability analysis*

[📂 Repository](../..) • [🎓 Course Info](#-about) • [🚀 Quick Start](#-getting-started)

</div>

---

## 📖 About

**SSI (Segurança de Sistemas Informáticos)** covers the fundamentals of information systems security at the University of Minho. The course spans cryptographic algorithms, authentication protocols, key exchange mechanisms, memory safety vulnerabilities, and web application security.

This repository contains:
- 📝 **Lab worksheets** — 9 weeks of practical exercises (S3–S12) covering topics from file permissions to SQL injection
- 🏆 **Final project** — A fully functional end-to-end encrypted chat system with X3DH key exchange and Double Ratchet protocol

### 🎯 Learning Objectives

- Understand **access control** models and **Linux permission** mechanisms
- Implement **classical and modern ciphers** (Caesar, Vigenère, OTP, AES, ChaCha20)
- Apply **MACs**, **authenticated encryption**, and **password-based key derivation**
- Perform **Diffie-Hellman key exchange** and understand the **Station-to-Station** protocol
- Identify and exploit **memory safety vulnerabilities** (buffer overflows, format strings)
- Detect and remediate **SQL injection** and **command injection** attacks
- Design and implement **end-to-end encrypted communication** systems

---

## 🗂️ Repository Structure

```
SSI/
├── Fichas/                  # Lab Worksheets (9 weeks)
│   ├── S3/                  # Linux File Permissions & Access Control
│   │   └── sec1.sh–sec5.sh  # Bash scripts
│   ├── S4/                  # Access Control & Privilege Escalation
│   │   └── Respostas_S4.md  # Detailed answers
│   ├── S5/                  # Classical Ciphers & OTP
│   │   └── *.py             # Caesar, Vigenère, OTP + attacks
│   ├── S6/                  # Symmetric Encryption
│   │   └── *.py             # AES-CBC, AES-CTR, ChaCha20
│   ├── S7/                  # MACs & Authenticated Encryption
│   │   └── *.py             # HMAC-SHA256, AES-GCM
│   ├── S8/                  # Key Exchange
│   │   └── *.py             # Diffie-Hellman, DH+AES-GCM, STS
│   ├── S10/                 # Theoretical Answers
│   ├── S11/                 # Memory Safety Vulnerabilities
│   │   └── *.c              # Buffer overflow, format string
│   └── S12/                 # SQL & Command Injection
│       └── *.py             # Vulnerable app + fixed version
└── Projeto/                 # Final Project — Secure E2EE Chat
    ├── src/                 # Source code
    ├── tests/               # 16 test files (181 tests)
    ├── diagrams/            # Architecture diagrams
    ├── docs_src/            # Documentation sources
    ├── report.md            # Project report
    └── README.md            # Comprehensive project docs (312 lines)
```

---

## 🛠️ Technologies

<div align="center">

| Technology | Purpose | Usage |
|------------|---------|-------|
| ![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white) | Primary Language | Cryptography, web exploits, chat system |
| ![C](https://img.shields.io/badge/C-00599C?style=flat&logo=c&logoColor=white) | Systems Language | Memory vulnerability exercises |
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat&logo=gnubash&logoColor=white) | Shell Scripting | Linux permissions & access control |
| ![cryptography](https://img.shields.io/badge/cryptography-lib-yellow?style=flat) | Crypto Library | AES, ChaCha20, X25519, Ed25519 |
| ![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=flat&logo=fastapi&logoColor=white) | Web Framework | Chat server (WebSockets) |
| ![SQLite](https://img.shields.io/badge/SQLite-003B57?style=flat&logo=sqlite&logoColor=white) | Database | Message & key storage |
| ![PyQt6](https://img.shields.io/badge/PyQt6-41CD52?style=flat&logo=qt&logoColor=white) | GUI Framework | Chat client interface |

</div>

---

## 📚 Course Content

<table>
<tr>
<td width="50%">

**🔑 Cryptography & Protocols**
- ✅ Linux file permissions & ACLs
- ✅ Access control & privilege escalation
- ✅ Classical ciphers (Caesar, Vigenère)
- ✅ One-Time Pad & perfect secrecy
- ✅ AES-CBC, AES-CTR, ChaCha20
- ✅ HMAC-SHA256 & message authentication
- ✅ AES-GCM authenticated encryption
- ✅ Password-based key derivation

</td>
<td width="50%">

**🛡️ Security & Vulnerability Analysis**
- ✅ Capability leaking & setuid exploits
- ✅ Diffie-Hellman key exchange
- ✅ Station-to-Station (STS) protocol
- ✅ Buffer overflow attacks & defenses
- ✅ Format string vulnerabilities
- ✅ SQL injection (detection & remediation)
- ✅ Command injection attacks
- ✅ Secure coding best practices

</td>
</tr>
</table>

### 📋 Lab Worksheets Breakdown

| Week | Topic | Languages | Key Exercises |
|------|-------|-----------|---------------|
| **S3** | Linux File Permissions & Access Control | Bash | `sec1.sh`–`sec5.sh` — permission scripts |
| **S4** | Access Control & Privilege Escalation | Markdown | Capability leaking, setuid exploits |
| **S5** | Classical Ciphers & OTP | Python | Caesar, Vigenère, OTP + cryptanalysis |
| **S6** | Symmetric Encryption | Python | AES-CBC, AES-CTR, ChaCha20, integrity attacks |
| **S7** | MACs & Authenticated Encryption | Python | HMAC-SHA256, AES-GCM, password-based encryption |
| **S8** | Key Exchange Protocols | Python | Diffie-Hellman, DH+AES-GCM, STS protocol |
| **S10** | Theoretical Questions | — | Written answers only |
| **S11** | Memory Safety Vulnerabilities | C | Buffer overflow, format string + patches |
| **S12** | Web Application Security | Python | SQL injection, command injection + fixes |

---

## 🏆 Final Project — Secure E2EE Chat

The course project is a fully functional **end-to-end encrypted chat system** implementing modern cryptographic protocols for secure real-time communication.

**Highlights:**
- 🔑 **X3DH Key Exchange** — Extended Triple Diffie-Hellman for initial key agreement
- 🔄 **Double Ratchet Protocol** — Forward secrecy and post-compromise security
- 🔐 **X25519 ECDH + Ed25519 Signatures** — Elliptic curve key exchange and authentication
- 🛡️ **AES-256-GCM** — Authenticated encryption for all messages
- 📜 **PKI & Certificates** — Certificate-based identity verification
- 👥 **Group Messaging** — Secure multi-party communication
- 🌐 **P2P Fallback** — Direct peer-to-peer mode when server is unavailable
- ✅ **181 Passing Tests** across 16 test files

**Tech Stack:** Python 3.11+, cryptography lib, FastAPI, WebSockets, PyQt6, SQLite, Rich

> For complete project documentation, see the [Project README](Projeto/README.md).

---

## 🚀 Getting Started

### Prerequisites

```bash
# Python 3.11+ (for most exercises and the project)
python3 --version

# GCC (for memory safety exercises in S11)
sudo apt install gcc

# Project dependencies
cd Projeto/
pip install -e ".[dev]"
```

### Running Lab Worksheets

```bash
# Bash scripts (S3)
cd Fichas/S3/
chmod +x sec1.sh
./sec1.sh

# Python exercises (S5–S8, S12)
cd Fichas/S5/
python3 cesar.py
python3 vigenere.py

# C programs (S11)
cd Fichas/S11/
gcc -o vuln vuln.c
./vuln
```

### Running the Project

```bash
cd Projeto/

# Run the server
make server

# Run the client (in another terminal)
make client

# Run all tests
make test
```

---

## 🎯 Skills Acquired

✅ **Cryptographic Implementation** — Hands-on with symmetric/asymmetric ciphers and protocols  
✅ **Access Control & Permissions** — Linux security model and privilege management  
✅ **Key Exchange Protocols** — Diffie-Hellman, STS, X3DH in practice  
✅ **Authenticated Encryption** — MACs, HMAC, AES-GCM, and integrity verification  
✅ **Vulnerability Analysis** — Identifying and exploiting buffer overflows and format strings  
✅ **Web Security** — SQL injection and command injection detection and remediation  
✅ **Secure Protocol Design** — End-to-end encryption with forward secrecy  
✅ **Security Testing** — Comprehensive test suites for cryptographic systems  
✅ **Secure Coding Practices** — Writing resilient code against common attack vectors  

---

## 👥 Authors

<div align="center">

| <img src="https://github.com/DelgadoDevT.png" width="100" height="100" style="border-radius: 50%"> | <img src="https://github.com/PaoComPlanta.png" width="100" height="100" style="border-radius: 50%"> | <img src="https://github.com/yHugoSoares.png" width="100" height="100" style="border-radius: 50%"> |
|:---:|:---:|:---:|
| **João Delgado** | **Simão Mendes** | **Hugo Soares** |
| Nº 106836 | Nº 106928 | Nº 107293 |
| [@DelgadoDevT](https://github.com/DelgadoDevT) | [@PaoComPlanta](https://github.com/PaoComPlanta) | [@yHugoSoares](https://github.com/yHugoSoares) |

</div>

---

## 📜 License

This work is part of the University of Minho academic archives and is subject to the repository's [Educational Use License](../../../LICENSE).

**For current students:** Use responsibly as a learning reference only.

---

<div align="center">

### 🎓 Part of UMinho Software Engineering Archives

**Developed in:** 2025/2026 Academic Year  
**Course Code:** SSI  
**Department:** Informatics Engineering  
**University:** Universidade do Minho

[⬆️ Back to Top](#-ssi---information-systems-security)

</div>
