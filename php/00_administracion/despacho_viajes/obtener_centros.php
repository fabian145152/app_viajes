<?php
include_once "../../../funciones/funciones.php";

$id_empresa = (int)($_GET['id_empresa'] ?? 0);

$pdo = conexion();

$sql = "SELECT id, nombre
        FROM centros_costo
        WHERE id_empresa = ?
        ORDER BY nombre";

$stmt = $pdo->prepare($sql);
$stmt->execute([$id_empresa]);

echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
