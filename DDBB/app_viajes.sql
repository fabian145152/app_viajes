-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-06-2026 a las 15:51:17
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.2.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `app_viajes`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autorizantes`
--

CREATE TABLE `autorizantes` (
  `id` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `id_centro_costo` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `celular` varchar(30) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `horario` varchar(100) DEFAULT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `autorizantes`
--

INSERT INTO `autorizantes` (`id`, `id_empresa`, `id_centro_costo`, `nombre`, `celular`, `email`, `horario`, `estado`) VALUES
(1, 999, 1, 'Fabian Alejandro', '1169356236', 'fabian_12345@hotmail.com', '06 A 18', 1),
(2, 1, 2, 'Fabian', '1169356236', 'fabian_12345@hotmail.com', '9 a 17', 1),
(3, 2, 3, 'Amendola', '11478458969', 'amen@gmail.com', '13 a 17', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `centros_costo`
--

CREATE TABLE `centros_costo` (
  `id` int(11) NOT NULL,
  `id_empresa` int(4) NOT NULL,
  `id_centro_costo` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `contacto_centro` varchar(50) NOT NULL,
  `cel` int(15) NOT NULL,
  `observaciones` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `centros_costo`
--

INSERT INTO `centros_costo` (`id`, `id_empresa`, `id_centro_costo`, `nombre`, `direccion`, `contacto_centro`, `cel`, `observaciones`) VALUES
(1, 999, 1, 'Paganini', 'Carlos Gardel 3296', '', 0, ''),
(2, 1, 1, 'Frente', 'Venezuela 4488', '', 0, 'Casa'),
(3, 2, 1, 'Calle Florentino Ameguino', 'Ameguino 2589', '', 0, 'Departamento 8');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `choferes`
--

CREATE TABLE `choferes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `cel` int(10) NOT NULL,
  `dir` varchar(30) NOT NULL,
  `barrio` varchar(20) NOT NULL,
  `cp` int(4) NOT NULL,
  `movil` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `choferes`
--

INSERT INTO `choferes` (`id`, `nombre`, `apellido`, `cel`, `dir`, `barrio`, `cp`, `movil`, `user_id`) VALUES
(2, 'Fabian', 'Nogueroles', 1169356236, 'Carlos Gardel 3296', 'V. Libertad', 1650, 2, 0),
(3, 'JORGE', 'Rodriguez', 1154873265, 'Caminito 2020', 'La Boca', 1245, NULL, 0),
(4, 'Cachorro', 'Lopez', 1145895689, 'Av Ricardo Balbin 2589', 'Saavedra', 1250, 3025, 0),
(5, 'Carlos', 'Piragine', 1125896589, 'Corrientes 458', 'Flores', 1444, 327, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta_empresa`
--

CREATE TABLE `cuenta_empresa` (
  `id` int(4) NOT NULL,
  `id_empresa` int(4) NOT NULL,
  `razon_social` varchar(50) NOT NULL,
  `dir` varchar(50) NOT NULL,
  `cuit` varchar(20) DEFAULT NULL,
  `inc_brutos` varchar(20) DEFAULT NULL,
  `contacto_1` varchar(50) DEFAULT NULL,
  `cel_1` int(10) DEFAULT NULL,
  `observaciones` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cuenta_empresa`
--

INSERT INTO `cuenta_empresa` (`id`, `id_empresa`, `razon_social`, `dir`, `cuit`, `inc_brutos`, `contacto_1`, `cel_1`, `observaciones`) VALUES
(1, 999, 'MyF', 'Carlos Gardel 3296', '30-14952694-7', '30-14952694-7', 'Fabian', 1169356236, 0),
(2, 1, 'Mercenarios anonimos', 'Campichuelo 4500', '3025896325-7', '3025896325-7', 'Fernando', 1125874589, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pasajeros_cc`
--

CREATE TABLE `pasajeros_cc` (
  `id` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `id_cc` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `celular` varchar(30) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `horario` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicaciones`
--

CREATE TABLE `ubicaciones` (
  `id` int(11) NOT NULL,
  `lat` decimal(10,7) DEFAULT NULL,
  `lng` decimal(10,7) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `device_id` varchar(30) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(4) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `telefono` int(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `permisos` varchar(15) NOT NULL,
  `estado` varchar(15) NOT NULL,
  `nom_apellido` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `telefono`, `email`, `password`, `permisos`, `estado`, `nom_apellido`) VALUES
(1, 'fabian', 1169356236, 'laboratorio.fabian@gmail.com', '$2y$10$9Y7tFQpxkwpYwzSulzEaju0/jbKU4lS2yx3Rv5.PWkY075nv2rikC', '0', 'activo', 'Fabian Nogueroles'),
(2, 'lucas', 1144444444, 'lucas.nogueroles@gmail.com', '$2y$10$nNHgf9izB3i1z1vUbvhBKe6C94mJVFFx5HUXNGdnIDNuUkCdXOQRG', '3', 'activo', 'Lucas Nogueroles'),
(3, 'jorge', 1156892356, 'Jorge@gmail.com', '$2y$10$AgC9SwZ2ikTJI8T6NtIQpetjz3oWLh8kvVIKvtv3N4T2hxFRdk6tO', '2', 'suspendido', 'JORGE MACELLO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos`
--

CREATE TABLE `vehiculos` (
  `id` int(11) NOT NULL,
  `categoria` varchar(15) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `patente` varchar(20) DEFAULT NULL,
  `estado` varchar(20) NOT NULL,
  `color` varchar(20) NOT NULL,
  `id_chofer` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `vehiculos`
--

INSERT INTO `vehiculos` (`id`, `categoria`, `marca`, `modelo`, `patente`, `estado`, `color`, `id_chofer`) VALUES
(1, 'TAXI', 'CHEVROLET', 'SPIN', 'AA456GG', 'disponible', 'NEGRA', NULL),
(2, 'REMIS', 'FIAT', 'CRONOS', 'AA456GG', 'disponible', 'BLANCO', 2),
(3, 'REMIS', 'TOYOTA', 'COROLLA', 'AA802GX', 'disponible', 'BLANCO', NULL),
(4, 'REMIS', 'TOYOTA', 'COROLLA', 'AA456GG', 'ocupado', 'NEGRO', NULL),
(5, 'REMIS', 'FIAT', 'CRONOS', 'AA802GX', 'disponible', 'NEGRO', NULL),
(6, 'REMIS', 'TOYOTA', 'COROLLA', 'AG444JH', 'disponible', 'AMARILLO', 4),
(7, 'REMIS', 'FIAT', 'CRONOS', 'AA589GT', 'ocupado', 'VERDE', 3),
(8, 'TAXI', 'CHEVROLET', 'SPIN', 'AA456FF', 'disponible', 'NEGRO', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viajes_despacho`
--

CREATE TABLE `viajes_despacho` (
  `id` int(20) NOT NULL,
  `cel_pasaj` int(10) NOT NULL,
  `nombre_pasaj` varchar(50) NOT NULL,
  `direccion_origen` varchar(70) NOT NULL,
  `direccion_destino` varchar(70) NOT NULL,
  `obs_operador` varchar(500) NOT NULL,
  `obs_pasaj` varchar(500) NOT NULL,
  `estado` varchar(15) NOT NULL,
  `diferido` varchar(20) NOT NULL,
  `fecha` date DEFAULT NULL,
  `hora` varchar(11) DEFAULT NULL,
  `categoria_movil` varchar(15) NOT NULL,
  `origen_lat` decimal(10,8) DEFAULT NULL,
  `origen_lng` decimal(11,8) DEFAULT NULL,
  `destino_lat` decimal(10,8) DEFAULT NULL,
  `destino_lng` decimal(11,8) DEFAULT NULL,
  `cc` int(4) DEFAULT NULL,
  `centro_de_costo` int(4) DEFAULT NULL,
  `id_autorizante` int(11) DEFAULT NULL,
  `obs_viaje` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `viajes_despacho`
--

INSERT INTO `viajes_despacho` (`id`, `cel_pasaj`, `nombre_pasaj`, `direccion_origen`, `direccion_destino`, `obs_operador`, `obs_pasaj`, `estado`, `diferido`, `fecha`, `hora`, `categoria_movil`, `origen_lat`, `origen_lng`, `destino_lat`, `destino_lng`, `cc`, `centro_de_costo`, `id_autorizante`, `obs_viaje`) VALUES
(6, 1122226666, 'Pascualito Peres', 'Belaustegui 3200, caba', '', '', '', 'Diferido', 'Si', '2026-06-01', '12:30', 'VAN', '-34.61847300', '-58.48105300', NULL, NULL, 0, 0, NULL, '0'),
(7, 1123895689, 'Juan Carlos Giles', 'Lafuente 1499, CABA', 'Sanabria 1900, CABA', '', '', 'Diferido', 'Si', '2026-04-28', '15:02', 'TAXI', '-34.64737290', '-58.45786790', '-34.61897950', '-58.49934130', 0, 0, NULL, '0'),
(12, 1156892356, 'Fabian Vena', 'Jonte 1979, caba', '', 'Operador', 'pasajero', 'Diferido', 'No', '0000-00-00', '', 'REMIS', '-34.60356530', '-58.47142840', NULL, NULL, NULL, 0, NULL, '0'),
(13, 1145784215, 'Jose Manuel', 'Juan B justo 8661, caba', '', 'Valor fijo $18.000-', '', 'Diferido', 'Si', '2026-06-01', '21:00', 'REMIS', '-34.60332710', '-58.45666290', NULL, NULL, 0, 0, NULL, '0'),
(14, 1125896589, 'Andres Castro Casado', 'Venezuela 1258, caba', 'Alvarez Jonre 1925, caba', 'Viaja solo', '', 'Completado', 'No', '0000-00-00', '', 'TAXI', '-34.61520970', '-58.40473700', NULL, NULL, NULL, 0, NULL, '0'),
(15, 2147483647, 'Franco Salas', 'Martinez Castro 2200, caba', '', 'Nada', '', 'En Curso', 'Si', '2026-04-23', '16:01', 'REMIS', '-34.63803450', '-58.47959650', NULL, NULL, 0, 0, NULL, '0'),
(16, 1125896325, 'Julieta Fuentes', 'Av Lafuente 120,caba', 'Beruti 2600, caba', '', '', 'Pendiente', 'Si', '2026-04-14', '22:00', 'REMIS', '-34.65672730', '-58.44623380', '-34.59218930', '-58.40268980', 0, 0, NULL, '0'),
(17, 1125896587, 'Carlos Piaggio', 'Pichincha 1936', '', 'VF 8500-', '', 'Cancelado', 'No', '0000-00-00', '', 'TAXI', '-34.70673700', '-58.37486600', NULL, NULL, NULL, 0, NULL, '0'),
(18, 1144445555, 'Alberto Garcia', 'Laprida 4490, Villa Martelli', 'Av Maipu 2200, Olivos', '', '', 'Pendiente', '', '2026-06-01', '10:50', 'REMIS', '-34.55154940', '-58.51190860', '-34.51614900', '-58.48816900', NULL, 0, NULL, '0'),
(21, 1125896547, 'Laura Garcia', 'San Nicolas 4560, caba', 'Av Juan Bautista Alberdi 3601, caba', 'Hola', 'Relinda', 'Pendiente', 'No', '2026-06-01', '14:19', 'REMIS', '-34.59401180', '-58.51181370', '-34.63601680', '-58.47657290', NULL, 0, NULL, '0'),
(22, 2147483647, 'Juan PErez', 'Miranda 258, caba', 'cuba 2585, caba', '', '', 'Pendiente', '', '2026-06-01', '21:09', 'VAN', '-34.63256040', '-58.51659780', '-34.55637170', '-58.45856500', NULL, 0, NULL, '0'),
(23, 1125896589, 'Ernest Heminwuey', 'Bolivia 950, villa martelli', 'laprida 4490, Villa martelli', 'Pelotudo', 'de mierda', 'inmediato', '', '2026-06-02', '11:11', 'REMIS', '-34.54661640', '-58.50690670', '-34.55154940', '-58.51190860', 2, 0, NULL, '0'),
(24, 1122334455, 'Pirulo achaval', 'Venezuela 4488, Villa martelli', 'Paraguay 350, villa martelli', '', '', 'En Curso', '', '2026-06-02', '15:19', 'TAXI', '-34.55236970', '-58.51121980', '-34.54868350', '-58.50704990', 0, 0, NULL, '0'),
(25, 2147483647, 'Cacho', 'Camacua 2000', 'Garcia del rio 1250, caba', 'Obs operador', 'Obs Pasajero', 'Pendiente', '', '2026-06-22', '16:35', 'REMIS', '-34.65731700', '-58.57914300', '-34.55175860', '-58.47860080', 2, 3, 3, '0'),
(26, 2147483647, 'Pirulo', 'Camacua 2000', 'Garcia del rio 1250, caba', 'Observ operador', 'Obs pasajero', 'Pendiente', '', '2026-06-22', '16:40', 'REMIS', '-34.65731700', '-58.57914300', '-34.55175860', '-58.47860080', 2, 3, 3, '0'),
(27, 1125895698, 'Paco', 'Aranguren 450, caba', 'Vera 3020,caba', 'sadf', 'sadfg', 'Pendiente', '', '2026-06-22', '16:47', 'REMIS', '-34.61241300', '-58.43735780', '-34.60189390', '-58.43493320', 2, 3, 3, '0'),
(28, 2147483647, 'Paco Jerte', 'Aranguren 450, caba', 'Sanabria 1979,caba', 'aaaa', 'bbbb', 'Pendiente', '', '2026-06-22', '16:14', 'REMIS', '-34.61241300', '-58.43735780', '-34.61847620', '-58.50530700', 0, 0, NULL, '0'),
(29, 1169356236, 'Fabian', 'Aranguren 450, caba', 'French 2500, Vicente lopez', 'Este pasajero hace una parada intermedia, espera 45 minutos y continua el viaje al destino Este pasa Este pasajero hace una parada intermedia, espera 45 minutos y continua el viaje al destino Este pasa Este pasaj', 'Este pasajero hace una parada intermedia, espera 45 minutos y continua el viaje al destino', 'Pendiente', '', '2026-06-23', '15:25', 'REMIS', '-34.61241300', '-58.43735780', '-34.55473440', '-58.51283720', 1, 0, NULL, '0');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `autorizantes`
--
ALTER TABLE `autorizantes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `centros_costo`
--
ALTER TABLE `centros_costo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `choferes`
--
ALTER TABLE `choferes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cuenta_empresa`
--
ALTER TABLE `cuenta_empresa`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pasajeros_cc`
--
ALTER TABLE `pasajeros_cc`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `viajes_despacho`
--
ALTER TABLE `viajes_despacho`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `autorizantes`
--
ALTER TABLE `autorizantes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `centros_costo`
--
ALTER TABLE `centros_costo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `choferes`
--
ALTER TABLE `choferes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cuenta_empresa`
--
ALTER TABLE `cuenta_empresa`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `pasajeros_cc`
--
ALTER TABLE `pasajeros_cc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `viajes_despacho`
--
ALTER TABLE `viajes_despacho`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `choferes`
--
ALTER TABLE `choferes`
  ADD CONSTRAINT `fk_vehiculo_asignado` FOREIGN KEY (`movil`) REFERENCES `vehiculos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
