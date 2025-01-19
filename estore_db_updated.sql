-- MariaDB dump 10.19  Distrib 10.6.7-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: estore
-- ------------------------------------------------------
-- Server version	10.6.7-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `authorities`
--

DROP TABLE IF EXISTS `authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `authority` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorities`
--

LOCK TABLES `authorities` WRITE;
/*!40000 ALTER TABLE `authorities` DISABLE KEYS */;
INSERT INTO `authorities` VALUES (7,'user1','ROLE_USER'),(8,'admin','ROLE_ADMIN'),(9,'user1','ROLE_USER'),(10,'admin','ROLE_ADMIN'),(11,'user1','ROLE_USER'),(12,'admin','ROLE_ADMIN'),(13,'user1','ROLE_USER'),(14,'admin','ROLE_ADMIN'),(15,'user1','ROLE_USER'),(16,'admin','ROLE_ADMIN'),(17,'user1','ROLE_USER'),(18,'admin','ROLE_ADMIN'),(19,'user1','ROLE_USER'),(20,'admin','ROLE_ADMIN'),(21,'user1','ROLE_USER'),(22,'admin','ROLE_ADMIN'),(23,'user1','ROLE_USER'),(24,'admin','ROLE_ADMIN'),(25,'user1','ROLE_USER'),(26,'admin','ROLE_ADMIN'),(27,'user1','ROLE_USER'),(28,'admin','ROLE_ADMIN'),(29,'user1','ROLE_USER'),(30,'admin','ROLE_ADMIN'),(31,'user1','ROLE_USER'),(32,'admin','ROLE_ADMIN');
/*!40000 ALTER TABLE `authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT,
  `header_id` bigint(64) NOT NULL,
  `payment_type_id` bigint(64) NOT NULL,
  `amount` double(20,3) DEFAULT NULL,
  `evoucher_id` binary(64) DEFAULT NULL,
  `promo_code_id` binary(64) DEFAULT NULL,
  PRIMARY KEY (`id`,`header_id`,`payment_type_id`),
  KEY `payment_id_idx` (`payment_type_id`),
  KEY `payment_header_id_idx` (`header_id`),
  CONSTRAINT `payment_header_id` FOREIGN KEY (`header_id`) REFERENCES `payment_header` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `payment_id` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_types` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_details`
--

DROP TABLE IF EXISTS `payment_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_details` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT,
  `header_id` bigint(64) NOT NULL,
  `evoucher_id` bigint(64) NOT NULL,
  `promo_code_id` bigint(64) NOT NULL,
  `price` double(20,3) NOT NULL,
  `quantity` int(11) NOT NULL,
  `amount` double(20,3) NOT NULL,
  `dis_amount` double(20,3) DEFAULT NULL,
  PRIMARY KEY (`id`,`header_id`,`evoucher_id`,`promo_code_id`),
  KEY `id_idx` (`header_id`),
  CONSTRAINT `id` FOREIGN KEY (`header_id`) REFERENCES `payment_header` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_details`
--

LOCK TABLES `payment_details` WRITE;
/*!40000 ALTER TABLE `payment_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_header`
--

DROP TABLE IF EXISTS `payment_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_header` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT,
  `total_amount` double(20,3) DEFAULT NULL,
  `total_dis_amount` double(20,3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_header`
--

LOCK TABLES `payment_header` WRITE;
/*!40000 ALTER TABLE `payment_header` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_types`
--

DROP TABLE IF EXISTS `payment_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_types` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT,
  `payment_code` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_mysql500_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_mysql500_ci DEFAULT NULL,
  `is_active` bit(1) DEFAULT b'1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_types`
--

LOCK TABLES `payment_types` WRITE;
/*!40000 ALTER TABLE `payment_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `enabled` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (7,'user1','$2a$10$ch8P2Uz/z4p4/y7syoORkunX0JrHprZwjszp.rrhLy4NES/XMKcEG',''),(8,'admin','$2a$10$EKIyBFInBn73GoIMVsLUm.6T3jrnltfm79KYxq8Daqljk/z6E0Z5O',''),(9,'user1','$2a$10$E4pIV0PyC9ozIPwtoVoAnu.9RpmDDdsZrKcv9V6mME4UZg/d12hMm',''),(10,'admin','$2a$10$FXvu3DywWZtldTocNO.buujR30gUs4rHiBnP5iXbkyNm5G7pR7VWm',''),(11,'user1','$2a$10$N/XvqV/.raYFln86EcolPOK0au8fthGp7gpUtBRWIUUlb8JoM9v56',''),(12,'admin','$2a$10$bgVC951bI/7QhW9uUcspceMqRmdWYxWnPPaRaFwz9rDTz9bfp53au',''),(13,'user1','$2a$10$hQpTzgcZgjK8A8B1ZmjjX.VVOdb96udCyk5l3xwaxZsWe1pmhMFuu',''),(14,'admin','$2a$10$OJbqPhU1GFpPKooGXyyeoOAc92FX4fQwlpRpXIp/g8vDJBgXxADSO',''),(15,'user1','$2a$10$yLzbDItHEX7vezIXjLtdUuODLhnd2lER11yN9.cuctWoGticAhO86',''),(16,'admin','$2a$10$ZrygpsRTisuk.vBURr2cxenn/ypDP6xiLUmn15/zvHrczQ9.UUm0S',''),(17,'user1','$2a$10$wrB9z2X1eN3ziOciQHsYM.1ZNmuIJPr4rzY.Kfj1M2lsUcBA2Nt7m',''),(18,'admin','$2a$10$pVgiKP19kREEH0tSh2K5yOiTuLqbncuLN2T7gL.HpFSTaoThu5O4e',''),(19,'user1','$2a$10$WMBu0CbKAKSe1Delv6GmMO0N4IwpeLj7N5fIYiHyAyCgn2aZRCSxG',''),(20,'admin','$2a$10$NAFb6lsjaDdAcsNs8qIMgOy44DbIKBxDJR8k4A0u.z/8zK6oEejyW',''),(21,'user1','$2a$10$yygP.Wcd2iB2AlzREqbNke.n/JQJ/tTX3aeIP8yKwPceEJd2lfhOO',''),(22,'admin','$2a$10$rS2G1zq1Enb/QdbXLVoHgur0aTDS7Msh2HM5ewy21mOSe7YzoC7Ui',''),(23,'user1','$2a$10$JjXrxftFu68AQF40R7684utM/Q0BDaXkgRIoSxSeKXzJdGJs45.YG',''),(24,'admin','$2a$10$r6fTc5aydwzeF5IrUWHgGO6DdpYMq0w9w9jgSraPPvuYYklom0QsW',''),(25,'user1','$2a$10$kKmrmG12DmI2d2j9lLD9t.2vIOoX1LOoqmKR6UoTfgSlUPMIilQra',''),(26,'admin','$2a$10$iApUUqHNTxAH8rAbaQPHuOhFGecvlVEONsxt21FcNME9VGowNhw5q',''),(27,'user1','$2a$10$lk3kPDqKSvH7KLVuumNyTO84ZspVN5RGoMsSeN/AGVwq02jclTg7C',''),(28,'admin','$2a$10$ylbHSTaifMI1lORF2GL6IutdgeBtJE5iex2JIy0bCrzJ6jva24tmq',''),(29,'user1','$2a$10$GOcAraeqzfAqotm3GqN.J.JBx/bbSd4g8uQ0DG1YJSEuZyPNfVd6K',''),(30,'admin','$2a$10$RFF5FmYPv//6tV1RXl1qyu3pVoi8sLJ2HH/qpiD9SiJnsEFOSxiwi',''),(31,'user1','$2a$10$Y2DbDtkvF6FJFTT2tgAyHuWlpNLrCRJksir3Fq0dVIAUEic8jRJda',''),(32,'admin','$2a$10$EmhNJ1HFD3Cv3MOWHzwdtOuEQHqqPWGqwPQSoNnoBNxbMGWbQTkBK','');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-19 17:06:01
