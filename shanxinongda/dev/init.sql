/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50741
Source Host           : localhost:3306
Source Database       : read_building

Target Server Type    : MYSQL
Target Server Version : 50741
File Encoding         : 65001

Date: 2026-06-18 10:43:36
*/

CREATE DATABASE IF NOT EXISTS `read_building`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE `read_building`;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for book_activ
-- ----------------------------
DROP TABLE IF EXISTS `book_activ`;
CREATE TABLE `book_activ` (
  `id` bigint(20) NOT NULL,
  `background` text COLLATE utf8mb4_unicode_ci,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `create_by` bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of book_activ
-- ----------------------------
INSERT INTO `book_activ` VALUES ('727657295454146560', 'https://ar-travel-file.1jiaohu.com/resource/20260326/5732b098ecc74b34a81de36cf26337ec.jpg', '1', '2', '1', '1', '1', '2025-09-29 15:34:47');
INSERT INTO `book_activ` VALUES ('792193128064094208', 'https://ar-travel-file.1jiaohu.com/resource/20260326/dd84d6799d4a4adcbe9fb6eeb6c5e03a.jpg', '2', '2', '1', '1', '1', '2026-03-26 17:37:09');
INSERT INTO `book_activ` VALUES ('792193168660762624', 'https://ar-travel-file.1jiaohu.com/resource/20260326/9ef868eeaaf841de854967813ea6caf8.jpg', '1', '1', '1', '1', '1', '2026-03-26 17:37:19');

-- ----------------------------
-- Table structure for book_user
-- ----------------------------
DROP TABLE IF EXISTS `book_user`;
CREATE TABLE `book_user` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键',
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_by` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `wly_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文旅云用户标识',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_phone` (`phone`) USING BTREE,
  UNIQUE KEY `uni_wly_id` (`wly_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表，手机号唯一';

-- ----------------------------
-- Records of book_user
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '表描述',
  `class_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES ('1', 'travel_slideshow', '小程序首页轮播图', 'TravelSlideshow', 'crud', 'com.ruoyi.system', 'system', 'slideshow', '小程序首页轮播图', 'ruoyi', '0', '/', null, 'admin', '2020-11-03 10:12:23', '', null, null);
INSERT INTO `gen_table` VALUES ('3', 'travel_scenic_spot', '景点表', 'TravelScenicSpot', 'crud', 'com.ruoyi.system', 'system', 'spot', '景点', 'ruoyi', '0', '/', null, 'admin', '2020-11-11 10:46:14', '', null, null);
INSERT INTO `gen_table` VALUES ('4', 'travel_scenic_spot_comment', '景点评论表', 'TravelScenicSpotComment', 'crud', 'com.ruoyi.system', 'system', 'comment', '景点评论', 'ruoyi', '0', '/', null, 'admin', '2020-11-11 11:41:24', '', null, null);
INSERT INTO `gen_table` VALUES ('6', 'book_admin', '管理员用户表', 'BookAdmin', 'crud', 'com.ruoyi.system', 'system', 'admin', '管理员用户', 'ruoyi', '0', '/', null, 'admin', '2020-11-24 17:28:43', '', null, null);
INSERT INTO `gen_table` VALUES ('8', 'book_open_time', '景点开放时间', 'BookOpenTime', 'crud', 'com.ruoyi.system', 'system', 'time', '景点开放时间', 'ruoyi', '0', '/', null, 'admin', '2020-11-24 17:28:43', '', null, null);
INSERT INTO `gen_table` VALUES ('9', 'book_tour', '景点表', 'BookTour', 'crud', 'com.ruoyi.system', 'system', 'tour', '景点', 'ruoyi', '0', '/', null, 'admin', '2020-11-24 17:28:43', '', null, null);
INSERT INTO `gen_table` VALUES ('10', 'book_appointment', '景点预约表', 'BookAppointment', 'crud', 'com.ruoyi.system', 'system', 'appointment', '景点预约', 'ruoyi', '0', '/', null, 'admin', '2020-11-24 17:36:58', '', null, null);
INSERT INTO `gen_table` VALUES ('11', 'travel_module', '大类', 'TravelModule', 'crud', 'com.ruoyi.system', 'system', 'module', '大类', 'ruoyi', '0', '/', null, 'admin', '2020-11-25 11:03:23', '', null, null);
INSERT INTO `gen_table` VALUES ('12', 'travel_module_detail', '景点表', 'TravelModuleDetail', 'crud', 'com.ruoyi.system', 'system', 'detail', '景点', 'ruoyi', '0', '/', null, 'admin', '2020-11-25 11:03:23', '', null, null);
INSERT INTO `gen_table` VALUES ('13', 'travel_scenic_spot_classfication', '景点分类表', 'TravelScenicSpotClassfication', 'crud', 'com.ruoyi.system', 'system', 'classfication', '景点分类', 'ruoyi', '0', '/', null, 'admin', '2020-11-25 11:03:23', '', null, null);
INSERT INTO `gen_table` VALUES ('14', 'travel_sub_classification', '二级分类', 'TravelSubClassification', 'crud', 'com.ruoyi.system', 'system', 'classification', '二级分类', 'ruoyi', '0', '/', null, 'admin', '2020-11-25 11:03:24', '', null, null);
INSERT INTO `gen_table` VALUES ('15', 'travel_vr', 'vr表', 'TravelVr', 'crud', 'com.ruoyi.system', 'system', 'vr', 'vr', 'ruoyi', '0', '/', null, 'admin', '2020-11-25 11:03:24', '', null, null);
INSERT INTO `gen_table` VALUES ('16', 'travel_recognition_library', '识别库', 'TravelRecognitionLibrary', 'crud', 'com.ruoyi.system', 'system', 'library', '识别库', 'ruoyi', '0', '/', null, 'admin', '2020-11-26 15:22:34', '', null, null);
INSERT INTO `gen_table` VALUES ('17', 'book_interval', '景点开放时间', 'BookInterval', 'crud', 'com.ruoyi.system', 'system', 'interval', '景点开放时间', 'ruoyi', '0', '/', null, 'admin', '2020-11-30 16:49:00', '', null, null);
INSERT INTO `gen_table` VALUES ('18', 'travel_vr_brief', '全景图简介表', 'TravelVrBrief', 'crud', 'com.ruoyi.system', 'system', 'brief', '全景图简介', 'ruoyi', '0', '/', null, 'admin', '2020-12-04 17:58:08', '', null, null);
INSERT INTO `gen_table` VALUES ('19', 'travel_scenic_spot_like', '景点点赞表', 'TravelScenicSpotLike', 'crud', 'com.ruoyi.system', 'system', 'like', '景点点赞', 'ruoyi', '0', '/', null, 'admin', '2020-12-11 10:26:59', '', null, null);
INSERT INTO `gen_table` VALUES ('20', 'park_admin', '管理员表', 'ParkAdmin', 'crud', 'com.ruoyi.system', 'system', 'admin', '管理员', 'ruoyi', '0', '/', null, 'admin', '2021-04-07 16:47:58', '', null, null);
INSERT INTO `gen_table` VALUES ('21', 'park_list', '停车场表', 'ParkList', 'crud', 'com.ruoyi.system', 'system', 'list', '停车场', 'ruoyi', '0', '/', null, 'admin', '2021-04-07 16:47:58', '', null, null);
INSERT INTO `gen_table` VALUES ('22', 'park_package', '计费规则表', 'ParkPackage', 'crud', 'com.ruoyi.system', 'system', 'package', '计费规则', 'ruoyi', '0', '/', null, 'admin', '2021-04-07 16:47:58', '', null, null);
INSERT INTO `gen_table` VALUES ('23', 'park_record', '', 'ParkRecord', 'crud', 'com.ruoyi.system', 'system', 'record', null, 'ruoyi', '0', '/', null, 'admin', '2021-04-07 16:47:58', '', null, null);
INSERT INTO `gen_table` VALUES ('24', 'park_user', '用户表', 'ParkUser', 'crud', 'com.ruoyi.system', 'system', 'user', '用户', 'ruoyi', '0', '/', null, 'admin', '2021-04-07 16:47:58', '', null, null);
INSERT INTO `gen_table` VALUES ('25', 'travel_model_video', '', 'TravelModelVideo', 'crud', 'com.ruoyi.system', 'system', 'video', null, 'ruoyi', '0', '/', null, 'admin', '2021-04-27 11:33:34', '', null, null);
INSERT INTO `gen_table` VALUES ('26', 'acticity', '', 'Acticity', 'crud', 'com.ruoyi.system', 'system', 'acticity', null, 'ruoyi', '0', '/', null, 'admin', '2023-09-08 10:57:22', '', null, null);
INSERT INTO `gen_table` VALUES ('27', 'appointment', '', 'Appointment', 'crud', 'com.ruoyi.system', 'system', 'appointment', null, 'ruoyi', '0', '/', null, 'admin', '2023-09-08 10:57:23', '', null, null);
INSERT INTO `gen_table` VALUES ('28', 'associated', '', 'Associated', 'crud', 'com.ruoyi.system', 'system', 'associated', null, 'ruoyi', '0', '/', null, 'admin', '2023-09-08 10:57:23', '', null, null);
INSERT INTO `gen_table` VALUES ('29', 'block', '', 'Block', 'crud', 'com.ruoyi.system', 'system', 'block', null, 'ruoyi', '0', '/', null, 'admin', '2023-09-08 10:57:23', '', null, null);
INSERT INTO `gen_table` VALUES ('30', 'type', '', 'Type', 'crud', 'com.ruoyi.system', 'system', 'type', null, 'ruoyi', '0', '/', null, 'admin', '2023-09-08 10:57:30', '', null, null);
INSERT INTO `gen_table` VALUES ('31', 'cultural_creativity', '', 'CulturalCreativity', 'crud', 'com.ruoyi.system', 'system', 'creativity', null, 'ruoyi', '0', '/', null, 'admin', '2023-09-08 10:58:14', '', null, null);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '字典类型',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=255 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES ('1', '1', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-11-03 10:12:23', '', null);
INSERT INTO `gen_table_column` VALUES ('2', '1', 'picture_url', '轮播图url', 'varchar(100)', 'String', 'pictureUrl', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2020-11-03 10:12:23', '', null);
INSERT INTO `gen_table_column` VALUES ('3', '1', 'status', '状态，0：无效 1：正常', 'tinyint(4) unsigned', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', '3', 'admin', '2020-11-03 10:12:23', '', null);
INSERT INTO `gen_table_column` VALUES ('4', '1', 'create_by', '创建人', 'bigint(20) unsigned', 'Long', 'createBy', '0', '0', '1', '1', null, null, null, 'EQ', 'input', '', '4', 'admin', '2020-11-03 10:12:23', '', null);
INSERT INTO `gen_table_column` VALUES ('5', '1', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '5', 'admin', '2020-11-03 10:12:23', '', null);
INSERT INTO `gen_table_column` VALUES ('17', '3', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-11-11 10:46:14', '', null);
INSERT INTO `gen_table_column` VALUES ('18', '3', 'name', '景点名称', 'varchar(50)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2020-11-11 10:46:14', '', null);
INSERT INTO `gen_table_column` VALUES ('19', '3', 'title', '景点标题', 'varchar(50)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2020-11-11 10:46:14', '', null);
INSERT INTO `gen_table_column` VALUES ('20', '3', 'sub_title', '景点副标题', 'varchar(50)', 'String', 'subTitle', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2020-11-11 10:46:14', '', null);
INSERT INTO `gen_table_column` VALUES ('21', '3', 'picture_url', '景点图片', 'varchar(500)', 'String', 'pictureUrl', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', '5', 'admin', '2020-11-11 10:46:14', '', null);
INSERT INTO `gen_table_column` VALUES ('22', '3', 'audio_url', '景点音频', 'varchar(500)', 'String', 'audioUrl', '0', '0', null, '1', '1', '1', '1', 'EQ', 'textarea', '', '6', 'admin', '2020-11-11 10:46:14', '', null);
INSERT INTO `gen_table_column` VALUES ('23', '3', 'address', '景点地址', 'varchar(100)', 'String', 'address', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '7', 'admin', '2020-11-11 10:46:14', '', null);
INSERT INTO `gen_table_column` VALUES ('24', '3', 'content', '景点内容', 'text', 'String', 'content', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'editor', '', '8', 'admin', '2020-11-11 10:46:14', '', null);
INSERT INTO `gen_table_column` VALUES ('25', '3', 'status', '状态，0：失效 1：正常', 'tinyint(4)', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', '9', 'admin', '2020-11-11 10:46:14', '', null);
INSERT INTO `gen_table_column` VALUES ('26', '3', 'create_by', '创建人', 'bigint(20) unsigned', 'Long', 'createBy', '0', '0', '1', '1', null, null, null, 'EQ', 'input', '', '10', 'admin', '2020-11-11 10:46:15', '', null);
INSERT INTO `gen_table_column` VALUES ('27', '3', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '11', 'admin', '2020-11-11 10:46:15', '', null);
INSERT INTO `gen_table_column` VALUES ('28', '3', 'longitude', '经度', 'varchar(20)', 'String', 'longitude', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '12', 'admin', '2020-11-11 10:46:15', '', null);
INSERT INTO `gen_table_column` VALUES ('29', '3', 'latitude', '纬度', 'varchar(20)', 'String', 'latitude', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '13', 'admin', '2020-11-11 10:46:15', '', null);
INSERT INTO `gen_table_column` VALUES ('30', '3', 'introduction', '景点简介', 'text', 'String', 'introduction', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '14', 'admin', '2020-11-11 10:46:15', '', null);
INSERT INTO `gen_table_column` VALUES ('31', '3', 'is_vr', '是否存在VR，0：不存在，1：存在', 'tinyint(4)', 'Integer', 'isVr', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '15', 'admin', '2020-11-11 10:46:15', '', null);
INSERT INTO `gen_table_column` VALUES ('32', '4', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-11-11 11:41:24', '', null);
INSERT INTO `gen_table_column` VALUES ('33', '4', 'scenic_spot_id', '景点id', 'bigint(20) unsigned', 'Long', 'scenicSpotId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2020-11-11 11:41:24', '', null);
INSERT INTO `gen_table_column` VALUES ('34', '4', 'comment_user_id', '评论人id', 'bigint(20) unsigned', 'Long', 'commentUserId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2020-11-11 11:41:24', '', null);
INSERT INTO `gen_table_column` VALUES ('35', '4', 'comment', '评论内容', 'varchar(500)', 'String', 'comment', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', '4', 'admin', '2020-11-11 11:41:24', '', null);
INSERT INTO `gen_table_column` VALUES ('36', '4', 'status', '状态，1：正常 0：失效', 'tinyint(4) unsigned', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', '5', 'admin', '2020-11-11 11:41:24', '', null);
INSERT INTO `gen_table_column` VALUES ('37', '4', 'create_by', '创建人', 'bigint(20) unsigned', 'Long', 'createBy', '0', '0', '1', '1', null, null, null, 'EQ', 'input', '', '6', 'admin', '2020-11-11 11:41:24', '', null);
INSERT INTO `gen_table_column` VALUES ('38', '4', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '7', 'admin', '2020-11-11 11:41:24', '', null);
INSERT INTO `gen_table_column` VALUES ('43', '6', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('44', '6', 'username', '管理员用户名', 'varchar(50)', 'String', 'username', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('45', '6', 'password', '管理员密码', 'varchar(32)', 'String', 'password', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('46', '6', 'is_super_admin', '是否是超级管理员，0：否 1：是', 'tinyint(1) unsigned', 'Integer', 'isSuperAdmin', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('47', '6', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '5', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('61', '8', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('62', '8', 'tour_id', '景点id', 'bigint(20) unsigned', 'Long', 'tourId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('63', '8', 'start', null, 'time', 'Date', 'start', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', '3', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('64', '8', 'end', null, 'time', 'Date', 'end', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', '4', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('65', '9', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('66', '9', 'name', '景点名称', 'varchar(60)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('67', '9', 'address', '景点地址', 'varchar(200)', 'String', 'address', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('68', '9', 'price', '景点门票价格 默认0元', 'decimal(7,5) unsigned', 'BigDecimal', 'price', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('69', '9', 'cover', null, 'varchar(255)', 'String', 'cover', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '5', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('70', '9', 'start_date', '开始日期 格式 2020-02-02 ', 'date', 'Date', 'startDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', '6', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('71', '9', 'end_date', '结束日期 格式 2020-09-02 ', 'date', 'Date', 'endDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', '7', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('72', '9', 'description', '景点描述', 'varchar(255)', 'String', 'description', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '8', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('73', '9', 'qrcode', '用于核销预约景点的二维码', 'text', 'String', 'qrcode', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '9', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('74', '9', 'status', '该景点活动是否暂停 (0 正常 1 暂停)', 'tinyint(1) unsigned', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', '10', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('75', '9', 'admin_id', '管理人员id', 'bigint(20) unsigned', 'Long', 'adminId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '11', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('76', '9', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '12', 'admin', '2020-11-24 17:28:43', '', null);
INSERT INTO `gen_table_column` VALUES ('77', '10', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-11-24 17:36:58', '', null);
INSERT INTO `gen_table_column` VALUES ('78', '10', 'tour_id', '预约景点ID', 'bigint(20) unsigned', 'Long', 'tourId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2020-11-24 17:36:58', '', null);
INSERT INTO `gen_table_column` VALUES ('79', '10', 'user_id', '预约用户的ID', 'bigint(20) unsigned', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2020-11-24 17:36:58', '', null);
INSERT INTO `gen_table_column` VALUES ('80', '10', 'name', '预约人姓名', 'varchar(30)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '4', 'admin', '2020-11-24 17:36:58', '', null);
INSERT INTO `gen_table_column` VALUES ('81', '10', 'appoint_date', '参观日期 yyyy-MM-dd', 'date', 'Date', 'appointDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', '5', 'admin', '2020-11-24 17:36:58', '', null);
INSERT INTO `gen_table_column` VALUES ('82', '10', 'appoint_time_start', '预约开始时间', 'time', 'Date', 'appointTimeStart', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', '6', 'admin', '2020-11-24 17:36:58', '', null);
INSERT INTO `gen_table_column` VALUES ('83', '10', 'appoint_time_end', '预约结束时间', 'time', 'Date', 'appointTimeEnd', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', '7', 'admin', '2020-11-24 17:36:58', '', null);
INSERT INTO `gen_table_column` VALUES ('84', '10', 'price', '景点门票价格', 'decimal(7,2) unsigned', 'BigDecimal', 'price', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '8', 'admin', '2020-11-24 17:36:58', '', null);
INSERT INTO `gen_table_column` VALUES ('85', '10', 'identity', '预约人身份证号', 'varchar(20)', 'String', 'identity', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '9', 'admin', '2020-11-24 17:36:58', '', null);
INSERT INTO `gen_table_column` VALUES ('86', '10', 'phone', '预约人手机号', 'varchar(15)', 'String', 'phone', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '10', 'admin', '2020-11-24 17:36:58', '', null);
INSERT INTO `gen_table_column` VALUES ('87', '10', 'child', '儿童人数', 'tinyint(4) unsigned', 'Integer', 'child', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '11', 'admin', '2020-11-24 17:36:58', '', null);
INSERT INTO `gen_table_column` VALUES ('88', '10', 'consumed', '是否核销（0 未核销 1 已核销）', 'tinyint(1) unsigned', 'Integer', 'consumed', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '12', 'admin', '2020-11-24 17:36:58', '', null);
INSERT INTO `gen_table_column` VALUES ('89', '10', 'create_time', '预约发生时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '13', 'admin', '2020-11-24 17:36:58', '', null);
INSERT INTO `gen_table_column` VALUES ('90', '11', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('91', '11', 'name', '名称', 'varchar(50)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('92', '11', 'status', '状态 1：正常 0：失效', 'tinyint(4) unsigned', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', '3', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('93', '11', 'flag', '标记，1：系统预定义 0：动态添加', 'tinyint(4)', 'Integer', 'flag', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('94', '11', 'create_by', '创建人', 'bigint(20) unsigned', 'Long', 'createBy', '0', '0', '1', '1', null, null, null, 'EQ', 'input', '', '5', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('95', '11', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '6', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('96', '12', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('97', '12', 'module_id', '模块id', 'bigint(20) unsigned', 'Long', 'moduleId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('98', '12', 'sub_classification_id', '二级分类id', 'bigint(20) unsigned', 'Long', 'subClassificationId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('99', '12', 'name', '景点名称', 'varchar(50)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '4', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('100', '12', 'title', '景点标题', 'varchar(50)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '5', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('101', '12', 'sub_title', '景点副标题', 'varchar(50)', 'String', 'subTitle', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '6', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('102', '12', 'picture_url', '景点图片', 'varchar(500)', 'String', 'pictureUrl', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', '7', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('103', '12', 'video_url', '视频', 'varchar(500)', 'String', 'videoUrl', '0', '0', null, '1', '1', '1', '1', 'EQ', 'textarea', '', '8', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('104', '12', 'audio_url', '景点音频', 'varchar(500)', 'String', 'audioUrl', '0', '0', null, '1', '1', '1', '1', 'EQ', 'textarea', '', '9', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('105', '12', 'address', '景点地址', 'varchar(100)', 'String', 'address', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '10', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('106', '12', 'content', '景点内容', 'text', 'String', 'content', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'editor', '', '11', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('107', '12', 'status', '状态，0：失效 1：正常', 'tinyint(4)', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', '12', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('108', '12', 'create_by', '创建人', 'bigint(20) unsigned', 'Long', 'createBy', '0', '0', '1', '1', null, null, null, 'EQ', 'input', '', '13', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('109', '12', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '14', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('110', '12', 'longitude', '经度', 'varchar(20)', 'String', 'longitude', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '15', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('111', '12', 'latitude', '纬度', 'varchar(20)', 'String', 'latitude', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '16', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('112', '12', 'introduction', '景点简介', 'text', 'String', 'introduction', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '17', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('113', '12', 'is_vr', '是否存在VR，0：不存在，1：存在', 'tinyint(4)', 'Integer', 'isVr', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '18', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('114', '12', 'vr_id', 'vr_id', 'bigint(20) unsigned', 'Long', 'vrId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '19', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('115', '12', 'pageviews', 'VR图浏览量', 'bigint(20)', 'Long', 'pageviews', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '20', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('116', '12', 'likes', '点赞量', 'bigint(20)', 'Long', 'likes', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '21', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('117', '12', 'phone_number', '手机号', 'bigint(20)', 'Long', 'phoneNumber', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '22', 'admin', '2020-11-25 11:03:23', '', null);
INSERT INTO `gen_table_column` VALUES ('118', '13', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('119', '13', 'scenic_spot_id', '景点id', 'bigint(20) unsigned', 'Long', 'scenicSpotId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('120', '13', 'classfication_name', '分类名称', 'varchar(50)', 'String', 'classficationName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '3', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('121', '13', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '4', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('122', '14', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('123', '14', 'name', '名称', 'varchar(50)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('124', '14', 'status', '状态 1：正常 0：失效', 'tinyint(4) unsigned', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', '3', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('125', '14', 'module_id', '模块id', 'bigint(20) unsigned', 'Long', 'moduleId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('126', '14', 'create_by', '创建人', 'bigint(20) unsigned', 'Long', 'createBy', '0', '0', '1', '1', null, null, null, 'EQ', 'input', '', '5', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('127', '14', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '6', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('128', '15', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('129', '15', 'name', '名称', 'varchar(50)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('130', '15', 'status', '状态 1：启用 0：关闭', 'tinyint(4) unsigned', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', '3', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('131', '15', 'identify', '标识', 'varchar(50)', 'String', 'identify', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('132', '15', 'create_by', '创建人', 'bigint(20) unsigned', 'Long', 'createBy', '0', '0', '1', '1', null, null, null, 'EQ', 'input', '', '5', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('133', '15', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '6', 'admin', '2020-11-25 11:03:24', '', null);
INSERT INTO `gen_table_column` VALUES ('134', '16', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-11-26 15:22:34', '', null);
INSERT INTO `gen_table_column` VALUES ('135', '16', 'filename', '文件名称', 'varchar(50)', 'String', 'filename', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2020-11-26 15:22:34', '', null);
INSERT INTO `gen_table_column` VALUES ('136', '16', 'url', '图片地址', 'varchar(100)', 'String', 'url', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2020-11-26 15:22:34', '', null);
INSERT INTO `gen_table_column` VALUES ('137', '16', 'module_detail_id', '关联景点id', 'bigint(20) unsigned', 'Long', 'moduleDetailId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2020-11-26 15:22:34', '', null);
INSERT INTO `gen_table_column` VALUES ('138', '16', 'source', '来源，1：用户 2：官方', 'tinyint(4) unsigned', 'Integer', 'source', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '5', 'admin', '2020-11-26 15:22:34', '', null);
INSERT INTO `gen_table_column` VALUES ('139', '16', 'cont_sign', '百度图片签名信息', 'varchar(50)', 'String', 'contSign', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '6', 'admin', '2020-11-26 15:22:34', '', null);
INSERT INTO `gen_table_column` VALUES ('140', '16', 'is_storage', '是否入库，0：否 1：是', 'tinyint(1) unsigned', 'Integer', 'isStorage', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '7', 'admin', '2020-11-26 15:22:34', '', null);
INSERT INTO `gen_table_column` VALUES ('141', '16', 'storage_time', '入库时间', 'datetime', 'Date', 'storageTime', '0', '0', null, '1', '1', '1', '1', 'EQ', 'datetime', '', '8', 'admin', '2020-11-26 15:22:34', '', null);
INSERT INTO `gen_table_column` VALUES ('142', '16', 'create_by', '创建人', 'bigint(20) unsigned', 'Long', 'createBy', '0', '0', '1', '1', null, null, null, 'EQ', 'input', '', '9', 'admin', '2020-11-26 15:22:34', '', null);
INSERT INTO `gen_table_column` VALUES ('143', '16', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '10', 'admin', '2020-11-26 15:22:34', '', null);
INSERT INTO `gen_table_column` VALUES ('144', '17', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-11-30 16:49:00', '', null);
INSERT INTO `gen_table_column` VALUES ('145', '17', 'tour_id', '景点id', 'bigint(20) unsigned', 'Long', 'tourId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2020-11-30 16:49:00', '', null);
INSERT INTO `gen_table_column` VALUES ('146', '17', 'start', '开始时间', 'time', 'Date', 'start', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', '3', 'admin', '2020-11-30 16:49:00', '', null);
INSERT INTO `gen_table_column` VALUES ('147', '17', 'end', '结束时间', 'time', 'Date', 'end', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', '4', 'admin', '2020-11-30 16:49:00', '', null);
INSERT INTO `gen_table_column` VALUES ('148', '18', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-12-04 17:58:08', '', null);
INSERT INTO `gen_table_column` VALUES ('149', '18', 'vr_id', '全景图id', 'bigint(20) unsigned', 'Long', 'vrId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2020-12-04 17:58:08', '', null);
INSERT INTO `gen_table_column` VALUES ('150', '18', 'introduction', '全景图简介', 'varchar(500)', 'String', 'introduction', '0', '0', null, '1', '1', '1', '1', 'EQ', 'textarea', '', '3', 'admin', '2020-12-04 17:58:08', '', null);
INSERT INTO `gen_table_column` VALUES ('151', '19', 'id', '主键', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2020-12-11 10:26:59', '', null);
INSERT INTO `gen_table_column` VALUES ('152', '19', 'scenic_spot_id', '景点id', 'bigint(20) unsigned', 'Long', 'scenicSpotId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2020-12-11 10:26:59', '', null);
INSERT INTO `gen_table_column` VALUES ('153', '19', 'like_user_id', '点赞人id', 'bigint(20) unsigned', 'Long', 'likeUserId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2020-12-11 10:26:59', '', null);
INSERT INTO `gen_table_column` VALUES ('154', '19', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '4', 'admin', '2020-12-11 10:26:59', '', null);
INSERT INTO `gen_table_column` VALUES ('155', '19', 'likes', '点赞量', 'bigint(20)', 'Long', 'likes', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '5', 'admin', '2020-12-11 10:26:59', '', null);
INSERT INTO `gen_table_column` VALUES ('156', '20', 'id', '主键', 'bigint(20)', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('157', '20', 'user_name', '管理员用户名', 'varchar(10)', 'String', 'userName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('158', '20', 'password', '管理员密码', 'varchar(10)', 'String', 'password', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('159', '20', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '4', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('160', '20', 'create_by', '创建人', 'bigint(20) unsigned', 'Long', 'createBy', '0', '0', '1', '1', null, null, null, 'EQ', 'input', '', '5', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('161', '21', 'id', '停车场id', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('162', '21', 'name', '停车场名称', 'varchar(20)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('163', '21', 'total_space', '停车场总车位数', 'int(10) unsigned', 'Integer', 'totalSpace', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('164', '21', 'package_id', '计费包id', 'bigint(20) unsigned', 'Long', 'packageId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('165', '21', 'address', '停车场地址', 'varchar(255)', 'String', 'address', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '5', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('166', '21', 'district', '所属行政区', 'varchar(255)', 'String', 'district', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '6', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('167', '21', 'mng_name', '管理员姓名', 'varchar(255)', 'String', 'mngName', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '7', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('168', '21', 'mng_tel', '管理员电话', 'bigint(255)', 'Long', 'mngTel', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '8', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('169', '21', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '9', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('170', '21', 'create_by', '创建人', 'bigint(20) unsigned', 'Long', 'createBy', '0', '0', '1', '1', null, null, null, 'EQ', 'input', '', '10', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('171', '22', 'id', '计费包的id', 'bigint(20) unsigned', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('172', '22', 'name', '计费规则名称', 'varchar(50)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('173', '22', 'billing_type', '计费方式，1：分时收费 2：分段收费 3：按次收费', 'tinyint(4) unsigned', 'Integer', 'billingType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', '3', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('174', '22', 'free_duration', '免费时长，单位分钟', 'int(10) unsigned', 'Integer', 'freeDuration', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('175', '22', 'charge_begin_time', '收费时间：开始时间', 'time', 'Date', 'chargeBeginTime', '0', '0', null, '1', '1', '1', '1', 'EQ', 'datetime', '', '5', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('176', '22', 'charge_end_time', '收费时间：结束时间', 'time', 'Date', 'chargeEndTime', '0', '0', null, '1', '1', '1', '1', 'EQ', 'datetime', '', '6', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('177', '22', 'hour_fee', '分时收费：每小时费用', 'decimal(10,2) unsigned', 'BigDecimal', 'hourFee', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '7', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('178', '22', 'segment_in_hour', '分段收费：多少小时之内', 'int(10) unsigned', 'Integer', 'segmentInHour', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '8', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('179', '22', 'segment_in_hour_fee', '分段收费：多少小时之内，每小时费用', 'decimal(10,2) unsigned', 'BigDecimal', 'segmentInHourFee', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '9', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('180', '22', 'segment_out_hour_fee', '分段收费：多少小时之外，每小时费用', 'decimal(10,2)', 'BigDecimal', 'segmentOutHourFee', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '10', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('181', '22', 'times_fee', '按次收费：每次费用', 'decimal(10,2) unsigned', 'BigDecimal', 'timesFee', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '11', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('182', '22', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '12', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('183', '22', 'create_by', '创建人', 'bigint(20) unsigned', 'Long', 'createBy', '0', '0', '1', '1', null, null, null, 'EQ', 'input', '', '13', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('184', '23', 'id', null, 'bigint(20)', 'Long', 'id', '1', '1', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('185', '23', 'in', '进入时间', 'datetime', 'Date', 'in', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', '2', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('186', '23', 'out', '出场时间', 'datetime', 'Date', 'out', '0', '0', null, '1', '1', '1', '1', 'EQ', 'datetime', '', '3', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('187', '23', 'time', '停车时长，单位分钟', 'int(10) unsigned', 'Integer', 'time', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('188', '23', 'cost', '停车费用', 'decimal(7,2)', 'BigDecimal', 'cost', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '5', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('189', '23', 'license_plate', '车牌号', 'varchar(20)', 'String', 'licensePlate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '6', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('190', '23', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', null, null, null, 'EQ', 'datetime', '', '7', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('191', '23', 'create_by', '创建人', 'bigint(20)', 'Long', 'createBy', '0', '0', '1', '1', null, null, null, 'EQ', 'input', '', '8', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('192', '24', 'id', '主键', 'bigint(20)', 'Long', 'id', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('193', '24', 'open_id', '微信openid', 'varchar(100)', 'String', 'openId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('194', '24', 'user_name', '用户名', 'varchar(50)', 'String', 'userName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '3', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('195', '24', 'password', '密码', 'varchar(50)', 'String', 'password', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('196', '24', 'license_plate', '车牌号', 'varchar(20)', 'String', 'licensePlate', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '5', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('197', '24', 'tel', '电话', 'varchar(20)', 'String', 'tel', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '6', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('198', '24', 'creat_time', '创建时间', 'datetime', 'Date', 'creatTime', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', '7', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('199', '24', 'creat_by', '创建人', 'varchar(20)', 'String', 'creatBy', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '8', 'admin', '2021-04-07 16:47:58', '', null);
INSERT INTO `gen_table_column` VALUES ('200', '25', 'id', null, 'bigint(20)', 'Long', 'id', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2021-04-27 11:33:34', '', null);
INSERT INTO `gen_table_column` VALUES ('201', '25', 'name', null, 'varchar(255)', 'String', 'name', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2021-04-27 11:33:34', '', null);
INSERT INTO `gen_table_column` VALUES ('202', '25', 'url', null, 'varchar(255)', 'String', 'url', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2021-04-27 11:33:34', '', null);
INSERT INTO `gen_table_column` VALUES ('203', '25', 'model_id', null, 'bigint(20)', 'Long', 'modelId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2021-04-27 11:33:34', '', null);
INSERT INTO `gen_table_column` VALUES ('204', '26', 'id', null, 'bigint(20)', 'Long', 'id', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2023-09-08 10:57:22', '', null);
INSERT INTO `gen_table_column` VALUES ('205', '26', 'type_id', '分类ID', 'bigint(20)', 'Long', 'typeId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2023-09-08 10:57:22', '', null);
INSERT INTO `gen_table_column` VALUES ('206', '26', 'name', '名称', 'varchar(255)', 'String', 'name', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '3', 'admin', '2023-09-08 10:57:22', '', null);
INSERT INTO `gen_table_column` VALUES ('207', '26', 'start_date', '开始日期', 'datetime', 'Date', 'startDate', '0', '0', null, '1', '1', '1', '1', 'EQ', 'datetime', '', '4', 'admin', '2023-09-08 10:57:22', '', null);
INSERT INTO `gen_table_column` VALUES ('208', '26', 'end_date', '结束日期', 'datetime', 'Date', 'endDate', '0', '0', null, '1', '1', '1', '1', 'EQ', 'datetime', '', '5', 'admin', '2023-09-08 10:57:22', '', null);
INSERT INTO `gen_table_column` VALUES ('209', '26', 'address', '活动地址', 'varchar(255)', 'String', 'address', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '6', 'admin', '2023-09-08 10:57:22', '', null);
INSERT INTO `gen_table_column` VALUES ('210', '26', 'other', '其他信息', 'varchar(255)', 'String', 'other', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '7', 'admin', '2023-09-08 10:57:22', '', null);
INSERT INTO `gen_table_column` VALUES ('211', '26', 'phone', '联系电话', 'varchar(255)', 'String', 'phone', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '8', 'admin', '2023-09-08 10:57:22', '', null);
INSERT INTO `gen_table_column` VALUES ('212', '26', 'img', '封面图片', 'varchar(255)', 'String', 'img', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '9', 'admin', '2023-09-08 10:57:22', '', null);
INSERT INTO `gen_table_column` VALUES ('213', '26', 'content', '活动详情', 'text', 'String', 'content', '0', '0', null, '1', '1', '1', '1', 'EQ', 'editor', '', '10', 'admin', '2023-09-08 10:57:22', '', null);
INSERT INTO `gen_table_column` VALUES ('214', '26', 'start_time', '活动开始时间', 'datetime', 'Date', 'startTime', '0', '0', null, '1', '1', '1', '1', 'EQ', 'datetime', '', '11', 'admin', '2023-09-08 10:57:22', '', null);
INSERT INTO `gen_table_column` VALUES ('215', '26', 'end_time', '活动结束时间', 'datetime', 'Date', 'endTime', '0', '0', null, '1', '1', '1', '1', 'EQ', 'datetime', '', '12', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('216', '26', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', null, '1', null, null, null, 'EQ', 'datetime', '', '13', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('217', '26', 'create_by', '创建人', 'varchar(255)', 'String', 'createBy', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '14', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('218', '27', 'id', null, 'bigint(20)', 'Long', 'id', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('219', '27', 'name', '姓名', 'varchar(255)', 'String', 'name', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('220', '27', 'phone', '手机号', 'varchar(255)', 'String', 'phone', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('221', '27', 'idcard', '证件号码', 'varchar(255)', 'String', 'idcard', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('222', '27', 'appoint_date', '预约日期', 'datetime', 'Date', 'appointDate', '0', '0', null, '1', '1', '1', '1', 'EQ', 'datetime', '', '5', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('223', '27', 'start_time', '活动开始时间', 'datetime', 'Date', 'startTime', '0', '0', null, '1', '1', '1', '1', 'EQ', 'datetime', '', '6', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('224', '27', 'end_time', '活动结束时间', 'datetime', 'Date', 'endTime', '0', '0', null, '1', '1', '1', '1', 'EQ', 'datetime', '', '7', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('225', '27', 'acticity_id', '活动id', 'bigint(20)', 'Long', 'acticityId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '8', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('226', '27', 'create_time', null, 'datetime', 'Date', 'createTime', '0', '0', null, '1', null, null, null, 'EQ', 'datetime', '', '9', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('227', '27', 'create_by', null, 'varchar(255)', 'String', 'createBy', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '10', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('228', '28', 'id', null, 'bigint(20)', 'Long', 'id', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('229', '28', 'road_id', '马路或者街区或者打卡表的ID', 'bigint(20)', 'Long', 'roadId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('230', '28', 'type', '1:街区 2：马路 3：打卡线路\n', 'varchar(255)', 'String', 'type', '0', '0', null, '1', '1', '1', '1', 'EQ', 'select', '', '3', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('231', '28', 'create_time', null, 'datetime', 'Date', 'createTime', '0', '0', null, '1', null, null, null, 'EQ', 'datetime', '', '4', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('232', '28', 'create_by', null, 'varchar(255)', 'String', 'createBy', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '5', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('233', '29', 'id', null, 'bigint(20)', 'Long', 'id', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('234', '29', 'name', '街区名称', 'varchar(255)', 'String', 'name', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('235', '29', 'subtitle', '副标题', 'varchar(255)', 'String', 'subtitle', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('236', '29', 'type_id', '分类ID', 'bigint(20)', 'Long', 'typeId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('237', '29', 'content', '内容', 'text', 'String', 'content', '0', '0', null, '1', '1', '1', '1', 'EQ', 'editor', '', '5', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('238', '29', 'img', '封面图片地址', 'varchar(255)', 'String', 'img', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '6', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('239', '29', 'type', '1：街区 2：马路', 'varchar(255)', 'String', 'type', '0', '0', null, '1', '1', '1', '1', 'EQ', 'select', '', '7', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('240', '29', 'create_time', null, 'datetime', 'Date', 'createTime', '0', '0', null, '1', null, null, null, 'EQ', 'datetime', '', '8', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('241', '29', 'create_by', null, 'varchar(255)', 'String', 'createBy', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '9', 'admin', '2023-09-08 10:57:23', '', null);
INSERT INTO `gen_table_column` VALUES ('242', '30', 'id', null, 'bigint(20)', 'Long', 'id', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2023-09-08 10:57:30', '', null);
INSERT INTO `gen_table_column` VALUES ('243', '30', 'name', '名称', 'varchar(255)', 'String', 'name', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2023-09-08 10:57:30', '', null);
INSERT INTO `gen_table_column` VALUES ('244', '30', 'inx', '排序', 'varchar(255)', 'String', 'inx', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2023-09-08 10:57:30', '', null);
INSERT INTO `gen_table_column` VALUES ('245', '30', 'type', '1:街区 2：马路 3：打卡线路 4：活动\n', 'varchar(255)', 'String', 'type', '0', '0', null, '1', '1', '1', '1', 'EQ', 'select', '', '4', 'admin', '2023-09-08 10:57:30', '', null);
INSERT INTO `gen_table_column` VALUES ('246', '30', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', null, '1', null, null, null, 'EQ', 'datetime', '', '5', 'admin', '2023-09-08 10:57:30', '', null);
INSERT INTO `gen_table_column` VALUES ('247', '30', 'create_by', '创建人', 'varchar(255)', 'String', 'createBy', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '6', 'admin', '2023-09-08 10:57:30', '', null);
INSERT INTO `gen_table_column` VALUES ('248', '31', 'id', null, 'bigint(20)', 'Long', 'id', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2023-09-08 10:58:14', '', null);
INSERT INTO `gen_table_column` VALUES ('249', '31', 'title', '标题', 'varchar(255)', 'String', 'title', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2023-09-08 10:58:14', '', null);
INSERT INTO `gen_table_column` VALUES ('250', '31', 'subtitle', '副标题', 'varchar(255)', 'String', 'subtitle', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2023-09-08 10:58:14', '', null);
INSERT INTO `gen_table_column` VALUES ('251', '31', 'img', '封面图片', 'varchar(255)', 'String', 'img', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '4', 'admin', '2023-09-08 10:58:14', '', null);
INSERT INTO `gen_table_column` VALUES ('252', '31', 'content', '文创详情', 'text', 'String', 'content', '0', '0', null, '1', '1', '1', '1', 'EQ', 'editor', '', '5', 'admin', '2023-09-08 10:58:14', '', null);
INSERT INTO `gen_table_column` VALUES ('253', '31', 'create_time', null, 'datetime', 'Date', 'createTime', '0', '0', null, '1', null, null, null, 'EQ', 'datetime', '', '6', 'admin', '2023-09-08 10:58:14', '', null);
INSERT INTO `gen_table_column` VALUES ('254', '31', 'create_by', null, 'varchar(255)', 'String', 'createBy', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '7', 'admin', '2023-09-08 10:58:14', '', null);

-- ----------------------------
-- Table structure for history_human
-- ----------------------------
DROP TABLE IF EXISTS `history_human`;
CREATE TABLE `history_human` (
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of history_human
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `blob_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `calendar_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cron_expression` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_zone_id` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entry_id` varchar(95) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `instance_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fired_time` bigint(20) NOT NULL,
  `sched_time` bigint(20) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job_group` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_nonconcurrent` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requests_recovery` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job_class_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_durable` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_nonconcurrent` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_update_data` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requests_recovery` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', null, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200094C0009626567696E54696D6571007E00094C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0007656E6454696D6571007E00094C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C78707074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001622CDE29E07870707400007070707400013174000E302F3130202A202A202A202A203F74001172795461736B2E72794E6F506172616D7374000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000001740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', null, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200094C0009626567696E54696D6571007E00094C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0007656E6454696D6571007E00094C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C78707074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001622CDE29E07870707400007070707400013174000E302F3135202A202A202A202A203F74001572795461736B2E7279506172616D7328277279272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000002740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', null, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200094C0009626567696E54696D6571007E00094C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0007656E6454696D6571007E00094C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C78707074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001622CDE29E07870707400007070707400013174000E302F3230202A202A202A202A203F74003872795461736B2E72794D756C7469706C65506172616D7328277279272C20747275652C20323030304C2C203331362E3530442C203130302974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000003740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC8974000133740001317800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lock_name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `instance_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_checkin_time` bigint(20) NOT NULL,
  `checkin_interval` bigint(20) NOT NULL,
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('RuoyiScheduler', 'ymliu1781750547807', '1781750611182', '15000');

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `repeat_count` bigint(20) NOT NULL,
  `repeat_interval` bigint(20) NOT NULL,
  `times_triggered` bigint(20) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `str_prop_1` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `str_prop_2` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `str_prop_3` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `int_prop_1` int(11) DEFAULT NULL,
  `int_prop_2` int(11) DEFAULT NULL,
  `long_prop_1` bigint(20) DEFAULT NULL,
  `long_prop_2` bigint(20) DEFAULT NULL,
  `dec_prop_1` decimal(13,4) DEFAULT NULL,
  `dec_prop_2` decimal(13,4) DEFAULT NULL,
  `bool_prop_1` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bool_prop_2` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `next_fire_time` bigint(20) DEFAULT NULL,
  `prev_fire_time` bigint(20) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `trigger_state` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_type` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` bigint(20) NOT NULL,
  `end_time` bigint(20) DEFAULT NULL,
  `calendar_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `misfire_instr` smallint(6) DEFAULT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', null, '1781750550000', '-1', '5', 'PAUSED', 'CRON', '1781750547000', '0', null, '2', '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', null, '1781750550000', '-1', '5', 'PAUSED', 'CRON', '1781750548000', '0', null, '2', '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', null, '1781750560000', '-1', '5', 'PAUSED', 'CRON', '1781750548000', '0', null, '2', '');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '参数键名',
  `config_value` text COLLATE utf8mb4_unicode_ci COMMENT '参数键值',
  `config_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('1', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES ('2', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '初始化密码 123456');
INSERT INTO `sys_config` VALUES ('3', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES ('4', 'oss存储配置', 'sys.oss.cloudStorage', '{\"aliyunAccessKeyId\":\"LTAIwiq9uvDj2DT9\",\"aliyunAccessKeySecret\":\"b3vMSkQEwP7iGOXEb8l23vSDq860VX\",\"aliyunBucketName\":\"ar-travel\",\"aliyunDomain\":\"https://ar-travel-file.1jiaohu.com\",\"aliyunEndPoint\":\"oss-cn-shanghai.aliyuncs.com\",\"aliyunPrefix\":\"resource\",\"qcloudBucketName\":\"\",\"qcloudDomain\":\"\",\"qcloudPrefix\":\"\",\"qcloudRegion\":\"\",\"qcloudSecretId\":\"\",\"qcloudSecretKey\":\"\",\"qiniuAccessKey\":\"\",\"qiniuBucketName\":\"ios-app\",\"qiniuDomain\":\"\",\"qiniuPrefix\":\"upload\",\"qiniuSecretKey\":\"\",\"huaweiAccessKeyId\":\"QXWZLLLNDZZ6XZCHQWE7\",\"huaweiAccessKeySecret\":\"NBdndrqd2YGVG37jul6uaJ4CcJKtUQx3JDS6YTE3\",\"huaweiBucketName\":\"pzxx-ar-travel\",\"huaweiDomain\":\"https://pzxx-ar-travel.obs.cn-east-2.myhuaweicloud.com:443\",\"huaweiEndPoint\":\"obs.cn-east-2.myhuaweicloud.com\",\"huaweiPrefix\":\"resource\",\"type\":\"2\"}', 'N', 'admin', '2020-11-04 11:17:46', 'admin', '2021-09-18 13:51:20', 'oss存储配置');
INSERT INTO `sys_config` VALUES ('5', '短信参数配置', 'SMS_CONFIG_KEY', '{\"platform\":1,\"aliyunAccessKeyId\":\"LTAIwiq9uvDj2DT9\",\"aliyunAccessKeySecret\":\"b3vMSkQEwP7iGOXEb8l23vSDq860VX\",\"aliyunSignName\":\"PengZhuang\"}', 'N', 'admin', '2020-10-23 15:09:51', 'ry', '2020-10-23 15:10:00', '');
INSERT INTO `sys_config` VALUES ('102', '人流量检测配置', 'travel.humanTraffic', '{ 	\"default\": { 		\"inAdjustRate\": \"1.04\", 		\"outAdjustRate\": \"1\" 	}, 	\"140235456616075264\": { 		\"inAdjustRate\": \"1.08\", 		\"outAdjustRate\": \"1\" 	} }', 'N', 'admin', '2021-10-02 00:44:20', 'admin', '2021-10-02 18:47:20', 'key：对应的景点id\ninAdjustRate：进的人数调整比例，1.04表示调整为原来的104%\noutAdjustRate：出的人数调整比例');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '部门名称',
  `order_num` int(11) DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('100', '0', '0', '山西农业大学', '0', '山西农业大学', '15888888888', 'pz@touchspace.cn', '0', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2026-06-10 11:03:28');
INSERT INTO `sys_dept` VALUES ('101', '100', '0,100', '深圳总公司', '1', '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('102', '100', '0,100', '长沙分公司', '2', '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('103', '101', '0,100,101', '研发部门', '1', '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('104', '101', '0,100,101', '市场部门', '2', '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('105', '101', '0,100,101', '测试部门', '3', '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('106', '101', '0,100,101', '财务部门', '4', '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('107', '101', '0,100,101', '运维部门', '5', '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('108', '102', '0,100,102', '市场部门', '1', '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('109', '102', '0,100,102', '财务部门', '2', '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES ('110', '100', '0,100', '内部管理人员账号', '1', null, null, null, '0', '0', 'admin', '2024-01-03 11:36:39', '', null);
INSERT INTO `sys_dept` VALUES ('111', '100', '0,100', '文物管理人员', '2', null, null, null, '0', '2', 'admin', '2025-12-31 15:42:41', '', null);
INSERT INTO `sys_dept` VALUES ('112', '111', '0,100,111', '街道管理人员', '1', null, null, null, '0', '2', 'admin', '2026-01-04 10:39:39', '', null);
INSERT INTO `sys_dept` VALUES ('113', '100', '0,100', '文物街道管理人员', '3', null, null, null, '0', '2', 'admin', '2026-01-04 11:00:59', '', null);
INSERT INTO `sys_dept` VALUES ('114', '100', '0,100', '巡检员', '3', null, null, null, '0', '2', 'admin', '2026-01-07 10:59:29', '', null);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(11) DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES ('1', '1', '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '性别男');
INSERT INTO `sys_dict_data` VALUES ('2', '2', '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '性别女');
INSERT INTO `sys_dict_data` VALUES ('3', '3', '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '性别未知');
INSERT INTO `sys_dict_data` VALUES ('4', '1', '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '显示菜单');
INSERT INTO `sys_dict_data` VALUES ('5', '2', '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES ('6', '1', '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES ('7', '2', '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '停用状态');
INSERT INTO `sys_dict_data` VALUES ('8', '1', '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES ('9', '2', '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '停用状态');
INSERT INTO `sys_dict_data` VALUES ('10', '1', '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '默认分组');
INSERT INTO `sys_dict_data` VALUES ('11', '2', '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统分组');
INSERT INTO `sys_dict_data` VALUES ('12', '1', '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统默认是');
INSERT INTO `sys_dict_data` VALUES ('13', '2', '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统默认否');
INSERT INTO `sys_dict_data` VALUES ('14', '1', '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '通知');
INSERT INTO `sys_dict_data` VALUES ('15', '2', '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '公告');
INSERT INTO `sys_dict_data` VALUES ('16', '1', '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES ('17', '2', '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '关闭状态');
INSERT INTO `sys_dict_data` VALUES ('18', '1', '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '新增操作');
INSERT INTO `sys_dict_data` VALUES ('19', '2', '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '修改操作');
INSERT INTO `sys_dict_data` VALUES ('20', '3', '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '删除操作');
INSERT INTO `sys_dict_data` VALUES ('21', '4', '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '授权操作');
INSERT INTO `sys_dict_data` VALUES ('22', '5', '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '导出操作');
INSERT INTO `sys_dict_data` VALUES ('23', '6', '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '导入操作');
INSERT INTO `sys_dict_data` VALUES ('24', '7', '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '强退操作');
INSERT INTO `sys_dict_data` VALUES ('25', '8', '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '生成操作');
INSERT INTO `sys_dict_data` VALUES ('26', '9', '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '清空操作');
INSERT INTO `sys_dict_data` VALUES ('27', '1', '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES ('28', '2', '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '停用状态');
INSERT INTO `sys_dict_data` VALUES ('100', '0', '新大陆', 'newLand', 'device_specification', null, null, 'N', '0', 'admin', '2022-07-11 11:07:49', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('101', '10', '近现代', '1', 'cris_era_type', null, null, 'N', '0', 'admin', '2025-11-26 09:43:20', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('102', '20', '清代', '2', 'cris_era_type', null, null, 'N', '0', 'admin', '2025-11-26 09:43:35', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('103', '30', '宋辽西夏金元', '3', 'cris_era_type', null, null, 'N', '0', 'admin', '2025-11-26 09:43:53', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('104', '40', '明代', '4', 'cris_era_type', null, null, 'N', '0', 'admin', '2025-11-26 09:44:06', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('134', '10', '新发现', '1', 'cris_survey_type', null, null, 'N', '0', 'admin', '2025-11-26 09:52:48', 'admin', '2025-12-04 14:11:44', null);
INSERT INTO `sys_dict_data` VALUES ('135', '20', '无变更', '2', 'cris_survey_type', null, null, 'N', '0', 'admin', '2025-11-26 09:52:58', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('136', '10', '日常巡检', '1', 'crisrecord_type', null, null, 'N', '0', 'admin', '2025-11-26 09:53:36', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('137', '20', '异常上报', '2', 'crisrecord_type', null, null, 'N', '0', 'admin', '2025-11-26 09:53:46', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('138', '10', '文物保护', '1', 'cris_group_type', null, null, 'N', '0', 'admin', '2025-11-26 09:54:31', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('140', '20', '消防安全', '2', 'cris_group_type', null, null, 'N', '0', 'admin', '2025-11-26 09:54:53', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('141', '10', '正常', '1', 'cris_check_res', null, null, 'N', '0', 'admin', '2025-11-26 09:55:30', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('142', '20', '异常', '2', 'cris_check_res', null, null, 'N', '0', 'admin', '2025-11-26 09:55:37', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('143', '0', '近现代重要史迹及代表性建筑', '1', 'relicsType', null, null, 'N', '0', 'admin', '2025-11-26 15:51:42', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('144', '1', '古建筑', '2', 'relicsType', null, null, 'N', '0', 'admin', '2025-11-26 15:51:53', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('145', '2', '古墓葬', '3', 'relicsType', null, null, 'N', '0', 'admin', '2025-11-26 15:52:04', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('146', '0', '名人故、旧居', '1', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 15:52:44', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('147', '1', '典型风格建筑或者构筑物', '2', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 15:52:53', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('148', '2', '文化教育建筑及附属物', '3', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 15:53:29', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('149', '3', '医疗卫生建筑', '4', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 15:53:41', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('150', '4', '坛庙祠堂', '5', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 15:54:20', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('151', '5', '名人或贵族墓', '6', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 15:54:29', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('152', '6', '重要革命历史事件及革命人物活动纪念地', '7', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 15:54:39', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('153', '7', '宗教建筑', '8', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 15:54:49', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('154', '8', '寺观塔阁(及其他宗教建筑)', '9', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 15:55:02', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('155', '9', '其他近现代代表性建筑', '10', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 15:55:14', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('156', '10', '传统民居', '11', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 16:00:32', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('157', '11', '军事建筑及设施', '12', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 16:00:48', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('158', '12', '宅第民居', '13', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 16:00:56', 'admin', '2025-11-26 16:01:10', null);
INSERT INTO `sys_dict_data` VALUES ('159', '13', '烈士墓及纪念设施', '14', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 16:01:26', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('160', '14', '工业建筑及附属装置装备(以及其他工业遗产)', '15', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 16:01:38', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('161', '15', '交通道路设施', '16', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 16:01:50', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('162', '16', '其他为纪念重大历史事件或者著名人物建立的建筑物、构筑物等', '17', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 16:02:05', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('163', '17', '体量较大的各种材质(如石、铜、铁、泥等)雕塑', '18', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 16:02:16', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('164', '18', '重大历史事件和重要机构旧址(及战争遗址、工业遗址等)', '19', 'srelicsType', null, null, 'N', '0', 'admin', '2025-11-26 16:02:30', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('165', '0', '尚未核定公布为文物保护单位的不可移动文物', '1', 'relicsRank', null, null, 'N', '0', 'admin', '2025-11-26 16:03:26', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('166', '1', '省级文物保护单位', '2', 'relicsRank', null, null, 'N', '0', 'admin', '2025-11-26 16:03:38', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('167', '2', '全国重点文物保护单位', '3', 'relicsRank', null, null, 'N', '0', 'admin', '2025-11-26 16:03:48', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('168', '3', '市级和县级文物保护单位', '4', 'relicsRank', null, null, 'N', '0', 'admin', '2025-11-26 16:03:58', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('169', '4', '未认定', '5', 'relicsRank', null, null, 'N', '0', 'admin', '2025-11-26 16:04:08', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('170', '0', '五星级', '1', 'construction_hotel_type', null, null, 'N', '0', 'admin', '2025-12-05 15:00:26', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('171', '0', '四星级', '2', 'construction_hotel_type', null, null, 'N', '0', 'admin', '2025-12-05 15:00:31', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('172', '0', '经济型', '3', 'construction_hotel_type', null, null, 'N', '0', 'admin', '2025-12-05 15:00:42', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('173', '19', '水利、农业相关建筑、设施及附属物（以及其他水利与农业遗产）', '20', 'srelicsType', null, null, 'N', '0', 'admin', '2025-12-24 12:43:24', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('175', '0', '漕河泾街道', '1', 'cris_street', null, null, 'N', '0', 'admin', '2025-12-30 11:01:43', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('176', '1', '枫林街道', '2', 'cris_street', null, null, 'N', '0', 'admin', '2025-12-30 11:02:00', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('177', '2', '虹梅街道', '3', 'cris_street', null, null, 'N', '0', 'admin', '2025-12-30 11:02:13', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('178', '3', '湖南街道', '4', 'cris_street', null, null, 'N', '0', 'admin', '2025-12-30 11:02:24', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('179', '4', '华泾道', '5', 'cris_street', null, null, 'N', '0', 'admin', '2025-12-30 11:03:09', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('180', '5', '康建街道', '6', 'cris_street', null, null, 'N', '0', 'admin', '2025-12-30 11:03:31', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('181', '6', '凌云街道', '7', 'cris_street', null, null, 'N', '0', 'admin', '2025-12-30 11:03:48', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('182', '7', '龙华街道', '8', 'cris_street', null, null, 'N', '0', 'admin', '2025-12-30 11:04:02', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('183', '8', '天平街道', '9', 'cris_street', null, null, 'N', '0', 'admin', '2025-12-30 11:04:15', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('184', '9', '田林街道', '10', 'cris_street', null, null, 'N', '0', 'admin', '2025-12-30 11:04:33', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('185', '10', '斜土街道', '11', 'cris_street', null, null, 'N', '0', 'admin', '2025-12-30 11:04:46', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('186', '11', '徐家汇街道', '12', 'cris_street', null, null, 'N', '0', 'admin', '2025-12-30 11:04:56', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('187', '12', '长桥街道', '13', 'cris_street', null, null, 'N', '0', 'admin', '2025-12-30 11:05:08', '', null, null);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '字典类型',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES ('1', '用户性别', 'sys_user_sex', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '用户性别列表');
INSERT INTO `sys_dict_type` VALUES ('2', '菜单状态', 'sys_show_hide', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES ('3', '系统开关', 'sys_normal_disable', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统开关列表');
INSERT INTO `sys_dict_type` VALUES ('4', '任务状态', 'sys_job_status', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '任务状态列表');
INSERT INTO `sys_dict_type` VALUES ('5', '任务分组', 'sys_job_group', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '任务分组列表');
INSERT INTO `sys_dict_type` VALUES ('6', '系统是否', 'sys_yes_no', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统是否列表');
INSERT INTO `sys_dict_type` VALUES ('7', '通知类型', 'sys_notice_type', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '通知类型列表');
INSERT INTO `sys_dict_type` VALUES ('8', '通知状态', 'sys_notice_status', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '通知状态列表');
INSERT INTO `sys_dict_type` VALUES ('9', '操作类型', 'sys_oper_type', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '操作类型列表');
INSERT INTO `sys_dict_type` VALUES ('10', '系统状态', 'sys_common_status', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '登录状态列表');
INSERT INTO `sys_dict_type` VALUES ('100', '硬件规格', 'device_specification', '0', 'admin', '2022-07-11 11:07:33', '', null, null);
INSERT INTO `sys_dict_type` VALUES ('101', '统计年代', 'cris_era_type', '0', 'admin', '2025-11-26 09:33:05', '', null, '文物统计年代');
INSERT INTO `sys_dict_type` VALUES ('105', '调查类型', 'cris_survey_type', '0', 'admin', '2025-11-26 09:52:34', '', null, '文物调查类型');
INSERT INTO `sys_dict_type` VALUES ('106', '记录类型', 'crisrecord_type', '0', 'admin', '2025-11-26 09:53:23', '', null, null);
INSERT INTO `sys_dict_type` VALUES ('107', '检查分组类型', 'cris_group_type', '0', 'admin', '2025-11-26 09:54:07', '', null, null);
INSERT INTO `sys_dict_type` VALUES ('108', '检查结果值', 'cris_check_res', '0', 'admin', '2025-11-26 09:55:18', '', null, null);
INSERT INTO `sys_dict_type` VALUES ('109', '文物类别', 'relicsType', '0', 'admin', '2025-11-26 15:50:27', '', null, null);
INSERT INTO `sys_dict_type` VALUES ('110', '文物小类', 'srelicsType', '0', 'admin', '2025-11-26 15:50:52', '', null, null);
INSERT INTO `sys_dict_type` VALUES ('111', '文物级别', 'relicsRank', '0', 'admin', '2025-11-26 15:51:06', 'admin', '2025-11-26 16:10:50', null);
INSERT INTO `sys_dict_type` VALUES ('112', '酒店类型', 'construction_hotel_type', '0', 'admin', '2025-12-05 14:58:50', 'admin', '2025-12-05 14:59:10', null);
INSERT INTO `sys_dict_type` VALUES ('113', '保护级别', 'cris_protection_type', '0', 'admin', '2025-12-24 18:03:25', '', null, null);
INSERT INTO `sys_dict_type` VALUES ('114', '街道', 'cris_street', '0', 'admin', '2025-12-29 16:40:16', '', null, null);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES ('1', '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_job` VALUES ('2', '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_job` VALUES ('3', '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '日志信息',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=158851 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '操作系统',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15453 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES ('15451', 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-06-18 10:31:39');
INSERT INTO `sys_logininfor` VALUES ('15452', 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-06-18 10:31:46');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int(11) DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组件路径',
  `is_frame` int(11) DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int(11) DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4571 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '0', '17', 'system', null, '1', '0', 'M', '0', '0', '', 'system', 'admin', '2018-03-16 11:33:00', 'admin', '2022-06-29 16:18:32', '系统管理目录');
INSERT INTO `sys_menu` VALUES ('2', '系统监控', '0', '17', 'monitor', null, '1', '0', 'M', '0', '0', '', 'monitor', 'admin', '2018-03-16 11:33:00', 'admin', '2022-06-29 16:18:25', '系统监控目录');
INSERT INTO `sys_menu` VALUES ('3', '系统工具', '0', '17', 'tool', null, '1', '0', 'M', '0', '0', '', 'tool', 'admin', '2018-03-16 11:33:00', 'admin', '2022-06-29 16:18:35', '系统工具目录');
INSERT INTO `sys_menu` VALUES ('100', '用户管理', '1', '1', 'user', 'system/user/index', '1', '0', 'C', '0', '0', 'system:user:list', 'user', 'admin', '2018-03-16 11:33:00', 'admin', '2023-01-12 16:10:53', '用户管理菜单');
INSERT INTO `sys_menu` VALUES ('101', '角色管理', '1', '2', 'role', 'system/role/index', '1', '0', 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '角色管理菜单');
INSERT INTO `sys_menu` VALUES ('102', '菜单管理', '1', '3', 'menu', 'system/menu/index', '1', '0', 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES ('103', '部门管理', '1', '4', 'dept', 'system/dept/index', '1', '0', 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '部门管理菜单');
INSERT INTO `sys_menu` VALUES ('104', '岗位管理', '1', '5', 'post', 'system/post/index', '1', '0', 'C', '0', '0', 'system:post:list', 'post', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES ('105', '字典管理', '1', '6', 'dict', 'system/dict/index', '1', '0', 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '字典管理菜单');
INSERT INTO `sys_menu` VALUES ('106', '参数设置', '1', '7', 'config', 'system/config/index', '1', '0', 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '参数设置菜单');
INSERT INTO `sys_menu` VALUES ('107', '通知公告', '1', '8', 'notice', 'system/notice/index', '1', '0', 'C', '0', '1', 'system:notice:list', 'message', 'admin', '2018-03-16 11:33:00', 'admin', '2021-01-22 14:52:42', '通知公告菜单');
INSERT INTO `sys_menu` VALUES ('108', '日志管理', '1', '9', 'log', 'system/log/index', '1', '0', 'M', '0', '0', '', 'log', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '日志管理菜单');
INSERT INTO `sys_menu` VALUES ('109', '在线用户', '2', '1', 'online', 'monitor/online/index', '1', '0', 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '在线用户菜单');
INSERT INTO `sys_menu` VALUES ('110', '定时任务', '2', '2', 'job', 'monitor/job/index', '1', '0', 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '定时任务菜单');
INSERT INTO `sys_menu` VALUES ('111', '数据监控', '2', '3', 'druid', 'monitor/druid/index', '1', '0', 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '数据监控菜单');
INSERT INTO `sys_menu` VALUES ('112', '服务监控', '2', '4', 'server', 'monitor/server/index', '1', '0', 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '服务监控菜单');
INSERT INTO `sys_menu` VALUES ('113', '表单构建', '3', '1', 'build', 'tool/build/index', '1', '0', 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '表单构建菜单');
INSERT INTO `sys_menu` VALUES ('114', '代码生成', '3', '2', 'gen', 'tool/gen/index', '1', '0', 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '代码生成菜单');
INSERT INTO `sys_menu` VALUES ('115', '系统接口', '3', '3', 'swagger', 'tool/swagger/index', '1', '0', 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统接口菜单');
INSERT INTO `sys_menu` VALUES ('500', '操作日志', '108', '1', 'operlog', 'monitor/operlog/index', '1', '0', 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '操作日志菜单');
INSERT INTO `sys_menu` VALUES ('501', '登录日志', '108', '2', 'logininfor', 'monitor/logininfor/index', '1', '0', 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '登录日志菜单');
INSERT INTO `sys_menu` VALUES ('1001', '用户查询', '100', '1', '', '', '1', '0', 'F', '0', '0', 'system:user:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1002', '用户新增', '100', '2', '', '', '1', '0', 'F', '0', '0', 'system:user:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1003', '用户修改', '100', '3', '', '', '1', '0', 'F', '0', '0', 'system:user:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1004', '用户删除', '100', '4', '', '', '1', '0', 'F', '0', '0', 'system:user:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1005', '用户导出', '100', '5', '', '', '1', '0', 'F', '0', '0', 'system:user:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1006', '用户导入', '100', '6', '', '', '1', '0', 'F', '0', '0', 'system:user:import', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1007', '重置密码', '100', '7', '', '', '1', '0', 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1008', '角色查询', '101', '1', '', '', '1', '0', 'F', '0', '0', 'system:role:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1009', '角色新增', '101', '2', '', '', '1', '0', 'F', '0', '0', 'system:role:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1010', '角色修改', '101', '3', '', '', '1', '0', 'F', '0', '0', 'system:role:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1011', '角色删除', '101', '4', '', '', '1', '0', 'F', '0', '0', 'system:role:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1012', '角色导出', '101', '5', '', '', '1', '0', 'F', '0', '0', 'system:role:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1013', '菜单查询', '102', '1', '', '', '1', '0', 'F', '0', '0', 'system:menu:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1014', '菜单新增', '102', '2', '', '', '1', '0', 'F', '0', '0', 'system:menu:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1015', '菜单修改', '102', '3', '', '', '1', '0', 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1016', '菜单删除', '102', '4', '', '', '1', '0', 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1017', '部门查询', '103', '1', '', '', '1', '0', 'F', '0', '0', 'system:dept:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1018', '部门新增', '103', '2', '', '', '1', '0', 'F', '0', '0', 'system:dept:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1019', '部门修改', '103', '3', '', '', '1', '0', 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1020', '部门删除', '103', '4', '', '', '1', '0', 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1021', '岗位查询', '104', '1', '', '', '1', '0', 'F', '0', '0', 'system:post:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1022', '岗位新增', '104', '2', '', '', '1', '0', 'F', '0', '0', 'system:post:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1023', '岗位修改', '104', '3', '', '', '1', '0', 'F', '0', '0', 'system:post:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1024', '岗位删除', '104', '4', '', '', '1', '0', 'F', '0', '0', 'system:post:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1025', '岗位导出', '104', '5', '', '', '1', '0', 'F', '0', '0', 'system:post:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1026', '字典查询', '105', '1', '#', '', '1', '0', 'F', '0', '0', 'system:dict:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1027', '字典新增', '105', '2', '#', '', '1', '0', 'F', '0', '0', 'system:dict:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1028', '字典修改', '105', '3', '#', '', '1', '0', 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1029', '字典删除', '105', '4', '#', '', '1', '0', 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1030', '字典导出', '105', '5', '#', '', '1', '0', 'F', '0', '0', 'system:dict:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1031', '参数查询', '106', '1', '#', '', '1', '0', 'F', '0', '0', 'system:config:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1032', '参数新增', '106', '2', '#', '', '1', '0', 'F', '0', '0', 'system:config:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1033', '参数修改', '106', '3', '#', '', '1', '0', 'F', '0', '0', 'system:config:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1034', '参数删除', '106', '4', '#', '', '1', '0', 'F', '0', '0', 'system:config:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1035', '参数导出', '106', '5', '#', '', '1', '0', 'F', '0', '0', 'system:config:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1036', '公告查询', '107', '1', '#', '', '1', '0', 'F', '0', '0', 'system:notice:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1037', '公告新增', '107', '2', '#', '', '1', '0', 'F', '0', '0', 'system:notice:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1038', '公告修改', '107', '3', '#', '', '1', '0', 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1039', '公告删除', '107', '4', '#', '', '1', '0', 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1040', '操作查询', '500', '1', '#', '', '1', '0', 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1041', '操作删除', '500', '2', '#', '', '1', '0', 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1042', '日志导出', '500', '4', '#', '', '1', '0', 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1043', '登录查询', '501', '1', '#', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1044', '登录删除', '501', '2', '#', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1045', '日志导出', '501', '3', '#', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1046', '在线查询', '109', '1', '#', '', '1', '0', 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1047', '批量强退', '109', '2', '#', '', '1', '0', 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1048', '单条强退', '109', '3', '#', '', '1', '0', 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1049', '任务查询', '110', '1', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1050', '任务新增', '110', '2', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1051', '任务修改', '110', '3', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1052', '任务删除', '110', '4', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1053', '状态修改', '110', '5', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1054', '任务导出', '110', '7', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1055', '生成查询', '114', '1', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1056', '生成修改', '114', '2', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1057', '生成删除', '114', '3', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1058', '导入代码', '114', '2', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1059', '预览代码', '114', '4', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('1060', '生成代码', '114', '5', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES ('2000', '建筑管理', '0', '1', '/scenic', 'scenic/index', '1', '0', 'C', '0', '0', 'scenic:list', 'color', 'admin', '2020-11-25 10:58:29', 'admin', '2024-01-03 10:12:44', '');
INSERT INTO `sys_menu` VALUES ('2002', '识别库管理', '0', '8', '/recognition', 'recognition/index', '1', '0', 'C', '0', '0', 'recongnition:list', 'color', 'admin', '2020-11-25 14:01:44', 'admin', '2023-12-27 14:43:59', '');
INSERT INTO `sys_menu` VALUES ('2003', 'VR管理', '0', '7', '/vr', 'vr/index', '1', '0', 'C', '0', '0', 'vr:list', 'button', 'admin', '2020-11-25 14:04:58', 'admin', '2023-12-27 14:44:06', '');
INSERT INTO `sys_menu` VALUES ('2004', '景点新增', '2000', '1', '', '', '1', '0', 'F', '0', '0', 'scenic:add', '#', 'admin', '2020-11-25 14:10:21', '', null, '');
INSERT INTO `sys_menu` VALUES ('2007', '启动页管理', '0', '11', '/view', 'view/index', '1', '0', 'C', '0', '0', 'view:list', 'dashboard', 'admin', '2020-11-27 14:58:29', 'admin', '2024-01-03 09:45:58', '');
INSERT INTO `sys_menu` VALUES ('2009', '封面图管理', '0', '5', '/coverpics', 'coverPics/index', '1', '0', 'C', '0', '0', '', 'wechat', 'admin', '2021-01-05 17:49:48', 'admin', '2025-09-29 15:32:51', '');
INSERT INTO `sys_menu` VALUES ('2010', '历史人物', '0', '6', '/historyperson', 'person/index', '1', '0', 'C', '0', '0', '', 'peoples', 'admin', '2021-04-19 10:17:24', '', null, '');
INSERT INTO `sys_menu` VALUES ('2017', '首页', '0', '0', '/', 'index', '1', '0', 'C', '1', '0', '', 'checkbox', 'admin', '2022-03-03 17:49:14', 'admin', '2026-06-18 10:13:28', '');
INSERT INTO `sys_menu` VALUES ('2050', '活动通知', '2040', '4', '/activity', 'doorway/activity', '1', '0', 'C', '0', '0', '', 'chart', 'admin', '2023-12-28 17:40:46', 'admin', '2024-01-03 11:26:51', '');
INSERT INTO `sys_menu` VALUES ('2054', 'banner管理', '0', '7', '/banner', 'activity/index', '1', '0', 'C', '0', '0', '', 'checkbox', 'admin', '2024-01-02 10:27:07', 'admin', '2024-01-02 10:29:48', '');
INSERT INTO `sys_menu` VALUES ('2077', '文物图表', '2017', '3', '', null, '1', '0', 'F', '0', '0', 'chart:xunjian', '#', 'admin', '2026-01-05 10:25:15', 'admin', '2026-01-05 10:35:23', '');
INSERT INTO `sys_menu` VALUES ('2081', '首页图表', '2017', '1', '', null, '1', '0', 'F', '0', '0', 'chart:index', '#', 'admin', '2026-01-06 13:50:43', '', null, '');
INSERT INTO `sys_menu` VALUES ('4564', '热剧游', '0', '4', 'doorway', null, '1', '0', 'M', '0', '0', '', 'color', 'admin', '2023-12-28 10:43:26', 'admin', '2026-06-10 11:10:17', '');
INSERT INTO `sys_menu` VALUES ('4568', '宣传视频', '4564', '1', 'video', 'doorway/video', '1', '0', 'C', '0', '0', '', 'international', 'admin', '2023-12-28 10:55:39', 'admin', '2024-01-03 10:12:00', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES ('1', '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '管理员');
INSERT INTO `sys_notice` VALUES ('2', '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '模块标题',
  `business_type` int(11) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '请求方式',
  `operator_type` int(11) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '返回参数',
  `status` int(11) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1437 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES ('1339', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2059', '192.168.1.115', '内网IP', '{menuId=2059}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 10:29:07');
INSERT INTO `sys_oper_log` VALUES ('1340', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2047', '192.168.1.115', '内网IP', '{menuId=2047}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 10:29:58');
INSERT INTO `sys_oper_log` VALUES ('1341', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2046', '192.168.1.115', '内网IP', '{menuId=2046}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 10:30:11');
INSERT INTO `sys_oper_log` VALUES ('1342', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2068', '192.168.1.115', '内网IP', '{menuId=2068}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 10:31:17');
INSERT INTO `sys_oper_log` VALUES ('1343', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2058', '192.168.1.115', '内网IP', '{menuId=2058}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 10:31:53');
INSERT INTO `sys_oper_log` VALUES ('1344', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2073', '192.168.1.115', '内网IP', '{menuId=2073}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', '0', null, '2026-06-10 10:32:37');
INSERT INTO `sys_oper_log` VALUES ('1345', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2073', '192.168.1.115', '内网IP', '{menuId=2073}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', '0', null, '2026-06-10 10:32:49');
INSERT INTO `sys_oper_log` VALUES ('1346', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2057', '192.168.1.115', '内网IP', '{menuId=2057}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 10:38:41');
INSERT INTO `sys_oper_log` VALUES ('1347', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2073', '192.168.1.115', '内网IP', '{menuId=2073}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', '0', null, '2026-06-10 10:38:48');
INSERT INTO `sys_oper_log` VALUES ('1348', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2036', '192.168.1.115', '内网IP', '{menuId=2036}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 10:48:59');
INSERT INTO `sys_oper_log` VALUES ('1349', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2031', '192.168.1.115', '内网IP', '{menuId=2031}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', '0', null, '2026-06-10 10:49:05');
INSERT INTO `sys_oper_log` VALUES ('1350', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2062', '192.168.1.115', '内网IP', '{menuId=2062}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 10:49:13');
INSERT INTO `sys_oper_log` VALUES ('1351', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2048', '192.168.1.115', '内网IP', '{menuId=2048}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', '0', null, '2026-06-10 10:52:08');
INSERT INTO `sys_oper_log` VALUES ('1352', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2061', '192.168.1.115', '内网IP', '{menuId=2061}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 10:55:54');
INSERT INTO `sys_oper_log` VALUES ('1353', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2060', '192.168.1.115', '内网IP', '{menuId=2060}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 10:57:30');
INSERT INTO `sys_oper_log` VALUES ('1354', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2031', '192.168.1.115', '内网IP', '{menuId=2031}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', '0', null, '2026-06-10 10:59:07');
INSERT INTO `sys_oper_log` VALUES ('1355', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2051', '192.168.1.115', '内网IP', '{menuId=2051}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 10:59:17');
INSERT INTO `sys_oper_log` VALUES ('1356', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2053', '192.168.1.115', '内网IP', '{menuId=2053}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 10:59:26');
INSERT INTO `sys_oper_log` VALUES ('1357', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2071', '192.168.1.115', '内网IP', '{menuId=2071}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 10:59:45');
INSERT INTO `sys_oper_log` VALUES ('1358', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2070', '192.168.1.115', '内网IP', '{menuId=2070}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:00:02');
INSERT INTO `sys_oper_log` VALUES ('1359', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2052', '192.168.1.115', '内网IP', '{menuId=2052}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:00:26');
INSERT INTO `sys_oper_log` VALUES ('1360', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2048', '192.168.1.121', '内网IP', '{menuId=2048}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', '0', null, '2026-06-10 11:01:12');
INSERT INTO `sys_oper_log` VALUES ('1361', '角色管理', '3', 'com.ruoyi.web.controller.system.SysRoleController.remove()', 'DELETE', '1', 'admin', null, '/system/role/104', '192.168.1.121', '内网IP', '{roleIds=104}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:01:27');
INSERT INTO `sys_oper_log` VALUES ('1362', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2049', '192.168.1.121', '内网IP', '{menuId=2049}', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":500}', '0', null, '2026-06-10 11:01:33');
INSERT INTO `sys_oper_log` VALUES ('1363', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2048', '192.168.1.121', '内网IP', '{menuId=2048}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', '0', null, '2026-06-10 11:01:37');
INSERT INTO `sys_oper_log` VALUES ('1364', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2039', '192.168.1.121', '内网IP', '{menuId=2039}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', '0', null, '2026-06-10 11:01:57');
INSERT INTO `sys_oper_log` VALUES ('1365', '角色管理', '3', 'com.ruoyi.web.controller.system.SysRoleController.remove()', 'DELETE', '1', 'admin', null, '/system/role/107,109,108,103,101,102,105,100', '192.168.1.121', '内网IP', '{roleIds=107,109,108,103,101,102,105,100}', 'null', '1', '文物管理员已分配,不能删除', '2026-06-10 11:02:31');
INSERT INTO `sys_oper_log` VALUES ('1366', '角色管理', '3', 'com.ruoyi.web.controller.system.SysRoleController.remove()', 'DELETE', '1', 'admin', null, '/system/role/109,108,103,101,102,105,100', '192.168.1.121', '内网IP', '{roleIds=109,108,103,101,102,105,100}', 'null', '1', '巡检员已分配,不能删除', '2026-06-10 11:02:37');
INSERT INTO `sys_oper_log` VALUES ('1367', '部门管理', '2', 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', '1', 'admin', null, '/system/dept', '192.168.1.115', '内网IP', '{\"deptName\":\"山西农业大学\",\"leader\":\"山西农业大学\",\"deptId\":100,\"orderNum\":\"0\",\"delFlag\":\"0\",\"params\":{},\"parentId\":0,\"createBy\":\"admin\",\"children\":[],\"createTime\":1521171180000,\"phone\":\"15888888888\",\"updateBy\":\"admin\",\"ancestors\":\"0\",\"email\":\"pz@touchspace.cn\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:03:28');
INSERT INTO `sys_oper_log` VALUES ('1368', '角色管理', '3', 'com.ruoyi.web.controller.system.SysRoleController.remove()', 'DELETE', '1', 'admin', null, '/system/role/109,108,103,101,102,105,100,107', '192.168.1.121', '内网IP', '{roleIds=109,108,103,101,102,105,100,107}', 'null', '1', '巡检员已分配,不能删除', '2026-06-10 11:03:32');
INSERT INTO `sys_oper_log` VALUES ('1369', '部门管理', '3', 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', '1', 'admin', null, '/system/dept/111', '192.168.1.115', '内网IP', '{deptId=111}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:03:33');
INSERT INTO `sys_oper_log` VALUES ('1370', '部门管理', '3', 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', '1', 'admin', null, '/system/dept/113', '192.168.1.115', '内网IP', '{deptId=113}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:03:35');
INSERT INTO `sys_oper_log` VALUES ('1371', '部门管理', '3', 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', '1', 'admin', null, '/system/dept/114', '192.168.1.115', '内网IP', '{deptId=114}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:03:37');
INSERT INTO `sys_oper_log` VALUES ('1372', '角色管理', '3', 'com.ruoyi.web.controller.system.SysRoleController.remove()', 'DELETE', '1', 'admin', null, '/system/role/103', '192.168.1.121', '内网IP', '{roleIds=103}', 'null', '1', '家门口博物馆已分配,不能删除', '2026-06-10 11:03:57');
INSERT INTO `sys_oper_log` VALUES ('1373', '角色管理', '3', 'com.ruoyi.web.controller.system.SysRoleController.remove()', 'DELETE', '1', 'admin', null, '/system/role/105', '192.168.1.115', '内网IP', '{roleIds=105}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:03:59');
INSERT INTO `sys_oper_log` VALUES ('1374', '角色管理', '3', 'com.ruoyi.web.controller.system.SysRoleController.remove()', 'DELETE', '1', 'admin', null, '/system/role/106', '192.168.1.115', '内网IP', '{roleIds=106}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:04:03');
INSERT INTO `sys_oper_log` VALUES ('1375', '角色管理', '3', 'com.ruoyi.web.controller.system.SysRoleController.remove()', 'DELETE', '1', 'admin', null, '/system/role/101,109,107,108,103,100,102', '192.168.1.115', '内网IP', '{roleIds=101,109,107,108,103,100,102}', 'null', '1', '编辑1已分配,不能删除', '2026-06-10 11:04:15');
INSERT INTO `sys_oper_log` VALUES ('1376', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2039', '192.168.1.121', '内网IP', '{menuId=2039}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:04:46');
INSERT INTO `sys_oper_log` VALUES ('1377', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2048', '192.168.1.121', '内网IP', '{menuId=2048}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:04:48');
INSERT INTO `sys_oper_log` VALUES ('1378', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2049', '192.168.1.121', '内网IP', '{menuId=2049}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:04:52');
INSERT INTO `sys_oper_log` VALUES ('1379', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2031', '192.168.1.115', '内网IP', '{menuId=2031}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:04:57');
INSERT INTO `sys_oper_log` VALUES ('1380', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2073', '192.168.1.115', '内网IP', '{menuId=2073}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:05:08');
INSERT INTO `sys_oper_log` VALUES ('1381', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2069', '192.168.1.115', '内网IP', '{menuId=2069}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:05:10');
INSERT INTO `sys_oper_log` VALUES ('1382', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2082', '192.168.1.115', '内网IP', '{menuId=2082}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:05:12');
INSERT INTO `sys_oper_log` VALUES ('1383', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2067', '192.168.1.115', '内网IP', '{menuId=2067}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:05:14');
INSERT INTO `sys_oper_log` VALUES ('1384', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2072', '192.168.1.115', '内网IP', '{menuId=2072}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:05:16');
INSERT INTO `sys_oper_log` VALUES ('1385', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2066', '192.168.1.115', '内网IP', '{menuId=2066}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:05:22');
INSERT INTO `sys_oper_log` VALUES ('1386', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2065', '192.168.1.115', '内网IP', '{menuId=2065}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:05:24');
INSERT INTO `sys_oper_log` VALUES ('1387', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2063', '192.168.1.115', '内网IP', '{menuId=2063}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:05:51');
INSERT INTO `sys_oper_log` VALUES ('1388', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/4567', '192.168.1.115', '内网IP', '{menuId=4567}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:06:33');
INSERT INTO `sys_oper_log` VALUES ('1389', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/4569', '192.168.1.115', '内网IP', '{menuId=4569}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:06:43');
INSERT INTO `sys_oper_log` VALUES ('1390', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/4570', '192.168.1.115', '内网IP', '{menuId=4570}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:06:53');
INSERT INTO `sys_oper_log` VALUES ('1391', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2064', '192.168.1.115', '内网IP', '{menuId=2064}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:07:07');
INSERT INTO `sys_oper_log` VALUES ('1392', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2056', '192.168.1.115', '内网IP', '{menuId=2056}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:07:16');
INSERT INTO `sys_oper_log` VALUES ('1393', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2037', '192.168.1.115', '内网IP', '{menuId=2037}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:07:21');
INSERT INTO `sys_oper_log` VALUES ('1394', '删除栏目', '5', 'com.pz.travel.controller.TravelBackstageController.remove1()', 'DELETE', '1', 'admin', null, '/travel/backstage/moudule/302945025682313216', '192.168.1.115', '内网IP', '{id=302945025682313216}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 11:09:33\"}', '0', null, '2026-06-10 11:09:33');
INSERT INTO `sys_oper_log` VALUES ('1395', '删除栏目', '5', 'com.pz.travel.controller.TravelBackstageController.remove1()', 'DELETE', '1', 'admin', null, '/travel/backstage/moudule/302598825200324608', '192.168.1.115', '内网IP', '{id=302598825200324608}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 11:09:35\"}', '0', null, '2026-06-10 11:09:35');
INSERT INTO `sys_oper_log` VALUES ('1396', '删除栏目', '5', 'com.pz.travel.controller.TravelBackstageController.remove1()', 'DELETE', '1', 'admin', null, '/travel/backstage/moudule/301779671497052160', '192.168.1.115', '内网IP', '{id=301779671497052160}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 11:09:36\"}', '0', null, '2026-06-10 11:09:36');
INSERT INTO `sys_oper_log` VALUES ('1397', '删除栏目', '5', 'com.pz.travel.controller.TravelBackstageController.remove1()', 'DELETE', '1', 'admin', null, '/travel/backstage/moudule/923342', '192.168.1.115', '内网IP', '{id=923342}', '{\"code\":200,\"data\":\"不可删除\",\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 11:09:41\"}', '0', null, '2026-06-10 11:09:40');
INSERT INTO `sys_oper_log` VALUES ('1398', '删除栏目', '5', 'com.pz.travel.controller.TravelBackstageController.remove1()', 'DELETE', '1', 'admin', null, '/travel/backstage/moudule/912419', '192.168.1.115', '内网IP', '{id=912419}', '{\"code\":200,\"data\":\"不可删除\",\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 11:09:43\"}', '0', null, '2026-06-10 11:09:42');
INSERT INTO `sys_oper_log` VALUES ('1399', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '192.168.1.115', '内网IP', '{\"visible\":\"0\",\"icon\":\"color\",\"orderNum\":\"4\",\"menuName\":\"热剧游\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"doorway\",\"children\":[],\"createTime\":1703731406000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":4564,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 11:10:17');
INSERT INTO `sys_oper_log` VALUES ('1400', '删除', '3', 'com.pz.travel.controller.HistoryHumanController.delete()', 'DELETE', '1', 'admin', null, '/travel/human/delete', '192.168.1.115', '内网IP', '{}', '{\"code\":200,\"data\":1,\"msg\":\"成功\",\"success\":true,\"timestamp\":\"2026-06-10 11:11:10\"}', '0', null, '2026-06-10 11:11:10');
INSERT INTO `sys_oper_log` VALUES ('1401', '删除栏目', '5', 'com.pz.travel.controller.TravelBackstageController.remove1()', 'DELETE', '1', 'admin', null, '/travel/backstage/moudule/912419', '192.168.1.115', '内网IP', '{id=912419}', '{\"code\":200,\"data\":\"不可删除\",\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 11:12:13\"}', '0', null, '2026-06-10 11:12:13');
INSERT INTO `sys_oper_log` VALUES ('1402', '删除栏目', '5', 'com.pz.travel.controller.TravelBackstageController.remove1()', 'DELETE', '1', 'admin', null, '/travel/backstage/moudule/923342', '192.168.1.115', '内网IP', '{id=923342}', '{\"code\":200,\"data\":\"不可删除\",\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 11:12:15\"}', '0', null, '2026-06-10 11:12:15');
INSERT INTO `sys_oper_log` VALUES ('1403', '删除二级分类', '3', 'com.pz.travel.controller.TravelBackstageController.remove2()', 'DELETE', '1', 'admin', null, '/travel/backstage/deleteTravelsubclassfication/169863465526366208', '192.168.1.115', '内网IP', '{id=169863465526366208}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 11:12:29\"}', '0', null, '2026-06-10 11:12:29');
INSERT INTO `sys_oper_log` VALUES ('1404', '删除二级分类', '3', 'com.pz.travel.controller.TravelBackstageController.remove2()', 'DELETE', '1', 'admin', null, '/travel/backstage/deleteTravelsubclassfication/301830026398273536', '192.168.1.115', '内网IP', '{id=301830026398273536}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 11:12:31\"}', '0', null, '2026-06-10 11:12:31');
INSERT INTO `sys_oper_log` VALUES ('1405', '删除二级分类', '3', 'com.pz.travel.controller.TravelBackstageController.remove2()', 'DELETE', '1', 'admin', null, '/travel/backstage/deleteTravelsubclassfication/301883053981306880', '192.168.1.115', '内网IP', '{id=301883053981306880}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 11:12:33\"}', '0', null, '2026-06-10 11:12:32');
INSERT INTO `sys_oper_log` VALUES ('1406', '删除二级分类', '3', 'com.pz.travel.controller.TravelBackstageController.remove2()', 'DELETE', '1', 'admin', null, '/travel/backstage/deleteTravelsubclassfication/301826416620867584', '192.168.1.115', '内网IP', '{id=301826416620867584}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 11:12:34\"}', '0', null, '2026-06-10 11:12:34');
INSERT INTO `sys_oper_log` VALUES ('1407', '新增景点', '1', 'com.pz.travel.controller.TravelBackstageController.add()', 'POST', '1', 'admin', null, '/travel/backstage/add', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"java.io.FileNotFoundException: L:\\\\data\\\\xuhui_travel\\\\basedir\\\\work\\\\Tomcat\\\\localhost\\\\ROOT\\\\data\\\\xuhui_travel\\\\files\\\\20260610\\\\e7a632f1-c6f3-4508-968f-71f4b36a5839山西铭贤学校(1).jpg (系统找不到指定的路径。)\",\"audioUrl\":\"\",\"id\":819640159091036160,\"travelModelVideos\":[],\"englishIntroduction\":\"\",\"longitude\":\"37.425856,112.582578\",\"pictureUrl\":\"java.io.FileNotFoundException: L:\\\\data\\\\xuhui_travel\\\\basedir\\\\work\\\\Tomcat\\\\localhost\\\\ROOT\\\\data\\\\xuhui_travel\\\\files\\\\20260610\\\\3c610e28-b6a9-439e-89ce-fb1f725e351a山西铭贤学校(1).jpg (系统找不到指定的路径。)\",\"activityName\":\"\",\"activityUrl\":\"\",\"isVr\":0,\"name\":\"山西铭贤学校旧址\",\"chineseOpenTime\":\"全天\",\"englishName\":\"Oberlin Shansi Memorial School Old Sit\",\"activity\":0,\"travelJointList\":[],\"content\":\"<p><img src=\\\"https://ar-travel.1jiaohu.com/files/20250929/a998eb72-782c-4a5b-a575-fa61ceb1fbe5ccc33bdf0cd84f5080726134406e0f3c.gif\\\"/><br/><br/></p><p style=\\\"text-align:center;\\\">山西铭贤学校旧址</p><p><img src=\\\"https://ar-travel.1jiaohu.com/files/20250929/d4156e0b-fbf8-4baa-8947-58c0270a4f94%E5%B1%B1%E8%A5%BF%E9%93%AD%E8%B4%A4%E5%AD%A6%E6%A0%A1.jpg\\\" data-extentions-extra-ocr-id=\\\"43d531f5c14e129461062a844ac2d031\\\" width=\\\"100%\\\"/></p><p>清<a href=\\\"https://baike.baidu.com/item/%E5%AE%A3%E7%BB%9F/1523933?fromModule=lemma_inlink\\\" target=\\\"_blank\\\">宣统</a>元年（1909年），孔祥熙将创办的铭贤学校搬迁至山西铭贤学校旧址，随学校的发展扩大，校舍陆续增建形成现有规模。民国二十一年（1932年）学校南迁，更名为铭贤学院。</p><p>1950年，铭贤学院迁回山西铭贤学校旧址。</p><p>1951年，山西铭贤学校被政府接收，更名为山西农学院。</p><p>1979年，山西农学院更名为山西农业大学。</p><p><br/></p><p style=\\\"text-align:center;\\\"><img src=\\\"https://ar-travel.1jiaohu.com/files/20250929/a55f6333-5c3e-4d6b-be3f-37f4b74a3e5ewps.png\\\" data-extentions-extra-ocr-id=\\\"bc57d408d846962bb47a5a2f1eea350d\\\"/>《亮剑》中南京军事学院一太谷<a target=\\\"_blank\\\" href=\\\"https://ent.163.com/keywords/5/7/5c71897f/1.html\\\">山西</a>农业大学</p><p><br/></p><p style=\\\"text-align:center;\\\"><img src=\\\"https://ar-travel.1jiaohu.com/files/20250929/5578d578-b145-4512-8ac2-399e53a5eb43wps%20(1).png\\\" data-extentions-extra-ocr-id=\\\"4e31cc9a68c6daeaf6aca8b50b87e48a\\', '{\"code\":301,\"message\":\"请检查数据内容\",\"msg\":\"请检查数据内容\",\"success\":false,\"timestamp\":\"2026-06-10 11:21:51\"}', '0', null, '2026-06-10 11:21:51');
INSERT INTO `sys_oper_log` VALUES ('1408', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '192.168.1.121', '内网IP', '{\"visible\":\"0\",\"icon\":\"checkbox\",\"orderNum\":\"0\",\"menuName\":\"首页\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"/\",\"component\":\"index\",\"children\":[],\"createTime\":1646300954000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2017,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-10 16:48:13');
INSERT INTO `sys_oper_log` VALUES ('1409', '删除景点', '3', 'com.pz.travel.controller.TravelBackstageController.delete()', 'DELETE', '1', 'admin', null, '/travel/backstage/scenicspot/110094003508350976', '192.168.1.115', '内网IP', '{id=110094003508350976}', 'null', '1', 'null', '2026-06-10 16:51:50');
INSERT INTO `sys_oper_log` VALUES ('1410', '删除景点', '3', 'com.pz.travel.controller.TravelBackstageController.delete()', 'DELETE', '1', 'admin', null, '/travel/backstage/scenicspot/110094003508350976', '192.168.1.121', '内网IP', '{id=110094003508350976}', 'null', '1', 'null', '2026-06-10 16:51:55');
INSERT INTO `sys_oper_log` VALUES ('1411', '新增景点', '1', 'com.pz.travel.controller.TravelBackstageController.add()', 'POST', '1', 'admin', null, '/travel/backstage/add', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/b36bd62ed70340ae9a9acdb9df1294ec.jpg\",\"audioUrl\":\"\",\"id\":819723818527625216,\"travelModelVideos\":[],\"englishIntroduction\":\"\",\"longitude\":\"37.425856,112.582578\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/d18d6024be6749f18fa5208b5cff939c.jpg\",\"activityName\":\"\",\"activityUrl\":\"\",\"isVr\":0,\"name\":\"山西铭贤学校旧址\",\"englishName\":\"Oberlin Shansi Memorial School Old Sit\",\"activity\":0,\"travelJointList\":[{\"scenicId\":819723818527625216,\"id\":819723818527625217,\"classificationId\":\"301883092531154944\"}],\"content\":\"<p style=\\\"text-align:center;\\\"><img src=\\\"https://ar-travel.1jiaohu.com/files/20250929/a998eb72-782c-4a5b-a575-fa61ceb1fbe5ccc33bdf0cd84f5080726134406e0f3c.gif\\\" width=\\\"30%\\\"/><br/><br/></p><p style=\\\"text-align:center;\\\">山西铭贤学校旧址</p><p><img src=\\\"https://ar-travel.1jiaohu.com/files/20250929/d4156e0b-fbf8-4baa-8947-58c0270a4f94%E5%B1%B1%E8%A5%BF%E9%93%AD%E8%B4%A4%E5%AD%A6%E6%A0%A1.jpg\\\" data-extentions-extra-ocr-id=\\\"43d531f5c14e129461062a844ac2d031\\\" width=\\\"100%\\\"/></p><p>清<a href=\\\"https://baike.baidu.com/item/%E5%AE%A3%E7%BB%9F/1523933?fromModule=lemma_inlink\\\" target=\\\"_blank\\\">宣统</a>元年（1909年），孔祥熙将创办的铭贤学校搬迁至山西铭贤学校旧址，随学校的发展扩大，校舍陆续增建形成现有规模。民国二十一年（1932年）学校南迁，更名为铭贤学院。</p><p>1950年，铭贤学院迁回山西铭贤学校旧址。</p><p>1951年，山西铭贤学校被政府接收，更名为山西农学院。</p><p>1979年，山西农学院更名为山西农业大学。</p><p><br/></p><p><img src=\\\"https://ar-travel.1jiaohu.com/files/20250929/a55f6333-5c3e-4d6b-be3f-37f4b74a3e5ewps.png\\\" data-extentions-extra-ocr-id=\\\"bc57d408d846962bb47a5a2f1eea350d\\\"/>《亮剑》中南京军事学院一太谷<a target=\\\"_blank\\\" href=\\\"https://ent.163.com/keywords/5/7/5c71897f/1.html\\\">山西</a>农业大学</p><p><br/></p><p><img src=\\\"https://ar-travel.1jiaohu.com/files/20250929/5578d578-b145-4512-8ac2-399e53a5eb43wps%20(1).png\\\" data-extentions-extra-ocr-id=\\\"4e31cc9a68c6daeaf6aca8b50b87e48a\\\"/>《亮剑》中南京军事学院一太谷山西农业大学</p><p><br/></p><p><img src=\\\"https://ar-travel.1jiaohu.com/files/20250929/6893a329-07ec-4276-baef-9649bc965c2bwps%20(2).png\\\" data-', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 16:54:16\"}', '0', null, '2026-06-10 16:54:16');
INSERT INTO `sys_oper_log` VALUES ('1412', '新增景点', '1', 'com.pz.travel.controller.TravelBackstageController.add()', 'POST', '1', 'admin', null, '/travel/backstage/add', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/fc3aadc692584aa68829aa598ba6c4f8.png\",\"audioUrl\":\"\",\"id\":819725592235872256,\"travelModelVideos\":[],\"englishIntroduction\":\"\",\"longitude\":\"37.424698,112.5820\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/571efc98d49549dea908da666de2fe0a.png\",\"activityName\":\"\",\"activityUrl\":\"\",\"isVr\":0,\"name\":\"韩氏楼\",\"chineseOpenTime\":\"全天\",\"englishName\":\"The Han Building\",\"activity\":0,\"travelJointList\":[],\"content\":\"<p>1924年落成的韩氏楼，是铭贤学校时期建成的主要建筑物之一，由美藉人氏韩明卫（Hemingway）家族捐款兴建。</p><p>孔祥熙在美国欧柏林大学求学时与美籍学生D.W.H.Hemingway相识交好，并为之起了个中国名字韩明卫。1903年韩明卫携新婚妻子韩美瑞到中国传教。1904年来到太谷，在孟家花园办起仁术医院（1901年办理教案时，孟家花园被据为教会财产），自任院长。1909年为支持铭贤学堂扩大办学规模，韩明卫将孟家花园换让给铭贤学堂。1924年建成韩氏楼，据《铭贤廿週纪念》标注：韩明卫之弟为纪念其母捐建韩氏楼，实则是韩氏家族共建。</p><p>韩氏楼位于嘉桂科学楼西南方，建筑面积1026平方米。古式建筑，砖木结构，青瓦大屋顶，十二角飞檐。东、中、西三处楼门均向北开启。中门与东西门之间的墙上各镶嵌一黑色石块，上刻有“韩氏纪念”和 “HEMINGWAYMEMORIAL1924”字样。屋内为地下一层，地上两层，楼梯、地面全为实木结构，居室全部向阳，北侧为入室通道。铭贤时期，地下一层为供暖、供热水和洗浴处，地上二层居室用作男生宿舍。1951年9月改称第一学生宿舍，后改为单身教职工宿舍和研究生宿舍。</p><p><br/></p><p style=\\\"text-align:center;\\\"><img src=\\\"https://ar-travel.1jiaohu.com/files/20250929/f7edf0db-7b0b-4d72-8cb6-52ce6c520bc9%E9%9F%A9%E6%B0%8F%E6%A5%BC%20(2).png\\\" data-extentions-extra-ocr-id=\\\"1de9b28daba3609395a3a9b7912f3616\\\"/><img src=\\\"https://ar-travel.1jiaohu.com/files/20250929/92367410-5358-4a89-96e4-b9c513bcfdd9%E9%9F%A9%E6%B0%8F%E6%A5%BC%20(3).png\\\" data-extentions-extra-ocr-id=\\\"f12929b7b49e9a85970a153a2da785db\\\"/></p>\",\"videoUrl\":\"\",\"moduleId\":847162,\"ticket\":\"免费\",\"createBy\":\"1\",\"inx\":1,\"relateDetailIds\":[],\"createTime\":1781082079842,\"videoCover\":\"\",\"remarks\":\"山西农业大学\"}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 17:01:19\"}', '0', null, '2026-06-10 17:01:19');
INSERT INTO `sys_oper_log` VALUES ('1413', '新增景点', '1', 'com.pz.travel.controller.TravelBackstageController.add()', 'POST', '1', 'admin', null, '/travel/backstage/add', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/9cb1b909ddfd4c1fa46d6289f01a53e0.png\",\"audioUrl\":\"\",\"id\":819726131627560960,\"travelModelVideos\":[],\"englishIntroduction\":\"\",\"longitude\":\"37.42205,112.58571\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/4b7cd7f564be47378faf1842e41cde63.png\",\"isVr\":0,\"name\":\"亭兰图书馆\",\"englishName\":\"The Tinglan Library of Shanxi Agricultural University\",\"content\":\"<p>1936年间先后竣工落成的亭兰图书馆、嘉桂科学楼，是铭贤学校时期建成的主要建筑物，由孔祥熙及其夫人宋霭龄于1935年7月为纪念双方父母而筹建。</p><p>亭兰图书馆和嘉桂科学楼各取孔祥熙和宋霭龄父母名字中的二字命名。著名书法家赵铁山亲书其名。当年由我校果树专家贾麟厚教授在两楼背面栽植的十几株加拿大毛白杨，至今己成参天大树。楼与大树相辉映，更显历史的厚重感。</p><p>此二楼主体结构由美国建筑设计师墨菲（HenryKilamMurphy）设计，天津基泰工程公司、天津营造公司补充画图并承建，为中西合璧风格（外观是中式，但内部构造却是西式）。两楼建筑面积都为1382平方米 （其中地下室各为309平米），总投资19.4万元。</p><p>两楼均为三层建筑，地上两层，地下一层，顶上有四面开启洞窗的隔热跃层。建筑用料为青砖、石料、水泥、木材。外墙以五层（其中亭兰外露四层）条型剁石、四层水泥预制块与多层青砖垒起。四壁开设工字型连接的方格窗户，上下窗口间有仿大理石彩墙相隔。室内地板、楼梯、扶手全用精心磨制的钢骨水泥注成。两楼地下室有供暖间、储存室、卫生间（配有座式马桶）等。</p><p>两楼楼门抱厦均建在五级石基（其中亭兰外露四层）上，双柱上端与飞檐下部雕刻着“瓶”、“鼎”及 “香炉”等，寓意平等与香火旺盛；又有海马、水壶，红色门柱以示水火相济。两楼门分别向西、向东开启，遥相对峙，意为“门当户对”。屋顶由木构架支承，形成中国建筑特有的曲面大屋顶。顶面用彩色琉璃瓦料铺成。众多彩色吻兽立于屋脊，有“大吻”“重兽”“戗兽”“合角吻兽”；在 “重兽”与“戗兽”前还有多处五个一队的“仙人走兽”，在这些走兽前有一个骑着似凤似鸡的领队，俗称“仙人”。梁枋斗栱彩绘醒目，八角飞檐湾曲高翘，有如翚鸟展翅高飞。其等级有似古代皇家大院中六宫的建筑风格。真乃极尽辉煌壮丽、美轮美奂之能事，这在晋中乡村甚至县城众多官商大院中也属少见。有道是：“剁石青砖大屋顶，中西合璧出茂工。内室精装取西法，屋顶仙兽袭六宫。孔宋儿女争高下，嘉桂亭兰各西东。家事逸闻成往趣，图书科学久对门。经风沐雨八十代，华屋檐下满燕影”。</p><p>亭兰图书馆，取孔祥熙父亲孔和亭的“亭”字和母亲庞玉兰的“兰”字命名。铭贤时期第一层为纪念室、办公室、编目室、阅报室及书库；第二层为阅览室及书库。书库上下可容书10万余册，阅览室可容二百余人同时阅览。为防火，楼内地板、楼梯踏步及栏杆均为水磨石材质，库内书架全部为铁架。阅览室屋内装设无影灯，光线明亮而柔和，不刺眼。桌椅为核桃木制，光滑细致。椅子腿下有橡皮垫，即使有人拖动也不会发出噪音干扰他人。两座图书台，为红木所制，整体为圆形，曲线如人背，设计非常人性化，坐着很舒适。室内备有各种书报杂志，可供读者自由阅览。目录分多种类型编排，方便学生按照书名、作者姓名、出版书店等方式查询，查询方法由北京请来的图书专家编制。图书功能一直延续至今。</p><p><br/></p><p data-we-empty-p=\\\"\\\" style=\\\"text-align:center;\\\"><img src=\\\"https://ar-travel-file.1jiaohu.com/resource/20260610/4444724780ce47c59e920c3464031d66.png\\\" style=\\\"max-width:100%;\\\" contenteditable=\\\"false\\\" data-extentions-extra-ocr-id=\\\"a4ae48d4d0f7a5685fae06fa77337953\\\"/></p>\",\"videoUrl\":\"\",\"moduleId\":847162,\"createBy', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 17:03:28\"}', '0', null, '2026-06-10 17:03:28');
INSERT INTO `sys_oper_log` VALUES ('1414', '新增景点', '1', 'com.pz.travel.controller.TravelBackstageController.add()', 'POST', '1', 'admin', null, '/travel/backstage/add', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/79498353e91d4b25944e41220f964b33.png\",\"audioUrl\":\"\",\"id\":819726611355275264,\"travelModelVideos\":[],\"englishIntroduction\":\"\",\"longitude\":\"37.42493,112.5827\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/51ffe00764924e60b0274bed24f978d3.png\",\"isVr\":0,\"name\":\"嘉桂科学楼\",\"englishName\":\"The Jia Gui Science Building of Shanxi Agricultural University\",\"content\":\"<p>嘉桂科学楼，取宋霭龄父亲宋嘉树的“嘉”字和母亲倪桂珍的“桂”字命名。铭贤时期第一层为物理实验室、生物实验室、仪器室、材料室、教室及教员室等；第二层为化学实验室、标本室、天平室、储存室、教室及教员室等。实验室仪器设备精良齐全，可供十几人同时实验。生物标本种类较多。各科的教室与实验室相通，取用方便。1951年以来曾为实验室、教室、图书室，及人事处、档案馆、学报、新农村发展研究院等办公处。</p><p><br/></p><p><img src=\\\"https://ar-travel.1jiaohu.com/files/20250929/57e0159e-cf28-4c48-9dbf-2368c2354fb4%E5%98%89%E6%A1%82%E7%A7%91%E5%AD%A6%E6%A5%BC1.png\\\" data-extentions-extra-ocr-id=\\\"b5a101869139c7e014866e3325d2dfe9\\\"/></p>\",\"videoUrl\":\"\",\"moduleId\":847162,\"createBy\":\"1\",\"inx\":1,\"relateDetailIds\":[],\"createTime\":1781082322819,\"videoCover\":\"\",\"remarks\":\"铭贤南路1号\"}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 17:05:22\"}', '0', null, '2026-06-10 17:05:22');
INSERT INTO `sys_oper_log` VALUES ('1415', '新增景点', '1', 'com.pz.travel.controller.TravelBackstageController.add()', 'POST', '1', 'admin', null, '/travel/backstage/add', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/0cae1aaadca348de8427946e0293a0f5.png\",\"audioUrl\":\"\",\"id\":819727024129314816,\"travelModelVideos\":[],\"englishIntroduction\":\"\",\"longitude\":\"37.42403,112.5805\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/c6ef9a1f25034d59b28e601ac8a6b030.png\",\"isVr\":0,\"name\":\"山西农业大学图书馆大楼\",\"englishName\":\"The Library Building of Shanxi Agricultural University\",\"content\":\"<p>山西农业大学的图书馆大楼是学校的重要设施之一，具有丰富的藏书和现代化的设施。山西农业大学的图书馆大楼不仅是学校的重要学术资源中心，也是校园文化建设的重要组成部分。</p><p><br/></p><p><img src=\\\"https://ar-travel-file.1jiaohu.com/resource/20260610/23f0df7e344c4ea892d228f20a52add1.png\\\" style=\\\"max-width:100%;\\\" contenteditable=\\\"false\\\" data-extentions-extra-ocr-id=\\\"642aa12f2dd4424679c4ec97b71d5b4b\\\"/></p>\",\"videoUrl\":\"\",\"moduleId\":847162,\"createBy\":\"1\",\"inx\":1,\"relateDetailIds\":[],\"createTime\":1781082421232,\"videoCover\":\"\",\"remarks\":\"山西农业大学图书馆大楼\"}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 17:07:01\"}', '0', null, '2026-06-10 17:07:01');
INSERT INTO `sys_oper_log` VALUES ('1416', '新增景点', '1', 'com.pz.travel.controller.TravelBackstageController.add()', 'POST', '1', 'admin', null, '/travel/backstage/add', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/f037325e092b493eb31135542494a7ca.png\",\"audioUrl\":\"\",\"id\":819727518461595648,\"travelModelVideos\":[],\"englishIntroduction\":\"\",\"longitude\":\"37.425,112.586\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/54c13dce495b4c7e9b1ad52452401db9.png\",\"isVr\":0,\"name\":\"山西农业大学19号学士公寓\",\"englishName\":\"The No. 19 Bachelor\'s Apartment at Shanxi Agricultural University\",\"content\":\"<p>我校的学生公寓设施一流,室内配有书桌、书架、电话，公寓楼周围绿地如茵、树木掩映、鸟语花香、环境优美。学生饮食服务中心既有大众化的饮食，还有各种各样的风味小吃，能满足各类学生不同的口味和消费水，在省内外高校享有盛誉。</p><p><br/></p><p><img src=\\\"https://ar-travel-file.1jiaohu.com/resource/20260610/43e0d2814177437b82462d6c4c757b25.png\\\" style=\\\"max-width:100%;\\\" contenteditable=\\\"false\\\" data-extentions-extra-ocr-id=\\\"d186470664e98aaa390ca97d41e4ee82\\\"/></p>\",\"videoUrl\":\"\",\"moduleId\":847162,\"createBy\":\"1\",\"inx\":2,\"relateDetailIds\":[],\"createTime\":1781082539090,\"videoCover\":\"\"}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 17:08:59\"}', '0', null, '2026-06-10 17:08:58');
INSERT INTO `sys_oper_log` VALUES ('1417', '新增景点', '1', 'com.pz.travel.controller.TravelBackstageController.add()', 'POST', '1', 'admin', null, '/travel/backstage/add', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/eb27494224c041a394afb923b6e129e5.jpg\",\"audioUrl\":\"\",\"id\":819728097422348288,\"travelModelVideos\":[],\"englishIntroduction\":\"\",\"longitude\":\"37.423875,112.582225\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/84446dfe854d492d83a527e79200d99b.jpg\",\"isVr\":0,\"name\":\"山西农业大学铭贤学校旧址\",\"englishName\":\"Oberlin Shansi Memorial School\",\"content\":\"<p>山西铭贤学校旧址，原为太谷望族孟氏的别墅，又称孟家花园，位于山西省晋中市<a href=\\\"https://baike.baidu.com/item/%E5%A4%AA%E8%B0%B7%E5%8C%BA/24190200?fromModule=lemma_inlink\\\" target=\\\"_blank\\\">太谷区</a>候城乡杨家庄村西，始建于清中期。<sup>&nbsp;<em></em></sup></p><p>山西铭贤学校旧址包括孟家花园、教学建筑和宿舍别墅群三个部分。<sup>&nbsp;[2]<em></em></sup>孟家花园，也称“孟氏园”，现存建筑占地面积南北长约80米，东西宽约100米，总面积约8000平方米，分东、中、西三院。东院为两进院落；中院（祀神区）系四合院；西院（寝室及书斋区）是三进院落<sup>&nbsp;[3]<em></em></sup>；教学建筑包括杭氏楼、田氏楼、韩氏楼、亭兰图书馆和嘉桂科学楼；宿舍别墅群，为学生宿舍、外教宿舍，现存16栋，均为二层砖构。<sup>&nbsp;[2]<em></em></sup>山西铭贤学校旧址为完整的旧址遗存，呈现出从清代私家园林到中西文化结合的现代教学设施的巨大变化，展现了清末民国时期中国教育变革的重要发展历程。旧址承载的大量历史信息，为研究北方私家园林、中西文化交流、建筑艺术等提供了实证。</p><p>2013年3月5日，山西铭贤学校旧址被中华人民共和国国务院公布为<a href=\\\"https://baike.baidu.com/item/%E7%AC%AC%E4%B8%83%E6%89%B9%E5%85%A8%E5%9B%BD%E9%87%8D%E7%82%B9%E6%96%87%E7%89%A9%E4%BF%9D%E6%8A%A4%E5%8D%95%E4%BD%8D/3525703?fromModule=lemma_inlink\\\" target=\\\"_blank\\\">第七批全国重点文物保护单位</a>。<sup>&nbsp;</sup></p><p><sup><br/></sup></p><p><img src=\\\"https://ar-travel-file.1jiaohu.com/resource/20260610/508a342eb0fa41b8af8f354823b0e579.jpg\\\" style=\\\"max-width:100%;\\\" contenteditable=\\\"false\\\" data-extentions-extra-ocr-id=\\\"6d2e539c5bfd1fd6504c394a279873d2\\\"/></p>\",\"videoUrl\":\"\",\"moduleId\":847162,\"createBy\":\"1\",\"inx\":1,\"relateDetailIds\":[],\"createTime\":1781082677125,\"videoCover\":\"\"}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 17:11:17\"}', '0', null, '2026-06-10 17:11:16');
INSERT INTO `sys_oper_log` VALUES ('1418', '新增景点', '1', 'com.pz.travel.controller.TravelBackstageController.add()', 'POST', '1', 'admin', null, '/travel/backstage/add', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/6c850421fca64195b5c968bef6b648e4.jpg\",\"audioUrl\":\"\",\"id\":819728677184212992,\"travelModelVideos\":[],\"englishIntroduction\":\"\",\"longitude\":\"37.437060,112.581633\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/e8f8d5130b6c461881d07c0467739e70.jpg\",\"isVr\":0,\"name\":\"崇圣楼\",\"englishName\":\"Chongsheng Building\",\"content\":\"\",\"videoUrl\":\"\",\"moduleId\":847162,\"createBy\":\"1\",\"inx\":2,\"relateDetailIds\":[],\"createTime\":1781082815351,\"videoCover\":\"\"}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 17:13:35\"}', '0', null, '2026-06-10 17:13:35');
INSERT INTO `sys_oper_log` VALUES ('1419', '删除栏目', '5', 'com.pz.travel.controller.TravelBackstageController.remove1()', 'DELETE', '1', 'admin', null, '/travel/backstage/moudule/912419', '192.168.1.121', '内网IP', '{id=912419}', '{\"code\":200,\"data\":\"不可删除\",\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 17:29:06\"}', '0', null, '2026-06-10 17:29:06');
INSERT INTO `sys_oper_log` VALUES ('1420', '删除栏目', '5', 'com.pz.travel.controller.TravelBackstageController.remove1()', 'DELETE', '1', 'admin', null, '/travel/backstage/moudule/912419', '192.168.1.115', '内网IP', '{id=912419}', '{\"code\":200,\"data\":\"不可删除\",\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 17:29:09\"}', '0', null, '2026-06-10 17:29:09');
INSERT INTO `sys_oper_log` VALUES ('1421', '新增景点', '1', 'com.pz.travel.controller.TravelBackstageController.add()', 'POST', '1', 'admin', null, '/travel/backstage/add', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/d1150b7809c0481a861cdd73008d1758.jpg\",\"audioUrl\":\"\",\"id\":819732931194130432,\"travelModelVideos\":[],\"englishIntroduction\":\"\",\"longitude\":\"37.423038,112.583703\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/655c292a1f274e648d46c456f82e395c.jpg\",\"activityName\":\"\",\"activityUrl\":\"\",\"isVr\":0,\"name\":\"活动\",\"englishName\":\"活动\",\"activity\":0,\"travelJointList\":[],\"content\":\"\",\"videoUrl\":\"\",\"moduleId\":923342,\"createBy\":\"1\",\"inx\":1,\"relateDetailIds\":[],\"createTime\":1781083829586,\"videoCover\":\"\",\"remarks\":\"\"}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 17:30:29\"}', '0', null, '2026-06-10 17:30:29');
INSERT INTO `sys_oper_log` VALUES ('1422', '修改景点', '2', 'com.pz.travel.controller.TravelBackstageController.update()', 'PUT', '1', 'admin', null, '/travel/backstage/update', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/d1150b7809c0481a861cdd73008d1758.jpg\",\"audioUrl\":\"\",\"id\":819732931194130432,\"englishIntroduction\":\"\",\"likes\":0,\"longitude\":\"37.423038,112.583703\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/655c292a1f274e648d46c456f82e395c.jpg\",\"activityName\":\"\",\"activityUrl\":\"\",\"isVr\":0,\"name\":\"草坪音乐节\",\"isUser\":0,\"status\":1,\"englishName\":\"活动\",\"activity\":0,\"travelJointList\":[],\"content\":\"\",\"pageviews\":0,\"videoUrl\":\"\",\"moduleId\":923342,\"address\":\"\",\"createBy\":\"1\",\"inx\":1,\"deleted\":0,\"relateDetailIds\":[],\"createTime\":1781083830000,\"videoCover\":\"\",\"remarks\":\"\"}', '{\"code\":301,\"message\":\"请检查数据内容\",\"msg\":\"请检查数据内容\",\"success\":false,\"timestamp\":\"2026-06-10 17:38:53\"}', '0', null, '2026-06-10 17:38:53');
INSERT INTO `sys_oper_log` VALUES ('1423', '修改景点', '2', 'com.pz.travel.controller.TravelBackstageController.update()', 'PUT', '1', 'admin', null, '/travel/backstage/update', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/d1150b7809c0481a861cdd73008d1758.jpg\",\"audioUrl\":\"\",\"id\":819732931194130432,\"englishIntroduction\":\"\",\"likes\":0,\"longitude\":\"37.423038,112.583703\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/655c292a1f274e648d46c456f82e395c.jpg\",\"activityName\":\"\",\"activityUrl\":\"\",\"isVr\":0,\"name\":\"草坪音乐节\",\"isUser\":0,\"status\":1,\"englishName\":\"草坪音乐节\",\"activity\":0,\"travelJointList\":[],\"content\":\"\",\"pageviews\":0,\"videoUrl\":\"\",\"moduleId\":923342,\"address\":\"\",\"createBy\":\"1\",\"inx\":1,\"deleted\":0,\"relateDetailIds\":[],\"createTime\":1781083830000,\"videoCover\":\"\",\"remarks\":\"\"}', '{\"code\":301,\"message\":\"请检查数据内容\",\"msg\":\"请检查数据内容\",\"success\":false,\"timestamp\":\"2026-06-10 17:39:03\"}', '0', null, '2026-06-10 17:39:03');
INSERT INTO `sys_oper_log` VALUES ('1424', '修改景点', '2', 'com.pz.travel.controller.TravelBackstageController.update()', 'PUT', '1', 'admin', null, '/travel/backstage/update', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/d1150b7809c0481a861cdd73008d1758.jpg\",\"audioUrl\":\"\",\"id\":819732931194130432,\"englishIntroduction\":\"\",\"likes\":0,\"longitude\":\"37.423038,112.583703\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/655c292a1f274e648d46c456f82e395c.jpg\",\"activityName\":\"\",\"activityUrl\":\"\",\"isVr\":0,\"name\":\"草坪音乐节\",\"isUser\":0,\"status\":1,\"englishName\":\"草坪音乐节\",\"activity\":0,\"travelJointList\":[],\"content\":\"\",\"pageviews\":0,\"videoUrl\":\"\",\"moduleId\":923342,\"address\":\"\",\"createBy\":\"1\",\"inx\":1,\"deleted\":0,\"relateDetailIds\":[],\"createTime\":1781083830000,\"videoCover\":\"\",\"remarks\":\"\"}', '{\"code\":301,\"message\":\"请检查数据内容\",\"msg\":\"请检查数据内容\",\"success\":false,\"timestamp\":\"2026-06-10 17:39:14\"}', '0', null, '2026-06-10 17:39:14');
INSERT INTO `sys_oper_log` VALUES ('1425', '修改景点', '2', 'com.pz.travel.controller.TravelBackstageController.update()', 'PUT', '1', 'admin', null, '/travel/backstage/update', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/d1150b7809c0481a861cdd73008d1758.jpg\",\"audioUrl\":\"\",\"id\":819732931194130432,\"englishIntroduction\":\"\",\"likes\":0,\"longitude\":\"37.423038,112.583703\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/655c292a1f274e648d46c456f82e395c.jpg\",\"activityName\":\"\",\"activityUrl\":\"\",\"isVr\":0,\"name\":\"草坪音乐\",\"isUser\":0,\"status\":1,\"englishName\":\"草坪音乐\",\"activity\":0,\"travelJointList\":[],\"content\":\"\",\"pageviews\":0,\"videoUrl\":\"\",\"moduleId\":923342,\"address\":\"\",\"createBy\":\"1\",\"inx\":1,\"deleted\":0,\"relateDetailIds\":[],\"createTime\":1781083830000,\"videoCover\":\"\",\"remarks\":\"\"}', '{\"code\":301,\"message\":\"请检查数据内容\",\"msg\":\"请检查数据内容\",\"success\":false,\"timestamp\":\"2026-06-10 17:39:35\"}', '0', null, '2026-06-10 17:39:35');
INSERT INTO `sys_oper_log` VALUES ('1426', '修改景点', '2', 'com.pz.travel.controller.TravelBackstageController.update()', 'PUT', '1', 'admin', null, '/travel/backstage/update', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/d1150b7809c0481a861cdd73008d1758.jpg\",\"audioUrl\":\"\",\"id\":819732931194130432,\"englishIntroduction\":\"\",\"likes\":0,\"longitude\":\"37.423038,112.583703\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/655c292a1f274e648d46c456f82e395c.jpg\",\"activityName\":\"\",\"activityUrl\":\"\",\"isVr\":0,\"name\":\"草坪音乐\",\"isUser\":0,\"status\":1,\"englishName\":\"草坪音乐\",\"activity\":0,\"travelJointList\":[],\"content\":\"\",\"pageviews\":0,\"videoUrl\":\"\",\"moduleId\":923342,\"address\":\"\",\"createBy\":\"1\",\"inx\":1,\"deleted\":0,\"relateDetailIds\":[],\"createTime\":1781083830000,\"videoCover\":\"\",\"remarks\":\"\"}', '{\"code\":301,\"message\":\"请检查数据内容\",\"msg\":\"请检查数据内容\",\"success\":false,\"timestamp\":\"2026-06-10 17:41:03\"}', '0', null, '2026-06-10 17:41:02');
INSERT INTO `sys_oper_log` VALUES ('1427', '修改景点', '2', 'com.pz.travel.controller.TravelBackstageController.update()', 'PUT', '1', 'admin', null, '/travel/backstage/update', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/d1150b7809c0481a861cdd73008d1758.jpg\",\"audioUrl\":\"\",\"id\":819732931194130432,\"englishIntroduction\":\"\",\"likes\":0,\"longitude\":\"37.423038,112.583703\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/655c292a1f274e648d46c456f82e395c.jpg\",\"activityName\":\"\",\"activityUrl\":\"\",\"isVr\":0,\"name\":\"草坪音乐\",\"isUser\":0,\"status\":1,\"englishName\":\"草坪音乐\",\"activity\":0,\"travelJointList\":[],\"content\":\"\",\"pageviews\":0,\"videoUrl\":\"\",\"moduleId\":923342,\"address\":\"\",\"createBy\":\"1\",\"inx\":1,\"deleted\":0,\"relateDetailIds\":[],\"createTime\":1781083830000,\"videoCover\":\"\",\"remarks\":\"\"}', '{\"code\":301,\"message\":\"请检查数据内容\",\"msg\":\"请检查数据内容\",\"success\":false,\"timestamp\":\"2026-06-10 17:41:12\"}', '0', null, '2026-06-10 17:41:12');
INSERT INTO `sys_oper_log` VALUES ('1428', '修改景点', '2', 'com.pz.travel.controller.TravelBackstageController.update()', 'PUT', '1', 'admin', null, '/travel/backstage/update', '192.168.1.121', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/d1150b7809c0481a861cdd73008d1758.jpg\",\"audioUrl\":\"\",\"id\":819732931194130432,\"englishIntroduction\":\"\",\"likes\":0,\"longitude\":\"37.423038,112.583703\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/655c292a1f274e648d46c456f82e395c.jpg\",\"activityName\":\"\",\"activityUrl\":\"\",\"isVr\":0,\"name\":\"活动\",\"isUser\":0,\"status\":1,\"englishName\":\"活动\",\"activity\":0,\"travelJointList\":[],\"content\":\"\",\"pageviews\":0,\"videoUrl\":\"\",\"moduleId\":923342,\"address\":\"\",\"createBy\":\"1\",\"inx\":1,\"deleted\":0,\"relateDetailIds\":[],\"createTime\":1781083830000,\"videoCover\":\"\",\"remarks\":\"\"}', '{\"code\":301,\"message\":\"请检查数据内容\",\"msg\":\"请检查数据内容\",\"success\":false,\"timestamp\":\"2026-06-10 17:41:13\"}', '0', null, '2026-06-10 17:41:13');
INSERT INTO `sys_oper_log` VALUES ('1429', '修改景点', '2', 'com.pz.travel.controller.TravelBackstageController.update()', 'PUT', '1', 'admin', null, '/travel/backstage/update', '192.168.1.121', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/d1150b7809c0481a861cdd73008d1758.jpg\",\"audioUrl\":\"\",\"id\":819732931194130432,\"englishIntroduction\":\"\",\"likes\":0,\"longitude\":\"37.423038,112.583703\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/655c292a1f274e648d46c456f82e395c.jpg\",\"activityName\":\"\",\"activityUrl\":\"\",\"isVr\":0,\"name\":\"活动\",\"isUser\":0,\"status\":1,\"englishName\":\"活动\",\"activity\":0,\"travelJointList\":[],\"content\":\"\",\"pageviews\":0,\"videoUrl\":\"\",\"moduleId\":923342,\"address\":\"\",\"createBy\":\"1\",\"inx\":1,\"deleted\":0,\"relateDetailIds\":[],\"createTime\":1781083830000,\"videoCover\":\"\",\"remarks\":\"\"}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 17:41:32\"}', '0', null, '2026-06-10 17:41:32');
INSERT INTO `sys_oper_log` VALUES ('1430', '修改景点', '2', 'com.pz.travel.controller.TravelBackstageController.update()', 'PUT', '1', 'admin', null, '/travel/backstage/update', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/d1150b7809c0481a861cdd73008d1758.jpg\",\"audioUrl\":\"\",\"id\":819732931194130432,\"englishIntroduction\":\"\",\"likes\":0,\"longitude\":\"37.423038,112.583703\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/655c292a1f274e648d46c456f82e395c.jpg\",\"activityName\":\"\",\"activityUrl\":\"\",\"isVr\":0,\"name\":\"草坪音乐节\",\"isUser\":0,\"status\":1,\"englishName\":\"草坪音乐节\",\"activity\":0,\"travelJointList\":[],\"content\":\"\",\"pageviews\":0,\"videoUrl\":\"\",\"moduleId\":923342,\"address\":\"\",\"createBy\":\"1\",\"inx\":1,\"deleted\":0,\"relateDetailIds\":[],\"createTime\":1781083830000,\"videoCover\":\"\",\"remarks\":\"\"}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 17:41:54\"}', '0', null, '2026-06-10 17:41:54');
INSERT INTO `sys_oper_log` VALUES ('1431', '修改景点', '2', 'com.pz.travel.controller.TravelBackstageController.update()', 'PUT', '1', 'admin', null, '/travel/backstage/update', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/d1150b7809c0481a861cdd73008d1758.jpg\",\"audioUrl\":\"\",\"id\":819732931194130432,\"englishIntroduction\":\"\",\"likes\":0,\"longitude\":\"37.423038,112.583703\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/655c292a1f274e648d46c456f82e395c.jpg\",\"activityName\":\"\",\"activityUrl\":\"\",\"isVr\":0,\"name\":\"草坪音乐节\",\"isUser\":0,\"status\":1,\"englishName\":\"草坪音乐节\",\"activity\":0,\"travelJointList\":[],\"content\":\"<p><img src=\\\"https://ar-travel-file.1jiaohu.com/resource/20260610/1b05f103a5a64c14a2810aacc1e2ab89.jpg\\\" style=\\\"max-width:100%;\\\" contenteditable=\\\"false\\\" data-extentions-extra-ocr-id=\\\"f775f24bf031bca5957d197b56bdec46\\\"/></p>\",\"pageviews\":0,\"videoUrl\":\"\",\"moduleId\":923342,\"address\":\"\",\"createBy\":\"1\",\"inx\":1,\"deleted\":0,\"relateDetailIds\":[],\"createTime\":1781083830000,\"videoCover\":\"\",\"remarks\":\"\"}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 17:42:48\"}', '0', null, '2026-06-10 17:42:48');
INSERT INTO `sys_oper_log` VALUES ('1432', '修改景点', '2', 'com.pz.travel.controller.TravelBackstageController.update()', 'PUT', '1', 'admin', null, '/travel/backstage/update', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/afad066c80e64c3f9c2d46829a2371b2.jpg\",\"audioUrl\":\"\",\"id\":819732931194130432,\"englishIntroduction\":\"\",\"likes\":0,\"longitude\":\"37.423038,112.583703\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/26f5dfb05136413abfed90bb496d65cc.jpg\",\"activityName\":\"\",\"activityUrl\":\"\",\"isVr\":0,\"name\":\"草坪音乐节\",\"isUser\":0,\"status\":1,\"englishName\":\"草坪音乐节\",\"activity\":0,\"travelJointList\":[],\"content\":\"<p>校各单位：</p><p>根据《中共山西省委宣传部山西省科学技术协会山西省科学技术厅关于开展2026年“山西最美科技工作者”学习宣传活动的通知》（附件）要求，我校开展2026年山西省“最美科技工作者”推荐工作，有关事项安排如下：</p><p>1、各单位根据文件要求自愿组织推荐，择优推荐不超过1名科技工作者参加遴选。</p><p>2、本次推荐面向基层。突出基层一线，注重选树青年科技工作者（45岁以下）典型，兼顾不同类别、年龄、性别的科技工作者（党外科技人员优先）。</p><p>3、工作单位：山西农业大学；推荐单位：山西省农学会；纪检意见由科研部统一办理。</p><p>4、各单位于7月10日前将候选人推荐表和汇总表Word版、盖章版汇总表发送至邮箱<a href=\\\"mailto:sxndxsjl@126.com\\\">sxndxsjl@126.com</a>。</p><p>联系人：王慧贤 李琦</p><p><br/></p><p><img src=\\\"https://ar-travel-file.1jiaohu.com/resource/20260610/ae98ee4950b140ae9c6e65f40fed30c5.jpg\\\" style=\\\"max-width:100%;\\\" contenteditable=\\\"false\\\" data-extentions-extra-ocr-id=\\\"b993da0ce4651f062bf40a4fcd1a9f68\\\"/></p>\",\"pageviews\":0,\"videoUrl\":\"\",\"moduleId\":923342,\"address\":\"\",\"createBy\":\"1\",\"inx\":1,\"deleted\":0,\"relateDetailIds\":[],\"createTime\":1781083830000,\"videoCover\":\"\",\"remarks\":\"\"}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 18:00:47\"}', '0', null, '2026-06-10 18:00:46');
INSERT INTO `sys_oper_log` VALUES ('1433', '新增景点', '1', 'com.pz.travel.controller.TravelBackstageController.add()', 'POST', '1', 'admin', null, '/travel/backstage/add', '192.168.1.115', '内网IP', '{\"backgroundCover\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/05d042b6fe1a4180ab8121e6d5cc7ed9.jpg\",\"audioUrl\":\"\",\"id\":819740936698597376,\"travelModelVideos\":[],\"englishIntroduction\":\"\",\"longitude\":\"37.423038,112.583703\",\"pictureUrl\":\"https://ar-travel-file.1jiaohu.com/resource/20260610/ea5461f9f66f4d43a1e6230e63fb26ab.jpg\",\"isVr\":0,\"name\":\"酷跑活动\",\"englishName\":\"酷跑活动\",\"content\":\"<p><img src=\\\"https://ar-travel-file.1jiaohu.com/resource/20260610/774870430c2e45aba1e5e0ea6b431f93.jpg\\\" style=\\\"max-width:100%;\\\" contenteditable=\\\"false\\\" data-extentions-extra-ocr-id=\\\"dc49e7c3724b42221477712d554f6e6e\\\"/></p><p><br/></p><p>6月1日至3日，校党委常委、副校（院）长张富强率城乡建设学院党政领导，赴湖北省丹江口市中国南水北调集团江汉水网建设开发有限公司（以下简称集团公司）及相关工程现场，围绕“深化校企合作、拓展就业岗位、搭建产教平台”开展专题调研交流，实地感受南水北调“世纪工程”的建设脉搏，并与企业方在人才培养、技术攻关、学生实习就业等方面达成了多项合作共识。</p>\",\"videoUrl\":\"\",\"moduleId\":923342,\"createBy\":\"1\",\"inx\":2,\"relateDetailIds\":[],\"createTime\":1781085738247,\"videoCover\":\"\"}', '{\"code\":200,\"data\":1,\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-10 18:02:18\"}', '0', null, '2026-06-10 18:02:18');
INSERT INTO `sys_oper_log` VALUES ('1434', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"1\",\"icon\":\"checkbox\",\"orderNum\":\"0\",\"menuName\":\"首页\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"/\",\"component\":\"index\",\"children\":[],\"createTime\":1646300954000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2017,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-18 10:13:28');
INSERT INTO `sys_oper_log` VALUES ('1435', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2038', '127.0.0.1', '内网IP', '{menuId=2038}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2026-06-18 10:32:08');
INSERT INTO `sys_oper_log` VALUES ('1436', '删除栏目', '5', 'com.pz.travel.controller.TravelBackstageController.remove1()', 'DELETE', '1', 'admin', null, '/travel/backstage/moudule/912419', '127.0.0.1', '内网IP', '{id=912419}', '{\"code\":200,\"data\":\"不可删除\",\"msg\":\"succeed\",\"success\":true,\"timestamp\":\"2026-06-18 10:37:16\"}', '0', null, '2026-06-18 10:37:16');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(11) NOT NULL COMMENT '显示顺序',
  `status` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES ('1', 'ceo', '董事长', '1', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_post` VALUES ('2', 'se', '项目经理', '2', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_post` VALUES ('3', 'hr', '人力资源', '3', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_post` VALUES ('4', 'user', '普通员工', '4', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(11) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 'admin', '1', '1', '1', '1', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '超级管理员');
INSERT INTO `sys_role` VALUES ('2', '普通角色', 'common', '2', '4', '1', '1', '0', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2021-01-22 14:49:38', '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户账号',
  `nick_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户昵称',
  `user_type` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号码',
  `sex` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `open_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `union_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '微信unionId',
  `source` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '用户来源，1：小程序 2：预约系统',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uni_open_id` (`open_id`) USING BTREE,
  UNIQUE KEY `uni_user_name` (`user_name`) USING BTREE,
  UNIQUE KEY `uni_union_id` (`union_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '100', 'admin', '碰撞', '00', 'pz@touchspace.cn', '15888888888', '0', '/profile/avatar/2025/12/25/e5e7d01f-3602-490b-b2aa-24855d70234f.jpeg', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2018-03-16 11:33:00', 'admin', '2018-03-16 11:33:00', 'ry', '2021-01-22 14:36:02', '管理员', null, null, '1');
INSERT INTO `sys_user` VALUES ('7116', null, null, null, '00', '', '', '0', '', '', '0', '0', '192.168.1.115', '2026-06-10 17:25:09', '1', '2026-06-10 11:13:50', '', '2026-06-10 17:25:08', null, 'oe6uP5WuQeUu9Umcqe2LXfi0g_JE', 'opSqp5-eyc0qhO_spjE9lVUAM2BU', '1');
INSERT INTO `sys_user` VALUES ('7117', null, null, null, '00', '', '', '0', '', '', '0', '0', '', null, '1', '2026-06-10 17:59:22', '', null, null, 'oe6uP5dMBoARFqmou33ogKkI5tfo', 'opSqp5zdk2OuDMUR_IZRDIecfSGE', '1');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES ('1', '1');
INSERT INTO `sys_user_post` VALUES ('2', '2');
INSERT INTO `sys_user_post` VALUES ('119', '2');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('2', '2');
INSERT INTO `sys_user_role` VALUES ('119', '2');
INSERT INTO `sys_user_role` VALUES ('119', '100');
INSERT INTO `sys_user_role` VALUES ('127', '100');
INSERT INTO `sys_user_role` VALUES ('176', '101');
INSERT INTO `sys_user_role` VALUES ('7048', '102');
INSERT INTO `sys_user_role` VALUES ('7052', '102');
INSERT INTO `sys_user_role` VALUES ('7053', '102');
INSERT INTO `sys_user_role` VALUES ('7068', '103');
INSERT INTO `sys_user_role` VALUES ('7096', '2');
INSERT INTO `sys_user_role` VALUES ('7097', '108');
INSERT INTO `sys_user_role` VALUES ('7099', '107');
INSERT INTO `sys_user_role` VALUES ('7100', '107');
INSERT INTO `sys_user_role` VALUES ('7101', '107');
INSERT INTO `sys_user_role` VALUES ('7102', '107');
INSERT INTO `sys_user_role` VALUES ('7103', '107');
INSERT INTO `sys_user_role` VALUES ('7104', '107');
INSERT INTO `sys_user_role` VALUES ('7105', '107');
INSERT INTO `sys_user_role` VALUES ('7106', '107');
INSERT INTO `sys_user_role` VALUES ('7107', '107');
INSERT INTO `sys_user_role` VALUES ('7108', '108');
INSERT INTO `sys_user_role` VALUES ('7109', '108');
INSERT INTO `sys_user_role` VALUES ('7110', '109');
INSERT INTO `sys_user_role` VALUES ('7111', '109');
INSERT INTO `sys_user_role` VALUES ('7112', '108');

-- ----------------------------
-- Table structure for travel_cover
-- ----------------------------
DROP TABLE IF EXISTS `travel_cover`;
CREATE TABLE `travel_cover` (
  `id` int(11) NOT NULL COMMENT '主键',
  `picture_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图片地址',
  `identity` tinyint(4) DEFAULT NULL COMMENT '0：拍照识别图片，1：建筑可阅读照片'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of travel_cover
-- ----------------------------
INSERT INTO `travel_cover` VALUES ('1001', 'https://ar-travel-file.1jiaohu.com/resource/20260326/bae2b181f1ee40549b708e6f3c88a80a.jpg', '0');
INSERT INTO `travel_cover` VALUES ('1002', 'https://ar-travel-file.1jiaohu.com/resource/20260326/686975f4dd434768839d4294197dfc6b.jpg', '1');

-- ----------------------------
-- Table structure for travel_joint
-- ----------------------------
DROP TABLE IF EXISTS `travel_joint`;
CREATE TABLE `travel_joint` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `scenic_id` bigint(20) DEFAULT NULL COMMENT '景点id',
  `classification_id` bigint(20) DEFAULT NULL COMMENT '分类id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of travel_joint
-- ----------------------------
INSERT INTO `travel_joint` VALUES ('84716207814610920', '84716207814610920', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('91691815547441153', '91691815547441153', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('101133541546659840', '101133541546659840', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('101374090283323392', '101374090283323392', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('101382072681369600', '101382072681369600', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('101386110781100032', '101386110781100032', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('101387904647172096', '101387904647172096', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('101425829812375552', '101425829812375552', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('101473961237549056', '101473961237549056', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('101475027312185344', '101475027312185344', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('103965455714357248', '103965455714357248', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('106469745251061760', '106469745251061760', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('106473125759422464', '106473125759422464', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('107291726443712512', '107291726443712512', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('107530024244219904', '107530024244219904', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('107556576512184320', '107556576512184320', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('107572589253365760', '107572589253365760', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('107597295851409408', '107597295851409408', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('132914943724097536', '132914943724097536', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('300911832200384514', '300911519808622592', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('302601647132250115', '148545588454232064', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('305136304113586178', '305136304113586176', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('497105049194074114', '140235456616075264', '301883092531154944');
INSERT INTO `travel_joint` VALUES ('497105148963983362', '101128647855050752', '301883092531154944');
INSERT INTO `travel_joint` VALUES ('497105328975122432', '151761939557781504', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('497105389234688000', '298955163371311104', '301883092531154944');
INSERT INTO `travel_joint` VALUES ('497105498529861632', '107563944008486912', '169863344680079360');
INSERT INTO `travel_joint` VALUES ('819723818527625217', '819723818527625216', '301883092531154944');

-- ----------------------------
-- Table structure for travel_module
-- ----------------------------
DROP TABLE IF EXISTS `travel_module`;
CREATE TABLE `travel_module` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态 1：正常 0：失效',
  `flag` tinyint(4) DEFAULT '0' COMMENT '标记，1：系统预定义 0：动态添加',
  `create_by` bigint(20) unsigned NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='大类';

-- ----------------------------
-- Records of travel_module
-- ----------------------------
INSERT INTO `travel_module` VALUES ('847162', '景点', '1', '1', '1', '2020-11-25 10:06:41');
INSERT INTO `travel_module` VALUES ('923342', '活动', '1', '0', '1', '2020-12-31 16:12:05');

-- ----------------------------
-- Table structure for travel_module_detail
-- ----------------------------
DROP TABLE IF EXISTS `travel_module_detail`;
CREATE TABLE `travel_module_detail` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键',
  `module_id` bigint(20) unsigned NOT NULL COMMENT '模块id',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '景点名称',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '景点标题',
  `sub_title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '景点副标题',
  `picture_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '景点图片',
  `video_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '视频',
  `audio_url` text COLLATE utf8mb4_unicode_ci COMMENT '景点音频',
  `address` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '景点地址',
  `content_link` tinytext COLLATE utf8mb4_unicode_ci COMMENT '景点内容链接',
  `content` mediumtext COLLATE utf8mb4_unicode_ci COMMENT '景点内容',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态，0：失效 1：正常',
  `create_by` bigint(20) unsigned NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `longitude` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '经度',
  `latitude` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '纬度',
  `introduction` text COLLATE utf8mb4_unicode_ci COMMENT '景点简介',
  `is_vr` tinyint(4) DEFAULT '0' COMMENT '是否存在VR，0：不存在，1：存在',
  `vr_id` bigint(20) unsigned DEFAULT NULL COMMENT 'vr_id',
  `pageviews` bigint(20) DEFAULT '0' COMMENT 'VR图浏览量',
  `likes` bigint(20) DEFAULT '0' COMMENT '点赞量',
  `phone_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `inx` int(11) DEFAULT NULL COMMENT '排序',
  `background_cover` text COLLATE utf8mb4_unicode_ci COMMENT '景点背景图',
  `video_cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '视频封面图',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '中文地址',
  `chinese_open_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `english_open_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `english_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `english_level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户识别是否打开',
  `level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ticket` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `english_ticket` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `english_introduction` mediumtext COLLATE utf8mb4_unicode_ci,
  `human` text COLLATE utf8mb4_unicode_ci,
  `is_user` int(10) unsigned DEFAULT '0',
  `deleted` int(11) DEFAULT '0',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `activity` int(11) DEFAULT '0',
  `activity_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activity_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `relate_detail_id` bigint(25) DEFAULT NULL,
  `block_id` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分类明细表';

-- ----------------------------
-- Records of travel_module_detail
-- ----------------------------
INSERT INTO `travel_module_detail` VALUES ('819723818527625216', '847162', '山西铭贤学校旧址', null, null, 'https://ar-travel-file.1jiaohu.com/resource/20260610/d18d6024be6749f18fa5208b5cff939c.jpg', '', '', '', null, '<p style=\"text-align:center;\"><img src=\"https://ar-travel.1jiaohu.com/files/20250929/a998eb72-782c-4a5b-a575-fa61ceb1fbe5ccc33bdf0cd84f5080726134406e0f3c.gif\" width=\"30%\"/><br/><br/></p><p style=\"text-align:center;\">山西铭贤学校旧址</p><p><img src=\"https://ar-travel.1jiaohu.com/files/20250929/d4156e0b-fbf8-4baa-8947-58c0270a4f94%E5%B1%B1%E8%A5%BF%E9%93%AD%E8%B4%A4%E5%AD%A6%E6%A0%A1.jpg\" data-extentions-extra-ocr-id=\"43d531f5c14e129461062a844ac2d031\" width=\"100%\"/></p><p>清<a href=\"https://baike.baidu.com/item/%E5%AE%A3%E7%BB%9F/1523933?fromModule=lemma_inlink\" target=\"_blank\">宣统</a>元年（1909年），孔祥熙将创办的铭贤学校搬迁至山西铭贤学校旧址，随学校的发展扩大，校舍陆续增建形成现有规模。民国二十一年（1932年）学校南迁，更名为铭贤学院。</p><p>1950年，铭贤学院迁回山西铭贤学校旧址。</p><p>1951年，山西铭贤学校被政府接收，更名为山西农学院。</p><p>1979年，山西农学院更名为山西农业大学。</p><p><br/></p><p><img src=\"https://ar-travel.1jiaohu.com/files/20250929/a55f6333-5c3e-4d6b-be3f-37f4b74a3e5ewps.png\" data-extentions-extra-ocr-id=\"bc57d408d846962bb47a5a2f1eea350d\"/>《亮剑》中南京军事学院一太谷<a target=\"_blank\" href=\"https://ent.163.com/keywords/5/7/5c71897f/1.html\">山西</a>农业大学</p><p><br/></p><p><img src=\"https://ar-travel.1jiaohu.com/files/20250929/5578d578-b145-4512-8ac2-399e53a5eb43wps%20(1).png\" data-extentions-extra-ocr-id=\"4e31cc9a68c6daeaf6aca8b50b87e48a\"/>《亮剑》中南京军事学院一太谷山西农业大学</p><p><br/></p><p><img src=\"https://ar-travel.1jiaohu.com/files/20250929/6893a329-07ec-4276-baef-9649bc965c2bwps%20(2).png\" data-extentions-extra-ocr-id=\"37e144b6fb23b672326bee0a476262e5\"/>《亮剑》中南京军事学院一太谷山西农业大学</p>', '1', '1', '2026-06-10 16:54:17', '37.425856,112.582578', null, null, '0', null, '0', '0', null, '1', 'https://ar-travel-file.1jiaohu.com/resource/20260610/b36bd62ed70340ae9a9acdb9df1294ec.jpg', '', '', null, null, 'Oberlin Shansi Memorial School Old Sit', null, null, null, null, '', null, '0', '0', '2026-06-10 16:54:16', '0', '', '', null, null);
INSERT INTO `travel_module_detail` VALUES ('819725592235872256', '847162', '韩氏楼', null, null, 'https://ar-travel-file.1jiaohu.com/resource/20260610/571efc98d49549dea908da666de2fe0a.png', '', '', '', null, '<p>1924年落成的韩氏楼，是铭贤学校时期建成的主要建筑物之一，由美藉人氏韩明卫（Hemingway）家族捐款兴建。</p><p>孔祥熙在美国欧柏林大学求学时与美籍学生D.W.H.Hemingway相识交好，并为之起了个中国名字韩明卫。1903年韩明卫携新婚妻子韩美瑞到中国传教。1904年来到太谷，在孟家花园办起仁术医院（1901年办理教案时，孟家花园被据为教会财产），自任院长。1909年为支持铭贤学堂扩大办学规模，韩明卫将孟家花园换让给铭贤学堂。1924年建成韩氏楼，据《铭贤廿週纪念》标注：韩明卫之弟为纪念其母捐建韩氏楼，实则是韩氏家族共建。</p><p>韩氏楼位于嘉桂科学楼西南方，建筑面积1026平方米。古式建筑，砖木结构，青瓦大屋顶，十二角飞檐。东、中、西三处楼门均向北开启。中门与东西门之间的墙上各镶嵌一黑色石块，上刻有“韩氏纪念”和 “HEMINGWAYMEMORIAL1924”字样。屋内为地下一层，地上两层，楼梯、地面全为实木结构，居室全部向阳，北侧为入室通道。铭贤时期，地下一层为供暖、供热水和洗浴处，地上二层居室用作男生宿舍。1951年9月改称第一学生宿舍，后改为单身教职工宿舍和研究生宿舍。</p><p><br/></p><p style=\"text-align:center;\"><img src=\"https://ar-travel.1jiaohu.com/files/20250929/f7edf0db-7b0b-4d72-8cb6-52ce6c520bc9%E9%9F%A9%E6%B0%8F%E6%A5%BC%20(2).png\" data-extentions-extra-ocr-id=\"1de9b28daba3609395a3a9b7912f3616\"/><img src=\"https://ar-travel.1jiaohu.com/files/20250929/92367410-5358-4a89-96e4-b9c513bcfdd9%E9%9F%A9%E6%B0%8F%E6%A5%BC%20(3).png\" data-extentions-extra-ocr-id=\"f12929b7b49e9a85970a153a2da785db\"/></p>', '1', '1', '2026-06-10 17:01:20', '37.424698,112.5820', null, null, '0', null, '0', '0', null, '1', 'https://ar-travel-file.1jiaohu.com/resource/20260610/fc3aadc692584aa68829aa598ba6c4f8.png', '', '山西农业大学', '全天', null, 'The Han Building', null, null, '免费', null, '', null, '0', '0', '2026-06-10 17:01:19', '0', '', '', null, null);
INSERT INTO `travel_module_detail` VALUES ('819726131627560960', '847162', '亭兰图书馆', null, null, 'https://ar-travel-file.1jiaohu.com/resource/20260610/4b7cd7f564be47378faf1842e41cde63.png', '', '', '', null, '<p>1936年间先后竣工落成的亭兰图书馆、嘉桂科学楼，是铭贤学校时期建成的主要建筑物，由孔祥熙及其夫人宋霭龄于1935年7月为纪念双方父母而筹建。</p><p>亭兰图书馆和嘉桂科学楼各取孔祥熙和宋霭龄父母名字中的二字命名。著名书法家赵铁山亲书其名。当年由我校果树专家贾麟厚教授在两楼背面栽植的十几株加拿大毛白杨，至今己成参天大树。楼与大树相辉映，更显历史的厚重感。</p><p>此二楼主体结构由美国建筑设计师墨菲（HenryKilamMurphy）设计，天津基泰工程公司、天津营造公司补充画图并承建，为中西合璧风格（外观是中式，但内部构造却是西式）。两楼建筑面积都为1382平方米 （其中地下室各为309平米），总投资19.4万元。</p><p>两楼均为三层建筑，地上两层，地下一层，顶上有四面开启洞窗的隔热跃层。建筑用料为青砖、石料、水泥、木材。外墙以五层（其中亭兰外露四层）条型剁石、四层水泥预制块与多层青砖垒起。四壁开设工字型连接的方格窗户，上下窗口间有仿大理石彩墙相隔。室内地板、楼梯、扶手全用精心磨制的钢骨水泥注成。两楼地下室有供暖间、储存室、卫生间（配有座式马桶）等。</p><p>两楼楼门抱厦均建在五级石基（其中亭兰外露四层）上，双柱上端与飞檐下部雕刻着“瓶”、“鼎”及 “香炉”等，寓意平等与香火旺盛；又有海马、水壶，红色门柱以示水火相济。两楼门分别向西、向东开启，遥相对峙，意为“门当户对”。屋顶由木构架支承，形成中国建筑特有的曲面大屋顶。顶面用彩色琉璃瓦料铺成。众多彩色吻兽立于屋脊，有“大吻”“重兽”“戗兽”“合角吻兽”；在 “重兽”与“戗兽”前还有多处五个一队的“仙人走兽”，在这些走兽前有一个骑着似凤似鸡的领队，俗称“仙人”。梁枋斗栱彩绘醒目，八角飞檐湾曲高翘，有如翚鸟展翅高飞。其等级有似古代皇家大院中六宫的建筑风格。真乃极尽辉煌壮丽、美轮美奂之能事，这在晋中乡村甚至县城众多官商大院中也属少见。有道是：“剁石青砖大屋顶，中西合璧出茂工。内室精装取西法，屋顶仙兽袭六宫。孔宋儿女争高下，嘉桂亭兰各西东。家事逸闻成往趣，图书科学久对门。经风沐雨八十代，华屋檐下满燕影”。</p><p>亭兰图书馆，取孔祥熙父亲孔和亭的“亭”字和母亲庞玉兰的“兰”字命名。铭贤时期第一层为纪念室、办公室、编目室、阅报室及书库；第二层为阅览室及书库。书库上下可容书10万余册，阅览室可容二百余人同时阅览。为防火，楼内地板、楼梯踏步及栏杆均为水磨石材质，库内书架全部为铁架。阅览室屋内装设无影灯，光线明亮而柔和，不刺眼。桌椅为核桃木制，光滑细致。椅子腿下有橡皮垫，即使有人拖动也不会发出噪音干扰他人。两座图书台，为红木所制，整体为圆形，曲线如人背，设计非常人性化，坐着很舒适。室内备有各种书报杂志，可供读者自由阅览。目录分多种类型编排，方便学生按照书名、作者姓名、出版书店等方式查询，查询方法由北京请来的图书专家编制。图书功能一直延续至今。</p><p><br/></p><p data-we-empty-p=\"\" style=\"text-align:center;\"><img src=\"https://ar-travel-file.1jiaohu.com/resource/20260610/4444724780ce47c59e920c3464031d66.png\" style=\"max-width:100%;\" contenteditable=\"false\" data-extentions-extra-ocr-id=\"a4ae48d4d0f7a5685fae06fa77337953\"/></p>', '1', '1', '2026-06-10 17:03:28', '37.42205,112.58571', null, null, '0', null, '0', '0', null, '1', 'https://ar-travel-file.1jiaohu.com/resource/20260610/9cb1b909ddfd4c1fa46d6289f01a53e0.png', '', null, null, null, 'The Tinglan Library of Shanxi Agricultural University', null, null, null, null, '', null, '0', '0', '2026-06-10 17:03:28', '0', null, null, null, null);
INSERT INTO `travel_module_detail` VALUES ('819726611355275264', '847162', '嘉桂科学楼', null, null, 'https://ar-travel-file.1jiaohu.com/resource/20260610/51ffe00764924e60b0274bed24f978d3.png', '', '', '', null, '<p>嘉桂科学楼，取宋霭龄父亲宋嘉树的“嘉”字和母亲倪桂珍的“桂”字命名。铭贤时期第一层为物理实验室、生物实验室、仪器室、材料室、教室及教员室等；第二层为化学实验室、标本室、天平室、储存室、教室及教员室等。实验室仪器设备精良齐全，可供十几人同时实验。生物标本种类较多。各科的教室与实验室相通，取用方便。1951年以来曾为实验室、教室、图书室，及人事处、档案馆、学报、新农村发展研究院等办公处。</p><p><br/></p><p><img src=\"https://ar-travel.1jiaohu.com/files/20250929/57e0159e-cf28-4c48-9dbf-2368c2354fb4%E5%98%89%E6%A1%82%E7%A7%91%E5%AD%A6%E6%A5%BC1.png\" data-extentions-extra-ocr-id=\"b5a101869139c7e014866e3325d2dfe9\"/></p>', '1', '1', '2026-06-10 17:05:23', '37.42493,112.5827', null, null, '0', null, '0', '0', null, '1', 'https://ar-travel-file.1jiaohu.com/resource/20260610/79498353e91d4b25944e41220f964b33.png', '', '铭贤南路1号', null, null, 'The Jia Gui Science Building of Shanxi Agricultural University', null, null, null, null, '', null, '0', '0', '2026-06-10 17:05:22', '0', null, null, null, null);
INSERT INTO `travel_module_detail` VALUES ('819727024129314816', '847162', '山西农业大学图书馆大楼', null, null, 'https://ar-travel-file.1jiaohu.com/resource/20260610/c6ef9a1f25034d59b28e601ac8a6b030.png', '', '', '', null, '<p>山西农业大学的图书馆大楼是学校的重要设施之一，具有丰富的藏书和现代化的设施。山西农业大学的图书馆大楼不仅是学校的重要学术资源中心，也是校园文化建设的重要组成部分。</p><p><br/></p><p><img src=\"https://ar-travel-file.1jiaohu.com/resource/20260610/23f0df7e344c4ea892d228f20a52add1.png\" style=\"max-width:100%;\" contenteditable=\"false\" data-extentions-extra-ocr-id=\"642aa12f2dd4424679c4ec97b71d5b4b\"/></p>', '1', '1', '2026-06-10 17:07:01', '37.42403,112.5805', null, null, '0', null, '0', '0', null, '1', 'https://ar-travel-file.1jiaohu.com/resource/20260610/0cae1aaadca348de8427946e0293a0f5.png', '', '山西农业大学图书馆大楼', null, null, 'The Library Building of Shanxi Agricultural University', null, null, null, null, '', null, '0', '0', '2026-06-10 17:07:00', '0', null, null, null, null);
INSERT INTO `travel_module_detail` VALUES ('819727518461595648', '847162', '山西农业大学19号学士公寓', null, null, 'https://ar-travel-file.1jiaohu.com/resource/20260610/54c13dce495b4c7e9b1ad52452401db9.png', '', '', '', null, '<p>我校的学生公寓设施一流,室内配有书桌、书架、电话，公寓楼周围绿地如茵、树木掩映、鸟语花香、环境优美。学生饮食服务中心既有大众化的饮食，还有各种各样的风味小吃，能满足各类学生不同的口味和消费水，在省内外高校享有盛誉。</p><p><br/></p><p><img src=\"https://ar-travel-file.1jiaohu.com/resource/20260610/43e0d2814177437b82462d6c4c757b25.png\" style=\"max-width:100%;\" contenteditable=\"false\" data-extentions-extra-ocr-id=\"d186470664e98aaa390ca97d41e4ee82\"/></p>', '1', '1', '2026-06-10 17:08:59', '37.425,112.586', null, null, '0', null, '0', '0', null, '2', 'https://ar-travel-file.1jiaohu.com/resource/20260610/f037325e092b493eb31135542494a7ca.png', '', null, null, null, 'The No. 19 Bachelor\'s Apartment at Shanxi Agricultural University', null, null, null, null, '', null, '0', '0', '2026-06-10 17:08:58', '0', null, null, null, null);
INSERT INTO `travel_module_detail` VALUES ('819728097422348288', '847162', '山西农业大学铭贤学校旧址', null, null, 'https://ar-travel-file.1jiaohu.com/resource/20260610/84446dfe854d492d83a527e79200d99b.jpg', '', '', '', null, '<p>山西铭贤学校旧址，原为太谷望族孟氏的别墅，又称孟家花园，位于山西省晋中市<a href=\"https://baike.baidu.com/item/%E5%A4%AA%E8%B0%B7%E5%8C%BA/24190200?fromModule=lemma_inlink\" target=\"_blank\">太谷区</a>候城乡杨家庄村西，始建于清中期。<sup>&nbsp;<em></em></sup></p><p>山西铭贤学校旧址包括孟家花园、教学建筑和宿舍别墅群三个部分。<sup>&nbsp;[2]<em></em></sup>孟家花园，也称“孟氏园”，现存建筑占地面积南北长约80米，东西宽约100米，总面积约8000平方米，分东、中、西三院。东院为两进院落；中院（祀神区）系四合院；西院（寝室及书斋区）是三进院落<sup>&nbsp;[3]<em></em></sup>；教学建筑包括杭氏楼、田氏楼、韩氏楼、亭兰图书馆和嘉桂科学楼；宿舍别墅群，为学生宿舍、外教宿舍，现存16栋，均为二层砖构。<sup>&nbsp;[2]<em></em></sup>山西铭贤学校旧址为完整的旧址遗存，呈现出从清代私家园林到中西文化结合的现代教学设施的巨大变化，展现了清末民国时期中国教育变革的重要发展历程。旧址承载的大量历史信息，为研究北方私家园林、中西文化交流、建筑艺术等提供了实证。</p><p>2013年3月5日，山西铭贤学校旧址被中华人民共和国国务院公布为<a href=\"https://baike.baidu.com/item/%E7%AC%AC%E4%B8%83%E6%89%B9%E5%85%A8%E5%9B%BD%E9%87%8D%E7%82%B9%E6%96%87%E7%89%A9%E4%BF%9D%E6%8A%A4%E5%8D%95%E4%BD%8D/3525703?fromModule=lemma_inlink\" target=\"_blank\">第七批全国重点文物保护单位</a>。<sup>&nbsp;</sup></p><p><sup><br/></sup></p><p><img src=\"https://ar-travel-file.1jiaohu.com/resource/20260610/508a342eb0fa41b8af8f354823b0e579.jpg\" style=\"max-width:100%;\" contenteditable=\"false\" data-extentions-extra-ocr-id=\"6d2e539c5bfd1fd6504c394a279873d2\"/></p>', '1', '1', '2026-06-10 17:11:17', '37.423875,112.582225', null, null, '0', null, '0', '0', null, '1', 'https://ar-travel-file.1jiaohu.com/resource/20260610/eb27494224c041a394afb923b6e129e5.jpg', '', null, null, null, 'Oberlin Shansi Memorial School', null, null, null, null, '', null, '0', '0', '2026-06-10 17:11:16', '0', null, null, null, null);
INSERT INTO `travel_module_detail` VALUES ('819728677184212992', '847162', '崇圣楼', null, null, 'https://ar-travel-file.1jiaohu.com/resource/20260610/e8f8d5130b6c461881d07c0467739e70.jpg', '', '', '', null, '', '1', '1', '2026-06-10 17:13:35', '37.437060,112.581633', null, null, '0', null, '0', '0', null, '2', 'https://ar-travel-file.1jiaohu.com/resource/20260610/6c850421fca64195b5c968bef6b648e4.jpg', '', null, null, null, 'Chongsheng Building', null, null, null, null, '', null, '0', '0', '2026-06-10 17:13:35', '0', null, null, null, null);
INSERT INTO `travel_module_detail` VALUES ('819732931194130432', '923342', '草坪音乐节', null, null, 'https://ar-travel-file.1jiaohu.com/resource/20260610/26f5dfb05136413abfed90bb496d65cc.jpg', '', '', '', null, '<p>校各单位：</p><p>根据《中共山西省委宣传部山西省科学技术协会山西省科学技术厅关于开展2026年“山西最美科技工作者”学习宣传活动的通知》（附件）要求，我校开展2026年山西省“最美科技工作者”推荐工作，有关事项安排如下：</p><p>1、各单位根据文件要求自愿组织推荐，择优推荐不超过1名科技工作者参加遴选。</p><p>2、本次推荐面向基层。突出基层一线，注重选树青年科技工作者（45岁以下）典型，兼顾不同类别、年龄、性别的科技工作者（党外科技人员优先）。</p><p>3、工作单位：山西农业大学；推荐单位：山西省农学会；纪检意见由科研部统一办理。</p><p>4、各单位于7月10日前将候选人推荐表和汇总表Word版、盖章版汇总表发送至邮箱<a href=\"mailto:sxndxsjl@126.com\">sxndxsjl@126.com</a>。</p><p>联系人：王慧贤 李琦</p><p><br/></p><p><img src=\"https://ar-travel-file.1jiaohu.com/resource/20260610/ae98ee4950b140ae9c6e65f40fed30c5.jpg\" style=\"max-width:100%;\" contenteditable=\"false\" data-extentions-extra-ocr-id=\"b993da0ce4651f062bf40a4fcd1a9f68\"/></p>', '1', '1', '2026-06-10 17:30:30', '37.423038,112.583703', null, null, '0', null, '0', '0', null, '1', 'https://ar-travel-file.1jiaohu.com/resource/20260610/afad066c80e64c3f9c2d46829a2371b2.jpg', '', '', null, null, '草坪音乐节', null, null, null, null, '', null, '0', '0', '2026-06-10 17:30:29', '0', '', '', null, null);
INSERT INTO `travel_module_detail` VALUES ('819740936698597376', '923342', '酷跑活动', null, null, 'https://ar-travel-file.1jiaohu.com/resource/20260610/ea5461f9f66f4d43a1e6230e63fb26ab.jpg', '', '', '', null, '<p><img src=\"https://ar-travel-file.1jiaohu.com/resource/20260610/774870430c2e45aba1e5e0ea6b431f93.jpg\" style=\"max-width:100%;\" contenteditable=\"false\" data-extentions-extra-ocr-id=\"dc49e7c3724b42221477712d554f6e6e\"/></p><p><br/></p><p>6月1日至3日，校党委常委、副校（院）长张富强率城乡建设学院党政领导，赴湖北省丹江口市中国南水北调集团江汉水网建设开发有限公司（以下简称集团公司）及相关工程现场，围绕“深化校企合作、拓展就业岗位、搭建产教平台”开展专题调研交流，实地感受南水北调“世纪工程”的建设脉搏，并与企业方在人才培养、技术攻关、学生实习就业等方面达成了多项合作共识。</p>', '1', '1', '2026-06-10 18:02:18', '37.423038,112.583703', null, null, '0', null, '0', '0', null, '2', 'https://ar-travel-file.1jiaohu.com/resource/20260610/05d042b6fe1a4180ab8121e6d5cc7ed9.jpg', '', null, null, null, '酷跑活动', null, null, null, null, '', null, '0', '0', '2026-06-10 18:02:18', '0', null, null, null, null);

-- ----------------------------
-- Table structure for travel_recognition_library
-- ----------------------------
DROP TABLE IF EXISTS `travel_recognition_library`;
CREATE TABLE `travel_recognition_library` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键',
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件名称',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片地址',
  `tag` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '标记，1:景点 2:文创',
  `module_detail_id` bigint(20) unsigned NOT NULL COMMENT '关联景点id',
  `source` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '来源，1：用户 2：官方',
  `cont_sign` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '百度图片签名信息',
  `is_storage` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否入库，0：否 1：是',
  `storage_time` datetime DEFAULT NULL COMMENT '入库时间',
  `create_by` bigint(20) unsigned NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_module_detail_id` (`module_detail_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='识别库';

-- ----------------------------
-- Records of travel_recognition_library
-- ----------------------------

-- ----------------------------
-- Table structure for travel_scenic_spot_comment
-- ----------------------------
DROP TABLE IF EXISTS `travel_scenic_spot_comment`;
CREATE TABLE `travel_scenic_spot_comment` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键',
  `scenic_spot_id` bigint(20) unsigned NOT NULL COMMENT '景点id',
  `comment_user_id` bigint(20) unsigned NOT NULL COMMENT '评论人id',
  `comment` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态，1：正常 0：失效',
  `create_by` bigint(20) unsigned NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_scenic_spot_id` (`scenic_spot_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='景点评论表';

-- ----------------------------
-- Records of travel_scenic_spot_comment
-- ----------------------------
INSERT INTO `travel_scenic_spot_comment` VALUES ('1', '1', '1', '测试', '1', '1', '2020-11-11 14:12:12');

-- ----------------------------
-- Table structure for travel_scenic_spot_like
-- ----------------------------
DROP TABLE IF EXISTS `travel_scenic_spot_like`;
CREATE TABLE `travel_scenic_spot_like` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键',
  `scenic_spot_id` bigint(20) unsigned NOT NULL COMMENT '景点id',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '点赞人id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_scenic_spot_id` (`scenic_spot_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='景点点赞表';

-- ----------------------------
-- Records of travel_scenic_spot_like
-- ----------------------------

-- ----------------------------
-- Table structure for travel_scenic_view
-- ----------------------------
DROP TABLE IF EXISTS `travel_scenic_view`;
CREATE TABLE `travel_scenic_view` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `scenic_id` bigint(20) DEFAULT NULL COMMENT '景点id',
  `dates` date DEFAULT NULL COMMENT '日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of travel_scenic_view
-- ----------------------------
INSERT INTO `travel_scenic_view` VALUES ('1264930687589552128', '7118', '819727024129314816', '2026-06-18');
INSERT INTO `travel_scenic_view` VALUES ('1264930716677050368', '7118', '819727518461595648', '2026-06-18');
INSERT INTO `travel_scenic_view` VALUES ('1264933246920298496', '7118', '819740936698597376', '2026-06-18');

-- ----------------------------
-- Table structure for travel_slideshow
-- ----------------------------
DROP TABLE IF EXISTS `travel_slideshow`;
CREATE TABLE `travel_slideshow` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键',
  `picture_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '轮播图url',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态，0：无效 1：正常',
  `create_by` bigint(20) unsigned NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='小程序首页轮播图';

-- ----------------------------
-- Records of travel_slideshow
-- ----------------------------
INSERT INTO `travel_slideshow` VALUES ('727644518316511232', 'https://ar-travel.1jiaohu.com/files/20250929/194507b3-bb36-4cb2-8795-1464d908710b启动页4.png', '1', '1', '2025-09-29 14:44:01');
INSERT INTO `travel_slideshow` VALUES ('727649333914374144', 'https://ar-travel.1jiaohu.com/files/20250929/4be37779-563a-4f7c-b8f4-e16f4e69818ee5b0661bd942e8455f08b21cb2ac69d3.jpg', '1', '1', '2025-09-29 15:03:09');
INSERT INTO `travel_slideshow` VALUES ('727649349101948928', 'https://ar-travel.1jiaohu.com/files/20250929/da5a44d0-c610-4b83-9d32-1fb2b62478d8e928a24b1f9645883f54aba5c377b00e.jpg', '1', '1', '2025-09-29 15:03:13');

-- ----------------------------
-- Table structure for travel_sub_classification
-- ----------------------------
DROP TABLE IF EXISTS `travel_sub_classification`;
CREATE TABLE `travel_sub_classification` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态 1：正常 0：失效',
  `module_id` bigint(20) unsigned NOT NULL COMMENT '模块id',
  `create_by` bigint(20) unsigned NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `order_by` int(11) DEFAULT '10' COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `idx_module_id` (`module_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='二级分类';

-- ----------------------------
-- Records of travel_sub_classification
-- ----------------------------
INSERT INTO `travel_sub_classification` VALUES ('169863344680079360', 'VR阅读', '1', '847162', '1', '2021-07-13 10:20:46', '5');
INSERT INTO `travel_sub_classification` VALUES ('301883092531154944', '红色印记', '1', '847162', '1', '2022-07-12 17:40:07', '10');

-- ----------------------------
-- Table structure for travel_video
-- ----------------------------
DROP TABLE IF EXISTS `travel_video`;
CREATE TABLE `travel_video` (
  `id` bigint(20) NOT NULL,
  `model_id` bigint(20) DEFAULT NULL,
  `tour_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tittle` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover` text COLLATE utf8mb4_unicode_ci,
  `video` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `type` int(11) DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `inx` int(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_model_id` (`model_id`,`name`,`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of travel_video
-- ----------------------------
INSERT INTO `travel_video` VALUES ('727642056713048064', '238797802266955776', '727564528384217088', ' 耕土耘心育桃李 科教融合开新篇-山西农业大', '视频农大', 'https://ar-travel.1jiaohu.com/files/20250929/81803914-51a0-4be9-8eb4-6354504480acwps (8).png', 'https://ar-travel.1jiaohu.com/files/20250929/9af98bb4-5ff6-4725-81b4-37b7a4c5b35a耕土耘心育桃李 科教融合开新篇-山西农业大.mp4', '2025-09-29 14:34:14', '1', '20', null, null, null, null, null);
INSERT INTO `travel_video` VALUES ('727644444454817792', '238797802266955776', null, '逐梦﹒青春', '2018年招生宣传片', 'https://ar-travel.1jiaohu.com/files/20250929/63e3ceee-f163-4d12-a5cb-58f5bdac8963逐梦﹒青春.png', 'https://ar-travel.1jiaohu.com/files/20250929/6ac171c9-e1b8-4f30-a0ae-30ed0515cec0逐梦﹒青春.mp4', '2025-09-29 14:43:43', '1', '4', null, null, null, null, null);
INSERT INTO `travel_video` VALUES ('727675869434482688', '238797802266955776', null, '白鹿原', '白鹿原在山西农大取景地', 'https://ar-travel.1jiaohu.com/files/20250929/e03993d3-7f58-4e51-8e7a-e853fea37ed4wps (12).png', 'https://ar-travel.1jiaohu.com/files/20250929/8927526b-17c8-4240-95b5-da99f601cef2白鹿原在山西农大取景地，老戏骨何冰的戏份。非常喜欢的一部经典电视剧，推荐大家看看。 山西农业大学 白鹿原 何冰 雷佳音 那些年追过的剧 - 抖音.mp4', '2025-09-29 16:48:36', '1', '6', null, null, null, null, null);

-- ----------------------------
-- Table structure for travel_views
-- ----------------------------
DROP TABLE IF EXISTS `travel_views`;
CREATE TABLE `travel_views` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `time` datetime DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of travel_views
-- ----------------------------

-- ----------------------------
-- Table structure for travel_vr
-- ----------------------------
DROP TABLE IF EXISTS `travel_vr`;
CREATE TABLE `travel_vr` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态 1：启用 0：关闭',
  `identify` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标识',
  `create_by` bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `vr_cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'VR封面图',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_identify` (`identify`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1058 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='vr表';

-- ----------------------------
-- Records of travel_vr
-- ----------------------------

-- ----------------------------
-- Table structure for travel_vr_brief
-- ----------------------------
DROP TABLE IF EXISTS `travel_vr_brief`;
CREATE TABLE `travel_vr_brief` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `scenic_id` bigint(20) unsigned DEFAULT NULL COMMENT '景点id',
  `brief_id` bigint(20) unsigned DEFAULT NULL COMMENT '全景图简介id',
  `introduction` text COLLATE utf8mb4_unicode_ci COMMENT '全景图简介',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1150 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='全景图简介表';


ALTER TABLE `travel_scenic_view`
    ADD COLUMN `event_type` tinyint(3) DEFAULT '1' COMMENT '事件类型：1-建筑浏览 2-建筑识别 3-VR查看' AFTER `dates`,
ADD COLUMN `source` varchar(64) DEFAULT NULL COMMENT '来源标识：首页、搜索、地图、分享等' AFTER `event_type`,
ADD COLUMN `source_detail` varchar(128) DEFAULT NULL COMMENT '来源补充说明' AFTER `source`;

ALTER TABLE `travel_views`
    ADD COLUMN `event_type` tinyint(3) DEFAULT '1' COMMENT '事件类型：1-小程序访问' AFTER `time`,
ADD COLUMN `source` varchar(64) DEFAULT NULL COMMENT '来源标识：首页、搜索、分享等' AFTER `event_type`,
ADD COLUMN `source_detail` varchar(128) DEFAULT NULL COMMENT '来源补充说明' AFTER `source`,
ADD COLUMN `page_name` varchar(64) DEFAULT NULL COMMENT '页面标识' AFTER `source_detail`;


CREATE TABLE `travel_model_video` (
                                      `id` bigint(20) NOT NULL COMMENT '主键ID',
                                      `name` varchar(255) DEFAULT NULL COMMENT '音频名称',
                                      `url` varchar(1000) DEFAULT NULL COMMENT '音频地址',
                                      `model_id` bigint(20) DEFAULT NULL COMMENT '景点ID，对应 travel_module_detail.id',
                                      `qr_url` varchar(1000) DEFAULT NULL COMMENT '二维码地址',
                                      `inx` int(11) DEFAULT NULL COMMENT '排序',
                                      `content` text COMMENT '内容说明',
                                      `theme` varchar(255) DEFAULT NULL COMMENT '主题',
                                      `people` varchar(255) DEFAULT NULL COMMENT '人物',
                                      PRIMARY KEY (`id`),
                                      KEY `idx_travel_model_video_model_id` (`model_id`),
                                      KEY `idx_travel_model_video_inx` (`inx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='景点音频表';
-- ----------------------------
-- Records of travel_vr_brief
-- ----------------------------
