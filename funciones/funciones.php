<?php
$host = "localhost";
$dbname = "app_viajes";
$user = "root";
$password = "belgrado";
try {
    // Aquí es donde nace $db
    $db = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $password);

    // Configuración para que PHP nos avise si hay errores de SQL
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Error de conexión: " . $e->getMessage();
    exit;
}

function conexion()
{
    $host = 'localhost';
    $db   = 'app_viajes';
    $user = 'root';          // Usuario por defecto en XAMPP/phpMyAdmin
    $pass = 'belgrado';              // Contraseña por defecto en XAMPP suele estar vacía
    // El puerto por defecto de MySQL es 3306, no es estrictamente necesario ponerlo si es el estándar

    try {
        // Cambiamos "pgsql" por "mysql"
        $dsn = "mysql:host=$host;dbname=$db;charset=utf8mb4";

        $conn = new PDO($dsn, $user, $pass, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4"
        ]);

        return $conn;
    } catch (PDOException $e) {
        echo "Error de conexión: " . $e->getMessage();
    }
}
// Obtener todos los usuarios
function obtenerUsuarios()
{
    $db = conexion();
    return $db->query("SELECT * FROM usuarios ORDER BY id")->fetchAll();
}

// Obtener un usuario específico
function obtenerUsuarioPorId($id)
{
    $db = conexion();
    $stmt = $db->prepare("SELECT * FROM usuarios WHERE id = ?");
    $stmt->execute([$id]);
    return $stmt->fetch();
}

function guardarUsuario($data)
{
    $db = conexion();

    // Normalización segura
    $nombre       = $data['nombre'] ?? null;
    $nom_apellido = $data['nom_apellido'] ?? null;
    $telefono     = $data['telefono'] ?? null;
    $email        = $data['email'] ?? null;
    $id           = $data['id'] ?? null;

    // Validación mínima obligatoria
    if (!$nombre || !$nom_apellido || !$email) {
        throw new Exception("Faltan campos obligatorios");
    }

    if (!empty($id)) {
        // UPDATE
        $sql = "UPDATE usuarios 
                SET nombre=?, nom_apellido=?, telefono=?, email=? 
                WHERE id=?";

        $stmt = $db->prepare($sql);

        return $stmt->execute([
            $nombre,
            $nom_apellido,
            $telefono,
            $email,
            $id
        ]);
    } else {
        // INSERT

        $password = $data['password'] ?? null;
        $permisos = $data['permisos'] ?? 0;
        $estado   = $data['estado'] ?? 'activo';

        if (!$password) {
            throw new Exception("La contraseña es obligatoria");
        }

        $passHash = password_hash($password, PASSWORD_DEFAULT);

        $sql = "INSERT INTO usuarios 
                (nombre, nom_apellido, telefono, email, password, permisos, estado) 
                VALUES (?, ?, ?, ?, ?, ?, ?)";

        $stmt = $db->prepare($sql);

        return $stmt->execute([
            $nombre,
            $nom_apellido,
            $telefono,
            $email,
            $passHash,
            $permisos,
            $estado
        ]);
    }
}
// Eliminar
function eliminarUsuario($id)
{
    $db = conexion();
    $stmt = $db->prepare("DELETE FROM usuarios WHERE id = ?");
    return $stmt->execute([$id]);
}

function actualizarConfiguracionUsuario($data)
{
    $db = conexion();

    // 🔒 Validaciones mínimas
    if (
        !isset(
            $data['id'],
            $data['nombre'],
            $data['nom_apellido'],
            $data['email'],
            $data['permisos'],
            $data['estado']
        )
    ) {
        return false;
    }

    $id        = (int)$data['id'];
    $nombre    = trim($data['nombre']);
    $nombre_completo = trim($data['nom_apellido']);
    $telefono  = trim($data['telefono'] ?? '');
    $email     = trim($data['email']);
    $permisos  = (int)$data['permisos'];
    $estado    = $data['estado'];

    // Validar valores permitidos
    if (!in_array($estado, ['activo', 'suspendido'])) {
        return false;
    }

    if ($permisos < 0 || $permisos > 3) {
        return false;
    }

    // --- BASE DEL UPDATE ---
    $sql = "UPDATE usuarios SET 
                nombre = ?,
                nom_apellido = ?, 
                telefono = ?, 
                email = ?, 
                permisos = ?, 
                estado = ?";

    $params = [
        $nombre,
        $nombre_completo,
        $telefono,
        $email,
        $permisos,
        $estado
    ];

    // 🔒 PASSWORD (solo si viene)
    if (isset($data['password'])) {
        $sql .= ", password = ?";
        $params[] = $data['password']; // ya viene hasheado
    }

    $sql .= " WHERE id = ?";
    $params[] = $id;

    $stmt = $db->prepare($sql);

    return $stmt->execute($params);
}


if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

function verificarLogin()
{
    if (!isset($_SESSION['permiso'])) {
        header("Location: /app_viajes/login.php"); // 👈 CAMBIAR ACA
        exit;
    }
}

/* ============================= */
/* PROTEGER PÁGINAS POR PERMISOS */
/* ============================= */
function protegerPagina($rolesPermitidos = [])
{

    // iniciar sesión si no está iniciada
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }

    // 🔐 validar login
    if (!isset($_SESSION['logueado'])) {
        die("No estás logueado");
    }

    // 🔐 validar permisos
    if (!empty($rolesPermitidos)) {
        if (!isset($_SESSION['permiso']) || !in_array($_SESSION['permiso'], $rolesPermitidos)) {
            die("⛔ No tenés permisos para acceder");
        }
    }
}

/* ============================= */
/* VALIDAR PERMISOS */
/* ============================= */
function tienePermiso($rolesPermitidos)
{
    return in_array($_SESSION['permiso'], $rolesPermitidos);
}



/* ========================================================================== */
/* CRUD UNIDADES
/* ========================================================================== */

/* ============================= */
/* VEHICULOS */
/* ============================= */

function obtenerVehiculos()
{
    $pdo = conexion();

    $sql = "SELECT v.*, 
                   CONCAT(c.apellido, ' ', c.nombre) AS chofer
            FROM vehiculos v
            LEFT JOIN choferes c ON v.id_chofer = c.id
            ORDER BY v.id DESC";

    return $pdo->query($sql)->fetchAll(PDO::FETCH_ASSOC);
}

function obtenerVehiculoPorId($id)
{
    $pdo = conexion();

    $sql = "SELECT * FROM vehiculos WHERE id = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$id]);

    return $stmt->fetch(PDO::FETCH_ASSOC);
}

function guardarVehiculo($data)
{
    $pdo = conexion();

    // 🔥 CLAVE: permitir NULL si no hay chofer
    $id_chofer = !empty($data['id_chofer']) ? $data['id_chofer'] : null;

    if (!empty($data['id'])) {
        // UPDATE
        $sql = "UPDATE vehiculos 
                SET categoria=?, marca=?, modelo=?, patente=?, estado=?, color=?, id_chofer=? 
                WHERE id=?";
        $stmt = $pdo->prepare($sql);

        return $stmt->execute([
            $data['categoria'],
            $data['marca'],
            $data['modelo'],
            $data['patente'],
            $data['estado'],
            $data['color'],
            $id_chofer,
            $data['id']
        ]);
    } else {
        // INSERT
        $sql = "INSERT INTO vehiculos 
                (categoria, marca, modelo, patente, estado, color, id_chofer) 
                VALUES (?, ?, ?, ?, ?, ?, ?)";
        $stmt = $pdo->prepare($sql);

        return $stmt->execute([
            $data['categoria'],
            $data['marca'],
            $data['modelo'],
            $data['patente'],
            $data['estado'],
            $data['color'],
            $id_chofer
        ]);
    }
}

function borrarVehiculo($id)
{
    $pdo = conexion();

    $stmt = $pdo->prepare("DELETE FROM vehiculos WHERE id=?");
    return $stmt->execute([$id]);
}

/* ============================= */
/* CHOFERES */
/* ============================= */

function obtenerChoferes()
{
    $pdo = conexion();

    $sql = "SELECT c.*, 
                   v.patente,
                   v.marca,
                   v.modelo
            FROM choferes c
            LEFT JOIN vehiculos v ON c.id = v.id_chofer
            ORDER BY c.apellido ASC, c.nombre ASC";

    return $pdo->query($sql)->fetchAll(PDO::FETCH_ASSOC);
}
function obtenerChoferPorId($id)
{
    $pdo = conexion();

    $sql = "SELECT * FROM choferes WHERE id = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$id]);

    return $stmt->fetch(PDO::FETCH_ASSOC);
}

function guardarChofer($data)
{
    $pdo = conexion();

    if (!empty($data['id'])) {
        // UPDATE
        $sql = "UPDATE choferes 
                SET nombre=?, apellido=?, cel=?, dir=?, barrio=?, cp=?
                WHERE id=?";
        $stmt = $pdo->prepare($sql);

        return $stmt->execute([
            $data['nombre'],
            $data['apellido'],
            $data['cel'],
            $data['dir'],
            $data['barrio'],
            $data['cp'],
            $data['id']
        ]);
    } else {
        // INSERT
        $sql = "INSERT INTO choferes (nombre, apellido, cel, dir, barrio, cp) 
                VALUES (?, ?, ?, ?, ?, ?)";
        $stmt = $pdo->prepare($sql);

        return $stmt->execute([
            $data['nombre'],
            $data['apellido'],
            $data['cel'],
            $data['dir'],
            $data['barrio'],
            $data['cp']
        ]);
    }
}

function borrarChofer($id)
{
    $pdo = conexion();

    // 🔥 IMPORTANTE: liberar vehículos antes de borrar
    $pdo->prepare("UPDATE vehiculos SET id_chofer = NULL WHERE id_chofer = ?")
        ->execute([$id]);

    $stmt = $pdo->prepare("DELETE FROM choferes WHERE id=?");
    return $stmt->execute([$id]);
}

/* ============================= */
/* CUENTA EMPRESA */
/* ============================= */

function obtenerEmpresas()
{
    $pdo = conexion();

    $sql = "SELECT * FROM cuenta_empresa ORDER BY numero_cuenta ASC";
    return $pdo->query($sql)->fetchAll(PDO::FETCH_ASSOC);
}

function obtenerEmpresaPorId($id)
{
    $pdo = conexion();

    $sql = "SELECT * FROM cuenta_empresa WHERE id = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$id]);

    return $stmt->fetch(PDO::FETCH_ASSOC);
}

function guardarEmpresa($data)
{
    $pdo = conexion();

    // Función auxiliar interna para limpiar strings vacíos a NULL real
    $limpiar = function ($valor) {
        // Trim quita espacios accidentales, si queda vacío tras el trim, devolvemos null
        return (isset($valor) && trim($valor) !== '') ? trim($valor) : null;
    };

    // Aplicamos la limpieza a los campos problemáticos
    $cuit          = $limpiar($data['cuit'] ?? null);
    $inc_brutos    = $limpiar($data['inc_brutos'] ?? null);
    $cel_1         = $limpiar($data['cel_1'] ?? null);
    $cel_2         = $limpiar($data['cel_2'] ?? null);
    $cel_3         = $limpiar($data['cel_3'] ?? null); // Agregado para consistencia
    $numero_cuenta = $limpiar($data['numero_cuenta'] ?? null);

    if (!empty($data['id'])) {
        // UPDATE
        $sql = "UPDATE cuenta_empresa SET
                razon_social=?, dir=?, cuit=?, inc_brutos=?, 
                cel_1=?, cel_2=?, cel_3=?,
                contacto_1=?, contacto_2=?, contacto_3=?,
                numero_cuenta=?
                WHERE id=?";
        $stmt = $pdo->prepare($sql);

        return $stmt->execute([
            $data['razon_social'],
            $data['dir'],
            $cuit,
            $inc_brutos,
            $cel_1,
            $cel_2,
            $cel_3,
            $data['contacto_1'],
            $data['contacto_2'],
            $data['contacto_3'],
            $numero_cuenta,
            $data['id']
        ]);
    } else {
        // INSERT
        $sql = "INSERT INTO cuenta_empresa
                (razon_social, dir, cuit, inc_brutos, 
                 cel_1, cel_2, cel_3,
                 contacto_1, contacto_2, contacto_3,
                 numero_cuenta)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $pdo->prepare($sql);

        return $stmt->execute([
            $data['razon_social'],
            $data['dir'],
            $cuit,
            $inc_brutos,
            $cel_1,
            $cel_2,
            $cel_3,
            $data['contacto_1'],
            $data['contacto_2'],
            $data['contacto_3'],
            $numero_cuenta
        ]);
    }
}

function borrarEmpresa($id)
{
    $pdo = conexion();

    $stmt = $pdo->prepare("DELETE FROM cuenta_empresa WHERE id=?");
    return $stmt->execute([$id]);
}


/* ============================= */
/* AUTORIZANTES */
/* ============================= */

function obtenerAutorizantes()
{
    $pdo = conexion();

    $sql = "SELECT a.*, e.razon_social 
    FROM autorizantes a 
    INNER JOIN cuenta_empresa e ON a.id_empresa = e.id 
    ORDER BY e.razon_social ASC";

    return $pdo->query($sql)->fetchAll(PDO::FETCH_ASSOC);
}

function obtenerAutorizantePorId($id)
{
    $pdo = conexion();

    $sql = "SELECT * FROM autorizantes WHERE id = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$id]);

    return $stmt->fetch(PDO::FETCH_ASSOC);
}

function guardarAutorizante($data)
{
    $pdo = conexion();
    $cel = !empty($data['cel']) ? $data['cel'] : null;

    if (!empty($data['id'])) {
        // UPDATE
        $sql = "UPDATE autorizantes 
                SET nombre=?, apellido=?, cel=?, email=?, id_empresa=? 
                WHERE id=?";
        $stmt = $pdo->prepare($sql);
        return $stmt->execute([
            $data['nombre'],
            $data['apellido'],
            $cel,
            $data['email'],
            $data['id_empresa'], // Aquí se guarda la empresa a la que pertenece
            $data['id']
        ]);
    } else {
        // INSERT
        $sql = "INSERT INTO autorizantes 
                (nombre, apellido, cel, email, id_empresa) 
                VALUES (?, ?, ?, ?, ?)";
        $stmt = $pdo->prepare($sql);
        return $stmt->execute([
            $data['nombre'],
            $data['apellido'],
            $cel,
            $data['email'],
            $data['id_empresa']
        ]);
    }
}

function borrarAutorizante($id)
{
    $pdo = conexion();

    $stmt = $pdo->prepare("DELETE FROM autorizantes WHERE id=?");
    return $stmt->execute([$id]);
}



// obtenerViajes: Trae todos los despachos
function obtenerViajes()
{
    global $db;
    $sql = "SELECT * FROM viajes_despacho ORDER BY id DESC";
    return $db->query($sql)->fetchAll(PDO::FETCH_ASSOC);
}

// obtenerViajePorId: Para cargar los datos al editar
function obtenerViajePorId($id)
{
    global $db;
    $stmt = $db->prepare("SELECT * FROM viajes_despacho WHERE id = ?");
    $stmt->execute([$id]);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}

// guardarViaje: Inserta uno nuevo o actualiza uno existente
function guardarViaje($datos)
{
    global $db;
    if (!empty($datos['id'])) {
        // ACTUALIZAR
        $sql = "UPDATE viajes_despacho SET 
                cel_pasaj=?, nombre_pasaj=?, direccion_origen=?, direccion_destino=?, 
                obs_operador=?, obs_pasaj=?, diferido=?, categoria_movil=? 
                WHERE id=?";
        $stmt = $db->prepare($sql);
        $stmt->execute([
            $datos['cel_pasaj'],
            $datos['nombre_pasaj'],
            $datos['direccion_origen'],
            $datos['direccion_destino'],
            $datos['obs_operador'],
            $datos['obs_pasaj'],
            $datos['diferido'],
            $datos['categoria_movil'],
            $datos['id']
        ]);
    } else {
        // INSERTAR NUEVO
        $sql = "INSERT INTO viajes_despacho 
                (cel_pasaj, nombre_pasaj, direccion_origen, direccion_destino, obs_operador, obs_pasaj, diferido, categoria_movil) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $db->prepare($sql);
        $stmt->execute([
            $datos['cel_pasaj'],
            $datos['nombre_pasaj'],
            $datos['direccion_origen'],
            $datos['direccion_destino'],
            $datos['obs_operador'],
            $datos['obs_pasaj'],
            $datos['diferido'],
            $datos['categoria_movil']
        ]);
    }
}

// borrarViaje: Elimina un registro
function borrarViaje($id)
{
    global $db;
    $stmt = $db->prepare("DELETE FROM viajes_despacho WHERE id = ?");
    $stmt->execute([$id]);
}
