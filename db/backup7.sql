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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `engine_schema_info`
--


/*!40000 ALTER TABLE `engine_schema_info` DISABLE KEYS */;
LOCK TABLES `engine_schema_info` WRITE;
INSERT INTO `engine_schema_info` VALUES ('login_engine',1);
UNLOCK TABLES;
/*!40000 ALTER TABLE `engine_schema_info` ENABLE KEYS */;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL auto_increment,
  `content` text,
  `ticket_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notes`
--


/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
LOCK TABLES `notes` WRITE;
INSERT INTO `notes` VALUES (1,'Just a test',5,1,'2006-03-13 23:46:43','2006-03-13 23:46:43'),(2,'This is a test\n\nagin\n\nwhat if i want a popsicle?\n\n*how bout this*',5,1,'2006-03-13 23:47:51','2006-03-13 23:47:51'),(3,'test',5,1,'2006-03-13 23:52:17','2006-03-13 23:52:17'),(4,'testing again',5,1,'2006-03-13 23:56:54','2006-03-13 23:56:54'),(5,'I think I need to go get some -icecream- before the game...',5,1,'2006-03-14 09:44:32','2006-03-14 09:44:32'),(6,'ok, i\'ve built the base system with basic functionality. this biggest thing right now is getting the search to work...',4,1,'2006-03-14 16:03:15','2006-03-14 16:03:15');
UNLOCK TABLES;
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;

--
-- Table structure for table `schema_info`
--

DROP TABLE IF EXISTS `schema_info`;
CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schema_info`
--


/*!40000 ALTER TABLE `schema_info` DISABLE KEYS */;
LOCK TABLES `schema_info` WRITE;
INSERT INTO `schema_info` VALUES (7);
UNLOCK TABLES;
/*!40000 ALTER TABLE `schema_info` ENABLE KEYS */;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
CREATE TABLE `states` (
  `id` int(11) NOT NULL auto_increment,
  `description` varchar(255) default NULL,
  `priority` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `states`
--


/*!40000 ALTER TABLE `states` DISABLE KEYS */;
LOCK TABLES `states` WRITE;
INSERT INTO `states` VALUES (1,'Pending',1),(2,'In Progress',2),(3,'Waiting',3),(4,'Scheduled',4),(5,'Completed',5),(6,'Archived',6);
UNLOCK TABLES;
/*!40000 ALTER TABLE `states` ENABLE KEYS */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tags`
--


/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
LOCK TABLES `tags` WRITE;
INSERT INTO `tags` VALUES (2,'test'),(3,'programming'),(4,'stuff'),(5,'ticket'),(6,'SabreTech'),(7,'optik'),(8,'software'),(9,'rails');
UNLOCK TABLES;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;

--
-- Table structure for table `tags_tickets`
--

DROP TABLE IF EXISTS `tags_tickets`;
CREATE TABLE `tags_tickets` (
  `ticket_id` int(11) default NULL,
  `tag_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tags_tickets`
--


/*!40000 ALTER TABLE `tags_tickets` DISABLE KEYS */;
LOCK TABLES `tags_tickets` WRITE;
INSERT INTO `tags_tickets` VALUES (4,3),(4,7),(4,9),(7,2),(8,2),(6,6),(6,7),(6,9),(6,3),(5,7),(5,8),(5,9);
UNLOCK TABLES;
/*!40000 ALTER TABLE `tags_tickets` ENABLE KEYS */;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
CREATE TABLE `tickets` (
  `id` int(11) NOT NULL auto_increment,
  `description` varchar(255) default NULL,
  `user_id` int(11) default NULL,
  `state_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tickets`
--


/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
LOCK TABLES `tickets` WRITE;
INSERT INTO `tickets` VALUES (4,'Build opportunity ticket system.',1,2,'2006-03-10 16:53:13','2006-03-14 16:02:19'),(5,'Start this application with limited functionality and limited interface and see where it goes...',1,2,'2006-03-10 17:09:05','2006-03-14 17:17:13'),(6,'Lets add user preferences to this nice little app. So you can set which tickets you want to see on your My Tickets page and do other little cool things :-)',1,2,'2006-03-13 15:22:12','2006-03-14 16:47:50'),(7,'test archived',1,6,'2006-03-14 16:37:20','2006-03-14 16:37:20'),(8,'test archived',1,6,'2006-03-14 16:37:35','2006-03-14 16:37:35');
UNLOCK TABLES;
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
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
  `delete_after` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--


/*!40000 ALTER TABLE `users` DISABLE KEYS */;
LOCK TABLES `users` WRITE;
INSERT INTO `users` VALUES (1,'jonmagic','0f51a388693a3b6fe61117dbebd0f85e534486a9','jonmagic@gmail.com','Jonathan','Hoyt','c508657a4404f708076b3adc94ca29d694618fb2',1,NULL,'764ea16678a44a31eb6080b671f47bd05fe354f2','2006-03-11 15:31:57','2006-03-10 15:31:57','2006-03-14 17:30:38','2006-03-14 17:30:37',0,NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

