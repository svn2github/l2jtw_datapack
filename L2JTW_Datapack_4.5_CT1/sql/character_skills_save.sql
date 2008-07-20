-- ---------------------------
-- Table structure for character_skills
-- ---------------------------
CREATE TABLE IF NOT EXISTS character_skills_save (
  `charId` int(11) NOT NULL DEFAULT '0',
  `skill_id` int(11) NOT NULL DEFAULT '0',
  `skill_level` int(3) NOT NULL DEFAULT '1',
  `effect_count` int(11) NOT NULL DEFAULT '0',
  `effect_cur_time` int(11) NOT NULL DEFAULT '0',
  `reuse_delay` int(8) NOT NULL DEFAULT '0',
  `systime` double(30,0) NOT NULL DEFAULT '0',
  `restore_type` int(1) NOT NULL DEFAULT '0',
  `class_index` int(1) NOT NULL DEFAULT '0',
  `buff_index` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`charId`,`skill_id`,`class_index`)
) ;