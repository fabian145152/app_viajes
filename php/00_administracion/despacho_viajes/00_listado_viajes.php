<?php
include_once "../../../funciones/funciones.php";
protegerPagina([0, 3]);

// ACCIONES
if (isset($_POST['guardar'])) {
    // Es recomendable validar los datos antes de enviar a la función
    guardarViaje($_POST);
    header("Location: listado_viajes.php");
    exit;
}

if (isset($_GET['borrar'])) {
    // Forzamos a que sea un entero para evitar inyecciones
    borrarViaje((int)$_GET['borrar']);
    header("Location: listado_viajes.php");
    exit;
}

$viaje = null;
if (isset($_GET['editar'])) {
    $viaje = obtenerViajePorId((int)$_GET['editar']);
}

$viajes = obtenerViajes();
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Despacho de Viajes</title>
    <link rel="stylesheet" href="../../../css/estilos.css">
</head>

<body>
    <div class="container">

        <div class="card operadores-layout">
            <div class="col-form">
                <h3><?= $viaje ? "Editar Despacho" : "Nuevo Viaje"; ?></h3>
                <form method="POST">
                    <input type="hidden" name="id" value="<?= $viaje['id'] ?? ''; ?>">

                    <div class="form-group">
                        <label>Celular Pasajero:</label>
                        <input type="number" name="cel_pasaj" placeholder="Ej: 1122334455" value="<?= htmlspecialchars($viaje['cel_pasaj'] ?? ''); ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Nombre Pasajero:</label>
                        <input type="text" name="nombre_pasaj" placeholder="Nombre completo" value="<?= htmlspecialchars($viaje['nombre_pasaj'] ?? ''); ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Dirección Origen:</label>
                        <input type="text" name="direccion_origen" placeholder="Calle y altura" value="<?= htmlspecialchars($viaje['direccion_origen'] ?? ''); ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Dirección Destino:</label>
                        <input type="text" name="direccion_destino" placeholder="Calle y altura" value="<?= htmlspecialchars($viaje['direccion_destino'] ?? ''); ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Observaciones Operador:</label>
                        <textarea name="obs_operador" placeholder="Notas internas"><?= htmlspecialchars($viaje['obs_operador'] ?? ''); ?></textarea>
                    </div>

                    <div class="form-group">
                        <label>Observaciones Pasajero:</label>
                        <textarea name="obs_pasaj" placeholder="Notas para el chofer"><?= htmlspecialchars($viaje['obs_pasaj'] ?? ''); ?></textarea>
                    </div>

                    <div class="form-group">
                        <label>Tipo de Viaje:</label>
                        <select name="diferido">
                            <option value="No" <?= (isset($viaje['diferido']) && $viaje['diferido'] == 'No') ? 'selected' : ''; ?>>Inmediato</option>
                            <option value="Si" <?= (isset($viaje['diferido']) && $viaje['diferido'] == 'Si') ? 'selected' : ''; ?>>Diferido / Programado</option>
                        </select>
                    </div>


                    <div class="form-group">
                        <label>Categoria de Móvil</label>
                        <select name="categoria_movil">
                            <option value="REMIS" <?= (isset($viaje['categoria_movil']) && $viaje['categoria_movil'] == 'REMIS') ? 'selected' : ''; ?>>Remis</option>
                            <option value="TAXI" <?= (isset($viaje['categoria_movil']) && $viaje['categoria_movil'] == 'TAXI') ? 'selected' : ''; ?>>Taxi</option>
                        </select>
                    </div>


                    <div class="actions" style="margin-top: 20px;">
                        <button type="submit" name="guardar" class="btn btn-success">
                            <?= $viaje ? "Actualizar Viaje" : "Despachar Viaje"; ?>
                        </button>
                        <a href="../../inicio_0.php" class="btn btn-danger">SALIR</a>
                    </div>
                </form>
            </div>

            <div class="col-tabla">
                <h3>Listado de Viajes Activos</h3>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Pasajero</th>
                            <th>Origen</th>
                            <th>Destino</th>
                            <th>Categoría</th>
                            <th>Tipo</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (empty($viajes)): ?>
                            <tr>
                                <td colspan="6" class="text-center">No hay viajes registrados.</td>
                            </tr>
                        <?php else: ?>
                            <?php foreach ($viajes as $v): ?>
                                <tr style="<?= $v['diferido'] === 'Si' ? 'background-color: #d4edda;' : ''; ?>">
                                    <td><?= $v['id']; ?></td>
                                    <td>
                                        <strong><?= htmlspecialchars($v['nombre_pasaj']); ?></strong><br>
                                        <small><?= htmlspecialchars($v['cel_pasaj']); ?></small>
                                    </td>
                                    <td><?= htmlspecialchars($v['direccion_origen']); ?></td>
                                    <td><?= htmlspecialchars($v['direccion_destino']); ?></td>
                                    <td><?= htmlspecialchars($v['categoria_movil']); ?></td>
                                    <td><?= htmlspecialchars($v['diferido']); ?></td>
                                    <td>
                                        <a href="?editar=<?= $v['id']; ?>" class="btn btn-warning btn-sm">Editar</a>
                                        <a href="?borrar=<?= $v['id']; ?>" class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de que deseas eliminar este viaje?')">Borrar</a>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>

</html>