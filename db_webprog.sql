CREATE DATABASE  IF NOT EXISTS `db_webprog` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_webprog`;
-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: db_webprog
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `account_has_user`
--

DROP TABLE IF EXISTS `account_has_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_has_user` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `mysql_user_name` char(6) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `users_ID` int DEFAULT NULL,
  `signedIn` tinyint GENERATED ALWAYS AS ((`users_ID` is not null)) VIRTUAL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `mysql_user_name_UNIQUE` (`mysql_user_name`),
  UNIQUE KEY `users_ID_UNIQUE` (`users_ID`),
  CONSTRAINT `FK_account_has_user2user` FOREIGN KEY (`users_ID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_has_user`
--

LOCK TABLES `account_has_user` WRITE;
/*!40000 ALTER TABLE `account_has_user` DISABLE KEYS */;
INSERT INTO `account_has_user` (`ID`, `mysql_user_name`, `users_ID`) VALUES (1,'user01',NULL),(2,'user02',NULL),(3,'user03',NULL),(4,'user04',NULL),(5,'user05',NULL),(6,'user06',NULL),(7,'user07',NULL),(8,'user08',NULL),(9,'user09',NULL),(10,'user10',NULL),(11,'user11',NULL),(12,'user12',NULL),(13,'user13',NULL),(14,'user14',NULL),(15,'user15',NULL),(16,'user16',NULL),(17,'user17',NULL),(18,'user18',NULL),(19,'user19',NULL),(20,'user20',NULL),(21,'user21',NULL),(22,'user22',NULL),(23,'user23',NULL),(24,'user24',NULL),(25,'user25',NULL),(26,'user26',NULL),(27,'user27',NULL),(28,'user28',NULL),(29,'user29',NULL),(30,'user30',NULL),(31,'user31',NULL);
/*!40000 ALTER TABLE `account_has_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channels`
--

DROP TABLE IF EXISTS `channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channels` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_hungarian_ci DEFAULT NULL,
  `player_1_ID` int DEFAULT NULL,
  `player_2_ID` int DEFAULT NULL,
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL DEFAULT 'e',
  PRIMARY KEY (`Id`),
  KEY `FK_channels2status` (`status`),
  KEY `FK_channels2user_1_idx` (`player_1_ID`),
  KEY `FK_channels2user_2_idx` (`player_2_ID`),
  CONSTRAINT `FK_channels2status` FOREIGN KEY (`status`) REFERENCES `status` (`ID`),
  CONSTRAINT `FK_channels2user_1` FOREIGN KEY (`player_1_ID`) REFERENCES `users` (`ID`),
  CONSTRAINT `FK_channels2user_2` FOREIGN KEY (`player_2_ID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channels`
--

LOCK TABLES `channels` WRITE;
/*!40000 ALTER TABLE `channels` DISABLE KEYS */;
INSERT INTO `channels` VALUES (1,NULL,NULL,NULL,'e'),(2,NULL,NULL,NULL,'e'),(3,NULL,NULL,NULL,'e'),(4,NULL,NULL,NULL,'e'),(5,NULL,NULL,NULL,'e'),(6,NULL,NULL,NULL,'e'),(7,NULL,NULL,NULL,'e'),(8,NULL,NULL,NULL,'e'),(9,NULL,NULL,NULL,'e'),(10,NULL,NULL,NULL,'e'),(11,NULL,NULL,NULL,'e'),(12,NULL,NULL,NULL,'e'),(13,NULL,NULL,NULL,'e'),(14,NULL,NULL,NULL,'e'),(15,NULL,NULL,NULL,'e'),(16,NULL,NULL,NULL,'e'),(17,NULL,NULL,NULL,'e'),(18,NULL,NULL,NULL,'e'),(19,NULL,NULL,NULL,'e'),(20,NULL,NULL,NULL,'e'),(21,NULL,NULL,NULL,'e'),(22,NULL,NULL,NULL,'e'),(23,NULL,NULL,NULL,'e'),(24,NULL,NULL,NULL,'e'),(25,NULL,NULL,NULL,'e'),(26,NULL,NULL,NULL,'e'),(27,NULL,NULL,NULL,'e'),(28,NULL,NULL,NULL,'e'),(29,NULL,NULL,NULL,'e'),(30,NULL,NULL,NULL,'e'),(31,NULL,NULL,NULL,'e');
/*!40000 ALTER TABLE `channels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `ID` char(1) CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES ('e','empty'),('s','satured'),('u','unsatured');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL,
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL,
  `Email` varchar(255) CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL,
  `points` int NOT NULL DEFAULT '0',
  `win` int NOT NULL DEFAULT '0',
  `lose` int NOT NULL DEFAULT '0',
  `passWord` varchar(255) CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (10,'Gál Zalán','gZaza99','zalan.gal.99@gmail.com',0,0,0,'*2A0F391CA7ADBA898ECC688F059A59972C20C0F7');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_webprog'
--
/*!50003 DROP FUNCTION IF EXISTS `CodePassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CodePassword`(`p_uncoded` VARCHAR(20)) RETURNS varchar(255) CHARSET utf8mb4 COLLATE utf8mb4_hungarian_ci
    DETERMINISTIC
BEGIN
    DECLARE `coded` VARCHAR(255) DEFAULT NULL;
    SET `coded` = CONCAT('*',UPPER(SHA1(UNHEX(SHA1(`p_uncoded`)))));
    RETURN `coded`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `JoinChannel` */;
ALTER DATABASE `db_webprog` CHARACTER SET utf8mb3 COLLATE utf8_hungarian_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `JoinChannel`(IN `ch_Id` INT, 
                                IN `pl_Id` INT )
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    	ROLLBACK;
    END;
	START TRANSACTION;
    
    UPDATE `channels`
    SET `player_2_ID` = pl_Id,
    	`status` = 's'
    WHERE `Id` = ch_Id;
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `db_webprog` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `LeaveChannel` */;
ALTER DATABASE `db_webprog` CHARACTER SET utf8mb3 COLLATE utf8_hungarian_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `LeaveChannel`(IN `ch_Id` INT, 
                                 IN `pl_Id` INT )
BEGIN
    DECLARE `p1` INT;
    DECLARE `p2` INT;
    DECLARE `stat` CHAR;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    	ROLLBACK;
    END;
	START TRANSACTION;
    
    SELECT `player_1_ID` 
    INTO `p1` 
    FROM `channels` 
    WHERE `Id` = `ch_Id`;
    
    SELECT `player_2_ID` 
    INTO `p2` 
    FROM `channels` 
    WHERE `Id` = `ch_Id`;
    
    SELECT `status` 
    INTO `stat` 
    FROM `channels` 
    WHERE `Id` = `ch_Id`;
    
    IF `pl_Id` = `p2` THEN
    	UPDATE `channels` 
        SET `player_2_ID` = NULL,
            `status` = 'u'
        WHERE `Id` = `ch_Id`;
    ELSEIF `pl_Id` = `p1` THEN
    	IF `stat` = 'u' THEN
        	UPDATE `channels` 
        	SET `player_1_ID` = NULL,
            	`name` = NULL,
        	    `status` = 'e'
        	WHERE `Id` = `ch_Id`;
        ELSEIF `stat` = 's' THEN
        	UPDATE `channels` 
        	SET `player_1_ID` = `p2`,
            	`player_2_ID` = NULL,
        	    `status` = 'u'
        	WHERE `Id` = `ch_Id`;
        END IF;
    END IF;
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `db_webprog` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `Login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Login`(IN  `p_usrName` VARCHAR(30), 
                               IN  `p_pwd`     VARCHAR(20), 
                               OUT `p_result`  BOOLEAN     )
BEGIN
	DECLARE `pwd` VARCHAR(255) DEFAULT NULL;
    DECLARE `userID` VARCHAR(30);
    SELECT `passWord` INTO `pwd` FROM `users` WHERE `username` = `p_usrName`;
    IF (`pwd` = CodePassword(`p_pwd`) ) THEN
        SET `p_result` = TRUE;
        
        SELECT `ID` INTO `userID` FROM `users` WHERE `username` = `p_usrName`;
		UPDATE `account_has_user` SET `users_ID` = `userID` WHERE `signedIn` = FALSE LIMIT 1;
	ELSE
        SET `p_result` = FALSE;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Logout` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Logout`(IN  `p_usrName` VARCHAR(30))
BEGIN
    DECLARE `userID` VARCHAR(30);
    
    SELECT `ID` INTO `userID` FROM `users` WHERE `username` = `p_usrName`;
    UPDATE `account_has_user` SET `users_ID` = NULL WHERE `users_ID` = `userID`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `OpenChannel` */;
ALTER DATABASE `db_webprog` CHARACTER SET utf8mb3 COLLATE utf8_hungarian_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OpenChannel`(IN `pl_Id`   INT, 
                                IN `ch_name` VARCHAR(64))
BEGIN
    DECLARE ch_Id INT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    	ROLLBACK;
    END;
	START TRANSACTION;

	SELECT `Id`
    INTO ch_Id
	FROM `channels`
	WHERE `status` = 'e'
	LIMIT 1;
    
    IF ch_Id IS NOT NULL THEN
    	UPDATE `channels`
    	SET `player_1_ID` = pl_Id,
    		`status` = 'u',
    	    `name` = ch_name
    	WHERE `channels`.`Id` = ch_Id;
    ELSE
    	INSERT INTO `channels`(`name`, `player_1_ID`, `status`)
    	VALUES (ch_name, pl_Id, 'u');
    END IF;
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `db_webprog` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `Register` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Register`(IN  `p_email`   VARCHAR(255),
                                                       IN  `p_name`    VARCHAR(50), 
                                                       IN  `p_usrName` VARCHAR(30), 
							                           IN  `p_pwd`     VARCHAR(20), 
													   OUT `p_result`  VARCHAR(255) )
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    	ROLLBACK;
        SET `p_result` = 'ERROR';
    END;
	START TRANSACTION;
    
    SET `p_result` = '';
    
    SELECT `Email` INTO `p_result` FROM `users` WHERE `Email` = `p_email`;
    IF `p_result` = '' THEN
    
        SELECT `username` INTO `p_result` FROM `users` WHERE `username` = `p_usrName`;
        IF `p_result` = '' THEN
        
            INSERT INTO `users` (`Email`, `name`, `username`, `passWord`)
			VALUES (`p_email`, `p_name`, `p_usrName`, CodePassword(`p_pwd`));
                
        END IF;
    
    END IF;
	
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-04 23:03:19
