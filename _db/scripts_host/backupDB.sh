#!/bin/bash

# BACKUP DB

YearMonth=$(date '+%Y-%m')
YearMonthDay=$(date '+%Y-%m-%d')
FileName=$(date '+%Y_%m_%d-%H_%M_%S')

db_dir="/home/silvajunior/Área de trabalho/desenvolvimento/pi6-tempguardianV2/_db"
cd "$db_dir"

mkdir -p  ./$YearMonth
cd ./$YearMonth || exit 1  # Se não conseguir acessar o diretório /$YearMonth, sai com erro

# Executa o backup do banco de dados
docker exec -i tempguardian_db bash -c 'mariadb-dump -u root -p"tX84c=7OljSX" db_tempguardian' > "/home/silvajunior/Área de trabalho/desenvolvimento/pi6-tempguardianV2/_db/$YearMonth/bkp_$FileName.sql"

# Verifica se o comando de backup foi executado com sucesso
if [ $? -eq 0 ]; then
    backup_status="Backup executado com sucesso"
else
    backup_status="Falha ao executar o backup"
fi

# LOGS 

date_hour=$(date '+%y/%m/%d %H:%M:%S')
space=" "
log_archive="/home/silvajunior/Área de trabalho/desenvolvimento/pi6-tempguardianV2/_db/scripts_host/execution_history.log"

# Logs a execução do script no arquivo de log
echo "$date_hour$space$backup_status" >> "$log_archive"