/*
 Navicat MySQL Data Transfer

 Source Server         : wheatgenetics
 Source Server Type    : MySQL
 Source Server Version : 50540
 Source Host           : beocat.cis.ksu.edu
 Source Database       : wheatgenetics

 Target Server Type    : MySQL
 Target Server Version : 50540
 File Encoding         : utf-8

 Date: 02/26/2015 10:50:24 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `phenocam_run`
-- ----------------------------
DROP TABLE IF EXISTS `phenocam_run`;
CREATE TABLE `phenocam_run` (
  `record_id` double(255,0) NOT NULL AUTO_INCREMENT,
  `run_id` varchar(50) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `run_filename` text,
  `md5sum` varchar(50) NOT NULL,
  `notes` longtext,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;
