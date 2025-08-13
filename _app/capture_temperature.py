import requests
from datetime import datetime
import time
import mysql.connector

# URL do serviço que retorna os dados em JSON

# Capturar do servidor oficial
url = 'http://172.16.248.9/status.json'

# Conexão com o banco de dados MySQL
def connect_to_database():
    return mysql.connector.connect(
        host="168.18.0.3",       
        user="root",    
        password="tX84c=7OljSX",  
        database="db_tempguardian",
    )

# Função para inserir os dados na tabela WeatherHistory
def insert_data(temperature, humidity, current_date, current_time):
    try:
        connection = connect_to_database()
        cursor = connection.cursor()
        
        # Definindo a consulta SQL para inserção
        insert_query = """
        INSERT INTO weather_history (temperature, humidity, date, hour)
        VALUES (%s, %s, %s, %s)
        """
        
        # Dados a serem inseridos
        data = (temperature, humidity, current_date, current_time)
        
        # Executando a consulta
        cursor.execute(insert_query, data)
        
        # Confirmando a inserção no banco
        connection.commit()
        print("Dados inseridos com sucesso!")
        
    except mysql.connector.Error as err:
        print(f"Erro ao inserir dados no banco de dados: {err}")
    finally:
        cursor.close()
        connection.close()

for _ in range(5):  # Tentar até 5 vezes
    try:
        response = requests.get(url, timeout=10)
        break  # Sair do loop se a requisição for bem-sucedida
    except requests.exceptions.RequestException as e:
        print(f"Falha na requisição: {e}, tentando novamente...")
        time.sleep(5)  # Esperar antes de tentar novamente

if response.status_code == 200:
    data = response.json()  # Parse a resposta JSON
    
    # Obtendo a data e hora atuais formatadas
    current_datetime = datetime.now()
    current_date = current_datetime.strftime("%Y-%m-%d")  # Formato: YYYY-MM-DD
    current_time = current_datetime.strftime("%H:%M:%S")  # Formato: HH:MM:SS
    
    # Exibindo os dados
    print("Date:", current_date)
    print("Hour:", current_time)
    print("Temperature:", data['temp'])
    print("Humidity:", data['umid'])
    
    """ Campos da tabela:
    
    CREATE TABLE WeatherHistory (
    id INT(11) NOT NULL AUTO_INCREMENT,
    temperature DOUBLE(5,2),
    humidity DOUBLE(5,2),
    date DATE NULL,
    hour TIME NULL,
    PRIMARY KEY (id)
    );
    """
    # Inserir os dados no banco de dados
    insert_data(data['temp'], data['umid'], current_date, current_time)
    
else:
    print("Falha ao recuperar os dados. Código de status HTTP:", response.status_code)
