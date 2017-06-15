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

 Date: 02/26/2015 11:45:15 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `phenocorn_htp`
-- ----------------------------
DROP TABLE IF EXISTS `phenocorn_htp`;
CREATE TABLE `phenocorn_htp` (
  `record_id` double(255,0) NOT NULL AUTO_INCREMENT,
  `run_file_name` text DEFAULT NULL,
  `run_id` text DEFAULT NULL,
  `plot_id` char(10) DEFAULT NULL,
  `sensor_id` text NOT NULL,
  `sensor_observation` double(255,5) NOT NULL,
  `absolute_sensor_position_x` double(255,5) NOT NULL,
  `absolute_sensor_position_y` double(255,5) NOT NULL,
  `absolute_sensor_position_z` double(255,5) NOT NULL,
  `sampling_time` time NOT NULL,
  `sampling_date` date NOT NULL,
  `left_utc` double(255,5) NOT NULL,
  `left_elevation` double(255,5) NOT NULL,
  `left_long` double(255,7) NOT NULL,
  `left_lat` double(255,7) NOT NULL,
  `long_zone` text NOT NULL,
  `lat_zone` text NOT NULL,
  `notes` longtext,
  PRIMARY KEY (`record_id`),
  KEY `absolute_sensor_position_y` (`absolute_sensor_position_y`),
  KEY `absolute_sensor_position_x` (`absolute_sensor_position_x`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;
