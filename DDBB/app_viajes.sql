-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-06-2026 a las 21:49:42
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
-- Estructura de tabla para la tabla `00_ubicaciones`
--

CREATE TABLE `00_ubicaciones` (
  `id` int(11) NOT NULL,
  `lat` decimal(10,8) DEFAULT NULL,
  `lng` decimal(11,8) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `usuario_id` varchar(50) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `00_ubicaciones`
--

INSERT INTO `00_ubicaciones` (`id`, `lat`, `lng`, `status`, `usuario_id`, `fecha`) VALUES
(1, '-34.64725710', '-58.45808430', 'activo', 'Chofer_01', '2026-04-24 15:47:45'),
(2, '-34.64725710', '-58.45808430', 'inactivo', 'Chofer_01', '2026-04-24 15:47:46'),
(3, '-34.64725710', '-58.45808430', 'inactivo', 'Chofer_01', '2026-04-24 15:47:46'),
(4, '-34.64725710', '-58.45808430', 'inactivo', 'Chofer_01', '2026-04-24 15:47:47'),
(5, '-34.64725780', '-58.45808790', 'activo', 'Chofer_01', '2026-04-24 15:55:14'),
(6, '-34.64725780', '-58.45808790', 'activo', 'Chofer_01', '2026-04-24 15:55:18'),
(7, '-34.64725830', '-58.45808390', 'activo', 'Chofer_01', '2026-04-24 15:55:22'),
(8, '-34.64726200', '-58.45808210', 'inactivo', 'Chofer_01', '2026-04-24 15:55:25'),
(9, '-34.64726200', '-58.45808210', 'inactivo', 'Chofer_01', '2026-04-24 15:55:26'),
(10, '-34.64726200', '-58.45808210', 'inactivo', 'Chofer_01', '2026-04-24 15:55:26'),
(11, '-34.64726250', '-58.45808210', 'activo', 'Chofer_01', '2026-04-24 15:55:51'),
(12, '-34.64726250', '-58.45808210', 'activo', 'Chofer_01', '2026-04-24 15:55:55'),
(13, '-34.64726300', '-58.45808230', 'activo', 'Chofer_01', '2026-04-24 15:56:01'),
(14, '-34.64726300', '-58.45808230', 'inactivo', 'Chofer_01', '2026-04-24 15:56:02'),
(15, '-34.64726300', '-58.45808230', 'inactivo', 'Chofer_01', '2026-04-24 15:56:02'),
(16, '-34.64726300', '-58.45808230', 'inactivo', 'Chofer_01', '2026-04-24 15:56:03'),
(17, '-34.64725550', '-58.45809090', 'activo', 'Chofer_01', '2026-04-24 16:03:46'),
(18, '-34.64725550', '-58.45809090', 'activo', 'Chofer_01', '2026-04-24 16:03:49'),
(19, '-34.64725230', '-58.45807790', 'activo', 'Chofer_01', '2026-04-24 16:03:55'),
(20, '-34.64725230', '-58.45807790', 'activo', 'Chofer_01', '2026-04-24 16:03:59'),
(21, '-34.64726030', '-58.45809810', 'activo', 'Chofer_01', '2026-04-24 16:04:05'),
(22, '-34.64726030', '-58.45809810', 'activo', 'Chofer_01', '2026-04-24 16:04:09'),
(23, '-34.64724350', '-58.45809210', 'activo', 'Chofer_01', '2026-04-24 16:04:15'),
(24, '-34.64724350', '-58.45809210', 'activo', 'Chofer_01', '2026-04-24 16:04:19'),
(25, '-34.64725620', '-58.45808150', 'activo', 'Chofer_01', '2026-04-24 16:04:25'),
(26, '-34.64725620', '-58.45808150', 'activo', 'Chofer_01', '2026-04-24 16:04:29'),
(27, '-34.64725330', '-58.45810740', 'activo', 'Chofer_01', '2026-04-24 16:04:35'),
(28, '-34.64725330', '-58.45810740', 'inactivo', 'Chofer_01', '2026-04-24 16:04:39'),
(29, '-34.64725330', '-58.45810740', 'inactivo', 'Chofer_01', '2026-04-24 16:04:39'),
(30, '-34.64725330', '-58.45810740', 'inactivo', 'Chofer_01', '2026-04-24 16:04:40'),
(31, '-34.64724840', '-58.45809020', 'activo', 'Chofer_01', '2026-04-24 16:05:36'),
(32, '-34.64724840', '-58.45809020', 'activo', 'Chofer_01', '2026-04-24 16:05:40'),
(33, '-34.64724840', '-58.45809020', 'inactivo', 'Chofer_01', '2026-04-24 16:05:41'),
(34, '-34.64724840', '-58.45809020', 'inactivo', 'Chofer_01', '2026-04-24 16:05:42'),
(35, '-34.64724840', '-58.45809020', 'inactivo', 'Chofer_01', '2026-04-24 16:05:43'),
(36, '-34.64723020', '-58.45809820', 'activo', 'Chofer_01', '2026-04-24 16:05:56'),
(37, '-34.64723020', '-58.45809820', 'activo', 'Chofer_01', '2026-04-24 16:06:00'),
(38, '-34.64723580', '-58.45809470', 'activo', 'Chofer_01', '2026-04-24 16:06:06'),
(39, '-34.64723580', '-58.45809470', 'inactivo', 'Chofer_01', '2026-04-24 16:06:09'),
(40, '-34.64723580', '-58.45809470', 'inactivo', 'Chofer_01', '2026-04-24 16:06:10'),
(41, '-34.64723580', '-58.45809470', 'inactivo', 'Chofer_01', '2026-04-24 16:06:10'),
(42, '-34.64725360', '-58.45808320', 'activo', 'Chofer_01', '2026-04-24 16:11:54'),
(43, '-34.64725360', '-58.45808320', 'activo', 'Chofer_01', '2026-04-24 16:11:58'),
(44, '-34.64726600', '-58.45809000', 'activo', 'Chofer_01', '2026-04-24 16:12:04'),
(45, '-34.64726600', '-58.45809000', 'inactivo', 'Chofer_01', '2026-04-24 16:12:04'),
(46, '-34.64726600', '-58.45809000', 'inactivo', 'Chofer_01', '2026-04-24 16:12:05'),
(47, '-34.64726600', '-58.45809000', 'inactivo', 'Chofer_01', '2026-04-24 16:12:05'),
(48, '-34.64726630', '-58.45808550', 'activo', 'Chofer_01', '2026-04-24 16:13:38'),
(49, '-34.64726630', '-58.45808550', 'activo', 'Chofer_01', '2026-04-24 16:13:42'),
(50, '-34.64725280', '-58.45808660', 'inactivo', 'Chofer_01', '2026-04-24 16:13:46'),
(51, '-34.64725280', '-58.45808660', 'inactivo', 'Chofer_01', '2026-04-24 16:13:47'),
(52, '-34.64725280', '-58.45808660', 'inactivo', 'Chofer_01', '2026-04-24 16:13:48'),
(53, '-34.64725660', '-58.45809120', 'activo', 'Chofer_01', '2026-04-24 16:18:20'),
(54, '-34.64725660', '-58.45809120', 'inactivo', 'Chofer_01', '2026-04-24 16:18:22'),
(55, '-34.64725660', '-58.45809120', 'inactivo', 'Chofer_01', '2026-04-24 16:18:23'),
(56, '-34.64725660', '-58.45809120', 'inactivo', 'Chofer_01', '2026-04-24 16:18:24'),
(57, '-34.64726680', '-58.45808290', 'activo', 'Chofer_01', '2026-04-24 17:22:51'),
(58, '-34.64726680', '-58.45808290', 'activo', 'Chofer_01', '2026-04-24 17:22:54'),
(59, '-34.64726650', '-58.45809270', 'inactivo', 'Chofer_01', '2026-04-24 17:22:59'),
(60, '-34.64726650', '-58.45809270', 'inactivo', 'Chofer_01', '2026-04-24 17:23:00'),
(61, '-34.64726650', '-58.45809270', 'inactivo', 'Chofer_01', '2026-04-24 17:23:00'),
(62, '-34.64725180', '-58.45808090', 'activo', 'Chofer_01', '2026-04-24 17:24:12'),
(63, '-34.64725180', '-58.45808090', 'activo', 'Chofer_01', '2026-04-24 17:24:16'),
(64, '-34.64726200', '-58.45807340', 'activo', 'Chofer_01', '2026-04-24 17:24:22'),
(65, '-34.64726200', '-58.45807340', 'activo', 'Chofer_01', '2026-04-24 17:24:26'),
(66, '-34.64726420', '-58.45808620', 'activo', 'Chofer_01', '2026-04-24 17:24:32'),
(67, '-34.64726420', '-58.45808620', 'activo', 'Chofer_01', '2026-04-24 17:24:36'),
(68, '-34.64725810', '-58.45808680', 'activo', 'Chofer_01', '2026-04-24 17:24:42'),
(69, '-34.64725810', '-58.45808680', 'activo', 'Chofer_01', '2026-04-24 17:24:46'),
(70, '-34.64725600', '-58.45808880', 'activo', 'Chofer_01', '2026-04-24 17:24:52'),
(71, '-34.64725600', '-58.45808880', 'activo', 'Chofer_01', '2026-04-24 17:24:56'),
(72, '-34.64725900', '-58.45808640', 'activo', 'Chofer_01', '2026-04-24 17:25:02'),
(73, '-34.64725900', '-58.45808640', 'activo', 'Chofer_01', '2026-04-24 17:25:06'),
(74, '-34.64725040', '-58.45808560', 'activo', 'Chofer_01', '2026-04-24 17:25:12'),
(75, '-34.64725040', '-58.45808560', 'inactivo', 'Chofer_01', '2026-04-24 17:25:16'),
(76, '-34.64725040', '-58.45808560', 'inactivo', 'Chofer_01', '2026-04-24 17:25:17'),
(77, '-34.64724880', '-58.45807090', 'inactivo', 'Chofer_01', '2026-04-24 17:25:18'),
(78, '-34.64724880', '-58.45807090', 'activo', 'Chofer_01', '2026-04-24 17:25:20'),
(79, '-34.64726090', '-58.45807660', 'activo', 'Chofer_01', '2026-04-24 17:25:26'),
(80, '-34.64726090', '-58.45807660', 'inactivo', 'Chofer_01', '2026-04-24 17:25:26'),
(81, '-34.64726090', '-58.45807660', 'inactivo', 'Chofer_01', '2026-04-24 17:25:27'),
(82, '-34.64726090', '-58.45807660', 'inactivo', 'Chofer_01', '2026-04-24 17:25:27'),
(83, '-34.64726840', '-58.45809360', 'activo', 'Chofer_01', '2026-04-24 17:28:48'),
(84, '-34.64726840', '-58.45809360', 'inactivo', 'Chofer_01', '2026-04-24 17:28:48'),
(85, '-34.64726840', '-58.45809360', 'inactivo', 'Chofer_01', '2026-04-24 17:28:48'),
(86, '-34.64726840', '-58.45809360', 'inactivo', 'Chofer_01', '2026-04-24 17:28:49'),
(87, '-34.64726840', '-58.45809360', 'activo', 'Chofer_01', '2026-04-24 17:34:00'),
(88, '-34.64724750', '-58.45806660', 'activo', 'Chofer_01', '2026-04-24 17:34:05'),
(89, '-34.64727670', '-58.45803050', 'inactivo', 'Chofer_01', '2026-04-24 17:34:08'),
(90, '-34.64726970', '-58.45802290', 'inactivo', 'Chofer_01', '2026-04-24 17:34:09'),
(91, '-34.64726970', '-58.45802290', 'inactivo', 'Chofer_01', '2026-04-24 17:34:10'),
(92, '-34.64726970', '-58.45802290', 'activo', 'Chofer_01', '2026-04-24 17:34:12'),
(93, '-34.64739090', '-58.45816590', 'activo', 'Chofer_01', '2026-04-24 17:34:48'),
(94, '-34.64739090', '-58.45816590', 'activo', 'Chofer_01', '2026-04-24 17:34:48'),
(95, '-34.64739090', '-58.45816590', 'inactivo', 'Chofer_01', '2026-04-24 17:34:50'),
(96, '-34.64739090', '-58.45816590', 'inactivo', 'Chofer_01', '2026-04-24 17:34:50'),
(97, '-34.64739090', '-58.45816590', 'inactivo', 'Chofer_01', '2026-04-24 17:34:51'),
(98, '-34.64739090', '-58.45816590', 'activo', 'Chofer_01', '2026-04-24 17:34:52'),
(99, '-34.64728210', '-58.45810570', 'activo', 'Chofer_01', '2026-04-24 17:34:58'),
(100, '-34.64728210', '-58.45810570', 'inactivo', 'Chofer_01', '2026-04-24 17:34:59'),
(101, '-34.64728210', '-58.45810570', 'inactivo', 'Chofer_01', '2026-04-24 17:34:59'),
(102, '-34.64728210', '-58.45810570', 'inactivo', 'Chofer_01', '2026-04-24 17:35:00'),
(103, '-34.64725990', '-58.45808100', 'activo', 'Chofer_01', '2026-04-24 17:51:40'),
(104, '-34.64725920', '-58.45808980', 'inactivo', 'Chofer_01', '2026-04-24 17:51:45'),
(105, '-34.64725920', '-58.45808980', 'inactivo', 'Chofer_01', '2026-04-24 17:51:46'),
(106, '-34.64725920', '-58.45808980', 'inactivo', 'Chofer_01', '2026-04-24 17:51:47'),
(107, '-34.64725930', '-58.45808300', 'activo', 'Chofer_01', '2026-04-24 17:52:00'),
(108, '-34.64725930', '-58.45808300', 'inactivo', 'Chofer_01', '2026-04-24 17:52:04'),
(109, '-34.64725930', '-58.45808300', 'inactivo', 'Chofer_01', '2026-04-24 17:52:05'),
(110, '-34.64723460', '-58.45808720', 'inactivo', 'Chofer_01', '2026-04-24 17:52:05'),
(111, '-34.64726140', '-58.45808170', 'activo', 'Chofer_01', '2026-04-24 17:52:14'),
(112, '-34.64723500', '-58.45810400', 'activo', 'Chofer_01', '2026-04-24 17:52:38'),
(113, '-34.64728430', '-58.45807510', 'inactivo', 'Chofer_01', '2026-04-24 17:52:41'),
(114, '-34.64728430', '-58.45807510', 'inactivo', 'Chofer_01', '2026-04-24 17:52:42'),
(115, '-34.64728430', '-58.45807510', 'activo', 'Chofer_01', '2026-04-24 17:52:42'),
(116, '-34.64728430', '-58.45807510', 'inactivo', 'Chofer_01', '2026-04-24 17:52:42'),
(117, '-34.64725300', '-58.45806460', 'activo', 'Chofer_01', '2026-04-24 17:52:47'),
(118, '-34.64725300', '-58.45806460', 'activo', 'Chofer_01', '2026-04-24 17:52:52'),
(119, '-34.64725370', '-58.45808760', 'inactivo', 'Chofer_01', '2026-04-24 17:52:58'),
(120, '-34.64725370', '-58.45808760', 'inactivo', 'Chofer_01', '2026-04-24 17:52:58'),
(121, '-34.64725370', '-58.45808760', 'inactivo', 'Chofer_01', '2026-04-24 17:52:59'),
(122, '-34.64725720', '-58.45808770', 'activo', 'Chofer_01', '2026-04-24 17:58:54'),
(123, '-34.64725720', '-58.45808770', 'activo', 'Chofer_01', '2026-04-24 17:58:57'),
(124, '-34.64725720', '-58.45808770', 'inactivo', 'Chofer_01', '2026-04-24 17:58:58'),
(125, '-34.64725720', '-58.45808770', 'inactivo', 'Chofer_01', '2026-04-24 17:58:59'),
(126, '-34.64725720', '-58.45808770', 'inactivo', 'Chofer_01', '2026-04-24 17:59:00'),
(127, '-34.64725790', '-58.45808040', 'activo', 'Chofer_01', '2026-04-24 17:59:37'),
(128, '-34.64725790', '-58.45808040', 'activo', 'Chofer_01', '2026-04-24 17:59:41'),
(129, '-34.64726040', '-58.45807970', 'inactivo', 'Chofer_01', '2026-04-24 17:59:45'),
(130, '-34.64726040', '-58.45807970', 'inactivo', 'Chofer_01', '2026-04-24 17:59:46'),
(131, '-34.64726040', '-58.45807970', 'inactivo', 'Chofer_01', '2026-04-24 17:59:46'),
(132, '-34.64725870', '-58.45808060', 'activo', 'Chofer_01', '2026-04-24 18:02:10'),
(133, '-34.64725870', '-58.45808060', 'inactivo', 'Chofer_01', '2026-04-24 18:02:13'),
(134, '-34.64725870', '-58.45808060', 'inactivo', 'Chofer_01', '2026-04-24 18:02:14'),
(135, '-34.64725870', '-58.45808060', 'inactivo', 'Chofer_01', '2026-04-24 18:02:15'),
(136, '-34.64725870', '-58.45808060', 'activo', 'Chofer_01', '2026-04-24 18:02:18'),
(137, '-34.64725960', '-58.45808900', 'activo', 'Chofer_01', '2026-04-24 18:05:13'),
(138, '-34.64725960', '-58.45808900', 'activo', 'Chofer_01', '2026-04-24 18:05:13'),
(139, '-34.64725960', '-58.45808900', 'activo', 'Chofer_01', '2026-04-24 18:05:14'),
(140, '-34.64725960', '-58.45808900', 'activo', 'Chofer_01', '2026-04-24 18:05:14'),
(141, '-34.64725960', '-58.45808900', 'activo', 'Chofer_01', '2026-04-24 18:05:14'),
(142, '-34.64725960', '-58.45808900', 'activo', 'Chofer_01', '2026-04-24 18:05:14'),
(143, '-34.64725960', '-58.45808900', 'activo', 'Chofer_01', '2026-04-24 18:05:14'),
(144, '-34.64725960', '-58.45808900', 'activo', 'Chofer_01', '2026-04-24 18:05:14'),
(145, '-34.64725960', '-58.45808900', 'activo', 'Chofer_01', '2026-04-24 18:05:14'),
(146, '-34.64725960', '-58.45808900', 'activo', 'Chofer_01', '2026-04-24 18:05:14'),
(147, '-34.64725960', '-58.45808900', 'activo', 'Chofer_01', '2026-04-24 18:05:15'),
(148, '-34.64725960', '-58.45808900', 'activo', 'Chofer_01', '2026-04-24 18:05:14'),
(149, '-34.64725960', '-58.45808900', 'activo', 'Chofer_01', '2026-04-24 18:05:15'),
(150, '-34.64725960', '-58.45808900', 'activo', 'Chofer_01', '2026-04-24 18:05:15'),
(151, '-34.64725960', '-58.45808900', 'activo', 'Chofer_01', '2026-04-24 18:05:15'),
(152, '-34.64725960', '-58.45808900', 'inactivo', 'Chofer_01', '2026-04-24 18:05:15'),
(153, '-34.64725960', '-58.45808900', 'inactivo', 'Chofer_01', '2026-04-24 18:05:16'),
(154, '-34.64725960', '-58.45808900', 'inactivo', 'Chofer_01', '2026-04-24 18:05:17'),
(155, '-34.64730610', '-58.45798560', 'activo', 'Chofer_01', '2026-04-24 18:05:21'),
(156, '-34.64740350', '-58.45788380', 'inactivo', 'Chofer_01', '2026-04-24 18:05:23'),
(157, '-34.64740350', '-58.45788380', 'inactivo', 'Chofer_01', '2026-04-24 18:05:24'),
(158, '-34.64734880', '-58.45795950', 'inactivo', 'Chofer_01', '2026-04-24 18:05:25'),
(159, '-34.64734880', '-58.45795950', 'activo', 'Chofer_01', '2026-04-24 18:05:29'),
(160, '-34.64741050', '-58.45789020', 'inactivo', 'Chofer_01', '2026-04-24 18:05:34'),
(161, '-34.64741050', '-58.45789020', 'inactivo', 'Chofer_01', '2026-04-24 18:05:35'),
(162, '-34.64741050', '-58.45789020', 'inactivo', 'Chofer_01', '2026-04-24 18:05:36'),
(163, '-34.64741050', '-58.45789020', 'activo', 'Chofer_01', '2026-04-24 18:05:38'),
(164, '-34.64725980', '-58.45808790', 'inactivo', 'Chofer_01', '2026-04-24 18:06:06'),
(165, '-34.64725980', '-58.45808790', 'inactivo', 'Chofer_01', '2026-04-24 18:06:06'),
(166, '-34.64725980', '-58.45808790', 'activo', 'Chofer_01', '2026-04-24 18:06:07'),
(167, '-34.64725980', '-58.45808790', 'inactivo', 'Chofer_01', '2026-04-24 18:06:07'),
(168, '-34.64725180', '-58.45808320', 'activo', 'Chofer_01', '2026-04-24 18:06:13'),
(169, '-34.64725180', '-58.45808320', 'activo', 'Chofer_01', '2026-04-24 18:06:17'),
(170, '-34.64726650', '-58.45809270', 'activo', 'Chofer_01', '2026-04-24 18:06:47'),
(171, '-34.64725300', '-58.45809320', 'activo', 'Chofer_01', '2026-04-24 18:06:53'),
(172, '-34.64725300', '-58.45809320', 'activo', 'Chofer_01', '2026-04-24 18:06:57'),
(173, '-34.64725220', '-58.45808310', 'activo', 'Chofer_01', '2026-04-24 18:07:03'),
(174, '-34.64725220', '-58.45808310', 'activo', 'Chofer_01', '2026-04-24 18:07:07'),
(175, '-34.64727140', '-58.45809020', 'activo', 'Chofer_01', '2026-04-24 18:07:13'),
(176, '-34.64727140', '-58.45809020', 'activo', 'Chofer_01', '2026-04-24 18:07:17'),
(177, '-34.64725260', '-58.45808030', 'activo', 'Chofer_01', '2026-04-24 18:07:23'),
(178, '-34.64725260', '-58.45808030', 'activo', 'Chofer_01', '2026-04-24 18:07:27'),
(179, '-34.64725490', '-58.45807680', 'activo', 'Chofer_01', '2026-04-24 18:07:33'),
(180, '-34.64725490', '-58.45807680', 'activo', 'Chofer_01', '2026-04-24 18:07:37'),
(181, '-34.64725540', '-58.45808780', 'activo', 'Chofer_01', '2026-04-24 18:07:43'),
(182, '-34.64725540', '-58.45808780', 'activo', 'Chofer_01', '2026-04-24 18:07:47'),
(183, '-34.64726010', '-58.45808560', 'activo', 'Chofer_01', '2026-04-24 18:07:53'),
(184, '-34.64726010', '-58.45808560', 'activo', 'Chofer_01', '2026-04-24 18:07:57'),
(185, '-34.64724730', '-58.45809320', 'activo', 'Chofer_01', '2026-04-24 18:08:03'),
(186, '-34.64724730', '-58.45809320', 'activo', 'Chofer_01', '2026-04-24 18:08:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autorizantes_cc`
--

CREATE TABLE `autorizantes_cc` (
  `id` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `id_cc` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `celular` varchar(30) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `horario` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `autorizantes_cc`
--

INSERT INTO `autorizantes_cc` (`id`, `id_empresa`, `id_cc`, `nombre`, `celular`, `email`, `horario`) VALUES
(11, 12, 24, 'Alegre Maria Florencia', '', 'aleflor@gmail.com', ''),
(13, 12, 24, 'Giles Juan Manuel', '', 'alegilesj@gmail.com', ''),
(14, 12, 24, 'Giles Pablo andres', '', 'alegi@gmail.com', ''),
(15, 12, 24, 'Perussetti Zully Elisa', '', 'aleperu@gmail.com', ''),
(16, 13, 26, 'CARNAU MAZZEI SABRINA', '', 'HHH@PORTENIO.COM', ''),
(17, 13, 26, 'ESTEVEZ EMILIANO', '', 'C@PORTENIO.COM', ''),
(18, 13, 26, 'MASTRANGELO PABLO', '', 'B@PORTENIO.COM', ''),
(19, 13, 26, 'MAZZINI	ALEJANDRA', '', 'mazini@PORTENIO.COM', ''),
(20, 13, 26, 'PEREDO	ROMAN', '', 'RO@PORTENIO.COM', ''),
(21, 13, 26, 'VAZQUEZ PABLO', '', 'FF@PORTENIO.COM', ''),
(22, 13, 26, 'YAÑEZ SANTIAGO', '', 'GG@PORTENIO.COM', ''),
(23, 14, 27, 'KUKIOLKA TAMARA', '', 'TAMARAKUKIOLKA@GMAIL.COM', ''),
(24, 14, 27, 'MOHADEB SALOMON', '', 'SALOMONMOHADEB@GMAIL.COM', ''),
(25, 14, 28, 'ALFIE VIVIANA ', '', 'VIVIANAALFIE@GMAIL.COM', ''),
(26, 14, 28, 'FINGERET NURIA', '', 'NURIAFINGERET@GMAIL.COM', ''),
(27, 14, 28, 'MOSER MARINA', '', 'MARINAMOSER@GMAIL.COM', ''),
(28, 14, 28, 'POMPAS KAREN', '', 'KARENPOMPAS@GMAIL.COM', ''),
(29, 14, 29, 'AJZENMESSER FERNANDO', '', 'FERNANDOAJZENMESSER@GMAIL.COM', ''),
(30, 14, 29, 'LIBERMAN MARIO', '', 'ertoamarcogliese@PORTENIO.COM', ''),
(31, 14, 30, 'ALGACE NADIA', '', 'NADIAALGACE@GMAIL.COM', ''),
(32, 14, 30, 'GROSMAN YANINA', '', 'VVV@PORTENIO.COM', ''),
(33, 14, 51, 'GALAGOVSKY TAMARA', '', 'GALAGOVSKY@PORTENIO.COM', ''),
(34, 14, 51, 'GOLDFINGER VERONICA', '', 'r@PORTENIO.COM', ''),
(35, 14, 32, 'FREUE MIRIAN', '', 'mfreue@amia.org.ar	', ''),
(36, 14, 33, 'BARANKIEWICZ IGNACIO', '', 'GTERWE|@PORTENIO.COM', ''),
(37, 14, 33, 'CAPLAN PABLO', '', 'pcaplan@amia.org.ar', ''),
(38, 14, 33, 'JAGODA MARCELO', '', 'mjagoda@amia.org.ar', ''),
(39, 14, 33, 'LUKACHER MARTIN', '', 'LUKACHER@PORTENIO.COM', ''),
(40, 14, 33, 'MILINKIEWICZ HERNAN', '', 'DQA@PORTENIO.COM', ''),
(41, 14, 34, 'PIESKE MARCELA ', '', 'MARCELAPIESKE@GMAIL.COM', ''),
(42, 14, 34, 'SAMSOLO VANESA', '', 'BHGG@PORTENIO.COM', ''),
(43, 14, 34, 'SCHERMAN GABRIEL', '', 'DDDDDDD@PORTENIO.COM', ''),
(44, 14, 34, 'STARK MATIAS', '', '	STARKAMATIAS@GMAIL.COM', ''),
(45, 14, 36, 'POMERANTZ DANIEL', '', 'POMERANTZ@PORTENIO.COM', ''),
(46, 14, 36, 'RONIT BOREN', '', 'RONIT@PORTENIO.COM', ''),
(47, 14, 37, 'KAPSZUK ELIO', '', 'ELIOKAPSZUK@GMAIL.COM', ''),
(48, 14, 37, 'SCHRAIER NADIA', '', 'SCHRAIER@PORTENIO.COM', ''),
(49, 14, 38, 'COSTANTINI DAMIAN', '', 'CONS@GMAIL.COM', ''),
(50, 14, 38, 'FARIAS RAQUEL', '', 'FAR@GMAIL.COM', ''),
(51, 14, 38, 'FELCMAN ADRIAN', '', 'FEL@GMAIL.COM', ''),
(52, 14, 38, 'KUPFERMAN MARCELO', '', 'KUPFERMAN@GMAIL.COM', ''),
(53, 14, 38, 'MOYA FLAVIO', '', 'MOY@GMAIL.COM', ''),
(54, 14, 38, 'PARED RAMON', '', 'PAR@GMAIL.COM', ''),
(55, 14, 40, 'ZALCMAN FLAVIA', '', 'ZALCMAN@PORTENIO.COM', ''),
(56, 14, 41, 'CROUDO KARINA', '', 'CROUDO@PORTENIO.COM', ''),
(57, 14, 41, 'EPELBAUM ELIANA', '', 'EPELBAUM@PORTENIO.COM', ''),
(58, 14, 41, 'FRIDMAN SEBASTIAN', '', 'FRIDMANS@PORTENIO.COM', ''),
(59, 14, 41, 'JAIT PAULA', '', 'JAIT@PORTENIO.COM', ''),
(60, 14, 41, 'KOHON FANNY', '', 'FANNYKOHON@GMAIL.COM', ''),
(61, 14, 41, 'LOKAJ DAMIAN', '', 'DAMIANLOKAJ@GMAIL.COM', ''),
(62, 14, 41, 'MIZRAHI XIMENA', '', 'MIZRAHI@PORTENIO.COM', ''),
(63, 14, 41, 'NAHUM AYLEN', '', 'NAHUM@PORTENIO.COM', ''),
(64, 14, 41, 'RACHILEVICH JULIETA', '', 'RACHILEVICH@PORTENIO.COM', ''),
(65, 14, 41, 'SCHUSTER BARBARA', '', 'shuster@PORTENIO.COM', ''),
(66, 14, 41, 'TABOADA CONSTANZA', '', 'CONSTANZATABOADA@GMAIL.COM', ''),
(67, 14, 41, 'VENTURA JULI', '', 'VENTURA@PORTENIO.COM', ''),
(68, 14, 42, 'AIJENBOM VALERIA', '', 'AIJEM@GMAIL.COM', ''),
(69, 14, 43, 'LLERNOVOY KARINA', '', 'LLERNOVOYK@PORTENIO.COM', ''),
(70, 14, 43, 'Emanuel Cynthia Florencia', '', 'EMA@GMAIL.COM', ''),
(71, 14, 43, 'Hamra Elías Eliahu Isaac', '', 'hamra@gmail.com', ''),
(72, 14, 43, 'LANIADO ANDREA', '', 'LAN@GMAIL.COM', ''),
(73, 14, 45, 'GLIKIN CLAUDIO', '', 'GLIKIN@PORTENIO.COM', ''),
(74, 14, 46, 'ALBAJARI VERONICA', '', '	alaba@PORTENIO.COM', ''),
(75, 14, 47, 'AUDAY SALVADOR', '', 'SALVADORAUDAY@GMAIL.COM', ''),
(76, 14, 47, 'GRUBER JACKELINE', '', 'SSSSS@PORTENIO.COM', ''),
(77, 14, 47, 'HEISEL MARIANA', '', 'DN@PORTENIO.COM', ''),
(78, 14, 48, 'CAHANSKY SERGIO', '', 'caja@PORTENIO.COM', ''),
(79, 14, 48, 'CHIPRUT ANDREA', '', 'CHIPRUT@PORTENIO.COM', ''),
(80, 14, 48, 'JUNOVICH SANDRA', '', 'JUNOVICH@PORTENIO.COM', ''),
(81, 14, 48, 'SALEM MARIANA ', '', 'SALEM@PORTENIO.COM', ''),
(82, 14, 49, 'COHEN IMACH ARIEL', '', 'COHEN@PORTENIO.COM', ''),
(83, 14, 49, 'GORENSTEN KARINA', '', 'GOREN@GMAIL.COM', ''),
(84, 14, 49, 'KOROB KARINA', '', 'KOROB@PORTENIO.COM', ''),
(85, 14, 49, 'LEWIN SANDRA', '', 'LEWIN@PORTENIO.COM', ''),
(86, 14, 49, 'PALEY KARINA', '', 'PALEY@PORTENIO.COM', ''),
(87, 14, 49, 'PALUCH LILI-VAAD', '', 'PALUCH@GMAIL.COM', ''),
(88, 14, 50, 'COHEN MARCOS', '', '	COHENNAR@GMAIL.COM', ''),
(89, 14, 50, 'JATEMLIANSKY TAMARA', '', '	cogliese@PORTENIO.COM', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `centros_costo`
--

CREATE TABLE `centros_costo` (
  `id` int(11) NOT NULL,
  `id_empresa` int(4) NOT NULL,
  `centro_de_costo` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `obs` varchar(255) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `centros_costo`
--

INSERT INTO `centros_costo` (`id`, `id_empresa`, `centro_de_costo`, `nombre`, `obs`, `direccion`) VALUES
(24, 12, 1, 'ALEGRE EN FLOR', '', 'CAMACUA 250'),
(26, 13, 1, 'ALGEIBA S.A.', '', 'PARANA 771 1Âº B'),
(27, 14, 1, 'ADMINISTARCION SISTEMAS', '', 'Pasteur 633'),
(28, 14, 2, 'ADMINISTRACION CONTADURIA', '', 'Pasteur 633'),
(29, 14, 3, 'ADMINISTRACION DOCUMENTOS', '', 'Pasteur 633'),
(30, 14, 4, 'ADMINISTRACION INMUEBLES', '', 'Pasteur 633'),
(31, 14, 5, 'ADMINISTRACION INMUEBLES', '', 'Pasteur 633'),
(32, 14, 6, 'ADMINNISTRACION COMPRAS', '', 'Pasteur 633'),
(33, 14, 7, 'COCHERIA', '', 'PASTEUR 735'),
(34, 14, 8, 'COMUNICACIONES', '', 'PASTEUR 735'),
(35, 14, 9, 'CULTURA', '', 'PASTEUR 735'),
(36, 14, 10, 'DIRECCION EJECUTIVA', '', 'PASTEUR 735'),
(37, 14, 11, 'ESPACIO DE ARTE', '', 'Pasteur 633	'),
(38, 14, 12, '	INFRAESTRUCTURA', '', 'Pasteur 633'),
(39, 14, 13, 'JUBILADOS', '', 'URIBURU 650'),
(40, 14, 14, 'JUVENTUD', '', 'PASTEUR 735'),
(41, 14, 15, 'PROGRAMA SOCIALES', '', 'PASTEUR 735'),
(42, 14, 16, 'RABINATO', '', 'PASTEUR 735'),
(43, 14, 17, 'RECURSOS HUMANOS', '', 'PASTEUR 675'),
(44, 14, 18, 'SECRETARIA INSTITUCIONAL', '', 'PASTEUR 735'),
(45, 14, 19, '	SEGURIDAD', '', 'PASTEUR 735'),
(46, 14, 20, 'SERVICIO DE EMPLEO', '', 'PASTEUR 735'),
(47, 14, 21, 'SERVICIOS COMUNITARIOS', '', 'PASTEUR 735'),
(48, 14, 22, 'SOCIOS Y DESARROLLO', '', 'PASTEUR 735'),
(49, 14, 23, 'VAAD HAJINUJ', '', 'PASTEUR 735'),
(50, 14, 24, 'VAAD HAKEHILOT', '', 'Pasteur 633'),
(51, 14, 25, 'ADMINISTRACION TESORERIA', '', 'Pasteur 633');

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
(1, 'TAXI', 'CHEVROLET', 'SPIN', 'AA456GG', 'disponible', 'NEGRA', 1),
(2, 'REMIS', 'FIAT', 'CRONOS', 'AA456GG', 'disponible', 'BLANCO', 2),
(3, 'REMIS', 'TOYOTA', 'COROLLA', 'AA802GX', 'disponible', 'BLANCO', NULL),
(4, 'REMIS', 'TOYOTA', 'COROLLA', 'AA456GG', 'ocupado', 'NEGRO', 1),
(5, 'REMIS', 'FIAT', 'CRONOS', 'AA802GX', 'disponible', 'NEGRO', NULL),
(6, 'REMIS', 'TOYOTA', 'COROLLA', 'AG444JH', 'disponible', 'AMARILLO', NULL),
(7, 'REMIS', 'FIAT', 'CRONOS', 'AA589GT', 'ocupado', 'VERDE', 3);

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
  `obs_operador` varchar(100) NOT NULL,
  `obs_pasaj` varchar(100) NOT NULL,
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
  `centro_de_costo` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `viajes_despacho`
--

INSERT INTO `viajes_despacho` (`id`, `cel_pasaj`, `nombre_pasaj`, `direccion_origen`, `direccion_destino`, `obs_operador`, `obs_pasaj`, `estado`, `diferido`, `fecha`, `hora`, `categoria_movil`, `origen_lat`, `origen_lng`, `destino_lat`, `destino_lng`, `cc`, `centro_de_costo`) VALUES
(3, 1122226666, 'Paco Jerte', 'Camacua 2000', 'Vera 3020', '', 'Hola', 'Pendiente', 'Si', '2026-06-02', '11:10', 'TAXI', '-34.65731700', '-58.57914300', '-38.66710030', '-62.26609340', 1, 0),
(4, 1169356236, 'Fabian Nogueroles', 'Camacua 2000, caba', 'French 2500, Vicente lopez', 'aaaa', 'bbbb', 'Pendiente', 'Si', '2026-06-02', '22:00', 'REMIS', '-34.62931130', '-58.45795720', '-34.55473440', '-58.51283720', 3, 0),
(5, 1155556666, 'Facundo PAreja', 'French 2500', 'Beruti 2600', '', '', 'Pendiente', '', '2026-04-28', '15:01', 'REMIS', '-34.59035210', '-58.40024590', '-34.59218930', '-58.40268980', NULL, 0),
(6, 1122226666, 'Pascualito Peres', 'Belaustegui 3200, caba', '', '', '', 'Diferido', 'Si', '2026-06-01', '12:30', 'VAN', '-34.61847300', '-58.48105300', NULL, NULL, 0, 0),
(7, 1123895689, 'Juan Carlos Giles', 'Lafuente 1499, CABA', 'Sanabria 1900, CABA', '', '', 'Diferido', 'Si', '2026-04-28', '15:02', 'TAXI', '-34.64737290', '-58.45786790', '-34.61897950', '-58.49934130', 0, 0),
(9, 1145896589, 'Gertrudis Lopez', 'Aranguren 450, caba', 'Garcia del rio 1250, caba', 'mirar bien', 'todo', 'Pendiente', 'No', '0000-00-00', '', 'REMIS', '-34.61241300', '-58.43735780', '-34.55175860', '-58.47860080', NULL, 0),
(10, 1145895623, 'Carlos Garcia', 'Av Lafuente 1499,caba', 'Sanabria 1979', 'Hola Como andas', 'Flaco palido', 'Asignado', 'No', '0000-00-00', '', 'TAXI', '-34.64737290', '-58.45786790', '-34.61847620', '-58.50530700', NULL, 0),
(11, 2147483647, 'Claudo Montes', 'Av Directorio 1499,caba', '', 'De nuevo', 'Prueba texto', 'En Curso', 'No', '0000-00-00', '', 'REMIS', '-34.63001600', '-58.44815960', NULL, NULL, NULL, 0),
(12, 1156892356, 'Fabian Vena', 'Jonte 1979, caba', '', 'Operador', 'pasajero', 'Diferido', 'No', '0000-00-00', '', 'REMIS', '-34.60356530', '-58.47142840', NULL, NULL, NULL, 0),
(13, 1145784215, 'Jose Manuel', 'Juan B justo 8661, caba', '', 'Valor fijo $18.000-', '', 'Diferido', 'Si', '2026-06-01', '21:00', 'REMIS', '-34.60332710', '-58.45666290', NULL, NULL, 0, 0),
(14, 1125896589, 'Andres Castro Casado', 'Venezuela 1258, caba', 'Alvarez Jonre 1925, caba', 'Viaja solo', '', 'Completado', 'No', '0000-00-00', '', 'TAXI', '-34.61520970', '-58.40473700', NULL, NULL, NULL, 0),
(15, 2147483647, 'Franco Salas', 'Martinez Castro 2200, caba', '', 'Nada', '', 'En Curso', 'Si', '2026-04-23', '16:01', 'REMIS', '-34.63803450', '-58.47959650', NULL, NULL, 0, 0),
(16, 1125896325, 'Julieta Fuentes', 'Av Lafuente 120,caba', 'Beruti 2600, caba', '', '', 'Pendiente', 'Si', '2026-04-14', '22:00', 'REMIS', '-34.65672730', '-58.44623380', '-34.59218930', '-58.40268980', 0, 0),
(17, 1125896587, 'Carlos Piaggio', 'Pichincha 1936', '', 'VF 8500-', '', 'Cancelado', 'No', '0000-00-00', '', 'TAXI', '-34.70673700', '-58.37486600', NULL, NULL, NULL, 0),
(18, 1144445555, 'Alberto Garcia', 'Laprida 4490, Villa Martelli', 'Av Maipu 2200, Olivos', '', '', 'Pendiente', '', '2026-06-01', '10:50', 'REMIS', '-34.55154940', '-58.51190860', '-34.51614900', '-58.48816900', NULL, 0),
(21, 1125896547, 'Laura Garcia', 'San Nicolas 4560, caba', 'Av Juan Bautista Alberdi 3601, caba', 'Hola', 'Relinda', 'Pendiente', 'No', '2026-06-01', '14:19', 'REMIS', '-34.59401180', '-58.51181370', '-34.63601680', '-58.47657290', NULL, 0),
(22, 2147483647, 'Juan PErez', 'Miranda 258, caba', 'cuba 2585, caba', '', '', 'Pendiente', '', '2026-06-01', '21:09', 'VAN', '-34.63256040', '-58.51659780', '-34.55637170', '-58.45856500', NULL, 0),
(23, 1125896589, 'Ernest Heminwuey', 'Bolivia 950, villa martelli', 'laprida 4490, Villa martelli', 'Pelotudo', 'de mierda', 'inmediato', '', '2026-06-02', '11:11', 'REMIS', '-34.54661640', '-58.50690670', '-34.55154940', '-58.51190860', 2, 0),
(24, 1122334455, 'Pirulo achaval', 'Venezuela 4488, Villa martelli', 'Paraguay 350, villa martelli', '', '', 'En Curso', '', '2026-06-02', '15:19', 'TAXI', '-34.55236970', '-58.51121980', '-34.54868350', '-58.50704990', 0, 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `00_ubicaciones`
--
ALTER TABLE `00_ubicaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `autorizantes_cc`
--
ALTER TABLE `autorizantes_cc`
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
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_vehiculo_asignado` (`id_vehiculo`);

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
-- AUTO_INCREMENT de la tabla `00_ubicaciones`
--
ALTER TABLE `00_ubicaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=187;

--
-- AUTO_INCREMENT de la tabla `autorizantes_cc`
--
ALTER TABLE `autorizantes_cc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT de la tabla `centros_costo`
--
ALTER TABLE `centros_costo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `viajes_despacho`
--
ALTER TABLE `viajes_despacho`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

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
