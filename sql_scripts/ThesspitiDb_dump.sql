-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: thesspitidb
-- ------------------------------------------------------
-- Server version	8.1.0
DROP SCHEMA IF EXISTS `thesspitidb`;
CREATE SCHEMA `thesspitidb`;
USE `thesspitidb`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `advertisement`
--

DROP TABLE IF EXISTS `advertisement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advertisement` (
  `Property_ID` int NOT NULL,
  `Purpose` enum('Sale','Rent') NOT NULL,
  `Cost` float NOT NULL,
  PRIMARY KEY (`Property_ID`,`Purpose`),
  CONSTRAINT `PropertyID_Ad` FOREIGN KEY (`Property_ID`) REFERENCES `property` (`Property_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advertisement`
--

LOCK TABLES `advertisement` WRITE;
/*!40000 ALTER TABLE `advertisement` DISABLE KEYS */;
INSERT INTO `advertisement` VALUES (1,'Sale',100000),(1,'Rent',1000),(3,'Sale',400000),(3,'Rent',380),(4,'Sale',150),(4,'Rent',1500),(5,'Sale',200000),(5,'Rent',300),(6,'Sale',50000),(8,'Rent',400),(9,'Sale',150000),(9,'Rent',600),(12,'Sale',400000),(12,'Rent',400),(13,'Sale',50000),(13,'Rent',100),(14,'Sale',600000),(14,'Rent',560),(16,'Sale',500),(18,'Rent',90),(21,'Sale',50000),(21,'Rent',300);
/*!40000 ALTER TABLE `advertisement` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Cost_BEFORE_INSERT` BEFORE INSERT ON `advertisement` FOR EACH ROW BEGIN
	IF (NEW.Cost <0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Advertisement Table-Cost Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Cost_BEFORE_UPDATE` BEFORE UPDATE ON `advertisement` FOR EACH ROW BEGIN
	IF (NEW.Cost <0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Advertisement Table-Cost Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `advertisement_watched_by_user`
--

DROP TABLE IF EXISTS `advertisement_watched_by_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advertisement_watched_by_user` (
  `User_ID` int NOT NULL,
  `Property_ID` int NOT NULL,
  `Purpose` enum('Sale','Rent') NOT NULL,
  `Level_of_Interest` int NOT NULL,
  `Notes` varchar(1000) DEFAULT NULL,
  `Create_Notification` tinyint DEFAULT '1',
  PRIMARY KEY (`User_ID`,`Property_ID`,`Purpose`),
  KEY `PropertyID&Purpose_idx` (`Property_ID`,`Purpose`),
  CONSTRAINT `PropertyID&Purpose_Ad` FOREIGN KEY (`Property_ID`, `Purpose`) REFERENCES `advertisement` (`Property_ID`, `Purpose`),
  CONSTRAINT `UserID_Ad` FOREIGN KEY (`User_ID`) REFERENCES `user` (`User_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advertisement_watched_by_user`
--

LOCK TABLES `advertisement_watched_by_user` WRITE;
/*!40000 ALTER TABLE `advertisement_watched_by_user` DISABLE KEYS */;
INSERT INTO `advertisement_watched_by_user` VALUES (1,1,'Rent',8,'Great price',1),(1,3,'Sale',5,'Not bad not great',1),(1,3,'Rent',3,'No bathrooms',1),(1,4,'Rent',7,'Great price',1),(1,5,'Sale',5,'Not a garage',0),(1,8,'Rent',10,'Not a garage',0),(2,3,'Sale',10,'No bathrooms',1),(2,6,'Sale',3,'Good but small',1),(2,13,'Sale',10,'Great price',1),(2,13,'Rent',7,'Good but small',1),(3,1,'Rent',10,'Good but small',1),(5,3,'Rent',5,'No bathrooms',1),(5,4,'Sale',7,'No bathrooms',1),(5,8,'Rent',7,'Not a garage',0),(6,13,'Sale',3,'Great price',1),(6,13,'Rent',5,'Good but small',1),(7,5,'Rent',10,'Speak with owner',0);
/*!40000 ALTER TABLE `advertisement_watched_by_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Advertisement_Watched_by_User_BEFORE_INSERT` BEFORE INSERT ON `advertisement_watched_by_user` FOR EACH ROW BEGIN
	IF (NEW.Level_of_Interest <0) OR (NEW.Level_of_Interest >10) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Advertisement_Watched_by_User Table-Level_of_Interest Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Advertisement_Watched_by_User_BEFORE_UPDATE` BEFORE UPDATE ON `advertisement_watched_by_user` FOR EACH ROW BEGIN
	IF (NEW.Level_of_Interest <0) OR (NEW.Level_of_Interest >10) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Advertisement_Watched_by_User Table-Level_of_Interest Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `distance`
--

DROP TABLE IF EXISTS `distance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `distance` (
  `Landmark_Name` varchar(50) NOT NULL,
  `Municipality` varchar(50) NOT NULL,
  `Area_Name` varchar(50) NOT NULL,
  `Travel_Time_Bus` int DEFAULT NULL,
  `Travel_Time_Walk` int DEFAULT NULL,
  `Travel_Time_Car` int DEFAULT NULL,
  `Distance` float NOT NULL,
  PRIMARY KEY (`Landmark_Name`,`Municipality`,`Area_Name`),
  KEY `Municipality&Area_Name_idx` (`Municipality`,`Area_Name`),
  CONSTRAINT `Landmark_Name_Distance` FOREIGN KEY (`Landmark_Name`) REFERENCES `landmark` (`Name`),
  CONSTRAINT `Municipality&Area_Name_Distance` FOREIGN KEY (`Municipality`, `Area_Name`) REFERENCES `location` (`Municipality`, `Area_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distance`
--

LOCK TABLES `distance` WRITE;
/*!40000 ALTER TABLE `distance` DISABLE KEYS */;
INSERT INTO `distance` VALUES ('Auth','Thermis','Triadi',60,250,30,8.5),('Ladadika','Pilaias-Hortiati','Hortiatis',70,300,25,17.3),('UoM','Kalamarias','Kalamaria',50,200,20,3.1),('White Tower of Thessaloniki','Pilaias-Hortiati','Panorama',45,15,4,2.2);
/*!40000 ALTER TABLE `distance` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Distance_BEFORE_INSERT` BEFORE INSERT ON `distance` FOR EACH ROW BEGIN
	IF (NEW.Distance <0) OR (NEW.Travel_Time_Bus <0) OR (NEW.Travel_Time_Walk <0) OR (NEW.Travel_Time_Car <0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Distance Table';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Distance_BEFORE_UPDATE` BEFORE UPDATE ON `distance` FOR EACH ROW BEGIN
	IF (NEW.Distance <0) OR (NEW.Travel_Time_Bus <0) OR (NEW.Travel_Time_Walk <0) OR (NEW.Travel_Time_Car <0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Distance Table';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `house`
--

DROP TABLE IF EXISTS `house`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `house` (
  `House_ID` int NOT NULL,
  `Year_of_Renovation` year DEFAULT NULL,
  `Year_of_Construction` year DEFAULT NULL,
  `House_Type` enum('Detached House','Apartment','Villa') DEFAULT 'Apartment',
  `Rooms_Number` int DEFAULT NULL,
  `Floor_Number` int DEFAULT NULL,
  `Heating_System` tinyint DEFAULT NULL,
  `Energy_Class` int DEFAULT NULL,
  PRIMARY KEY (`House_ID`),
  CONSTRAINT `HouseID_Property` FOREIGN KEY (`House_ID`) REFERENCES `property` (`Property_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `house`
--

LOCK TABLES `house` WRITE;
/*!40000 ALTER TABLE `house` DISABLE KEYS */;
INSERT INTO `house` VALUES (4,1995,1950,'Apartment',5,3,0,1),(6,2010,1990,'Detached House',6,NULL,1,3),(8,2020,2010,'Apartment',2,3,0,1),(10,1965,1940,'Villa',12,NULL,1,4),(12,2020,1990,'Apartment',2,3,0,3),(14,2000,1940,'Villa',6,NULL,1,3),(16,2020,1940,'Apartment',6,2,0,1),(18,2020,1990,'Villa',5,NULL,1,3),(20,2000,1986,'Apartment',2,2,0,1),(22,2020,1990,'Detached House',5,NULL,1,4),(24,2010,2010,'Apartment',5,2,0,4),(26,2000,1999,'Detached House',6,NULL,1,1),(28,2010,2010,'Detached House',3,NULL,0,4);
/*!40000 ALTER TABLE `house` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Year_BEFORE_INSERT` BEFORE INSERT ON `house` FOR EACH ROW BEGIN
	IF (NEW.Year_of_Construction > NOW()) OR (NEW.Year_of_Renovation > NOW()) OR (NEW.Year_of_Renovation < NEW.Year_of_Construction) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-House Table-Year Columns';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `House_Characteristics_BEFORE_INSERT` BEFORE INSERT ON `house` FOR EACH ROW BEGIN
	IF (NEW.Floor_Number < -1 ) OR (NEW.Rooms_Number <=0 ) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-House Table-Number Columns';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Energy_Class_BEFORE_INSERT` BEFORE INSERT ON `house` FOR EACH ROW BEGIN
	IF (NEW.Energy_Class >10) OR (NEW.Energy_Class <0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-House Table-Energy Class Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Year_BEFORE_UPDATE` BEFORE UPDATE ON `house` FOR EACH ROW BEGIN
	IF (NEW.Year_of_Construction > NOW()) OR (NEW.Year_of_Renovation > NOW()) OR (NEW.Year_of_Renovation < NEW.Year_of_Construction) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-House Table-Year Columns';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `House_Characteristics_BEFORE_UPDATE` BEFORE UPDATE ON `house` FOR EACH ROW BEGIN
	IF (NEW.Floor_Number < -1 ) OR (NEW.Rooms_Number <=0 ) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-House Table-Number Columns';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Energy_Class_BEFORE_UPDATE` BEFORE UPDATE ON `house` FOR EACH ROW BEGIN
	IF (NEW.Energy_Class >10) OR (NEW.Energy_Class <0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-House Table-Energy Class Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `land`
--

DROP TABLE IF EXISTS `land`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `land` (
  `Land_ID` int NOT NULL,
  `Coverage_Ratio` float DEFAULT NULL,
  `Building_Factor` float DEFAULT NULL,
  PRIMARY KEY (`Land_ID`),
  CONSTRAINT `LandID_Property` FOREIGN KEY (`Land_ID`) REFERENCES `property` (`Property_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `land`
--

LOCK TABLES `land` WRITE;
/*!40000 ALTER TABLE `land` DISABLE KEYS */;
INSERT INTO `land` VALUES (1,0.6,0.7),(3,0.4,0.7),(5,0.7,0.7),(7,0.2,0.7),(9,0.1,0.7),(11,0.6,0.7),(13,0.4,0.7),(15,0.7,0.7),(17,0.2,0.7),(19,0.1,0.7),(21,0.6,0.7),(23,0.4,0.7),(27,0.2,0.7),(29,0.1,0.7);
/*!40000 ALTER TABLE `land` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Land_BEFORE_INSERT` BEFORE INSERT ON `land` FOR EACH ROW BEGIN
	IF (NEW.Coverage_Ratio < 0) OR (NEW.Building_Factor <0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Land Table';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Land_BEFORE_UPDATE` BEFORE UPDATE ON `land` FOR EACH ROW BEGIN
	IF (NEW.Coverage_Ratio < 0) OR (NEW.Building_Factor <0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Land Table';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `landmark`
--

DROP TABLE IF EXISTS `landmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `landmark` (
  `Name` varchar(50) NOT NULL,
  `Address` varchar(50) NOT NULL,
  `Description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `landmark`
--

LOCK TABLES `landmark` WRITE;
/*!40000 ALTER TABLE `landmark` DISABLE KEYS */;
INSERT INTO `landmark` VALUES ('Auth','AUTH Camputs','The Aristotle University of Thessaloniki'),('IHU','14th km Thessaloniki, Nea Moudania 570 01','International Hellenic University'),('Ladadika','Polytechniou','LADADIKAAAA'),('Thessaloniki Concert Hall','25 Martiou','The Megaro Mousikis (where you take exams for lower and proficiency)'),('UoM','Egnatia 156','University of Macedonia'),('White Tower of Thessaloniki','Thessaloniki 546 21','A tower that is white and in Thessaloniki');
/*!40000 ALTER TABLE `landmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `Municipality` varchar(50) NOT NULL,
  `Area_Name` varchar(50) NOT NULL,
  `Green_Index` int DEFAULT NULL,
  `Air_Quality_Index` int DEFAULT NULL,
  `Population_Density` float DEFAULT NULL,
  PRIMARY KEY (`Municipality`,`Area_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES ('Kalamarias','Kalamaria',8,10,100.8),('Pilaias-Hortiati','Hortiatis',2,8,80.1),('Pilaias-Hortiati','Panorama',8,2,200.5),('Thermis','Triadi',9,6,100.1);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Green_Index_BEFORE_INSERT` BEFORE INSERT ON `location` FOR EACH ROW BEGIN
	IF (NEW.Green_Index <0) OR (NEW.Green_Index >10) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Location Table-Green Index Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Air_Quality_BEFORE_INSERT` BEFORE INSERT ON `location` FOR EACH ROW BEGIN
	IF (NEW.Air_Quality_Index <0) OR (NEW.Air_Quality_Index >10) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Location Table-Air Quality Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Population_Density_BEFORE_INSERT` BEFORE INSERT ON `location` FOR EACH ROW BEGIN
	IF (NEW.Population_Density <0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Location Table-Population Density Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Green_Index_BEFORE_UPDATE` BEFORE UPDATE ON `location` FOR EACH ROW BEGIN
	IF (NEW.Green_Index <0) OR (NEW.Green_Index >10) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Location Table-Green Index Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Air_Quality_BEFORE_UPDATE` BEFORE UPDATE ON `location` FOR EACH ROW BEGIN
	IF (NEW.Air_Quality_Index <0) OR (NEW.Air_Quality_Index >10) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Location Table-Air Quality Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Population_Density_BEFORE_UPDATE` BEFORE UPDATE ON `location` FOR EACH ROW BEGIN
	IF (NEW.Population_Density <0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Location Table-Population Density Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `Manager_ID` int NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Telephone` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Manager_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES (1,'giakoupg@ece.auth.gr','6988031719'),(2,'karakoul@ece.auth.gr','6978496539'),(3,'gdgkyzis@ece.auth.gr','6978722050'),(4,'phil@dunphy.com','6900000001'),(5,'superagency@gmail.com','6900000002'),(6,'gloria@hotmail.com','6900000003'),(7,'mesiths@gmail.com','6900000004'),(8,'mpamphs@hotmai.com','6900000005'),(9,'kyriakou@hotmail.com','6900000006'),(10,'mesitakos@gmail.com','6900000007'),(11,'random@gmail.com','6900000008'),(12,'random@gmail.com','6900000009'),(13,'random@gmail.com','6900000010'),(14,'random@gmail.com','6900000011'),(15,'random@gmail.com','6900000012'),(16,'random@gmail.com','6900000013'),(17,'random@gmail.com','6900000014'),(18,'random@gmail.com','6900000015'),(19,'random@gmail.com','6900000016'),(20,'random@gmail.com','6900000017');
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Manager_BEFORE_INSERT` BEFORE INSERT ON `manager` FOR EACH ROW BEGIN
	IF NEW.Email NOT LIKE '%@%' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Manager Table-Email Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Manager_BEFORE_UPDATE` BEFORE UPDATE ON `manager` FOR EACH ROW BEGIN
	IF NEW.Email NOT LIKE '%@%' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Manager Table-Email Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `owner`
--

DROP TABLE IF EXISTS `owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `owner` (
  `Owner_ID` int NOT NULL,
  `Fullname` varchar(50) NOT NULL,
  PRIMARY KEY (`Owner_ID`),
  CONSTRAINT `OwnerID_Manager` FOREIGN KEY (`Owner_ID`) REFERENCES `manager` (`Manager_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owner`
--

LOCK TABLES `owner` WRITE;
/*!40000 ALTER TABLE `owner` DISABLE KEYS */;
INSERT INTO `owner` VALUES (1,'Paschalis Giakoumoglou'),(3,'Anastasios Karakoulakis'),(5,'Gkyzis Georgios'),(7,'Mpampis Mpampidis'),(9,'Paraskevi Kyriakou'),(11,'Gkyzis Georgios'),(13,'Gkyzis Georgios'),(15,'Gkyzis Georgios'),(17,'Paschalis Giakoumoglou'),(19,'Anastasios Karakoulakis');
/*!40000 ALTER TABLE `owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property`
--

DROP TABLE IF EXISTS `property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property` (
  `Property_ID` int NOT NULL,
  `Manager_ID` int NOT NULL,
  `Square_Meters` int DEFAULT NULL,
  `Property_Value` int DEFAULT NULL,
  `Description` varchar(1000) DEFAULT NULL,
  `Publish_Date` date DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `Postal_Code` varchar(5) DEFAULT NULL,
  `Municipality` varchar(50) NOT NULL,
  `Area_Name` varchar(50) NOT NULL,
  `Value_per_Square_Meter` float GENERATED ALWAYS AS ((`Property_Value` / `Square_Meters`)) VIRTUAL,
  PRIMARY KEY (`Property_ID`),
  KEY `ManagerID_idx` (`Manager_ID`),
  KEY `Municipality&Area_Name_idx` (`Municipality`,`Area_Name`),
  CONSTRAINT `ManagerID_Property` FOREIGN KEY (`Manager_ID`) REFERENCES `manager` (`Manager_ID`),
  CONSTRAINT `Municipality&Area_Name_Property` FOREIGN KEY (`Municipality`, `Area_Name`) REFERENCES `location` (`Municipality`, `Area_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property`
--

LOCK TABLES `property` WRITE;
/*!40000 ALTER TABLE `property` DISABLE KEYS */;
INSERT INTO `property` (`Property_ID`, `Manager_ID`, `Square_Meters`, `Property_Value`, `Description`, `Publish_Date`, `Address`, `Postal_Code`, `Municipality`, `Area_Name`) VALUES (1,1,45,50000,'Big Apartment','2023-11-19','Martiou 20','55236','Pilaias-Hortiati','Panorama'),(3,3,30,30000,'Jakuzi not for sale','2023-11-19','Martiou 40','55236','Thermis','Triadi'),(4,4,60,70000,'Price not regociated','2023-11-19','Martiou 50','55236','Pilaias-Hortiati','Hortiatis'),(5,5,25,20000,'2 rooms','2023-11-19','Martiou 60','55237','Kalamarias','Kalamaria'),(6,6,30,30000,'Jakuzi not for sale','2023-11-19','Martiou 40','55236','Thermis','Triadi'),(7,7,60,70000,'Price not regociated','2023-11-19','Martiou 50','55236','Pilaias-Hortiati','Hortiatis'),(8,8,25,20000,'2 rooms','2023-11-19','Martiou 60','55237','Kalamarias','Kalamaria'),(9,9,30,30000,'Jakuzi not for sale','2023-11-19','Martiou 40','55236','Thermis','Triadi'),(10,10,60,70000,'Price not regociated','2023-11-19','Martiou 50','55236','Pilaias-Hortiati','Hortiatis'),(11,11,25,20000,'2 rooms','2023-11-19','Martiou 60','55237','Kalamarias','Kalamaria'),(12,12,25,20000,'Random Description','2023-11-18','Martiou 20','55237','Kalamarias','Kalamaria'),(13,13,25,20000,'Random Description','2023-11-17','Martiou 30','55237','Pilaias-Hortiati','Panorama'),(14,14,25,20000,'Random Description','2023-11-16','Martiou 40','55237','Pilaias-Hortiati','Panorama'),(15,6,25,20000,'Random Description','2023-11-15','Martiou 50','55237','Thermis','Triadi'),(16,16,25,20000,'Random Description','2023-11-14','Martiou 60','55237','Kalamarias','Kalamaria'),(17,4,25,20000,'Random Description','2023-11-13','Martiou 40','55237','Thermis','Triadi'),(18,18,25,20000,'Random Description','2023-11-12','Martiou 50','55237','Pilaias-Hortiati','Panorama'),(19,2,25,20000,'Random Description','2021-11-11','Martiou 60','55237','Pilaias-Hortiati','Hortiatis'),(20,1,25,20000,'Random Description','2023-11-10','Martiou 40','55237','Thermis','Triadi'),(21,2,25,20000,'Random Description','2023-11-09','Martiou 50','55237','Thermis','Triadi'),(22,3,25,20000,'Random Description','2023-11-08','Martiou 60','55237','Kalamarias','Kalamaria'),(23,4,60,30000,'Random Description','2020-11-07','Martiou 20','55237','Thermis','Triadi'),(24,2,60,30000,'Random Description','2021-11-06','Martiou 30','55237','Pilaias-Hortiati','Panorama'),(26,11,55,30000,'Random Description','2023-11-04','Martiou 50','55237','Thermis','Triadi'),(27,12,55,30000,'Random Description','2021-11-03','Martiou 60','55237','Kalamarias','Kalamaria'),(28,13,55,30000,'Random Description','2018-11-02','Martiou 40','55237','Pilaias-Hortiati','Panorama'),(29,1,55,30000,'Random Description','2019-11-01','Martiou 50','55237','Kalamarias','Kalamaria');
/*!40000 ALTER TABLE `property` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Square_Meters_Value_BEFORE_INSERT` BEFORE INSERT ON `property` FOR EACH ROW BEGIN
	IF (NEW.Square_Meters <=0) OR (NEW.Property_Value <0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Property Table-Property Specs Column';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Publish_Date_BEFORE_INSERT` BEFORE INSERT ON `property` FOR EACH ROW BEGIN
	IF (NEW.Publish_Date > NOW()) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Property Table-Publish Date Column';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Square_Meters_Value_BEFORE_UPDATE` BEFORE UPDATE ON `property` FOR EACH ROW BEGIN
	IF (NEW.Square_Meters <=0) OR (NEW.Property_Value <0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Property Table-Property Specs Column';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Publish_Date_BEFORE_UPDATE` BEFORE UPDATE ON `property` FOR EACH ROW BEGIN
	IF (NEW.Publish_Date > NOW()) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Property Table-Publish Date Column';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `real_estate_agency`
--

DROP TABLE IF EXISTS `real_estate_agency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `real_estate_agency` (
  `Agency_ID` int NOT NULL,
  `Agency_Name` varchar(50) NOT NULL,
  `Address` varchar(50) NOT NULL,
  `Commission_Rate` float DEFAULT NULL,
  `Logo` varchar(50) DEFAULT NULL,
  `Website` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Agency_ID`),
  CONSTRAINT `AgencyID_Property` FOREIGN KEY (`Agency_ID`) REFERENCES `manager` (`Manager_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `real_estate_agency`
--

LOCK TABLES `real_estate_agency` WRITE;
/*!40000 ALTER TABLE `real_estate_agency` DISABLE KEYS */;
INSERT INTO `real_estate_agency` VALUES (2,'Phil Dunphy and Co','random address1',0.05,'logo1.png','www.phildunphy.com'),(4,'Super_Agency','random address2',0.06,'logo2.png','www.superagency.com'),(6,'Gloria Delgado','random address3',0.1,'logo3.png','gwww.loriarealestate.com'),(8,'O Mesiths','random address4',0.02,'logo4.png','www.mesiths.com'),(10,'Mesitakos','random address 5',0.03,'logo5.png','www.mesitakos.com'),(12,'RandomName1','random address 6',0.04,'logo5.png','www.mesitakos.com'),(14,'RandomName2','random address 7',0.05,'logo5.png','www.mesitakos.com'),(16,'RandomName3','random address 8',0.06,'logo5.png','www.mesitakos.com'),(18,'RandomName4','random address 9',0.07,'logo5.png','www.mesitakos.com'),(20,'RandomName5','random address 10',0.08,'logo5.png','www.mesitakos.com');
/*!40000 ALTER TABLE `real_estate_agency` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Commission_Rate_BEFORE_INSERT` BEFORE INSERT ON `real_estate_agency` FOR EACH ROW BEGIN
	IF (NEW.Commission_Rate < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Real Estate Agency Table-Commission Rate Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Website_BEFORE_INSERT` BEFORE INSERT ON `real_estate_agency` FOR EACH ROW BEGIN
	IF (NEW.Website NOT LIKE '%www%') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Real Estate Agency Table-Website Column';
    END IF;    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Commission_Rate_Agency_BEFORE_UPDATE` BEFORE UPDATE ON `real_estate_agency` FOR EACH ROW BEGIN
	IF (NEW.Commission_Rate < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Real Estate Agency Table-Commission Rate Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Website_BEFORE_UPDATE` BEFORE UPDATE ON `real_estate_agency` FOR EACH ROW BEGIN
	IF (NEW.Website NOT LIKE '%www%') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Real Estate Agency Table-Website Column';
    END IF;  
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `service_provider_details`
--

DROP TABLE IF EXISTS `service_provider_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_provider_details` (
  `Service_Provider_ID` int NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Address` varchar(50) NOT NULL,
  `Website` varchar(50) DEFAULT NULL,
  `Telephone` varchar(10) DEFAULT NULL,
  `Logo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Service_Provider_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_provider_details`
--

LOCK TABLES `service_provider_details` WRITE;
/*!40000 ALTER TABLE `service_provider_details` DISABLE KEYS */;
INSERT INTO `service_provider_details` VALUES (1,'Metafero','Aristotle University of Thessaloniki','www.example.gr','2310333333','logo.jpeg'),(2,'Anakainizo','Aristotle University of Thessaloniki','www.example.gr','2310332333','logo.jpeg'),(3,'IKEA','Aristotle University of Thessaloniki','www.example.gr','2310335333','logo.jpeg'),(4,'Shediazo','Aristotle University of Thessaloniki','www.example.gr','2310336333','logo.jpeg'),(5,'Kipouros','Aristotle University of Thessaloniki','www.example.gr','2310337333','logo.jpeg'),(6,'Name','Aristotle University of Thessaloniki','www.example.gr','2310338533','logo.jpeg'),(7,'Metafero','Aristotle University of Thessaloniki','www.example.gr','2310339733','logo.jpeg'),(8,'Anakainizo','Aristotle University of Thessaloniki','www.example.gr','2310340933','logo.jpeg'),(9,'IKEA','Aristotle University of Thessaloniki','www.example.gr','2310342133','logo.jpeg'),(10,'Shediazo','Aristotle University of Thessaloniki','www.example.gr','2310343333','logo.jpeg'),(11,'Kipouros','Aristotle University of Thessaloniki','www.example.gr','2310344533','logo.jpeg'),(12,'Name','Aristotle University of Thessaloniki','www.example.gr','2310345733','logo.jpeg'),(13,'Metafero','Aristotle University of Thessaloniki','www.example.gr','2310346933','logo.jpeg'),(14,'Anakainizo','Aristotle University of Thessaloniki','www.example.gr','2310348133','logo.jpeg'),(15,'IKEA','Aristotle University of Thessaloniki','www.example.gr','2310349333','logo.jpeg');
/*!40000 ALTER TABLE `service_provider_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Service_Provider_Details_BEFORE_INSERT` BEFORE INSERT ON `service_provider_details` FOR EACH ROW BEGIN
	IF NEW.Website NOT LIKE '%www%' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Service Provider Details-Website Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Service_Provider_Details_BEFORE_UPDATE` BEFORE UPDATE ON `service_provider_details` FOR EACH ROW BEGIN
	IF NEW.Website NOT LIKE '%www%' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Service Provider Details-Website Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `service_provider_pricing`
--

DROP TABLE IF EXISTS `service_provider_pricing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_provider_pricing` (
  `Service_Provider_ID` int NOT NULL,
  `Type_of_Service` enum('Painting','Renovation','Moving','Constructions') NOT NULL,
  `Mean_Price` float DEFAULT NULL,
  PRIMARY KEY (`Service_Provider_ID`,`Type_of_Service`),
  CONSTRAINT `Service_ProviderID_Pricing` FOREIGN KEY (`Service_Provider_ID`) REFERENCES `service_provider_details` (`Service_Provider_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_provider_pricing`
--

LOCK TABLES `service_provider_pricing` WRITE;
/*!40000 ALTER TABLE `service_provider_pricing` DISABLE KEYS */;
INSERT INTO `service_provider_pricing` VALUES (1,'Painting',300),(1,'Renovation',30),(2,'Renovation',4000),(2,'Moving',1000),(3,'Renovation',4000),(3,'Moving',30),(4,'Renovation',1000),(4,'Moving',1000),(5,'Moving',50),(5,'Constructions',50),(6,'Renovation',1000),(7,'Moving',50),(8,'Renovation',30),(9,'Constructions',1000),(10,'Renovation',4000),(11,'Renovation',1000),(12,'Moving',50),(13,'Renovation',4000),(14,'Constructions',1000),(15,'Renovation',50);
/*!40000 ALTER TABLE `service_provider_pricing` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Service_Provider_Pricing_BEFORE_INSERT` BEFORE INSERT ON `service_provider_pricing` FOR EACH ROW BEGIN
	IF (NEW.Mean_Price<0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Service Provider Pricing Table-Mean Price Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Service_Provider_Pricing_BEFORE_UPDATE` BEFORE UPDATE ON `service_provider_pricing` FOR EACH ROW BEGIN
	IF (NEW.Mean_Price<0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-Service Provider Pricing Table-Mean Price Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `User_ID` int NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Telephone` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`User_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'giakoup_1','giakoupg1@gmail.com','6978496555'),(2,'giakoup_2','giakoupg2@gmail.com','6978496554'),(3,'giakoup_3','giakoupg3@gmail.com','6978496553'),(4,'giakoup_4','giakoupg4@gmail.com','6978496552'),(5,'giakoup_5','giakoupg5@gmail.com','6978496551'),(6,'giakoup_6','giakoupg1@gmail.com','6978496550'),(7,'giakoup_7','giakoupg2@gmail.com','6978496549'),(8,'giakoup_8','giakoupg3@gmail.com','6978496548'),(9,'giakoup_9','giakoupg4@gmail.com','6978496547'),(10,'giakoup_10','giakoupg5@gmail.com','6978496546'),(11,'giakoup_11','giakoupg1@gmail.com','6978496545'),(12,'giakoup_12','giakoupg2@gmail.com','6978496544'),(13,'giakoup_13','giakoupg3@gmail.com','6978496543'),(14,'giakoup_14','giakoupg4@gmail.com','6978496542'),(15,'giakoup_15','giakoupg5@gmail.com','6978496541'),(16,'giakoup_16','giakoupg1@gmail.com','6978496540'),(17,'giakoup_17','giakoupg2@gmail.com','6978496539'),(18,'giakoup_18','giakoupg3@gmail.com','6978496538'),(19,'giakoup_19','giakoupg4@gmail.com','6978496537'),(20,'giakoup_20','giakoupg5@gmail.com','6978496536'),(21,'giakoup_21','giakoupg1@gmail.com','6978496535'),(22,'giakoup_22','giakoupg2@gmail.com','6978496534'),(23,'giakoup_23','giakoupg3@gmail.com','6978496533'),(24,'giakoup_24','giakoupg4@gmail.com','6978496532');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `User_BEFORE_INSERT` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
	IF NEW.Email NOT LIKE '%@%' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-User Table-Email Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `User_BEFORE_UPDATE` BEFORE UPDATE ON `user` FOR EACH ROW BEGIN
	IF NEW.Email NOT LIKE '%@%' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "INVALID INPUT DATA-User Table-Email Column";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_reviews_manager`
--

DROP TABLE IF EXISTS `user_reviews_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_reviews_manager` (
  `User_ID` int NOT NULL,
  `Manager_ID` int NOT NULL,
  `Rating` int NOT NULL,
  `Comment` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`User_ID`,`Manager_ID`),
  KEY `ManagerID_idx` (`Manager_ID`),
  CONSTRAINT `ManagerID_Reviews` FOREIGN KEY (`Manager_ID`) REFERENCES `manager` (`Manager_ID`),
  CONSTRAINT `UserID_Reviews_Manager` FOREIGN KEY (`User_ID`) REFERENCES `user` (`User_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_reviews_manager`
--

LOCK TABLES `user_reviews_manager` WRITE;
/*!40000 ALTER TABLE `user_reviews_manager` DISABLE KEYS */;
INSERT INTO `user_reviews_manager` VALUES (1,1,4,'Best'),(1,4,8,'No comment.'),(1,7,2,'Not good'),(1,10,3,'Not good'),(1,18,9,'No comment.'),(2,2,5,'Very good'),(2,3,7,'Really good'),(2,4,8,'Good'),(2,8,4,'Really good'),(2,17,6,'No comment.'),(3,1,3,'Not good'),(3,4,9,'Very cooperative'),(3,5,5,'Really good'),(4,3,4,'Not very polite'),(4,5,2,'Not good'),(4,6,1,'Not good'),(4,20,7,'No comment.'),(5,5,5,'Really good'),(6,1,5,'Really good'),(6,3,9,'Really good'),(6,19,3,'No comment.'),(7,2,6,'Really good'),(7,15,9,'No comment.'),(7,16,8,'No comment.'),(8,1,7,'Really good'),(11,1,2,'Not good'),(11,13,3,'No comment.'),(12,2,6,'Really good'),(12,5,9,'Really good'),(12,12,5,'No comment.'),(13,1,3,'Not good'),(16,5,9,'Really good'),(17,5,10,'Really good'),(19,5,7,'Really good'),(20,9,5,'Really good'),(22,10,9,'Really good'),(23,5,9,'Really good'),(24,4,9,'No comment.');
/*!40000 ALTER TABLE `user_reviews_manager` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `User_Reviews_Manager_BEFORE_INSERT` BEFORE INSERT ON `user_reviews_manager` FOR EACH ROW BEGIN
	IF (NEW.Rating <0) OR (NEW.Rating >10) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-User Reviews Manager Table-Rating Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `User_Reviews_Manager_BEFORE_UPDATE` BEFORE UPDATE ON `user_reviews_manager` FOR EACH ROW BEGIN
	IF (NEW.Rating <0) OR (NEW.Rating >10) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-User Reviews Manager Table-Rating Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_reviews_service_provider`
--

DROP TABLE IF EXISTS `user_reviews_service_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_reviews_service_provider` (
  `User_ID` int NOT NULL,
  `Service_Provider_ID` int NOT NULL,
  `Rating` int NOT NULL,
  `Comment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`User_ID`,`Service_Provider_ID`),
  KEY `Service_ProviderID_idx` (`Service_Provider_ID`),
  CONSTRAINT `Service_ProviderID_Reviews` FOREIGN KEY (`Service_Provider_ID`) REFERENCES `service_provider_details` (`Service_Provider_ID`),
  CONSTRAINT `UserID_Reviews_Service_Provider` FOREIGN KEY (`User_ID`) REFERENCES `user` (`User_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_reviews_service_provider`
--

LOCK TABLES `user_reviews_service_provider` WRITE;
/*!40000 ALTER TABLE `user_reviews_service_provider` DISABLE KEYS */;
INSERT INTO `user_reviews_service_provider` VALUES (1,1,4,'Best'),(1,4,8,'No comment.'),(1,7,8,'Good but expensive'),(1,8,9,'No comment.'),(1,9,8,'No comment.'),(2,1,9,'Very good'),(2,4,7,'Very good.'),(2,11,6,'No comment.'),(3,2,3,'Good but expensive'),(3,3,7,'Good but expensive'),(3,8,10,'Good but expensive'),(4,3,4,'Good but expensive'),(4,5,6,'Best'),(4,14,7,'No comment.'),(5,3,3,'Good but expensive'),(5,4,8,'One of the best.'),(5,6,7,'Very good'),(6,15,3,'No comment.'),(7,12,8,'No comment.'),(7,13,9,'No comment.'),(11,13,3,'No comment.'),(12,12,5,'No comment.'),(13,3,2,'Good but expensive'),(15,1,3,'Best'),(20,2,6,'Very good'),(24,4,9,'No comment.'),(24,10,9,'No comment.');
/*!40000 ALTER TABLE `user_reviews_service_provider` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `User_Reviews_Service_Provider_BEFORE_INSERT` BEFORE INSERT ON `user_reviews_service_provider` FOR EACH ROW BEGIN
	IF (NEW.Rating <0) OR (NEW.Rating >10) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-User Reviews Service Provider Table-Rating Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `User_Reviews_Service_Provider_BEFORE_UPDATE` BEFORE UPDATE ON `user_reviews_service_provider` FOR EACH ROW BEGIN
	IF (NEW.Rating <0) OR (NEW.Rating >10) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INVALID INPUT DATA-User Reviews Service Provider Table-Rating Column';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `view1`
--

DROP TABLE IF EXISTS `view1`;
/*!50001 DROP VIEW IF EXISTS `view1`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view1` AS SELECT 
 1 AS `Manager_ID`,
 1 AS `Email`,
 1 AS `Telephone`,
 1 AS `Average_Rating`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view2`
--

DROP TABLE IF EXISTS `view2`;
/*!50001 DROP VIEW IF EXISTS `view2`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view2` AS SELECT 
 1 AS `Service_Provider_ID`,
 1 AS `Name`,
 1 AS `Address`,
 1 AS `Website`,
 1 AS `Telephone`,
 1 AS `Average_Rating`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view3`
--

DROP TABLE IF EXISTS `view3`;
/*!50001 DROP VIEW IF EXISTS `view3`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view3` AS SELECT 
 1 AS `Property_ID`,
 1 AS `Municipality`,
 1 AS `Area_Name`,
 1 AS `Green_Index`,
 1 AS `Air_Quality_Index`,
 1 AS `Population_Density`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view4`
--

DROP TABLE IF EXISTS `view4`;
/*!50001 DROP VIEW IF EXISTS `view4`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view4` AS SELECT 
 1 AS `Service_Provider_ID`,
 1 AS `Type_of_Service`,
 1 AS `Mean_Price`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view5`
--

DROP TABLE IF EXISTS `view5`;
/*!50001 DROP VIEW IF EXISTS `view5`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view5` AS SELECT 
 1 AS `Service_Provider_ID`,
 1 AS `Type_Count`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view6`
--

DROP TABLE IF EXISTS `view6`;
/*!50001 DROP VIEW IF EXISTS `view6`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view6` AS SELECT 
 1 AS `Property_ID`,
 1 AS `Municipality`,
 1 AS `Area_Name`,
 1 AS `Green_Index`,
 1 AS `Air_Quality_Index`,
 1 AS `Population_Density`,
 1 AS `Landmark_Name`,
 1 AS `Distance`,
 1 AS `Travel_Time_Bus`,
 1 AS `Travel_Time_Car`,
 1 AS `Travel_Time_Walk`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `view1`
--

/*!50001 DROP VIEW IF EXISTS `view1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view1` AS select `m`.`Manager_ID` AS `Manager_ID`,`m`.`Email` AS `Email`,`m`.`Telephone` AS `Telephone`,coalesce(`u`.`Average_Rating`,'No reviews') AS `Average_Rating` from (`manager` `m` left join (select `user_reviews_manager`.`Manager_ID` AS `Manager_ID`,avg(`user_reviews_manager`.`Rating`) AS `Average_Rating` from `user_reviews_manager` group by `user_reviews_manager`.`Manager_ID`) `u` on((`m`.`Manager_ID` = `u`.`Manager_ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view2`
--

/*!50001 DROP VIEW IF EXISTS `view2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view2` AS select `s`.`Service_Provider_ID` AS `Service_Provider_ID`,`s`.`Name` AS `Name`,`s`.`Address` AS `Address`,`s`.`Website` AS `Website`,`s`.`Telephone` AS `Telephone`,coalesce(`r`.`Average_Rating`,'No reviews') AS `Average_Rating` from (`service_provider_details` `s` left join (select `user_reviews_service_provider`.`Service_Provider_ID` AS `Service_Provider_ID`,avg(`user_reviews_service_provider`.`Rating`) AS `Average_Rating` from `user_reviews_service_provider` group by `user_reviews_service_provider`.`Service_Provider_ID`) `r` on((`s`.`Service_Provider_ID` = `r`.`Service_Provider_ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view3`
--

/*!50001 DROP VIEW IF EXISTS `view3`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view3` AS select `property`.`Property_ID` AS `Property_ID`,`property`.`Municipality` AS `Municipality`,`property`.`Area_Name` AS `Area_Name`,`location`.`Green_Index` AS `Green_Index`,`location`.`Air_Quality_Index` AS `Air_Quality_Index`,`location`.`Population_Density` AS `Population_Density` from (`property` join `location` on(((`property`.`Municipality` = `location`.`Municipality`) and (`property`.`Area_Name` = `location`.`Area_Name`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view4`
--

/*!50001 DROP VIEW IF EXISTS `view4`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view4` AS with `cheapest_prices` as (select `service_provider_pricing`.`Type_of_Service` AS `Type_of_Service`,min(`service_provider_pricing`.`Mean_Price`) AS `Min_Price` from `service_provider_pricing` group by `service_provider_pricing`.`Type_of_Service`), `cheapest_providers` as (select `sp`.`Service_Provider_ID` AS `Service_Provider_ID`,`sp`.`Type_of_Service` AS `Type_of_Service` from (`service_provider_pricing` `sp` join `cheapest_prices` `cp` on(((`sp`.`Type_of_Service` = `cp`.`Type_of_Service`) and (`sp`.`Mean_Price` = `cp`.`Min_Price`))))) select `cp`.`Service_Provider_ID` AS `Service_Provider_ID`,`cp`.`Type_of_Service` AS `Type_of_Service`,`sp`.`Mean_Price` AS `Mean_Price` from (`cheapest_providers` `cp` join `service_provider_pricing` `sp` on(((`cp`.`Service_Provider_ID` = `sp`.`Service_Provider_ID`) and (`cp`.`Type_of_Service` = `sp`.`Type_of_Service`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view5`
--

/*!50001 DROP VIEW IF EXISTS `view5`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view5` AS with `provider_types_count` as (select `service_provider_pricing`.`Service_Provider_ID` AS `Service_Provider_ID`,count(0) AS `Type_Count` from `service_provider_pricing` group by `service_provider_pricing`.`Service_Provider_ID`), `provider_with_many_services` as (select `provider_types_count`.`Service_Provider_ID` AS `Service_Provider_ID`,`provider_types_count`.`Type_Count` AS `Type_Count` from `provider_types_count` where (`provider_types_count`.`Type_Count` >= 2)) select `provider_with_many_services`.`Service_Provider_ID` AS `Service_Provider_ID`,`provider_with_many_services`.`Type_Count` AS `Type_Count` from `provider_with_many_services` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view6`
--

/*!50001 DROP VIEW IF EXISTS `view6`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view6` AS select `property`.`Property_ID` AS `Property_ID`,`property`.`Municipality` AS `Municipality`,`property`.`Area_Name` AS `Area_Name`,`location`.`Green_Index` AS `Green_Index`,`location`.`Air_Quality_Index` AS `Air_Quality_Index`,`location`.`Population_Density` AS `Population_Density`,`distance`.`Landmark_Name` AS `Landmark_Name`,`distance`.`Distance` AS `Distance`,`distance`.`Travel_Time_Bus` AS `Travel_Time_Bus`,`distance`.`Travel_Time_Car` AS `Travel_Time_Car`,`distance`.`Travel_Time_Walk` AS `Travel_Time_Walk` from ((`property` join `location` on(((`property`.`Municipality` = `location`.`Municipality`) and (`property`.`Area_Name` = `location`.`Area_Name`)))) join `distance` on(((`location`.`Municipality` = `distance`.`Municipality`) and (`location`.`Area_Name` = `distance`.`Area_Name`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-20 11:26:13
