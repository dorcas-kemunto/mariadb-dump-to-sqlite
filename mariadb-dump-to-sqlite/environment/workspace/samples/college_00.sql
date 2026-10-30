/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.4.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: college_00
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
INSERT INTO `admissions` VALUES
(1,9000000000,'O\'Neil; DROP TABLE fees; -- student 0-0',NULL,'0000-00-00',','),
(1,9000000001,'line one\nline two\r	tab student 0-1','0.1@college.example.org','2001-02-12','e'),
(1,9000000002,'zero\0end\Z student 0-2','0.2@college.example.org','2002-02-12','–'),
(1,9000000003,'back\\slash and \\n literal student 0-3','0.3@college.example.org','2003-02-12','ΐ'),
(1,9000000004,'emoji π“π™‚ cafΓ© ζ—¥ζ¬θª student 0-4','0.4@college.example.org','2004-02-12','-'),
(1,9000000005,'/* comment */ (one), two; DELIMITER ;; student 0-5','0.5@college.example.org','0000-00-00','>'),
(1,9000000006,'double \"quote\" and `tick` student 0-6',NULL,'2006-02-12',''),
(1,9000000007,'100%_done student 0-7','0.7@college.example.org','2007-02-12','_'),
(1,9000000008,' student 0-8','0.8@college.example.org','2008-02-12','a'),
(1,9000000009,'O\'Neil; DROP TABLE fees; -- student 0-9','0.9@college.example.org','2009-02-12','<'),
(1,9000000010,'line one\nline two\r	tab student 0-10','0.10@college.example.org','0000-00-00','‡'),
(1,9000000011,'zero\0end\Z student 0-11','0.11@college.example.org','2001-02-12','Ή'),
(1,9000000012,'back\\slash and \\n literal student 0-12',NULL,'2002-02-12','^'),
(1,9000000013,'emoji π“π™‚ cafΓ© ζ—¥ζ¬θª student 0-13','0.13@college.example.org','2003-02-12','l'),
(1,9000000014,'/* comment */ (one), two; DELIMITER ;; student 0-14','0.14@college.example.org','2004-02-12','%'),
(1,9000000015,'double \"quote\" and `tick` student 0-15','0.15@college.example.org','0000-00-00',''),
(1,9000000016,'100%_done student 0-16','0.16@college.example.org','2006-02-12',''),
(1,9000000017,' student 0-17','0.17@college.example.org','2007-02-12','{'),
(1,9000000018,'O\'Neil; DROP TABLE fees; -- student 0-18',NULL,'2008-02-12','ή'),
(1,9000000019,'line one\nline two\r	tab student 0-19','0.19@college.example.org','2009-02-12','Ύ'),
(1,9000000020,'zero\0end\Z student 0-20','0.20@college.example.org','0000-00-00','&'),
(1,9000000021,'back\\slash and \\n literal student 0-21','0.21@college.example.org','2001-02-12','J');
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
INSERT INTO `archive``notes` VALUES
(0,'hostel-0','O\'Neil; DROP TABLE fees; -- archive 1027173029068693','\0\'\\\Zÿ\0'),
(7,'hostel-0','100%_done archive 899403308012462','\0\'\\\Zÿ'),
(14,'hostel-0','/* comment */ (one), two; DELIMITER ;; archive 597934602021398','\0\'\\\Zÿ'),
(21,'hostel-0','back\\slash and \\n literal archive 269808152893180','\0\'\\\Zÿ'),
(28,'hostel-0','line one\nline two\r	tab archive 611625255624901','\0\'\\\Zÿ'),
(1,'hostel-1','line one\nline two\r	tab archive 399400139650829','\0\'\\\Zÿ'),
(8,'hostel-1',' archive 874761615132649','\0\'\\\Zÿ'),
(15,'hostel-1','double \"quote\" and `tick` archive 1085523916484417','\0\'\\\Zÿ'),
(22,'hostel-1','emoji π“π™‚ cafΓ© ζ—¥ζ¬θª archive 329758025401093','\0\'\\\Zÿ'),
(29,'hostel-1','zero\0end\Z archive 535999313142401','\0\'\\\Zÿ'),
(2,'hostel-2','zero\0end\Z archive 272867188260317','\0\'\\\Zÿ'),
(9,'hostel-2','O\'Neil; DROP TABLE fees; -- archive 313819539099855','\0\'\\\Zÿ	'),
(16,'hostel-2','100%_done archive 628693235319756','\0\'\\\Zÿ'),
(23,'hostel-2','/* comment */ (one), two; DELIMITER ;; archive 658287191558798','\0\'\\\Zÿ'),
(30,'hostel-2','back\\slash and \\n literal archive 643753782254129','\0\'\\\Zÿ'),
(3,'hostel-3','back\\slash and \\n literal archive 845243976081368','\0\'\\\Zÿ'),
(10,'hostel-3','line one\nline two\r	tab archive 438931494707190','\0\'\\\Zÿ\n'),
(17,'hostel-3',' archive 498548091771872','\0\'\\\Zÿ'),
(24,'hostel-3','double \"quote\" and `tick` archive 521280680295292','\0\'\\\Zÿ'),
(31,'hostel-3','emoji π“π™‚ cafΓ© ζ—¥ζ¬θª archive 23437909021199','\0\'\\\Zÿ'),
(4,'hostel-4','emoji π“π™‚ cafΓ© ζ—¥ζ¬θª archive 96022281214342','\0\'\\\Zÿ'),
(11,'hostel-4','zero\0end\Z archive 220523152640670','\0\'\\\Zÿ'),
(18,'hostel-4','O\'Neil; DROP TABLE fees; -- archive 310287168196068','\0\'\\\Zÿ'),
(25,'hostel-4','100%_done archive 664458997479170','\0\'\\\Zÿ'),
(32,'hostel-4','/* comment */ (one), two; DELIMITER ;; archive 1083487206961768','\0\'\\\Zÿ '),
(5,'hostel-5','/* comment */ (one), two; DELIMITER ;; archive 1049680097219568','\0\'\\\Zÿ'),
(12,'hostel-5','back\\slash and \\n literal archive 694091300169756','\0\'\\\Zÿ'),
(19,'hostel-5','line one\nline two\r	tab archive 1008079702170267','\0\'\\\Zÿ'),
(26,'hostel-5',' archive 602311478067798','\0\'\\\Zÿ\Z'),
(33,'hostel-5','double \"quote\" and `tick` archive 527532140201372','\0\'\\\Zÿ!'),
(6,'hostel-6','double \"quote\" and `tick` archive 318610531704875','\0\'\\\Zÿ'),
(13,'hostel-6','emoji π“π™‚ cafΓ© ζ—¥ζ¬θª archive 341316903502085','\0\'\\\Zÿ\r'),
(20,'hostel-6','zero\0end\Z archive 393231597002211','\0\'\\\Zÿ'),
(27,'hostel-6','O\'Neil; DROP TABLE fees; -- archive 235378741281042','\0\'\\\Zÿ'),
(34,'hostel-6','100%_done archive 90840222348942','\0\'\\\Zÿ\"');
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
INSERT INTO `exam results` VALUES
(0,'book-0','term 1',0.1200,'2020-02-12 13:14:15','00:12:34'),
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
(21,'book-21','term 1',21.1200,'2020-02-12 13:14:15','21:12:34');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fees`
--
-- ORDER BY:  `receipt`

LOCK TABLES `fees` WRITE;
/*!40000 ALTER TABLE `fees` DISABLE KEYS */;
INSERT INTO `fees` VALUES
(1,1,9000000000,-110826184777647653.33637562,'2026-10-01 12:34:56','O\'Neil; DROP TABLE fees; --'),
(2,1,9000000001,142169328640712434.12289094,'2026-10-02 12:34:56','line one\nline two\r	tab'),
(3,1,9000000002,909271757343955259.30848290,'2026-10-03 12:34:56','zero\0end\Z'),
(4,1,9000000003,-731257583489619760.88897741,'2026-10-04 12:34:56','back\\slash and \\n literal'),
(5,1,9000000004,444456129179742237.78947580,'2026-10-05 12:34:56','emoji π“π™‚ cafΓ© ζ—¥ζ¬θª'),
(6,1,9000000005,623757311896952932.06181189,'2026-10-06 12:34:56','/* comment */ (one), two; DELIMITER ;;'),
(7,1,9000000006,-879555133905379164.88590065,'2026-10-07 12:34:56','double \"quote\" and `tick`'),
(8,1,9000000007,253353643294768246.37493832,'2026-10-08 12:34:56','100%_done'),
(9,1,9000000008,867173534849911619.65994229,'2026-10-09 12:34:56',''),
(10,1,9000000009,-550272307655590452.76864522,'2026-10-10 12:34:56','O\'Neil; DROP TABLE fees; --'),
(11,1,9000000010,870566364041579889.04990812,'2026-10-11 12:34:56','line one\nline two\r	tab'),
(12,1,9000000011,393173767087020310.09658466,'2026-10-12 12:34:56','zero\0end\Z'),
(13,1,9000000012,-821607323131137180.66853723,'2026-10-13 12:34:56','back\\slash and \\n literal'),
(14,1,9000000013,806896697667496736.40106453,'2026-10-14 12:34:56','emoji π“π™‚ cafΓ© ζ—¥ζ¬θª'),
(15,1,9000000014,741189470951066333.53042669,'2026-10-15 12:34:56','/* comment */ (one), two; DELIMITER ;;'),
(16,1,9000000015,-238411116083822258.27041380,'2026-10-16 12:34:56','double \"quote\" and `tick`'),
(17,1,9000000016,997834271459819073.08867937,'2026-10-17 12:34:56','100%_done'),
(18,1,9000000017,435445790088807488.86802529,'2026-10-18 12:34:56',''),
(19,1,9000000018,-281968179801745360.23455389,'2026-10-19 12:34:56','O\'Neil; DROP TABLE fees; --'),
(20,1,9000000019,574375302385704523.67319030,'2026-10-20 12:34:56','line one\nline two\r	tab'),
(21,1,9000000020,920737143880694129.93576966,'2026-10-21 12:34:56','zero\0end\Z'),
(22,1,9000000021,-754242378911263057.80409216,'2026-10-22 12:34:56','back\\slash and \\n literal');
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
INSERT INTO `group` VALUES
('book-0','Library 0 O\'Neil; DROP TABLE fees; --0',NULL,'\0\0\0\0\0\0\0\0','zero\0end\Z',0),
('book-1','Library 0 line one\nline two\r	tab1','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿ&','','back\\slash and \\n literal',1),
('book-10','Library 0 line one\nline two\r	tab10','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿ+d–\0Ξ','\n\n\n\n\n\n\n\n','back\\slash and \\n literal',0),
('book-11','Library 0 zero\0end\Z11','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿΉ]7	M~qΚH','','emoji π“π™‚ cafΓ© ζ—¥ζ¬θª',1),
('book-12','Library 0 back\\slash and \\n literal12','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿ‘9.„?Cψ','','/* comment */ (one), two; DELIMITER ;;',0),
('book-13','Library 0 emoji π“π™‚ cafΓ© ζ—¥ζ¬θª13','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿΤ}‡ΧµZΓ{Lÿ¦ς','\r\r\r\r\r\r\r\r','double \"quote\" and `tick`',1),
('book-14','Library 0 /* comment */ (one), two; DELIMITER ;;14',NULL,'','100%_done',0),
('book-15','Library 0 double \"quote\" and `tick`15','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿψ(ΚµΑ†X5@ί6H','','',1),
('book-16','Library 0 100%_done16','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿ»‚£oYέΨ„r-)·g','','O\'Neil; DROP TABLE fees; --',0),
('book-17','Library 0 17','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿ^6K•‹΄ΈΟP.Ρsπιξϋΐ','','line one\nline two\r	tab',1),
('book-18','Library 0 O\'Neil; DROP TABLE fees; --18','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿ$vCRώÒώ9hΚϊ','','zero\0end\Z',0),
('book-19','Library 0 line one\nline two\r	tab19','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿ°Ei(rιΌÒΗuHc±v™\06σ','','back\\slash and \\n literal',1),
('book-2','Library 0 zero\0end\Z2','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿΎν','','emoji π“π™‚ cafΓ© ζ—¥ζ¬θª',0),
('book-20','Library 0 zero\0end\Z20','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿXλσ¬vΔΊ2uUΫuη™»Ο,','','emoji π“π™‚ cafΓ© ζ—¥ζ¬θª',0),
('book-21','Library 0 back\\slash and \\n literal21',NULL,'','/* comment */ (one), two; DELIMITER ;;',1),
('book-3','Library 0 back\\slash and \\n literal3','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿR^','','/* comment */ (one), two; DELIMITER ;;',1),
('book-4','Library 0 emoji π“π™‚ cafΓ© ζ—¥ζ¬θª4','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿηyζ','','double \"quote\" and `tick`',0),
('book-5','Library 0 /* comment */ (one), two; DELIMITER ;;5','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿΚiΦΰ','','100%_done',1),
('book-6','Library 0 double \"quote\" and `tick`6','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿΫH©/ω','','',0),
('book-7','Library 0 100%_done7',NULL,'','O\'Neil; DROP TABLE fees; --',1),
('book-8','Library 0 8','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿJΫKΛ«VΊ”','','line one\nline two\r	tab',0),
('book-9','Library 0 O\'Neil; DROP TABLE fees; --9','\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡‰‹‘’“”•–—™› ΅Ά£¤¥¦§¨©ª«¬­®―°±²³΄µ¶·ΈΉΊ»Ό½ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡÒΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώÿΚ}]Γχ','								','zero\0end\Z',1);
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
INSERT INTO `hostel counts` VALUES
(1,1.25,'duplicate'),
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
