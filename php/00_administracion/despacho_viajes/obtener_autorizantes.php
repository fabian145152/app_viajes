<?php
require_once "../../../funciones/funciones.php";
protegerPagina([0, 3]);

header('Content-Type: application/json; charset=utf-8');

if (isset($_GET['id_cc']) && $_GET['id_cc'] !== '') {
    $id_cc = $_GET['id_cc'];
    $id_empresa = $_GET['id_empresa'] ?? null; // Recibimos la empresa opcional/cruzada

    try {
        $pdo = conexion();

        // Si viene la empresa, la sumamos al WHERE para garantizar que pertenezca a ese ecosistema
        if ($id_empresa) {
            $sql = "SELECT id, nombre, celular 
                    FROM autorizantes 
                    WHERE id_cc = ? AND id_empresa = ? AND estado = 1 
                    ORDER BY nombre";
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$id_cc, $id_empresa]);
        } else {
            $sql = "SELECT id, nombre, celular 
                    FROM autorizantes 
                    WHERE id_cc = ? AND estado = 1 
                    ORDER BY nombre";
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$id_cc]);
        }

        $autorizantes = $stmt->fetchAll(PDO::FETCH_ASSOC);

        echo json_encode($autorizantes);
    } catch (PDOException $e) {
        echo json_encode(["error" => "Error en la consulta", "detalle" => $e->getMessage()]);
    }
    exit;
}