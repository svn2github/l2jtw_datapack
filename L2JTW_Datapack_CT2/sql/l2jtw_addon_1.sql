/************ Made in Taiwan ************/

/************ 修正32007加爾巴-釣魚會員 ************/
Delete From spawnlist Where `id` > 820000;
INSERT INTO `spawnlist` VALUES ('820001', '', '1', '32007', '140967', '-123600', '-1905 ', '0', '0', '11829', '60', '0', '0');
UPDATE `npc` SET `type` = 'L2Fisherman' WHERE `id` in (32007);
UPDATE `npc` SET `rhand` = '7560' WHERE `id` in (32007);
Delete From merchant_shopids Where npc_id in (32007);
Delete From merchant_buylists Where shop_id in (3200700);
INSERT INTO merchant_shopids VALUES (3200700,'32007');
INSERT INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(7807,-1,3200700,0),
(7808,-1,3200700,1),
(7809,-1,3200700,2),
(6520,-1,3200700,3),
(6523,-1,3200700,4),
(6526,-1,3200700,5),
(8506,-1,3200700,6),
(8509,-1,3200700,7),
(8512,-1,3200700,8),
(8484,-1,3200700,9),
(8485,-1,3200700,10),
(8486,-1,3200700,11),
(6529,-1,3200700,12),
(6530,-1,3200700,13),
(6531,-1,3200700,14),
(6532,-1,3200700,15),
(6533,-1,3200700,16),
(6534,-1,3200700,17),
(7561,-1,3200700,18),
(8193,-1,3200700,19),
(8194,-1,3200700,20),
(8195,-1,3200700,21),
(8196,-1,3200700,22),
(8197,-1,3200700,23),
(8198,-1,3200700,24),
(8199,-1,3200700,25),
(8200,-1,3200700,26),
(8202,-1,3200700,27);


/************ 地獄邊界 NPC 修正 (gto提供) ************/
DELETE FROM npc WHERE id= "22315";
DELETE FROM npc WHERE id= "22316";
DELETE FROM npc WHERE id= "22317";
DELETE FROM npc WHERE id= "22320";
DELETE FROM npc WHERE id= "22321";
DELETE FROM npc WHERE id= "22322";
DELETE FROM npc WHERE id= "22323";
DELETE FROM npc WHERE id= "22324";
DELETE FROM npc WHERE id= "22325";
DELETE FROM npc WHERE id= "22326";
DELETE FROM npc WHERE id= "22327";
DELETE FROM npc WHERE id= "22328";
DELETE FROM npc WHERE id= "22329";
DELETE FROM npc WHERE id= "22330";
DELETE FROM npc WHERE id= "22334";
DELETE FROM npc WHERE id= "22335";
DELETE FROM npc WHERE id= "22336";
DELETE FROM npc WHERE id= "22337";
DELETE FROM npc WHERE id= "22339";
DELETE FROM npc WHERE id= "22340";
DELETE FROM npc WHERE id= "22341";
DELETE FROM npc WHERE id= "22342";
DELETE FROM npc WHERE id= "22343";
DELETE FROM npc WHERE id= "22344";
DELETE FROM npc WHERE id= "22345";
DELETE FROM npc WHERE id= "22346";
DELETE FROM npc WHERE id= "22347";
DELETE FROM npc WHERE id= "22349";
INSERT INTO npc (`id`, `idTemplate`, `name`, `serverSideName`, `title`, `serverSideTitle`, `class`, `collision_radius`, `collision_height`, `level`, `sex`, `type`, `attackrange`, `hp`, `mp`, `hpreg`, `mpreg`, `str`, `con`, `dex`, `int`, `wit`, `men`, `exp`, `sp`, `patk`, `pdef`, `matk`, `mdef`, `atkspd`, `aggro`, `matkspd`, `rhand`, `lhand`, `armor`, `walkspd`, `runspd`, `faction_id`, `faction_range`, `isUndead`, `absorb_level`, `absorb_type`, `ss`, `bss`, `ss_rate`, `AI`, `drop_herbs`) VALUES
(22315, 22315, "Garden Guard ", 0, "", 0, "LineageMonster.water_giant", 20, 27, 83, "male", "L2Monster", 40, 4716, 1972, 26.86, 3.09, 40, 43, 30, 21, 20, 10, 10475, 1217, 2249, 736, 1258, 494, 200, 0, 333, 0, 0, 0, 22, 181, "NULL", 0, 0, 0, "LAST_HIT", 0, 0, 0, "fighter", "false"),
(22316, 22316, "Garden Guardian Tree", 0, "", 0, "LineageMonster3.Jungle_Bleeze", 20, 27, 83, "male", "L2Monster", 40, 4716, 1972, 26.86, 3.09, 40, 43, 30, 21, 20, 10, 10475, 1217, 2249, 736, 1258, 494, 200, 0, 333, 0, 0, 0, 22, 181, "NULL", 0, 0, 0, "LAST_HIT", 0, 0, 0, "fighter", "false"),
(22317, 22317, "Garden Castalia", 0, "", 0, "LineageMonster4.tears_d", 20, 27, 1, "male", "L2Monster", 40, 2444, 2444, 0, 0, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 253, 0, 253, 0, 0, NULL, 80, 120, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false"),
(22320, 22320, "Junior Watchman", 0, "", 0, "LineageMonster4.eyeless", 36, 43.5, 83, "male", "L2Monster", 40, 51870, 2444, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 163195, 17623, 12532, 1055, 4855, 954, 278, 370, 333, 0, 0, NULL, 60, 180, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "mage", "false"),
(22321, 22321, "Junior Summoner", 0, "", 0, "LineageMonster2.vampire_witch", 6, 21.5, 83, "female", "L2Monster", 40, 51870, 2444, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 155629, 16805, 12532, 1055, 4855, 954, 278, 370, 333, 946, 0, NULL, 64, 180, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "mage", "false"),
(22322, 22322, "Subjugated Native", 0, "", 0, "LineageNPC.a_common_peopleC_Mhuman", 10, 24, 1, "male", "L2Monster", 40, 2444, 2444, 0, 0, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 278, 0, 333, 8219, 0, NULL, 50, 100, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false"),
(22323, 22323, "Charmed Native", 0, "", 0, "LineageNPC.a_common_peopleC_Mhuman", 10, 24, 1, "male", "L2Monster", 40, 2444, 2444, 0, 0, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 278, 0, 333, 8528, 0, NULL, 50, 100, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false"),
(22324, 22324, "Blind Huntsman", 0, "", 0, "LineageMonster4.eyeless_080p", 34, 35, 83, "male", "L2Monster", 40, 12120, 2011, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 28643, 2982, 9532, 1455, 3955, 1154, 278, 370, 333, 0, 0, 0, 60, 200, "NULL", 0, 0, 0, "LAST_HIT", 0, 0, 0, "fighter", "false"),
(22325, 22325, "Blind Watchman", 0, "", 0, "LineageMonster4.eyeless_080p", 34, 35, 83, "male", "L2Monster", 40, 12120, 2011, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 25715, 2666, 9532, 1455, 3955, 1154, 278, 370, 333, 0, 0, 0, 60, 200, "NULL", 0, 0, 0, "LAST_HIT", 0, 0, 0, "mage", "false"),
(22326, 22326, "Hellinark", 0, "Naia's Guardian", 0, "LineageMonster.karik", 19, 35, 1, "male", "L2Monster", 40, 2444, 2444, 0, 0, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 253, 0, 253, 0, 0, NULL, 80, 120, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false"),
(22327, 22327, "Arcane Scout", 0, "", 0, "LineageMonster.dark_mahum", 13, 26, 83, "male", "L2Monster", 40, 103599, 2444, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 320391, 34598, 23356, 1220, 6250, 1034, 278, 500, 333, 234, 0, NULL, 50, 160, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "fighter", "false"),
(22328, 22328, "Arcane Guardian", 0, "", 0, "LineageMonster3.Succubus_Raid", 12, 30.7, 83, "male", "L2Monster", 40, 51799, 2444, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 135761, 14070, 12532, 1055, 4855, 954, 278, 420, 333, 0, 0, NULL, 60, 170, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "mage", "false"),
(22329, 22329, "Arcane Watchman", 0, "", 0, "LineageMonster3.Death_Blader_Raid", 15, 32.5, 83, "male", "L2Monster", 40, 103599, 2444, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 330999, 35954, 23356, 1220, 6250, 1034, 278, 500, 333, 0, 0, NULL, 60, 170, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false"),
(22330, 22330, "Remnant Wraith", 0, "", 0, "LineageMonster3.zombie_laborer", 11, 28.5, 83, "male", "L2Monster", 40, 6060, 2444, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 17814, 1922, 2933, 717, 1755, 654, 253, 420, 253, 0, 0, NULL, 80, 120, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "fighter", "false"),
(22334, 22334, "Sand Scorpion", 0, "", 0, "LineageMonster2.sandScorpion", 28, 66, 1, "male", "L2Monster", 40, 2444, 2444, 0, 0, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 278, 0, 333, 0, 0, NULL, 37, 170, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false"),
(22335, 22335, "Desert Scorpion", 0, "", 0, "LineageMonster2.sandScorpion", 28, 66, 84, "male", "L2Monster", 40, 51736, 2444, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 151636, 16036, 12532, 1855, 4855, 1154, 278, 420, 333, 0, 0, NULL, 37, 170, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "fighter", "false"),
(22336, 22336, "Sand Devil", 0, "", 0, "LineageMonster2.imperial_warlord_zombie_sand", 7, 30, 84, "male", "L2Monster", 40, 17245, 2444, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 49859, 5317, 4532, 1055, 1955, 854, 278, 420, 333, 0, 0, NULL, 39, 150, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "fighter", "false"),
(22337, 22337, "Desiccator", 0, "", 0, "LineageMonster.skeleton_knight_sand", 10, 25, 84, "male", "L2Monster", 40, 17245, 2444, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 47145, 5029, 4533, 1055, 1955, 854, 278, 420, 333, 0, 0, NULL, 40, 160, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "mage", "false"),
(22339, 22339, "Wandering Caravan", 0, "", 0, "LineageMonster4.Caravan", 33, 58.5, 84, "male", "L2Monster", 40, 6381, 2444, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 18810, 2005, 2933, 717, 1755, 654, 278, 420, 333, 0, 0, NULL, 56, 160, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "fighter", "false"),
(22340, 22340, "Sandstorm", 0, "", 0, "LineageMonster4.SandTourbillon", 10, 28, 84, "male", "L2Monster", 40, 51736, 2444, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 146852, 15665, 12532, 1055, 4855, 954, 278, 420, 333, 0, 0, NULL, 180, 250, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false"),
(22341, 22341, "Keltas", 0, "", 0, "LineageMonster3.Vampire_Troop_Leader", 19, 35, 1, "male", "L2Monster", 40, 2444, 2444, 0, 0, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 253, 0, 253, 0, 0, NULL, 80, 120, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false"),
(22342, 22342, "Darion's Enforcer", 0, "", 0, "LineageMonster.silhouette", 32, 35, 84, "female", "L2Monster", 40, 6381, 2444, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 12424, 1325, 2943, 717, 1500, 634, 253, 420, 253, 0, 0, NULL, 80, 120, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "fighter", "false"),
(22343, 22343, "Darion's Executioner", 0, "", 0, "LineageMonster.shadeless", 32, 35, 84, "male", "L2Monster", 40, 6381, 2444, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 9996, 1065, 2943, 717, 1500, 634, 253, 420, 253, 0, 0, NULL, 80, 120, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "mage", "false"),
(22344, 22344, "Quarry Supervior", 0, "", 0, "LineageMonster2.vampire_warrior", 9, 31.5, 1, "male", "L2Monster", 40, 2444, 2444, 0, 0, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 278, 0, 333, 6723, 0, NULL, 43, 165, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false"),
(22345, 22345, "Quarry Bowman", 0, "", 0, "LineageMonster2.vampire_wizard", 5.5, 28, 84, "female", "L2Monster", 40, 8622, 2444, 56.86, 3.09, 40, 43, 30, 21, 20, 10, 22388, 2302, 500, 500, 500, 500, 278, 0, 333, 99, 0, NULL, 46, 165, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "mage", "false"),
(22346, 22346, "Quarry Foreman", 0, "", 0, "LineageMonster3.Vampire_Troop_Leader_120p", 22, 43, 1, "male", "L2Monster", 40, 2444, 2444, 0, 0, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 278, 0, 333, 8686, 0, NULL, 60, 165, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false"),
(22347, 22347, "Quarry Patrolman", 0, "", 0, "LineageMonster4.eyeless_080p", 34, 35, 1, "male", "L2Monster", 40, 2444, 2444, 0, 0, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 278, 0, 333, 0, 0, NULL, 60, 210, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false"),
(22349, 22349, "Chimera of Earth", 0, "", 0, "LineageMonster4.Chimera", 35, 36, 1, "male", "L2Monster", 40, 2444, 2444, 0, 0, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 253, 0, 253, 0, 0, NULL, 80, 120, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false");


/************ 地獄邊界 NPC 掉落物品修正 (gto提供) ************/
DELETE FROM `droplist` where `mobId`='22288';
DELETE FROM `droplist` where `mobId`='22320';
DELETE FROM `droplist` where `mobId`='22321';
DELETE FROM `droplist` where `mobId`='22324';
DELETE FROM `droplist` where `mobId`='22325';
DELETE FROM `droplist` where `mobId`='22327';
DELETE FROM `droplist` where `mobId`='22328';
DELETE FROM `droplist` where `mobId`='22329';
DELETE FROM `droplist` where `mobId`='22330';
DELETE FROM `droplist` where `mobId`='22335';
DELETE FROM `droplist` where `mobId`='22336';
DELETE FROM `droplist` where `mobId`='22337';
DELETE FROM `droplist` where `mobId`='22339';
DELETE FROM `droplist` where `mobId`='22340';
DELETE FROM `droplist` where `mobId`='22342';
DELETE FROM `droplist` where `mobId`='22343';
INSERT INTO `droplist` VALUES
(22288,57,6113,9156,0,700000), -- Adena
(22288,1868,9,9,2,133000), -- Thread
(22288,1873,3,6,2,250000), -- Silver Nugget
(22288,1876,1,1,2,133000), -- Mithril Ore
(22320,9599,1,3,1,730000), -- Ancient Tome of the Demon
(22320,57,16450,32970,0,700000), -- Adena
(22320,1895,1,3,1,250000), -- Metallic Fiber
(22320,9674,1,1,1,100000), -- Darion's Badge
(22320,4040,1,1,1,38461), -- Mold Lubricant
(22320,5522,1,1,2,11363), -- Sealed Armor of Nightmare Pattern
(22320,9628,1,1,1,10753), -- Leonard
(22320,5523,1,1,2,9901), -- Sealed Majestic Plate Armor Pattern
(22320,9630,1,1,1,5747), -- Orichalcum
(22320,9551,1,1,200,4854), -- Divine Stone
(22320,12262,1,1,2,1024), -- Common Item - Sealed Majestic Plate Armor
(22320,12270,1,1,2,1024), -- Common Item - Sealed Armor of Nightmare
(22320,1895,1,23,-1,243333), -- Metallic Fiber
(22320,4040,1,2,-1,203333), -- Mold Lubricant
(22320,960,1,1,-1,5069), -- Scroll: Enchant Armor S
(22320,4034,1,1,2,2000),
(22321,57,15780,31650,0,700000), -- Adena
(22321,9599,1,3,1,690000), -- Ancient Tome of the Demon
(22321,1885,1,1,1,111111), -- High Grade Suede
(22321,1871,9,27,1,83333), -- Charcoal
(22321,9674,1,1,1,66667), -- Darion's Badge
(22321,5220,1,1,1,58824), -- Metal Hardener
(22321,1866,14,42,1,40000), -- Suede
(22321,1344,805,2394,2,22723), -- Mithril Arrow
(22321,5487,1,1,2,15152), -- Sealed Nightmare Robe Fabric
(22321,9488,1,1,2,15152), -- Sealed Majestic Robe Fabric
(22321,4041,1,1,1,11904), -- Mold Hardener
(22321,9551,1,1,200,4505), -- Divine Stone
(22321,960,1,1,2,588), -- Scroll: Enchant Armor S
(22321,12259,1,1,2,1256), -- Common Item - Sealed Majestic Robe
(22321,12266,1,1,2,1256), -- Common Item - Sealed Nightmare Robe
(22321,6698,1,2,-1,12635), -- Sealed Tateossian Earring Part
(22321,6699,1,2,-1,12635), -- Sealed Tateossian Ring Gem
(22321,6901,1,1,-1,8223), -- Recipe: Shining Arrow(100%)
(22321,4034,1,1,2,2000),
(22324,57,3249,6516,0,700000), -- Adena
(22324,9599,1,1,1,333333), -- Ancient Tome of the Demon
(22324,1873,1,1,1,142857), -- Silver Nugget
(22324,1864,4,12,1,83333), -- Stem
(22324,1865,2,6,1,62500), -- Varnish
(22324,1866,3,9,1,35714), -- Suede
(22324,1868,10,30,1,33333), -- Thread
(22324,9674,1,1,1,15873), -- Darion's Badge
(22324,5495,1,1,2,8000), -- Sealed Shield of Nightmare Fragment
(22324,5528,1,1,2,8000), -- Sealed Majestic Circlet Design
(22324,5527,1,1,2,8000), -- Sealed Helm of Nightmare Design
(22324,9551,1,1,200,1961), -- Divine Stone
(22324,12268,1,1,2,1206), -- Common Item - Sealed Shield of Nightmare
(22324,12261,1,1,2,903), -- Common Item - Sealed Majestic Circlet
(22324,960,1,1,2,302), -- Scroll: Enchant Armor S
(22324,12269,1,1,2,151), -- Common Item - Sealed Helm of Nightmare
(22324,6702,1,1,-1,10000), -- Sealed Imperial Crusader Gaiters Pattern
(22324,6901,1,1,-1,2000), -- Recipe: Shining Arrow(100%)
(22324,4034,1,1,2,2000),
(22325,57,2915,5843,0,700000), -- Adena
(22325,9599,1,1,1,250000), -- Ancient Tome of the Demon
(22325,1867,1,3,1,125000), -- Animal Skin
(22325,9674,1,1,1,100000), -- Darion's Badge
(22325,1344,40,120,2,0909), -- Mithril Arrow
(22325,1869,2,6,1,55555), -- Iron Ore
(22325,1870,3,9,1,45455), -- Coal
(22325,1871,3,9,1,37037), -- Charcoal
(22325,1872,8,24,1,17857), -- Animal Bone
(22325,5495,1,1,2,9090), -- Sealed Shield of Nightmare Fragment
(22325,5528,1,1,2,9090), -- Sealed Majestic Circlet Design
(22325,5527,1,1,2,9090), -- Sealed Helm of Nightmare Design
(22325,9551,1,1,200,772), -- Divine Stone
(22325,6901,1,1,2,154), -- Recipe: Shining Arrow(100%)
(22325,12261,1,1,2,926), -- Common Item - Sealed Majestic Circlet
(22325,12269,1,1,2,463), -- Common Item - Sealed Helm of Nightmare
(22325,12268,1,1,2,309), -- Common Item - Sealed Shield of Nightmare
(22325,6703,1,2,-1,12500), -- Sealed Imperial Crusader Gauntlets Design
(22325,960,1,2,-1,417), -- Scroll: Enchant Armor S
(22325,4034,1,1,2,2000),
(22327,57,32200,64540,0,700000), -- Adena
(22327,9599,2,6,1,690000), -- Ancient Tome of the Demon
(22327,1895,3,9,1,166667), -- Metallic Fiber
(22327,1868,204,587,1,20000), -- Thread
(22327,1876,4,12,1,83333), -- Mithril Ore
(22327,4042,1,1,1,62500), -- Enria
(22327,1344,1515,4496,2,25000), -- Mithril Arrow
(22327,1873,18,54,1,32258), -- Silver Nugget
(22327,9674,26,75,1,28571), -- Darion's Badge
(22327,5544,1,1,2,3676), -- Branch of the Mother Tree Head
(22327,5533,1,1,2,3676), -- Elysian Head
(22327,8342,1,1,2,3676), -- Flaming Dragon Skull Piece
(22327,8349,1,1,2,3676), -- Doom Crusher Head
(22327,9551,1,1,200,22727), -- Divine Stone
(22327,960,1,2,-1,12635), -- Scroll: Enchant Armor S
(22327,11970,1,1,2,620), -- Common Item - Branch of the Mother Tree
(22327,11974,1,1,2,620), -- Common Item - Elysian
(22327,11966,1,1,2,155), -- Common Item - Doom Crusher
(22327,11969,1,1,2,155), -- Common Item - Flaming Dragon Skull
(22327,6706,1,1,-1,18870), -- Sealed Imperial Crusader Helmet Pattern
(22327,6705,1,1,-1,18870), -- Sealed Imperial Crusader Shield Part
(22327,6901,1,1,-1,1258), -- Recipe: Shining Arrow(100%)
(22327,4034,1,1,2,2000),
(22328,57,13010,26070,0,700000), -- Adena
(22328,9599,1,3,1,600000), -- Ancient Tome of the Demon
(22328,9674,1,3,1,166667), -- Darion's Badge
(22328,1879,1,1,1,142857), -- Cokes
(22328,1885,1,1,1,100000), -- High Grade Suede
(22328,5538,1,1,2,22222), -- Dragon Grinder Edge
(22328,9551,1,1,200,19608), -- Divine Stone
(22328,9629,1,1,1,12658), -- Adamantine
(22328,9628,1,1,1,6711), -- Leonard
(22328,9630,1,1,1,6135), -- Orichalcum
(22328,9574,1,1,200,6135), -- Mid-Grade Life Stone: level 80
(22328,11967,1,1,2,5155), -- Common Item - Dragon Grinder
(22328,9573,1,1,200,2882), -- Life Stone: level 80
(22328,6901,1,1,2,240), -- Recipe: Shining Arrow(100%)
(22328,9575,1,1,200,120), -- High-Grade Life Stone: level 80
(22328,1344,60,180,2,16667), -- Mithril Arrow
(22328,270,1,1,2,100), -- Dragon Grinder
(22328,1885,1,7,-1,20408), -- High Grade Suede
(22328,4034,1,1,2,2000),
(22329,57,33230,66640,0,700000), -- Adena
(22329,9599,2,6,1,660000), -- Ancient Tome of the Demon
(22329,1344,363,1079,2,125000), -- Mithril Arrow
(22329,9674,15,42,1,52632), -- Darion's Badge
(22329,4040,1,1,1,76923), -- Mold Lubricant
(22329,9551,1,1,200,35714), -- Divine Stone
(22329,1895,22,60,1,35714), -- Metallic Fiber
(22329,5534,1,1,2,27027), -- Soul Bow Stave
(22329,9628,1,1,1,22727), -- Leonard
(22329,9630,1,1,1,13889), -- Orichalcum
(22329,11975,1,1,2,4608), -- Common Item - Soul Bow
(22329,959,1,1,2,3071), -- Scroll: Enchant Weapon S
(22329,289,1,1,2,1870), -- Soul Bow
(22329,6708,1,1,-1,13514), -- Sealed Draconic Leather Gloves Fabric
(22329,6707,1,1,-1,3378), -- Sealed Draconic Leather Armor Part
(22329,6901,1,1,-1,563), -- Recipe: Shining Arrow(100%)
(22329,4034,1,1,2,2000),
(22330,57,2045,4100,0,700000), -- Adena
(22330,9599,1,1,1,166667), -- Ancient Tome of the Demon
(22330,1879,1,1,1,25641), -- Cokes
(22330,1885,1,1,1,12658), -- High Grade Suede
(22330,5537,1,1,2,1915), -- Soul Separator Head
(22330,9628,1,1,1,1675), -- Leonard
(22330,9573,1,1,200,1196), -- Life Stone: level 80
(22330,9630,1,1,1,718), -- Orichalcum
(22330,11973,1,1,2,478), -- Common Item - Soul Separator
(22330,9574,1,1,200,323), -- Mid-Grade Life Stone: level 80
(22330,9629,1,1,1,239), -- Adamantine
(22330,960,1,1,2,239), -- Scroll: Enchant Armor S
(22330,9575,1,1,200,213), -- High-Grade Life Stone: level 80
(22330,9551,1,1,200,323), -- Divine Stone
(22330,6901,1,1,-1,4082), -- Recipe: Shining Arrow(100%)
(22330,1344,1,1,-1,28571), -- Sealed Draconic Leather Boots Design
(22330,960,1,1,-1,461), -- Scroll: Enchant Armor S
(22330,4034,1,1,2,2000),
(22335,57,13130,26250,0,700000), -- Adena
(22335,9599,1,3,1,570000), -- Ancient Tome of the Demon
(22335,1873,2,6,1,142857), -- Silver Nugget
(22335,1868,15,45,1,90909), -- Thread
(22335,1895,3,9,1,58824), -- Metallic Fiber
(22335,1876,3,9,1,45454), -- Mithril Ore
(22335,10012,4,12,1,35714), -- Scorpion Poison Stinger
(22335,4042,1,1,1,19231), -- Enria
(22335,5488,1,1,2,13699), -- Sealed Majestic Robe Fabric
(22335,9549,1,1,200,12987), -- Wind Stone
(22335,5487,1,1,2,10309), -- Sealed Nightmare Robe Fabric
(22335,12259,1,1,2,1818), -- Common Item - Sealed Majestic Robe
(22335,12266,1,1,2,1818), -- Common Item - Sealed Nightmare Robe
(22335,6714,1,1,-1,45454), -- Sealed Major Arcana Circlet Pattern
(22335,6901,1,1,-1,2020), -- Recipe: Shining Arrow(100%)
(22335,7579,1,1,-1,6494), -- Draconic Bow Shaft
(22335,4034,1,1,2,2000),
(22336,57,4750,8405,0,700000), -- Adena
(22336,9599,1,1,1,250000), -- Ancient Tome of the Demon
(22336,1895,1,1,1,200000), -- Metallic Fiber
(22336,1344,47,63,2,166667), -- Mithril Arrow
(22336,1868,4,4,1,52632), -- Thread
(22336,1876,1,1,1,52632), -- Mithril Ore
(22336,5488,1,1,2,52632), -- Sealed Majestic Necklace Beads
(22336,1895,2,4,-1,53846), -- Metallic Fiber
(22336,4034,1,1,2,2000),
(22337,57,4087,8156,0,700000), -- Adena
(22337,9599,1,1,1,333333), -- Ancient Tome of the Demon
(22337,1871,1,3,1,200000), -- Charcoal
(22337,1866,1,3,1,90909), -- Suede
(22337,1877,1,1,1,14925), -- Adamantite Nugget
(22337,4040,1,1,1,14925), -- Mold Lubricant
(22337,5515,1,1,2,6803), -- Sealed Majestic Gauntlets Design
(22337,5502,1,1,2,5435), -- Sealed Boots of Nightmare Lining
(22337,5503,1,1,2,5435), -- Sealed Majestic Boots Lining
(22337,12260,1,1,2,5435), -- Common Item - Sealed Majestic Boots
(22337,5514,1,1,2,4082), -- Sealed Gauntlets of Nightmare Design
(22337,4041,1,1,1,2725), -- Mold Hardener
(22337,12264,1,1,2,1362), -- Common Item - Sealed Gauntlet of Nightmare
(22337,9549,1,1,200,1362), -- Wind Stone
(22337,12267,1,1,2,1362), -- Common Item - Sealed Boots of Nightmare
(22337,12257,1,1,2,1362), -- Common Item - Sealed Majestic Gauntlet
(22337,6901,1,1,2,1362), -- Recipe: Shining Arrow(100%)
(22337,4034,1,1,2,2000),
(22339,57,2115,4227,0,700000), -- Adena
(22339,9599,1,1,1,166667), -- Ancient Tome of the Demon
(22339,1879,1,1,1,40000), -- Cokes
(22339,1885,1,1,1,24390), -- High Grade Suede
(22339,9676,1,1,1,14286), -- Mark of Betrayal
(22339,9628,1,1,1,3401), -- Leonard
(22339,9630,1,1,1,2725), -- Orichalcum
(22339,5529,1,1,2,2387), -- Dragon Slayer Edge
(22339,9629,1,1,1,2045), -- Adamantine
(22339,5545,1,1,2,1704), -- Dark Legion's Edge Blade
(22339,5546,1,1,2,1021), -- Sword of Miracles Edge
(22339,11964,1,1,2,0341), -- Common Item - Dark Legion
(22339,960,1,1,2,0212), -- Scroll: Enchant Armor S
(22339,1885,1,2,-1,10929), -- High Grade Suede
(22339,8715,1,1,-1,3643), -- Behemoth's Tuning Fork Piece
(22339,4034,1,1,2,2000),
(22340,57,13260,25410,0,700000), -- Adena
(22340,9599,1,3,1,510000), -- Ancient Tome of the Demon
(22340,1895,1,3,1,250000), -- Metallic Fiber
(22340,4040,1,1,1,60000), -- Mold Lubricant
(22340,9628,1,1,1,20000), -- Leonard
(22340,9549,1,1,200,20000), -- Wind Stone
(22340,8349,1,1,2,20000), -- Doom Crusher Head
(22340,9630,1,1,1,10000), -- Orichalcum
(22340,5533,1,1,2,10000), -- Elysian Head
(22340,8342,1,1,2,10000), -- Flaming Dragon Skull Piece
(22340,8716,1,1,-1,55555), -- Naga Storm Piece
(22340,6901,1,1,-1,27778), -- Recipe: Shining Arrow(100%)
(22340,4034,1,1,2,2000),
(22342,57,1420,2621,0,700000), -- Adena
(22342,9599,1,1,1,125000), -- Ancient Tome of the Demon
(22342,1344,11,28,2,500000), -- Mithril Arrow
(22342,9674,1,1,1,50000), -- Darion's Badge
(22342,1894,1,1,1,8850), -- Crafted Leather
(22342,4044,1,1,1,6329), -- Thons
(22342,4039,1,1,1,5076), -- Mold Glue
(22342,5537,1,1,2,3802), -- Soul Separator Head
(22342,4041,1,1,1,0422), -- Mold Hardener
(22342,9549,1,1,200,0422), -- Wind Stone
(22342,960,1,1,2,0422), -- Scroll: Enchant Armor S
(22343,57,1185,2236,0,700000), -- Adena
(22343,9599,1,1,1,125000), -- Ancient Tome of the Demon
(22343,1344,1,1,1,333333), -- Thread
(22343,9674,1,1,1,5917), -- Darion's Badge
(22343,1894,1,1,1,50000), -- Silver Nugget
(22343,4044,1,1,1,11364), -- Metallic Thread
(22343,4039,1,1,1,8475), -- Compound Braid
(22343,5537,1,1,1,5051), -- Thons
(22343,4034,1,1,2,2000),
(22343,4041,1,1,2,1686); -- Dragon Grinder Edge


/************ 赤紅座龍 修正 (gto提供) ************/
DELETE FROM npc WHERE id IN ( 16038,16039,16040 );
INSERT INTO `npc` VALUES
(16038, 16038, "Red Wind Strider", 0, "", 0, "Monster.strider", 8, 29, 70, "male", "L2Npc", 40, 2444, 2444, 0, 0, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 278, 0, 333, 0, 0, NULL, 60, 60, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false"),
(16039, 16039, "Red Star Strider", 0, "", 0, "Monster.strider", 8, 29, 70, "male", "L2Npc", 40, 2444, 2444, 0, 0, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 278, 0, 333, 0, 0, NULL, 60, 60, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false"),
(16040, 16040, "Red Twilight Strider", 0, "", 0, "Monster.strider", 8, 29, 70, "male", "L2Npc", 40, 2444, 2444, 0, 0, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 278, 0, 333, 0, 0, NULL, 60, 60, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false");


/************ 增加貓熊手鐲 ************/
Delete From armor Where item_id in (20063,20064,20065,20066,20067,20068);
INSERT INTO `armor` VALUES ('20063', 'Agathion Seal Bracelet - Baby Panda', 'lbracelet', 'false', 'none', '150', 'wood', 'none', '0', '-1', '0', '0', '0', '0', '0', 'true', 'true', 'true', 'true', '0-0;');
INSERT INTO `armor` VALUES ('20064', 'Agathion Seal Bracelet - Bamboo Panda', 'lbracelet', 'false', 'none', '150', 'wood', 'none', '0', '-1', '0', '0', '0', '0', '0', 'true', 'true', 'true', 'true', '0-0;');
INSERT INTO `armor` VALUES ('20065', 'Agathion Seal Bracelet - Sexy Panda', 'lbracelet', 'false', 'none', '150', 'wood', 'none', '0', '-1', '0', '0', '0', '0', '0', 'true', 'true', 'true', 'true', '0-0;');
INSERT INTO `armor` VALUES ('20066', 'Agathion Seal Bracelet - Baby Panda - Big Head 15-day limited period', 'lbracelet', 'false', 'none', '150', 'wood', 'none', '0', '21600', '0', '0', '0', '0', '0', 'true', 'true', 'true', 'true', '0-0;');
INSERT INTO `armor` VALUES ('20067', 'Agathion Seal Bracelet - Bamboo Panda - Resurrection 15-day limited period', 'lbracelet', 'false', 'none', '150', 'wood', 'none', '0', '21600', '0', '0', '0', '0', '0', 'true', 'true', 'true', 'true', '0-0;');
INSERT INTO `armor` VALUES ('20068', 'Agathion Seal Bracelet - Sexy Panda - Escape 15-day limited period', 'lbracelet', 'false', 'none', '150', 'wood', 'none', '0', '21600', '0', '0', '0', '0', '0', 'true', 'true', 'true', 'true', '0-0;');


/************ 修正要塞/小天使/小惡魔/魯道夫/媽祖/普萊皮塔/貓熊/愛心壺精/淡紫鬃馬騎乘的手鐲 ************/
UPDATE `armor` SET `skill` = '3361-1;3267-1;5458-1;' WHERE `item_id` in (9909);
UPDATE `armor` SET `skill` = '3361-1;3267-1;5458-1;' WHERE `item_id` in (10018);
UPDATE `armor` SET `skill` = '3269-1;3267-1;5414-1;' WHERE `item_id` in (10139);
UPDATE `armor` SET `skill` = '3423-1;3267-1;5535-1;' WHERE `item_id` in (10320);
UPDATE `armor` SET `skill` = '3424-1;3267-1;5536-1;' WHERE `item_id` in (10326);
UPDATE `armor` SET `skill` = '3425-1;3267-1;5537-1;' WHERE `item_id` in (10606);
UPDATE `armor` SET `skill` = '3423-1;3267-1;5535-1;' WHERE `item_id` in (12779);
UPDATE `armor` SET `skill` = '3424-1;3267-1;5536-1;' WHERE `item_id` in (12780);
UPDATE `armor` SET `skill` = '8247-1;' WHERE `item_id` in (13022,13308,20029,20030);
UPDATE `armor` SET `skill` = '8245-1;3267-1;' WHERE `item_id` in (13023,13254,13309,13340);
UPDATE `armor` SET `skill` = '21000-1;3267-1;23000-1;' WHERE `item_id` in (20006);
UPDATE `armor` SET `skill` = '21001-1;3267-1;23001-1;' WHERE `item_id` in (20007);
UPDATE `armor` SET `skill` = '21002-1;3267-1;23002-1;' WHERE `item_id` in (20008);
UPDATE `armor` SET `skill` = '21003-1;3267-1;23003-1;' WHERE `item_id` in (20012);
UPDATE `armor` SET `skill` = '21008-1;3267-1;23010-1' WHERE `item_id` in (20063);
UPDATE `armor` SET `skill` = '21009-1;3267-1;23011-1' WHERE `item_id` in (20064);
UPDATE `armor` SET `skill` = '21010-1;3267-1;23012-1' WHERE `item_id` in (20065);


/************ 增加淡紫鬃馬(參考L2J論壇) ************/
Delete From npc Where `id` ='13130';
INSERT INTO `npc` VALUES
(13130, 13130, "Light Purple Maned Horse", 0, "", 0, "Monster.horse", 8, 32.8, 70, "male", "L2Npc", 40, 2444, 2444, 0, 0, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 278, 0, 333, 0, 0, NULL, 60, 60, "", 0, 0, 0, "LAST_HIT", 0, 0, 0, "balanced", "false");


/************ 增加土著全套變身技能 ************/
Delete From armorsets Where id in (79);
INSERT INTO `armorsets` VALUES ('79', '9670', '9671', '9669', '0', '0', '3359', '1', '0', '0', '0');


/************ 增加頭飾的附加技能(祝福復活/祝福返回/大頭/煙火) ************/
UPDATE `armor` SET `skill` = '3263-1;' WHERE `item_id` in (9177,9178,9179,9180,9181,9182,9183,10621,10625,10629);
UPDATE `armor` SET `skill` = '3264-1;' WHERE `item_id` in (9184,9185,9186,9187,9188,9189,9190,10620,10624,10628);
UPDATE `armor` SET `skill` = '3265-1;' WHERE `item_id` in (9191,9192,9193,9194,9195,9196,9197,10623,10627,10631);
UPDATE `armor` SET `skill` = '3266-1;' WHERE `item_id` in (9198,9199,9200,9201,9202,9203,9204,9890,9891,9892,9893,9894,9895,9896,10622,10626,10630);
UPDATE `armor` SET `skill` = '21005-3;' WHERE `item_id` in (20016);
UPDATE `armor` SET `skill` = '21006-1;21007-1;' WHERE `item_id` in (20018);
UPDATE `armor` SET `skill` = '21004-1;' WHERE `item_id` in (20019);


/************ 增加壺精的附加技能(祝福復活/祝福返回/大頭/煙火) ************/
ALTER TABLE `items` CHANGE `mana_left` `mana_left` decimal(10,0) NOT NULL default -1;
UPDATE `armor` SET `skill` = '3423-1;3267-1;5538-1;' WHERE `item_id` in (10316);
UPDATE `armor` SET `skill` = '3423-1;3267-1;5539-1;' WHERE `item_id` in (10317);
UPDATE `armor` SET `skill` = '3423-1;3267-1;5540-1;' WHERE `item_id` in (10318);
UPDATE `armor` SET `skill` = '3423-1;3267-1;5541-1;' WHERE `item_id` in (10319);
UPDATE `armor` SET `skill` = '3424-1;3267-1;5542-1;' WHERE `item_id` in (10322);
UPDATE `armor` SET `skill` = '3424-1;3267-1;5543-1;' WHERE `item_id` in (10323);
UPDATE `armor` SET `skill` = '3424-1;3267-1;5544-1;' WHERE `item_id` in (10324);
UPDATE `armor` SET `skill` = '3424-1;3267-1;5545-1;' WHERE `item_id` in (10325);
UPDATE `armor` SET `skill` = '21000-1;3267-1;23000-1;23004-1;' WHERE `item_id` in (20009);
UPDATE `armor` SET `skill` = '21001-1;3267-1;23001-1;23005-1;' WHERE `item_id` in (20010);
UPDATE `armor` SET `skill` = '21002-1;3267-1;23002-1;23006-1;' WHERE `item_id` in (20011);
UPDATE `armor` SET `skill` = '21003-1;3267-1;23003-1;23007-1;' WHERE `item_id` in (20013);
UPDATE `armor` SET `skill` = '21003-1;3267-1;23003-1;23009-1;' WHERE `item_id` in (20014);
UPDATE `armor` SET `skill` = '21003-1;3267-1;23003-1;23008-1;' WHERE `item_id` in (20015);
UPDATE `armor` SET `skill` = '21008-1;3267-1;23010-1;23013-1;' WHERE `item_id` in (20066);
UPDATE `armor` SET `skill` = '21008-1;3267-1;23011-1;23014-1;' WHERE `item_id` in (20067);
UPDATE `armor` SET `skill` = '21010-1;3267-1;23012-1;23015-1;' WHERE `item_id` in (20068);


/************ 增加道具的變身技能 ************/
UPDATE `armor` SET `skill` = '3335-1;' WHERE `item_id` in (10141); -- 雪人變身
UPDATE `armor` SET `skill` = '3336-1;' WHERE `item_id` in (10142); -- 野牛變身
UPDATE `weapon` SET `skill` = '3418-1;' WHERE `item_id` in (10167); -- 豬豬塔糖
-- UPDATE `weapon` SET `skill` = '8244-1;' WHERE `item_id` in (12814); -- 守門人變身魔杖
-- UPDATE `weapon` SET `skill` = '8246-1;' WHERE `item_id` in (12800,13253,13324,13339); -- 南瓜變身魔杖


/************ 增加/修改/刪除NPC ************/
Delete From spawnlist Where `id` in (51369); -- 官服此位置無NPC(活動守門人)
-- 增加NPC維他命管理者
Delete From spawnlist Where `npc_templateid` in (32478);
INSERT INTO `spawnlist` VALUES ('810001', '', '1', '32478', '47597', '49924', '-2995', '0', '0', '33231', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810002', '', '1', '32478', '13432', '17255', '-4574', '0', '0', '46871', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810003', '', '1', '32478', '115020', '-179727', '-879', '0', '0', '0', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810004', '', '1', '32478', '-82374', '153659', '-3177', '0', '0', '16383', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810005', '', '1', '32478', '-43721', '-113474', '-239', '0', '0', '32767', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810006', '', '1', '32478', '-115213', '45057', '502', '0', '0', '32408', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810007', '', '1', '32478', '-81926', '243372', '-3730', '0', '0', '38436', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810008', '', '1', '32478', '-13236', '124615', '-3126', '0', '0', '49151', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810009', '', '1', '32478', '20556', '144776', '-3080', '0', '0', '32767', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810010', '', '1', '32478', '17735', '169802', '-3495', '0', '0', '19465', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810011', '', '1', '32478', '82675', '146736', '-3466', '0', '0', '32767', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810012', '', '1', '32478', '109951', '220614', '-3479', '0', '0', '16383', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810013', '', '1', '32478', '55379', '220614', '-1527', '0', '0', '16383', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810014', '', '1', '32478', '81782', '55399', '-1529', '0', '0', '16383', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810015', '', '1', '32478', '115650', '76613', '-2668', '0', '0', '58618', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810016', '', '1', '32478', '148411', '26581', '-2207', '0', '0', '16094', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810017', '', '1', '32478', '43569', '-48972', '-796', '0', '0', '1843', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810018', '', '1', '32478', '146141', '-57893', '-2983', '0', '0', '44315', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('810019', '', '1', '32478', '88934', '-140814', '-1539', '0', '0', '11547', '60', '0', '0');
-- 修正NPC ID
UPDATE `spawnlist` SET `npc_templateid` = '35440' WHERE `id` ='33771'; -- 丹尼爾(根據地守門人)
-- 刪除不存在的NPC
Delete From `spawnlist` Where `npc_templateid` in (30880,30881,30882,30883,30884,30885,30886,30887,30888,30889);
-- 修正NPC位置
Delete From spawnlist Where `id` in (33177,33178,33472,33485,33594,33613,33614,33628,33635,51230,51231,51232);
INSERT INTO `spawnlist` VALUES ('33177', 'dion05_npc2021_02', '1', '30484', '17530', '113970', '-11672', '0', '0', '16384', '60', '0', '0'); -- 潘帝娜(克塔1樓守門人)
INSERT INTO `spawnlist` VALUES ('33178', 'dion05_npc2021_03', '1', '30487', '17898', '113953', '-11672', '0', '0', '16384', '60', '0', '0'); -- 貝內(克塔1樓守門人)
INSERT INTO `spawnlist` VALUES ('33472', 'oren16_npc2218_016', '1', '31605', '85692', '16400', '-2803', '0', '0', '38000', '60', '0', '0'); -- 金斯雷(象牙塔)
INSERT INTO `spawnlist` VALUES ('33485', 'oren17_npc2219_009', '1', '30676', '81655', '54737', '-1509', '0', '0', '24576', '60', '0', '0'); -- 庫羅普(歐瑞倉庫)
INSERT INTO `spawnlist` VALUES ('33594', 'innadril09_npc2324_23', '1', '31092', '114486', '217413', '-3631', '0', '0', '0', '60', '0', '0'); -- 財富的地下商人(水上都市海音斯)
INSERT INTO `spawnlist` VALUES ('33613', 'aden17_npc2317_01', '1', '31675', '111186', '-13261', '-1702', '0', '0', '13828', '60', '0', '0'); -- 維克特 馮 德伊克(國境守備隊隊長)
INSERT INTO `spawnlist` VALUES ('33614', 'aden17_npc2317_02', '1', '31679', '111532', '-17238', '-1702', '0', '0', '49586', '60', '0', '0'); -- 尤斯特斯 馮 伊森(邊境警備隊隊長)
INSERT INTO `spawnlist` VALUES ('33628', 'aden17_npc2317_03', '1', '31677', '111532', '-13266', '-1704', '0', '0', '14508', '60', '0', '0'); -- 國境守備隊員
INSERT INTO `spawnlist` VALUES ('33635', 'aden17_npc2317_03', '1', '31677', '111178', '-17234', '-1702', '0', '0', '46468', '60', '0', '0'); -- 國境守備隊員
INSERT INTO `spawnlist` VALUES ('51230', 'godard02_npc2416_45', '1', '35366', '145715', '-57107', '-2980', '0', '0', '36487', '60', '0', '0'); -- 莊園管理員(高達特城鎮)
INSERT INTO `spawnlist` VALUES ('51231', 'schuttgart', '1', '30767', '85792', '-142809', '-1341', '0', '0', '10508', '60', '0', '0'); -- 拍賣管理者(修加特城鎮)
INSERT INTO `spawnlist` VALUES ('51232', 'schuttgart', '1', '35558', '89344', '-141591', '-1541', '0', '0', '64817', '60', '0', '0'); -- 莊園管理員(修加特城鎮)
-- 加入漏掉的NPC
UPDATE `npc` SET `type` = 'L2Adventurer' WHERE `id` in (32074); -- 修正古魯丁分會長的NPC類型
INSERT INTO `spawnlist` VALUES ('820002', '', '1', '35644', '116178', '-181602', '-1365', '0', '0', '0', '60', '0', '0'); -- 莊園管理員(矮人村莊)
INSERT INTO `spawnlist` VALUES ('820003', '', '1', '35645', '-44159', '-112229', '-239', '0', '0', '39768', '60', '0', '0'); -- 莊園管理員(半獸人村莊)
INSERT INTO `spawnlist` VALUES ('820004', '', '1', '32327', '116934', '77257', '-2694', '0', '0', '40092', '60', '0', '0'); -- 冒險者助手(獵人村莊)
INSERT INTO `spawnlist` VALUES ('820005', '', '1', '32327', '146351', '27386', '-2204', '0', '0', '58824', '60', '0', '0'); -- 冒險者助手(亞丁城鎮)
INSERT INTO `spawnlist` VALUES ('820006', '', '1', '32321', '147271', '28647', '-2268', '0', '0', '53514', '60', '0', '0'); -- 道具仲介商(亞丁城鎮)
INSERT INTO `spawnlist` VALUES ('820008', '', '1', '32327', '148123', '-57006', '-2783', '0', '0', '34065', '60', '0', '0'); -- 冒險者助手(高達特城鎮)
INSERT INTO `spawnlist` VALUES ('820009', '', '1', '32071', '84432', '-144032', '-1538', '0', '0', '8764', '60', '0', '0'); -- 琳達(修加特城鎮)
INSERT INTO `spawnlist` VALUES ('820010', '', '1', '31691', '86123', '-145764', '-1292', '0', '0', '0', '60', '0', '0'); -- 訓練用草人(修加特城鎮的戰士公會)
INSERT INTO `spawnlist` VALUES ('820011', '', '1', '31691', '86123', '-145628', '-1295', '0', '0', '0', '60', '0', '0'); -- 訓練用草人(修加特城鎮的戰士公會)
INSERT INTO `spawnlist` VALUES ('820012', '', '1', '31691', '86123', '-145492', '-1292', '0', '0', '0', '60', '0', '0'); -- 訓練用草人(修加特城鎮的戰士公會)
INSERT INTO `spawnlist` VALUES ('820013', '', '1', '31691', '86123', '-145356', '-1292', '0', '0', '0', '60', '0', '0'); -- 訓練用草人(修加特城鎮的戰士公會)
INSERT INTO `spawnlist` VALUES ('820014', '', '1', '31691', '86123', '-145220', '-1292', '0', '0', '0', '60', '0', '0'); -- 訓練用草人(修加特城鎮的戰士公會)
INSERT INTO `spawnlist` VALUES ('820015', '', '1', '31691', '86315', '-145764', '-1292', '0', '0', '0', '60', '0', '0'); -- 訓練用草人(修加特城鎮的戰士公會)
INSERT INTO `spawnlist` VALUES ('820016', '', '1', '31691', '86315', '-145628', '-1292', '0', '0', '0', '60', '0', '0'); -- 訓練用草人(修加特城鎮的戰士公會)
INSERT INTO `spawnlist` VALUES ('820017', '', '1', '31691', '86315', '-145492', '-1295', '0', '0', '0', '60', '0', '0'); -- 訓練用草人(修加特城鎮的戰士公會)
INSERT INTO `spawnlist` VALUES ('820018', '', '1', '31691', '86315', '-145356', '-1292', '0', '0', '0', '60', '0', '0'); -- 訓練用草人(修加特城鎮的戰士公會)
INSERT INTO `spawnlist` VALUES ('820019', '', '1', '31691', '86315', '-145220', '-1292', '0', '0', '0', '60', '0', '0'); -- 訓練用草人(修加特城鎮的戰士公會)
INSERT INTO `spawnlist` VALUES ('820020', '', '1', '32327', '43568', '-47602', '-796', '0', '0', '43240', '60', '0', '0'); -- 冒險者助手(魯因城鎮)
INSERT INTO `spawnlist` VALUES ('820021', '', '1', '32484', '42668', '-47915', '-796', '0', '0', '52507', '60', '0', '0'); -- 開拓者幹員(魯因城鎮)
INSERT INTO `spawnlist` VALUES ('820022', '', '1', '32271', '153570', '142067', '-9727', '0', '0', '0', '60', '0', '0'); -- 帕爾米
INSERT INTO `spawnlist` VALUES ('820023', '', '1', '32469', '-111520', '41743', '2172', '0', '0', '30892', '60', '0', '0'); -- 艾特伯格 副長老(闇天使村莊)
INSERT INTO `spawnlist` VALUES ('820024', '', '1', '32119', '23707', '-19108', '-2815', '0', '0', '37776', '60', '0', '0'); -- 烏魯 凱莫
INSERT INTO `spawnlist` VALUES ('820025', '', '1', '32120', '27716', '-11685', '-2281', '0', '0', '31470', '60', '0', '0'); -- 巴魯 凱莫
INSERT INTO `spawnlist` VALUES ('820026', '', '1', '32121', '18714', '-9635', '-2790', '0', '0', '54407', '60', '0', '0'); -- 裘太 凱莫
-- 加入新的NPC
Delete From npc Where `id` in (32491,32497,32498,32499,32503,32513,32514,32515,32516); -- 地下競技場助手/調查官 艾德勒/惡魔島的復活者/肯特拉獸人 咒術士/地下競技場的入場管理員
INSERT INTO `npc` VALUES ('32491', '32491', '32491', '0', '', '0', 'LineageNPCs2.TP_battlezone_staff', '7.8', '17.29', '70', 'male', 'L2Teleporter', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '278', '0', '333', '0', '0', '0', '50', '100', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32497', '32497', '32497', '0', '', '1', 'NPC.a_mageguild_teacher_MElf', '7.00', '22.20', '70', 'male', 'L2Npc', '40', '3862', '1493', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '1314', '470', '780', '382', '278', '0', '333', '0', '0', '0', '55', '132', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32498', '32498', '32498', '0', '', '0', 'LineageNPC.a_fighterguild_teacher_MHuman', '8', '23', '70', 'male', 'L2Npc', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '278', '0', '333', '0', '0', '0', '50', '120', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32499', '32499', '32499', '0', '', '0', 'LineageMonster.ketra_orc_shaman_20_bi', '30.00', '23.56', '70', 'male', 'L2Npc', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '253', '0', '253', '0', '0', '0', '80', '120', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32503', '32503', '32503', '0', '', '0', 'LineageNPC.e_smith_master_MDwarf', '8', '17', '1', 'male', 'L2Teleporter', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '253', '0', '253', '0', '0', '0', '80', '120', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32513', '32513', '32513', '0', '', '0', 'LineageNPCs2.TP_battlezone_staff', '7.8', '17.29', '70', 'male', 'L2Teleporter', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '278', '0', '333', '0', '0', '0', '50', '100', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32514', '32514', '32514', '0', '', '0', 'LineageNPCs2.TP_battlezone_staff', '7.8', '17.29', '70', 'male', 'L2Teleporter', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '278', '0', '333', '0', '0', '0', '50', '100', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32515', '32515', '32515', '0', '', '0', 'LineageNPCs2.TP_battlezone_staff', '7.8', '17.29', '70', 'male', 'L2Teleporter', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '278', '0', '333', '0', '0', '0', '50', '100', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32516', '32516', '32516', '0', '', '0', 'LineageNPCs2.TP_battlezone_staff', '7.8', '17.29', '70', 'male', 'L2Teleporter', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '278', '0', '333', '0', '0', '0', '50', '100', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
Delete From `spawnlist` Where `npc_templateid` in (32377); -- 刪除地下競技場重複的入場管理員
INSERT INTO `spawnlist` VALUES ('830001', '', '1', '32491', '-82166', '-49176', '-10341', '0', '0', '31175', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('830002', '', '1', '32497', '-80571', '151295', '-3045', '0', '0', '20607', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('830003', '', '1', '32498', '85093', '147609', '-3404', '0', '0', '49151', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('830004', '', '1', '32499', '143477', '-58989', '-3470', '0', '0', '39607', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('830005', '', '1', '32503', '-70661', '-71066', '-1419', '0', '0', '49151', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('830006', '', '1', '32513', '-84640', '-45360', '-10728', '0', '0', '56156', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('830007', '', '1', '32514', '-77408', '-50656', '-10728', '0', '0', '29664', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('830008', '', '1', '32515', '-81904', '-53904', '-10728', '0', '0', '17044', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('830009', '', '1', '32516', '-86359', '-50593', '-10728', '0', '0', '3704', '60', '0', '0');
INSERT INTO `spawnlist` VALUES ('830010', '', '1', '32377', '-79117', '-45433', '-10731', '0', '0', '40959', '60', '0', '0');
-- 加入移動到柯雷塔的晶體/各等級的地下競技場外面
Delete From teleport Where `id` in (12060,32378,3249140,3249150,3249160,3249170,3249100);
INSERT INTO `teleport` VALUES ('Fantasy Isle -> Underground Coliseum', '12060', '-82271', '-49196', '-10352', '0', '0');
INSERT INTO `teleport` VALUES ('Fantasy Isle\'s -> Kratei Cube', '32378', '-70522', '-71026', '-1416', '0', '0');
INSERT INTO `teleport` VALUES ('Underground Coliseum -> Underground Coliseum LV40', '3249140', '-84451', '-45452', '-10728', '0', '0');
INSERT INTO `teleport` VALUES ('Underground Coliseum -> Underground Coliseum LV50', '3249150', '-86154', '-50429', '-10728', '0', '0');
INSERT INTO `teleport` VALUES ('Underground Coliseum -> Underground Coliseum LV60', '3249160', '-82009', '-53652', '-10728', '0', '0');
INSERT INTO `teleport` VALUES ('Underground Coliseum -> Underground Coliseum LV70', '3249170', '-77586', '-50503', '-10728', '0', '0');
INSERT INTO `teleport` VALUES ('Underground Coliseum -> Underground Coliseum LV00', '3249100', '-79309', '-45561', '-10728', '0', '0');
-- 修正奇岩港口的傳送價格
UPDATE `teleport` SET `price` = '5200' WHERE `id` in (63);
UPDATE `teleport` SET `price` = '7100' WHERE `id` in (107);
-- 修正獵捕石道具類型
UPDATE `etcitem` SET `item_type` = 'none' WHERE `item_id` in (8764);


/************ 增加商店基本型武器/防具/飾品的販賣 ************/
Delete From merchant_shopids Where shop_id in (3029402,3023002,3023003,3023102,3068402,3068403,3083402,3083702,3083703,3083802,3083803,3084102,3084202,3089102,3089103,3016301,3016401,3016502,3125602,3125603,3125702,3125703,3125802,3125803,3125902,3125903,3126001,3126101,3130002,3130003,3130102,3130103,3130202,3130203,3130302,3130303,3130401,3130501);
INSERT INTO merchant_shopids VALUES
(3029402,'30294'),
(3023002,'30230'),
(3023003,'30230'),
(3023102,'30231'),
(3068402,'30684'),
(3068403,'30684'),
(3083402,'30834'),
(3083702,'30837'),
(3083703,'30837'),
(3083802,'30838'),
(3083803,'30838'),
(3084102,'30841'),
(3084202,'30842'),
(3089102,'30891'),
(3089103,'30891'),
(3016301,'30163'),
(3016401,'30164'),
(3016502,'30165'),
(3125602,'31256'),
(3125603,'31256'),
(3125702,'31257'),
(3125703,'31257'),
(3125802,'31258'),
(3125803,'31258'),
(3125902,'31259'),
(3125903,'31259'),
(3126001,'31260'),
(3126101,'31261'),
(3130002,'31300'),
(3130003,'31300'),
(3130102,'31301'),
(3130103,'31301'),
(3130202,'31302'),
(3130203,'31302'),
(3130302,'31303'),
(3130303,'31303'),
(3130401,'31304'),
(3130501,'31305');

Delete From merchant_buylists Where shop_id in (3029402,3023002,3023003,3023102,3068402,3068403,3083402,3083702,3083703,3083802,3083803,3084102,3084202,3089102,3089103,3016301,3016401,3016502,3125602,3125603,3125702,3125703,3125802,3125803,3125902,3125903,3126001,3126101,3130002,3130003,3130102,3130103,3130202,3130203,3130302,3130303,3130401,3130501);
INSERT INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
-- 30294
(12312,-1,3029402,0),
(12311,-1,3029402,1),
(12313,-1,3029402,2),

-- 30230
(12014,-1,3023002,0),
(12008,-1,3023002,1),
(12012,-1,3023002,2),
(12015,-1,3023002,3),
(12020,-1,3023002,4),
(12021,-1,3023002,5),
(12031,-1,3023002,6),
(12041,-1,3023002,7),
(12013,-1,3023002,8),
(12025,-1,3023002,9),
(12007,-1,3023002,10),
(12016,-1,3023002,11),
(12006,-1,3023002,12),
(12029,-1,3023002,13),
(12009,-1,3023002,14),
(12028,-1,3023002,15),
(12042,-1,3023002,16),
(12043,-1,3023002,17),
(12011,-1,3023003,0),
(12010,-1,3023003,1),
(12017,-1,3023003,2),
(12022,-1,3023003,3),
(12019,-1,3023003,4),
(12018,-1,3023003,5),
(12048,-1,3023003,6),
(12047,-1,3023003,7),
(12013,-1,3023003,8),
(12025,-1,3023003,9),
(12007,-1,3023003,10),
(12016,-1,3023003,11),
(12006,-1,3023003,12),
(12029,-1,3023003,13),
(12009,-1,3023003,14),
(12028,-1,3023003,15),

-- 30231
(12312,-1,3023102,0),
(12311,-1,3023102,1),
(12313,-1,3023102,2),

-- 30684
(11614,-1,3068402,0),
(11605,-1,3068402,1),
(11613,-1,3068402,2),
(11617,-1,3068402,3),
(11606,-1,3068402,4),
(11623,-1,3068402,5),
(11626,-1,3068402,6),
(11618,-1,3068402,7),
(11622,-1,3068402,8),
(11635,-1,3068402,9),
(11646,-1,3068402,10),
(11632,-1,3068402,11),
(11629,-1,3068402,12),
(11647,-1,3068402,13),
(11631,-1,3068402,14),
(11608,-1,3068402,15),
(11642,-1,3068402,16),
(11610,-1,3068403,0),
(11619,-1,3068403,1),
(11611,-1,3068403,2),
(11612,-1,3068403,3),
(11609,-1,3068403,4),
(11627,-1,3068403,5),
(11630,-1,3068403,6),
(11634,-1,3068403,7),
(11633,-1,3068403,8),
(11637,-1,3068403,9),
(11655,-1,3068403,10),
(11656,-1,3068403,11),
(11657,-1,3068403,12),
(11662,-1,3068403,13),
(11664,-1,3068403,14),
(11672,-1,3068403,15),

-- 30834
(11610,-1,3083402,0),
(11619,-1,3083402,1),
(11612,-1,3083402,2),
(11609,-1,3083402,3),
(11627,-1,3083402,4),
(11630,-1,3083402,5),
(11634,-1,3083402,6),
(11633,-1,3083402,7),
(11637,-1,3083402,8),
(11655,-1,3083402,9),
(11656,-1,3083402,10),
(11657,-1,3083402,11),
(11662,-1,3083402,12),
(11664,-1,3083402,13),
(11672,-1,3083402,14),
(11660,-1,3083402,15),
(11663,-1,3083402,16),
(11678,-1,3083402,17),
(11676,-1,3083402,18),
(11693,-1,3083402,19),
(11709,-1,3083402,20),
(11715,-1,3083402,21),
(11732,-1,3083402,22),
(11737,-1,3083402,23),
(11729,-1,3083402,24),
(11731,-1,3083402,25),
(12011,-1,3083402,26),
(12010,-1,3083402,27),
(12017,-1,3083402,28),
(12022,-1,3083402,29),
(12019,-1,3083402,30),
(12018,-1,3083402,31),
(12048,-1,3083402,32),
(12047,-1,3083402,33),
(12058,-1,3083402,34),
(12057,-1,3083402,35),
(12083,-1,3083402,36),
(12013,-1,3083402,37),
(12025,-1,3083402,38),
(12051,-1,3083402,39),
(12069,-1,3083402,40),
(12063,-1,3083402,41),
(12073,-1,3083402,42),
(12078,-1,3083402,43),
(12007,-1,3083402,44),
(12016,-1,3083402,45),
(12038,-1,3083402,46),
(12068,-1,3083402,47),
(12046,-1,3083402,48),
(12037,-1,3083402,49),
(12055,-1,3083402,50),
(12061,-1,3083402,51),
(12072,-1,3083402,52),
(12076,-1,3083402,53),
(12082,-1,3083402,54),
(12006,-1,3083402,55),
(12029,-1,3083402,56),
(12033,-1,3083402,57),
(12070,-1,3083402,58),
(12035,-1,3083402,59),
(12045,-1,3083402,60),
(12053,-1,3083402,61),
(12062,-1,3083402,62),
(12071,-1,3083402,63),
(12075,-1,3083402,64),
(12077,-1,3083402,65),
(12009,-1,3083402,66),
(12028,-1,3083402,67),
(12050,-1,3083402,68),
(12064,-1,3083402,69),
(12079,-1,3083402,70),

-- 30837
(11614,-1,3083702,0),
(11605,-1,3083702,1),
(11613,-1,3083702,2),
(11617,-1,3083702,3),
(11606,-1,3083702,4),
(11623,-1,3083702,5),
(11626,-1,3083702,6),
(11618,-1,3083702,7),
(11622,-1,3083702,8),
(11635,-1,3083702,9),
(11646,-1,3083702,10),
(11632,-1,3083702,11),
(11629,-1,3083702,12),
(11647,-1,3083702,13),
(11631,-1,3083702,14),
(11608,-1,3083702,15),
(11642,-1,3083702,16),
(11675,-1,3083702,17),
(11756,-1,3083702,18),
(11765,-1,3083702,19),
(11751,-1,3083702,20),
(11750,-1,3083702,21),
(11761,-1,3083702,22),
(11755,-1,3083702,23),
(11768,-1,3083702,24),
(11767,-1,3083702,25),
(11762,-1,3083702,26),
(11747,-1,3083702,27),
(11763,-1,3083702,28),
(11759,-1,3083702,29),
(11760,-1,3083702,30),
(11749,-1,3083702,31),
(11783,-1,3083702,32),
(11794,-1,3083702,33),
(11789,-1,3083702,34),
(11778,-1,3083702,35),
(11788,-1,3083702,36),
(11777,-1,3083702,37),
(11782,-1,3083702,38),
(11790,-1,3083702,39),
(11775,-1,3083702,40),
(11776,-1,3083702,41),
(11821,-1,3083702,42),
(11807,-1,3083702,43),
(11820,-1,3083702,44),
(11801,-1,3083702,45),
(11815,-1,3083702,46),
(11816,-1,3083702,47),
(11800,-1,3083702,48),
(11803,-1,3083702,49),
(11826,-1,3083702,50),
(11827,-1,3083702,51),
(11814,-1,3083702,52),
(11813,-1,3083702,53),
(11822,-1,3083702,54),
(11830,-1,3083702,55),
(11832,-1,3083702,56),
(11853,-1,3083702,57),
(11863,-1,3083702,58),
(11856,-1,3083702,59),
(11857,-1,3083702,60),
(11839,-1,3083702,61),
(11858,-1,3083702,62),
(11843,-1,3083702,63),
(11840,-1,3083702,64),
(11610,-1,3083703,0),
(11619,-1,3083703,1),
(11611,-1,3083703,2),
(11612,-1,3083703,3),
(11609,-1,3083703,4),
(11627,-1,3083703,5),
(11630,-1,3083703,6),
(11634,-1,3083703,7),
(11633,-1,3083703,8),
(11637,-1,3083703,9),
(11655,-1,3083703,10),
(11656,-1,3083703,11),
(11657,-1,3083703,12),
(11662,-1,3083703,13),
(11664,-1,3083703,14),
(11672,-1,3083703,15),
(11764,-1,3083703,16),
(11757,-1,3083703,17),
(11748,-1,3083703,18),
(11779,-1,3083703,19),
(11792,-1,3083703,20),
(11793,-1,3083703,21),
(11829,-1,3083703,22),
(11805,-1,3083703,23),
(11802,-1,3083703,24),
(11799,-1,3083703,25),
(11804,-1,3083703,26),
(11806,-1,3083703,27),
(11817,-1,3083703,28),
(11825,-1,3083703,29),
(11819,-1,3083703,30),
(11824,-1,3083703,31),
(11828,-1,3083703,32),
(11833,-1,3083703,33),
(11850,-1,3083703,34),
(11859,-1,3083703,35),
(11842,-1,3083703,36),
(11838,-1,3083703,37),
(11855,-1,3083703,38),

-- 30838
(12014,-1,3083802,0),
(12008,-1,3083802,1),
(12015,-1,3083802,2),
(12012,-1,3083802,3),
(12020,-1,3083802,4),
(12021,-1,3083802,5),
(12024,-1,3083802,6),
(12032,-1,3083802,7),
(12030,-1,3083802,8),
(12031,-1,3083802,9),
(12041,-1,3083802,10),
(12034,-1,3083802,11),
(12023,-1,3083802,12),
(12044,-1,3083802,13),
(12049,-1,3083802,14),
(12039,-1,3083802,15),
(12043,-1,3083802,16),
(12042,-1,3083802,17),
(12036,-1,3083802,18),
(12060,-1,3083802,19),
(12059,-1,3083802,20),
(12056,-1,3083802,21),
(12054,-1,3083802,22),
(12052,-1,3083802,23),
(12081,-1,3083802,24),
(12080,-1,3083802,25),
(12074,-1,3083802,26),
(12013,-1,3083802,27),
(12025,-1,3083802,28),
(12051,-1,3083802,29),
(12069,-1,3083802,30),
(12063,-1,3083802,31),
(12073,-1,3083802,32),
(12078,-1,3083802,33),
(12007,-1,3083802,34),
(12016,-1,3083802,35),
(12038,-1,3083802,36),
(12068,-1,3083802,37),
(12037,-1,3083802,38),
(12055,-1,3083802,39),
(12061,-1,3083802,40),
(12072,-1,3083802,41),
(12076,-1,3083802,42),
(12006,-1,3083802,43),
(12029,-1,3083802,44),
(12033,-1,3083802,45),
(12070,-1,3083802,46),
(12035,-1,3083802,47),
(12053,-1,3083802,48),
(12062,-1,3083802,49),
(12071,-1,3083802,50),
(12075,-1,3083802,51),
(12077,-1,3083802,52),
(12009,-1,3083802,53),
(12028,-1,3083802,54),
(12050,-1,3083802,55),
(12079,-1,3083802,56),
(12085,-1,3083802,57),
(12095,-1,3083802,58),
(12094,-1,3083802,59),
(12086,-1,3083802,60),
(12091,-1,3083802,61),
(12084,-1,3083802,62),
(12093,-1,3083802,63),
(12101,-1,3083802,64),
(12088,-1,3083802,65),
(12089,-1,3083802,66),
(12087,-1,3083802,67),
(12092,-1,3083802,68),
(12096,-1,3083802,69),
(12128,-1,3083802,70),
(12144,-1,3083802,71),
(12135,-1,3083802,72),
(12107,-1,3083802,73),
(12129,-1,3083802,74),
(12126,-1,3083802,75),
(12143,-1,3083802,76),
(12109,-1,3083802,77),
(12111,-1,3083802,78),
(12130,-1,3083802,79),
(12106,-1,3083802,80),
(12127,-1,3083802,81),
(12120,-1,3083802,82),
(12145,-1,3083802,83),
(12108,-1,3083802,84),
(12116,-1,3083802,85),
(12112,-1,3083802,86),
(12119,-1,3083802,87),
(12131,-1,3083802,88),
(12134,-1,3083802,89),
(12141,-1,3083802,90),
(12137,-1,3083802,91),
(12118,-1,3083802,92),
(12114,-1,3083802,93),
(12125,-1,3083802,94),
(12132,-1,3083802,95),
(12136,-1,3083802,96),
(12142,-1,3083802,97),
(12110,-1,3083802,98),
(12113,-1,3083802,99),
(12133,-1,3083802,100),
(12011,-1,3083803,0),
(12010,-1,3083803,1),
(12017,-1,3083803,2),
(12022,-1,3083803,3),
(12019,-1,3083803,4),
(12018,-1,3083803,5),
(12048,-1,3083803,6),
(12047,-1,3083803,7),
(12013,-1,3083803,8),
(12025,-1,3083803,9),
(12063,-1,3083803,10),
(12007,-1,3083803,11),
(12016,-1,3083803,12),
(12046,-1,3083803,13),
(12065,-1,3083803,14),
(12122,-1,3083803,15),
(12006,-1,3083803,16),
(12029,-1,3083803,17),
(12045,-1,3083803,18),
(12066,-1,3083803,19),
(12121,-1,3083803,20),
(12009,-1,3083803,21),
(12028,-1,3083803,22),
(12099,-1,3083803,23),
(12100,-1,3083803,24),
(12098,-1,3083803,25),
(12097,-1,3083803,26),
(12115,-1,3083803,27),
(12124,-1,3083803,28),
(12139,-1,3083803,29),
(12123,-1,3083803,30),
(12138,-1,3083803,31),

-- 30841
(12312,-1,3084102,0),
(12311,-1,3084102,1),
(12313,-1,3084102,2),
(12326,-1,3084102,3),
(12328,-1,3084102,4),
(12327,-1,3084102,5),
(12331,-1,3084102,6),
(12329,-1,3084102,7),
(12330,-1,3084102,8),
(12333,-1,3084102,9),
(12332,-1,3084102,10),
(12334,-1,3084102,11),
(12337,-1,3084102,12),
(12335,-1,3084102,13),
(12336,-1,3084102,14),

-- 30842
(12312,-1,3084202,0),
(12311,-1,3084202,1),
(12313,-1,3084202,2),
(12326,-1,3084202,3),
(12328,-1,3084202,4),
(12327,-1,3084202,5),
(12331,-1,3084202,6),
(12329,-1,3084202,7),
(12330,-1,3084202,8),
(12333,-1,3084202,9),
(12332,-1,3084202,10),
(12334,-1,3084202,11),
(12337,-1,3084202,12),
(12335,-1,3084202,13),
(12336,-1,3084202,14),

-- 30891
(11614,-1,3089102,0),
(11605,-1,3089102,1),
(11613,-1,3089102,2),
(11617,-1,3089102,3),
(11606,-1,3089102,4),
(11623,-1,3089102,5),
(11626,-1,3089102,6),
(11618,-1,3089102,7),
(11622,-1,3089102,8),
(11635,-1,3089102,9),
(11643,-1,3089102,10),
(11646,-1,3089102,11),
(11632,-1,3089102,12),
(11640,-1,3089102,13),
(11629,-1,3089102,14),
(11645,-1,3089102,15),
(11647,-1,3089102,16),
(11631,-1,3089102,17),
(11667,-1,3089102,18),
(11675,-1,3089102,19),
(11670,-1,3089102,20),
(11673,-1,3089102,21),
(11659,-1,3089102,22),
(11666,-1,3089102,23),
(11671,-1,3089102,24),
(11661,-1,3089102,25),
(11714,-1,3089102,26),
(11685,-1,3089102,27),
(11706,-1,3089102,28),
(11683,-1,3089102,29),
(11708,-1,3089102,30),
(11710,-1,3089102,31),
(11711,-1,3089102,32),
(11713,-1,3089102,33),
(11712,-1,3089102,34),
(11686,-1,3089102,35),
(11703,-1,3089102,36),
(11608,-1,3089102,37),
(11642,-1,3089102,38),
(11665,-1,3089102,39),
(11691,-1,3089102,40),
(11625,-1,3089102,41),
(11736,-1,3089102,42),
(11727,-1,3089102,43),
(11726,-1,3089102,44),
(11730,-1,3089102,45),
(11728,-1,3089102,46),
(11725,-1,3089102,47),
(11733,-1,3089102,48),
(11610,-1,3089103,0),
(11619,-1,3089103,1),
(11611,-1,3089103,2),
(11612,-1,3089103,3),
(11609,-1,3089103,4),
(11627,-1,3089103,5),
(11630,-1,3089103,6),
(11634,-1,3089103,7),
(11633,-1,3089103,8),
(11637,-1,3089103,9),
(11655,-1,3089103,10),
(11656,-1,3089103,11),
(11657,-1,3089103,12),
(11662,-1,3089103,13),
(11664,-1,3089103,14),
(11672,-1,3089103,15),
(11660,-1,3089103,16),
(11663,-1,3089103,17),
(11678,-1,3089103,18),
(11676,-1,3089103,19),
(11693,-1,3089103,20),
(11696,-1,3089103,21),
(11692,-1,3089103,22),
(11709,-1,3089103,23),
(11715,-1,3089103,24),
(11732,-1,3089103,25),
(11737,-1,3089103,26),
(11729,-1,3089103,27),
(11731,-1,3089103,28),

-- 30163
(11610,-1,3016301,0),
(11619,-1,3016301,1),
(11611,-1,3016301,2),
(11612,-1,3016301,3),
(11609,-1,3016301,4),
(11627,-1,3016301,5),
(11630,-1,3016301,6),
(11634,-1,3016301,7),
(11633,-1,3016301,8),
(11637,-1,3016301,9),
(11655,-1,3016301,10),
(11656,-1,3016301,11),
(11657,-1,3016301,12),
(11662,-1,3016301,13),
(11664,-1,3016301,14),
(11672,-1,3016301,15),
(11660,-1,3016301,16),
(11663,-1,3016301,17),
(11678,-1,3016301,18),
(11676,-1,3016301,19),
(11693,-1,3016301,20),
(11696,-1,3016301,21),
(11692,-1,3016301,22),
(11709,-1,3016301,23),
(11715,-1,3016301,24),
(11732,-1,3016301,25),
(11737,-1,3016301,26),
(11729,-1,3016301,27),
(11731,-1,3016301,28),

-- 30164
(12011,-1,3016401,0),
(12010,-1,3016401,1),
(12017,-1,3016401,2),
(12022,-1,3016401,3),
(12019,-1,3016401,4),
(12018,-1,3016401,5),
(12048,-1,3016401,6),
(12047,-1,3016401,7),
(12058,-1,3016401,8),
(12057,-1,3016401,9),
(12083,-1,3016401,10),
(12013,-1,3016401,11),
(12025,-1,3016401,12),
(12051,-1,3016401,13),
(12069,-1,3016401,14),
(12063,-1,3016401,15),
(12073,-1,3016401,16),
(12078,-1,3016401,17),
(12007,-1,3016401,18),
(12016,-1,3016401,19),
(12038,-1,3016401,20),
(12068,-1,3016401,21),
(12046,-1,3016401,22),
(12065,-1,3016401,23),
(12072,-1,3016401,24),
(12076,-1,3016401,25),
(12082,-1,3016401,26),
(12006,-1,3016401,27),
(12029,-1,3016401,28),
(12033,-1,3016401,29),
(12070,-1,3016401,30),
(12045,-1,3016401,31),
(12066,-1,3016401,32),
(12071,-1,3016401,33),
(12075,-1,3016401,34),
(12077,-1,3016401,35),
(12009,-1,3016401,36),
(12028,-1,3016401,37),
(12050,-1,3016401,38),
(12079,-1,3016401,39),

-- 30165
(12312,-1,3016502,0),
(12315,-1,3016502,1),
(12317,-1,3016502,2),
(12320,-1,3016502,3),
(12311,-1,3016502,4),
(12314,-1,3016502,5),
(12318,-1,3016502,6),
(12322,-1,3016502,7),
(12313,-1,3016502,8),
(12316,-1,3016502,9),
(12319,-1,3016502,10),
(12321,-1,3016502,11),
(12325,-1,3016502,12),
(12323,-1,3016502,13),
(12324,-1,3016502,14),

-- 31256
(11614,-1,3125602,0),
(11605,-1,3125602,1),
(11613,-1,3125602,2),
(11617,-1,3125602,3),
(11606,-1,3125602,4),
(11623,-1,3125602,5),
(11626,-1,3125602,6),
(11618,-1,3125602,7),
(11622,-1,3125602,8),
(11635,-1,3125602,9),
(11643,-1,3125602,10),
(11646,-1,3125602,11),
(11632,-1,3125602,12),
(11640,-1,3125602,13),
(11629,-1,3125602,14),
(11645,-1,3125602,15),
(11647,-1,3125602,16),
(11631,-1,3125602,17),
(11667,-1,3125602,18),
(11675,-1,3125602,19),
(11670,-1,3125602,20),
(11673,-1,3125602,21),
(11659,-1,3125602,22),
(11666,-1,3125602,23),
(11671,-1,3125602,24),
(11661,-1,3125602,25),
(11714,-1,3125602,26),
(11685,-1,3125602,27),
(11706,-1,3125602,28),
(11683,-1,3125602,29),
(11708,-1,3125602,30),
(11710,-1,3125602,31),
(11711,-1,3125602,32),
(11713,-1,3125602,33),
(11712,-1,3125602,34),
(11686,-1,3125602,35),
(11703,-1,3125602,36),
(11608,-1,3125602,37),
(11642,-1,3125602,38),
(11665,-1,3125602,39),
(11691,-1,3125602,40),
(11625,-1,3125602,41),
(11736,-1,3125602,42),
(11727,-1,3125602,43),
(11726,-1,3125602,44),
(11730,-1,3125602,45),
(11728,-1,3125602,46),
(11725,-1,3125602,47),
(11733,-1,3125602,48),
(11610,-1,3125603,0),
(11619,-1,3125603,1),
(11611,-1,3125603,2),
(11612,-1,3125603,3),
(11609,-1,3125603,4),
(11627,-1,3125603,5),
(11630,-1,3125603,6),
(11634,-1,3125603,7),
(11633,-1,3125603,8),
(11637,-1,3125603,9),
(11655,-1,3125603,10),
(11656,-1,3125603,11),
(11657,-1,3125603,12),
(11662,-1,3125603,13),
(11664,-1,3125603,14),
(11672,-1,3125603,15),
(11660,-1,3125603,16),
(11663,-1,3125603,17),
(11678,-1,3125603,18),
(11676,-1,3125603,19),
(11693,-1,3125603,20),
(11696,-1,3125603,21),
(11692,-1,3125603,22),
(11709,-1,3125603,23),
(11715,-1,3125603,24),
(11732,-1,3125603,25),
(11737,-1,3125603,26),
(11729,-1,3125603,27),
(11731,-1,3125603,28),

-- 31257
(11614,-1,3125702,0),
(11605,-1,3125702,1),
(11613,-1,3125702,2),
(11617,-1,3125702,3),
(11606,-1,3125702,4),
(11623,-1,3125702,5),
(11626,-1,3125702,6),
(11618,-1,3125702,7),
(11622,-1,3125702,8),
(11635,-1,3125702,9),
(11643,-1,3125702,10),
(11646,-1,3125702,11),
(11632,-1,3125702,12),
(11640,-1,3125702,13),
(11629,-1,3125702,14),
(11645,-1,3125702,15),
(11647,-1,3125702,16),
(11631,-1,3125702,17),
(11667,-1,3125702,18),
(11675,-1,3125702,19),
(11670,-1,3125702,20),
(11673,-1,3125702,21),
(11659,-1,3125702,22),
(11666,-1,3125702,23),
(11671,-1,3125702,24),
(11661,-1,3125702,25),
(11714,-1,3125702,26),
(11685,-1,3125702,27),
(11706,-1,3125702,28),
(11683,-1,3125702,29),
(11708,-1,3125702,30),
(11710,-1,3125702,31),
(11711,-1,3125702,32),
(11713,-1,3125702,33),
(11712,-1,3125702,34),
(11686,-1,3125702,35),
(11703,-1,3125702,36),
(11608,-1,3125702,37),
(11642,-1,3125702,38),
(11665,-1,3125702,39),
(11691,-1,3125702,40),
(11625,-1,3125702,41),
(11736,-1,3125702,42),
(11727,-1,3125702,43),
(11726,-1,3125702,44),
(11730,-1,3125702,45),
(11728,-1,3125702,46),
(11725,-1,3125702,47),
(11733,-1,3125702,48),
(11610,-1,3125703,0),
(11619,-1,3125703,1),
(11611,-1,3125703,2),
(11612,-1,3125703,3),
(11609,-1,3125703,4),
(11627,-1,3125703,5),
(11630,-1,3125703,6),
(11634,-1,3125703,7),
(11633,-1,3125703,8),
(11637,-1,3125703,9),
(11655,-1,3125703,10),
(11656,-1,3125703,11),
(11657,-1,3125703,12),
(11662,-1,3125703,13),
(11664,-1,3125703,14),
(11672,-1,3125703,15),
(11660,-1,3125703,16),
(11663,-1,3125703,17),
(11678,-1,3125703,18),
(11676,-1,3125703,19),
(11693,-1,3125703,20),
(11696,-1,3125703,21),
(11692,-1,3125703,22),
(11709,-1,3125703,23),
(11715,-1,3125703,24),
(11732,-1,3125703,25),
(11737,-1,3125703,26),
(11729,-1,3125703,27),
(11731,-1,3125703,28),

-- 31258
(12014,-1,3125802,0),
(12008,-1,3125802,1),
(12015,-1,3125802,2),
(12012,-1,3125802,3),
(12020,-1,3125802,4),
(12021,-1,3125802,5),
(12024,-1,3125802,6),
(12032,-1,3125802,7),
(12030,-1,3125802,8),
(12031,-1,3125802,9),
(12041,-1,3125802,10),
(12034,-1,3125802,11),
(12023,-1,3125802,12),
(12044,-1,3125802,13),
(12049,-1,3125802,14),
(12039,-1,3125802,15),
(12043,-1,3125802,16),
(12042,-1,3125802,17),
(12036,-1,3125802,18),
(12060,-1,3125802,19),
(12059,-1,3125802,20),
(12056,-1,3125802,21),
(12054,-1,3125802,22),
(12052,-1,3125802,23),
(12081,-1,3125802,24),
(12080,-1,3125802,25),
(12074,-1,3125802,26),
(12013,-1,3125802,27),
(12025,-1,3125802,28),
(12051,-1,3125802,29),
(12069,-1,3125802,30),
(12073,-1,3125802,31),
(12078,-1,3125802,32),
(12007,-1,3125802,33),
(12016,-1,3125802,34),
(12038,-1,3125802,35),
(12068,-1,3125802,36),
(12037,-1,3125802,37),
(12072,-1,3125802,38),
(12076,-1,3125802,39),
(12006,-1,3125802,40),
(12029,-1,3125802,41),
(12033,-1,3125802,42),
(12070,-1,3125802,43),
(12035,-1,3125802,44),
(12071,-1,3125802,45),
(12075,-1,3125802,46),
(12077,-1,3125802,47),
(12009,-1,3125802,48),
(12028,-1,3125802,49),
(12050,-1,3125802,50),
(12079,-1,3125802,51),
(12011,-1,3125803,0),
(12010,-1,3125803,1),
(12017,-1,3125803,2),
(12022,-1,3125803,3),
(12019,-1,3125803,4),
(12018,-1,3125803,5),
(12048,-1,3125803,6),
(12047,-1,3125803,7),
(12058,-1,3125803,8),
(12057,-1,3125803,9),
(12083,-1,3125803,10),
(12013,-1,3125803,11),
(12025,-1,3125803,12),
(12051,-1,3125803,13),
(12069,-1,3125803,14),
(12063,-1,3125803,15),
(12073,-1,3125803,16),
(12078,-1,3125803,17),
(12007,-1,3125803,18),
(12016,-1,3125803,19),
(12038,-1,3125803,20),
(12068,-1,3125803,21),
(12046,-1,3125803,22),
(12065,-1,3125803,23),
(12072,-1,3125803,24),
(12076,-1,3125803,25),
(12082,-1,3125803,26),
(12006,-1,3125803,27),
(12029,-1,3125803,28),
(12033,-1,3125803,29),
(12070,-1,3125803,30),
(12045,-1,3125803,31),
(12066,-1,3125803,32),
(12071,-1,3125803,33),
(12075,-1,3125803,34),
(12077,-1,3125803,35),
(12009,-1,3125803,36),
(12028,-1,3125803,37),
(12050,-1,3125803,38),
(12079,-1,3125803,39),

-- 31259
(12014,-1,3125902,0),
(12008,-1,3125902,1),
(12015,-1,3125902,2),
(12012,-1,3125902,3),
(12020,-1,3125902,4),
(12021,-1,3125902,5),
(12024,-1,3125902,6),
(12032,-1,3125902,7),
(12030,-1,3125902,8),
(12031,-1,3125902,9),
(12041,-1,3125902,10),
(12034,-1,3125902,11),
(12023,-1,3125902,12),
(12044,-1,3125902,13),
(12049,-1,3125902,14),
(12039,-1,3125902,15),
(12043,-1,3125902,16),
(12042,-1,3125902,17),
(12036,-1,3125902,18),
(12060,-1,3125902,19),
(12059,-1,3125902,20),
(12056,-1,3125902,21),
(12054,-1,3125902,22),
(12052,-1,3125902,23),
(12081,-1,3125902,24),
(12080,-1,3125902,25),
(12074,-1,3125902,26),
(12013,-1,3125902,27),
(12025,-1,3125902,28),
(12051,-1,3125902,29),
(12069,-1,3125902,30),
(12073,-1,3125902,31),
(12078,-1,3125902,32),
(12007,-1,3125902,33),
(12016,-1,3125902,34),
(12038,-1,3125902,35),
(12068,-1,3125902,36),
(12037,-1,3125902,37),
(12072,-1,3125902,38),
(12076,-1,3125902,39),
(12006,-1,3125902,40),
(12029,-1,3125902,41),
(12033,-1,3125902,42),
(12070,-1,3125902,43),
(12035,-1,3125902,44),
(12071,-1,3125902,45),
(12075,-1,3125902,46),
(12077,-1,3125902,47),
(12009,-1,3125902,48),
(12028,-1,3125902,49),
(12050,-1,3125902,50),
(12079,-1,3125902,51),
(12011,-1,3125903,0),
(12010,-1,3125903,1),
(12017,-1,3125903,2),
(12022,-1,3125903,3),
(12019,-1,3125903,4),
(12018,-1,3125903,5),
(12048,-1,3125903,6),
(12047,-1,3125903,7),
(12058,-1,3125903,8),
(12057,-1,3125903,9),
(12083,-1,3125903,10),
(12013,-1,3125903,11),
(12025,-1,3125903,12),
(12051,-1,3125903,13),
(12069,-1,3125903,14),
(12063,-1,3125903,15),
(12073,-1,3125903,16),
(12078,-1,3125903,17),
(12007,-1,3125903,18),
(12016,-1,3125903,19),
(12038,-1,3125903,20),
(12068,-1,3125903,21),
(12046,-1,3125903,22),
(12065,-1,3125903,23),
(12072,-1,3125903,24),
(12076,-1,3125903,25),
(12082,-1,3125903,26),
(12006,-1,3125903,27),
(12029,-1,3125903,28),
(12033,-1,3125903,29),
(12070,-1,3125903,30),
(12045,-1,3125903,31),
(12066,-1,3125903,32),
(12071,-1,3125903,33),
(12075,-1,3125903,34),
(12077,-1,3125903,35),
(12009,-1,3125903,36),
(12028,-1,3125903,37),
(12050,-1,3125903,38),
(12079,-1,3125903,39),

-- 31260
(12312,-1,3126001,0),
(12315,-1,3126001,1),
(12317,-1,3126001,2),
(12320,-1,3126001,3),
(12311,-1,3126001,4),
(12314,-1,3126001,5),
(12318,-1,3126001,6),
(12322,-1,3126001,7),
(12313,-1,3126001,8),
(12316,-1,3126001,9),
(12319,-1,3126001,10),
(12321,-1,3126001,11),
(12325,-1,3126001,12),
(12323,-1,3126001,13),
(12324,-1,3126001,14),
(12312,-1,3126101,0),
(12315,-1,3126101,1),
(12317,-1,3126101,2),
(12320,-1,3126101,3),
(12311,-1,3126101,4),
(12314,-1,3126101,5),
(12318,-1,3126101,6),
(12322,-1,3126101,7),
(12313,-1,3126101,8),
(12316,-1,3126101,9),
(12319,-1,3126101,10),
(12321,-1,3126101,11),
(12325,-1,3126101,12),
(12323,-1,3126101,13),
(12324,-1,3126101,14),

-- 31300
(11614,-1,3130002,0),
(11605,-1,3130002,1),
(11613,-1,3130002,2),
(11617,-1,3130002,3),
(11606,-1,3130002,4),
(11623,-1,3130002,5),
(11626,-1,3130002,6),
(11618,-1,3130002,7),
(11622,-1,3130002,8),
(11635,-1,3130002,9),
(11643,-1,3130002,10),
(11646,-1,3130002,11),
(11632,-1,3130002,12),
(11640,-1,3130002,13),
(11629,-1,3130002,14),
(11645,-1,3130002,15),
(11647,-1,3130002,16),
(11631,-1,3130002,17),
(11667,-1,3130002,18),
(11675,-1,3130002,19),
(11670,-1,3130002,20),
(11673,-1,3130002,21),
(11659,-1,3130002,22),
(11666,-1,3130002,23),
(11671,-1,3130002,24),
(11661,-1,3130002,25),
(11714,-1,3130002,26),
(11685,-1,3130002,27),
(11706,-1,3130002,28),
(11683,-1,3130002,29),
(11708,-1,3130002,30),
(11710,-1,3130002,31),
(11711,-1,3130002,32),
(11713,-1,3130002,33),
(11712,-1,3130002,34),
(11686,-1,3130002,35),
(11703,-1,3130002,36),
(11608,-1,3130002,37),
(11642,-1,3130002,38),
(11665,-1,3130002,39),
(11691,-1,3130002,40),
(11625,-1,3130002,41),
(11736,-1,3130002,42),
(11727,-1,3130002,43),
(11726,-1,3130002,44),
(11730,-1,3130002,45),
(11728,-1,3130002,46),
(11725,-1,3130002,47),
(11733,-1,3130002,48),
(11747,-1,3130002,49),
(11763,-1,3130002,50),
(11759,-1,3130002,51),
(11760,-1,3130002,52),
(11749,-1,3130002,53),
(11783,-1,3130002,54),
(11794,-1,3130002,55),
(11789,-1,3130002,56),
(11778,-1,3130002,57),
(11788,-1,3130002,58),
(11777,-1,3130002,59),
(11782,-1,3130002,60),
(11790,-1,3130002,61),
(11775,-1,3130002,62),
(11776,-1,3130002,63),
(11821,-1,3130002,64),
(11807,-1,3130002,65),
(11820,-1,3130002,66),
(11801,-1,3130002,67),
(11815,-1,3130002,68),
(11816,-1,3130002,69),
(11800,-1,3130002,70),
(11803,-1,3130002,71),
(11826,-1,3130002,72),
(11827,-1,3130002,73),
(11814,-1,3130002,74),
(11813,-1,3130002,75),
(11822,-1,3130002,76),
(11830,-1,3130002,77),
(11832,-1,3130002,78),
(11853,-1,3130002,79),
(11863,-1,3130002,80),
(11856,-1,3130002,81),
(11839,-1,3130002,82),
(11857,-1,3130002,83),
(11858,-1,3130002,84),
(11843,-1,3130002,85),
(11840,-1,3130002,86),
(11610,-1,3130003,0),
(11619,-1,3130003,1),
(11611,-1,3130003,2),
(11612,-1,3130003,3),
(11609,-1,3130003,4),
(11627,-1,3130003,5),
(11630,-1,3130003,6),
(11634,-1,3130003,7),
(11633,-1,3130003,8),
(11637,-1,3130003,9),
(11655,-1,3130003,10),
(11656,-1,3130003,11),
(11657,-1,3130003,12),
(11662,-1,3130003,13),
(11664,-1,3130003,14),
(11672,-1,3130003,15),
(11660,-1,3130003,16),
(11663,-1,3130003,17),
(11678,-1,3130003,18),
(11676,-1,3130003,19),
(11693,-1,3130003,20),
(11696,-1,3130003,21),
(11692,-1,3130003,22),
(11709,-1,3130003,23),
(11715,-1,3130003,24),
(11732,-1,3130003,25),
(11737,-1,3130003,26),
(11729,-1,3130003,27),
(11731,-1,3130003,28),
(11764,-1,3130003,29),
(11757,-1,3130003,30),
(11748,-1,3130003,31),
(11779,-1,3130003,32),
(11792,-1,3130003,33),
(11793,-1,3130003,34),
(11829,-1,3130003,35),
(11805,-1,3130003,36),
(11802,-1,3130003,37),
(11799,-1,3130003,38),
(11804,-1,3130003,39),
(11806,-1,3130003,40),
(11817,-1,3130003,41),
(11825,-1,3130003,42),
(11819,-1,3130003,43),
(11824,-1,3130003,44),
(11828,-1,3130003,45),
(11833,-1,3130003,46),
(11850,-1,3130003,47),
(11859,-1,3130003,48),
(11842,-1,3130003,49),
(11838,-1,3130003,50),
(11855,-1,3130003,51),

-- 31301
(11614,-1,3130102,0),
(11605,-1,3130102,1),
(11613,-1,3130102,2),
(11617,-1,3130102,3),
(11606,-1,3130102,4),
(11623,-1,3130102,5),
(11626,-1,3130102,6),
(11618,-1,3130102,7),
(11622,-1,3130102,8),
(11635,-1,3130102,9),
(11643,-1,3130102,10),
(11646,-1,3130102,11),
(11632,-1,3130102,12),
(11640,-1,3130102,13),
(11629,-1,3130102,14),
(11645,-1,3130102,15),
(11647,-1,3130102,16),
(11631,-1,3130102,17),
(11667,-1,3130102,18),
(11675,-1,3130102,19),
(11670,-1,3130102,20),
(11673,-1,3130102,21),
(11659,-1,3130102,22),
(11666,-1,3130102,23),
(11671,-1,3130102,24),
(11661,-1,3130102,25),
(11714,-1,3130102,26),
(11685,-1,3130102,27),
(11706,-1,3130102,28),
(11683,-1,3130102,29),
(11708,-1,3130102,30),
(11710,-1,3130102,31),
(11711,-1,3130102,32),
(11713,-1,3130102,33),
(11712,-1,3130102,34),
(11686,-1,3130102,35),
(11703,-1,3130102,36),
(11608,-1,3130102,37),
(11642,-1,3130102,38),
(11665,-1,3130102,39),
(11691,-1,3130102,40),
(11625,-1,3130102,41),
(11736,-1,3130102,42),
(11727,-1,3130102,43),
(11726,-1,3130102,44),
(11730,-1,3130102,45),
(11728,-1,3130102,46),
(11725,-1,3130102,47),
(11733,-1,3130102,48),
(11747,-1,3130102,49),
(11763,-1,3130102,50),
(11759,-1,3130102,51),
(11760,-1,3130102,52),
(11749,-1,3130102,53),
(11783,-1,3130102,54),
(11794,-1,3130102,55),
(11789,-1,3130102,56),
(11778,-1,3130102,57),
(11788,-1,3130102,58),
(11777,-1,3130102,59),
(11782,-1,3130102,60),
(11790,-1,3130102,61),
(11775,-1,3130102,62),
(11776,-1,3130102,63),
(11821,-1,3130102,64),
(11807,-1,3130102,65),
(11820,-1,3130102,66),
(11801,-1,3130102,67),
(11815,-1,3130102,68),
(11816,-1,3130102,69),
(11800,-1,3130102,70),
(11803,-1,3130102,71),
(11826,-1,3130102,72),
(11827,-1,3130102,73),
(11814,-1,3130102,74),
(11813,-1,3130102,75),
(11822,-1,3130102,76),
(11830,-1,3130102,77),
(11832,-1,3130102,78),
(11853,-1,3130102,79),
(11863,-1,3130102,80),
(11856,-1,3130102,81),
(11839,-1,3130102,82),
(11857,-1,3130102,83),
(11858,-1,3130102,84),
(11843,-1,3130102,85),
(11840,-1,3130102,86),
(11610,-1,3130103,0),
(11619,-1,3130103,1),
(11611,-1,3130103,2),
(11612,-1,3130103,3),
(11609,-1,3130103,4),
(11627,-1,3130103,5),
(11630,-1,3130103,6),
(11634,-1,3130103,7),
(11633,-1,3130103,8),
(11637,-1,3130103,9),
(11655,-1,3130103,10),
(11656,-1,3130103,11),
(11657,-1,3130103,12),
(11662,-1,3130103,13),
(11664,-1,3130103,14),
(11672,-1,3130103,15),
(11660,-1,3130103,16),
(11663,-1,3130103,17),
(11678,-1,3130103,18),
(11676,-1,3130103,19),
(11693,-1,3130103,20),
(11696,-1,3130103,21),
(11692,-1,3130103,22),
(11709,-1,3130103,23),
(11715,-1,3130103,24),
(11732,-1,3130103,25),
(11737,-1,3130103,26),
(11729,-1,3130103,27),
(11731,-1,3130103,28),
(11764,-1,3130103,29),
(11757,-1,3130103,30),
(11748,-1,3130103,31),
(11779,-1,3130103,32),
(11792,-1,3130103,33),
(11793,-1,3130103,34),
(11829,-1,3130103,35),
(11805,-1,3130103,36),
(11802,-1,3130103,37),
(11799,-1,3130103,38),
(11804,-1,3130103,39),
(11806,-1,3130103,40),
(11817,-1,3130103,41),
(11825,-1,3130103,42),
(11819,-1,3130103,43),
(11824,-1,3130103,44),
(11828,-1,3130103,45),
(11833,-1,3130103,46),
(11850,-1,3130103,47),
(11859,-1,3130103,48),
(11842,-1,3130103,49),
(11838,-1,3130103,50),
(11855,-1,3130103,51),

-- 31302
(12014,-1,3130202,0),
(12008,-1,3130202,1),
(12015,-1,3130202,2),
(12012,-1,3130202,3),
(12020,-1,3130202,4),
(12021,-1,3130202,5),
(12024,-1,3130202,6),
(12032,-1,3130202,7),
(12030,-1,3130202,8),
(12031,-1,3130202,9),
(12041,-1,3130202,10),
(12034,-1,3130202,11),
(12023,-1,3130202,12),
(12044,-1,3130202,13),
(12049,-1,3130202,14),
(12039,-1,3130202,15),
(12043,-1,3130202,16),
(12042,-1,3130202,17),
(12036,-1,3130202,18),
(12060,-1,3130202,19),
(12059,-1,3130202,20),
(12056,-1,3130202,21),
(12054,-1,3130202,22),
(12052,-1,3130202,23),
(12081,-1,3130202,24),
(12080,-1,3130202,25),
(12074,-1,3130202,26),
(12013,-1,3130202,27),
(12025,-1,3130202,28),
(12051,-1,3130202,29),
(12069,-1,3130202,30),
(12063,-1,3130202,31),
(12073,-1,3130202,32),
(12078,-1,3130202,33),
(12007,-1,3130202,34),
(12016,-1,3130202,35),
(12038,-1,3130202,36),
(12068,-1,3130202,37),
(12037,-1,3130202,38),
(12055,-1,3130202,39),
(12061,-1,3130202,40),
(12072,-1,3130202,41),
(12076,-1,3130202,42),
(12006,-1,3130202,43),
(12029,-1,3130202,44),
(12033,-1,3130202,45),
(12070,-1,3130202,46),
(12035,-1,3130202,47),
(12053,-1,3130202,48),
(12062,-1,3130202,49),
(12071,-1,3130202,50),
(12075,-1,3130202,51),
(12077,-1,3130202,52),
(12009,-1,3130202,53),
(12028,-1,3130202,54),
(12050,-1,3130202,55),
(12064,-1,3130202,56),
(12079,-1,3130202,57),
(12085,-1,3130202,58),
(12095,-1,3130202,59),
(12094,-1,3130202,60),
(12086,-1,3130202,61),
(12091,-1,3130202,62),
(12084,-1,3130202,63),
(12093,-1,3130202,64),
(12101,-1,3130202,65),
(12088,-1,3130202,66),
(12089,-1,3130202,67),
(12087,-1,3130202,68),
(12092,-1,3130202,69),
(12096,-1,3130202,70),
(12128,-1,3130202,71),
(12144,-1,3130202,72),
(12135,-1,3130202,73),
(12107,-1,3130202,74),
(12129,-1,3130202,75),
(12126,-1,3130202,76),
(12143,-1,3130202,77),
(12109,-1,3130202,78),
(12111,-1,3130202,79),
(12130,-1,3130202,80),
(12106,-1,3130202,81),
(12127,-1,3130202,82),
(12120,-1,3130202,83),
(12145,-1,3130202,84),
(12108,-1,3130202,85),
(12116,-1,3130202,86),
(12112,-1,3130202,87),
(12119,-1,3130202,88),
(12131,-1,3130202,89),
(12134,-1,3130202,90),
(12141,-1,3130202,91),
(12137,-1,3130202,92),
(12118,-1,3130202,93),
(12114,-1,3130202,94),
(12125,-1,3130202,95),
(12132,-1,3130202,96),
(12136,-1,3130202,97),
(12142,-1,3130202,98),
(12110,-1,3130202,99),
(12113,-1,3130202,100),
(12133,-1,3130202,101),
(12011,-1,3130203,0),
(12010,-1,3130203,1),
(12017,-1,3130203,2),
(12022,-1,3130203,3),
(12019,-1,3130203,4),
(12018,-1,3130203,5),
(12048,-1,3130203,6),
(12047,-1,3130203,7),
(12058,-1,3130203,8),
(12057,-1,3130203,9),
(12083,-1,3130203,10),
(12013,-1,3130203,11),
(12025,-1,3130203,12),
(12051,-1,3130203,13),
(12069,-1,3130203,14),
(12063,-1,3130203,15),
(12073,-1,3130203,16),
(12078,-1,3130203,17),
(12007,-1,3130203,18),
(12016,-1,3130203,19),
(12038,-1,3130203,20),
(12068,-1,3130203,21),
(12046,-1,3130203,22),
(12065,-1,3130203,23),
(12072,-1,3130203,24),
(12076,-1,3130203,25),
(12082,-1,3130203,26),
(12006,-1,3130203,27),
(12029,-1,3130203,28),
(12033,-1,3130203,29),
(12070,-1,3130203,30),
(12045,-1,3130203,31),
(12066,-1,3130203,32),
(12122,-1,3130203,33),
(12071,-1,3130203,34),
(12075,-1,3130203,35),
(12077,-1,3130203,36),
(12121,-1,3130203,37),
(12009,-1,3130203,38),
(12028,-1,3130203,39),
(12050,-1,3130203,40),
(12064,-1,3130203,41),
(12079,-1,3130203,42),
(12099,-1,3130203,43),
(12100,-1,3130203,44),
(12098,-1,3130203,45),
(12097,-1,3130203,46),
(12115,-1,3130203,47),
(12124,-1,3130203,48),
(12139,-1,3130203,49),
(12123,-1,3130203,50),
(12138,-1,3130203,51),

-- 30303
(12014,-1,3130302,0),
(12008,-1,3130302,1),
(12015,-1,3130302,2),
(12012,-1,3130302,3),
(12020,-1,3130302,4),
(12021,-1,3130302,5),
(12024,-1,3130302,6),
(12032,-1,3130302,7),
(12030,-1,3130302,8),
(12031,-1,3130302,9),
(12041,-1,3130302,10),
(12034,-1,3130302,11),
(12023,-1,3130302,12),
(12044,-1,3130302,13),
(12049,-1,3130302,14),
(12039,-1,3130302,15),
(12043,-1,3130302,16),
(12042,-1,3130302,17),
(12036,-1,3130302,18),
(12060,-1,3130302,19),
(12059,-1,3130302,20),
(12056,-1,3130302,21),
(12054,-1,3130302,22),
(12052,-1,3130302,23),
(12081,-1,3130302,24),
(12080,-1,3130302,25),
(12074,-1,3130302,26),
(12013,-1,3130302,27),
(12025,-1,3130302,28),
(12051,-1,3130302,29),
(12069,-1,3130302,30),
(12063,-1,3130302,31),
(12073,-1,3130302,32),
(12078,-1,3130302,33),
(12007,-1,3130302,34),
(12016,-1,3130302,35),
(12038,-1,3130302,36),
(12068,-1,3130302,37),
(12037,-1,3130302,38),
(12055,-1,3130302,39),
(12061,-1,3130302,40),
(12072,-1,3130302,41),
(12076,-1,3130302,42),
(12006,-1,3130302,43),
(12029,-1,3130302,44),
(12033,-1,3130302,45),
(12070,-1,3130302,46),
(12035,-1,3130302,47),
(12053,-1,3130302,48),
(12062,-1,3130302,49),
(12071,-1,3130302,50),
(12075,-1,3130302,51),
(12077,-1,3130302,52),
(12009,-1,3130302,53),
(12028,-1,3130302,54),
(12050,-1,3130302,55),
(12064,-1,3130302,56),
(12079,-1,3130302,57),
(12085,-1,3130302,58),
(12095,-1,3130302,59),
(12094,-1,3130302,60),
(12086,-1,3130302,61),
(12091,-1,3130302,62),
(12084,-1,3130302,63),
(12093,-1,3130302,64),
(12101,-1,3130302,65),
(12088,-1,3130302,66),
(12089,-1,3130302,67),
(12087,-1,3130302,68),
(12092,-1,3130302,69),
(12096,-1,3130302,70),
(12128,-1,3130302,71),
(12144,-1,3130302,72),
(12135,-1,3130302,73),
(12107,-1,3130302,74),
(12129,-1,3130302,75),
(12126,-1,3130302,76),
(12143,-1,3130302,77),
(12109,-1,3130302,78),
(12111,-1,3130302,79),
(12130,-1,3130302,80),
(12106,-1,3130302,81),
(12127,-1,3130302,82),
(12120,-1,3130302,83),
(12145,-1,3130302,84),
(12108,-1,3130302,85),
(12116,-1,3130302,86),
(12112,-1,3130302,87),
(12119,-1,3130302,88),
(12131,-1,3130302,89),
(12134,-1,3130302,90),
(12141,-1,3130302,91),
(12137,-1,3130302,92),
(12118,-1,3130302,93),
(12114,-1,3130302,94),
(12125,-1,3130302,95),
(12132,-1,3130302,96),
(12136,-1,3130302,97),
(12142,-1,3130302,98),
(12110,-1,3130302,99),
(12113,-1,3130302,100),
(12133,-1,3130302,101),
(12011,-1,3130303,0),
(12010,-1,3130303,1),
(12017,-1,3130303,2),
(12022,-1,3130303,3),
(12019,-1,3130303,4),
(12018,-1,3130303,5),
(12048,-1,3130303,6),
(12047,-1,3130303,7),
(12058,-1,3130303,8),
(12057,-1,3130303,9),
(12083,-1,3130303,10),
(12013,-1,3130303,11),
(12025,-1,3130303,12),
(12051,-1,3130303,13),
(12069,-1,3130303,14),
(12063,-1,3130303,15),
(12073,-1,3130303,16),
(12078,-1,3130303,17),
(12007,-1,3130303,18),
(12016,-1,3130303,19),
(12038,-1,3130303,20),
(12068,-1,3130303,21),
(12046,-1,3130303,22),
(12065,-1,3130303,23),
(12072,-1,3130303,24),
(12076,-1,3130303,25),
(12082,-1,3130303,26),
(12006,-1,3130303,27),
(12029,-1,3130303,28),
(12033,-1,3130303,29),
(12070,-1,3130303,30),
(12045,-1,3130303,31),
(12066,-1,3130303,32),
(12122,-1,3130303,33),
(12071,-1,3130303,34),
(12075,-1,3130303,35),
(12077,-1,3130303,36),
(12121,-1,3130303,37),
(12009,-1,3130303,38),
(12028,-1,3130303,39),
(12050,-1,3130303,40),
(12064,-1,3130303,41),
(12079,-1,3130303,42),
(12099,-1,3130303,43),
(12100,-1,3130303,44),
(12098,-1,3130303,45),
(12097,-1,3130303,46),
(12115,-1,3130303,47),
(12124,-1,3130303,48),
(12139,-1,3130303,49),
(12123,-1,3130303,50),
(12138,-1,3130303,51),

-- 31304
(12312,-1,3130401,0),
(12315,-1,3130401,1),
(12317,-1,3130401,2),
(12320,-1,3130401,3),
(12311,-1,3130401,4),
(12314,-1,3130401,5),
(12318,-1,3130401,6),
(12322,-1,3130401,7),
(12313,-1,3130401,8),
(12316,-1,3130401,9),
(12319,-1,3130401,10),
(12321,-1,3130401,11),
(12325,-1,3130401,12),
(12323,-1,3130401,13),
(12324,-1,3130401,14),
(12326,-1,3130401,15),
(12328,-1,3130401,16),
(12327,-1,3130401,17),
(12331,-1,3130401,18),
(12329,-1,3130401,19),
(12330,-1,3130401,20),
(12333,-1,3130401,21),
(12332,-1,3130401,22),
(12334,-1,3130401,23),
(12337,-1,3130401,24),
(12335,-1,3130401,25),
(12336,-1,3130401,26),

-- 31305
(12312,-1,3130501,0),
(12315,-1,3130501,1),
(12317,-1,3130501,2),
(12320,-1,3130501,3),
(12311,-1,3130501,4),
(12314,-1,3130501,5),
(12318,-1,3130501,6),
(12322,-1,3130501,7),
(12313,-1,3130501,8),
(12316,-1,3130501,9),
(12319,-1,3130501,10),
(12321,-1,3130501,11),
(12325,-1,3130501,12),
(12323,-1,3130501,13),
(12324,-1,3130501,14),
(12326,-1,3130501,15),
(12328,-1,3130501,16),
(12327,-1,3130501,17),
(12331,-1,3130501,18),
(12329,-1,3130501,19),
(12330,-1,3130501,20),
(12333,-1,3130501,21),
(12332,-1,3130501,22),
(12334,-1,3130501,23),
(12337,-1,3130501,24),
(12335,-1,3130501,25),
(12336,-1,3130501,26);


/************ 修正32007加爾巴-釣魚會員 ************/
Delete From npc_buffer Where npc_id in (1000003);
INSERT INTO `npc_buffer` VALUES
('1000003', '264', '1', '57', '100', '264'),
('1000003', '265', '1', '57', '100', '265'),
('1000003', '266', '1', '57', '100', '266'),
('1000003', '267', '1', '57', '100', '267'),
('1000003', '268', '1', '57', '100', '268'),
('1000003', '269', '1', '57', '100', '269'),
('1000003', '270', '1', '57', '100', '270'),
('1000003', '271', '1', '57', '100', '271'),
('1000003', '272', '1', '57', '100', '272'),
('1000003', '273', '1', '57', '100', '273'),
('1000003', '274', '1', '57', '100', '274'),
('1000003', '275', '1', '57', '100', '275'),
('1000003', '276', '1', '57', '100', '276'),
('1000003', '277', '1', '57', '100', '277'),
('1000003', '304', '1', '57', '100', '304'),
('1000003', '305', '1', '57', '100', '305'),
('1000003', '306', '1', '57', '100', '306'),
('1000003', '307', '1', '57', '100', '307'),
('1000003', '308', '1', '57', '100', '308'),
('1000003', '309', '1', '57', '100', '309'),
('1000003', '310', '1', '57', '100', '310'),
('1000003', '311', '1', '57', '100', '311'),
('1000003', '349', '1', '57', '100', '349'),
('1000003', '363', '1', '57', '100', '363'),
('1000003', '364', '1', '57', '100', '364'),
('1000003', '366', '1', '57', '100', '366'),
('1000003', '367', '1', '57', '100', '367'),
('1000003', '529', '1', '57', '100', '529'),
('1000003', '530', '1', '57', '100', '530'),
('1000003', '1032', '3', '57', '100', '1032'),
('1000003', '1033', '3', '57', '100', '1033'),
('1000003', '1035', '4', '57', '100', '1035'),
('1000003', '1036', '2', '57', '100', '1036'),
('1000003', '1040', '3', '57', '100', '1040'),
('1000003', '1043', '1', '57', '100', '1043'),
('1000003', '1044', '3', '57', '100', '1044'),
('1000003', '1045', '6', '57', '100', '1045'),
('1000003', '1048', '6', '57', '100', '1048'),
('1000003', '1059', '3', '57', '100', '1059'),
('1000003', '1062', '2', '57', '100', '1062'),
('1000003', '1068', '3', '57', '100', '1068'),
('1000003', '1077', '3', '57', '100', '1077'),
('1000003', '1078', '6', '57', '100', '1078'),
('1000003', '1085', '3', '57', '100', '1085'),
('1000003', '1086', '2', '57', '100', '1086'),
('1000003', '1182', '3', '57', '100', '1182'),
('1000003', '1189', '3', '57', '100', '1189'),
('1000003', '1191', '3', '57', '100', '1191'),
('1000003', '1204', '2', '57', '100', '1204'),
('1000003', '1240', '3', '57', '100', '1240'),
('1000003', '1242', '3', '57', '100', '1242'),
('1000003', '1243', '6', '57', '100', '1243'),
('1000003', '1303', '2', '57', '100', '1303'),
('1000003', '1397', '3', '57', '100', '1397');
