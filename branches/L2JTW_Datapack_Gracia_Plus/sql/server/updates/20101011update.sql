ALTER TABLE `characters` ADD COLUMN `PcPoint` int(15) NOT NULL DEFAULT 0;
ALTER TABLE `clan_skills` ADD COLUMN `sub_pledge_id` INT NOT NULL default -2,
DROP PRIMARY KEY, ADD PRIMARY KEY (`clan_id`,`skill_id`,`sub_pledge_id`);
ALTER TABLE `item_attributes` DROP `elemType`, DROP `elemValue`;