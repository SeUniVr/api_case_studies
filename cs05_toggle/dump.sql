-- MySQL dump 10.13  Distrib 8.0.3-rc, for Linux (x86_64)
--
-- Host: localhost    Database: Toogle
-- ------------------------------------------------------
-- Server version	8.0.3-rc-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS Toogle;
CREATE DATABASE Toogle;
USE Toogle;

--
-- Table structure for table `Services`
--

DROP TABLE IF EXISTS `Services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Services` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `name` longtext,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Services`
--
INSERT INTO Services VALUES
(1, 1, 'Service1'),
(2, 2, 'Service2'),
(3, 3, 'Service3'),
(4, 1, NULL),
(5, 2, NULL),
(6, 1, NULL);

LOCK TABLES `Services` WRITE;
/*!40000 ALTER TABLE `Services` DISABLE KEYS */;
/*!40000 ALTER TABLE `Services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Toggles`
--

DROP TABLE IF EXISTS `Toggles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Toggles` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` longtext,
  `State` bit(1) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO Toggles VALUES
(1, 'FirstToggleName', 1),
(2, 'SecondToggleName', 1),
(3, 'FirstToggleName', 0),
(4, 'FirstToggleName', 1),
(5, 'FirstToggleName', 0),
(6, NULL, 1),
(7, NULL, 0),
(8, NULL, 1),
(9, 'FirstToggleName', 0);

--
-- Dumping data for table `Toggles`
--

LOCK TABLES `Toggles` WRITE;
/*!40000 ALTER TABLE `Toggles` DISABLE KEYS */;
/*!40000 ALTER TABLE `Toggles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TogglesServices`
--

DROP TABLE IF EXISTS `TogglesServices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `TogglesServices` (
  `TogglesServicesId` int(11) NOT NULL AUTO_INCREMENT,
  `ToggleId` int(11) DEFAULT NULL,
  `ServiceId` int(11) DEFAULT NULL,
  PRIMARY KEY (`TogglesServicesId`),
  KEY `IX_TogglesServices_ServiceId` (`ServiceId`),
  KEY `IX_TogglesServices_ToggleId` (`ToggleId`),
  CONSTRAINT `FK_TogglesServices_Services_ServiceId` FOREIGN KEY (`ServiceId`) REFERENCES `Services` (`id`),
  CONSTRAINT `FK_TogglesServices_Toggles_ToggleId` FOREIGN KEY (`ToggleId`) REFERENCES `Toggles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TogglesServices`
--

INSERT INTO TogglesServices VALUES
(1, 1, 1),
(2, 1, 1),
(3, 2, 2),
(4, 2, 4),
(5, 5, 5),
(6, 5, 5),
(7, 6, 5),
(8, 6, 5);

LOCK TABLES `TogglesServices` WRITE;
/*!40000 ALTER TABLE `TogglesServices` DISABLE KEYS */;
/*!40000 ALTER TABLE `TogglesServices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Users` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` longtext,
  `LastName` longtext,
  `Username` longtext,
  `PasswordSalt` longblob,
  `PasswordHash` longblob,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

INSERT INTO Users VALUES
(1, 'a', 'b', 'a_user', NULL, NULL),
(2, NULL, NULL, NULL, NULL, NULL),
(3, 'c', 'd', 'c_user', NULL, NULL),
(4, 'e', 'f', 'e_user', NULL, NULL),
(5, NULL, 'h', 'g_user', NULL, NULL);

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__EFMigrationsHistory`
--

DROP TABLE IF EXISTS `__EFMigrationsHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `__EFMigrationsHistory` (
  `MigrationId` varchar(95) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__EFMigrationsHistory`
--

LOCK TABLES `__EFMigrationsHistory` WRITE;
/*!40000 ALTER TABLE `__EFMigrationsHistory` DISABLE KEYS */;
INSERT INTO `__EFMigrationsHistory` VALUES ('20180826221052_ToggleAPI','2.1.14-servicing-32113'),('20180829194630_AddServicesAndToggleRelationship','2.1.14-servicing-32113'),('20180830040807_UpdatingSomeFields','2.1.14-servicing-32113');
/*!40000 ALTER TABLE `__EFMigrationsHistory` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-29 15:21:34
