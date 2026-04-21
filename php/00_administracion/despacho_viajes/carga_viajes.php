<?php
include_once "../../../funciones/funciones.php";
protegerPagina([0, 3]);

if (isset($_POST['guardar'])) {
    guardarViaje($_POST);
    header("Location: lista_viajes.php");
    exit;
}

$viaje = null;
if (isset($_GET['editar'])) {
    $viaje = obtenerViajePorId((int)$_GET['editar']);
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>NUEVOS VIAJES</title>
    <link rel="stylesheet" href="../../../css/estilos.css">
    <link rel="stylesheet" href="../../../css/listado_viajes.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="listado_viajes.js" defer></script>

    <style>
        /* GRID PRINCIPAL */
        .form-2cols {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        /* COLUMNAS */
        .form-2cols .col {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        /* FILA COMPLETA (botones abajo) */
        .form-full {
            grid-column: 1 / 3;
            margin-top: 10px;
        }

        /* INPUTS MÁS LIMPIOS */
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        /* RESPONSIVE (IMPORTANTE) */
        @media (max-width: 768px) {
            .form-2cols {
                grid-template-columns: 1fr;
            }

            .form-full {
                grid-column: 1;
            }
        }

        /* BOTON TARIFA (forzado) */
        .btn-tarifa {
            background-color: #ffc107 !important;
            color: #000 !important;
            font-weight: bold;
        }

        /* opcional: hover */
        .btn-tarifa:hover {
            background-color: #e0a800 !important;
        }
    </style>
</head>

<body>

    <div class="container">
        <div class="card">

            <h3><?= $viaje ? "Editar Viaje" : "Nuevo Viaje"; ?></h3>

            <form method="POST" class="form-2cols">

                <input type="hidden" name="id" value="<?= $viaje['id'] ?? '' ?>">


                <!-- COLUMNA IZQUIERDA -->
                <div class="col">

                    <div class="form-group">
                        <label>Celular</label>
                        <input type="number" name="cel_pasaj" value="<?= $viaje['cel_pasaj'] ?? '' ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Nombre</label>
                        <input type="text" name="nombre_pasaj" value="<?= $viaje['nombre_pasaj'] ?? '' ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Observaciones Operador</label>
                        <textarea name="obs_operador" rows="3"><?= $viaje['obs_operador'] ?? '' ?></textarea>
                    </div>

                    <div class="form-group">
                        <label>Observaciones Pasajero</label>
                        <textarea name="obs_pasaj" rows="3"><?= $viaje['obs_pasaj'] ?? '' ?></textarea>
                    </div>

                </div>

                <!-- COLUMNA DERECHA -->
                <div class="col">


                    <div class="form-group">
                        <label>Origen</label>

                        <div class="input-mapa">
                            <input type="text" id="dir_origen" name="direccion_origen"
                                onkeyup="autocomplete(this)">

                            <button type="button" class="btn-map btn-origen"
                                onclick="verMapa('dir_origen')">
                                📍ORIGEN
                            </button>
                        </div>

                        <div id="dir_origen_list" class="autocomplete-box"></div>

                        <input type="hidden" name="origen_lat" id="dir_origen_lat">
                        <input type="hidden" name="origen_lng" id="dir_origen_lng">
                    </div>

                    <div class="form-group">
                        <label>Destino</label>

                        <input type="text" id="dir_destino" name="direccion_destino" onkeyup="autocomplete(this)">

                        <div id="dir_destino_list" class="autocomplete-box"></div>

                        <input type="hidden" name="destino_lat" id="dir_destino_lat">
                        <input type="hidden" name="destino_lng" id="dir_destino_lng">

                        <div style="display:flex; gap:5px;">
                            <button type="button" class="btn-map btn-destino"
                                onclick="verMapa('dir_destino')">🟢 DESTINO</button>

                            <button type="button" class="btn-map btn-recorrido"
                                onclick="verRecorrido(
                        document.getElementById('dir_origen').value,
                        document.getElementById('dir_destino').value
                    )">➡️ RECORRIDO</button>
                        </div>
                    </div>



                    <div class="form-group">
                        <label>Tipo</label>
                        <select name="diferido" id="diferido">
                            <option value="No">Inmediato</option>
                            <option value="Si">Diferido</option>
                        </select>
                    </div>

                    <div id="campos_diferido">
                        <input type="date" name="fecha">
                        <input type="time" name="hora">
                    </div>

                    <div class="form-group">
                        <label>Categoría</label>
                        <select name="categoria_movil" id="categoria_movil">
                            <option value="">ELIJA CATEGORÍA</option>
                            <option value="REMIS">REMIS</option>
                            <option value="TAXI">TAXI</option>
                        </select>
                    </div>

                    <div id="bloque_tarifa" style="display:flex; gap:10px; align-items:center; margin-top:10px;">

                        <button type="button"
                            class="btn-map btn-tarifa"
                            style="min-width:200px;"
                            onclick="calcularTarifa()">
                            💲 CALCULAR VIAJE
                        </button>

                        <input type="text"
                            id="tarifa_resultado"
                            placeholder="Importe $"
                            readonly
                            style="flex:1;">

                    </div>
                    
                </div>

                <!-- FILA COMPLETA -->
                <div class="form-full">
                    <button type="submit" name="guardar">Guardar</button>
                    <a href="lista_viajes.php">Volver al listado</a>
                </div>

            </form>

        </div>
    </div>

    <!-- MODAL MAPA -->
    <div id="mapModal" style="display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:#000000aa;">
        <div style="width:80%;height:80%;margin:5% auto;background:white;">
            <button onclick="cerrarMapa()">Cerrar</button>
            <div id="map" style="width:100%;height:90%;"></div>
        </div>
    </div>

</body>

</html>