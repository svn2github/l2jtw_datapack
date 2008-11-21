/************ Made in Taiwan ************/

/************ 釣魚會員32007 修正 ************/
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


/************ 媽祖/普萊皮塔/愛心壺精的手鐲 修正 ************/
Delete From armor Where item_id in (20006,20007,20008,20012,13023);
INSERT INTO `armor` VALUES
(20006,'Agathion Seal Bracelet - Majo','lbracelet','true','none',150, 'wood','none',0,-1,0,0,0,0,0,'false','false','true','false','3267-1;21000-1;23000-1;'),
(20007,'Agathion Seal Bracelet - Gold Majo','lbracelet','true','none',150, 'wood','none',0,-1,0,0,0,0,0,'false','false','true','false','3267-1;21001-1;23001-1;'),
(20008,'Agathion Seal Bracelet - Black Majo','lbracelet','true','none',150, 'wood','none',0,-1,0,0,0,0,0,'false','false','true','false','3267-1;21002-1;23002-1;'),
(20012,'Agathion Seal Bracelet - Plaipitak','lbracelet','true','none',150, 'wood','none',0,-1,0,0,0,0,0,'false','false','true','false','3267-1;21003-1;23003-1;'),
(13023,'Agathion of Love - 30-day limited period','lbracelet','true','none',30, 'wood','none',0,-1,0,0,0,0,0,'false','false','true','false','3267-1;8245-1;');
