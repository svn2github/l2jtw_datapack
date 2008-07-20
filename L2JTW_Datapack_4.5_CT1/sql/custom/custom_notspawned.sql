#--------------------------------------
# Table structure for custom_notspawned
#--------------------------------------
DROP TABLE IF EXISTS `custom_notspawned`;
CREATE TABLE `custom_notspawned` (
  `id` int(11) NOT NULL,
  `isCustom` int(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM;
