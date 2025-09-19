#!/usr/bin/env bash

# Inicia o cron em segundo plano
/etc/init.d/cron start

# Atribui permissões de execução nos scripts
chmod u+x /app/scripts/crontab_scheduler.sh
chmod u+x /app/scripts/script_executor.sh

# Executa o script
/app/scripts/crontab_scheduler.sh

exec "$@"