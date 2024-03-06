-- MariaDB dump 10.19-11.2.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: tl_testlink
-- ------------------------------------------------------
-- Server version	11.2.2-MariaDB

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
-- Table structure for table `assignment_status`
--

DROP TABLE IF EXISTS `assignment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignment_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment_status`
--

LOCK TABLES `assignment_status` WRITE;
/*!40000 ALTER TABLE `assignment_status` DISABLE KEYS */;
INSERT INTO `assignment_status` VALUES
(1,'open'),
(2,'closed'),
(3,'completed'),
(4,'todo_urgent'),
(5,'todo');
/*!40000 ALTER TABLE `assignment_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignment_types`
--

DROP TABLE IF EXISTS `assignment_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignment_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_table` varchar(30) DEFAULT '',
  `description` varchar(100) NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment_types`
--

LOCK TABLES `assignment_types` WRITE;
/*!40000 ALTER TABLE `assignment_types` DISABLE KEYS */;
INSERT INTO `assignment_types` VALUES
(1,'testplan_tcversions','testcase_execution'),
(2,'tcversions','testcase_review');
/*!40000 ALTER TABLE `assignment_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_id` int(10) unsigned NOT NULL DEFAULT 0,
  `fk_table` varchar(250) DEFAULT '',
  `title` varchar(250) DEFAULT '',
  `description` varchar(250) DEFAULT '',
  `file_name` varchar(250) NOT NULL DEFAULT '',
  `file_path` varchar(250) DEFAULT '',
  `file_size` int(11) NOT NULL DEFAULT 0,
  `file_type` varchar(250) NOT NULL DEFAULT '',
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `content` longblob DEFAULT NULL,
  `compression_type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `attachments_idx1` (`fk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachments`
--

LOCK TABLES `attachments` WRITE;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `baseline_l1l2_context`
--

DROP TABLE IF EXISTS `baseline_l1l2_context`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `baseline_l1l2_context` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) unsigned NOT NULL DEFAULT 0,
  `platform_id` int(10) unsigned NOT NULL DEFAULT 0,
  `being_exec_ts` timestamp NOT NULL,
  `end_exec_ts` timestamp NOT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx1` (`testplan_id`,`platform_id`,`creation_ts`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `baseline_l1l2_context`
--

LOCK TABLES `baseline_l1l2_context` WRITE;
/*!40000 ALTER TABLE `baseline_l1l2_context` DISABLE KEYS */;
/*!40000 ALTER TABLE `baseline_l1l2_context` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `baseline_l1l2_details`
--

DROP TABLE IF EXISTS `baseline_l1l2_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `baseline_l1l2_details` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `context_id` int(10) unsigned NOT NULL,
  `top_tsuite_id` int(10) unsigned NOT NULL DEFAULT 0,
  `child_tsuite_id` int(10) unsigned NOT NULL DEFAULT 0,
  `status` char(1) DEFAULT NULL,
  `qty` int(10) unsigned NOT NULL DEFAULT 0,
  `total_tc` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx1` (`context_id`,`top_tsuite_id`,`child_tsuite_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `baseline_l1l2_details`
--

LOCK TABLES `baseline_l1l2_details` WRITE;
/*!40000 ALTER TABLE `baseline_l1l2_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `baseline_l1l2_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `builds`
--

DROP TABLE IF EXISTS `builds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `builds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT 'undefined',
  `notes` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `release_date` date DEFAULT NULL,
  `closed_on_date` date DEFAULT NULL,
  `commit_id` varchar(64) DEFAULT NULL,
  `tag` varchar(64) DEFAULT NULL,
  `branch` varchar(64) DEFAULT NULL,
  `release_candidate` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`testplan_id`,`name`),
  KEY `testplan_id` (`testplan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Available builds';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `builds`
--

LOCK TABLES `builds` WRITE;
/*!40000 ALTER TABLE `builds` DISABLE KEYS */;
INSERT INTO `builds` VALUES
(2,137,'Spigen and Chinense GaN Fast Charger Testing','<p>Spigen Charger -60Watts</p>\r\n\r\n<p>Chinense GaN Fast Charger- 65Watts</p>\r\n\r\n<p>&nbsp;</p>\r\n',1,1,NULL,'2024-01-04 04:44:29','2024-01-26',NULL,'','','','');
/*!40000 ALTER TABLE `builds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cfield_build_design_values`
--

DROP TABLE IF EXISTS `cfield_build_design_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfield_build_design_values` (
  `field_id` int(10) NOT NULL DEFAULT 0,
  `node_id` int(10) NOT NULL DEFAULT 0,
  `value` varchar(4000) NOT NULL DEFAULT '',
  PRIMARY KEY (`field_id`,`node_id`),
  KEY `idx_cfield_build_design_values` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cfield_build_design_values`
--

LOCK TABLES `cfield_build_design_values` WRITE;
/*!40000 ALTER TABLE `cfield_build_design_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `cfield_build_design_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cfield_design_values`
--

DROP TABLE IF EXISTS `cfield_design_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfield_design_values` (
  `field_id` int(10) NOT NULL DEFAULT 0,
  `node_id` int(10) NOT NULL DEFAULT 0,
  `value` varchar(4000) NOT NULL DEFAULT '',
  PRIMARY KEY (`field_id`,`node_id`),
  KEY `idx_cfield_design_values` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cfield_design_values`
--

LOCK TABLES `cfield_design_values` WRITE;
/*!40000 ALTER TABLE `cfield_design_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `cfield_design_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cfield_execution_values`
--

DROP TABLE IF EXISTS `cfield_execution_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfield_execution_values` (
  `field_id` int(10) NOT NULL DEFAULT 0,
  `execution_id` int(10) NOT NULL DEFAULT 0,
  `testplan_id` int(10) NOT NULL DEFAULT 0,
  `tcversion_id` int(10) NOT NULL DEFAULT 0,
  `value` varchar(4000) NOT NULL DEFAULT '',
  PRIMARY KEY (`field_id`,`execution_id`,`testplan_id`,`tcversion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cfield_execution_values`
--

LOCK TABLES `cfield_execution_values` WRITE;
/*!40000 ALTER TABLE `cfield_execution_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `cfield_execution_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cfield_node_types`
--

DROP TABLE IF EXISTS `cfield_node_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfield_node_types` (
  `field_id` int(10) NOT NULL DEFAULT 0,
  `node_type_id` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`field_id`,`node_type_id`),
  KEY `idx_custom_fields_assign` (`node_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cfield_node_types`
--

LOCK TABLES `cfield_node_types` WRITE;
/*!40000 ALTER TABLE `cfield_node_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `cfield_node_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cfield_testplan_design_values`
--

DROP TABLE IF EXISTS `cfield_testplan_design_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfield_testplan_design_values` (
  `field_id` int(10) NOT NULL DEFAULT 0,
  `link_id` int(10) NOT NULL DEFAULT 0 COMMENT 'point to testplan_tcversion id',
  `value` varchar(4000) NOT NULL DEFAULT '',
  PRIMARY KEY (`field_id`,`link_id`),
  KEY `idx_cfield_tplan_design_val` (`link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cfield_testplan_design_values`
--

LOCK TABLES `cfield_testplan_design_values` WRITE;
/*!40000 ALTER TABLE `cfield_testplan_design_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `cfield_testplan_design_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cfield_testprojects`
--

DROP TABLE IF EXISTS `cfield_testprojects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfield_testprojects` (
  `field_id` int(10) unsigned NOT NULL DEFAULT 0,
  `testproject_id` int(10) unsigned NOT NULL DEFAULT 0,
  `display_order` smallint(5) unsigned NOT NULL DEFAULT 1,
  `location` smallint(5) unsigned NOT NULL DEFAULT 1,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `required_on_design` tinyint(1) NOT NULL DEFAULT 0,
  `required_on_execution` tinyint(1) NOT NULL DEFAULT 0,
  `monitorable` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`field_id`,`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cfield_testprojects`
--

LOCK TABLES `cfield_testprojects` WRITE;
/*!40000 ALTER TABLE `cfield_testprojects` DISABLE KEYS */;
/*!40000 ALTER TABLE `cfield_testprojects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `codetrackers`
--

DROP TABLE IF EXISTS `codetrackers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `codetrackers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` int(10) DEFAULT 0,
  `cfg` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codetrackers_uidx1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `codetrackers`
--

LOCK TABLES `codetrackers` WRITE;
/*!40000 ALTER TABLE `codetrackers` DISABLE KEYS */;
/*!40000 ALTER TABLE `codetrackers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_fields`
--

DROP TABLE IF EXISTS `custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_fields` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `label` varchar(64) NOT NULL DEFAULT '' COMMENT 'label to display on user interface',
  `type` smallint(6) NOT NULL DEFAULT 0,
  `possible_values` varchar(4000) NOT NULL DEFAULT '',
  `default_value` varchar(4000) NOT NULL DEFAULT '',
  `valid_regexp` varchar(255) NOT NULL DEFAULT '',
  `length_min` int(10) NOT NULL DEFAULT 0,
  `length_max` int(10) NOT NULL DEFAULT 0,
  `show_on_design` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '1=> show it during specification design',
  `enable_on_design` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '1=> user can write/manage it during specification design',
  `show_on_execution` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '1=> show it during test case execution',
  `enable_on_execution` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '1=> user can write/manage it during test case execution',
  `show_on_testplan_design` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `enable_on_testplan_design` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_custom_fields_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_fields`
--

LOCK TABLES `custom_fields` WRITE;
/*!40000 ALTER TABLE `custom_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `db_version`
--

DROP TABLE IF EXISTS `db_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_version` (
  `version` varchar(50) NOT NULL DEFAULT 'unknown',
  `upgrade_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db_version`
--

LOCK TABLES `db_version` WRITE;
/*!40000 ALTER TABLE `db_version` DISABLE KEYS */;
INSERT INTO `db_version` VALUES
('DB 1.9.20','2023-12-20 10:54:37','TestLink 1.9.20 Raijin');
/*!40000 ALTER TABLE `db_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int(10) unsigned NOT NULL DEFAULT 0,
  `log_level` smallint(5) unsigned NOT NULL DEFAULT 0,
  `source` varchar(45) DEFAULT NULL,
  `description` text NOT NULL,
  `fired_at` int(10) unsigned NOT NULL DEFAULT 0,
  `activity` varchar(45) DEFAULT NULL,
  `object_id` int(10) unsigned DEFAULT NULL,
  `object_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `fired_at` (`fired_at`)
) ENGINE=InnoDB AUTO_INCREMENT=3345 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES
(2193,380,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_login_failed\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:10:\"172.27.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703842615,'LOGIN_FAILED',1,'users'),
(2194,381,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_login_failed\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:10:\"172.27.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703842634,'LOGIN_FAILED',1,'users'),
(2195,382,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:10:\"172.27.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703842711,'LOGIN',1,'users'),
(2196,383,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_config\' is not localized for locale \'en_US\' ',1703842711,'LOCALIZATION',0,NULL),
(2197,383,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_left_bottom_link\' is not localized for locale \'en_US\' ',1703842711,'LOCALIZATION',0,NULL),
(2198,383,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_right_top_link\' is not localized for locale \'en_US\' ',1703842711,'LOCALIZATION',0,NULL),
(2199,383,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_right_bottom_link\' is not localized for locale \'en_US\' ',1703842711,'LOCALIZATION',0,NULL),
(2200,383,32,'GUI - Test Project ID : 1','string \'poweredBy\' is not localized for locale \'en_US\'  - using en_GB',1703842711,'LOCALIZATION',0,NULL),
(2201,383,32,'GUI - Test Project ID : 1','string \'system_descr\' is not localized for locale \'en_US\'  - using en_GB',1703842711,'LOCALIZATION',0,NULL),
(2202,383,32,'GUI - Test Project ID : 1','string \'href_codetracker_management\' is not localized for locale \'en_US\'  - using en_GB',1703842711,'LOCALIZATION',0,NULL),
(2203,384,32,'GUI - Test Project ID : 1','string \'expiration\' is not localized for locale \'en_US\'  - using en_GB',1703842718,'LOCALIZATION',0,NULL),
(2204,384,32,'GUI - Test Project ID : 1','string \'expiration_date\' is not localized for locale \'en_US\'  - using en_GB',1703842718,'LOCALIZATION',0,NULL),
(2205,385,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_user_created\";s:6:\"params\";a:1:{i:0;s:30:\"v.bhavana@Kaynestechnology.net\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703842822,'CREATE',3,'users'),
(2206,386,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_user_created\";s:6:\"params\";a:1:{i:0;s:32:\"suneel.duth@kaynestechnology.net\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703842891,'CREATE',4,'users'),
(2207,387,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_user_saved\";s:6:\"params\";a:1:{i:0;s:30:\"v.bhavana@Kaynestechnology.net\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703842934,'SAVE',3,'users'),
(2208,388,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_user_saved\";s:6:\"params\";a:1:{i:0;s:31:\"rj.ravindra@kenestechnology.net\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703842947,'SAVE',2,'users'),
(2209,389,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_user_apikey_set\";s:6:\"params\";a:1:{i:0;s:31:\"rj.ravindra@kenestechnology.net\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703842977,'CREATE',0,'users'),
(2210,390,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_user_disabled\";s:6:\"params\";a:1:{i:0;s:31:\"rj.ravindra@kenestechnology.net\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703843013,'DISABLE',2,'users'),
(2211,391,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_user_disabled\";s:6:\"params\";a:1:{i:0;s:31:\"rj.ravindra@kenestechnology.net\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703843021,'DISABLE',2,'users'),
(2212,392,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_user_saved\";s:6:\"params\";a:1:{i:0;s:31:\"rj.ravindra@kenestechnology.net\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703843032,'SAVE',2,'users'),
(2213,393,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined variable: user - in /opt/bitnami/testlink/lib/functions/common.php - Line 1925',1703843694,'PHP',0,NULL),
(2214,394,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:17:\"audit_user_logout\";s:6:\"params\";a:1:{i:0;s:5:\"admin\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703843696,'LOGOUT',1,'users'),
(2215,395,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:30:\"v.bhavana@Kaynestechnology.net\";i:1;s:10:\"172.27.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703846902,'LOGIN',3,'users'),
(2216,396,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_config\' is not localized for locale \'en_US\' ',1703846902,'LOCALIZATION',0,NULL),
(2217,396,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_left_bottom_link\' is not localized for locale \'en_US\' ',1703846902,'LOCALIZATION',0,NULL),
(2218,396,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_right_top_link\' is not localized for locale \'en_US\' ',1703846902,'LOCALIZATION',0,NULL),
(2219,396,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_right_bottom_link\' is not localized for locale \'en_US\' ',1703846903,'LOCALIZATION',0,NULL),
(2220,396,32,'GUI - Test Project ID : 1','string \'poweredBy\' is not localized for locale \'en_US\'  - using en_GB',1703846903,'LOCALIZATION',0,NULL),
(2221,396,32,'GUI - Test Project ID : 1','string \'system_descr\' is not localized for locale \'en_US\'  - using en_GB',1703846903,'LOCALIZATION',0,NULL),
(2222,396,32,'GUI - Test Project ID : 1','string \'href_codetracker_management\' is not localized for locale \'en_US\'  - using en_GB',1703846903,'LOCALIZATION',0,NULL),
(2223,396,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: platform_view - in /opt/bitnami/testlink/gui/templates_c/1a970f0fd23865718fe165dfcf14693f3e80cffc_0.file.mainPageLeft.tpl.php - Line 181',1703846903,'PHP',0,NULL),
(2224,397,32,'GUI - Test Project ID : 1','string \'without_platforms\' is not localized for locale \'en_US\'  - using en_GB',1703848684,'LOCALIZATION',0,NULL),
(2225,397,32,'GUI - Test Project ID : 1','string \'exec_tree_counters_logic\' is not localized for locale \'en_US\'  - using en_GB',1703848684,'LOCALIZATION',0,NULL),
(2226,397,32,'GUI - Test Project ID : 1','string \'platforms\' is not localized for locale \'en_US\'  - using en_GB',1703848684,'LOCALIZATION',0,NULL),
(2227,397,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1703848684,'PHP',0,NULL),
(2228,398,32,'GUI - Test Project ID : 1','string \'file_upload_ko\' is not localized for locale \'en_US\'  - using en_GB',1703848684,'LOCALIZATION',0,NULL),
(2229,398,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1703848684,'PHP',0,NULL),
(2230,398,32,'GUI - Test Project ID : 1','string \'allowed_files\' is not localized for locale \'en_US\'  - using en_GB',1703848684,'LOCALIZATION',0,NULL),
(2231,398,32,'GUI - Test Project ID : 1','string \'allowed_filenames_regexp\' is not localized for locale \'en_US\'  - using en_GB',1703848684,'LOCALIZATION',0,NULL),
(2232,399,32,'GUI - Test Project ID : 1','string \'updateLinkToThisTCVersion\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2233,399,32,'GUI - Test Project ID : 1','string \'btn_new_version_from_latest\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2234,399,32,'GUI - Test Project ID : 1','string \'code_mgmt\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2235,399,32,'GUI - Test Project ID : 1','string \'code_link_tl_to_cts\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2236,399,32,'GUI - Test Project ID : 1','string \'can_not_edit_frozen_tc\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2237,399,32,'GUI - Test Project ID : 1','string \'testcase_version_operations\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2238,399,32,'GUI - Test Project ID : 1','string \'select_keywords\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2239,399,32,'GUI - Test Project ID : 1','string \'createKW\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2240,399,32,'GUI - Test Project ID : 1','string \'btn_create_and_link\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2241,399,32,'GUI - Test Project ID : 1','string \'img_title_remove_platform\' is not localized for locale \'en_US\' ',1703848783,'LOCALIZATION',0,NULL),
(2242,399,32,'GUI - Test Project ID : 1','string \'select_platforms\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2243,399,32,'GUI - Test Project ID : 1','string \'remove_plat_msgbox_msg\' is not localized for locale \'en_US\' ',1703848783,'LOCALIZATION',0,NULL),
(2244,399,32,'GUI - Test Project ID : 1','string \'remove_plat_msgbox_title\' is not localized for locale \'en_US\' ',1703848783,'LOCALIZATION',0,NULL),
(2245,399,32,'GUI - Test Project ID : 1','string \'can_not_delete_a_frozen_relation\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2246,399,32,'GUI - Test Project ID : 1','string \'can_not_delete_relation_frozen_tc\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2247,399,32,'GUI - Test Project ID : 1','string \'can_not_delete_relation_because_this_is_not_the_latest\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2248,399,32,'GUI - Test Project ID : 1','string \'this_tcversion\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2249,399,32,'GUI - Test Project ID : 1','string \'can_not_delete_relation_tcversion_frozen\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2250,399,32,'GUI - Test Project ID : 1','string \'can_not_delete_relation_related_tcversion_frozen\' is not localized for locale \'en_US\'  - using en_GB',1703848783,'LOCALIZATION',0,NULL),
(2251,400,32,'GUI - Test Project ID : 1','string \'btn_add_to_testsuites_deep\' is not localized for locale \'en_US\'  - using en_GB',1703848801,'LOCALIZATION',0,NULL),
(2252,401,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: platform_view - in /opt/bitnami/testlink/gui/templates_c/1a970f0fd23865718fe165dfcf14693f3e80cffc_0.file.mainPageLeft.tpl.php - Line 181',1703848819,'PHP',0,NULL),
(2253,402,32,'GUI - Test Project ID : 1','string \'use_latest_exec_on_contex_for_counters\' is not localized for locale \'en_US\'  - using en_GB',1703848829,'LOCALIZATION',0,NULL),
(2254,402,32,'GUI - Test Project ID : 1','string \'use_latest_exec_on_testplan_for_counters\' is not localized for locale \'en_US\'  - using en_GB',1703848829,'LOCALIZATION',0,NULL),
(2255,402,32,'GUI - Test Project ID : 1','string \'use_latest_exec_on_testplan_plat_for_counters\' is not localized for locale \'en_US\'  - using en_GB',1703848829,'LOCALIZATION',0,NULL),
(2256,403,2,'GUI - Test Project ID : 1','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /opt/bitnami/testlink/lib/functions/tlPlatform.class.php - Line 107',1703848829,'PHP',0,NULL),
(2257,403,32,'GUI - Test Project ID : 1','string \'restAPIExecParameters\' is not localized for locale \'en_US\'  - using en_GB',1703848829,'LOCALIZATION',0,NULL),
(2258,404,2,'GUI - Test Project ID : 1','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /opt/bitnami/testlink/lib/functions/tlPlatform.class.php - Line 107',1703848830,'PHP',0,NULL),
(2259,405,2,'GUI - Test Project ID : 1','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /opt/bitnami/testlink/lib/functions/tlPlatform.class.php - Line 107',1703848849,'PHP',0,NULL),
(2260,406,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: platform_view - in /opt/bitnami/testlink/gui/templates_c/1a970f0fd23865718fe165dfcf14693f3e80cffc_0.file.mainPageLeft.tpl.php - Line 181',1703848850,'PHP',0,NULL),
(2261,407,32,'GUI - Test Project ID : 1','string \'tcvqty_with_kw\' is not localized for locale \'en_US\'  - using en_GB',1703848862,'LOCALIZATION',0,NULL),
(2262,408,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: platform_view - in /opt/bitnami/testlink/gui/templates_c/1a970f0fd23865718fe165dfcf14693f3e80cffc_0.file.mainPageLeft.tpl.php - Line 181',1703848865,'PHP',0,NULL),
(2263,409,2,'GUI - Test Project ID : 1','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /opt/bitnami/testlink/lib/functions/tlPlatform.class.php - Line 107',1703848874,'PHP',0,NULL),
(2264,410,2,'GUI - Test Project ID : 1','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /opt/bitnami/testlink/lib/functions/tlPlatform.class.php - Line 107',1703848874,'PHP',0,NULL),
(2265,411,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: platform_view - in /opt/bitnami/testlink/gui/templates_c/1a970f0fd23865718fe165dfcf14693f3e80cffc_0.file.mainPageLeft.tpl.php - Line 181',1703848884,'PHP',0,NULL),
(2266,412,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1703848931,'PHP',0,NULL),
(2267,413,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1703848931,'PHP',0,NULL),
(2268,414,32,'GUI - Test Project ID : 1','string \'link_report_by_tsuite\' is not localized for locale \'en_US\'  - using en_GB',1703848944,'LOCALIZATION',0,NULL),
(2269,414,32,'GUI - Test Project ID : 1','string \'baseline_l1l2\' is not localized for locale \'en_US\'  - using en_GB',1703848944,'LOCALIZATION',0,NULL),
(2270,414,32,'GUI - Test Project ID : 1','string \'link_report_test_absolute_latest_exec\' is not localized for locale \'en_US\'  - using en_GB',1703848944,'LOCALIZATION',0,NULL),
(2271,414,32,'GUI - Test Project ID : 1','string \'link_report_never_run\' is not localized for locale \'en_US\'  - using en_GB',1703848944,'LOCALIZATION',0,NULL),
(2272,414,32,'GUI - Test Project ID : 1','string \'link_report_exec_timeline\' is not localized for locale \'en_US\'  - using en_GB',1703848944,'LOCALIZATION',0,NULL),
(2273,415,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: platform_view - in /opt/bitnami/testlink/gui/templates_c/1a970f0fd23865718fe165dfcf14693f3e80cffc_0.file.mainPageLeft.tpl.php - Line 181',1703849000,'PHP',0,NULL),
(2274,416,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:10:\"172.27.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703849036,'LOGIN',1,'users'),
(2275,417,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_config\' is not localized for locale \'en_US\' ',1703849036,'LOCALIZATION',0,NULL),
(2276,417,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_left_bottom_link\' is not localized for locale \'en_US\' ',1703849036,'LOCALIZATION',0,NULL),
(2277,417,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_right_top_link\' is not localized for locale \'en_US\' ',1703849036,'LOCALIZATION',0,NULL),
(2278,417,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_right_bottom_link\' is not localized for locale \'en_US\' ',1703849036,'LOCALIZATION',0,NULL),
(2279,417,32,'GUI - Test Project ID : 1','string \'poweredBy\' is not localized for locale \'en_US\'  - using en_GB',1703849036,'LOCALIZATION',0,NULL),
(2280,417,32,'GUI - Test Project ID : 1','string \'system_descr\' is not localized for locale \'en_US\'  - using en_GB',1703849036,'LOCALIZATION',0,NULL),
(2281,417,32,'GUI - Test Project ID : 1','string \'href_codetracker_management\' is not localized for locale \'en_US\'  - using en_GB',1703849036,'LOCALIZATION',0,NULL),
(2282,418,32,'GUI - Test Project ID : 1','string \'expiration\' is not localized for locale \'en_US\'  - using en_GB',1703849040,'LOCALIZATION',0,NULL),
(2283,418,32,'GUI - Test Project ID : 1','string \'expiration_date\' is not localized for locale \'en_US\'  - using en_GB',1703849040,'LOCALIZATION',0,NULL),
(2284,419,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_user_saved\";s:6:\"params\";a:1:{i:0;s:30:\"v.bhavana@Kaynestechnology.net\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703849049,'SAVE',3,'users'),
(2285,420,32,'GUI - Test Project ID : 1','string \'desc_cfield_assignment\' is not localized for locale \'en_US\'  - using en_GB',1703849062,'LOCALIZATION',0,NULL),
(2286,420,32,'GUI - Test Project ID : 1','string \'desc_exec_assign_testcases\' is not localized for locale \'en_US\'  - using en_GB',1703849062,'LOCALIZATION',0,NULL),
(2287,420,32,'GUI - Test Project ID : 1','string \'desc_codetrackers_view\' is not localized for locale \'en_US\'  - using en_GB',1703849062,'LOCALIZATION',0,NULL),
(2288,420,32,'GUI - Test Project ID : 1','string \'desc_codetrackers_management\' is not localized for locale \'en_US\'  - using en_GB',1703849062,'LOCALIZATION',0,NULL),
(2289,420,32,'GUI - Test Project ID : 1','string \'right_testproject_add_remove_keywords_executed_tcversions\' is not localized for locale \'en_US\'  - using en_GB',1703849062,'LOCALIZATION',0,NULL),
(2290,420,32,'GUI - Test Project ID : 1','string \'right_delete_frozen_tcversion\' is not localized for locale \'en_US\'  - using en_GB',1703849062,'LOCALIZATION',0,NULL),
(2291,421,32,'GUI - Test Project ID : 1','string \'th_codetracker_rights\' is not localized for locale \'en_US\'  - using en_GB',1703849088,'LOCALIZATION',0,NULL),
(2292,422,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_role_saved\";s:6:\"params\";a:1:{i:0;s:10:\"Team admin\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703849174,'SAVE',1,'roles'),
(2293,423,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_user_saved\";s:6:\"params\";a:1:{i:0;s:30:\"v.bhavana@Kaynestechnology.net\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703849183,'SAVE',3,'users'),
(2294,424,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1703849229,'PHP',0,NULL),
(2295,425,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1703849229,'PHP',0,NULL),
(2296,426,32,'GUI - Test Project ID : 1','string \'th_codetracker\' is not localized for locale \'en_US\'  - using en_GB',1703849262,'LOCALIZATION',0,NULL),
(2297,427,32,'GUI - Test Project ID : 1','string \'testproject_code_tracker_integration\' is not localized for locale \'en_US\'  - using en_GB',1703849298,'LOCALIZATION',0,NULL),
(2298,427,32,'GUI - Test Project ID : 1','string \'code_tracker\' is not localized for locale \'en_US\'  - using en_GB',1703849298,'LOCALIZATION',0,NULL),
(2299,427,32,'GUI - Test Project ID : 1','string \'no_codetracker_defined\' is not localized for locale \'en_US\'  - using en_GB',1703849298,'LOCALIZATION',0,NULL),
(2300,428,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1703849336,'PHP',0,NULL),
(2301,429,32,'GUI - Test Project ID : 1','string \'without_platforms\' is not localized for locale \'en_US\'  - using en_GB',1703849401,'LOCALIZATION',0,NULL),
(2302,429,32,'GUI - Test Project ID : 1','string \'exec_tree_counters_logic\' is not localized for locale \'en_US\'  - using en_GB',1703849401,'LOCALIZATION',0,NULL),
(2303,429,32,'GUI - Test Project ID : 1','string \'platforms\' is not localized for locale \'en_US\'  - using en_GB',1703849401,'LOCALIZATION',0,NULL),
(2304,430,32,'GUI - Test Project ID : 1','string \'file_upload_ko\' is not localized for locale \'en_US\'  - using en_GB',1703849411,'LOCALIZATION',0,NULL),
(2305,430,32,'GUI - Test Project ID : 1','string \'allowed_files\' is not localized for locale \'en_US\'  - using en_GB',1703849411,'LOCALIZATION',0,NULL),
(2306,430,32,'GUI - Test Project ID : 1','string \'allowed_filenames_regexp\' is not localized for locale \'en_US\'  - using en_GB',1703849411,'LOCALIZATION',0,NULL),
(2307,431,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 130',1703850135,'PHP',0,NULL),
(2308,431,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined property: stdClass::$itemID - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 152',1703850135,'PHP',0,NULL),
(2309,432,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:22:\"audit_testplan_created\";s:6:\"params\";a:2:{i:0;s:11:\"GaN Chagers\";i:1;s:18:\"Test at Mysore Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1703850234,'CREATED',133,'testplans'),
(2310,433,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:30:\"v.bhavana@Kaynestechnology.net\";i:1;s:10:\"172.27.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704083366,'LOGIN',3,'users'),
(2311,434,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_config\' is not localized for locale \'en_US\' ',1704083367,'LOCALIZATION',0,NULL),
(2312,434,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_left_bottom_link\' is not localized for locale \'en_US\' ',1704083367,'LOCALIZATION',0,NULL),
(2313,434,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_right_top_link\' is not localized for locale \'en_US\' ',1704083367,'LOCALIZATION',0,NULL),
(2314,434,32,'GUI - Test Project ID : 1','string \'plugin_TLTest_right_bottom_link\' is not localized for locale \'en_US\' ',1704083367,'LOCALIZATION',0,NULL),
(2315,434,32,'GUI - Test Project ID : 1','string \'poweredBy\' is not localized for locale \'en_US\'  - using en_GB',1704083367,'LOCALIZATION',0,NULL),
(2316,434,32,'GUI - Test Project ID : 1','string \'system_descr\' is not localized for locale \'en_US\'  - using en_GB',1704083367,'LOCALIZATION',0,NULL),
(2317,434,32,'GUI - Test Project ID : 1','string \'href_codetracker_management\' is not localized for locale \'en_US\'  - using en_GB',1704083367,'LOCALIZATION',0,NULL),
(2318,435,32,'GUI - Test Project ID : 1','string \'file_upload_ko\' is not localized for locale \'en_US\'  - using en_GB',1704088119,'LOCALIZATION',0,NULL),
(2319,435,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 130',1704088119,'PHP',0,NULL),
(2320,435,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined property: stdClass::$itemID - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 152',1704088119,'PHP',0,NULL),
(2321,435,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index:  - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 302',1704088119,'PHP',0,NULL),
(2322,435,32,'GUI - Test Project ID : 1','string \'allowed_files\' is not localized for locale \'en_US\'  - using en_GB',1704088119,'LOCALIZATION',0,NULL),
(2323,435,32,'GUI - Test Project ID : 1','string \'allowed_filenames_regexp\' is not localized for locale \'en_US\'  - using en_GB',1704088119,'LOCALIZATION',0,NULL),
(2324,436,32,'GUI - Test Project ID : 1','string \'link_report_by_tsuite\' is not localized for locale \'en_US\'  - using en_GB',1704088137,'LOCALIZATION',0,NULL),
(2325,436,32,'GUI - Test Project ID : 1','string \'baseline_l1l2\' is not localized for locale \'en_US\'  - using en_GB',1704088137,'LOCALIZATION',0,NULL),
(2326,436,32,'GUI - Test Project ID : 1','string \'link_report_test_absolute_latest_exec\' is not localized for locale \'en_US\'  - using en_GB',1704088137,'LOCALIZATION',0,NULL),
(2327,436,32,'GUI - Test Project ID : 1','string \'link_report_never_run\' is not localized for locale \'en_US\'  - using en_GB',1704088137,'LOCALIZATION',0,NULL),
(2328,436,32,'GUI - Test Project ID : 1','string \'link_report_exec_timeline\' is not localized for locale \'en_US\'  - using en_GB',1704088137,'LOCALIZATION',0,NULL),
(2329,437,32,'GUI - Test Project ID : 1','string \'without_platforms\' is not localized for locale \'en_US\'  - using en_GB',1704088180,'LOCALIZATION',0,NULL),
(2330,437,32,'GUI - Test Project ID : 1','string \'exec_tree_counters_logic\' is not localized for locale \'en_US\'  - using en_GB',1704088180,'LOCALIZATION',0,NULL),
(2331,437,32,'GUI - Test Project ID : 1','string \'platforms\' is not localized for locale \'en_US\'  - using en_GB',1704088180,'LOCALIZATION',0,NULL),
(2332,437,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704088180,'PHP',0,NULL),
(2333,438,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704088221,'PHP',0,NULL),
(2334,439,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704088228,'PHP',0,NULL),
(2335,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined property: stdClass::$filter_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 420',1704088232,'PHP',0,NULL),
(2336,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704088232,'PHP',0,NULL),
(2337,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704088232,'PHP',0,NULL),
(2338,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: filter_priority - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 605',1704088232,'PHP',0,NULL),
(2339,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 612',1704088232,'PHP',0,NULL),
(2340,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 616',1704088232,'PHP',0,NULL),
(2341,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 633',1704088232,'PHP',0,NULL),
(2342,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: filter_result_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 640',1704088232,'PHP',0,NULL),
(2343,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: filter_bugs - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 647',1704088232,'PHP',0,NULL),
(2344,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: setting_testplan - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 698',1704088232,'PHP',0,NULL),
(2345,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined property: stdClass::$basehref - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 736',1704088232,'PHP',0,NULL),
(2346,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined property: stdClass::$wrapOpen - in /opt/bitnami/testlink/gui/templates_c/1b04e701ff66471e26588a9fe0ec47707efb608d_0.file.planAddTCNavigator.tpl.php - Line 102',1704088232,'PHP',0,NULL),
(2347,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined property: stdClass::$wrapClose - in /opt/bitnami/testlink/gui/templates_c/1b04e701ff66471e26588a9fe0ec47707efb608d_0.file.planAddTCNavigator.tpl.php - Line 106',1704088232,'PHP',0,NULL),
(2348,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 27',1704088232,'PHP',0,NULL),
(2349,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 142',1704088232,'PHP',0,NULL),
(2350,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 113',1704088232,'PHP',0,NULL),
(2351,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 127',1704088232,'PHP',0,NULL),
(2352,440,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: setting_exec_tree_counters_logic - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 197',1704088232,'PHP',0,NULL),
(2353,441,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704088399,'PHP',0,NULL),
(2354,442,32,'GUI - Test Project ID : 1','string \'show_calendar\' is not localized for locale \'en_US\' ',1704088608,'LOCALIZATION',0,NULL),
(2355,443,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/search/searchCommands.class.php - Line 998',1704088608,'PHP',0,NULL),
(2356,444,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 221',1704088650,'PHP',0,NULL),
(2357,444,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 245',1704088650,'PHP',0,NULL),
(2358,444,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 277',1704088650,'PHP',0,NULL),
(2359,445,32,'GUI - Test Project ID : 1','string \'th_codetracker\' is not localized for locale \'en_US\'  - using en_GB',1704088676,'LOCALIZATION',0,NULL),
(2360,446,32,'GUI - Test Project ID : 1','string \'testproject_code_tracker_integration\' is not localized for locale \'en_US\'  - using en_GB',1704088704,'LOCALIZATION',0,NULL),
(2361,446,32,'GUI - Test Project ID : 1','string \'code_tracker\' is not localized for locale \'en_US\'  - using en_GB',1704088704,'LOCALIZATION',0,NULL),
(2362,446,32,'GUI - Test Project ID : 1','string \'no_codetracker_defined\' is not localized for locale \'en_US\'  - using en_GB',1704088704,'LOCALIZATION',0,NULL),
(2363,447,2,'GUI - Test Project ID : 1','In TestProject Create with id: 134, name: GaN Charger, prefix: TCGaN',1704088903,NULL,0,NULL),
(2364,447,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_testproject_created\";s:6:\"params\";a:1:{i:0;s:11:\"GaN Charger\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704088903,'CREATE',134,'testprojects'),
(2365,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089211,'PHP',0,NULL),
(2366,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 4',1704089211,NULL,0,NULL),
(2367,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089211,'PHP',0,NULL),
(2368,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 8',1704089211,NULL,0,NULL),
(2369,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089211,'PHP',0,NULL),
(2370,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 10',1704089211,NULL,0,NULL),
(2371,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089211,'PHP',0,NULL),
(2372,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 12',1704089211,NULL,0,NULL),
(2373,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089211,'PHP',0,NULL),
(2374,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 14',1704089211,NULL,0,NULL),
(2375,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089211,'PHP',0,NULL),
(2376,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 16',1704089211,NULL,0,NULL),
(2377,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089211,'PHP',0,NULL),
(2378,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 18',1704089211,NULL,0,NULL),
(2379,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089211,'PHP',0,NULL),
(2380,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 20',1704089211,NULL,0,NULL),
(2381,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089211,'PHP',0,NULL),
(2382,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 22',1704089211,NULL,0,NULL),
(2383,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089211,'PHP',0,NULL),
(2384,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 24',1704089211,NULL,0,NULL),
(2385,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089211,'PHP',0,NULL),
(2386,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 26',1704089211,NULL,0,NULL),
(2387,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089211,'PHP',0,NULL),
(2388,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 28',1704089211,NULL,0,NULL),
(2389,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089211,'PHP',0,NULL),
(2390,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 30',1704089211,NULL,0,NULL),
(2391,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089211,'PHP',0,NULL),
(2392,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 32',1704089211,NULL,0,NULL),
(2393,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089211,'PHP',0,NULL),
(2394,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 34',1704089212,NULL,0,NULL),
(2395,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089212,'PHP',0,NULL),
(2396,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 36',1704089212,NULL,0,NULL),
(2397,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089212,'PHP',0,NULL),
(2398,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 38',1704089212,NULL,0,NULL),
(2399,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089212,'PHP',0,NULL),
(2400,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 40',1704089212,NULL,0,NULL),
(2401,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089212,'PHP',0,NULL),
(2402,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 42',1704089212,NULL,0,NULL),
(2403,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089212,'PHP',0,NULL),
(2404,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 44',1704089212,NULL,0,NULL),
(2405,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089212,'PHP',0,NULL),
(2406,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 46',1704089212,NULL,0,NULL),
(2407,448,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/requirement_mgr.class.php - Line 585',1704089212,'PHP',0,NULL),
(2408,448,2,'GUI - Test Project ID : 1','In TestRequirement Delete with id: 48',1704089212,NULL,0,NULL),
(2409,448,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:37:\"audit_all_user_roles_removed_testplan\";s:6:\"params\";a:1:{i:0;s:18:\"Sample Test Plan 1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704089212,'ASSIGN',132,'testplans'),
(2410,448,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:37:\"audit_all_user_roles_removed_testplan\";s:6:\"params\";a:1:{i:0;s:18:\"Test at Mysore Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704089212,'ASSIGN',133,'testplans'),
(2411,448,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:40:\"audit_all_user_roles_removed_testproject\";s:6:\"params\";a:1:{i:0;s:11:\"GaN Chagers\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704089212,'ASSIGN',1,'testprojects'),
(2412,448,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_testproject_deleted\";s:6:\"params\";a:1:{i:0;s:11:\"GaN Chagers\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704089212,'DELETE',1,'testprojects'),
(2413,449,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 0 - in /opt/bitnami/testlink/lib/general/navBar.php - Line 160',1704089212,'PHP',0,NULL),
(2414,449,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/general/navBar.php - Line 160',1704089212,'PHP',0,NULL),
(2415,449,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 0 - in /opt/bitnami/testlink/lib/general/navBar.php - Line 161',1704089212,'PHP',0,NULL),
(2416,450,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 221',1704089309,'PHP',0,NULL),
(2417,450,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 245',1704089309,'PHP',0,NULL),
(2418,450,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 277',1704089309,'PHP',0,NULL),
(2419,451,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:22:\"audit_req_spec_created\";s:6:\"params\";a:2:{i:0;s:11:\"GaN Charger\";i:1;s:22:\"Sample Charges Details\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704089696,'CREATE',135,'req_specs'),
(2420,451,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 221',1704089696,'PHP',0,NULL),
(2421,451,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 245',1704089696,'PHP',0,NULL),
(2422,451,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 277',1704089696,'PHP',0,NULL),
(2423,452,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 130',1704174149,'PHP',0,NULL),
(2424,452,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$itemID - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 152',1704174149,'PHP',0,NULL),
(2425,453,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:22:\"audit_testplan_created\";s:6:\"params\";a:2:{i:0;s:11:\"GaN Charger\";i:1;s:40:\"Sample Charger Testing @Mysore Shyam Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704174325,'CREATED',137,'testplans'),
(2426,454,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 130',1704174331,'PHP',0,NULL),
(2427,454,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$itemID - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 152',1704174331,'PHP',0,NULL),
(2428,454,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index:  - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 302',1704174331,'PHP',0,NULL),
(2429,455,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:20:\"audit_testplan_saved\";s:6:\"params\";a:2:{i:0;s:11:\"GaN Charger\";i:1;s:40:\"Sample Charger Testing @Mysore Shyam Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704175321,'SAVE',137,'testplans'),
(2430,456,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704175339,'PHP',0,NULL),
(2431,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$filter_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 420',1704175362,'PHP',0,NULL),
(2432,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704175362,'PHP',0,NULL),
(2433,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704175362,'PHP',0,NULL),
(2434,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_priority - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 605',1704175362,'PHP',0,NULL),
(2435,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 612',1704175362,'PHP',0,NULL),
(2436,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 616',1704175362,'PHP',0,NULL),
(2437,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 633',1704175362,'PHP',0,NULL),
(2438,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_result_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 640',1704175362,'PHP',0,NULL),
(2439,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_bugs - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 647',1704175362,'PHP',0,NULL),
(2440,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_testplan - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 698',1704175362,'PHP',0,NULL),
(2441,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$basehref - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 736',1704175362,'PHP',0,NULL),
(2442,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$wrapOpen - in /opt/bitnami/testlink/gui/templates_c/1b04e701ff66471e26588a9fe0ec47707efb608d_0.file.planAddTCNavigator.tpl.php - Line 102',1704175362,'PHP',0,NULL),
(2443,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$wrapClose - in /opt/bitnami/testlink/gui/templates_c/1b04e701ff66471e26588a9fe0ec47707efb608d_0.file.planAddTCNavigator.tpl.php - Line 106',1704175362,'PHP',0,NULL),
(2444,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 27',1704175362,'PHP',0,NULL),
(2445,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 142',1704175362,'PHP',0,NULL),
(2446,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 113',1704175362,'PHP',0,NULL),
(2447,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 127',1704175362,'PHP',0,NULL),
(2448,457,2,'GUI - Test Project ID : 134','E_NOTICE\nArray to string conversion - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 181',1704175362,'PHP',0,NULL),
(2449,457,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_exec_tree_counters_logic - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 197',1704175362,'PHP',0,NULL),
(2450,458,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_testcase_name - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 286',1704175389,'PHP',0,NULL),
(2451,458,2,'GUI - Test Project ID : 134','E_WARNING\nInvalid argument supplied for foreach() - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 325',1704175389,'PHP',0,NULL),
(2452,458,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: spec_view - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 355',1704175389,'PHP',0,NULL),
(2453,458,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 355',1704175389,'PHP',0,NULL),
(2454,458,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 355',1704175389,'PHP',0,NULL),
(2455,458,2,'GUI - Test Project ID : 134','E_WARNING\nInvalid argument supplied for foreach() - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 355',1704175389,'PHP',0,NULL),
(2456,458,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: num_tc - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 363',1704175389,'PHP',0,NULL),
(2457,458,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: has_linked_items - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 365',1704175389,'PHP',0,NULL),
(2458,458,32,'GUI - Test Project ID : 134','string \'note_platform_filter\' is not localized for locale \'en_US\'  - using en_GB',1704175389,'LOCALIZATION',0,NULL),
(2459,459,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_testcase_name - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 286',1704175390,'PHP',0,NULL),
(2460,459,2,'GUI - Test Project ID : 134','E_WARNING\nInvalid argument supplied for foreach() - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 325',1704175390,'PHP',0,NULL),
(2461,459,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: spec_view - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 355',1704175390,'PHP',0,NULL),
(2462,459,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 355',1704175390,'PHP',0,NULL),
(2463,459,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 355',1704175390,'PHP',0,NULL),
(2464,459,2,'GUI - Test Project ID : 134','E_WARNING\nInvalid argument supplied for foreach() - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 355',1704175390,'PHP',0,NULL),
(2465,459,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: num_tc - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 363',1704175390,'PHP',0,NULL),
(2466,459,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: has_linked_items - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 365',1704175390,'PHP',0,NULL),
(2467,460,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_testcase_name - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 286',1704175390,'PHP',0,NULL),
(2468,460,2,'GUI - Test Project ID : 134','E_WARNING\nInvalid argument supplied for foreach() - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 325',1704175390,'PHP',0,NULL),
(2469,460,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: spec_view - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 355',1704175390,'PHP',0,NULL),
(2470,460,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 355',1704175390,'PHP',0,NULL),
(2471,460,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 355',1704175390,'PHP',0,NULL),
(2472,460,2,'GUI - Test Project ID : 134','E_WARNING\nInvalid argument supplied for foreach() - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 355',1704175390,'PHP',0,NULL),
(2473,460,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: num_tc - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 363',1704175390,'PHP',0,NULL),
(2474,460,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: has_linked_items - in /opt/bitnami/testlink/lib/plan/planAddTC.php - Line 365',1704175390,'PHP',0,NULL),
(2475,461,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704175395,'PHP',0,NULL),
(2476,462,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704175421,'PHP',0,NULL),
(2477,463,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1704175421,'PHP',0,NULL),
(2478,464,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704175439,'PHP',0,NULL),
(2479,465,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704175453,'PHP',0,NULL),
(2480,466,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704175688,'PHP',0,NULL),
(2481,467,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704175695,'PHP',0,NULL),
(2482,468,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$filter_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 420',1704175706,'PHP',0,NULL),
(2483,468,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704175706,'PHP',0,NULL),
(2484,468,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704175706,'PHP',0,NULL),
(2485,468,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_priority - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 605',1704175706,'PHP',0,NULL),
(2486,468,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 612',1704175706,'PHP',0,NULL),
(2487,468,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 616',1704175706,'PHP',0,NULL),
(2488,468,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 633',1704175706,'PHP',0,NULL),
(2489,468,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_result_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 640',1704175706,'PHP',0,NULL),
(2490,468,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_bugs - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 647',1704175706,'PHP',0,NULL),
(2491,468,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_testplan - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 698',1704175706,'PHP',0,NULL),
(2492,468,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 27',1704175706,'PHP',0,NULL),
(2493,468,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 142',1704175706,'PHP',0,NULL),
(2494,468,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 113',1704175706,'PHP',0,NULL),
(2495,468,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 127',1704175706,'PHP',0,NULL),
(2496,468,2,'GUI - Test Project ID : 134','E_NOTICE\nArray to string conversion - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 181',1704175706,'PHP',0,NULL),
(2497,468,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_exec_tree_counters_logic - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 197',1704175706,'PHP',0,NULL),
(2498,469,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 130',1704175861,'PHP',0,NULL),
(2499,469,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$itemID - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 152',1704175861,'PHP',0,NULL),
(2500,469,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index:  - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 302',1704175861,'PHP',0,NULL),
(2501,470,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$filter_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 420',1704175923,'PHP',0,NULL),
(2502,470,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704175923,'PHP',0,NULL),
(2503,470,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704175923,'PHP',0,NULL),
(2504,470,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_priority - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 605',1704175923,'PHP',0,NULL),
(2505,470,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 612',1704175923,'PHP',0,NULL),
(2506,470,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 616',1704175923,'PHP',0,NULL),
(2507,470,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 633',1704175923,'PHP',0,NULL),
(2508,470,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_result_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 640',1704175923,'PHP',0,NULL),
(2509,470,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_bugs - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 647',1704175923,'PHP',0,NULL),
(2510,470,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_testplan - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 698',1704175923,'PHP',0,NULL),
(2511,470,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 27',1704175923,'PHP',0,NULL),
(2512,470,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 142',1704175923,'PHP',0,NULL),
(2513,470,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 113',1704175923,'PHP',0,NULL),
(2514,470,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 127',1704175923,'PHP',0,NULL),
(2515,470,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_exec_tree_counters_logic - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 197',1704175923,'PHP',0,NULL),
(2516,471,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$filter_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 420',1704175924,'PHP',0,NULL),
(2517,471,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704175924,'PHP',0,NULL),
(2518,471,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704175924,'PHP',0,NULL),
(2519,471,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_priority - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 605',1704175924,'PHP',0,NULL),
(2520,471,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 612',1704175924,'PHP',0,NULL),
(2521,471,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 616',1704175924,'PHP',0,NULL),
(2522,471,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 633',1704175924,'PHP',0,NULL),
(2523,471,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_result_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 640',1704175924,'PHP',0,NULL),
(2524,471,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_bugs - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 647',1704175924,'PHP',0,NULL),
(2525,471,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_testplan - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 698',1704175924,'PHP',0,NULL),
(2526,471,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 27',1704175924,'PHP',0,NULL),
(2527,471,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 142',1704175924,'PHP',0,NULL),
(2528,471,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 113',1704175924,'PHP',0,NULL),
(2529,471,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 127',1704175924,'PHP',0,NULL),
(2530,471,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_exec_tree_counters_logic - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 197',1704175924,'PHP',0,NULL),
(2531,472,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$filter_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 420',1704175937,'PHP',0,NULL),
(2532,472,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704175937,'PHP',0,NULL),
(2533,472,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704175937,'PHP',0,NULL),
(2534,472,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_priority - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 605',1704175937,'PHP',0,NULL),
(2535,472,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 612',1704175937,'PHP',0,NULL),
(2536,472,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 616',1704175937,'PHP',0,NULL),
(2537,472,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 633',1704175937,'PHP',0,NULL),
(2538,472,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_result_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 640',1704175937,'PHP',0,NULL),
(2539,472,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_bugs - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 647',1704175937,'PHP',0,NULL),
(2540,472,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_testplan - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 698',1704175937,'PHP',0,NULL),
(2541,472,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 27',1704175937,'PHP',0,NULL),
(2542,472,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 142',1704175937,'PHP',0,NULL),
(2543,472,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 113',1704175937,'PHP',0,NULL),
(2544,472,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 127',1704175937,'PHP',0,NULL),
(2545,472,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_exec_tree_counters_logic - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 197',1704175937,'PHP',0,NULL),
(2546,473,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$filter_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 420',1704175941,'PHP',0,NULL),
(2547,473,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704175941,'PHP',0,NULL),
(2548,473,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704175941,'PHP',0,NULL),
(2549,473,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_priority - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 605',1704175941,'PHP',0,NULL),
(2550,473,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 612',1704175941,'PHP',0,NULL),
(2551,473,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 616',1704175941,'PHP',0,NULL),
(2552,473,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 633',1704175941,'PHP',0,NULL),
(2553,473,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_result_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 640',1704175941,'PHP',0,NULL),
(2554,473,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_bugs - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 647',1704175941,'PHP',0,NULL),
(2555,473,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_testplan - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 698',1704175941,'PHP',0,NULL),
(2556,473,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 27',1704175941,'PHP',0,NULL),
(2557,473,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 142',1704175941,'PHP',0,NULL),
(2558,473,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 113',1704175941,'PHP',0,NULL),
(2559,473,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 127',1704175941,'PHP',0,NULL),
(2560,473,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_exec_tree_counters_logic - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 197',1704175941,'PHP',0,NULL),
(2561,474,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$filter_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 420',1704175943,'PHP',0,NULL),
(2562,474,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704175943,'PHP',0,NULL),
(2563,474,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 599',1704175943,'PHP',0,NULL),
(2564,474,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_priority - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 605',1704175943,'PHP',0,NULL),
(2565,474,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 612',1704175943,'PHP',0,NULL),
(2566,474,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_keywords - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 616',1704175943,'PHP',0,NULL),
(2567,474,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 633',1704175943,'PHP',0,NULL),
(2568,474,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_result_result - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 640',1704175943,'PHP',0,NULL),
(2569,474,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_bugs - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 647',1704175943,'PHP',0,NULL),
(2570,474,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_testplan - in /opt/bitnami/testlink/lib/functions/tlTestCaseFilterByRequirementControl.class.php - Line 698',1704175943,'PHP',0,NULL),
(2571,474,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 27',1704175943,'PHP',0,NULL),
(2572,474,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: filter_assigned_user - in /opt/bitnami/testlink/gui/templates_c/c1282b1387ae220ea9ea45052a801e8b99886383_0.file.inc_filter_panel_js.tpl.php - Line 142',1704175943,'PHP',0,NULL),
(2573,474,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_platform - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 113',1704175943,'PHP',0,NULL),
(2574,474,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_build - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 127',1704175943,'PHP',0,NULL),
(2575,474,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: setting_exec_tree_counters_logic - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 197',1704175943,'PHP',0,NULL),
(2576,475,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704176013,'PHP',0,NULL),
(2577,476,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1704176013,'PHP',0,NULL),
(2578,477,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704176131,'PHP',0,NULL),
(2579,478,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1704176131,'PHP',0,NULL),
(2580,479,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1704176137,'PHP',0,NULL),
(2581,480,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1704176138,'PHP',0,NULL),
(2582,481,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704176146,'PHP',0,NULL),
(2583,482,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704176146,'PHP',0,NULL),
(2584,483,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704177074,'PHP',0,NULL),
(2585,484,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 221',1704178029,'PHP',0,NULL),
(2586,484,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 245',1704178029,'PHP',0,NULL),
(2587,484,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 277',1704178029,'PHP',0,NULL),
(2588,485,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 221',1704178078,'PHP',0,NULL),
(2589,485,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 245',1704178078,'PHP',0,NULL),
(2590,485,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 277',1704178078,'PHP',0,NULL),
(2591,486,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:22:\"audit_req_spec_deleted\";s:6:\"params\";a:2:{i:0;s:11:\"GaN Charger\";i:1;s:22:\"Sample Charges Details\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704178152,'DELETE',135,'req_specs'),
(2592,487,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 221',1704178157,'PHP',0,NULL),
(2593,487,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 245',1704178157,'PHP',0,NULL),
(2594,487,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 277',1704178157,'PHP',0,NULL),
(2595,488,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type bool - in /opt/bitnami/testlink/lib/requirements/reqSpecCommands.class.php - Line 208',1704178222,'PHP',0,NULL),
(2596,488,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:22:\"audit_req_spec_created\";s:6:\"params\";a:2:{i:0;s:11:\"GaN Charger\";i:1;s:15:\"Charger Testing\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704178223,'CREATE',138,'req_specs'),
(2597,488,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 221',1704178223,'PHP',0,NULL),
(2598,488,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 245',1704178223,'PHP',0,NULL),
(2599,488,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/ef1685d2aa892938987008051a1410b5b54f388a_0.file.reqSpecEdit.tpl.php - Line 277',1704178223,'PHP',0,NULL),
(2600,489,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/lib/requirements/reqSpecEdit.php - Line 213',1704178322,'PHP',0,NULL),
(2601,490,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/226b3472a2450358f1c4d5ee83713f23e0c21bfa_0.file.reqEdit.tpl.php - Line 375',1704178456,'PHP',0,NULL),
(2602,490,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/226b3472a2450358f1c4d5ee83713f23e0c21bfa_0.file.reqEdit.tpl.php - Line 398',1704178456,'PHP',0,NULL),
(2603,490,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/226b3472a2450358f1c4d5ee83713f23e0c21bfa_0.file.reqEdit.tpl.php - Line 412',1704178456,'PHP',0,NULL),
(2604,490,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/226b3472a2450358f1c4d5ee83713f23e0c21bfa_0.file.reqEdit.tpl.php - Line 419',1704178456,'PHP',0,NULL),
(2605,490,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/226b3472a2450358f1c4d5ee83713f23e0c21bfa_0.file.reqEdit.tpl.php - Line 443',1704178456,'PHP',0,NULL),
(2606,491,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/226b3472a2450358f1c4d5ee83713f23e0c21bfa_0.file.reqEdit.tpl.php - Line 375',1704178565,'PHP',0,NULL),
(2607,491,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/226b3472a2450358f1c4d5ee83713f23e0c21bfa_0.file.reqEdit.tpl.php - Line 398',1704178565,'PHP',0,NULL),
(2608,491,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/226b3472a2450358f1c4d5ee83713f23e0c21bfa_0.file.reqEdit.tpl.php - Line 412',1704178565,'PHP',0,NULL),
(2609,491,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/226b3472a2450358f1c4d5ee83713f23e0c21bfa_0.file.reqEdit.tpl.php - Line 419',1704178565,'PHP',0,NULL),
(2610,491,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/226b3472a2450358f1c4d5ee83713f23e0c21bfa_0.file.reqEdit.tpl.php - Line 443',1704178565,'PHP',0,NULL),
(2611,492,2,'GUI - Test Project ID : 134','In TestRequirement Create with id: 141',1704178982,NULL,0,NULL),
(2612,492,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_requirement_created\";s:6:\"params\";a:1:{i:0;s:7:\"req 001\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704178982,'CREATE',141,'requirements'),
(2613,492,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/lib/requirements/reqEdit.php - Line 235',1704178982,'PHP',0,NULL),
(2614,493,32,'GUI - Test Project ID : 134','string \'img_title_relation_frozen\' is not localized for locale \'en_US\'  - using en_GB',1704178982,'LOCALIZATION',0,NULL),
(2615,493,32,'GUI - Test Project ID : 134','string \'obsolete\' is not localized for locale \'en_US\'  - using en_GB',1704178982,'LOCALIZATION',0,NULL),
(2616,494,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704179839,'PHP',0,NULL),
(2617,495,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1704179839,'PHP',0,NULL),
(2618,496,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/tree.class.php - Line 725',1704179913,'PHP',0,NULL),
(2619,496,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/tree.class.php - Line 725',1704179913,'PHP',0,NULL),
(2620,496,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_testsuite_display_message\' is not localized for locale \'en_US\' ',1704179913,'LOCALIZATION',0,NULL),
(2621,496,2,'GUI - Test Project ID : 134','Im in testsuite create',1704179913,NULL,0,NULL),
(2622,497,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704179913,'PHP',0,NULL),
(2623,498,32,'GUI - Test Project ID : 134','string \'btn_add_to_testsuites_deep\' is not localized for locale \'en_US\'  - using en_GB',1704179918,'LOCALIZATION',0,NULL),
(2624,498,32,'GUI - Test Project ID : 134','string \'select_keywords\' is not localized for locale \'en_US\'  - using en_GB',1704179918,'LOCALIZATION',0,NULL),
(2625,499,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/testcase.class.php - Line 5361',1704179924,'PHP',0,NULL),
(2626,500,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704181221,'PHP',0,NULL),
(2627,501,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1704181221,'PHP',0,NULL),
(2628,502,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/testcase.class.php - Line 5361',1704181231,'PHP',0,NULL),
(2629,503,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/testcase.class.php - Line 5361',1704181254,'PHP',0,NULL),
(2630,503,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/tree.class.php - Line 725',1704181254,'PHP',0,NULL),
(2631,503,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/tree.class.php - Line 725',1704181254,'PHP',0,NULL),
(2632,503,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1704181254,'PHP',0,NULL),
(2633,503,32,'GUI - Test Project ID : 134','string \'updateLinkToThisTCVersion\' is not localized for locale \'en_US\'  - using en_GB',1704181254,'LOCALIZATION',0,NULL),
(2634,503,32,'GUI - Test Project ID : 134','string \'btn_new_version_from_latest\' is not localized for locale \'en_US\'  - using en_GB',1704181254,'LOCALIZATION',0,NULL),
(2635,503,32,'GUI - Test Project ID : 134','string \'code_mgmt\' is not localized for locale \'en_US\'  - using en_GB',1704181254,'LOCALIZATION',0,NULL),
(2636,503,32,'GUI - Test Project ID : 134','string \'code_link_tl_to_cts\' is not localized for locale \'en_US\'  - using en_GB',1704181254,'LOCALIZATION',0,NULL),
(2637,503,32,'GUI - Test Project ID : 134','string \'can_not_edit_frozen_tc\' is not localized for locale \'en_US\'  - using en_GB',1704181254,'LOCALIZATION',0,NULL),
(2638,503,32,'GUI - Test Project ID : 134','string \'testcase_version_operations\' is not localized for locale \'en_US\'  - using en_GB',1704181254,'LOCALIZATION',0,NULL),
(2639,503,32,'GUI - Test Project ID : 134','string \'createKW\' is not localized for locale \'en_US\'  - using en_GB',1704181254,'LOCALIZATION',0,NULL),
(2640,503,32,'GUI - Test Project ID : 134','string \'btn_create_and_link\' is not localized for locale \'en_US\'  - using en_GB',1704181254,'LOCALIZATION',0,NULL),
(2641,503,32,'GUI - Test Project ID : 134','string \'img_title_remove_platform\' is not localized for locale \'en_US\' ',1704181254,'LOCALIZATION',0,NULL),
(2642,503,32,'GUI - Test Project ID : 134','string \'select_platforms\' is not localized for locale \'en_US\'  - using en_GB',1704181254,'LOCALIZATION',0,NULL),
(2643,503,32,'GUI - Test Project ID : 134','string \'remove_plat_msgbox_msg\' is not localized for locale \'en_US\' ',1704181254,'LOCALIZATION',0,NULL),
(2644,503,32,'GUI - Test Project ID : 134','string \'remove_plat_msgbox_title\' is not localized for locale \'en_US\' ',1704181254,'LOCALIZATION',0,NULL),
(2645,503,32,'GUI - Test Project ID : 134','string \'can_not_delete_a_frozen_relation\' is not localized for locale \'en_US\'  - using en_GB',1704181254,'LOCALIZATION',0,NULL),
(2646,503,32,'GUI - Test Project ID : 134','string \'can_not_delete_relation_frozen_tc\' is not localized for locale \'en_US\'  - using en_GB',1704181254,'LOCALIZATION',0,NULL),
(2647,503,32,'GUI - Test Project ID : 134','string \'can_not_delete_relation_because_this_is_not_the_latest\' is not localized for locale \'en_US\'  - using en_GB',1704181254,'LOCALIZATION',0,NULL),
(2648,503,32,'GUI - Test Project ID : 134','string \'this_tcversion\' is not localized for locale \'en_US\'  - using en_GB',1704181254,'LOCALIZATION',0,NULL),
(2649,503,32,'GUI - Test Project ID : 134','string \'can_not_delete_relation_tcversion_frozen\' is not localized for locale \'en_US\'  - using en_GB',1704181254,'LOCALIZATION',0,NULL),
(2650,503,32,'GUI - Test Project ID : 134','string \'can_not_delete_relation_related_tcversion_frozen\' is not localized for locale \'en_US\'  - using en_GB',1704181254,'LOCALIZATION',0,NULL),
(2651,504,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704181254,'PHP',0,NULL),
(2652,505,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/testcase.class.php - Line 5361',1704181258,'PHP',0,NULL),
(2653,506,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/testcase.class.php - Line 5361',1704181279,'PHP',0,NULL),
(2654,507,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/testcase.class.php - Line 5361',1704181295,'PHP',0,NULL),
(2655,507,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1704181295,'PHP',0,NULL),
(2656,508,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704181295,'PHP',0,NULL),
(2657,509,2,'GUI - Test Project ID : 134','In TestCase Update with id: 146, planid: 147, title: Line Regulation Testing, summary<p>Line Regulation Testing</p>\r\n',1704181342,NULL,0,NULL),
(2658,509,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1704181342,'PHP',0,NULL),
(2659,510,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704181342,'PHP',0,NULL),
(2660,511,2,'GUI - Test Project ID : 134','In TestCase Update with id: 146, planid: 147, title: Line Regulation Testing, summary<p>Line Regulation Testing</p>\r\n',1704181360,NULL,0,NULL),
(2661,511,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1704181360,'PHP',0,NULL),
(2662,512,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704181361,'PHP',0,NULL),
(2663,513,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:30:\"v.bhavana@Kaynestechnology.net\";i:1;s:10:\"172.27.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704341126,'LOGIN',3,'users'),
(2664,514,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_config\' is not localized for locale \'en_US\' ',1704341127,'LOCALIZATION',0,NULL),
(2665,514,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_left_bottom_link\' is not localized for locale \'en_US\' ',1704341127,'LOCALIZATION',0,NULL),
(2666,514,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_right_top_link\' is not localized for locale \'en_US\' ',1704341127,'LOCALIZATION',0,NULL),
(2667,514,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_right_bottom_link\' is not localized for locale \'en_US\' ',1704341127,'LOCALIZATION',0,NULL),
(2668,514,32,'GUI - Test Project ID : 134','string \'poweredBy\' is not localized for locale \'en_US\'  - using en_GB',1704341127,'LOCALIZATION',0,NULL),
(2669,514,32,'GUI - Test Project ID : 134','string \'system_descr\' is not localized for locale \'en_US\'  - using en_GB',1704341127,'LOCALIZATION',0,NULL),
(2670,514,32,'GUI - Test Project ID : 134','string \'href_codetracker_management\' is not localized for locale \'en_US\'  - using en_GB',1704341127,'LOCALIZATION',0,NULL),
(2671,515,32,'GUI - Test Project ID : 134','string \'without_platforms\' is not localized for locale \'en_US\'  - using en_GB',1704343172,'LOCALIZATION',0,NULL),
(2672,515,32,'GUI - Test Project ID : 134','string \'exec_tree_counters_logic\' is not localized for locale \'en_US\'  - using en_GB',1704343172,'LOCALIZATION',0,NULL),
(2673,515,32,'GUI - Test Project ID : 134','string \'platforms\' is not localized for locale \'en_US\'  - using en_GB',1704343172,'LOCALIZATION',0,NULL),
(2674,515,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704343172,'PHP',0,NULL),
(2675,516,32,'GUI - Test Project ID : 134','string \'file_upload_ko\' is not localized for locale \'en_US\'  - using en_GB',1704343172,'LOCALIZATION',0,NULL),
(2676,516,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1704343172,'PHP',0,NULL),
(2677,516,32,'GUI - Test Project ID : 134','string \'allowed_files\' is not localized for locale \'en_US\'  - using en_GB',1704343172,'LOCALIZATION',0,NULL),
(2678,516,32,'GUI - Test Project ID : 134','string \'allowed_filenames_regexp\' is not localized for locale \'en_US\'  - using en_GB',1704343172,'LOCALIZATION',0,NULL),
(2679,517,32,'GUI - Test Project ID : 134','string \'updateLinkToThisTCVersion\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2680,517,32,'GUI - Test Project ID : 134','string \'btn_new_version_from_latest\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2681,517,32,'GUI - Test Project ID : 134','string \'code_mgmt\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2682,517,32,'GUI - Test Project ID : 134','string \'code_link_tl_to_cts\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2683,517,32,'GUI - Test Project ID : 134','string \'can_not_edit_frozen_tc\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2684,517,32,'GUI - Test Project ID : 134','string \'testcase_version_operations\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2685,517,32,'GUI - Test Project ID : 134','string \'select_keywords\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2686,517,32,'GUI - Test Project ID : 134','string \'createKW\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2687,517,32,'GUI - Test Project ID : 134','string \'btn_create_and_link\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2688,517,32,'GUI - Test Project ID : 134','string \'img_title_remove_platform\' is not localized for locale \'en_US\' ',1704343175,'LOCALIZATION',0,NULL),
(2689,517,32,'GUI - Test Project ID : 134','string \'select_platforms\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2690,517,32,'GUI - Test Project ID : 134','string \'remove_plat_msgbox_msg\' is not localized for locale \'en_US\' ',1704343175,'LOCALIZATION',0,NULL),
(2691,517,32,'GUI - Test Project ID : 134','string \'remove_plat_msgbox_title\' is not localized for locale \'en_US\' ',1704343175,'LOCALIZATION',0,NULL),
(2692,517,32,'GUI - Test Project ID : 134','string \'can_not_delete_a_frozen_relation\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2693,517,32,'GUI - Test Project ID : 134','string \'can_not_delete_relation_frozen_tc\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2694,517,32,'GUI - Test Project ID : 134','string \'can_not_delete_relation_because_this_is_not_the_latest\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2695,517,32,'GUI - Test Project ID : 134','string \'this_tcversion\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2696,517,32,'GUI - Test Project ID : 134','string \'can_not_delete_relation_tcversion_frozen\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2697,517,32,'GUI - Test Project ID : 134','string \'can_not_delete_relation_related_tcversion_frozen\' is not localized for locale \'en_US\'  - using en_GB',1704343175,'LOCALIZATION',0,NULL),
(2698,518,2,'GUI - Test Project ID : 134','In TestCase Update with id: 146, planid: 147, title: Line Regulation Testing, summary<p>Line Regulation Testing</p>\r\n',1704343261,NULL,0,NULL),
(2699,518,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1704343261,'PHP',0,NULL),
(2700,519,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704343266,'PHP',0,NULL),
(2701,520,2,'GUI - Test Project ID : 134','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /opt/bitnami/testlink/lib/general/frmWorkArea.php - Line 216',1704343341,'PHP',0,NULL),
(2702,521,32,'GUI - Test Project ID : 134','string \'commit_id\' is not localized for locale \'en_US\'  - using en_GB',1704343345,'LOCALIZATION',0,NULL),
(2703,521,32,'GUI - Test Project ID : 134','string \'branch\' is not localized for locale \'en_US\'  - using en_GB',1704343345,'LOCALIZATION',0,NULL),
(2704,521,32,'GUI - Test Project ID : 134','string \'tag\' is not localized for locale \'en_US\'  - using en_GB',1704343345,'LOCALIZATION',0,NULL),
(2705,521,32,'GUI - Test Project ID : 134','string \'release_candidate\' is not localized for locale \'en_US\'  - using en_GB',1704343345,'LOCALIZATION',0,NULL),
(2706,522,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$creation_ts - in /opt/bitnami/testlink/lib/plan/buildEdit.php - Line 390',1704343469,'PHP',0,NULL),
(2707,522,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_build_created\";s:6:\"params\";a:3:{i:0;s:11:\"GaN Charger\";i:1;s:40:\"Sample Charger Testing @Mysore Shyam Lab\";i:2;s:44:\"Spigen and Chinense GaN Fast Charger Testing\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704343469,'CREATE',2,'builds'),
(2708,523,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: bulk_tester_div - in /opt/bitnami/testlink/lib/plan/tc_exec_assignment.php - Line 259',1704343514,'PHP',0,NULL),
(2709,523,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/plan/tc_exec_assignment.php - Line 375',1704343514,'PHP',0,NULL),
(2710,523,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/plan/tc_exec_assignment.php - Line 378',1704343514,'PHP',0,NULL),
(2711,523,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/roles.inc.php - Line 398',1704343514,'PHP',0,NULL),
(2712,523,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/roles.inc.php - Line 398',1704343514,'PHP',0,NULL),
(2713,523,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/roles.inc.php - Line 398',1704343514,'PHP',0,NULL),
(2714,524,32,'GUI - Test Project ID : 134','string \'btn_add_to_testsuites_deep\' is not localized for locale \'en_US\'  - using en_GB',1704343694,'LOCALIZATION',0,NULL),
(2715,525,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: user - in /opt/bitnami/testlink/lib/functions/common.php - Line 1925',1704346089,'PHP',0,NULL),
(2716,526,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:17:\"audit_user_logout\";s:6:\"params\";a:1:{i:0;s:30:\"v.bhavana@Kaynestechnology.net\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704346097,'LOGOUT',3,'users'),
(2717,527,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:30:\"v.bhavana@Kaynestechnology.net\";i:1;s:10:\"172.27.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704346101,'LOGIN',3,'users'),
(2718,528,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_config\' is not localized for locale \'en_US\' ',1704346101,'LOCALIZATION',0,NULL),
(2719,528,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_left_bottom_link\' is not localized for locale \'en_US\' ',1704346101,'LOCALIZATION',0,NULL),
(2720,528,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_right_top_link\' is not localized for locale \'en_US\' ',1704346101,'LOCALIZATION',0,NULL),
(2721,528,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_right_bottom_link\' is not localized for locale \'en_US\' ',1704346101,'LOCALIZATION',0,NULL),
(2722,528,32,'GUI - Test Project ID : 134','string \'poweredBy\' is not localized for locale \'en_US\'  - using en_GB',1704346101,'LOCALIZATION',0,NULL),
(2723,528,32,'GUI - Test Project ID : 134','string \'system_descr\' is not localized for locale \'en_US\'  - using en_GB',1704346101,'LOCALIZATION',0,NULL),
(2724,528,32,'GUI - Test Project ID : 134','string \'href_codetracker_management\' is not localized for locale \'en_US\'  - using en_GB',1704346101,'LOCALIZATION',0,NULL),
(2725,529,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: user - in /opt/bitnami/testlink/lib/functions/common.php - Line 1925',1704346106,'PHP',0,NULL),
(2726,530,32,'GUI - Test Project ID : 134','string \'without_platforms\' is not localized for locale \'en_US\'  - using en_GB',1704346119,'LOCALIZATION',0,NULL),
(2727,530,32,'GUI - Test Project ID : 134','string \'exec_tree_counters_logic\' is not localized for locale \'en_US\'  - using en_GB',1704346120,'LOCALIZATION',0,NULL),
(2728,530,32,'GUI - Test Project ID : 134','string \'platforms\' is not localized for locale \'en_US\'  - using en_GB',1704346120,'LOCALIZATION',0,NULL),
(2729,531,32,'GUI - Test Project ID : 134','string \'use_latest_exec_on_contex_for_counters\' is not localized for locale \'en_US\'  - using en_GB',1704346154,'LOCALIZATION',0,NULL),
(2730,531,32,'GUI - Test Project ID : 134','string \'use_latest_exec_on_testplan_for_counters\' is not localized for locale \'en_US\'  - using en_GB',1704346154,'LOCALIZATION',0,NULL),
(2731,532,32,'GUI - Test Project ID : 134','string \'restAPIExecParameters\' is not localized for locale \'en_US\'  - using en_GB',1704346154,'LOCALIZATION',0,NULL),
(2732,533,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: user - in /opt/bitnami/testlink/lib/functions/common.php - Line 1925',1704346190,'PHP',0,NULL),
(2733,534,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704348025,'PHP',0,NULL),
(2734,535,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704354223,'PHP',0,NULL),
(2735,536,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704354237,'PHP',0,NULL),
(2736,537,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 705',1704354243,'PHP',0,NULL),
(2737,537,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 710',1704354243,'PHP',0,NULL),
(2738,537,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 747',1704354243,'PHP',0,NULL),
(2739,537,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 1164',1704354243,'PHP',0,NULL),
(2740,537,32,'GUI - Test Project ID : 134','string \'note_platform_filter\' is not localized for locale \'en_US\'  - using en_GB',1704354243,'LOCALIZATION',0,NULL),
(2741,538,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 705',1704354243,'PHP',0,NULL),
(2742,538,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 710',1704354243,'PHP',0,NULL),
(2743,538,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 747',1704354243,'PHP',0,NULL),
(2744,538,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 1164',1704354243,'PHP',0,NULL),
(2745,539,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704354282,'PHP',0,NULL),
(2746,540,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 705',1704354287,'PHP',0,NULL),
(2747,540,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 710',1704354287,'PHP',0,NULL),
(2748,540,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 747',1704354287,'PHP',0,NULL),
(2749,540,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 1164',1704354287,'PHP',0,NULL),
(2750,541,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 705',1704354287,'PHP',0,NULL),
(2751,541,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 710',1704354287,'PHP',0,NULL),
(2752,541,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 747',1704354287,'PHP',0,NULL),
(2753,541,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 1164',1704354287,'PHP',0,NULL),
(2754,542,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:33:\"TCGaN-1 : Long Regulation testing\";i:1;s:1:\"1\";i:2;s:40:\"Sample Charger Testing @Mysore Shyam Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704354509,'ASSIGN',137,'testplans'),
(2755,542,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:33:\"TCGaN-2 : Line Regulation Testing\";i:1;s:1:\"1\";i:2;s:40:\"Sample Charger Testing @Mysore Shyam Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704354509,'ASSIGN',137,'testplans'),
(2756,542,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 705',1704354509,'PHP',0,NULL),
(2757,542,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 710',1704354509,'PHP',0,NULL),
(2758,542,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 747',1704354509,'PHP',0,NULL),
(2759,542,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 1164',1704354509,'PHP',0,NULL),
(2760,542,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/56889df98de7ae8b0bc28961d8c4d1c24b8ef6c7_0.file.planAddTC_m1.tpl.php - Line 462',1704354509,'PHP',0,NULL),
(2761,542,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/56889df98de7ae8b0bc28961d8c4d1c24b8ef6c7_0.file.planAddTC_m1.tpl.php - Line 467',1704354509,'PHP',0,NULL),
(2762,542,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/56889df98de7ae8b0bc28961d8c4d1c24b8ef6c7_0.file.planAddTC_m1.tpl.php - Line 479',1704354509,'PHP',0,NULL),
(2763,542,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/56889df98de7ae8b0bc28961d8c4d1c24b8ef6c7_0.file.planAddTC_m1.tpl.php - Line 462',1704354509,'PHP',0,NULL),
(2764,542,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/56889df98de7ae8b0bc28961d8c4d1c24b8ef6c7_0.file.planAddTC_m1.tpl.php - Line 467',1704354509,'PHP',0,NULL),
(2765,542,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/56889df98de7ae8b0bc28961d8c4d1c24b8ef6c7_0.file.planAddTC_m1.tpl.php - Line 479',1704354509,'PHP',0,NULL),
(2766,543,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704354510,'PHP',0,NULL),
(2767,544,32,'GUI - Test Project ID : 134','string \'th_codetracker\' is not localized for locale \'en_US\'  - using en_GB',1704354884,'LOCALIZATION',0,NULL),
(2768,545,32,'GUI - Test Project ID : 134','string \'testproject_code_tracker_integration\' is not localized for locale \'en_US\'  - using en_GB',1704354893,'LOCALIZATION',0,NULL),
(2769,545,32,'GUI - Test Project ID : 134','string \'code_tracker\' is not localized for locale \'en_US\'  - using en_GB',1704354893,'LOCALIZATION',0,NULL),
(2770,545,32,'GUI - Test Project ID : 134','string \'no_codetracker_defined\' is not localized for locale \'en_US\'  - using en_GB',1704354893,'LOCALIZATION',0,NULL),
(2771,546,2,'GUI - Test Project ID : 134','In TestProject Update with id: 134, name: GaN Charger, prefix: TCGaN',1704354904,NULL,0,NULL),
(2772,546,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:23:\"audit_testproject_saved\";s:6:\"params\";a:1:{i:0;s:11:\"GaN Charger\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704354904,'UPDATE',134,'testprojects'),
(2773,547,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uribase - in /opt/bitnami/testlink/lib/issuetrackerintegration/bugzillaxmlrpcInterface.class.php - Line 65',1704354953,'PHP',0,NULL),
(2774,547,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704354953,'PHP',0,NULL),
(2775,547,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704354953,'PHP',0,NULL),
(2776,547,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704354953,'PHP',0,NULL),
(2777,547,32,'GUI - Test Project ID : 134','string \'issue_subject_tcname\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2778,547,32,'GUI - Test Project ID : 134','string \'issue_subject_tcpathname\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2779,547,32,'GUI - Test Project ID : 134','string \'issue_subject_projectname\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2780,547,32,'GUI - Test Project ID : 134','string \'issue_subject_planname\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2781,547,32,'GUI - Test Project ID : 134','string \'issue_subject_buildname\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2782,547,32,'GUI - Test Project ID : 134','string \'issue_subject_platfname\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2783,547,32,'GUI - Test Project ID : 134','string \'issue_subject_execon\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2784,547,32,'GUI - Test Project ID : 134','string \'add_link_to_tlexec_print_view\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2785,547,32,'GUI - Test Project ID : 134','string \'copy_attachments_from_latest_exec\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2786,547,32,'GUI - Test Project ID : 134','string \'hasNewestVersionMsg\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2787,547,32,'GUI - Test Project ID : 134','string \'partialExecNoAttachmentsWarning\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2788,547,32,'GUI - Test Project ID : 134','string \'partialExecNothingToSave\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2789,547,32,'GUI - Test Project ID : 134','string \'saveStepsForPartialExec\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2790,547,32,'GUI - Test Project ID : 134','string \'updateLinkToLatestTCVersion\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2791,547,32,'GUI - Test Project ID : 134','string \'file_upload_ko\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2792,547,32,'GUI - Test Project ID : 134','string \'pleaseOpenTSuite\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2793,547,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/8f7d50b23a3ad2636127523615ed9c295157f12b_0.file.inc_exec_show_tc_exec.tpl.php - Line 244',1704354953,'PHP',0,NULL),
(2794,547,32,'GUI - Test Project ID : 134','string \'allowed_files\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2795,547,32,'GUI - Test Project ID : 134','string \'allowed_filenames_regexp\' is not localized for locale \'en_US\'  - using en_GB',1704354953,'LOCALIZATION',0,NULL),
(2796,548,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704354953,'PHP',0,NULL),
(2797,548,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704354953,'PHP',0,NULL),
(2798,548,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704354953,'PHP',0,NULL),
(2799,548,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/8f7d50b23a3ad2636127523615ed9c295157f12b_0.file.inc_exec_show_tc_exec.tpl.php - Line 244',1704354953,'PHP',0,NULL),
(2800,549,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355016,'PHP',0,NULL),
(2801,549,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355016,'PHP',0,NULL),
(2802,549,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704355016,'PHP',0,NULL),
(2803,549,2,'GUI - Test Project ID : 134','In TestRun with testrunid: 13, planid: 137, buildid: 2, testcaseid: 144, Notes: p, Status: http://192.168.0.124:83/ltx.php?item=exec&feature_id=9&build_id=2',1704355016,NULL,0,NULL),
(2804,549,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_exec_saved\";s:6:\"params\";a:3:{i:0;s:7:\"TCGaN-1\";i:1;s:44:\"Spigen and Chinense GaN Fast Charger Testing\";i:2;s:40:\"Sample Charger Testing @Mysore Shyam Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704355016,'CREATE',13,'execution'),
(2805,550,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355022,'PHP',0,NULL),
(2806,550,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355022,'PHP',0,NULL),
(2807,550,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704355023,'PHP',0,NULL),
(2808,550,2,'GUI - Test Project ID : 134','In TestRun with testrunid: 14, planid: 137, buildid: 2, testcaseid: 144, Notes: p, Status: http://192.168.0.124:83/ltx.php?item=exec&feature_id=9&build_id=2',1704355023,NULL,0,NULL),
(2809,550,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_exec_saved\";s:6:\"params\";a:3:{i:0;s:7:\"TCGaN-1\";i:1;s:44:\"Spigen and Chinense GaN Fast Charger Testing\";i:2;s:40:\"Sample Charger Testing @Mysore Shyam Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704355023,'CREATE',14,'execution'),
(2810,551,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355106,'PHP',0,NULL),
(2811,551,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355106,'PHP',0,NULL),
(2812,551,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704355106,'PHP',0,NULL),
(2813,552,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355135,'PHP',0,NULL),
(2814,552,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355135,'PHP',0,NULL),
(2815,552,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704355135,'PHP',0,NULL),
(2816,552,32,'GUI - Test Project ID : 134','string \'FILE_UPLOAD_allowed_filenames_regexp\' is not localized for locale \'en_US\'  - using en_GB',1704355135,'LOCALIZATION',0,NULL),
(2817,552,2,'GUI - Test Project ID : 134','In TestRun with testrunid: 15, planid: 137, buildid: 2, testcaseid: 144, Notes: p, Status: http://192.168.0.124:83/ltx.php?item=exec&feature_id=9&build_id=2',1704355135,NULL,0,NULL),
(2818,552,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_exec_saved\";s:6:\"params\";a:3:{i:0;s:7:\"TCGaN-1\";i:1;s:44:\"Spigen and Chinense GaN Fast Charger Testing\";i:2;s:40:\"Sample Charger Testing @Mysore Shyam Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704355135,'CREATE',15,'execution'),
(2819,553,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$refreshTree - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 2290',1704355176,'PHP',0,NULL),
(2820,553,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355176,'PHP',0,NULL),
(2821,553,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355176,'PHP',0,NULL),
(2822,553,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704355176,'PHP',0,NULL),
(2823,554,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 130',1704355215,'PHP',0,NULL),
(2824,554,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$itemID - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 152',1704355215,'PHP',0,NULL),
(2825,554,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index:  - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 302',1704355215,'PHP',0,NULL),
(2826,555,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355229,'PHP',0,NULL),
(2827,555,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355229,'PHP',0,NULL),
(2828,555,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704355229,'PHP',0,NULL),
(2829,556,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355230,'PHP',0,NULL),
(2830,556,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355230,'PHP',0,NULL),
(2831,556,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704355230,'PHP',0,NULL),
(2832,557,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355252,'PHP',0,NULL),
(2833,557,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355252,'PHP',0,NULL),
(2834,557,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704355252,'PHP',0,NULL),
(2835,557,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_exec_deleted\";s:6:\"params\";a:3:{i:0;s:7:\"TCGaN-1\";i:1;s:44:\"Spigen and Chinense GaN Fast Charger Testing\";i:2;s:40:\"Sample Charger Testing @Mysore Shyam Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704355252,'DELETE',15,'execution'),
(2836,558,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355257,'PHP',0,NULL),
(2837,558,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355257,'PHP',0,NULL),
(2838,558,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704355257,'PHP',0,NULL),
(2839,558,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_exec_deleted\";s:6:\"params\";a:3:{i:0;s:7:\"TCGaN-1\";i:1;s:44:\"Spigen and Chinense GaN Fast Charger Testing\";i:2;s:40:\"Sample Charger Testing @Mysore Shyam Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704355257,'DELETE',13,'execution'),
(2840,559,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355261,'PHP',0,NULL),
(2841,559,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355261,'PHP',0,NULL),
(2842,559,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704355261,'PHP',0,NULL),
(2843,559,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_exec_deleted\";s:6:\"params\";a:3:{i:0;s:7:\"TCGaN-1\";i:1;s:44:\"Spigen and Chinense GaN Fast Charger Testing\";i:2;s:40:\"Sample Charger Testing @Mysore Shyam Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704355261,'DELETE',14,'execution'),
(2844,559,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/8f7d50b23a3ad2636127523615ed9c295157f12b_0.file.inc_exec_show_tc_exec.tpl.php - Line 244',1704355261,'PHP',0,NULL),
(2845,560,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355266,'PHP',0,NULL),
(2846,560,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355266,'PHP',0,NULL),
(2847,560,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704355266,'PHP',0,NULL),
(2848,560,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/8f7d50b23a3ad2636127523615ed9c295157f12b_0.file.inc_exec_show_tc_exec.tpl.php - Line 244',1704355266,'PHP',0,NULL),
(2849,561,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355266,'PHP',0,NULL),
(2850,561,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355266,'PHP',0,NULL),
(2851,561,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704355266,'PHP',0,NULL),
(2852,561,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/8f7d50b23a3ad2636127523615ed9c295157f12b_0.file.inc_exec_show_tc_exec.tpl.php - Line 244',1704355266,'PHP',0,NULL),
(2853,562,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355274,'PHP',0,NULL),
(2854,562,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704355274,'PHP',0,NULL),
(2855,562,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704355274,'PHP',0,NULL),
(2856,562,2,'GUI - Test Project ID : 134','In TestRun with testrunid: 16, planid: 137, buildid: 2, testcaseid: 144, Notes: p, Status: http://192.168.0.124:83/ltx.php?item=exec&feature_id=9&build_id=2',1704355274,NULL,0,NULL),
(2857,562,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_exec_saved\";s:6:\"params\";a:3:{i:0;s:7:\"TCGaN-1\";i:1;s:44:\"Spigen and Chinense GaN Fast Charger Testing\";i:2;s:40:\"Sample Charger Testing @Mysore Shyam Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704355274,'CREATE',16,'execution'),
(2858,563,32,'GUI - Test Project ID : 134','string \'show_calendar\' is not localized for locale \'en_US\' ',1704355288,'LOCALIZATION',0,NULL),
(2859,564,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/search/searchCommands.class.php - Line 998',1704355288,'PHP',0,NULL),
(2860,565,2,'GUI - Test Project ID : 134','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /opt/bitnami/testlink/lib/functions/tlTestPlanMetrics.class.php - Line 1026',1704359166,'PHP',0,NULL),
(2861,566,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_login_failed\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:10:\"172.27.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704359269,'LOGIN_FAILED',1,'users'),
(2862,567,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_login_failed\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:10:\"172.27.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704359279,'LOGIN_FAILED',1,'users'),
(2863,568,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:10:\"172.27.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704359310,'LOGIN',1,'users'),
(2864,569,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_config\' is not localized for locale \'en_US\' ',1704359311,'LOCALIZATION',0,NULL),
(2865,569,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_left_bottom_link\' is not localized for locale \'en_US\' ',1704359311,'LOCALIZATION',0,NULL),
(2866,569,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_right_top_link\' is not localized for locale \'en_US\' ',1704359311,'LOCALIZATION',0,NULL),
(2867,569,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_right_bottom_link\' is not localized for locale \'en_US\' ',1704359311,'LOCALIZATION',0,NULL),
(2868,569,32,'GUI - Test Project ID : 134','string \'poweredBy\' is not localized for locale \'en_US\'  - using en_GB',1704359311,'LOCALIZATION',0,NULL),
(2869,569,32,'GUI - Test Project ID : 134','string \'system_descr\' is not localized for locale \'en_US\'  - using en_GB',1704359311,'LOCALIZATION',0,NULL),
(2870,569,32,'GUI - Test Project ID : 134','string \'href_codetracker_management\' is not localized for locale \'en_US\'  - using en_GB',1704359311,'LOCALIZATION',0,NULL),
(2871,570,32,'GUI - Test Project ID : 134','string \'without_platforms\' is not localized for locale \'en_US\'  - using en_GB',1704359315,'LOCALIZATION',0,NULL),
(2872,570,32,'GUI - Test Project ID : 134','string \'use_latest_exec_on_contex_for_counters\' is not localized for locale \'en_US\'  - using en_GB',1704359315,'LOCALIZATION',0,NULL),
(2873,570,32,'GUI - Test Project ID : 134','string \'use_latest_exec_on_testplan_for_counters\' is not localized for locale \'en_US\'  - using en_GB',1704359315,'LOCALIZATION',0,NULL),
(2874,570,32,'GUI - Test Project ID : 134','string \'exec_tree_counters_logic\' is not localized for locale \'en_US\'  - using en_GB',1704359315,'LOCALIZATION',0,NULL),
(2875,570,32,'GUI - Test Project ID : 134','string \'platforms\' is not localized for locale \'en_US\'  - using en_GB',1704359315,'LOCALIZATION',0,NULL),
(2876,571,32,'GUI - Test Project ID : 134','string \'restAPIExecParameters\' is not localized for locale \'en_US\'  - using en_GB',1704359315,'LOCALIZATION',0,NULL),
(2877,572,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uribase - in /opt/bitnami/testlink/lib/issuetrackerintegration/bugzillaxmlrpcInterface.class.php - Line 65',1704359401,'PHP',0,NULL),
(2878,572,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704359401,'PHP',0,NULL),
(2879,572,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704359401,'PHP',0,NULL),
(2880,572,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704359401,'PHP',0,NULL),
(2881,572,32,'GUI - Test Project ID : 134','string \'issue_subject_tcname\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2882,572,32,'GUI - Test Project ID : 134','string \'issue_subject_tcpathname\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2883,572,32,'GUI - Test Project ID : 134','string \'issue_subject_projectname\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2884,572,32,'GUI - Test Project ID : 134','string \'issue_subject_planname\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2885,572,32,'GUI - Test Project ID : 134','string \'issue_subject_buildname\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2886,572,32,'GUI - Test Project ID : 134','string \'issue_subject_platfname\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2887,572,32,'GUI - Test Project ID : 134','string \'issue_subject_execon\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2888,572,32,'GUI - Test Project ID : 134','string \'add_link_to_tlexec_print_view\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2889,572,32,'GUI - Test Project ID : 134','string \'copy_attachments_from_latest_exec\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2890,572,32,'GUI - Test Project ID : 134','string \'hasNewestVersionMsg\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2891,572,32,'GUI - Test Project ID : 134','string \'partialExecNoAttachmentsWarning\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2892,572,32,'GUI - Test Project ID : 134','string \'partialExecNothingToSave\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2893,572,32,'GUI - Test Project ID : 134','string \'saveStepsForPartialExec\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2894,572,32,'GUI - Test Project ID : 134','string \'updateLinkToLatestTCVersion\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2895,572,32,'GUI - Test Project ID : 134','string \'file_upload_ko\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2896,572,32,'GUI - Test Project ID : 134','string \'pleaseOpenTSuite\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2897,572,32,'GUI - Test Project ID : 134','string \'allowed_files\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2898,572,32,'GUI - Test Project ID : 134','string \'allowed_filenames_regexp\' is not localized for locale \'en_US\'  - using en_GB',1704359401,'LOCALIZATION',0,NULL),
(2899,573,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704359467,'PHP',0,NULL),
(2900,573,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704359467,'PHP',0,NULL),
(2901,573,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704359467,'PHP',0,NULL),
(2902,573,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/8f7d50b23a3ad2636127523615ed9c295157f12b_0.file.inc_exec_show_tc_exec.tpl.php - Line 244',1704359467,'PHP',0,NULL),
(2903,574,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704359572,'PHP',0,NULL),
(2904,574,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704359572,'PHP',0,NULL),
(2905,574,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704359572,'PHP',0,NULL),
(2906,574,32,'GUI - Test Project ID : 134','string \'FILE_UPLOAD_allowed_filenames_regexp\' is not localized for locale \'en_US\'  - using en_GB',1704359572,'LOCALIZATION',0,NULL),
(2907,574,2,'GUI - Test Project ID : 134','In TestRun with testrunid: 17, planid: 137, buildid: 2, testcaseid: 146, Notes: p, Status: http://192.168.0.124:83/ltx.php?item=exec&feature_id=10&build_id=2',1704359572,NULL,0,NULL),
(2908,574,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_exec_saved\";s:6:\"params\";a:3:{i:0;s:7:\"TCGaN-2\";i:1;s:44:\"Spigen and Chinense GaN Fast Charger Testing\";i:2;s:40:\"Sample Charger Testing @Mysore Shyam Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704359572,'CREATE',17,'execution'),
(2909,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359601,'PHP',0,NULL),
(2910,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359601,'PHP',0,NULL),
(2911,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359601,'PHP',0,NULL),
(2912,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359601,'PHP',0,NULL),
(2913,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359601,'PHP',0,NULL),
(2914,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359601,'PHP',0,NULL),
(2915,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359601,'PHP',0,NULL),
(2916,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359601,'PHP',0,NULL),
(2917,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359601,'PHP',0,NULL),
(2918,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359601,'PHP',0,NULL),
(2919,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359601,'PHP',0,NULL),
(2920,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359601,'PHP',0,NULL),
(2921,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359601,'PHP',0,NULL),
(2922,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359601,'PHP',0,NULL),
(2923,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359601,'PHP',0,NULL),
(2924,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359601,'PHP',0,NULL),
(2925,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359601,'PHP',0,NULL),
(2926,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359601,'PHP',0,NULL),
(2927,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359601,'PHP',0,NULL),
(2928,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359601,'PHP',0,NULL),
(2929,575,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359601,'PHP',0,NULL),
(2930,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359604,'PHP',0,NULL),
(2931,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359604,'PHP',0,NULL),
(2932,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359604,'PHP',0,NULL),
(2933,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359604,'PHP',0,NULL),
(2934,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359604,'PHP',0,NULL),
(2935,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359604,'PHP',0,NULL),
(2936,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359604,'PHP',0,NULL),
(2937,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359604,'PHP',0,NULL),
(2938,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359604,'PHP',0,NULL),
(2939,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359604,'PHP',0,NULL),
(2940,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359604,'PHP',0,NULL),
(2941,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359604,'PHP',0,NULL),
(2942,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359604,'PHP',0,NULL),
(2943,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359604,'PHP',0,NULL),
(2944,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359604,'PHP',0,NULL),
(2945,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359604,'PHP',0,NULL),
(2946,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359604,'PHP',0,NULL),
(2947,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359604,'PHP',0,NULL),
(2948,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359604,'PHP',0,NULL),
(2949,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359604,'PHP',0,NULL),
(2950,576,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359604,'PHP',0,NULL),
(2951,577,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359611,'PHP',0,NULL),
(2952,577,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359611,'PHP',0,NULL),
(2953,577,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359611,'PHP',0,NULL),
(2954,577,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359611,'PHP',0,NULL),
(2955,577,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359611,'PHP',0,NULL),
(2956,577,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359611,'PHP',0,NULL),
(2957,577,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359611,'PHP',0,NULL),
(2958,577,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359611,'PHP',0,NULL),
(2959,577,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359611,'PHP',0,NULL),
(2960,577,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359611,'PHP',0,NULL),
(2961,577,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359611,'PHP',0,NULL),
(2962,577,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359611,'PHP',0,NULL),
(2963,577,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359611,'PHP',0,NULL),
(2964,577,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359611,'PHP',0,NULL),
(2965,577,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359611,'PHP',0,NULL),
(2966,578,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359634,'PHP',0,NULL),
(2967,578,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359634,'PHP',0,NULL),
(2968,578,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359634,'PHP',0,NULL),
(2969,578,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359634,'PHP',0,NULL),
(2970,578,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359634,'PHP',0,NULL),
(2971,578,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359634,'PHP',0,NULL),
(2972,578,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359634,'PHP',0,NULL),
(2973,578,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359634,'PHP',0,NULL),
(2974,578,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359634,'PHP',0,NULL),
(2975,578,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359634,'PHP',0,NULL),
(2976,578,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359634,'PHP',0,NULL),
(2977,578,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359634,'PHP',0,NULL),
(2978,578,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359634,'PHP',0,NULL),
(2979,578,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359634,'PHP',0,NULL),
(2980,578,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359634,'PHP',0,NULL),
(2981,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359638,'PHP',0,NULL),
(2982,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359638,'PHP',0,NULL),
(2983,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359638,'PHP',0,NULL),
(2984,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359638,'PHP',0,NULL),
(2985,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359638,'PHP',0,NULL),
(2986,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359638,'PHP',0,NULL),
(2987,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359638,'PHP',0,NULL),
(2988,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359638,'PHP',0,NULL),
(2989,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359638,'PHP',0,NULL),
(2990,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359638,'PHP',0,NULL),
(2991,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359638,'PHP',0,NULL),
(2992,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359638,'PHP',0,NULL),
(2993,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359638,'PHP',0,NULL),
(2994,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359638,'PHP',0,NULL),
(2995,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359638,'PHP',0,NULL),
(2996,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359638,'PHP',0,NULL),
(2997,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359638,'PHP',0,NULL),
(2998,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359638,'PHP',0,NULL),
(2999,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359638,'PHP',0,NULL),
(3000,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359638,'PHP',0,NULL),
(3001,579,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359639,'PHP',0,NULL),
(3002,580,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359648,'PHP',0,NULL),
(3003,580,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359648,'PHP',0,NULL),
(3004,580,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359648,'PHP',0,NULL),
(3005,580,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359648,'PHP',0,NULL),
(3006,580,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359648,'PHP',0,NULL),
(3007,580,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359648,'PHP',0,NULL),
(3008,580,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359648,'PHP',0,NULL),
(3009,580,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359648,'PHP',0,NULL),
(3010,580,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359648,'PHP',0,NULL),
(3011,580,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359648,'PHP',0,NULL),
(3012,580,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359648,'PHP',0,NULL),
(3013,580,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359648,'PHP',0,NULL),
(3014,580,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359648,'PHP',0,NULL),
(3015,580,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359648,'PHP',0,NULL),
(3016,580,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359648,'PHP',0,NULL),
(3017,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359666,'PHP',0,NULL),
(3018,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359666,'PHP',0,NULL),
(3019,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359666,'PHP',0,NULL),
(3020,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359666,'PHP',0,NULL),
(3021,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359666,'PHP',0,NULL),
(3022,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359666,'PHP',0,NULL),
(3023,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359666,'PHP',0,NULL),
(3024,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359666,'PHP',0,NULL),
(3025,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359666,'PHP',0,NULL),
(3026,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359666,'PHP',0,NULL),
(3027,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359666,'PHP',0,NULL),
(3028,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359666,'PHP',0,NULL),
(3029,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359666,'PHP',0,NULL),
(3030,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359666,'PHP',0,NULL),
(3031,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359666,'PHP',0,NULL),
(3032,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359666,'PHP',0,NULL),
(3033,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359666,'PHP',0,NULL),
(3034,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359666,'PHP',0,NULL),
(3035,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359667,'PHP',0,NULL),
(3036,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359667,'PHP',0,NULL),
(3037,581,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359667,'PHP',0,NULL),
(3038,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359671,'PHP',0,NULL),
(3039,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359671,'PHP',0,NULL),
(3040,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359671,'PHP',0,NULL),
(3041,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359671,'PHP',0,NULL),
(3042,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359671,'PHP',0,NULL),
(3043,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359671,'PHP',0,NULL),
(3044,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359671,'PHP',0,NULL),
(3045,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359671,'PHP',0,NULL),
(3046,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359671,'PHP',0,NULL),
(3047,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359671,'PHP',0,NULL),
(3048,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359671,'PHP',0,NULL),
(3049,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359671,'PHP',0,NULL),
(3050,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359671,'PHP',0,NULL),
(3051,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359671,'PHP',0,NULL),
(3052,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359671,'PHP',0,NULL),
(3053,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359671,'PHP',0,NULL),
(3054,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359671,'PHP',0,NULL),
(3055,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359671,'PHP',0,NULL),
(3056,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359671,'PHP',0,NULL),
(3057,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359671,'PHP',0,NULL),
(3058,582,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359671,'PHP',0,NULL),
(3059,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359677,'PHP',0,NULL),
(3060,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359677,'PHP',0,NULL),
(3061,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359677,'PHP',0,NULL),
(3062,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359677,'PHP',0,NULL),
(3063,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359677,'PHP',0,NULL),
(3064,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359677,'PHP',0,NULL),
(3065,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359677,'PHP',0,NULL),
(3066,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359677,'PHP',0,NULL),
(3067,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359677,'PHP',0,NULL),
(3068,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359677,'PHP',0,NULL),
(3069,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359677,'PHP',0,NULL),
(3070,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359677,'PHP',0,NULL),
(3071,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359677,'PHP',0,NULL),
(3072,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359677,'PHP',0,NULL),
(3073,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359677,'PHP',0,NULL),
(3074,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359677,'PHP',0,NULL),
(3075,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359677,'PHP',0,NULL),
(3076,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359677,'PHP',0,NULL),
(3077,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359677,'PHP',0,NULL),
(3078,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359677,'PHP',0,NULL),
(3079,583,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359677,'PHP',0,NULL),
(3080,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359678,'PHP',0,NULL),
(3081,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359678,'PHP',0,NULL),
(3082,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359678,'PHP',0,NULL),
(3083,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359678,'PHP',0,NULL),
(3084,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359678,'PHP',0,NULL),
(3085,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359678,'PHP',0,NULL),
(3086,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359678,'PHP',0,NULL),
(3087,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359678,'PHP',0,NULL),
(3088,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359678,'PHP',0,NULL),
(3089,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359678,'PHP',0,NULL),
(3090,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359678,'PHP',0,NULL),
(3091,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359678,'PHP',0,NULL),
(3092,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359678,'PHP',0,NULL),
(3093,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359678,'PHP',0,NULL),
(3094,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359678,'PHP',0,NULL),
(3095,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359678,'PHP',0,NULL),
(3096,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359678,'PHP',0,NULL),
(3097,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359678,'PHP',0,NULL),
(3098,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359678,'PHP',0,NULL),
(3099,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359678,'PHP',0,NULL),
(3100,584,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359678,'PHP',0,NULL),
(3101,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359701,'PHP',0,NULL),
(3102,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359701,'PHP',0,NULL),
(3103,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359701,'PHP',0,NULL),
(3104,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359701,'PHP',0,NULL),
(3105,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359701,'PHP',0,NULL),
(3106,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359701,'PHP',0,NULL),
(3107,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359701,'PHP',0,NULL),
(3108,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359701,'PHP',0,NULL),
(3109,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359701,'PHP',0,NULL),
(3110,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359701,'PHP',0,NULL),
(3111,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359701,'PHP',0,NULL),
(3112,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359701,'PHP',0,NULL),
(3113,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359701,'PHP',0,NULL),
(3114,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359701,'PHP',0,NULL),
(3115,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359701,'PHP',0,NULL),
(3116,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359701,'PHP',0,NULL),
(3117,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359701,'PHP',0,NULL),
(3118,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359701,'PHP',0,NULL),
(3119,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359701,'PHP',0,NULL),
(3120,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359701,'PHP',0,NULL),
(3121,585,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359701,'PHP',0,NULL),
(3122,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359703,'PHP',0,NULL),
(3123,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359703,'PHP',0,NULL),
(3124,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359703,'PHP',0,NULL),
(3125,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359703,'PHP',0,NULL),
(3126,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359703,'PHP',0,NULL),
(3127,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359703,'PHP',0,NULL),
(3128,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359703,'PHP',0,NULL),
(3129,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359703,'PHP',0,NULL),
(3130,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359703,'PHP',0,NULL),
(3131,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359703,'PHP',0,NULL),
(3132,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359703,'PHP',0,NULL),
(3133,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359703,'PHP',0,NULL),
(3134,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359703,'PHP',0,NULL),
(3135,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359703,'PHP',0,NULL),
(3136,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359703,'PHP',0,NULL),
(3137,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359703,'PHP',0,NULL),
(3138,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359703,'PHP',0,NULL),
(3139,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359703,'PHP',0,NULL),
(3140,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359703,'PHP',0,NULL),
(3141,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359703,'PHP',0,NULL),
(3142,586,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359703,'PHP',0,NULL),
(3143,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359705,'PHP',0,NULL),
(3144,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359705,'PHP',0,NULL),
(3145,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359705,'PHP',0,NULL),
(3146,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359705,'PHP',0,NULL),
(3147,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359705,'PHP',0,NULL),
(3148,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359705,'PHP',0,NULL),
(3149,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359705,'PHP',0,NULL),
(3150,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359705,'PHP',0,NULL),
(3151,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359705,'PHP',0,NULL),
(3152,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359705,'PHP',0,NULL),
(3153,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359705,'PHP',0,NULL),
(3154,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359705,'PHP',0,NULL),
(3155,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359705,'PHP',0,NULL),
(3156,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359705,'PHP',0,NULL),
(3157,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359705,'PHP',0,NULL),
(3158,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359705,'PHP',0,NULL),
(3159,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359705,'PHP',0,NULL),
(3160,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359705,'PHP',0,NULL),
(3161,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359705,'PHP',0,NULL),
(3162,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359705,'PHP',0,NULL),
(3163,587,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359705,'PHP',0,NULL),
(3164,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359706,'PHP',0,NULL),
(3165,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359706,'PHP',0,NULL),
(3166,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359706,'PHP',0,NULL),
(3167,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359706,'PHP',0,NULL),
(3168,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359706,'PHP',0,NULL),
(3169,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359706,'PHP',0,NULL),
(3170,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359706,'PHP',0,NULL),
(3171,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359706,'PHP',0,NULL),
(3172,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359706,'PHP',0,NULL),
(3173,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359706,'PHP',0,NULL),
(3174,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359706,'PHP',0,NULL),
(3175,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359706,'PHP',0,NULL),
(3176,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359706,'PHP',0,NULL),
(3177,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359706,'PHP',0,NULL),
(3178,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359706,'PHP',0,NULL),
(3179,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359706,'PHP',0,NULL),
(3180,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359706,'PHP',0,NULL),
(3181,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359706,'PHP',0,NULL),
(3182,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359706,'PHP',0,NULL),
(3183,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359706,'PHP',0,NULL),
(3184,588,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359706,'PHP',0,NULL),
(3185,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359706,'PHP',0,NULL),
(3186,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359706,'PHP',0,NULL),
(3187,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359706,'PHP',0,NULL),
(3188,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 1 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359706,'PHP',0,NULL),
(3189,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359706,'PHP',0,NULL),
(3190,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359706,'PHP',0,NULL),
(3191,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359706,'PHP',0,NULL),
(3192,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 2 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359706,'PHP',0,NULL),
(3193,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359706,'PHP',0,NULL),
(3194,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359706,'PHP',0,NULL),
(3195,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359706,'PHP',0,NULL),
(3196,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 3 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359706,'PHP',0,NULL),
(3197,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359706,'PHP',0,NULL),
(3198,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359706,'PHP',0,NULL),
(3199,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359706,'PHP',0,NULL),
(3200,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 4 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359706,'PHP',0,NULL),
(3201,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359706,'PHP',0,NULL),
(3202,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 45',1704359706,'PHP',0,NULL),
(3203,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 46',1704359706,'PHP',0,NULL),
(3204,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined offset: 5 - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 47',1704359706,'PHP',0,NULL),
(3205,589,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: uploadOP - in /opt/bitnami/testlink/lib/attachments/attachmentupload.php - Line 60',1704359706,'PHP',0,NULL),
(3206,590,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704359709,'PHP',0,NULL),
(3207,590,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704359709,'PHP',0,NULL),
(3208,590,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704359709,'PHP',0,NULL),
(3209,591,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704359725,'PHP',0,NULL),
(3210,591,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704359725,'PHP',0,NULL),
(3211,591,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704359725,'PHP',0,NULL),
(3212,592,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704359726,'PHP',0,NULL),
(3213,592,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704359726,'PHP',0,NULL),
(3214,592,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704359726,'PHP',0,NULL),
(3215,593,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704359742,'PHP',0,NULL),
(3216,593,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704359742,'PHP',0,NULL),
(3217,593,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704359742,'PHP',0,NULL),
(3218,593,32,'GUI - Test Project ID : 134','string \'FILE_UPLOAD_allowed_files\' is not localized for locale \'en_US\'  - using en_GB',1704359742,'LOCALIZATION',0,NULL),
(3219,593,2,'GUI - Test Project ID : 134','In TestRun with testrunid: 18, planid: 137, buildid: 2, testcaseid: 144, Notes: p, Status: http://192.168.0.124:83/ltx.php?item=exec&feature_id=9&build_id=2',1704359742,NULL,0,NULL),
(3220,593,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_exec_saved\";s:6:\"params\";a:3:{i:0;s:7:\"TCGaN-1\";i:1;s:44:\"Spigen and Chinense GaN Fast Charger Testing\";i:2;s:40:\"Sample Charger Testing @Mysore Shyam Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704359742,'CREATE',18,'execution'),
(3221,594,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704362448,'PHP',0,NULL),
(3222,595,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1704362448,'PHP',0,NULL),
(3223,596,32,'GUI - Test Project ID : 134','string \'img_title_relation_frozen\' is not localized for locale \'en_US\'  - using en_GB',1704362455,'LOCALIZATION',0,NULL),
(3224,596,32,'GUI - Test Project ID : 134','string \'obsolete\' is not localized for locale \'en_US\'  - using en_GB',1704362455,'LOCALIZATION',0,NULL),
(3225,597,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 130',1704362463,'PHP',0,NULL),
(3226,597,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$itemID - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 152',1704362463,'PHP',0,NULL),
(3227,597,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index:  - in /opt/bitnami/testlink/gui/templates_c/5760ab2fbcb6be6f977f78c58e2ad16e85ecd1e3_0.file.planEdit.tpl.php - Line 302',1704362463,'PHP',0,NULL),
(3228,598,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1704362478,'PHP',0,NULL),
(3229,599,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1704362478,'PHP',0,NULL),
(3230,600,32,'GUI - Test Project ID : 134','string \'on_design\' is not localized for locale \'en_US\'  - using en_GB',1704362487,'LOCALIZATION',0,NULL),
(3231,600,32,'GUI - Test Project ID : 134','string \'on_exec\' is not localized for locale \'en_US\'  - using en_GB',1704362487,'LOCALIZATION',0,NULL),
(3232,601,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704363928,'PHP',0,NULL),
(3233,601,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704363928,'PHP',0,NULL),
(3234,601,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704363928,'PHP',0,NULL),
(3235,602,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuetype - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704363933,'PHP',0,NULL),
(3236,602,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$issuepriority - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1641',1704363933,'PHP',0,NULL),
(3237,602,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$component - in /opt/bitnami/testlink/lib/execute/execSetResults.php - Line 1649',1704363933,'PHP',0,NULL),
(3238,602,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_exec_deleted\";s:6:\"params\";a:3:{i:0;s:7:\"TCGaN-1\";i:1;s:44:\"Spigen and Chinense GaN Fast Charger Testing\";i:2;s:40:\"Sample Charger Testing @Mysore Shyam Lab\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1704363933,'DELETE',18,'execution'),
(3239,603,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:30:\"v.bhavana@Kaynestechnology.net\";i:1;s:10:\"172.27.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1705037423,'LOGIN',3,'users'),
(3240,604,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_config\' is not localized for locale \'en_US\' ',1705037424,'LOCALIZATION',0,NULL),
(3241,604,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_left_bottom_link\' is not localized for locale \'en_US\' ',1705037424,'LOCALIZATION',0,NULL),
(3242,604,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_right_top_link\' is not localized for locale \'en_US\' ',1705037424,'LOCALIZATION',0,NULL),
(3243,604,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_right_bottom_link\' is not localized for locale \'en_US\' ',1705037424,'LOCALIZATION',0,NULL),
(3244,604,32,'GUI - Test Project ID : 134','string \'poweredBy\' is not localized for locale \'en_US\'  - using en_GB',1705037424,'LOCALIZATION',0,NULL),
(3245,604,32,'GUI - Test Project ID : 134','string \'system_descr\' is not localized for locale \'en_US\'  - using en_GB',1705037424,'LOCALIZATION',0,NULL),
(3246,604,32,'GUI - Test Project ID : 134','string \'href_codetracker_management\' is not localized for locale \'en_US\'  - using en_GB',1705037424,'LOCALIZATION',0,NULL),
(3247,605,32,'GUI - Test Project ID : 134','string \'without_platforms\' is not localized for locale \'en_US\'  - using en_GB',1705037472,'LOCALIZATION',0,NULL),
(3248,605,32,'GUI - Test Project ID : 134','string \'exec_tree_counters_logic\' is not localized for locale \'en_US\'  - using en_GB',1705037472,'LOCALIZATION',0,NULL),
(3249,605,32,'GUI - Test Project ID : 134','string \'platforms\' is not localized for locale \'en_US\'  - using en_GB',1705037472,'LOCALIZATION',0,NULL),
(3250,605,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1705037472,'PHP',0,NULL),
(3251,606,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 705',1705037705,'PHP',0,NULL),
(3252,606,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 710',1705037705,'PHP',0,NULL),
(3253,606,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 747',1705037705,'PHP',0,NULL),
(3254,606,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/specview.php - Line 1164',1705037705,'PHP',0,NULL),
(3255,606,32,'GUI - Test Project ID : 134','string \'note_platform_filter\' is not localized for locale \'en_US\'  - using en_GB',1705037705,'LOCALIZATION',0,NULL),
(3256,607,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:30:\"v.bhavana@Kaynestechnology.net\";i:1;s:10:\"172.27.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1705386265,'LOGIN',3,'users'),
(3257,608,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_config\' is not localized for locale \'en_US\' ',1705386265,'LOCALIZATION',0,NULL),
(3258,608,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_left_bottom_link\' is not localized for locale \'en_US\' ',1705386265,'LOCALIZATION',0,NULL),
(3259,608,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_right_top_link\' is not localized for locale \'en_US\' ',1705386265,'LOCALIZATION',0,NULL),
(3260,608,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_right_bottom_link\' is not localized for locale \'en_US\' ',1705386265,'LOCALIZATION',0,NULL),
(3261,608,32,'GUI - Test Project ID : 134','string \'poweredBy\' is not localized for locale \'en_US\'  - using en_GB',1705386265,'LOCALIZATION',0,NULL),
(3262,608,32,'GUI - Test Project ID : 134','string \'system_descr\' is not localized for locale \'en_US\'  - using en_GB',1705386265,'LOCALIZATION',0,NULL),
(3263,608,32,'GUI - Test Project ID : 134','string \'href_codetracker_management\' is not localized for locale \'en_US\'  - using en_GB',1705386265,'LOCALIZATION',0,NULL),
(3264,609,32,'GUI - Test Project ID : 134','string \'without_platforms\' is not localized for locale \'en_US\'  - using en_GB',1705386360,'LOCALIZATION',0,NULL),
(3265,609,32,'GUI - Test Project ID : 134','string \'exec_tree_counters_logic\' is not localized for locale \'en_US\'  - using en_GB',1705386360,'LOCALIZATION',0,NULL),
(3266,609,32,'GUI - Test Project ID : 134','string \'platforms\' is not localized for locale \'en_US\'  - using en_GB',1705386360,'LOCALIZATION',0,NULL),
(3267,609,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1705386360,'PHP',0,NULL),
(3268,610,32,'GUI - Test Project ID : 134','string \'file_upload_ko\' is not localized for locale \'en_US\'  - using en_GB',1705386360,'LOCALIZATION',0,NULL),
(3269,610,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1705386360,'PHP',0,NULL),
(3270,610,32,'GUI - Test Project ID : 134','string \'allowed_files\' is not localized for locale \'en_US\'  - using en_GB',1705386360,'LOCALIZATION',0,NULL),
(3271,610,32,'GUI - Test Project ID : 134','string \'allowed_filenames_regexp\' is not localized for locale \'en_US\'  - using en_GB',1705386360,'LOCALIZATION',0,NULL),
(3272,611,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1705387107,'PHP',0,NULL),
(3273,612,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_testsuite_display_message\' is not localized for locale \'en_US\' ',1705387176,'LOCALIZATION',0,NULL),
(3274,612,2,'GUI - Test Project ID : 134','Im in testsuite create',1705387176,NULL,0,NULL),
(3275,613,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1705387176,'PHP',0,NULL),
(3276,614,32,'GUI - Test Project ID : 134','string \'btn_add_to_testsuites_deep\' is not localized for locale \'en_US\'  - using en_GB',1705387181,'LOCALIZATION',0,NULL),
(3277,614,32,'GUI - Test Project ID : 134','string \'select_keywords\' is not localized for locale \'en_US\'  - using en_GB',1705387181,'LOCALIZATION',0,NULL),
(3278,615,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/testcase.class.php - Line 5361',1705387185,'PHP',0,NULL),
(3279,616,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/testcase.class.php - Line 5361',1705387330,'PHP',0,NULL),
(3280,616,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/tree.class.php - Line 725',1705387330,'PHP',0,NULL),
(3281,616,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/tree.class.php - Line 725',1705387330,'PHP',0,NULL),
(3282,616,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1705387330,'PHP',0,NULL),
(3283,616,32,'GUI - Test Project ID : 134','string \'updateLinkToThisTCVersion\' is not localized for locale \'en_US\'  - using en_GB',1705387330,'LOCALIZATION',0,NULL),
(3284,616,32,'GUI - Test Project ID : 134','string \'btn_new_version_from_latest\' is not localized for locale \'en_US\'  - using en_GB',1705387330,'LOCALIZATION',0,NULL),
(3285,616,32,'GUI - Test Project ID : 134','string \'code_mgmt\' is not localized for locale \'en_US\'  - using en_GB',1705387330,'LOCALIZATION',0,NULL),
(3286,616,32,'GUI - Test Project ID : 134','string \'code_link_tl_to_cts\' is not localized for locale \'en_US\'  - using en_GB',1705387330,'LOCALIZATION',0,NULL),
(3287,616,32,'GUI - Test Project ID : 134','string \'can_not_edit_frozen_tc\' is not localized for locale \'en_US\'  - using en_GB',1705387330,'LOCALIZATION',0,NULL),
(3288,616,32,'GUI - Test Project ID : 134','string \'testcase_version_operations\' is not localized for locale \'en_US\'  - using en_GB',1705387330,'LOCALIZATION',0,NULL),
(3289,616,32,'GUI - Test Project ID : 134','string \'createKW\' is not localized for locale \'en_US\'  - using en_GB',1705387330,'LOCALIZATION',0,NULL),
(3290,616,32,'GUI - Test Project ID : 134','string \'btn_create_and_link\' is not localized for locale \'en_US\'  - using en_GB',1705387330,'LOCALIZATION',0,NULL),
(3291,616,32,'GUI - Test Project ID : 134','string \'img_title_remove_platform\' is not localized for locale \'en_US\' ',1705387330,'LOCALIZATION',0,NULL),
(3292,616,32,'GUI - Test Project ID : 134','string \'select_platforms\' is not localized for locale \'en_US\'  - using en_GB',1705387330,'LOCALIZATION',0,NULL),
(3293,616,32,'GUI - Test Project ID : 134','string \'remove_plat_msgbox_msg\' is not localized for locale \'en_US\' ',1705387330,'LOCALIZATION',0,NULL),
(3294,616,32,'GUI - Test Project ID : 134','string \'remove_plat_msgbox_title\' is not localized for locale \'en_US\' ',1705387330,'LOCALIZATION',0,NULL),
(3295,616,32,'GUI - Test Project ID : 134','string \'can_not_delete_a_frozen_relation\' is not localized for locale \'en_US\'  - using en_GB',1705387330,'LOCALIZATION',0,NULL),
(3296,616,32,'GUI - Test Project ID : 134','string \'can_not_delete_relation_frozen_tc\' is not localized for locale \'en_US\'  - using en_GB',1705387330,'LOCALIZATION',0,NULL),
(3297,616,32,'GUI - Test Project ID : 134','string \'can_not_delete_relation_because_this_is_not_the_latest\' is not localized for locale \'en_US\'  - using en_GB',1705387330,'LOCALIZATION',0,NULL),
(3298,616,32,'GUI - Test Project ID : 134','string \'this_tcversion\' is not localized for locale \'en_US\'  - using en_GB',1705387330,'LOCALIZATION',0,NULL),
(3299,616,32,'GUI - Test Project ID : 134','string \'can_not_delete_relation_tcversion_frozen\' is not localized for locale \'en_US\'  - using en_GB',1705387330,'LOCALIZATION',0,NULL),
(3300,616,32,'GUI - Test Project ID : 134','string \'can_not_delete_relation_related_tcversion_frozen\' is not localized for locale \'en_US\'  - using en_GB',1705387330,'LOCALIZATION',0,NULL),
(3301,617,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1705387330,'PHP',0,NULL),
(3302,618,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/67b7c3539c41dafa6cbe92bcc071ac342a645830_0.file.inc_tcbody.tpl.php - Line 119',1705387335,'PHP',0,NULL),
(3303,619,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/gui/templates_c/67b7c3539c41dafa6cbe92bcc071ac342a645830_0.file.inc_tcbody.tpl.php - Line 119',1705387381,'PHP',0,NULL),
(3304,620,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1705387384,'PHP',0,NULL),
(3305,621,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/testcase.class.php - Line 5361',1705387432,'PHP',0,NULL),
(3306,621,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1705387432,'PHP',0,NULL),
(3307,622,2,'GUI - Test Project ID : 134','E_NOTICE\nTrying to access array offset on value of type null - in /opt/bitnami/testlink/lib/functions/testcase.class.php - Line 5361',1705389565,'PHP',0,NULL),
(3308,623,32,'GUI - Test Project ID : 134','string \'skip_testcase_import\' is not localized for locale \'en_US\'  - using en_GB',1705389740,'LOCALIZATION',0,NULL),
(3309,624,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1705467385,'PHP',0,NULL),
(3310,625,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1705467386,'PHP',0,NULL),
(3311,626,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1705467442,'PHP',0,NULL),
(3312,627,32,'GUI - Test Project ID : 134','string \'force_frozen_testcases_versions\' is not localized for locale \'en_US\'  - using en_GB',1705467458,'LOCALIZATION',0,NULL),
(3313,628,1,'GUI - Test Project ID : 134','Argument \"edit\" has invalid value: ',1705467463,NULL,0,NULL),
(3314,629,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1705467501,'PHP',0,NULL),
(3315,630,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:30:\"v.bhavana@Kaynestechnology.net\";i:1;s:10:\"172.27.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1705898943,'LOGIN',3,'users'),
(3316,631,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_config\' is not localized for locale \'en_US\' ',1705898943,'LOCALIZATION',0,NULL),
(3317,631,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_left_bottom_link\' is not localized for locale \'en_US\' ',1705898943,'LOCALIZATION',0,NULL),
(3318,631,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_right_top_link\' is not localized for locale \'en_US\' ',1705898943,'LOCALIZATION',0,NULL),
(3319,631,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_right_bottom_link\' is not localized for locale \'en_US\' ',1705898943,'LOCALIZATION',0,NULL),
(3320,631,32,'GUI - Test Project ID : 134','string \'poweredBy\' is not localized for locale \'en_US\'  - using en_GB',1705898943,'LOCALIZATION',0,NULL),
(3321,631,32,'GUI - Test Project ID : 134','string \'system_descr\' is not localized for locale \'en_US\'  - using en_GB',1705898943,'LOCALIZATION',0,NULL),
(3322,631,32,'GUI - Test Project ID : 134','string \'href_codetracker_management\' is not localized for locale \'en_US\'  - using en_GB',1705898943,'LOCALIZATION',0,NULL),
(3323,632,16,'GUI - Test Project ID : 134','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:10:\"172.27.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1705988162,'LOGIN',1,'users'),
(3324,633,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_config\' is not localized for locale \'en_US\' ',1705988162,'LOCALIZATION',0,NULL),
(3325,633,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_left_bottom_link\' is not localized for locale \'en_US\' ',1705988162,'LOCALIZATION',0,NULL),
(3326,633,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_right_top_link\' is not localized for locale \'en_US\' ',1705988162,'LOCALIZATION',0,NULL),
(3327,633,32,'GUI - Test Project ID : 134','string \'plugin_TLTest_right_bottom_link\' is not localized for locale \'en_US\' ',1705988162,'LOCALIZATION',0,NULL),
(3328,633,32,'GUI - Test Project ID : 134','string \'poweredBy\' is not localized for locale \'en_US\'  - using en_GB',1705988162,'LOCALIZATION',0,NULL),
(3329,633,32,'GUI - Test Project ID : 134','string \'system_descr\' is not localized for locale \'en_US\'  - using en_GB',1705988162,'LOCALIZATION',0,NULL),
(3330,633,32,'GUI - Test Project ID : 134','string \'href_codetracker_management\' is not localized for locale \'en_US\'  - using en_GB',1705988162,'LOCALIZATION',0,NULL),
(3331,634,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined variable: user - in /opt/bitnami/testlink/lib/functions/common.php - Line 1925',1705988177,'PHP',0,NULL),
(3332,635,32,'GUI - Test Project ID : 134','string \'expiration\' is not localized for locale \'en_US\'  - using en_GB',1705988181,'LOCALIZATION',0,NULL),
(3333,635,32,'GUI - Test Project ID : 134','string \'expiration_date\' is not localized for locale \'en_US\'  - using en_GB',1705988181,'LOCALIZATION',0,NULL),
(3334,636,32,'GUI - Test Project ID : 134','string \'without_platforms\' is not localized for locale \'en_US\'  - using en_GB',1705988191,'LOCALIZATION',0,NULL),
(3335,636,32,'GUI - Test Project ID : 134','string \'use_latest_exec_on_contex_for_counters\' is not localized for locale \'en_US\'  - using en_GB',1705988191,'LOCALIZATION',0,NULL),
(3336,636,32,'GUI - Test Project ID : 134','string \'use_latest_exec_on_testplan_for_counters\' is not localized for locale \'en_US\'  - using en_GB',1705988191,'LOCALIZATION',0,NULL),
(3337,636,32,'GUI - Test Project ID : 134','string \'exec_tree_counters_logic\' is not localized for locale \'en_US\'  - using en_GB',1705988191,'LOCALIZATION',0,NULL),
(3338,636,32,'GUI - Test Project ID : 134','string \'platforms\' is not localized for locale \'en_US\'  - using en_GB',1705988191,'LOCALIZATION',0,NULL),
(3339,637,32,'GUI - Test Project ID : 134','string \'restAPIExecParameters\' is not localized for locale \'en_US\'  - using en_GB',1705988191,'LOCALIZATION',0,NULL),
(3340,638,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined index: size - in /opt/bitnami/testlink/gui/templates_c/12a82239248d9e8bd2a95f9018e8967b73321817_0.file.inc_filter_panel.tpl.php - Line 351',1705988194,'PHP',0,NULL),
(3341,639,32,'GUI - Test Project ID : 134','string \'file_upload_ko\' is not localized for locale \'en_US\'  - using en_GB',1705988194,'LOCALIZATION',0,NULL),
(3342,639,2,'GUI - Test Project ID : 134','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /opt/bitnami/testlink/gui/templates_c/a826a56ec1cd6f3a879499ad99bfecc2df857da3_0.file.containerView.tpl.php - Line 123',1705988194,'PHP',0,NULL),
(3343,639,32,'GUI - Test Project ID : 134','string \'allowed_files\' is not localized for locale \'en_US\'  - using en_GB',1705988194,'LOCALIZATION',0,NULL),
(3344,639,32,'GUI - Test Project ID : 134','string \'allowed_filenames_regexp\' is not localized for locale \'en_US\'  - using en_GB',1705988194,'LOCALIZATION',0,NULL);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `exec_by_date_time`
--

DROP TABLE IF EXISTS `exec_by_date_time`;
/*!50001 DROP VIEW IF EXISTS `exec_by_date_time`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `exec_by_date_time` AS SELECT
 1 AS `testplan_name`,
  1 AS `yyyy_mm_dd`,
  1 AS `yyyy_mm`,
  1 AS `hh`,
  1 AS `hour`,
  1 AS `id`,
  1 AS `build_id`,
  1 AS `tester_id`,
  1 AS `execution_ts`,
  1 AS `status`,
  1 AS `testplan_id`,
  1 AS `tcversion_id`,
  1 AS `tcversion_number`,
  1 AS `platform_id`,
  1 AS `execution_type`,
  1 AS `execution_duration`,
  1 AS `notes` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `execution_bugs`
--

DROP TABLE IF EXISTS `execution_bugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `execution_bugs` (
  `execution_id` int(10) unsigned NOT NULL DEFAULT 0,
  `bug_id` varchar(64) NOT NULL DEFAULT '0',
  `tcstep_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`execution_id`,`bug_id`,`tcstep_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `execution_bugs`
--

LOCK TABLES `execution_bugs` WRITE;
/*!40000 ALTER TABLE `execution_bugs` DISABLE KEYS */;
/*!40000 ALTER TABLE `execution_bugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `execution_tcsteps`
--

DROP TABLE IF EXISTS `execution_tcsteps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `execution_tcsteps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `execution_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tcstep_id` int(10) unsigned NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `execution_tcsteps_idx1` (`execution_id`,`tcstep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `execution_tcsteps`
--

LOCK TABLES `execution_tcsteps` WRITE;
/*!40000 ALTER TABLE `execution_tcsteps` DISABLE KEYS */;
/*!40000 ALTER TABLE `execution_tcsteps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `execution_tcsteps_wip`
--

DROP TABLE IF EXISTS `execution_tcsteps_wip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `execution_tcsteps_wip` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tcstep_id` int(10) unsigned NOT NULL DEFAULT 0,
  `testplan_id` int(10) unsigned NOT NULL DEFAULT 0,
  `platform_id` int(10) unsigned NOT NULL DEFAULT 0,
  `build_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tester_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `execution_tcsteps_wip_idx1` (`tcstep_id`,`testplan_id`,`platform_id`,`build_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `execution_tcsteps_wip`
--

LOCK TABLES `execution_tcsteps_wip` WRITE;
/*!40000 ALTER TABLE `execution_tcsteps_wip` DISABLE KEYS */;
INSERT INTO `execution_tcsteps_wip` VALUES
(13,128,132,0,1,1,'2023-12-22 06:58:03','not able to charges','f'),
(14,129,132,0,1,1,'2023-12-22 06:58:03','chager','p'),
(15,130,132,0,1,1,'2023-12-22 06:58:03','pass','p'),
(16,131,132,0,1,1,'2023-12-22 06:58:03','working','p');
/*!40000 ALTER TABLE `execution_tcsteps_wip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `executions`
--

DROP TABLE IF EXISTS `executions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `executions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `build_id` int(10) NOT NULL DEFAULT 0,
  `tester_id` int(10) unsigned DEFAULT NULL,
  `execution_ts` datetime DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `testplan_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tcversion_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tcversion_number` smallint(5) unsigned NOT NULL DEFAULT 1,
  `platform_id` int(10) unsigned NOT NULL DEFAULT 0,
  `execution_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 -> manual, 2 -> automated',
  `execution_duration` decimal(6,2) DEFAULT NULL COMMENT 'NULL will be considered as NO DATA Provided by user',
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `executions_idx1` (`testplan_id`,`tcversion_id`,`platform_id`,`build_id`),
  KEY `executions_idx2` (`execution_type`),
  KEY `executions_idx3` (`tcversion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `executions`
--

LOCK TABLES `executions` WRITE;
/*!40000 ALTER TABLE `executions` DISABLE KEYS */;
INSERT INTO `executions` VALUES
(16,2,3,'2024-01-04 08:01:14','p',137,145,1,0,1,NULL,''),
(17,2,1,'2024-01-04 09:12:52','p',137,147,1,0,1,NULL,'');
/*!40000 ALTER TABLE `executions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testproject_id` int(10) unsigned NOT NULL,
  `owner_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `ipaddress` varchar(255) NOT NULL,
  `content` text DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `modification_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `inventory_idx1` (`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issuetrackers`
--

DROP TABLE IF EXISTS `issuetrackers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issuetrackers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` int(10) DEFAULT 0,
  `cfg` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `issuetrackers_uidx1` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issuetrackers`
--

LOCK TABLES `issuetrackers` WRITE;
/*!40000 ALTER TABLE `issuetrackers` DISABLE KEYS */;
INSERT INTO `issuetrackers` VALUES
(1,'Bugzilla',1,'<issuetracker>\r\n    <dbhost>localhost:5432</dbhost>\r\n    <dbname>bugs</dbname>\r\n    <dbschema>bugs</dbschema>\r\n    <dbtype>postgres</dbtype>\r\n    <dbuser>bugs</dbuser>\r\n    <dbpassword>bugs</dbpassword>\r\n    <uricreate>localhost/bugzilla/</uricreate>\r\n    <uriview>localhost/bugzilla/show_bug.cgi?id=</uriview>\r\n</issuetracker>');
/*!40000 ALTER TABLE `issuetrackers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keywords`
--

DROP TABLE IF EXISTS `keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keywords` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `keyword` varchar(100) NOT NULL DEFAULT '',
  `testproject_id` int(10) unsigned NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `keyword_testproject_id` (`keyword`,`testproject_id`),
  KEY `testproject_id` (`testproject_id`),
  KEY `keyword` (`keyword`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keywords`
--

LOCK TABLES `keywords` WRITE;
/*!40000 ALTER TABLE `keywords` DISABLE KEYS */;
/*!40000 ALTER TABLE `keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `latest_exec_by_context`
--

DROP TABLE IF EXISTS `latest_exec_by_context`;
/*!50001 DROP VIEW IF EXISTS `latest_exec_by_context`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `latest_exec_by_context` AS SELECT
 1 AS `tcversion_id`,
  1 AS `testplan_id`,
  1 AS `build_id`,
  1 AS `platform_id`,
  1 AS `id` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `latest_exec_by_testplan`
--

DROP TABLE IF EXISTS `latest_exec_by_testplan`;
/*!50001 DROP VIEW IF EXISTS `latest_exec_by_testplan`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `latest_exec_by_testplan` AS SELECT
 1 AS `tcversion_id`,
  1 AS `testplan_id`,
  1 AS `id` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `latest_exec_by_testplan_plat`
--

DROP TABLE IF EXISTS `latest_exec_by_testplan_plat`;
/*!50001 DROP VIEW IF EXISTS `latest_exec_by_testplan_plat`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `latest_exec_by_testplan_plat` AS SELECT
 1 AS `tcversion_id`,
  1 AS `testplan_id`,
  1 AS `platform_id`,
  1 AS `id` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `latest_req_version`
--

DROP TABLE IF EXISTS `latest_req_version`;
/*!50001 DROP VIEW IF EXISTS `latest_req_version`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `latest_req_version` AS SELECT
 1 AS `req_id`,
  1 AS `version` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `latest_req_version_id`
--

DROP TABLE IF EXISTS `latest_req_version_id`;
/*!50001 DROP VIEW IF EXISTS `latest_req_version_id`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `latest_req_version_id` AS SELECT
 1 AS `req_id`,
  1 AS `version`,
  1 AS `req_version_id` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `latest_rspec_revision`
--

DROP TABLE IF EXISTS `latest_rspec_revision`;
/*!50001 DROP VIEW IF EXISTS `latest_rspec_revision`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `latest_rspec_revision` AS SELECT
 1 AS `req_spec_id`,
  1 AS `testproject_id`,
  1 AS `revision` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `latest_tcase_version_id`
--

DROP TABLE IF EXISTS `latest_tcase_version_id`;
/*!50001 DROP VIEW IF EXISTS `latest_tcase_version_id`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `latest_tcase_version_id` AS SELECT
 1 AS `testcase_id`,
  1 AS `version`,
  1 AS `tcversion_id` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `latest_tcase_version_number`
--

DROP TABLE IF EXISTS `latest_tcase_version_number`;
/*!50001 DROP VIEW IF EXISTS `latest_tcase_version_number`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `latest_tcase_version_number` AS SELECT
 1 AS `testcase_id`,
  1 AS `version` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `milestones`
--

DROP TABLE IF EXISTS `milestones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `milestones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) unsigned NOT NULL DEFAULT 0,
  `target_date` date NOT NULL,
  `start_date` date DEFAULT NULL,
  `a` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `b` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `c` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT 'undefined',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_testplan_id` (`name`,`testplan_id`),
  KEY `testplan_id` (`testplan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `milestones`
--

LOCK TABLES `milestones` WRITE;
/*!40000 ALTER TABLE `milestones` DISABLE KEYS */;
/*!40000 ALTER TABLE `milestones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_types`
--

DROP TABLE IF EXISTS `node_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL DEFAULT 'testproject',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_types`
--

LOCK TABLES `node_types` WRITE;
/*!40000 ALTER TABLE `node_types` DISABLE KEYS */;
INSERT INTO `node_types` VALUES
(1,'testproject'),
(2,'testsuite'),
(3,'testcase'),
(4,'testcase_version'),
(5,'testplan'),
(6,'requirement_spec'),
(7,'requirement'),
(8,'requirement_version'),
(9,'testcase_step'),
(10,'requirement_revision'),
(11,'requirement_spec_revision'),
(12,'build'),
(13,'platform'),
(14,'user');
/*!40000 ALTER TABLE `node_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nodes_hierarchy`
--

DROP TABLE IF EXISTS `nodes_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nodes_hierarchy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `node_type_id` int(10) unsigned NOT NULL DEFAULT 1,
  `node_order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid_m_nodeorder` (`parent_id`,`node_order`),
  KEY `nodes_hierarchy_node_type_id` (`node_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nodes_hierarchy`
--

LOCK TABLES `nodes_hierarchy` WRITE;
/*!40000 ALTER TABLE `nodes_hierarchy` DISABLE KEYS */;
INSERT INTO `nodes_hierarchy` VALUES
(134,'GaN Charger',NULL,1,1),
(137,'Sample Charger Testing @Mysore Shyam Lab',134,5,0),
(138,'Sample charger Testing',134,6,1),
(139,'Charger Testing',138,11,0),
(140,'Sample charger Testing',138,11,0),
(141,'Test Spigen and Chinese GaN charger',138,7,1),
(142,'',141,8,0),
(143,'Sample Charger Test Suite',134,2,1),
(144,'Long Regulation testing',143,3,1000),
(145,'',144,4,0),
(146,'Line Regulation Testing',143,3,1001),
(147,'',146,4,0),
(148,'Charger Test Scenarios',134,2,2),
(149,'Output Power',148,3,1000),
(150,'',149,4,0),
(151,'',150,9,0);
/*!40000 ALTER TABLE `nodes_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object_keywords`
--

DROP TABLE IF EXISTS `object_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_keywords` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_id` int(10) unsigned NOT NULL DEFAULT 0,
  `fk_table` varchar(30) DEFAULT '',
  `keyword_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx01_object_keywords` (`fk_id`,`fk_table`,`keyword_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_keywords`
--

LOCK TABLES `object_keywords` WRITE;
/*!40000 ALTER TABLE `object_keywords` DISABLE KEYS */;
/*!40000 ALTER TABLE `object_keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platforms`
--

DROP TABLE IF EXISTS `platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `platforms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `testproject_id` int(10) unsigned NOT NULL,
  `notes` text NOT NULL,
  `enable_on_design` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `enable_on_execution` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_platforms` (`testproject_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platforms`
--

LOCK TABLES `platforms` WRITE;
/*!40000 ALTER TABLE `platforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `platforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basename` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
INSERT INTO `plugins` VALUES
(1,'TLTest',1,NULL,'2023-12-21 04:31:52');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugins_configuration`
--

DROP TABLE IF EXISTS `plugins_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `testproject_id` int(11) NOT NULL,
  `config_key` varchar(255) NOT NULL,
  `config_type` int(11) NOT NULL,
  `config_value` varchar(255) NOT NULL,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugins_configuration`
--

LOCK TABLES `plugins_configuration` WRITE;
/*!40000 ALTER TABLE `plugins_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugins_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `req_coverage`
--

DROP TABLE IF EXISTS `req_coverage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `req_coverage` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `req_id` int(10) NOT NULL,
  `req_version_id` int(10) NOT NULL,
  `testcase_id` int(10) NOT NULL,
  `tcversion_id` int(10) NOT NULL,
  `link_status` int(11) NOT NULL DEFAULT 1,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `review_requester_id` int(10) unsigned DEFAULT NULL,
  `review_request_ts` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `req_coverage_full_link` (`req_id`,`req_version_id`,`testcase_id`,`tcversion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='relation test case version ** requirement version';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `req_coverage`
--

LOCK TABLES `req_coverage` WRITE;
/*!40000 ALTER TABLE `req_coverage` DISABLE KEYS */;
/*!40000 ALTER TABLE `req_coverage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `req_monitor`
--

DROP TABLE IF EXISTS `req_monitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `req_monitor` (
  `req_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `testproject_id` int(11) NOT NULL,
  PRIMARY KEY (`req_id`,`user_id`,`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `req_monitor`
--

LOCK TABLES `req_monitor` WRITE;
/*!40000 ALTER TABLE `req_monitor` DISABLE KEYS */;
/*!40000 ALTER TABLE `req_monitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `req_relations`
--

DROP TABLE IF EXISTS `req_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `req_relations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source_id` int(10) unsigned NOT NULL,
  `destination_id` int(10) unsigned NOT NULL,
  `relation_type` smallint(5) unsigned NOT NULL DEFAULT 1,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `req_relations`
--

LOCK TABLES `req_relations` WRITE;
/*!40000 ALTER TABLE `req_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `req_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `req_revisions`
--

DROP TABLE IF EXISTS `req_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `req_revisions` (
  `parent_id` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL,
  `revision` smallint(5) unsigned NOT NULL DEFAULT 1,
  `req_doc_id` varchar(64) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `scope` text DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT 'V',
  `type` char(1) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `expected_coverage` int(10) NOT NULL DEFAULT 1,
  `log_message` text DEFAULT NULL,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `modifier_id` int(10) unsigned DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `req_revisions_uidx1` (`parent_id`,`revision`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `req_revisions`
--

LOCK TABLES `req_revisions` WRITE;
/*!40000 ALTER TABLE `req_revisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `req_revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `req_specs`
--

DROP TABLE IF EXISTS `req_specs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `req_specs` (
  `id` int(10) unsigned NOT NULL,
  `testproject_id` int(10) unsigned NOT NULL,
  `doc_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `req_spec_uk1` (`doc_id`,`testproject_id`),
  KEY `testproject_id` (`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Dev. Documents (e.g. System Requirements Specification)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `req_specs`
--

LOCK TABLES `req_specs` WRITE;
/*!40000 ALTER TABLE `req_specs` DISABLE KEYS */;
INSERT INTO `req_specs` VALUES
(138,134,'Requirment 001');
/*!40000 ALTER TABLE `req_specs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `req_specs_revisions`
--

DROP TABLE IF EXISTS `req_specs_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `req_specs_revisions` (
  `parent_id` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL,
  `revision` smallint(5) unsigned NOT NULL DEFAULT 1,
  `doc_id` varchar(64) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `scope` text DEFAULT NULL,
  `total_req` int(10) NOT NULL DEFAULT 0,
  `status` int(10) unsigned DEFAULT 1,
  `type` char(1) DEFAULT NULL,
  `log_message` text DEFAULT NULL,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `modifier_id` int(10) unsigned DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `req_specs_revisions_uidx1` (`parent_id`,`revision`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `req_specs_revisions`
--

LOCK TABLES `req_specs_revisions` WRITE;
/*!40000 ALTER TABLE `req_specs_revisions` DISABLE KEYS */;
INSERT INTO `req_specs_revisions` VALUES
(138,139,1,'GaN001','Charger Testing','',0,1,'1','Requirement Specification Created',3,'2024-01-02 06:50:23',NULL,'2024-01-02 06:50:23'),
(138,140,2,'Requirment 001','Sample charger Testing','',0,1,'1','',3,'2024-01-02 06:52:02',NULL,'2024-01-02 06:52:02');
/*!40000 ALTER TABLE `req_specs_revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `req_versions`
--

DROP TABLE IF EXISTS `req_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `req_versions` (
  `id` int(10) unsigned NOT NULL,
  `version` smallint(5) unsigned NOT NULL DEFAULT 1,
  `revision` smallint(5) unsigned NOT NULL DEFAULT 1,
  `scope` text DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT 'V',
  `type` char(1) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `expected_coverage` int(10) NOT NULL DEFAULT 1,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `modifier_id` int(10) unsigned DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT current_timestamp(),
  `log_message` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `req_versions`
--

LOCK TABLES `req_versions` WRITE;
/*!40000 ALTER TABLE `req_versions` DISABLE KEYS */;
INSERT INTO `req_versions` VALUES
(142,1,1,'<p>Test Spigen and Chinese GaN Fast charger @Mysore Shyam Lab</p>','D','3',1,1,20,3,'2024-01-02 07:03:02',NULL,'2024-01-02 07:03:02','Requirement Created');
/*!40000 ALTER TABLE `req_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reqmgrsystems`
--

DROP TABLE IF EXISTS `reqmgrsystems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reqmgrsystems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` int(10) DEFAULT 0,
  `cfg` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reqmgrsystems_uidx1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reqmgrsystems`
--

LOCK TABLES `reqmgrsystems` WRITE;
/*!40000 ALTER TABLE `reqmgrsystems` DISABLE KEYS */;
/*!40000 ALTER TABLE `reqmgrsystems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requirements`
--

DROP TABLE IF EXISTS `requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requirements` (
  `id` int(10) unsigned NOT NULL,
  `srs_id` int(10) unsigned NOT NULL,
  `req_doc_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `requirements_req_doc_id` (`srs_id`,`req_doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requirements`
--

LOCK TABLES `requirements` WRITE;
/*!40000 ALTER TABLE `requirements` DISABLE KEYS */;
INSERT INTO `requirements` VALUES
(141,138,'req 001');
/*!40000 ALTER TABLE `requirements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rights` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `rights_descr` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rights`
--

LOCK TABLES `rights` WRITE;
/*!40000 ALTER TABLE `rights` DISABLE KEYS */;
INSERT INTO `rights` VALUES
(53,'cfield_assignment'),
(18,'cfield_management'),
(17,'cfield_view'),
(51,'codetracker_management'),
(52,'codetracker_view'),
(56,'delete_frozen_tcversion'),
(22,'events_mgt'),
(54,'exec_assign_testcases'),
(36,'exec_delete'),
(35,'exec_edit_notes'),
(49,'exec_ro_access'),
(41,'exec_testcases_assigned_to_me'),
(31,'issuetracker_management'),
(32,'issuetracker_view'),
(29,'keyword_assignment'),
(9,'mgt_modify_key'),
(12,'mgt_modify_product'),
(11,'mgt_modify_req'),
(7,'mgt_modify_tc'),
(48,'mgt_plugins'),
(16,'mgt_testplan_create'),
(30,'mgt_unfreeze_req'),
(13,'mgt_users'),
(20,'mgt_view_events'),
(8,'mgt_view_key'),
(10,'mgt_view_req'),
(6,'mgt_view_tc'),
(21,'mgt_view_usergroups'),
(50,'monitor_requirement'),
(24,'platform_management'),
(25,'platform_view'),
(26,'project_inventory_management'),
(27,'project_inventory_view'),
(33,'reqmgrsystem_management'),
(34,'reqmgrsystem_view'),
(28,'req_tcase_link_management'),
(14,'role_management'),
(19,'system_configuration'),
(47,'testcase_freeze'),
(43,'testplan_add_remove_platforms'),
(2,'testplan_create_build'),
(1,'testplan_execute'),
(3,'testplan_metrics'),
(40,'testplan_milestone_overview'),
(4,'testplan_planning'),
(45,'testplan_set_urgent_testcases'),
(46,'testplan_show_testcases_newest_versions'),
(37,'testplan_unlink_executed_testcases'),
(44,'testplan_update_linked_testcase_versions'),
(5,'testplan_user_role_assignment'),
(55,'testproject_add_remove_keywords_executed_tcversions'),
(38,'testproject_delete_executed_testcases'),
(39,'testproject_edit_executed_testcases'),
(42,'testproject_metrics_dashboard'),
(23,'testproject_user_role_assignment'),
(15,'user_role_assignment');
/*!40000 ALTER TABLE `rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `risk_assignments`
--

DROP TABLE IF EXISTS `risk_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `risk_assignments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) unsigned NOT NULL DEFAULT 0,
  `node_id` int(10) unsigned NOT NULL DEFAULT 0,
  `risk` char(1) NOT NULL DEFAULT '2',
  `importance` char(1) NOT NULL DEFAULT 'M',
  PRIMARY KEY (`id`),
  UNIQUE KEY `risk_assignments_tplan_node_id` (`testplan_id`,`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `risk_assignments`
--

LOCK TABLES `risk_assignments` WRITE;
/*!40000 ALTER TABLE `risk_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `risk_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_rights`
--

DROP TABLE IF EXISTS `role_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_rights` (
  `role_id` int(10) NOT NULL DEFAULT 0,
  `right_id` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`role_id`,`right_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_rights`
--

LOCK TABLES `role_rights` WRITE;
/*!40000 ALTER TABLE `role_rights` DISABLE KEYS */;
INSERT INTO `role_rights` VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,8),
(1,9),
(1,10),
(1,11),
(1,12),
(1,16),
(1,17),
(1,18),
(1,20),
(1,22),
(1,24),
(1,25),
(1,26),
(1,27),
(1,28),
(1,29),
(1,30),
(1,31),
(1,32),
(1,35),
(1,36),
(1,37),
(1,38),
(1,39),
(1,40),
(1,41),
(1,43),
(1,44),
(1,45),
(1,46),
(1,47),
(1,49),
(1,50),
(1,51),
(1,52),
(1,53),
(1,54),
(1,55),
(1,56),
(4,3),
(4,6),
(4,7),
(4,8),
(4,9),
(4,10),
(4,11),
(4,28),
(4,29),
(4,30),
(4,50),
(5,3),
(5,6),
(5,8),
(6,1),
(6,2),
(6,3),
(6,6),
(6,7),
(6,8),
(6,9),
(6,11),
(6,25),
(6,27),
(6,28),
(6,29),
(6,30),
(6,50),
(7,1),
(7,3),
(7,6),
(7,8),
(8,1),
(8,2),
(8,3),
(8,4),
(8,5),
(8,6),
(8,7),
(8,8),
(8,9),
(8,10),
(8,11),
(8,12),
(8,13),
(8,14),
(8,15),
(8,16),
(8,17),
(8,18),
(8,19),
(8,20),
(8,21),
(8,22),
(8,23),
(8,24),
(8,25),
(8,26),
(8,27),
(8,28),
(8,29),
(8,30),
(8,31),
(8,32),
(8,33),
(8,34),
(8,35),
(8,36),
(8,37),
(8,38),
(8,39),
(8,40),
(8,41),
(8,42),
(8,43),
(8,44),
(8,45),
(8,46),
(8,47),
(8,48),
(8,50),
(8,51),
(8,52),
(8,53),
(8,54),
(9,1),
(9,2),
(9,3),
(9,4),
(9,5),
(9,6),
(9,7),
(9,8),
(9,9),
(9,10),
(9,11),
(9,16),
(9,24),
(9,25),
(9,26),
(9,27),
(9,28),
(9,29),
(9,30),
(9,31),
(9,32),
(9,35),
(9,36),
(9,37),
(9,38),
(9,39),
(9,40),
(9,41),
(9,43),
(9,44),
(9,45),
(9,46),
(9,47),
(9,49),
(9,50),
(9,53),
(9,54),
(9,55);
/*!40000 ALTER TABLE `role_rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_rights_roles_descr` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES
(1,'Team admin',''),
(2,'<reserved system role 2>',NULL),
(3,'<no rights>',NULL),
(4,'test designer',NULL),
(5,'guest',NULL),
(6,'senior tester',NULL),
(7,'tester',NULL),
(8,'admin',NULL),
(9,'leader','');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tcsteps`
--

DROP TABLE IF EXISTS `tcsteps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tcsteps` (
  `id` int(10) unsigned NOT NULL,
  `step_number` int(11) NOT NULL DEFAULT 1,
  `actions` text DEFAULT NULL,
  `expected_results` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `execution_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 -> manual, 2 -> automated',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tcsteps`
--

LOCK TABLES `tcsteps` WRITE;
/*!40000 ALTER TABLE `tcsteps` DISABLE KEYS */;
INSERT INTO `tcsteps` VALUES
(151,1,'<p>Click on the Link and follow the Test procedure of the Output Power.</p>\r\n\r\n<p><a href=\"https://writer.zoho.com/writer/open/bwngy397e26220ca7474e834fe358d51faeec\">https://writer.zoho.com/writer/open/bwngy397e26220ca7474e834fe358d51faeec</a></p>\r\n','',1,1);
/*!40000 ALTER TABLE `tcsteps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tcversions`
--

DROP TABLE IF EXISTS `tcversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tcversions` (
  `id` int(10) unsigned NOT NULL,
  `tc_external_id` int(10) unsigned DEFAULT NULL,
  `version` smallint(5) unsigned NOT NULL DEFAULT 1,
  `layout` smallint(5) unsigned NOT NULL DEFAULT 1,
  `status` smallint(5) unsigned NOT NULL DEFAULT 1,
  `summary` text DEFAULT NULL,
  `preconditions` text DEFAULT NULL,
  `importance` smallint(5) unsigned NOT NULL DEFAULT 2,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `updater_id` int(10) unsigned DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT current_timestamp(),
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `execution_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 -> manual, 2 -> automated',
  `estimated_exec_duration` decimal(6,2) DEFAULT NULL COMMENT 'NULL will be considered as NO DATA Provided by user',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tcversions`
--

LOCK TABLES `tcversions` WRITE;
/*!40000 ALTER TABLE `tcversions` DISABLE KEYS */;
INSERT INTO `tcversions` VALUES
(145,1,1,1,7,'','',2,3,'2024-01-02 07:40:54',NULL,'2024-01-02 07:40:54',1,1,1,NULL),
(147,2,1,1,7,'<p>Line Regulation Testing</p>\r\n','<p>Line Regulation Testing</p>\r\n',2,3,'2024-01-02 07:41:35',3,'2024-01-04 04:41:01',1,1,1,360.00),
(150,3,1,1,1,'<p>Verify and measure the ouput power of the charger.&nbsp;</p>\r\n','',2,3,'2024-01-16 06:42:10',3,'2024-01-16 06:43:52',1,1,1,NULL);
/*!40000 ALTER TABLE `tcversions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `tcversions_without_keywords`
--

DROP TABLE IF EXISTS `tcversions_without_keywords`;
/*!50001 DROP VIEW IF EXISTS `tcversions_without_keywords`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `tcversions_without_keywords` AS SELECT
 1 AS `testcase_id`,
  1 AS `id` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `tcversions_without_platforms`
--

DROP TABLE IF EXISTS `tcversions_without_platforms`;
/*!50001 DROP VIEW IF EXISTS `tcversions_without_platforms`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `tcversions_without_platforms` AS SELECT
 1 AS `testcase_id`,
  1 AS `id` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `testcase_keywords`
--

DROP TABLE IF EXISTS `testcase_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testcase_keywords` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testcase_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tcversion_id` int(10) unsigned NOT NULL DEFAULT 0,
  `keyword_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx01_testcase_keywords` (`testcase_id`,`tcversion_id`,`keyword_id`),
  KEY `idx02_testcase_keywords` (`tcversion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testcase_keywords`
--

LOCK TABLES `testcase_keywords` WRITE;
/*!40000 ALTER TABLE `testcase_keywords` DISABLE KEYS */;
/*!40000 ALTER TABLE `testcase_keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testcase_platforms`
--

DROP TABLE IF EXISTS `testcase_platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testcase_platforms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testcase_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tcversion_id` int(10) unsigned NOT NULL DEFAULT 0,
  `platform_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx01_testcase_platform` (`testcase_id`,`tcversion_id`,`platform_id`),
  KEY `idx02_testcase_platform` (`tcversion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testcase_platforms`
--

LOCK TABLES `testcase_platforms` WRITE;
/*!40000 ALTER TABLE `testcase_platforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `testcase_platforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testcase_relations`
--

DROP TABLE IF EXISTS `testcase_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testcase_relations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source_id` int(10) unsigned NOT NULL,
  `destination_id` int(10) unsigned NOT NULL,
  `link_status` tinyint(1) NOT NULL DEFAULT 1,
  `relation_type` smallint(5) unsigned NOT NULL DEFAULT 1,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testcase_relations`
--

LOCK TABLES `testcase_relations` WRITE;
/*!40000 ALTER TABLE `testcase_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `testcase_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testcase_script_links`
--

DROP TABLE IF EXISTS `testcase_script_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testcase_script_links` (
  `tcversion_id` int(10) unsigned NOT NULL DEFAULT 0,
  `project_key` varchar(64) NOT NULL,
  `repository_name` varchar(64) NOT NULL,
  `code_path` varchar(255) NOT NULL,
  `branch_name` varchar(64) DEFAULT NULL,
  `commit_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`tcversion_id`,`project_key`,`repository_name`,`code_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testcase_script_links`
--

LOCK TABLES `testcase_script_links` WRITE;
/*!40000 ALTER TABLE `testcase_script_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `testcase_script_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testplan_platforms`
--

DROP TABLE IF EXISTS `testplan_platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testplan_platforms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) unsigned NOT NULL,
  `platform_id` int(10) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_testplan_platforms` (`testplan_id`,`platform_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Connects a testplan with platforms';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testplan_platforms`
--

LOCK TABLES `testplan_platforms` WRITE;
/*!40000 ALTER TABLE `testplan_platforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `testplan_platforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testplan_tcversions`
--

DROP TABLE IF EXISTS `testplan_tcversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testplan_tcversions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tcversion_id` int(10) unsigned NOT NULL DEFAULT 0,
  `node_order` int(10) unsigned NOT NULL DEFAULT 1,
  `urgency` smallint(5) NOT NULL DEFAULT 2,
  `platform_id` int(10) unsigned NOT NULL DEFAULT 0,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `testplan_tcversions_tplan_tcversion` (`testplan_id`,`tcversion_id`,`platform_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testplan_tcversions`
--

LOCK TABLES `testplan_tcversions` WRITE;
/*!40000 ALTER TABLE `testplan_tcversions` DISABLE KEYS */;
INSERT INTO `testplan_tcversions` VALUES
(9,137,145,10000,2,0,3,'2024-01-04 07:48:29'),
(10,137,147,10010,2,0,3,'2024-01-04 07:48:29');
/*!40000 ALTER TABLE `testplan_tcversions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testplans`
--

DROP TABLE IF EXISTS `testplans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testplans` (
  `id` int(10) unsigned NOT NULL,
  `testproject_id` int(10) unsigned NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `api_key` varchar(64) NOT NULL DEFAULT '829a2ded3ed0829a2dedd8ab81dfa2c77e8235bc3ed0d8ab81dfa2c77e8235bc',
  PRIMARY KEY (`id`),
  UNIQUE KEY `testplans_api_key` (`api_key`),
  KEY `testplans_testproject_id_active` (`testproject_id`,`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testplans`
--

LOCK TABLES `testplans` WRITE;
/*!40000 ALTER TABLE `testplans` DISABLE KEYS */;
INSERT INTO `testplans` VALUES
(137,134,'<p>Object : Test Spigen and Chinese GaN Fast sample chargers.</p>',1,1,1,'108241064f70d41dfd41a4f986056faa4fcff89c5d25469e10deea9b917deca1');
/*!40000 ALTER TABLE `testplans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testproject_codetracker`
--

DROP TABLE IF EXISTS `testproject_codetracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testproject_codetracker` (
  `testproject_id` int(10) unsigned NOT NULL,
  `codetracker_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testproject_codetracker`
--

LOCK TABLES `testproject_codetracker` WRITE;
/*!40000 ALTER TABLE `testproject_codetracker` DISABLE KEYS */;
/*!40000 ALTER TABLE `testproject_codetracker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testproject_issuetracker`
--

DROP TABLE IF EXISTS `testproject_issuetracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testproject_issuetracker` (
  `testproject_id` int(10) unsigned NOT NULL,
  `issuetracker_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testproject_issuetracker`
--

LOCK TABLES `testproject_issuetracker` WRITE;
/*!40000 ALTER TABLE `testproject_issuetracker` DISABLE KEYS */;
INSERT INTO `testproject_issuetracker` VALUES
(134,1);
/*!40000 ALTER TABLE `testproject_issuetracker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testproject_reqmgrsystem`
--

DROP TABLE IF EXISTS `testproject_reqmgrsystem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testproject_reqmgrsystem` (
  `testproject_id` int(10) unsigned NOT NULL,
  `reqmgrsystem_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testproject_reqmgrsystem`
--

LOCK TABLES `testproject_reqmgrsystem` WRITE;
/*!40000 ALTER TABLE `testproject_reqmgrsystem` DISABLE KEYS */;
/*!40000 ALTER TABLE `testproject_reqmgrsystem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testprojects`
--

DROP TABLE IF EXISTS `testprojects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testprojects` (
  `id` int(10) unsigned NOT NULL,
  `notes` text DEFAULT NULL,
  `color` varchar(12) NOT NULL DEFAULT '#9BD',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `option_reqs` tinyint(1) NOT NULL DEFAULT 0,
  `option_priority` tinyint(1) NOT NULL DEFAULT 0,
  `option_automation` tinyint(1) NOT NULL DEFAULT 0,
  `options` text DEFAULT NULL,
  `prefix` varchar(16) NOT NULL,
  `tc_counter` int(10) unsigned NOT NULL DEFAULT 0,
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `issue_tracker_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `code_tracker_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `reqmgr_integration_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `api_key` varchar(64) NOT NULL DEFAULT '0d8ab81dfa2c77e8235bc829a2ded3edfa2c78235bc829a27eded3ed0d8ab81d',
  PRIMARY KEY (`id`),
  UNIQUE KEY `testprojects_prefix` (`prefix`),
  UNIQUE KEY `testprojects_api_key` (`api_key`),
  KEY `testprojects_id_active` (`id`,`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testprojects`
--

LOCK TABLES `testprojects` WRITE;
/*!40000 ALTER TABLE `testprojects` DISABLE KEYS */;
INSERT INTO `testprojects` VALUES
(134,'','',1,0,0,0,'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:1;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:1;}','TCGaN',3,1,1,0,0,'23a08c0f7d2227525aaf90c1c7cf1b48ed36072c48cc5436eece2c04539fc30e');
/*!40000 ALTER TABLE `testprojects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testsuites`
--

DROP TABLE IF EXISTS `testsuites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testsuites` (
  `id` int(10) unsigned NOT NULL,
  `details` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testsuites`
--

LOCK TABLES `testsuites` WRITE;
/*!40000 ALTER TABLE `testsuites` DISABLE KEYS */;
INSERT INTO `testsuites` VALUES
(143,''),
(148,'<p>This Suite has test scenarios of the charger.</p>\r\n');
/*!40000 ALTER TABLE `testsuites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `text_templates`
--

DROP TABLE IF EXISTS `text_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `text_templates` (
  `id` int(10) unsigned NOT NULL,
  `type` smallint(5) unsigned NOT NULL,
  `title` varchar(100) NOT NULL,
  `template_data` text DEFAULT NULL,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_public` tinyint(1) NOT NULL DEFAULT 0,
  UNIQUE KEY `idx_text_templates` (`type`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Global Project Templates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `text_templates`
--

LOCK TABLES `text_templates` WRITE;
/*!40000 ALTER TABLE `text_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `text_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entry_point` varchar(45) NOT NULL DEFAULT '',
  `start_time` int(10) unsigned NOT NULL DEFAULT 0,
  `end_time` int(10) unsigned NOT NULL DEFAULT 0,
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `session_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=640 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES
(1,'/login.php',1703071931,1703071931,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(2,'/lib/project/projectEdit.php',1703071931,1703071931,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(3,'/logout.php',1703072025,1703072025,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(4,'/login.php',1703072857,1703072857,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(5,'/lib/project/projectEdit.php',1703072857,1703072857,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(6,'/lib/usermanagement/userInfo.php',1703072862,1703072862,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(7,'/lib/usermanagement/userInfo.php',1703072875,1703072875,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(8,'/lib/project/projectEdit.php',1703073027,1703073027,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(9,'/lib/general/mainPage.php',1703073033,1703073033,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(10,'/lib/issuetrackers/issueTrackerView.php',1703073072,1703073072,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(11,'/lib/issuetrackers/issueTrackerEdit.php',1703073172,1703073172,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(12,'/lib/project/projectEdit.php',1703073193,1703073193,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(13,'/lib/usermanagement/usersView.php',1703073598,1703073598,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(14,'/lib/usermanagement/usersEdit.php',1703073699,1703073699,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(15,'/login.php',1703132212,1703132212,1,'02e48m960mekvgauigps0578v8'),
(16,'/lib/general/mainPage.php',1703132213,1703132213,1,'02e48m960mekvgauigps0578v8'),
(17,'/lib/project/projectView.php',1703132226,1703132226,1,'02e48m960mekvgauigps0578v8'),
(18,'/lib/project/projectEdit.php',1703132236,1703132236,1,'02e48m960mekvgauigps0578v8'),
(19,'/lib/testcases/listTestCases.php',1703132251,1703132251,1,'02e48m960mekvgauigps0578v8'),
(20,'/lib/testcases/archiveData.php',1703132251,1703132251,1,'02e48m960mekvgauigps0578v8'),
(21,'/lib/usermanagement/usersView.php',1703132266,1703132266,1,'02e48m960mekvgauigps0578v8'),
(22,'/lib/testcases/listTestCases.php',1703132327,1703132327,1,'02e48m960mekvgauigps0578v8'),
(23,'/lib/testcases/archiveData.php',1703132327,1703132327,1,'02e48m960mekvgauigps0578v8'),
(24,'/lib/issuetrackers/issueTrackerView.php',1703133089,1703133089,1,'02e48m960mekvgauigps0578v8'),
(25,'/lib/testcases/listTestCases.php',1703133099,1703133099,1,'02e48m960mekvgauigps0578v8'),
(26,'/lib/testcases/archiveData.php',1703133099,1703133099,1,'02e48m960mekvgauigps0578v8'),
(27,'/lib/general/mainPage.php',1703133115,1703133115,1,'02e48m960mekvgauigps0578v8'),
(28,'/lib/testcases/listTestCases.php',1703133160,1703133160,1,'02e48m960mekvgauigps0578v8'),
(29,'/lib/usermanagement/rolesView.php',1703133650,1703133650,1,'02e48m960mekvgauigps0578v8'),
(30,'/lib/usermanagement/rolesEdit.php',1703133655,1703133655,1,'02e48m960mekvgauigps0578v8'),
(31,'/lib/usermanagement/rolesEdit.php',1703133735,1703133735,1,'02e48m960mekvgauigps0578v8'),
(32,'/logout.php',1703134456,1703134456,1,'02e48m960mekvgauigps0578v8'),
(33,'/login.php',1703139264,1703139264,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(34,'/lib/general/mainPage.php',1703139264,1703139264,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(35,'/lib/requirements/reqSpecListTree.php',1703139267,1703139267,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(36,'/lib/usermanagement/usersView.php',1703139274,1703139274,1,'lbtrfg6a63qs1nccosg5fm9u2k'),
(37,'/login.php',1703149039,1703149039,1,'02e48m960mekvgauigps0578v8'),
(38,'/lib/general/mainPage.php',1703149039,1703149039,1,'02e48m960mekvgauigps0578v8'),
(39,'/lib/project/projectView.php',1703156260,1703156260,1,'02e48m960mekvgauigps0578v8'),
(40,'/lib/project/projectEdit.php',1703156263,1703156263,1,'02e48m960mekvgauigps0578v8'),
(41,'/lib/platforms/platformsView.php',1703156278,1703156278,1,'02e48m960mekvgauigps0578v8'),
(42,'/lib/platforms/platformsEdit.php',1703156279,1703156279,1,'02e48m960mekvgauigps0578v8'),
(43,'/lib/plan/planEdit.php',1703156301,1703156301,1,'02e48m960mekvgauigps0578v8'),
(44,'/lib/requirements/reqSpecListTree.php',1703156317,1703156317,1,'02e48m960mekvgauigps0578v8'),
(45,'/lib/requirements/reqSpecEdit.php',1703156320,1703156320,1,'02e48m960mekvgauigps0578v8'),
(46,'/login.php',1703217617,1703217617,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(47,'/lib/general/mainPage.php',1703217618,1703217618,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(48,'/lib/project/projectView.php',1703217622,1703217622,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(49,'/login.php',1703218837,1703218837,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(50,'/lib/project/projectEdit.php',1703218968,1703218968,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(51,'/lib/requirements/reqSpecListTree.php',1703219523,1703219523,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(52,'/login.php',1703220099,1703220099,1,'qi4neba6fua8j17kt1ea7lgagl'),
(53,'/lib/general/mainPage.php',1703220099,1703220099,1,'qi4neba6fua8j17kt1ea7lgagl'),
(54,'/lib/requirements/reqSpecListTree.php',1703220102,1703220102,1,'qi4neba6fua8j17kt1ea7lgagl'),
(55,'/lib/requirements/reqSpecEdit.php',1703220106,1703220106,1,'qi4neba6fua8j17kt1ea7lgagl'),
(56,'/lib/requirements/reqSpecEdit.php',1703220215,1703220216,1,'qi4neba6fua8j17kt1ea7lgagl'),
(57,'/lib/requirements/reqSpecView.php',1703220224,1703220224,1,'qi4neba6fua8j17kt1ea7lgagl'),
(58,'/lib/requirements/reqEdit.php',1703220234,1703220234,1,'qi4neba6fua8j17kt1ea7lgagl'),
(59,'/lib/requirements/reqEdit.php',1703220268,1703220268,1,'qi4neba6fua8j17kt1ea7lgagl'),
(60,'/lib/requirements/reqView.php',1703220268,1703220268,1,'qi4neba6fua8j17kt1ea7lgagl'),
(61,'/lib/requirements/reqEdit.php',1703220387,1703220387,1,'qi4neba6fua8j17kt1ea7lgagl'),
(62,'/lib/requirements/reqEdit.php',1703220431,1703220431,1,'qi4neba6fua8j17kt1ea7lgagl'),
(63,'/lib/requirements/reqEdit.php',1703220455,1703220455,1,'qi4neba6fua8j17kt1ea7lgagl'),
(64,'/lib/requirements/reqEdit.php',1703220469,1703220469,1,'qi4neba6fua8j17kt1ea7lgagl'),
(65,'/lib/requirements/reqEdit.php',1703220489,1703220489,1,'qi4neba6fua8j17kt1ea7lgagl'),
(66,'/lib/requirements/reqEdit.php',1703220614,1703220614,1,'qi4neba6fua8j17kt1ea7lgagl'),
(67,'/lib/requirements/reqEdit.php',1703220640,1703220640,1,'qi4neba6fua8j17kt1ea7lgagl'),
(68,'/lib/requirements/reqEdit.php',1703220658,1703220659,1,'qi4neba6fua8j17kt1ea7lgagl'),
(69,'/lib/requirements/reqEdit.php',1703220671,1703220671,1,'qi4neba6fua8j17kt1ea7lgagl'),
(70,'/lib/requirements/reqEdit.php',1703220689,1703220689,1,'qi4neba6fua8j17kt1ea7lgagl'),
(71,'/lib/requirements/reqEdit.php',1703220704,1703220704,1,'qi4neba6fua8j17kt1ea7lgagl'),
(72,'/lib/requirements/reqEdit.php',1703220717,1703220717,1,'qi4neba6fua8j17kt1ea7lgagl'),
(73,'/lib/requirements/reqEdit.php',1703220766,1703220766,1,'qi4neba6fua8j17kt1ea7lgagl'),
(74,'/lib/requirements/reqEdit.php',1703220786,1703220786,1,'qi4neba6fua8j17kt1ea7lgagl'),
(75,'/lib/requirements/reqEdit.php',1703220803,1703220803,1,'qi4neba6fua8j17kt1ea7lgagl'),
(76,'/lib/requirements/reqEdit.php',1703220819,1703220819,1,'qi4neba6fua8j17kt1ea7lgagl'),
(77,'/lib/requirements/reqEdit.php',1703220844,1703220844,1,'qi4neba6fua8j17kt1ea7lgagl'),
(78,'/lib/requirements/reqEdit.php',1703220862,1703220862,1,'qi4neba6fua8j17kt1ea7lgagl'),
(79,'/lib/requirements/reqEdit.php',1703220879,1703220879,1,'qi4neba6fua8j17kt1ea7lgagl'),
(80,'/lib/requirements/reqEdit.php',1703220890,1703220890,1,'qi4neba6fua8j17kt1ea7lgagl'),
(81,'/lib/requirements/reqEdit.php',1703220915,1703220915,1,'qi4neba6fua8j17kt1ea7lgagl'),
(82,'/lib/requirements/reqEdit.php',1703220933,1703220933,1,'qi4neba6fua8j17kt1ea7lgagl'),
(83,'/lib/requirements/reqEdit.php',1703221324,1703221324,1,'qi4neba6fua8j17kt1ea7lgagl'),
(84,'/lib/requirements/reqEdit.php',1703221344,1703221344,1,'qi4neba6fua8j17kt1ea7lgagl'),
(85,'/lib/requirements/reqEdit.php',1703221370,1703221370,1,'qi4neba6fua8j17kt1ea7lgagl'),
(86,'/lib/requirements/reqEdit.php',1703221388,1703221388,1,'qi4neba6fua8j17kt1ea7lgagl'),
(87,'/lib/requirements/reqEdit.php',1703221402,1703221402,1,'qi4neba6fua8j17kt1ea7lgagl'),
(88,'/lib/testcases/listTestCases.php',1703221935,1703221935,1,'qi4neba6fua8j17kt1ea7lgagl'),
(89,'/lib/testcases/archiveData.php',1703221935,1703221935,1,'qi4neba6fua8j17kt1ea7lgagl'),
(90,'/lib/testcases/archiveData.php',1703221938,1703221938,1,'qi4neba6fua8j17kt1ea7lgagl'),
(91,'/lib/testcases/containerEdit.php',1703221952,1703221952,1,'qi4neba6fua8j17kt1ea7lgagl'),
(92,'/lib/testcases/listTestCases.php',1703221952,1703221952,1,'qi4neba6fua8j17kt1ea7lgagl'),
(93,'/lib/testcases/containerEdit.php',1703221961,1703221961,1,'qi4neba6fua8j17kt1ea7lgagl'),
(94,'/lib/testcases/listTestCases.php',1703221962,1703221962,1,'qi4neba6fua8j17kt1ea7lgagl'),
(95,'/lib/testcases/containerEdit.php',1703221967,1703221967,1,'qi4neba6fua8j17kt1ea7lgagl'),
(96,'/lib/testcases/listTestCases.php',1703221967,1703221967,1,'qi4neba6fua8j17kt1ea7lgagl'),
(97,'/lib/testcases/containerEdit.php',1703221973,1703221973,1,'qi4neba6fua8j17kt1ea7lgagl'),
(98,'/lib/testcases/listTestCases.php',1703221973,1703221973,1,'qi4neba6fua8j17kt1ea7lgagl'),
(99,'/lib/testcases/containerEdit.php',1703221979,1703221979,1,'qi4neba6fua8j17kt1ea7lgagl'),
(100,'/lib/testcases/listTestCases.php',1703221979,1703221979,1,'qi4neba6fua8j17kt1ea7lgagl'),
(101,'/lib/testcases/containerEdit.php',1703221984,1703221984,1,'qi4neba6fua8j17kt1ea7lgagl'),
(102,'/lib/testcases/listTestCases.php',1703221985,1703221985,1,'qi4neba6fua8j17kt1ea7lgagl'),
(103,'/lib/testcases/containerEdit.php',1703221990,1703221990,1,'qi4neba6fua8j17kt1ea7lgagl'),
(104,'/lib/testcases/listTestCases.php',1703221990,1703221990,1,'qi4neba6fua8j17kt1ea7lgagl'),
(105,'/lib/testcases/containerEdit.php',1703221995,1703221995,1,'qi4neba6fua8j17kt1ea7lgagl'),
(106,'/lib/testcases/listTestCases.php',1703221996,1703221996,1,'qi4neba6fua8j17kt1ea7lgagl'),
(107,'/lib/testcases/containerEdit.php',1703222001,1703222001,1,'qi4neba6fua8j17kt1ea7lgagl'),
(108,'/lib/testcases/listTestCases.php',1703222002,1703222002,1,'qi4neba6fua8j17kt1ea7lgagl'),
(109,'/lib/testcases/containerEdit.php',1703222006,1703222006,1,'qi4neba6fua8j17kt1ea7lgagl'),
(110,'/lib/testcases/listTestCases.php',1703222006,1703222006,1,'qi4neba6fua8j17kt1ea7lgagl'),
(111,'/lib/testcases/containerEdit.php',1703222012,1703222012,1,'qi4neba6fua8j17kt1ea7lgagl'),
(112,'/lib/testcases/listTestCases.php',1703222012,1703222012,1,'qi4neba6fua8j17kt1ea7lgagl'),
(113,'/lib/testcases/containerEdit.php',1703222024,1703222024,1,'qi4neba6fua8j17kt1ea7lgagl'),
(114,'/lib/testcases/listTestCases.php',1703222024,1703222024,1,'qi4neba6fua8j17kt1ea7lgagl'),
(115,'/lib/testcases/containerEdit.php',1703222029,1703222029,1,'qi4neba6fua8j17kt1ea7lgagl'),
(116,'/lib/testcases/listTestCases.php',1703222029,1703222029,1,'qi4neba6fua8j17kt1ea7lgagl'),
(117,'/lib/testcases/containerEdit.php',1703222035,1703222035,1,'qi4neba6fua8j17kt1ea7lgagl'),
(118,'/lib/testcases/listTestCases.php',1703222035,1703222035,1,'qi4neba6fua8j17kt1ea7lgagl'),
(119,'/lib/testcases/containerEdit.php',1703222041,1703222041,1,'qi4neba6fua8j17kt1ea7lgagl'),
(120,'/lib/testcases/listTestCases.php',1703222041,1703222041,1,'qi4neba6fua8j17kt1ea7lgagl'),
(121,'/lib/testcases/containerEdit.php',1703222046,1703222046,1,'qi4neba6fua8j17kt1ea7lgagl'),
(122,'/lib/testcases/listTestCases.php',1703222046,1703222046,1,'qi4neba6fua8j17kt1ea7lgagl'),
(123,'/lib/testcases/containerEdit.php',1703222052,1703222052,1,'qi4neba6fua8j17kt1ea7lgagl'),
(124,'/lib/testcases/listTestCases.php',1703222052,1703222052,1,'qi4neba6fua8j17kt1ea7lgagl'),
(125,'/lib/testcases/containerEdit.php',1703222057,1703222057,1,'qi4neba6fua8j17kt1ea7lgagl'),
(126,'/lib/testcases/listTestCases.php',1703222058,1703222058,1,'qi4neba6fua8j17kt1ea7lgagl'),
(127,'/lib/testcases/containerEdit.php',1703222063,1703222063,1,'qi4neba6fua8j17kt1ea7lgagl'),
(128,'/lib/testcases/listTestCases.php',1703222063,1703222063,1,'qi4neba6fua8j17kt1ea7lgagl'),
(129,'/lib/testcases/containerEdit.php',1703222068,1703222068,1,'qi4neba6fua8j17kt1ea7lgagl'),
(130,'/lib/testcases/listTestCases.php',1703222068,1703222068,1,'qi4neba6fua8j17kt1ea7lgagl'),
(131,'/lib/testcases/containerEdit.php',1703222074,1703222074,1,'qi4neba6fua8j17kt1ea7lgagl'),
(132,'/lib/testcases/listTestCases.php',1703222074,1703222074,1,'qi4neba6fua8j17kt1ea7lgagl'),
(133,'/lib/testcases/containerEdit.php',1703222079,1703222079,1,'qi4neba6fua8j17kt1ea7lgagl'),
(134,'/lib/testcases/listTestCases.php',1703222079,1703222079,1,'qi4neba6fua8j17kt1ea7lgagl'),
(135,'/lib/testcases/archiveData.php',1703222119,1703222119,1,'qi4neba6fua8j17kt1ea7lgagl'),
(136,'/lib/testcases/tcEdit.php',1703222125,1703222125,1,'qi4neba6fua8j17kt1ea7lgagl'),
(137,'/lib/testcases/tcEdit.php',1703222164,1703222164,1,'qi4neba6fua8j17kt1ea7lgagl'),
(138,'/lib/testcases/listTestCases.php',1703222164,1703222164,1,'qi4neba6fua8j17kt1ea7lgagl'),
(139,'/lib/testcases/tcEdit.php',1703222178,1703222178,1,'qi4neba6fua8j17kt1ea7lgagl'),
(140,'/lib/testcases/listTestCases.php',1703222178,1703222178,1,'qi4neba6fua8j17kt1ea7lgagl'),
(141,'/lib/testcases/tcEdit.php',1703222188,1703222188,1,'qi4neba6fua8j17kt1ea7lgagl'),
(142,'/lib/testcases/tcEdit.php',1703222200,1703222200,1,'qi4neba6fua8j17kt1ea7lgagl'),
(143,'/lib/testcases/listTestCases.php',1703222200,1703222200,1,'qi4neba6fua8j17kt1ea7lgagl'),
(144,'/lib/testcases/tcEdit.php',1703222213,1703222213,1,'qi4neba6fua8j17kt1ea7lgagl'),
(145,'/lib/testcases/listTestCases.php',1703222214,1703222214,1,'qi4neba6fua8j17kt1ea7lgagl'),
(146,'/lib/testcases/tcEdit.php',1703222224,1703222224,1,'qi4neba6fua8j17kt1ea7lgagl'),
(147,'/lib/testcases/tcEdit.php',1703222230,1703222230,1,'qi4neba6fua8j17kt1ea7lgagl'),
(148,'/lib/testcases/listTestCases.php',1703222230,1703222230,1,'qi4neba6fua8j17kt1ea7lgagl'),
(149,'/lib/testcases/tcEdit.php',1703222236,1703222236,1,'qi4neba6fua8j17kt1ea7lgagl'),
(150,'/lib/testcases/tcEdit.php',1703222269,1703222269,1,'qi4neba6fua8j17kt1ea7lgagl'),
(151,'/lib/testcases/listTestCases.php',1703222269,1703222269,1,'qi4neba6fua8j17kt1ea7lgagl'),
(152,'/lib/testcases/tcEdit.php',1703222284,1703222284,1,'qi4neba6fua8j17kt1ea7lgagl'),
(153,'/lib/testcases/tcEdit.php',1703222349,1703222349,1,'qi4neba6fua8j17kt1ea7lgagl'),
(154,'/lib/testcases/listTestCases.php',1703222349,1703222349,1,'qi4neba6fua8j17kt1ea7lgagl'),
(155,'/lib/testcases/tcEdit.php',1703222360,1703222360,1,'qi4neba6fua8j17kt1ea7lgagl'),
(156,'/lib/testcases/tcEdit.php',1703222383,1703222383,1,'qi4neba6fua8j17kt1ea7lgagl'),
(157,'/lib/testcases/listTestCases.php',1703222383,1703222383,1,'qi4neba6fua8j17kt1ea7lgagl'),
(158,'/lib/testcases/tcEdit.php',1703222442,1703222443,1,'qi4neba6fua8j17kt1ea7lgagl'),
(159,'/lib/testcases/listTestCases.php',1703222443,1703222443,1,'qi4neba6fua8j17kt1ea7lgagl'),
(160,'/lib/testcases/tcEdit.php',1703222449,1703222449,1,'qi4neba6fua8j17kt1ea7lgagl'),
(161,'/lib/testcases/tcEdit.php',1703222452,1703222452,1,'qi4neba6fua8j17kt1ea7lgagl'),
(162,'/lib/testcases/tcEdit.php',1703222491,1703222491,1,'qi4neba6fua8j17kt1ea7lgagl'),
(163,'/lib/testcases/tcEdit.php',1703222510,1703222510,1,'qi4neba6fua8j17kt1ea7lgagl'),
(164,'/lib/testcases/listTestCases.php',1703222510,1703222510,1,'qi4neba6fua8j17kt1ea7lgagl'),
(165,'/lib/testcases/tcEdit.php',1703222529,1703222529,1,'qi4neba6fua8j17kt1ea7lgagl'),
(166,'/lib/testcases/listTestCases.php',1703222529,1703222529,1,'qi4neba6fua8j17kt1ea7lgagl'),
(167,'/lib/testcases/tcEdit.php',1703222544,1703222544,1,'qi4neba6fua8j17kt1ea7lgagl'),
(168,'/lib/testcases/tcEdit.php',1703222552,1703222552,1,'qi4neba6fua8j17kt1ea7lgagl'),
(169,'/lib/testcases/listTestCases.php',1703222552,1703222552,1,'qi4neba6fua8j17kt1ea7lgagl'),
(170,'/lib/testcases/tcEdit.php',1703222562,1703222562,1,'qi4neba6fua8j17kt1ea7lgagl'),
(171,'/lib/testcases/tcEdit.php',1703222571,1703222571,1,'qi4neba6fua8j17kt1ea7lgagl'),
(172,'/lib/testcases/listTestCases.php',1703222571,1703222571,1,'qi4neba6fua8j17kt1ea7lgagl'),
(173,'/lib/testcases/tcEdit.php',1703222586,1703222586,1,'qi4neba6fua8j17kt1ea7lgagl'),
(174,'/lib/testcases/tcEdit.php',1703222595,1703222595,1,'qi4neba6fua8j17kt1ea7lgagl'),
(175,'/lib/testcases/listTestCases.php',1703222595,1703222595,1,'qi4neba6fua8j17kt1ea7lgagl'),
(176,'/lib/testcases/tcEdit.php',1703222607,1703222607,1,'qi4neba6fua8j17kt1ea7lgagl'),
(177,'/lib/testcases/tcEdit.php',1703222616,1703222616,1,'qi4neba6fua8j17kt1ea7lgagl'),
(178,'/lib/testcases/listTestCases.php',1703222616,1703222616,1,'qi4neba6fua8j17kt1ea7lgagl'),
(179,'/lib/testcases/tcEdit.php',1703222629,1703222629,1,'qi4neba6fua8j17kt1ea7lgagl'),
(180,'/lib/testcases/tcEdit.php',1703222638,1703222638,1,'qi4neba6fua8j17kt1ea7lgagl'),
(181,'/lib/testcases/listTestCases.php',1703222638,1703222638,1,'qi4neba6fua8j17kt1ea7lgagl'),
(182,'/lib/testcases/tcEdit.php',1703222651,1703222651,1,'qi4neba6fua8j17kt1ea7lgagl'),
(183,'/lib/testcases/tcEdit.php',1703222656,1703222657,1,'qi4neba6fua8j17kt1ea7lgagl'),
(184,'/lib/testcases/listTestCases.php',1703222657,1703222657,1,'qi4neba6fua8j17kt1ea7lgagl'),
(185,'/lib/testcases/tcEdit.php',1703222666,1703222666,1,'qi4neba6fua8j17kt1ea7lgagl'),
(186,'/lib/testcases/tcEdit.php',1703222676,1703222676,1,'qi4neba6fua8j17kt1ea7lgagl'),
(187,'/lib/testcases/listTestCases.php',1703222676,1703222676,1,'qi4neba6fua8j17kt1ea7lgagl'),
(188,'/lib/testcases/tcEdit.php',1703222683,1703222683,1,'qi4neba6fua8j17kt1ea7lgagl'),
(189,'/lib/testcases/tcEdit.php',1703222692,1703222692,1,'qi4neba6fua8j17kt1ea7lgagl'),
(190,'/lib/testcases/listTestCases.php',1703222692,1703222692,1,'qi4neba6fua8j17kt1ea7lgagl'),
(191,'/lib/testcases/tcEdit.php',1703222705,1703222705,1,'qi4neba6fua8j17kt1ea7lgagl'),
(192,'/lib/testcases/tcEdit.php',1703222716,1703222716,1,'qi4neba6fua8j17kt1ea7lgagl'),
(193,'/lib/testcases/listTestCases.php',1703222716,1703222716,1,'qi4neba6fua8j17kt1ea7lgagl'),
(194,'/lib/testcases/tcEdit.php',1703222729,1703222729,1,'qi4neba6fua8j17kt1ea7lgagl'),
(195,'/lib/testcases/tcEdit.php',1703222737,1703222737,1,'qi4neba6fua8j17kt1ea7lgagl'),
(196,'/lib/testcases/listTestCases.php',1703222737,1703222737,1,'qi4neba6fua8j17kt1ea7lgagl'),
(197,'/lib/testcases/tcEdit.php',1703223444,1703223444,1,'qi4neba6fua8j17kt1ea7lgagl'),
(198,'/lib/testcases/tcEdit.php',1703223468,1703223468,1,'qi4neba6fua8j17kt1ea7lgagl'),
(199,'/lib/testcases/listTestCases.php',1703223468,1703223468,1,'qi4neba6fua8j17kt1ea7lgagl'),
(200,'/lib/testcases/tcEdit.php',1703223491,1703223491,1,'qi4neba6fua8j17kt1ea7lgagl'),
(201,'/lib/testcases/tcEdit.php',1703223497,1703223497,1,'qi4neba6fua8j17kt1ea7lgagl'),
(202,'/lib/testcases/listTestCases.php',1703223497,1703223497,1,'qi4neba6fua8j17kt1ea7lgagl'),
(203,'/lib/testcases/tcEdit.php',1703223515,1703223515,1,'qi4neba6fua8j17kt1ea7lgagl'),
(204,'/lib/testcases/tcEdit.php',1703223525,1703223525,1,'qi4neba6fua8j17kt1ea7lgagl'),
(205,'/lib/testcases/listTestCases.php',1703223525,1703223525,1,'qi4neba6fua8j17kt1ea7lgagl'),
(206,'/lib/testcases/tcEdit.php',1703223536,1703223536,1,'qi4neba6fua8j17kt1ea7lgagl'),
(207,'/lib/testcases/tcEdit.php',1703223547,1703223547,1,'qi4neba6fua8j17kt1ea7lgagl'),
(208,'/lib/testcases/listTestCases.php',1703223547,1703223547,1,'qi4neba6fua8j17kt1ea7lgagl'),
(209,'/lib/testcases/tcEdit.php',1703223560,1703223560,1,'qi4neba6fua8j17kt1ea7lgagl'),
(210,'/lib/testcases/tcEdit.php',1703223566,1703223566,1,'qi4neba6fua8j17kt1ea7lgagl'),
(211,'/lib/testcases/listTestCases.php',1703223567,1703223567,1,'qi4neba6fua8j17kt1ea7lgagl'),
(212,'/lib/testcases/tcEdit.php',1703223595,1703223595,1,'qi4neba6fua8j17kt1ea7lgagl'),
(213,'/lib/testcases/tcEdit.php',1703223606,1703223606,1,'qi4neba6fua8j17kt1ea7lgagl'),
(214,'/lib/testcases/listTestCases.php',1703223606,1703223606,1,'qi4neba6fua8j17kt1ea7lgagl'),
(215,'/lib/testcases/tcEdit.php',1703223615,1703223615,1,'qi4neba6fua8j17kt1ea7lgagl'),
(216,'/lib/testcases/tcEdit.php',1703223623,1703223623,1,'qi4neba6fua8j17kt1ea7lgagl'),
(217,'/lib/testcases/listTestCases.php',1703223624,1703223624,1,'qi4neba6fua8j17kt1ea7lgagl'),
(218,'/lib/testcases/tcEdit.php',1703223845,1703223845,1,'qi4neba6fua8j17kt1ea7lgagl'),
(219,'/lib/testcases/listTestCases.php',1703223845,1703223845,1,'qi4neba6fua8j17kt1ea7lgagl'),
(220,'/lib/testcases/listTestCases.php',1703226356,1703226356,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(221,'/lib/testcases/archiveData.php',1703226356,1703226356,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(222,'/lib/testcases/archiveData.php',1703226486,1703226486,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(223,'/lib/requirements/reqView.php',1703226529,1703226529,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(224,'/lib/requirements/reqEdit.php',1703226545,1703226545,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(225,'/lib/requirements/reqEdit.php',1703226574,1703226574,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(226,'/lib/testcases/listTestCases.php',1703226770,1703226770,1,'qi4neba6fua8j17kt1ea7lgagl'),
(227,'/lib/testcases/archiveData.php',1703226770,1703226770,1,'qi4neba6fua8j17kt1ea7lgagl'),
(228,'/lib/testcases/tcEdit.php',1703226781,1703226781,1,'qi4neba6fua8j17kt1ea7lgagl'),
(229,'/lib/testcases/tcEdit.php',1703226836,1703226836,1,'qi4neba6fua8j17kt1ea7lgagl'),
(230,'/lib/testcases/tcEdit.php',1703226845,1703226845,1,'qi4neba6fua8j17kt1ea7lgagl'),
(231,'/lib/testcases/tcEdit.php',1703226854,1703226854,1,'qi4neba6fua8j17kt1ea7lgagl'),
(232,'/lib/testcases/tcEdit.php',1703226856,1703226856,1,'qi4neba6fua8j17kt1ea7lgagl'),
(233,'/lib/plan/planEdit.php',1703226948,1703226948,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(234,'/lib/plan/planEdit.php',1703227002,1703227002,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(235,'/lib/plan/buildEdit.php',1703227080,1703227080,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(236,'/lib/plan/buildEdit.php',1703227173,1703227173,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(237,'/lib/plan/planAddTCNavigator.php',1703227242,1703227242,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(238,'/lib/plan/planAddTC.php',1703227381,1703227381,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(239,'/lib/plan/planAddTC.php',1703227463,1703227463,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(240,'/lib/plan/planAddTCNavigator.php',1703227464,1703227464,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(241,'/lib/plan/planAddTC.php',1703227472,1703227472,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(242,'/lib/plan/planAddTC.php',1703227478,1703227478,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(243,'/lib/plan/planAddTCNavigator.php',1703227479,1703227479,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(244,'/lib/plan/planAddTC.php',1703227595,1703227595,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(245,'/lib/plan/planAddTCNavigator.php',1703227595,1703227595,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(246,'/lib/execute/execNavigator.php',1703227607,1703227607,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(247,'/lib/execute/execDashboard.php',1703227607,1703227607,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(248,'/lib/execute/execSetResults.php',1703227691,1703227691,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(249,'/lib/execute/execSetResults.php',1703227691,1703227691,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(250,'/lib/execute/execSetResults.php',1703227692,1703227692,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(251,'/lib/execute/execSetResults.php',1703227693,1703227693,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(252,'/lib/execute/execSetResults.php',1703227695,1703227695,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(253,'/lib/execute/execSetResults.php',1703227820,1703227820,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(254,'/lib/execute/execSetResults.php',1703227823,1703227823,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(255,'/lib/execute/execSetResults.php',1703227930,1703227930,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(256,'/lib/execute/execSetResults.php',1703227982,1703227982,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(257,'/lib/execute/execSetResults.php',1703228058,1703228058,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(258,'/lib/execute/execSetResults.php',1703228070,1703228070,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(259,'/lib/execute/execSetResults.php',1703228094,1703228094,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(260,'/lib/execute/execSetResults.php',1703228110,1703228110,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(261,'/lib/execute/execSetResults.php',1703228123,1703228123,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(262,'/lib/execute/execSetResults.php',1703228127,1703228127,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(263,'/lib/execute/execSetResults.php',1703228131,1703228131,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(264,'/lib/execute/execSetResults.php',1703228151,1703228151,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(265,'/lib/execute/execSetResults.php',1703228154,1703228154,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(266,'/lib/plan/planEdit.php',1703228188,1703228188,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(267,'/lib/results/resultsNavigator.php',1703228203,1703228203,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(268,'/lib/results/printDocOptions.php',1703228213,1703228213,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(269,'/lib/results/printDocument.php',1703228217,1703228217,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(270,'/lib/results/printDocument.php',1703228231,1703228231,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(271,'/lib/results/printDocument.php',1703228239,1703228239,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(272,'/lib/execute/execSetResults.php',1703228261,1703228261,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(273,'/lib/execute/execSetResults.php',1703228283,1703228283,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(274,'/lib/platforms/platformsView.php',1703228791,1703228791,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(275,'/lib/platforms/platformsEdit.php',1703228793,1703228793,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(276,'/lib/platforms/platformsEdit.php',1703228880,1703228880,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(277,'/lib/platforms/platformsEdit.php',1703228882,1703228882,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(278,'/lib/platforms/platformsEdit.php',1703228889,1703228889,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(279,'/lib/platforms/platformsEdit.php',1703228890,1703228890,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(280,'/lib/platforms/platformsEdit.php',1703228899,1703228899,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(281,'/lib/platforms/platformsEdit.php',1703228901,1703228901,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(282,'/lib/platforms/platformsEdit.php',1703228912,1703228912,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(283,'/lib/plan/planAddTCNavigator.php',1703228976,1703228976,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(284,'/lib/platforms/platformsAssign.php',1703229021,1703229021,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(285,'/lib/plan/planAddTCNavigator.php',1703229030,1703229030,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(286,'/lib/plan/planAddTC.php',1703229032,1703229032,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(287,'/lib/plan/planAddTCNavigator.php',1703229109,1703229109,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(288,'/lib/plan/planAddTC.php',1703229111,1703229112,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(289,'/lib/plan/planAddTC.php',1703229121,1703229121,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(290,'/lib/plan/planAddTC.php',1703229128,1703229128,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(291,'/lib/plan/planAddTC.php',1703229195,1703229195,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(292,'/lib/plan/planAddTC.php',1703229199,1703229199,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(293,'/lib/plan/planAddTC.php',1703229206,1703229206,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(294,'/lib/plan/planAddTC.php',1703229207,1703229207,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(295,'/lib/plan/planAddTC.php',1703229211,1703229211,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(296,'/lib/execute/execNavigator.php',1703229219,1703229219,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(297,'/lib/execute/execDashboard.php',1703229219,1703229219,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(298,'/lib/execute/execDashboard.php',1703229219,1703229219,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(299,'/lib/execute/execSetResults.php',1703229227,1703229227,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(300,'/lib/execute/execSetResults.php',1703229426,1703229426,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(301,'/lib/execute/execSetResults.php',1703229471,1703229471,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(302,'/lib/execute/execDashboard.php',1703229518,1703229518,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(303,'/lib/execute/execSetResults.php',1703229523,1703229523,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(304,'/lib/execute/execSetResults.php',1703229560,1703229560,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(305,'/lib/execute/execSetResults.php',1703229584,1703229584,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(306,'/lib/execute/execSetResults.php',1703229605,1703229605,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(307,'/lib/execute/execSetResults.php',1703229624,1703229624,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(308,'/lib/testcases/tcAssignedToUser.php',1703229784,1703229784,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(309,'/lib/execute/execSetResults.php',1703229797,1703229797,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(310,'/lib/execute/execSetResults.php',1703229802,1703229802,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(311,'/lib/testcases/tcAssignedToUser.php',1703229812,1703229812,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(312,'/lib/execute/execSetResults.php',1703229819,1703229819,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(313,'/lib/execute/execSetResults.php',1703229823,1703229823,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(314,'/lib/execute/execSetResults.php',1703229827,1703229827,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(315,'/lib/testcases/tcAssignedToUser.php',1703229834,1703229834,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(316,'/lib/execute/execSetResults.php',1703229838,1703229839,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(317,'/lib/execute/execSetResults.php',1703229843,1703229843,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(318,'/lib/execute/execSetResults.php',1703229845,1703229845,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(319,'/lib/execute/execSetResults.php',1703229859,1703229859,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(320,'/lib/execute/execSetResults.php',1703229862,1703229862,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(321,'/lib/testcases/tcAssignedToUser.php',1703229869,1703229869,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(322,'/lib/execute/execSetResults.php',1703229873,1703229873,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(323,'/lib/execute/execSetResults.php',1703229885,1703229885,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(324,'/lib/execute/execSetResults.php',1703229887,1703229887,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(325,'/lib/execute/execSetResults.php',1703229894,1703229894,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(326,'/lib/execute/execSetResults.php',1703229898,1703229898,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(327,'/lib/execute/execSetResults.php',1703229900,1703229900,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(328,'/lib/testcases/tcAssignedToUser.php',1703229905,1703229905,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(329,'/lib/testcases/archiveData.php',1703229910,1703229910,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(330,'/lib/results/printDocument.php',1703229966,1703229966,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(331,'/lib/results/resultsTCFlat.php',1703229970,1703229970,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(332,'/lib/results/execTimelineStats.php',1703229984,1703229984,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(333,'/lib/results/testPlanWithCF.php',1703229987,1703229987,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(334,'/lib/results/testCasesWithCF.php',1703229988,1703229988,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(335,'/lib/results/resultsByStatus.php',1703229993,1703229993,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(336,'/lib/results/resultsByStatus.php',1703229995,1703229995,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(337,'/lib/results/resultsTCAbsoluteLatest.php',1703229998,1703229998,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(338,'/lib/results/resultsTCFlat.php',1703229999,1703229999,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(339,'/lib/results/resultsTC.php',1703230002,1703230002,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(340,'/lib/results/metricsDashboard.php',1703230032,1703230032,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(341,'/lib/results/metricsDashboard.php',1703230212,1703230212,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(342,'/lib/results/overallPieChart.php',1703230219,1703230219,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(343,'/lib/results/keywordBarChart.php',1703230219,1703230219,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(344,'/lib/results/topLevelSuitesBarChart.php',1703230219,1703230219,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(345,'/lib/execute/execDashboard.php',1703230228,1703230228,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(346,'/lib/execute/execDashboard.php',1703230228,1703230228,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(347,'/lib/testcases/listTestCases.php',1703230324,1703230324,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(348,'/lib/testcases/archiveData.php',1703230324,1703230324,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(349,'/lib/testcases/listTestCases.php',1703230358,1703230358,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(350,'/lib/plan/planEdit.php',1703230471,1703230471,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(351,'/lib/testcases/tcAssignedToUser.php',1703230483,1703230483,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(352,'/lib/execute/execDashboard.php',1703230497,1703230497,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(353,'/lib/execute/execDashboard.php',1703230497,1703230497,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(354,'/lib/execute/execSetResults.php',1703230502,1703230502,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(355,'/lib/testcases/listTestCases.php',1703230525,1703230525,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(356,'/lib/testcases/archiveData.php',1703230525,1703230525,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(357,'/lib/platforms/platformsView.php',1703230530,1703230530,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(358,'/lib/execute/execDashboard.php',1703230549,1703230549,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(359,'/lib/execute/execDashboard.php',1703230549,1703230549,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(360,'/lib/execute/execSetResults.php',1703230552,1703230552,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(361,'/lib/execute/execSetResults.php',1703230579,1703230579,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(362,'/lib/results/metricsDashboard.php',1703230603,1703230603,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(363,'/lib/results/overallPieChart.php',1703230624,1703230624,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(364,'/lib/results/keywordBarChart.php',1703230624,1703230624,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(365,'/lib/results/topLevelSuitesBarChart.php',1703230624,1703230624,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(366,'/lib/plan/planEdit.php',1703237539,1703237539,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(367,'/lib/execute/execDashboard.php',1703237544,1703237544,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(368,'/lib/execute/execDashboard.php',1703237544,1703237544,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(369,'/lib/execute/execDashboard.php',1703237549,1703237549,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(370,'/lib/execute/execSetResults.php',1703237558,1703237558,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(371,'/lib/results/resultsByTSuite.php',1703237614,1703237614,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(372,'/lib/results/resultsGeneral.php',1703237616,1703237616,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(373,'/lib/results/testCasesWithCF.php',1703237640,1703237640,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(374,'/lib/results/neverRunByPP.php',1703237642,1703237642,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(375,'/lib/results/resultsByStatus.php',1703237643,1703237643,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(376,'/lib/results/resultsByStatus.php',1703237644,1703237644,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(377,'/lib/results/resultsTCFlat.php',1703237648,1703237648,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(378,'/lib/results/resultsTC.php',1703237649,1703237649,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(379,'/lib/results/metricsDashboard.php',1703237663,1703237663,1,'ivvm5l9r8qilnujo3hb3qfd4es'),
(380,'/login.php',1703842615,1703842615,0,NULL),
(381,'/login.php',1703842634,1703842634,0,NULL),
(382,'/login.php',1703842711,1703842711,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(383,'/lib/general/mainPage.php',1703842711,1703842711,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(384,'/lib/usermanagement/usersView.php',1703842718,1703842718,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(385,'/lib/usermanagement/usersEdit.php',1703842822,1703842822,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(386,'/lib/usermanagement/usersEdit.php',1703842891,1703842891,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(387,'/lib/usermanagement/usersEdit.php',1703842934,1703842934,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(388,'/lib/usermanagement/usersEdit.php',1703842947,1703842947,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(389,'/lib/usermanagement/usersEdit.php',1703842977,1703842977,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(390,'/lib/usermanagement/usersView.php',1703843013,1703843013,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(391,'/lib/usermanagement/usersView.php',1703843021,1703843021,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(392,'/lib/usermanagement/usersEdit.php',1703843032,1703843032,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(393,'/lib/usermanagement/userInfo.php',1703843694,1703843694,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(394,'/logout.php',1703843696,1703843696,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(395,'/login.php',1703846902,1703846902,3,'m0rsh552n46tllobmoqh11etg4'),
(396,'/lib/general/mainPage.php',1703846902,1703846903,3,'m0rsh552n46tllobmoqh11etg4'),
(397,'/lib/testcases/listTestCases.php',1703848684,1703848684,3,'m0rsh552n46tllobmoqh11etg4'),
(398,'/lib/testcases/archiveData.php',1703848684,1703848684,3,'m0rsh552n46tllobmoqh11etg4'),
(399,'/lib/testcases/archiveData.php',1703848783,1703848783,3,'m0rsh552n46tllobmoqh11etg4'),
(400,'/lib/testcases/archiveData.php',1703848801,1703848801,3,'m0rsh552n46tllobmoqh11etg4'),
(401,'/lib/general/mainPage.php',1703848819,1703848819,3,'m0rsh552n46tllobmoqh11etg4'),
(402,'/lib/execute/execNavigator.php',1703848829,1703848829,3,'m0rsh552n46tllobmoqh11etg4'),
(403,'/lib/execute/execDashboard.php',1703848829,1703848829,3,'m0rsh552n46tllobmoqh11etg4'),
(404,'/lib/execute/execDashboard.php',1703848830,1703848830,3,'m0rsh552n46tllobmoqh11etg4'),
(405,'/lib/execute/execDashboard.php',1703848849,1703848849,3,'m0rsh552n46tllobmoqh11etg4'),
(406,'/lib/general/mainPage.php',1703848850,1703848850,3,'m0rsh552n46tllobmoqh11etg4'),
(407,'/lib/keywords/keywordsView.php',1703848862,1703848862,3,'m0rsh552n46tllobmoqh11etg4'),
(408,'/lib/general/mainPage.php',1703848865,1703848865,3,'m0rsh552n46tllobmoqh11etg4'),
(409,'/lib/execute/execDashboard.php',1703848874,1703848874,3,'m0rsh552n46tllobmoqh11etg4'),
(410,'/lib/execute/execDashboard.php',1703848874,1703848874,3,'m0rsh552n46tllobmoqh11etg4'),
(411,'/lib/general/mainPage.php',1703848884,1703848884,3,'m0rsh552n46tllobmoqh11etg4'),
(412,'/lib/testcases/listTestCases.php',1703848931,1703848931,3,'m0rsh552n46tllobmoqh11etg4'),
(413,'/lib/testcases/archiveData.php',1703848931,1703848931,3,'m0rsh552n46tllobmoqh11etg4'),
(414,'/lib/results/resultsNavigator.php',1703848944,1703848944,3,'m0rsh552n46tllobmoqh11etg4'),
(415,'/lib/general/mainPage.php',1703849000,1703849000,3,'m0rsh552n46tllobmoqh11etg4'),
(416,'/login.php',1703849036,1703849036,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(417,'/lib/general/mainPage.php',1703849036,1703849036,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(418,'/lib/usermanagement/usersView.php',1703849040,1703849040,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(419,'/lib/usermanagement/usersEdit.php',1703849049,1703849049,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(420,'/lib/usermanagement/rolesView.php',1703849062,1703849062,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(421,'/lib/usermanagement/rolesEdit.php',1703849088,1703849088,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(422,'/lib/usermanagement/rolesEdit.php',1703849174,1703849174,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(423,'/lib/usermanagement/usersEdit.php',1703849183,1703849183,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(424,'/lib/testcases/listTestCases.php',1703849229,1703849229,3,'m0rsh552n46tllobmoqh11etg4'),
(425,'/lib/testcases/archiveData.php',1703849229,1703849229,3,'m0rsh552n46tllobmoqh11etg4'),
(426,'/lib/project/projectView.php',1703849262,1703849262,3,'m0rsh552n46tllobmoqh11etg4'),
(427,'/lib/project/projectEdit.php',1703849298,1703849298,3,'m0rsh552n46tllobmoqh11etg4'),
(428,'/lib/plan/planAddTCNavigator.php',1703849336,1703849336,3,'m0rsh552n46tllobmoqh11etg4'),
(429,'/lib/requirements/reqSpecListTree.php',1703849401,1703849401,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(430,'/lib/requirements/reqSpecView.php',1703849411,1703849411,1,'48pe8rhtkg8d24ecepjt7srl6r'),
(431,'/lib/plan/planEdit.php',1703850135,1703850135,3,'m0rsh552n46tllobmoqh11etg4'),
(432,'/lib/plan/planEdit.php',1703850234,1703850234,3,'m0rsh552n46tllobmoqh11etg4'),
(433,'/login.php',1704083366,1704083366,3,'an1k77qssj10ueqinqbcprohn0'),
(434,'/lib/general/mainPage.php',1704083367,1704083367,3,'an1k77qssj10ueqinqbcprohn0'),
(435,'/lib/plan/planEdit.php',1704088119,1704088119,3,'an1k77qssj10ueqinqbcprohn0'),
(436,'/lib/results/resultsNavigator.php',1704088137,1704088137,3,'an1k77qssj10ueqinqbcprohn0'),
(437,'/lib/plan/planAddTCNavigator.php',1704088180,1704088180,3,'an1k77qssj10ueqinqbcprohn0'),
(438,'/lib/plan/planAddTCNavigator.php',1704088221,1704088221,3,'an1k77qssj10ueqinqbcprohn0'),
(439,'/lib/plan/planAddTCNavigator.php',1704088228,1704088228,3,'an1k77qssj10ueqinqbcprohn0'),
(440,'/lib/plan/planAddTCNavigator.php',1704088232,1704088232,3,'an1k77qssj10ueqinqbcprohn0'),
(441,'/lib/plan/planAddTCNavigator.php',1704088399,1704088399,3,'an1k77qssj10ueqinqbcprohn0'),
(442,'/lib/search/searchMgmt.php',1704088608,1704088608,3,'an1k77qssj10ueqinqbcprohn0'),
(443,'/lib/search/search.php',1704088608,1704088608,3,'an1k77qssj10ueqinqbcprohn0'),
(444,'/lib/requirements/reqSpecEdit.php',1704088650,1704088650,3,'an1k77qssj10ueqinqbcprohn0'),
(445,'/lib/project/projectView.php',1704088676,1704088676,3,'an1k77qssj10ueqinqbcprohn0'),
(446,'/lib/project/projectEdit.php',1704088704,1704088704,3,'an1k77qssj10ueqinqbcprohn0'),
(447,'/lib/project/projectEdit.php',1704088903,1704088903,3,'an1k77qssj10ueqinqbcprohn0'),
(448,'/lib/project/projectEdit.php',1704089211,1704089212,3,'an1k77qssj10ueqinqbcprohn0'),
(449,'/lib/general/navBar.php',1704089212,1704089212,3,'an1k77qssj10ueqinqbcprohn0'),
(450,'/lib/requirements/reqSpecEdit.php',1704089309,1704089309,3,'an1k77qssj10ueqinqbcprohn0'),
(451,'/lib/requirements/reqSpecEdit.php',1704089696,1704089696,3,'an1k77qssj10ueqinqbcprohn0'),
(452,'/lib/plan/planEdit.php',1704174149,1704174149,3,'an1k77qssj10ueqinqbcprohn0'),
(453,'/lib/plan/planEdit.php',1704174325,1704174325,3,'an1k77qssj10ueqinqbcprohn0'),
(454,'/lib/plan/planEdit.php',1704174331,1704174331,3,'an1k77qssj10ueqinqbcprohn0'),
(455,'/lib/plan/planEdit.php',1704175321,1704175321,3,'an1k77qssj10ueqinqbcprohn0'),
(456,'/lib/plan/planAddTCNavigator.php',1704175339,1704175339,3,'an1k77qssj10ueqinqbcprohn0'),
(457,'/lib/plan/planAddTCNavigator.php',1704175362,1704175362,3,'an1k77qssj10ueqinqbcprohn0'),
(458,'/lib/plan/planAddTC.php',1704175389,1704175389,3,'an1k77qssj10ueqinqbcprohn0'),
(459,'/lib/plan/planAddTC.php',1704175390,1704175390,3,'an1k77qssj10ueqinqbcprohn0'),
(460,'/lib/plan/planAddTC.php',1704175390,1704175390,3,'an1k77qssj10ueqinqbcprohn0'),
(461,'/lib/plan/planAddTCNavigator.php',1704175395,1704175395,3,'an1k77qssj10ueqinqbcprohn0'),
(462,'/lib/testcases/listTestCases.php',1704175421,1704175421,3,'an1k77qssj10ueqinqbcprohn0'),
(463,'/lib/testcases/archiveData.php',1704175421,1704175421,3,'an1k77qssj10ueqinqbcprohn0'),
(464,'/lib/plan/planAddTCNavigator.php',1704175439,1704175439,3,'an1k77qssj10ueqinqbcprohn0'),
(465,'/lib/plan/planAddTCNavigator.php',1704175453,1704175453,3,'an1k77qssj10ueqinqbcprohn0'),
(466,'/lib/plan/planAddTCNavigator.php',1704175688,1704175688,3,'an1k77qssj10ueqinqbcprohn0'),
(467,'/lib/plan/planAddTCNavigator.php',1704175695,1704175695,3,'an1k77qssj10ueqinqbcprohn0'),
(468,'/lib/plan/planAddTCNavigator.php',1704175706,1704175706,3,'an1k77qssj10ueqinqbcprohn0'),
(469,'/lib/plan/planEdit.php',1704175861,1704175861,3,'an1k77qssj10ueqinqbcprohn0'),
(470,'/lib/plan/planAddTCNavigator.php',1704175923,1704175923,3,'an1k77qssj10ueqinqbcprohn0'),
(471,'/lib/plan/planAddTCNavigator.php',1704175924,1704175924,3,'an1k77qssj10ueqinqbcprohn0'),
(472,'/lib/plan/planAddTCNavigator.php',1704175937,1704175937,3,'an1k77qssj10ueqinqbcprohn0'),
(473,'/lib/plan/planAddTCNavigator.php',1704175941,1704175941,3,'an1k77qssj10ueqinqbcprohn0'),
(474,'/lib/plan/planAddTCNavigator.php',1704175943,1704175943,3,'an1k77qssj10ueqinqbcprohn0'),
(475,'/lib/testcases/listTestCases.php',1704176013,1704176013,3,'an1k77qssj10ueqinqbcprohn0'),
(476,'/lib/testcases/archiveData.php',1704176013,1704176013,3,'an1k77qssj10ueqinqbcprohn0'),
(477,'/lib/testcases/listTestCases.php',1704176131,1704176131,3,'an1k77qssj10ueqinqbcprohn0'),
(478,'/lib/testcases/archiveData.php',1704176131,1704176131,3,'an1k77qssj10ueqinqbcprohn0'),
(479,'/lib/testcases/archiveData.php',1704176137,1704176137,3,'an1k77qssj10ueqinqbcprohn0'),
(480,'/lib/testcases/archiveData.php',1704176138,1704176138,3,'an1k77qssj10ueqinqbcprohn0'),
(481,'/lib/testcases/listTestCases.php',1704176146,1704176146,3,'an1k77qssj10ueqinqbcprohn0'),
(482,'/lib/testcases/listTestCases.php',1704176146,1704176146,3,'an1k77qssj10ueqinqbcprohn0'),
(483,'/lib/testcases/listTestCases.php',1704177074,1704177074,3,'an1k77qssj10ueqinqbcprohn0'),
(484,'/lib/requirements/reqSpecEdit.php',1704178029,1704178029,3,'an1k77qssj10ueqinqbcprohn0'),
(485,'/lib/requirements/reqSpecEdit.php',1704178078,1704178078,3,'an1k77qssj10ueqinqbcprohn0'),
(486,'/lib/requirements/reqSpecEdit.php',1704178152,1704178152,3,'an1k77qssj10ueqinqbcprohn0'),
(487,'/lib/requirements/reqSpecEdit.php',1704178157,1704178157,3,'an1k77qssj10ueqinqbcprohn0'),
(488,'/lib/requirements/reqSpecEdit.php',1704178222,1704178223,3,'an1k77qssj10ueqinqbcprohn0'),
(489,'/lib/requirements/reqSpecEdit.php',1704178322,1704178322,3,'an1k77qssj10ueqinqbcprohn0'),
(490,'/lib/requirements/reqEdit.php',1704178456,1704178456,3,'an1k77qssj10ueqinqbcprohn0'),
(491,'/lib/requirements/reqEdit.php',1704178565,1704178565,3,'an1k77qssj10ueqinqbcprohn0'),
(492,'/lib/requirements/reqEdit.php',1704178982,1704178982,3,'an1k77qssj10ueqinqbcprohn0'),
(493,'/lib/requirements/reqView.php',1704178982,1704178982,3,'an1k77qssj10ueqinqbcprohn0'),
(494,'/lib/testcases/listTestCases.php',1704179839,1704179839,3,'an1k77qssj10ueqinqbcprohn0'),
(495,'/lib/testcases/archiveData.php',1704179839,1704179839,3,'an1k77qssj10ueqinqbcprohn0'),
(496,'/lib/testcases/containerEdit.php',1704179913,1704179913,3,'an1k77qssj10ueqinqbcprohn0'),
(497,'/lib/testcases/listTestCases.php',1704179913,1704179913,3,'an1k77qssj10ueqinqbcprohn0'),
(498,'/lib/testcases/archiveData.php',1704179918,1704179918,3,'an1k77qssj10ueqinqbcprohn0'),
(499,'/lib/testcases/tcEdit.php',1704179924,1704179924,3,'an1k77qssj10ueqinqbcprohn0'),
(500,'/lib/testcases/listTestCases.php',1704181221,1704181221,3,'an1k77qssj10ueqinqbcprohn0'),
(501,'/lib/testcases/archiveData.php',1704181221,1704181221,3,'an1k77qssj10ueqinqbcprohn0'),
(502,'/lib/testcases/tcEdit.php',1704181231,1704181231,3,'an1k77qssj10ueqinqbcprohn0'),
(503,'/lib/testcases/tcEdit.php',1704181254,1704181254,3,'an1k77qssj10ueqinqbcprohn0'),
(504,'/lib/testcases/listTestCases.php',1704181254,1704181254,3,'an1k77qssj10ueqinqbcprohn0'),
(505,'/lib/testcases/tcEdit.php',1704181258,1704181258,3,'an1k77qssj10ueqinqbcprohn0'),
(506,'/lib/testcases/tcEdit.php',1704181279,1704181279,3,'an1k77qssj10ueqinqbcprohn0'),
(507,'/lib/testcases/tcEdit.php',1704181295,1704181295,3,'an1k77qssj10ueqinqbcprohn0'),
(508,'/lib/testcases/listTestCases.php',1704181295,1704181295,3,'an1k77qssj10ueqinqbcprohn0'),
(509,'/lib/testcases/tcEdit.php',1704181342,1704181342,3,'an1k77qssj10ueqinqbcprohn0'),
(510,'/lib/testcases/listTestCases.php',1704181342,1704181342,3,'an1k77qssj10ueqinqbcprohn0'),
(511,'/lib/testcases/tcEdit.php',1704181360,1704181360,3,'an1k77qssj10ueqinqbcprohn0'),
(512,'/lib/testcases/listTestCases.php',1704181361,1704181361,3,'an1k77qssj10ueqinqbcprohn0'),
(513,'/login.php',1704341126,1704341126,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(514,'/lib/general/mainPage.php',1704341127,1704341127,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(515,'/lib/testcases/listTestCases.php',1704343172,1704343172,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(516,'/lib/testcases/archiveData.php',1704343172,1704343172,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(517,'/lib/testcases/archiveData.php',1704343175,1704343175,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(518,'/lib/testcases/tcEdit.php',1704343261,1704343261,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(519,'/lib/testcases/listTestCases.php',1704343266,1704343266,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(520,'/lib/general/frmWorkArea.php',1704343341,1704343341,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(521,'/lib/plan/buildEdit.php',1704343345,1704343345,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(522,'/lib/plan/buildEdit.php',1704343469,1704343469,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(523,'/lib/plan/tc_exec_assignment.php',1704343514,1704343514,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(524,'/lib/testcases/archiveData.php',1704343694,1704343694,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(525,'/lib/usermanagement/userInfo.php',1704346089,1704346089,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(526,'/logout.php',1704346097,1704346097,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(527,'/login.php',1704346101,1704346101,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(528,'/lib/general/mainPage.php',1704346101,1704346101,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(529,'/lib/usermanagement/userInfo.php',1704346106,1704346106,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(530,'/lib/requirements/reqSpecListTree.php',1704346119,1704346120,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(531,'/lib/execute/execNavigator.php',1704346154,1704346154,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(532,'/lib/execute/execDashboard.php',1704346154,1704346154,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(533,'/lib/usermanagement/userInfo.php',1704346190,1704346190,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(534,'/lib/plan/planAddTCNavigator.php',1704348025,1704348025,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(535,'/lib/plan/planAddTCNavigator.php',1704354223,1704354223,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(536,'/lib/plan/planAddTCNavigator.php',1704354237,1704354237,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(537,'/lib/plan/planAddTC.php',1704354243,1704354243,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(538,'/lib/plan/planAddTC.php',1704354243,1704354243,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(539,'/lib/plan/planAddTCNavigator.php',1704354282,1704354282,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(540,'/lib/plan/planAddTC.php',1704354287,1704354287,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(541,'/lib/plan/planAddTC.php',1704354287,1704354287,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(542,'/lib/plan/planAddTC.php',1704354509,1704354509,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(543,'/lib/plan/planAddTCNavigator.php',1704354510,1704354510,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(544,'/lib/project/projectView.php',1704354884,1704354884,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(545,'/lib/project/projectEdit.php',1704354893,1704354893,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(546,'/lib/project/projectEdit.php',1704354904,1704354904,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(547,'/lib/execute/execSetResults.php',1704354953,1704354953,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(548,'/lib/execute/execSetResults.php',1704354953,1704354953,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(549,'/lib/execute/execSetResults.php',1704355016,1704355016,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(550,'/lib/execute/execSetResults.php',1704355022,1704355023,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(551,'/lib/execute/execSetResults.php',1704355106,1704355106,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(552,'/lib/execute/execSetResults.php',1704355135,1704355135,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(553,'/lib/execute/execSetResults.php',1704355176,1704355176,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(554,'/lib/plan/planEdit.php',1704355215,1704355215,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(555,'/lib/execute/execSetResults.php',1704355229,1704355230,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(556,'/lib/execute/execSetResults.php',1704355230,1704355230,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(557,'/lib/execute/execSetResults.php',1704355252,1704355252,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(558,'/lib/execute/execSetResults.php',1704355257,1704355257,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(559,'/lib/execute/execSetResults.php',1704355261,1704355261,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(560,'/lib/execute/execSetResults.php',1704355266,1704355266,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(561,'/lib/execute/execSetResults.php',1704355266,1704355266,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(562,'/lib/execute/execSetResults.php',1704355274,1704355274,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(563,'/lib/search/searchMgmt.php',1704355288,1704355288,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(564,'/lib/search/search.php',1704355288,1704355288,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(565,'/lib/results/metricsDashboard.php',1704359166,1704359166,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(566,'/login.php',1704359269,1704359269,0,NULL),
(567,'/login.php',1704359279,1704359279,0,NULL),
(568,'/login.php',1704359310,1704359310,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(569,'/lib/general/mainPage.php',1704359311,1704359311,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(570,'/lib/execute/execNavigator.php',1704359315,1704359315,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(571,'/lib/execute/execDashboard.php',1704359315,1704359315,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(572,'/lib/execute/execSetResults.php',1704359401,1704359401,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(573,'/lib/execute/execSetResults.php',1704359467,1704359467,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(574,'/lib/execute/execSetResults.php',1704359572,1704359572,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(575,'/lib/attachments/attachmentupload.php',1704359601,1704359601,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(576,'/lib/attachments/attachmentupload.php',1704359604,1704359604,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(577,'/lib/attachments/attachmentupload.php',1704359611,1704359611,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(578,'/lib/attachments/attachmentupload.php',1704359634,1704359634,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(579,'/lib/attachments/attachmentupload.php',1704359638,1704359639,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(580,'/lib/attachments/attachmentupload.php',1704359648,1704359648,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(581,'/lib/attachments/attachmentupload.php',1704359666,1704359667,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(582,'/lib/attachments/attachmentupload.php',1704359671,1704359671,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(583,'/lib/attachments/attachmentupload.php',1704359677,1704359677,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(584,'/lib/attachments/attachmentupload.php',1704359678,1704359678,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(585,'/lib/attachments/attachmentupload.php',1704359701,1704359701,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(586,'/lib/attachments/attachmentupload.php',1704359703,1704359703,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(587,'/lib/attachments/attachmentupload.php',1704359705,1704359705,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(588,'/lib/attachments/attachmentupload.php',1704359706,1704359706,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(589,'/lib/attachments/attachmentupload.php',1704359706,1704359706,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(590,'/lib/execute/execSetResults.php',1704359709,1704359709,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(591,'/lib/execute/execSetResults.php',1704359725,1704359725,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(592,'/lib/execute/execSetResults.php',1704359726,1704359726,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(593,'/lib/execute/execSetResults.php',1704359742,1704359742,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(594,'/lib/testcases/listTestCases.php',1704362448,1704362448,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(595,'/lib/testcases/archiveData.php',1704362448,1704362448,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(596,'/lib/requirements/reqView.php',1704362455,1704362455,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(597,'/lib/plan/planEdit.php',1704362463,1704362463,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(598,'/lib/testcases/listTestCases.php',1704362478,1704362478,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(599,'/lib/testcases/archiveData.php',1704362478,1704362478,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(600,'/lib/platforms/platformsView.php',1704362487,1704362487,1,'p1t4gp5pt9q1g4idhfqro7uce4'),
(601,'/lib/execute/execSetResults.php',1704363928,1704363928,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(602,'/lib/execute/execSetResults.php',1704363933,1704363933,3,'dcib0mosmv32r5jndcsm0dcg3j'),
(603,'/login.php',1705037423,1705037423,3,'khtp64o0da9g4e85cnshr4qf9e'),
(604,'/lib/general/mainPage.php',1705037424,1705037424,3,'khtp64o0da9g4e85cnshr4qf9e'),
(605,'/lib/plan/planAddTCNavigator.php',1705037472,1705037472,3,'khtp64o0da9g4e85cnshr4qf9e'),
(606,'/lib/plan/planAddTC.php',1705037705,1705037705,3,'khtp64o0da9g4e85cnshr4qf9e'),
(607,'/login.php',1705386265,1705386265,3,'3itjeak5fp5qtssn4iqugnhirf'),
(608,'/lib/general/mainPage.php',1705386265,1705386265,3,'3itjeak5fp5qtssn4iqugnhirf'),
(609,'/lib/testcases/listTestCases.php',1705386360,1705386360,3,'3itjeak5fp5qtssn4iqugnhirf'),
(610,'/lib/testcases/archiveData.php',1705386360,1705386360,3,'3itjeak5fp5qtssn4iqugnhirf'),
(611,'/lib/testcases/archiveData.php',1705387107,1705387107,3,'3itjeak5fp5qtssn4iqugnhirf'),
(612,'/lib/testcases/containerEdit.php',1705387176,1705387176,3,'3itjeak5fp5qtssn4iqugnhirf'),
(613,'/lib/testcases/listTestCases.php',1705387176,1705387176,3,'3itjeak5fp5qtssn4iqugnhirf'),
(614,'/lib/testcases/archiveData.php',1705387181,1705387181,3,'3itjeak5fp5qtssn4iqugnhirf'),
(615,'/lib/testcases/tcEdit.php',1705387185,1705387185,3,'3itjeak5fp5qtssn4iqugnhirf'),
(616,'/lib/testcases/tcEdit.php',1705387330,1705387330,3,'3itjeak5fp5qtssn4iqugnhirf'),
(617,'/lib/testcases/listTestCases.php',1705387330,1705387330,3,'3itjeak5fp5qtssn4iqugnhirf'),
(618,'/lib/testcases/tcEdit.php',1705387335,1705387335,3,'3itjeak5fp5qtssn4iqugnhirf'),
(619,'/lib/testcases/tcEdit.php',1705387381,1705387381,3,'3itjeak5fp5qtssn4iqugnhirf'),
(620,'/lib/testcases/tcEdit.php',1705387384,1705387384,3,'3itjeak5fp5qtssn4iqugnhirf'),
(621,'/lib/testcases/tcEdit.php',1705387432,1705387432,3,'3itjeak5fp5qtssn4iqugnhirf'),
(622,'/lib/testcases/tcEdit.php',1705389565,1705389565,3,'3itjeak5fp5qtssn4iqugnhirf'),
(623,'/lib/testcases/tcImport.php',1705389740,1705389740,3,'3itjeak5fp5qtssn4iqugnhirf'),
(624,'/lib/testcases/archiveData.php',1705467385,1705467385,3,'3itjeak5fp5qtssn4iqugnhirf'),
(625,'/lib/testcases/listTestCases.php',1705467386,1705467386,3,'3itjeak5fp5qtssn4iqugnhirf'),
(626,'/lib/testcases/listTestCases.php',1705467442,1705467442,3,'3itjeak5fp5qtssn4iqugnhirf'),
(627,'/lib/testcases/tcBulkOp.php',1705467458,1705467458,3,'3itjeak5fp5qtssn4iqugnhirf'),
(628,'/lib/testcases/archiveData.php',1705467463,1705467463,3,'3itjeak5fp5qtssn4iqugnhirf'),
(629,'/lib/testcases/listTestCases.php',1705467501,1705467501,3,'3itjeak5fp5qtssn4iqugnhirf'),
(630,'/login.php',1705898943,1705898943,3,'ne3khg70a6qdjfbjqu3ngjlemh'),
(631,'/lib/general/mainPage.php',1705898943,1705898943,3,'ne3khg70a6qdjfbjqu3ngjlemh'),
(632,'/login.php',1705988162,1705988162,1,'4rpodv26epfk00q98b5t5g4pmu'),
(633,'/lib/general/mainPage.php',1705988162,1705988162,1,'4rpodv26epfk00q98b5t5g4pmu'),
(634,'/lib/usermanagement/userInfo.php',1705988177,1705988177,1,'4rpodv26epfk00q98b5t5g4pmu'),
(635,'/lib/usermanagement/usersView.php',1705988181,1705988181,1,'4rpodv26epfk00q98b5t5g4pmu'),
(636,'/lib/execute/execNavigator.php',1705988191,1705988191,1,'4rpodv26epfk00q98b5t5g4pmu'),
(637,'/lib/execute/execDashboard.php',1705988191,1705988191,1,'4rpodv26epfk00q98b5t5g4pmu'),
(638,'/lib/testcases/listTestCases.php',1705988194,1705988194,1,'4rpodv26epfk00q98b5t5g4pmu'),
(639,'/lib/testcases/archiveData.php',1705988194,1705988194,1,'4rpodv26epfk00q98b5t5g4pmu');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `tsuites_tree_depth_2`
--

DROP TABLE IF EXISTS `tsuites_tree_depth_2`;
/*!50001 DROP VIEW IF EXISTS `tsuites_tree_depth_2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `tsuites_tree_depth_2` AS SELECT
 1 AS `prefix`,
  1 AS `testproject_name`,
  1 AS `level1_name`,
  1 AS `level2_name`,
  1 AS `testproject_id`,
  1 AS `level1_id`,
  1 AS `level2_id` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user_assignments`
--

DROP TABLE IF EXISTS `user_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_assignments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(10) unsigned NOT NULL DEFAULT 1,
  `feature_id` int(10) unsigned NOT NULL DEFAULT 0,
  `user_id` int(10) unsigned DEFAULT 0,
  `build_id` int(10) unsigned DEFAULT 0,
  `deadline_ts` datetime DEFAULT NULL,
  `assigner_id` int(10) unsigned DEFAULT 0,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(10) unsigned DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `user_assignments_feature_id` (`feature_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_assignments`
--

LOCK TABLES `user_assignments` WRITE;
/*!40000 ALTER TABLE `user_assignments` DISABLE KEYS */;
INSERT INTO `user_assignments` VALUES
(9,1,9,3,2,NULL,3,'2024-01-04 07:48:29',1),
(10,1,10,3,2,NULL,3,'2024-01-04 07:48:29',1);
/*!40000 ALTER TABLE `user_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_group` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group_assign`
--

DROP TABLE IF EXISTS `user_group_assign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group_assign` (
  `usergroup_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `idx_user_group_assign` (`usergroup_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group_assign`
--

LOCK TABLES `user_group_assign` WRITE;
/*!40000 ALTER TABLE `user_group_assign` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group_assign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_testplan_roles`
--

DROP TABLE IF EXISTS `user_testplan_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_testplan_roles` (
  `user_id` int(10) NOT NULL DEFAULT 0,
  `testplan_id` int(10) NOT NULL DEFAULT 0,
  `role_id` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`,`testplan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_testplan_roles`
--

LOCK TABLES `user_testplan_roles` WRITE;
/*!40000 ALTER TABLE `user_testplan_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_testplan_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_testproject_roles`
--

DROP TABLE IF EXISTS `user_testproject_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_testproject_roles` (
  `user_id` int(10) NOT NULL DEFAULT 0,
  `testproject_id` int(10) NOT NULL DEFAULT 0,
  `role_id` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`,`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_testproject_roles`
--

LOCK TABLES `user_testproject_roles` WRITE;
/*!40000 ALTER TABLE `user_testproject_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_testproject_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `role_id` int(10) unsigned NOT NULL DEFAULT 0,
  `email` varchar(100) NOT NULL DEFAULT '',
  `first` varchar(50) NOT NULL DEFAULT '',
  `last` varchar(50) NOT NULL DEFAULT '',
  `locale` varchar(10) NOT NULL DEFAULT 'en_GB',
  `default_testproject_id` int(10) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `script_key` varchar(32) DEFAULT NULL,
  `cookie_string` varchar(64) NOT NULL DEFAULT '',
  `auth_method` varchar(10) DEFAULT '',
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `expiration_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_login` (`login`),
  UNIQUE KEY `users_cookie_string` (`cookie_string`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='User information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'admin','$2y$10$UBLAf8p02QPQumS/PtZwY.xUmbnedE1RBzV8lqp8SpuzuzTxbpFB.',8,'khazi.devops@gmail.com','admin','Administrator','en_US',NULL,1,NULL,'c34c0da7d4a07e645341d155daed2c3278ffe563e03d3ece400b6e6db6441c87','','2023-12-20 10:54:37',NULL),
(2,'rj.ravindra@kenestechnology.net','$2y$10$tGTSfrobpgOsTi0nQyxBfe0yCQM/gyNfekdN.68OkiLYlO8YrZaYW',6,'rj.ravindra@kenestechnology.net','Ravindra','Reddy J','en_US',NULL,1,'f1c5ed8c637356366a24751515814140','4098356de49ad07989b6ab119830cf671db5fa87c73302f666cf0fdfd08b8437','','2023-12-20 12:01:39',NULL),
(3,'v.bhavana@Kaynestechnology.net','$2y$10$1rQUiYx7pfgI2.zuuwMFhe4huhfaChyXHq8eRbapyQ8.MkoBS.Pn2',1,'v.bhavana@Kaynestechnology.net','Vaddadi','Bhavana','en_US',NULL,1,NULL,'e821280ca2f4d2cc822b22d1eed054dbfe7bbeb2d60a5f869255668a42322ea2','','2023-12-29 09:40:22',NULL),
(4,'suneel.duth@kaynestechnology.net','$2y$10$sg.t490dAfFESMT17u/Z4OP9yHr230CpJATpJmfcvdgGug93/JKwO',7,'suneel.duth@kaynestechnology.net','Dusara','Suneelduth','en_US',NULL,1,NULL,'39f55cf5fae32cac57f1556c92fe88aff2d1bd8bb8a38fe55b83d4c96b571c13','','2023-12-29 09:41:31',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `exec_by_date_time`
--

/*!50001 DROP VIEW IF EXISTS `exec_by_date_time`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tl_testlink`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `exec_by_date_time` AS (select `NHTPL`.`name` AS `testplan_name`,date_format(`E`.`execution_ts`,'%Y-%m-%d') AS `yyyy_mm_dd`,date_format(`E`.`execution_ts`,'%Y-%m') AS `yyyy_mm`,date_format(`E`.`execution_ts`,'%H') AS `hh`,date_format(`E`.`execution_ts`,'%k') AS `hour`,`E`.`id` AS `id`,`E`.`build_id` AS `build_id`,`E`.`tester_id` AS `tester_id`,`E`.`execution_ts` AS `execution_ts`,`E`.`status` AS `status`,`E`.`testplan_id` AS `testplan_id`,`E`.`tcversion_id` AS `tcversion_id`,`E`.`tcversion_number` AS `tcversion_number`,`E`.`platform_id` AS `platform_id`,`E`.`execution_type` AS `execution_type`,`E`.`execution_duration` AS `execution_duration`,`E`.`notes` AS `notes` from ((`executions` `E` join `testplans` `TPL` on(`TPL`.`id` = `E`.`testplan_id`)) join `nodes_hierarchy` `NHTPL` on(`NHTPL`.`id` = `TPL`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `latest_exec_by_context`
--

/*!50001 DROP VIEW IF EXISTS `latest_exec_by_context`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tl_testlink`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_exec_by_context` AS select `executions`.`tcversion_id` AS `tcversion_id`,`executions`.`testplan_id` AS `testplan_id`,`executions`.`build_id` AS `build_id`,`executions`.`platform_id` AS `platform_id`,max(`executions`.`id`) AS `id` from `executions` group by `executions`.`tcversion_id`,`executions`.`testplan_id`,`executions`.`build_id`,`executions`.`platform_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `latest_exec_by_testplan`
--

/*!50001 DROP VIEW IF EXISTS `latest_exec_by_testplan`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tl_testlink`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_exec_by_testplan` AS select `executions`.`tcversion_id` AS `tcversion_id`,`executions`.`testplan_id` AS `testplan_id`,max(`executions`.`id`) AS `id` from `executions` group by `executions`.`tcversion_id`,`executions`.`testplan_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `latest_exec_by_testplan_plat`
--

/*!50001 DROP VIEW IF EXISTS `latest_exec_by_testplan_plat`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tl_testlink`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_exec_by_testplan_plat` AS select `executions`.`tcversion_id` AS `tcversion_id`,`executions`.`testplan_id` AS `testplan_id`,`executions`.`platform_id` AS `platform_id`,max(`executions`.`id`) AS `id` from `executions` group by `executions`.`tcversion_id`,`executions`.`testplan_id`,`executions`.`platform_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `latest_req_version`
--

/*!50001 DROP VIEW IF EXISTS `latest_req_version`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tl_testlink`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_req_version` AS select `RQ`.`id` AS `req_id`,max(`RQV`.`version`) AS `version` from ((`nodes_hierarchy` `NHRQV` join `requirements` `RQ` on(`RQ`.`id` = `NHRQV`.`parent_id`)) join `req_versions` `RQV` on(`RQV`.`id` = `NHRQV`.`id`)) group by `RQ`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `latest_req_version_id`
--

/*!50001 DROP VIEW IF EXISTS `latest_req_version_id`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tl_testlink`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_req_version_id` AS select `LRQVN`.`req_id` AS `req_id`,`LRQVN`.`version` AS `version`,`REQV`.`id` AS `req_version_id` from ((`latest_req_version` `LRQVN` join `nodes_hierarchy` `NHRQV` on(`NHRQV`.`parent_id` = `LRQVN`.`req_id`)) join `req_versions` `REQV` on(`REQV`.`id` = `NHRQV`.`id` and `REQV`.`version` = `LRQVN`.`version`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `latest_rspec_revision`
--

/*!50001 DROP VIEW IF EXISTS `latest_rspec_revision`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tl_testlink`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_rspec_revision` AS select `RSR`.`parent_id` AS `req_spec_id`,`RS`.`testproject_id` AS `testproject_id`,max(`RSR`.`revision`) AS `revision` from (`req_specs_revisions` `RSR` join `req_specs` `RS` on(`RS`.`id` = `RSR`.`parent_id`)) group by `RSR`.`parent_id`,`RS`.`testproject_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `latest_tcase_version_id`
--

/*!50001 DROP VIEW IF EXISTS `latest_tcase_version_id`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tl_testlink`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_tcase_version_id` AS select `LTCVN`.`testcase_id` AS `testcase_id`,`LTCVN`.`version` AS `version`,`TCV`.`id` AS `tcversion_id` from ((`latest_tcase_version_number` `LTCVN` join `nodes_hierarchy` `NHTCV` on(`NHTCV`.`parent_id` = `LTCVN`.`testcase_id`)) join `tcversions` `TCV` on(`TCV`.`id` = `NHTCV`.`id` and `TCV`.`version` = `LTCVN`.`version`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `latest_tcase_version_number`
--

/*!50001 DROP VIEW IF EXISTS `latest_tcase_version_number`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tl_testlink`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_tcase_version_number` AS select `NH_TC`.`id` AS `testcase_id`,max(`TCV`.`version`) AS `version` from ((`nodes_hierarchy` `NH_TC` join `nodes_hierarchy` `NH_TCV` on(`NH_TCV`.`parent_id` = `NH_TC`.`id`)) join `tcversions` `TCV` on(`NH_TCV`.`id` = `TCV`.`id`)) group by `NH_TC`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tcversions_without_keywords`
--

/*!50001 DROP VIEW IF EXISTS `tcversions_without_keywords`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tl_testlink`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `tcversions_without_keywords` AS select `NHTCV`.`parent_id` AS `testcase_id`,`NHTCV`.`id` AS `id` from `nodes_hierarchy` `NHTCV` where `NHTCV`.`node_type_id` = 4 and !exists(select 1 from `testcase_keywords` `TCK` where `TCK`.`tcversion_id` = `NHTCV`.`id` limit 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tcversions_without_platforms`
--

/*!50001 DROP VIEW IF EXISTS `tcversions_without_platforms`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tl_testlink`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `tcversions_without_platforms` AS select `NHTCV`.`parent_id` AS `testcase_id`,`NHTCV`.`id` AS `id` from `nodes_hierarchy` `NHTCV` where `NHTCV`.`node_type_id` = 4 and !exists(select 1 from `testcase_platforms` `TCPL` where `TCPL`.`tcversion_id` = `NHTCV`.`id` limit 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tsuites_tree_depth_2`
--

/*!50001 DROP VIEW IF EXISTS `tsuites_tree_depth_2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tl_testlink`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `tsuites_tree_depth_2` AS select `TPRJ`.`prefix` AS `prefix`,`NHTPRJ`.`name` AS `testproject_name`,`NHTS_L1`.`name` AS `level1_name`,`NHTS_L2`.`name` AS `level2_name`,`NHTPRJ`.`id` AS `testproject_id`,`NHTS_L1`.`id` AS `level1_id`,`NHTS_L2`.`id` AS `level2_id` from (((`testprojects` `TPRJ` join `nodes_hierarchy` `NHTPRJ` on(`TPRJ`.`id` = `NHTPRJ`.`id`)) left join `nodes_hierarchy` `NHTS_L1` on(`NHTS_L1`.`parent_id` = `NHTPRJ`.`id`)) left join `nodes_hierarchy` `NHTS_L2` on(`NHTS_L2`.`parent_id` = `NHTS_L1`.`id`)) where `NHTPRJ`.`node_type_id` = 1 and `NHTS_L1`.`node_type_id` = 2 and `NHTS_L2`.`node_type_id` = 2 */;
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

-- Dump completed on 2024-01-23  9:02:35
