-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.40-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema yakimbe
--

CREATE DATABASE IF NOT EXISTS yakimbe DEFAULT CHARSET=utf8;
USE yakimbe;

--
-- Definition of table `action`
--

DROP TABLE IF EXISTS `action`;
CREATE TABLE `action` (
  `action_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `action_type` varchar(20) NOT NULL,
  `item_id` bigint(20) unsigned NOT NULL,
  `user_id` mediumint(8) unsigned NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`action_id`),
  KEY `user_id` (`user_id`),
  KEY `item_id` (`item_id`) USING BTREE,
  CONSTRAINT `action_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  CONSTRAINT `action_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `action`
--

/*!40000 ALTER TABLE `action` DISABLE KEYS */;
/*!40000 ALTER TABLE `action` ENABLE KEYS */;


--
-- Definition of table `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) unsigned NOT NULL,
  `item_commenting_on_id` bigint(20) unsigned NOT NULL,
  `body` varchar(2000) NOT NULL,
  `parent_comment_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  UNIQUE KEY `item_id` (`item_id`),
  KEY `parent_comment_id` (`parent_comment_id`),
  KEY `item_commenting_on_id` (`item_commenting_on_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`parent_comment_id`) REFERENCES `comment` (`comment_id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`item_commenting_on_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `comment`
--

--
-- Definition of table `item`
--

DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `item_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL,
  `submission_time` datetime NOT NULL,
  `is_dead` tinyint(1) DEFAULT '0',
  `rating` mediumint(9) DEFAULT '0',
  `item_type` varchar(20) NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `item`
--


--
-- Definition of table `link`
--

DROP TABLE IF EXISTS `link`;
CREATE TABLE `link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) unsigned NOT NULL,
  `url` varchar(2000) NOT NULL,
  `headline` varchar(90) NOT NULL,
  `subhead` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `item_id` (`item_id`),
  CONSTRAINT `link_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `link`
--
--
-- Definition of table `text`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `web_site` varchar(100) DEFAULT NULL,
  `email` varchar(75) NOT NULL,
  `registration_date` datetime NOT NULL,
  `pw` varchar(60) NOT NULL COMMENT 'bcrypt',
  `location` varchar(20) DEFAULT NULL,
  `is_admin` tinyint(4) DEFAULT '0',
  `items_per_page` smallint(5) unsigned DEFAULT '20',
  `rating` int(10) unsigned DEFAULT '0',
  `is_account_verified` int(10) unsigned DEFAULT '0' COMMENT '1 if verified, otherwise it''''s their random verification number',
  `email_opt_in` tinyint(1) NOT NULL DEFAULT '0',
  `sex` varchar(20) DEFAULT NULL,
  `birth_year` int(4) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`,`user_name`,`first_name`,`last_name`,`email`,`registration_date`,`pw`,`is_admin`,`is_account_verified`) VALUES 
 (9,'jwoodruff','change','this','babble@fish.com','2010-01-22 07:37:24','$2a$11$GRRnC.KEnEcX3R6rvCKZEelEwGMvBgV6WjCVwmd6hiRj7FZeXXpia',1,1);


--
-- Definition of function `isEmailUnique`
--

DROP FUNCTION IF EXISTS `isEmailUnique`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` FUNCTION `isEmailUnique`(inputEmail VARCHAR(75)) RETURNS tinyint(1)
BEGIN
  DECLARE emailExists BOOLEAN DEFAULT FALSE;
  SELECT COUNT(email) INTO emailExists FROM user WHERE email = inputEmail;
    IF emailExists THEN
      RETURN false;
    ELSE
      RETURN true;
    END IF;
    
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `isUserNameUnique`
--

DROP FUNCTION IF EXISTS `isUserNameUnique`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` FUNCTION `isUserNameUnique`(inputUserName VARCHAR(20)) RETURNS tinyint(1)
BEGIN
  DECLARE userNameExists BOOLEAN DEFAULT FALSE;
  SELECT COUNT(user_name) INTO userNameExists FROM user WHERE user_name = inputUserName;
    IF userNameExists THEN
      RETURN false;
    ELSE
      RETURN true;
    END IF;
    
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `createNewUser`
--

DROP PROCEDURE IF EXISTS `createNewUser`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createNewUser`(IN strUserName VARCHAR(20), IN strFirstName VARCHAR(20), 
                                         IN strLastName VARCHAR(20), IN strDescription VARCHAR(200), 
                                         IN strWebSite VARCHAR(100), IN strEmail VARCHAR(75), 
                                         IN strLocation VARCHAR(20), IN strPassword VARCHAR(20), 
                                         IN strEncryptionKey VARCHAR(20), IN verificationNumber INT(10))
BEGIN
	INSERT INTO user (user_id, user_name, first_name, last_name, 
                      description, web_site, email, location, registration_date, pwd, is_account_verified)
        VALUES (NULL, strUserName, strFirstName, strLastName, 
                      strDescription, strWebSite, strEmail, strLocation, NOW(), AES_ENCRYPT(strPassword,strEncryptionKey), verificationNumber);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getComments`
--

DROP PROCEDURE IF EXISTS `getComments`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getComments`(In itemCommentingOnId INT)
BEGIN
	SELECT *
  FROM comment c
    INNER JOIN item i
    ON i.item_id = c.item_id
    INNER JOIN user u
    ON u.user_id = i.user_id
  WHERE c.item_commenting_on_id = itemCommentingOnId;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `getLink`
--

DROP PROCEDURE IF EXISTS `getLink`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLink`(In myItemId INT)
BEGIN
	SELECT i.item_id, u.user_id, u.user_name, i.submission_time, 
                            i.rating, i.item_type, l.link_id, l.url, l.headline, l.subhead
  FROM item i
    INNER JOIN link l
    ON l.item_id = i.item_id
    INNER JOIN user u
    ON u.user_id = i.user_id
  WHERE i.item_id = myItemId;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

DELIMITER ;

--
-- Definition of procedure `getNewLinks`
--

DROP PROCEDURE IF EXISTS `getNewLinks`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getNewLinks`(IN resultSetLimit INT,IN startPos INT)
BEGIN
  
  IF (startPos > 0) THEN
  
    SET SQL_SELECT_LIMIT = resultSetLimit + startPos;
    SET @rownum=0;
    
    SELECT * 
    FROM (
          SELECT @rownum:=@rownum+1 'itemCount', i.item_id, u.user_id, u.user_name, i.submission_time, 
                            i.rating, i.item_type, l.link_id, l.url, l.headline, l.subhead, 
                            (SELECT count(c.item_id) from comment c where c.item_commenting_on_id = i.item_id) num_comments
          FROM item i
            INNER JOIN link l
            ON l.item_id = i.item_id
            INNER JOIN user u
            ON u.user_id = i.user_id
          WHERE i.is_dead = false
          ORDER BY submission_time DESC
          ) t
    WHERE t.itemCount > startPos;
    
  ELSE
  
    SET SQL_SELECT_LIMIT = resultSetLimit;
  
    SELECT i.item_id, u.user_id, u.user_name, i.submission_time, 
           i.rating, i.item_type, l.link_id, l.url, l.headline, l.subhead,
           (SELECT count(c.item_id) from comment c where c.item_commenting_on_id = i.item_id) num_comments
    FROM item i
      INNER JOIN link l
      ON l.item_id = i.item_id
      INNER JOIN user u
      ON u.user_id = i.user_id
    WHERE i.is_dead = false
    ORDER BY submission_time DESC;
          
  END IF;
  
	SET SQL_SELECT_LIMIT = default;
  
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;


--
-- Definition of procedure `getUser`
--

DROP PROCEDURE IF EXISTS `getUser`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUser`(strUserName varchar(20), strPassword varchar(20), strEncryptionKey varchar(20))
BEGIN
	SELECT * 
  FROM user u
  WHERE u.user_name = strUserName AND
        AES_DECRYPT(u.pwd, strEncryptionKey) = strPassword;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `insertComment`
--

DROP PROCEDURE IF EXISTS `insertComment`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertComment`(IN intUserId mediumint(8), IN body VARCHAR(2000), IN parentId bigint(20), IN itemCommentingOnId bigint(20))
BEGIN
	INSERT INTO comment (comment_id, item_id, body, parent_comment_id, item_commenting_on_id)
				VALUES (NULL, (SELECT MAX(item_id) FROM item i INNER JOIN user u ON u.user_id = i.user_id WHERE u.user_id = intUserId),
						body, parentId, itemCommentingOnId);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `insertItem`
--

DROP PROCEDURE IF EXISTS `insertItem`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertItem`(IN intUserId mediumint(8), IN strItemSubmissionType VARCHAR(10))
BEGIN
			INSERT INTO  item (item_id, user_id, submission_time, item_type)
						VALUES (NULL, intUserId, NOW(), strItemSubmissionType);
		END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `insertLink`
--

DROP PROCEDURE IF EXISTS `insertLink`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertLink`(IN intUserId mediumint(8), IN strURL VARCHAR(2000), IN strHeadline VARCHAR(90), IN strSubhead VARCHAR(90))
BEGIN
			INSERT INTO link (link_id, item_id, url, headline, subhead)
						VALUES (NULL, (SELECT MAX(item_id) FROM item i INNER JOIN user u ON u.user_id = i.user_id WHERE u.user_id = intUserId),
								strURL, strHeadline, strSubhead);
		END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `insertNewAction`
--

DROP PROCEDURE IF EXISTS `insertNewAction`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertNewAction`(IN strUserName VARCHAR(20), IN strActionType VARCHAR(20), IN longItemId bigint(20))
BEGIN
			INSERT INTO action (action_id, item_id, user_id, action_type, datetime)
						VALUES (NULL, longItemId, (SELECT u.user_id FROM user u WHERE strUserName = u.user_name), strActionType, NOW());
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `updateRating`
--

DROP PROCEDURE IF EXISTS `updateRating`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateRating`(IN updatedRating INT, IN longItemId LONG)
BEGIN
  UPDATE item
  SET rating = (rating + updatedRating)
  WHERE item_id = longItemId;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;






INSERT INTO `yakimbe`.`item` (`item_id`,`user_id`,`submission_time`,`is_dead`,`rating`,`item_type`) VALUES

 (49,9,'2010-01-22 07:47:35',0,-1,'link'),
 (51,9,'2010-01-22 07:50:34',0,2,'link'),
 (52,9,'2010-01-22 07:59:14',0,0,'link'),
 (53,9,'2010-01-22 08:00:40',0,5,'link'),
 (54,9,'2010-01-22 08:04:17',0,0,'link'),
 (55,9,'2010-01-22 08:07:13',0,0,'link'),
 (56,9,'2010-01-22 08:10:28',0,0,'link'),
 (57,9,'2010-01-22 08:11:44',0,1,'link'),
 (58,9,'2010-01-22 08:14:50',0,0,'link'),
 (59,9,'2010-01-22 09:01:01',0,1,'link'),
 (60,9,'2010-01-22 09:04:24',0,0,'link'),
 (61,9,'2010-01-22 09:05:20',0,0,'link'),
 (62,9,'2010-01-22 09:14:18',0,0,'link');
INSERT INTO `yakimbe`.`item` (`item_id`,`user_id`,`submission_time`,`is_dead`,`rating`,`item_type`) VALUES
 (63,9,'2010-01-22 09:16:01',0,0,'link'),
 (64,9,'2010-01-22 09:16:58',0,0,'link'),
 (65,9,'2010-01-22 10:33:26',0,3,'link'),
 (69,9,'2010-01-22 10:40:11',0,0,'link'),
 (70,9,'2010-01-22 10:43:40',0,0,'link'),
 (71,9,'2010-01-22 10:44:50',0,0,'link'),
 (72,9,'2010-01-22 10:49:54',0,2,'link'),
 (73,9,'2010-01-22 12:13:54',0,0,'link'),
 (74,9,'2010-01-22 16:00:15',0,0,'link'),
 (75,9,'2010-01-22 22:33:34',0,0,'link'),
 
 (78,9,'2010-01-23 22:19:10',0,5,'link');
INSERT INTO `yakimbe`.`item` (`item_id`,`user_id`,`submission_time`,`is_dead`,`rating`,`item_type`) VALUES
 (79,9,'2010-01-24 00:49:21',0,0,'link'),
 (80,9,'2010-01-24 00:50:20',0,0,'link'),
 
 (82,9,'2010-01-30 23:55:13',0,1,'link'),
 (83,9,'2010-02-01 12:19:19',0,2,'link'),
 (84,9,'2010-02-01 12:23:59',0,0,'link'),
 (85,9,'2010-02-01 13:44:13',0,2,'link'),
 (86,9,'2010-02-02 08:22:47',0,0,'link'),
 (87,9,'2010-02-02 08:50:29',0,1,'link'),
 (88,9,'2010-02-02 08:53:35',0,0,'link'),
 (89,9,'2010-02-02 08:55:57',0,0,'link'),
 (90,9,'2010-02-02 08:58:59',0,0,'link'),
 (91,9,'2010-02-02 09:01:23',0,0,'link'),
 (92,9,'2010-02-02 09:06:18',0,0,'link'),
 (93,9,'2010-02-02 09:10:04',0,0,'link');
INSERT INTO `yakimbe`.`item` (`item_id`,`user_id`,`submission_time`,`is_dead`,`rating`,`item_type`) VALUES
 (94,9,'2010-02-02 09:14:53',0,0,'link'),
 (95,9,'2010-02-02 09:20:13',0,0,'link'),
 (96,9,'2010-02-02 10:13:04',0,1,'link'),
 (97,9,'2010-02-03 10:03:59',0,0,'link'),
 (98,9,'2010-02-03 11:58:18',0,0,'link'),
 (99,9,'2010-02-03 12:19:05',0,0,'link'),
 (100,9,'2010-02-03 12:39:01',0,0,'link'),
 (101,9,'2010-02-04 12:30:06',0,0,'link'),
 (105,9,'2010-02-05 07:32:35',0,0,'link'),
 (106,9,'2010-02-05 07:34:35',0,0,'link');
INSERT INTO `yakimbe`.`item` (`item_id`,`user_id`,`submission_time`,`is_dead`,`rating`,`item_type`) VALUES
 (116,9,'2010-02-05 11:47:42',0,4,'link'),
 (118,9,'2010-02-05 12:00:46',0,0,'link');
INSERT INTO `yakimbe`.`item` (`item_id`,`user_id`,`submission_time`,`is_dead`,`rating`,`item_type`) VALUES
 (128,9,'2010-02-05 19:17:43',0,0,'link'),
 (138,9,'2010-02-08 07:55:19',0,0,'link'),
 (139,9,'2010-02-08 08:00:25',0,0,'link'),
 (140,9,'2010-02-08 08:06:33',0,0,'link'),
 (141,9,'2010-02-08 08:09:39',0,0,'link'),
 (142,9,'2010-02-08 08:13:26',0,0,'link'),
 (143,9,'2010-02-08 08:18:15',0,2,'link'),
 (144,9,'2010-02-08 08:19:57',0,0,'link');
INSERT INTO `yakimbe`.`item` (`item_id`,`user_id`,`submission_time`,`is_dead`,`rating`,`item_type`) VALUES
 (145,9,'2010-02-08 08:23:02',0,2,'link'),
 (146,9,'2010-02-08 08:27:07',0,1,'link'),
 (148,9,'2010-02-08 08:31:10',0,0,'link'),
 (149,9,'2010-02-08 08:32:30',0,6,'link'),
 (150,9,'2010-02-08 08:34:08',0,0,'link'),
 (151,9,'2010-02-08 10:26:33',0,0,'link'),
 (152,9,'2010-02-08 11:49:10',0,2,'link'),
 (153,9,'2010-02-08 12:21:25',0,0,'link'),
 (154,9,'2010-02-08 12:26:30',0,1,'link'),
 (155,9,'2010-02-08 13:29:24',0,1,'link'),
 (158,9,'2010-02-08 13:58:46',0,0,'link'),
 (159,9,'2010-02-08 13:59:42',0,0,'link'),
 (160,9,'2010-02-09 09:42:22',0,0,'link');
INSERT INTO `yakimbe`.`item` (`item_id`,`user_id`,`submission_time`,`is_dead`,`rating`,`item_type`) VALUES
 (161,9,'2010-02-09 10:13:24',0,0,'link'),
 (162,9,'2010-02-09 10:15:03',0,2,'link'),
 (167,9,'2010-02-09 16:02:58',0,1,'link'),
 (168,9,'2010-02-10 08:09:32',0,7,'link'),
 (169,9,'2010-02-10 08:14:33',0,0,'link'),
 (170,9,'2010-02-10 12:16:03',0,4,'link'),
 (171,9,'2010-02-10 12:34:06',0,0,'link'),
 (172,9,'2010-02-11 12:37:12',0,0,'link'),
 (174,9,'2010-02-12 08:28:58',0,3,'link'),
 (175,9,'2010-02-12 09:14:23',0,2,'link');
INSERT INTO `yakimbe`.`item` (`item_id`,`user_id`,`submission_time`,`is_dead`,`rating`,`item_type`) VALUES
 (178,9,'2010-02-17 08:01:17',0,0,'link'),
 (181,9,'2010-02-18 12:04:48',0,0,'link'),
 (182,9,'2010-02-19 08:00:36',0,3,'link'),
 (183,9,'2010-02-19 08:04:17',0,1,'link'),
 (184,9,'2010-02-19 08:07:14',0,0,'link'),
 (185,9,'2010-02-19 08:10:00',0,0,'link'),
 (186,9,'2010-02-22 15:50:14',0,0,'link'),
 (187,9,'2010-02-22 15:53:03',0,0,'link'),
 (188,9,'2010-02-22 15:55:20',0,0,'link'),
 (189,9,'2010-02-22 15:56:14',0,0,'link'),
 (190,9,'2010-02-23 11:45:53',0,0,'link'),
 (192,9,'2010-02-23 11:50:45',0,0,'link');
INSERT INTO `yakimbe`.`item` (`item_id`,`user_id`,`submission_time`,`is_dead`,`rating`,`item_type`) VALUES
 (193,9,'2010-02-23 11:55:21',0,5,'link'),
 (194,9,'2010-02-23 12:01:20',0,0,'link'),
 (195,9,'2010-02-23 12:07:45',0,0,'link'),
 (196,9,'2010-02-23 12:11:32',0,0,'link'),
 (197,9,'2010-02-23 12:15:37',0,0,'link'),
 (198,9,'2010-02-24 08:20:25',0,1,'link'),
 (199,9,'2010-02-24 08:27:11',0,0,'link'),
 (200,9,'2010-02-24 08:32:16',0,0,'link'),
 (201,9,'2010-02-24 08:36:27',0,3,'link'),
 (202,9,'2010-02-24 08:42:23',0,1,'link'),
 (203,9,'2010-02-24 08:57:54',0,0,'link'),
 (204,9,'2010-02-24 12:32:34',0,2,'link'),
 (205,9,'2010-02-24 15:40:51',0,4,'link');
 
 
 
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (28,49,'http://michiganlibraryauthorvisits.blogspot.com/2009/12/capital-area-district-librarys-upcoming.html','Tukufu Zuberi from PBS History Detectives coming to Lansing library',''),
 (29,51,'http://www.lansingstatejournal.com/article/20100122/NEWS01/1220328','BWL trying to hike rates again','9.3% increase for electric, 8.9% for water probably coming March 1'),
 (30,52,'http://www.lansingstatejournal.com/article/20100122/NEWS01/301220031/-1/middayupdates/MSU-student-won-t-face-charge-of-terror-threats','Terrorrism charges against MSU student dropped','Zachariah M. Aslam spoke to crisis counselor about detonating a bomb'),
 (31,53,'http://statenews.com/index.php/article/2010/01/msu_to_unveil_new_spartan_logo_in_april','MSU debuting new logo in April',''),
 (32,54,'http://www.lansingcitypulse.com/lansing/blog-154-eli-and-edythe-broad-art-museum-update.html','Eli and Edythe Broad art museum gets another $2M from donors','Project expected to cost between $40-45 million'),
 (33,55,'http://www.livingstondaily.com/article/20100120/NEWS01/1200314/1002/MagLev-train-gets-mixed-report-with-report-PDF','Status of Lansing-to-Detroit MagLev? Questionable.','');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (34,56,'http://www.lansingcitypulse.com/lansing/article-3885-blowing-smoke.html','Lawmakes move to weaken medical marijuana law','Bills spell out sentencing guidelines, disallow growing of pot, more'),
 (35,57,'http://www.lansingcitypulse.com/lansing/article-3889-the-hardest-count.html','Census Bureau begins to count Lansing\'s homeless next week',''),
 (36,58,'http://www.cityoflansingmi.com/view_news.jsp?id=2309','[event] Cardboard Classic Sled Contest is Saturday Dec. 23',''),
 (37,59,'http://www.wilx.com/home/headlines/82325492.html','Former Eastern coach charged with sexual misconduct','Tommie Boyd charged with misconduct with a minor from Fraser'),
 (38,60,'http://www.wilx.com/home/headlines/82294537.html','25 homes invaded over Christmas break in East Lansing','Police arrested two men; still on the lookout'),
 (39,61,'http://www.wilx.com/home/headlines/82295007.html','State Police to complete move by April 1',''),
 (40,62,'http://www.publicbroadcasting.net/michigan/news.newsmain/article/1/0/1602287/Michigan.News/Bowman.Wants.To.Get.Back.In.The.Game.','Robert Bowman may throw hat in ring for Governor\'s office','');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (41,63,'http://www.publicbroadcasting.net/michigan/news.newsmain/article/1/0/1602160/Michigan.News/White.House.to.Host.Great.Lakes-Asian.Carp.Summit','White house to host Great Lakes Asian Carp summit',''),
 (42,64,'http://www.publicbroadcasting.net/michigan/news.newsmain/article/1/0/1601907/Michigan.News/Michigan%27s.Unemployment.Rate.Declines.Slightly.','Michigan\'s unemployment declines, slightly','Rate dropped one-tenth of a percent in December'),
 (43,65,'http://www.lansingstatejournal.com/article/20100122/NEWS01/301220004','Lansing \'serial killer\' Matthew Macon denied appeal in 2 murders','Macon was suspected of killing five women in the summer of 2007'),
 (44,69,'http://www.stewardshipnetwork.org/site/c.hrLOKWPILuF/b.5187337/k.2F8/2010_Stewardship_Network_Conference.htm','[event] Conference focuses on restoring native ecosystems','3rd annual conference takes place Jan. 22-23 at the Kellogg center'),
 (45,70,'http://museum.msu.edu/s-program/mtap/Programs&Services/dailylives.html','lunch lecture: our daily work / our daily lives','Brown bag lecture today at 12:15; MSU Museum');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (46,71,'http://news.msu.edu/story/7326/','Million-dollar grant to MSU helps expand broadband access in Mich.',''),
 (47,72,'http://thelansingblog.com/2010/01/20/this-weekend-join-michigan-statehood-day-celebration-at-michigan-historical-museum-downtown/','Michigan Statehood Day celebration at Michigan Historical Museum',''),
 (48,73,'http://www.lansingstatejournal.com/article/20100122/NEWS01/301220006','MSU freshman to go to trial for East Lansing fireworks explosion','Nikolai Wasielewski faces felony charges in connection to Nov. 1 prank'),
 (49,74,'http://www.lansingstatejournal.com/article/20100122/THINGS0104/1230303&referrer=FRONTPAGECAROUSEL','event: Lansing Orchestra plays Mendelssohn, Strauss and Brahms tonight','Brahms piece rarely performed due to requiring two soloists'),
 (50,75,'http://www.lansingstatejournal.com/article/20100122/NEWS03/1090301','GM names new Lansing plants manager','Scott Whybrew previously in charge of operations in South America');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (52,78,'http://www.statenews.com/index.php/article/2010/01/spartans_rally_to_beat_minnesota_6564','Spartans come from behind to beat Minnesota, 65-64','MSU delivers Golden Gophers first loss of the season, come away 7-0'),
 (53,79,'http://www.wlns.com/global/story.asp?s=11845730','Amazing race casting call coming to Lansing','CBS series.'),
 (54,80,'http://www.wlns.com/global/story.asp?s=11845730','Amazing race casting call coming to Jackson','CBS series to host casting session on February 3rd from 5 to 8 p.m'),
 (56,82,'http://www.lansingstatejournal.com/article/20100130/NEWS01/1300324&referrer=FRONTPAGECAROUSEL','Granholm seeks to retire 46,000 state employees',''),
 (57,83,'http://www.lansingstatejournal.com/article/20100201/NEWS01/2010330&referrer=FRONTPAGECAROUSEL','New life: Old industrial sites provide home to new data centers','ACD.net, Jackson National Life, Liquid Web and others invest in region'),
 (58,84,'http://www.freep.com/article/20100201/BUSINESS01/100201006/1318/Toyota-offers-pedal-fix-apologizes-to-owners','Toyota shipping parts to fix gas pedals','Problem was related to firction device in pedal');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (59,85,'http://www.capitalgainsmedia.com/features/knap0330.aspx','The Knapps Building: MSU students imagine a new purpose','Interior design students reimagine Knapps as condos, restaurant, more'),
 (60,86,'http://www.capitalgainsmedia.com/innovationnews/Jazzfest0403.aspx','Lansing\'s JazzFest nets $10,000 grant',''),
 (61,87,'http://www.lansingstatejournal.com/article/20100202/NEWS06/2020325','Obama\'s budget includes $10M for MSU FRIB research facility',''),
 (62,88,'http://www.lansingstatejournal.com/article/20100202/NEWS03/2020310/1004/NEWS03/Eatery-expansion--Restaurant-Mediteran-in-downtown-Lansing-set-to-add-dining-space--deli','Restaurant Mediteran to expand, add eurpean-style deli','Downtown Lansing eatery to take over old Contemporary Shoe Repair'),
 (63,89,'http://www.lansingstatejournal.com/article/20100201/NEWS03/2010312/1004/news03','Job shearch = tax breaks',''),
 (64,90,'http://www.statenews.com/index.php/article/2010/02/el_police_arrest_mississippi_fugitive','E.L. police arrest Mississippi fugitive','Man convicted to 80 years skipped bail before trial'),
 (65,91,'http://www.statenews.com/index.php/multimedia/37247','video: Looking ahead to Wisconsin','');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (66,92,'http://michiganmessenger.com/34200/to-fix-the-state-granholm-must-be-relevant','State of the State: Granholm faces a tightrope walk in yearly address',''),
 (67,93,'http://www.detnews.com/article/20100201/POLITICS03/2010361/Michigan-schools--small-businesses-will-fare-well-in-Obama-budget','Michigan schools, small businesses will fare well in Obama budget',''),
 (68,94,'http://michiganmessenger.com/34068/state-follows-trend-to-virtual-government','Michigan governments moving to virtual services to cut costs','State of Michigan leads the way, municipalities following'),
 (69,95,'http://www.lansingcitypulse.com/lansing/blog-163-hallman-birthday-and-fundraiser-supports-police.html','Lansing officer reminesces about Genessee neighborhood beat','During his patrol, neighborhood contained 14 active crack houses'),
 (70,96,'http://www.lansingstatejournal.com/article/20100202/NEWS01/2020327&referrer=FRONTPAGECAROUSEL','With less snowfall, area road commissions have plows parked',''),
 (71,97,'http://www.lansingstatejournal.com/article/20100203/GW0201/2030328&referrer=FRONTPAGECAROUSEL','Wisconsin deals MSU seasons first loss, injures Kalin Lucas','With Lucas out, rest of season in jeopardy');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (72,98,'http://www.statenews.com/index.php/article/2010/02/questions_abound_if_lucas_misses_extended_time','How will the Spartans fare without Lucas?','Spartans might need to replace leader, crunch-time scorer'),
 (73,99,'http://www.lansingstatejournal.com/article/20100203/NEWS03/2030320','Lansing-made crossovers help GMs sales numbers',''),
 (74,100,'http://www.capitalgainsmedia.com/innovationnews/Bailey0404.aspx','E.L.\'s Bailey Neighborhood Lands $115,000 Grant for LED Street Lights',''),
 (75,101,'http://www.lansingstatejournal.com/article/20100204/NEWS04/2040339&referrer=FRONTPAGECAROUSEL','State of the State: Many in mid-Michigan could be impacted',''),
 (76,105,'http://www.lansingstatejournal.com/article/20100205/NEWS03/2050329','Eight of mid-Michigan\'s top ten best-selling cars are GM built',''),
 (77,106,'http://www.lansingstatejournal.com/article/20100205/NEWS01/302050002','Thousands of Michigan children overdue for second H1N1',''),
 (78,116,'http://www.wilx.com/news/headlines/83486052.html','Police confront group of gun toting men at S. Lansing Ponderssoa','Weapons were legal, but assault rifle pushed restaurant owner too far');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (79,118,'http://www.wilx.com/home/headlines/83636337.html','MSU backs away from new logo; will use current logo','Protests from fans caused univesity to back away from new design'),
 (80,128,'http://www.wlns.com/Global/story.asp?S=11941234','Lansing Mayor Virg Bernero to run for mayor',''),
 (81,138,'http://www.lansingstatejournal.com/article/20100208/NEWS06/2080329','New MSU Museum hopes to expand reach to 1M people','Museum reach not previously measured, but estimated to be around 50k'),
 (82,139,'http://www.lansingstatejournal.com/article/99999999/INTERACTIVE0101/90515002/-1/special','State of Michigan contracts database',''),
 (83,140,'http://www.statenews.com/index.php/article/2010/02/super_bowl_ads_ranked_by_msu_faculty','MSU faculty rank Superbowl ads','Google\'s Parisian love ranks top'),
 (84,141,'http://www.statenews.com/index.php/article/2010/02/the_race_is_on','Despite losses, all is not lost for Spartans','MSU down to one game lead in the Big Ten'),
 (85,142,'http://www.lansingcitypulse.com/lansing/article-3934-the-third-rail.html','Could new investment in rail transportation be a boon for Michigan?','REO town depot a reminder of days gone by');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (86,143,'http://www.lansingcitypulse.com/lansing/article-3928-the-smell.html','First Michigan Caregivers Cup brings cannabis culture to Ypsilanti','Event for marijuana caregivers a \'helpful, necessary celebration\''),
 (87,144,'http://www.lansingcitypulse.com/lansing/article-3930-the-watchmen.html','ACLU to study Lansing Police security cameras','22 crime-fighting cameras have been installed in the last 3 years'),
 (88,145,'http://www.lansingcitypulse.com/lansing/article-3935-whatufffds-cooking.html','Tough economy poses tough challenges for area restaurants','Kelly\'s Downtown, Club 621 have yet to reopen, many have simply closed'),
 (89,146,'http://www.lansingcitypulse.com/lansing/article-3939-sculpture-for-the-city.html','Sculpture planned to commemorate Lansing\'s sesquicentennial','Design unkown, but will be 8- to 20-feet tall polished stainless steel'),
 (90,148,'http://www.wilx.com/home/headlines/83786782.html','Bernero confirms run for Governor on WILX',''),
 (91,149,'http://www.wilx.com/weather/headlines/83761702.html','WILX weather: 6-10\` of snow headed our way','');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (92,150,'http://www.wlns.com/global/story.asp?s=11949774','Local church aims to fill semi for Haiti relief',''),
 (93,151,'http://thelansingblog.com/2010/02/08/parents-what-about-the-magnet-schools-in-the-lansing-school-district/','Lansing Magnet schools: Maybe the Lansing School District isn\'t so bad','A look at the Lansing Magnet School Fair at Don Johnson Field House'),
 (94,152,'http://www.wilx.com/news/headlines/83806612.html','Suspected robber shot by his victim, killed by drunk driver','Only in Detroit...'),
 (95,153,'http://www.cityofeastlansing.com/fiscalchallenges/','East Lansing seeks input on fiscal challenges',''),
 (96,154,'http://eatlansing.wordpress.com/2009/09/27/michigan-brewing-company/','Review: Michigan Brewing Company',''),
 (97,155,'http://www.freep.com/article/20100208/SPORTS07/100208025/1055/MSU-would-love-for-Lucas-to-return-but-is-he-ready','Spartans not sure if Kalin Lucas will return Tuesday',''),
 (98,158,'http://www.whartoncenter.com/boxoffice/performance.aspx?pid=904','[ event ] WILCO to play at Wharton Center 2/21','');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (99,159,'http://www.whartoncenter.com/boxoffice/performance.aspx?pid=913','An evening with Lewis Black at Wharton this weekend [ event ]',''),
 (100,160,'http://www.lansingstatejournal.com/article/20100209/NEWS03/2090326','Area auto suppliers hiring up to 525 workers','Shifts being added due to Chevy Traverse moving to Lansing-Delta plant'),
 (101,161,'http://www.lansingstatejournal.com/article/20100209/COLUMNISTS09/2090319/1016/COLUMNISTS09','Eaton Rapids man vindicated, sad in wake of Toyota recalls','Letter writer has been crying foul on Toyota \'quality\' image for years'),
 (102,162,'http://www.lansingstatejournal.com/article/20100209/NEWS01/2090321','E.L. looking at tax increases, layoffs & more to balance budget','City faces a $5M deficit'),
 (103,167,'http://www.lansingstatejournal.com/article/20100209/NEWS01/302080002&referrer=FRONTPAGECAROUSEL','East Lansing Police Chief wins doughnut eating contest','Cheif ate 3 paczkis, plus one bite, for the win'),
 (104,168,'http://statenews.com/index.php/article/2010/02/whiteout_woes','Spartans lose third in a row','Tuesdays loss is worst at-home loss since \'05');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (105,169,'http://statenews.com/index.php/article/2010/02/lucas_show_grit_heart_in_loss','Lucas showed grit, heart in loss',''),
 (106,170,'http://www.acd.net/Press/News%20Release%2001-25-10.pdf','[ pdf ] ACD.net awarded $41M to build 955 mile fiber network','Project extends high-speed service to rural areas of the state'),
 (107,171,'http://www.lansingstatejournal.com/article/20100210/NEWS01/2100321','23 y.o. DeWitt man charged in death of 3 y.o stepdaughter','Man \'... flung her backwards\' for signing and dancing'),
 (108,172,'http://www.detnews.com/article/20100211/POLITICS02/2110449/1022/rss10','Granholm budget cuts sales, business taxes, adds service tax','Includes $565M in cuts'),
 (110,174,'http://statenews.com/index.php/page/interactive_computing_change','[ interactive ] Year-to-year percent change of state budget','Graphic of state funding changes in four categories');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (111,175,'http://www.lansingstatejournal.com/article/20100212/NEWS01/2120313','Feds pass on surest solution to halt Great Lakes carp invasion','$80M plan to study, stop fish with electric & poison approved instead'),
 (113,178,'http://www.lansingstatejournal.com/article/20100217/NEWS01/302030027','Animal organs discovered at Frandor Fitness USA',''),
 (114,181,'http://www.lansingstatejournal.com/article/20100218/NEWS06/2180351','MSU lands $25 million science foundation grant for study of evolution','College will study natural and digital worlds'),
 (115,182,'http://www.statenews.com/index.php/article/2010/02/from_recession_to_reinvention','East Lansing entrepreneurs strive to revitalize stale economy',''),
 (116,183,'http://www.msucatalyst.com/catalyst-home/2010/2/8/your-dream-job-game-plan.html','[ book ] Molly Fletcher: Your Dream Job Game Plan','MSU grad, agent to Tom Izzo gives advice on career planning'),
 (117,184,'http://www.statenews.com/index.php/article/2010/02/dehaan_breaks_alltime_ncaa_blocks_record','DeHaan breaks all-time NCAA blocks record','');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (118,185,'http://www.lansingstatejournal.com/article/20100219/NEWS01/302190004','Detroit City Council President crashes city vehicle','Charles Pugh drove how with 2 flat tires, filed report next day'),
 (119,186,'http://www.statenews.com/index.php/article/2010/02/new_credit_card_law_effective_monday','New credit card rules go into effect today','Freebies for signing up banned; anyone under 21 must have co-signer'),
 (120,187,'http://www.statenews.com/index.php/article/2010/02/14_teams_work_on_films_for_485_contest','14 teams compete in 48 hour film contest','48/5 challenges contestants to make a 5-minute film in 48 hours'),
 (121,188,'http://www.lansingstatejournal.com/article/20100222/HOLT02/302220013','Holt superintendent defends decision to keep school open','Holt the only major school district in Ingham County to have class'),
 (122,189,'http://www.lansingstatejournal.com/apps/pbcs.dll/gallery?Avis=A3&Dato=20100221&Kategori=NEWS&Lopenr=2210803','[ gallery ] MSU Chocolate Party',''),
 (123,190,'http://en.wikipedia.org/wiki/Lynx_(web_browser)','This was submitted using Lynx','');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (124,192,'http://www.statenews.com/index.php/article/2010/02/4_candidates_run_for_ingham_county_commissioner','Four candidate run for Ingham County Commissioner','Elections happening today (Feb. 23)'),
 (125,193,'http://www.statenews.com/index.php/article/2010/02/spartans_must_focus_on_bigger_picture_after_loss','Nowak: Spartans must focus on bigger picture','After second home loss in a row, Izzo must refocus team'),
 (126,194,'http://www.detnews.com/article/20100223/SPORTS0201/2230404/U-M-expected-to-release-findings-of-football-investigation-today','U-M Expected to release finding of football investigation today','Program allegedly violated time restrictions on off-season workouts'),
 (127,195,'http://www.lansingstatejournal.com/article/20100223/NEWS03/2230326','Accident Fund\'s parking deck not eligible for tax-free stimulus money','$31M of federal money now available for other projects'),
 (128,196,'http://www.msucatalyst.com/catalyst-home/2010/2/23/the-podcasting-project.html','MSU Podcasting Project makes lectures available to all','Professors, others post free podcasts on university\'s Web site'),
 (129,197,'http://eatlansing.wordpress.com/2010/02/10/dustys-tap-room-to-start-sunday-brunch/','Dusty\'s taproom to start Sunday brunch','');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (130,198,'http://www.lansingstatejournal.com/article/20100224/NEWS01/2240323/Lansing-police-Chief-Mark-Alley-to-retire','Lansing Police Chief Mark Alley to retire','Chief leaving for position at Emergent BioSolutions after 24 years'),
 (131,199,'http://www.lansingstatejournal.com/article/20100224/NEWS01/2240318/','Dimondale teen arraigned in fatal accident','Robert Cook struck a car driven by his mother, crash killed passenger'),
 (132,200,'http://www.lansingstatejournal.com/article/20100224/NEWS01/2240316/','Ingham County Commissioners approve closing jail post','Move expected to save $640,000, force early release of some inmates'),
 (133,201,'http://www.lansingstatejournal.com/article/20100224/NEWS05/2240319/','Waverly looks to athletics, staffing to trim budget','School needs to trim 12.6% to close $3.8M deficit next year'),
 (134,202,'http://www.detnews.com/article/20100223/SPORTS0201/2230404/U-M-expected-to-release-findings-of-football-investigation-today','NCAA charges U-M football program with 5 major violations','Violations involve voluntary summer workouts and providing false info'),
 (135,203,'http://www.statenews.com/index.php/article/2010/02/trekking_to_timbuktu','MSU Alum authors book about trip to Timbuktu','');
INSERT INTO `yakimbe`.`link` (`link_id`,`item_id`,`url`,`headline`,`subhead`) VALUES 
 (136,204,'http://www.lansingstatejournal.com/article/20100224/NEWS01/2240315/','Dispute at Friendship Baptist Church flares to involve Lansing Police','Disagreement over church finances has divided congregation'),
 (137,205,'http://www.lansingstatejournal.com/article/20100224/NEWS01/302240014/Accident-closes-southbound-U.S.-127-near-Jolly-exit','Rush hour alert: Accident closes southbound U.S. 127 near Jolly','Police are asking motorists to avoid the area');




CREATE TABLE `beta` (
  `beta1_user_count` int(3) DEFAULT '0'
);

INSERT INTO beta (beta1_user_count) VALUES(0);