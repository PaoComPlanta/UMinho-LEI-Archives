
# 📚 Document Indexing System

## 📋 General Description

This project, created within the scope of the **Operating Systems** course at the University of Minho, implements a **Document Indexing System** through a **client-server architecture** developed in C. It allows users to index, search, and manage metadata of locally stored text documents. The system includes persistent storage, a custom cache mechanism, and support for concurrent operations through child processes.

Communication between the `dclient` (client) and `dserver` (server) is accomplished through **named pipes (FIFOs)**, ensuring asynchronous, isolated, and scalable interactions.

---

## 👥 Authors

- [DelgadoDevT](https://github.com/DelgadoDevT)
- [PaoComPlanta](https://github.com/PaoComPlanta)
- [TiagoBrito5](https://github.com/TiagoBrito5)

---

## ⚡ Features

### 📝 Indexing (`-a`)
Adds document metadata (title, authors, year, path) to the system. Metadata is appended or inserted in the first available free space.

```bash
./bin/dclient -a "title" "authors" "year" "path"
```

### 🔍 Metadata Query (`-c`)
Retrieves the metadata of a specific document through its key. Operation optimized by the cache system.

```bash
./bin/dclient -c "key"
```

### 🗑️ Remove Entry (`-d`)
Marks metadata as invalid and adds its position to the free space queue for future reuse.

```bash
./bin/dclient -d "key"
```

### 📊 Line Count by Keyword (`-l`)
Counts the number of lines containing a specific keyword in a document.

```bash
./bin/dclient -l "key" "keyword"
```

### 🔎 Global Search (`-s`)
Executes a parallel search across all documents using multiple processes (controlled by the user).

```bash
./bin/dclient -s "keyword" "num_processes"
```

### 🛑 Shutdown Server (`-f`)
Safely shuts down the server, persisting the current state and releasing resources.

```bash
./bin/dclient -f
```

---

## 🏗️ Architecture

- **🔌 Client-Server Communication**: through named pipes (`/tmp/serverChannel` and `/tmp/clientChannel<PID>`)
- **💾 Metadata Storage**: binary files (`metadata.bin`, `freeQueue.bin`, `identifier.bin`) ensure data persistence
- **⚙️ Concurrency**: the server manages parallel keyword searches using `fork()` and limits active processes as specified by the user
- **🚀 Cache**: in-memory cache with fixed size (defined at server startup) improves read performance, using the **Clock Algorithm** for replacement
- **♻️ Free Space Queue**: stores reusable positions in the metadata file to reduce fragmentation
- **🧹 Garbage Collector**: compacts metadata storage periodically or when limits are reached

---

## 🚀 How to Run

### 1️⃣ Compile the project
```bash
make
```

### 2️⃣ Generate documentation with Doxygen (optional)
```bash
make doc
```

### 3️⃣ Start the server
```bash
./bin/dserver dataset/ 36000
```
> **Note:** The second argument defines the cache size (optional)

### 4️⃣ Execute client commands
Use the syntax presented in the **Features** section

### 5️⃣ Shutdown the server
```bash
./bin/dclient -f
```

---

## 💾 Persistence Files

| File | Description |
|----------|-----------|
| `metadata.bin` | Stores all document metadata |
| `freeQueue.bin` | Records reusable positions in the metadata file |
| `identifier.bin` | Records the next unique ID to be assigned |

> These files are loaded at server startup and saved on shutdown.

---

## 📝 Notes

- ⚠️ The system was designed for **UNIX-based environments** (e.g., Linux)
- 📦 All binaries are located in the `bin/` folder
- 🔧 Named pipes are created in `/tmp/`

