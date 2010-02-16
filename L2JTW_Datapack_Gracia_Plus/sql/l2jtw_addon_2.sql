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
REPLACE INTO `npcskills` VALUES
('25532', '733', '1'),
('25532', '734', '1'),
('25532', '4418', '5'),
('25534', '4419', '5');


/************ 刪除自訂的欲界資料表 ************/
DROP TABLE IF EXISTS kamaloka;
