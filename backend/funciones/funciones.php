<?php



function conexion()
{
    $host = 'localhost';
    $db   = 'app_viajes';
    $user = 'postgres';
    $pass = 'belgrado';
    $port = '5432';

    try {
        $dsn = "pgsql:host=$host;port=$port;dbname=$db";
        $conn = new PDO($dsn, $user, $pass, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);

        return $conn;
        //echo "¡Conexión exitosa a PostgreSQL!";

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

    if (!empty($data['id'])) {
        // UPDATE
        $sql = "UPDATE usuarios 
                SET nombre=?, nom_apellido=?, telefono=?, email=? 
                WHERE id=?";
        $stmt = $db->prepare($sql);

        return $stmt->execute([
            $data['nombre'],
            $data['nom_apellido'],
            $data['telefono'],
            $data['email'],
            $data['id']
        ]);
    } else {
        // INSERT
        $passHash = password_hash($data['password'], PASSWORD_DEFAULT);

        $sql = "INSERT INTO usuarios 
                (nombre, nom_apellido, telefono, email, password, permisos, estado) 
                VALUES (?, ?, ?, ?, ?, ?, ?)";

        $stmt = $db->prepare($sql);

        return $stmt->execute([
            $data['nombre'],
            $data['nom_apellido'],
            $data['telefono'],
            $data['email'],
            $passHash,
            $data['permisos'],
            $data['estado']
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
                SET marca=?, modelo=?, patente=?, estado=?, color=?, id_chofer=? 
                WHERE id=?";
        $stmt = $pdo->prepare($sql);

        return $stmt->execute([
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
                (marca, modelo, patente, estado, color, id_chofer) 
                VALUES (?, ?, ?, ?, ?, ?)";
        $stmt = $pdo->prepare($sql);

        return $stmt->execute([
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

    // NULLS controlados
    $cuit = !empty($data['cuit']) ? $data['cuit'] : null;
    $inc_brutos = !empty($data['inc_brutos']) ? $data['inc_brutos'] : null;
    $cel_1 = !empty($data['cel_1']) ? $data['cel_1'] : null;
    $cel_2 = !empty($data['cel_2']) ? $data['cel_2'] : null;
    $numero_cuenta = !empty($data['numero_cuenta']) ? $data['numero_cuenta'] : null;

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
            $data['cel_3'],
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
            $data['cel_3'],
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

    $sql = "SELECT a.*, 
                   e.razon_social
            FROM autorizantes a
            LEFT JOIN cuenta_empresa e ON a.id_empresa = e.id
            ORDER BY a.apellido ASC";

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
            $data['id_empresa'],
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
