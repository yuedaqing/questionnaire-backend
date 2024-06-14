# 数据库初始化
# @author <a href="https://github.com/yuedaqing">岳岳</a>
#

-- 创建库
create database if not exists questionnaire;

-- 切换库
use questionnaire;

/*
 Navicat Premium Data Transfer

 Source Server         : yueyue
 Source Server Type    : MySQL
 Source Server Version : 50737
 Source Host           : localhost:3306
 Source Schema         : questionnaire

 Target Server Type    : MySQL
 Target Server Version : 50737
 File Encoding         : 65001

 Date: 14/06/2024 11:08:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for app
-- ----------------------------
DROP TABLE IF EXISTS `app`;
CREATE TABLE `app`  (
                        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                        `appName` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
                        `appDesc` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '应用描述',
                        `appIcon` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '应用图标',
                        `appType` tinyint(4) NOT NULL DEFAULT 0 COMMENT '应用类型（0-得分类，1-测评类）',
                        `scoringStrategy` tinyint(4) NOT NULL DEFAULT 0 COMMENT '评分策略（0-自定义，1-AI）',
                        `reviewStatus` int(11) NOT NULL DEFAULT 0 COMMENT '审核状态：0-待审核, 1-通过, 2-拒绝',
                        `reviewMessage` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核信息',
                        `reviewerId` bigint(20) NULL DEFAULT NULL COMMENT '审核人 id',
                        `reviewTime` datetime(0) NULL DEFAULT NULL COMMENT '审核时间',
                        `userId` bigint(20) NOT NULL COMMENT '创建用户 id',
                        `createTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                        `updateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                        `isDelete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除',
                        PRIMARY KEY (`id`) USING BTREE,
                        INDEX `idx_appName`(`appName`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '应用' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
                             `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                             `questionContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '题目内容（json格式）',
                             `appId` bigint(20) NOT NULL COMMENT '应用 id',
                             `userId` bigint(20) NOT NULL COMMENT '创建用户 id',
                             `createTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                             `updateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                             `isDelete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除',
                             PRIMARY KEY (`id`) USING BTREE,
                             INDEX `idx_appId`(`appId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '题目' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for scoring_result
-- ----------------------------
DROP TABLE IF EXISTS `scoring_result`;
CREATE TABLE `scoring_result`  (
                                   `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                   `resultName` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '结果名称，如物流师',
                                   `resultDesc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '结果描述',
                                   `resultPicture` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '结果图片',
                                   `resultProp` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '结果属性集合 JSON，如 [I,S,T,J]',
                                   `resultScoreRange` int(11) NULL DEFAULT NULL COMMENT '结果得分范围，如 80，表示 80及以上的分数命中此结果',
                                   `appId` bigint(20) NOT NULL COMMENT '应用 id',
                                   `userId` bigint(20) NOT NULL COMMENT '创建用户 id',
                                   `createTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                   `updateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                   `isDelete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   INDEX `idx_appId`(`appId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '评分结果' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
                         `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                         `userAccount` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账号',
                         `userPassword` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
                         `unionId` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信开放平台id',
                         `mpOpenId` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公众号openId',
                         `userName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户昵称',
                         `userAvatar` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户头像',
                         `userProfile` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户简介',
                         `userRole` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user' COMMENT '用户角色：user/admin/ban',
                         `createTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                         `updateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                         `isDelete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除',
                         PRIMARY KEY (`id`) USING BTREE,
                         INDEX `idx_unionId`(`unionId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_answer
-- ----------------------------
DROP TABLE IF EXISTS `user_answer`;
CREATE TABLE `user_answer`  (
                                `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                `appId` bigint(20) NOT NULL COMMENT '应用 id',
                                `appType` tinyint(4) NOT NULL DEFAULT 0 COMMENT '应用类型（0-得分类，1-角色测评类）',
                                `scoringStrategy` tinyint(4) NOT NULL DEFAULT 0 COMMENT '评分策略（0-自定义，1-AI）',
                                `choices` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '用户答案（JSON 数组）',
                                `resultId` bigint(20) NULL DEFAULT NULL COMMENT '评分结果 id',
                                `resultName` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '结果名称，如物流师',
                                `resultDesc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '结果描述',
                                `resultPicture` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '结果图标',
                                `resultScore` int(11) NULL DEFAULT NULL COMMENT '得分',
                                `userId` bigint(20) NOT NULL COMMENT '用户 id',
                                `createTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                `updateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                `isDelete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除',
                                PRIMARY KEY (`id`) USING BTREE,
                                INDEX `idx_appId`(`appId`) USING BTREE,
                                INDEX `idx_userId`(`userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户答题记录' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
