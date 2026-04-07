<?php
include_once "../../../funciones/funciones.php";

protegerPagina([0, 3]);

// GUARDAR
if (isset($_POST['guardar'])) {
    guardarEmpresa($_POST);
    header("Location: listado_empresas.php");
    exit;
}

// BORRAR
if (isset($_GET['borrar'])) {
    borrarEmpresa($_GET['borrar']);
    header("Location: listado_empresas.php");
    exit;
}

// EDITAR
$empresa = null;
if (isset($_GET['editar'])) {
    $empresa = obtenerEmpresaPorId($_GET['editar']);
}

// DATOS
$empresas = obtenerEmpresas();
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Empresas</title>
    <link rel="stylesheet" href="../../../css/estilos.css">
</head>

<body>

    <div class="container">
        <h2 class="text-center">Gestión de Cuentas Corrientes de empresas</h2>

        <div class="card operadores-layout">

            <!-- FORM -->
            <div class="col-form">
                <h3><?php echo $empresa ? "Editar Empresa" : "Nueva Empresa"; ?></h3>

                <form method="POST">

                    <input type="hidden" name="id" value="<?php echo $empresa['id'] ?? ''; ?>">

                    <input type="text" name="razon_social" placeholder="Razón Social"
                        value="<?php echo $empresa['razon_social'] ?? ''; ?>" required>

                    <input type="text" name="dir" placeholder="Dirección"
                        value="<?php echo $empresa['dir'] ?? ''; ?>">

                    <input type="number" name="cuit" placeholder="CUIT"
                        value="<?php echo $empresa['cuit'] ?? ''; ?>">

                    <input type="number" name="inc_brutos" placeholder="Ingresos Brutos"
                        value="<?php echo $empresa['inc_brutos'] ?? ''; ?>">

                    <input type="number" name="cel_1" placeholder="Celular 1"
                        value="<?php echo $empresa['cel_1'] ?? ''; ?>">

                    <input type="number" name="cel_2" placeholder="Celular 2"
                        value="<?php echo $empresa['cel_2'] ?? ''; ?>">

                    <input type="text" name="cel_3" placeholder="Celular 3"
                        value="<?php echo $empresa['cel_3'] ?? ''; ?>">

                    <input type="text" name="contacto_1" placeholder="Contacto 1"
                        value="<?php echo $empresa['contacto_1'] ?? ''; ?>">

                    <input type="text" name="contacto_2" placeholder="Contacto 2"
                        value="<?php echo $empresa['contacto_2'] ?? ''; ?>">

                    <input type="text" name="contacto_3" placeholder="Contacto 3"
                        value="<?php echo $empresa['contacto_3'] ?? ''; ?>">

                    <input type="number" name="numero_cuenta" placeholder="Número de Cuenta"
                        value="<?php echo $empresa['numero_cuenta'] ?? ''; ?>">

                    <button type="submit" name="guardar" class="btn btn-success">
                        <?php echo $empresa ? "Actualizar" : "Crear Empresa"; ?>
                    </button>

                    <?php if ($empresa): ?>
                        <a href="listado_empresas.php" class="btn btn-gray">Cancelar</a>
                    <?php endif; ?>

                    <a href="../../inicio_0.php" class="btn btn-danger">SALIR</a>

                </form>
            </div>

            <!-- TABLA -->
            <div class="col-tabla">
                <table class="table">
                    <thead>
                        <tr>
                            <th>C/C</th>
                            <th>Razón Social</th>
                            <th>Contacto</th>
                            <th>Celular</th>
                            <th>Direccion</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>

                    <tbody>
                        <?php foreach ($empresas as $e): ?>
                            <tr>
                                <?php $e['id']; ?>
                                <td><?php echo $e['numero_cuenta']; ?></td>
                                <td><?php echo htmlspecialchars($e['razon_social']); ?></td>
                                

                                <td>
                                    <?php echo $e['contacto_1'] ?? '-'; ?>
                                </td>
                                
                                <td>
                                    <?php echo $e['cel_1'] ?? '-'; ?>
                                </td>

                                <td>
                                    <?php echo $e['dir'] ?? '-'; ?>
                                </td>

                                <td>
                                    <a href="?editar=<?php echo $e['id']; ?>" class="btn btn-warning">Editar</a>

                                    <a href="?borrar=<?php echo $e['id']; ?>"
                                        class="btn btn-danger"
                                        onclick="return confirm('¿Eliminar empresa?')">
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