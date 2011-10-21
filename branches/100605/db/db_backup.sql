-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.37-1ubuntu5.1-log


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

CREATE DATABASE IF NOT EXISTS yakimbe;
USE yakimbe;
CREATE TABLE  `yakimbe`.`action` (
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
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8;
INSERT INTO `yakimbe`.`action` VALUES  (91,'upvote',223,33,'2010-03-04 22:06:21'),
 (96,'downvote',227,9,'2010-03-04 22:08:25'),
 (97,'downvote',224,9,'2010-03-04 22:08:34'),
 (98,'downvote',233,9,'2010-03-04 22:11:24'),
 (99,'upvote',233,33,'2010-03-04 23:10:18'),
 (100,'downvote',237,9,'2010-03-05 07:12:29'),
 (101,'downvote',232,9,'2010-03-05 07:57:26'),
 (102,'upvote',235,9,'2010-03-05 07:57:39'),
 (103,'upvote',236,9,'2010-03-05 08:17:56'),
 (104,'upvote',244,33,'2010-03-05 17:15:18'),
 (105,'downvote',244,9,'2010-03-05 17:19:53'),
 (106,'downvote',239,9,'2010-03-05 17:19:57'),
 (107,'downvote',244,35,'2010-03-05 19:23:46'),
 (108,'downvote',247,9,'2010-03-06 02:33:27'),
 (110,'downvote',249,9,'2010-03-06 02:54:03'),
 (111,'upvote',250,9,'2010-03-06 02:54:04'),
 (112,'downvote',243,9,'2010-03-06 19:44:50'),
 (113,'upvote',245,9,'2010-03-06 20:15:25'),
 (114,'upvote',254,9,'2010-03-06 21:33:43'),
 (115,'upvote',254,37,'2010-03-07 00:01:57'),
 (116,'upvote',255,9,'2010-03-07 12:45:21'),
 (117,'upvote',258,9,'2010-03-07 19:32:35');
INSERT INTO `yakimbe`.`action` VALUES  (118,'upvote',262,9,'2010-03-07 19:32:48'),
 (119,'upvote',264,9,'2010-03-07 23:28:40'),
 (120,'upvote',271,40,'2010-03-08 15:08:59'),
 (121,'upvote',270,40,'2010-03-08 15:09:03'),
 (122,'upvote',265,40,'2010-03-08 15:09:06'),
 (123,'upvote',230,40,'2010-03-08 15:10:22'),
 (124,'upvote',262,40,'2010-03-08 15:10:29'),
 (125,'downvote',271,9,'2010-03-08 15:51:07'),
 (126,'upvote',219,37,'2010-03-08 22:31:03'),
 (127,'upvote',274,9,'2010-03-09 08:28:46'),
 (128,'upvote',219,9,'2010-03-09 08:28:48'),
 (129,'downvote',277,9,'2010-03-09 10:19:06'),
 (130,'upvote',279,9,'2010-03-09 12:19:04'),
 (131,'upvote',270,45,'2010-03-09 16:54:57'),
 (132,'downvote',283,45,'2010-03-09 17:12:34'),
 (133,'downvote',287,45,'2010-03-09 17:12:46'),
 (134,'downvote',286,45,'2010-03-09 17:12:50'),
 (135,'downvote',285,45,'2010-03-09 17:12:53'),
 (136,'downvote',284,45,'2010-03-09 17:12:55'),
 (137,'upvote',206,45,'2010-03-09 17:13:13'),
 (138,'upvote',211,45,'2010-03-09 17:16:13'),
 (139,'upvote',230,45,'2010-03-09 17:17:17');
INSERT INTO `yakimbe`.`action` VALUES  (140,'upvote',216,45,'2010-03-09 17:17:23'),
 (141,'downvote',209,45,'2010-03-09 17:17:39'),
 (142,'upvote',212,45,'2010-03-09 17:26:39'),
 (143,'upvote',255,45,'2010-03-09 17:28:30'),
 (144,'upvote',256,45,'2010-03-09 17:28:41'),
 (145,'downvote',290,45,'2010-03-09 17:28:56'),
 (146,'upvote',280,37,'2010-03-09 22:04:25'),
 (147,'downvote',291,9,'2010-03-10 07:26:31'),
 (148,'downvote',294,9,'2010-03-10 09:48:26'),
 (149,'downvote',270,9,'2010-03-10 09:48:33'),
 (150,'downvote',267,9,'2010-03-10 09:48:54'),
 (151,'downvote',280,9,'2010-03-10 09:49:01'),
 (152,'upvote',295,9,'2010-03-10 09:51:42'),
 (153,'upvote',300,9,'2010-03-10 16:13:07'),
 (154,'upvote',303,9,'2010-03-11 08:13:55'),
 (155,'upvote',304,9,'2010-03-11 08:16:31'),
 (156,'downvote',306,9,'2010-03-11 11:53:29'),
 (157,'upvote',308,9,'2010-03-11 11:53:30'),
 (158,'downvote',297,9,'2010-03-11 11:53:39'),
 (159,'upvote',312,9,'2010-03-11 12:12:05'),
 (160,'upvote',314,9,'2010-03-12 07:19:35'),
 (161,'upvote',306,45,'2010-03-12 10:18:47');
INSERT INTO `yakimbe`.`action` VALUES  (162,'upvote',323,9,'2010-03-12 12:50:38'),
 (163,'upvote',315,9,'2010-03-12 12:50:39'),
 (164,'downvote',318,9,'2010-03-12 12:51:00'),
 (165,'upvote',325,9,'2010-03-13 11:16:54'),
 (168,'upvote',333,9,'2010-03-15 08:18:14'),
 (169,'upvote',332,9,'2010-03-15 08:18:22'),
 (170,'upvote',335,9,'2010-03-15 08:23:15'),
 (171,'downvote',338,9,'2010-03-15 08:57:33'),
 (172,'upvote',330,50,'2010-03-15 10:46:58'),
 (173,'upvote',333,50,'2010-03-15 10:47:22'),
 (174,'upvote',335,50,'2010-03-15 10:49:03'),
 (176,'upvote',344,37,'2010-03-15 23:44:29'),
 (177,'upvote',344,9,'2010-03-16 07:13:24'),
 (178,'upvote',347,9,'2010-03-16 07:23:55'),
 (179,'downvote',345,35,'2010-03-16 22:15:45'),
 (180,'downvote',340,35,'2010-03-16 22:15:59'),
 (181,'downvote',343,35,'2010-03-16 22:16:12'),
 (182,'upvote',338,35,'2010-03-16 22:16:30'),
 (183,'upvote',316,35,'2010-03-16 22:16:51'),
 (184,'upvote',306,35,'2010-03-16 22:23:33'),
 (185,'upvote',351,9,'2010-03-17 07:45:52'),
 (186,'upvote',353,9,'2010-03-17 07:47:45');
INSERT INTO `yakimbe`.`action` VALUES  (187,'downvote',354,9,'2010-03-17 08:06:21'),
 (188,'upvote',351,40,'2010-03-17 11:17:50'),
 (189,'upvote',354,40,'2010-03-17 11:18:45'),
 (190,'upvote',351,37,'2010-03-17 12:15:31'),
 (191,'upvote',357,37,'2010-03-17 12:15:39'),
 (192,'upvote',356,9,'2010-03-17 12:21:45'),
 (193,'upvote',364,37,'2010-03-17 12:53:42'),
 (195,'upvote',338,56,'2010-03-17 13:22:25'),
 (197,'upvote',360,57,'2010-03-17 15:16:18'),
 (198,'upvote',337,57,'2010-03-17 15:20:16'),
 (199,'downvote',375,9,'2010-03-17 16:57:50'),
 (200,'upvote',378,9,'2010-03-17 17:59:41'),
 (201,'upvote',376,9,'2010-03-17 18:00:30'),
 (202,'upvote',368,9,'2010-03-17 18:01:46'),
 (203,'upvote',371,37,'2010-03-17 18:10:26'),
 (206,'upvote',380,37,'2010-03-17 18:18:38'),
 (207,'upvote',381,9,'2010-03-17 18:53:36'),
 (208,'upvote',375,37,'2010-03-17 19:35:54'),
 (209,'upvote',373,9,'2010-03-17 20:03:19'),
 (210,'upvote',383,9,'2010-03-18 07:04:14'),
 (213,'upvote',385,9,'2010-03-18 07:24:07'),
 (214,'upvote',388,9,'2010-03-18 07:24:14'),
 (216,'downvote',330,9,'2010-03-18 07:26:27');
INSERT INTO `yakimbe`.`action` VALUES  (218,'upvote',386,9,'2010-03-18 13:04:14'),
 (219,'downvote',364,9,'2010-03-18 13:04:23'),
 (220,'upvote',389,9,'2010-03-18 16:24:36'),
 (221,'upvote',391,9,'2010-03-18 16:31:12'),
 (222,'downvote',337,33,'2010-03-18 17:07:43'),
 (223,'downvote',335,33,'2010-03-18 17:07:54'),
 (224,'downvote',389,33,'2010-03-18 17:07:59'),
 (225,'downvote',332,33,'2010-03-18 17:08:11'),
 (229,'upvote',356,37,'2010-03-18 17:23:57'),
 (230,'upvote',388,37,'2010-03-18 17:52:06'),
 (231,'upvote',386,37,'2010-03-18 17:53:32'),
 (232,'upvote',390,9,'2010-03-18 18:42:39'),
 (233,'downvote',392,37,'2010-03-18 20:25:31'),
 (234,'upvote',396,9,'2010-03-18 23:07:54'),
 (235,'upvote',398,9,'2010-03-19 07:08:25'),
 (236,'upvote',402,9,'2010-03-19 12:29:12'),
 (237,'upvote',403,9,'2010-03-19 16:52:58'),
 (238,'upvote',408,9,'2010-03-20 18:05:55'),
 (239,'upvote',410,9,'2010-03-21 12:15:26'),
 (240,'upvote',411,9,'2010-03-22 07:26:01'),
 (241,'upvote',412,9,'2010-03-22 11:50:42'),
 (242,'upvote',415,9,'2010-03-22 12:05:16');
INSERT INTO `yakimbe`.`action` VALUES  (243,'upvote',417,9,'2010-03-23 09:25:24'),
 (244,'upvote',421,9,'2010-03-24 07:05:12'),
 (245,'upvote',422,9,'2010-03-24 07:11:30'),
 (246,'upvote',424,9,'2010-03-24 08:10:43'),
 (247,'upvote',425,9,'2010-03-24 08:18:22'),
 (248,'upvote',432,9,'2010-03-24 11:54:14'),
 (249,'upvote',430,9,'2010-03-24 11:54:19'),
 (250,'upvote',435,9,'2010-03-24 12:01:45'),
 (251,'upvote',436,9,'2010-03-24 13:07:41'),
 (252,'upvote',439,9,'2010-03-24 19:00:16'),
 (254,'downvote',439,35,'2010-03-24 21:28:06'),
 (255,'downvote',440,35,'2010-03-24 21:28:10'),
 (256,'upvote',432,35,'2010-03-24 21:28:20'),
 (257,'upvote',425,35,'2010-03-24 21:28:33'),
 (258,'upvote',444,9,'2010-03-25 07:56:02'),
 (259,'upvote',445,9,'2010-03-25 08:11:42'),
 (260,'upvote',448,9,'2010-03-25 13:09:04'),
 (263,'upvote',444,45,'2010-03-25 14:35:17'),
 (264,'upvote',452,9,'2010-03-25 23:08:23'),
 (265,'upvote',456,9,'2010-03-26 09:09:36'),
 (266,'upvote',455,9,'2010-03-26 11:04:04'),
 (267,'upvote',458,9,'2010-03-26 11:06:53'),
 (268,'upvote',460,9,'2010-03-26 14:54:02');
INSERT INTO `yakimbe`.`action` VALUES  (269,'upvote',461,9,'2010-03-26 14:55:41'),
 (270,'upvote',464,9,'2010-03-26 20:09:00'),
 (271,'upvote',465,9,'2010-03-26 20:28:32'),
 (272,'upvote',467,9,'2010-03-26 20:32:37'),
 (273,'upvote',466,9,'2010-03-26 20:32:38'),
 (274,'upvote',469,9,'2010-03-26 20:34:28'),
 (275,'upvote',468,9,'2010-03-26 20:34:29'),
 (276,'upvote',470,9,'2010-03-26 20:37:37'),
 (277,'upvote',471,9,'2010-03-26 20:37:38'),
 (278,'upvote',472,9,'2010-03-26 20:37:40'),
 (279,'upvote',475,9,'2010-03-26 20:40:52'),
 (280,'upvote',474,9,'2010-03-26 20:40:54'),
 (281,'upvote',473,9,'2010-03-26 20:40:54');
CREATE TABLE  `yakimbe`.`beta` (
  `beta1_user_count` int(3) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
INSERT INTO `yakimbe`.`beta` VALUES  (34);
CREATE TABLE  `yakimbe`.`comment` (
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
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;
INSERT INTO `yakimbe`.`comment` VALUES  (1,212,211,'Still haven\'t gotten out to this place but this review lowered my expectations slightly. It seems like, at the least, they have an interesting menu. ',NULL),
 (2,213,206,'History: Matthew Macon allegedly killed as many as seven women in the Lansing area, including LCC professor Carolyn Kronenberg, for which Claude McCollum was wrongly tried and convicted for. McCollum\'s sentence was overturned in early 2008. \r\n\r\nMacon is the primary suspect in a string of killings in the fall of 2007 that left 5 women dead, including Lansing city councilwoman Carol Wood\'s mother.\r\n\r\nMacon was charged and convicted for the murder of 2 of those women and is currently serving a life sentence. Ingham County Prosecutor Stuart Dunnings III announced Monday that his office will not prosecute the other cases.',NULL),
 (3,214,203,'Has anyone read this?  Looks like a small publisher, but it is available on Amazon (http://www.amazon.com/Somewhere-Sand-Timbuktu-Chris-Berggren/dp/1440163642/).  Timbuktu was recently in the news because of a stampede near a mosque which killed 26.',NULL),
 (4,218,203,'No, can\'t say that I have. It would be an interesting read though, I\'ve always wondered how people manage to do crazy things like this. Of course it would have to start in a bar... ',3);
INSERT INTO `yakimbe`.`comment` VALUES  (5,220,219,'I saw this program posted on google awhile ago and was hoping that our area would apply for this. I think it has the potential to seriously transform the area, similar to how canals and railroads transformed economies years ago.',NULL),
 (6,225,224,'This whole thing seem ridiculous to me. I heard the E.L. police referred to this as an IED (improvised explosive device) like it was Iraq or something. Come on, this was just stupid college kids doing stupid things. \r\n\r\nAt least they aren\'t facing jail time or anything ridiculous like that. ',NULL),
 (7,228,227,'I, for one, think this is a great idea. Everytime I try and cross Saginaw or Oakland I feel like I\'m in frogger with a wall of traffic charging at me. It would be nice to see some east-side like flavor move into the west-side businesses in this corridor as well; maybe a change like this would encourage that.',NULL),
 (8,229,223,'Wow, that\'s huge. The first round of jobs they were hiring for were crap. Not that I was terribly qualified at the time, but the salary they offered was very poor and the terms were \'temporary position, from 12-36 months.\' I\'m not sure if that\'s standard IBM practice, but as the recruiter explained it, they were looking to keep a constant flow of college grads moving through the place. \r\n\r\nHopefully (and it sounds like this is the case) these jobs are a bit more permanent, experienced positions. That\'s great. It\'s really good for the region to have IBM here and growing their operations.',NULL),
 (9,236,233,'Interesting. I know Mac\'s Bar has had \"Neon Tuesdays\" for a while. (Every Tuesday @ 9 pm. Free) I\'m not sure if they have live bands, but they have electronic music / dancing, and attract the MSU crowd.\r\n\r\nAlso, \"Beatloaf\" has to be the best stage name I\'ve ever heard.',NULL);
INSERT INTO `yakimbe`.`comment` VALUES  (10,241,233,'I\'ve never been to club x-cel, nor have I been to an \'electronic music night\' (back in my day, we used to call them \'raves\') since, oh, 1999, but what the hell. Maybe I\'ll use this as an excuse to check out the club. all I can say is it better not be a bunch of dudes standing behind their macbooks. \r\rYou can\'t call yourself a DJ if you\'re not actually jockeying discs, can you?',9),
 (11,245,244,'Just to clarify, he is not a member of Flogging Molly.  He is touring with them, and they are playing at the Fillmore in Detroit on Saturday.',NULL),
 (12,251,244,'Daaah! didn\'t read it close enough. Thanks for the clarification. ',11),
 (13,252,250,'Welcome, please check out our news and updates blog here at blog.yakimbe.com, and come back often to try out new features! ',NULL),
 (14,255,254,'Wine Tasting Event\r\nALL proceeds To benefit the Capital Area Humane Society\r\n*Sponsored by Northwood University&#8217;s Lansing Alumni Chapter*\r\nSaturday March 27, 2010 3-6pm\r\nCountry House Catering in Okemos (formerly Golden Rose)\r\nFeaturing Burgdorf Wineries array of wines\r\n$20 in advance, $25 at the door\r\n**Price includes appetizers & raffle prizes, tasting tickets & cash bar available**\r\n \r\nPayment can be made to Nicole Murphy:\r\n10720 Ireland Dr.\r\nGrand Ledge, MI 48837\r\n Questions?  517-303-5006 or coleymurphy@hotmail.com\r\n',NULL),
 (15,256,254,'This sounds like a great event. How much are you hoping to raise, and can people still make donations if they can\'t attend?',14);
INSERT INTO `yakimbe`.`comment` VALUES  (16,268,267,'I\'ve never really decided how I feel about casinos. They kind of seem like the easy way out, but then again they do draw lots of people. \r\n\r\nHowever, that said, I think the novelty is wearing off. Now Ohio has legalized casinos, and I think other areas will too. They\'ll probably not be as big a draw as this continues.',NULL),
 (17,269,211,'There\'s a lot that\'s promising about this restaurant, but more than the quality of the food, what they need to work on most is evening out the service experiences. Some have been absolutely stellar and others -- like the one where I had to get up from the table and find a manager -- have been near-deal-breakers for us. I contend that fabulous atmosphere and terrific, professional service could carry them a long way as they work out any menu kinks.',NULL),
 (18,272,271,'That\'s a bummer. I was glad to see that the men spanked Michigan though. Hopefully they can keep that up! \r\n\r\nAlso, welcome to Yakimbe!',NULL),
 (19,273,270,'You know, I\'ve often wondered about where the homeless spend there day, especially in the bitter cold of winter. I\'ve noticed the library is a haven for some, but I imagine they probably don\'t let them hang out for too long, given the \'these tables are for reading\' signs. \r\n\r\nIt\'s good to know there\'s a place in town to provide for them. Does the V of A serve a function like this as well, or is it one of the \'you\'re done eating, now leave\' places... ?\r\n\r\nIt seems like Michigan would be a very difficult place to be homeless.',NULL);
INSERT INTO `yakimbe`.`comment` VALUES  (20,274,219,'Citizens can nominate Lansing here\r\r http://www.google.com/appserve/fiberrfi/public/options/',NULL),
 (21,276,219,'Awesome! Thanks for posting this. Everyone that has any interest in seeing the Lansing area continue to grow needs to go and nominate our town for this program. \r\rSince Larry Page is an East Lansing native, we could have a chance, but we\'re going to have to compete with the home of his alma mater (that, of course, being Ann Arbor...)',20),
 (22,278,277,'I just completed this - be sure to mention the growing tech sector in Lansing, including LiquidWeb, TechSmith, NioWave, MSU, IBM\'s Global Delivery Center, the state Government\'s 1500+ IT workers, as well as the coming particle accelerator project (the FRiB) at MSU. \r\n\r\nGigabit fiber in Lansing would be a great draw for more tech-sector businesses and has the potential to give our local economy a great boost. ',NULL),
 (23,282,281,'I like the idea of buying local, but I am usually deterred by the high price tags. What are the prices like?',NULL),
 (24,289,211,'Ughh totally agree the food was really good but totally overpriced. And if you have a large party forget it, it took over an hour just to get drinks before they even took our order!',NULL);
INSERT INTO `yakimbe`.`comment` VALUES  (25,290,254,'This sounds good, hoping to make it!',NULL),
 (26,292,291,'Has anyone heard of or been to something like this before? I\'m interested in meeting more people around here interested in coding etc, and this sounds like a great idea, but I\'d like to know a little more about what to expect before signing up. ',NULL),
 (27,295,294,'Hopefully this trend keeps up. I heard on Michigan Radio this morning that when you include those whose benefits have run out but are still seeking employment, or are working part-time but are seeking full-time, this rate is something like 21.9%. That\'s nearly 1/4 of the state out of work or underemployed. That\'s insanely high, especially when you consider that\'s an average!',NULL),
 (28,298,297,'Man, I wish I was on this trip. Sounds like so much fun. Here\'s the blog post from GM about the challenge: \r\n\r\nhttp://teamlansingsxsw.tumblr.com/',NULL),
 (29,299,297,'Darn it I\'m having URL issues today. Here\'s the one I really wanted to post: \r\rhttp://fastlane.gmblogs.com/archives/2010/02/chevrolets_sxsw_road_trip_challenge.html',28),
 (30,301,291,'No, but it sounds awesome. It would be super-cool if we could do this. Maybe get Sparty to join us... ',26);
INSERT INTO `yakimbe`.`comment` VALUES  (31,304,219,'Looks like Granholm is jumping on the bandwagon to try and make this happen, she met with Larry and asked him to bring their fiber to Michigan. Hopefully Lansing wins over Ann Arbor. Go Green!\r\n\r\nhttp://www.lansingstatejournal.com/article/20100311/NEWS01/303110027/',NULL),
 (32,309,306,'Stories like this always make me cringe. I commute 2 miles on my bike in the summer, and you have to be aware of absolutely everything around you. I\'ve had cars pull out in front of me, try to pass me when there wasn\'t room and more.  This town needs to better plan for cyclists and pedestrians as valid modes of transportation or stories like this will continue to happen. ',NULL),
 (33,317,316,'So sad, we need more bike lanes in Lansing. Drivers have to be aware that we have to share the road, and please, please, please for the safety of everyone bike riders need to wear helmets at all times!',NULL),
 (34,319,318,'Scary!',NULL),
 (35,320,318,'Maybe, but what does it really mean? It would be nice to have a few more details, other than \'provided disingenuous information.\' What is that? \r\rI suppose this is probably related to the underwear bomber incident? I remember hearing they didn\'t follow any sort of protocol in that incident, taxing the full plane right up to the terminal with a potential bomb on board, but it doesn\'t really say that. \r\rAnyone know more about the back-story to this article?',34),
 (36,321,314,'Duplicate - see http://www.yakimbe.com/submission/316',NULL);
INSERT INTO `yakimbe`.`comment` VALUES  (37,322,316,'Yup, more bike lanes, better sidewalks are needed in many areas. I\'m glad the Walk Bike Lansing plan was voted into effect, it should be interesting to see how it\'s implemented with this summer\'s CSO construction on West Saginaw. Check out the page here: \r\rhttp://www.nwlansing.org/westsidealliancenews.html\r\rI know city councilwoman and Walk Bike Lansing advocate Jessica Yorko was seeking input on a pedestrian and bike plan that included reducing Saginaw and/or Oakland streets to three lanes, to make room for streetscaping and bike lanes. ',33),
 (38,323,315,'Lansing\'s bus system is excellent, I know they\'ve won several national awards for a great system and good service in the mid-size city category. We\'re lucky to have such solid system, mostly because it serves MSU so heavily I would bet. I live right on the 1 line on Michigan Avenue and it\'s great to be able to jump on the bus and be in downtown Lansing or on campus in just a few minutes. ',NULL),
 (39,326,325,'This was frustrating to watch. If they just could have made their free throws...',NULL);
INSERT INTO `yakimbe`.`comment` VALUES  (40,331,330,'Hopefully they\'ll play better than they did Saturday. Sheesh.',NULL),
 (41,339,338,'Wish them a happy birthday by tagging your tweet #biggby, or check out the stream here: http://twitter.com/#search?q=%23Biggby',NULL),
 (42,341,330,'Definitely... But I doubt they will go past the second round the way they have been playing.',NULL),
 (43,342,330,'Agreed. I was surprised they were seeded so high, honestly, but they did have a pretty good season. Well, until they started losing that is.',42),
 (44,346,344,'Yikes! Rabid horses - that\'s crazy. From what I remember of previous rabies reports, this is pretty unusual. ',NULL),
 (45,348,347,'Last winter I was actually thinking it would be a great thing if Lansing had an outdoor ice skating rink somewhere. I was actually looking to go, and the only one I could find in the area was one at Washington park, which (I believe) is indoors. This would be a great addition to the downtown. ',NULL),
 (46,349,345,'OK, I am a sucker for pastries, but the 3 varieties I sampled from this place were sub-par.  You have to realize that it is located in a former Bell\'s Pizza which is sharing a roof with a gas station.',NULL),
 (47,350,345,'They do offer bacon brownies though. And they deliver!',46);
INSERT INTO `yakimbe`.`comment` VALUES  (48,352,351,'I have been waiting for these guys to reopen since forever! I was worried it was never going to happen. Hooray!',NULL),
 (49,355,354,'Though this may belong on meta.yakimbe.com (coming soon?), our first real press is exciting!',NULL),
 (50,357,351,'We went last night for a pre-St. Patrick\'s Day dinner. It looks virtually identical to the old place (similar layout, same bar), so if you need your fix, you\'re good to go. One disappointment: They\'re still a smoking bar. I figured opening this close to the May 1 ban, they\'d skip the smoking option completely.',NULL),
 (51,358,351,'Yea, that\'s exactly what I need! I kept looking in the window, and it does look eerily familiar.  I think they just picked everything up and plopped it down in the new building. \r\rSo weird that they wouldn\'t just go no-smoking immedately. Seems like MBC has had a good amount of success with that tactic, and I know that new Tin Can place by Harem is no-smoking now too. \r\rI suppose after being closed for nearly a year they\'re just anxious to get their customers back though. I can\'t believe they could afford to close up shop for that long. ',50),
 (52,359,354,'Yea, maybe :) it is cool to see though, no? ',49);
INSERT INTO `yakimbe`.`comment` VALUES  (53,360,353,'I really can\'t wait to see this building take shape. I think it\'s going to be one of those buildings that people either love or hate, and will probably mostly hate just because it\'s not a colonial-style brick building. Which is exactly why I love it already. \r\n\r\nThe architect, London-based Zaha Hadid, is world renowned for her unique structures and this is only her second project in the U.S. This area needs some unique architecture to help us define who we are in the 21st century, and this is a great start. ',NULL),
 (54,361,351,'Thanks for the info. I\'ll definitely have to plan a trip out there soon. What is their front patio space like? It looks like it\'s a smaller area than what they had before, but it\'s hard to tell without tables set up and everything.',50),
 (55,362,356,'You know, this is one of those places that is so close to my house I forget about it when I\'m thinking of places to go. The one time we stopped, I don\'t think they had any open tables, so this is a great thing! Especially for that block of Michigan Avenue. I would love to see more news like this for that stretch between downtown and East Lansing.',NULL),
 (56,365,364,'Interesting, but I wonder how much \'adventure travel\' there really is in the Lansing area - we don\'t really have steep mountains or anything particularly scenic (given other not-so-far off destination) to make people choose Lansing as a destination. \r\n\r\nI can, however, see how highlighting this kind of stuff could help morale in the area.',NULL);
INSERT INTO `yakimbe`.`comment` VALUES  (57,366,364,'I looked into this company a little bit and they sound awesome. They have about 5 different locations around the state. It looks like they are sponsoring one of five trebuchets (old fashioned catapults) in a competition out at MSU in May.\r\n\r\nhttp://www.greenplanetextreme.com/index.html ',NULL),
 (58,367,351,'Went last night for cherry burger and green beer.  Same vibe as former location.  Definitely high on the list for \"pub and grub\" night out.',NULL),
 (59,368,356,'OUTSTANDING news!  Soup Spoon is a favorite on my lunch list.  Also a great place for Saturday brunch.  Seating has always been a problem if you get there after 12pm.  Hopefully the expansion will solve that problem.  Just be sure to staff accordingly.  Service can sometimes be a bit slow.',NULL),
 (60,369,347,'Could be a nice addition to downtown Lansing; however, the rink at the Stadium was never well attended.  I realize that was partly a weather-related problem with keeping the rink frozen.  I hope someone did their advance research.',NULL),
 (61,370,338,'Happy Birthday Biggby!  Congrats to Biggby Bob and the whole gang.  Keep up it!',NULL);
INSERT INTO `yakimbe`.`comment` VALUES  (62,371,364,'Very cool.  We may landlocked without convenient access to the Great Lakes, but the Lansing area has outstanding outdoor offerings.  Hopefully this new endeavor will shine a spotlight on yet another reason to get out and about in Greater Lansing.',NULL),
 (63,372,306,'Very sad indeed.  Yet another example of why the Complete Streets project is so important.',NULL),
 (64,373,353,'Yesterday\'s groundbreaking was an exciting step forward.  Eloquent remarks by Pres. Simon, Eli Broad, Governor Granholm, Zaha Hadid, and others.  I\'m keeping my fingers crossed that the vision for the museum truly becomes a reality and isn\'t compromised by cost overruns or construction delays.',NULL),
 (65,374,329,'The English Inn is a bit of a hike for those of us who live in Lansing\'s urban center, but its well worth the drive.  Outstanding brunch.  Ask to be seated in the sunroom.  Don\'t forget to check out the English Pub in the lower level.  The Library room in the lower level is also a great location for staff retreats.',NULL),
 (66,376,356,'I keep meaning to go to Soup Spoon - they do such a good job marketing themselves. Hopefully they\'ll open for dinner at some point, it\'s tough to make it off campus during the day when I have classes to get lunch in Lansing. ',NULL);
INSERT INTO `yakimbe`.`comment` VALUES  (67,377,351,'So happy! Definitely dropping by for a celebratory drink tonight. It only seems appropriate to go to an Irish pub on St. Patty\'s anyway.',NULL),
 (68,378,364,'Dying to try the Bike-Row-Brew. Optimistically, highlighting this kind of stuff can help draw a larger audience, which can draw more of it to the area ... I hope Over the Edge comes back. Wanted to join in, but gotta be out of state that day.',NULL),
 (69,379,375,'Great post. I\'ve been thinking about this same thing actually. I grew up in Northeastern Ohio, near Canton. That whole corner of the state is pretty much urban sprawl from Cleveland. Not a ton of character, lots of box stores and chains. \r\n\r\nI also lived in Staunton, Virginia for 2 years. Staunton was a very small, touristy southern town with lots of Victorian charm. They have a replica of Blackfriars playhouse, with a Shakespeare program to match, which fits right in with the antique shops and yearly Victorian Festival. Lots of character, but once you\'re around awhile, not really that much there (from an urban perspective, at least) either.\r\n\r\nWhat does Lansing have? Lansing is unique in that it\'s a good-sized metro area (upwards of 500,000 in the msa, I believe) but it\'s still its own little urban-island in a sea of farmland. We don\'t have six lane highways or hour-and-a-half waits at Olive Garden like we did in Ohio, but we have -far- more choices and diversity than Virginia. We have the chain stores and strip malls, but we have a whole lot of successful small businesses too. And I think that\'s what makes us unique. \r\n\r\nOn first impression, Lansing may not seem like much, but stick around, and you notice there\'s a lot there, just underneath the surface. This is a town full of people that know how to weather tough times, and are starting to realize that this town, ... you know,  this towns pretty cool. ',NULL),
 (70,380,364,'That sounds like an insane amount of fun, actually. I\'d have to really whip myself into shape if I was going to attempt any of this stuff I think!',68);
INSERT INTO `yakimbe`.`comment` VALUES  (71,381,375,'Thanks! I definitely agree that there\'s something beneath the surface in this place. I think it\'s mostly the people. All of a sudden, everyone\'s got a spring in their step. I wonder how that got started. Either way, it\'s really cool. I love this place. I just wish we could articulate a clear compelling brand. Maybe that\'s what\'s so cool about this place. It\'s cool despite a lot of factors working against it. People fiercely love this place anyway, and that love has increased exponentially in the past year. It\'s a mystery!',NULL),
 (72,382,375,'Yea, it does seem like people are a bit more upbeat about the area lately. It\'s good to hear someone else say that, cause I thought maybe I was just being unfairly negative about Lansing for the past, oh, three years.\r\n\r\nBut it seems like there\'s a lot of great projects happening right now, from the fancy-modern art museum to the Ottawa Power Station -finally- getting a tenant after 20 year to the new city market that make downtown feel alive. It\'s wonderful.',71),
 (73,383,375,'Right! There\'s *so much* going on right now. I might have a skewed perspective because I\'m new, and I\'m a student, but over the past year a lot has changed. The TIC and the Hatch in Lansing, YSG, gumball, Lansing Breakfast, Ignite, TEDxLansing, and the list goes on.',72);
INSERT INTO `yakimbe`.`comment` VALUES  (74,387,386,'I was going to link to the original article from the Leslie Weekly Guardian, until I realized it was a PDF of the entire paper! If you\'re interested, you can find it on page 4: \r\n\r\nhttp://www.theleslieweeklyguardian.com/volume%202%20issue%2021/Guardian%20March%209%202010%20Layout%201.pdf',NULL),
 (75,392,354,'JOHN BRUCE! JOHN BRUCE!',NULL),
 (76,393,390,'Definitely a good idea. People all over drive to Indiana and spend thousands that they could be spending here in MI.',NULL),
 (77,395,390,'I know. Consider the irony of the recent case in East Lansing, where several college students were charged with (I believe) felony counts of some sort for tossing a (currently) illegal firework into someone\'s front yard. They could still be on probation when these \'illegal explosive devices\' become legal in the state. ',76),
 (78,397,396,'I really don\'t know how I feel about this. On one hand, it would be great to see Michigan as progressive, as well as get clean energy. But on the other hand, it\'s hard to imagine how these 30 story towers would affect the lake. I don\'t think the worries about fishing are well founded, if anything I would think these towers might actually create good fishing grounds...',NULL),
 (79,404,403,'It\'s great to see another live music venue in downtown Lansing. I have to say I am very un-impressed with the space at the new Small Planet (not to mention it\'s awful location), so I hope this goes over big. ',NULL);
INSERT INTO `yakimbe`.`comment` VALUES  (80,407,406,'The story says the last time they increased tuition was 2007 so I suppose it\'s time. LCC is so affordable and really a great college, I hope these budget shortfalls don\'t change that. ',NULL),
 (81,414,413,'Ha - this is pretty awesome actually. here\'s the clip of her laying the smack down on YouTube: http://www.youtube.com/watch?v=3Jj6pqajvB8',NULL),
 (82,416,415,'Like it or not, this health care bill is progress. It may not be perfect, and it surely will need tweaked, but getting this passed is, I believe, an important part of this country growing up and accepting responsibility for it\'s citizens.\r\n\r\nThe last thing Michigan needs is to be exempted from this. ',NULL),
 (83,423,422,'This whole deal sounds kind of shady to me. I feel sorry for the owner of the hangar. If the president of a local college signed a contract with me, I\'d be pretty confident that the deal was done and I -basically- had money in the bank. \r\n\r\nOn the other hand, what is Knight doing, running around signing $160,000 contracts without any sort of approval? Their purchasing process must be awful, or Knight just has no idea what he\'s doing. ',NULL),
 (84,427,424,'This is excellent! But... this isn\'t going to be that crazy power-yoga you were talking about, is it? That stuff kind a frightens me, and I think I hurt my knee -trying- to jog yesterday. *sound of tiny violin playing*',NULL);
INSERT INTO `yakimbe`.`comment` VALUES  (85,428,425,'What a great story. I can\'t imagine doing this myself, let alone with macular degeneration, at retirement age. We should all be so active. \r\n\r\nMy one question is: the story AND the photo say she\'s 62, but in her quote it says 64. Wonder which is right? Either way, she\'s got a good, oh, 30+ years on me. Impressive. ',NULL),
 (86,433,432,'Dude - it\'s about time we got a sonic! I know it\'s not a mecca for locavores or the slow food movement or anything, but... It\'s sonic! A round of root beer floats for everyone!',NULL),
 (87,434,430,'That\'s impressive, especially in this sector. I believe I remember hearing that even Home Depot and the box stores were starting to hurt their for awhile. \r\n\r\nIt\'s good to see a company that\'s not afraid to invest in itself and develop some new strategies. ',NULL),
 (88,437,424,'Yes, it\'s power yoga, yoga to empower you! You choose how you want to interpret it and how to push yourself (in other words, get your butt in my room!)',NULL),
 (89,441,432,'I want me some TOTS!',NULL);
INSERT INTO `yakimbe`.`comment` VALUES  (90,442,424,'I just might do that actually. I bought some fancy new active wear, so now I can appear in public and do active things. I\'ll see if I can talk my wife into comiing with me :) \r\rAny idea what days the class will be? ',88),
 (91,447,424,'Every Wednesday, 6:45 p.m. starting April 14.',90),
 (92,453,452,'Such a shame. Hopefully they\'ve managed relationships with the rest of their vendors better than this. ',NULL),
 (93,458,456,'I really hope they manage to figure out what\'s wrong here and don\'t end up closing. Losing the airport would just be bad news for Lansing, even if it\'s not exactly O\'Hare.',NULL),
 (94,461,460,'Sparty\'s #1 right now, I don\'t even see \'ol Brutus in the top 5. Go Green!',NULL);
CREATE TABLE  `yakimbe`.`edit_comments` (
  `edit_comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) unsigned NOT NULL,
  `comment` varchar(140) NOT NULL,
  `time_created` datetime NOT NULL,
  PRIMARY KEY (`edit_comment_id`),
  KEY `fk1` (`item_id`),
  CONSTRAINT `fk1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
INSERT INTO `yakimbe`.`edit_comments` VALUES  (1,291,'subhead edit','2010-03-09 22:28:59'),
 (2,291,'Added quotes back in subhead','2010-03-10 08:54:15'),
 (3,297,'Entered incorrect URL, replaced with correct one','2010-03-10 11:55:17'),
 (4,342,'Fixed spelling.','2010-03-16 19:15:26'),
 (5,360,'Added bit about the architect','2010-03-17 12:30:01'),
 (6,379,'minor edits','2010-03-17 16:57:48'),
 (7,380,'modified to make sense','2010-03-17 18:05:47'),
 (8,382,'Minor edit to reword sentence in first graph.','2010-03-17 18:59:41'),
 (9,379,'edits to fix a typo','2010-03-17 19:01:52'),
 (10,403,'Corrected typo','2010-03-19 16:52:50'),
 (11,404,'Deleted a paragraph','2010-03-20 13:26:19'),
 (12,415,'Changed the word \'starts\' to \'begins\' in headline','2010-03-22 12:11:42'),
 (13,423,'wording change','2010-03-24 07:14:39'),
 (14,432,'entered a better URL','2010-03-24 11:50:40'),
 (15,432,'Replaced curly quote with straight quote','2010-03-24 11:51:22'),
 (16,435,'Edited the headline to fix typo','2010-03-24 12:02:45');
CREATE TABLE  `yakimbe`.`item` (
  `item_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL,
  `submission_time` datetime NOT NULL,
  `is_dead` tinyint(1) DEFAULT '0',
  `rating` mediumint(9) DEFAULT '0',
  `item_type` varchar(20) NOT NULL,
  `is_user_notified` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=476 DEFAULT CHARSET=utf8;
INSERT INTO `yakimbe`.`item` VALUES  (49,9,'2010-01-22 07:47:35',0,-1,'link',0),
 (51,9,'2010-01-22 07:50:34',0,2,'link',0),
 (52,9,'2010-01-22 07:59:14',0,0,'link',0),
 (53,9,'2010-01-22 08:00:40',0,5,'link',0),
 (54,9,'2010-01-22 08:04:17',0,0,'link',0),
 (55,9,'2010-01-22 08:07:13',0,0,'link',0),
 (56,9,'2010-01-22 08:10:28',0,0,'link',0),
 (57,9,'2010-01-22 08:11:44',0,1,'link',0),
 (58,9,'2010-01-22 08:14:50',0,0,'link',0),
 (59,9,'2010-01-22 09:01:01',0,1,'link',0),
 (60,9,'2010-01-22 09:04:24',0,0,'link',0),
 (61,9,'2010-01-22 09:05:20',0,0,'link',0),
 (62,9,'2010-01-22 09:14:18',0,0,'link',0),
 (63,9,'2010-01-22 09:16:01',0,0,'link',0),
 (64,9,'2010-01-22 09:16:58',0,0,'link',0),
 (65,9,'2010-01-22 10:33:26',0,3,'link',0),
 (69,9,'2010-01-22 10:40:11',0,0,'link',0),
 (70,9,'2010-01-22 10:43:40',0,0,'link',0),
 (71,9,'2010-01-22 10:44:50',0,0,'link',0),
 (72,9,'2010-01-22 10:49:54',0,2,'link',0),
 (73,9,'2010-01-22 12:13:54',0,0,'link',0),
 (74,9,'2010-01-22 16:00:15',0,0,'link',0),
 (75,9,'2010-01-22 22:33:34',0,0,'link',0);
INSERT INTO `yakimbe`.`item` VALUES  (78,9,'2010-01-23 22:19:10',0,5,'link',0),
 (79,9,'2010-01-24 00:49:21',0,0,'link',0),
 (80,9,'2010-01-24 00:50:20',0,0,'link',0),
 (82,9,'2010-01-30 23:55:13',0,1,'link',0),
 (83,9,'2010-02-01 12:19:19',0,2,'link',0),
 (84,9,'2010-02-01 12:23:59',0,0,'link',0),
 (85,9,'2010-02-01 13:44:13',0,2,'link',0),
 (86,9,'2010-02-02 08:22:47',0,0,'link',0),
 (87,9,'2010-02-02 08:50:29',0,1,'link',0),
 (88,9,'2010-02-02 08:53:35',0,0,'link',0),
 (89,9,'2010-02-02 08:55:57',0,0,'link',0),
 (90,9,'2010-02-02 08:58:59',0,0,'link',0),
 (91,9,'2010-02-02 09:01:23',0,0,'link',0),
 (92,9,'2010-02-02 09:06:18',0,0,'link',0),
 (93,9,'2010-02-02 09:10:04',0,0,'link',0),
 (94,9,'2010-02-02 09:14:53',0,0,'link',0),
 (95,9,'2010-02-02 09:20:13',0,0,'link',0),
 (96,9,'2010-02-02 10:13:04',0,1,'link',0),
 (97,9,'2010-02-03 10:03:59',0,0,'link',0),
 (98,9,'2010-02-03 11:58:18',0,0,'link',0),
 (99,9,'2010-02-03 12:19:05',0,0,'link',0),
 (100,9,'2010-02-03 12:39:01',0,0,'link',0),
 (101,9,'2010-02-04 12:30:06',0,0,'link',0);
INSERT INTO `yakimbe`.`item` VALUES  (105,9,'2010-02-05 07:32:35',0,0,'link',0),
 (106,9,'2010-02-05 07:34:35',0,0,'link',0),
 (116,9,'2010-02-05 11:47:42',0,4,'link',0),
 (118,9,'2010-02-05 12:00:46',0,0,'link',0),
 (128,9,'2010-02-05 19:17:43',0,0,'link',0),
 (138,9,'2010-02-08 07:55:19',0,0,'link',0),
 (139,9,'2010-02-08 08:00:25',0,0,'link',0),
 (140,9,'2010-02-08 08:06:33',0,0,'link',0),
 (141,9,'2010-02-08 08:09:39',0,0,'link',0),
 (142,9,'2010-02-08 08:13:26',0,0,'link',0),
 (143,9,'2010-02-08 08:18:15',0,2,'link',0),
 (144,9,'2010-02-08 08:19:57',0,0,'link',0),
 (145,9,'2010-02-08 08:23:02',0,2,'link',0),
 (146,9,'2010-02-08 08:27:07',0,1,'link',0),
 (148,9,'2010-02-08 08:31:10',0,0,'link',0),
 (149,9,'2010-02-08 08:32:30',0,6,'link',0),
 (150,9,'2010-02-08 08:34:08',0,0,'link',0),
 (151,9,'2010-02-08 10:26:33',0,0,'link',0),
 (152,9,'2010-02-08 11:49:10',0,2,'link',0),
 (153,9,'2010-02-08 12:21:25',0,0,'link',0),
 (154,9,'2010-02-08 12:26:30',0,1,'link',0),
 (155,9,'2010-02-08 13:29:24',0,1,'link',0),
 (158,9,'2010-02-08 13:58:46',0,1,'link',0);
INSERT INTO `yakimbe`.`item` VALUES  (159,9,'2010-02-08 13:59:42',0,0,'link',0),
 (160,9,'2010-02-09 09:42:22',0,0,'link',0),
 (161,9,'2010-02-09 10:13:24',0,0,'link',0),
 (162,9,'2010-02-09 10:15:03',0,2,'link',0),
 (167,9,'2010-02-09 16:02:58',0,1,'link',0),
 (168,9,'2010-02-10 08:09:32',0,7,'link',0),
 (169,9,'2010-02-10 08:14:33',0,0,'link',0),
 (170,9,'2010-02-10 12:16:03',0,4,'link',0),
 (171,9,'2010-02-10 12:34:06',0,0,'link',0),
 (172,9,'2010-02-11 12:37:12',0,0,'link',0),
 (174,9,'2010-02-12 08:28:58',0,3,'link',0),
 (175,9,'2010-02-12 09:14:23',0,2,'link',0),
 (178,9,'2010-02-17 08:01:17',0,0,'link',0),
 (181,9,'2010-02-18 12:04:48',0,0,'link',0),
 (182,9,'2010-02-19 08:00:36',0,3,'link',0),
 (183,9,'2010-02-19 08:04:17',0,1,'link',0),
 (184,9,'2010-02-19 08:07:14',0,0,'link',0),
 (185,9,'2010-02-19 08:10:00',0,0,'link',0),
 (186,9,'2010-02-22 15:50:14',0,0,'link',0),
 (187,9,'2010-02-22 15:53:03',0,0,'link',0),
 (188,9,'2010-02-22 15:55:20',0,0,'link',0),
 (189,9,'2010-02-22 15:56:14',0,0,'link',0),
 (190,9,'2010-02-23 11:45:53',0,-1,'link',0);
INSERT INTO `yakimbe`.`item` VALUES  (192,9,'2010-02-23 11:50:45',0,0,'link',0),
 (193,9,'2010-02-23 11:55:21',0,5,'link',0),
 (194,9,'2010-02-23 12:01:20',0,0,'link',0),
 (195,9,'2010-02-23 12:07:45',0,0,'link',0),
 (196,9,'2010-02-23 12:11:32',0,0,'link',0),
 (197,9,'2010-02-23 12:15:37',0,0,'link',0),
 (198,9,'2010-02-24 08:20:25',0,1,'link',0),
 (199,9,'2010-02-24 08:27:11',0,0,'link',0),
 (200,9,'2010-02-24 08:32:16',0,0,'link',0),
 (201,9,'2010-02-24 08:36:27',0,3,'link',0),
 (202,9,'2010-02-24 08:42:23',0,1,'link',0),
 (203,9,'2010-02-24 08:57:54',0,2,'link',0),
 (204,9,'2010-02-24 12:32:34',0,2,'link',0),
 (205,9,'2010-02-24 15:40:51',0,4,'link',0),
 (206,9,'2010-03-02 12:40:59',0,2,'link',0),
 (207,9,'2010-03-02 12:44:46',0,3,'link',0),
 (208,9,'2010-03-02 12:45:35',0,2,'link',0),
 (209,9,'2010-03-02 14:28:12',0,2,'link',0),
 (210,9,'2010-03-02 14:32:00',0,0,'link',0),
 (211,9,'2010-03-02 14:35:22',0,4,'link',0),
 (212,9,'2010-03-02 19:18:55',0,1,'comment',0),
 (213,9,'2010-03-02 20:06:18',0,-1,'comment',0),
 (214,35,'2010-03-02 20:07:26',0,2,'comment',0);
INSERT INTO `yakimbe`.`item` VALUES  (215,9,'2010-03-02 20:30:39',0,0,'link',0),
 (216,9,'2010-03-02 20:54:22',0,6,'link',0),
 (217,35,'2010-03-02 22:15:15',0,-1,'link',0),
 (218,9,'2010-03-03 07:22:53',0,0,'comment',0),
 (219,9,'2010-03-03 07:56:59',0,6,'link',0),
 (220,9,'2010-03-03 08:02:20',0,0,'comment',0),
 (221,9,'2010-03-03 08:22:40',0,0,'link',0),
 (222,9,'2010-03-03 08:28:46',0,0,'link',0),
 (223,35,'2010-03-03 21:43:01',0,6,'link',0),
 (224,9,'2010-03-03 22:53:35',0,3,'link',0),
 (225,9,'2010-03-03 22:56:10',0,0,'comment',0),
 (226,9,'2010-03-04 08:00:38',0,3,'link',0),
 (227,9,'2010-03-04 08:25:09',0,3,'link',0),
 (228,9,'2010-03-04 08:27:41',0,1,'comment',0),
 (229,9,'2010-03-04 08:33:49',0,1,'comment',0),
 (230,9,'2010-03-04 12:31:47',0,2,'link',0),
 (231,9,'2010-03-04 12:33:40',0,0,'link',0),
 (232,9,'2010-03-04 12:42:59',0,-1,'link',0),
 (233,35,'2010-03-04 20:31:29',0,1,'link',0),
 (234,9,'2010-03-04 21:12:44',0,0,'link',0),
 (235,9,'2010-03-04 22:58:14',0,1,'link',0),
 (236,37,'2010-03-04 23:20:45',0,1,'comment',0);
INSERT INTO `yakimbe`.`item` VALUES  (237,9,'2010-03-05 07:12:16',0,-1,'link',0),
 (238,9,'2010-03-05 07:42:07',0,0,'link',0),
 (239,9,'2010-03-05 08:01:52',0,-1,'link',0),
 (240,9,'2010-03-05 08:09:04',0,0,'link',0),
 (241,9,'2010-03-05 08:17:28',0,0,'comment',0),
 (242,35,'2010-03-05 12:51:56',0,0,'link',0),
 (243,35,'2010-03-05 12:53:41',0,-1,'link',0),
 (244,9,'2010-03-05 16:23:35',0,-1,'link',0),
 (245,35,'2010-03-05 19:23:26',0,1,'comment',0),
 (246,9,'2010-03-06 02:32:15',0,0,'link',0),
 (247,9,'2010-03-06 02:33:25',0,-1,'link',0),
 (248,9,'2010-03-06 02:35:06',0,0,'link',0),
 (249,9,'2010-03-06 02:52:35',1,-1,'link',0),
 (250,9,'2010-03-06 02:53:57',0,1,'link',0),
 (251,9,'2010-03-06 02:56:13',0,0,'comment',0),
 (252,9,'2010-03-06 02:58:59',0,0,'comment',0),
 (253,9,'2010-03-06 12:43:01',0,0,'link',0),
 (254,39,'2010-03-06 20:33:23',0,2,'link',0),
 (255,39,'2010-03-06 20:34:43',0,2,'comment',0),
 (256,9,'2010-03-07 12:45:04',0,1,'comment',0),
 (257,9,'2010-03-07 14:49:55',0,0,'link',0),
 (258,9,'2010-03-07 14:56:45',0,1,'link',0);
INSERT INTO `yakimbe`.`item` VALUES  (259,9,'2010-03-07 15:04:20',0,0,'link',0),
 (260,9,'2010-03-07 15:23:02',0,0,'link',0),
 (261,9,'2010-03-07 15:28:01',0,0,'link',0),
 (262,9,'2010-03-07 16:48:53',0,2,'link',0),
 (263,9,'2010-03-07 17:13:19',0,0,'link',0),
 (264,9,'2010-03-07 23:28:35',0,1,'link',0),
 (265,9,'2010-03-08 07:09:25',0,1,'link',0),
 (266,9,'2010-03-08 07:14:37',0,0,'link',0),
 (267,9,'2010-03-08 07:22:07',0,-1,'link',0),
 (268,9,'2010-03-08 07:25:35',0,0,'comment',0),
 (269,40,'2010-03-08 14:58:04',0,0,'comment',0),
 (270,40,'2010-03-08 15:00:03',0,1,'link',0),
 (271,40,'2010-03-08 15:03:43',0,0,'link',0),
 (272,9,'2010-03-08 15:46:19',0,0,'comment',0),
 (273,9,'2010-03-08 15:50:39',0,0,'comment',0),
 (274,37,'2010-03-08 22:10:58',0,1,'comment',0),
 (275,9,'2010-03-09 08:22:55',0,0,'link',0),
 (276,9,'2010-03-09 08:28:43',0,0,'comment',0),
 (277,9,'2010-03-09 10:19:03',0,-1,'link',0),
 (278,9,'2010-03-09 10:22:08',0,0,'comment',0),
 (279,9,'2010-03-09 12:19:01',0,1,'link',0),
 (280,9,'2010-03-09 12:31:47',0,0,'link',0);
INSERT INTO `yakimbe`.`item` VALUES  (281,44,'2010-03-09 12:58:10',0,0,'link',0),
 (282,45,'2010-03-09 17:00:12',0,0,'comment',0),
 (283,45,'2010-03-09 17:09:24',1,-1,'link',0),
 (284,45,'2010-03-09 17:09:29',1,-1,'link',0),
 (285,45,'2010-03-09 17:09:33',1,-1,'link',0),
 (286,45,'2010-03-09 17:09:33',1,-1,'link',0),
 (287,45,'2010-03-09 17:09:42',1,-1,'link',0),
 (288,45,'2010-03-09 17:09:42',0,0,'link',0),
 (289,45,'2010-03-09 17:16:09',0,0,'comment',0),
 (290,45,'2010-03-09 17:28:16',0,-1,'comment',0),
 (291,37,'2010-03-09 17:54:59',0,-1,'link',0),
 (292,37,'2010-03-09 19:11:39',0,0,'comment',0),
 (293,9,'2010-03-10 07:26:23',0,0,'link',0),
 (294,9,'2010-03-10 09:48:23',0,-1,'link',0),
 (295,9,'2010-03-10 09:51:39',0,1,'comment',0),
 (296,9,'2010-03-10 11:48:29',0,0,'link',0),
 (297,9,'2010-03-10 11:54:22',0,-1,'link',0),
 (298,9,'2010-03-10 11:55:59',0,0,'comment',0),
 (299,9,'2010-03-10 11:56:37',0,0,'comment',0),
 (300,9,'2010-03-10 16:13:05',0,1,'link',0),
 (301,9,'2010-03-10 22:19:00',0,0,'comment',0),
 (302,9,'2010-03-10 23:17:50',0,0,'link',0);
INSERT INTO `yakimbe`.`item` VALUES  (303,9,'2010-03-11 08:13:52',0,1,'link',0),
 (304,9,'2010-03-11 08:16:21',0,1,'comment',0),
 (305,9,'2010-03-11 08:18:47',0,0,'link',0),
 (306,9,'2010-03-11 11:46:25',0,1,'link',0),
 (307,9,'2010-03-11 11:50:34',0,0,'link',0),
 (308,9,'2010-03-11 11:53:18',0,1,'link',0),
 (309,9,'2010-03-11 11:57:08',0,0,'comment',0),
 (310,9,'2010-03-11 11:59:41',0,0,'link',0),
 (311,9,'2010-03-11 12:05:45',0,0,'link',0),
 (312,9,'2010-03-11 12:12:01',0,1,'link',0),
 (313,9,'2010-03-11 12:16:26',0,0,'link',0),
 (314,9,'2010-03-12 07:19:33',0,1,'link',0),
 (315,47,'2010-03-12 09:27:50',0,1,'link',0),
 (316,45,'2010-03-12 10:11:44',0,1,'link',0),
 (317,45,'2010-03-12 10:13:58',0,0,'comment',0),
 (318,45,'2010-03-12 10:17:29',0,-1,'link',0),
 (319,45,'2010-03-12 10:18:42',0,0,'comment',0),
 (320,9,'2010-03-12 12:32:50',0,0,'comment',0),
 (321,9,'2010-03-12 12:40:06',0,0,'comment',0),
 (322,9,'2010-03-12 12:48:17',0,0,'comment',0),
 (323,9,'2010-03-12 12:50:36',0,1,'comment',0),
 (324,9,'2010-03-12 13:27:40',0,0,'link',0);
INSERT INTO `yakimbe`.`item` VALUES  (325,9,'2010-03-13 11:15:52',0,1,'link',0),
 (326,9,'2010-03-13 11:16:48',0,0,'comment',0),
 (327,9,'2010-03-13 11:21:29',0,0,'link',0),
 (328,9,'2010-03-13 11:35:24',0,0,'link',0),
 (329,9,'2010-03-13 11:57:50',0,0,'link',0),
 (330,9,'2010-03-15 00:17:59',0,0,'link',0),
 (331,9,'2010-03-15 00:18:25',0,0,'comment',0),
 (332,9,'2010-03-15 00:24:21',0,0,'link',0),
 (333,9,'2010-03-15 08:18:07',0,2,'link',0),
 (334,9,'2010-03-15 08:20:45',0,0,'link',0),
 (335,9,'2010-03-15 08:23:13',0,1,'link',0),
 (336,9,'2010-03-15 08:26:10',0,0,'link',0),
 (337,9,'2010-03-15 08:39:43',0,0,'link',0),
 (338,9,'2010-03-15 08:57:28',0,1,'link',0),
 (339,9,'2010-03-15 08:58:14',0,0,'comment',0),
 (340,50,'2010-03-15 10:46:43',0,-1,'link',0),
 (341,51,'2010-03-15 12:31:27',0,0,'comment',0),
 (342,9,'2010-03-15 15:24:50',0,0,'comment',0),
 (343,9,'2010-03-15 18:47:00',0,-1,'link',0),
 (344,52,'2010-03-15 21:50:11',0,2,'link',0),
 (345,9,'2010-03-16 07:12:20',0,-1,'link',0),
 (346,9,'2010-03-16 07:13:22',0,0,'comment',0);
INSERT INTO `yakimbe`.`item` VALUES  (347,9,'2010-03-16 07:23:51',0,1,'link',0),
 (348,9,'2010-03-16 07:44:51',0,0,'comment',0),
 (349,35,'2010-03-16 22:15:37',0,0,'comment',0),
 (350,37,'2010-03-16 23:28:19',0,0,'comment',0),
 (351,9,'2010-03-17 07:45:19',0,3,'link',0),
 (352,9,'2010-03-17 07:45:47',0,0,'comment',0),
 (353,9,'2010-03-17 07:47:43',0,1,'link',0),
 (354,9,'2010-03-17 08:05:19',0,0,'link',0),
 (355,37,'2010-03-17 08:42:42',0,0,'comment',0),
 (356,40,'2010-03-17 11:14:26',0,2,'link',0),
 (357,40,'2010-03-17 11:17:47',0,1,'comment',0),
 (358,9,'2010-03-17 12:05:24',0,0,'comment',0),
 (359,9,'2010-03-17 12:07:04',0,0,'comment',0),
 (360,9,'2010-03-17 12:12:24',0,1,'comment',0),
 (361,37,'2010-03-17 12:18:05',0,0,'comment',0),
 (362,9,'2010-03-17 12:23:04',0,0,'comment',0),
 (363,9,'2010-03-17 12:24:45',0,0,'link',0),
 (364,9,'2010-03-17 12:34:35',0,0,'link',0),
 (365,9,'2010-03-17 12:37:30',0,0,'comment',0),
 (366,37,'2010-03-17 12:53:09',0,0,'comment',0),
 (367,56,'2010-03-17 13:15:17',0,0,'comment',0),
 (368,56,'2010-03-17 13:18:49',0,1,'comment',0);
INSERT INTO `yakimbe`.`item` VALUES  (369,56,'2010-03-17 13:21:22',0,0,'comment',0),
 (370,56,'2010-03-17 13:22:19',0,0,'comment',0),
 (371,56,'2010-03-17 13:23:51',0,1,'comment',0),
 (372,56,'2010-03-17 13:25:09',0,0,'comment',0),
 (373,56,'2010-03-17 13:27:56',0,1,'comment',0),
 (374,56,'2010-03-17 13:30:07',0,0,'comment',0),
 (375,57,'2010-03-17 15:19:29',0,0,'link',0),
 (376,57,'2010-03-17 15:24:09',0,1,'comment',0),
 (377,44,'2010-03-17 15:28:44',0,0,'comment',0),
 (378,44,'2010-03-17 15:31:17',0,1,'comment',0),
 (379,9,'2010-03-17 16:52:51',0,0,'comment',0),
 (380,9,'2010-03-17 18:03:36',0,1,'comment',0),
 (381,57,'2010-03-17 18:49:43',0,1,'comment',0),
 (382,9,'2010-03-17 18:58:05',0,0,'comment',0),
 (383,57,'2010-03-17 22:18:25',0,1,'comment',0),
 (384,9,'2010-03-17 23:06:06',0,0,'link',0),
 (385,9,'2010-03-17 23:08:04',0,1,'link',0),
 (386,9,'2010-03-18 07:15:39',0,2,'link',0),
 (387,9,'2010-03-18 07:17:25',0,0,'comment',0),
 (388,9,'2010-03-18 07:22:30',0,2,'link',0),
 (389,9,'2010-03-18 16:24:27',0,0,'link',0),
 (390,9,'2010-03-18 16:27:01',0,1,'link',0);
INSERT INTO `yakimbe`.`item` VALUES  (391,9,'2010-03-18 16:31:09',0,1,'link',0),
 (392,51,'2010-03-18 18:19:00',0,-1,'comment',0),
 (393,51,'2010-03-18 18:20:51',0,0,'comment',0),
 (394,9,'2010-03-18 18:39:36',0,0,'link',0),
 (395,9,'2010-03-18 18:41:32',0,0,'comment',0),
 (396,52,'2010-03-18 19:08:50',0,1,'link',0),
 (397,9,'2010-03-18 23:07:53',0,0,'comment',0),
 (398,9,'2010-03-19 07:08:20',0,1,'link',0),
 (399,9,'2010-03-19 07:14:18',0,0,'link',0),
 (400,9,'2010-03-19 07:15:18',0,0,'link',0),
 (401,9,'2010-03-19 07:19:28',0,0,'link',0),
 (402,9,'2010-03-19 12:29:10',0,1,'link',0),
 (403,9,'2010-03-19 16:47:41',0,1,'link',0),
 (404,9,'2010-03-19 16:50:47',0,0,'comment',0),
 (405,9,'2010-03-19 16:57:11',0,0,'link',0),
 (406,9,'2010-03-20 13:22:20',0,0,'link',0),
 (407,9,'2010-03-20 13:25:49',0,0,'comment',0),
 (408,9,'2010-03-20 18:05:52',0,1,'link',0),
 (409,9,'2010-03-21 12:09:32',0,0,'link',0),
 (410,9,'2010-03-21 12:15:24',0,1,'link',0),
 (411,9,'2010-03-22 07:25:57',0,1,'link',0),
 (412,9,'2010-03-22 11:50:40',0,1,'link',0);
INSERT INTO `yakimbe`.`item` VALUES  (413,9,'2010-03-22 11:54:37',0,0,'link',0),
 (414,9,'2010-03-22 11:58:19',0,0,'comment',0),
 (415,9,'2010-03-22 12:05:12',0,1,'link',0),
 (416,9,'2010-03-22 12:10:55',0,0,'comment',0),
 (417,9,'2010-03-23 07:53:01',0,1,'link',0),
 (418,9,'2010-03-23 11:53:28',0,0,'link',0),
 (419,9,'2010-03-23 11:56:01',0,0,'link',0),
 (420,44,'2010-03-23 13:58:17',0,0,'link',0),
 (421,9,'2010-03-24 07:05:10',0,1,'link',0),
 (422,9,'2010-03-24 07:11:27',0,1,'link',0),
 (423,9,'2010-03-24 07:13:48',0,0,'comment',0),
 (424,62,'2010-03-24 07:41:10',0,1,'link',0),
 (425,62,'2010-03-24 07:45:49',0,2,'link',0),
 (426,9,'2010-03-24 08:10:34',0,0,'link',0),
 (427,9,'2010-03-24 08:15:11',0,0,'comment',0),
 (428,9,'2010-03-24 08:20:38',0,0,'comment',0),
 (429,9,'2010-03-24 08:25:41',0,0,'link',0),
 (430,63,'2010-03-24 11:39:00',0,1,'link',0),
 (431,9,'2010-03-24 11:44:33',0,0,'link',0),
 (432,9,'2010-03-24 11:50:11',0,2,'link',0),
 (433,9,'2010-03-24 11:52:40',0,0,'comment',0),
 (434,9,'2010-03-24 11:56:11',0,0,'comment',0);
INSERT INTO `yakimbe`.`item` VALUES  (435,9,'2010-03-24 12:01:43',0,1,'link',0),
 (436,9,'2010-03-24 13:07:38',0,1,'link',0),
 (437,62,'2010-03-24 14:40:23',0,0,'comment',0),
 (438,9,'2010-03-24 18:28:58',0,0,'link',0),
 (439,9,'2010-03-24 19:00:12',0,0,'link',0),
 (440,9,'2010-03-24 19:17:49',0,-1,'link',0),
 (441,35,'2010-03-24 21:30:06',0,0,'comment',0),
 (442,9,'2010-03-24 22:52:42',0,0,'comment',0),
 (443,9,'2010-03-25 07:08:40',0,0,'link',0),
 (444,9,'2010-03-25 07:55:54',0,2,'link',0),
 (445,9,'2010-03-25 08:11:32',0,1,'link',0),
 (446,9,'2010-03-25 08:28:36',0,0,'link',0),
 (447,62,'2010-03-25 12:49:57',0,0,'comment',0),
 (448,9,'2010-03-25 13:08:24',0,1,'link',0),
 (449,9,'2010-03-25 13:11:07',0,0,'link',0),
 (450,9,'2010-03-25 13:12:52',0,0,'link',0),
 (451,9,'2010-03-25 14:51:30',0,0,'link',0),
 (452,9,'2010-03-25 23:08:20',0,1,'link',0),
 (453,9,'2010-03-25 23:08:55',0,0,'comment',0),
 (454,9,'2010-03-26 07:21:13',0,0,'link',0),
 (455,62,'2010-03-26 07:46:57',0,1,'link',0),
 (456,9,'2010-03-26 09:09:33',0,1,'link',0);
INSERT INTO `yakimbe`.`item` VALUES  (457,9,'2010-03-26 09:10:50',0,0,'link',0),
 (458,9,'2010-03-26 11:06:51',0,1,'comment',0),
 (459,9,'2010-03-26 11:36:43',0,0,'link',0),
 (460,9,'2010-03-26 14:54:00',0,1,'link',0),
 (461,9,'2010-03-26 14:55:38',0,1,'comment',0),
 (462,9,'2010-03-26 16:42:18',0,0,'link',0),
 (463,9,'2010-03-26 16:43:47',0,0,'link',0),
 (464,9,'2010-03-26 20:08:57',0,1,'link',0),
 (465,9,'2010-03-26 20:28:27',0,1,'link',0),
 (466,9,'2010-03-26 20:30:33',0,1,'link',0),
 (467,9,'2010-03-26 20:32:32',0,1,'link',0),
 (468,9,'2010-03-26 20:33:34',0,1,'link',0),
 (469,9,'2010-03-26 20:34:25',0,1,'link',0),
 (470,9,'2010-03-26 20:36:10',0,1,'link',0),
 (471,9,'2010-03-26 20:36:46',0,1,'link',0),
 (472,9,'2010-03-26 20:37:35',0,1,'link',0),
 (473,9,'2010-03-26 20:38:16',0,1,'link',0),
 (474,9,'2010-03-26 20:40:01',0,1,'link',0),
 (475,9,'2010-03-26 20:40:46',0,1,'link',0);
CREATE TABLE  `yakimbe`.`link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) unsigned NOT NULL,
  `url` varchar(2000) NOT NULL,
  `headline` varchar(90) NOT NULL,
  `subhead` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `item_id` (`item_id`),
  CONSTRAINT `link_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=314 DEFAULT CHARSET=utf8;
INSERT INTO `yakimbe`.`link` VALUES  (28,49,'http://michiganlibraryauthorvisits.blogspot.com/2009/12/capital-area-district-librarys-upcoming.html','Tukufu Zuberi from PBS History Detectives coming to Lansing library',''),
 (29,51,'http://www.lansingstatejournal.com/article/20100122/NEWS01/1220328','BWL trying to hike rates again','9.3% increase for electric, 8.9% for water probably coming March 1'),
 (30,52,'http://www.lansingstatejournal.com/article/20100122/NEWS01/301220031/-1/middayupdates/MSU-student-won-t-face-charge-of-terror-threats','Terrorrism charges against MSU student dropped','Zachariah M. Aslam spoke to crisis counselor about detonating a bomb'),
 (31,53,'http://statenews.com/index.php/article/2010/01/msu_to_unveil_new_spartan_logo_in_april','MSU debuting new logo in April',''),
 (32,54,'http://www.lansingcitypulse.com/lansing/blog-154-eli-and-edythe-broad-art-museum-update.html','Eli and Edythe Broad art museum gets another $2M from donors','Project expected to cost between $40-45 million'),
 (33,55,'http://www.livingstondaily.com/article/20100120/NEWS01/1200314/1002/MagLev-train-gets-mixed-report-with-report-PDF','Status of Lansing-to-Detroit MagLev? Questionable.','');
INSERT INTO `yakimbe`.`link` VALUES  (34,56,'http://www.lansingcitypulse.com/lansing/article-3885-blowing-smoke.html','Lawmakes move to weaken medical marijuana law','Bills spell out sentencing guidelines, disallow growing of pot, more'),
 (35,57,'http://www.lansingcitypulse.com/lansing/article-3889-the-hardest-count.html','Census Bureau begins to count Lansing\'s homeless next week',''),
 (36,58,'http://www.cityoflansingmi.com/view_news.jsp?id=2309','[event] Cardboard Classic Sled Contest is Saturday Dec. 23',''),
 (37,59,'http://www.wilx.com/home/headlines/82325492.html','Former Eastern coach charged with sexual misconduct','Tommie Boyd charged with misconduct with a minor from Fraser'),
 (38,60,'http://www.wilx.com/home/headlines/82294537.html','25 homes invaded over Christmas break in East Lansing','Police arrested two men; still on the lookout'),
 (39,61,'http://www.wilx.com/home/headlines/82295007.html','State Police to complete move by April 1',''),
 (40,62,'http://www.publicbroadcasting.net/michigan/news.newsmain/article/1/0/1602287/Michigan.News/Bowman.Wants.To.Get.Back.In.The.Game.','Robert Bowman may throw hat in ring for Governor\'s office',''),
 (41,63,'http://www.publicbroadcasting.net/michigan/news.newsmain/article/1/0/1602160/Michigan.News/White.House.to.Host.Great.Lakes-Asian.Carp.Summit','White house to host Great Lakes Asian Carp summit','');
INSERT INTO `yakimbe`.`link` VALUES  (42,64,'http://www.publicbroadcasting.net/michigan/news.newsmain/article/1/0/1601907/Michigan.News/Michigan%27s.Unemployment.Rate.Declines.Slightly.','Michigan\'s unemployment declines, slightly','Rate dropped one-tenth of a percent in December'),
 (43,65,'http://www.lansingstatejournal.com/article/20100122/NEWS01/301220004','Lansing \'serial killer\' Matthew Macon denied appeal in 2 murders','Macon was suspected of killing five women in the summer of 2007'),
 (44,69,'http://www.stewardshipnetwork.org/site/c.hrLOKWPILuF/b.5187337/k.2F8/2010_Stewardship_Network_Conference.htm','[event] Conference focuses on restoring native ecosystems','3rd annual conference takes place Jan. 22-23 at the Kellogg center'),
 (45,70,'http://museum.msu.edu/s-program/mtap/Programs&Services/dailylives.html','lunch lecture: our daily work / our daily lives','Brown bag lecture today at 12:15; MSU Museum'),
 (46,71,'http://news.msu.edu/story/7326/','Million-dollar grant to MSU helps expand broadband access in Mich.',''),
 (47,72,'http://thelansingblog.com/2010/01/20/this-weekend-join-michigan-statehood-day-celebration-at-michigan-historical-museum-downtown/','Michigan Statehood Day celebration at Michigan Historical Museum','');
INSERT INTO `yakimbe`.`link` VALUES  (48,73,'http://www.lansingstatejournal.com/article/20100122/NEWS01/301220006','MSU freshman to go to trial for East Lansing fireworks explosion','Nikolai Wasielewski faces felony charges in connection to Nov. 1 prank'),
 (49,74,'http://www.lansingstatejournal.com/article/20100122/THINGS0104/1230303&referrer=FRONTPAGECAROUSEL','event: Lansing Orchestra plays Mendelssohn, Strauss and Brahms tonight','Brahms piece rarely performed due to requiring two soloists'),
 (50,75,'http://www.lansingstatejournal.com/article/20100122/NEWS03/1090301','GM names new Lansing plants manager','Scott Whybrew previously in charge of operations in South America'),
 (52,78,'http://www.statenews.com/index.php/article/2010/01/spartans_rally_to_beat_minnesota_6564','Spartans come from behind to beat Minnesota, 65-64','MSU delivers Golden Gophers first loss of the season, come away 7-0'),
 (53,79,'http://www.wlns.com/global/story.asp?s=11845730','Amazing race casting call coming to Lansing','CBS series.'),
 (54,80,'http://www.wlns.com/global/story.asp?s=11845730','Amazing race casting call coming to Jackson','CBS series to host casting session on February 3rd from 5 to 8 p.m');
INSERT INTO `yakimbe`.`link` VALUES  (56,82,'http://www.lansingstatejournal.com/article/20100130/NEWS01/1300324&referrer=FRONTPAGECAROUSEL','Granholm seeks to retire 46,000 state employees',''),
 (57,83,'http://www.lansingstatejournal.com/article/20100201/NEWS01/2010330&referrer=FRONTPAGECAROUSEL','New life: Old industrial sites provide home to new data centers','ACD.net, Jackson National Life, Liquid Web and others invest in region'),
 (58,84,'http://www.freep.com/article/20100201/BUSINESS01/100201006/1318/Toyota-offers-pedal-fix-apologizes-to-owners','Toyota shipping parts to fix gas pedals','Problem was related to firction device in pedal'),
 (59,85,'http://www.capitalgainsmedia.com/features/knap0330.aspx','The Knapps Building: MSU students imagine a new purpose','Interior design students reimagine Knapps as condos, restaurant, more'),
 (60,86,'http://www.capitalgainsmedia.com/innovationnews/Jazzfest0403.aspx','Lansing\'s JazzFest nets $10,000 grant',''),
 (61,87,'http://www.lansingstatejournal.com/article/20100202/NEWS06/2020325','Obama\'s budget includes $10M for MSU FRIB research facility',''),
 (62,88,'http://www.lansingstatejournal.com/article/20100202/NEWS03/2020310/1004/NEWS03/Eatery-expansion--Restaurant-Mediteran-in-downtown-Lansing-set-to-add-dining-space--deli','Restaurant Mediteran to expand, add eurpean-style deli','Downtown Lansing eatery to take over old Contemporary Shoe Repair');
INSERT INTO `yakimbe`.`link` VALUES  (63,89,'http://www.lansingstatejournal.com/article/20100201/NEWS03/2010312/1004/news03','Job shearch = tax breaks',''),
 (64,90,'http://www.statenews.com/index.php/article/2010/02/el_police_arrest_mississippi_fugitive','E.L. police arrest Mississippi fugitive','Man convicted to 80 years skipped bail before trial'),
 (65,91,'http://www.statenews.com/index.php/multimedia/37247','video: Looking ahead to Wisconsin',''),
 (66,92,'http://michiganmessenger.com/34200/to-fix-the-state-granholm-must-be-relevant','State of the State: Granholm faces a tightrope walk in yearly address',''),
 (67,93,'http://www.detnews.com/article/20100201/POLITICS03/2010361/Michigan-schools--small-businesses-will-fare-well-in-Obama-budget','Michigan schools, small businesses will fare well in Obama budget',''),
 (68,94,'http://michiganmessenger.com/34068/state-follows-trend-to-virtual-government','Michigan governments moving to virtual services to cut costs','State of Michigan leads the way, municipalities following'),
 (69,95,'http://www.lansingcitypulse.com/lansing/blog-163-hallman-birthday-and-fundraiser-supports-police.html','Lansing officer reminesces about Genessee neighborhood beat','During his patrol, neighborhood contained 14 active crack houses');
INSERT INTO `yakimbe`.`link` VALUES  (70,96,'http://www.lansingstatejournal.com/article/20100202/NEWS01/2020327&referrer=FRONTPAGECAROUSEL','With less snowfall, area road commissions have plows parked',''),
 (71,97,'http://www.lansingstatejournal.com/article/20100203/GW0201/2030328&referrer=FRONTPAGECAROUSEL','Wisconsin deals MSU seasons first loss, injures Kalin Lucas','With Lucas out, rest of season in jeopardy'),
 (72,98,'http://www.statenews.com/index.php/article/2010/02/questions_abound_if_lucas_misses_extended_time','How will the Spartans fare without Lucas?','Spartans might need to replace leader, crunch-time scorer'),
 (73,99,'http://www.lansingstatejournal.com/article/20100203/NEWS03/2030320','Lansing-made crossovers help GMs sales numbers',''),
 (74,100,'http://www.capitalgainsmedia.com/innovationnews/Bailey0404.aspx','E.L.\'s Bailey Neighborhood Lands $115,000 Grant for LED Street Lights',''),
 (75,101,'http://www.lansingstatejournal.com/article/20100204/NEWS04/2040339&referrer=FRONTPAGECAROUSEL','State of the State: Many in mid-Michigan could be impacted',''),
 (76,105,'http://www.lansingstatejournal.com/article/20100205/NEWS03/2050329','Eight of mid-Michigan\'s top ten best-selling cars are GM built','');
INSERT INTO `yakimbe`.`link` VALUES  (77,106,'http://www.lansingstatejournal.com/article/20100205/NEWS01/302050002','Thousands of Michigan children overdue for second H1N1',''),
 (78,116,'http://www.wilx.com/news/headlines/83486052.html','Police confront group of gun toting men at S. Lansing Ponderssoa','Weapons were legal, but assault rifle pushed restaurant owner too far'),
 (79,118,'http://www.wilx.com/home/headlines/83636337.html','MSU backs away from new logo; will use current logo','Protests from fans caused univesity to back away from new design'),
 (80,128,'http://www.wlns.com/Global/story.asp?S=11941234','Lansing Mayor Virg Bernero to run for mayor',''),
 (81,138,'http://www.lansingstatejournal.com/article/20100208/NEWS06/2080329','New MSU Museum hopes to expand reach to 1M people','Museum reach not previously measured, but estimated to be around 50k'),
 (82,139,'http://www.lansingstatejournal.com/article/99999999/INTERACTIVE0101/90515002/-1/special','State of Michigan contracts database',''),
 (83,140,'http://www.statenews.com/index.php/article/2010/02/super_bowl_ads_ranked_by_msu_faculty','MSU faculty rank Superbowl ads','Google\'s Parisian love ranks top');
INSERT INTO `yakimbe`.`link` VALUES  (84,141,'http://www.statenews.com/index.php/article/2010/02/the_race_is_on','Despite losses, all is not lost for Spartans','MSU down to one game lead in the Big Ten'),
 (85,142,'http://www.lansingcitypulse.com/lansing/article-3934-the-third-rail.html','Could new investment in rail transportation be a boon for Michigan?','REO town depot a reminder of days gone by'),
 (86,143,'http://www.lansingcitypulse.com/lansing/article-3928-the-smell.html','First Michigan Caregivers Cup brings cannabis culture to Ypsilanti','Event for marijuana caregivers a \'helpful, necessary celebration\''),
 (87,144,'http://www.lansingcitypulse.com/lansing/article-3930-the-watchmen.html','ACLU to study Lansing Police security cameras','22 crime-fighting cameras have been installed in the last 3 years'),
 (88,145,'http://www.lansingcitypulse.com/lansing/article-3935-whatufffds-cooking.html','Tough economy poses tough challenges for area restaurants','Kelly\'s Downtown, Club 621 have yet to reopen, many have simply closed'),
 (89,146,'http://www.lansingcitypulse.com/lansing/article-3939-sculpture-for-the-city.html','Sculpture planned to commemorate Lansing\'s sesquicentennial','Design unkown, but will be 8- to 20-feet tall polished stainless steel');
INSERT INTO `yakimbe`.`link` VALUES  (90,148,'http://www.wilx.com/home/headlines/83786782.html','Bernero confirms run for Governor on WILX',''),
 (91,149,'http://www.wilx.com/weather/headlines/83761702.html','WILX weather: 6-10` of snow headed our way',''),
 (92,150,'http://www.wlns.com/global/story.asp?s=11949774','Local church aims to fill semi for Haiti relief',''),
 (93,151,'http://thelansingblog.com/2010/02/08/parents-what-about-the-magnet-schools-in-the-lansing-school-district/','Lansing Magnet schools: Maybe the Lansing School District isn\'t so bad','A look at the Lansing Magnet School Fair at Don Johnson Field House'),
 (94,152,'http://www.wilx.com/news/headlines/83806612.html','Suspected robber shot by his victim, killed by drunk driver','Only in Detroit...'),
 (95,153,'http://www.cityofeastlansing.com/fiscalchallenges/','East Lansing seeks input on fiscal challenges',''),
 (96,154,'http://eatlansing.wordpress.com/2009/09/27/michigan-brewing-company/','Review: Michigan Brewing Company',''),
 (97,155,'http://www.freep.com/article/20100208/SPORTS07/100208025/1055/MSU-would-love-for-Lucas-to-return-but-is-he-ready','Spartans not sure if Kalin Lucas will return Tuesday','');
INSERT INTO `yakimbe`.`link` VALUES  (98,158,'http://www.whartoncenter.com/boxoffice/performance.aspx?pid=904','[ event ] WILCO to play at Wharton Center 2/21',''),
 (99,159,'http://www.whartoncenter.com/boxoffice/performance.aspx?pid=913','An evening with Lewis Black at Wharton this weekend [ event ]',''),
 (100,160,'http://www.lansingstatejournal.com/article/20100209/NEWS03/2090326','Area auto suppliers hiring up to 525 workers','Shifts being added due to Chevy Traverse moving to Lansing-Delta plant'),
 (101,161,'http://www.lansingstatejournal.com/article/20100209/COLUMNISTS09/2090319/1016/COLUMNISTS09','Eaton Rapids man vindicated, sad in wake of Toyota recalls','Letter writer has been crying foul on Toyota \'quality\' image for years'),
 (102,162,'http://www.lansingstatejournal.com/article/20100209/NEWS01/2090321','E.L. looking at tax increases, layoffs & more to balance budget','City faces a $5M deficit'),
 (103,167,'http://www.lansingstatejournal.com/article/20100209/NEWS01/302080002&referrer=FRONTPAGECAROUSEL','East Lansing Police Chief wins doughnut eating contest','Cheif ate 3 paczkis, plus one bite, for the win'),
 (104,168,'http://statenews.com/index.php/article/2010/02/whiteout_woes','Spartans lose third in a row','Tuesdays loss is worst at-home loss since \'05');
INSERT INTO `yakimbe`.`link` VALUES  (105,169,'http://statenews.com/index.php/article/2010/02/lucas_show_grit_heart_in_loss','Lucas showed grit, heart in loss',''),
 (106,170,'http://www.acd.net/Press/News%20Release%2001-25-10.pdf','[ pdf ] ACD.net awarded $41M to build 955 mile fiber network','Project extends high-speed service to rural areas of the state'),
 (107,171,'http://www.lansingstatejournal.com/article/20100210/NEWS01/2100321','23 y.o. DeWitt man charged in death of 3 y.o stepdaughter','Man \'... flung her backwards\' for signing and dancing'),
 (108,172,'http://www.detnews.com/article/20100211/POLITICS02/2110449/1022/rss10','Granholm budget cuts sales, business taxes, adds service tax','Includes $565M in cuts'),
 (110,174,'http://statenews.com/index.php/page/interactive_computing_change','[ interactive ] Year-to-year percent change of state budget','Graphic of state funding changes in four categories'),
 (111,175,'http://www.lansingstatejournal.com/article/20100212/NEWS01/2120313','Feds pass on surest solution to halt Great Lakes carp invasion','$80M plan to study, stop fish with electric & poison approved instead'),
 (113,178,'http://www.lansingstatejournal.com/article/20100217/NEWS01/302030027','Animal organs discovered at Frandor Fitness USA','');
INSERT INTO `yakimbe`.`link` VALUES  (114,181,'http://www.lansingstatejournal.com/article/20100218/NEWS06/2180351','MSU lands $25 million science foundation grant for study of evolution','College will study natural and digital worlds'),
 (115,182,'http://www.statenews.com/index.php/article/2010/02/from_recession_to_reinvention','East Lansing entrepreneurs strive to revitalize stale economy',''),
 (116,183,'http://www.msucatalyst.com/catalyst-home/2010/2/8/your-dream-job-game-plan.html','[ book ] Molly Fletcher: Your Dream Job Game Plan','MSU grad, agent to Tom Izzo gives advice on career planning'),
 (117,184,'http://www.statenews.com/index.php/article/2010/02/dehaan_breaks_alltime_ncaa_blocks_record','DeHaan breaks all-time NCAA blocks record',''),
 (118,185,'http://www.lansingstatejournal.com/article/20100219/NEWS01/302190004','Detroit City Council President crashes city vehicle','Charles Pugh drove how with 2 flat tires, filed report next day'),
 (119,186,'http://www.statenews.com/index.php/article/2010/02/new_credit_card_law_effective_monday','New credit card rules go into effect today','Freebies for signing up banned; anyone under 21 must have co-signer'),
 (120,187,'http://www.statenews.com/index.php/article/2010/02/14_teams_work_on_films_for_485_contest','14 teams compete in 48 hour film contest','48/5 challenges contestants to make a 5-minute film in 48 hours');
INSERT INTO `yakimbe`.`link` VALUES  (121,188,'http://www.lansingstatejournal.com/article/20100222/HOLT02/302220013','Holt superintendent defends decision to keep school open','Holt the only major school district in Ingham County to have class'),
 (122,189,'http://www.lansingstatejournal.com/apps/pbcs.dll/gallery?Avis=A3&Dato=20100221&Kategori=NEWS&Lopenr=2210803','[ gallery ] MSU Chocolate Party',''),
 (123,190,'http://en.wikipedia.org/wiki/Lynx_(web_browser)','This was submitted using Lynx',''),
 (124,192,'http://www.statenews.com/index.php/article/2010/02/4_candidates_run_for_ingham_county_commissioner','Four candidate run for Ingham County Commissioner','Elections happening today (Feb. 23)'),
 (125,193,'http://www.statenews.com/index.php/article/2010/02/spartans_must_focus_on_bigger_picture_after_loss','Nowak: Spartans must focus on bigger picture','After second home loss in a row, Izzo must refocus team'),
 (126,194,'http://www.detnews.com/article/20100223/SPORTS0201/2230404/U-M-expected-to-release-findings-of-football-investigation-today','U-M Expected to release finding of football investigation today','Program allegedly violated time restrictions on off-season workouts'),
 (127,195,'http://www.lansingstatejournal.com/article/20100223/NEWS03/2230326','Accident Fund\'s parking deck not eligible for tax-free stimulus money','$31M of federal money now available for other projects');
INSERT INTO `yakimbe`.`link` VALUES  (128,196,'http://www.msucatalyst.com/catalyst-home/2010/2/23/the-podcasting-project.html','MSU Podcasting Project makes lectures available to all','Professors, others post free podcasts on university\'s Web site'),
 (129,197,'http://eatlansing.wordpress.com/2010/02/10/dustys-tap-room-to-start-sunday-brunch/','Dusty\'s taproom to start Sunday brunch',''),
 (130,198,'http://www.lansingstatejournal.com/article/20100224/NEWS01/2240323/Lansing-police-Chief-Mark-Alley-to-retire','Lansing Police Chief Mark Alley to retire','Chief leaving for position at Emergent BioSolutions after 24 years'),
 (131,199,'http://www.lansingstatejournal.com/article/20100224/NEWS01/2240318/','Dimondale teen arraigned in fatal accident','Robert Cook struck a car driven by his mother, crash killed passenger'),
 (132,200,'http://www.lansingstatejournal.com/article/20100224/NEWS01/2240316/','Ingham County Commissioners approve closing jail post','Move expected to save $640,000, force early release of some inmates'),
 (133,201,'http://www.lansingstatejournal.com/article/20100224/NEWS05/2240319/','Waverly looks to athletics, staffing to trim budget','School needs to trim 12.6% to close $3.8M deficit next year');
INSERT INTO `yakimbe`.`link` VALUES  (134,202,'http://www.detnews.com/article/20100223/SPORTS0201/2230404/U-M-expected-to-release-findings-of-football-investigation-today','NCAA charges U-M football program with 5 major violations','Violations involve voluntary summer workouts and providing false info'),
 (135,203,'http://www.statenews.com/index.php/article/2010/02/trekking_to_timbuktu','MSU Alum authors book about trip to Timbuktu',''),
 (136,204,'http://www.lansingstatejournal.com/article/20100224/NEWS01/2240315/','Dispute at Friendship Baptist Church flares to involve Lansing Police','Disagreement over church finances has divided congregation'),
 (137,205,'http://www.lansingstatejournal.com/article/20100224/NEWS01/302240014/Accident-closes-southbound-U.S.-127-near-Jolly-exit','Rush hour alert: Accident closes southbound U.S. 127 near Jolly','Police are asking motorists to avoid the area'),
 (138,206,'http://www.lansingstatejournal.com/article/20100302/NEWS01/3020325/Lansing-murders-Macon-told-police-he-enjoyed-killing-w-video','Convicted killer Matthew Macon: \'I get pleasure off pain\'','Macon was suspected of killing five women in the summer of 2007'),
 (139,207,'http://www.statenews.com/index.php/article/2010/03/training_days','MSU program aims to get homeless veterans back on their feet','');
INSERT INTO `yakimbe`.`link` VALUES  (140,208,'http://www.lansingcitypulse.com/lansing/article-4018-group-renovation.html','Local nonprofit helping to renovate local recovery houses',''),
 (141,209,'http://eastlansingburgerclub.blogspot.com/','Flood Burger: citrus juicer, frozen burger juice, 2 all-beef patties','Delicious or frightening, I\'m not sure'),
 (142,210,'http://news.msu.edu/story/7521/','Sparrow Hospital, MSU team up to provide long-term aid to Haiti','Organizations hope to setup program to train Haitian medical students'),
 (143,211,'http://eatlansing.wordpress.com/2010/03/01/enso/','Enso: Style over substance','Swank new restaurant in Chandler Plaza leaves patron wanting more'),
 (144,215,'http://www.cityofeastlansing.com/Home/Departments/Communications/MediaRoom/articleType/ArticleView/articleId/443/SCENE-Metrospace-to-Unveil-Three-New-Exhibits-The-3in1-Show/','[ event ] Scene Metrospace to open the 3-in-1 show March 12',''),
 (145,216,'http://jessewoodruff.com/yakimbeblog/','Yakimbe sponsors Ignite Lansing!',''),
 (146,217,'http://news.msu.edu/story/7519/','MSU, INgage Networks form new research and development partnership','INgage Networks was formerly known as Neighborhood America');
INSERT INTO `yakimbe`.`link` VALUES  (147,219,'http://www.statenews.com/index.php/article/2010/03/lansing_area_teams_up_to_bring_google_fiberoptic_internet','Will Google co-founder Larry Page bring Gigabit fiber to Lansing area?','Google-backed project aims to pilot superspeed internet connections in mid-sized cities'),
 (148,221,'http://www.lansingstatejournal.com/article/20100303/NEWS01/3030319/Developers-plan-high-end-lofts-commercial-space-in-East-Lansing','Developer plans to bring 8-story condo unit to East Lansing','64,000 sq. ft. building would be at Grove & Albert streets; units would rent for $1500+'),
 (149,222,'http://thelansingblog.com/2010/03/02/weekly-southside-lansing-coffee-klatsch-started-today/','Southside Community Center kicks off weekly coffee klatsch','Organizers hope to make it an opportunity to meet, speak with city council members'),
 (150,223,'http://www.lsj.com/article/20100303/NEWS03/3030323/1004/NEWS03','IBM to add 60 jobs at MSU operation','Job recruiting events planned at campus center'),
 (151,224,'http://www.lansingstatejournal.com/article/20100303/NEWS01/303030004/Two-MSU-students-sentenced-for-role-in-firework-incident-w-video','MSU students sentenced in fireworks \'bombing\' case','Darby Dudley and Olivia Hudson sentenced to 18 mo. probation, 40 hrs community service');
INSERT INTO `yakimbe`.`link` VALUES  (152,226,'http://www.nwlansing.org/westsidealliancenews.html','CSO construction will reduce saginaw to one lane, close MLK Blvd.','Construction to start this month and last through the summer'),
 (153,227,'http://campaign.constantcontact.com/render?v=001cHaZO6NvI5WfbdCiYaOfEtFUTCg8HabVq_2DYXowG4l9o7Ab10g6VJtqgGiYmHp2A5Kv8yD0tvSlAY7R6hdorKHD8HbNZWiwn5uLJYuYggFcwPnbwZwVbICag4cWiuixQFImVV7yUgb0JZrK7gMDzy8kNRHzo5IxG5j5n7qVHcmWx4Owprccf02nIK_AFLtFhjwSI0jUMdmaDAhQodGhwN8xxnpNWIZRU-ZPB9_Dn7HFbreqvdb_hA%3D%3D','Input sought: petition to add bike lanes, streetscape to West Saginaw','Petition calls for reducing saginaw to three lanes, adding bike lanes, parking'),
 (154,230,'http://www.statenews.com/index.php/article/2010/03/obrien_appearance_might_exclude_some_students','Conan O\'Brien may perform at MSU this summer','ASMSU put in $150,000 bid for O\'Brien\'s appearance, but summer show may exclude students'),
 (155,231,'http://www.statenews.com/index.php/article/2010/03/obrien_appearance_might_exclude_some_students','Body pulled from IM West pool was visiting Chinese scholar','Cause of death unknown, police awaiting autopsy reports'),
 (156,232,'http://www.statenews.com/index.php/article/2010/03/spartans_aware_of_battles_3point_range','Spartans face Penn State Taylor Battle\'s deadly 3-point shot tonight','');
INSERT INTO `yakimbe`.`link` VALUES  (157,233,'http://www.lsj.com/article/20100304/NOISE02/3040308/Lansing-scores-an-electronic-music-night','Lansing scores an electronic music night','LEAK links local DJs, producers'),
 (158,234,'http://www.msuspartans.com/gametracker/launch/gt_mbaskbl.html?event=821626&school=msu&sport=mbaskbl&camefrom=&startschool=&','Spartans take down Penn State, 67-65','Replay the game'),
 (159,235,'http://www.lansingstatejournal.com/article/20100304/NEWS01/303040017/As-Lansing-principal-sees-it-pets-better-protected-than-children','Principal: Pets better protected than children',''),
 (160,237,'http://www.lansingstatejournal.com/article/20100305/NEWS01/3050328/','Jobless fear end of their unemployment benefits',''),
 (161,238,'http://news.msu.edu/story/7532/#','MSU develops video game to help children avoid landmines','Goal of project is to teach children in cambodia, other war-torn countries to avoid UXO\'s'),
 (162,239,'http://www.statenews.com/index.php/article/2010/03/msu_defeats_penn_state_at_breslin_6765','MSU defeats Penn State at Breslin 67-65','Spartans break at-home losing streak to overcome the Nittany Lions by 2 points'),
 (163,240,'http://www.statenews.com/index.php/blog/hoop_there_it_is/2010/03/morgan_joins_elite_1500_point_700_rebound_club','Raymar Morgan hits elite 1,500 points, 700 rebound record','Two clutch free throws with made Morgan 1 of only 5 Spartans to achieve record');
INSERT INTO `yakimbe`.`link` VALUES  (164,242,'http://anrweek.canr.msu.edu/','95th Agriculture and Natural Resources Week (ANR Week) March 5-13',''),
 (165,243,'http://www.quietwatersymposium.org/qws2010.html','15th Annual Quiet Water Symposium - March 6th @ MSU Pavilion',''),
 (166,244,'http://noise.typepad.com/local_music_beat/2010/03/weekend-riff-.html','Frank Turner, of Flogging Molly, to play Macs Bar on Saturday','Grammy-winner Alicia Keys plays Friday and Saturday at Fox theater in Detroit'),
 (167,246,'http://www.lansingstatejournal.com/apps/pbcs.dll/section?category=HSSFormResults&result_type=scores&sc_id=-1&userid=4051&daterange=-10&css=&showBleachers=true&showStats=true&StatsURL=http%3A%2F%2Fwww.highschoolsports.net%2FStats%2FGameStats-g.cfm&showBoxscore=true&showGameSummary=true&showTeamStats=true&showPlayerStats=true&bLocal=true&news_id=lsj&fromdate=07%2F01%2F2009&todate=06%2F30%2F2010&Secondary=false&Sex_id=2&Level_id=1&Sport_id=2&tier1=-1&tier2=-1&tier3=-1&tier4=-1&tier5=-1&tier6=-1','High School Girls Basketball Scores',''),
 (168,247,'http://www.statenews.com/index.php/article/2010/03/spartans_beat_michigan_6150','Spartans beat Michigan, 61-50','Advance to face Iowa, Penn State winner at 5 p.m. Saturday');
INSERT INTO `yakimbe`.`link` VALUES  (169,248,'http://www.lansingnoise.com/article/20100305/NOISE/100305002/1104/noise&referrer=NEWSFRONTCAROUSEL','Ignite Lansing: Links to speakers, background info',''),
 (170,249,'http://blog.yakimbe.com/wp-admin','Welcome Ignite Lansing participants!',''),
 (171,250,'http://blog.yakimbe.com/','Welcome Ignite Lansing participants!',''),
 (172,253,'http://docs.google.com/fileview?id=0B9UMhsA6Izp3MjhmZjIzOGEtMmI0Ny00NzBhLTkwNjEtNjFmYmM5NjAwNzNk&hl=en','Can bike sharing work in Lansing? Eve of ignition winner thinks so.','Theresa Gasinski wins Lansing Ignite presentations with plan for bike sharing business'),
 (173,254,'http://www.facebook.com/home.php?#!/event.php?eid=332811983632','Humane Society Wine Tasting Event','Sponsored by Northwood University\'s Lansing Alumni Chapter'),
 (174,257,'http://www.lansingstatejournal.com/article/20100307/NEWS01/3070527/MEA-staffers-salaries-rise-as-local-teachers-make-money-saving-sacrifices','Michigan Education Association staffers see 7-15% raises','While teachers face pay cuts & staff reductions, MEA staff is well compensated'),
 (175,258,'http://www.davemulder.com/articles/when-michigan-state-became-sparty/','When Michigan State became \'Sparty\'','Google analytics reveals increasing usage of the Spartan\'s unofficial nickname');
INSERT INTO `yakimbe`.`link` VALUES  (176,259,'http://www.msucatalyst.com/catalyst-home/2010/3/7/msucatalyst-visits-msu-podcasting.html','MSU-alumni news site MSU Catalyst featured on Podcasting Project','Site founder Megan Gebhart talks about projects growth, future plans'),
 (177,260,'http://mientertainment.biz/content/2010/3/6/congrats-to-mike-siracuse-at-riverwalk-for-15-years.html','Riverwalk Theatre manager Mike Siracuse celebrates 15 years','As the only paid employee, Siracuse has kept theater group running since 1995'),
 (178,261,'http://bilmoore.com/?p=13','Be childish and make friends!','Local sales expert Bill Moore offers advice on networking, meeting new people'),
 (179,262,'http://capitalgainsmedia.com/features/dress0408.aspx','MSU student designed dress worn by James Cameron\'s wife on red carpet','Jillian Granz won global competition to design a \'sustainable\' dress for Suzy Amis Cameron'),
 (180,263,'http://www.capitalgainsmedia.com/devnews/fish0408.aspx','New Vendor Features Great Lakes Fish, Special Orders in City Market',''),
 (181,264,'http://www.lansingstatejournal.com/article/20100307/NEWS01/303070004/?GID=0','Fire destroys R&D Auto Repair at Elm and Cedar st.','Passing motorist reported fire at 4:50 a.m., 33 firefighters fought blaze');
INSERT INTO `yakimbe`.`link` VALUES  (182,265,'http://www.lansingstatejournal.com/article/20100308/GW0201/3080329/MSU-men-s-basketball-Spartans-again-Big-Ten-champs','Spartans are once again Big Ten champs','Izzo\'s team blasts Michigan, earns share of 2nd straight conference title'),
 (183,266,'http://www.lansingstatejournal.com/article/20100308/NEWS01/3080324/Warmer-temps-set-maple-sap-to-flowing','Fenner Nature Center Maple Festival scheduled for March 20-21','Warmer weather has set maple sap flowing'),
 (184,267,'http://www.lansingstatejournal.com/article/20100308/NEWS03/3080325/','Proposed November ballot initiative would allow casinos in Lansing','Benton Harbor, Detroit, Flint,  Muskegon, Romulus also included in measure'),
 (185,270,'http://robinmswartz.blogspot.com/2010/03/feeding-belly-and-spirit.html','Downtown Lansing day shelter feeds body, spirit','Open Door Ministry a godsend for homeless, working poor'),
 (186,271,'http://www.msuspartans.com/sports/w-baskbl/recaps/030610aaa.html','MSU women fall to Iowa in semifinals of Big Ten Tournament','Tight game goes down to the final minute'),
 (187,275,'http://www.capitalgainsmedia.com/features/meyer0408.aspx','Jason Meyers finds happiness in East Lansing\'s startup scene','Previous Chicago resident yearned for the Windy city\'s vibe before making his own');
INSERT INTO `yakimbe`.`link` VALUES  (188,277,'http://www.google.com/appserve/fiberrfi/public/options/','Nominate Lansing for google\'s super-high-speed internet trial','Search giant is searching for communities to try out gigabit fiber optic connectivity'),
 (189,279,'http://blonde-bedhead.blogspot.com/2010/03/downtown-portland-mich.html','High fashion in downtown Portland (yes, Portland Mich.)','Local fashionistas find high-fashion, low prices in U.P. for Portland Oscar party'),
 (190,280,'http://wordwright.blogspot.com/2010/03/little-controversy-is-good-thing.html','Schneider pans Ignite Lansing, gets strong response',''),
 (191,281,'http://www.cawlm.com/article/delicious-finds/','Delicious Finds: Accessories so good we want to eat them up','Featuring local designers'),
 (192,283,'http://www.lansingstatejournal.com/article/20100309/NEWS01/3090323/','Venue: Lansing nightclub slashing suspect faces another assault charge',''),
 (193,284,'http://www.lansingstatejournal.com/article/20100309/NEWS01/3090323/','Venue: Lansing nightclub slashing suspect faces another assault charge',''),
 (194,285,'http://www.lansingstatejournal.com/article/20100309/NEWS01/3090323/','Venue: Lansing nightclub slashing suspect faces another assault charge','');
INSERT INTO `yakimbe`.`link` VALUES  (195,286,'http://www.lansingstatejournal.com/article/20100309/NEWS01/3090323/','Venue: Lansing nightclub slashing suspect faces another assault charge',''),
 (196,287,'http://www.lansingstatejournal.com/article/20100309/NEWS01/3090323/','Venue: Lansing nightclub slashing suspect faces another assault charge',''),
 (197,288,'http://www.lansingstatejournal.com/article/20100309/NEWS01/3090323/','Venue: Lansing nightclub slashing suspect faces another assault charge',''),
 (198,291,'http://lansinggivecamp.org/Home.aspx','Weekend Event Gives Local Programmers & Designers Chance to Volunteer','Impression 5 Will Be Hosting This Year\'s \"GiveCamp\"'),
 (199,293,'http://www.capitalgainsmedia.com/devnews/glrent0409.aspx','Grand Ledge receives more than $400,000 to rehab downtown lofts','MSHDA Rental Rehabilitation Project looks to increase the number of available apartments'),
 (200,294,'http://www.freep.com/article/20100310/BUSINESS06/3100329/1322/State-jobless-rate-shows-stability-declines-to-14.3','State jobless rate declines two-tenths to 14.3%','Rate has stabilized over past several months, possibly indicating labor market bottomed'),
 (201,296,'http://www.lansingstatejournal.com/article/20100310/NEWS03/3100326/Lansing-downtown-eatery-selections-cooking-up','Downtown Lansing an \'up and coming\' destination for new businesses','New restaurants move in to Washington Square locations while others expand');
INSERT INTO `yakimbe`.`link` VALUES  (202,297,'http://teamlansingsxsw.tumblr.com/','Chevy SXSW Roadtrip Challenge: Team Lansing makes it\'s way to festival','Team must complete challenges, including arm-wrestling short-order cook, on way to Austin'),
 (203,300,'http://www.lansingstatejournal.com/article/20100308/NOISE11/303080010/Elton-John-to-perform-in-Grand-Rapids--ticket-sales-start-Monday','[ event ] Elton John to play Grand Rapids April 24','Tickets start at $39, on sale March 15 through Ticketmaster'),
 (204,302,'http://www.capitalgainsmedia.com/innovationnews/missiong0409.aspx','LCC Student Pioneers Full-Service Recycling For Businesses in Lansing','Mission Green removes burden of maintaining recycling program from businesses'),
 (205,303,'http://www.lansingstatejournal.com/article/20100311/NEWS01/303090043/','Accident closes Grand River Ave. at Meridian Road intersection',''),
 (206,305,'http://www.lansingstatejournal.com/article/20100311/NEWS01/3110342/','Comedian Conan O\'Brien picks Fowlerville woman to follow on Twitter','Late night talks show host said he would only follow one person, picked Sarah Killen'),
 (207,306,'http://www.lansingstatejournal.com/article/20100311/NEWS01/303090043/','Cyclist killed in crash at Okemos and Meridian','Crash occurred between 6:15 and 6:30 this morning; further details not available');
INSERT INTO `yakimbe`.`link` VALUES  (208,307,'http://www.lansingstatejournal.com/article/20100311/NEWS01/303110011/','Delhi Twp. man, 79, to stand trial on sexually assaulting 3 girls','Eugene Smith charged with assaulting 3 girls between the ages of 6 and 8'),
 (209,308,'http://www.wilx.com/home/headlines/87299812.html','Cadillac distancing itself from GM brand','Automaker is removing references to its parent company from marketing materials, more'),
 (210,310,'http://www.wilx.com/home/headlines/87279887.html','Public funds dwindling for Michigan political campaigns','$7.2M pulled from fund to balance budget deficit'),
 (211,311,'http://www.michigan.gov/dnr/0,1607,7-153-10371_10402-232925--,00.html','DNR needs volunteers for 15th Annual Frog & Toad Survey',''),
 (212,312,'http://robinmswartz.blogspot.com/2010/02/turning-6400-into-77270206.html','Turning $6,400 into $772,702.06','Cristo Rey case manager helps scores of people obtain prescriptions with limited funds'),
 (213,313,'http://www.lansingcitypulse.com/lansing/article-4081-virg-watch.html','Bernero: State should start it\'s own bank','Gubernatorial candidate says state-owned bank would help turn economy around'),
 (214,314,'http://www.lansingstatejournal.com/article/20100312/NEWS01/303090043/','Police say driver fell asleep in crash that killed cyclist','Cyclist, 23, was not wearing a helmet');
INSERT INTO `yakimbe`.`link` VALUES  (215,315,'http://www.capitalgainsmedia.com/features/transit0409.aspx','Building Transportation Connections','What determines whether a Lansing developer builds around public transportation?'),
 (216,316,'http://www.lansingstatejournal.com/article/20100312/NEWS01/303090043/1001/NEWS/Police-say-driver-fell-asleep-in-crash-that-killed-cyclist-near-Okemos','Police say driver fell asleep in crash that killed cyclist near Okemos',''),
 (217,318,'http://www.publicbroadcasting.net/michigan/news.newsmain/article/0/1/1622823/Michigan.News/Problems.at.Detroit.Metro.','Problems at Detroit Metro',''),
 (218,324,'http://michigan.gov/minewswire/0,1607,7-136-3452-233295--,00.html','State employee early retirement legislation introduced','State employee, school employee retirement bills part of governor\'s 29 government reforms'),
 (219,325,'http://statenews.com/index.php/article/2010/03/minnesota_knocks_msu_out_of_big_ten_tournament_in_ot','Minnesota knocks Spartans out of Big Ten Tournament in overtime','Went 18-34 at the free throw line, including 5-12 in overtime'),
 (220,327,'http://www.lansingstatejournal.com/article/20100312/NEWS01/303120007/Lansing-man-pleads-no-contest-in-crash-that-killed-local-mother-son','Daniel Burwell pleads no contest in crash that killed mother, son','Burwell fled the scene, had a BAC of .18 three hours after crash');
INSERT INTO `yakimbe`.`link` VALUES  (221,328,'http://lansingnoise.com/article/20100311/NOISE02/3110312/1115/NOISE11/Spotlight--Junius-brings-intense-noise-rock-to-East-Lansing','[ event ] Boston-based Junius hits Mac\'s Bar with intense noise rock','Local metal band Cavalcade opens show at 9 p.m.'),
 (222,329,'http://www.cawlm.com/article/the-english-inn/','Review: The English Inn lives up to its reputation of fine dining','High-end restaurant focuses on creating a high-quality experience for special occasions'),
 (223,330,'http://statenews.com/index.php/article/2010/03/spartans_to_march_west','Spartans head to Spokane to face off with New Mexico State','MSU seeded No. 5, face the Aggies on Friday'),
 (224,332,'http://www.wilx.com/home/headlines/87628247.html','Lansing police searching for triple-shooting suspect',''),
 (225,333,'http://www.lansingstatejournal.com/article/20100315/NEWS04/3150330/State-s-term-limits-have-boosted-lobbyist-influence-study-finds','Study: Term limits boost lobbyist influence in Michigan','\'We should abolish term limits, and if we don\'t we should lengthen them\' says study author'),
 (226,334,'http://www.lansingstatejournal.com/article/20100315/NEWS01/3150328/','Police investigate shooting at Lansing motorcycle club','Three men hospitalized after incident at private Hood Riders Motorcycle club in N. Lansing');
INSERT INTO `yakimbe`.`link` VALUES  (227,335,'http://www.lansingstatejournal.com/article/20100315/NEWS02/3150327/','Tax credits up to 42% for music production go unused for 2 years','Incentive is part of movie industry tax breaks, not highly publicized'),
 (228,336,'http://www.statenews.com/index.php/article/2010/03/rather_hall_rulings_get_handed_down','Rulings in Rather Hall fight get handed down','3 MSU players sentenced to 18 mo. probation, 150 hours community service'),
 (229,337,'http://www.msucatalyst.com/catalyst-home/2010/3/15/why-i-relay-kelly-montgomery.html','Why I Relay: Kelly Montgomery','24-year-old battling stage 4 lymphoma tells why she\'s involved with Relay for Life'),
 (230,338,'http://www.toledoonthemove.com/news/story.aspx?id=429689','Biggby turns 15 today, giving away free coffee to \'E-Ward\' members','Founders Bob Fish and Mary Roszel to join partners for celebration at original Biggbys'),
 (231,340,'http://www.wlns.com/global/story.asp?s=12141127','Howell schools look to consolidate busing',''),
 (232,343,'http://statenews.com/index.php/blog/can_i_get_a_whoop_whoop/2010/03/recruits_earn_honors','MSU\'s Klarissa Bell was named Michigan’s Miss Basketball','');
INSERT INTO `yakimbe`.`link` VALUES  (233,344,'http://michigan.gov/som/0,1607,7-192-45414_45416-233422--,00.html','Veterinarian Urges Pet / Livestock Owners to Vaccinate Against Rabies','Rabid horse identified  in Lapeer County is state\'s third rabies case this year'),
 (234,345,'http://eatlansing.wordpress.com/2010/03/15/sugarshack/','Sugarshack: amazing cupcakes, delivered to your door','Bakery on Grand River Ave. creates wonderful treats and delivers in a 5 mile radius'),
 (235,347,'http://www.lansingcitypulse.com/lansing/article-4092-shopping-and-skating.html','Grant could bring skate park to city market area','$500,000 ice rink could be in Lansing\'s future with MEDC grant, TIFA funds'),
 (236,351,'http://www.lansingstatejournal.com/article/20100313/NEWS01/303130012/1001/NEWS/Kelly-s-Downtown-reopens-today-after-move--expansion','Kelly\'s Downtown reopens today after move, expansion',''),
 (237,353,'http://www.lansingstatejournal.com/article/20100317/NEWS06/3170326/MSU-thinks-big-in-new-art-museum','Ground broken for $28M Eli and Edythe Broad Art Museum at MSU',''),
 (238,354,'http://www.capitalgainsmedia.com/devnews/yakim0410.aspx','Yakimbe in the news','');
INSERT INTO `yakimbe`.`link` VALUES  (239,356,'http://www.capitalgainsmedia.com/devnews/soup0410.aspx','Soup Spoon adds seats!',''),
 (240,363,'http://www.lansingstatejournal.com/article/20100317/NEWS01/303170009/Lansing-motorcycle-club-shooting-suspect-turns-himself-in','Motorcycle club shooting suspect turns himself in','Victims of shooting are in stable condition'),
 (241,364,'http://www.capitalgainsmedia.com/features/adven0410.aspx','Lansing area looks to adventure travel to draw visitors, business','Industry is seen as a way to help Michigan diversify and keep more young talent'),
 (242,375,'http://nbashaw.tumblr.com/post/454169330/whylovelan','Why Do You Care About Lansing?','What\'s makes us special? What\'s our brand?'),
 (243,384,'http://www.capitalgainsmedia.com/features/google0410.aspx','Editor’s Pick: The Google Fiber For Greater Lansing Project',''),
 (244,385,'http://www.lansingstatejournal.com/article/20100317/NEWS01/303170011/Convicted-embezzler-gets-tax-credit','Convicted embezzler receives $9.1M tax credit from Mich.','Appeared beside Gov. Granholm as example of growing business in press conference'),
 (245,386,'http://www.capitalgainsmedia.com/inthenews/depot0410.aspx','Speilberg Considers Leslie Depot Diner For New Film','');
INSERT INTO `yakimbe`.`link` VALUES  (246,388,'http://www.facebook.com/group.php?gid=336478496672&ref=nf&v=info#!/event.php?eid=366094839759&index=1','Event: Google fiber for greater Lansing Project rally tonight','Voice your support March 18 from 6-8 p.m. at Hannah Community center'),
 (247,389,'http://danieljhogan.com/home/2010/03/17/lansingnext-005/','Audio: LansingNext discusses Google fiber with Rory Neuner','Also: Biggby\'s 15th anniversary, Tim Nester on TalkLansing.net, more'),
 (248,390,'http://www.wilx.com/home/headlines/88418187.html','Michigan discusses lifting ban on illegal fireworks to raise money','House committee passed bill to raise estimated $2.6M to preserve fire protection services'),
 (249,391,'http://www.wlns.com/global/story.asp?s=12158166','State worker pay cuts fail for second time','Twice state senate republicans have failed to defeat a 3% pay raise for union workers'),
 (250,394,'http://www.lansingnoise.com/article/20100318/NOISE04/3180317/1104/noise&referrer=NEWSFRONTCAROUSEL','MSU alum\'s Web site a go-to for foodies','\'Hungry Dudes\' get their due'),
 (251,396,'http://www.fox17online.com/news/fox17-opponents-fight-lake-michigan-wind-farm,0,4295916.story','Opponents Fight Lake Michigan Wind Farm','A day at the beach this summer could look different!');
INSERT INTO `yakimbe`.`link` VALUES  (252,398,'http://www.statenews.com/index.php/article/2010/03/put_on_your_dancin_shoes','New Mexico State guard Jahmar Young has never heard of Kalin Lucas','NMSU\'s leading scorer and second leading assist man reflects the confidence of Aggies'),
 (253,399,'http://www.statenews.com/index.php/article/2010/03/few_st_patricks_day_arrests_tickets','32 St. Patrick\'s day arrests in East Lansing','Nice weather meant more house parties, but arrests were \'nothing out of the ordinary\''),
 (254,400,'http://www.lansingstatejournal.com/article/20100319/NEWS03/3190315/Google-gets-lots-of-love-in-East-Lansing','Google gets lots of love in East Lansing','Dozens turn out to hear details of fiber-optic plan'),
 (255,401,'http://www.lansingstatejournal.com/article/20100318/NEWS05/303180022/1006/NEWS05','Boy took shotgun to Lansing school','Student brought an unloaded, sawed-off shotgun to Wexford Montessori School'),
 (256,402,'http://blonde-bedhead.blogspot.com/2010/03/blonde-bedhead-giveaway.html','Blonde Bedhead: Win this purse from Grace Boutique in Old Town','To enter, leave a comment on local fashion blog \'Blonde Bedhead\''),
 (257,403,'http://lansingnoise.com/article/20100318/NOISE02/3180309/1115/NOISE11/Spotlight--New-Lansing-venue-for-metal--rock--R&B-','New live music venue in downtown Lansing','\'The Loft\' near Harem, The Nuthouse has capacity for 400, hosting metal show on Saturday');
INSERT INTO `yakimbe`.`link` VALUES  (258,405,'http://statenews.com/index.php/article/2010/03/jenrette_smith_get_jail_time_three_others_get_probation_for_rather_hall_fight','Jenrette, Smith get jail, others get probation for Rather Hall fight','Deane, Rucker get 12 months probation, former player Williams gets 18 mo. probation'),
 (259,406,'http://www.lansingstatejournal.com/article/20100320/NEWS01/3200324/LCC-eyes-4-per-credit-tuition-hike','LCC considers $4 per-credit tuition hike','Increase would cost full-time students $48-$72 per semester, raise $1.8M for LCC'),
 (260,408,'http://www.lansingcitypulse.com/lansing/article-4098-eyesore-of-the-week.html','Eyesore of the week: 200 S. Martin Luther King Jr. Blvd.','Shuttered corner store property faces major challenges posed by neighborhood, economy'),
 (261,409,'http://www.lansingstatejournal.com/article/20100321/SPORTS02/3210593/High-school-basketball-East-Lansing-girls-win-Class-A-state-title','State Champs: East Lansing girls win Class A state title','Trojans conquer Detroit Renaissance for crown, 65-54'),
 (262,410,'http://statenews.com/index.php/article/2010/03/izzo_hoping_to_work_turnaround_magic_once_again','Izzo hoping to work turnaround magic once again','Spartans busy preparing to face Maryland in St. Louis Sunday');
INSERT INTO `yakimbe`.`link` VALUES  (263,411,'http://www.lansingstatejournal.com/article/20100322/NEWS03/3220319/Web-design-whiz-kid','Nicholas Chilenko: Web design whiz kid','21-year-old MSU grad started his first Web company at age 10'),
 (264,412,'http://greenandwhite.com/article/20100322/GW0201/3220332&referrer=FRONTPAGECAROUSEL','MSU squeaks out another one, heads to sweet 16','Lucious 3 at buzzer sends Spartans to St. Louis'),
 (265,413,'http://www.lansingstatejournal.com/article/20100225/GLW/2250302/1132/glw','Sen. Debbie Stabenow blazed a trail for women - in politics and life','Maternity care quip in healthcare debate a pivotal moment for Stabenow'),
 (266,415,'http://www.lansingstatejournal.com/article/20100322/NEWS01/303220003/Drive-to-exempt-Michigan-from-federal-health-care-starts','Drive to exempt Michigan from federal health care begins','Republicans, tea partiers and grassroots organizations gathering signatures'),
 (267,417,'http://www.statenews.com/index.php/article/2010/03/lucas_officially_out_for_ncaa_tournament','Lucas ruptured his left Achilles tendon, out for rest of tournament',''),
 (268,418,'http://www.lansingstatejournal.com/article/20100323/NEWS01/3230321/Lansing-budget-plan-Cut-work-week-for-some-city-workers','Lansing budget calls for city workers to switch to four-day work week','Move helps address $12M budget deficit, includes only non-emergency personnel,');
INSERT INTO `yakimbe`.`link` VALUES  (269,419,'http://www.lansingstatejournal.com/article/20100323/NEWS01/303230002/Michigan-state-employees-protest-retirement-plan-pay-freeze','200+ State workers protest retirement plan, pay freeze',''),
 (270,420,'http://www.entrepreneur.com/magazine/entrepreneur/2010/april/205496.html','From the Blackboard to the Boardroom','East Lansing-based GiftZip.com is one of 7 featured entrepreneurs'),
 (271,421,'http://www.lansingstatejournal.com/article/20100324/NEWS04/3240320/200-state-workers-rally-at-Capitol','200+ state workers rally at capitol','Employees protest possible pay freeze, proposal to encourage retirements'),
 (272,422,'http://www.lansingstatejournal.com/article/20100324/NEWS06/3240316/LCC-countersues-in-hangar-case','LCC counter-sues over $160k/year aircraft hangar contract','College says pres. Brent Knight signed contract without authority, demands money back'),
 (273,424,'http://bythurston.wordpress.com/2010/03/22/yoga-by-any-means-necessary/','Yoga by any means necessary, free class starts April 14','Free weekly community class for ages 13 and up'),
 (274,425,'http://www.deridderdailynews.com/news/x673426195/-I-Love-Louisiana','Lansing woman, 62, on 3,100 cycling trip across the country','Suffers macular degeneration, \"just following my dream\"');
INSERT INTO `yakimbe`.`link` VALUES  (275,426,'http://www.lansingstatejournal.com/article/20100324/NEWS01/3240315/1002/NEWS01','Attorney calls fatal Lansing shooting \'accidental\'','Defendants lawyer says \"He didn\'t even pull the trigger,\" only meant to scare victim'),
 (276,429,'http://www.capitalgainsmedia.com/features/student0411.aspx','Student entrepreneurs fired up by mid-Michigan startup scene','MSU entrepreneurs are opening businesses between—sometimes instead of—hitting the books'),
 (277,430,'http://www.capitalgainsmedia.com/innovationnews/floor0411.aspx','Lansing Flooring Company Experiences 53% in Profit in 2010',''),
 (278,431,'http://www.capitalgainsmedia.com/devnews/eden0411.aspx','Eden\'s juice to bring healthy food options downtown','New restaurant will sell yogurt, smoothies and raw juices'),
 (279,432,'http://www.capitalgainsmedia.com/inthenews/southside0411.aspx','Sonic franchisees will spend $1.45M on Southside Sonic restaurant','The site - Governor\'s Inn at 1000 Ramada Dr. - will host other developments as well,'),
 (280,435,'http://talklansing.net/lansingnext','Hear what Yakimbe\'s founders have to say about Yakimbe on LansingNEXT','Download the episode now - iPod friendly!');
INSERT INTO `yakimbe`.`link` VALUES  (281,436,'http://americancity.org/buzz/entry/2143/','Next American City: Lansing\'s tech sector helping to ease city\'s woes','Nanotech, biotech, and health care are scooping up cheap real estate, expanding'),
 (282,438,'http://www.lansingstatejournal.com/article/20100324/NEWS01/303240007/Nurses-rally-at-Capitol-for-nurse-to-patient-ratios','1,000 nurses rally at capitol to support nurse-patient ratio bill','the Safe Patient Care Act, would establish minimum nurse-to-patient ratios'),
 (283,439,'http://noise.typepad.com/local_music_beat/2010/03/interview-podcast-maynard-james-keenan-from-tool-puscifer-in-detroit.html','Frontman of Tool, A Perfect Circle brings new project to Detroit','Project meshing music, videos and sketch comedy comes to Royal Oak'),
 (284,440,'http://www.freep.com/article/20100324/NEWS04/100324066/1319/Ex-Lion-Boyd-cleared-of-sex-charge','Ex-Eastern high football coach cleared of forced sex with girl, 16','Tommy Boyd still face charges in a separate case involving a 15-year-old girl'),
 (285,443,'http://www.lansingcitypulse.com/lansing/article-4139-virg-watch.html','Have ice cream in the a.m. and a private conversation with Virg','April 1 \'un-breakfast\' fundraiser being held in Old Town');
INSERT INTO `yakimbe`.`link` VALUES  (286,444,'http://www.lansingnoise.com/article/20100325/NOISE14/3250325/1104/noise&referrer=NEWSFRONTCAROUSEL','LansingNEXT featured on cover of Noise, Yakimbe makes cameo appearance','Internet radio show avoids the trap of partisan politics, highlights local news'),
 (287,445,'http://www.statenews.com/index.php/article/2010/03/hello_st_louis','Heading to St. Louis? Here\'s a few things for your todo list','Pep rally scheduled, several key bars and restaurants must be visited'),
 (288,446,'http://www.statenews.com/index.php/article/2010/03/instructor_receives_probation_in_sex_case','MSU instructor receives probation in sex case','Takashi Higuchi sentenced to 6 months probation for accosting a child with immoral purpose'),
 (289,448,'http://www.lansingstatejournal.com/article/20100325/NEWS01/303250001/East-Lansing-Bank-of-America-robbery-suspect-captured','East Lansing Bank of America robbery suspect captured',''),
 (290,449,'http://www.lansingcitypulse.com/lansing/article-4138-spring-guide-2010.html','Spring Guide 2010: Upcoming performances and events',''),
 (291,450,'http://www.capitalgainsmedia.com/features/giving0411.aspx','Give camp provides opportunity for techies to help area non-profits','');
INSERT INTO `yakimbe`.`link` VALUES  (292,451,'http://news.msu.edu/story/7628/','MSU researcher reports her first giant panda capture and release','Vanessa Hull succeeds in capture of giant panda after three years of work'),
 (293,452,'http://bythurston.wordpress.com/2010/03/25/be-informed-today-march-25/','Fresh Lake Whitefish Company not returning to City Market','Vendor says they were \"not made to feel welcome,\" will open shop in Grand Ledge'),
 (294,454,'http://www.statenews.com/index.php/article/2010/03/former_el_mayor_singh_to_run_for_msu_board_of_trustees','Former E.L. mayor Singh to run for MSU Board of Trustees',''),
 (295,455,'http://bythurston.wordpress.com/2010/03/26/hey-lansing-just-b-the-e/','Hey Lansing! Just B the E','Q&A with organizers of EarthDayLansing'),
 (296,456,'http://www.lansingstatejournal.com/article/20100326/NEWS03/3250359/Infrequent-fliers-Lansing-airport-fighting-for-business','Air passenger traffic in Lansing down 59% in 10 years','Airport struggling to compete with other regional airports'),
 (297,457,'http://www.lansingstatejournal.com/article/20100326/NEWS01/3260321/Lansing-police-investigate-possible-homicides','Lansing police investigate possible homicides','');
INSERT INTO `yakimbe`.`link` VALUES  (298,459,'http://www.macsbar.com/','Mustard Plug playing Macs Bar this weekend','Show starts at 6 p.m. March 28'),
 (299,460,'http://www.huffingtonpost.com/2010/03/24/sweet-16-mascots-which-ma_n_510278.html','Vote for Sparty on Huffington Post mascot contest',''),
 (300,462,'http://www.statenews.com/index.php/article/2010/03/away_games','MSU hosts 36 international student-athletes from 13 countries','International students make up 5 percent of the MSU student-athlete population'),
 (301,463,'http://www.capitalgainsmedia.com/innovationnews/humanity0411.aspx','Habitat for Humanity Invests $65,000 in Foreclosed Lansing House','Habitat has already selected a second home for the remediation program'),
 (302,464,'http://www.lansingstatejournal.com/article/20100326/GW0201/3260325/TIME-TO-SHINE-FOR-MSU-BASKETBALL-Spartans-in-the-Sweet-Sixteen','Korie Lucious comes of age after game-winning buzzer beater','Injured Kalin Lucas puts Lucious in the spotlight tonight'),
 (303,465,'http://espn.go.com/blog/collegebasketballnation/tag/_/name/032610-panthers-spartans','ESPN Sweet 16 MSU-Northern Iowa preview','Lucas\' injury puts big question mark on outcome of game');
INSERT INTO `yakimbe`.`link` VALUES  (304,466,'http://www.statenews.com/index.php/article/2010/03/what_it_takes_to_be_elite','What it takes to be Elite','MSU has stronger program, but Northern Iowa is coming in hot after upsetting Kansas'),
 (305,467,'http://www.vancouversun.com/sports/Panthers+Spartans+battle+Louis/2729944/story.html','Panthers and Spartans do battle in St. Louis',''),
 (306,468,'http://www.usatoday.com/sports/college/mensbasketball/2010-03-25-michigan-state-brings-northern-iowa-back-to-reality_N.htm','Michigan State helps bring Northern Iowa back to reality',''),
 (307,469,'http://www.philly.com/inquirer/sports/89250657.html','Northern Iowa no longer underdog to anyone',''),
 (308,470,'http://whitehouse.blogs.foxnews.com/2010/03/25/obama-cheers-on-northern-iowa-in-ncaa/','Obama cheers on Northern Iowa in NCAA',''),
 (309,471,'http://www.freep.com/article/20100325/SPORTS07/3250422/1354/','Northern Iowa following George Mason\'s footsteps',''),
 (310,472,'http://www.northern-iowan.org/panthers-look-for-a-sweet-performance-versus-spartans-1.2203279','Panthers look for a “sweet” performance versus Spartans','Men’s basketball competes in its first-ever Sweet 16 today'),
 (311,473,'http://www.freep.com/article/20100325/SPORTS07/3250423/1055/SPORTS/Tom-Izzo-cautious-of-Northern-Iowas-clutch-shooting','Tom Izzo cautious of Northern Iowa\'s clutch shooting','');
INSERT INTO `yakimbe`.`link` VALUES  (312,474,'http://weblogs.baltimoresun.com/sports/college/maryland_terps/blog/2010/03/michigan_statenorthern_iowa_will_terp_fans_unite.html','Michigan State-Northern Iowa: Will Terp fans unite?',''),
 (313,475,'http://www.statenews.com/index.php/article/2010/03/spartans_northern_iowa_appear_evenly_matched','Nowak: Spartans, Northern Iowa appear evenly matched','');
CREATE TABLE  `yakimbe`.`user` (
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
  `is_admin` tinyint(1) DEFAULT '0',
  `items_per_page` smallint(5) unsigned DEFAULT '20',
  `rating` int(10) unsigned DEFAULT '0',
  `is_account_verified` int(10) unsigned DEFAULT '0' COMMENT '1 if verified, otherwise it''''s their random verification number',
  `email_opt_in` tinyint(1) NOT NULL DEFAULT '0',
  `sex` varchar(20) DEFAULT NULL,
  `birth_year` int(4) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;
INSERT INTO `yakimbe`.`user` VALUES  (9,'jwoodruff','Jesse','Woodruff','I\'m your average workaholic. Me and John Bruce built Yakimbe. From scratch. Also, Yakimbe is a sponsor of Ignite Lansing.','www.yakimbe.com','babble@fish.com','2010-01-22 07:37:24','$2a$11$GRRnC.KEnEcX3R6rvCKZEelEwGMvBgV6WjCVwmd6hiRj7FZeXXpia','Lansing\'s East Side',1,20,0,1,1,'male',1981),
 (33,'babblefish','John',NULL,NULL,NULL,'jbruce2112@gmail.com','2010-03-02 11:56:27','$2a$11$RaKensJXJyhjcdyWiby.1u12fycYuQa1P89KBFXwZhvrlkVP9DB9u',NULL,1,20,0,1,1,NULL,NULL),
 (35,'sparty','Dave',NULL,NULL,NULL,'sparty@gmail.com','2010-03-02 19:53:41','$2a$11$FyWdwFX2Wz/jCGxGt5fpIOsXTtDnd9LQQ2RjieaDG0P1/hGaWIKcS','Grand Ledge',0,20,0,1,1,'male',1978),
 (36,'bethclute','Beth','Clute',NULL,NULL,'bethmclute@gmail.com','2010-03-02 20:47:37','$2a$11$apPOoqj.MVHS11460iikA.bC/Gfe9Mg6aYbrYiOLcZ8LKMyO3opAm','Mason',0,20,0,1,0,'female',1982),
 (37,'jbruce2112','John','Bruce','I helped built Yakimbe along with Jesse. I\'m a student at LCC and enjoy Rush.','http://www.yakimbe.com','john@yakimbe.com','2010-03-04 23:14:23','$2a$11$TS7KILfKaBcfr15ZPqIOxehwJQBDQ4lBcsijVv0ZhANqxy5mz1b0e','Lansing\'s East Side',1,20,0,1,1,'male',1988),
 (38,'usertest','Jesse','Woodruff','I\'m a complete fake.','www.test.com','jesse@jessewoodruff.com','2010-03-06 18:43:22','$2a$11$tOXL6UosWvexgDbOf3hr2eYIPH2WY3cFQQuUXTjEjIhpI0PIJ.6Au','Lansing\'s East Side',0,20,0,1,0,'male',1981);
INSERT INTO `yakimbe`.`user` VALUES  (39,'divamurphy',NULL,NULL,NULL,NULL,'coleymurphy@Hotmail.com','2010-03-06 20:31:19','$2a$11$SQ4DGthkwCKxNI4mmZT6xuxs/VHxJkI4JWOSDPB8C75lhZc8vcC9W',NULL,0,20,0,1,0,NULL,NULL),
 (40,'movcritic','Robin','Miner-Swartz','I\'m the director of communications for the Capital Region Community Foundation, a collection of endowment funds that supports the charitable needs of Ingham, Eaton and Clinton counties.','www.crcfoundation.org','robinminerswartz@yahoo.com','2010-03-08 14:51:25','$2a$11$l5juhkSLmRnfYREAv5XnUO.O/WRQSB9avvh/lR.xC0/CNwHJLLbtu','Lansing\'s West Side',0,20,0,1,0,'female',1971),
 (41,'daniejhogan',NULL,NULL,NULL,NULL,'hogand@gmail.com','2010-03-08 15:52:07','$2a$11$WsREBbHc35F3LBQqW6k6tOAPT1uv/OUU9lV8zx2wlc/WD9wPsAK16',NULL,0,20,0,1,1,NULL,NULL),
 (42,'kiddharma','Sam','Mills','Writer, poet, and a usual suspect who maintains his composure during high-speed chases.',NULL,'sammills@earthlink.net','2010-03-08 19:04:27','$2a$11$s4QepYl.TvtiJZaCpgwygeTIt119zIKfLJ7.QEsNmPZdNSgt8Qw8a','Lansing\'s South Side',0,20,0,1,0,'male',1955),
 (43,'e-train',NULL,NULL,NULL,NULL,'woodruffj2@michigan.gov','2010-03-09 08:10:53','$2a$11$JlsJBT8Ie0YTdiWs6JGd5uwpy03O7x09x4Ni3SGBWqCTQnnW7qUda',NULL,0,20,0,1,1,NULL,NULL);
INSERT INTO `yakimbe`.`user` VALUES  (44,'spacecase',NULL,NULL,NULL,NULL,'emily.wenstrom@gmail.com','2010-03-09 12:56:31','$2a$11$E85YfQec1nhZIqBVfxV6oenz3w3.CWyUOAW8Nm3XTABpApFxKxWye',NULL,0,20,0,1,1,NULL,NULL),
 (45,'rasputin','Angela','Woodruff','I am a PTA student, who love black kittehs!',NULL,'angelawoodruff@hotmail.com','2010-03-09 16:49:10','$2a$11$wRtsIb/SWelemi7vrJSeT.yF1xbOkj6j0nEmJDnNtvxWXlrLlN0hm',NULL,0,20,0,1,0,'female',1976),
 (46,'aribadler','Ari','Adler','I\'m a former journalist who is now putting those skills to use on the other side of the industry as a media-relations professional.\r\n\r\nI handle media relations and social media for a Michigan company and I\'m also an adjunct instructor at Michigan State University.\r\n\r\nI serve as a professional adviser for the MSU chapter of the Public Relations Student Society of America and I\'m available as a speaker and trainer.\r\n\r\nFollow me on Twitter at @aribadler.','www.aribadler.wordpress.com','aribadler@gmail.com','2010-03-12 09:03:59','$2a$11$LM46g.fI2cTbB8PrJAARa.mvil2iPuOaKyoseCSVgQklZlFjjpVcC','Okemos',0,20,0,1,0,'male',1967),
 (47,'lansingcapgains','Ivy','Hughes',NULL,'www.capitalgainsmedia.com','ivy@capitalgainsmedia.com','2010-03-12 09:24:19','$2a$11$FuQwvLEVM9fzFd.2FtvHFeCOagCJZ4m0zVhU1co28BnusaxBiB78G','Lansing\'s East Side',0,20,0,1,0,'female',1981);
INSERT INTO `yakimbe`.`user` VALUES  (48,'jbrucey',NULL,NULL,NULL,NULL,'lol@yakiyaki.com','2010-03-15 00:02:35','$2a$11$JKMpv5FyuTb/Appi8f4Us.iytIKjZ4nF0wSdu98kP491oz/eWfidi',NULL,0,20,0,41364169,0,NULL,NULL),
 (49,'jwood85',NULL,NULL,NULL,NULL,'justinwood24@gmail.com','2010-03-15 03:26:08','$2a$11$7kyolEAIp.i0Dzyj/TKk4eT1NZbDuJP7Frdjr.cqga8RoBCDpeYXq',NULL,0,20,0,1,1,NULL,NULL),
 (50,'cmyk',NULL,NULL,NULL,NULL,'jessewoodruff@hotmail.com','2010-03-15 10:44:42','$2a$11$mMi5aZedVmRWR5KKjRfopeBCYbw/fKar/Gvgy46DfnO/vDOlqKWD2',NULL,0,20,0,1,0,NULL,NULL),
 (51,'Wittmann444','Paul','Wittmann',NULL,NULL,'wittmann444@gmail.com','2010-03-15 12:29:05','$2a$11$EdDtHY5PxrBNVw1rsjqMIOf/5qO4LqkxaxmpWYrg5jPKmWjlD8rxK','Grand Ledge',0,20,0,1,0,'male',1987),
 (52,'Ellen','Ellen','Martin',NULL,NULL,'ellenmartin99@gmail.com','2010-03-15 17:30:05','$2a$11$nwx7oIi7vkJOx9mSINIbNelcTs2tdFQ0USzlxHU8oPzkTbB3um/pG','Holt',0,20,0,1,0,'female',1961),
 (53,'masonchamber',NULL,NULL,NULL,NULL,'masonchamber@masonchamber.org','2010-03-17 10:20:26','$2a$11$zwyY/S3QoyS7l9RujGgCG./mkbtSUPX9KujqJ8ot16Bc0gKiZiN4u',NULL,0,20,0,1,1,NULL,NULL),
 (54,'gregcomperchio','Greg','Comperchio','New Media Account Manager at WILX TV 10 in Lansing, MI. Live in Holt, MI. Graduated with Marketing degree from Western Michigan University in 2004.','www.wilx.com','greg.comperchio@wilx.com','2010-03-17 10:26:28','$2a$11$1nrxcKBJH0iWtBA1DxjZ2.mDbUhjTpfsZaWqxKbzy93m5G8gxyRkq','Charlotte',0,20,0,1,0,'male',1982);
INSERT INTO `yakimbe`.`user` VALUES  (55,'Gene','Gene','Townsend','Building contractor specializing in energy-efficient, healthy & durable residential & commercial new buildings &renovations.  Our company is a member of the US Green Building Council and we have completed several LEED-certified projects.','www.vbihomes.com','eftownsend@gmail.com','2010-03-17 11:40:12','$2a$11$O1U9ckkylbb2gXznay.Fcu6KTThpfkQiEW2nY1T6KYmWYNDce7cFK','Lansing\'s North Side',0,20,0,1,0,'male',1952),
 (56,'ILoveLansing','Kent','Love',NULL,NULL,'kentalove@hotmail.com','2010-03-17 13:13:13','$2a$11$kX.0zDC7MDk.Z.72/rV2cuzPMKBO.e8Hjdtf4iIqTYJGNFGeY5r1.','Lansing\'s West Side',0,20,0,1,0,'male',1970),
 (57,'nbashaw','Nathan','Bashaw','I\'m a student at MSU and an entrepreneur.','www.nathanbashaw.com','nbashaw@gmail.com','2010-03-17 15:14:17','$2a$11$GcZWLI54gAEDj2CfzBpw/e11Wwdp7wVI6kHzYupjEu23tpSPlwfku','East Lansing',0,20,0,1,0,'male',1989),
 (58,'LansingSymphony',NULL,NULL,NULL,NULL,'info@lansingsymphony.org','2010-03-17 16:33:44','$2a$11$dSJoPrhaFLt/uG93mhAqgu0pLC9APq0yDZBEbQKKrG7WWAEf5cdya',NULL,0,20,0,1,1,NULL,NULL),
 (59,'lewisri2',NULL,NULL,NULL,NULL,'rich.lewis@hotmail.com','2010-03-17 22:07:45','$2a$11$hDto/hl8/Fh/jI1R59NWdeQ.IYhctTeHl/LU./jbHG2a8yOF6PESG',NULL,0,20,0,1,1,NULL,NULL);
INSERT INTO `yakimbe`.`user` VALUES  (60,'yakback',NULL,NULL,NULL,NULL,'codeee@yahoo.com','2010-03-18 14:51:18','$2a$11$NtleyIUpts6Dd7..NeFHhOdp5TvSOyh0OfKBTF4XmJKMe4QcKByzy',NULL,0,20,0,1,0,NULL,NULL),
 (61,'bluallstr','Lisa','Benck','map designer, graphic designer, artist, community and revitalization activist. I am interested in sustainable communities and growth, organic and fresh food, and everything outside','www.lisabenck.com','benck.lisa@gmail.com','2010-03-22 09:16:14','$2a$11$7U9jZXxmBecPPRri9zd5DusRxHiso94IJHJ7z9.3QiqAy0z/BLj22',NULL,0,20,0,1,0,'female',1981),
 (62,'BYThurston',NULL,NULL,NULL,NULL,'belinda.thurston@gmail.com','2010-03-24 07:36:52','$2a$11$qlKg8MRTQhgEbs5sC6RmGepso9Nd85oNg9ozeQ7f/nCmbD8quDBJW',NULL,0,20,0,1,1,NULL,NULL),
 (63,'MotherFlippin','Tashmica','Torok',NULL,'www.mother-flippin.blogspot.com','glassb0x@yahoo.com','2010-03-24 11:34:15','$2a$11$IvS6q1NtF0ADy5Zm6d9UoO.wACsgwuAOS5PRfxDMLr5I4BpW1UzMe','Lansing\'s South Side',0,20,0,1,0,'female',1980),
 (64,'redspecs',NULL,NULL,NULL,NULL,'kidron@pioneercable.net','2010-03-24 19:18:27','$2a$11$ZEicOBh/Wj1BiK9dKwtx6e.DCbj7v5q6IANUAMHT2uW3/Z1V2JsiG',NULL,0,20,0,1,1,NULL,NULL),
 (65,'testnewuser',NULL,NULL,NULL,NULL,'omgwhathappened@hotmail.com','2010-03-24 21:08:00','$2a$11$JL1q73UmDFarKYyOD4H5yOEN6bSAfp2uxZcFipAOtAxC/LFM3CmFK',NULL,0,20,0,1,1,NULL,NULL);
INSERT INTO `yakimbe`.`user` VALUES  (66,'whyshitdoesntwork',NULL,NULL,NULL,NULL,'whyshitdoesntwork@hotmail.com','2010-03-24 21:17:00','$2a$11$eeZG4za0vSqBhnBv5ldYZuiUxf6x/wjJPTy6uPM/X5ATDGqt7f.Lu',NULL,0,20,0,55116758,1,NULL,NULL),
 (67,'auntm60','Marian','Bliznik','I hail from Calif. and am the PROUD Aunt of John Bruce!  Will follow with interest! Aunt Marian',NULL,'mbliznik@yahoo.com','2010-03-24 22:02:27','$2a$11$SkVLCmgopuLQVSNAEhIiT.LsWJdIBMZk1e30igMYZb6e2vs1nTY3u',NULL,0,20,0,1,0,'female',1949),
 (68,'spotlightkell','Kelly','Steffen',NULL,'www.spotlightcampus.org','steffe211@gmail.com','2010-03-25 10:46:45','$2a$11$Pa9XAJYGOfqvTMtdBatmHOQ6Ts.8K4xUuln1uhJ2LifRm9SEBnTs6','East Lansing',0,20,0,1,0,'female',1987),
 (69,'emilylawler','Emily','Lawler','I\'m the editor of an alternative MSU publication, The Big Green. And in general, I love the Lansing news scene! ','www.thebiggreen.net','lawlere1@msu.edu','2010-03-26 13:40:08','$2a$11$iFLpE3v4CC9ea/pRPl7aieDTcm3vP27bcNgjFxFM0CwO8d93QhNxi','East Lansing',0,20,0,1,0,'female',1989);

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` FUNCTION  `yakimbe`.`isEmailUnique`(inputEmail VARCHAR(75)) RETURNS tinyint(1)
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

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` FUNCTION  `yakimbe`.`isUserNameUnique`(inputUserName VARCHAR(20)) RETURNS tinyint(1)
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

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `yakimbe`.`createNewUser`(IN strUserName VARCHAR(20), IN strFirstName VARCHAR(20), 
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

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `yakimbe`.`getComments`(In itemCommentingOnId INT)
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

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `yakimbe`.`getLink`(In myItemId INT)
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

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `yakimbe`.`getMostActive`(IN resultSetLimit INT, IN startPos INT)
BEGIN
  
  IF (startPos > 0) THEN
  
    SET SQL_SELECT_LIMIT = resultSetLimit + startPos;
    SET @rownum=0;
    
    SELECT * 
    FROM (
          SELECT @rownum:=@rownum+1 'itemCount', i.item_id, u.user_name, u.user_id, i.submission_time, 
                i.rating, i.item_type, i.location, l.link_id, l.url, l.headline, l.subhead,
                (SELECT count(c.item_id) from comment c where c.item_commenting_on_id = i.item_id) num_comments
          FROM item i
              INNER JOIN link l
                ON l.item_id = i.item_id
              INNER JOIN user u
                ON u.user_id = i.user_id
          WHERE i.is_dead = false AND
                (i.submission_time >= DATE_SUB(CURDATE(), INTERVAL 2 WEEK))
          ORDER BY i.rating DESC
          ) t
    WHERE t.itemCount > startPos;
    
  ELSE
  
    SET SQL_SELECT_LIMIT = resultSetLimit;
    
    SELECT @rownum:=@rownum+1 'itemCount', i.item_id, u.user_name, u.user_id, i.submission_time, 
            i.rating, i.item_type, i.location, l.link_id, l.url, l.headline, l.subhead,
           (SELECT count(c.item_id) from comment c where c.item_commenting_on_id = i.item_id) num_comments
          FROM item i
              INNER JOIN link l
                ON l.item_id = i.item_id
              INNER JOIN user u
                ON u.user_id = i.user_id
          WHERE i.is_dead = false AND
                (i.submission_time >= DATE_SUB(CURDATE(), INTERVAL 2 WEEK))
          ORDER BY i.rating DESC; 
    
  
  END IF;

  SET SQL_SELECT_LIMIT = default;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `yakimbe`.`getNewLinks`(IN resultSetLimit INT,IN startPos INT)
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

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `yakimbe`.`getUpwardTrending`(IN resultSetLimit INT, IN startPos INT)
BEGIN

  IF (startPos > 0) THEN
  
    SET SQL_SELECT_LIMIT = resultSetLimit+startPos;
    SET @rownum=0;
    
    SELECT *
    FROM (
          SELECT DISTINCT @rownum:=@rownum+1 'itemCount', i.item_id, i.submission_time, i.rating, 
                i.item_type, i.location, l.headline, l.subhead, l.url, l.link_id, u.user_name, u.user_id, 
                (SELECT count(a.item_id) from action a where a.item_id = i.item_id) num_actions,
                (SELECT count(c.item_id) from comment c where c.item_commenting_on_id = i.item_id) num_comments
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
          ORDER BY num_actions DESC
          ) t
    WHERE t.itemCount > startPos;
    
  ELSE
  
    SET SQL_SELECT_LIMIT = resultSetLimit;
    
    SELECT DISTINCT i.item_id, i.submission_time, i.rating, 
                i.item_type, i.location, l.headline, l.subhead, l.url, l.link_id, u.user_name, u.user_id, 
                (SELECT count(a.item_id) from action a where a.item_id = i.item_id) num_actions,
                (SELECT count(c.item_id) from comment c where c.item_commenting_on_id = i.item_id) num_comments
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
      
  END IF;
  
  SET SQL_SELECT_LIMIT = default;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `yakimbe`.`getUser`(strUserName varchar(20), strPassword varchar(20), strEncryptionKey varchar(20))
BEGIN
	SELECT * 
  FROM user u
  WHERE u.user_name = strUserName AND
        AES_DECRYPT(u.pwd, strEncryptionKey) = strPassword;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `yakimbe`.`insertComment`(IN intUserId mediumint(8), IN body VARCHAR(2000), IN parentId bigint(20), IN itemCommentingOnId bigint(20))
BEGIN
	INSERT INTO comment (comment_id, item_id, body, parent_comment_id, item_commenting_on_id)
				VALUES (NULL, (SELECT MAX(item_id) FROM item i INNER JOIN user u ON u.user_id = i.user_id WHERE u.user_id = intUserId),
						body, parentId, itemCommentingOnId);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `yakimbe`.`insertItem`(IN intUserId mediumint(8), IN strItemSubmissionType VARCHAR(10))
BEGIN
			INSERT INTO  item (item_id, user_id, submission_time, item_type)
						VALUES (NULL, intUserId, NOW(), strItemSubmissionType);
		END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `yakimbe`.`insertLink`(IN intUserId mediumint(8), IN strURL VARCHAR(2000), IN strHeadline VARCHAR(90), IN strSubhead VARCHAR(90))
BEGIN
			INSERT INTO link (link_id, item_id, url, headline, subhead)
						VALUES (NULL, (SELECT MAX(item_id) FROM item i INNER JOIN user u ON u.user_id = i.user_id WHERE u.user_id = intUserId),
								strURL, strHeadline, strSubhead);
		END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `yakimbe`.`insertNewAction`(IN strUserName VARCHAR(20), IN strActionType VARCHAR(20), IN longItemId bigint(20))
BEGIN
			INSERT INTO action (action_id, item_id, user_id, action_type, datetime)
						VALUES (NULL, longItemId, (SELECT u.user_id FROM user u WHERE strUserName = u.user_name), strActionType, NOW());
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `yakimbe`.`updateRating`(IN updatedRating INT, IN longItemId LONG)
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
