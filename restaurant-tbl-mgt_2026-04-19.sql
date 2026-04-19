# ************************************************************
# Sequel Ace SQL dump
# Version 20100
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 127.0.0.1 (MySQL 8.4.8)
# Database: restaurant-tbl-mgt
# Generation Time: 2026-04-19 15:59:47 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table main
# ------------------------------------------------------------

DROP TABLE IF EXISTS `main`;

CREATE TABLE `main` (
  `Customer_ID` int NOT NULL,
  `First_Name` varchar(30) NOT NULL,
  `Last_Name` varchar(30) NOT NULL,
  `Mobile_No` int DEFAULT NULL,
  `Registered_Date` date DEFAULT (curdate()),
  PRIMARY KEY (`Customer_ID`),
  UNIQUE KEY `Mobile_No` (`Mobile_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `main` WRITE;
/*!40000 ALTER TABLE `main` DISABLE KEYS */;

INSERT INTO `main` (`Customer_ID`, `First_Name`, `Last_Name`, `Mobile_No`, `Registered_Date`)
VALUES
	(1,'Paul','Walker',713342908,'2026-04-19'),
	(2,'Dom','Toretto',713378798,'2026-04-19'),
	(3,'Gal','Gaddot',778047908,'2026-04-19'),
	(4,'Peter','Parker',898902908,'2026-04-19'),
	(5,'Saman','Kumara',713889097,'2026-04-19');

/*!40000 ALTER TABLE `main` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
