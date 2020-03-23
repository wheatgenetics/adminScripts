/*
 Navicat MySQL Data Transfer

 Source Server         : wheatgenetics_local
 Source Server Type    : MySQL
 Source Server Version : 50620
 Source Host           : localhost
 Source Database       : wheatgenetics_local

 Target Server Type    : MySQL
 Target Server Version : 50620
 File Encoding         : utf-8

 Date: 04/28/2015 15:47:34 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `uas_run_new`
-- ----------------------------
DROP TABLE IF EXISTS `uas_run_new`;
CREATE TABLE `uas_run_new` (
  `record_id` double(255,0) NOT NULL AUTO_INCREMENT,
  `flight_id` varchar(50) NOT NULL,
  `start_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_date` date NOT NULL,
  `end_time` time NOT NULL,
  `flight_filename` text NOT NULL,
  `md5sum` varchar(50) NOT NULL,
  `sensor_id` text DEFAULT NULL,
  `experiment_id` varchar(50) DEFAULT NULL,
  `planned_elevation_m` decimal(5.2) DEFAULT NULL,
  `uas_x_min` double(255,7) DEFAULT NULL,
  `uas_x_max` double(255,7) DEFAULT NULL,
  `uas_y_min` double(255,7) DEFAULT NULL,
  `uas_y_max` double(255,7) DEFAULT NULL,
  `cam_x_min` double(255,7) DEFAULT NULL,
  `cam_x_max` double(255,7) DEFAULT NULL,
  `cam_y_min` double(255,7) DEFAULT NULL,
  `cam_y_max` double(255,7) DEFAULT NULL,
  `location` varchar(20) DEFAULT NULL,
  `region` varchar(20) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `notes` longtext,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;
