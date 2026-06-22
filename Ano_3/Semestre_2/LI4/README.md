<div align="center">

# 🏪 LI4 - Software Engineering Lab IV

### Taki — Distributed Franchise Management System

![Java](https://img.shields.io/badge/Java-21-orange?style=for-the-badge&logo=openjdk&logoColor=white)
![Javalin](https://img.shields.io/badge/Javalin-6.x-blue?style=for-the-badge)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Vite](https://img.shields.io/badge/Vite-5.x-646CFF?style=for-the-badge&logo=vite&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose%20v2-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Year](https://img.shields.io/badge/Year-3rd-brightgreen?style=for-the-badge)
![Semester](https://img.shields.io/badge/Semester-2-blue?style=for-the-badge)

*Full-stack franchise management platform with autonomous store operations and resilient synchronization*

[📂 Repository](../..) • [🎓 Course Info](#-about) • [🚀 Quick Start](#%EF%B8%8F-installation)

</div>

---

## 📖 About

**LI4 (Laboratórios de Informática IV)** is the capstone software engineering lab of the Informatics Engineering degree at University of Minho. Students design, implement, and deploy a complete full-stack system using industry-standard practices — from requirements engineering and UML modeling through to containerized deployment and manual testing.

**Taki** is an integrated management system for a convenience store franchise network. It ensures **operational autonomy** at each store (POS, inventory, returns) and **synchronization** with the headquarters central server through a **Hub-and-Spoke** architecture built on JWT RS256 and PostgreSQL.

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🏬 Autonomous Local Operations
- Point of Sale (POS) with barcode scanner
- Per-store stock management, returns, and promotions
- Continues operating even without headquarters connectivity

</td>
<td width="50%">

### 🌐 Central Network Management
- Central catalog propagated to all branches
- Aggregated KPIs, PDF reports, and **SAF-T** export
- Global CRUD for stores, profiles, and employees

</td>
</tr>
<tr>
<td width="50%">

### 🔄 Resilient Synchronization
- *Outbox Pattern* in DAOs for *at-least-once* delivery
- Idempotency by UUID — no duplicates after reconnection
- Redundant headquarters endpoints via `URLS_SEDE_CSV`

</td>
<td width="50%">

### 🔐 Distributed Authentication
- JWT **RS256** signed with shared RSA key pair
- **HttpOnly** cookie `auth_token` with `SameSite`
- RBAC: `CENTRAL_MANAGER`, `STORE_MANAGER`, `CASHIER`

</td>
</tr>
<tr>
<td width="50%">

### 🐳 Docker Orchestration
- 3 profiles: **CENTRAL**, **BRANCH**, and **DEV**
- PostgreSQL, Javalin, and Vite in isolated containers
- Reproducible startup on any machine

</td>
<td width="50%">

### 📊 Real-Time Dashboards
- Sales KPIs, average ticket value, and volume per store
- Sales by hour, month, and category
- Inventory reports and invoice duplicates (PDF)

</td>
</tr>
<tr>
<td colspan="2">

### 🧪 Test Coverage & Documentation
- Manual test suite for Local API, Global API, and UI ([`docs/MANUAL_TEST_SCRIPT.md`](docs/MANUAL_TEST_SCRIPT.md))
- Complete production installation manual ([`docs/MANUAL_INSTALACAO.md`](docs/MANUAL_INSTALACAO.md))
- Academic report, UML diagrams, and state machines in Typst (`LI4/`)

</td>
</tr>
</table>

---

## 🏗️ Architecture

```
MACHINE A — Headquarters (192.168.1.82)       LOCAL NETWORK
┌──────────────────────────┐
│ docker-compose-          │       HTTP (demo) / HTTPS (production)
│   central.yml            │◄──────────────────────────────────┐
│                          │                                   │
│  :8081  Global API       │                                   │
│  :8080  Local API        │       MACHINE B — Store N         │
│  :5173  Frontend         │       ┌──────────────────────────┐│
│  :5432  PostgreSQL       │       │ docker-compose.yml       ││
└──────────────────────────┘       │  :8080  Local API        │┘
                                   │  :5173  Frontend          │
                                   │  :5433  PostgreSQL        │
                                   └──────────────────────────┘
                                                ▲
                                       Terminal (browser)
                                       http://<STORE_IP>:5173
```

| Layer | Technology |
|---|---|
| Backend | Java 21 · Javalin · Gradle 8.6 |
| Database | PostgreSQL 16 (UUID, *outbox pattern*) |
| Authentication | JWT **RS256** via HttpOnly cookie |
| Frontend | Vite (host `0.0.0.0`) |
| Orchestration | Docker Compose v2 |
| Documentation | Typst |

| File | Mode | When to Use |
|---|---|---|
| `docker-compose-central.yml` | **CENTRAL** | Headquarters server — Local + Global API |
| `docker-compose.yml`         | **BRANCH**  | Each store's server — Local API only |
| `docker-compose-dev.yml`     | **DEV**     | Full environment on a single machine |

---

## 🛠️ Installation

### Prerequisites

| Component | Minimum Version | Verify With |
|---|---|---|
| Docker Engine | **24.x** | `docker --version` |
| Docker Compose | **2.x** (plugin) | `docker compose version` |
| Git | **2.x** | `git --version` |

> JDK 21 and Node.js are **not** required on the host machines — Docker handles everything. They are only needed if you want to run the project outside of containers.

### Quick Start

1. **Clone the repository:**

```bash
git clone https://github.com/SirLordNelson/LI4_2526.git
cd LI4_2526
git checkout dev
```

2. **Generate RSA keys** *(one-time setup, shared across the entire network)*:

```bash
openssl genrsa -out private_key.pem 2048
openssl rsa -in private_key.pem -pubout -out public_key.pem
base64 -w 0 public_key.pem  > public_key.b64
base64 -w 0 private_key.pem > private_key.b64
```

> ⚠ **Important:** the same key pair must exist at headquarters **and** at every store — otherwise JWTs will not be mutually recognized.

3. **Configure the `.env` file:**

```bash
cp .env.example .env
# Edit and paste TAKI_JWT_PUBLIC_KEY and TAKI_JWT_PRIVATE_KEY
```

4. **Start Headquarters:**

```bash
docker compose -f docker-compose-central.yml down -v --remove-orphans
docker compose -f docker-compose-central.yml up -d --build
sleep 5
bash ./database/load_data.sh central
```

5. **Start a Store** *(repeat for each branch, `N = 1..4`)*:

In `docker-compose.yml`, adjust `TAKI_CORS_ORIGIN` to the store's frontend IP and add to `.env`:

```ini
URLS_SEDE_CSV=http://192.168.1.82:8081/api/v1
```

Then:

```bash
docker compose -f docker-compose.yml down -v --remove-orphans
docker compose -f docker-compose.yml up -d --build
sleep 5
bash ./database/load_data.sh N   # 1, 2, 3, or 4
```

> 📘 **Production deployment:** see the detailed procedure in [`docs/MANUAL_INSTALACAO.md`](docs/MANUAL_INSTALACAO.md).

---

## 🚀 Usage

### LAN Access

With headquarters at `192.168.1.82` (recorded in `lan_ip.txt`), any device on the same network can access:

| Service | URL |
|---|---|
| 🖥️  Frontend (HQ) | `http://192.168.1.82:5173` |
| 🔌 Local API       | `http://192.168.1.82:8080` |
| 🌐 Global API      | `http://192.168.1.82:8081` |

To discover the machine's current IP:

```bash
cat lan_ip.txt
# or
hostname -I | awk '{print $1}'
```

### Quick Verification

```bash
# Health-check the Global API (headquarters)
curl http://localhost:8081/health
# Expected: 200 OK

# Login as central manager
curl -c cookies.txt -s -X POST http://localhost:8081/api/global/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"dono@taki.pt","password":"admin"}' | python3 -m json.tool
```

### Firewall (Linux)

```bash
sudo ufw allow 5173/tcp   # Frontend
sudo ufw allow 8080/tcp   # Local API
sudo ufw allow 8081/tcp   # Global API
```

### Demo Credentials

| User | Email | Password | Role | Store |
|---|---|---|---|---|
| Central Manager | `dono@taki.pt`            | `admin` | `CENTRAL_MANAGER` | HQ |
| Store 1 Manager | `tiago.rocha@taki.pt`     | `admin` | `STORE_MANAGER`   | 1 |
| Store 1 Cashier | `operador1@taki.pt`       | `admin` | `CASHIER`         | 1 |
| Store 2 Manager | `sofia.alves@taki.pt`     | `admin` | `STORE_MANAGER`   | 2 |
| Store 2 Cashier | `operador2@taki.pt`       | `admin` | `CASHIER`         | 2 |
| Store 3 Manager | `carolina.jesus@taki.pt`  | `admin` | `STORE_MANAGER`   | 3 |
| Store 3 Cashier | `operador3@taki.pt`       | `admin` | `CASHIER`         | 3 |
| Store 4 Manager | `david.marques@taki.pt`   | `admin` | `STORE_MANAGER`   | 4 |
| Store 4 Cashier | `operador4@taki.pt`       | `admin` | `CASHIER`         | 4 |

---

## 📚 Documentation

| Document | Description |
|---|---|
| [`docs/MANUAL_INSTALACAO.md`](docs/MANUAL_INSTALACAO.md) | Complete installation and production deployment procedure (HQ + branches) |
| [`docs/MANUAL_TEST_SCRIPT.md`](docs/MANUAL_TEST_SCRIPT.md) | Manual test script for Local API, Global API, synchronization, and UI |
| `LI4/` | Academic report (Typst) — requirements, use cases, and diagrams |
| `seq/` · `*.puml` | UML class, sequence, and state machine diagrams (PlantUML) |
| [`AUDIT_REPORT.md`](AUDIT_REPORT.md) | Internal code and security audit report |

---

## 📂 Repository Structure

```
LI4_2526/
├── 📁 backend/                  # Javalin application (Java 21 + Gradle)
│   └── src/main/java/pt/uminho/taki/
│       ├── 📁 api/local/        # Local API routes and controllers
│       ├── 📁 api/global/       # Global API routes and controllers
│       └── 📁 ln/               # Business logic (sales, inventory, sync, …)
├── 📁 frontend/                 # Vite SPA (host 0.0.0.0)
├── 📁 database/
│   ├── 📄 schema_postgres.sql       # DDL + UUID types
│   ├── 📄 logica_ativa_postgres.sql # Triggers and procedures
│   ├── 📄 sincronizacao_postgres.sql# Outbox + sync functions
│   ├── 📄 user_roles.sql            # Profiles and permissions
│   ├── 📄 indices_postgres.sql      # Performance indexes
│   ├── 🐍 populate.py               # Generates deterministic CSVs
│   └── 📜 load_data.sh              # Loads CSVs (central|1..4)
├── 📁 docs/                     # Installation and test manuals
├── 📁 seq/                      # Sequence diagrams (PlantUML)
├── 📁 LI4/                      # Academic report (Typst)
├── 🐳 docker-compose.yml        # BRANCH mode (store)
├── 🐳 docker-compose-central.yml# CENTRAL mode (headquarters)
├── 🐳 docker-compose-dev.yml    # DEV mode (everything on one machine)
├── ⚙️  .env.example
├── 🌐 lan_ip.txt                # Current headquarters IP
├── 📄 LICENSE
└── 📄 README.md                 # This file
```

---

## 🩺 Troubleshooting

| Symptom | Likely Cause | Solution |
|---|---|---|
| `CORS error` in browser | Wrong `TAKI_CORS_ORIGIN` | Update the frontend IP in `docker-compose*.yml` and restart |
| Backend won't start | Missing JWT keys | Check `TAKI_JWT_PUBLIC_KEY` / `TAKI_JWT_PRIVATE_KEY` in `.env` |
| Database won't initialize | Port already in use | `docker compose down -v` and `ss -tlnp \| grep 5432` |
| Frontend can't reach backend | Hardcoded IP | `VITE_LOCAL_API_TARGET` should use `http://backend:8080` inside Docker |
| `401 Unauthorized` | Cookie not sent | Ensure `withCredentials: true` in the Vite proxy |
| Synchronization fails | HQ endpoint unreachable | Check `URLS_SEDE_CSV` in `.env` and network connectivity |

---

## 🎯 Skills Acquired

✅ Full-stack distributed system design  
✅ Hub-and-Spoke architecture with resilient synchronization  
✅ JWT RS256 authentication and RBAC authorization  
✅ Docker Compose multi-profile orchestration  
✅ Outbox Pattern for at-least-once message delivery  
✅ RESTful API design (Local + Global)  
✅ UML modeling and academic report writing  
✅ Production deployment and troubleshooting  

---

## 👥 Authors

**Group 17** — *Software Engineering Lab IV · Informatics Engineering · 2025/2026*

<table>
<tr>
<td align="center">
<a href="https://github.com/SirLordNelson">
<img src="https://github.com/SirLordNelson.png" width="100px;" alt="SirLordNelson"/><br />
<sub><b>SirLordNelson</b></sub>
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
<td align="center">
<a href="https://github.com/M4chad0">
<img src="https://github.com/M4chad0.png" width="100px;" alt="M4chad0"/><br />
<sub><b>M4chad0</b></sub>
</a>
</td>
<td align="center">
<a href="https://github.com/Kyuma23">
<img src="https://github.com/Kyuma23.png" width="100px;" alt="Kyuma23"/><br />
<sub><b>Kyuma23</b></sub>
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
**Course Code:** LI4  
**University of Minho** — Informatics Engineering

[⬆️ Back to Top](#-li4---software-engineering-lab-iv)

</div>
