// ================= INIT =================
document.addEventListener("DOMContentLoaded", function () {

    const select = document.getElementById("diferido");
    const campos = document.getElementById("campos_diferido");

    if (select && campos) {
        function toggleCampos() {
            campos.style.display = (select.value === "Si") ? "block" : "none";
        }

        toggleCampos();
        select.addEventListener("change", toggleCampos);
    }

});


// ================= MAPA =================
let map;
let markers = [];
let rutas = [];

function limpiarMapa() {
    markers.forEach(m => map.removeLayer(m));
    rutas.forEach(r => map.removeLayer(r));

    markers = [];
    rutas = [];
}

function abrirMapa() {
    document.getElementById("mapModal").style.display = "block";

    // FIX render leaflet dentro de modal
    setTimeout(() => {
        if (map) map.invalidateSize();
    }, 200);
}

function cerrarMapa() {
    document.getElementById("mapModal").style.display = "none";
}


// ================= GEO =================
async function geocodificar(direccion) {

    direccion = direccion.trim();

    if (!direccion || direccion.length < 5) {
        return null;
    }

    let query = encodeURIComponent(direccion + ', Buenos Aires, Argentina');

    let url = `https://nominatim.openstreetmap.org/search?format=json&q=${query}&limit=1&countrycodes=ar`;

    try {
        let res = await fetch(url, {
            headers: {
                'Accept-Language': 'es'
            }
        });

        let data = await res.json();

        console.log("Geocoding:", direccion, data);

        if (!data || data.length === 0) return null;

        return data[0];

    } catch (error) {
        console.error("Error geocoding:", error);
        return null;
    }
}


// ================= VER UBICACION =================
async function verMapa(direccion) {

    let geo = await geocodificar(direccion);

    if (!geo) {
        alert("Dirección no encontrada");
        return;
    }

    abrirMapa();

    let lat = geo.lat;
    let lon = geo.lon;

    if (!map) {
        map = L.map('map').setView([lat, lon], 15);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap'
        }).addTo(map);

    } else {
        map.setView([lat, lon], 15);
    }

    limpiarMapa();

    let m = L.marker([lat, lon])
        .addTo(map)
        .bindPopup(direccion)
        .openPopup();

    markers.push(m);
}


// ================= VER RECORRIDO =================
async function verRecorrido(origen, destino) {

    origen = origen.trim();
    destino = destino.trim();

    if (!origen || !destino) {
        return alert("Complete origen y destino");
    }

    let geoO = await geocodificar(origen);
    let geoD = await geocodificar(destino);

    if (!geoO || !geoD) {
        return alert("Direcciones no encontradas");
    }

    abrirMapa();

    let lat1 = geoO.lat;
    let lon1 = geoO.lon;

    let lat2 = geoD.lat;
    let lon2 = geoD.lon;

    if (!map) {
        map = L.map('map').setView([lat1, lon1], 13);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap'
        }).addTo(map);
    }

    limpiarMapa();

    let m1 = L.marker([lat1, lon1]).addTo(map).bindPopup("Origen");
    let m2 = L.marker([lat2, lon2]).addTo(map).bindPopup("Destino");

    markers.push(m1, m2);

    try {

        let url = `https://router.project-osrm.org/route/v1/driving/${lon1},${lat1};${lon2},${lat2}?overview=full&geometries=geojson&alternatives=true`;

        let res = await fetch(url);
        let data = await res.json();

        console.log("Rutas:", data);

        if (!data.routes || data.routes.length === 0) {
            return alert("No se encontró ruta");
        }

        rutas = []; // limpiar array de rutas

        data.routes.forEach((route, index) => {

            let layer = L.geoJSON(route.geometry, {
                style: {
                    color: index === 0 ? 'blue' : 'gray',
                    weight: index === 0 ? 6 : 4,
                    opacity: index === 0 ? 1 : 0.5
                }
            }).addTo(map);

            // 👉 CLICK EN RUTA
            layer.on('click', function () {

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

                // ✅ ACTUALIZA DISTANCIA SEGÚN RUTA SELECCIONADA
                let km = route.distance / 1000;
                window.distancia_km = km;

                //console.log("Ruta seleccionada:", km.toFixed(2) + " km");
                let km = data.routes[0].distance / 1000;

                // variables
                const remis = 1800;
                const bajadaBandera = 500;

                // cálculos
                const importeRemis = km * remis;
                const valorTaxi = km * bajadaBandera * (km / 5);

                // mostrar todo junto
                alert(
                    "Distancia: " + km.toFixed(2) + " km\n" +
                    "Importe Remis: $ " + importeRemis.toFixed(0) + "\n" +
                    "Valor Taxi: $ " + valorTaxi.toFixed(0)
                );
                
            });

            rutas.push(layer);
        });

        // 👉 AJUSTAR MAPA
        map.fitBounds(rutas[0].getBounds());

        // ✅ DISTANCIA POR DEFECTO (primera ruta)
        let km = data.routes[0].distance / 1000;
        window.distancia_km = km;

        console.log("Distancia inicial:", km.toFixed(2) + " km");

    } catch (error) {
        console.error("Error routing:", error);
        alert("Error al calcular ruta");
    }
}

