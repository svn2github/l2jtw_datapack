/************ Made in Taiwan ************/

/************ 修正武器 ************/
UPDATE `weapon` SET `onCrit_skill_chance` = '100' WHERE `item_id` in (4694,4789,4795,4804,4807,5604,5646,6308,8104,8105,8125,8128,8811,9254,9282,9287,9321,9347);
UPDATE `weapon` SET `onCrit_skill_chance` = '6' WHERE `item_id` in (4781);
UPDATE `weapon` SET `onCrit_skill_chance` = '7' WHERE `item_id` in (4775);
UPDATE `weapon` SET `onCrit_skill_chance` = '9' WHERE `item_id` in (4760,4766);
UPDATE `weapon` SET `onCrit_skill_chance` = '12' WHERE `item_id` in (4805);
UPDATE `weapon` SET `onCrit_skill_chance` = '14' WHERE `item_id` in (4796,4801);
UPDATE `weapon` SET `onCrit_skill_chance` = '17' WHERE `item_id` in (4790);
UPDATE `weapon` SET `onCrit_skill_chance` = '25' WHERE `item_id` in (4859);
UPDATE `weapon` SET `onCrit_skill_chance` = '27' WHERE `item_id` in (4856);
UPDATE `weapon` SET `onCrit_skill_chance` = '29' WHERE `item_id` in (4852);
UPDATE `weapon` SET `onCrit_skill_chance` = '31' WHERE `item_id` in (4847,4849);
UPDATE `weapon` SET `onCrit_skill_chance` = '32' WHERE `item_id` in (4843);
UPDATE `weapon` SET `onCrit_skill_chance` = '34' WHERE `item_id` in (4835,4838,4840);
UPDATE `weapon` SET `onCast_skill_chance` = '50' WHERE `item_id` in (4865,4877,4889,4898);
UPDATE `weapon` SET `skill` = '3260-1;3261-1;3262-1;' WHERE `item_id` in (9140,9141);


/************ 修正地獄邊界的NPC ************/
REPLACE INTO spawnlist VALUES
('850001', '', 1, 18466, 4681, 243922, -1930, 0, 0, 37373, 10, 0, 0),    -- 外廓警衛隊長
('850002', '', 1, 22326, -23961, 245615, -3138, 0, 0, 129600, 10, 0, 0), -- 海琳納克
('850003', '', 1, 32344, 13278, 282253, -9705, 0, 0, 49686, 10, 0, 0),   -- 陰沉碑石
('850004', '', 1, 32302, 13219, 282021, -7547, 0, 0, 50484, 10, 0, 0),   -- 塞良
('850005', '', 1, 32373, 17938, 283202, -9700, 0, 0, 9914, 10, 0, 0);    -- 多利安

REPLACE INTO `npc` VALUES 
(18466, 18466, 'Outpost Captain', 0, '', 0, 'LineageMonster3.benom', 20.00, 56.00, 84, 'male', 'L2Monster', 90, 1282576, 3720, 300.00, 20.00, 60, 65, 70, 75, 70, 80, 2629657, 267913, 32578, 10675, 5907, 2146, 620, 0, 3820, 8203, 8203, 0, 0, 50, 280, 0, 13, 'FULL_PARTY', 'false'),
(22326, 22326, 'Hellinark', 0, 'Guardian of Naia', 0, 'LineageMonster.karik', 19.00, 90.00, 84, 'male', 'L2Monster', 60, 465488, 4355, 202.00, 10.00, 64, 66, 68, 62, 61, 58, 2629657, 267913, 28564, 3856, 12487, 5647, 590, 0, 3819, 0, 0, 0, 0, 40, 290, 0, 13, 'FULL_PARTY', 'false'),
(32362, 32362, 'Hellbound Native', 0, '', 0, 'LineageNPC.a_common_peopleC_Mhuman', 8.00, 23.50, 1, 'male', 'L2Npc', 40, 2444, 2444, 0.00, 0.00, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 253, 0, 253, 0, 0, 0, 0, 80, 120, 0, 0, 'LAST_HIT', 'false');
REPLACE INTO `minions` VALUES (22448, 22451, 2, 2); -- 雷歐達斯 反抗軍指揮官
REPLACE INTO `minions` VALUES (22449, 22450, 8, 8); -- 亞邁士康里 拷問專家
UPDATE `etcitem` SET `skill` = '2440-1;', `handler` = 'ItemSkills' WHERE `item_id` = '9599'; -- 惡魔的古書
UPDATE `etcitem` SET `skill` = '2357-1;', `handler` = 'ItemSkills' , `item_type` = 'herb' WHERE `item_id` = '9849'; -- 惡魔溫熱的血


/************ 修正神諭之島的NPC ************/
UPDATE `etcitem` SET `handler` = 'PaganKeys' WHERE `item_id` = '9694'; -- 祕密花園的鑰匙
UPDATE `etcitem` SET `skill` = '2362-1;', `handler` = 'PaganKeys' WHERE `item_id` = '10015'; -- 監獄門鑰匙
REPLACE INTO `npc` VALUES
(25531, 25531, 'Darnel', 0, 'Square', 0, 'LineageMonster4.rah', 20.00, 40.00, 81, 'female', 'L2RaidBoss', 60, 2140552, 17569, 382.02, 10.32, 65, 66, 68, 70, 62, 65, 1543436, 615888, 8856, 4615, 7408, 2011, 424, 0, 3819, 0, 0, 0, 0, 80, 307, 0, 0, 'FULL_PARTY', 'false'),
(25532, 25532, 'Kechi', 0, 'Fire', 0, 'LineageMonster4.Keyache', 12.00, 29.00, 82, 'male', 'L2RaidBoss', 50, 534278, 16784, 402.02, 10.45, 70, 69, 64, 67, 68, 70, 2329744, 867941, 8856, 5286, 7408, 2911, 422, 0, 3819, 0, 0, 0, 0, 80, 307, 0, 0, 'FULL_PARTY', 'false'),
(25534, 25534, 'Tears', 0, 'Ice', 0, 'LineageMonster4.tears', 20.00, 27.50, 83, 'female', 'L2RaidBoss', 40, 2219066, 19500, 362.02, 10.81, 62, 61, 64, 79, 70, 66, 1810897, 729241, 8156, 4615, 8408, 2011, 422, 0, 3819, 9640, 9643, 0, 0, 80, 307, 0, 0, 'LAST_HIT', 'false'),
(25535, 25535, 'Tears', 0, 'Ice', 0, 'LineageMonster4.tears', 20.00, 27.50, 83, 'female', 'L2Monster', 40, 2219066, 19500, 362.02, 9.81, 62, 61, 64, 79, 70, 80, 1, 1, 450, 5000, 300, 7000, 409, 500, 3819, 9640, 9643, 0, 0, 55, 307, 0, 0, 'LAST_HIT', 'false');

REPLACE INTO `npcskills` VALUES
('25531', '4063', '1'),
('25531', '4333', '6'),
('25531', '4409', '17'),
('25532', '733', '1'),
('25532', '734', '1'),
('25532', '4418', '5'),
('25534', '4419', '5'),
('25535', '4419', '5'),
('25535', '5238', '1');


/************ 新增欲界資料表 ************/
CREATE TABLE IF NOT EXISTS `kamaloka` (`charID` int(10) NOT NULL,`HallAbyss` decimal(20,0) NOT NULL DEFAULT '0',`LabyrinthAbyss` decimal(20,0) NOT NULL DEFAULT '0',PRIMARY KEY (`charID`)) DEFAULT CHARSET=utf8;
