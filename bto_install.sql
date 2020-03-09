-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.11-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.3.0.5915
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para gta5_gamemode_essential
CREATE DATABASE IF NOT EXISTS `gta5_gamemode_essential` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `gta5_gamemode_essential`;

-- Volcando estructura para tabla gta5_gamemode_essential.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `banned` varchar(50) NOT NULL DEFAULT '0',
  `banner` varchar(50) NOT NULL,
  `reason` varchar(150) NOT NULL DEFAULT '0',
  `expires` datetime NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla gta5_gamemode_essential.bans: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `bans` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.coordinates
CREATE TABLE IF NOT EXISTS `coordinates` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla gta5_gamemode_essential.coordinates: ~12 rows (aproximadamente)
/*!40000 ALTER TABLE `coordinates` DISABLE KEYS */;
INSERT INTO `coordinates` (`id`, `x`, `y`, `z`, `name`) VALUES
	(1, 2681.752, 2800.187, 40.36, 'Minas de Los Santos'),
	(2, 1077.64, -1989.417, 30.883, 'Fuente de metal'),
	(3, -510.449, -2751.847, 6.2, 'Venta de Hierro'),
	(7, -801.323, 5403.05, 34.0766, 'Recolecta de madera'),
	(8, -555.881, 5319.96, 73.5997, 'Tratamiento de madera'),
	(9, -473.829, -985.232, 23.5457, 'Venta de madera'),
	(10, -1813.25, 2105.58, 135.808, 'Viñedos'),
	(11, 823.7, 2193.76, 52.0271, 'Bodega'),
	(12, -561.508, 302.273, 82.6591, 'Venta de vino'),
	(13, 2217.01, 5577.23, 53.8241, 'Plantacion de Marihuana'),
	(14, -1674.55, -1069.29, 13.1529, 'Secadero de Marihuana'),
	(15, 485.292, -3382.2, 6.06991, 'Venta de Marihuana');
/*!40000 ALTER TABLE `coordinates` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.items
CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) DEFAULT NULL,
  `isIllegal` tinyint(1) NOT NULL DEFAULT 0,
  `food` varchar(255) NOT NULL DEFAULT '0',
  `water` varchar(255) NOT NULL DEFAULT '0',
  `needs` varchar(255) NOT NULL DEFAULT '0',
  `limitation` int(11) DEFAULT 15,
  `type` varchar(255) NOT NULL DEFAULT 'object',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla gta5_gamemode_essential.items: ~14 rows (aproximadamente)
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`id`, `libelle`, `isIllegal`, `food`, `water`, `needs`, `limitation`, `type`) VALUES
	(1, 'Piedra', 0, '0', '0', '0', NULL, 'object'),
	(3, 'Mineral de hierro', 0, '0', '0', '0', NULL, 'object'),
	(6, 'Hierro', 0, '0', '0', '0', NULL, 'object'),
	(7, 'Diamante', 0, '0', '0', '0', NULL, 'object'),
	(30, 'Burger', 0, '30', '0', '0', NULL, 'food'),
	(31, 'Coca-Cola', 0, '5', '20', '0', NULL, 'drink'),
	(32, 'Morceaux de bois', 0, '0', '0', '0', 15, 'object'),
	(33, 'Planches', 0, '0', '0', '0', 15, 'object'),
	(34, 'Raisins', 0, '5', '5', '0', 15, 'food'),
	(36, 'Barril de vino', 0, '0', '0', '0', 15, 'object'),
	(37, 'Hojas de cañamo', 1, '0', '0', '0', 15, 'object'),
	(38, 'Marijuana', 1, '0', '0', '0', 15, 'object'),
	(40, 'Ensalada', 0, '30', '0', '0', NULL, 'food'),
	(41, 'Agua', 0, '0', '20', '0', NULL, 'drink');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `job_id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(40) NOT NULL,
  `salary` int(11) NOT NULL DEFAULT 500,
  `whitelisted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla gta5_gamemode_essential.jobs: ~24 rows (aproximadamente)
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` (`job_id`, `job_name`, `salary`, `whitelisted`) VALUES
	(1, 'Desempleado', 200, 0),
	(2, 'LSPD (Cadete)', 450, 1),
	(3, 'LSPD (Oficial)', 750, 1),
	(4, 'LSPD (Sargento)', 1000, 1),
	(5, 'LSPD (Comandante)', 1600, 1),
	(6, 'CHU (Interno)', 400, 1),
	(7, 'CHU (Médico)', 850, 1),
	(8, 'CHU (Jefe de servicio)', 900, 1),
	(9, 'CHU (Director)', 2700, 1),
	(10, 'GSPR 1', 2200, 1),
	(11, 'GSPR 2', 3200, 1),
	(12, 'GSPR 3', 4800, 1),
	(13, 'Gobernador', 5000, 1),
	(14, 'Ministro de Economia', 3000, 1),
	(15, 'Ministro de Interior', 3000, 1),
	(16, 'Ministro de Comunicacion', 3000, 1),
	(17, 'Leñador', 90, 0),
	(18, 'Viticultor', 75, 0),
	(19, 'Minero', 75, 0),
	(20, 'Ilegal', 50000, 0),
	(21, 'Repartidor', 75, 0),
	(22, 'Taxi', 90, 0),
	(23, 'Juez', 1300, 1),
	(24, 'Abogado', 1000, 1);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.licences
CREATE TABLE IF NOT EXISTS `licences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` int(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla gta5_gamemode_essential.licences: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `licences` DISABLE KEYS */;
INSERT INTO `licences` (`id`, `name`, `price`) VALUES
	(1, 'De conducir', 1000),
	(2, 'De posesion de armas', 5000);
/*!40000 ALTER TABLE `licences` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.recolt
CREATE TABLE IF NOT EXISTS `recolt` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `raw_id` int(11) unsigned DEFAULT NULL,
  `treated_id` int(11) unsigned DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `field_id` int(10) unsigned DEFAULT NULL,
  `treatment_id` int(10) unsigned DEFAULT NULL,
  `seller_id` int(10) unsigned DEFAULT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `isIllegal` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  KEY `raw_id` (`raw_id`),
  KEY `treated_id` (`treated_id`),
  KEY `job_id` (`job_id`),
  KEY `field_id` (`field_id`),
  KEY `treatment_id` (`treatment_id`),
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `recolt_ibfk_1` FOREIGN KEY (`raw_id`) REFERENCES `items` (`id`),
  CONSTRAINT `recolt_ibfk_2` FOREIGN KEY (`treated_id`) REFERENCES `items` (`id`),
  CONSTRAINT `recolt_ibfk_3` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`),
  CONSTRAINT `recolt_ibfk_4` FOREIGN KEY (`field_id`) REFERENCES `coordinates` (`id`),
  CONSTRAINT `recolt_ibfk_5` FOREIGN KEY (`treatment_id`) REFERENCES `coordinates` (`id`),
  CONSTRAINT `recolt_ibfk_6` FOREIGN KEY (`seller_id`) REFERENCES `coordinates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla gta5_gamemode_essential.recolt: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `recolt` DISABLE KEYS */;
INSERT INTO `recolt` (`ID`, `raw_id`, `treated_id`, `job_id`, `price`, `field_id`, `treatment_id`, `seller_id`, `nom`, `isIllegal`) VALUES
	(4, 1, 3, 19, 40, 1, 2, 3, 'Minero', 0),
	(5, 32, 33, 17, 55, 7, 8, 9, 'Leñador', 0),
	(6, 34, 36, 18, 40, 10, 11, 12, 'Viticultor', 0),
	(7, 37, 38, 1, 95, 13, 14, 15, 'Canabicultor', 0);
/*!40000 ALTER TABLE `recolt` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `player_state` int(255) NOT NULL DEFAULT 0,
  `group` varchar(50) NOT NULL DEFAULT '0',
  `permission_level` int(11) NOT NULL DEFAULT 0,
  `money` double NOT NULL DEFAULT 0,
  `dirty_money` double NOT NULL DEFAULT 0,
  `bankbalance` int(32) DEFAULT 0,
  `job` int(11) DEFAULT 1,
  `lastpos` varchar(255) DEFAULT '{241.609985351563, -877.769958496094,  30.4920997619629, 0}',
  `personalvehicle` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'github.com/xchopin',
  `isFirstConnection` int(11) DEFAULT 1,
  `food` double NOT NULL DEFAULT 100,
  `water` double NOT NULL DEFAULT 100,
  `needs` double NOT NULL DEFAULT 0,
  `enService` tinyint(4) NOT NULL DEFAULT 0,
  `phone_number` varchar(255) DEFAULT 'none',
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla gta5_gamemode_essential.users: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `identifier`, `player_state`, `group`, `permission_level`, `money`, `dirty_money`, `bankbalance`, `job`, `lastpos`, `personalvehicle`, `name`, `isFirstConnection`, `food`, `water`, `needs`, `enService`, `phone_number`) VALUES
	(75, 'ip:26.60.248.214', 0, 'admin', 4, 300000, 199899998, 199899998, 20, '{-1298.85693359375, -2808.11669921875,  14.4076881408691, 359.997314453125}', 'vide', 'bTo', 0, 175, 175, 0, 1, '67HO462');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.user_appartement
CREATE TABLE IF NOT EXISTS `user_appartement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `money` int(11) NOT NULL DEFAULT 0,
  `dirtymoney` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla gta5_gamemode_essential.user_appartement: 0 rows
/*!40000 ALTER TABLE `user_appartement` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_appartement` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.user_clothes
CREATE TABLE IF NOT EXISTS `user_clothes` (
  `identifier` varchar(150) NOT NULL,
  `skin` varchar(255) NOT NULL DEFAULT 'mp_m_freemode_01',
  `face` varchar(255) NOT NULL DEFAULT '0',
  `face_texture` varchar(255) NOT NULL DEFAULT '0',
  `hair` varchar(255) NOT NULL DEFAULT '11',
  `hair_texture` varchar(255) NOT NULL DEFAULT '4',
  `shirt` varchar(255) NOT NULL DEFAULT '0',
  `shirt_texture` varchar(255) NOT NULL DEFAULT '0',
  `pants` varchar(255) NOT NULL DEFAULT '8',
  `pants_texture` varchar(255) NOT NULL DEFAULT '0',
  `shoes` varchar(255) NOT NULL DEFAULT '1',
  `shoes_texture` varchar(255) NOT NULL DEFAULT '0',
  `vest` varchar(255) NOT NULL DEFAULT '0',
  `vest_texture` varchar(255) NOT NULL DEFAULT '0',
  `bag` varchar(255) NOT NULL DEFAULT '40',
  `bag_texture` varchar(255) NOT NULL DEFAULT '0',
  `hat` varchar(255) NOT NULL DEFAULT '1',
  `hat_texture` varchar(255) NOT NULL DEFAULT '1',
  `mask` varchar(255) NOT NULL DEFAULT '0',
  `mask_texture` varchar(255) NOT NULL DEFAULT '0',
  `glasses` varchar(255) NOT NULL DEFAULT '6',
  `glasses_texture` varchar(255) NOT NULL DEFAULT '0',
  `gloves` varchar(255) NOT NULL DEFAULT '2',
  `gloves_texture` varchar(255) NOT NULL DEFAULT '0',
  `jacket` varchar(255) NOT NULL DEFAULT '7',
  `jacket_texture` varchar(255) NOT NULL DEFAULT '2',
  `ears` varchar(255) NOT NULL DEFAULT '1',
  `ears_texture` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`identifier`),
  CONSTRAINT `fk_user_clothes` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla gta5_gamemode_essential.user_clothes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `user_clothes` DISABLE KEYS */;
INSERT INTO `user_clothes` (`identifier`, `skin`, `face`, `face_texture`, `hair`, `hair_texture`, `shirt`, `shirt_texture`, `pants`, `pants_texture`, `shoes`, `shoes_texture`, `vest`, `vest_texture`, `bag`, `bag_texture`, `hat`, `hat_texture`, `mask`, `mask_texture`, `glasses`, `glasses_texture`, `gloves`, `gloves_texture`, `jacket`, `jacket_texture`, `ears`, `ears_texture`) VALUES
	('ip:26.60.248.214', 'mp_m_freemode_01', '20', '0', '3', '4', '75', '0', '45', '0', '10', '0', '0', '0', '20', '0', '61', '6', '0', '0', '7', '9', '1', '0', '4', '0', '32', '0');
/*!40000 ALTER TABLE `user_clothes` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.user_inventory
CREATE TABLE IF NOT EXISTS `user_inventory` (
  `user_id` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `item_id` int(11) unsigned NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`item_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `user_inventory_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla gta5_gamemode_essential.user_inventory: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `user_inventory` DISABLE KEYS */;
INSERT INTO `user_inventory` (`user_id`, `item_id`, `quantity`) VALUES
	('ip:26.60.248.214', 30, 100),
	('ip:26.60.248.214', 31, 100),
	('ip:26.60.248.214', 40, 0),
	('ip:26.60.248.214', 41, 0);
/*!40000 ALTER TABLE `user_inventory` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.user_licence
CREATE TABLE IF NOT EXISTS `user_licence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `licence_id` int(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla gta5_gamemode_essential.user_licence: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `user_licence` DISABLE KEYS */;
INSERT INTO `user_licence` (`id`, `identifier`, `licence_id`) VALUES
	(50, 'ip:26.60.248.214', 1),
	(51, 'ip:26.60.248.214', 2);
/*!40000 ALTER TABLE `user_licence` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.user_message
CREATE TABLE IF NOT EXISTS `user_message` (
  `owner_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'Inconnu',
  `msg` varchar(255) NOT NULL,
  `date` varchar(255) DEFAULT '01/01/1970',
  `has_read` int(11) NOT NULL DEFAULT 0,
  `receiver_id` varchar(255) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=537 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla gta5_gamemode_essential.user_message: 0 rows
/*!40000 ALTER TABLE `user_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_message` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.user_phonelist
CREATE TABLE IF NOT EXISTS `user_phonelist` (
  `contact_id` varchar(255) NOT NULL,
  `owner_id` varchar(255) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT 'Contact',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=175 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla gta5_gamemode_essential.user_phonelist: 0 rows
/*!40000 ALTER TABLE `user_phonelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_phonelist` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.user_vehicle
CREATE TABLE IF NOT EXISTS `user_vehicle` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `vehicle_name` varchar(60) DEFAULT NULL,
  `vehicle_model` varchar(60) DEFAULT NULL,
  `vehicle_plate` varchar(60) DEFAULT NULL,
  `vehicle_state` varchar(60) DEFAULT NULL,
  `vehicle_colorprimary` varchar(60) DEFAULT NULL,
  `vehicle_colorsecondary` varchar(60) DEFAULT NULL,
  `vehicle_pearlescentcolor` varchar(60) NOT NULL,
  `vehicle_wheelcolor` varchar(60) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_user_vehicle` (`identifier`),
  CONSTRAINT `fk_user_vehicle` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla gta5_gamemode_essential.user_vehicle: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `user_vehicle` DISABLE KEYS */;
INSERT INTO `user_vehicle` (`ID`, `identifier`, `vehicle_name`, `vehicle_model`, `vehicle_plate`, `vehicle_state`, `vehicle_colorprimary`, `vehicle_colorsecondary`, `vehicle_pearlescentcolor`, `vehicle_wheelcolor`) VALUES
	(39, 'ip:26.60.248.214', 'gburrito', 'gburrito', 'bToEle', 'Rentré', '12', '12', '3', '3'),
	(40, 'ip:26.60.248.214', 'cliffhanger', 'cliffhanger', 'bTo3Le', 'Rentré', '12', '12', '2', '2'),
	(41, 'ip:26.60.248.214', 'prototipo', 'prototipo', 'bTo3L3', 'Rentré', '12', '12', '2', '2');
/*!40000 ALTER TABLE `user_vehicle` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.user_weapons
CREATE TABLE IF NOT EXISTS `user_weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `weapon_model` varchar(255) NOT NULL,
  `withdraw_cost` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_weapon` (`identifier`),
  CONSTRAINT `fk_user_weapon` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla gta5_gamemode_essential.user_weapons: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `user_weapons` DISABLE KEYS */;
INSERT INTO `user_weapons` (`id`, `identifier`, `weapon_model`, `withdraw_cost`) VALUES
	(63, 'ip:26.60.248.214', 'WEAPON_MACHETE', 10),
	(64, 'ip:26.60.248.214', 'GADGET_PARACHUTE', 8),
	(65, 'ip:26.60.248.214', 'WEAPON_COMBATPISTOL', 40),
	(66, 'ip:26.60.248.214', 'WEAPON_GUSENBERG', 295),
	(69, 'ip:26.60.248.214', 'WEAPON_FIREWORK', 100),
	(70, 'ip:26.60.248.214', 'WEAPON_GUSENBERG', 295);
/*!40000 ALTER TABLE `user_weapons` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.user_whitelist
CREATE TABLE IF NOT EXISTS `user_whitelist` (
  `identifier` varchar(255) NOT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla gta5_gamemode_essential.user_whitelist: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `user_whitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_whitelist` ENABLE KEYS */;

-- Volcando estructura para tabla gta5_gamemode_essential.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` int(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla gta5_gamemode_essential.vehicles: ~164 rows (aproximadamente)
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` (`id`, `name`, `price`, `model`) VALUES
	(1, 'Blista', 15000, 'blista'),
	(2, 'Brioso R/A', 155000, 'brioso'),
	(3, 'Dilettante', 25000, 'Dilettante'),
	(4, 'Issi', 18000, 'issi2'),
	(5, 'Panto', 85000, 'panto'),
	(6, 'Prairie', 30000, 'prairie'),
	(7, 'Rhapsody', 120000, 'rhapsody'),
	(8, 'Cognoscenti Cabrio', 180000, 'cogcabrio'),
	(9, 'Exemplar', 200000, 'exemplar'),
	(10, 'F620', 80000, 'f620'),
	(11, 'Felon', 90000, 'felon'),
	(12, 'Felon GT', 95000, 'felon2'),
	(13, 'Jackal', 60000, 'jackal'),
	(14, 'Oracle', 80000, 'oracle'),
	(15, 'Oracle XS', 82000, 'oracle2'),
	(16, 'Sentinel', 90000, 'sentinel'),
	(17, 'Sentinel XS', 60000, 'sentinel2'),
	(18, 'Windsor', 800000, 'windsor'),
	(19, 'Windsor Drop', 850000, 'windsor2'),
	(20, 'Zion', 60000, 'zion'),
	(21, 'Zion Cabrio', 65000, 'zion2'),
	(22, '9F', 120000, 'ninef'),
	(23, '9F Cabrio', 130000, 'ninef2'),
	(24, 'Alpha', 150000, 'alpha'),
	(25, 'Banshee', 105000, 'banshee'),
	(26, 'Bestia GTS', 610000, 'bestiagts'),
	(27, 'Blista Compact', 42000, 'blista'),
	(28, 'Buffalo', 35000, 'buffalo'),
	(29, 'Buffalo S', 96000, 'buffalo2'),
	(30, 'Carbonizzare', 195000, 'carbonizzare'),
	(31, 'Comet', 100000, 'comet2'),
	(32, 'Coquette', 138000, 'coquette'),
	(33, 'Drift Tampa', 995000, 'tampa2'),
	(34, 'Feltzer', 130000, 'feltzer2'),
	(35, 'Furore GT', 448000, 'furoregt'),
	(36, 'Fusilade', 36000, 'fusilade'),
	(37, 'Jester', 240000, 'jester'),
	(38, 'Jester(Racecar)', 350000, 'jester2'),
	(39, 'Kuruma', 95000, 'kuruma'),
	(40, 'Lynx', 1735000, 'lynx'),
	(41, 'Massacro', 275000, 'massacro'),
	(42, 'Massacro(Racecar)', 385000, 'massacro2'),
	(43, 'Omnis', 701000, 'omnis'),
	(44, 'Penumbra', 24000, 'penumbra'),
	(45, 'Rapid GT', 140000, 'rapidgt'),
	(46, 'Rapid GT Convertible', 150000, 'rapidgt2'),
	(47, 'Schafter V12', 140000, 'schafter3'),
	(48, 'Sultan', 12000, 'sultan'),
	(49, 'Surano', 110000, 'surano'),
	(50, 'Tropos', 816000, 'tropos'),
	(51, 'Verkierer', 695000, 'verlierer2'),
	(52, 'Casco', 680000, 'casco'),
	(53, 'Coquette Classic', 665000, 'coquette2'),
	(54, 'JB 700', 350000, 'jb700'),
	(55, 'Pigalle', 400000, 'pigalle'),
	(56, 'Stinger', 850000, 'stinger'),
	(57, 'Stinger GT', 875000, 'stingergt'),
	(58, 'Stirling GT', 975000, 'feltzer3'),
	(59, 'Z-Type', 950000, 'ztype'),
	(60, 'Adder', 1000000, 'adder'),
	(61, 'Banshee 900R', 565000, 'banshee2'),
	(62, 'Bullet', 155000, 'bullet'),
	(63, 'Cheetah', 650000, 'cheetah'),
	(64, 'Entity XF', 795000, 'entityxf'),
	(65, 'ETR1', 199500, 'sheava'),
	(66, 'FMJ', 1750000, 'fmj'),
	(67, 'Infernus', 440000, 'infernus'),
	(68, 'Osiris', 1950000, 'osiris'),
	(69, 'RE-7B', 2475000, 'le7b'),
	(70, 'Reaper', 1595000, 'reaper'),
	(71, 'Sultan RS', 795000, 'sultanrs'),
	(72, 'T20', 2200000, 't20'),
	(73, 'Turismo R', 500000, 'turismor'),
	(74, 'Tyrus', 2550000, 'tyrus'),
	(75, 'Vacca', 240000, 'vacca'),
	(76, 'Voltic', 150000, 'voltic'),
	(77, 'X80 Proto', 2700000, 'prototipo'),
	(78, 'Zentorno', 725000, 'zentorno'),
	(79, 'Blade', 160000, 'blade'),
	(80, 'Buccaneer', 29000, 'buccaneer'),
	(81, 'Chino', 225000, 'chino'),
	(82, 'Coquette BlackFin', 695000, 'coquette3'),
	(83, 'Dominator', 35000, 'dominator'),
	(84, 'Dukes', 62000, 'dukes'),
	(85, 'Gauntlet', 32000, 'gauntlet'),
	(86, 'Hotknife', 90000, 'hotknife'),
	(87, 'Faction', 36000, 'faction'),
	(88, 'Nightshade', 585000, 'nightshade'),
	(89, 'Picador', 9000, 'picador'),
	(90, 'Sabre Turbo', 15000, 'sabregt'),
	(91, 'Tampa', 375000, 'tampa'),
	(92, 'Virgo', 195000, 'virgo'),
	(93, 'Vigero', 21000, 'vigero'),
	(94, 'Bifta', 75000, 'bifta'),
	(95, 'Blazer', 8000, 'blazer'),
	(96, 'Brawler', 715000, 'brawler'),
	(97, 'Bubsta 6x6', 249000, 'dubsta3'),
	(98, 'Dune Buggy', 20000, 'dune'),
	(99, 'Rebel', 22000, 'rebel2'),
	(100, 'Sandking', 38000, 'sandking'),
	(101, 'The Liberator', 550000, 'monster'),
	(102, 'Trophy Truck', 550000, 'trophytruck'),
	(103, 'Baller', 90000, 'baller'),
	(104, 'Cavalcade', 60000, 'cavalcade'),
	(105, 'Grabger', 35000, 'granger'),
	(106, 'Huntley S', 195000, 'huntley'),
	(107, 'Landstalker', 58000, 'landstalker'),
	(108, 'Radius', 32000, 'radi'),
	(109, 'Rocoto', 85000, 'rocoto'),
	(110, 'Seminole', 30000, 'seminole'),
	(111, 'XLS', 253000, 'xls'),
	(112, 'Bison', 30000, 'bison'),
	(113, 'Bobcat XL', 23000, 'bobcatxl'),
	(114, 'Gang Burrito', 65000, 'gburrito'),
	(115, 'Journey', 15000, 'journey'),
	(116, 'Minivan', 30000, 'minivan'),
	(117, 'Paradise', 25000, 'paradise'),
	(118, 'Rumpo', 13000, 'rumpo'),
	(119, 'Surfer', 11000, 'surfer'),
	(120, 'Youga', 16000, 'youga'),
	(121, 'Asea', 1000000, 'asea'),
	(122, 'Asterope', 1000000, 'asterope'),
	(123, 'Fugitive', 24000, 'fugitive'),
	(124, 'Glendale', 200000, 'glendale'),
	(125, 'Ingot', 9000, 'ingot'),
	(126, 'Intruder', 16000, 'intruder'),
	(127, 'Premier', 10000, 'premier'),
	(128, 'Primo', 9000, 'primo'),
	(129, 'Primo Custom', 9500, 'primo2'),
	(130, 'Regina', 8000, 'regina'),
	(131, 'Schafter', 65000, 'schafter2'),
	(132, 'Stanier', 10000, 'stanier'),
	(133, 'Stratum', 10000, 'stratum'),
	(134, 'Stretch', 30000, 'stretch'),
	(135, 'Super Diamond', 250000, 'superd'),
	(136, 'Surge', 38000, 'surge'),
	(137, 'Tailgater', 55000, 'tailgater'),
	(138, 'Warrener', 120000, 'warrener'),
	(139, 'Washington', 15000, 'washington'),
	(140, 'Akuma', 9000, 'AKUMA'),
	(141, 'Bagger', 5000, 'bagger'),
	(142, 'Bati 801', 15000, 'bati'),
	(143, 'Bati 801RR', 15000, 'bati2'),
	(144, 'BF400', 95000, 'bf400'),
	(145, 'Carbon RS', 40000, 'carbonrs'),
	(146, 'Cliffhanger', 225000, 'cliffhanger'),
	(147, 'Daemon', 5000, 'daemon'),
	(148, 'Double T', 12000, 'double'),
	(149, 'Enduro', 48000, 'enduro'),
	(150, 'Faggio', 4000, 'faggio2'),
	(151, 'Gargoyle', 120000, 'gargoyle'),
	(152, 'Hakuchou', 82000, 'hakuchou'),
	(153, 'Hexer', 15000, 'hexer'),
	(154, 'Innovation', 90000, 'innovation'),
	(155, 'Lectro', 700000, 'lectro'),
	(156, 'Nemesis', 12000, 'nemesis'),
	(157, 'PCJ-600', 9000, 'pcj'),
	(158, 'Ruffian', 9000, 'ruffian'),
	(159, 'Sanchez', 7000, 'sanchez'),
	(160, 'Sovereign', 90000, 'sovereign'),
	(161, 'Thrust', 75000, 'thrust'),
	(162, 'Vader', 9000, 'vader'),
	(163, 'Vindicator', 600000, 'vindicator'),
	(164, 'Duster', 600000, 'duster'),
	(165, 'Cuban800', 600000, 'cuban800'),
	(166, 'Mammatus', 600000, 'mammatus'),
	(167, 'Stunt', 600000, 'stunt'),
	(168, 'Velum', 600000, 'velum'),
	(169, 'Velum2', 600000, 'velum2'),
	(170, 'Annihilator', 600000, 'annihilator'),
	(171, 'Frogger', 600000, 'frogger'),
	(172, 'Valkyrie', 600000, 'valkyrie'),
	(173, 'Cargobob2', 600000, 'cargobob2');
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
