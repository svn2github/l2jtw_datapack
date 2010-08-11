DROP TABLE IF EXISTS `character_premium_items`;
CREATE TABLE `character_premium_items` (
  `charId` int(11) NOT NULL,
  `itemNum` int(11) NOT NULL,
  `itemId` int(11) NOT NULL,
  `itemCount` bigint(20) unsigned NOT NULL,
  `itemSender` varchar(50) NOT NULL,
  `itemElementType` int(1) NOT NULL DEFAULT '-1',
  `itemElementValue` int(3) unsigned NOT NULL DEFAULT '0',
  `itemEnchantLevel` int(2) unsigned NOT NULL DEFAULT '0',
  `itemAugumentSkillId` int(6) unsigned NOT NULL DEFAULT '0',
  `itemAugumentSkillLevel` int(3) unsigned NOT NULL DEFAULT '0',
  KEY `charId` (`charId`),
  KEY `itemNum` (`itemNum`)
);
