-- MySQL dump 10.13  Distrib 5.7.21, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: spa
-- ------------------------------------------------------
-- Server version	5.7.21

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
-- Current Database: `spa`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `spa` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `spa`;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `gravatar` varchar(2083) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Colin','http://www.gravatar.com/avatar/a51972ea936bc3b841350caef34ea47e?s=64&d=monsterid'),(2,'Kyle','http://www.gravatar.com/avatar/432f3e353c689fc37af86ae861d934f9?s=64&d=monsterid'),(3,'Thomas','http://www.gravatar.com/avatar/48009c6a27d25ef0ea03f985d1f186b0?s=64&d=monsterid'),(4,'James','http://www.gravatar.com/avatar/9372f138140c8578c82bbc77b2eca602?s=64&d=monsterid');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `color` varchar(30) DEFAULT NULL,
  `price` decimal(20,2) unsigned zerofill DEFAULT NULL,
  `inventory` int(10) unsigned NOT NULL,
  `melts` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
INSERT INTO `widgets` VALUES (1,'Losenoid','red',000000000000000009.00,100,1),(2,'Rowlow','red',000000000000000003.00,7,1),(3,'Printure','green',000000000000000005.55,18,0),(4,'Claster','off-white',000000000000000012.56,9,1),(5,'Pepelexa hi','purple',000000000000000000.99,0,1),(6,'Dropellet','speckled',000000000000000016.00,99,1),(7,'Jeebus','depends on the viewing angle',000000000000000018.11,36,1),(8,'Nodile','red',000000000000000050.00,20,1),(9,'Kaloobon','white',000000000000000008.00,40,1),(10,'Bioyino','turtle-shell',000000000000000090.12,3,1),(11,'Dizoolexa','magenta',000000000000000067.23,976,0),(12,'Skippy','green',000000000000000000.01,404,1),(13,'what','black',000000000000000050.00,4,1),(14,'My id is actually 333','purple',000000000000000600.00,900,1),(15,'Test','blue',000000000000000007.77,13,1),(16,'Testing','red',000000000000000004.00,7,1),(17,'Testing','test',000000000000000004.00,7,1),(18,'Testing','test',000000000000000004.00,7,1),(19,'Testing','test',000000000000000000.00,7,1),(20,'Testing','test',000000000000000000.00,7,1),(21,'Testing','test',000000000000000000.00,7,1),(22,'Testing','test',000000000000000002.88,7,1),(23,'Testing','test',000000000000000001.00,7,1),(24,'Testing','test',000000000000000001.00,7,1),(25,'Testing','test',000000000000000001.00,0,1),(26,'Testing','test',000000000000000001.00,0,1),(27,'Testing','test',000000000000000001.00,52,1),(28,'Testing','test',000000000000000001.00,52,1),(29,'Testing','test',000000000000000006.75,52,1),(30,'Losenoid','blue',000000000000000009.99,51,1),(31,'testing 123','red',000000000000000123.00,123,1),(32,'xyz','red',000000000000000123.00,0,1),(33,'test 123','red',000000000000000123.00,1,1),(34,'test 123','red',000000000000000123.00,0,1),(35,'test 123','red',000000000000000000.00,0,1),(36,'testing 123','red',000000000000000123.00,1,1),(37,'testing 123','purple',000000000000000123.00,123,1),(38,'testing 321','blue',000000000000000321.00,111,1),(39,'testing 123','black',000000000000000111.00,111,1),(40,'xxy','purple',000000000000123123.00,555,1),(41,'test','turtle-shell',000000000000000123.00,111,1),(42,'new widget','blue',000000000000000111.00,123,1),(43,'Tester','magenta',000000000000000010.00,0,1),(44,'Quin Testing updated','Blue',000000000000000100.00,99,1),(45,'Losenoid','blue',000000000000000009.99,51,1),(46,'Losenoid','blue',000000000000000009.99,51,1),(47,'Losenoid','blue',000000000000000009.99,51,1),(48,'Losenoid','blue',000000000000000009.99,51,1),(49,'Losenoid','blue',000000000000000009.99,51,1),(50,'Losenoid','blue',000000000000000009.99,51,1),(51,'Losenoid','blue',000000000000000009.99,51,1),(52,'Losenoid','blue',000000000000000009.99,51,1),(53,'Losenoid','blue',000000000000000009.99,51,1),(54,'Losenoid','blue',000000000000000009.99,51,1),(55,'Quin Testing updated2','Blue',000000000000000100.00,99,1),(56,'Quin','glue',000000000000000100.00,99,1),(57,'Quin2','glue',000000000000000100.00,99,1),(58,'chocolate final','Brown',000000000000000010.00,1000,1),(59,'test1','Yellow',000000000000001000.00,999,0),(60,'test4','Yellow',000000000000001000.00,999,0),(61,'test2','Yellow',000000000000001000.00,999,1),(62,'test2','Yellow',000000000000001000.00,999,1),(63,'test2','Yellow',000000000000001000.00,999,1),(64,'test2','Yellow',000000000000001000.00,999,1),(65,'test2','Yellow',000000000000001000.00,999,1),(66,'test2','Yellow',000000000000001000.00,999,1),(67,'test2','Yellow',000000000000001000.00,999,1);
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-21 20:14:12
