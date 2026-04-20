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

// DATOS BASE
$empresas = obtenerEmpresas();
$autorizantes = obtenerAutorizantes();

// LÓGICA DE FILTRO POR EMPRESA
$filtro_empresa = $_GET['filtro_empresa'] ?? '';

if (!empty($filtro_empresa)) {
    $autorizantes_filtrados = [];
    foreach ($autorizantes as $a) {
        if ($a['id_empresa'] == $filtro_empresa) {
            $autorizantes_filtrados[] = $a;
        }
    }
    $autorizantes = $autorizantes_filtrados;
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Autorizantes</title>
    <link rel="stylesheet" href="../../../css/estilos.css">
    <style>
        /* Estilos para el filtro en una sola línea */
        .filtro-box-horizontal {
            background: #fff;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-inline {
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
            gap: 15px;
            flex-wrap: nowrap;
        }

        .form-inline label {
            margin: 0;
            white-space: nowrap;
            font-size: 16px;
        }

        .form-inline select {
            padding: 8px;
            min-width: 250px;
            border-radius: 5px;
            border: 1px solid #ccc;
            cursor: pointer;
        }

        .btn-inline {
            margin: 0 !important;
            padding: 8px 15px;
            text-decoration: none;
            font-size: 14px;
            display: inline-block;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2 class="text-center">Gestión de Autorizantes</h2>

        <div class="filtro-box-horizontal">
            <form method="GET" class="form-inline">
                <label><strong>Filtrar por Empresa:</strong></label>

                <select name="filtro_empresa" onchange="this.form.submit()">
                    <option value="">-- Ver todos los autorizantes --</option>
                    <?php foreach ($empresas as $e): ?>
                        <option value="<?php echo $e['id']; ?>"
                            <?php echo ($filtro_empresa == $e['id']) ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($e['razon_social']); ?>
                        </option>
                    <?php endforeach; ?>
                </select>

                <?php if (!empty($filtro_empresa)): ?>
                    <a href="listado_autorizantes.php" class="btn btn-gray btn-inline">
                        Limpiar Filtro
                    </a>
                <?php endif; ?>
            </form>
        </div>

        <div class="card operadores-layout">

            <div class="col-form">
                <h3><?php echo $aut ? "Editar Autorizante" : "Nuevo Autorizante"; ?></h3>
                <form method="POST">
                    <input type="hidden" name="id" value="<?php echo $aut['id'] ?? ''; ?>">

                    <input type="text" name="nombre" placeholder="Nombre" value="<?php echo $aut['nombre'] ?? ''; ?>" required>
                    <input type="text" name="apellido" placeholder="Apellido" value="<?php echo $aut['apellido'] ?? ''; ?>" required>
                    <input type="number" name="cel" placeholder="Celular" value="<?php echo $aut['cel'] ?? ''; ?>">
                    <input type="email" name="email" placeholder="Email" value="<?php echo $aut['email'] ?? ''; ?>">

                    <label>Empresa a la que pertenece:</label>
                    <select name="id_empresa" required>
                        <option value="">Seleccionar empresa...</option>
                        <?php foreach ($empresas as $e): ?>
                            <option value="<?php echo $e['id']; ?>"
                                <?php echo (isset($aut['id_empresa']) && $aut['id_empresa'] == $e['id']) ? 'selected' : ''; ?>>
                                <?php echo htmlspecialchars($e['razon_social']); ?>
                            </option>
                        <?php endforeach; ?>
                    </select>

                    <button type="submit" name="guardar" class="btn btn-success">
                        <?php echo $aut ? "Actualizar" : "Crear Autorizante"; ?>
                    </button>

                    <div style="margin-top: 10px;">
                        <a href="../../inicio_0.php" class="btn btn-danger">SALIR</a>
                        <?php if ($aut): ?>
                            <a href="listado_autorizantes.php" class="btn btn-gray">Cancelar</a>
                        <?php endif; ?>
                    </div>
                </form>
            </div>

            <div class="col-tabla">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Empresa</th>
                            <th>Apellido y Nombre</th>
                            <th>Celular</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (count($autorizantes) > 0): ?>
                            <?php foreach ($autorizantes as $a): ?>
                                <tr>
                                    <td><strong><?php echo htmlspecialchars($a['razon_social']); ?></strong></td>
                                    <td><?php echo htmlspecialchars($a['apellido'] . ", " . $a['nombre']); ?></td>
                                    <td><?php echo $a['cel'] ?? '-'; ?></td>
                                    <td>
                                        <a href="?editar=<?php echo $a['id']; ?>" class="btn btn-warning">Editar</a>
                                        <a href="?borrar=<?php echo $a['id']; ?>" class="btn btn-danger" onclick="return confirm('¿Borrar autorizante?')">Borrar</a>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="4" class="text-center">No se encontraron autorizantes.</td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>

</html>