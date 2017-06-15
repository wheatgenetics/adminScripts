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

 Date: 04/21/2015 14:00:28 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `phemu_images`
-- ----------------------------
DROP TABLE IF EXISTS `phemu_images`;
CREATE TABLE `phemu_images` (
  `record_id` double(255,0) NOT NULL AUTO_INCREMENT,
  `image_file_name` text,
  `run_id` text,
  `sensor_id` text,
  `entity_id` char(10) DEFAULT NULL,
  `absolute_sensor_position_x` double(255,5) DEFAULT NULL,
  `absolute_sensor_position_y` double(255,5) DEFAULT NULL,
  `absolute_sensor_position_z` double(255,5) DEFAULT NULL,
  `sampling_time` time DEFAULT NULL,
  `sampling_date` date DEFAULT NULL,
  `left_utc` double(255,5) DEFAULT NULL,
  `left_elevation` double(255,5) DEFAULT NULL,
  `left_long` double(255,7) DEFAULT NULL,
  `left_lat` double(255,7) DEFAULT NULL,
  `long_zone` text,
  `lat_zone` text,
  `left_utm_x` double(255,5) DEFAULT NULL,
  `left_utm_y` double(255,5) DEFAULT NULL,
  `right_utc` double(255,5) DEFAULT NULL,
  `right_elevation` double(255,5) DEFAULT NULL,
  `right_long` double(255,7) DEFAULT NULL,
  `right_lat` double(255,7) DEFAULT NULL,
  `right_utm_x` double(255,5) DEFAULT NULL,
  `right_utm_y` double(255,5) DEFAULT NULL,
  `sensor_offset_x_from_left_gps` double(255,5) DEFAULT NULL,
  `sensor_offset_y_from_left_gps` double(255,5) DEFAULT NULL,
  `sensor_offset_z_from_left_gps` double(255,5) DEFAULT NULL,
  `notes` longtext,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

SET FOREIGN_KEY_CHECKS = 1;
