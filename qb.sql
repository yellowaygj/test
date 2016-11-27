/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : qb

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2016-11-23 21:12:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `logdata`
-- ----------------------------
DROP TABLE IF EXISTS `logdata`;
CREATE TABLE `logdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `roleid` int(11) NOT NULL,
  `operate` varchar(255) NOT NULL,
  `node` varchar(255) DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `roleid` (`roleid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of logdata
-- ----------------------------

-- ----------------------------
-- Table structure for `permission`
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `describe` varchar(255) NOT NULL,
  `state` int(11) DEFAULT '0',
  `flevel` int(11) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `permission_ibfk_1` (`flevel`),
  CONSTRAINT `permission_ibfk_1` FOREIGN KEY (`flevel`) REFERENCES `permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('0', '系统权限管理', '系统权限管理', '1', '0', '');
INSERT INTO `permission` VALUES ('2', '用户管理1', '用户管理', '1', '0', '用户管理');
INSERT INTO `permission` VALUES ('3', '增加用户1', '添加新用户1', '0', '2', '1');
INSERT INTO `permission` VALUES ('4', '修改用户1', '修改用户权限', '0', '2', '1');
INSERT INTO `permission` VALUES ('5', '删除用户1', '删除用户功能1', '0', '2', '1');
INSERT INTO `permission` VALUES ('6', '权限分派', '用户权限管理', '1', '0', '');
INSERT INTO `permission` VALUES ('7', '添加角色', '添加职能岗位', '0', '6', '');
INSERT INTO `permission` VALUES ('8', '修改角色', '职能权限求改', '0', '6', '');
INSERT INTO `permission` VALUES ('9', '删除角色', '删除角色', '0', '6', '');
INSERT INTO `permission` VALUES ('11', '查询总类', '查询查看信息', '1', '0', '');
INSERT INTO `permission` VALUES ('12', '查询产品类型', '查询产品类型', '0', '11', '');
INSERT INTO `permission` VALUES ('13', '查询库存', '查询库存', '0', '11', '');
INSERT INTO `permission` VALUES ('14', '查询人员', '查询人员', '1', '11', '');
INSERT INTO `permission` VALUES ('15', '查询薪资', '查询薪资', '0', '11', '');
INSERT INTO `permission` VALUES ('59', '查询新增1', '查询新增2', '0', '14', '查询新增3');

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'admin');
INSERT INTO `role` VALUES ('2', 'guest');
INSERT INTO `role` VALUES ('3', 'db');
INSERT INTO `role` VALUES ('4', 'user');
INSERT INTO `role` VALUES ('5', '办公室主任');
INSERT INTO `role` VALUES ('6', '经理');
INSERT INTO `role` VALUES ('7', '财务');
INSERT INTO `role` VALUES ('8', '审计');
INSERT INTO `role` VALUES ('9', '组长');
INSERT INTO `role` VALUES ('10', '组员');
INSERT INTO `role` VALUES ('11', '普通员工');
INSERT INTO `role` VALUES ('12', '董事长');
INSERT INTO `role` VALUES ('13', '无业游民');
INSERT INTO `role` VALUES ('14', '懂事');
INSERT INTO `role` VALUES ('15', '高级经理');
INSERT INTO `role` VALUES ('16', '客户管理');
INSERT INTO `role` VALUES ('17', '测试人员');
INSERT INTO `role` VALUES ('20', 'aaa');

-- ----------------------------
-- Table structure for `role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `rid` (`rid`),
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('74', '6', '7');
INSERT INTO `role_permission` VALUES ('75', '6', '8');
INSERT INTO `role_permission` VALUES ('76', '6', '9');
INSERT INTO `role_permission` VALUES ('126', '3', '6');
INSERT INTO `role_permission` VALUES ('127', '3', '7');
INSERT INTO `role_permission` VALUES ('128', '3', '8');
INSERT INTO `role_permission` VALUES ('129', '3', '9');
INSERT INTO `role_permission` VALUES ('130', '3', '11');
INSERT INTO `role_permission` VALUES ('131', '3', '12');
INSERT INTO `role_permission` VALUES ('132', '3', '13');
INSERT INTO `role_permission` VALUES ('133', '3', '14');
INSERT INTO `role_permission` VALUES ('134', '3', '59');
INSERT INTO `role_permission` VALUES ('135', '3', '15');
INSERT INTO `role_permission` VALUES ('136', '5', '6');
INSERT INTO `role_permission` VALUES ('137', '5', '7');
INSERT INTO `role_permission` VALUES ('138', '5', '8');
INSERT INTO `role_permission` VALUES ('139', '5', '9');
INSERT INTO `role_permission` VALUES ('140', '3', '5');
INSERT INTO `role_permission` VALUES ('144', '3', '4');
INSERT INTO `role_permission` VALUES ('145', '7', '6');
INSERT INTO `role_permission` VALUES ('146', '7', '7');
INSERT INTO `role_permission` VALUES ('147', '7', '8');
INSERT INTO `role_permission` VALUES ('148', '7', '9');
INSERT INTO `role_permission` VALUES ('149', '5', '5');
INSERT INTO `role_permission` VALUES ('150', '5', '2');
INSERT INTO `role_permission` VALUES ('151', '5', '3');
INSERT INTO `role_permission` VALUES ('152', '5', '4');
INSERT INTO `role_permission` VALUES ('153', '6', '5');
INSERT INTO `role_permission` VALUES ('154', '5', '12');
INSERT INTO `role_permission` VALUES ('155', '5', '11');
INSERT INTO `role_permission` VALUES ('156', '5', '13');
INSERT INTO `role_permission` VALUES ('157', '5', '14');
INSERT INTO `role_permission` VALUES ('158', '5', '59');
INSERT INTO `role_permission` VALUES ('159', '5', '15');
INSERT INTO `role_permission` VALUES ('160', '5', '0');
INSERT INTO `role_permission` VALUES ('161', '6', '13');
INSERT INTO `role_permission` VALUES ('163', '6', '12');
INSERT INTO `role_permission` VALUES ('164', '8', '6');
INSERT INTO `role_permission` VALUES ('165', '8', '7');
INSERT INTO `role_permission` VALUES ('166', '8', '8');
INSERT INTO `role_permission` VALUES ('167', '8', '9');
INSERT INTO `role_permission` VALUES ('200', '2', '4');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `pwd` varchar(255) NOT NULL,
  `nickname` varchar(255) NOT NULL,
  `img` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `state` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'xf', '123', '鲸', null, '2016-10-20 01:00:00', '1');
INSERT INTO `user` VALUES ('2', 'zx', '123', '猫', null, '2016-10-20 02:00:00', '1');
INSERT INTO `user` VALUES ('25', 'HJ1', '123', '123', null, null, '1');
INSERT INTO `user` VALUES ('26', '1', '3', '1', null, null, '1');
INSERT INTO `user` VALUES ('27', '2', '2', '2', null, null, '1');
INSERT INTO `user` VALUES ('28', '3', '3', '3', null, null, '1');
INSERT INTO `user` VALUES ('29', '4', '4', '4', null, null, '1');
INSERT INTO `user` VALUES ('30', '5', '5', '5', null, null, '1');
INSERT INTO `user` VALUES ('31', '6', '6', '6', null, null, '1');
INSERT INTO `user` VALUES ('32', '7', '7', '7', null, null, '1');
INSERT INTO `user` VALUES ('33', '5', '5', '5', null, null, '1');

-- ----------------------------
-- Table structure for `user_role`
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `roleid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `roleid` (`roleid`),
  CONSTRAINT `roleid` FOREIGN KEY (`roleid`) REFERENCES `role` (`id`),
  CONSTRAINT `userid` FOREIGN KEY (`userid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('26', '2', '2');
INSERT INTO `user_role` VALUES ('27', '2', '3');
INSERT INTO `user_role` VALUES ('28', '2', '4');
INSERT INTO `user_role` VALUES ('29', '2', '5');
INSERT INTO `user_role` VALUES ('30', '1', '7');
INSERT INTO `user_role` VALUES ('32', '1', '13');
INSERT INTO `user_role` VALUES ('33', '1', '2');
INSERT INTO `user_role` VALUES ('35', '1', '6');
INSERT INTO `user_role` VALUES ('36', '1', '9');
INSERT INTO `user_role` VALUES ('37', '1', '4');
INSERT INTO `user_role` VALUES ('41', '1', '1');
INSERT INTO `user_role` VALUES ('56', '1', '3');
INSERT INTO `user_role` VALUES ('59', '2', '1');
INSERT INTO `user_role` VALUES ('60', '2', '16');
INSERT INTO `user_role` VALUES ('61', '2', '17');
INSERT INTO `user_role` VALUES ('62', '2', '11');
INSERT INTO `user_role` VALUES ('63', '2', '13');
INSERT INTO `user_role` VALUES ('64', '2', '20');
INSERT INTO `user_role` VALUES ('65', '2', '12');
INSERT INTO `user_role` VALUES ('66', '2', '14');
INSERT INTO `user_role` VALUES ('67', '2', '15');
INSERT INTO `user_role` VALUES ('68', '2', '20');
INSERT INTO `user_role` VALUES ('69', '2', '17');
INSERT INTO `user_role` VALUES ('70', '2', '16');
INSERT INTO `user_role` VALUES ('72', '25', '1');
INSERT INTO `user_role` VALUES ('73', '25', '2');
INSERT INTO `user_role` VALUES ('74', '25', '3');
