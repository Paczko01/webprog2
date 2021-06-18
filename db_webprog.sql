-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2021. Jún 18. 03:41
-- Kiszolgáló verziója: 10.4.19-MariaDB
-- PHP verzió: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `db_webprog`
--

DELIMITER $$
--
-- Eljárások
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `JoinChannel` (IN `ch_Id` INT, IN `pl_Id` INT)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LeaveChannel` (IN `ch_Id` INT, IN `pl_Id` INT)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OpenChannel` (IN `pl_Id` INT, IN `ch_name` VARCHAR(64))  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Register` (IN `p_usrName` VARCHAR(30), IN `p_pwd` VARCHAR(30), IN `p_name` VARCHAR(50))  INSERT INTO `users` (`username`, `passWord`, `name`)
VALUES (p_usrName, PASSWORD(p_pwd), p_name)$$

--
-- Függvények
--
CREATE DEFINER=`root`@`localhost` FUNCTION `IsLoginValid` (`p_usrName` VARCHAR(30), `p_pwd` VARCHAR(30)) RETURNS TINYINT(1) BEGIN
	DECLARE pwd VARCHAR(255);
    SELECT `passWord` INTO pwd FROM `users` WHERE `username` = p_usrName;
    RETURN (PASSWORD(p_pwd) = pwd);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `channels`
--

CREATE TABLE `channels` (
  `Id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `player_1_ID` int(11) DEFAULT NULL,
  `player_2_ID` int(11) DEFAULT NULL,
  `status` char(1) COLLATE utf8_hungarian_ci NOT NULL DEFAULT 'e' COMMENT 'e:empty\r\nu:unsatured\r\ns:satured'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `channels`
--

INSERT INTO `channels` (`Id`, `name`, `player_1_ID`, `player_2_ID`, `status`) VALUES
(1, NULL, NULL, NULL, 'u'),
(2, NULL, 3, NULL, 'u'),
(3, 'Torpedo_1', 2, NULL, 'u'),
(4, NULL, NULL, NULL, 'e');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_hungarian_ci NOT NULL,
  `points` int(11) NOT NULL DEFAULT 0,
  `win` int(11) NOT NULL DEFAULT 0,
  `lose` int(11) NOT NULL DEFAULT 0,
  `username` varchar(30) COLLATE utf8_hungarian_ci NOT NULL,
  `passWord` varchar(255) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`ID`, `name`, `points`, `win`, `lose`, `username`, `passWord`) VALUES
(1, 'Ebéd Elek', 69, 12, 6, 'Ebedelek00', '*E4EE7DB331F233FA4918367B0A9187ECB98B53F0'),
(2, 'Ammed Shearen', 30, 10, 40, 'MrShearen', '*AA60810541C94ED093125E059781F5DC8FC2CA1E'),
(3, 'Maja Hee', 0, 0, 0, 'MrsMaja', '*429D068DAA9EA5EE6E5AA4BFD1F269BD0499346C');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `channels`
--
ALTER TABLE `channels`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk1_users` (`player_1_ID`),
  ADD KEY `fk2_users` (`player_2_ID`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `username` (`username`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `channels`
--
ALTER TABLE `channels`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `channels`
--
ALTER TABLE `channels`
  ADD CONSTRAINT `fk1_users` FOREIGN KEY (`player_1_ID`) REFERENCES `users` (`ID`),
  ADD CONSTRAINT `fk2_users` FOREIGN KEY (`player_2_ID`) REFERENCES `users` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
