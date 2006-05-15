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
INSERT INTO `schema_info` VALUES (8);
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
INSERT INTO `tags` VALUES (1,'test'),(2,'blue'),(3,'gold'),(4,'Oh'),(5,'yeah');
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
INSERT INTO `tags_tickets` VALUES (1,1),(1,2),(1,3),(2,4),(2,5);
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
INSERT INTO `tickets` VALUES (1,'test1',1,4,'2006-04-24 10:58:25','2006-04-24 10:59:33'),(2,'Just need to add some more functionality to this ticket system, make it easier to use!',1,2,'2006-05-02 15:28:04','2006-05-02 15:28:14');
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
INSERT INTO `users` VALUES (1,'jonmagic','5adb3a5d976ecfe532e3671ffad52dfd6f706473','jonmagic','Jonathan','Hoyt','67e0816c0e84e52aa3db2b225ca2602b664f046e',1,NULL,'19a653a5b6036850679628b00afaf79d86a59324','2006-04-25 10:58:05','2006-04-24 10:58:05','2006-05-02 15:23:24','2006-05-02 15:23:24',0,NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

