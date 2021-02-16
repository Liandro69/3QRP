-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.14-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for tqrpbase
DROP DATABASE IF EXISTS `tqrpbase`;
CREATE DATABASE IF NOT EXISTS `tqrpbase` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */;
USE `tqrpbase`;

-- Dumping structure for table tqrpbase.addon_account
DROP TABLE IF EXISTS `addon_account`;
CREATE TABLE IF NOT EXISTS `addon_account` (
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.addon_account: ~18 rows (approximately)
DELETE FROM `addon_account`;
/*!40000 ALTER TABLE `addon_account` DISABLE KEYS */;
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('bank_savings', 'Livret Bleu', 0),
	('caution', 'Caution', 0),
	('housing_black_money', 'Housing Black Money', 0),
	('motels_bed_black_money', 'Motels Black Money Bed', 0),
	('motels_black_money', 'Motels Black Money ', 0),
	('property_black_money', 'Kara Para', 0),
	('society_ambulance', 'Ambulance', 1),
	('society_banker', 'Banco', 1),
	('society_cardealer', 'Concessionnaire', 1),
	('society_mechanic', 'Benny\'S', 1),
	('society_mechanic2', 'LS Customs', 1),
	('society_police', 'Polícia', 1),
	('society_police_black_money', 'Police Black Money', 1),
	('society_realestateagent', 'Agent immobilier', 1),
	('society_state', 'Estado', 1),
	('society_taxi', 'Taxi', 1),
	('society_unicorn', 'Vanilla Unicorn', 1),
	('vault_black_money', 'Money Vault', 0);
/*!40000 ALTER TABLE `addon_account` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.addon_account_data
DROP TABLE IF EXISTS `addon_account_data`;
CREATE TABLE IF NOT EXISTS `addon_account_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  KEY `index_addon_account_data_account_name` (`account_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.addon_account_data: ~0 rows (approximately)
DELETE FROM `addon_account_data`;
/*!40000 ALTER TABLE `addon_account_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `addon_account_data` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.addon_inventory
DROP TABLE IF EXISTS `addon_inventory`;
CREATE TABLE IF NOT EXISTS `addon_inventory` (
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.addon_inventory: ~14 rows (approximately)
DELETE FROM `addon_inventory`;
/*!40000 ALTER TABLE `addon_inventory` DISABLE KEYS */;
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('housing', 'Housing', 0),
	('motels', 'Motels Inventory', 0),
	('motels_bed', 'Motels Bed Inventory', 0),
	('property', 'Propiedade', 0),
	('society_ambulance', 'Ambulance', 1),
	('society_banker', 'Banco', 1),
	('society_cardealer', 'Concesionnaire', 1),
	('society_mechanic', 'Benny\'S', 1),
	('society_mechanic2', 'LS Customs', 1),
	('society_police', 'Police', 1),
	('society_state', 'Estado', 1),
	('society_taxi', 'Taxi', 1),
	('society_unicorn', 'Vanilla', 1),
	('vault', 'Vault', 0);
/*!40000 ALTER TABLE `addon_inventory` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.addon_inventory_items
DROP TABLE IF EXISTS `addon_inventory_items`;
CREATE TABLE IF NOT EXISTS `addon_inventory_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`),
  KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`),
  KEY `index_addon_inventory_inventory_name` (`inventory_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.addon_inventory_items: ~0 rows (approximately)
DELETE FROM `addon_inventory_items`;
/*!40000 ALTER TABLE `addon_inventory_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `addon_inventory_items` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.allhousing
DROP TABLE IF EXISTS `allhousing`;
CREATE TABLE IF NOT EXISTS `allhousing` (
  `id` int(11) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `ownername` varchar(50) NOT NULL,
  `owned` tinyint(4) NOT NULL,
  `price` int(11) NOT NULL,
  `resalepercent` int(11) NOT NULL,
  `resalejob` varchar(50) NOT NULL,
  `entry` longtext NOT NULL,
  `garage` longtext NOT NULL,
  `furniture` longtext NOT NULL,
  `shell` varchar(50) NOT NULL,
  `interior` varchar(50) DEFAULT NULL,
  `shells` longtext NOT NULL,
  `doors` longtext DEFAULT NULL,
  `housekeys` longtext NOT NULL,
  `wardrobe` longtext NOT NULL,
  `inventory` longtext NOT NULL,
  `inventorylocation` longtext NOT NULL,
  `mortage_owed` int(11) NOT NULL DEFAULT 0,
  `last_repayment` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table tqrpbase.allhousing: ~0 rows (approximately)
DELETE FROM `allhousing`;
/*!40000 ALTER TABLE `allhousing` DISABLE KEYS */;
/*!40000 ALTER TABLE `allhousing` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.billing
DROP TABLE IF EXISTS `billing`;
CREATE TABLE IF NOT EXISTS `billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `sender` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `target_type` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `target` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `amount` int(11) NOT NULL,
  `day` int(2) NOT NULL,
  `month` int(2) NOT NULL,
  `sender_name` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'Desconhecido',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- Dumping data for table tqrpbase.billing: ~0 rows (approximately)
DELETE FROM `billing`;
/*!40000 ALTER TABLE `billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.characters
DROP TABLE IF EXISTS `characters`;
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `dateofbirth` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `sex` varchar(1) COLLATE utf8mb4_bin NOT NULL DEFAULT 'M',
  `height` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.characters: ~1 rows (approximately)
DELETE FROM `characters`;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.companies
DROP TABLE IF EXISTS `companies`;
CREATE TABLE IF NOT EXISTS `companies` (
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `investRate` float DEFAULT NULL,
  `rate` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT 'stale',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.companies: ~16 rows (approximately)
DELETE FROM `companies`;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` (`name`, `label`, `investRate`, `rate`) VALUES
	('24/7', 'TNYFVN', -3.5, 'up'),
	('Ammu-Nation', 'AMNA', -1.14, 'down'),
	('Augury Insurance', 'AUGIN', 3.59, 'up'),
	('Downtown Cab Co.', 'DCC', 0.45, 'up'),
	('ECola', 'ECLA', 2.33, 'up'),
	('Fleeca', 'FLCA', -2.57, 'down'),
	('Globe Oil', 'GLBO', 0.54, 'up'),
	('GoPostal', 'GPSTL', -0.71, 'up'),
	('Lifeinvader', 'LIVDR', 3.98, 'up'),
	('Los Santos Air', 'LSA', -3.62, 'up'),
	('Los Santos Transit', 'LST', -3.12, 'down'),
	('Maze Bank', 'MBANK', -3.95, 'up'),
	('Post OP', 'PSTP', 0.14, 'down'),
	('RON', 'RON', -2.64, 'up'),
	('Up-n-Atom Burger', 'UNAB', -0.51, 'down'),
	('Weazel', 'NEWS', -0.24, 'up');
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.craftingtables
DROP TABLE IF EXISTS `craftingtables`;
CREATE TABLE IF NOT EXISTS `craftingtables` (
  `location` longtext COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.craftingtables: ~4 rows (approximately)
DELETE FROM `craftingtables`;
/*!40000 ALTER TABLE `craftingtables` DISABLE KEYS */;
INSERT INTO `craftingtables` (`location`) VALUES
	('{"x":-311.09762573242,"heading":82.386840820313,"z":22.370580673218,"y":-1171.9079589844}'),
	('{"x":20.791204452515,"heading":161.38888549805,"z":44.558559417725,"y":-437.44311523438}'),
	('{"x":112.52996063232,"heading":-46.341808319092,"z":28.591716766357,"y":-1595.2628173828}'),
	('{"z":268.13507080078,"y":-974.93371582031,"x":-149.59992980957,"heading":223.00442504883}');
/*!40000 ALTER TABLE `craftingtables` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.datastore
DROP TABLE IF EXISTS `datastore`;
CREATE TABLE IF NOT EXISTS `datastore` (
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.datastore: ~14 rows (approximately)
DELETE FROM `datastore`;
/*!40000 ALTER TABLE `datastore` DISABLE KEYS */;
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('housing', 'Housing', 0),
	('motels', 'Motels Datastore', 0),
	('motels_bed', 'Motels Bed Datastore', 0),
	('property', 'Propiedade', 0),
	('society_ambulance', 'Ambulance', 1),
	('society_mechanic', 'Benny\'S', 1),
	('society_police', 'Police', 1),
	('society_taxi', 'Taxi', 1),
	('society_unicorn', 'Unicorn', 1),
	('user_ears', 'Ears', 0),
	('user_glasses', 'Glasses', 0),
	('user_helmet', 'Helmet', 0),
	('user_mask', 'Mask', 0),
	('vault', 'Vault', 0);
/*!40000 ALTER TABLE `datastore` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.datastore_data
DROP TABLE IF EXISTS `datastore_data`;
CREATE TABLE IF NOT EXISTS `datastore_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_bin DEFAULT NULL,
  `data` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  KEY `index_datastore_data_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.datastore_data: ~0 rows (approximately)
DELETE FROM `datastore_data`;
/*!40000 ALTER TABLE `datastore_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `datastore_data` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.disc_ammo
DROP TABLE IF EXISTS `disc_ammo`;
CREATE TABLE IF NOT EXISTS `disc_ammo` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner` text COLLATE utf8mb4_bin NOT NULL,
  `hash` text COLLATE utf8mb4_bin NOT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.disc_ammo: ~0 rows (approximately)
DELETE FROM `disc_ammo`;
/*!40000 ALTER TABLE `disc_ammo` DISABLE KEYS */;
/*!40000 ALTER TABLE `disc_ammo` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.dopeplants
DROP TABLE IF EXISTS `dopeplants`;
CREATE TABLE IF NOT EXISTS `dopeplants` (
  `owner` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `plant` longtext COLLATE utf8mb4_bin NOT NULL,
  `plantid` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.dopeplants: ~0 rows (approximately)
DELETE FROM `dopeplants`;
/*!40000 ALTER TABLE `dopeplants` DISABLE KEYS */;
/*!40000 ALTER TABLE `dopeplants` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.dpkeybinds
DROP TABLE IF EXISTS `dpkeybinds`;
CREATE TABLE IF NOT EXISTS `dpkeybinds` (
  `id` varchar(50) DEFAULT NULL,
  `keybind1` varchar(50) DEFAULT 'num4',
  `emote1` varchar(255) DEFAULT '',
  `keybind2` varchar(50) DEFAULT 'num5',
  `emote2` varchar(255) DEFAULT '',
  `keybind3` varchar(50) DEFAULT 'num6',
  `emote3` varchar(255) DEFAULT '',
  `keybind4` varchar(50) DEFAULT 'num7',
  `emote4` varchar(255) DEFAULT '',
  `keybind5` varchar(50) DEFAULT 'num8',
  `emote5` varchar(255) DEFAULT '',
  `keybind6` varchar(50) DEFAULT 'num9',
  `emote6` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table tqrpbase.dpkeybinds: ~1 rows (approximately)
DELETE FROM `dpkeybinds`;
/*!40000 ALTER TABLE `dpkeybinds` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpkeybinds` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.fine_types
DROP TABLE IF EXISTS `fine_types`;
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `jailtime` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.fine_types: ~79 rows (approximately)
DELETE FROM `fine_types`;
/*!40000 ALTER TABLE `fine_types` DISABLE KEYS */;
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`, `jailtime`) VALUES
	(61, '1.1 - ULTRAPASSAR SINAL VERMELHO ', 75, 0, 0),
	(62, '1.2 - ANDAR SEM CAPACETE (Moto)', 50, 0, 0),
	(63, '1.3 - CONDUZIR SEM HABILITAÇÃO', 250, 0, 0),
	(64, '1.4 - ANDAR COM VEICULO DANIFICADO', 50, 0, 0),
	(65, '1.5 - ESTACIONAR EM LOCAL PROIBIDO', 75, 0, 0),
	(66, '1.6 - CONDUZIR EMBRIAGADO', 100, 0, 0),
	(67, '1.7 - VEICULO CLONADO/FURTO', 550, 0, 15),
	(68, '1.8 - ABANDONO DE VEÍCULO', 150, 0, 0),
	(69, '1.9 - FUGA APÓS CAUSAR UM ACIDENTE', 550, 0, 10),
	(70, '1.10- EXCESSO DE VELOCIDADE', 100, 0, 0),
	(71, '1.11 - CONDUÇÃO IMPRUDENTE', 110, 0, 0),
	(72, '1.12 - MODIFICAÇÕES  ILEGAIS', 10, 0, 0),
	(73, '2.1 - TRAJES (Balístico)', 50, 1, 8),
	(74, '2.2 - COLETES (Balístico)', 75, 1, 10),
	(75, '2.3 - OBSTRUÇÃO FACIAL(Máscaras/ Capacetes totalmente fechados)', 50, 1, 0),
	(76, '2.4 - CAPACETE  (Balístico)', 150, 1, 0),
	(77, '2.5 - INADIMPLÊNCIA( Ter mais de 5 multas/faturas não pagas)', 0, 1, 60),
	(78, '3.1 - FORMAÇÃO DE QUADRILHA', 0, 2, 10),
	(79, '3.2 - ROUBO A BANCO', 6000, 2, 80),
	(80, '3.3 - ROUBO A LOJAS', 2000, 2, 25),
	(81, '3.4 - ROUBO A CIVIL', 750, 2, 20),
	(82, '3.5 - ROUBO  A PROPIEDADE', 950, 2, 15),
	(83, '3.6 - ROUBO  A JOELHARIA', 3000, 2, 40),
	(84, '4.1 - OCULTAÇÃO DE PROVAS', 2000, 3, 20),
	(85, '4.2 - TENTATIVA DE SUBORNO', 0, 3, 15),
	(86, '4.3 - FALSA REPRESENTAÇÃO DE UM ADVOGADO/FUNCIONÁRIO DO GOV', 250, 3, 20),
	(87, '4.4 - NÃO COMPARECER EM TRIBUNAL', 0, 3, 14),
	(88, '4.5 - OBSTRUÇÃO DE JUSTIÇA', 250, 3, 10),
	(89, '4.6 - RELATÓRIO FALSO', 500, 3, 8),
	(90, '4.7 - ABUSAR DA LINHA DE EMERGÊNCIA', 275, 3, 0),
	(91, '4.8 - DESRESPEITO AO TRIBUNAL', 500, 3, 10),
	(92, '4.9 - NÃO APARECER NO DEPARTAMENTO DA POLÍCIA', 0, 3, 3),
	(93, '4.10 - PESCA ILEGAL', 500, 3, 0),
	(94, '5.1 - RESISTÊNCIA A PRISÃO', 700, 4, 10),
	(95, '5.2 - OMISSÃO DE SOCORRO', 500, 4, 5),
	(96, '5.3 - DANO AO PATRIMÔNIO PÚBLICO', 500, 4, 5),
	(97, '5.4 - DIFAMAÇÃO', 500, 4, 5),
	(98, '5.5 - FURTO', 500, 4, 20),
	(99, '5.6 - ROUBO', 950, 4, 16),
	(100, '5.7 - ATENTADO AO PUDOR', 100, 4, 5),
	(101, '5.8 - POLUIÇÃO SONORA', 250, 4, 0),
	(102, '5.9 - TENTATIVA DE FUGA', 750, 4, 7),
	(103, '5.10 - FUGA A POLÍCIA', 1000, 4, 15),
	(104, '5.11 - DESMANTELAMENTO DE VEICULOS', 300, 4, 10),
	(105, '5.12 - ESCAPAR A CUSTODIA', 1000, 4, 20),
	(106, '6.1 - DESACATO', 200, 5, 3),
	(107, '6.2 - DESOBEDECER A AUTORIDADE', 500, 5, 0),
	(108, '6.3 - EXTORSÃO', 1200, 5, 10),
	(109, '6.4 - FALSIDADE IDEOLÓGICA', 100, 5, 5),
	(110, '6.5 - CALÚNIA', 100, 5, 3),
	(111, '6.6 - PERJÚRIO', 7500, 5, 60),
	(112, '6.7 - AGRESSÃO', 250, 5, 10),
	(113, '6.8 - AMEAÇA', 600, 5, 10),
	(114, '6.9 - SEQUESTRO', 900, 5, 15),
	(115, '6.10 - INVASÃO', 250, 5, 5),
	(116, '7.1 - HOMICÍDIO DOLOSO (com intenção de matar)', 4000, 6, 40),
	(117, '7.2 - HOMICÍDIO CULPOSO (sem intenção de matar)', 2000, 6, 20),
	(118, '7.3 - LATROCÍNIO ', 4000, 6, 60),
	(119, '7.4 - HOMICÍDIO DE FUNCIONARIO PÚBLICO ', 2000, 6, 30),
	(120, '8.0 - Tazer', 750, 7, 0),
	(121, '8.1 - Pistola ', 950, 7, 15),
	(122, '8.2 - Pistola Automática ou de Alto Calibre', 1000, 7, 30),
	(123, '8.3 - Caçadeira ', 3000, 7, 35),
	(124, '8.4 - SubMetralhadora ', 4500, 7, 35),
	(125, '8.6- Arma Branca ', 500, 7, 5),
	(126, '8.7 - MicroSMG', 2500, 7, 40),
	(127, '8.8 - Posse de Ferramentas de Roubo', 350, 7, 10),
	(128, '8.9 - Posse de Blueprints Ilegais', 500, 7, 10),
	(129, '9.1 - TRÁFICO DE ARMAS', 2000, 8, 25),
	(130, '9.2 - TRÁFICO DE HAXIXE (Por 2g/saco) ', 22, 8, 1),
	(131, '9.3 - TRÁFICO DE OSTRAS ', 1500, 8, 15),
	(132, '9.4 - TRÁFICO DE TUBARÃO', 3500, 8, 30),
	(133, '9.5 - DINHEIRO SUJO', 5500, 8, 20),
	(134, '9.6 - TRÁFICO DE PARTES DE ARAMENTO', 200, 8, 20),
	(135, '9.7 - TRÁFICO DE METANFETAMINA', 30, 8, 1),
	(136, '9.8 - TRÁFICO DE ERVA', 20, 8, 1),
	(137, '9.9 -  VENDA ILEGAL DE OBJETOS', 400, 8, 7),
	(138, '3.7 - ROUBO A LOJA DE ARMAS', 3500, 2, 30),
	(139, '3.8 - ROUBO A CARRINHA FORTE', 3500, 2, 30);
/*!40000 ALTER TABLE `fine_types` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.glovebox_inventory
DROP TABLE IF EXISTS `glovebox_inventory`;
CREATE TABLE IF NOT EXISTS `glovebox_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) COLLATE utf8mb4_bin NOT NULL,
  `data` text COLLATE utf8mb4_bin NOT NULL,
  `owned` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.glovebox_inventory: ~0 rows (approximately)
DELETE FROM `glovebox_inventory`;
/*!40000 ALTER TABLE `glovebox_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `glovebox_inventory` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.invest
DROP TABLE IF EXISTS `invest`;
CREATE TABLE IF NOT EXISTS `invest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) COLLATE utf8mb4_bin NOT NULL,
  `amount` float NOT NULL,
  `rate` float NOT NULL,
  `job` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `sold` datetime DEFAULT NULL,
  `soldAmount` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.invest: ~0 rows (approximately)
DELETE FROM `invest`;
/*!40000 ALTER TABLE `invest` DISABLE KEYS */;
/*!40000 ALTER TABLE `invest` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.items
DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `weight` float NOT NULL DEFAULT 1,
  `rare` tinyint(1) NOT NULL DEFAULT 0,
  `can_remove` tinyint(1) NOT NULL DEFAULT 1,
  `price` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.items: ~267 rows (approximately)
DELETE FROM `items`;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`, `price`) VALUES
	('2ct_gold_chain', '2CT Corrente Ouro', 0.7, 0, 1, 0),
	('Dispersante', 'Dispersante', 0.5, 0, 1, 0),
	('HeavyArmor', 'Colete Pesado', 10, 0, 1, 30),
	('MedArmor', 'Colete Médio', 4, 0, 1, 0),
	('MountedScope', 'Scope Pistolas MK2', 2, 0, 1, 0),
	('Pentrite', 'Pentrite', 0.5, 0, 1, 0),
	('SmallArmor', 'Colete Leve', 2, 0, 1, 0),
	('Suppressor', 'Silenciador', 0.5, 0, 1, 0),
	('WEAPON_ADVANCEDRIFLE', 'IMI Compact Tavor CTAR-21', 10, 0, 1, 50000),
	('WEAPON_APPISTOL', 'Colt SCAMP', 5, 0, 1, 50000),
	('WEAPON_ASSAULTRIFLE', 'AK-47 Norinco 56-2', 10, 0, 1, 50000),
	('WEAPON_ASSAULTSHOTGUN', 'UTAS UTS-15', 10, 0, 1, 50000),
	('WEAPON_ASSAULTSMG', 'FN P90 TR', 10, 0, 1, 50000),
	('WEAPON_AUTOSHOTGUN', 'Remington 870', 10, 0, 1, 50000),
	('WEAPON_BALL', 'Bola', 1, 0, 1, 50),
	('WEAPON_BAT', 'Taco Baseball', 5, 0, 1, 400),
	('WEAPON_BATTLEAXE', 'Machado de Batalha', 10, 0, 1, 760),
	('WEAPON_BOTTLE', 'Garrafa Partida', 2, 0, 1, 50),
	('WEAPON_BULLPUPRIFLE', 'Norinco Type 86S', 10, 0, 1, 50000),
	('WEAPON_BULLPUPSHOTGUN', 'Kel-Tec KSG', 10, 0, 1, 50000),
	('WEAPON_BZGAS', 'BZ Tear Gas', 2, 0, 1, 50000),
	('WEAPON_CARBINERIFLE', 'Colt AR-15', 10, 0, 1, 50000),
	('WEAPON_COMBATMG', 'Hybrid FN Derivative', 5, 0, 1, 50000),
	('WEAPON_COMBATPDW', 'MPX-SD', 5, 0, 1, 50000),
	('WEAPON_COMBATPISTOL', 'Glock 26', 5, 0, 1, 650),
	('WEAPON_COMPACTLAUNCHER', 'M79 Grenade Launcher', 10, 0, 1, 50000),
	('WEAPON_COMPACTRIFLE', 'AK Micro Draco', 10, 0, 1, 50000),
	('WEAPON_CROWBAR', 'Pé de Cabra', 5, 0, 1, 2655),
	('WEAPON_DAGGER', 'Punhal', 5, 0, 1, 60),
	('WEAPON_DBSHOTGUN', 'Caçadeira Duplo Cano', 5, 0, 1, 50000),
	('WEAPON_DIGISCANNER', 'Digiscanner', 5, 0, 1, 50000),
	('WEAPON_DOUBLEACTION', 'Colt New Army&Navy', 5, 0, 1, 50000),
	('WEAPON_FIREEXTINGUISHER', 'Extintor', 5, 0, 1, 80),
	('WEAPON_FIREWORK', 'Panzerschreck', 10, 0, 1, 5000),
	('WEAPON_FLARE', 'H&L Flare', 1, 0, 1, 70),
	('WEAPON_FLAREGUN', 'Flare Gun', 2, 0, 1, 0),
	('WEAPON_FLASHLIGHT', 'Lanterna', 2, 0, 1, 20),
	('WEAPON_GARBAGEBAG', 'Saco de Lixo', 10, 0, 1, 0),
	('WEAPON_GOLFCLUB', 'Taco de Golfe', 2, 0, 1, 1500),
	('WEAPON_GRENADE', 'M61 Hand Grenade', 10, 0, 1, 0),
	('WEAPON_GRENADELAUNCHER', 'Milkor Mark 14 MGL', 10, 0, 1, 0),
	('WEAPON_GUSENBERG', 'Thompson M1928A1', 10, 0, 1, 0),
	('WEAPON_HAMMER', 'Martelo', 1, 0, 1, 1500),
	('WEAPON_HANDCUFFS', 'Algemas', 1, 0, 1, 0),
	('WEAPON_HATCHET', 'Machado', 2, 0, 1, 0),
	('WEAPON_HEAVYPISTOL', 'W.B 1911', 5, 0, 1, 0),
	('WEAPON_HEAVYSHOTGUN', 'Saiga-12S', 10, 0, 1, 0),
	('WEAPON_HEAVYSNIPER', 'Barrett M107', 10, 0, 1, 0),
	('WEAPON_HOMINGLAUNCHER', 'FIM-92 Stinger', 10, 0, 1, 0),
	('WEAPON_KNIFE', 'Bayoneta', 2, 0, 1, 1000),
	('WEAPON_KNUCKLE', 'Soqueira', 2, 0, 1, 200),
	('WEAPON_MACHETE', 'Machete', 5, 0, 1, 0),
	('WEAPON_MACHINEPISTOL', 'Intratec TEC-DC9', 5, 0, 1, 22500),
	('WEAPON_MARKSMANPISTOL', 'Thompson C.A Contender', 10, 0, 1, 0),
	('WEAPON_MARKSMANRIFLE', 'Ruger Mini-30', 10, 0, 1, 0),
	('WEAPON_MG', 'Shrewsbury MG', 10, 0, 1, 0),
	('WEAPON_MICROSMG', '.45 ACP MiniUzi', 5, 0, 1, 0),
	('WEAPON_MINIGUN', 'M197 3b Gatling', 10, 0, 1, 0),
	('WEAPON_MINISMG', 'Sa.Vz. 82 Skorpion', 5, 0, 1, 0),
	('WEAPON_MOLOTOV', 'Molotov', 2, 0, 1, 0),
	('WEAPON_MUSKET', 'Musket M107 para Caça', 10, 0, 1, 12500),
	('WEAPON_NIGHTSTICK', 'Cacetete', 5, 0, 1, 0),
	('WEAPON_PETROLCAN', 'Jerrycan', 5, 0, 1, 0),
	('WEAPON_PIPEBOMB', 'Pipe Bomb', 2, 0, 1, 0),
	('WEAPON_PISTOL', 'Taurus PT92AF', 5, 0, 1, 11550),
	('WEAPON_PISTOL50', 'Desert Eagle', 5, 0, 1, 0),
	('WEAPON_POOLCUE', 'Taco de Bilhar', 2, 0, 1, 0),
	('WEAPON_PROXMINE', 'Mina de Proximidade', 2, 0, 1, 0),
	('WEAPON_PUMPSHOTGUN', 'Mossberg 590', 5, 0, 1, 0),
	('WEAPON_RAILGUN', 'Rail Gun', 10, 0, 1, 0),
	('WEAPON_REVOLVER', 'Colt 1851', 5, 0, 1, 0),
	('WEAPON_RPG', 'RPG-7', 10, 0, 1, 0),
	('WEAPON_SAWNOFFSHOTGUN', 'Mossberg 500', 5, 0, 1, 24500),
	('WEAPON_SMG', 'Heckler&Koch MP5N', 5, 0, 1, 3000),
	('WEAPON_SMOKEGRENADE', 'M18 Smoke Grenade', 2, 0, 1, 0),
	('WEAPON_SNIPERRIFLE', 'AW-F Sniper', 10, 0, 1, 0),
	('WEAPON_SNOWBALL', 'Bola de Neve', 0.5, 0, 1, 0),
	('WEAPON_SNSPISTOL', 'Heckler&Koch P7M10', 5, 0, 1, 5000),
	('WEAPON_SPECIALCARBINE', 'Heckler&Koch G36C', 10, 0, 1, 3500),
	('WEAPON_STICKYBOMB', 'M112 C4', 2, 0, 1, 0),
	('WEAPON_STINGER', 'Stinger', 10, 0, 1, 0),
	('WEAPON_STUNGUN', 'Stinger S-200', 2, 0, 1, 100),
	('WEAPON_SWITCHBLADE', 'Ponta e Mola', 2, 0, 1, 750),
	('WEAPON_VINTAGEPISTOL', 'FN Model 1922', 5, 0, 1, 0),
	('WEAPON_WRENCH', 'Chave Inglesa', 10, 0, 1, 3785),
	('acetone', 'Acetona', 0.6, 0, 1, 24),
	('acidbat', 'Ácido de Bateria', 0.5, 0, 1, 20),
	('advancedlockpick', 'Gazua Avançada', 0.5, 0, 1, 0),
	('ammoanalyzer', 'Analizador de Munição', 5, 0, 1, 0),
	('anchor', 'Âncora', 20, 0, 1, 0),
	('anel', 'Anel de Ouro', 1, 0, 1, 0),
	('arma_alcademira', 'Alça de Mira', 0.5, 0, 1, 965),
	('arma_armacaocar', 'Armação Carabina', 0.5, 0, 1, 0),
	('arma_armacaopistola', 'Armação Pistola', 2, 0, 1, 3000),
	('arma_botao', 'Botão Carregador', 0.5, 0, 1, 0),
	('arma_cano', 'Cano para Arma', 0.5, 0, 1, 780),
	('arma_canocarabina', 'Cano Carabina', 0.5, 0, 1, 0),
	('arma_cao', 'Cão de Arma', 0.5, 0, 1, 760),
	('arma_gatilho', 'Gatilho', 0.5, 0, 1, 600),
	('arma_mola', 'Mola', 0.5, 0, 1, 650),
	('arma_percurssor', 'Percurssor', 0.5, 0, 1, 460),
	('arma_percurssorcar', 'Percurssor de Carabina', 0.5, 0, 1, 0),
	('arma_tambor', 'Tambor de Arma', 0.5, 0, 1, 420),
	('armacaodb', 'Armação Caçadeira DC', 5, 0, 1, 0),
	('armbrace', 'Braçadeira', 0.5, 0, 1, 50),
	('bagofdope', 'Dose de Haxixe 2g', 0.2, 0, 1, 0),
	('bagofmeth', 'Metafeminina 2g', 0.1, 0, 1, 0),
	('bandage', 'Ligadura', 0.5, 0, 1, 0),
	('bankkey', 'Cartão do Gerente', 0.1, 0, 1, 0),
	('batteri', 'Pilhas', 0.5, 0, 1, 0),
	('binoculos', 'Binoculos', 0.5, 0, 1, 20),
	('blindfold', 'Venda para os Olhos', 0.1, 0, 1, 10),
	('bloodsample', 'Amostra de Sangue', 0.1, 0, 1, 0),
	('blowtorch', 'Maçarico', 2, 0, 1, 350),
	('blueberry_fruit', 'Mirtilo', 0.5, 0, 1, 0),
	('blueberry_package', 'Caixa de mirtilos', 5, 0, 1, 0),
	('blueberry_seed', 'Semente de Mirtilos', 0.1, 0, 1, 65),
	('bobbypin', 'Gancho para o Cabelo', 0.1, 0, 1, 0),
	('borracha', 'Borracha', 0.5, 0, 1, 0),
	('bottleWater_package', 'Caixa de garrafas de agua', 5, 0, 1, 0),
	('bread', 'Big Queen', 0.1, 0, 1, 1),
	('bulletproof', 'Colete à prova de bala', 5, 0, 1, 0),
	('bulletsample', 'Cartucho de bala', 0.5, 0, 1, 0),
	('cabomadeira', 'Cabo de Madeira', 0.5, 0, 1, 0),
	('cabplastico', 'Cabo de Borracha', 0.5, 0, 1, 0),
	('carbon_piece', 'Pedaço de Carvão', 1, 0, 1, 0),
	('carokit', 'Kit Á Maduka', 1.5, 0, 1, 300),
	('carotool', 'Utensílios de Reparação', 1.5, 0, 1, 0),
	('cascadebanana', 'Casca de Banana', 0.1, 0, 1, 55),
	('cebmartelo', 'Cabeça de Martelo', 2, 0, 1, 0),
	('chips', 'Fichas', 0, 0, 1, 0),
	('chips3qrp', 'Fichas Casino', 0, 0, 1, 0),
	('cigarett', 'Cigarro', 0.1, 0, 1, 3),
	('clip', 'Munição x15', 0.5, 0, 1, 2850),
	('coffee', 'Café', 0.2, 0, 5, 0),
	('cokeburn', 'USB-C Branco', 0.5, 0, 1, 0),
	('comp_explosivo', 'Componente Explosivo', 1.5, 0, 1, 0),
	('copper', 'Cobre', 0.5, 0, 1, 400),
	('craftingtable', 'Mesa de Craft', 25, 0, 1, 0),
	('cuff_keys', 'Chave Algemas', 0.1, 0, 1, 0),
	('cuffs', 'Algemas', 0.5, 0, 1, 0),
	('darknet', 'Dark Net', 1, 0, 1, 0),
	('detonador', 'Detonador', 1, 0, 1, 0),
	('dia_box', 'Caixa de Diamantes', 2, 0, 1, 0),
	('diamond', 'Diamantes', 0.5, 0, 1, 0),
	('dirty_waterBottle', 'Garrafa de Água Suja', 1, 0, 1, 0),
	('disc_ammo_pistol', 'Munição para Pistola', 1.5, 0, 1, 800),
	('disc_ammo_pistol_large', '3x Munição para Pistola ', 2, 0, 1, 50),
	('disc_ammo_rifle', 'Rifle Ammo', 1.5, 0, 1, 0),
	('disc_ammo_rifle_large', 'Rifle Ammo Large', 2, 0, 1, 0),
	('disc_ammo_shotgun', 'Shotgun Shells', 1.5, 0, 1, 0),
	('disc_ammo_shotgun_large', 'Shotgun Shells Large', 2, 0, 1, 60),
	('disc_ammo_smg', 'SMG Ammo', 1.5, 0, 1, 1000),
	('disc_ammo_smg_large', 'SMG Ammo Large', 2, 0, 1, 150),
	('disc_ammo_snp', 'Sniper Ammo', 1.5, 0, 1, 0),
	('disc_ammo_snp_large', 'Sniper Ammo Large', 2, 0, 1, 0),
	('dnaanalyzer', 'Analizador de ADN', 2, 0, 1, 0),
	('dopebag', '50x Saco Embalar', 1.5, 0, 1, 5),
	('drugbags', 'Sacos', 0.5, 0, 1, 0),
	('drugscales', 'Balança', 0.2, 0, 1, 0),
	('ducttape', 'Fita Adesiva', 0.1, 0, 1, 30),
	('emptybottleglass', 'Garrafa de Agua Vazia', 0.1, 0, 1, 0),
	('energy', 'Queenbull', 1, 0, 1, 500),
	('fabric', 'Pano', 0.1, 0, 1, 30),
	('fertilizer_25', 'Fertilizante', 1.5, 0, 1, 5),
	('filter', 'Filtro de Cartão', 0.1, 0, 1, 1),
	('firstaid', 'First-Aid Kit', 1, 0, 1, 0),
	('firstaidkit', 'Kit 1ºs Socorros', 0.5, 0, 1, 0),
	('fish', 'Peixe cru', 0.5, 0, 1, 0),
	('fishbait', 'Isco de Peixe', 0.5, 0, 1, 2),
	('fishingbait', 'Fishing Bait', 1, 0, 1, 0),
	('fishingknife', 'Faca Utilitária', 0.5, 0, 1, 50),
	('fishingrod', 'Cana de Pesca', 1, 0, 1, 100),
	('fixkit', 'Kit Á-Barinho', 0.5, 0, 1, 400),
	('flashlight', 'Lanterna Para Armas', 1, 0, 1, 0),
	('full_waterBottle', 'Garrafa de agua pura', 1, 0, 1, 0),
	('gasmask', 'Mascara de Gas', 0.2, 0, 1, 100),
	('gasolinehi276', 'Gasolina Com-276', 1.5, 0, 1, 3),
	('gauze', 'Gaze', 0.1, 0, 1, 0),
	('gold', 'Ouro', 1.5, 0, 1, 0),
	('gold_bar', 'Barra de Ouro 400oz', 11, 0, 1, 0),
	('gold_piece', 'Pepita de Ouro', 1, 0, 1, 0),
	('graodecafe', 'Grão de Café', 0.1, 0, 1, 0),
	('gym_membership', 'Cartão Ginásio', 0.1, 0, 1, 80),
	('highgradefemaleseed', 'Semente de Erva Fêmea', 0.1, 0, 1, 0),
	('highgradefert', 'Fertilizante 50PXC', 2, 0, 1, 130),
	('highgrademaleseed', 'Semente de Erva Macho', 0.1, 0, 1, 0),
	('hqscale', 'Balança Alta Qualidade', 3, 0, 1, 125000),
	('hydrocodone', 'Hydrocodona', 0.5, 0, 1, 0),
	('icetea', 'ForTheQueen', 0.5, 0, 1, 0),
	('id_card', 'Cartão do Gerente', 0.1, 0, 1, 0),
	('iron', 'Ferro', 1.5, 0, 1, 0),
	('iron_piece', 'Pepita de Ferro', 1.5, 0, 1, 0),
	('jager', 'Tres Padradas', 0.5, 0, 1, 0),
	('jagerbomb', 'Spawn 70', 0.5, 0, 1, 0),
	('jagercerbere', 'Lixo Real', 0.5, 0, 1, 0),
	('joint', 'Ganza', 0.2, 0, 1, 0),
	('jusfruit', 'Na Bolso', 0.5, 0, 1, 0),
	('key', 'Chaves', 0.1, 0, 1, 0),
	('lamina', 'Lâmina', 0.5, 0, 1, 0),
	('laptop_h', 'Portatil do B1G', 1, 0, 1, 0),
	('lighter', 'Isqueiro', 0.1, 0, 1, 4),
	('lingot_carbon', 'Carvão Processado', 10, 0, 1, 0),
	('lingot_gold', 'Lingote de ouro', 2, 0, 1, 0),
	('lingot_iron', 'Lingote de ferro', 2, 0, 1, 0),
	('lingot_silver', 'Lingote de prata', 2, 0, 1, 0),
	('lithium', 'Lítio de Baterias', 0.7, 0, 1, 41),
	('lockpick', 'Gazua', 0.2, 0, 1, 255),
	('lockpickcar', 'Gazua Especial', 0.2, 0, 1, 255),
	('martini', 'Martini', 0.2, 0, 1, 0),
	('massademira', 'Massa de Mira', 0.2, 0, 1, 0),
	('mckey', 'Chave Lost MC', 0.2, 0, 1, 0),
	('medikit', 'Kit Médico', 0.2, 0, 1, 0),
	('medkit', 'Medkit', 1, 0, 1, 0),
	('menthe', 'Mint Martino', 0.2, 0, 1, 0),
	('meth', 'Metafeminina 100g', 0.5, 0, 1, 0),
	('methburn', 'Blue USB-C', 0.5, 0, 1, 0),
	('methlab', 'Kit de Laboratório', 30, 0, 1, 0),
	('mixapero', 'Aprol Spritz', 0.5, 0, 1, 0),
	('mojito', 'Mojito', 0.5, 0, 1, 0),
	('molafaca', 'Mola para Faca', 0.5, 0, 1, 0),
	('morphine', 'Morfina', 1, 0, 1, 0),
	('nail', 'Prego', 0.1, 0, 1, 20),
	('neckbrace', 'Braçadeira Pescoço', 0.5, 0, 1, 16),
	('net_cracker', 'Net Cracker', 0.5, 0, 1, 0),
	('note', 'Nota em Branco', 0.1, 0, 1, 2),
	('notepad', 'Bloco de Notas', 0.1, 0, 1, 5),
	('odorizante', 'Odorizante', 0.5, 0, 1, 0),
	('oxido_ferro', 'Oxido de Ferro', 0.5, 0, 1, 0),
	('oxycutter', 'Maçarico Plasma', 5, 0, 1, 0),
	('oxygen_mask', 'Máscara de Oxigénio', 50, 0, 1, 62),
	('pacificidcard', 'Cartão ID Banco', 0.1, 0, 1, 0),
	('packaged_plank', 'Tábuas Empacotadas', 2, 0, 1, 0),
	('pearl_b', 'Ostra Fresca', 0.5, 0, 1, 0),
	('petrol', 'Petróleo', 2, 0, 1, 0),
	('petrol_raffin', 'Petróleo Refinado', 1, 0, 1, 0),
	('phone', 'Telemóvel', 0.5, 0, 1, 55),
	('pine_processed', 'Madeira de pinho procesada', 1.5, 0, 1, 0),
	('pine_wood', 'Madeira de pinho', 2, 0, 1, 0),
	('plantpot', 'Vaso para Planta', 2, 0, 1, 0),
	('playersafe', 'Cofre', 20, 0, 1, 0),
	('pneu', 'Pneu', 5, 0, 1, 0),
	('pollution_waterBottle', 'Garrafa de agua Contaminada', 0.5, 0, 1, 0),
	('purifiedwater', 'Água Purificada', 0.5, 0, 1, 0),
	('queencoin', 'Queencoin', 0.5, 0, 1, 0),
	('radio', 'Rádio', 0.5, 0, 1, 50),
	('recipe_WEAPON_CROWBAR', 'Blueprint: Pé de Cabra', 0.1, 0, 1, 0),
	('recipe_WEAPON_DBSHOTGUN', 'Blueprint: Caçadeira Duplo Cano', 0.1, 0, 1, 0),
	('recipe_WEAPON_HAMMER', 'Blueprint: Martelo', 0.1, 0, 1, 0),
	('recipe_WEAPON_HEAVYPISTOL', 'Blueprint: W.B 1911', 0.1, 0, 1, 0),
	('recipe_WEAPON_MACHETE', 'Blueprint: Machete', 0.1, 0, 1, 0),
	('recipe_WEAPON_MACHINEPISTOL', 'Blueprint: Intratec TEC-DC9', 0.1, 0, 1, 0),
	('recipe_WEAPON_MINISMG', 'Blueprint: Sa.Vz. 82 Skorpion', 0.1, 0, 1, 0),
	('recipe_WEAPON_PISTOL', 'Blueprint: Taurus PT92AF', 0.1, 0, 1, 0),
	('recipe_WEAPON_SWITCHBLADE', 'Blueprint: Ponta e Mola', 0.1, 0, 1, 0),
	('recipe_WEAPON_WRENCH', 'Blueprint: Chave Inglesa', 0.1, 0, 1, 0),
	('recipe_advancedlockpick', 'Blueprint: Gazua Avançada', 0.1, 0, 1, 0),
	('recipe_arma_armacaopistola', 'Blueprint: Armação de Pistola', 0.1, 0, 1, 0),
	('recipe_arma_cano', 'Blueprint: Cano de Pistola', 0.1, 0, 1, 0),
	('recipe_arma_cao', 'Blueprint: Cão de Arma', 0.1, 0, 1, 0),
	('recipe_arma_gatilho', 'Blueprint: Gatilho', 0.1, 0, 1, 0),
	('recipe_arma_mola', 'Blueprint: Mola de Arma', 0.1, 0, 1, 0),
	('recipe_arma_percurssor', 'Blueprint: Percurssor', 0.1, 0, 1, 0),
	('recipe_arma_tambor', 'Blueprint: Tambor', 0.1, 0, 1, 0),
	('recipe_armacaodb', 'Blueprint: Armação Caçadeira DC', 0.2, 0, 1, 0),
	('recipe_cabomadeira', 'Blueprint: Cabo de Madeira', 0.1, 0, 1, 0),
	('recipe_cabplastico', 'Blueprint: Cabo de Borracha', 0.1, 0, 1, 0),
	('recipe_cebmartelo', 'Blueprint: Cabeça de Martelo', 0.1, 0, 1, 0),
	('recipe_lamina', 'Blueprint: Lâmina', 0.1, 0, 1, 0),
	('recipe_lockpick', 'Blueprint: Gazua', 0.1, 0, 1, 0),
	('recipe_massademira', 'Blueprint: Massa de Mira', 0.2, 0, 1, 0),
	('recipe_molafaca', 'Blueprint: Mola de Faca', 0.1, 0, 1, 0),
	('recipe_nail', 'Blueprint: Prego', 0.1, 0, 1, 8000),
	('recipe_plantpot', 'Blueprint: Vaso para Plantas', 0.1, 0, 1, 0),
	('recipe_screw', 'Blueprint: Parafuso', 0.2, 0, 1, 8000),
	('redphosphorus', 'Fósforo Vermelho', 0.1, 0, 1, 0),
	('rhum', 'Rum', 0.1, 0, 1, 0),
	('rhumcoca', 'Cuba Livre', 0.5, 0, 1, 0),
	('rhumfruit', 'Rum Fruta', 0.5, 0, 1, 0),
	('rolex', 'Relógio Rolex', 0.5, 0, 1, 0),
	('rolpaper', 'Mortalha', 0.1, 0, 1, 1),
	('rope', 'Corda', 0.5, 0, 1, 0),
	('salt_waterBottle', 'Garrafa de agua com sal', 0.5, 0, 1, 0),
	('saucisson', 'Taco', 0.5, 0, 1, 0),
	('scrapmetal', 'Aluminio', 1.5, 0, 1, 0),
	('screw', 'Parafuso', 0.2, 0, 1, 20),
	('screwdriver', 'Chave de Fendas', 0.5, 0, 1, 300),
	('shark', 'Tubarão', 30, 0, 1, 0),
	('shell_a', 'Ostras Concha', 2.5, 0, 1, 0),
	('sickle', 'Foice', 1.5, 0, 1, 385),
	('silver', 'Prata', 0.5, 0, 1, 0),
	('silver_piece', 'Pepita de Prata', 0.5, 0, 1, 0),
	('stone', 'Pedra', 5, 0, 1, 0),
	('tactitalmuzle', 'Cano de Arma', 0.5, 0, 1, 0),
	('tec9_body', 'Corpo Tec-9', 5, 0, 1, 5000),
	('terra', 'Terra', 0.1, 0, 1, 0),
	('thermal_charge', 'Carga Termica', 1, 0, 1, 0),
	('tira_magnesio', 'Tira de Magnesio', 0.5, 0, 1, 0),
	('tomato_fruit', 'Tomate', 0.5, 0, 1, 0),
	('tomato_package', 'Caixa de tomates', 4, 0, 1, 0),
	('tomato_seed', 'Semente de Tomates', 0.1, 0, 1, 42),
	('toxic_waterBottle', 'Garrafa de Agua Poluida', 0.5, 0, 1, 0),
	('trimmedweed', 'Marijuana Cortada', 0.1, 0, 1, 0),
	('tuboplastico', 'Tubo de Plástico', 0.5, 0, 1, 0),
	('tuning_laptop', 'Tablet Xuning450', 0.5, 0, 1, 0),
	('turtle', 'Tartaruga', 0.5, 0, 1, 0),
	('turtlebait', 'Isca Tartaruga', 0.5, 0, 1, 0),
	('usbhack', 'USB Hacking Banco', 0.5, 0, 1, 0),
	('vicodin', 'Vicodin', 0.5, 0, 1, 68),
	('vodka', 'Casa dos Mirtillos', 0.5, 0, 1, 0),
	('water', 'Garrafa de Agua', 0.5, 0, 1, 2),
	('waterBottle', 'Garrafa Vazia', 0.1, 0, 1, 0),
	('water_50', 'Garrafa de Agua 50L', 0.5, 0, 1, 2),
	('wateringcan', 'Regador', 2, 0, 1, 0),
	('weed_100', 'Haxixe 100g', 1, 0, 1, 0),
	('weed_brick', 'Tijolo Haxixe', 10.5, 0, 1, 0),
	('weedburn', 'USB-C Verde', 0.5, 0, 1, 0),
	('whiskycoca', 'Wuivski', 0.5, 0, 1, 0),
	('wire', 'Arame', 0.5, 0, 1, 0),
	('wood', 'Madeira', 2, 0, 1, 0),
	('wool', 'Lã', 0.5, 0, 1, 0);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.jobs
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.jobs: ~17 rows (approximately)
DELETE FROM `jobs`;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('ambulance', 'SEM', 0),
	('ballas', 'Ballas', 0),
	('banker', 'Banquier', 0),
	('cardealer', 'Concessionnaire', 0),
	('juiz', 'Juiz', 1),
	('lost', 'The Lost', 1),
	('mechanic', 'Benny\'S', 0),
	('mechanic2', 'LS Custom\'S', 0),
	('millers', 'Millers', 1),
	('offambulance', 'Off-Duty', 0),
	('offpolice', 'Off-Duty', 0),
	('police', 'LSPD', 0),
	('realestateagent', 'PB', 0),
	('state', 'Estado', 0),
	('taxi', 'O Matos', 0),
	('unemployed', 'Desempregado', 0),
	('unicorn', 'Vanilla', 1);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.job_grades
DROP TABLE IF EXISTS `job_grades`;
CREATE TABLE IF NOT EXISTS `job_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext COLLATE utf8mb4_bin NOT NULL,
  `skin_female` longtext COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.job_grades: ~67 rows (approximately)
DELETE FROM `job_grades`;
/*!40000 ALTER TABLE `job_grades` DISABLE KEYS */;
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(1, 'unemployed', 0, 'unemployed', 'Desempregado', 30, '{}', '{}'),
	(2, 'ambulance', 0, 'ambulance', 'Paramedicos', 1500, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":3,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":117,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":1}', '{"tshirt_2":1,"hair_color_1":-1,"glasses_2":-1,"shoes":2,"torso_2":0,"hair_color_2":0,"pants_1":36,"glasses_1":-1,"hair_1":-1,"sex":1,"decals_2":0,"tshirt_1":44,"helmet_1":-1,"helmet_2":0,"arms":3,"face":-1,"decals_1":-1,"torso_1":147,"hair_2":0,"skin":-1,"pants_2":-1}'),
	(3, 'ambulance', 1, 'doctor', 'Estagiário', 1750, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":3,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":117,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":1}', '{"tshirt_2":1,"hair_color_1":-1,"glasses_2":-1,"shoes":2,"torso_2":0,"hair_color_2":0,"pants_1":36,"glasses_1":-1,"hair_1":-1,"sex":1,"decals_2":0,"tshirt_1":44,"helmet_1":-1,"helmet_2":0,"arms":3,"face":-1,"decals_1":-1,"torso_1":147,"hair_2":0,"skin":-1,"pants_2":-1}'),
	(4, 'ambulance', 2, 'chief_doctor', 'Médico De Familia', 2000, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":3,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":117,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":1}', '{"tshirt_2":1,"hair_color_1":-1,"glasses_2":-1,"shoes":2,"torso_2":0,"hair_color_2":0,"pants_1":36,"glasses_1":-1,"hair_1":-1,"sex":1,"decals_2":0,"tshirt_1":44,"helmet_1":-1,"helmet_2":0,"arms":3,"face":-1,"decals_1":-1,"torso_1":147,"hair_2":0,"skin":-1,"pants_2":-1}'),
	(5, 'ambulance', 5, 'boss', 'Director Hospitalar', 3000, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":3,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":117,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":1}', '{"tshirt_2":1,"hair_color_1":-1,"glasses_2":-1,"shoes":2,"torso_2":0,"hair_color_2":0,"pants_1":36,"glasses_1":-1,"hair_1":-1,"sex":1,"decals_2":0,"tshirt_1":44,"helmet_1":-1,"helmet_2":0,"arms":3,"face":-1,"decals_1":-1,"torso_1":147,"hair_2":0,"skin":-1,"pants_2":-1}'),
	(6, 'banker', 0, 'advisor', 'Conseiller', 10, '{}', '{}'),
	(7, 'banker', 1, 'banker', 'Banquier', 20, '{}', '{}'),
	(8, 'banker', 2, 'business_banker', 'Banquier d\'affaire', 30, '{}', '{}'),
	(9, 'banker', 3, 'trader', 'Trader', 40, '{}', '{}'),
	(10, 'banker', 4, 'boss', 'Patron', 0, '{}', '{}'),
	(11, 'mechanic', 0, 'recrue', 'Recruta', 30, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":3,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":1}', '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":39,"glasses_1":0,"hair_1":2,"sex":1,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":59,"hair_2":0,"skin":34,"pants_2":0}'),
	(12, 'mechanic', 1, 'novice', 'Novato', 30, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":3,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":1}', '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":39,"glasses_1":0,"hair_1":2,"sex":1,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":59,"hair_2":0,"skin":34,"pants_2":0}'),
	(13, 'mechanic', 2, 'experimente', 'Experiente', 30, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":3,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":1}', '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":39,"glasses_1":0,"hair_1":2,"sex":1,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":59,"hair_2":0,"skin":34,"pants_2":0}'),
	(14, 'mechanic', 3, 'chief', 'Chefe de Equipa', 30, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":0,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":0}', '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":39,"glasses_1":0,"hair_1":2,"sex":1,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":59,"hair_2":0,"skin":34,"pants_2":0}'),
	(15, 'mechanic', 4, 'boss', 'Patrão', 30, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":0,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":0}', '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":39,"glasses_1":0,"hair_1":2,"sex":1,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":59,"hair_2":0,"skin":34,"pants_2":0}'),
	(16, 'police', 0, 'recruta', 'Recruta', 500, '{}', '{}'),
	(17, 'police', 1, 'agente', 'Agente', 1000, '{}', '{}'),
	(18, 'police', 2, 'aprincipal', 'Agente Principal', 1250, '{}', '{}'),
	(19, 'police', 3, 'scapitao', 'Sub-Capitão', 1500, '{}', '{}'),
	(20, 'police', 8, 'boss', 'Chefe DPLS', 3000, '{}', '{}'),
	(21, 'realestateagent', 0, 'location', 'Comercial', 10, '{}', '{}'),
	(22, 'realestateagent', 1, 'vendeur', 'Vendedor', 25, '{}', '{}'),
	(23, 'realestateagent', 2, 'gestion', 'Gerente', 40, '{}', '{}'),
	(24, 'realestateagent', 3, 'boss', 'JB', 0, '{}', '{}'),
	(25, 'taxi', 0, 'recrue', 'O Matos', 30, '{}', '{}'),
	(30, 'unicorn', 0, 'barman', 'Barman', 30, '{}', '{}'),
	(31, 'unicorn', 1, 'dancer', 'Stripper', 30, '{}', '{}'),
	(32, 'unicorn', 2, 'viceboss', 'Sub-Gerente', 30, '{}', '{}'),
	(33, 'unicorn', 3, 'boss', 'Gerente', 30, '{}', '{}'),
	(34, 'cardealer', 0, 'recruit', 'Recrue', 10, '{}', '{}'),
	(35, 'cardealer', 1, 'novice', 'Novice', 25, '{}', '{}'),
	(36, 'cardealer', 2, 'experienced', 'Experimente', 40, '{}', '{}'),
	(37, 'cardealer', 3, 'boss', 'Patron', 0, '{}', '{}'),
	(44, 'offpolice', 0, 'recruta', 'Recruta', 0, '{}', '{}'),
	(45, 'offpolice', 1, 'agente', 'Agente', 0, '{}', '{}'),
	(46, 'offpolice', 2, 'aprincipal', 'Agente Principal', 0, '{}', '{}'),
	(47, 'offpolice', 3, 'aprincipal', 'Agente Principal', 0, '{}', '{}'),
	(48, 'offpolice', 4, 'capitao', 'Capitão', 0, '{}', '{}'),
	(49, 'offambulance', 0, 'ambulance', 'Estagiário', 0, '{}', '{}'),
	(50, 'offambulance', 1, 'doctor', 'Médico', 0, '{}', '{}'),
	(51, 'offambulance', 2, 'chief_doctor', 'Médico De Familia', 0, '{}', '{}'),
	(52, 'offambulance', 3, 'psicologo', 'Director Hospitalar', 0, '{}', '{}'),
	(53, 'ballas', 0, 'ballas', 'Ballas Gangshitzzz', 30, '{}', '{}'),
	(64, 'lost', 0, 'lost', 'The Lost MC', 30, '{}', '{}'),
	(65, 'ambulance', 3, 'psicologo', 'Psicologo', 2500, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":3,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":117,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":1}', '{"tshirt_2":1,"hair_color_1":-1,"glasses_2":-1,"shoes":2,"torso_2":0,"hair_color_2":0,"pants_1":36,"glasses_1":-1,"hair_1":-1,"sex":1,"decals_2":0,"tshirt_1":44,"helmet_1":-1,"helmet_2":0,"arms":3,"face":-1,"decals_1":-1,"torso_1":147,"hair_2":0,"skin":-1,"pants_2":-1}'),
	(66, 'ambulance', 4, 'cirugiao', 'Cirurgiao ', 2500, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":3,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":117,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":1}', '{"tshirt_2":1,"hair_color_1":-1,"glasses_2":-1,"shoes":2,"torso_2":0,"hair_color_2":0,"pants_1":36,"glasses_1":-1,"hair_1":-1,"sex":1,"decals_2":0,"tshirt_1":44,"helmet_1":-1,"helmet_2":0,"arms":3,"face":-1,"decals_1":-1,"torso_1":147,"hair_2":0,"skin":-1,"pants_2":-1}'),
	(67, 'millers', 0, 'millers', 'Millers', 30, '{}', '{}'),
	(68, 'police', 4, 'capitao', 'Capitão', 1750, '{}', '{}'),
	(69, 'police', 5, 'major', 'Major', 2000, '{}', '{}'),
	(70, 'police', 6, 'sargento', 'Sargento', 2250, '{}', '{}'),
	(71, 'police', 7, 'tgeneral', 'Tenente General', 2500, '{}', '{}'),
	(72, 'offpolice', 5, 'major', 'Major', 0, '{}', '{}'),
	(73, 'offpolice', 6, 'sargento', 'Sargento', 0, '{}', '{}'),
	(74, 'offpolice', 7, 'tgeneral', 'Tenente General', 0, '{}', '{}'),
	(75, 'offpolice', 8, 'boss', 'Chefe DPLS', 0, '{}', '{}'),
	(76, 'juiz', 0, 'aoficioso', 'Advogado Oficioso', 1500, '{}', '{}'),
	(77, 'juiz', 1, 'aparticular', 'Advogado Particular', 750, '{}', '{}'),
	(78, 'juiz', 2, 'procurador', 'Procurador', 1750, '{}', '{}'),
	(79, 'juiz', 3, 'juiz', 'Juiz', 2000, '{}', '{}'),
	(80, 'mechanic2', 0, 'recrue', 'Recruta', 30, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":3,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":1}', '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":39,"glasses_1":0,"hair_1":2,"sex":1,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":59,"hair_2":0,"skin":34,"pants_2":0}'),
	(81, 'mechanic2', 1, 'novice', 'Novato', 30, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":3,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":1}', '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":39,"glasses_1":0,"hair_1":2,"sex":1,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":59,"hair_2":0,"skin":34,"pants_2":0}'),
	(82, 'mechanic2', 2, 'experimente', 'Experiente', 40, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":3,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":1}', '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":39,"glasses_1":0,"hair_1":2,"sex":1,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":59,"hair_2":0,"skin":34,"pants_2":0}'),
	(83, 'mechanic2', 3, 'chief', 'Chefe de Equipa', 30, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":0,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":0}', '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":39,"glasses_1":0,"hair_1":2,"sex":1,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":59,"hair_2":0,"skin":34,"pants_2":0}'),
	(84, 'mechanic2', 4, 'boss', 'Patrão', 30, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":3,"torso_2":0,"hair_color_2":0,"pants_1":39,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":66,"hair_2":0,"skin":34,"pants_2":0}', '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":7,"torso_2":0,"hair_color_2":0,"pants_1":39,"glasses_1":0,"hair_1":2,"sex":1,"decals_2":0,"tshirt_1":15,"helmet_1":-1,"helmet_2":0,"arms":35,"face":19,"decals_1":60,"torso_1":59,"hair_2":0,"skin":34,"pants_2":0}'),
	(85, 'state', 3, 'minister', 'Ministro', 0, '{}', '{}'),
	(86, 'offambulance', 4, 'cirugiao', 'Cirurgiao ', 0, '{}', '{}'),
	(87, 'offambulance', 5, 'boss', 'Director Hospitalar', 0, '{}', '{}');
/*!40000 ALTER TABLE `job_grades` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.known_recipes
DROP TABLE IF EXISTS `known_recipes`;
CREATE TABLE IF NOT EXISTS `known_recipes` (
  `identifier` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `data` longtext COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.known_recipes: ~0 rows (approximately)
DELETE FROM `known_recipes`;
/*!40000 ALTER TABLE `known_recipes` DISABLE KEYS */;
/*!40000 ALTER TABLE `known_recipes` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.licenses
DROP TABLE IF EXISTS `licenses`;
CREATE TABLE IF NOT EXISTS `licenses` (
  `type` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.licenses: ~6 rows (approximately)
DELETE FROM `licenses`;
/*!40000 ALTER TABLE `licenses` DISABLE KEYS */;
INSERT INTO `licenses` (`type`, `label`) VALUES
	('boat', 'Marítima'),
	('dmv', 'Código'),
	('drive', 'Veículos Ligeiros'),
	('drive_bike', 'Motociclo'),
	('drive_truck', 'Veículos Pesados'),
	('weapon', 'Porte de arma');
/*!40000 ALTER TABLE `licenses` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.mdt_reports
DROP TABLE IF EXISTS `mdt_reports`;
CREATE TABLE IF NOT EXISTS `mdt_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `incident` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `charges` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `author` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `jailtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.mdt_reports: ~0 rows (approximately)
DELETE FROM `mdt_reports`;
/*!40000 ALTER TABLE `mdt_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdt_reports` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.mdt_warrants
DROP TABLE IF EXISTS `mdt_warrants`;
CREATE TABLE IF NOT EXISTS `mdt_warrants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `char_id` int(11) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `report_title` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `charges` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `expire` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `notes` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `author` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.mdt_warrants: ~0 rows (approximately)
DELETE FROM `mdt_warrants`;
/*!40000 ALTER TABLE `mdt_warrants` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdt_warrants` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.owned_vehicles
DROP TABLE IF EXISTS `owned_vehicles`;
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(22) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'State of the car',
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) NOT NULL,
  `x` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '232.22',
  `y` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '-800.74',
  `z` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '30.52',
  `h` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `health` int(11) DEFAULT 0,
  `garage` varchar(50) DEFAULT 'A',
  `lockcheck` int(11) NOT NULL DEFAULT 1,
  `finance` int(32) NOT NULL DEFAULT 0,
  `financetimer` int(32) NOT NULL DEFAULT 0,
  `time` bigint(20) NOT NULL DEFAULT 0,
  `tunerdata` longtext NOT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table tqrpbase.owned_vehicles: ~0 rows (approximately)
DELETE FROM `owned_vehicles`;
/*!40000 ALTER TABLE `owned_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `owned_vehicles` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.pawnshops
DROP TABLE IF EXISTS `pawnshops`;
CREATE TABLE IF NOT EXISTS `pawnshops` (
  `shopdata` longtext DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table tqrpbase.pawnshops: ~3 rows (approximately)
DELETE FROM `pawnshops`;
/*!40000 ALTER TABLE `pawnshops` DISABLE KEYS */;
INSERT INTO `pawnshops` (`shopdata`, `id`) VALUES
	('{"title":"Kevin daz drogazz","loc":{"z":4.66,"x":-1169.32,"y":-1572.78},"buy":[{"label":"Marijuana","price":80,"item":"trimmedweed","count":50,"max":50,"startcount":0},{"label":"Metanfetamina","price":120,"item":"meth","count":0,"max":40,"startcount":0}],"blip":false,"text":"Pressiona [~r~E~s~] pra falares com o Kevin.","sell":[{"label":"Marijuana","price":24,"count":50,"max":50,"item":"trimmedweed"},{"label":"Metanfetamina","price":50,"count":0,"max":40,"item":"meth"}]}', 1),
	('{"title":"Loja dos 500","loc":{"z":4.37,"x":-1215.91,"y":-1515.76},"buy":[{"label":"Rolex","price":1055,"count":182,"max":50,"item":"rolex"},{"label":"Oxycutter","price":1850,"count":0,"max":2,"item":"oxycutter"},{"label":"Corrente de Ouro","price":495,"count":500,"max":100,"item":"2ct_gold_chain"},{"label":"Perola","price":880,"count":1424,"max":5000,"item":"pearl_b"},{"label":"Anel","price":1500,"count":0,"max":50,"item":"anel"},{"label":"Caixa de Diamantes","price":5000,"count":6,"max":10,"item":"dia_box"}],"blip":false,"text":"Pressiona [~r~E~s~] para falar com o vendedor.","sell":[{"label":"Rolex","price":515,"count":182,"max":500,"item":"rolex"},{"label":"Oxycutter","price":650,"count":0,"max":2,"item":"oxycutter"},{"label":"Corrente de Ouro","price":495,"count":500,"max":500,"item":"2ct_gold_chain"},{"label":"Perola","price":120,"count":1424,"max":5000,"item":"pearl_b"},{"label":"Anel","price":800,"count":0,"max":50,"item":"anel"},{"label":"Caixa de Diamantes","price":1725,"count":6,"max":10,"item":"dia_box"}]}', 2),
	('{"title":"Black Market","loc":{"z":-30.27,"x":830.43,"y":-2171.67},"buy":[{"label":"Minigun","item":"weapon_minigun","price":999999999,"max":1,"count":0,"startcount":0,"weapon":true},{"label":"Assault Shotgun","item":"weapon_assaultshotgun","price":999999999,"max":5,"count":0,"startcount":0,"weapon":true},{"label":"Pump Shotgun","item":"weapon_pumpshotgun","price":999999999,"max":5,"count":0,"startcount":0,"weapon":true}],"blip":false,"text":"Press [~r~E~s~] to interact with the Black Market.","sell":[{"label":"Minigun","price":999999999,"item":"weapon_minigun","count":0,"max":1,"weapon":true},{"label":"Assault Shotgun","price":99999999,"item":"weapon_assaultshotgun","count":0,"max":5,"weapon":true},{"label":"Pump Shotgun","price":99999999,"item":"weapon_pumpshotgun","count":0,"max":5,"weapon":true}]}', 3);
/*!40000 ALTER TABLE `pawnshops` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.phone_calls
DROP TABLE IF EXISTS `phone_calls`;
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender` varchar(12) NOT NULL,
  `receiver` varchar(12) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` int(1) NOT NULL DEFAULT 0,
  `anon` int(1) NOT NULL DEFAULT 0,
  `sender_deleted` int(1) NOT NULL DEFAULT 0,
  `receiver_deleted` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table tqrpbase.phone_calls: ~0 rows (approximately)
DELETE FROM `phone_calls`;
/*!40000 ALTER TABLE `phone_calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_calls` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.phone_contacts
DROP TABLE IF EXISTS `phone_contacts`;
CREATE TABLE IF NOT EXISTS `phone_contacts` (
  `identifier` varchar(40) NOT NULL,
  `name` longtext NOT NULL,
  `number` longtext NOT NULL,
  `avatar` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table tqrpbase.phone_contacts: ~1 rows (approximately)
DELETE FROM `phone_contacts`;
/*!40000 ALTER TABLE `phone_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_contacts` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.phone_instas
DROP TABLE IF EXISTS `phone_instas`;
CREATE TABLE IF NOT EXISTS `phone_instas` (
  `identifier` varchar(60) DEFAULT NULL,
  `author` varchar(50) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `photo` varchar(255) NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table tqrpbase.phone_instas: ~0 rows (approximately)
DELETE FROM `phone_instas`;
/*!40000 ALTER TABLE `phone_instas` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_instas` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.phone_messages
DROP TABLE IF EXISTS `phone_messages`;
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` longtext NOT NULL DEFAULT 'current_timestamp()',
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Dumping data for table tqrpbase.phone_messages: 0 rows
DELETE FROM `phone_messages`;
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.phone_texts
DROP TABLE IF EXISTS `phone_texts`;
CREATE TABLE IF NOT EXISTS `phone_texts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender` varchar(12) NOT NULL DEFAULT '0',
  `receiver` varchar(12) NOT NULL DEFAULT '0',
  `message` varchar(255) NOT NULL DEFAULT '0',
  `sent_time` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `sender_read` int(1) NOT NULL DEFAULT 1,
  `sender_deleted` int(1) NOT NULL DEFAULT 0,
  `receiver_read` int(1) NOT NULL DEFAULT 0,
  `receiver_deleted` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `sender` (`sender`),
  KEY `receiver` (`receiver`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table tqrpbase.phone_texts: ~1 rows (approximately)
DELETE FROM `phone_texts`;
/*!40000 ALTER TABLE `phone_texts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_texts` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.phone_tweets
DROP TABLE IF EXISTS `phone_tweets`;
CREATE TABLE IF NOT EXISTS `phone_tweets` (
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `author` varchar(50) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table tqrpbase.phone_tweets: ~1 rows (approximately)
DELETE FROM `phone_tweets`;
/*!40000 ALTER TABLE `phone_tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_tweets` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.phone_yp
DROP TABLE IF EXISTS `phone_yp`;
CREATE TABLE IF NOT EXISTS `phone_yp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `advert` varchar(500) DEFAULT NULL,
  `phoneNumber` varchar(50) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table tqrpbase.phone_yp: ~0 rows (approximately)
DELETE FROM `phone_yp`;
/*!40000 ALTER TABLE `phone_yp` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_yp` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.playersafes
DROP TABLE IF EXISTS `playersafes`;
CREATE TABLE IF NOT EXISTS `playersafes` (
  `owner` varchar(50) NOT NULL,
  `location` longtext NOT NULL,
  `instance` varchar(50) NOT NULL,
  `inventory` longtext NOT NULL,
  `dirtymoney` int(11) NOT NULL,
  `weapons` longtext NOT NULL,
  `safeid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table tqrpbase.playersafes: ~0 rows (approximately)
DELETE FROM `playersafes`;
/*!40000 ALTER TABLE `playersafes` DISABLE KEYS */;
/*!40000 ALTER TABLE `playersafes` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.playerstattoos
DROP TABLE IF EXISTS `playerstattoos`;
CREATE TABLE IF NOT EXISTS `playerstattoos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `tattoos` varchar(5000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table tqrpbase.playerstattoos: ~1 rows (approximately)
DELETE FROM `playerstattoos`;
/*!40000 ALTER TABLE `playerstattoos` DISABLE KEYS */;
/*!40000 ALTER TABLE `playerstattoos` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.society_moneywash
DROP TABLE IF EXISTS `society_moneywash`;
CREATE TABLE IF NOT EXISTS `society_moneywash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `society` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.society_moneywash: ~0 rows (approximately)
DELETE FROM `society_moneywash`;
/*!40000 ALTER TABLE `society_moneywash` DISABLE KEYS */;
/*!40000 ALTER TABLE `society_moneywash` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.times
DROP TABLE IF EXISTS `times`;
CREATE TABLE IF NOT EXISTS `times` (
  `identifier` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `s` int(10) DEFAULT NULL,
  `m` int(10) DEFAULT NULL,
  `h` int(10) DEFAULT NULL,
  `d` int(10) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.times: ~1 rows (approximately)
DELETE FROM `times`;
/*!40000 ALTER TABLE `times` DISABLE KEYS */;
/*!40000 ALTER TABLE `times` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.tqrp_skills
DROP TABLE IF EXISTS `tqrp_skills`;
CREATE TABLE IF NOT EXISTS `tqrp_skills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `stamina` varchar(255) NOT NULL,
  `strength` varchar(255) NOT NULL,
  `driving` varchar(255) DEFAULT NULL,
  `shooting` varchar(255) DEFAULT NULL,
  `fishing` varchar(255) DEFAULT NULL,
  `drugs` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

-- Dumping data for table tqrpbase.tqrp_skills: ~0 rows (approximately)
DELETE FROM `tqrp_skills`;
/*!40000 ALTER TABLE `tqrp_skills` DISABLE KEYS */;
/*!40000 ALTER TABLE `tqrp_skills` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.trunk_inventory
DROP TABLE IF EXISTS `trunk_inventory`;
CREATE TABLE IF NOT EXISTS `trunk_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) COLLATE utf8mb4_bin NOT NULL,
  `data` text COLLATE utf8mb4_bin NOT NULL,
  `owned` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.trunk_inventory: ~0 rows (approximately)
DELETE FROM `trunk_inventory`;
/*!40000 ALTER TABLE `trunk_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `trunk_inventory` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.tweets
DROP TABLE IF EXISTS `tweets`;
CREATE TABLE IF NOT EXISTS `tweets` (
  `handle` longtext NOT NULL,
  `message` varchar(500) NOT NULL,
  `time` longtext NOT NULL,
  `photo` varchar(50) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table tqrpbase.tweets: ~0 rows (approximately)
DELETE FROM `tweets`;
/*!40000 ALTER TABLE `tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tweets` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `permission_level` int(11) DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `skin` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `job` varchar(50) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `loadout` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `inventory` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `position` varchar(255) COLLATE utf8mb4_bin DEFAULT '{"x":-269.4,"y":-955.3,"z":31.2,"heading":205.8}',
  `is_dead` tinyint(1) DEFAULT 0,
  `dateofbirth` varchar(25) COLLATE utf8mb4_bin DEFAULT '',
  `sex` varchar(10) COLLATE utf8mb4_bin DEFAULT '',
  `height` varchar(5) COLLATE utf8mb4_bin DEFAULT '',
  `status` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `tattoos` varchar(5000) COLLATE utf8mb4_bin DEFAULT NULL,
  `phone_number` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL,
  `jail` int(11) NOT NULL DEFAULT 0,
  `userimage` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `hair` longtext COLLATE utf8mb4_bin NOT NULL,
  `ip` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.users: ~1 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.user_accounts
DROP TABLE IF EXISTS `user_accounts`;
CREATE TABLE IF NOT EXISTS `user_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(22) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `money` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.user_accounts: ~1 rows (approximately)
DELETE FROM `user_accounts`;
/*!40000 ALTER TABLE `user_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_accounts` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.user_convictions
DROP TABLE IF EXISTS `user_convictions`;
CREATE TABLE IF NOT EXISTS `user_convictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) DEFAULT NULL,
  `offense` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.user_convictions: ~0 rows (approximately)
DELETE FROM `user_convictions`;
/*!40000 ALTER TABLE `user_convictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_convictions` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.user_documents
DROP TABLE IF EXISTS `user_documents`;
CREATE TABLE IF NOT EXISTS `user_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(45) COLLATE utf8mb4_bin NOT NULL,
  `data` longtext COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.user_documents: ~0 rows (approximately)
DELETE FROM `user_documents`;
/*!40000 ALTER TABLE `user_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_documents` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.user_lastcharacter
DROP TABLE IF EXISTS `user_lastcharacter`;
CREATE TABLE IF NOT EXISTS `user_lastcharacter` (
  `steamid` varchar(255) NOT NULL,
  `charid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table tqrpbase.user_lastcharacter: ~1 rows (approximately)
DELETE FROM `user_lastcharacter`;
/*!40000 ALTER TABLE `user_lastcharacter` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_lastcharacter` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.user_licenses
DROP TABLE IF EXISTS `user_licenses`;
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.user_licenses: ~0 rows (approximately)
DELETE FROM `user_licenses`;
/*!40000 ALTER TABLE `user_licenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_licenses` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.user_mdt
DROP TABLE IF EXISTS `user_mdt`;
CREATE TABLE IF NOT EXISTS `user_mdt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) DEFAULT NULL,
  `notes` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `mugshot_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.user_mdt: ~0 rows (approximately)
DELETE FROM `user_mdt`;
/*!40000 ALTER TABLE `user_mdt` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_mdt` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.vehicles
DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `model` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) COLLATE utf8mb4_bin DEFAULT NULL,
  `inshop` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.vehicles: ~381 rows (approximately)
DELETE FROM `vehicles`;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` (`name`, `model`, `price`, `category`, `inshop`) VALUES
	('Dodge Charger', '14charger', 500, 'police', 1),
	('Mustang - Sargento', '2015polstang', 5000, 'police', 1),
	('Ford Explorer', '2016explorer', 500, 'police', 1),
	('Ford Taurus', '2016taurus', 500, 'police', 1),
	('Akuma', 'AKUMA', 9990, 'motorcycles', 1),
	('Asbo', 'Asbo', 3300, 'compact', 0),
	('Issi Sport', 'Issi7', 44130, 'sports', 0),
	('Kanjo', 'Kanjo', 8700, 'compact', 0),
	('Mercedes Benz', 'actros', 37500, 'commercial', 0),
	('Adder', 'adder', 320000, 'super', 0),
	('Alpha', 'alpha', 32000, 'super', 1),
	('Asea', 'asea', 4100, 'sedans', 1),
	('Autarch', 'autarch', 350000, 'super', 0),
	('Avarus', 'avarus', 9200, 'motorcycles', 1),
	('Bagger', 'bagger', 7200, 'motorcycles', 1),
	('Baller', 'baller2', 11940, 'suvs', 1),
	('Baller Sport', 'baller3', 28830, 'suvs', 1),
	('Baller Sport Black', 'baller5', 120000, 'suvs', 0),
	('Baller Sport Black XL', 'baller6', 160000, 'suvs', 0),
	('Banshee', 'banshee', 60000, 'sports', 1),
	('Banshee 900R', 'banshee2', 120000, 'importcars', 0),
	('Bati 801', 'bati', 39500, 'importbikes', 0),
	('Bati 801RR', 'bati2', 49500, 'importbikes', 1),
	('Bestia GTS', 'bestiagts', 99999, 'sports', 0),
	('BF400', 'bf400', 17876, 'motorcycles', 1),
	('Bf Injection', 'bfinjection', 7865, 'compacts', 1),
	('Bifta', 'bifta', 13123, 'compacts', 0),
	('Bison', 'bison', 14200, 'vans', 1),
	('Blade', 'blade', 8345, 'muscle', 1),
	('Blazer', 'blazer', 2800, 'motorcycles', 1),
	('Blazer Sport', 'blazer4', 6879, 'motorcycles', 1),
	('Blista', 'blista', 2437, 'compacts', 1),
	('BMX (velo)', 'bmx', 158, 'motorcycles', 1),
	('Bobcat XL', 'bobcatxl', 9210, 'vans', 1),
	('Brawler', 'brawler', 16787, 'super', 1),
	('Brioso R/A', 'brioso', 5198, 'compacts', 1),
	('Btype', 'btype', 18400, 'sportsclassics', 1),
	('Btype Hotroad', 'btype2', 32320, 'sportsclassics', 0),
	('Btype Luxe', 'btype3', 22120, 'sportsclassics', 1),
	('Buccaneer', 'buccaneer', 8420, 'muscle', 1),
	('Buccaneer Rider', 'buccaneer2', 12320, 'muscle', 1),
	('Buffalo', 'buffalo', 18100, 'sports', 1),
	('Buffalo S', 'buffalo2', 21250, 'sports', 1),
	('Bullet', 'bullet', 95300, 'super', 0),
	('Burrito', 'burrito', 4560, 'vans', 1),
	('Burrito', 'burrito3', 4800, 'vans', 1),
	('Chevrolet Camaro', 'camarorb', 5000, 'police', 1),
	('Camper', 'camper', 1990, 'vans', 0),
	('caracara2', 'caracara2', 61500, 'offroad', 0),
	('Carbonizzare', 'carbonizzare', 189399, 'sports', 0),
	('Carbon RS', 'carbonrs', 29220, 'motorcycles', 1),
	('Casco', 'casco', 30000, 'sportsclassics', 1),
	('Cavalcade', 'cavalcade2', 6200, 'suvs', 1),
	('Cheburek', 'cheburek', 5899, 'sports', 0),
	('Cheetah', 'cheetah', 196902, 'super', 0),
	('cheetah2', 'cheetah2', 210100, 'sportsclassics', 69699),
	('Chimera', 'chimera', 24320, 'motorcycles', 0),
	('Chino', 'chino', 15806, 'muscle', 1),
	('Chino Luxe', 'chino2', 21304, 'muscle', 1),
	('Cliffhanger', 'cliffhanger', 8950, 'motorcycles', 1),
	('Cognoscenti Cabrio', 'cogcabrio', 45290, 'coupes', 0),
	('Cognoscenti', 'cognoscenti', 41200, 'sedans', 1),
	('Comet', 'comet2', 92789, 'sports', 1),
	('Comet 3', 'comet3', 155789, 'sports', 0),
	('Comet 5', 'comet5', 201220, 'sports', 0),
	('Contender', 'contender', 42180, 'suvs', 1),
	('Coquette', 'coquette', 103000, 'sports', 0),
	('Coquette Classic', 'coquette2', 93200, 'sportsclassics', 0),
	('Coquette BlackFin', 'coquette3', 82000, 'muscle', 0),
	('Cruiser (velo)', 'cruiser', 80, 'motorcycles', 1),
	('Cyclone', 'cyclone', 265000, 'super', 0),
	('Daemon', 'daemon', 6423, 'motorcycles', 1),
	('Daemon High', 'daemon2', 10400, 'motorcycles', 1),
	('Defiler', 'defiler', 25100, 'motorcycles', 1),
	('Diablous', 'diablous2', 19550, 'moto', 1),
	('Dinghy4', 'dinghy4', 85000, 'importbikes', 1),
	('DLoader', 'dloader', 7200, 'offroad', 1),
	('Dominator', 'dominator', 33300, 'muscle', 1),
	('Dominator20', 'dominator3', 55420, 'muscle', 1),
	('Double T', 'double', 14210, 'motorcycles', 1),
	('drafter', 'drafter', 76222, 'sports', 0),
	('Dubsta', 'dubsta', 39250, 'suvs', 1),
	('Dubsta Luxuary', 'dubsta2', 49670, 'suvs', 1),
	('Bubsta 6x6', 'dubsta3', 99999, 'offroad', 1),
	('Dukes', 'dukes', 28000, 'muscle', 1),
	('Elegy', 'elegy', 54500, 'sports', 1),
	('ellie', 'ellie', 34999, 'muscle', 0),
	('emerus', 'emerus', 399999, 'super', 0),
	('Emperor', 'emperor', 970, 'sedans', 1),
	('Enduro', 'enduro', 5210, 'motorcycles', 1),
	('entity2', 'entity2', 350111, 'super', 0),
	('Entity XF', 'entityxf', 313000, 'importcars', 0),
	('Esskey', 'esskey', 6112, 'motorcycles', 1),
	('everon', 'everon', 77233, 'offroad', 0),
	('Exemplar', 'exemplar', 14500, 'coupes', 1),
	('F620', 'f620', 15200, 'coupes', 1),
	('Faction', 'faction', 4100, 'muscle', 1),
	('Faction Rider', 'faction2', 5200, 'muscle', 1),
	('Faction XL', 'faction3', 6400, 'muscle', 1),
	('Faggio', 'faggio', 700, 'motorcycles', 1),
	('Vespa', 'faggio2', 2800, 'motorcycles', 1),
	('DODGE CHARGER -TEN.GENERAL', 'fbi', 1000, 'police', 1),
	('SUV -CHEFE', 'fbi2', 1000, 'police', 1),
	('Felon', 'felon', 26100, 'coupes', 1),
	('Felon GT', 'felon2', 30100, 'coupes', 0),
	('Feltzer', 'feltzer2', 64100, 'sports', 1),
	('Stirling GT', 'feltzer3', 85000, 'sportsclassics', 1),
	('Fixter (velo)', 'fixter', 100, 'motorcycles', 1),
	('Flash GT', 'flashgt', 43000, 'sports', 1),
	('Flat Bed', 'flatbed', 5200, 'vans', 1),
	('FMJ', 'fmj', 212000, 'super', 0),
	('Fhantom', 'fq2', 17000, 'suvs', 1),
	('Fugitive', 'fugitive', 9400, 'sedans', 1),
	('furia', 'furia', 389999, 'super', 0),
	('Furore GT', 'furoregt', 61200, 'sports', 1),
	('Fusilade', 'fusilade', 7532, 'sports', 1),
	('Futo', 'futo', 2100, 'sedans', 1),
	('Gargoyle', 'gargoyle', 16500, 'motorcycles', 1),
	('Gauntlet', 'gauntlet', 26300, 'muscle', 1),
	('gauntlet3', 'gauntlet3', 29999, 'muscle', 0),
	('gauntlet4', 'gauntlet4', 56100, 'muscle', 0),
	('GB200', 'gb200', 58520, 'sports', 1),
	('Gang Burrito', 'gburrito', 9120, 'vans', 1),
	('Burrito', 'gburrito2', 8120, 'vans', 1),
	('Glendale', 'glendale', 2500, 'sedans', 1),
	('gp1', 'gp1', 339100, 'super', 0),
	('Granger', 'granger', 17200, 'suvs', 1),
	('Gresley', 'gresley', 14520, 'suvs', 1),
	('GT 500', 'gt500', 39120, 'sportsclassics', 1),
	('Guardian', 'guardian', 78090, 'van', 1),
	('Hakuchou', 'hakuchou', 44500, 'motorcycles', 1),
	('Hakuchou Sport', 'hakuchou2', 65000, 'motorcycles', 0),
	('hellion', 'hellion', 33000, 'offroad', 0),
	('Hermes', 'hermes', 49670, 'muscle', 0),
	('Hexer', 'hexer', 3899, 'motorcycles', 1),
	('Hotknife', 'hotknife', 57492, 'muscle', 0),
	('Huntley S', 'huntley', 10230, 'suvs', 1),
	('Hustler', 'hustler', 43102, 'muscle', 0),
	('imorgon', 'imorgon', 139222, 'sports', 0),
	('Impaler', 'impaler', 13302, 'muscle', 1),
	('Impaler GT', 'impaler2', 23000, 'muscle', 0),
	('Impaler Luxury', 'impaler3', 25032, 'coupes', 0),
	('Infernus', 'infernus', 134000, 'super', 0),
	('infernus2', 'infernus2', 220111, 'sportsclassics', 0),
	('Innovation', 'innovation', 13729, 'motorcycles', 1),
	('Intruder', 'intruder', 5800, 'sedans', 1),
	('Issi', 'issi2', 3742, 'compacts', 0),
	('italigtb', 'italigtb', 244640, 'super', 0),
	('italigtb2', 'italigtb2', 258000, 'super', 0),
	('italigto', 'italigto', 325000, 'sports', 0),
	('Jackal', 'jackal', 11200, 'coupes', 1),
	('Jester', 'jester', 71300, 'sports', 1),
	('Jester(Racecar)', 'jester2', 65200, 'sports', 0),
	('jester3', 'jester3', 53210, 'sports', 0),
	('Jetmax', 'jetmax', 125000, 'importbikes', 0),
	('Journey', 'journey', 999, 'vans', 1),
	('jugular', 'jugular', 99999, 'sports', 0),
	('Kamacho', 'kamacho', 61230, 'offroad', 1),
	('Renault Kangoo', 'kangoo', 12820, 'vans', 1),
	('Khamelion', 'khamelion', 41200, 'sports', 1),
	('komoda', 'komoda', 82111, 'sports', 0),
	('krieger', 'krieger', 399989, 'super', 0),
	('Kuruma', 'kuruma', 39210, 'sports', 1),
	('Landstalker', 'landstalker', 4512, 'suvs', 1),
	('RE-7B', 'le7b', 142000, 'importcars', 0),
	('locust', 'locust', 96245, 'sports', 0),
	('Lynx', 'lynx', 51200, 'sports', 1),
	('Mamba', 'mamba', 70999, 'sports', 0),
	('MAN', 'man', 35000, 'vans', 0),
	('Manana', 'manana', 2210, 'sportsclassics', 1),
	('Manchez', 'manchez', 6300, 'motorcycles', 1),
	('Marquis', 'marquis', 215000, 'importbikes', 1),
	('Massacro', 'massacro', 89200, 'sports', 1),
	('Massacro(Racecar)', 'massacro2', 98100, 'sports', 1),
	('Mesa', 'mesa', 7230, 'suvs', 1),
	('Mesa Trail', 'mesa3', 24520, 'suvs', 1),
	('Minivan', 'minivan', 3900, 'vans', 1),
	('Monroe', 'monroe', 43190, 'sportsclassics', 1),
	('The Liberator', 'monster', 210000, 'offroad', 0),
	('Moonbeam', 'moonbeam', 7620, 'vans', 1),
	('Moonbeam Rider', 'moonbeam2', 11201, 'vans', 1),
	('MuleF', 'mulef', 3850, 'vans', 1),
	('nebula', 'nebula', 11234, 'sportsclassics', 0),
	('Nemesis', 'nemesis', 5820, 'motorcycles', 1),
	('neo', 'neo', 299000, 'sports', 0),
	('Neon', 'neon', 199200, 'sports', 0),
	('nero', 'nero', 189899, 'super', 0),
	('nero2', 'nero2', 209999, 'super', 0),
	('Nightblade', 'nightblade', 41500, 'importbikes', 0),
	('Nightshade', 'nightshade', 38100, 'muscle', 1),
	('9F', 'ninef', 80999, 'sports', 0),
	('9F Cabrio', 'ninef2', 89999, 'sports', 0),
	('novak', 'novak', 63122, 'SUV', 0),
	('Omnis', 'omnis', 34120, 'sports', 1),
	('Oracle XS', 'oracle2', 12420, 'coupes', 1),
	('Osiris', 'osiris', 299100, 'super', 1),
	('outlaw', 'outlaw', 32000, 'compact', 0),
	('Panto', 'panto', 1100, 'compacts', 1),
	('Paradise', 'paradise', 3120, 'vans', 1),
	('paragon', 'paragon', 127111, 'super', 0),
	('Pariah', 'pariah', 98999, 'sports', 1),
	('Patriot', 'patriot', 51202, 'suvs', 1),
	('PCJ-600', 'pcj', 7320, 'motorcycles', 1),
	('penetrator', 'penetrator', 260000, 'super', 0),
	('Penumbra', 'penumbra', 9820, 'sports', 1),
	('peyote2', 'peyote2', 67420, 'muscle', 0),
	('Pfister', 'pfister811', 132191, 'super', 0),
	('Phoenix', 'phoenix', 13132, 'muscle', 1),
	('Picador', 'picador', 6120, 'muscle', 1),
	('Pigalle', 'pigalle', 7129, 'sportsclassics', 1),
	('Tenente General - Police 4', 'police4', 500, 'police', 1),
	('Prairie', 'prairie', 2959, 'compacts', 1),
	('Premier', 'premier', 1999, 'sedans', 1),
	('Primo Custom', 'primo2', 9210, 'sedans', 1),
	('X80 Proto', 'prototipo', 1200000, 'super', 0),
	('Viatura de 2 Rodas', 'r1200rtp', 50, 'police', 1),
	('Radius', 'radi', 12000, 'suvs', 1),
	('raiden', 'raiden', 189999, 'sports', 0),
	('Rapid GT', 'rapidgt', 32200, 'sports', 1),
	('Rapid GT Convertible', 'rapidgt2', 33200, 'sports', 1),
	('Rapid GT3', 'rapidgt3', 39200, 'sportsclassics', 1),
	('Raptor', 'raptor', 22222, 'motorcycles', 0),
	('RatBike', 'ratbike', 20100, 'importbikes', 1),
	('RatLoader', 'ratloader2', 9210, 'offroad', 1),
	('Reaper', 'reaper', 219999, 'importcars', 0),
	('Rebel', 'rebel2', 7160, 'offroad', 1),
	('rebla', 'rebla', 59699, 'SUV', 0),
	('Regina', 'regina', 999, 'sedans', 1),
	('Retinue', 'retinue', 17300, 'sportsclassics', 1),
	('retinue2', 'retinue2', 22000, 'sportsclassics', 0),
	('Revolter', 'revolter', 72292, 'sports', 0),
	('Rhapsody', 'rhapsody', 1832, 'compacts', 1),
	('riata', 'riata', 16420, 'offroad', 0),
	('Rocoto', 'rocoto', 29320, 'suvs', 1),
	('rrocket', 'rrocket', 29200, 'motorcycles', 0),
	('Ruffian', 'ruffian', 11800, 'motorcycles', 1),
	('Rumpo', 'rumpo', 4500, 'vans', 1),
	('Rumpo Trail', 'rumpo3', 47379, 'vans', 1),
	('Sabre Turbo', 'sabregt', 9100, 'muscle', 1),
	('Sabre GT', 'sabregt2', 12600, 'muscle', 1),
	('Sadler', 'sadler', 38120, 'vans', 1),
	('Sanchez', 'sanchez', 5500, 'motorcycles', 1),
	('Sanchez Sport', 'sanchez2', 6000, 'motorcycles', 1),
	('Sanctus', 'sanctus', 45420, 'importbikes', 0),
	('Sandking', 'sandking', 29999, 'offroad', 1),
	('Savestra', 'savestra', 32700, 'sportsclassics', 1),
	('SC 1', 'sc1', 245120, 'super', 0),
	('Schafter', 'schafter2', 35000, 'sedans', 1),
	('Schafter V12', 'schafter3', 52310, 'sports', 1),
	('schlagen', 'schlagen', 105555, 'sports', 0),
	('Seashark', 'seashark', 42500, 'importbikes', 1),
	('Seminole', 'seminole', 10000, 'suvs', 1),
	('Sentinel', 'sentinel', 15800, 'coupes', 1),
	('Sentinel XS', 'sentinel2', 19700, 'coupes', 1),
	('Sentinel3', 'sentinel3', 24650, 'sports', 1),
	('Seven 70', 'seven70', 48800, 'sports', 1),
	('ETR1', 'sheava', 108199, 'importcars', 0),
	('Shotaro Concept', 'shotaro', 520000, 'importbikes', 0),
	('Slam Van', 'slamvan', 5620, 'vans', 1),
	('Slam Van GT', 'slamvan2', 8700, 'vans', 1),
	('Slam Van Turbo', 'slamvan3', 11347, 'vans', 1),
	('Sovereign', 'sovereign', 7300, 'motorcycles', 1),
	('Specter2', 'specter2', 101200, 'super', 0),
	('Speeder', 'speeder', 89550, 'importbikes', 0),
	('speedo2', 'speedo2', 6500, 'vans', 1),
	('Stafford', 'stafford', 48300, 'sportsclassics', 1),
	('Stinger', 'stinger', 57000, 'sportsclassics', 1),
	('Stinger GT', 'stingergt', 56000, 'sportsclassics', 0),
	('Stretch', 'stretch', 30000, 'sedans', 1),
	('stryder', 'stryder', 8999, 'motorcycles', 0),
	('sugoi', 'sugoi', 33333, 'sports', 0),
	('Sultan', 'sultan', 27460, 'sports', 1),
	('Sultan2', 'sultan2', 68999, 'sport', 0),
	('Sultan RS', 'sultanrs', 65220, 'importcars', 1),
	('Suntrap', 'suntrap', 35500, 'importbikes', 0),
	('Super Diamond', 'superd', 52000, 'sedans', 1),
	('Surano', 'surano', 48200, 'sports', 1),
	('Surfer', 'surfer', 8200, 'vans', 1),
	('T20', 't20', 250120, 'super', 0),
	('Tailgater', 'tailgater', 12890, 'sedans', 1),
	('Tampa', 'tampa', 16200, 'muscle', 1),
	('Drift Tampa', 'tampa2', 33120, 'sports', 1),
	('Taxi', 'taxi', 2550, 'compacts', 1),
	('tempesta', 'tempesta', 199888, 'super', 0),
	('tezeract', 'tezeract', 400000, 'super', 0),
	('thrax', 'thrax', 400100, 'super', 0),
	('Thrust', 'thrust', 10260, 'motorcycles', 1),
	('torero', 'torero', 208100, 'sportsclassics', 0),
	('Toro', 'toro', 232500, 'importbikes', 0),
	('toros', 'toros', 69699, 'SUV', 0),
	('Tow Truck', 'towtruck', 14120, 'vans', 1),
	('Trator', 'tractor2', 12850, 'vans', 1),
	('Atrelado', 'trailersmall', 6000, 'vans', 1),
	('Tri bike (velo)', 'tribike3', 520, 'motorcycles', 1),
	('Trophy Truck', 'trophytruck', 31000, 'offroad', 1),
	('Tropic', 'tropic', 32500, 'importbikes', 0),
	('Tropos', 'tropos', 60520, 'sports', 1),
	('Tulip', 'tulip', 37200, 'muscle', 1),
	('turismo2', 'turismo2', 250222, 'sportsclassics', 0),
	('Turismo R', 'turismor', 235100, 'super', 0),
	('Tyrus', 'tyrus', 270000, 'super', 0),
	('Vacca', 'vacca', 190000, 'super', 0),
	('Vader', 'vader', 4100, 'motorcycles', 1),
	('vagrant', 'vagrant', 39899, 'compact', 0),
	('Vamos', 'vamos', 35000, 'muscle', 1),
	('Verlierer', 'verlierer2', 89999, 'sports', 1),
	('Vigero', 'vigero', 8500, 'muscle', 1),
	('Virgo', 'virgo', 8520, 'muscle', 1),
	('Viseris', 'viseris', 70000, 'sportsclassics', 0),
	('Visione', 'visione', 300000, 'super', 0),
	('Voltic', 'voltic', 69000, 'super', 0),
	('Voodoo', 'voodoo', 10200, 'muscle', 1),
	('Vortex', 'vortex', 18100, 'motorcycles', 1),
	('vstr', 'vstr', 88555, 'sports', 0),
	('Warrener', 'warrener', 3900, 'sedans', 1),
	('Washington', 'washington', 3800, 'sedans', 1),
	('Windsor', 'windsor', 55500, 'coupes', 0),
	('Windsor Drop', 'windsor2', 69000, 'coupes', 0),
	('Woflsbane', 'wolfsbane', 38100, 'importbikes', 0),
	('xa21', 'xa21', 177280, 'super', 0),
	('XLS', 'xls', 27000, 'suvs', 1),
	('Yosemite', 'yosemite', 11200, 'vans', 1),
	('yosemite2', 'yosemite2', 20998, 'muscle', 0),
	('Youga', 'youga', 4800, 'vans', 1),
	('Youga Luxuary', 'youga2', 6500, 'vans', 1),
	('Z190', 'z190', 70540, 'sportsclassics', 0),
	('Zentorno', 'zentorno', 299000, 'super', 0),
	('Zion', 'zion', 9200, 'coupes', 1),
	('Zion Cabrio', 'zion2', 12200, 'coupes', 0),
	('zion3', 'zion3', 12387, 'sportsclassics', 0),
	('Zombie', 'zombiea', 9500, 'motorcycles', 1),
	('Zombie Luxuary', 'zombieb', 13000, 'importbikes', 1),
	('zorrusso', 'zorrusso', 221000, 'super', 0),
	('Z-Type', 'ztype', 280000, 'sportsclassics', 0);
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.vehicles_display
DROP TABLE IF EXISTS `vehicles_display`;
CREATE TABLE IF NOT EXISTS `vehicles_display` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `profit` int(11) NOT NULL DEFAULT 10,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table tqrpbase.vehicles_display: ~6 rows (approximately)
DELETE FROM `vehicles_display`;
/*!40000 ALTER TABLE `vehicles_display` DISABLE KEYS */;
INSERT INTO `vehicles_display` (`ID`, `name`, `model`, `profit`, `price`) VALUES
	(1, 'Comet5', 'comet5', 0, 201220),
	(2, 'Paragon', 'paragon', 0, 127111),
	(3, 'Specter2', 'specter2', 0, 101200),
	(4, 'Vstr', 'vstr', 0, 88555),
	(5, 'Cheburek', 'cheburek', 0, 5899),
	(6, 'Sheava', 'sheava', 0, 108199);
/*!40000 ALTER TABLE `vehicles_display` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.vehicle_categories
DROP TABLE IF EXISTS `vehicle_categories`;
CREATE TABLE IF NOT EXISTS `vehicle_categories` (
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.vehicle_categories: ~15 rows (approximately)
DELETE FROM `vehicle_categories`;
/*!40000 ALTER TABLE `vehicle_categories` DISABLE KEYS */;
INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
	('compacts', 'Compactos'),
	('coupes', 'Coupés'),
	('importbikes', 'Motas/Barcos Importados'),
	('importcars', 'Carros Importados'),
	('motorcycles', 'Motas'),
	('muscle', 'Muscle Americanos'),
	('offroad', 'Off Road'),
	('police', 'D.P.L.S'),
	('sedans', 'Sedans'),
	('sports', 'Desportivos'),
	('sportsclassics', 'Desportivos Classicos'),
	('super', 'Super-Desportivos'),
	('suvs', 'SUVs'),
	('utility', 'Utilidade'),
	('vans', 'Carinhas/Comerciais');
/*!40000 ALTER TABLE `vehicle_categories` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.warehouses
DROP TABLE IF EXISTS `warehouses`;
CREATE TABLE IF NOT EXISTS `warehouses` (
  `storeID` int(11) NOT NULL,
  `materials` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`storeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table tqrpbase.warehouses: ~1 rows (approximately)
DELETE FROM `warehouses`;
/*!40000 ALTER TABLE `warehouses` DISABLE KEYS */;
INSERT INTO `warehouses` (`storeID`, `materials`) VALUES
	(1, '{"wood":7,"mine":8,"water":2,"food":20}');
/*!40000 ALTER TABLE `warehouses` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.warrants
DROP TABLE IF EXISTS `warrants`;
CREATE TABLE IF NOT EXISTS `warrants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` text COLLATE utf8mb4_bin DEFAULT NULL,
  `crime_description` text COLLATE utf8mb4_bin DEFAULT NULL,
  `char_description` text COLLATE utf8mb4_bin DEFAULT NULL,
  `active` tinyint(4) DEFAULT 1,
  `code` varchar(10) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.warrants: ~0 rows (approximately)
DELETE FROM `warrants`;
/*!40000 ALTER TABLE `warrants` DISABLE KEYS */;
/*!40000 ALTER TABLE `warrants` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.weedplants
DROP TABLE IF EXISTS `weedplants`;
CREATE TABLE IF NOT EXISTS `weedplants` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stage` int(3) unsigned NOT NULL DEFAULT 1,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `soil` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stage` (`stage`,`time`)
) ENGINE=InnoDB AUTO_INCREMENT=3796 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table tqrpbase.weedplants: ~0 rows (approximately)
DELETE FROM `weedplants`;
/*!40000 ALTER TABLE `weedplants` DISABLE KEYS */;
/*!40000 ALTER TABLE `weedplants` ENABLE KEYS */;

-- Dumping structure for table tqrpbase.whitelist
DROP TABLE IF EXISTS `whitelist`;
CREATE TABLE IF NOT EXISTS `whitelist` (
  `identifier` varchar(75) NOT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table tqrpbase.whitelist: ~0 rows (approximately)
DELETE FROM `whitelist`;
/*!40000 ALTER TABLE `whitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `whitelist` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
