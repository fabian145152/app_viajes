<?php
include_once "../../../funciones/funciones.php";

protegerPagina([0, 3]);

$id_empresa = (int)($_GET['id_empresa'] ?? 0);


if (!$id_empresa) {
    die("Empresa no válida");
}

$empresa = obtenerEmpresaPorId($id_empresa);

if (isset($_POST['guardar'])) {
    guardarCentroCosto($_POST);

    header("Location: centro_de_costos.php?id_empresa=" . $id_empresa);
    exit;
}

if (isset($_GET['borrar'])) {
    borrarCentroCosto($_GET['borrar']);

    header("Location: centro_de_costos.php?id_empresa=" . $id_empresa);
    exit;
}

$editar = null;

if (isset($_GET['editar'])) {
    $editar = obtenerCentroCostoPorId($_GET['editar']);
}

$centros = obtenerCentrosCostoPorEmpresa($id_empresa);
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <title>Centros de Costos</title>
    <link rel="stylesheet" href="../../../css/estilos.css">
</head>

<body>

    <div class="container">

        <h2>
            Empresa:
            <?= $empresa['razon_social'] ?>
        </h2>

        <div class="card operadores-layout">

            <div class="col-form">

                <h3>
                    <?= $editar ? 'Editar Centro' : 'Nuevo Centro' ?>
                </h3>

                <form method="POST">

                    <input type="hidden" name="id"
                        value="<?= $editar['id'] ?? '' ?>">

                    <input type="hidden" name="id_empresa"
                        value="<?= $id_empresa ?>">

                    <input
                        type="text"
                        name="nombre"
                        placeholder="Nombre del Centro de Costo"
                        required
                        value="<?= $editar['nombre'] ?? '' ?>">

                    <textarea
                        name="obs"
                        placeholder="Observaciones"><?= $editar['obs'] ?? '' ?></textarea>

                    <button
                        type="submit"
                        name="guardar"
                        class="btn btn-success">
                        Guardar
                    </button>

                    <a href="listado_empresas.php"
                        class="btn btn-danger">
                        Volver
                    </a>

                </form>

            </div>

            <div class="col-tabla">

                <table class="table">

                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Empresa</th>
                            <th>Código</th>
                            <th>Nombre</th>
                            <th>Observaciones</th>
                            <th>Acciones</th>
                            <th>Autorizantes</th>
                        </tr>
                    </thead>

                    <tbody>

                        <?php foreach ($centros as $c): ?>

                            <tr>

                                <td><?= $c['id'] ?></td>

                                <td><?= htmlspecialchars($c['razon_social']) ?></td>

                                <td><?= $c['centro_de_costo'] ?></td>
                                <td><?= htmlspecialchars($c['nombre']) ?></td>

                                <!--                            <td><?= $c['centro_de_costo'] ?></td> -->

                                <td><?= $c['obs'] ?></td>

                                <td>

                                    <a
                                        href="?id_empresa=<?= $id_empresa ?>&editar=<?= $c['id'] ?>"
                                        class="btn btn-warning">
                                        Editar
                                    </a>

                                    <a
                                        href="?id_empresa=<?= $id_empresa ?>&borrar=<?= $c['id'] ?>"
                                        class="btn btn-danger"
                                        onclick="return confirm('¿Eliminar?')">
                                        Borrar
                                    </a>

                                </td>

                                <td>

                                    <a
                                        href="autorizantes_cc.php?id_empresa=<?= $id_empresa ?>&id_cc=<?= $c['id'] ?>"
                                        class="btn btn-success">
                                        Autorizantes
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