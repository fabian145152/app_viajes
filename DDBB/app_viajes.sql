-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-06-2026 a las 13:35:15
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
(1, 999, 999, 'Fabian Alejandro', '1169356236', 'fabian_12345@hotmail.com', '06 A 18', 1),
(9, 3, 5, 'Alegre Maria Florencia', '', 'aleflor@gmail.com', '', 1),
(10, 3, 5, 'Giles Juan Manuel', '', 'alegilesj@gmail.com', '', 1),
(11, 3, 5, 'Giles Pablo andres', '', 'alegi@gmail.com', '', 1),
(12, 3, 5, 'Perussetti Zully Elisa', '', 'aleperu@gmail.com', '', 1),
(13, 3, 5, 'Ruggiero Enzo', '', 'aleenz@gmail.com', '', 1),
(14, 4, 6, 'CARNAU MAZZEI SABRINA', '', 'HHH@PORTENIO.COM', '', 1),
(15, 4, 6, 'ESTEVEZ EMILIANO', '', 'C@PORTENIO.COM', '', 1),
(16, 4, 6, 'MASTRANGELO PABLO', '', 'B@PORTENIO.COM', '', 1),
(17, 4, 6, 'MAZZINI	ALEJANDRA', '', 'mazini@PORTENIO.COM', '', 1),
(18, 4, 6, 'PEREDO	ROMAN', '', 'RO@PORTENIO.COM', '', 1),
(19, 4, 6, 'VAZQUEZ PABLO', '', 'FF@PORTENIO.COM', '', 1),
(20, 4, 6, 'YAÑEZ SANTIAGO', '', '	GG@PORTENIO.COM', '', 1),
(21, 5, 22, 'AIJENBOM VALERIA-RABINATO', '', 'AIJEM@GMAIL.COM', '', 1),
(22, 5, 9, 'AJZENMESSER FERNANDO - ADMINISTRACION-DOC', '', 'FERNANDOAJZENMESSER@GMAIL.COM', '', 1),
(23, 5, 26, 'ALBAJARI VERONICA-SERVICIOS DE EMPLEO', '', 'alaba@PORTENIO.COM', '', 1),
(24, 5, 8, 'ALFIE VIVIANA - ADMINISTRACION-CONTADURIA', '', 'VIVIANAALFIE@GMAIL.COM', '', 1),
(25, 5, 10, 'ALGACE NADIA - ADMINISTRACION-INMUEBLES', '', 'NADIAALGACE@GMAIL.COM', '', 1),
(26, 5, 27, 'AUDAY SALVADOR - SERVICIOS COMUNITARIOS', '', 'SALVADORAUDAY@GMAIL.COM', '', 1),
(27, 5, 13, 'BARANKIEWICZ IGNACIO-COCHERIA', '', 'GTERWE|@PORTENIO.COM', '', 1),
(28, 5, 28, 'CAHANSKY SERGIO - SOCIOS Y DESARROLLO', '', 'caja@PORTENIO.COM', '', 1),
(29, 5, 13, 'CAPLAN PABLO - COCHERIA', '', 'pcaplan@amia.org.ar', '', 1),
(30, 5, 28, 'CHIPRUT ANDREA - SOCIOS Y DESARROLLO', '', 'CHIPRUT@PORTENIO.COM', '', 1),
(31, 5, 29, 'COHEN IMACH ARIEL - VAAD HAJINUJ', '', 'COHEN@PORTENIO.COM', '', 1),
(33, 5, 18, 'COSTANTINI DAMIAN-INFRAESTRUCTUTA', '', 'CONS@GMAIL.COM', '', 1),
(34, 5, 21, 'CROUDO KARINA - PROGRAMAS SOCIALES', '', 'CROUDO@PORTENIO.COM', '', 1),
(35, 5, 24, 'Emanuel Cynthia Florencia-SECRETARIA INSTITUCIONAL', '', 'EMA@GMAIL.COM', '', 1),
(36, 5, 21, 'EPELBAUM ELIANA - PROGRAMAS SOCIALES', '', 'EPELBAUM@PORTENIO.COM', '', 1),
(37, 5, 18, 'FARIAS RAQUEL -INFRAESTRUCTURA', '', 'FAR@GMAIL.COM', '', 1),
(38, 5, 18, 'FELCMAN ADRIAN-INFRAESTRUCTURA', '', 'FEL@GMAIL.COM', '', 1),
(39, 5, 8, 'FINGERET NURIA - ADMINISTRACION-CONTADURIA', '', 'NURIAFINGERET@GMAIL.COM', '', 1),
(40, 5, 8, 'FLORES CLAUDIA - SERVIVIO DE EMPLEO', '', 'FLORES@PORTENIO.COM', '', 1),
(41, 5, 26, 'FRAUMAN ILEANA - SERVIVIO DE EMPLEO', '', 'FRAUMAN@PORTENIO.COM', '', 1),
(42, 5, 12, 'FREUE MIRIAN - ADMINISTRACION- COMPRAS', '', 'mfreue@amia.org.ar', '', 1),
(43, 5, 21, 'FRIDMAN SEBASTIAN - PROGRAMAS SOCIALES', '', 'FRIDMANS@PORTENIO.COM', '', 1),
(44, 5, 11, 'GALAGOVSKY TAMARA - ADMINISTRACION-TESORERIA', '', 'GALAGOVSKY@PORTENIO.COM', '', 1),
(45, 5, 25, 'GLIKIN CLAUDIO - SEGURIDAD', '', 'GLIKIN@PORTENIO.COM', '', 1),
(46, 5, 11, 'GOLDFINGER VERONICA - ADMINISTRACION-TESORERIA', '', 'r@PORTENIO.COM', '', 1),
(47, 5, 29, 'GORENSTEN KARINA-VAAD HAJINUJ', '', 'GOREN@GMAIL.COM', '', 1),
(48, 5, 10, 'GROSMAN YANINA - ADMINISTRACION-Inmuebles', '', 'VVV@PORTENIO.COM', '', 1),
(49, 5, 27, 'GRUBER JACKELINE - SERVICIOS COMUNITARIOS', '', 'SSSSS@PORTENIO.COM', '', 1),
(50, 5, 24, 'Hamra Elías Eliahu Isaac-Secretaria institucional', '', 'hamra@gmail.com', '', 1),
(51, 5, 27, 'HEISEL MARIANA - SERVICIOS COMUNITARIOS', '', 'DN@PORTENIO.COM', '', 1),
(52, 5, 13, 'JAGODA MARCELO - COCHERIA', '', 'mjagoda@amia.org.ar', '', 1),
(53, 5, 21, 'JAIT PAULA - PROGRAMAS SOCIALES', '', 'JAIT@PORTENIO.COM', '', 1),
(55, 5, 28, 'JUNOVICH SANDRA - SOCIOS Y DESARROLLO', '', 'JUNOVICH@PORTENIO.COM', '', 1),
(56, 5, 17, 'KAPSZUK ELIO - ESPACIO DE ARTE', '', 'ELIOKAPSZUK@GMAIL.COM', '', 1),
(57, 5, 21, 'KOHON FANNY - PROGRAMAS SOCIALES', '', 'FANNYKOHON@GMAIL.COM', '', 1),
(58, 5, 29, 'KOROB KARINA - VAAD HAJINUJ', '', 'KOROB@PORTENIO.COM', '', 1),
(59, 5, 13, 'KRAWIEC SILVINA', '', 'skrawiec@amia.org.ar', '', 1),
(60, 5, 7, 'KUKIOLKA TAMARA - ADMINISTRACION-SISTEMA', '', 'TAMARAKUKIOLKA@GMAIL.COM', '', 1),
(61, 5, 18, 'KUPFERMAN MARCELO-INFRAESTRUCTURA', '', 'KUPFERMAN@GMAIL.COM', '', 1),
(62, 5, 24, 'LANIADO ANDREA-SECRETARIA INSTITUCIONAL', '', 'LAN@GMAIL.COM', '', 1),
(63, 5, 29, 'LEWIN SANDRA - VAAD HAJINUJ', '', 'LEWIN@PORTENIO.COM', '', 1),
(64, 5, 9, 'LIBERMAN MARIO - ADMINISTRACION-DOCUMENTOS', '', 'ertoamarcogliese@PORTENIO.COM', '', 1),
(65, 5, 23, 'LLERNOVOY KARINA - RECURSOS HUMANOS', '', 'LLERNOVOYK@PORTENIO.COM', '', 1),
(66, 5, 21, 'LOKAJ DAMIAN - PROGRAMAS SOCIALES', '', 'DAMIANLOKAJ@GMAIL.COM', '', 1),
(67, 5, 13, 'LUKACHER MARTIN - COCHERIA', '', 'LUKACHER@PORTENIO.COM', '', 1),
(68, 5, 13, 'MILINKIEWICZ HERNAN - COCHERIA', '', 'DQA@PORTENIO.COM', '', 1),
(69, 5, 21, 'MIZRAHI XIMENA - PROGRAMAS SOCIALES', '', 'MIZRAHI@PORTENIO.COM', '', 1),
(70, 5, 7, 'MOHADEB SALOMON - ADMINISTRACION-SISTEMA', '', 'SALOMONMOHADEB@GMAIL.COM', '', 1),
(71, 5, 8, 'MOSER MARINA - ADMINISTRACION-CONTADURIA', '', 'MARINAMOSER@GMAIL.COM', '', 1),
(72, 5, 18, 'MOYA FLAVIO-INFRAESTRUCTURA', '', 'MOY@GMAIL.COM', '', 1),
(73, 5, 21, 'NAHUM AYLEN - PROGRAMAS SOCIALES', '', 'NAHUM@PORTENIO.COM', '', 1),
(74, 5, 29, 'PALEY KARINA - VAAD HAJINUJ', '', 'PALEY@PORTENIO.COM', '', 1),
(75, 5, 29, 'PALUCH LILI-VAAD HAJINUJ', '', 'PALUCH@GMAIL.COM', '', 1),
(76, 5, 18, 'PARED RAMON -INFRAESTRUCTURA', '', 'PAR@GMAIL.COM', '', 1),
(77, 5, 26, 'PASARELLI FERNANDO - SERVIVIO DE EMPLEO', '', 'PASARELLI@PORTENIO.COM', '', 1),
(78, 5, 14, 'PIESKE MARCELA - COMUNICACIÓN y PRENSA', '', 'MARCELAPIESKE@GMAIL.COM', '', 1),
(79, 5, 16, 'POMERANTZ DANIEL - DIRECCION EJECUTIVA', '', 'POMERANTZ@PORTENIO.COM', '', 1),
(80, 5, 8, 'POMPAS KAREN - ADMINISTRACION-CONTADURIA', '', 'KARENPOMPAS@GMAIL.COM', '', 1),
(81, 5, 21, 'RACHILEVICH JULIETA - PROGRAMAS SOCIALES', '', 'RACHILEVICH@PORTENIO.COM', '', 1),
(82, 5, 16, 'RONIT BOREN - DIRECCION EJECUTIVA', '', 'RONIT@PORTENIO.COM', '', 1),
(83, 5, 13, 'SABAJ SERGIO', '', 'SSABAJ@AMIA.ORG.AR', '', 1),
(84, 5, 28, 'SALEM MARIANA - SOCIOS Y DESARROLLO', '', 'SALEM@PORTENIO.COM', '', 1),
(85, 5, 14, 'SAMSOLO VANESA - COMUNICACIÓN', '', 'BHGG@PORTENIO.COM', '', 1),
(86, 5, 14, 'SCHERMAN GABRIEL - COMUNICACIÓN', '', 'DDDDDDD@PORTENIO.COM', '', 1),
(87, 5, 17, 'SCHRAIER NADIA - ESPACIO DE ARTE', '', 'SCHRAIER@PORTENIO.COM', '', 1),
(88, 5, 21, 'SCHUSTER BARBARA - PROGRAMAS SOCIALES', '', 'shuster@PORTENIO.COM', '', 1),
(89, 5, 14, 'STARK MATIAS - COMUNICACIÓN', '', 'STARKAMATIAS@GMAIL.COM', '', 1),
(90, 5, 21, 'TABOADA CONSTANZA - PROGRAMAS SOCIALES', '', 'CONSTANZATABOADA@GMAIL.COM', '', 1),
(91, 5, 21, 'VENTURA JULI - PROGRAMAS SOCIALES', '', 'VENTURA@PORTENIO.COM', '', 1),
(92, 5, 20, 'ZALCMAN FLAVIA - JUVENTUD', '', 'ZALCMAN@PORTENIO.COM', '', 1),
(93, 5, 30, 'COHEN MARCOS -VAAD HAKEHILOT', '', 'COHENNAR@GMAIL.COM', '', 1),
(94, 5, 30, 'JATEMLIANSKY TAMARA -VAAD HAKEHILOT', '', 'cogliese@PORTENIO.COM', '', 1),
(95, 1, 2, 'Fabian', '1169356236', 'fabian_12345@hotmail.com', '8 a 12', 1);

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
(1, 999, 999, 'Paganini', 'Carlos Gardel 3296', '', 0, ''),
(2, 1, 1, 'Frente', 'Venezuela 4488', '', 0, 'Casa'),
(5, 3, 3, 'ALEGRE EN FLOR', 'Av. Cordoba 1776', '', 0, ''),
(6, 4, 1, 'ALGEIBA S.A.', 'PARANA 771 1Âº B', '', 0, ''),
(7, 5, 1, 'ADMINISTARCION SISTEMAS', 'Pasteur 633', '', 0, ''),
(8, 5, 2, 'ADMINISTRACION CONTADURIA', 'Pasteur 633', '', 0, ''),
(9, 5, 3, 'ADMINISTRACION DOCUMENTOS', 'Pasteur 633', '', 0, ''),
(10, 5, 4, 'ADMINISTRACION INMUEBLES', 'Pasteur 633', '', 0, ''),
(11, 5, 5, 'ADMINISTRACION TESORERIA', 'Pasteur 633', '', 0, ''),
(12, 5, 6, 'ADMINNISTRACION COMPRAS', 'Pasteur 633', '', 0, ''),
(13, 5, 7, 'COCHERIA', 'Pasteur 735', '', 0, ''),
(14, 5, 8, 'COMUNICACIONES', 'PASTEUR 735', '', 0, ''),
(15, 5, 9, 'CULTURA', 'PASTEUR 735', '', 0, ''),
(16, 5, 10, 'DIRECCION EJECUTIVA', 'PASTEUR 735', '', 0, ''),
(17, 5, 11, 'ESPACIO DE ARTE', 'PASTEUR 735', '', 0, ''),
(18, 5, 12, 'INFRAESTRUCTURA', 'Pasteur 633', '', 0, ''),
(19, 5, 13, 'JUBILADOS', 'URIBURU 650', '', 0, ''),
(20, 5, 14, 'JUVENTUD', 'PASTEUR 735', '', 0, ''),
(21, 5, 15, 'PROGRAMA SOCIALES', 'PASTEUR 735', '', 0, ''),
(22, 5, 16, 'RABINATO', 'PASTEUR 735', '', 0, ''),
(23, 5, 17, 'RECURSOS HUMANOS', 'PASTEUR 675', '', 0, ''),
(24, 5, 18, 'SECRETARIA INSTITUCIONAL', 'PASTEUR 735', '', 0, ''),
(25, 5, 19, 'SEGURIDAD', 'PASTEUR 735', '', 0, ''),
(26, 5, 20, 'SERVICIO DE EMPLEO', 'PASTEUR 735', '', 0, ''),
(27, 5, 21, 'SERVICIOS COMUNITARIOS', 'PASTEUR 735', '', 0, ''),
(28, 5, 22, '	SOCIOS Y DESARROLLO', 'PASTEUR 735', '', 0, ''),
(29, 5, 23, 'VAAD HAJINUJ', 'PASTEUR 735', '', 0, ''),
(30, 5, 24, '	VAAD HAKEHILOT', 'Pasteur 633', '', 0, '');

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
(3, 14, 'ALEGRE EN FLOR', 'FELIPE VALLESE 501-CABA', '27920804867', '27920804867', NULL, NULL, 0),
(4, 5032, 'ALGEIBA S.A.', 'PARANA 771 1Âº B', '20129904187', NULL, NULL, NULL, 0),
(5, 17, 'AMIA', 'Pasteur 633', '33333334532', NULL, NULL, NULL, 0);

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

--
-- Volcado de datos para la tabla `ubicaciones`
--

INSERT INTO `ubicaciones` (`id`, `lat`, `lng`, `user_id`, `device_id`, `fecha`) VALUES
(242, '-34.6472650', '-58.4580445', 'usuario2', '05.008', '2026-04-29 12:42:44'),
(243, '-34.6473177', '-58.4580516', 'usuario2', '05.008', '2026-04-29 12:42:49'),
(245, '-34.6472948', '-58.4580255', 'usuario17', '05.0071', '2026-04-29 12:42:59'),
(246, '-34.6473331', '-58.4580315', 'usuario17', '05.0071', '2026-04-29 12:43:04'),
(253, '-34.6472550', '-58.4581008', 'usuario11', '05.011', '2026-04-29 12:43:57'),
(254, '-34.6472648', '-58.4581008', 'usuario11', '05.011', '2026-04-29 12:44:01'),
(255, '-34.6472755', '-58.4580973', 'usuario1', '05.007', '2026-04-29 12:44:06'),
(256, '-34.6473067', '-58.4580823', 'usuario1', '05.007', '2026-04-29 12:44:11'),
(257, '-34.6473281', '-58.4580716', 'usuario1', '05.007', '2026-04-29 12:44:16'),
(258, '-34.6473153', '-58.4580683', 'usuario1', '05.007', '2026-04-29 12:44:21'),
(259, '-34.6472584', '-58.4580887', 'usuario1', '05.007', '2026-04-29 12:54:59'),
(260, '-34.6472343', '-58.4580851', 'usuario1', '05.007', '2026-04-29 12:55:28'),
(261, '-34.6472463', '-58.4580818', 'usuario1', 'ABC123', '2026-04-29 12:56:48'),
(262, '-34.6472463', '-58.4580818', 'usuario1', 'ABC123', '2026-04-29 12:56:49'),
(263, '-34.6473122', '-58.4581683', 'usuario1', 'ABC123', '2026-04-29 12:57:43'),
(264, '-34.6473980', '-58.4582067', 'usuario1', 'ABC123', '2026-04-29 12:57:49'),
(265, '-34.6472473', '-58.4580860', 'usuario1', 'ABC123', '2026-04-29 12:58:18'),
(266, '-34.6472473', '-58.4580860', 'usuario1', 'ABC123', '2026-04-29 12:58:24'),
(267, '-34.6473032', '-58.4581728', 'usuario1', 'ABC123', '2026-04-29 12:58:41'),
(268, '-34.6472724', '-58.4580644', 'usuario1', 'ABC123', '2026-04-29 12:59:17'),
(269, '-34.6472074', '-58.4579858', 'usuario1', 'ABC123', '2026-04-29 12:59:32'),
(270, '-34.6472484', '-58.4580852', 'usuario1', 'ABC123', '2026-04-29 13:08:09'),
(271, '-34.6472643', '-58.4580833', 'usuario1', 'ABC123', '2026-04-29 13:15:09'),
(272, '-34.6472520', '-58.4580840', 'usuario1', 'ABC123', '2026-04-29 13:15:16'),
(273, '-34.6472405', '-58.4580953', 'usuario1', 'ABC123', '2026-04-29 13:15:29'),
(274, '-34.6474092', '-58.4581265', 'usuario1', 'ABC123', '2026-04-29 13:15:34'),
(275, '-34.6473752', '-58.4581166', 'usuario1', 'ABC123', '2026-04-29 13:15:36'),
(276, '-34.6472628', '-58.4580964', 'usuario1', 'ABC123', '2026-04-29 13:16:29'),
(277, '-34.6472069', '-58.4580859', 'usuario1', 'ABC123', '2026-04-29 13:19:08'),
(278, '-34.6472069', '-58.4580859', 'usuario1', 'ABC123', '2026-04-29 13:19:09'),
(279, '-34.6472620', '-58.4580822', 'usuario1', 'ABC123', '2026-04-29 13:43:49'),
(280, '-34.6473656', '-58.4581004', 'usuario1', 'ABC123', '2026-04-29 13:44:22'),
(281, '-34.6474310', '-58.4581935', 'usuario1', 'ABC123', '2026-04-29 13:44:29'),
(282, '-34.6472486', '-58.4580996', 'usuario1', 'ABC123', '2026-04-29 13:48:12'),
(283, '-34.6468468', '-58.4593068', 'movil999', 'ABC123', '2026-04-29 14:09:22'),
(284, '-34.6467762', '-58.4595430', 'movil999', 'ABC123', '2026-04-29 14:09:27'),
(285, '-34.6467507', '-58.4596412', 'movil999', 'ABC123', '2026-04-29 14:09:32'),
(286, '-34.6469098', '-58.4591722', 'movil999', 'ABC123', '2026-04-29 14:09:38'),
(287, '-34.6472260', '-58.4582561', 'movil999', 'ABC123', '2026-04-29 14:09:43'),
(288, '-34.6472367', '-58.4581429', 'movil999', 'ABC123', '2026-04-29 14:09:53'),
(289, '-34.6472510', '-58.4580254', 'movil999', 'ABC123', '2026-04-29 14:10:19'),
(290, '-34.6472418', '-58.4581072', '9999', 'ABC456', '2026-04-29 14:12:17'),
(291, '-34.6472041', '-58.4580064', '9999', 'ABC456', '2026-04-29 14:12:32'),
(292, '-34.6472021', '-58.4578473', '9999', 'ABC456', '2026-04-29 14:12:37'),
(293, '-34.6472036', '-58.4579589', '9999', 'ABC456', '2026-04-29 14:12:52'),
(294, '-34.6472572', '-58.4580787', '9999', 'ABC456', '2026-04-29 14:18:19'),
(295, '-34.6472572', '-58.4580787', '9999', 'ABC456', '2026-04-29 14:18:24');

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
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `autorizantes`
--
ALTER TABLE `autorizantes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT de la tabla `centros_costo`
--
ALTER TABLE `centros_costo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `choferes`
--
ALTER TABLE `choferes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cuenta_empresa`
--
ALTER TABLE `cuenta_empresa`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `pasajeros_cc`
--
ALTER TABLE `pasajeros_cc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=296;

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
