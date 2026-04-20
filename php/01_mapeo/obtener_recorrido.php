<?php

/**
 * LECTOR DE RECORRIDO - POSTGRESQL + POSTGIS
 * Ubicación sugerida: C:\xampp\htdocs\app_viajes\obtener_recorrido.php
 */

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// 1. Configuración de conexión
$host = "localhost";
$db   = "app_viajes";
$user = "postgres";
$pass = "belgrado";
$port = "5432";

try {
    $pdo = new PDO("pgsql:host=$host;port=$port;dbname=$db", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // 2. Obtener el ID del usuario desde la URL (si existe)
    // Ejemplo: obtener_recorrido.php?usuario_id=Chofer_01
    $usuario_id = isset($_GET['usuario_id']) ? $_GET['usuario_id'] : null;

    // 3. Si no se especificó un usuario, buscamos quién fue el último en moverte
    if (!$usuario_id) {
        $stmt_last = $pdo->query("SELECT usuario_id FROM ubicaciones ORDER BY fecha_registro DESC LIMIT 1");
        $last_user = $stmt_last->fetch(PDO::FETCH_ASSOC);
        $usuario_id = $last_user ? $last_user['usuario_id'] : null;
    }

    // 4. Si no hay ningún usuario en la base de datos, devolvemos array vacío
    if (!$usuario_id) {
        echo json_encode([]);
        exit;
    }

    // 5. Consulta para obtener el historial de coordenadas del usuario
    // ST_Y es Latitud, ST_X es Longitud. Convertimos de Geography a Geometry para extraerlas.
    $sql = "SELECT 
                ST_Y(posicion::geometry) as lat, 
                ST_X(posicion::geometry) as lng, 
                status, 
                fecha_registro 
            FROM ubicaciones 
            WHERE usuario_id = :usr
            ORDER BY fecha_registro ASC";

    $stmt = $pdo->prepare($sql);
    $stmt->execute(['usr' => $usuario_id]);

    // Obtenemos todos los puntos
    $puntos = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // 6. Formatear la salida: asegurar que lat y lng sean números (float) para el mapa
    $resultado = [];
    foreach ($puntos as $punto) {
        $resultado[] = [
            "lat"            => (float)$punto['lat'],
            "lng"            => (float)$punto['lng'],
            "status"         => $punto['status'],
            "fecha_registro" => $punto['fecha_registro'],
            "usuario_id"     => $usuario_id
        ];
    }

    echo json_encode($resultado);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        "res" => "error",
        "mensaje" => "Error de base de datos: " . $e->getMessage()
    ]);
}
