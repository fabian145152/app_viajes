<?php
header("Content-Type: application/json");

$conexion = new mysqli("localhost", "root", "belgrado", "app_viajes");

if ($conexion->connect_error) {
    echo json_encode(["res" => "ERROR", "msg" => "DB"]);
    exit;
}

$lat = $_POST['lat'] ?? null;
$lng = $_POST['lng'] ?? null;
$user_id = $_POST['user_id'] ?? null;
$device_id = $_POST['device_id'] ?? null;

if ($lat === null || $lng === null) {
    echo json_encode(["res" => "ERROR", "msg" => "Faltan datos"]);
    exit;
}

$stmt = $conexion->prepare("
    INSERT INTO ubicaciones (lat, lng, user_id, device_id)
    VALUES (?, ?, ?, ?)
");

$stmt->bind_param("ddss", $lat, $lng, $user_id, $device_id);
$stmt->execute();

echo json_encode(["res" => "OK"]);

$stmt->close();
$conexion->close();
