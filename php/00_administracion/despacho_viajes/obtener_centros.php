<?php
require_once "../../../funciones/funciones.php";
protegerPagina([0, 3]);

header('Content-Type: application/json; charset=utf-8');

if (isset($_GET['id_empresa']) && $_GET['id_empresa'] !== '') {
    // SE QUITA EL (int) por si es un string/CUIT. PDO lo parametriza de forma segura.
    $id_empresa = $_GET['id_empresa']; 

    try {
        $pdo = conexion(); 
        
        $sql = "SELECT id, centro_de_costo, nombre 
                FROM centros_costo 
                WHERE id_empresa = ? 
                ORDER BY nombre";

        $stmt = $pdo->prepare($sql);
        $stmt->execute([$id_empresa]);
        
        // Forzamos FETCH_ASSOC para que JSON no duplique índices numéricos
        $centros = $stmt->fetchAll(PDO::FETCH_ASSOC); 

        echo json_encode($centros);
    } catch (PDOException $e) {
        echo json_encode(["error" => "Error en la consulta", "detalle" => $e->getMessage()]);
    }
    exit;
}