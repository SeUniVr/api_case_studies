-- MySQL dump 10.13  Distrib 8.0.22, for Linux (x86_64)
--
-- Host: localhost    Database: ticketdb
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS ticketdb;
CREATE DATABASE ticketdb;
USE ticketdb;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport` (
  `id` bigint NOT NULL,
  `capacity` int DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `id` bigint NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `id` bigint NOT NULL,
  `arrival_date` datetime DEFAULT NULL,
  `departure_date` datetime DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `quota` int DEFAULT NULL,
  `quota_filled` int DEFAULT NULL,
  `quota_filled_percentage` int DEFAULT NULL,
  `flight_company_id` bigint DEFAULT NULL,
  `route_flight_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8u092esxyghsq190bun619vq` (`flight_company_id`),
  KEY `FKbe5mgl9uelnc4mouubfcapxgx` (`route_flight_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hibernate_sequence`
--

LOCK TABLES `hibernate_sequence` WRITE;
/*!40000 ALTER TABLE `hibernate_sequence` DISABLE KEYS */;
INSERT INTO `hibernate_sequence` VALUES (1),(1),(1),(1),(1),(1);
/*!40000 ALTER TABLE `hibernate_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plane`
--

DROP TABLE IF EXISTS `plane`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plane` (
  `id` bigint NOT NULL,
  `name` varchar(20) NOT NULL,
  `number_seat` int DEFAULT NULL,
  `company_plane_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKcanj3i951r335cukh26x4sww6` (`company_plane_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plane`
--

LOCK TABLES `plane` WRITE;
/*!40000 ALTER TABLE `plane` DISABLE KEYS */;
/*!40000 ALTER TABLE `plane` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route` (
  `id` bigint NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `arrival_airport_id` bigint DEFAULT NULL,
  `departure_airport_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfgy0gl8x94s6jf9pw5irxhjax` (`arrival_airport_id`),
  KEY `FKrhi4sk6rhj303om7ur6wp1g4q` (`departure_airport_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `id` bigint NOT NULL,
  `is_sold` bit(1) DEFAULT NULL,
  `price` int DEFAULT NULL,
  `ticket_code` varchar(255) NOT NULL,
  `ticket_flight_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKp9nlo1ikv3ndnbsgjlwx6ecj5` (`ticket_flight_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-30 11:43:45

-- (id, capacity, location, name)
INSERT INTO airport VALUES
(0, 100, "Verona", "Valerio Catullo"),
(1, 1000, "London", "London Gatwick"),
(2, 100000, "New York", "JFK International"),
(3, NULL, NULL, "Los Angeles International"),
(4, NULL, "Vancouver", "Vancouver International");

-- (id, name)
INSERT INTO company VALUES
(0, 'Cheap flights'),
(1, 'Global airlines'),
(2, 'European airlines'),
(3, 'Green Air'),
(4, 'Blue Wings');

-- (id, name, arrival_id, dep_id)
INSERT INTO route VALUES
(0, 'Verona2London', 1, 0),
(1, 'Verona2Vancouver', 4, 0),
(2, 'LA2Vancouver', 4, 3),
(3, 'Vancouver2Verona', 0, 4),
(4, 'London2LA', 3, 1),
(5, NULL, NULL, NULL),
(6, 'Unknown2Unk', NULL, NULL);

-- (id, name, #seats, compani_id)
INSERT INTO plane VALUES
(0, 'Bigplane', NULL, NULL),
(1, 'Smallplane', 10, NULL),
(2, 'Smallplane', 10, 1),
(3, 'Mediumplane', 100, 3),
(4, 'Personal', 2, 4),
(5, 'Fastplane', NULL, 2);

-- (id, arrival_date, departure_date, duration, name, quota, quota_filled, quota_filled_perc, company_id, route_id)
INSERT INTO flight VALUES
(0, NULL, NULL, 9, 'Long flight to Verona', NULL, NULL, NULL, 1, 3),
(1, NULL, NULL, 5, 'Short flight to London', 50, NULL, NULL, 2, 0),
(3, NULL, NULL, NULL, 'Empty flight', NULL, NULL, NULL, NULL, NULL);

-- (id, is_sold, price, ticket_code, flight_id)
INSERT INTO ticket VALUES
(0, NULL, NULL, 'emptyticket-ticket-code', NULL),
(1, 1, 150, 'another-ticket-code', 0),
(2, 0, NULL, 'third-ticket-code', NULL),
(3, 1, 300, 'just-a-ticket-code', NULL),
(4, NULL, 500, 'ticket-code', 3);