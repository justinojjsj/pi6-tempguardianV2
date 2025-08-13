<html>
<?php
date_default_timezone_set('America/Sao_Paulo'); // Define o fuso horário
include 'conexao.php'; // Inclui a conexão com o banco de dados

// Arrays para armazenar os dados do gráfico
$labels = [];
$temperatures = [];
$humidities = [];

if ($conn) {
    $sql = "SELECT * FROM weather_history ORDER BY date DESC, hour DESC LIMIT 10";
    $result = mysqli_query($conn, $sql);

    if ($result && mysqli_num_rows($result) > 0) {
        while ($row = mysqli_fetch_assoc($result)) {
            $labels[] = $row["date"] . " " . $row["hour"];
            $temperatures[] = $row["temperature"];
            $humidities[] = $row["humidity"];
        }
    }
}
?>

<head>
    <?php include "./header.php"; ?>
    <script>
        // Atualiza a página a cada 5 minutos
        setTimeout(function() {
            window.location.reload();
        }, 300000);

        // Dados para o gráfico
        const labels = <?php echo json_encode(array_reverse($labels)); ?>;
        const temperatures = <?php echo json_encode(array_reverse($temperatures)); ?>;
        const humidities = <?php echo json_encode(array_reverse($humidities)); ?>;

        window.onload = function() {
            const ctx = document.getElementById('tempHumidityChart').getContext('2d');
            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: 'Temperatura (°C)',
                            data: temperatures,
                            borderColor: 'rgba(255, 99, 132, 1)',
                            backgroundColor: 'rgba(255, 99, 132, 0.2)',
                            fill: false,
                            tension: 0.3
                        },
                        {
                            label: 'Umidade (%)',
                            data: humidities,
                            borderColor: 'rgba(54, 162, 235, 1)',
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            fill: false,
                            tension: 0.3
                        }
                    ]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Valores'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Data e Hora'
                            }
                        }
                    }
                }
            });
        };
    </script>
</head>

<body>
    <!-- Cabeçalho -->
    <header class="bg-primary text-white text-center py-4">
        <h1 class="display-4">TempGuardian</h1>
        <p class="lead">Monitoramento de Temperatura e Umidade em Tempo Real</p>
    </header>

    <!-- Conteúdo Principal -->
    <div class="container mt-5">
        <!-- Seção do Gráfico -->
        <section class="mb-5">
            <h2 class="text-center mb-4">Gráfico de Temperatura e Umidade</h2>
            <div class="card shadow-sm">
                <div class="card-body">
                    <canvas id="tempHumidityChart" height="100"></canvas>
                </div>
            </div>
        </section>

        <!-- Seção da Tabela -->
        <section>
            <h2 class="text-center mb-4">Registros de Temperatura e Umidade</h2>
            <p class="text-center text-muted">Última atualização: <?php echo date('d/m/Y H:i:s'); ?></p>
            <?php
            if (!$conn) {
                echo "<div class='alert alert-danger text-center' role='alert'>Erro ao conectar ao banco de dados.</div>";
                exit;
            }

            $sql = "SELECT * FROM weather_history ORDER BY date DESC, hour DESC LIMIT 10";
            $result = mysqli_query($conn, $sql);

            if ($result && mysqli_num_rows($result) > 0) {
                echo "<div class='table-responsive'>";
                echo "<table class='table table-striped table-hover table-bordered'>";
                echo "<thead class='table-dark'><tr><th>ID</th><th>Temperatura (°C)</th><th>Umidade (%)</th><th>Data</th><th>Hora</th></tr></thead>";
                echo "<tbody>";
                while ($row = mysqli_fetch_assoc($result)) {
                    echo "<tr>";
                    echo "<td>" . $row["id"] . "</td>";
                    echo "<td data-value='" . $row["temperature"] . "'>" . $row["temperature"] . "</td>";
                    echo "<td data-value='" . $row["humidity"] . "'>" . $row["humidity"] . "</td>";
                    echo "<td>" . $row["date"] . "</td>";
                    echo "<td>" . $row["hour"] . "</td>";
                    echo "</tr>";
                }
                echo "</tbody>";
                echo "</table>";
                echo "</div>";
            } else {
                echo "<div class='alert alert-warning text-center' role='alert'>Nenhum registro de temperatura encontrado.</div>";
            }

            mysqli_close($conn);
            ?>
        </section>
    </div>

    <!-- Rodapé -->
    <footer class="bg-light text-center py-3 mt-5">
        <p class="text-muted mb-0">&copy; <?php echo date('Y'); ?> TempGuardian. Todos os direitos reservados.</p>
    </footer>

    <!-- Bootstrap JS (para funcionalidades como tooltips, se necessário) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>