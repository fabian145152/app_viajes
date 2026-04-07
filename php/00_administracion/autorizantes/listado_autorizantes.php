<?php
include_once "../../../funciones/funciones.php";

protegerPagina([0, 3]);

// GUARDAR
if (isset($_POST['guardar'])) {
    guardarAutorizante($_POST);
    header("Location: listado_autorizantes.php");
    exit;
}

// BORRAR
if (isset($_GET['borrar'])) {
    borrarAutorizante($_GET['borrar']);
    header("Location: listado_autorizantes.php");
    exit;
}

// EDITAR
$aut = null;
if (isset($_GET['editar'])) {
    $aut = obtenerAutorizantePorId($_GET['editar']);
}

// DATOS
$autorizantes = obtenerAutorizantes();
$empresas = obtenerEmpresas();
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Autorizantes</title>
    <link rel="stylesheet" href="../../../css/estilos.css">
</head>

<body>

    <div class="container">
        <h2 class="text-center">Gestión de Autorizantes</h2>

        <div class="card operadores-layout">

            <!-- FORM -->
            <div class="col-form">
                <h3><?php echo $aut ? "Editar Autorizante" : "Nuevo Autorizante"; ?></h3>

                <form method="POST">

                    <input type="hidden" name="id" value="<?php echo $aut['id'] ?? ''; ?>">

                    <input type="text" name="nombre" placeholder="Nombre"
                        value="<?php echo $aut['nombre'] ?? ''; ?>" required>

                    <input type="text" name="apellido" placeholder="Apellido"
                        value="<?php echo $aut['apellido'] ?? ''; ?>" required>

                    <input type="number" name="cel" placeholder="Celular"
                        value="<?php echo $aut['cel'] ?? ''; ?>">

                    <input type="email" name="email" placeholder="Email"
                        value="<?php echo $aut['email'] ?? ''; ?>">

                    <!-- EMPRESA -->
                    <label>Empresa:</label>
                    <select name="id_empresa" required>

                        <option value="">Seleccionar empresa</option>

                        <?php foreach ($empresas as $e): ?>
                            <option value="<?php echo $e['id']; ?>"
                                <?php if (($aut['id_empresa'] ?? '') == $e['id']) echo 'selected'; ?>>
                                <?php echo htmlspecialchars($e['razon_social']); ?>
                            </option>
                        <?php endforeach; ?>

                    </select>

                    <button type="submit" name="guardar" class="btn btn-success">
                        <?php echo $aut ? "Actualizar" : "Crear Autorizante"; ?>
                    </button>

                    <?php if ($aut): ?>
                        <a href="listado_autorizantes.php" class="btn btn-gray">Cancelar</a>
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
                            <th>Apellido</th>
                            <th>Nombre</th>
                            <th>Empresa</th>
                            <th>Celular</th>
                            <th>Email</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>

                    <tbody>
                        <?php foreach ($autorizantes as $a): ?>
                            <tr>
                                <td><?php echo $a['id']; ?></td>
                                <td><?php echo htmlspecialchars($a['apellido']); ?></td>
                                <td><?php echo htmlspecialchars($a['nombre']); ?></td>
                                <td><?php echo htmlspecialchars($a['razon_social']); ?></td>
                                <td><?php echo $a['cel'] ?? '-'; ?></td>
                                <td><?php echo $a['email'] ?? '-'; ?></td>

                                <td>
                                    <a href="?editar=<?php echo $a['id']; ?>" class="btn btn-warning">Editar</a>

                                    <a href="?borrar=<?php echo $a['id']; ?>"
                                        class="btn btn-danger"
                                        onclick="return confirm('¿Eliminar autorizante?')">
                                        Borrar
                                    </a>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>

                </table>
            </div>

        </div>
    </div>

</body>

</html>