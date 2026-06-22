#!/usr/bin/env python3

import re

# Mesmo padrão usado na aplicação segura
SAFE_NAME = re.compile(r'^[\w.\-]+$')

if __name__ == "__main__":
    casos_teste = [
        "note.txt",
        "minha-nota.txt",
        "note.txt; cat /etc/passwd",
        "note.txt; id; whoami",
        "`ls -la`",
        "../../../etc/shadow",
    ]
    
    print("--- Teste de Validação de Nomes de Ficheiro ---")
    for nome in casos_teste:
        resultado = "PERMITIDO" if SAFE_NAME.match(nome) else "BLOQUEADO"
        print(f"  [{resultado}]  {nome!r}")
