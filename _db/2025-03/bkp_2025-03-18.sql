-- MariaDB dump 10.19-11.3.2-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: db_tempguardian
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB-1:11.3.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `weather_history`
--

DROP TABLE IF EXISTS `weather_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weather_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temperature` double(5,2) NOT NULL,
  `humidity` double(5,2) NOT NULL,
  `date` date DEFAULT NULL,
  `hour` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Table with historical temperature and humidity data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weather_history`
--

LOCK TABLES `weather_history` WRITE;
/*!40000 ALTER TABLE `weather_history` DISABLE KEYS */;
INSERT INTO `weather_history` VALUES
(1,22.49,43.58,'2025-03-13','19:26:57'),
(2,22.52,43.66,'2025-03-13','19:44:28'),
(3,20.46,42.53,'2025-03-18','13:14:14'),
(4,20.75,42.04,'2025-03-18','13:35:19'),
(5,20.45,42.69,'2025-03-18','13:50:01'),
(6,20.38,42.94,'2025-03-18','13:54:47'),
(7,20.38,42.98,'2025-03-18','14:00:01'),
(8,20.29,43.17,'2025-03-18','14:10:02'),
(9,20.28,43.26,'2025-03-18','14:20:01'),
(10,20.34,42.88,'2025-03-18','14:30:01'),
(11,20.39,43.22,'2025-03-18','14:40:01');
/*!40000 ALTER TABLE `weather_history` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-18 14:46:32
