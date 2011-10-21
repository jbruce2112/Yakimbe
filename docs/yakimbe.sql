CREATE DATABASE Yakimbe 
	CHARACTER SET latin1
	COLLATE latin1_swedish_ci;
	
USE Yakimbe;

-- CREATE TABLES --

CREATE TABLE `user` (
  `user_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `web_site` varchar(100) DEFAULT NULL,
  `email` varchar(75) NOT NULL,
  `registration_date` datetime NOT NULL,
  `pwd` blob NOT NULL COMMENT 'aes encryption',
  `location` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `item` (
  `item_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL,
  `submission_time` datetime NOT NULL,
  `is_dead` tinyint(1) DEFAULT '0',
  `rating` mediumint(9) DEFAULT '0',
  `item_type` varchar(20) NOT NULL,
  `location` varchar(50) NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

	
CREATE TABLE `link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) unsigned NOT NULL,
  `url` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `item_id` (`item_id`),
  CONSTRAINT `link_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

	
CREATE TABLE `text` (
  `text_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) unsigned NOT NULL,
  `body` varchar(2000) NOT NULL,
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`text_id`),
  UNIQUE KEY `item_id` (`item_id`),
  CONSTRAINT `text_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


	
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
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=latin1;

-- FUNCTIONS --

DELIMITER $$

DROP FUNCTION IF EXISTS yakimbe.isEmailUnique;
CREATE FUNCTION yakimbe.`isEmailUnique`(inputEmail VARCHAR(75)) RETURNS tinyint(1)
BEGIN
  DECLARE emailExists BOOLEAN DEFAULT FALSE;
  SELECT email INTO emailExists FROM user WHERE email = inputEmail;
    IF emailExists THEN
      RETURN false;
    ELSE
      RETURN true;
    END IF;
    
END$$

DROP FUNCTION IF EXISTS yakimbe.isUserNameUnique;
CREATE FUNCTION yakimbe.`isUserNameUnique`(inputUserName VARCHAR(20)) RETURNS tinyint(1)
BEGIN
  DECLARE userNameExists BOOLEAN DEFAULT FALSE;
  SELECT user_name INTO userNameExists FROM user WHERE user_name = inputUserName;
    IF userNameExists THEN
      RETURN false;
    ELSE
      RETURN true;
    END IF;
    
END$$

DELIMITER ;


-- STORED PROCS --
DELIMITER $$

DROP PROCEDURE IF EXISTS yakimbe.createNewUser;
CREATE PROCEDURE yakimbe.`createNewUser`(IN strUserName VARCHAR(20), IN strFirstName VARCHAR(20), 
                                         IN strLastName VARCHAR(20), IN strDescription VARCHAR(200), 
                                         IN strWebSite VARCHAR(100), IN strEmail VARCHAR(75), 
                                         IN strLocation VARCHAR(20), IN strPassword VARCHAR(20), 
                                         IN strEncryptionKey VARCHAR(20))
BEGIN
	INSERT INTO USER (user_id, user_name, first_name, last_name, 
                      description, web_site, email, location, registration_date, pwd)
        VALUES (NULL, strUserName, strFirstName, strLastName, 
                      strDescription, strWebSite, strEmail, strLocation, NOW(), AES_ENCRYPT(strPassword,strEncryptionKey));
END$$

DROP PROCEDURE IF EXISTS yakimbe.getCurrentItems;
CREATE PROCEDURE yakimbe.`getCurrentItems`(IN startPosition INT, IN stopPosition INT)
BEGIN
  DECLARE resultSetLimit INT DEFAULT 0;
  DECLARE mostActiveLimit INT DEFAULT 0;
  DECLARE upwardsTrendingLimit INT DEFAULT 0;
  
  SET resultSetLimit = (stopPosition - startPosition);
  SET mostActiveLimit = (resultSetLimit * (3/4));
  SET upwardsTrendingLimit = (resultSetLimit * (1/4));
  
  
  SET @mostActiveResults := (SELECT i.item_id, u.user_name, u.user_id, i.submission_time, 
         i.rating, i.item_type, i.location, l.link_id, l.url, l.title
  FROM item i
      INNER JOIN link l
      ON l.item_id = i.item_id
      INNER JOIN user u
      ON u.user_id = i.user_id
      INNER JOIN action a
      ON a.item_id = i.item_id
    WHERE i.is_dead = false AND
          (i.submission_time >= DATE_SUB(CURDATE(), INTERVAL 2 WEEK))
    ORDER BY i.rating DESC);
    
  #SET @upwardsTrendingResults := CONCAT(getUpwardTrending(upwardsTrendingLimit));
  
  
  #SET SQL_SELECT_LIMIT = resultSetLimit;
  

END$$

DROP PROCEDURE IF EXISTS yakimbe.getMostActive;
CREATE PROCEDURE yakimbe.`getMostActive`(IN resultSetLimit INT)
BEGIN
  SET SQL_SELECT_LIMIT = resultSetLimit;

  SELECT i.item_id, u.user_name, u.user_id, i.submission_time, 
         i.rating, i.item_type, i.location, l.link_id, l.url, l.title
  FROM item i
      INNER JOIN link l
        ON l.item_id = i.item_id
      INNER JOIN user u
        ON u.user_id = i.user_id
    WHERE i.is_dead = false AND
          (i.submission_time >= DATE_SUB(CURDATE(), INTERVAL 2 WEEK))
    ORDER BY i.rating DESC;

  SET SQL_SELECT_LIMIT = default;

END$$

DROP PROCEDURE IF EXISTS yakimbe.getNewLinks;
CREATE PROCEDURE yakimbe.`getNewLinks`(IN resultSetLimit INT)
BEGIN
			SET SQL_SELECT_LIMIT = resultSetLimit;

			 SELECT i.item_id, u.user_id, u.user_name, i.submission_time, i.rating, i.item_type, i.location, l.link_id, l.url, l.title
			FROM item i
			  INNER JOIN link l
			  ON l.item_id = i.item_id
			  INNER JOIN user u
			  ON u.user_id = i.user_id
			WHERE i.is_dead = false
			ORDER BY submission_time DESC;

			  SET SQL_SELECT_LIMIT = default;
		END$$

		DROP PROCEDURE IF EXISTS yakimbe.getUpwardTrending;
CREATE PROCEDURE yakimbe.`getUpwardTrending`(IN resultSetLimit INT)
BEGIN
  SET SQL_SELECT_LIMIT = resultSetLimit;

SELECT DISTINCT i.item_id, i.submission_time, i.rating, 
         i.item_type, i.location, l.title, l.url, l.link_id, u.user_name, u.user_id, (SELECT count(a.item_id) from action a where a.item_id = i.item_id) num_actions
  FROM item i
      LEFT OUTER JOIN link l
        ON l.item_id = i.item_id
      LEFT OUTER JOIN user u
        ON i.user_id = u.user_id
      LEFT OUTER JOIN action a
        on a.item_id = i.item_id
    WHERE i.rating >= 0 AND
          i.is_dead = false AND
          EXISTS (SELECT a.action_id FROM action a WHERE a.item_id = i.item_id)
    ORDER BY num_actions DESC;
    
  SET SQL_SELECT_LIMIT = default;
END$$


DROP PROCEDURE IF EXISTS yakimbe.getUser;
CREATE PROCEDURE yakimbe.`getUser`(strUserName varchar(20), strPassword varchar(20), strEncryptionKey varchar(20))
BEGIN
	SELECT * 
  FROM user u
  WHERE u.user_name = strUserName AND
        AES_DECRYPT(u.pwd, strEncryptionKey) = strPassword;
END$$


DROP PROCEDURE IF EXISTS yakimbe.insertItem;
CREATE PROCEDURE yakimbe.`insertItem`(IN strUserName VARCHAR(20), IN strItemSubmissionType VARCHAR(10), IN strUserLocation VARCHAR(50))
BEGIN
			INSERT INTO  ITEM (item_id, user_id, submission_time, item_type, location)
						VALUES (NULL, (SELECT user_id  FROM USER WHERE user_name = strUserName),
								NOW(), strItemSubmissionType, strUserLocation);
		END$$

		
		DROP PROCEDURE IF EXISTS yakimbe.insertLink;
CREATE PROCEDURE yakimbe.`insertLink`(IN strUserName VARCHAR(20), IN strURL VARCHAR(100), IN strTitle VARCHAR(100))
BEGIN
			INSERT INTO LINK (link_id, item_id, url, title)
						VALUES (NULL, (SELECT MAX(item_id) FROM ITEM INNER JOIN USER ON USER.user_id = ITEM.user_id WHERE user_name = strUserName),
								strURL, strTitle);
		END$$

		DROP PROCEDURE IF EXISTS yakimbe.insertNewAction;
CREATE PROCEDURE yakimbe.`insertNewAction`(IN strUserName VARCHAR(20), IN strActionType VARCHAR(20), IN longItemId LONG)
BEGIN
			INSERT INTO ACTION (action_id, item_id, user_id, action_type, datetime)
						VALUES (NULL, longItemId, (SELECT u.user_id FROM user u WHERE strUserName = u.user_name), strActionType, NOW());
END$$

DROP PROCEDURE IF EXISTS yakimbe.insertNewAction;
CREATE PROCEDURE yakimbe.`insertNewAction`(IN strUserName VARCHAR(20), IN strActionType VARCHAR(20), IN longItemId LONG)
BEGIN
			INSERT INTO ACTION (action_id, item_id, user_id, action_type, datetime)
						VALUES (NULL, longItemId, (SELECT u.user_id FROM user u WHERE strUserName = u.user_name), strActionType, NOW());
END$$

DROP PROCEDURE IF EXISTS yakimbe.updateRating;
CREATE PROCEDURE yakimbe.`updateRating`(IN updatedRating INT, IN longItemId LONG)
BEGIN
  UPDATE item
  SET rating = (rating + updatedRating)
  WHERE item_id = longItemId;
END$$

DELIMITER ;

	
	
-- INITIAL BULLSHIT DATALOAD --

-- BEGIN INSERT STATEMENTS --

	
-- START COMMENTS --
/*
INSERT INTO ITEM (item_id, user_id, submission_time, item_type, location) VALUES (
	NULL,
	(SELECT user_id from user where user_name = "jbruce2112"), 
	NOW(), 
	"comment", 
	"lansing");
	
INSERT INTO COMMENT (comment_id, item_id, item_commenting_on_id, body) VALUES (
	NULL,
	(SELECT MAX(item_id) FROM ITEM WHERE user_id = (SELECT user_id FROM user WHERE user_name = "jbruce2112")),
	5,
	"You make a really great point Jesse"
	);

INSERT INTO ITEM (item_id, user_id, submission_time, item_type, location) VALUES (
	NULL,
	(SELECT user_id from user where user_name = "woodruffj2"), 
	NOW(), 
	"comment", 
	"lansing");
	
INSERT INTO COMMENT (comment_id, item_id, parent_comment_id, item_commenting_on_id, body) VALUES (
	NULL,
	(SELECT MAX(item_id) FROM ITEM WHERE user_id = (SELECT user_id FROM user WHERE user_name = "woodruffj2")),
	1,
	5,
	"Golly thanks John."
	);
	
INSERT INTO ITEM (item_id, user_id, submission_time, item_type, location) VALUES (
	NULL,
	(SELECT user_id from user where user_name = "jbruce2112"), 
	NOW(), 
	"comment", 
	"lansing");
	
INSERT INTO COMMENT (comment_id, item_id, parent_comment_id, item_commenting_on_id, body) VALUES (
	NULL,
	(SELECT MAX(item_id) FROM ITEM WHERE user_id = (SELECT user_id FROM user WHERE user_name = "jbruce2112")),
	1,
	5,
	"I'm having a lot of fun on this site."
	);
	
INSERT INTO ITEM (item_id, user_id, submission_time, item_type, location) VALUES (
	NULL,
	(SELECT user_id from user where user_name = "woodruffj2"), 
	NOW(), 
	"comment", 
	"lansing");
	
INSERT INTO COMMENT (comment_id, item_id, item_commenting_on_id, body) VALUES (
	NULL,
	(SELECT MAX(item_id) FROM ITEM WHERE user_id = (SELECT user_id FROM user WHERE user_name = "woodruffj2")),
	5,
	"This comment should be the same level as John's. No parent comment."
	);
*/