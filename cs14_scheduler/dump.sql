-- MySQL dump 10.13  Distrib 8.0.3-rc, for Linux (x86_64)
--
-- Host: localhost    Database: scheduler
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

DROP DATABASE IF EXISTS scheduler;
CREATE DATABASE scheduler;
USE scheduler;

--
-- Table structure for table `SequelizeMeta`
--

DROP TABLE IF EXISTS `SequelizeMeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `SequelizeMeta` (
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SequelizeMeta`
--

LOCK TABLES `SequelizeMeta` WRITE;
/*!40000 ALTER TABLE `SequelizeMeta` DISABLE KEYS */;
INSERT INTO `SequelizeMeta` VALUES ('20171101181703-create-operator.js')
,('20171101194551-create-season.js')
,('20171101194629-create-sport.js')
,('20171101194630-create-tiebreakers.js')
,('20171101194735-create-rules.js')
,('20171101194852-create-tiebreakers-rules.js')
,('20171101213420-create-gender.js')
,('20171101213554-create-state.js')
,('20171101213855-create-event-type.js')
,('20171101213959-create-division.js')
,('20171101214217-create-events.js')
,('20171101214452-create-facility.js')
,('20171101214524-create-event-facilities.js')
,('20171110130550-create-custom-point.js')
,('20171110132657-create-custom-point-sport.js')
,('20171110140416-create-custom-point-event.js')
,('20171115154112-create-registration-systems.js')
,('20171115154234-create-coaches.js')
,('20171115154323-create-team.js')
,('20171115164433-create-operator-team.js')
,('20171115201239-create-division-team.js')
,('20171116145724-event-drop-columns-location-and-division-FK.js')
,('20171116145824-add-column-division-abbreviation-skill.js')
,('20171116146824-insert-genders.js')
,('20171116245824-add-column-event-logo-location.js')
,('20171129002734-create-operator-rule.js')
,('20171129002931-create-event-rule.js')
,('20171129003216-add-value-to-rules.js')
,('20171129014123-modify-custom-points.js')
,('20171129140000-default-rules.js')
,('20171129154211-remove-tiebreaker.js')
,('20171129224354-default-points.js')
,('20171205140817-add-group-to-points.js')
,('20171207142436-create-page.js')
,('20171207181703-create-users.js')
,('20171212181703-create-roles-table.js')
,('20171213223406-create-operator-page.js')
,('20171213223918-create-event-page.js')
,('20171213225301-add-group-and-values-to-operator-points.js')
,('20171214000834-default-page-details.js')
,('20171218145724-facilities-change-columns-state-and-deleted.js')
,('20171219146824-insert-admin-user.js')
,('20171220214524-create-events-teams.js')
,('20180102214524-create-events-divisions.js')
,('20180103225301-add-division-event_id.js');
/*!40000 ALTER TABLE `SequelizeMeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coaches`
--

DROP TABLE IF EXISTS `coaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `coaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `registration_id` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  `external_coach_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `registration_id` (`registration_id`),
  CONSTRAINT `coaches_ibfk_1` FOREIGN KEY (`registration_id`) REFERENCES `registration_systems` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coaches`
--

LOCK TABLES `coaches` WRITE;
/*!40000 ALTER TABLE `coaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `coaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_points`
--

DROP TABLE IF EXISTS `custom_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `custom_points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  `values` text,
  `points` int(11) DEFAULT NULL,
  `group` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_points`
--

LOCK TABLES `custom_points` WRITE;
/*!40000 ALTER TABLE `custom_points` DISABLE KEYS */;
INSERT INTO `custom_points` VALUES (1,'Points for a Win','2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}',3,NULL)
,(2,'Points for a Tie','2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}',1,NULL)
,(3,'Points for a Loss','2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}',0,NULL)
,(4,'Points Per Goal','2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}',0,1)
,(5,'Maximum Points Per Goal','2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}',0,1)
,(6,'Points for a Shoutout','2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}',0,2);
/*!40000 ALTER TABLE `custom_points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `divisions`
--

DROP TABLE IF EXISTS `divisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `divisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `gender_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  `abbreviation` varchar(10) DEFAULT NULL,
  `skill` varchar(255) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gender_id` (`gender_id`),
  KEY `divisions_event_id_foreign_idx` (`event_id`),
  CONSTRAINT `divisions_event_id_foreign_idx` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  CONSTRAINT `divisions_ibfk_1` FOREIGN KEY (`gender_id`) REFERENCES `genders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `divisions`
--

LOCK TABLES `divisions` WRITE;
/*!40000 ALTER TABLE `divisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `divisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `divisions_teams`
--

DROP TABLE IF EXISTS `divisions_teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `divisions_teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `division_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `divisions_teams`
--

LOCK TABLES `divisions_teams` WRITE;
/*!40000 ALTER TABLE `divisions_teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `divisions_teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `operator_id` int(11) NOT NULL,
  `sport_id` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `operator_id` (`operator_id`),
  KEY `sport_id` (`sport_id`),
  CONSTRAINT `events_ibfk_2` FOREIGN KEY (`operator_id`) REFERENCES `operators` (`id`),
  CONSTRAINT `events_ibfk_3` FOREIGN KEY (`sport_id`) REFERENCES `sports` (`id`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_custom_points`
--

DROP TABLE IF EXISTS `events_custom_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `events_custom_points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `custom_point_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `custom_point_id` (`custom_point_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `events_custom_points_ibfk_1` FOREIGN KEY (`custom_point_id`) REFERENCES `custom_points` (`id`),
  CONSTRAINT `events_custom_points_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_custom_points`
--

LOCK TABLES `events_custom_points` WRITE;
/*!40000 ALTER TABLE `events_custom_points` DISABLE KEYS */;
/*!40000 ALTER TABLE `events_custom_points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_facilities`
--

DROP TABLE IF EXISTS `events_facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `events_facilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `facility_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`),
  KEY `facility_id` (`facility_id`),
  CONSTRAINT `events_facilities_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  CONSTRAINT `events_facilities_ibfk_2` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_facilities`
--

LOCK TABLES `events_facilities` WRITE;
/*!40000 ALTER TABLE `events_facilities` DISABLE KEYS */;
/*!40000 ALTER TABLE `events_facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_page`
--

DROP TABLE IF EXISTS `events_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `events_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logo_1` text,
  `logo_2` text,
  `logo_3` text,
  `notes` text,
  `social_media` varchar(255) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_page`
--

LOCK TABLES `events_page` WRITE;
/*!40000 ALTER TABLE `events_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `events_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_rules`
--

DROP TABLE IF EXISTS `events_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `events_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rule_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `teams` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rule_id` (`rule_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `events_rules_ibfk_1` FOREIGN KEY (`rule_id`) REFERENCES `rules` (`id`),
  CONSTRAINT `events_rules_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_rules`
--

LOCK TABLES `events_rules` WRITE;
/*!40000 ALTER TABLE `events_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `events_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_teams`
--

DROP TABLE IF EXISTS `events_teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `events_teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`),
  KEY `team_id` (`team_id`),
  CONSTRAINT `events_teams_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  CONSTRAINT `events_teams_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_teams`
--

LOCK TABLES `events_teams` WRITE;
/*!40000 ALTER TABLE `events_teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `events_teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facilities`
--

DROP TABLE IF EXISTS `facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `facilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `abbreviation` varchar(10) NOT NULL,
  `street` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `zip` varchar(20) NOT NULL,
  `mapUrl` varchar(500) NOT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `operator_id` (`operator_id`),
  KEY `facilities_state_id_foreign_idx` (`state_id`),
  CONSTRAINT `facilities_ibfk_2` FOREIGN KEY (`operator_id`) REFERENCES `operators` (`id`),
  CONSTRAINT `facilities_state_id_foreign_idx` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facilities`
--

LOCK TABLES `facilities` WRITE;
/*!40000 ALTER TABLE `facilities` DISABLE KEYS */;
/*!40000 ALTER TABLE `facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genders`
--

DROP TABLE IF EXISTS `genders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `genders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genders`
--

LOCK TABLES `genders` WRITE;
/*!40000 ALTER TABLE `genders` DISABLE KEYS */;
INSERT INTO `genders` VALUES (1,'Girls','2021-01-04 00:00:00','2021-01-04 00:00:00',NULL)
,(2,'Boys','2021-01-04 00:00:00','2021-01-04 00:00:00',NULL)
,(3,'All','2021-01-04 00:00:00','2021-01-04 00:00:00',NULL);
/*!40000 ALTER TABLE `genders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operators`
--

DROP TABLE IF EXISTS `operators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `operators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operators`
--

LOCK TABLES `operators` WRITE;
/*!40000 ALTER TABLE `operators` DISABLE KEYS */;
/*!40000 ALTER TABLE `operators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operators_custom_points`
--

DROP TABLE IF EXISTS `operators_custom_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `operators_custom_points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `custom_point_id` int(11) DEFAULT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  `values` text,
  `group` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `custom_point_id` (`custom_point_id`),
  KEY `operator_id` (`operator_id`),
  CONSTRAINT `operators_custom_points_ibfk_1` FOREIGN KEY (`custom_point_id`) REFERENCES `custom_points` (`id`),
  CONSTRAINT `operators_custom_points_ibfk_2` FOREIGN KEY (`operator_id`) REFERENCES `operators` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operators_custom_points`
--

LOCK TABLES `operators_custom_points` WRITE;
/*!40000 ALTER TABLE `operators_custom_points` DISABLE KEYS */;
/*!40000 ALTER TABLE `operators_custom_points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operators_page`
--

DROP TABLE IF EXISTS `operators_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `operators_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logo_1` text,
  `logo_2` text,
  `logo_3` text,
  `notes` text,
  `social_media` varchar(255) DEFAULT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operators_page`
--

LOCK TABLES `operators_page` WRITE;
/*!40000 ALTER TABLE `operators_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `operators_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operators_rules`
--

DROP TABLE IF EXISTS `operators_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `operators_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rule_id` int(11) DEFAULT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `teams` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rule_id` (`rule_id`),
  KEY `operator_id` (`operator_id`),
  CONSTRAINT `operators_rules_ibfk_1` FOREIGN KEY (`rule_id`) REFERENCES `rules` (`id`),
  CONSTRAINT `operators_rules_ibfk_2` FOREIGN KEY (`operator_id`) REFERENCES `operators` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operators_rules`
--

LOCK TABLES `operators_rules` WRITE;
/*!40000 ALTER TABLE `operators_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `operators_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operators_teams`
--

DROP TABLE IF EXISTS `operators_teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `operators_teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operator_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operators_teams`
--

LOCK TABLES `operators_teams` WRITE;
/*!40000 ALTER TABLE `operators_teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `operators_teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logo_1` text,
  `logo_2` text,
  `logo_3` text,
  `notes` text,
  `social_media` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'logo_1-1609758346432.png','logo_2-1609758346449.png','logo_3-1609758346465.png','These are the default notes','@primetimesportz','2021-01-04 10:48:20','2021-01-04 11:05:46',NULL);
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_systems`
--

DROP TABLE IF EXISTS `registration_systems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `registration_systems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_systems`
--

LOCK TABLES `registration_systems` WRITE;
/*!40000 ALTER TABLE `registration_systems` DISABLE KEYS */;
/*!40000 ALTER TABLE `registration_systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin','2021-01-04 00:00:00','2021-01-04 00:00:00',NULL)
,(2,'Operator','2021-01-04 00:00:00','2021-01-04 00:00:00',NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rules`
--

DROP TABLE IF EXISTS `rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `order` int(11) DEFAULT NULL,
  `sport_id` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  `values` text,
  `value` varchar(255) DEFAULT NULL,
  `teams` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sport_id` (`sport_id`),
  CONSTRAINT `rules_ibfk_1` FOREIGN KEY (`sport_id`) REFERENCES `sports` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rules`
--

LOCK TABLES `rules` WRITE;
/*!40000 ALTER TABLE `rules` DISABLE KEYS */;
INSERT INTO `rules` VALUES (1,'Head to Head',NULL,1,'2021-01-04 10:48:18','2021-01-04 10:48:18',NULL,'{}','1',2)
,(2,'Point Differential',NULL,1,'2021-01-04 10:48:18','2021-01-04 10:48:18',NULL,'{}','1',2)
,(3,'Points Against',NULL,1,'2021-01-04 10:48:18','2021-01-04 10:48:18',NULL,'{}','1',2)
,(4,'Points For',NULL,1,'2021-01-04 10:48:18','2021-01-04 10:48:18',NULL,'{}','1',2)
,(5,'Coin Flip',NULL,1,'2021-01-04 10:48:18','2021-01-04 10:48:18',NULL,'{}','1',2)
,(6,'Common Point differential',NULL,1,'2021-01-04 10:48:18','2021-01-04 10:48:18',NULL,'{}','1',3)
,(7,'Common Wins',NULL,1,'2021-01-04 10:48:18','2021-01-04 10:48:18',NULL,'{}','1',3)
,(8,'Common Points Against',NULL,1,'2021-01-04 10:48:18','2021-01-04 10:48:18',NULL,'{}','1',3)
,(9,'Common Points For',NULL,1,'2021-01-04 10:48:18','2021-01-04 10:48:18',NULL,'{}','1',3)
,(10,'Points For',NULL,1,'2021-01-04 10:48:18','2021-01-04 10:48:18',NULL,'{}','1',3)
,(11,'Points Against',NULL,1,'2021-01-04 10:48:18','2021-01-04 10:48:18',NULL,'{}','1',3)
,(12,'Point Differential',NULL,1,'2021-01-04 10:48:18','2021-01-04 10:48:18',NULL,'{}','1',3)
,(13,'Coin Flip',NULL,1,'2021-01-04 10:48:18','2021-01-04 10:48:18',NULL,'{}','1',3)
,(14,'Head to Head',NULL,2,'2021-01-04 10:48:18','2021-01-04 10:48:18',NULL,'{}','1',2)
,(15,'Point Differential',NULL,2,'2021-01-04 10:48:18','2021-01-04 10:48:18',NULL,'{}','1',2)
,(16,'Points Against',NULL,2,'2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}','1',2)
,(17,'Points For',NULL,2,'2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}','1',2)
,(18,'Coin Flip',NULL,2,'2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}','1',2)
,(19,'Common Point differential',NULL,2,'2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}','1',3)
,(20,'Common Wins',NULL,2,'2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}','1',3)
,(21,'Common Points Against',NULL,2,'2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}','1',3)
,(22,'Common Points For',NULL,2,'2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}','1',3)
,(23,'Points For',NULL,2,'2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}','1',3)
,(24,'Points Against',NULL,2,'2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}','1',3)
,(25,'Point Differential',NULL,2,'2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}','1',3)
,(26,'Coin Flip',NULL,2,'2021-01-04 10:48:19','2021-01-04 10:48:19',NULL,'{}','1',3);
/*!40000 ALTER TABLE `rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sports`
--

DROP TABLE IF EXISTS `sports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sports`
--

LOCK TABLES `sports` WRITE;
/*!40000 ALTER TABLE `sports` DISABLE KEYS */;
INSERT INTO `sports` VALUES (1,'Basketball','2021-01-04 10:48:18','2021-01-04 10:48:18',NULL)
,(2,'Soccer','2021-01-04 10:48:18','2021-01-04 10:48:18',NULL);
/*!40000 ALTER TABLE `sports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `abbreviation` varchar(2) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `registration_id` int(11) DEFAULT NULL,
  `external_team_id` int(11) DEFAULT NULL,
  `coach_id` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `registration_id` (`registration_id`),
  KEY `coach_id` (`coach_id`),
  CONSTRAINT `teams_ibfk_1` FOREIGN KEY (`registration_id`) REFERENCES `registration_systems` (`id`),
  CONSTRAINT `teams_ibfk_2` FOREIGN KEY (`coach_id`) REFERENCES `coaches` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiebreakers`
--

DROP TABLE IF EXISTS `tiebreakers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tiebreakers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sport_id` int(11) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sport_id` (`sport_id`),
  CONSTRAINT `tiebreakers_ibfk_1` FOREIGN KEY (`sport_id`) REFERENCES `sports` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiebreakers`
--

LOCK TABLES `tiebreakers` WRITE;
/*!40000 ALTER TABLE `tiebreakers` DISABLE KEYS */;
/*!40000 ALTER TABLE `tiebreakers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiebreakers_rules`
--

DROP TABLE IF EXISTS `tiebreakers_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tiebreakers_rules` (
  `rule_id` int(11) DEFAULT NULL,
  `tiebreaker_id` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  KEY `rule_id` (`rule_id`),
  KEY `tiebreaker_id` (`tiebreaker_id`),
  CONSTRAINT `tiebreakers_rules_ibfk_1` FOREIGN KEY (`rule_id`) REFERENCES `rules` (`id`),
  CONSTRAINT `tiebreakers_rules_ibfk_2` FOREIGN KEY (`tiebreaker_id`) REFERENCES `tiebreakers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiebreakers_rules`
--

LOCK TABLES `tiebreakers_rules` WRITE;
/*!40000 ALTER TABLE `tiebreakers_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `tiebreakers_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,NULL,'admin@admin',NULL,'2021-01-04 00:00:00','2021-01-04 00:00:00',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_roles`
--

LOCK TABLES `users_roles` WRITE;
/*!40000 ALTER TABLE `users_roles` DISABLE KEYS */;
INSERT INTO `users_roles` VALUES (1,1,1,'2021-01-04 00:00:00','2021-01-04 00:00:00',NULL);
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-04 19:55:44
