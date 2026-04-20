<?php
include_once "../funciones/funciones.php";


protegerPagina([0]); // ya valida todo

$id = $_SESSION['id_usuario'];

$sql = "SELECT * FROM usuarios WHERE id = :id LIMIT 1";
$pdo = conexion();
$stmt = $pdo->prepare($sql);
$stmt->bindParam(':id', $id, PDO::PARAM_INT);
$stmt->execute();
$row = $stmt->fetch(PDO::FETCH_ASSOC);

$nombre_completo = $row['nom_apellido'] ?? '';
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <h1>Inicio Superusuario</h1>
    <p>Bienvenido <?php echo $nombre_completo; ?></p>

    <ul>
        <li><a href="00_administracion/menu_admin.php">ADMINISTRACION</a></li>
        <li><a href="00_administracion/trafico/listado.php">TRAFICO</a></li>
        <li><a href="00_administracion/choferes/listado_choferes.php">CHOFERES</a></li>
        <li><a href="00_administracion/cuentas_empresas/listado_empresas.php">CUENTAS CORRIENTES EMPRESAS</a></li>
        <li><a href="00_administracion/autorizantes/listado_autorizantes.php">AUTORIZANTES</a></li>
        <li><a href="00_administracion/despacho_viajes/listado_viajes.php" target="_blank">CARGA DE VIAJES</a></li>
        <li><a href="00_administracion/viajes_cursados/estado_viajes.php">VIAJES EN CURSO</a></li>

        <li></li>
        <li><a href="01_mapeo/ver_mapa.html" target="_blank">MAPEO</a></li>
        <li><a href="01_mapeo/recibir.php" target="_blank">RECIBIR</a></li>
        <li><a href="01_mapeo/obtener_recorrido.php" target="_blank">RECORRIDO</a></li>
        <li></li>
        <li><a href="logout.php">SALIR</a></li>
        <li></li>
    </ul>
</body>

</html>