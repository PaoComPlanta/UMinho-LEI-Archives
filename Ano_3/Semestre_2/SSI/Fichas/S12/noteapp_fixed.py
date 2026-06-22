#!/usr/bin/env python3

import os
import re
import sqlite3

DB_FILE = "notes.db"

# Regex simples para validar nomes de ficheiros seguros
SAFE_NAME = re.compile(r'^[\w.\-]+$')


def init_db():
    conn = sqlite3.connect(DB_FILE)
    conn.execute(
        "CREATE TABLE IF NOT EXISTS notes "
        "(id INTEGER PRIMARY KEY, title TEXT, body TEXT)"
    )
    conn.execute(
        "INSERT OR IGNORE INTO notes (id, title, body) VALUES "
        "(1, 'Welcome', 'This is your first note.'), "
        "(2, 'Reminder', 'Submit the SSI lab report on time.'), "
        "(3, 'Secret', 'The admin password is hunter2.')"
    )
    conn.commit()
    conn.close()


def search_notes(query):
    conn = sqlite3.connect(DB_FILE)
    # Uso de placeholders para evitar SQL injection
    sql = "SELECT id, title, body FROM notes WHERE title LIKE ?"
    search_term = f"%{query}%"
    
    cursor = conn.execute(sql, (search_term,))
    results = cursor.fetchall()
    
    if results:
        for row in results:
            print(f"  [{row[0]}] {row[1]}: {row[2]}")
    else:
        print("  Nenhuma nota encontrada.")
    
    conn.close()


def export_note(note_id):
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.execute("SELECT title, body FROM notes WHERE id = ?", (note_id,))
    row = cursor.fetchone()
    conn.close()

    if not row:
        print("  Nota não encontrada.")
        return

    filename = input("  Nome do ficheiro para exportar: ").strip()

    if not SAFE_NAME.match(filename):
        print("  Aviso: O nome do ficheiro é inválido. Use apenas letras, números, pontos ou traços.")
        return

    content = f"Title: {row[0]}\nBody: {row[1]}\n"
    
    with open(filename, "w", encoding="utf-8") as f:
        f.write(content)
    
    print(f"  Nota exportada com sucesso para {filename}")


def main():
    init_db()
    while True:
        print("\n=== App de Notas (Segura) ===")
        print("1. Procurar notas")
        print("2. Exportar nota")
        print("3. Sair")
        
        choice = input("Escolha: ").strip()

        if choice == "1":
            query = input("  Termo de pesquisa: ")
            search_notes(query)
        elif choice == "2":
            try:
                note_id = int(input("  ID da nota: "))
                export_note(note_id)
            except ValueError:
                print("  ID inválido.")
        elif choice == "3":
            break
        else:
            print("  Opção inválida.")


if __name__ == "__main__":
    main()
