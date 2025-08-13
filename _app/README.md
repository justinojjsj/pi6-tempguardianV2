# TempGuardian

## INFORMAÇÕES IMPORTANTES (FUNCIONA APENAS EM SISTEMA OPERACIONAL LINUX)

O arquivo dockerfile-python e docker-entrypoint estão configurados para que quando os containers forem ativados façam os seguintes procedimentos:

1. Colocar o crontab em execução
2. Executar o script crontab_scheduler.sh que definirá os horários que devem ser executados os scripts

Por sua vez, o arquivo crontab_scheduler.sh irá executar o script_executor.sh nas horas programadas.