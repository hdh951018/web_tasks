-- MySQL dump 10.13  Distrib 5.5.44, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: msgboard
-- ------------------------------------------------------
-- Server version	5.5.44-0ubuntu0.14.04.1

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
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msg` varchar(10000) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,'行走在 冬夜的冷风中','2015-08-11 18:16:39',100002),(2,' 飘散的 踩碎的 都是梦','2015-08-11 18:16:39',100002),(3,' 孤单单这一刻 如何 确定你曾爱过我 ','2015-08-11 18:16:39',100002),(4,'停留在冬夜的冷风中 我不是 也不想 装脆弱 ','2015-08-11 18:16:39',100001),(5,'我没说不代表我不会痛','2015-08-11 18:16:39',100000),(6,'停留在冬夜的冷风中 我不是 也不想 装脆弱 ','2015-08-11 18:16:39',100002),(7,'只因为你说过 爱是等待是细水长流 ','2015-08-11 18:16:39',100000),(8,'Je le sais continue c’est pas bon  ','2015-08-11 18:16:39',100000),(9,'A la fin turestes pas longtemps','2015-08-11 18:16:39',100000),(10,'我没说不代表我不会痛','2015-08-11 18:16:39',100002),(11,'行走在 冬夜的冷风中','2015-08-11 18:16:39',100001),(12,' 飘散的 踩碎的 都是梦','2015-08-11 18:16:39',100001),(13,' 孤单单这一刻 如何 确定你曾爱过我 ','2015-08-11 18:16:39',100001),(14,'停留在冬夜的冷风中 我不是 也不想 装脆弱 ','2015-08-11 18:16:39',100000),(15,'我没说不代表我不会痛','2015-08-11 18:16:40',100001),(16,'停留在冬夜的冷风中 我不是 也不想 装脆弱 ','2015-08-11 18:16:40',100001),(17,'只因为你说过 爱是等待是细水长流 ','2015-08-11 18:16:40',100001),(18,'Je le sais continue c’est pas bon  ','2015-08-11 18:16:40',100001),(19,'A la fin turestes pas longtemps','2015-08-11 18:16:40',100001),(20,'我没说不代表我不会痛','2015-08-11 18:16:40',100001),(21,'行走在 冬夜的冷风中','2015-08-11 18:16:40',100000),(22,' 飘散的 踩碎的 都是梦','2015-08-11 18:16:40',100001),(23,' 孤单单这一刻 如何 确定你曾爱过我 ','2015-08-11 18:16:40',100000),(24,'停留在冬夜的冷风中 我不是 也不想 装脆弱 ','2015-08-11 18:16:40',100002),(25,'我没说不代表我不会痛','2015-08-11 18:16:40',100000),(26,'停留在冬夜的冷风中 我不是 也不想 装脆弱 ','2015-08-11 18:16:40',100001),(27,'只因为你说过 爱是等待是细水长流 ','2015-08-11 18:16:40',100000),(28,'Je le sais continue c’est pas bon  ','2015-08-11 18:16:40',100002),(29,'A la fin turestes pas longtemps','2015-08-11 18:16:40',100000),(30,'我没说不代表我不会痛','2015-08-11 18:16:40',100000),(31,'行走在 冬夜的冷风中','2015-08-11 18:16:40',100001),(32,' 飘散的 踩碎的 都是梦','2015-08-11 18:16:40',100001),(33,' 孤单单这一刻 如何 确定你曾爱过我 ','2015-08-11 18:16:40',100000),(34,'停留在冬夜的冷风中 我不是 也不想 装脆弱 ','2015-08-11 18:16:40',100000),(35,'我没说不代表我不会痛','2015-08-11 18:16:40',100000),(36,'停留在冬夜的冷风中 我不是 也不想 装脆弱 ','2015-08-11 18:16:40',100000),(37,'只因为你说过 爱是等待是细水长流 ','2015-08-11 18:16:40',100002),(38,'Je le sais continue c’est pas bon  ','2015-08-11 18:16:40',100002),(39,'A la fin turestes pas longtemps','2015-08-11 18:16:40',100000),(40,'我没说不代表我不会痛','2015-08-11 18:16:40',100002),(41,'行走在 冬夜的冷风中','2015-08-11 18:16:40',100000),(42,' 飘散的 踩碎的 都是梦','2015-08-11 18:16:41',100001),(43,' 孤单单这一刻 如何 确定你曾爱过我 ','2015-08-11 18:16:41',100001),(44,'停留在冬夜的冷风中 我不是 也不想 装脆弱 ','2015-08-11 18:16:41',100002),(45,'我没说不代表我不会痛','2015-08-11 18:16:41',100002),(46,'停留在冬夜的冷风中 我不是 也不想 装脆弱 ','2015-08-11 18:16:41',100001),(47,'只因为你说过 爱是等待是细水长流 ','2015-08-11 18:16:41',100002),(48,'Je le sais continue c’est pas bon  ','2015-08-11 18:16:41',100002),(49,'A la fin turestes pas longtemps','2015-08-11 18:16:41',100001),(50,'我没说不代表我不会痛','2015-08-11 18:16:41',100000);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `userpassword` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100003 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (100000,'jasonsi','f7c3bc1d808e04732adf679965ccc34ca7ae3441'),(100001,'jasonpu','f7c3bc1d808e04732adf679965ccc34ca7ae3441'),(100002,'jasonshe','f7c3bc1d808e04732adf679965ccc34ca7ae3441');
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

-- Dump completed on 2015-08-12  2:20:00
