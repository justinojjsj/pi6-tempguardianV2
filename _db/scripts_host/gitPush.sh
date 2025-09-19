#!/bin/bash

# Caminho base do projeto
db_dir="/home/silvajunior/Área de trabalho/desenvolvimento/pi6-tempguardianV2"
cd "$db_dir" || { echo "Erro: não foi possível acessar o diretório $db_dir"; exit 1; }

# Nome do commit com data/hora
FileName=$(date '+%Y_%m_%d-%H_%M_%S')

# Git: atualiza e tenta o push
git checkout updateDB
git add --all
git commit -m "Atualização do banco $FileName"

# Verifica se o push foi bem-sucedido
if git push; then
    push_status="Push executado com sucesso"
else
    push_status="Falha ao executar o push"
fi

# Registro em log
date_hour=$(date '+%y/%m/%d %H:%M:%S')
log_archive="$db_dir/_db/scripts_host/execution_history.log"
echo "$date_hour $push_status" >> "$log_archive"