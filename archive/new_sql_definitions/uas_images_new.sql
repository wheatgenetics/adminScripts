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
--  Table structure for `uas_images_new`
-- ----------------------------
DROP TABLE IF EXISTS `uas_images_new`;
CREATE TABLE `uas_images_new` (
  `record_id` double(255,0) NOT NULL AUTO_INCREMENT,
  `image_file_name` text,
  `flight_id` text,
  `sensor_id` text,
  `uas_position_x` double(255,5) DEFAULT NULL,
  `uas_position_y` double(255,5) DEFAULT NULL,
  `uas_position_z` double(255,5) DEFAULT NULL,
  `uas_latitude` double(255,7) DEFAULT NULL,
  `uas_longitude` double(255,7) DEFAULT NULL,
  `uas_sampling_date_utc` date DEFAULT NULL,
  `uas_sampling_time_utc` time DEFAULT NULL,
  `uas_lat_zone` text DEFAULT NULL,
  `uas_long_zone` text DEFAULT NULL,
  `uas_altitude_reference` text DEFAULT NULL,
  `cam_position_x` double(255,5) DEFAULT NULL,
  `cam_position_y` double(255,5) DEFAULT NULL,
  `cam_position_z` double(255,5) DEFAULT NULL,
  `cam_latitude` double(255,7) DEFAULT NULL,
  `cam_longitude` double(255,7) DEFAULT NULL,
  `cam_sampling_date_utc` date DEFAULT NULL,
  `cam_sampling_time_utc` time DEFAULT NULL,
  `cam_lat_zone` text DEFAULT NULL,
  `cam_long_zone` text DEFAULT NULL,
  `cam_altitude_reference` text DEFAULT NULL,
  `md5sum` varchar(50) DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;
