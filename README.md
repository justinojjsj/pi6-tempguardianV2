# TempGuardianV2

## JUSTIFICATIVA DO SISTEMA

O sistema tem a função de capturar os dados de temperatura e umidade de um sensor IOT, enviar via rede cabeada UTP para ser armazenada em banco de dados. Os dados armazenados são consumidos pelo ESP32 que desligará os equipamentos e notificará o administrador caso a temperatura ultrapasse o limite inferior (congelamento) ou superior (superaquecimento). Por fim, os dados armazenados serão utilizados para gerar relatórios via interface web com a finalidade de gerir eficientemente a energia. 

Dessa forma, o nome TempGuardian refere-se ao guardião de temperatura, função do sistema. A segunda versão adiciona o ESP32 que automatizará a gestão dos equipamentos, sem a necessidade de intervenção humana (adicionando IOT também no final do processo). Além disso, essa segunda versão adicionará relatórios mais detalhados que contribuirá para tomada de decisão.

## COMO CONFIGURAR OS SISTEMAS

Para funcionar os sistemas é necessário:

1. Instalar o docker:
    -  Sistema Operacional Windows:
        - Instalar o docker desktop (como administrador);
        - Fazer login do docker hub e conectar ao docker desktop;
        - **IMPORTANTE**: Reiniciar a máquina quando estiver tudo ok, antes de seguir para os próximos passos.
    - Sistema Operacional Linux: Apenas instalar o docker.

2. Fazer um clone no repositório https://github.com/justinojjsj/pi5-tempguardian.git
    * *Observação: Por favor, antes de dar um push, crie sua branch, não dê push diretamente na main* 
    
3. Criar a rede docker que será compartilhada entre os sistemas:
    ```
    docker network create --subnet=168.18.0.0/16 rede_default
    ```
4. Executar os containers docker. Existem duas formas:
    - Método 1: 
        - Utilizando o power shell (windows) ou terminal (linux) acessar o diretório onde está salvo o arquivo docker-compose.yaml
        - Digitar o seguinte comando: 
        ```
        docker-compose up -d
        ```
    - Método 2:
        - Instalar o VSCODE
        - Instalar o plugin docker
        - Abrir o projeto pi5-tempguardian no VSCODE
        - Encontrar o arquivo docker-compose.yaml
        - Clicar com o botão direito no arquivo e clicar em [compose-up]

    - Observação: Em sistema operacional Rwindows (rsrs), deve entrar no arquivo docker-entrypoint.sh e converter o final de linha de CRLF para LF (usando o VSCODE no canto inferior direito da janela). Após essa conversão, dê o docker-compose up -d para rodar o container python corretamente.

5. Após estar com os containers em execução acessar o PhpmyAdmin através do navegador (usuário: root senha: tX84c=7OljSX):
    ```
    127.0.0.1:4089 
    ```

    ```
    root
    ```
    
    ```
    tX84c=7OljSX
    ```
    - Criar um banco de dados com o nome: db_tempguardian
    - Importar arquivo db_DDMMYYYY.sql (mais recente) que está na pasta _db

6. Acessar o site do sistema:
    ```
    127.0.0.1:4087
    ```

*Passos necessários somente se for executar os scripts (shell e python)* 

7. Executar os containers e configurar o cron (esse passo não é necessário, a não ser que o sistema não esteja sendo alimentado automaticamente):
    ```
    docker exec -it tempguardian_python bash
    ```
    ```
    crontab -e
    ```
    - Selecionar opção 1 (vai selecionar o editor de texto NANO)
    - Copiar a seguinte linha ao final do arquivo (remova o espaço antes e depois)
    ```
    0,15,30,45 * * * * /app/script_executor.sh
    ```
    - Ctrl+o para salvar arquivo, Ctrol+x para sair do arquivo:
    - Digitar no terminal
    ```
    chmod u+x /app/script_executor.sh

8. Observações:

    - A versão do python que está sendo instalada no container é a 3.7.5. Portanto, caso queira executar o script diretamente da sua máquina instale essa versão (ou utilize um ambiente python com essa versão pelo pyenv: https://blog.accurate.com.br/tutorial-pyenv/#Habilitando_o_ambiente_virtual_LinuxMacOs)

    - Caso não queira ou possa instalar o python, utilize o próprio container para executar o script:

    ```
    docker exec -it tempguardian_python bash
    ```

    - Em seguida execute:

    ```
    python capture_temperature.py
    ```

9. Backup do banco de dados:

    - É executado um backup do banco de dados todos os dias às 23:55 e disponibilizado na pasta _db/ANO-MÊS
    - Os dados mais recentes estarão nos backups mais atuais (verificar a data)
    - Será dado um push na branch db_e_log-atualizados todos os dias às 23:59
    - O script que executa o backup está no .gitignore
