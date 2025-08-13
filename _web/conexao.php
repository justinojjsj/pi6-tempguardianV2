<?php
$host = 'container_tempguardian_db'; // Nome do serviço do MySQL no docker-compose.yml
$usuario = 'root';
$senha = 'tX84c=7OljSX';
$banco = 'db_tempguardian';

// estabelecer a conexão
$conn = mysqli_connect($host, $usuario, $senha, $banco);

// Verifica se houve erro na conexão
if (!$conn) {
    die("Falha na Conexão: (" . mysqli_connect_errno() . ") " . mysqli_connect_error());
}

?>