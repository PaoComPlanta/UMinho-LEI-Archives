#!/bin/bash

# Exercício 1
echo "Texto de Lisboa" > lisboa.txt
echo "Texto do Porto" > porto.txt
echo "Texto de Braga" > braga.txt

# Exercício 2
ls -l lisboa.txt

# Exercício 3
chmod 666 lisboa.txt

# Exercício 4
chmod u=rx,u-w porto.txt 

# Exercício 5
chmod 400 braga.txt

# Exercício 6
mkdir -p dir1 dir2
ls -ld dir1 dir2

# Exercício 7
chmod go-x dir2
ls -ld dir2