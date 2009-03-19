
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for autoannouncements
-- ----------------------------
CREATE TABLE `autoannouncements` (
  `id` int(11) NOT NULL,
  `initial` bigint(20) NOT NULL,
  `delay` bigint(20) NOT NULL,
  `memo` text,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
