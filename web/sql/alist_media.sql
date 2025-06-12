/*
 Navicat Premium Data Transfer

 Source Server         : Web项目
 Source Server Type    : MySQL
 Source Server Version : 80404
 Source Host           : 110.42.102.224:3306
 Source Schema         : alist_media

 Target Server Type    : MySQL
 Target Server Version : 80404
 File Encoding         : 65001

 Date: 12/06/2025 19:00:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for media_files
-- ----------------------------
DROP TABLE IF EXISTS `media_files`;
CREATE TABLE `media_files`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_type` enum('image','video','audio','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` bigint NULL DEFAULT NULL,
  `alist_path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `preview_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `uploaded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `media_files_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of media_files
-- ----------------------------
INSERT INTO `media_files` VALUES (1, 1, '009.jpg', 'image', 106238, '/cloudflare/009.jpg', 'https://alist.5888888885.xyz/d/cloudflare/009.jpg', '2025-05-29 08:24:47');
INSERT INTO `media_files` VALUES (2, 1, '1000049672.jpg', 'image', 4251891, '/cloudflare/1000049672.jpg', 'https://alist.5888888885.xyz/d/cloudflare/1000049672.jpg', '2025-05-29 08:24:47');
INSERT INTO `media_files` VALUES (3, 1, 'R.png', 'image', 11324, '/cloudflare/R.png', 'https://alist.5888888885.xyz/d/cloudflare/R.png', '2025-05-29 08:24:47');
INSERT INTO `media_files` VALUES (4, 1, 'Thumb.webp', 'image', 38120, '/cloudflare/Thumb.webp', 'https://alist.5888888885.xyz/d/cloudflare/Thumb.webp', '2025-05-29 08:24:47');
INSERT INTO `media_files` VALUES (5, 1, 'beach-4814418.jpg', 'image', 5099583, '/cloudflare/beach-4814418.jpg', 'https://alist.5888888885.xyz/d/cloudflare/beach-4814418.jpg', '2025-05-29 08:24:47');
INSERT INTO `media_files` VALUES (6, 3, 'xiaolin.mp4', 'video', 6861989770, '/cloudflare/xiaolin.mp4', 'https://alist.5888888885.xyz/d/cloudflare/xiaolin.mp4', '2025-05-29 08:24:47');
INSERT INTO `media_files` VALUES (22, 4, '465346436.jpg', 'image', 11324, '/cloudflare/465346436.jpg', 'https://alist.5888888885.xyz/d/cloudflare/465346436.jpg', '2025-05-29 08:48:43');
INSERT INTO `media_files` VALUES (24, 4, 'T2.drawio.png', 'image', 11324, '/cloudflare/T2.drawio.png', 'https://alist.5888888885.xyz/d/cloudflare/T2.drawio.png', '2025-05-29 09:22:27');
INSERT INTO `media_files` VALUES (26, 4, 'local665ad24e9c0ad.png', 'image', 11324, '/cloudflare/local665ad24e9c0ad.png', 'https://alist.5888888885.xyz/d/cloudflare/local665ad24e9c0ad.png', '2025-05-29 09:23:04');
INSERT INTO `media_files` VALUES (28, 1, '白云.png', 'image', 11324, '/cloudflare/白云.png', 'https://alist.5888888885.xyz/d/cloudflare/白云.png', '2025-05-30 13:08:39');
INSERT INTO `media_files` VALUES (29, 4, 'img-3.jpg', 'image', 11324, '/cloudflare/img-3.jpg', 'https://alist.5888888885.xyz/d/cloudflare/img-3.jpg', '2025-06-03 09:57:54');
INSERT INTO `media_files` VALUES (30, 4, '三角洲行动   2024-10-18 14-50-53.mp4', 'video', 11324, '/cloudflare/三角洲行动   2024-10-18 14-50-53.mp4', 'https://alist.5888888885.xyz/d/cloudflare/三角洲行动   2024-10-18 14-50-53.mp4', '2025-06-03 09:59:03');
INSERT INTO `media_files` VALUES (33, 4, '001.png', 'image', 287873, '/cloudflare/001.png', 'https://alist.5888888885.xyz/d/cloudflare/001.png', '2025-06-03 10:16:40');
INSERT INTO `media_files` VALUES (34, 4, 'icon.png', 'image', 12243, '/cloudflare/icon.png', 'https://alist.5888888885.xyz/d/cloudflare/icon.png', '2025-06-03 13:40:38');
INSERT INTO `media_files` VALUES (35, 4, 'clouds-2751811.jpg', 'image', 2663458, '/cloudflare/clouds-2751811.jpg', 'https://alist.5888888885.xyz/d/cloudflare/clouds-2751811.jpg', '2025-06-03 13:40:54');
INSERT INTO `media_files` VALUES (36, 4, 'preview1748627204654.png.jpg', 'image', 1019209, '/cloudflare/preview1748627204654.png.jpg', 'https://alist.5888888885.xyz/d/cloudflare/preview1748627204654.png.jpg', '2025-06-03 14:54:20');
INSERT INTO `media_files` VALUES (39, 4, '64c69533d494f.png', 'image', 133936, '/cloudflare/64c69533d494f.png', 'https://alist.5888888885.xyz/d/cloudflare/64c69533d494f.png', '2025-06-04 16:19:47');
INSERT INTO `media_files` VALUES (41, 4, 'beach-4814418.jpg', 'image', 5099583, '/cloudflare/beach-4814418.jpg', 'https://alist.5888888885.xyz/d/cloudflare/beach-4814418.jpg', '2025-06-05 00:17:34');
INSERT INTO `media_files` VALUES (42, 4, 'beach-4814418.jpg', 'image', 5099583, '/cloudflare/beach-4814418.jpg', 'https://alist.5888888885.xyz/d/cloudflare/beach-4814418.jpg', '2025-06-05 00:17:44');
INSERT INTO `media_files` VALUES (46, 3, 'gaituba.com_crop-round.jpg', 'image', 655613, '/cloudflare/gaituba.com_crop-round.jpg', 'https://alist.5888888885.xyz/d/cloudflare/gaituba.com_crop-round.jpg', '2025-06-05 00:31:54');
INSERT INTO `media_files` VALUES (47, 4, '133816550333027095.jpg', 'image', 1920459, '/cloudflare/133816550333027095.jpg', 'https://alist.5888888885.xyz/d/cloudflare/133816550333027095.jpg', '2025-06-05 02:21:11');
INSERT INTO `media_files` VALUES (50, 3, '24324324.mp4', 'video', 739483, '/cloudflare/24324324.mp4', 'https://alist.5888888885.xyz/d/cloudflare/24324324.mp4', '2025-06-05 02:30:57');
INSERT INTO `media_files` VALUES (52, 3, '5645654.png', 'image', 5648360, '/cloudflare/5645654.png', 'https://alist.5888888885.xyz/d/cloudflare/5645654.png', '2025-06-05 02:57:22');
INSERT INTO `media_files` VALUES (54, 4, '1749172676577.jpeg', 'image', 6475216, '/cloudflare/1749172676577.jpeg', 'https://alist.5888888885.xyz/d/cloudflare/1749172676577.jpeg', '2025-06-06 02:06:40');
INSERT INTO `media_files` VALUES (55, 3, 'halo博客封面图.png', 'image', 137519, '/cloudflare/halo博客封面图.png', 'https://alist.5888888885.xyz/d/cloudflare/halo博客封面图.png', '2025-06-06 04:16:21');
INSERT INTO `media_files` VALUES (57, 3, 'luotao.jpg', 'image', 14090, '/cloudflare/luotao.jpg', 'https://alist.5888888885.xyz/d/cloudflare/luotao.jpg', '2025-06-06 15:34:29');
INSERT INTO `media_files` VALUES (62, 4, '324534.png', 'image', 1652528, '/cloudflare/324534.png', 'https://alist.5888888885.xyz/d/cloudflare/324534.png', '2025-06-07 03:44:12');
INSERT INTO `media_files` VALUES (63, 4, '003.png', 'image', 207851, '/cloudflare/003.png', 'https://alist.5888888885.xyz/d/cloudflare/003.png', '2025-06-08 02:10:41');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_regular` tinyint(1) NOT NULL DEFAULT 1 COMMENT '普通用户标识，默认true',
  `is_editor` tinyint(1) NOT NULL DEFAULT 0 COMMENT '编辑者标识',
  `is_admin` tinyint(1) NOT NULL DEFAULT 0 COMMENT '管理员标识',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'testuser', 'hashedpassword123', 'test@example.com', '2025-05-24 15:55:45', 1, 0, 0);
INSERT INTO `users` VALUES (2, 'test', 'test', 'test@test', '2025-05-28 15:07:38', 1, 0, 0);
INSERT INTO `users` VALUES (3, 'Tom', '123456', '123@123', '2025-05-28 15:22:08', 1, 1, 0);
INSERT INTO `users` VALUES (4, 'luotao', '20050508', '18727430326@163.com', '2025-05-29 08:42:19', 1, 0, 1);

SET FOREIGN_KEY_CHECKS = 1;
