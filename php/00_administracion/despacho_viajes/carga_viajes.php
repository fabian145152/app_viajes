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
    <title>NUEVOS VIAJES</title>
    <link rel="stylesheet" href="../../../css/estilos.css">
    <link rel="stylesheet" href="../../../css/listado_viajes.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="../../../css/carga_viajes.css">
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="listado_viajes.js" defer></script>

    <script>
        function formatearCelular(cel) {
            if (!cel) return '';
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
                if (!diferido) return;

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

            if (diferido) {
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
            }
        });
    </script>
</head>

<body>

    <div class="container">
        <div class="card">

            <h3><?= $viaje ? "Editar Viaje" : "Nuevo Viaje de Cuenta corriente"; ?></h3>

            <div style="text-align:left; margin-bottom:15px;">
                <a href="carga_viajes.php" class="btn btn-primary" style="margin-right:10px;">
                    Viaje de Cta Cte
                </a>
                <a href="carga_viajes_efectivo.php" class="btn btn-success">
                    Viaje Efectivo
                </a>
            </div>

            <form method="POST" class="form-2cols">
                <input type="hidden" name="id" value="<?= $viaje['id'] ?? '' ?>">

                <div class="col">
                    <div class="form-group">
                        <label>Empresa</label>
                        <select name="cc" id="cc" required>
                            <option value="">-- Seleccione Empresa --</option>
                            <?php foreach ($empresas as $empresa): ?>
                                <option value="<?= $empresa['id'] ?>" <?= (($viaje['cc'] ?? '') == $empresa['id']) ? 'selected' : '' ?>>
                                    <?= $empresa['id_empresa'] ?> - <?= htmlspecialchars($empresa['razon_social']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <div class="form-group" id="contenedor_cc" style="display: <?= !empty($viaje['id_cc']) ? 'block' : 'none' ?>;">
                        <label>Centro de Costo</label>
                        <select name="id_cc" id="id_cc" required>
                            <?php if (!empty($viaje['id_cc'])): ?>
                                <option value="<?= $viaje['id_cc'] ?>" selected>Cargando centro guardado...</option>
                            <?php else: ?>
                                <option value="">Seleccione Centro de Costo</option>
                            <?php endif; ?>
                        </select>
                    </div>

                    <div class="form-group" id="contenedor_autorizante" style="display: <?= !empty($viaje['id_autorizante']) ? 'block' : 'none' ?>;">
                        <label>Autorizante</label>
                        <select name="id_autorizante" id="id_autorizante">
                            <?php if (!empty($viaje['id_autorizante'])): ?>
                                <option value="<?= $viaje['id_autorizante'] ?>" selected>Cargando autorizante guardado...</option>
                            <?php else: ?>
                                <option value="">Seleccione Autorizante</option>
                            <?php endif; ?>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Nombre del Pasajero</label>
                        <input type="text" name="nombre_pasaj" id="nombre_pasaj" value="<?= htmlspecialchars($viaje['nombre_pasaj'] ?? '') ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Celular del Pasajero</label>
                        <input type="text" name="cel_pasaj" id="cel_pasaj" value="<?= htmlspecialchars($viaje['cel_pasaj'] ?? '') ?>" required>
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

                    <div class="fecha-hora">
                        <input type="date" name="fecha" id="fecha" value="<?= $viaje['fecha'] ?? date('Y-m-d') ?>">
                        <input type="time" name="hora" id="hora" value="<?= isset($viaje['hora']) ? substr($viaje['hora'], 0, 5) : date('H:i') ?>">
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
                        <button type="button" class="btn-map btn-tarifa" style="min-width:200px;" onclick="calcularTarifa()">💲 CALCULAR VIAJE</button>
                        <input type="text" id="tarifa_resultado" placeholder="Importe $" readonly style="flex:1;">
                    </div>
                </div>

                <div class="form-full acciones-form">
                    <button type="submit" name="guardar" class="btn-guardar">💾 Guardar Viaje</button>
                    <a href="lista_viajes.php" class="btn-volver">↩ Volver</a>

                    <a href="../../inicio_0.php" class="btn-volver">
                        ↩ Salir
                    </a>
                </div>

            </form>

        </div>
    </div>

    <div id="mapModal" style="display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:#000000aa;z-index:9999;">
        <div style="width:80%;height:80%;margin:5% auto;background:white;padding:10px;border-radius:8px;">
            <button onclick="cerrarMapa()" style="float:right; margin-bottom:10px;">Cerrar</button>
            <div id="map" style="width:100%;height:90%;"></div>
        </div>
    </div>

    <script>
        // Lógica de compatibilidad si se abren registros en modo edición
        document.addEventListener("DOMContentLoaded", function() {
            let empresaPrevia = document.getElementById('cc').value;
            let ccPrevio = "<?= $viaje['id_cc'] ?? '' ?>";
            let autPrevio = "<?= $viaje['id_autorizante'] ?? '' ?>";

            if (empresaPrevia) {
                cargarCentros(empresaPrevia, ccPrevio, autPrevio);
            }
        });

        // ===================================
        // 1. ESCUCHA: CAMBIO DE EMPRESA
        // ===================================
        document.getElementById('cc').addEventListener('change', function() {
            let empresa = this.value;
            cargarCentros(empresa, null, null);
        });

        function cargarCentros(empresa, ccPreseleccionado, autPreseleccionado) {
            let contenedorCC = document.getElementById('contenedor_cc');
            let contenedorAut = document.getElementById('contenedor_autorizante');
            let comboCC = document.getElementById('id_cc');
            let comboAut = document.getElementById('id_autorizante');

            if (!empresa) {
                contenedorCC.style.display = 'none';
                contenedorAut.style.display = 'none';
                comboCC.innerHTML = '<option value="">Seleccione Centro de Costo</option>';
                comboAut.innerHTML = '<option value="">Seleccione Autorizante</option>';
                return;
            }

            // Desplegamos Centro de Costo secuencialmente
            contenedorCC.style.display = 'block';
            if (!ccPreseleccionado) {
                contenedorAut.style.display = 'none';
            }
            comboCC.innerHTML = '<option value="">Cargando centros...</option>';

            fetch('obtener_centros.php?id_empresa=' + empresa)
                .then(response => {
                    if (!response.ok) throw new Error('HTTP Status ' + response.status);
                    return response.text(); // Capturamos texto para interceptar errores fatales de PHP
                })
                .then(texto => {
                    try {
                        let datos = JSON.parse(texto);

                        if (datos.error) {
                            comboCC.innerHTML = '<option value="">Error SQL: ' + datos.error + '</option>';
                            console.error("Error devuelto desde la base de datos:", datos);
                            return;
                        }

                        comboCC.innerHTML = '<option value="">-- Seleccione Centro de Costo --</option>';
                        if (Array.isArray(datos)) {
                            if (datos.length === 0) {
                                comboCC.innerHTML = '<option value="">La empresa no registra centros</option>';
                                return;
                            }
                            datos.forEach(cc => {
                                let esSelected = (ccPreseleccionado == cc.id) ? 'selected' : '';
                                comboCC.innerHTML += '<option value="' + cc.id + '" ' + esSelected + '>' + cc.centro_de_costo + ' - ' + cc.nombre + '</option>';
                            });

                            if (ccPreseleccionado) {
                                cargarAutorizantes(ccPreseleccionado, autPreseleccionado);
                            }
                        } else {
                            comboCC.innerHTML = '<option value="">Error: Datos corruptos</option>';
                        }
                    } catch (e) {
                        console.error("El servidor no devolvió JSON limpio. Respuesta capturada:\n", texto);
                        comboCC.innerHTML = '<option value="">Error: Ver Consola (F12)</option>';
                    }
                })
                .catch(error => {
                    console.error("Error de Red / Conexión fetch centros:", error);
                    comboCC.innerHTML = '<option value="">Error de Red</option>';
                });
        }

        // ===================================
        // 2. ESCUCHA: CAMBIO DE CENTRO DE COSTO
        // ===================================
        document.getElementById('id_cc').addEventListener('change', function() {
            let id_cc = this.value;
            cargarAutorizantes(id_cc, null);
        });

        function cargarAutorizantes(id_cc, autPreseleccionado) {
            let contenedorAut = document.getElementById('contenedor_autorizante');
            let comboAut = document.getElementById('id_autorizante');

            if (!id_cc) {
                contenedorAut.style.display = 'none';
                comboAut.innerHTML = '<option value="">Seleccione Autorizante</option>';
                return;
            }

            contenedorAut.style.display = 'block';
            comboAut.innerHTML = '<option value="">Cargando autorizantes...</option>';

            // CAPTURAMOS LA EMPRESA SELECCIONADA
            let empresa = document.getElementById('cc').value;

            // Enviamos AMBOS datos en el fetch
            fetch('obtener_autorizantes.php?id_cc=' + id_cc + '&id_empresa=' + empresa)
                .then(response => {
                    if (!response.ok) throw new Error('HTTP Status ' + response.status);
                    return response.text();
                })
                .then(texto => {
                    try {
                        let datos = JSON.parse(texto);

                        if (datos.error) {
                            comboAut.innerHTML = '<option value="">Error SQL: ' + datos.error + '</option>';
                            return;
                        }

                        comboAut.innerHTML = '<option value="">-- Seleccione Autorizante --</option>';
                        if (Array.isArray(datos)) {
                            if (datos.length === 0) {
                                comboAut.innerHTML = '<option value="">No hay autorizantes activos</option>';
                                return;
                            }

                            // 💾 Guardamos la lista temporalmente en el navegador
                            window.autorizantesCargados = datos;

                            datos.forEach(a => {
                                let esSelected = (autPreseleccionado == a.id) ? 'selected' : '';
                                let tel = a.celular ? ' - ' + formatearCelular(a.celular) : '';
                                comboAut.innerHTML += '<option value="' + a.id + '" ' + esSelected + '>' + a.nombre + tel + '</option>';
                            });
                        } else {
                            comboAut.innerHTML = '<option value="">Error: Datos corruptos</option>';
                        }
                    } catch (e) {
                        console.error("Respuesta del servidor:\n", texto);
                        comboAut.innerHTML = '<option value="">Error: Ver Consola</option>';
                    }
                })
                .catch(error => {
                    comboAut.innerHTML = '<option value="">Error de Red</option>';
                });
        }
        // Escucha cuando el operador cambia manualmente de autorizante para auto-completar los inputs
        document.getElementById('id_autorizante').addEventListener('change', function() {
            let idSeleccionado = this.value;
            if (idSeleccionado && window.autorizantesCargados) {
                let autorizante = window.autorizantesCargados.find(a => a.id == idSeleccionado);
                if (autorizante) {
                    document.getElementById('nombre_pasaj').value = autorizante.nombre;
                    document.getElementById('cel_pasaj').value = autorizante.celular || '';
                }
            }
        });
    </script>
</body>

</html>