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
