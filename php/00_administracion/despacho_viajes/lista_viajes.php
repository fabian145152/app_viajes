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

$filtro = $_GET['estado'] ?? '';

$todosLosViajes = obtenerViajes();

/* CONTADORES */
$contadores = [
    'inmediato' => 0,
    'pendiente' => 0,
    'asignado' => 0,
    'en curso' => 0,
    'diferido' => 0,
    'completado' => 0,
    'cancelado' => 0
];

foreach ($todosLosViajes as $v) {
    $estado = strtolower(trim($v['estado']));

    if (isset($contadores[$estado])) {
        $contadores[$estado]++;
    }
}

/* FILTROS */
if ($filtro != '') {

    // Mostrar solamente el estado seleccionado
    $viajes = array_filter($todosLosViajes, function ($v) use ($filtro) {
        return strtolower(trim($v['estado'])) == strtolower(trim($filtro));
    });
} else {

    // Vista principal
    $viajes = array_filter($todosLosViajes, function ($v) {

        $estado = strtolower(trim($v['estado']));

        return in_array($estado, [
            'inmediato',
            'pendiente',
            'asignado',
            'en curso'
        ]);
    });
}

/* ORDENAMIENTO */
usort($viajes, function ($a, $b) {

    $aDif = strtolower(trim($a['estado'])) == 'diferido';
    $bDif = strtolower(trim($b['estado'])) == 'diferido';

    if ($aDif != $bDif) {
        return $aDif ? 1 : -1;
    }

    if ($aDif && $bDif) {

        $fechaA = strtotime($a['fecha'] . ' ' . $a['hora']);
        $fechaB = strtotime($b['fecha'] . ' ' . $b['hora']);

        return $fechaA <=> $fechaB;
    }

    return $b['id'] <=> $a['id'];
});



?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Listado de Viajes</title>

    <link rel="stylesheet" href="../../../css/estilos.css">
    <link rel="stylesheet" href="../../../css/listado_viajes.css">

    <style>
        /* CONTENEDOR */
        .container {
            width: 100%;
            margin: 0 auto;
        }

        /* MENU SUPERIOR */
        .menu-viajes {
            display: flex;
            gap: 10px;
            width: 100%;
            margin-bottom: 20px;
        }

        .menu-viajes a {
            flex: 1;
            text-align: center;
            padding: 5px 8px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            font-size: 13px;
        }

        .menu-viajes a:hover {
            background: #0056b3;
        }

        /* SCROLL TABLA */
        /* SCROLL SOLO SOBRE LA LISTA */
        .tabla-scroll {
            height: calc(100vh - 220px);
            overflow-y: auto;

            border-top: 1px solid #ccc;
            border-left: 1px solid #ccc;
            border-right: 1px solid #ccc;
            border-bottom: none;
        }

        /* TABLA */
        .table {
            width: 100%;
            table-layout: auto;
            border-collapse: collapse;
        }

        .table td,
        .table th {
            white-space: normal;
            word-break: break-word;
            padding: 4px 8px;
            vertical-align: top;
        }

        .table td {
            max-width: 250px;
        }

        .table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        /* HEADER FIJO */
        .table thead th {
            position: sticky;
            top: 0;
            background: #343a40;
            color: white;
            z-index: 100;
        }


        .table {
            width: 100%;
            table-layout: auto;
            border-collapse: collapse;
            font-size: 11px;
            /* antes heredaba el tamaño normal */
        }

        .table td,
        .table th {
            padding: 3px 5px;
            font-size: 11px;
            white-space: nowrap;
            /* evita saltos de línea */
        }
    </style>
</head>

<body>

    <div class="container">
        <div class="card">

            <h3>Estado de los Viajes</h3>

            <div class="menu-viajes">

                <a href="carga_viajes.php">+ Nuevo Viaje</a>

                <a href="mapa_de_viajes.php" target="_blank">Mapa</a>

                <a href="lista_viajes.php">
                    Todos (<?= count($viajes) ?>)
                </a>

                <a href="?estado=inmediato" style="background: #e2e3e5; color:#000;">
                    Inmediatos (<?= $contadores['inmediato'] ?>)
                </a>

                <a href="?estado=pendiente" style="background: #fff3cd; color:#000;">
                    Pendientes (<?= $contadores['pendiente'] ?>)
                </a>

                <a href="?estado=asignado" style="background: #d1ecf1; color:#000;">
                    Asignados (<?= $contadores['asignado'] ?>)
                </a>

                <a href="?estado=en curso" style="background: #d4edda; color:#000;">
                    En curso (<?= $contadores['en curso'] ?>)
                </a>

                <a href="?estado=diferido" style="background: #e2d6c3; color:#000;">
                    Diferidos (<?= $contadores['diferido'] ?>)
                </a>

                <a href="?estado=completado" style="background: #d6e9ff; color:#000;">
                    Completados (<?= $contadores['completado'] ?>)
                </a>

                <a href="?estado=cancelado" style="background: #f8d7da; color:#000;">
                    Cancelados (<?= $contadores['cancelado'] ?>)
                </a>

            </div>

            <div class="tabla-scroll">
                <table class="table">
                    <thead>
                        <tr>
                            <th>N° viaje</th>
                            <th>Pasajero</th>
                            <th>Celular</th>
                            <th>Origen</th>
                            <th>Destino</th>
                            <th>Obs operador</th>
                            <th>Obs chofer</th>
                            <th>Estado</th>
                            <th>Fecha</th>
                            <th>Hora</th>
                            <th>Cat</th>
                            <th>Gps.</th>
                            <th>C/C</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>

                    <tbody>
                        <?php foreach ($viajes as $v): ?>
                            <?php
                            $fondo = '#ffffff';

                            switch (strtolower(trim($v['estado']))) {
                                case 'inmediato':
                                    $fondo = '#e2e3e5'; // gris claro
                                    break;

                                case 'pendiente':
                                    $fondo = '#fff3cd'; // amarillo claro
                                    break;

                                case 'asignado':
                                    $fondo = '#d1ecf1'; // celeste claro
                                    break;

                                case 'en curso':
                                    $fondo = '#d4edda'; // verde claro
                                    break;

                                case 'diferido':
                                    $fondo = '#e2d6c3'; // marrón claro
                                    break;

                                case 'completado':
                                    $fondo = '#d6e9ff'; // azul claro
                                    break;

                                case 'cancelado':
                                    $fondo = '#f8d7da'; // rojo claro
                                    break;
                            }


                            ?>

                            <tr style="background-color: <?= $fondo ?>;">

                                <td><?= $v['id'] ?></td>

                                <td><?= $v['nombre_pasaj'] ?></td>
                                <td><?= $v['cel_pasaj'] ?></td>


                                <td><?= $v['direccion_origen'] ?></td>
                                <td><?= $v['direccion_destino'] ?></td>

                                <td><?= $v['obs_operador'] ?></td>
                                <td><?= $v['obs_pasaj'] ?></td>

                                <!-- TIPO -->
                                <!-- 
                                <td>
                                    <?= (empty($v['fecha']) || $v['fecha'] === '0000-00-00')
                                        ? 'Inmediato'
                                        : 'Diferido' ?>
                                </td>
                                -->
                                <td>
                                    <?php
                                    $color = '#000';

                                    switch (strtolower(trim($v['estado']))) {

                                        case 'inmediato':
                                            $color = '#6c757d';
                                            break;
                                        case 'pendiente':
                                            $color = '#ffc107';
                                            break;

                                        case 'asignado':
                                            $color = '#17a2b8';
                                            break;

                                        case 'en curso':
                                            $color = '#28a745';
                                            break;

                                        case 'diferido':
                                            $color = '#8b7355';
                                            break;

                                        case 'completado':
                                            $color = '#007bff';
                                            break;

                                        case 'cancelado':
                                            $color = '#dc3545';
                                            break;
                                    }
                                    ?>

                                    <span style="font-weight:bold;color:<?= $color ?>;">
                                        <?= $v['estado'] ?>
                                    </span>
                                </td>

                                <!-- FECHA -->
                                <td>
                                    <?= ($v['fecha'] === '0000-00-00' && empty($v['hora']))
                                        ? ''
                                        : $v['fecha'] ?>
                                </td>

                                <!-- HORA -->
                                <td>
                                    <?= ($v['fecha'] === '0000-00-00' && empty($v['hora']))
                                        ? ''
                                        : $v['hora'] ?>
                                </td>

                                <!-- CATEGORIA -->
                                <td>
                                    <?= $v['categoria_movil'] ?>
                                </td>


                                <td style="text-align:center;">
                                    <?php
                                    $gps_ok =
                                        ($v['origen_lat'] < 0) &&
                                        ($v['origen_lng'] < 0); // &&                                 
                                    ?>

                                    <!-- TILDES GPS -->
                                    <?php if ($gps_ok): ?>
                                        <span style="color:green;font-size:20px;">✔</span>
                                    <?php else: ?>
                                        <span style="color:red;font-size:20px;">✘</span>
                                    <?php endif; ?>
                                </td>

                                <!-- C/C -->
                                <td><?= htmlspecialchars($v['empresa'] ?: 'VIAJE DE CALLE') ?></td>
                                <td>
                                    <a href=" carga_viajes.php?editar=<?= $v['id'] ?>">Editar</a> |
                                    <a href="?borrar=<?= $v['id'] ?>" onclick="return confirm('¿Eliminar?')">Borrar</a>
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