/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost:3306
 Source Schema         : blog_service

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : 65001

 Date: 19/03/2021 19:05:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for blog_article
-- ----------------------------
DROP TABLE IF EXISTS `blog_article`;
CREATE TABLE `blog_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT '' COMMENT '文章标题',
  `desc` varchar(255) DEFAULT '' COMMENT '文章简述',
  `cover_image_url` varchar(255) DEFAULT '' COMMENT '封面图片地址',
  `content` longtext COMMENT '文章内容',
  `created_on` int(10) unsigned DEFAULT '0' COMMENT '新建时间',
  `created_by` varchar(100) DEFAULT '' COMMENT '创建人',
  `modified_on` int(10) unsigned DEFAULT '0' COMMENT '修改时间',
  `modified_by` varchar(100) DEFAULT '' COMMENT '修改人',
  `deleted_on` int(10) unsigned DEFAULT '0' COMMENT '删除时间',
  `is_del` tinyint(3) unsigned DEFAULT '0' COMMENT '是否删除 0为未删除、1为已删除',
  `state` tinyint(3) unsigned DEFAULT '1' COMMENT '状态 0为禁用、1为启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='文章管理';

-- ----------------------------
-- Records of blog_article
-- ----------------------------
BEGIN;
INSERT INTO `blog_article` VALUES (1, 'PHP测试1', '测试1', 'http://www.baidu.com', '测试测试测试测试测试1', 1604633684, '曹为林', 1604633684, '', 0, 0, 1);
INSERT INTO `blog_article` VALUES (2, 'PHP测试2', '测试2', 'http://www.baidu.com', '测试测试测试测试测试2', 1604633684, '曹为林', 1604633684, '', 0, 0, 1);
INSERT INTO `blog_article` VALUES (3, 'PHP测试3', '测试3', 'http://www.baidu.com', '测试测试测试测试测试3', 1604633684, '曹为林', 1604633684, '', 0, 0, 1);
INSERT INTO `blog_article` VALUES (4, 'PHP测试4', '测试4', 'http://www.baidu.com', '测试测试测试测试测试4', 1604633684, '曹为林', 1604633684, '', 0, 0, 1);
INSERT INTO `blog_article` VALUES (5, 'PHP测试5', '测试5', 'http://www.baidu.com', '测试测试测试测试测试5', 1604633684, '曹为林', 1604633684, '', 0, 0, 1);
INSERT INTO `blog_article` VALUES (6, 'PHP测试', '测试', 'http://www.baidu.com', '测试测试测试测试测试', 1616059870, '曹为林', 1616059870, '', 0, 0, 1);
INSERT INTO `blog_article` VALUES (7, 'PHP测试', '测试', 'http://www.baidu.com', '测试测试测试测试测试', 1616059975, '曹为林', 1616059975, '', 0, 0, 1);
COMMIT;

-- ----------------------------
-- Table structure for blog_article_tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_article_tag`;
CREATE TABLE `blog_article_tag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL COMMENT '文章ID',
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '标签ID',
  `created_on` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  `created_by` varchar(100) DEFAULT '' COMMENT '创建人',
  `modified_on` int(10) unsigned DEFAULT '0' COMMENT '修改时间',
  `modified_by` varchar(100) DEFAULT '' COMMENT '修改人',
  `deleted_on` int(10) unsigned DEFAULT '0' COMMENT '删除时间',
  `is_del` tinyint(3) unsigned DEFAULT '0' COMMENT '是否删除 0为未删除、1为已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='文章标签关联';

-- ----------------------------
-- Records of blog_article_tag
-- ----------------------------
BEGIN;
INSERT INTO `blog_article_tag` VALUES (1, 1, 1, 1604633684, '曹为林', 1604633684, '', 0, 0);
INSERT INTO `blog_article_tag` VALUES (2, 2, 1, 1604633684, '曹为林', 1604633684, '', 0, 0);
INSERT INTO `blog_article_tag` VALUES (3, 3, 1, 1604633684, '曹为林', 1604633684, '', 0, 0);
INSERT INTO `blog_article_tag` VALUES (4, 4, 1, 1604633684, '曹为林', 1604633684, '', 0, 0);
INSERT INTO `blog_article_tag` VALUES (5, 5, 1, 1604633684, '曹为林', 1604633684, '', 0, 0);
INSERT INTO `blog_article_tag` VALUES (6, 6, 1, 1616059870, '曹为林', 1616059870, '', 0, 0);
INSERT INTO `blog_article_tag` VALUES (7, 7, 1, 1616059975, '曹为林', 1616059975, '', 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for blog_auth
-- ----------------------------
DROP TABLE IF EXISTS `blog_auth`;
CREATE TABLE `blog_auth` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `app_key` varchar(20) NOT NULL DEFAULT '' COMMENT 'Key',
  `app_secret` varchar(50) NOT NULL DEFAULT '' COMMENT 'Secret',
  `created_on` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '新建时间',
  `created_by` varchar(100) NOT NULL DEFAULT '' COMMENT '创建人',
  `modified_on` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `modified_by` varchar(100) NOT NULL DEFAULT '' COMMENT '修改人',
  `deleted_on` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `is_del` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除 0为未删除、1为已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_app_key` (`app_key`) USING BTREE COMMENT 'app_key唯一性'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='认证管理';

-- ----------------------------
-- Records of blog_auth
-- ----------------------------
BEGIN;
INSERT INTO `blog_auth` VALUES (1, 'cwl', '123456', 1604633684, 'caoweilin', 0, '', 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for blog_tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_tag`;
CREATE TABLE `blog_tag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '' COMMENT '标签名称',
  `created_on` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  `created_by` varchar(100) DEFAULT '' COMMENT '创建人',
  `modified_on` int(10) unsigned DEFAULT '0' COMMENT '修改时间',
  `modified_by` varchar(100) DEFAULT '' COMMENT '修改人',
  `deleted_on` int(10) unsigned DEFAULT '0' COMMENT '删除时间',
  `is_del` tinyint(3) unsigned DEFAULT '0' COMMENT '是否删除 0为未删除、1为已删除',
  `state` tinyint(3) unsigned DEFAULT '1' COMMENT '状态 0为禁用、1为启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='标签管理';

-- ----------------------------
-- Records of blog_tag
-- ----------------------------
BEGIN;
INSERT INTO `blog_tag` VALUES (1, 'Php', 1604570406, 'caoweilin', 1604573432, 'cwl', 0, 0, 1);
INSERT INTO `blog_tag` VALUES (2, 'Python', 1604570406, 'cwl', 1604570406, 'lin', 1604642127, 0, 1);
INSERT INTO `blog_tag` VALUES (3, 'Java', 1604570406, 'caoweilin', 1604573432, 'cwl', 0, 0, 1);
INSERT INTO `blog_tag` VALUES (4, 'Go', 1604570406, 'caoweilin', 1604573432, 'cwl', 0, 0, 1);
COMMIT;

-- ----------------------------
-- Table structure for blog_task_receive_log
-- ----------------------------
DROP TABLE IF EXISTS `blog_task_receive_log`;
CREATE TABLE `blog_task_receive_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '逻辑主键',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用戶id',
  `task_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '任务id',
  `tag` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '奖励类型(0-无 1-背包礼物，2-盲盒碎片，3-盲盒抽獎券 4-人气值,5-猫粮',
  `num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '任务类型 0-用户任务,1-主播任务',
  `ext` varchar(200) NOT NULL DEFAULT '' COMMENT '扩展信息',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '标题',
  `act_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动ID',
  `db_insert_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '写入时间',
  `db_update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`uid`),
  KEY `idx_actid` (`act_id`),
  KEY `idx_insert` (`db_insert_time`),
  KEY `idx_update` (`db_update_time`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COMMENT='任务领取日誌';

-- ----------------------------
-- Records of blog_task_receive_log
-- ----------------------------
BEGIN;
INSERT INTO `blog_task_receive_log` VALUES (1, 1, 2, 2, 5, 0, '', '會員每日免費領取', 3, '2021-03-17 17:53:40', '2021-03-17 17:53:48');
INSERT INTO `blog_task_receive_log` VALUES (2, 1, 2, 2, 520, 0, '', '累積收到520個晴天娃娃(520/520)', 3, '2021-03-17 17:53:40', '2021-03-17 17:54:29');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
