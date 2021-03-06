-- MySQL dump 10.9
--
-- Host: localhost    Database: optik_dev
-- ------------------------------------------------------
-- Server version	4.1.15-standard

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `engine_schema_info`
--

DROP TABLE IF EXISTS `engine_schema_info`;
CREATE TABLE `engine_schema_info` (
  `engine_name` varchar(255) default NULL,
  `version` int(11) default NULL
);

--
-- Dumping data for table `engine_schema_info`
--


/*!40000 ALTER TABLE `engine_schema_info` DISABLE KEYS */;
INSERT INTO `engine_schema_info` VALUES ('login_engine',1);
/*!40000 ALTER TABLE `engine_schema_info` ENABLE KEYS */;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
CREATE TABLE `notes` (
  `id` mediumint(11) PRIMARY KEY,
  `content` text,
  `ticket_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL
);


--
-- Table structure for table `schema_info`
--

DROP TABLE IF EXISTS `schema_info`;
CREATE TABLE `schema_info` (
  `version` int(11) default NULL
);

--
-- Dumping data for table `schema_info`
--


/*!40000 ALTER TABLE `schema_info` DISABLE KEYS */;
INSERT INTO `schema_info` VALUES (8);
/*!40000 ALTER TABLE `schema_info` ENABLE KEYS */;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
CREATE TABLE `states` (
  `id` INTEGER PRIMARY KEY,
  `description` varchar(255) default NULL,
  `priority` int(11) default NULL
);

--
-- Dumping data for table `states`
--


/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` VALUES (1,'Pending',1);
INSERT INTO `states` VALUES (2,'In Progress',2);
INSERT INTO `states` VALUES (3,'Waiting',3);
INSERT INTO `states` VALUES (4,'Scheduled',4);
INSERT INTO `states` VALUES (5,'Completed',5);
INSERT INTO `states` VALUES (6,'Archived',6);
/*!40000 ALTER TABLE `states` ENABLE KEYS */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` INTEGER PRIMARY KEY,
  `name` varchar(255) default NULL
);

--
-- Table structure for table `tags_tickets`
--

DROP TABLE IF EXISTS `tags_tickets`;
CREATE TABLE `tags_tickets` (
  `ticket_id` int(11) default NULL,
  `tag_id` int(11) default NULL
);


--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
CREATE TABLE `tickets` (
  `id` INTEGER PRIMARY KEY,
  `description` varchar(255) default NULL,
  `user_id` int(11) default NULL,
  `state_id` int(11) default NULL,
  `parts` varchar(255) default NULL,
  `referrals` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL
);


--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` INTEGER PRIMARY KEY,
  `login` varchar(80) NOT NULL default '',
  `salted_password` varchar(40) NOT NULL default '',
  `email` varchar(60) NOT NULL default '',
  `firstname` varchar(40) default NULL,
  `lastname` varchar(40) default NULL,
  `salt` varchar(40) NOT NULL default '',
  `verified` int(11) default '0',
  `role` varchar(40) default NULL,
  `security_token` varchar(40) default NULL,
  `token_expiry` datetime default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `logged_in_at` datetime default NULL,
  `deleted` int(11) default '0',
  `delete_after` datetime default NULL
);

