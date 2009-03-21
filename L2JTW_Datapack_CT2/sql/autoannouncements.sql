
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for autoannouncements
-- ----------------------------
CREATE TABLE `autoannouncements` (
  `id` int(11) NOT NULL,
  `initial` bigint(20) NOT NULL,
  `delay` bigint(20) NOT NULL,
  `cycle` int(11) NOT NULL,
  `memo` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8;
