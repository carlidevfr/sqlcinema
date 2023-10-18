-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: gestion_cinemas
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

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
-- Table structure for table `cinemas`
--

DROP TABLE IF EXISTS `cinemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cinemas` (
  `idCinema` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`idCinema`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cinemas`
--

LOCK TABLES `cinemas` WRITE;
/*!40000 ALTER TABLE `cinemas` DISABLE KEYS */;
INSERT INTO `cinemas` VALUES (1,'Pathé'),(2,'VOX'),(3,'UGC Jaune');
/*!40000 ALTER TABLE `cinemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directors`
--

DROP TABLE IF EXISTS `directors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directors` (
  `user_id` char(36) NOT NULL,
  `cinema_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`cinema_id`),
  KEY `cinema_id` (`cinema_id`),
  CONSTRAINT `directors_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`userId`),
  CONSTRAINT `directors_ibfk_2` FOREIGN KEY (`cinema_id`) REFERENCES `cinemas` (`idCinema`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directors`
--

LOCK TABLES `directors` WRITE;
/*!40000 ALTER TABLE `directors` DISABLE KEYS */;
INSERT INTO `directors` VALUES ('81d99513-6680-11ee-ab47-3244bff07888',1),('81d99513-6680-11ee-ab47-3244bff07888',2),('81d99513-6680-11ee-ab47-3244bff07888',3);
/*!40000 ALTER TABLE `directors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `idCinema` int(11) NOT NULL,
  `employeeId` char(36) NOT NULL,
  `isAdmin` tinyint(1) NOT NULL,
  PRIMARY KEY (`employeeId`),
  KEY `idCinema` (`idCinema`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`idCinema`) REFERENCES `cinemas` (`idCinema`),
  CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`employeeId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'81d994b8-6680-11ee-ab47-3244bff07888',0),(2,'81d994e7-6680-11ee-ab47-3244bff07888',0),(1,'81d99513-6680-11ee-ab47-3244bff07888',1);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movierooms`
--

DROP TABLE IF EXISTS `movierooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movierooms` (
  `idMovieRoom` int(11) NOT NULL AUTO_INCREMENT,
  `seatQuantity` int(11) NOT NULL,
  `roomName` varchar(250) DEFAULT NULL,
  `isInCinema` int(11) NOT NULL,
  `managedBy` char(36) DEFAULT NULL,
  PRIMARY KEY (`idMovieRoom`),
  KEY `isInCinema` (`isInCinema`),
  KEY `managedBy` (`managedBy`),
  CONSTRAINT `movierooms_ibfk_1` FOREIGN KEY (`isInCinema`) REFERENCES `cinemas` (`idCinema`) ON DELETE CASCADE,
  CONSTRAINT `movierooms_ibfk_2` FOREIGN KEY (`managedBy`) REFERENCES `users` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movierooms`
--

LOCK TABLES `movierooms` WRITE;
/*!40000 ALTER TABLE `movierooms` DISABLE KEYS */;
INSERT INTO `movierooms` VALUES (1,250,'Salle 1',1,NULL),(2,200,'Salle 2',1,NULL),(3,75,'Salle 3',1,NULL),(4,300,'Salle 1',2,NULL),(5,200,'Salle 2',2,NULL),(6,500,'Salle 1',3,NULL),(7,240,'Salle 2',3,NULL);
/*!40000 ALTER TABLE `movierooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movies` (
  `idMovie` int(11) NOT NULL AUTO_INCREMENT,
  `movieName` varchar(250) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `director` varchar(250) DEFAULT NULL,
  `releaseDate` date DEFAULT NULL,
  PRIMARY KEY (`idMovie`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (1,'Le Navet','L\'histoire passionnante de la pousse d\'un navet solitaire','Leo Sali','2023-10-25'),(2,'Chat Pristi','Une comédie rafraichissante avec Milou le chat','Sarah KITTY','2023-10-20');
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderdetails` (
  `idOrderDetails` int(11) NOT NULL AUTO_INCREMENT,
  `inOrder` int(11) NOT NULL,
  `seance` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`idOrderDetails`),
  KEY `inOrder` (`inOrder`),
  KEY `seance` (`seance`),
  KEY `price` (`price`),
  CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`inOrder`) REFERENCES `orders` (`idOrder`) ON DELETE CASCADE,
  CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`seance`) REFERENCES `seances` (`idSeance`),
  CONSTRAINT `orderdetails_ibfk_3` FOREIGN KEY (`price`) REFERENCES `prices` (`idPrice`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
INSERT INTO `orderdetails` VALUES (1,1,2,2,1),(2,1,2,2,3),(3,1,2,2,2),(4,2,1,6,1);
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `idOrder` int(11) NOT NULL AUTO_INCREMENT,
  `customer` char(36) NOT NULL,
  `dateOrder` datetime NOT NULL,
  `payment` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`idOrder`),
  KEY `customer` (`customer`),
  KEY `payment` (`payment`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer`) REFERENCES `users` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`payment`) REFERENCES `paymentmethods` (`idPayment`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'81d98bf1-6680-11ee-ab47-3244bff07888','2023-11-05 12:30:00',2,1),(2,'81d99427-6680-11ee-ab47-3244bff07888','2023-11-05 11:30:00',1,1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymentmethods`
--

DROP TABLE IF EXISTS `paymentmethods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentmethods` (
  `idPayment` int(11) NOT NULL AUTO_INCREMENT,
  `paymentMethod` varchar(250) NOT NULL,
  PRIMARY KEY (`idPayment`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymentmethods`
--

LOCK TABLES `paymentmethods` WRITE;
/*!40000 ALTER TABLE `paymentmethods` DISABLE KEYS */;
INSERT INTO `paymentmethods` VALUES (1,'En ligne'),(2,'Sur place');
/*!40000 ALTER TABLE `paymentmethods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prices` (
  `idPrice` int(11) NOT NULL AUTO_INCREMENT,
  `priceName` varchar(250) NOT NULL,
  `price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`idPrice`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices`
--

LOCK TABLES `prices` WRITE;
/*!40000 ALTER TABLE `prices` DISABLE KEYS */;
INSERT INTO `prices` VALUES (1,'Plein tarif',9.20),(2,'Etudiant',7.60),(3,'Moins de 14 ans',5.90);
/*!40000 ALTER TABLE `prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seances`
--

DROP TABLE IF EXISTS `seances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seances` (
  `idSeance` int(11) NOT NULL AUTO_INCREMENT,
  `movie` int(11) NOT NULL,
  `dateSeance` datetime NOT NULL,
  `isInRoom` int(11) NOT NULL,
  PRIMARY KEY (`idSeance`),
  KEY `movie` (`movie`),
  KEY `isInRoom` (`isInRoom`),
  CONSTRAINT `seances_ibfk_1` FOREIGN KEY (`movie`) REFERENCES `movies` (`idMovie`) ON DELETE CASCADE,
  CONSTRAINT `seances_ibfk_2` FOREIGN KEY (`isInRoom`) REFERENCES `movierooms` (`idMovieRoom`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seances`
--

LOCK TABLES `seances` WRITE;
/*!40000 ALTER TABLE `seances` DISABLE KEYS */;
INSERT INTO `seances` VALUES (1,1,'2023-11-05 16:30:00',1),(2,1,'2023-11-05 16:30:00',4),(3,1,'2023-11-05 16:30:00',6),(4,2,'2023-11-05 16:30:00',2),(5,2,'2023-11-05 18:30:00',5),(6,2,'2023-11-05 19:30:00',7);
/*!40000 ALTER TABLE `seances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userId` char(36) NOT NULL,
  `firstname` varchar(250) DEFAULT NULL,
  `lastname` varchar(250) DEFAULT NULL,
  `email` varchar(250) NOT NULL,
  `password` varchar(60) NOT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('81d98bf1-6680-11ee-ab47-3244bff07888','Léa','ASAHA','lea.asaha@gmail.com','$2y$10$mqB8yDpk23TtmtrJz94QOeDfb1NI/HCgMv1RiN1BXOlHcB1pJ1gKi'),('81d99427-6680-11ee-ab47-3244bff07888','Mireille','SELIEU','mireille.selieu@gmail.com','$2y$10$F9qw8Unkrb6zjg8w0TPx4empkLjNL.BAtvrtjiWJHn.ltKHtiSh5e'),('81d994b8-6680-11ee-ab47-3244bff07888','SARAH','DE LA COUR','sarah.delacour@gmail.com','$2y$10$0U38FScBg95NXqxB0SX/rO/fa2MSdGzPxysiBxWSIPJO1MmFcndcm'),('81d994e7-6680-11ee-ab47-3244bff07888','José','GARCIA','jose.garcia@gmail.com','$2y$10$bp8mwKwyft3yZguTy4DPJ.xPFoZILOSC5rX0w0rXVuYEppDUYxfvy'),('81d99513-6680-11ee-ab47-3244bff07888','LISA','XEO','lisa.xeo@gmail.com','$2y$10$TWOdSjZZvQVjRvOZZQ0NyOsWKJkAT9K1zOiGqtRY0jhNrGmh3TcMG');
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

-- Dump completed on 2023-10-17 10:52:30
