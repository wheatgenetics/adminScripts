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

*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `phenocorn_images`
-- ----------------------------
DROP TABLE IF EXISTS `phenocorn_images`;
CREATE TABLE `phenocorn_images` (
  `sequence_number` double(255,0) NOT NULL AUTO_INCREMENT,
  `image_file_name` text,
  `run_id` text,
  `sensor_id` text,
  `absolute_sensor_position_x` double(255,5) DEFAULT NULL,
  `absolute_sensor_position_y` double(255,5) DEFAULT NULL,
  `absolute_sensor_position_z` double(255,5) DEFAULT NULL,
  `lat_zone` text,
  `long_zone` text,
  `longitude` double(255,7) DEFAULT NULL,
  `latitude` double(255,7) DEFAULT NULL,
  `sampling_date` date DEFAULT NULL,
  `sampling_time` time DEFAULT NULL,
  `md5sum` varchar(50) DEFAULT NULL,
  `notes` longtext,
  PRIMARY KEY (`sequence_number`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;
