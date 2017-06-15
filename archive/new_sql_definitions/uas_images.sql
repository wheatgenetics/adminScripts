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

 Date: 02/26/2015 11:42:14 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `uas_images`
-- ----------------------------
DROP TABLE IF EXISTS `uas_images`;
CREATE TABLE `uas_images` (
  `record_id` double(255,0) NOT NULL AUTO_INCREMENT,
  `image_file_name` text,
  `flight_id` text,
  `sensor_id` text,
  `uas_position_x` double(255,5) DEFAULT NULL,
  `uas_position_y` double(255,5) DEFAULT NULL,
  `uas_position_z` double(255,5) DEFAULT NULL,
  `camera_position_x` double(255,5) DEFAULT NULL,
  `camera_position_y` double(255,5) DEFAULT NULL,
  `camera_position_z` double(255,5) DEFAULT NULL,
  `lat_zone` text,
  `long_zone` text,
  `longitude` double(255,7) DEFAULT NULL,
  `latitude` double(255,7) DEFAULT NULL,
  `sampling_date` date DEFAULT NULL,
  `sampling_time` time DEFAULT NULL,
  `md5sum` varchar(50) DEFAULT NULL,
  `notes` longtext,
  PRIMARY KEY (`record_id`),
  KEY `uas_position_x` (`uas_position_x`),
  KEY `uas_position_y` (`uas_position_y`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;
