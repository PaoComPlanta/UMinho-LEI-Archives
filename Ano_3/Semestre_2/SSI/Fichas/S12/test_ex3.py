#!/usr/bin/env python3

import sqlite3

DB_FILE = "notes.db"

def search_notes_fixed(query):
    conn = sqlite3.connect(DB_FILE)
    sql = "SELECT id, title, body FROM notes WHERE title LIKE ?"
    param = f"%{query}%"
    
    try:
        cursor = conn.execute(sql, (param,))
        results = cursor.fetchall()
        if results:
            for row in results:
                print(f"  [{row[0]}] {row[1]}: {row[2]}")
        else:
            print("  Nenhuma nota encontrada.")
    except sqlite3.Error as e:
        print(f"  Erro: {e}")
    conn.close()

if __name__ == "__main__":
    payloads = [
        ("Normal",    "Welcome"),
        ("Tentativa 1", "' OR '1'='1"),
        ("Tentativa 2", "' UNION SELECT 1, sql, '' FROM sqlite_master --"),
        ("Tentativa 3", "' UNION SELECT 1, title, body FROM notes --"),
    ]
    for label, p in payloads:
        print(f"\n--- Validação {label}: {p!r} ---")
        search_notes_fixed(p)
