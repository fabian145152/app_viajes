-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-06-2026 a las 15:29:29
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
  `id_vehiculo` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `choferes`
--

INSERT INTO `choferes` (`id`, `nombre`, `apellido`, `cel`, `dir`, `barrio`, `cp`, `id_vehiculo`, `user_id`) VALUES
(1, 'ROBERTO', 'PEREZ', 1169356236, 'Campichuelo 1534', 'Flores', 1408, NULL, 0),
(2, 'Fabian', 'Nogueroles', 1169356236, 'Carlos Gardel 3296', 'V. Libertad', 1650, NULL, 0),
(3, 'JORGE', 'Rodriguez', 1154873265, 'Caminito 2020', 'La Boca', 1245, NULL, 0);

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
  `id_centro_de_costo` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cuenta_empresa`
--

INSERT INTO `cuenta_empresa` (`id`, `id_empresa`, `razon_social`, `dir`, `cuit`, `inc_brutos`, `contacto_1`, `cel_1`, `id_centro_de_costo`) VALUES
(12, 14, 'ALEGRE EN FLOR', 'FELIPE VALLESE 501-CABA', '27920804867', '27920804867', NULL, 1122604527, 0),
(13, 5032, 'ALGEIBA S.A.', 'PARANA 771 1Âº B', '20129904187', NULL, NULL, NULL, 0),
(14, 17, 'AMIA', 'Pasteur 633', '33333334532', NULL, NULL, NULL, 0);

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
(1, 'TAXI', 'CHEVROLET', 'SPIN', 'AA456GG', 'disponible', 'NEGRA', 1),
(2, 'REMIS', 'FIAT', 'CRONOS', 'AA456GG', 'disponible', 'BLANCO', 2),
(3, 'REMIS', 'TOYOTA', 'COROLLA', 'AA802GX', 'disponible', 'BLANCO', NULL),
(4, 'REMIS', 'TOYOTA', 'COROLLA', 'AA456GG', 'ocupado', 'NEGRO', 1),
(5, 'REMIS', 'FIAT', 'CRONOS', 'AA802GX', 'disponible', 'NEGRO', NULL),
(6, 'REMIS', 'TOYOTA', 'COROLLA', 'AG444JH', 'disponible', 'AMARILLO', NULL),
(7, 'REMIS', 'FIAT', 'CRONOS', 'AA589GT', 'ocupado', 'VERDE', 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `choferes`
--
ALTER TABLE `choferes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_vehiculo_asignado` (`id_vehiculo`);

--
-- Indices de la tabla `cuenta_empresa`
--
ALTER TABLE `cuenta_empresa`
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
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `choferes`
--
ALTER TABLE `choferes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cuenta_empresa`
--
ALTER TABLE `cuenta_empresa`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `choferes`
--
ALTER TABLE `choferes`
  ADD CONSTRAINT `fk_vehiculo_asignado` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
