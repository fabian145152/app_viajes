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

$empresas = obtenerEmpresas();
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>NUEVOS VIAJES - EFECTIVO</title>
    <link rel="stylesheet" href="../../../css/estilos.css">
    <link rel="stylesheet" href="../../../css/listado_viajes.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="../../../css/carga_viajes.css">
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="listado_viajes.js" defer></script>

    <script>
        function formatearCelular(cel) {
            cel = cel.toString().replace(/\D/g, '');
            if (cel.length === 10) {
                return cel.substring(0, 2) + '-' +
                    cel.substring(2, 6) + '-' +
                    cel.substring(6);
            }
            return cel;
        }

        document.addEventListener("DOMContentLoaded", function() {
            const diferido = document.getElementById("diferido");
            const fecha = document.getElementById("fecha");
            const hora = document.getElementById("hora");

            // TRUE cuando estoy editando
            const editando = <?= isset($viaje['id']) ? 'true' : 'false' ?>;

            function fechaActual() {
                const ahora = new Date();
                const yyyy = ahora.getFullYear();
                const mm = String(ahora.getMonth() + 1).padStart(2, '0');
                const dd = String(ahora.getDate()).padStart(2, '0');
                const hh = String(ahora.getHours()).padStart(2, '0');
                const mi = String(ahora.getMinutes()).padStart(2, '0');

                fecha.value = `${yyyy}-${mm}-${dd}`;
                hora.value = `${hh}:${mi}`;
            }

            function actualizarFechaHora() {
                if (diferido.value === "No") {
                    if (!editando) {
                        fechaActual();
                    }
                    fecha.readOnly = true;
                    hora.readOnly = true;
                } else {
                    fecha.readOnly = false;
                    hora.readOnly = false;
                    if (!editando) {
                        fecha.value = "";
                        hora.value = "";
                    }
                }
            }

            diferido.addEventListener("change", function() {
                if (this.value === "No") {
                    fechaActual();
                    fecha.readOnly = true;
                    hora.readOnly = true;
                } else {
                    fecha.value = "";
                    hora.value = "";
                    fecha.readOnly = false;
                    hora.readOnly = false;
                }
            });

            actualizarFechaHora();
        });
    </script>
</head>

<body>

    <div class="container">
        <div class="card">

            <h3><?= $viaje ? "Editar Viaje Efectivo" : "Nuevo Viaje Efectivo"; ?></h3>

            <div style="text-align:left; margin-bottom:15px;">
                <a href="carga_viajes.php" class="btn btn-primary" style="margin-right:10px;">
                    Viaje Cuenta Corriente
                </a>
                <a href="carga_viajes.php" class="btn btn-warning">
                    Viaje de Cuenta
                </a>
            </div>

            <form method="POST" class="form-2cols">
                <input type="hidden" name="id" value="<?= $viaje['id'] ?? '' ?>">
                <input type="hidden" name="cc" value="0">

                <div class="col">

                    <div class="form-group">
                        <label>Nombre del Pasajero</label>
                        <input type="text" name="nombre_pasaj" value="<?= htmlspecialchars($viaje['nombre_pasaj'] ?? '') ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Celular</label>
                        <input type="text" name="cel_pasaj" value="<?= htmlspecialchars($viaje['cel_pasaj'] ?? '') ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Observaciones Operador</label>
                        <textarea name="obs_operador" rows="3"><?= $viaje['obs_operador'] ?? '' ?></textarea>
                    </div>

                    <div class="form-group">
                        <label>Observaciones Pasajero, datos del viaje</label>
                        <textarea name="obs_pasaj" rows="3"><?= $viaje['obs_pasaj'] ?? '' ?></textarea>
                    </div>

                </div>

                <div class="col">

                    <div class="form-group">
                        <label>Estado</label>
                        <select name="estado" id="estado" required>
                            <option value="Pendiente" <?= (($viaje['estado'] ?? 'Pendiente') == 'Pendiente') ? 'selected' : '' ?>>Pendiente</option>
                            <option value="Inmediato" <?= (($viaje['estado'] ?? '') == 'Inmediato') ? 'selected' : '' ?>>Inmediato</option>
                            <option value="Asignado" <?= (($viaje['estado'] ?? '') == 'Asignado') ? 'selected' : '' ?>>Asignado</option>
                            <option value="En Curso" <?= (($viaje['estado'] ?? '') == 'En Curso') ? 'selected' : '' ?>>En Curso</option>
                            <option value="Diferido" <?= (($viaje['estado'] ?? '') == 'Diferido') ? 'selected' : '' ?>>Diferido</option>
                            <option value="Completado" <?= (($viaje['estado'] ?? '') == 'Completado') ? 'selected' : '' ?>>Completado</option>
                            <option value="Cancelado" <?= (($viaje['estado'] ?? '') == 'Cancelado') ? 'selected' : '' ?>>Cancelado</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>¿Es Diferido?</label>
                        <select name="diferido" id="diferido" required>
                            <option value="No" <?= (($viaje['diferido'] ?? 'No') == 'No') ? 'selected' : '' ?>>No (Inmediato)</option>
                            <option value="Si" <?= (($viaje['diferido'] ?? '') == 'Si') ? 'selected' : '' ?>>Si (Programado)</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Origen</label>
                        <div class="input-mapa">
                            <input type="text" id="dir_origen" name="direccion_origen" value="<?= htmlspecialchars($viaje['direccion_origen'] ?? '') ?>" onkeyup="autocomplete(this)">
                            <button type="button" class="btn-map btn-origen" onclick="verMapa('dir_origen')">📍ORIGEN</button>
                        </div>
                        <div id="dir_origen_list" class="autocomplete-box"></div>
                        <input type="hidden" name="origen_lat" id="dir_origen_lat" value="<?= $viaje['origen_lat'] ?? '' ?>">
                        <input type="hidden" name="origen_lng" id="dir_origen_lng" value="<?= $viaje['origen_lng'] ?? '' ?>">
                    </div>
                    <div class="form-group">
                        <label>Destino</label>
                        <div class="input-mapa">
                            <input type="text" id="dir_destino" name="direccion_destino" value="<?= htmlspecialchars($viaje['direccion_destino'] ?? '') ?>" onkeyup="autocomplete(this)">
                            <div style="display:flex; gap:5px;">
                                <button type="button" class="btn-map btn-destino" onclick="verMapa('dir_destino')">🟢 DESTINO</button>
                                <button type="button" class="btn-map btn-recorrido" onclick="verRecorrido(document.getElementById('dir_origen').value, document.getElementById('dir_destino').value)">➡️ RECORRIDO</button>
                            </div>
                        </div>
                        <div id="dir_destino_list" class="autocomplete-box"></div>
                        <input type="hidden" name="destino_lat" id="dir_destino_lat" value="<?= $viaje['destino_lat'] ?? '' ?>">
                        <input type="hidden" name="destino_lng" id="dir_destino_lng" value="<?= $viaje['destino_lng'] ?? '' ?>">
                    </div>



                    <div class="form-group">
                        <label>Fecha y Hora</label>
                        <div class="fecha-hora" style="display:flex; gap:10px;">
                            <input type="date" name="fecha" id="fecha" value="<?= $viaje['fecha'] ?? date('Y-m-d') ?>" style="flex:1;">
                            <input type="time" name="hora" id="hora" value="<?= isset($viaje['hora']) ? substr($viaje['hora'], 0, 5) : date('H:i') ?>" style="flex:1;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Categoría</label>
                        <select name="categoria_movil" id="categoria_movil" required>
                            <option value="">-- ELIJA CATEGORÍA --</option>
                            <option value="REMIS" <?= (($viaje['categoria_movil'] ?? '') == 'REMIS') ? 'selected' : '' ?>>REMIS</option>
                            <option value="TAXI" <?= (($viaje['categoria_movil'] ?? '') == 'TAXI') ? 'selected' : '' ?>>TAXI</option>
                            <option value="VAN" <?= (($viaje['categoria_movil'] ?? '') == 'VAN') ? 'selected' : '' ?>>VAN</option>
                        </select>
                    </div>

                    <div id="bloque_tarifa" style="display:flex; gap:10px; align-items:center; margin-top:10px;">
                        <button type="button" class="btn-map btn-tarifa" style="min-width:200px;" onclick="calcularTarifa()">
                            💲 CALCULAR VIAJE
                        </button>
                        <input type="text" id="tarifa_resultado" placeholder="Importe $" readonly style="flex:1;">
                    </div>

                </div>

                <div class="form-full acciones-form">
                    <button type="submit" name="guardar" class="btn-guardar">
                        💾 Guardar Viaje
                    </button>
                    <a href="lista_viajes.php" class="btn-volver">
                        ↩ Listado de viajes
                    </a>
                    <a href="../../inicio_0.php" class="btn-volver">
                        ↩ Salir
                    </a>
                </div>

            </form>

        </div>
    </div>

    <div id="mapModal" style="display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:#000000aa;z-index:9999;">
        <div style="width:80%;height:80%;margin:5% auto;background:white;padding:10px;border-radius:8px;">
            <button onclick="cerrarMapa()" class="btn btn-danger" style="float:right; margin-bottom:10px;">Cerrar</button>
            <div id="map" style="width:100%;height:90%;"></div>
        </div>
    </div>

</body>

</html>