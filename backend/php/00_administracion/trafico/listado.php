<?php
include_once "../../../funciones/funciones.php";

protegerPagina([0, 3]);

// GUARDAR
if (isset($_POST['guardar'])) {
    guardarVehiculo($_POST);
    header("Location: listado.php");
    exit;
}

// BORRAR
if (isset($_GET['borrar'])) {
    borrarVehiculo($_GET['borrar']);
    header("Location: listado.php");
    exit;
}

// EDITAR
$vehiculo_a_editar = null;
if (isset($_GET['editar'])) {
    $vehiculo_a_editar = obtenerVehiculoPorId($_GET['editar']);
}

// DATOS
$vehiculos = obtenerVehiculos();
$choferes  = obtenerChoferes();
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Vehículos</title>
    <link rel="stylesheet" href="../../../css/estilos.css">
</head>

<body>

    <div class="container">
        <h2 class="text-center">Gestión de Vehículos</h2>

        <div class="card operadores-layout">

            <!-- FORM -->
            <div class="col-form">
                <h3><?php echo $vehiculo_a_editar ? "Editar Vehículo" : "Nuevo Vehículo"; ?></h3>

                <form method="POST">

                    <input type="hidden" name="id" value="<?php echo $vehiculo_a_editar['id'] ?? ''; ?>">

                    <input type="text" name="marca" placeholder="Marca"
                        value="<?php echo $vehiculo_a_editar['marca'] ?? ''; ?>" required>

                    <input type="text" name="modelo" placeholder="Modelo"
                        value="<?php echo $vehiculo_a_editar['modelo'] ?? ''; ?>">

                    <input type="text" name="patente" placeholder="Patente"
                        value="<?php echo $vehiculo_a_editar['patente'] ?? ''; ?>">

                    <input type="text" name="color" placeholder="Color"
                        value="<?php echo $vehiculo_a_editar['color'] ?? ''; ?>">

                    <label>Estado:</label>
                    <select name="estado">
                        <option value="disponible"
                            <?php if (($vehiculo_a_editar['estado'] ?? '') == 'disponible') echo 'selected'; ?>>
                            Disponible
                        </option>
                        <option value="ocupado"
                            <?php if (($vehiculo_a_editar['estado'] ?? '') == 'ocupado') echo 'selected'; ?>>
                            Ocupado
                        </option>
                    </select>

                    <label>Chofer:</label>
                    <select name="id_chofer">
                        <option value="">Sin asignar</option>

                        <?php foreach ($choferes as $c): ?>
                            <option value="<?php echo $c['id']; ?>"
                                <?php if (($vehiculo_a_editar['id_chofer'] ?? '') == $c['id']) echo 'selected'; ?>>
                                <?php echo htmlspecialchars($c['apellido'] . ' ' . $c['nombre']); ?>
                            </option>
                        <?php endforeach; ?>
                    </select>

                    <button type="submit" name="guardar" class="btn btn-success">
                        <?php echo $vehiculo_a_editar ? "Actualizar" : "Crear Vehículo"; ?>
                    </button>

                    <?php if ($vehiculo_a_editar): ?>
                        <a href="listado.php" class="btn btn-gray">Cancelar</a>
                    <?php endif; ?>

                    <a href="../../inicio_0.php" class="btn btn-danger">SALIR</a>

                </form>
            </div>

            <!-- TABLA -->
            <div class="col-tabla">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Marca</th>
                            <th>Modelo</th>
                            <th>Patente</th>
                            <th>Color</th>
                            <th>Estado</th>
                            <th>Chofer</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>

                    <tbody>
                        <?php if (count($vehiculos) > 0): ?>
                            <?php foreach ($vehiculos as $v): ?>
                                <tr>
                                    <td><?php echo $v['id']; ?></td>
                                    <td><?php echo htmlspecialchars($v['marca']); ?></td>
                                    <td><?php echo htmlspecialchars($v['modelo']); ?></td>
                                    <td><?php echo htmlspecialchars($v['patente']); ?></td>
                                    <td><?php echo htmlspecialchars($v['color']); ?></td>

                                    <td>
                                        <?php if ($v['estado'] == 'disponible'): ?>
                                            <span class="badge badge-success">Disponible</span>
                                        <?php else: ?>
                                            <span class="badge badge-danger">Ocupado</span>
                                        <?php endif; ?>
                                    </td>

                                    <td>
                                        <?php echo $v['chofer'] ?? 'Sin asignar'; ?>
                                    </td>

                                    <td>
                                        <a href="?editar=<?php echo $v['id']; ?>" class="btn btn-warning">Editar</a>

                                        <a href="?borrar=<?php echo $v['id']; ?>"
                                            class="btn btn-danger"
                                            onclick="return confirm('¿Eliminar vehículo?')">
                                            Borrar
                                        </a>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="8">No hay vehículos.</td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>

        </div>
    </div>

</body>

</html>