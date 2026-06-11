<?php
include_once "../../../funciones/funciones.php";

$id_empresa = (int)($_GET['id_empresa'] ?? 0);

$pdo = conexion();

$sql = "
    SELECT id,
           centro_de_costo,
           nombre
    FROM centro_costos
    WHERE id_empresa = ?
    ORDER BY nombre
";

$stmt = $pdo->prepare($sql);
$stmt->execute([$id_empresa]);

header('Content-Type: application/json');
echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
