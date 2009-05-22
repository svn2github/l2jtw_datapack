ALTER TABLE `custom_armorsets` ADD `mw_legs` SMALLINT UNSIGNED NOT NULL DEFAULT 0 AFTER `enchant6skill`;
ALTER TABLE `custom_armorsets` ADD `mw_head` SMALLINT UNSIGNED NOT NULL DEFAULT 0 AFTER `mw_legs`;
ALTER TABLE `custom_armorsets` ADD `mw_gloves` SMALLINT UNSIGNED NOT NULL DEFAULT 0 AFTER `mw_head`;
ALTER TABLE `custom_armorsets` ADD `mw_feet` SMALLINT UNSIGNED NOT NULL DEFAULT 0 AFTER `mw_gloves`;
ALTER TABLE `custom_armorsets` ADD `mw_shield` SMALLINT UNSIGNED NOT NULL DEFAULT 0 AFTER `mw_feet`;
ALTER TABLE `custom_armorsets` ADD `skill_lvl` TINYINT UNSIGNED NOT NULL default 0 AFTER `skill_id` ;
ALTER TABLE `armorsets` ADD `skill_lvl` TINYINT UNSIGNED NOT NULL default 0 AFTER `skill_id` ;
ALTER TABLE `items` ADD `time` decimal NOT NULL default 0 after `mana_left`;
