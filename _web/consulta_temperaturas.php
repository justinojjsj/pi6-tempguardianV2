<?php
include 'conexao.php'; // Arquivo que faz a conexão com o banco

$sql = "SELECT * FROM weather_history ORDER BY id DESC"; // Busca todos os registros em ordem decrescente
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<h2>Registros de Temperatura e Umidade</h2>";
    echo "<table border='1'>
            <tr>
                <th>ID</th>
                <th>Temperatura (°C)</th>
                <th>Umidade (%)</th>
                <th>Data</th>
                <th>Hora</th>
            </tr>";
    while ($row = $result->fetch_assoc()) {
        echo "<tr>
                <td>{$row['id']}</td>
                <td>{$row['temperature']}°C</td>
                <td>{$row['humidity']}%</td>
                <td>{$row['date']}</td>
                <td>{$row['hour']}</td>
              </tr>";
    }
    echo "</table>";
} else {
    echo "Nenhum registro encontrado.";
}

$conn->close();
?>
