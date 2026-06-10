<?php
/*
include_once "../../../funciones/funciones.php";

$id_cc = (int)($_GET['id_cc'] ?? 0);

$pdo = conexion();

$sql = "SELECT id, nombre
        FROM autorizantes_cc
        WHERE id_cc = ?
        ORDER BY nombre";

$stmt = $pdo->prepare($sql);
$stmt->execute([$id_cc]);

header('Content-Type: application/json');

echo json_encode(
    $stmt->fetchAll(PDO::FETCH_ASSOC)
);

*/

include_once "../../../funciones/funciones.php";

$id_cc = (int)($_GET['id_cc'] ?? 0);

$pdo = conexion();

$sql = "SELECT id, nombre, celular
        FROM autorizantes_cc
        WHERE id_cc = ?
        ORDER BY nombre";

$stmt = $pdo->prepare($sql);
$stmt->execute([$id_cc]);

header('Content-Type: application/json');

echo json_encode(
    $stmt->fetchAll(PDO::FETCH_ASSOC)
);
