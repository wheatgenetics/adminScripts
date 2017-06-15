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

 Date: 02/26/2015 11:45:30 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `phenocam_images`
-- ----------------------------
DROP TABLE IF EXISTS `phenocam_images`;
CREATE TABLE `phenocam_images` (
  `record_id` double(255,0) NOT NULL AUTO_INCREMENT,
  `image_file_name` text,
  `run_id` text,
  `sensor_id` text,
  `sensor_position_x` double(255,5) DEFAULT NULL,
  `sensor_position_y` double(255,5) DEFAULT NULL,
  `sensor_position_z` double(255,5) DEFAULT NULL,
  `lat_zone` text,
  `long_zone` text,
  `sampling_date` date DEFAULT NULL,
  `sampling_time` time DEFAULT NULL,
  `md5sum` varchar(50) DEFAULT NULL,
  `notes` longtext,
  PRIMARY KEY (`record_id`),
  KEY `sensor_position_x` (`sensor_position_x`),
  KEY `sensor_position_y` (`sensor_position_y`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;
