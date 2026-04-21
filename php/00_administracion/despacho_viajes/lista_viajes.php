<?php
include_once "../../../funciones/funciones.php";
protegerPagina([0, 3]);

// BORRAR
if (isset($_GET['borrar'])) {
    borrarViaje((int)$_GET['borrar']);
    header("Location: lista_viajes.php");
    exit;
}

$viajes = obtenerViajes();
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Listado de Viajes</title>

    <link rel="stylesheet" href="../../../css/estilos.css">
    <link rel="stylesheet" href="../../../css/listado_viajes.css">
</head>

<body>

    <div class="container">
        <div class="card">

            <h3>Viajes</h3>

            <a href="carga_viajes.php">+ Nuevo Viaje</a>

            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Pasajero</th>
                        <th>Origen</th>
                        <th>Destino</th>
                        <th>Tipo</th>
                        <th>Fecha</th>
                        <th>Hora</th>
                        <th>Acciones</th>
                    </tr>
                </thead>

                <tbody>
                    <?php foreach ($viajes as $v): ?>
                        <tr style="<?= $v['diferido'] == "Si" ? 'background:#d4edda;' : '' ?>">

                            <td><?= $v['id'] ?></td>

                            <td>
                                <?= $v['nombre_pasaj'] ?><br>
                                <small><?= $v['cel_pasaj'] ?></small>
                            </td>

                            <td><?= $v['direccion_origen'] ?></td>
                            <td><?= $v['direccion_destino'] ?></td>

                            <td><?= $v['diferido'] ?></td>
                            <td><?= $v['fecha'] ?></td>
                            <td><?= $v['hora'] ?></td>

                            <td>
                                <a href="carga_viajes.php?editar=<?= $v['id'] ?>">Editar</a>
                                <a href="?borrar=<?= $v['id'] ?>" onclick="return confirm('¿Eliminar?')">Borrar</a>
                            </td>

                        </tr>
                    <?php endforeach; ?>
                </tbody>

            </table>

        </div>
    </div>

</body>

</html>