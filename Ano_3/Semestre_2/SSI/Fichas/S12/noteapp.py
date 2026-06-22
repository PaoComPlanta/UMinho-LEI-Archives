#!/usr/bin/env python3
"""A deliberately vulnerable note-taking application."""

import os
import sqlite3
import sys

DB_FILE = "notes.db"


def init_db():
    """Create the notes table if it does not exist."""
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
        print(f"  Erro na pesquisa: {e}")
    conn.close()


def export_note(note_id):
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.execute(
        "SELECT title, body FROM notes WHERE id = ?", (note_id,)
    )
    row = cursor.fetchone()
    conn.close()

    if row is None:
        print("  Nota não encontrada.")
        return

    filename = input("  Nome do ficheiro para exportar: ")
    cmd = f"echo 'Title: {row[0]}\nBody: {row[1]}' > {filename}"
    os.system(cmd)
    print(f"  Nota exportada para {filename}")


def main():
    init_db()
    while True:
        print("\n=== Note App ===")
        print("1. Search notes")
        print("2. Export note")
        print("3. Quit")
        choice = input("Choice: ").strip()

        if choice == "1":
            query = input("  Search query: ")
            search_notes(query)
        elif choice == "2":
            try:
                note_id = int(input("  Note ID: "))
            except ValueError:
                print("  Invalid ID.")
                continue
            export_note(note_id)
        elif choice == "3":
            break
        else:
            print("  Invalid choice.")


if __name__ == "__main__":
    main()
