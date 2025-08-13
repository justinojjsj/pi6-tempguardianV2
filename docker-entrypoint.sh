#!/usr/bin/env bash

# Inicia o cron em segundo plano
/etc/init.d/cron start

# Atribui permissões de execução nos scripts
chmod u+x /app/crontab_scheduler.sh
chmod u+x /app/script_executor.sh

# Executa o script
/app/crontab_scheduler.sh

exec "$@"