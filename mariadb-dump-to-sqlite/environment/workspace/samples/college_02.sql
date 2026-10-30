/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.4.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: college_02
-- ------------------------------------------------------
-- Server version	11.4.13-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `admissions`
--

DROP TABLE IF EXISTS `admissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `admissions` (
  `campus` smallint(6) NOT NULL DEFAULT 1,
  `student_id` bigint(20) NOT NULL,
  `name` varchar(180) NOT NULL DEFAULT 'not supplied',
  `email` varchar(200) DEFAULT NULL,
  `born` date NOT NULL DEFAULT '0000-00-00',
  `flags` bit(8) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`campus`,`student_id`),
  UNIQUE KEY `email_key` (`email`),
  KEY `name_key` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admissions`
--
-- ORDER BY:  `campus`,`student_id`

LOCK TABLES `admissions` WRITE;
/*!40000 ALTER TABLE `admissions` DISABLE KEYS */;
INSERT INTO `admissions` (`campus`, `student_id`, `name`, `email`, `born`, `flags`) VALUES (1,9000002000,'O\'Neil; DROP TABLE fees; -- student 2-0',NULL,'0000-00-00','M'),
(1,9000002001,'line one\nline two\r	tab student 2-1','2.1@college.example.org','2001-02-12','€'),
(1,9000002002,'zero\0end\Z student 2-2','2.2@college.example.org','2002-02-12','U'),
(1,9000002003,'back\\slash and \\n literal student 2-3','2.3@college.example.org','2003-02-12','A'),
(1,9000002004,'emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª student 2-4','2.4@college.example.org','2004-02-12','m'),
(1,9000002005,'/* comment */ (one), two; DELIMITER ;; student 2-5','2.5@college.example.org','0000-00-00',''),
(1,9000002006,'double \"quote\" and `tick` student 2-6',NULL,'2006-02-12','	'),
(1,9000002007,'100%_done student 2-7','2.7@college.example.org','2007-02-12','Z'),
(1,9000002008,' student 2-8','2.8@college.example.org','2008-02-12','!'),
(1,9000002009,'O\'Neil; DROP TABLE fees; -- student 2-9','2.9@college.example.org','2009-02-12',''),
(1,9000002010,'line one\nline two\r	tab student 2-10','2.10@college.example.org','0000-00-00','<'),
(1,9000002011,'zero\0end\Z student 2-11','2.11@college.example.org','2001-02-12',''),
(1,9000002012,'back\\slash and \\n literal student 2-12',NULL,'2002-02-12','Í'),
(1,9000002013,'emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª student 2-13','2.13@college.example.org','2003-02-12',''),
(1,9000002014,'/* comment */ (one), two; DELIMITER ;; student 2-14','2.14@college.example.org','2004-02-12','r'),
(1,9000002015,'double \"quote\" and `tick` student 2-15','2.15@college.example.org','0000-00-00','ƒ'),
(1,9000002016,'100%_done student 2-16','2.16@college.example.org','2006-02-12','h'),
(1,9000002017,' student 2-17','2.17@college.example.org','2007-02-12','¿'),
(1,9000002018,'O\'Neil; DROP TABLE fees; -- student 2-18',NULL,'2008-02-12','…'),
(1,9000002019,'line one\nline two\r	tab student 2-19','2.19@college.example.org','2009-02-12',''),
(1,9000002020,'zero\0end\Z student 2-20','2.20@college.example.org','0000-00-00','­'),
(1,9000002021,'back\\slash and \\n literal student 2-21','2.21@college.example.org','2001-02-12','‚'),
(1,9000002022,'emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª student 2-22','2.22@college.example.org','2002-02-12','k'),
(1,9000002023,'/* comment */ (one), two; DELIMITER ;; student 2-23','2.23@college.example.org','2003-02-12','');
/*!40000 ALTER TABLE `admissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER normalise_name BEFORE UPDATE ON `admissions` FOR EACH ROW BEGIN SET NEW.name = TRIM(NEW.name); SET NEW.campus=NEW.campus; END 
*/;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `archive``notes`
--

DROP TABLE IF EXISTS `archive``notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `archive``notes` (
  `sequence` bigint(20) NOT NULL,
  `section` varchar(30) NOT NULL,
  `comment` longtext DEFAULT NULL,
  `raw` varbinary(200) DEFAULT NULL,
  PRIMARY KEY (`section`,`sequence`),
  UNIQUE KEY `seq_key` (`sequence`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archive``notes`
--
-- ORDER BY:  `section`,`sequence`

LOCK TABLES `archive``notes` WRITE;
/*!40000 ALTER TABLE `archive``notes` DISABLE KEYS */;
INSERT INTO `archive``notes` (`sequence`, `section`, `comment`, `raw`) VALUES (0,'hostel-0','O\'Neil; DROP TABLE fees; -- archive 941038925506024','\0\'\\\Zÿ\0'),
(7,'hostel-0','100%_done archive 1004584899062257','\0\'\\\Zÿ'),
(14,'hostel-0','/* comment */ (one), two; DELIMITER ;; archive 396378788954089','\0\'\\\Zÿ'),
(21,'hostel-0','back\\slash and \\n literal archive 670509032960476','\0\'\\\Zÿ'),
(28,'hostel-0','line one\nline two\r	tab archive 653451892523305','\0\'\\\Zÿ'),
(35,'hostel-0',' archive 1049497732668099','\0\'\\\Zÿ#'),
(1,'hostel-1','line one\nline two\r	tab archive 455665790691412','\0\'\\\Zÿ'),
(8,'hostel-1',' archive 517895520382052','\0\'\\\Zÿ'),
(15,'hostel-1','double \"quote\" and `tick` archive 215101896893903','\0\'\\\Zÿ'),
(22,'hostel-1','emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª archive 649354668128708','\0\'\\\Zÿ'),
(29,'hostel-1','zero\0end\Z archive 465524986920339','\0\'\\\Zÿ'),
(36,'hostel-1','O\'Neil; DROP TABLE fees; -- archive 491318931963356','\0\'\\\Zÿ$'),
(2,'hostel-2','zero\0end\Z archive 64174666591892','\0\'\\\Zÿ'),
(9,'hostel-2','O\'Neil; DROP TABLE fees; -- archive 1118208747433586','\0\'\\\Zÿ	'),
(16,'hostel-2','100%_done archive 854035872633882','\0\'\\\Zÿ'),
(23,'hostel-2','/* comment */ (one), two; DELIMITER ;; archive 948441540524121','\0\'\\\Zÿ'),
(30,'hostel-2','back\\slash and \\n literal archive 465331792349464','\0\'\\\Zÿ'),
(3,'hostel-3','back\\slash and \\n literal archive 1105032170794029','\0\'\\\Zÿ'),
(10,'hostel-3','line one\nline two\r	tab archive 604434791685688','\0\'\\\Zÿ\n'),
(17,'hostel-3',' archive 336350616000576','\0\'\\\Zÿ'),
(24,'hostel-3','double \"quote\" and `tick` archive 66263788250669','\0\'\\\Zÿ'),
(31,'hostel-3','emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª archive 911509773571724','\0\'\\\Zÿ'),
(4,'hostel-4','emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª archive 796387368110948','\0\'\\\Zÿ'),
(11,'hostel-4','zero\0end\Z archive 125079943215120','\0\'\\\Zÿ'),
(18,'hostel-4','O\'Neil; DROP TABLE fees; -- archive 11483230992751','\0\'\\\Zÿ'),
(25,'hostel-4','100%_done archive 957926231796399','\0\'\\\Zÿ'),
(32,'hostel-4','/* comment */ (one), two; DELIMITER ;; archive 359841603223193','\0\'\\\Zÿ '),
(5,'hostel-5','/* comment */ (one), two; DELIMITER ;; archive 15829203073009','\0\'\\\Zÿ'),
(12,'hostel-5','back\\slash and \\n literal archive 19626421591701','\0\'\\\Zÿ'),
(19,'hostel-5','line one\nline two\r	tab archive 455050095882126','\0\'\\\Zÿ'),
(26,'hostel-5',' archive 577779884973028','\0\'\\\Zÿ\Z'),
(33,'hostel-5','double \"quote\" and `tick` archive 386969208813956','\0\'\\\Zÿ!'),
(6,'hostel-6','double \"quote\" and `tick` archive 1071606874832407','\0\'\\\Zÿ'),
(13,'hostel-6','emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª archive 156795479724318','\0\'\\\Zÿ\r'),
(20,'hostel-6','zero\0end\Z archive 750613822810204','\0\'\\\Zÿ'),
(27,'hostel-6','O\'Neil; DROP TABLE fees; -- archive 291452188038457','\0\'\\\Zÿ'),
(34,'hostel-6','100%_done archive 878831936193588','\0\'\\\Zÿ\"');
/*!40000 ALTER TABLE `archive``notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `current_students`
--

DROP TABLE IF EXISTS `current_students`;
/*!50001 DROP VIEW IF EXISTS `current_students`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `current_students` AS SELECT
 NULL AS `campus`,
 NULL AS `student_id` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `exam results`
--

DROP TABLE IF EXISTS `exam results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam results` (
  `id` int(11) NOT NULL,
  `book` varchar(40) DEFAULT NULL,
  `term` varchar(20) NOT NULL DEFAULT 'term 1',
  `mark` decimal(12,4) DEFAULT NULL,
  `stamp` timestamp NOT NULL DEFAULT '2020-01-01 00:00:00',
  `duration` time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (`id`),
  KEY `exam_book` (`book`),
  KEY `term_key` (`term`,`mark`),
  CONSTRAINT `exam_book` FOREIGN KEY (`book`) REFERENCES `group` (`code`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam results`
--
-- ORDER BY:  `id`

LOCK TABLES `exam results` WRITE;
/*!40000 ALTER TABLE `exam results` DISABLE KEYS */;
INSERT INTO `exam results` (`id`, `book`, `term`, `mark`, `stamp`, `duration`) VALUES (0,'book-0','term 1',0.1200,'2020-02-12 13:14:15','00:12:34'),
(1,'book-1','term 2',1.1200,'2020-02-12 13:14:15','01:12:34'),
(2,'book-2','term 3',2.1200,'2020-02-12 13:14:15','02:12:34'),
(3,'book-3','term 1',3.1200,'2020-02-12 13:14:15','03:12:34'),
(4,'book-4','term 2',4.1200,'2020-02-12 13:14:15','04:12:34'),
(5,'book-5','term 3',5.1200,'2020-02-12 13:14:15','05:12:34'),
(6,'book-6','term 1',6.1200,'2020-02-12 13:14:15','06:12:34'),
(7,'book-7','term 2',7.1200,'2020-02-12 13:14:15','07:12:34'),
(8,'book-8','term 3',8.1200,'2020-02-12 13:14:15','08:12:34'),
(9,'book-9','term 1',9.1200,'2020-02-12 13:14:15','09:12:34'),
(10,'book-10','term 2',10.1200,'2020-02-12 13:14:15','10:12:34'),
(11,'book-11','term 3',11.1200,'2020-02-12 13:14:15','11:12:34'),
(12,'book-12','term 1',12.1200,'2020-02-12 13:14:15','12:12:34'),
(13,'book-13','term 2',13.1200,'2020-02-12 13:14:15','13:12:34'),
(14,'book-14','term 3',14.1200,'2020-02-12 13:14:15','14:12:34'),
(15,'book-15','term 1',15.1200,'2020-02-12 13:14:15','15:12:34'),
(16,'book-16','term 2',16.1200,'2020-02-12 13:14:15','16:12:34'),
(17,'book-17','term 3',17.1200,'2020-02-12 13:14:15','17:12:34'),
(18,'book-18','term 1',18.1200,'2020-02-12 13:14:15','18:12:34'),
(19,'book-19','term 2',19.1200,'2020-02-12 13:14:15','19:12:34'),
(20,'book-20','term 3',20.1200,'2020-02-12 13:14:15','20:12:34'),
(21,'book-21','term 1',21.1200,'2020-02-12 13:14:15','21:12:34'),
(22,'book-22','term 2',22.1200,'2020-02-12 13:14:15','22:12:34'),
(23,'book-23','term 3',23.1200,'2020-02-12 13:14:15','23:12:34');
/*!40000 ALTER TABLE `exam results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fees`
--

DROP TABLE IF EXISTS `fees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fees` (
  `receipt` int(11) NOT NULL AUTO_INCREMENT,
  `campus` smallint(6) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `paid_at` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `memo` text DEFAULT NULL,
  PRIMARY KEY (`receipt`),
  UNIQUE KEY `payment_key` (`campus`,`student_id`,`paid_at`),
  KEY `amount_key` (`amount`),
  CONSTRAINT `fee_student` FOREIGN KEY (`campus`, `student_id`) REFERENCES `admissions` (`campus`, `student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fees`
--
-- ORDER BY:  `receipt`

LOCK TABLES `fees` WRITE;
/*!40000 ALTER TABLE `fees` DISABLE KEYS */;
INSERT INTO `fees` (`receipt`, `campus`, `student_id`, `amount`, `paid_at`, `memo`) VALUES (1,1,9000002000,-783781091503038230.78055150,'2026-10-01 12:34:56','O\'Neil; DROP TABLE fees; --'),
(2,1,9000002001,663553853945908413.84410506,'2026-10-02 12:34:56','line one\nline two\r	tab'),
(3,1,9000002002,319742376142631851.95530902,'2026-10-03 12:34:56','zero\0end\Z'),
(4,1,9000002003,-105766461707307785.98918692,'2026-10-04 12:34:56','back\\slash and \\n literal'),
(5,1,9000002004,308755243028701161.56772940,'2026-10-05 12:34:56','emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª'),
(6,1,9000002005,206030600047137080.40913810,'2026-10-06 12:34:56','/* comment */ (one), two; DELIMITER ;;'),
(7,1,9000002006,-735001655139248546.00867078,'2026-10-07 12:34:56','double \"quote\" and `tick`'),
(8,1,9000002007,399081683844182416.16058382,'2026-10-08 12:34:56','100%_done'),
(9,1,9000002008,765897949231818453.58927034,'2026-10-09 12:34:56',''),
(10,1,9000002009,-661599392345620326.31734654,'2026-10-10 12:34:56','O\'Neil; DROP TABLE fees; --'),
(11,1,9000002010,912273125283078170.75038656,'2026-10-11 12:34:56','line one\nline two\r	tab'),
(12,1,9000002011,772309489439538519.69865181,'2026-10-12 12:34:56','zero\0end\Z'),
(13,1,9000002012,-447738433643474075.58779816,'2026-10-13 12:34:56','back\\slash and \\n literal'),
(14,1,9000002013,506035531473234846.93428468,'2026-10-14 12:34:56','emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª'),
(15,1,9000002014,939551666794220983.64053350,'2026-10-15 12:34:56','/* comment */ (one), two; DELIMITER ;;'),
(16,1,9000002015,-580501994959560303.65242994,'2026-10-16 12:34:56','double \"quote\" and `tick`'),
(17,1,9000002016,668131594800354658.86059010,'2026-10-17 12:34:56','100%_done'),
(18,1,9000002017,337804451204205157.50993090,'2026-10-18 12:34:56',''),
(19,1,9000002018,-359277054300284247.70684921,'2026-10-19 12:34:56','O\'Neil; DROP TABLE fees; --'),
(20,1,9000002019,504805899792021094.88180886,'2026-10-20 12:34:56','line one\nline two\r	tab'),
(21,1,9000002020,209181858919088043.30444217,'2026-10-21 12:34:56','zero\0end\Z'),
(22,1,9000002021,-885528488200893860.75420459,'2026-10-22 12:34:56','back\\slash and \\n literal'),
(23,1,9000002022,509893504802110519.78630077,'2026-10-23 12:34:56','emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª'),
(24,1,9000002023,158268710883708948.40474898,'2026-10-24 12:34:56','/* comment */ (one), two; DELIMITER ;;');
/*!40000 ALTER TABLE `fees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `group` (
  `code` varchar(40) NOT NULL,
  `label` varchar(150) NOT NULL DEFAULT 'book; (new), copy',
  `payload` longblob DEFAULT NULL,
  `signature` binary(8) DEFAULT NULL,
  `note` varchar(200) DEFAULT 'it''s ready',
  `active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`code`),
  UNIQUE KEY `label_key` (`label`),
  KEY `active_key` (`active`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--
-- ORDER BY:  `code`

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` (`code`, `label`, `payload`, `signature`, `note`, `active`) VALUES ('book-0','Library 2 O\'Neil; DROP TABLE fees; --0',NULL,'\0\0\0\0\0\0\0\0','zero\0end\Z',0),
('book-1','Library 2 line one\nline two\r	tab1','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿæ','','back\\slash and \\n literal',1),
('book-10','Library 2 line one\nline two\r	tab10','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿ©ï[/uƒÙaÀ','\n\n\n\n\n\n\n\n','back\\slash and \\n literal',0),
('book-11','Library 2 zero\0end\Z11','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿ¸k\n÷§.ÊQÖ','','emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª',1),
('book-12','Library 2 back\\slash and \\n literal12','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿ¿T©SÆQ¿[:v6W','','/* comment */ (one), two; DELIMITER ;;',0),
('book-13','Library 2 emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª13','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿ=°ÇëÆ?x´ğ}#','\r\r\r\r\r\r\r\r','double \"quote\" and `tick`',1),
('book-14','Library 2 /* comment */ (one), two; DELIMITER ;;14',NULL,'','100%_done',0),
('book-15','Library 2 double \"quote\" and `tick`15','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿ{?:\r–¹«ë[iLßj)','','',1),
('book-16','Library 2 100%_done16','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿ6M0´Ÿo©‚y‘Y^Ÿ@','','O\'Neil; DROP TABLE fees; --',0),
('book-17','Library 2 17','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿÍœFÓ^~Ø*ó*','','line one\nline two\r	tab',1),
('book-18','Library 2 O\'Neil; DROP TABLE fees; --18','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿGäº4PQh \"\"­ØëB>]x','','zero\0end\Z',0),
('book-19','Library 2 line one\nline two\r	tab19','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿ”_Í} û)@‡ıc%·Öõ?r','','back\\slash and \\n literal',1),
('book-2','Library 2 zero\0end\Z2','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿ=Ğ','','emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª',0),
('book-20','Library 2 zero\0end\Z20','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿ›ªÆÜSåÅ1Ø?tÃZB>¾m','','emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª',0),
('book-21','Library 2 back\\slash and \\n literal21',NULL,'','/* comment */ (one), two; DELIMITER ;;',1),
('book-22','Library 2 emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª22','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿMÄc İ”³ìµ¶JDG&Ùı.ã±«ª','','double \"quote\" and `tick`',0),
('book-23','Library 2 /* comment */ (one), two; DELIMITER ;;23','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿ–›Kx3\"ó\\Éw7bÚ¨ş]ğ±%','','100%_done',1),
('book-3','Library 2 back\\slash and \\n literal3','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿ“É','','/* comment */ (one), two; DELIMITER ;;',1),
('book-4','Library 2 emoji ğŸ“ğŸ™‚ cafÃ© æ—¥æœ¬èª4','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿ£Ä(g','','double \"quote\" and `tick`',0),
('book-5','Library 2 /* comment */ (one), two; DELIMITER ;;5','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿç¬.[','','100%_done',1),
('book-6','Library 2 double \"quote\" and `tick`6','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿ…æº„á','','',0),
('book-7','Library 2 100%_done7',NULL,'','O\'Neil; DROP TABLE fees; --',1),
('book-8','Library 2 8','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿ²îì¯¸º»','','line one\nline two\r	tab',0),
('book-9','Library 2 O\'Neil; DROP TABLE fees; --9','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿÏı”jDgßÙŸ','								','zero\0end\Z',1);
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostel counts`
--

DROP TABLE IF EXISTS `hostel counts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hostel counts` (
  `room` int(11) DEFAULT NULL,
  `reading` double NOT NULL DEFAULT 1.25,
  `label` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostel counts`
--

LOCK TABLES `hostel counts` WRITE;
/*!40000 ALTER TABLE `hostel counts` DISABLE KEYS */;
INSERT INTO `hostel counts` (`room`, `reading`, `label`) VALUES (1,1.25,'duplicate'),
(1,1.25,'duplicate'),
(NULL,-0.125,NULL),
(2,0.00000001,'small');
/*!40000 ALTER TABLE `hostel counts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `current_students`
--

/*!50001 DROP VIEW IF EXISTS `current_students`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `current_students` AS select `admissions`.`campus` AS `campus`,`admissions`.`student_id` AS `student_id` from `admissions` */;
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
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed
