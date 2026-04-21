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
    <title>Carga de Viaje</title>

    <link rel="stylesheet" href="../../../css/estilos.css">
    <link rel="stylesheet" href="../../../css/listado_viajes.css">

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <script src="../../../js/listado_viajes.js"></script>

    <!-- CAMPOS DIFERIDO -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const select = document.getElementById("diferido");
            const campos = document.getElementById("campos_diferido");

            function toggleCampos() {
                campos.style.display = (select.value === "Si") ? "block" : "none";
            }

            toggleCampos();
            select.addEventListener("change", toggleCampos);
        });
    </script>

    <!-- MAPA -->
    <script>
        let map;
        let markers = [];
        let rutas = [];

        function limpiarMapa() {
            markers.forEach(m => map.removeLayer(m));
            markers = [];
            rutas.forEach(r => map.removeLayer(r));
            rutas = [];
        }

        function verMapa(direccion) {
            if (!direccion) return alert("Ingrese dirección");

            document.getElementById("mapModal").style.display = "block";

            fetch(`https://nominatim.openstreetmap.org/search?format=json&q=${direccion+', Buenos Aires, Argentina'}`)
                .then(r => r.json())
                .then(data => {

                    if (!data.length) return alert("Dirección no encontrada");

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
            if (!origen || !destino) return alert("Complete origen y destino");

            document.getElementById("mapModal").style.display = "block";

            Promise.all([
                    fetch(`https://nominatim.openstreetmap.org/search?format=json&q=${origen+', Buenos Aires, Argentina'}`).then(r => r.json()),
                    fetch(`https://nominatim.openstreetmap.org/search?format=json&q=${destino+', Buenos Aires, Argentina'}`).then(r => r.json())
                ])
                .then(([o, d]) => {

                    if (!o.length || !d.length) return alert("Dirección no encontrada");

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

                    fetch(`https://router.project-osrm.org/route/v1/driving/${lon1},${lat1};${lon2},${lat2}?overview=full&geometries=geojson&alternatives=true`)
                        .then(r => r.json())
                        .then(data => {

                            if (!data.routes.length) return alert("Sin ruta");

                            data.routes.forEach((route, index) => {

                                let layer = L.geoJSON(route.geometry, {
                                    style: {
                                        color: index === 0 ? 'blue' : 'gray',
                                        weight: index === 0 ? 6 : 4,
                                        opacity: index === 0 ? 1 : 0.5
                                    }
                                }).addTo(map);

                                layer.on('click', function() {
                                    rutas.forEach(r => r.setStyle({
                                        color: 'gray',
                                        weight: 4,
                                        opacity: 0.5
                                    }));

                                    this.setStyle({
                                        color: 'red',
                                        weight: 6,
                                        opacity: 1
                                    });
                                });

                                rutas.push(layer);
                            });

                            map.fitBounds(rutas[0].getBounds());
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
        <div class="card">

            <h3><?= $viaje ? "Editar Viaje" : "Nuevo Viaje"; ?></h3>

            <form method="POST">
                <input type="hidden" name="id" value="<?= $viaje['id'] ?? '' ?>">

                <div class="form-group">
                    <label>Celular</label>
                    <input type="number" name="cel_pasaj" value="<?= $viaje['cel_pasaj'] ?? '' ?>" required>
                </div>

                <div class="form-group">
                    <label>Nombre</label>
                    <input type="text" name="nombre_pasaj" value="<?= $viaje['nombre_pasaj'] ?? '' ?>" required>
                </div>

                <div class="form-group">
                    <label>Origen</label>
                    <div style="display:flex; gap:5px;">
                        <input type="text" id="dir_origen" name="direccion_origen"
                            value="<?= $viaje['direccion_origen'] ?? '' ?>" required>

                        <button type="button" class="btn-map"
                            onclick="verMapa(document.getElementById('dir_origen').value)">O</button>
                    </div>
                </div>

                <div class="form-group">
                    <label>Destino</label>
                    <div style="display:flex; gap:5px;">
                        <input type="text" id="dir_destino" name="direccion_destino"
                            value="<?= $viaje['direccion_destino'] ?? '' ?>">

                        <button type="button" class="btn-map"
                            onclick="verMapa(document.getElementById('dir_destino').value)">D</button>

                        <button type="button" class="btn-map"
                            onclick="verRecorrido(
                document.getElementById('dir_origen').value,
                document.getElementById('dir_destino').value
            )">R</button>
                    </div>
                </div>

                <div class="form-group">
                    <label>Tipo</label>
                    <select name="diferido" id="diferido">
                        <option value="No" <?= ($viaje['diferido'] ?? '') == "No" ? 'selected' : '' ?>>Inmediato</option>
                        <option value="Si" <?= ($viaje['diferido'] ?? '') == "Si" ? 'selected' : '' ?>>Diferido</option>
                    </select>
                </div>

                <div id="campos_diferido" style="display:none;">
                    <input type="date" name="fecha" value="<?= $viaje['fecha'] ?? '' ?>">
                    <input type="time" name="hora" value="<?= $viaje['hora'] ?? '' ?>">
                </div>

                <div class="form-group">
                    <label>Categoría</label>
                    <select name="categoria_movil">
                        <option value="REMIS">Remis</option>
                        <option value="TAXI">Taxi</option>
                    </select>
                </div>

                <button type="submit" name="guardar">Guardar</button>
                <a href="lista_viajes.php">Volver al listado</a>

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