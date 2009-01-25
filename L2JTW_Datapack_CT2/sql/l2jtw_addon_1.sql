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
REPLACE INTO `npc` VALUES ('1501', '1501', 'Majo Agathion', '0', '', '0', 'LineageNPC2.Agathion_CL', '32.00', '23.56', '70', 'male', 'L2Npc', '40', '2444', '2444', '0.00', '0.00', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '253', '0', '253', '0', '0', null, '80', '120', 'NULL', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
REPLACE INTO `npc` VALUES ('1502', '1502', 'Gold Agathion', '0', '', '0', 'LineageNPC2.Agathion_CL', '32.00', '23.56', '70', 'male', 'L2Npc', '40', '2444', '2444', '0.00', '0.00', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '253', '0', '253', '0', '0', null, '80', '120', 'NULL', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
REPLACE INTO `npc` VALUES ('1503', '1503', 'Black Agathion', '0', '', '0', 'LineageNPC2.Agathion_CL', '32.00', '23.56', '70', 'male', 'L2Npc', '40', '2444', '2444', '0.00', '0.00', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '253', '0', '253', '0', '0', null, '80', '120', 'NULL', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
REPLACE INTO `npc` VALUES ('1504', '1504', 'Plaipitak Agathion', '0', '', '0', 'LineageNPC2.Agathion_CL', '32.00', '23.56', '70', 'male', 'L2Npc', '40', '2444', '2444', '0.00', '0.00', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '253', '0', '253', '0', '0', null, '80', '120', 'NULL', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
REPLACE INTO `npc` VALUES ('16049', '16049', 'Love Agathion', '0', '', '0', 'LineageNPC2.Agathion_CL', '32.00', '23.56', '70', 'male', 'L2Npc', '40', '2444', '2444', '0.00', '0.00', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '253', '0', '253', '0', '0', null, '80', '120', 'NULL', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
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
UPDATE `weapon` SET `skill` = '8244-1;' WHERE `item_id` in (12814); -- 守門人變身魔杖
UPDATE `weapon` SET `skill` = '8246-1;' WHERE `item_id` in (12800,13253,13324,13339); -- 南瓜變身魔杖


/************ 增加狩獵幫手 ************/
UPDATE `etcitem` SET `duration` = '300' WHERE `item_id` IN (13017,13018,13019,13020);
REPLACE INTO `npc` VALUES ('16043', '16043', 'Fox Shaman', '0', '', '0', 'LineageMonster4.foxian_wizard_pet', '10', '19', '70', 'male', 'L2Pet', '40', '2444', '2444', '0.00', '0.00', '40', '43', '30', '21', '20', '25', '0', '0', '500', '500', '500', '500', '253', '0', '253', '0', '0', '0', '80', '120', 'NULL', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'fighter', 'false');
REPLACE INTO `npc` VALUES ('16044', '16044', 'Wild Beast Fighter', '0', '', '0', 'LineageMonster4.beast_fighter_pet', '10', '17', '70', 'male', 'L2Pet', '40', '2444', '2444', '0.00', '0.00', '40', '43', '30', '21', '20', '25', '0', '0', '500', '500', '500', '500', '253', '0', '253', '0', '0', '0', '80', '120', 'NULL', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'fighter', 'false');
REPLACE INTO `npc` VALUES ('16045', '16045', 'White Weasel', '0', '', '0', 'LineageMonster4.ferret_pet', '10', '13', '70', 'male', 'L2Pet', '40', '2444', '2444', '0.00', '0.00', '40', '43', '30', '21', '20', '25', '0', '0', '500', '500', '500', '500', '253', '0', '253', '0', '0', '0', '80', '120', 'NULL', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'fighter', 'false');
REPLACE INTO `npc` VALUES ('16046', '16046', 'Fairy Princess', '0', '', '0', 'LineageMonster4.fairy_princess_pet', '10', '18', '70', 'male', 'L2Pet', '40', '2444', '2444', '0.00', '0.00', '40', '43', '30', '21', '20', '25', '0', '0', '500', '500', '500', '500', '253', '0', '253', '0', '0', '0', '80', '120', 'NULL', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'fighter', 'false');
REPLACE INTO `npcskills` VALUES
(16044,5745,1),
(16045,5745,1),
(16044,5746,1),
(16044,5747,1),
(16044,5748,1),
(16043,5753,1),
(16044,5753,1),
(16045,5753,1),
(16046,5753,1),
(16043,5749,1),
(16043,5750,1),
(16043,5751,1),
(16043,5752,1),
(16046,5752,1),
(16045,5771,1),
(16046,5771,1),
(16034,5771,1),
(16035,5771,1),
(16036,5771,1),
(14916,5761,1),
(14917,5761,1);
REPLACE INTO `pets_stats` VALUES
('Fox Shaman',16043,70,266966617,3161,1039,1075,1155,468,444,92,93,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,71,311043873,3250,1115,1085,1158,474,447,98,97,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,72,366944678,3340,1151,1097,1161,382,450,102,101,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,73,436722878,3433,1199,1108,1164,490,453,106,105,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,74,522505733,3527,1247,1119,1167,497,456,110,109,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,75,626774887,3621,1299,1130,1170,505,459,114,113,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,76,772136519,3718,1350,1142,1173,512,462,118,117,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,77,944761536,3815,1403,1154,1176,521,465,122,121,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,78,1148089335,3985,1465,1140,1180,549,468,126,125,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,79,1386786292,4009,1514,1179,1184,537,471,130,129,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,80,1664975622,4109,1572,1192,1188,545,474,134,133,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,81,1998969732,4209,1632,1205,1192,553,477,138,137,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,82,2379093816,4311,1693,1219,1196,561,480,142,141,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,83,2831502296,4416,1756,1233,1200,570,483,146,145,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,84,3340379889,4521,1821,1248,1204,579,486,150,149,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,85,3905839397,4629,1887,1263,1208,588,489,154,153,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fox Shaman',16043,86,4567019890,4740,1955,1278,1212,597,492,158,157,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,70,266966617,4647,623,1688,578,468,444,92,93,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,71,311043873,4778,669,1703,579,474,447,98,97,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,72,366944678,4910,691,1722,581,382,450,102,101,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,73,436722878,5047,719,1740,582,490,453,106,105,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,74,522505733,5185,748,1757,584,497,456,110,109,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,75,626774887,5323,779,1774,585,505,459,114,113,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,76,772136519,5465,810,1793,587,512,462,118,117,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,77,944761536,5608,842,1812,588,521,465,122,121,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,78,1148089335,5845,879,1791,589,549,468,126,125,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,79,1386786292,5893,908,1851,592,537,471,130,129,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,80,1664975622,6040,943,1871,594,545,474,134,133,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,81,1998969732,6187,979,1892,596,553,477,138,137,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,82,2379093816,6337,1016,1914,598,561,480,142,141,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,83,2831502296,6492,1054,1936,600,570,483,146,145,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,84,3340379889,6646,1093,1959,602,579,486,150,149,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,85,3905839397,6805,1132,1983,604,588,489,154,153,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Wild Beast Fighter',16044,86,4567019890,6968,1173,2006,606,597,492,158,157,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,70,266966617,3856,1320,1381,866,468,444,92,93,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,71,311043873,3965,1416,1394,869,474,447,98,97,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,72,366944678,4075,1462,1409,871,382,450,102,101,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,73,436722878,4188,1523,1423,873,490,453,106,105,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,74,522505733,4303,1584,1437,875,497,456,110,109,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,75,626774887,4418,1650,1451,878,505,459,114,113,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,76,772136519,4536,1715,1467,880,512,462,118,117,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,77,944761536,4654,1782,1482,882,521,465,122,121,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,78,1148089335,4871,1856,1464,883,549,468,126,125,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,79,1386786292,4891,1923,1514,888,537,471,130,129,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,80,1664975622,5013,1996,1531,891,545,474,134,133,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,81,1998969732,5135,2073,1547,894,553,477,138,137,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,82,2379093816,5259,2150,1565,897,561,480,142,141,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,83,2831502296,5388,2230,1583,900,570,483,146,145,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,84,3340379889,5516,2313,1602,903,579,486,150,149,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,85,3905839397,5647,2396,1622,906,588,489,154,153,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('White Weasel',16045,86,4567019890,5783,2483,1642,909,597,492,158,157,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,70,266966617,3477,1386,1075,961,468,444,92,93,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,71,311043873,3575,1487,1085,963,474,447,98,97,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,72,366944678,3674,1535,1097,966,382,450,102,101,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,73,436722878,3777,1599,1108,968,490,453,106,105,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,74,522505733,3880,1663,1119,971,497,456,110,109,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,75,626774887,3983,1733,1130,973,505,459,114,113,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,76,772136519,4090,1801,1142,976,512,462,118,117,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,77,944761536,4197,1872,1154,978,521,465,122,121,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,78,1148089335,4384,1954,1140,982,549,468,126,125,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,79,1386786292,4410,2020,1179,985,537,471,130,129,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,80,1664975622,4520,2097,1192,988,545,474,134,133,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,81,1998969732,4630,2177,1205,992,553,477,138,137,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,82,2379093816,4743,2258,1219,995,561,480,142,141,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,83,2831502296,4858,2343,1233,998,570,483,146,145,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,84,3340379889,4974,2429,1248,1002,579,486,150,149,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,85,3905839397,5092,2517,1263,1005,588,489,154,153,44,187,278,333,100000000,0,0,92287,40,15,0.05),
('Fairy Princess',16046,86,4567019890,5214,2608,1278,1008,597,492,158,157,44,187,278,333,100000000,0,0,92287,40,15,0.05);


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
Delete From npc Where `id` in (32491,32497,32498,32499,32503,32513,32514,32515,32516,13135,14916,14917); -- 地下競技場助手/調查官 艾德勒/惡魔島的復活者/肯特拉獸人 咒術士/地下競技場的入場管理員/南瓜幽靈/底格里斯
INSERT INTO `npc` VALUES ('32491', '32491', 'Underground Coliseum Helper', '0', '', '0', 'LineageNPCs2.TP_battlezone_staff', '7.8', '17.29', '70', 'male', 'L2Teleporter', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '278', '0', '333', '0', '0', '0', '50', '100', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32497', '32497', 'Inspector Adler', '0', '', '1', 'NPC.a_mageguild_teacher_MElf', '7.00', '22.20', '70', 'male', 'L2Npc', '40', '3862', '1493', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '1314', '470', '780', '382', '278', '0', '333', '0', '0', '0', '55', '132', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32498', '32498', 'Devil\'s Isle Survivor', '0', '', '0', 'LineageNPC.a_fighterguild_teacher_MHuman', '8', '23', '70', 'male', 'L2Npc', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '278', '0', '333', '0', '0', '0', '50', '120', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32499', '32499', 'Ketra Orc Shaman', '0', '', '0', 'LineageMonster.ketra_orc_shaman_20_bi', '30.00', '23.56', '70', 'male', 'L2Npc', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '253', '0', '253', '0', '0', '0', '80', '120', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32503', '32503', 'Entrance Manager', '0', '', '0', 'LineageNPC.e_smith_master_MDwarf', '8', '17', '1', 'male', 'L2Teleporter', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '253', '0', '253', '0', '0', '0', '80', '120', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32513', '32513', 'Kun', '0', '', '0', 'LineageNPCs2.TP_battlezone_staff', '7.8', '17.29', '70', 'male', 'L2Teleporter', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '278', '0', '333', '0', '0', '0', '50', '100', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32514', '32514', 'Tarion', '0', '', '0', 'LineageNPCs2.TP_battlezone_staff', '7.8', '17.29', '70', 'male', 'L2Teleporter', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '278', '0', '333', '0', '0', '0', '50', '100', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32515', '32515', 'Leo', '0', '', '0', 'LineageNPCs2.TP_battlezone_staff', '7.8', '17.29', '70', 'male', 'L2Teleporter', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '278', '0', '333', '0', '0', '0', '50', '100', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('32516', '32516', 'Candice', '0', '', '0', 'LineageNPCs2.TP_battlezone_staff', '7.8', '17.29', '70', 'male', 'L2Teleporter', '40', '2444', '2444', '0', '0', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '278', '0', '333', '0', '0', '0', '50', '100', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('13135', '13135', 'Pumpkin Ghost', '0', '', '0', 'Npc2.Pumpkin_Head_man', '8.00', '25.00', '70', 'etc', 'L2Npc', '40', '3862', '1493', '11.85', '2.78', '40', '43', '30', '21', '20', '10', '0', '0', '1314', '470', '780', '382', '278', '0', '333', '0', '0', '0', '50', '120', 'NULL', '0', '1', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
INSERT INTO `npc` VALUES ('14916', '14916', 'Tigress', '0', '', '0', 'LineageMonster.saber_toothed_tiger_070p', '8.00', '20.00', '63', 'female', 'L2Monster', '40', '3862', '1722', '11.85', '2.78', '40', '43', '30', '21', '20', '25', '0', '0', '1335', '470', '780', '440', '282', '0', '333', '0', '0', '0', '88', '187', 'NULL', '0', '0', '0', 'LAST_HIT', '4', '4', '0', 'fighter', 'false');
INSERT INTO `npc` VALUES ('14917', '14917', 'Tigress', '0', '', '0', 'LineageMonster.saber_toothed_tiger_070p', '8.00', '20.00', '67', 'female', 'L2Monster', '40', '3862', '1722', '11.85', '2.78', '40', '43', '30', '21', '20', '25', '0', '0', '1335', '470', '780', '440', '282', '0', '333', '0', '0', '0', '88', '187', 'NULL', '0', '0', '0', 'LAST_HIT', '4', '4', '0', 'fighter', 'false');
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
-- 更新暗雲宅邸NPC
REPLACE INTO `npc` VALUES ('18369', '18369', 'Chromatic Crystaline Golem', '0', '', '0', 'LineageMonster4.Crystal_Golem', '40.00', '47.00', '82', 'male', 'L2Monster', '40', '4663', '1633', '0.00', '0.00', '45', '45', '43', '42', '45', '43', '9308', '1016', '2224', '730', '1199', '950', '277', '500', '253', '0', '0', '0', '80', '120', 'CHROMATIC_GOLEM_CLAN', '700', '0', '0', 'LAST_HIT', '5', '5', '0', 'balanced', 'false');
REPLACE INTO `npc` VALUES ('18370', '18370', 'Chromatic Crystaline Golem', '0', '', '0', 'LineageMonster4.Crystal_Golem', '40.00', '47.00', '82', 'male', 'L2Monster', '40', '4664', '1445', '0.00', '0.00', '45', '41', '42', '43', '42', '45', '9308', '1016', '2001', '730', '1199', '950', '391', '500', '391', '0', '0', '0', '80', '120', 'CHROMATIC_GOLEM_CLAN', '700', '0', '0', 'LAST_HIT', '0', '5', '0', 'balanced', 'false');
REPLACE INTO `npc` VALUES ('18371', '18371', 'Beleth Sample', '0', '', '0', 'LineageMonster3.zombie_gateguard', '17.00', '30.50', '82', 'male', 'L2Monster', '40', '4663', '2444', '0.00', '0.00', '44', '44', '44', '55', '55', '55', '3848', '420', '2305', '665', '2305', '765', '320', '0', '320', '8217', '0', '0', '0', '120', '', '0', '1', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
REPLACE INTO `npc` VALUES ('18372', '18372', 'Beleth Sample', '0', '', '0', 'LineageMonster3.zombie_laborer', '11.00', '24.60', '82', 'male', 'L2Monster', '40', '2332', '1436', '0.00', '0.00', '40', '41', '41', '20', '20', '20', '3848', '420', '2445', '990', '1880', '1120', '310', '100', '310', '8529', '0', '0', '0', '120', '', '0', '1', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
REPLACE INTO `npc` VALUES ('18373', '18373', 'Beleth Sample', '0', '', '0', 'LineageMonster3.zombie_enlisted_man', '17.00', '22.30', '81', 'male', 'L2Monster', '40', '2332', '1637', '0.00', '0.00', '41', '41', '44', '40', '40', '40', '3848', '420', '2557', '766', '1264', '775', '330', '100', '330', '0', '0', '0', '0', '120', '', '0', '1', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
REPLACE INTO `npc` VALUES ('18374', '18374', 'Beleth Sample', '0', '', '0', 'LineageMonster3.zombie_em_knight', '17.00', '22.30', '82', 'male', 'L2Monster', '40', '2332', '1637', '0.00', '0.00', '45', '45', '45', '40', '40', '40', '3848', '420', '2554', '745', '1225', '775', '391', '0', '391', '8219', '0', '0', '0', '127', '', '0', '1', '0', 'LAST_HIT', '100', '50', '30', 'balanced', 'false');
REPLACE INTO `npc` VALUES ('18375', '18375', 'Beleth Sample', '0', '', '0', 'LineageMonster.skeleton_royal_guard', '11.00', '28.50', '82', 'male', 'L2Monster', '40', '1554', '1225', '3.00', '3.00', '41', '31', '35', '40', '40', '40', '3848', '420', '2557', '756', '1225', '775', '333', '0', '333', '946', '945', '0', '0', '120', '', '0', '1', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
REPLACE INTO `npc` VALUES ('18376', '18376', 'Beleth Sample', '0', '', '0', 'LineageMonster.vale_master', '16.00', '47.00', '82', 'male', 'L2Monster', '40', '2332', '2664', '0.00', '0.00', '55', '40', '55', '40', '40', '40', '3848', '420', '2554', '760', '1355', '825', '333', '0', '333', '205', '0', '0', '0', '120', '', '0', '1', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
REPLACE INTO `npc` VALUES ('18377', '18377', 'Beleth Sample', '0', '', '0', 'LineageMonster.skeleton_knight', '10.00', '25.00', '82', 'male', 'L2Monster', '40', '2332', '2664', '0.00', '0.00', '40', '40', '40', '20', '20', '20', '3848', '420', '2554', '760', '1220', '825', '278', '0', '333', '150', '103', '0', '0', '120', '', '0', '1', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
REPLACE INTO `npc` VALUES ('22264', '22264', 'Castalia', '0', '', '0', 'LineageMonster4.tears_d', '20.00', '28.00', '82', 'female', 'L2Monster', '40', '4663', '1934', '26.86', '3.09', '42', '45', '42', '25', '22', '24', '13088', '1431', '1912', '598', '1220', '485', '310', '200', '560', '9638', '9638', '0', '60', '180', 'water_clan', '400', '0', '0', 'LAST_HIT', '50', '50', '75', 'balanced', 'true');
REPLACE INTO `npc` VALUES ('22272', '22272', 'Beleth\'s Minion', '0', '', '0', 'LineageMonster.vale_master', '12.00', '40.00', '82', 'male', 'L2Monster', '40', '9327', '1442', '26.86', '3.09', '40', '43', '41', '21', '20', '10', '16529', '1727', '2554', '735', '1220', '865', '310', '0', '333', '0', '0', '0', '0', '192', 'BELETH_MINION_CLAN', '200', '1', '0', 'LAST_HIT', '0', '0', '0', 'fighter', 'false');
REPLACE INTO `npc` VALUES ('22273', '22273', 'Beleth\'s Minion', '0', '', '0', 'LineageMonster.silhouette', '8.00', '23.00', '82', 'male', 'L2Monster', '40', '9327', '1448', '26.86', '3.09', '51', '52', '54', '32', '31', '32', '15999', '1669', '1912', '650', '1880', '865', '372', '0', '333', '0', '0', '0', '88', '192', 'BELETH_MINION_CLAN', '200', '1', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
REPLACE INTO `npc` VALUES ('22274', '22274', 'Beleth\'s Minion', '0', '', '0', 'LineageMonster.shadeless', '7.00', '28.00', '82', 'male', 'L2Monster', '40', '9327', '2662', '26.86', '3.09', '40', '43', '40', '21', '20', '20', '16318', '1705', '2557', '702', '1220', '765', '325', '0', '325', '0', '0', '0', '0', '192', 'BELETH_MINION_CLAN', '200', '1', '0', 'LAST_HIT', '0', '0', '0', 'fighter', 'false');
REPLACE INTO `npc` VALUES ('22402', '22402', 'Shadow Column', '0', '', '0', 'LineageNpcEV.dark_clouds_chessman', '60.00', '79.00', '82', 'male', 'L2Monster', '40', '2332', '1884', '67.15', '3.09', '65', '65', '65', '45', '45', '45', '4232', '465', '0', '735', '1220', '765', '355', '0', '355', '0', '0', '0', '0', '0', '', '0', '0', '0', 'LAST_HIT', '0', '0', '0', 'balanced', 'false');
REPLACE INTO `npcskills` VALUES ('18369', '4101', '10');
REPLACE INTO `npcskills` VALUES ('18369', '4303', '1');
REPLACE INTO `npcskills` VALUES ('18369', '4410', '15');
REPLACE INTO `npcskills` VALUES ('18369', '4411', '15');
REPLACE INTO `npcskills` VALUES ('18369', '4789', '5');
REPLACE INTO `npcskills` VALUES ('18370', '4101', '10');
REPLACE INTO `npcskills` VALUES ('18370', '4303', '1');
REPLACE INTO `npcskills` VALUES ('18370', '4410', '16');
REPLACE INTO `npcskills` VALUES ('18370', '4411', '15');
REPLACE INTO `npcskills` VALUES ('18370', '4477', '10');
REPLACE INTO `npcskills` VALUES ('18370', '4597', '10');
REPLACE INTO `npcskills` VALUES ('18370', '4789', '5');
REPLACE INTO `npcskills` VALUES ('18371', '4303', '1');
REPLACE INTO `npcskills` VALUES ('18371', '4413', '8');
REPLACE INTO `npcskills` VALUES ('18371', '4573', '8');
REPLACE INTO `npcskills` VALUES ('18371', '4670', '12');
REPLACE INTO `npcskills` VALUES ('18371', '5202', '8');
REPLACE INTO `npcskills` VALUES ('18372', '4077', '6');
REPLACE INTO `npcskills` VALUES ('18372', '4257', '6');
REPLACE INTO `npcskills` VALUES ('18372', '4303', '1');
REPLACE INTO `npcskills` VALUES ('18372', '4410', '16');
REPLACE INTO `npcskills` VALUES ('18372', '4411', '16');
REPLACE INTO `npcskills` VALUES ('18372', '4413', '9');
REPLACE INTO `npcskills` VALUES ('18373', '4247', '5');
REPLACE INTO `npcskills` VALUES ('18373', '4303', '1');
REPLACE INTO `npcskills` VALUES ('18373', '4410', '15');
REPLACE INTO `npcskills` VALUES ('18373', '4411', '14');
REPLACE INTO `npcskills` VALUES ('18373', '4413', '11');
REPLACE INTO `npcskills` VALUES ('18374', '4086', '1');
REPLACE INTO `npcskills` VALUES ('18374', '4244', '6');
REPLACE INTO `npcskills` VALUES ('18374', '4303', '1');
REPLACE INTO `npcskills` VALUES ('18374', '4410', '15');
REPLACE INTO `npcskills` VALUES ('18374', '4411', '17');
REPLACE INTO `npcskills` VALUES ('18374', '4413', '10');
REPLACE INTO `npcskills` VALUES ('18374', '4471', '1');
REPLACE INTO `npcskills` VALUES ('18375', '4085', '1');
REPLACE INTO `npcskills` VALUES ('18375', '4086', '1');
REPLACE INTO `npcskills` VALUES ('18375', '4088', '5');
REPLACE INTO `npcskills` VALUES ('18375', '4303', '1');
REPLACE INTO `npcskills` VALUES ('18375', '4410', '15');
REPLACE INTO `npcskills` VALUES ('18375', '4411', '15');
REPLACE INTO `npcskills` VALUES ('18375', '4413', '10');
REPLACE INTO `npcskills` VALUES ('18376', '4078', '5');
REPLACE INTO `npcskills` VALUES ('18376', '4094', '8');
REPLACE INTO `npcskills` VALUES ('18376', '4097', '10');
REPLACE INTO `npcskills` VALUES ('18376', '4099', '2');
REPLACE INTO `npcskills` VALUES ('18376', '4303', '1');
REPLACE INTO `npcskills` VALUES ('18376', '4410', '15');
REPLACE INTO `npcskills` VALUES ('18376', '4411', '15');
REPLACE INTO `npcskills` VALUES ('18376', '4413', '10');
REPLACE INTO `npcskills` VALUES ('18377', '4078', '7');
REPLACE INTO `npcskills` VALUES ('18377', '4101', '8');
REPLACE INTO `npcskills` VALUES ('18377', '4303', '1');
REPLACE INTO `npcskills` VALUES ('18377', '4410', '12');
REPLACE INTO `npcskills` VALUES ('22264', '4257', '10');
REPLACE INTO `npcskills` VALUES ('22264', '4410', '14');
REPLACE INTO `npcskills` VALUES ('22264', '4411', '15');
REPLACE INTO `npcskills` VALUES ('22264', '4419', '5');
REPLACE INTO `npcskills` VALUES ('22264', '4789', '8');
REPLACE INTO `npcskills` VALUES ('22272', '4304', '1');
REPLACE INTO `npcskills` VALUES ('22272', '4410', '15');
REPLACE INTO `npcskills` VALUES ('22273', '4152', '10');
REPLACE INTO `npcskills` VALUES ('22273', '4303', '1');
REPLACE INTO `npcskills` VALUES ('22273', '4411', '21');
REPLACE INTO `npcskills` VALUES ('22274', '4303', '1');
REPLACE INTO `npcskills` VALUES ('22274', '4410', '15');
REPLACE INTO `npcskills` VALUES ('22402', '4303', '1');
REPLACE INTO `npcskills` VALUES ('22402', '5225', '1');
-- 加入黎明/黃昏的神諭處可觀看比賽
REPLACE INTO `npc` VALUES ('830000', '31031', 'Broadcasting Tower', '0', '', '0', 'NPC.broadcasting_tower', '7.00', '35.00', '70', 'etc', 'L2Observation', '40', '3862', '1493', '11.85', '2.78', '40', '43', '30', '21', '20', '10', '0', '0', '1314', '470', '780', '382', '278', '0', '333', '0', '0', '0', '55', '132', 'NULL', '0', '1', '0', 'LAST_HIT', '0', '0', '0', 'fighter', 'false');
UPDATE `spawnlist` SET `npc_templateid` = '830000' WHERE `id` in (48128,48129,48130,48131);


/************ 增加寵物/使魔的技能(攻城高崙/鬃狼/座狼/座龍/聖恩獸) ************/
REPLACE INTO `npcskills` VALUES
(14738,4079,1),
(14739,4079,1),
(14740,4079,1),
(14741,4079,1),
(14742,4079,1),
(14743,4079,1),
(14744,4079,1),
(14745,4079,1),
(14746,4079,1),
(14747,4079,1),
(14748,4079,1),
(14749,4079,1),
(14750,4079,1),
(14751,4079,1),
(14752,4079,1),
(14753,4079,1),
(14754,4079,1),
(14755,4079,1),
(14756,4079,1),
(14757,4079,1),
(14758,4079,1),
(14759,4079,1),
(14760,4079,1),
(14761,4079,1),
(14762,4079,1),
(14763,4079,1),
(14764,4079,1),
(14765,4079,1),
(14766,4079,1),
(14767,4079,1),
(14870,5580,1),
(14870,5581,1),
(14870,5582,1),
(14870,5583,1),
(16025,5442,1),
(16037,5442,2),
(16041,5442,3),
(16042,5442,4),
(16025,5443,1),
(16037,5443,2),
(16041,5443,3),
(16042,5443,4),
(16025,5444,1),
(16037,5444,1),
(16041,5444,2),
(16042,5444,2),
(16025,5445,1),
(16037,5445,1),
(16041,5445,1),
(16042,5445,1),
(16037,5584,1),
(16042,5584,1),
(16038,5585,1),
(16039,5585,1);
