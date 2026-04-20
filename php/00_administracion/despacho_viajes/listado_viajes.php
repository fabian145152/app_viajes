<?php
include_once "../../../funciones/funciones.php";
protegerPagina([0, 3]);

// ACCIONES
if (isset($_POST['guardar'])) {
    guardarViaje($_POST);
    header("Location: listado_viajes.php");
    exit;
}

if (isset($_GET['borrar'])) {
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
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <link rel="stylesheet" href="../../../css/listado_viajes.css">
    <script src="../../../js/listado_viajes.js"></script>



    <script>
        let map;
        let markers = [];
        let line;

        function limpiarMapa() {
            markers.forEach(m => map.removeLayer(m));
            markers = [];
            if (line) map.removeLayer(line);
        }

        function verMapa(direccion) {
            document.getElementById("mapModal").style.display = "block";

            fetch(`https://nominatim.openstreetmap.org/search?format=json&q=${direccion+', Buenos Aires, Argentina'}`)
                .then(r => r.json())
                .then(data => {
                    if (!data.length) {
                        alert("Dirección no encontrada");
                        return;
                    }

                    let lat = data[0].lat;
                    let lon = data[0].lon;

                    if (!map) {
                        map = L.map('map').setView([lat, lon], 15);
                        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);
                    } else {
                        map.setView([lat, lon], 15);
                    }

                    limpiarMapa();

                    let m = L.marker([lat, lon]).addTo(map).bindPopup(direccion).openPopup();
                    markers.push(m);
                });
        }

        function verRecorrido(origen, destino) {
            document.getElementById("mapModal").style.display = "block";

            Promise.all([
                    fetch(`https://nominatim.openstreetmap.org/search?format=json&q=${origen+', Buenos Aires, Argentina'}`).then(r => r.json()),
                    fetch(`https://nominatim.openstreetmap.org/search?format=json&q=${destino+', Buenos Aires, Argentina'}`).then(r => r.json())
                ])
                .then(([o, d]) => {
                    if (!o.length || !d.length) {
                        alert("Dirección no encontrada");
                        return;
                    }

                    let lat1 = o[0].lat,
                        lon1 = o[0].lon;
                    let lat2 = d[0].lat,
                        lon2 = d[0].lon;

                    if (!map) {
                        map = L.map('map').setView([lat1, lon1], 13);
                        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);
                    }

                    limpiarMapa();

                    let m1 = L.marker([lat1, lon1]).addTo(map).bindPopup("Origen");
                    let m2 = L.marker([lat2, lon2]).addTo(map).bindPopup("Destino");
                    markers.push(m1, m2);

                    fetch(`https://router.project-osrm.org/route/v1/driving/${lon1},${lat1};${lon2},${lat2}?overview=full&geometries=geojson`)
                        .then(r => r.json())
                        .then(data => {
                            if (!data.routes.length) {
                                alert("Sin ruta");
                                return;
                            }

                            line = L.geoJSON(data.routes[0].geometry, {
                                style: {
                                    color: 'blue',
                                    weight: 5
                                }
                            }).addTo(map);
                            map.fitBounds(line.getBounds());
                        });
                });
        }

        function cerrarMapa() {
            document.getElementById("mapModal").style.display = "none";
        }
    </script>
</head>

<body>

    <div class="container">
        <div class="card operadores-layout">

            <!-- FORMULARIO COMPLETO -->
            <div class="col-form">
                <h3><?= $viaje ? "Editar Despacho" : "Nuevo Viaje"; ?></h3>

                <form method="POST">
                    <input type="hidden" name="id" value="<?= $viaje['id'] ?? ''; ?>">

                    <div class="form-group">
                        <label>Celular Pasajero</label>
                        <input type="number" name="cel_pasaj" value="<?= htmlspecialchars($viaje['cel_pasaj'] ?? '') ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Nombre Pasajero</label>
                        <input type="text" name="nombre_pasaj" value="<?= htmlspecialchars($viaje['nombre_pasaj'] ?? '') ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Dirección Origen</label>
                        <input type="text" name="direccion_origen" value="<?= htmlspecialchars($viaje['direccion_origen'] ?? '') ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Dirección Destino</label>
                        <input type="text" name="direccion_destino" value="<?= htmlspecialchars($viaje['direccion_destino'] ?? '') ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Observaciones Operador</label>
                        <textarea name="obs_operador"><?= htmlspecialchars($viaje['obs_operador'] ?? '') ?></textarea>
                    </div>

                    <div class="form-group">
                        <label>Observaciones Pasajero</label>
                        <textarea name="obs_pasaj"><?= htmlspecialchars($viaje['obs_pasaj'] ?? '') ?></textarea>
                    </div>

                    <div class="form-group">
                        <label>Tipo de Viaje</label>
                        <select name="diferido">
                            <option value="No" <?= (isset($viaje['diferido']) && $viaje['diferido'] == "No") ? 'selected' : ''; ?>>Inmediato</option>
                            <option value="Si" <?= (isset($viaje['diferido']) && $viaje['diferido'] == "Si") ? 'selected' : ''; ?>>Diferido</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Categoría</label>
                        <select name="categoria_movil">
                            <option value="REMIS" <?= (isset($viaje['categoria_movil']) && $viaje['categoria_movil'] == "REMIS") ? 'selected' : ''; ?>>Remis</option>
                            <option value="TAXI" <?= (isset($viaje['categoria_movil']) && $viaje['categoria_movil'] == "TAXI") ? 'selected' : ''; ?>>Taxi</option>
                        </select>
                    </div>

                    <div class="actions">
                        <button type="submit" name="guardar">Guardar</button>
                        <a href="../../inicio_0.php">Salir</a>
                    </div>

                </form>
            </div>

            <!-- TABLA -->
            <div class="col-tabla">
                <h3>Listado de Viajes Activos</h3>

                <div><strong>Referencias:</strong> 🔵 Origen | 🟢 Destino | 🔴 Recorrido</div>

                <table class="table">
                    <thead>
                        <tr>
                            <th class="col-id">ID</th>
                            <th class="col-pasajero">Pasajero</th>
                            <th class="col-direccion">Origen</th>
                            <th class="col-direccion">Destino</th>
                            <th class="col-cat">Categoría</th>
                            <th class="col-tipo">Tipo</th>
                            <th class="col-mapa">Mapa</th>
                            <th class="col-acciones">Acciones</th>
                        </tr>
                    </thead>

                    <tbody>
                        <?php if (empty($viajes)): ?>
                            <tr>
                                <td colspan="8">No hay viajes</td>
                            </tr>
                            <?php else: foreach ($viajes as $v): ?>

                                <tr style="<?= $v['diferido'] == "Si" ? 'background:#d4edda;' : '' ?>">

                                    <td class="col-id"><?= $v['id'] ?></td>

                                    <td class="col-pasajero">
                                        <strong><?= htmlspecialchars($v['nombre_pasaj']) ?></strong><br>
                                        <small><?= htmlspecialchars($v['cel_pasaj']) ?></small>
                                    </td>

                                    <td class="col-direccion">
                                        <div class="dir-cell">
                                            <span><?= htmlspecialchars($v['direccion_origen']) ?></span>
                                            <button class="btn-map btn-origen"
                                                title="Ver origen"
                                                onclick='verMapa(<?= json_encode($v["direccion_origen"]); ?>)'>
                                                O
                                            </button>
                                        </div>
                                    </td>

                                    <td class="col-direccion">
                                        <div class="dir-cell">
                                            <span><?= htmlspecialchars($v['direccion_destino']) ?></span>
                                            <button class="btn-map btn-destino"
                                                title="Ver destino"
                                                onclick='verMapa(<?= json_encode($v["direccion_destino"]); ?>)'>
                                                D
                                            </button>
                                        </div>
                                    </td>

                                    <td class="col-cat"><?= $v['categoria_movil'] ?></td>
                                    <td class="col-tipo"><?= $v['diferido'] ?></td>

                                    <td class="col-mapa">
                                        <button class="btn-map btn-recorrido"
                                            title="Ver recorrido"
                                            onclick='verRecorrido(
        <?= json_encode($v["direccion_origen"]); ?>,
        <?= json_encode($v["direccion_destino"]); ?>
    )'>
                                            R
                                    </td>

                                    <td class="col-acciones">
                                        <a href="?editar=<?= $v['id'] ?>">Editar</a>
                                        <a href="?borrar=<?= $v['id'] ?>" onclick="return confirm('¿Eliminar?')">Borrar</a>
                                    </td>

                                </tr>

                        <?php endforeach;
                        endif; ?>
                    </tbody>
                </table>
            </div>

        </div>
    </div>

    <!-- MAPA -->
    <div id="mapModal" style="display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:#000000aa;">
        <div style="width:80%;height:80%;margin:5% auto;background:white;">
            <button onclick="cerrarMapa()">Cerrar</button>
            <div id="map" style="width:100%;height:90%;"></div>
        </div>
    </div>

</body>

</html>