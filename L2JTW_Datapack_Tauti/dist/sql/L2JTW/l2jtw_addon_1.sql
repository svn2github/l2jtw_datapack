/************ Made in Taiwan ************/

-- 修正NPC設定
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (30880,30881,30882,30883,30884,30885,30886,30887,30888,30889); -- 刪除官服不存在的NPC

-- 修正NPC掉落:修正封印大天使的掉落,因為spawnlist只有21070封印大天使,沒有21071封印大天使
UPDATE `droplist` SET `mobId` = 21070 WHERE `mobId` = 21071;

-- 導入l2jtw_addon_1.sql後,就可以馬上挑戰BOSS(等待下次挑戰的時間歸0)
REPLACE INTO `grandboss_data` VALUES
(29001, -21610, 181594, -5734, 0, 0, 229898.48, 667.776, 0), -- 巨蟻女王 (40)
(29006, 17726, 108915, -6480, 0, 0, 622493.58388, 3793.536, 0), -- 核心 (50)
(29014, 55024, 17368, -5412, 10126, 0, 622493.58388, 3793.536, 0), -- 奧爾芬 (50)
(29019, 185708, 114298, -8221, 32768, 0, 17850000, 39960, 0), -- 安塔瑞斯 (79)
(29020, 116033, 17447, 10104, 40188, 0, 4068372, 39960, 0), -- 巴溫 (75)
(29022, 55312, 219168, -3223, 0, 0, 858518.36, 399600, 0), -- 札肯 (60)
(29028, -105200, -253104, -15264, 0, 0, 223107426.1796109, 4497143.692870192, 0), -- 巴拉卡斯 (85)
(29066, 185708, 114298, -8221,32768, 0, 14518000, 3996000, 0), -- 安塔瑞斯 覺醒 (79)
(29067, 185708, 114298, -8221,32768, 0, 16184000, 3996000, 0), -- 安塔瑞斯 常 (79)
(29068, 185708, 114298, -8221,32768, 0, 204677324.07859, 3996000, 0), -- 安塔瑞斯 強壯 (85)
(29045, 0, 0, 0, 0, 0, 1018821.42723286, 52001.06567747795, 0), -- 芙琳泰沙 (85)
(29065, -123348, -248881, -15537, 44732, 0, 1532678, 4255, 0), -- 賽爾蘭
(29099, 153569, 142075, -12732, 60025, 0, 1448567, 3718, 0), -- 巴爾勒
(29118, 0, 0, 0, 0, 0, 4109288, 1220547, 0); -- 巴列斯 (83)

-- 修正賽爾蘭/巴爾勒
UPDATE `npc` SET `hp` = '1532678', `mp` = '4255', `type` = 'L2GrandBoss', `level` = '87' WHERE `id` IN (29065);
UPDATE `npc` SET `atkspd` = '540', `matkspd` = '253', `walkspd` = '80', `runspd` = '120' WHERE `id` IN (29099);
UPDATE `npc` SET `collision_radius` = '38.00', `collision_height` = '77.00' WHERE `id` IN (29108);
DELETE FROM `npcskills` Where `skillid` IN (5118);
REPLACE INTO `droplist` VALUES
(29099,6578,1,10,2,500000),
(29099,9458,1,1,1,300000),
(29099,9467,1,1,1,300000),
(29099,10170,1,1,1,1000000),
(29099,57,180000,220000,0,1000000);
REPLACE INTO `npcskills` VALUES
(29099,4298,1),
(29099,4422,5),
(29099,4789,1),
(29100,4305,1);

-- 修正城堡資料庫的PRIMARY KEY,由name改為id,以防止中文化後,還可以導入英文名稱的城堡資料庫
ALTER TABLE `castle` DROP PRIMARY KEY, ADD PRIMARY KEY (`id`);

-- 修正攻城的預設時間:古魯丁/狄恩/亞丁/魯因/修加特為星期日20:00,奇岩/歐瑞/因納得立/高達特為星期日16:00(只限全新安裝資料庫才有效)
UPDATE `castle` SET `siegeDate` = '978782400000' WHERE `siegeDate` = '0' AND `id` IN (1,2,5,8,9);
UPDATE `castle` SET `siegeDate` = '979459200000' WHERE `siegeDate` = '0' AND `id` IN (3,4,6,7);

-- 修正狩獵首領重生時，HP/MP全滿 (感謝 wolo 提供)
Update `npc`, `raidboss_spawnlist` SET `raidboss_spawnlist`.`heading`=0, `raidboss_spawnlist`.`currentHp`=`npc`.`hp`,`raidboss_spawnlist`.`currentMp`=`npc`.`mp` WHERE `npc`.`type`='L2RaidBoss' AND `npc`.`id`=`raidboss_spawnlist`.`boss_id`;

-- 碼頭巡邏兵改成AI控制
Delete From `spawnlist` Where `npc_templateid` in (32628,32629);

-- 修正NPC
UPDATE `npc` SET `type` = 'L2Npc' WHERE `id` IN (32628,32629); -- 碼頭巡邏兵的類型改為一般NPC
UPDATE `npc` SET `type` = 'L2Teleporter' WHERE `id` IN (32540,32542,32602); -- 深淵的守門人/安定的再生種子/臨時傳送師的類型改為傳送
UPDATE `npc` SET `type` = 'L2Monster' WHERE `id` IN (29030,29033,29036,29037); -- 魔狼的類型"暫時"改為一般怪物

-- 加入新傳送
REPLACE INTO `teleport` VALUES
('3254001', '3254001', '-212836', '209824', '4288', '0', '0', '57'),   -- 深淵的守門人
('3260201', '3260201', '-245833', '220174', '-12104', '0', '0', '57'), -- 臨時傳送師
('3260202', '3260202', '-251624', '213420', '-12072', '0', '0', '57'), -- 臨時傳送師
('3260203', '3260203', '-249774', '207316', '-11952', '0', '0', '57'); -- 臨時傳送師

-- 刪除村莊的彩券商人,因為官服沒有彩券商人
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (30990,30992,30993,30994);

-- 「新說話之島村莊」加入轉職管理員
REPLACE INTO `spawnlist` (`location`, `count`, `npc_templateid`, `locx`, `locy`, `locz`, `heading`, `respawn_delay`) VALUES
('新說話之島村莊',1,31756,-113661,255162,-1499,33264,60),
('新說話之島村莊',1,31757,-113658,255456,-1499,32414,60);

-- 刪除其中一隻轉職管理員(不定時改刪另一個)
-- DELETE FROM `spawnlist` WHERE `npc_templateid` IN (31756);
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (31757);


/************ Add by pmq *********/
-- 加入漏掉的NPC
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (35601,35602,35603,35605,35623,35624,35628,35638,35639,35640,35641,35642,32761,32777,32778,32781); -- 刪除不正確位置的NPC
INSERT INTO `spawnlist` (location,count,npc_templateid,locx,locy,locz,randomx,randomy,heading,respawn_delay,loc_id,periodOfDay) VALUES
('unset', 1, 35638, 56736, -26400, 568, 0, 0, 49000, 60, 0, 0),      -- 巴倫斯 飛龍管理員
('unset', 1, 35639, 58128, -32000, 296, 0, 0, 0, 60, 0, 0),          -- 傑卡德 傳令
('unset', 1, 35640, 58024, -25744, 592, 0, 0, 49000, 60, 0, 0),      -- 凡德羅 執事
('unset', 1, 35641, 58080, -29552, 568, 0, 0, 49000, 60, 0, 0),      -- 要塞守門人
('unset', 1, 35641, 58137, -29223, 568, 0, 0, 16500, 60, 0, 0),      -- 要塞守門人
('unset', 1, 35642, 58024, -26456, 592, 0, 0, 49000, 60, 0, 0),      -- 要塞守門人
('unset', 1, 35642, 58074, -26325, 597, 0, 0, 15732, 60, 0, 0),      -- 要塞守門人
('unset', 1, 32778, 102471, -124260, -2774, 0, 0, 47093, 60, 0, 0),  -- 傭兵戰士 吉妮亞工會
('unset', 1, 32777, 102305, -124365, -2759, 0, 0, 63881, 60, 0, 0),  -- 上級騎士 吉妮亞工會
('unset', 1, 32761, 102537, -124429, -2792, 0, 0, 30357, 60, 0, 0),  -- 凱高爾
('unset', 1, 32781, 102393, -124493, -2787, 0, 0, 17538, 60, 0, 0);  -- 吉妮亞

-- 怪物手拿武器
UPDATE `npc` SET`rhand`= 127 where id = 22485;
UPDATE `npc` SET`rhand`= 127 where id = 22486;
UPDATE `npc` SET`rhand`= 72 where id = 22487;
UPDATE `npc` SET`rhand`= 201 where id = 25616;
UPDATE `npc` SET`rhand`= 72 where id = 29130;
UPDATE `npc` SET`rhand`= 201 where id = 29131;
UPDATE `npc` SET`rhand`= 68 where id = 22488;
UPDATE `npc` SET`rhand`= 68 where id = 22489;
UPDATE `npc` SET`rhand`= 93 where id = 22490;
UPDATE `npc` SET`rhand`= 221 where id = 25617;
UPDATE `npc` SET`rhand`= 16 where id = 29133;
UPDATE `npc` SET`rhand`= 159 where id = 29134;
UPDATE `npc` SET`rhand`= 946, `lhand`= 945 where id = 22495;
UPDATE `npc` SET`rhand`= 124 where id = 29138;
UPDATE `npc` SET`rhand`= 148 where id = 22500;
UPDATE `npc` SET`rhand`= 148 where id = 22501;
UPDATE `npc` SET`rhand`= 148 where id = 22502;
UPDATE `npc` SET`rhand`= 8221 where id = 25621;
UPDATE `npc` SET`rhand`= 8221 where id = 29144;
UPDATE `npc` SET`rhand`= 6717 where id = 29145;
UPDATE `npc` SET`rhand`= 6718 where id = 29146;
UPDATE `npc` SET`rhand`= 78 where id = 25622;
UPDATE `npc` SET`rhand`= 1472 where id = 22364;
UPDATE `npc` SET`rhand`= 6722 where id = 22449;
UPDATE `npc` SET`rhand`= 13983 where id = 25648;
UPDATE `npc` SET`rhand`= 78 where id = 22368;

-- 修改地獄之島怪物
UPDATE `npc` SET `type`='L2Monster', `level`=83, `hp`=3835, `mp`=1777, `exp`=0, `sp`=0, `walkspd`=0, `runspd`=0 where id='18484';  -- 奈雅塔門
UPDATE `npc` SET `level`=81, `hp`=338766, `mp`=1708, `exp`=2629657, `sp`=267913 where id='22326';         -- 奈雅的守護者 海琳納克
UPDATE `npc` SET `level`=81, `hp`=111546, `mp`=1846, `exp`=0, `sp`=0 where id='18466';                    -- 外廓警衛隊長
UPDATE `npc` SET `level`=86, `hp`=194672, `mp`=1881, `exp`=944308, `sp`=93684 where id='22448';           -- 雷歐達斯 反抗軍指揮官
UPDATE `npc` SET `level`=86, `hp`=4439, `mp`=1881, `exp`=16123, `sp`=1680 where id='22451';               -- 原住民精銳軍
UPDATE `npc` SET `level`=81, `hp`=197755, `mp`=1708, `exp`=449479, `sp`=47956 where id='22341';           -- 凱達士
UPDATE `npc` SET `level`=81, `hp`=3461, `mp`=1708, `exp`=12425, `sp`=1325 where id='22342';               -- 達里昂的執行者
UPDATE `npc` SET `level`=81, `hp`=3461, `mp`=1708, `exp`=9997, `sp`=1066 where id='22343';                -- 達里昂的處刑者

-- Seed OF Destruction
UPDATE `npc` SET `type`='L2Monster' where id='29167';  --

REPLACE INTO npcskills VALUES
-- 龍馬軍 步兵
-- Dragon Steed Troop Infantry
(22541,4299,1),
-- 龍馬軍 步兵
-- Dragon Steed Troop Infantry
(22597,4299,1),
-- 龍馬軍 步兵
-- Dragon Steed Troop Infantry
(22589,4299,1),
-- 龍馬軍 步兵
-- Dragon Steed Troop Infantry
(22575,4299,1),
(22575,5827,6),
-- 黑暗祭司
-- Priest of Darkness
(22551,4295,1),
(22551,5839,1),
-- 龍馬軍 魔法師
-- Dragon Steed Troop Magician
(22543,4299,1),
-- 龍馬軍 魔法師
-- Dragon Steed Troop Magician
(22577,4299,1),
(22577,5827,6),
-- 龍馬軍 魔法師
-- Dragon Steed Troop Magician
(22584,4299,1),
-- 龍馬軍 魔法師
-- Dragon Steed Troop Magician
(22592,4299,1),
-- 突變龍獸
-- Mutation Drake
(22552,4299,1),
-- 龍馬軍 標槍兵
-- Dragon Steed Troop Javelin Thrower
(22549,4299,1),
-- 龍馬軍 標槍兵
-- Dragon Steed Troop Javelin Thrower
(22548,4299,1),
-- 龍馬軍 標槍兵
-- Dragon Steed Troop Javelin Thrower
(22581,4299,1),
-- 龍馬軍 標槍兵
-- Dragon Steed Troop Javelin Thrower
(22582,4299,1),
-- 龍馬軍 軍團長
-- Dragon Steed Troop Commander
(22538,4299,1),
(22538,4441,5),
(22538,4071,5),
-- 龍馬軍 軍團長
-- Dragon Steed Troop Commander
(22572,4299,1),
(22572,5827,6),
(22572,4441,5),
(22572,4071,5),
-- 龍馬軍 軍團長
-- Dragon Steed Troop Commander
(22586,4299,1),
(22586,5827,6),
(22586,4441,5),
(22586,4071,5),
-- 龍馬軍 軍團長
-- Dragon Steed Troop Commander
(22594,4299,1),
(22594,5827,6),
(22594,4441,5),
(22594,4071,5),
-- 親衛隊長
-- Royal Guard Captain
(22536,4299,1),
(22536,5362,9),
-- 親衛隊長
-- Royal Guard Captain
(22570,4299,1),
(22570,5362,9),
-- 敢死隊 蒂雅特親衛隊
-- Soldiers of Bravery (Tiats Bodyguards)
(29162,4299,1),
(29162,5259,12),
-- 敢死隊 蒂雅特親衛隊
-- Soldiers of Bravery (Tiats Bodyguards)
(22569,4299,1),
(22569,5259,12),
-- 龍馬軍 大魔法師
-- Dragon Steed Troop Grand Magician
(22537,4299,1),
-- 龍馬軍 大魔法師
-- Dragon Steed Troop Grand Magician
(22571,4299,1),
-- 龍馬軍 治療師
-- Dragon Steed Troop Healer
(22547,4299,1),
-- 龍馬軍 治療師
-- Dragon Steed Troop Healer
(22580,4299,1),
-- 狂戰士
-- Warrior of Light
(22546,4299,1),
-- 狂戰士
-- Warrior of Light
(22579,4299,1),
-- 闇龍的族人
-- Wife of the Dragon of Darkness
(22545,4299,1),
-- 不死的狂信徒
-- Fanatic of Infinity
(22509,5909,1),
(22509,5465,1),
-- 腐敗的傳令
-- Rotten Messenger
(22510,5909,1),
-- 不死的狂信者
-- Zealot of Infinity
(22511,5910,1),
-- 屍體切割機
-- Body Severer
(22512,5909,1),
-- 屍體收割機
-- Body Harvester
(22513,5909,1),
-- 靈魂抽取者
-- Soul Exploiter
(22514,5910,1),
-- 靈魂掠食者
-- Soul Devourer
(22515,5909,1),
-- 羅格那獸人 被惡靈附身的
-- Ragna Orc (Spirit Infested)
(22691,4333,6),
(22691,4312,1),
-- 羅格那獸人戰士 被惡靈附身的
-- Ragna Orc Warrior (Spirit Infested)
(22692,4333,6),
(22692,4312,1),
-- 羅格那獸人英雄 被惡靈附身的
-- Ragna Orc Hero (Spirit Infested)
(22693,4333,6),
(22693,4312,1),
-- 羅格那獸人司令官 被惡靈附身的
-- Ragna Orc Commander (Spirit Infested)
(22694,4333,6),
-- 羅格那獸人治療師 被惡靈附身的
-- Ragna Orc Healer (Spirit Infested)
(22695,4333,6),
-- 羅格那獸人咒術士 被惡靈附身的
-- Ragna Orc Shaman (Spirit Infested)
(22696,4333,6),
-- 羅格那獸人預言者 被惡靈附身的
-- Ragna Orc Seer (Spirit Infested)
(22697,4333,6),
-- 羅格那獸人射手 被惡靈附身的
-- Ragna Orc Archer (Spirit Infested)
(22698,4333,6),
(22698,4313,1),
-- 羅格那獸人狙擊手 被惡靈附身的
-- Ragna Orc Sniper (Spirit Infested)
(22699,4333,6),
-- 巴蘭卡的守護者
(22700,4417,14),
(22700,4333,6),
(22700,4410,13),
(22700,4413,17),
(22700,4444,5),
(22700,5620,2),
-- 巴蘭卡的魔物
-- Varangkas Dre Vanul
(22701,4417,14),
(22701,4333,6),
-- 巴蘭卡的毀滅者
-- Varangkas Destroyer
(22702,4417,14),
(22702,4333,6);

-- Seed of Destruction show movie
-- REPLACE INTO `zone_vertices` VALUES
-- (25253,0,-251280,211765),
-- (25253,1,-250599,211765),
-- (25253,2,-250599,211571),
-- (25253,3,-251280,211571);

-- land zone before enter in SoD
-- REPLACE INTO `zone_vertices` VALUES
-- (25254,0,-249138,250114),
-- (25254,1,-246840,252076),
-- (25254,2,-246730,251982),
-- (25254,3,-248699,249660);

-- 四方結界怪物資料 Update 23-08-2010
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=86802,  `sp`=9470,  `hp`=3461, `mp`=1708 where id='22708';  -- 惡夢的侵略戰士
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=86975,  `sp`=9490,  `hp`=3461, `mp`=1708 where id='22709';  -- 惡夢的侵略治癒者
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=55431,  `sp`=6053,  `hp`=3461, `mp`=1708 where id='22710';  -- 惡夢的侵略引導者
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=76351,  `sp`=8361,  `hp`=3461, `mp`=1708 where id='22711';  -- 惡夢的侵略破壞者
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=56907,  `sp`=6223,  `hp`=3461, `mp`=1708 where id='22712';  -- 惡夢的侵略暗殺者
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=71490,  `sp`=7803,  `hp`=3461, `mp`=1708 where id='22713';  -- 惡夢的侵略咒術士
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=54103,  `sp`=5901,  `hp`=3461, `mp`=1708 where id='22714';  -- 惡夢的侵略弓箭手
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=86802,  `sp`=9470,  `hp`=3461, `mp`=1708 where id='22715';  -- 惡夢的侵略士兵
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=86802,  `sp`=9470,  `hp`=3461, `mp`=1708 where id='22716';  -- 惡夢的侵略士兵
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=94735,  `sp`=10335, `hp`=3461, `mp`=1708 where id='22717';  -- 惡夢的侵略使徒
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=102165, `sp`=11188, `hp`=3461, `mp`=1708 where id='22718';  -- 惡夢的侵略精銳兵

-- 廣場結界怪物資料 Update 23-08-2010
UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=173525, `sp`=19428, `hp`=65802, `mp`=1743 where id='22719';  -- 虛無的侵略戰士
UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=165990, `sp`=18584, `hp`=65802, `mp`=1743 where id='22720';  -- 虛無的侵略治癒者
UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=91554,  `sp`=10250, `hp`=32946, `mp`=1743 where id='22721';  -- 虛無的侵略引導者
UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=165520, `sp`=18532, `hp`=65802, `mp`=1743 where id='22722';  -- 虛無的侵略破壞者
UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=93237,  `sp`=10439, `hp`=32946, `mp`=1743 where id='22723';  -- 虛無的侵略暗殺者
UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=166465, `sp`=18638, `hp`=65802, `mp`=1743 where id='22724';  -- 虛無的侵略咒術士
UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=162858, `sp`=18234, `hp`=65802, `mp`=1743 where id='22725';  -- 虛無的侵略弓箭手
UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=165520, `sp`=18532, `hp`=65802, `mp`=1743 where id='22726';  -- 虛無的侵略士兵
UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=165520, `sp`=18532, `hp`=65802, `mp`=1743 where id='22727';  -- 虛無的侵略士兵
UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=165520, `sp`=18532, `hp`=65802, `mp`=1743 where id='22728';  -- 虛無的侵略使徒
UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=310252, `sp`=33057, `hp`=65802, `mp`=1743 where id='22729';  -- 虛無的侵略精銳兵

-- 塔之結界怪物資料 Update 23-08-2010
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=357615, `sp`=38610, `hp`=112020, `mp`=1812 where id='22730';  -- 怨靈的侵略戰士
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=337518, `sp`=36440, `hp`=112020, `mp`=1812 where id='22731';  -- 怨靈的侵略治癒者
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=338470, `sp`=36543, `hp`=112020, `mp`=1812 where id='22732';  -- 怨靈的侵略引導者
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=356663, `sp`=38507, `hp`=112020, `mp`=1812 where id='22733';  -- 怨靈的侵略破壞者
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=166805, `sp`=18009, `hp`=56054,  `mp`=1812 where id='22734';  -- 怨靈的侵略暗殺者
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=338470, `sp`=36543, `hp`=112020, `mp`=1812 where id='22735';  -- 怨靈的侵略咒術士
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=159361, `sp`=17205, `hp`=56054,  `mp`=1812 where id='22736';  -- 怨靈的侵略弓箭手
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=336554, `sp`=36336, `hp`=112020, `mp`=1812 where id='22737';  -- 怨靈的侵略士兵
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=336554, `sp`=36336, `hp`=112020, `mp`=1812 where id='22738';  -- 怨靈的侵略士兵
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=618577, `sp`=63492, `hp`=112020, `mp`=1812 where id='22739';  -- 怨靈的侵略使徒
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=650929, `sp`=66985, `hp`=112020, `mp`=1812 where id='22740';  -- 怨靈的侵略精銳兵

-- 結界首領怪物資料 Update 23-08-2010
UPDATE `npc` SET `type`='L2RaidBoss', `level`=81, `exp`=3327990,  `sp`=394141,  `hp`=436294, `mp`=18120 where id='25690';  -- 亞恩奇奈爾 夢境的侵蝕者  可吸魂
UPDATE `npc` SET `type`='L2RaidBoss', `level`=81, `exp`=3327990,  `sp`=394141,  `hp`=436294, `mp`=18120 where id='25691';  -- 亞恩奇奈爾 夢境的侵蝕者  可吸魂
UPDATE `npc` SET `type`='L2RaidBoss', `level`=81, `exp`=3327990,  `sp`=394141,  `hp`=436294, `mp`=18120 where id='25692';  -- 亞恩奇奈爾 夢境的侵蝕者  可吸魂
UPDATE `npc` SET `type`='L2RaidBoss', `level`=81, `exp`=3327990,  `sp`=394141,  `hp`=436294, `mp`=18120 where id='25693';  -- 亞恩奇奈爾 夢境的侵蝕者  可吸魂
UPDATE `npc` SET `type`='L2RaidBoss', `level`=82, `exp`=37775745, `sp`=1117041, `hp`=436294, `mp`=18120 where id='25694';  -- 亞恩奇奈爾(Lv82) 夢境的侵蝕者  可吸魂
UPDATE `npc` SET `type`='L2RaidBoss', `level`=84, `exp`=42720365, `sp`=1206690, `hp`=449514, `mp`=19170 where id='25695';  -- 亞恩奇奈爾(Lv84) 夢境的侵蝕者  可吸魂

-- 受傷的龍怪物資料 Update 23-08-2010
UPDATE `npc` SET `type`='L2Monster', `level`=71, `exp`=21105, `sp`=2186, `hp`=2856, `mp`=1574 where id='18635';  -- 巴瑞卡賽勒諾斯訓練兵
UPDATE `npc` SET `type`='L2Monster', `level`=71, `exp`=18501, `sp`=1904, `hp`=2856, `mp`=1574 where id='18636';  -- 巴瑞卡賽勒諾斯步兵
UPDATE `npc` SET `type`='L2Monster', `level`=72, `exp`=11090, `sp`=1200, `hp`=2856, `mp`=1574 where id='18637';  -- 放牧的羚羊
UPDATE `npc` SET `type`='L2Monster', `level`=72, `exp`=25065, `sp`=2642, `hp`=2974, `mp`=1607 where id='18638';  -- 巴瑞卡賽勒諾斯偵查兵
UPDATE `npc` SET `type`='L2Monster', `level`=72, `exp`=24846, `sp`=2618, `hp`=2974, `mp`=1607 where id='18639';  -- 巴瑞卡賽勒諾斯狩獵者
UPDATE `npc` SET `type`='L2Monster', `level`=72, `exp`=24583, `sp`=2580, `hp`=2974, `mp`=1607 where id='18640';  -- 巴瑞卡賽勒諾斯咒術士
UPDATE `npc` SET `type`='L2Monster', `level`=72, `exp`=25424, `sp`=2681, `hp`=2974, `mp`=1607 where id='18641';  -- 巴瑞卡賽勒諾斯祭司
UPDATE `npc` SET `type`='L2Monster', `level`=72, `exp`=25564, `sp`=2696, `hp`=2974, `mp`=1607 where id='18642';  -- 巴瑞卡賽勒諾斯戰士
UPDATE `npc` SET `type`='L2Monster', `level`=72, `exp`=11090, `sp`=1200, `hp`=2856, `mp`=1574 where id='18643';  -- 放牧的羚羊
UPDATE `npc` SET `type`='L2Monster', `level`=72, `exp`=33107, `sp`=3490, `hp`=2974, `mp`=1607 where id='18644';  -- 巴瑞卡賽勒諾斯靈媒
UPDATE `npc` SET `type`='L2Monster', `level`=73, `exp`=23321, `sp`=2452, `hp`=2974, `mp`=1607 where id='18645';  -- 巴瑞卡賽勒諾斯魔導士
UPDATE `npc` SET `type`='L2Monster', `level`=73, `exp`=25564, `sp`=2696, `hp`=2974, `mp`=1607 where id='18646';  -- 巴瑞卡賽勒諾斯下士
UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=23952, `sp`=2522, `hp`=2974, `mp`=1607 where id='18647';  -- 放牧的芙拉瓦
UPDATE `npc` SET `type`='L2Monster', `level`=73, `exp`=18178, `sp`=1988, `hp`=2974, `mp`=1607 where id='18648';  -- 巴瑞卡賽勒諾斯祭司長
UPDATE `npc` SET `type`='L2Monster', `level`=73, `exp`=25065, `sp`=2642, `hp`=2974, `mp`=1607 where id='18649';  -- 巴瑞卡賽勒諾斯大魔導士
UPDATE `npc` SET `type`='L2Monster', `level`=73, `exp`=27045, `sp`=2858, `hp`=2974, `mp`=1607 where id='18650';  -- 巴瑞卡賽勒諾斯軍官
UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=15760, `sp`=1724, `hp`=2974, `mp`=1607 where id='18651';  -- 放牧的羚羊長老
UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=32231, `sp`=3394, `hp`=2974, `mp`=1607 where id='18652';  -- 巴瑞卡賽勒諾斯大祭司長
UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=26151, `sp`=2761, `hp`=2974, `mp`=1607 where id='18653';  -- 巴瑞卡精銳親衛隊
UPDATE `npc` SET `type`='L2Monster', `level`=72, `exp`=31469, `sp`=3310, `hp`=2974, `mp`=1607 where id='18654';  -- 巴瑞卡軍團長
UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=16812, `sp`=1840, `hp`=2974, `mp`=1607 where id='18655';  -- 巴瑞卡首席親衛隊
UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=24846, `sp`=2618, `hp`=2974, `mp`=1607 where id='18656';  -- 巴瑞卡首席魔導士
UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=16952, `sp`=1855, `hp`=2974, `mp`=1607 where id='18657';  -- 預言者的親衛兵
UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=16339, `sp`=1788, `hp`=2974, `mp`=1607 where id='18658';  -- 預言者的門徒
UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=32073, `sp`=3370, `hp`=2974, `mp`=1607 where id='18659';  -- 巴瑞卡預言者

-- 邊緣菲拉卡(城堡)怪物資料 Update 23-08-2010
UPDATE `npc` SET `type`='L2Monster', `level`=79, `exp`=0, `sp`=0, `hp`=8710, `mp`=1641 where id='25656';  -- 卡納迪斯 狂信徒(Lv79)
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=2730278, `sp`=394141, `hp`=423463, `mp`=1708 where id='25653';  -- 卡納迪斯 先驅者(Lv81) 侵略軍
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=0, `sp`=0, `hp`=8760, `mp`=1708 where id='25657';  -- 卡納迪斯 狂信徒(Lv81)
UPDATE `npc` SET `type`='L2Monster', `level`=83, `exp`=2911026, `sp`=402310, `hp`=431974, `mp`=1777 where id='25654';  -- 卡納迪斯 先驅者(Lv83) 侵略軍
UPDATE `npc` SET `type`='L2Monster', `level`=83, `exp`=0, `sp`=0, `hp`=8789, `mp`=1777 where id='25658';  -- 卡納迪斯 狂信徒(Lv83)
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=3100451, `sp`=410692, `hp`=440657, `mp`=1846 where id='25655';  -- 卡納迪斯 先驅者(Lv85) 侵略軍

-- 邊緣菲拉卡(要塞)怪物資料 Update 23-08-2010
UPDATE `npc` SET `type`='L2Monster', `level`=75, `exp`=0, `sp`=0, `hp`=8551, `mp`=1507 where id='25662';  -- 卡納迪斯 追從者(Lv75)
UPDATE `npc` SET `type`='L2Monster', `level`=77, `exp`=2588731, `sp`=332450, `hp`=406426, `mp`=1574 where id='25659';  -- 卡納迪斯 前導者(Lv77) 侵略軍
UPDATE `npc` SET `type`='L2Monster', `level`=78, `exp`=0, `sp`=0, `hp`=8678, `mp`=1607 where id='25663';  -- 卡納迪斯 追從者(Lv78)
UPDATE `npc` SET `type`='L2Monster', `level`=80, `exp`=2706502, `sp`=353878, `hp`=419270, `mp`=1674 where id='25660';  -- 卡納迪斯 前導者(Lv80) 侵略軍
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=0, `sp`=0, `hp`=8760, `mp`=1708 where id='25664';  -- 卡納迪斯 追從者(Lv81) 
UPDATE `npc` SET `type`='L2Monster', `level`=83, `exp`=2853103, `sp`=373311, `hp`=431974, `mp`=1777 where id='25661';  -- 卡納迪斯 前導者(Lv83) 侵略軍

-- 地下競技場怪物資料 Update 23-08-2010
UPDATE `npc` SET `type`='L2Monster', `level`=45, `exp`=3834,  `sp`=266,  `hp`=1183, `mp`=610  where id='22443';  -- 柯爾堂的使者(Lv45)
UPDATE `npc` SET `type`='L2Monster', `level`=55, `exp`=5728,  `sp`=462,  `hp`=1673, `mp`=889  where id='22444';  -- 柯爾堂的使者(Lv55)
UPDATE `npc` SET `type`='L2Monster', `level`=65, `exp`=7797,  `sp`=724,  `hp`=2193, `mp`=1188 where id='22445';  -- 柯爾堂的使者(Lv65)
UPDATE `npc` SET `type`='L2Monster', `level`=75, `exp`=9659,  `sp`=1018, `hp`=2676, `mp`=1507 where id='22446';  -- 柯爾堂的使者(Lv75)
UPDATE `npc` SET `type`='L2Monster', `level`=80, `exp`=10183, `sp`=1143, `hp`=3290, `mp`=1674 where id='22447';  -- 柯爾堂的使者(Lv80)

-- 增加地下收容所怪物資料 Update 23-08-2010
UPDATE `npc` SET `type`='L2Monster', `level`=72, `exp`=2192267, `sp`=353878, `hp`=192008, `mp`=1410 where id='25572';  -- 不法者哈爾庫 過去的囚犯
UPDATE `npc` SET `type`='L2Monster', `level`=71, `exp`=0, `sp`=0, `hp`=8318, `mp`=1377 where id='25574';  -- 哈爾庫的警衛
UPDATE `npc` SET `type`='L2Monster', `level`=71, `exp`=0, `sp`=0, `hp`=8318, `mp`=1377 where id='25573';  -- 哈爾庫的追隨者
REPLACE INTO `minions` VALUES (25572, 25574, 1, 1);
REPLACE INTO `minions` VALUES (25572, 25573, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=73, `exp`=2234730, `sp`=360602, `hp`=194342, `mp`=1442 where id='25575';  -- 透視者朗鐵 過去的囚犯
UPDATE `npc` SET `type`='L2Monster', `level`=72, `exp`=0, `sp`=0, `hp`=8383, `mp`=1410 where id='25577';  -- 朗鐵的水晶體
UPDATE `npc` SET `type`='L2Monster', `level`=72, `exp`=0, `sp`=0, `hp`=8383, `mp`=1410 where id='25576';  -- 朗鐵的虹膜
REPLACE INTO `minions` VALUES (25575, 25577, 1, 1);
REPLACE INTO `minions` VALUES (25575, 25576, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=73, `exp`=2234730, `sp`=360602, `hp`=388684, `mp`=1442 where id='25578';  -- 史克雷 過去的囚犯

UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=2280800, `sp`=367102, `hp`=196619, `mp`=1475 where id='25579';  -- 海西奈爾 過去的囚犯
UPDATE `npc` SET `type`='L2Monster', `level`=73, `exp`=0, `sp`=0, `hp`=8444, `mp`=1442 where id='25581';  -- 海西奈爾的刺客
UPDATE `npc` SET `type`='L2Monster', `level`=73, `exp`=0, `sp`=0, `hp`=8444, `mp`=1442 where id='25580';  -- 海西奈爾的守護兵
REPLACE INTO `minions` VALUES (25579, 25581, 1, 1);
REPLACE INTO `minions` VALUES (25579, 25580, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=75, `exp`=2329613, `sp`=373311, `hp`=198851, `mp`=1507 where id='25582';  -- 加爾力安 過去的囚犯
UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=0, `sp`=0, `hp`=8500, `mp`=1475 where id='25584';  -- 加爾力安的僕人
UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=0, `sp`=0, `hp`=8500, `mp`=1475 where id='25583';  -- 加爾力安的女兒
REPLACE INTO `minions` VALUES (25582, 25584, 1, 1);
REPLACE INTO `minions` VALUES (25582, 25583, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=76, `exp`=2383518, `sp`=369370, `hp`=201046, `mp`=1540 where id='25585';  -- 麥以迪 過去的囚犯
UPDATE `npc` SET `type`='L2Monster', `level`=75, `exp`=0, `sp`=0, `hp`=8551, `mp`=1507 where id='25586';  -- 麥以迪之妹
UPDATE `npc` SET `type`='L2Monster', `level`=75, `exp`=0, `sp`=0, `hp`=8551, `mp`=1507 where id='25587';  -- 麥以迪之弟
REPLACE INTO `minions` VALUES (25585, 25586, 1, 1);
REPLACE INTO `minions` VALUES (25585, 25587, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=77, `exp`=2441393, `sp`=374864, `hp`=406426, `mp`=1574 where id='25588';  -- 無法阻止的幕烏士 過去的囚犯

UPDATE `npc` SET `type`='L2Monster', `level`=78, `exp`=2504377, `sp`=380180, `hp`=205362, `mp`=1607 where id='25589';  -- 被放逐的巴里達 過去的囚犯
UPDATE `npc` SET `type`='L2Monster', `level`=77, `exp`=0, `sp`=0, `hp`=8641, `mp`=1574 where id='25591';  -- 巴里達的侍女
UPDATE `npc` SET `type`='L2Monster', `level`=77, `exp`=0, `sp`=0, `hp`=8641, `mp`=1574 where id='25590';  -- 巴里達的侍從
REPLACE INTO `minions` VALUES (25589, 25591, 1, 1);
REPLACE INTO `minions` VALUES (25589, 25590, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=80, `exp`=2643172, `sp`=390090, `hp`=209635, `mp`=1674 where id='25593';  -- 掠食者凱爾格 過去的囚犯
UPDATE `npc` SET `type`='L2Monster', `level`=79, `exp`=0, `sp`=0, `hp`=8710, `mp`=1641 where id='25594';  -- 凱爾格的追隨者
UPDATE `npc` SET `type`='L2Monster', `level`=79, `exp`=0, `sp`=0, `hp`=8710, `mp`=1641 where id='25595';  -- 凱爾格的部下
REPLACE INTO `minions` VALUES (25593, 25594, 1, 1);
REPLACE INTO `minions` VALUES (25593, 25595, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=79, `exp`=2571288, `sp`=385228, `hp`=415001, `mp`=1641 where id='25592';  -- 大將軍卡拉隆 過去的囚犯

-- 增加城堡地監怪物資料 Update 23-08-2010
UPDATE `npc` SET `type`='L2Monster', `level`=75, `exp`=2329613, `sp`=373311, `hp`=198851, `mp`=1507 where id='25546';  -- 背信的拉尼安 過去的罪犯
UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=0, `sp`=0, `hp`=8500, `mp`=1475 where id='25547';  -- 拉尼安的同夥
UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=0, `sp`=0, `hp`=8500, `mp`=1475 where id='25548';  -- 拉尼安的治癒者
REPLACE INTO `minions` VALUES (25546, 25547, 1, 1);
REPLACE INTO `minions` VALUES (25546, 25548, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=75, `exp`=2329613, `sp`=373311, `hp`=198851, `mp`=1507 where id='25549';  -- 詐欺犯泰西亞 過去的罪犯
UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=0, `sp`=0, `hp`=8500, `mp`=1475 where id='25550';  -- 泰西亞的大弟子
UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=0, `sp`=0, `hp`=8500, `mp`=1475 where id='25551';  -- 泰西亞的跑腿
REPLACE INTO `minions` VALUES (25549, 25550, 1, 1);
REPLACE INTO `minions` VALUES (25549, 25551, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=76, `exp`=2383518, `sp`=369370, `hp`=402092, `mp`=1540 where id='25552';  -- 靈魂獵人查昆迪 過去的罪犯

UPDATE `npc` SET `type`='L2Monster', `level`=77, `exp`=2441393, `sp`=374864, `hp`=406426, `mp`=1574 where id='25553';  -- 岩石拳杜泰格 過去的罪犯

UPDATE `npc` SET `type`='L2Monster', `level`=78, `exp`=2504377, `sp`=380180, `hp`=205362, `mp`=1607 where id='25554';  -- 不屈的布魯泰齊歐 過去的罪犯
UPDATE `npc` SET `type`='L2Monster', `level`=77, `exp`=0, `sp`=0, `hp`=8641, `mp`=1574 where id='25555';  -- 布魯泰齊歐的右手
UPDATE `npc` SET `type`='L2Monster', `level`=77, `exp`=0, `sp`=0, `hp`=8641, `mp`=1574 where id='25556';  -- 布魯泰齊歐的左手
REPLACE INTO `minions` VALUES (25554, 25555, 1, 1);
REPLACE INTO `minions` VALUES (25554, 25556, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=79, `exp`=2571288, `sp`=385228, `hp`=207500, `mp`=1641 where id='25557';  -- 森林掠食者凱凱諾斯 過去的罪犯
UPDATE `npc` SET `type`='L2Monster', `level`=78, `exp`=0, `sp`=0, `hp`=8678, `mp`=1607 where id='25558';  -- 凱凱諾斯的側根
UPDATE `npc` SET `type`='L2Monster', `level`=78, `exp`=0, `sp`=0, `hp`=8678, `mp`=1607 where id='25559';  -- 凱凱諾斯的花
REPLACE INTO `minions` VALUES (25557, 25558, 1, 1);
REPLACE INTO `minions` VALUES (25557, 25559, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=79, `exp`=2571288, `sp`=385228, `hp`=207500, `mp`=1641 where id='25560';  -- 暴走劍士斯里卡德 過去的罪犯
UPDATE `npc` SET `type`='L2Monster', `level`=78, `exp`=0, `sp`=0, `hp`=8678, `mp`=1607 where id='25561';  -- 斯里卡德的鐘
UPDATE `npc` SET `type`='L2Monster', `level`=78, `exp`=0, `sp`=0, `hp`=8678, `mp`=1607 where id='25562';  -- 斯里卡德的見習生
REPLACE INTO `minions` VALUES (25560, 25561, 1, 1);
REPLACE INTO `minions` VALUES (25560, 25562, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=2730278, `sp`=394141, `hp`=211731, `mp`=1708 where id='25563';  -- 美貌的奈茲里耶 過去的罪犯
UPDATE `npc` SET `type`='L2Monster', `level`=80, `exp`=0, `sp`=0, `hp`=8738, `mp`=1674 where id='25564';  -- 奈茲里耶的追隨者
UPDATE `npc` SET `type`='L2Monster', `level`=80, `exp`=0, `sp`=0, `hp`=8738, `mp`=1674 where id='25565';  -- 奈茲里耶的部下
REPLACE INTO `minions` VALUES (25563, 25564, 1, 1);
REPLACE INTO `minions` VALUES (25563, 25565, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=2819564, `sp`=398177, `hp`=213848, `mp`=1743 where id='25566';  -- 粗野的南龐 過去的罪犯
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=0, `sp`=0, `hp`=8760, `mp`=1708 where id='25567';  -- 南龐的至交
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=0, `sp`=0, `hp`=8760, `mp`=1708 where id='25568';  -- 南龐的老友
REPLACE INTO `minions` VALUES (25566, 25567, 1, 1);
REPLACE INTO `minions` VALUES (25566, 25568, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=2819564, `sp`=398177, `hp`=213848, `mp`=1743 where id='25569';  -- 破壞者加斯 過去的罪犯
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=0, `sp`=0, `hp`=8760, `mp`=1708 where id='25570';  -- 加斯的偵查兵
UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=0, `sp`=0, `hp`=8760, `mp`=1708 where id='25571';  -- 加斯的突擊兵
REPLACE INTO `minions` VALUES (25569, 25570, 1, 1);
REPLACE INTO `minions` VALUES (25569, 25571, 1, 1);

-- 權能培訓場
UPDATE `npc` SET `type`='L2Monster', `level`=83, `exp`=8453,  `sp`=912,   `hp`=3835, `mp`=1777 where id='22780';  -- 賽爾豺狼士兵(弓手)
UPDATE `npc` SET `type`='L2Monster', `level`=83, `exp`=8453,  `sp`=912,   `hp`=3835, `mp`=1777 where id='22782';  -- 賽爾豺狼士兵(戰士)
UPDATE `npc` SET `type`='L2Monster', `level`=83, `exp`=8453,  `sp`=912,   `hp`=3835, `mp`=1777 where id='22784';  -- 賽爾豺狼士兵(法師)
UPDATE `npc` SET `type`='L2Monster', `level`=83, `exp`=17547, `sp`=1759,  `hp`=3835, `mp`=1777 where id='18908';  -- 賽爾豺狼料理長
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=20751, `sp`=2063,  `hp`=4039, `mp`=1812 where id='22786';  -- 賽爾豺狼十夫長(弓手)
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=20751, `sp`=2063,  `hp`=4039, `mp`=1812 where id='22787';  -- 賽爾豺狼十夫長(戰士)
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=20751, `sp`=2063,  `hp`=4039, `mp`=1812 where id='22788';  -- 賽爾豺狼十夫長(法師)
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=4807,  `sp`=512,   `hp`=4039, `mp`=1812 where id='22781';  -- 賽爾豺狼熟練兵(弓手)
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=8532,  `sp`=910,   `hp`=4039, `mp`=1812 where id='22783';  -- 賽爾豺狼熟練兵(戰士)
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=11192, `sp`=1194,  `hp`=4039, `mp`=1812 where id='22785';  -- 賽爾豺狼熟練兵(法師)
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=25111, `sp`=2528,  `hp`=4039, `mp`=1812 where id='22778';  -- 賽爾豺狼訓練教官(弓手)
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=25111, `sp`=2528,  `hp`=4039, `mp`=1812 where id='22775';  -- 賽爾豺狼訓練教官(法師)
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=25111, `sp`=2528,  `hp`=4039, `mp`=1812 where id='22777';  -- 賽爾豺狼訓練教官(戰士)
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=37863, `sp`=3820,  `hp`=4039, `mp`=1812 where id='22776';  -- 賽爾豺狼訓練教官長
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=24663, `sp`= 2481, `hp`=4039, `mp`=1812 where id='22779';  -- 賽爾豺狼護衛戰士
-- 蜥蜴草原
UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=19616, `sp`=2145, `hp`=3643, `mp`=1743 where id='18862';  -- 坦塔蜥蜴人守護者 幽谷勒斯的隨行員
UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=14826, `sp`=1621, `hp`=3643, `mp`=1743 where id='22768';  -- 坦塔蜥蜴人巡守
UPDATE `npc` SET `type`='L2Monster', `level`=83, `exp`=21133, `sp`=2282, `hp`=3835, `mp`=1777 where id='22772';  -- 坦塔蜥蜴人弓箭手
UPDATE `npc` SET `type`='L2Monster', `level`=83, `exp`=19888, `sp`=2147, `hp`=3835, `mp`=1777 where id='22769';  -- 坦塔蜥蜴人戰士
UPDATE `npc` SET `type`='L2Monster', `level`=83, `exp`=20911, `sp`=2258, `hp`=3835, `mp`=1777 where id='22773';  -- 坦塔蜥蜴人魔法師
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=34362, `sp`=3499, `hp`=4039, `mp`=1812 where id='22770';  -- 坦塔蜥蜴人勇士
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=38824, `sp`=3950, `hp`=4039, `mp`=1812 where id='22774';  -- 坦塔蜥蜴人召喚士
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=35295, `sp`=3599, `hp`=4039, `mp`=1812 where id='22771';  -- 坦塔蜥蜴人狂戰士
UPDATE `npc` SET `type`='L2Monster', `level`=84, `exp`=0,     `sp`=0,    `hp`=4039, `mp`=1812 where id='18863';  -- 祭司長 幽谷勒斯 坦塔蜥蜴人
-- 柯克拉闊 -- 殄滅之種
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=579450,  `sp`=58220,  `hp`=55817,  `mp`=1846 where id='22762';  -- 卡伊歐納
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=579303,  `sp`=58205,  `hp`=55817,  `mp`=1846 where id='22760';  -- 卡尼比
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=579303,  `sp`=58205,  `hp`=55817,  `mp`=1846 where id='22761';  -- 奇里歐納
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=1209443, `sp`=121549, `hp`=111546, `mp`=1846 where id='22765';  -- 精銳卡伊歐納 柯克拉闊
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=1209443, `sp`=121549, `hp`=111546, `mp`=1846 where id='22763';  -- 精銳卡尼比 柯克拉闊
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=1206702, `sp`=121260, `hp`=111546, `mp`=1846 where id='22764';  -- 精銳奇里歐納 柯克拉闊
-- 比斯塔闊 -- 殄滅之種
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=585939,  `sp`=58904,  `hp`=55817,  `mp`=1846 where id='22749';  -- 特雷坎
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=579303,  `sp`=58205,  `hp`=55817,  `mp`=1846 where id='22746';  -- 巴格連特
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=579303,  `sp`=58205,  `hp`=55817,  `mp`=1846 where id='22747';  -- 布拉奇安
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=579450,  `sp`=58220,  `hp`=55817,  `mp`=1846 where id='22748';  -- 格洛伊坎
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=1209443, `sp`=121549, `hp`=111546, `mp`=1846 where id='22750';  -- 精銳巴格連特 比斯塔闊
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=1209443, `sp`=121549, `hp`=111546, `mp`=1846 where id='22751';  -- 精銳布拉齊安 比斯塔闊
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=1206702, `sp`=121260, `hp`=111546, `mp`=1846 where id='22752';  -- 精銳格洛伊坎 比斯塔闊
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=1209443, `sp`=121549, `hp`=111546, `mp`=1846 where id='22753';  -- 精銳特雷坎 比斯塔闊
-- 雷提里闊 -- 殄滅之種
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=579303,  `sp`=58205,  `hp`=55817,  `mp`=1846 where id='22755';  -- 克拉奇安
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=579450,  `sp`=58220,  `hp`=55817,  `mp`=1846 where id='22756';  -- 塔迪翁
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=579303,  `sp`=58205,  `hp`=55817,  `mp`=1846 where id='22754';  -- 托特黎安
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=1206702, `sp`=121260, `hp`=111546, `mp`=1846 where id='22758';  -- 精銳克拉奇安 雷提里闊
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=1209443, `sp`=121549, `hp`=111546, `mp`=1846 where id='22759';  -- 精銳塔迪翁 雷提里闊
UPDATE `npc` SET `type`='L2Monster', `level`=85, `exp`=1209443, `sp`=121549, `hp`=111546, `mp`=1846 where id='22757';  -- 精銳托特黎安 雷提里闊
-- 殄滅之種 85級狩獵首領
UPDATE `npc` SET `type`='L2RaidBoss', `level`=85, `exp`=3233771, `sp`=403115, `hp`=631293, `mp`=18468 where id='25697';  -- 土倫巴 雷提里闊
UPDATE `npc` SET `type`='L2RaidBoss', `level`=85, `exp`=3078748, `sp`=399008, `hp`=763865, `mp`=18468 where id='25696';  -- 塔克拉甘 比斯塔闊  可吸魂
UPDATE `npc` SET `type`='L2RaidBoss', `level`=85, `exp`=3233771, `sp`=403115, `hp`=631293, `mp`=18468 where id='25698';  -- 多帕建 柯克拉闊  可吸魂

-- new npc for 葫蘆
DELETE FROM npcskills WHERE npcid IN (12774,12775,12776,12777,12778,12779,13016,13017);
-- DELETE FROM npcaidata WHERE npcId IN (12774,12775,12776,12777,12778,12779,13016,13017);
UPDATE npc SET `type`='L2ChronoMonster' WHERE id IN (12774,12775,12776,12777,12778,12779,13016,13017);

UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=12774;  -- 未成熟的葫蘆
UPDATE npc SET level=1,hp=300 ,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=12775;  -- 優良的葫蘆
UPDATE npc SET level=1,hp=300 ,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=12776;  -- 不良的葫蘆
UPDATE npc SET level=1,hp=300 ,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=12777;  -- 未成熟的大葫蘆
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=12778;  -- 優良的大葫蘆
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=12779;  -- 不良的大葫蘆
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=13016;  -- 優良的葫蘆王
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=13017;  -- 優良的大葫蘆王

-- NPC
DELETE FROM npcskills WHERE  npcid IN (13271,13272,13273,13274,13275,13276,13277,13278);
-- DELETE FROM npcaidata WHERE npcId IN (13271,13272,13273,13274,13275,13276,13277,13278);
UPDATE npc SET `type`='L2ChronoMonster' WHERE id IN (13271,13272,13273,13274,13275,13276,13277,13278);

UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=13271; -- 未成熟的西瓜
UPDATE npc SET level=1,hp=300 ,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=13272; -- 不良的西瓜
UPDATE npc SET level=1,hp=300 ,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=13273; -- 優良的西瓜
UPDATE npc SET level=1,hp=300 ,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=13274; -- 優良的西瓜王
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=13275; -- 未成熟的香甜西瓜
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=13276; -- 不良的香甜西瓜
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=13277; -- 優良的香甜西瓜
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32,walkspd=1,runspd=1 WHERE id=13278; -- 優良的香甜西瓜王

-- 諾爾妮庭園首領怪物資料 
UPDATE `npc` SET `type`='L2RaidBoss' where id='25528';  -- 最終試練官 塔庇里歐斯
UPDATE `npc` SET `type`='L2Monster', `exp`=0,  `sp`=0 where id='25529';  -- 試練官的部下 庭園的警衛隊
UPDATE `npc` SET `type`='L2Monster', `exp`=0,  `sp`=0 where id='25530';  -- 試練官的部下 庭園的警衛隊
REPLACE INTO `minions` VALUES (25528, 25529, 3, 3);
REPLACE INTO `minions` VALUES (25528, 25530, 1, 1);

DELETE FROM npcskills WHERE npcid IN (18437);

-- 修改 LV 16071 馬奎安 / 16072 精銳馬奎安
UPDATE npc SET `level` = '75' WHERE `id` in (16071,16072);

-- 修正(菲拉卡-受傷的龍)NPC設定
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18635; -- 巴瑞卡賽勒諾斯訓練兵
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18636; -- 巴瑞卡賽勒諾斯步兵
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18640; -- 巴瑞卡賽勒諾斯咒術士
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18641; -- 巴瑞卡賽勒諾斯祭司
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18642; -- 巴瑞卡賽勒諾斯戰士
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18644; -- 巴瑞卡賽勒諾斯靈媒
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18645; -- 巴瑞卡賽勒諾斯魔導士
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18646; -- 巴瑞卡賽勒諾斯下士
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18648; -- 巴瑞卡賽勒諾斯祭司長
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18649; -- 巴瑞卡賽勒諾斯大魔導士
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18650; -- 巴瑞卡賽勒諾斯軍官
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18652; -- 巴瑞卡賽勒諾斯大祭司長
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18653; -- 巴瑞卡精銳親衛隊
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18654; -- 巴瑞卡軍團長
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18655; -- 巴瑞卡首席親衛隊
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18656; -- 巴瑞卡首席魔導士
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18657; -- 預言者的親衛兵
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18658; -- 預言者的門徒
UPDATE `npcaidata` SET `aggro` = 900 WHERE `npcId` = 18659; -- 巴瑞卡預言者
UPDATE `npcaidata` SET `aggro` = 1200 WHERE `npcId` = 18660; -- 拉塔那

REPLACE INTO npcskills VALUES
-- 菲拉卡-受傷的龍
(18635,4032,7), -- NPC Strike
(18636,4573,7), -- NPC Sonic Blaster
(18640,4065,7), -- NPC Heal
(18641,4065,7), -- NPC Heal
(18642,4572,7), -- NPC Triple Sonic Slash
(18644,4065,7), -- NPC Heal
(18646,4572,7), -- NPC Triple Sonic Slash
(18648,4065,7), -- NPC Heal
(18649,4573,7), -- NPC Sonic Blaster
(18650,4072,7), -- 休克
(18654,4573,7), -- NPC Sonic Blaster
(18655,4573,7), -- NPC Sonic Blaster
(18656,4065,7), -- NPC Heal
(18657,4573,7), -- NPC Sonic Blaster
(18658,4065,7), -- NPC Heal
(18659,4065,7), -- NPC Heal
(18660,5715,1), -- 電流火燄
(18660,5716,1), -- 衝擊
(18660,5717,1), -- 火焰氣息
(18660,5718,1), -- 怒擊
(18660,5759,1); -- 展示-拉塔那起身

-- 沉默修道院狩獵首領
UPDATE `npc` SET `hp`=837564.609209036, `patk`=4094.68934, `pdef`=1428.96384939, `matk`=1092.88500315956, `mdef`=576.114, `matkspd`=6000 where id='25701';  -- 輝煌的支配者 亞奈斯
UPDATE `spawnlist` SET `locx` = 119120, `locy` = -80576, `locz` = -2694 WHERE `npc_templateid` = 32757;
UPDATE `raidboss_spawnlist` SET `boss_id` = 25701 WHERE `boss_id` = 29096;
UPDATE `minions` SET `boss_id` = 25701 WHERE `boss_id` = 29096;
UPDATE `npcaidata` SET `clan` = 'solina_clan', `clanRange` = 1000, `aiType` = 'balanced' WHERE `npcId` = 25701;

-- Remove from spawnlist mobov 50 + of School Authority
-- DELETE  FROM spawnlist where  (npc_templateid=20948 AND locx<=97580 AND locx>=76270 AND locy<=73220 AND locy>=54290);
-- DELETE  FROM spawnlist where  (npc_templateid=20944 AND locx<=97580 AND locx>=76270 AND locy<=73220 AND locy>=54290);
-- DELETE  FROM spawnlist where  (npc_templateid=20946 AND locx<=97580 AND locx>=76270 AND locy<=73220 AND locy>=54290);
-- DELETE  FROM spawnlist where  (npc_templateid=20945 AND locx<=97580 AND locx>=76270 AND locy<=73220 AND locy>=54290);
-- DELETE  FROM spawnlist where  (npc_templateid=20947 AND locx<=97580 AND locx>=76270 AND locy<=73220 AND locy>=54290);
-- DELETE  FROM spawnlist where  (npc_templateid=20952 AND locx<=97580 AND locx>=76270 AND locy<=73220 AND locy>=54290);
-- DELETE  FROM spawnlist where  (npc_templateid=20950 AND locx<=97580 AND locx>=76270 AND locy<=73220 AND locy>=54290);
-- DELETE  FROM spawnlist where  (npc_templateid=20951 AND locx<=97580 AND locx>=76270 AND locy<=73220 AND locy>=54290);
-- DELETE  FROM spawnlist where  (npc_templateid=20949 AND locx<=97580 AND locx>=76270 AND locy<=73220 AND locy>=54290);
-- DELETE  FROM spawnlist where  (npc_templateid=20953 AND locx<=97580 AND locx>=76270 AND locy<=73220 AND locy>=54290);

-- 修正貝斯之塔怪物新掉落
DELETE FROM `droplist` WHERE `mobId` IN (22373,22374,22375,22376);

REPLACE INTO droplist VALUES
(22373,57,7594,15210,0,700000),
(22373,9599,1,2,100,93500),
(22373,15654,1,1,1,2166),
(22373,15655,1,1,1,2166),
(22373,15656,1,1,1,2166),
(22373,15703,1,1,1,10),
(22373,15704,1,1,1,10),
(22373,15705,1,1,1,10),
(22373,1895,1,1,2,228102),
(22373,4040,1,1,2,15967),
(22373,9628,1,1,2,6262),
(22373,9630,1,1,2,4202),
(22373,9551,1,1,200,4387),
(22373,960,1,1,2,32),
(22373,15654,1,1,-1,2566),
(22373,15655,1,1,-1,2566),
(22373,15656,1,1,-1,2566),
(22373,15657,1,1,-1,2566),
(22373,15658,1,1,-1,2566),
(22373,15659,1,1,-1,2566),
(22373,15784,1,1,-1,400),
(22373,15785,1,1,-1,400),
(22373,15786,1,1,-1,400),
(22373,15787,1,1,-1,400),
(22373,15788,1,1,-1,400),
(22373,15789,1,1,-1,400),
(22374,57,21215,42489,0,700000),
(22374,9599,1,2,100,93500),
(22374,15657,1,1,1,2166),
(22374,15658,1,1,1,2166),
(22374,15659,1,1,1,2166),
(22374,15706,1,1,1,10),
(22374,15707,1,1,1,10),
(22374,15708,1,1,1,10),
(22374,1895,1,1,2,228102),
(22374,4040,1,1,2,15967),
(22374,9628,1,1,2,6262),
(22374,9630,1,1,2,4202),
(22374,9551,1,1,200,4387),
(22374,959,1,1,2,32),
(22374,15654,1,1,-1,2566),
(22374,15655,1,1,-1,2566),
(22374,15656,1,1,-1,2566),
(22374,15657,1,1,-1,2566),
(22374,15658,1,1,-1,2566),
(22374,15659,1,1,-1,2566),
(22374,15784,1,1,-1,400),
(22374,15785,1,1,-1,400),
(22374,15786,1,1,-1,400),
(22374,15787,1,1,-1,400),
(22374,15788,1,1,-1,400),
(22374,15789,1,1,-1,400),
(22375,57,44908,89941,0,700000),
(22375,9599,3,9,100,95700),
(22375,15645,1,1,1,1947),
(22375,15646,1,1,1,1950),
(22375,15694,1,1,1,10),
(22375,15695,1,1,1,10),
(22375,1868,120,360,2,34970),
(22375,1873,12,36,2,69940),
(22375,1889,4,12,2,31085),
(22375,4044,1,1,2,139881),
(22375,5549,3,9,2,59949),
(22375,9551,1,1,200,5571),
(22375,15645,1,1,-1,2566),
(22375,15646,1,1,-1,2566),
(22375,15647,1,1,-1,2566),
(22375,15692,1,1,-1,2566),
(22375,15693,1,1,-1,2566),
(22375,15775,1,1,-1,400),
(22375,15776,1,1,-1,400),
(22375,15777,1,1,-1,400),
(22375,15790,1,1,-1,400),
(22375,15791,1,1,-1,400),
(22376,57,119181,238696,0,700000),
(22376,9599,7,21,100,95800),
(22376,15772,1,1,1,3519),
(22376,15773,1,1,1,3577),
(22376,15774,1,1,1,3564),
(22376,15766,1,1,1,100),
(22376,15767,1,1,1,100),
(22376,15768,1,1,1,100),
(22376,4041,1,1,2,108948),
(22376,1881,38,144,2,21695),
(22376,1872,240,720,2,34803),
(22376,1867,720,2160,2,11601),
(22376,1875,4,12,2,92808),
(22376,9551,1,1,200,4233),
(22376,15772,1,1,-1,4319),
(22376,15773,1,1,-1,3863),
(22376,15774,1,1,-1,3472),
(22376,15812,1,1,-1,500),
(22376,15813,1,1,-1,500),
(22376,15814,1,1,-1,500);

-- 修正 Q196 怪物設定為主動
UPDATE `npcaidata` SET `aggro` = 400 WHERE `npcId` = 27371; -- 莉莉恩殺戮者
UPDATE `npcaidata` SET `aggro` = 400 WHERE `npcId` = 27372; -- 莉莉恩魔導士
UPDATE `npcaidata` SET `aggro` = 400 WHERE `npcId` = 27373; -- 莉莉恩隨從騎士
UPDATE `npcaidata` SET `aggro` = 400 WHERE `npcId` = 27374; -- 席琳的邪念
UPDATE `npcaidata` SET `aggro` = 400 WHERE `npcId` = 27375; -- 席琳的邪念
UPDATE `npcaidata` SET `aggro` = 400 WHERE `npcId` = 27376; -- 莉莉恩騎士
UPDATE `npcaidata` SET `aggro` = 400 WHERE `npcId` = 27377; -- 莉莉恩刺客
UPDATE `npcaidata` SET `aggro` = 400 WHERE `npcId` = 27378; -- 莉莉恩大魔道士
UPDATE `npcaidata` SET `aggro` = 400 WHERE `npcId` = 27379; -- 莉莉恩禁衛騎士

-- 修正錯誤
UPDATE npc SET type = 'L2Monster' WHERE id = 22766;
UPDATE `npcaidata` SET `aggro` = 300 WHERE `npcId` = 22766;
DELETE FROM spawnlist WHERE npc_templateid = 32760 AND locx = -24040;
DELETE FROM spawnlist WHERE npc_templateid = 32777 AND locx = -23993;
DELETE FROM spawnlist WHERE npc_templateid = 32778 AND locx = -23993;

-- 修正 Q195 怪物設定為主動
UPDATE npc SET type = 'L2Monster' WHERE id = 18834;  -- 黎明的警衛隊員
UPDATE `npcaidata` SET `aggro` = 150 WHERE `npcId` = 18834;
UPDATE npc SET type = 'L2Monster' WHERE id = 18835;  -- 黎明的警衛隊員
UPDATE `npcaidata` SET `aggro` = 150 WHERE `npcId` = 18835;
UPDATE npc SET type = 'L2Monster' WHERE id = 27351;  -- 黎明的警衛隊員
UPDATE `npcaidata` SET `aggro` = 150 WHERE `npcId` = 27351;

-- 刪除舊龍之谷怪物 NPC
DELETE FROM `spawnlist` WHERE `location` IN ('giran05_tb2421_59','giran05_tb2421_20','giran05_tb2421_29','giran03_tb2321_24','giran05_tb2421_10','giran05_tb2421_81','giran03_2221_02','giran03_2221_05','giran03_2221_08','giran03_2221_15','giran03_2221_19','giran03_2221_p05','giran03_2321_02','giran03_2321_04','giran03_2321_07','giran03_2321_09','giran03_2321_12','giran03_2321_15','giran05_2421_01','giran05_2421_08','giran05_2421_10','giran05_2421_17','giran05_2421_18','giran05_2421_29','giran05_2421_38','giran05_2421_45','giran05_2421_50','giran05_2421_53','giran05_2421_68','giran05_2421_75','giran05_2421_p04','giran05_2421_p50','giran03_2221_H5');

-- 修改龍之谷怪物 AI
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22815;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22818;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22819;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22820;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22821;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22822;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22823;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22824;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 400, `aiType` = 'balanced' WHERE `npcId` = 22825;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'balanced' WHERE `npcId` = 22826;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'balanced' WHERE `npcId` = 22827;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'balanced' WHERE `npcId` = 22828;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22829;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'balanced' WHERE `npcId` = 22830;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22831;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22832;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22833;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22834;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'balanced' WHERE `npcId` = 22835;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'balanced' WHERE `npcId` = 22836;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'balanced' WHERE `npcId` = 22837;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22838;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22839;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22840;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22841;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22842;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'archer' WHERE `npcId` = 22843;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22844;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22845;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22846;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22847;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22848;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22849;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22850;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22851;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22852;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22853;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22854;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22855;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22856;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'fighter' WHERE `npcId` = 22857;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'balanced' WHERE `npcId` = 22858;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'balanced' WHERE `npcId` = 22860;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'balanced' WHERE `npcId` = 22861;
UPDATE `npcaidata` SET `clanRange` = 300, `aggro` = 300, `aiType` = 'balanced' WHERE `npcId` = 22862;
UPDATE `npcaidata` SET `aggro` = 600 WHERE `npcId` = 25727;

-- NPC 增加或修改方法
-- `id`               = 18960,                                smallint(5) unsigned NOT NULL DEFAULT '0',
-- `idTemplate`       = 18960,                                smallint(5) unsigned NOT NULL DEFAULT '0',
-- `name`             = 'Drake Lord',                         varchar(200) NOT NULL DEFAULT '',
-- `serverSideName`   = 0,                                    tinyint(1) NOT NULL DEFAULT '0',
-- `title`            = '',                                   varchar(45) NOT NULL DEFAULT '',
-- `serverSideTitle`  = 0,                                    tinyint(1) NOT NULL DEFAULT '0',
-- `class`            = 'LineageMonster6.transform_clodecus', varchar(200) DEFAULT NULL,
-- `collision_radius` = 25,                                   decimal(6,2) DEFAULT NULL,
-- `collision_height` = 35,                                   decimal(6,2) DEFAULT NULL,
-- `level`            = 80,                                   tinyint(2) DEFAULT NULL,
-- `sex`              = 'male',                               enum('etc','female','male') NOT NULL DEFAULT 'etc',
-- `type`             = 'L2Npc',                              varchar(22) DEFAULT NULL,
-- `attackrange`      = 40,                                   smallint(4) DEFAULT NULL,
-- `hp`               = 2444,                                 decimal(30,15) DEFAULT NULL,
-- `mp`               = 2444,                                 decimal(30,15) DEFAULT NULL,
-- `hpreg`            = 0,                                    decimal(30,15) DEFAULT NULL,
-- `mpreg`            = 0,                                    decimal(30,15) DEFAULT NULL,
-- `str`              = 10,                                   tinyint(2) NOT NULL DEFAULT '40',
-- `con`              = 10,                                   tinyint(2) NOT NULL DEFAULT '43',
-- `dex`              = 10,                                   tinyint(2) NOT NULL DEFAULT '30',
-- `int`              = 10,                                   tinyint(2) NOT NULL DEFAULT '21',
-- `wit`              = 10,                                   tinyint(2) NOT NULL DEFAULT '20',
-- `men`              = 10,                                   tinyint(2) NOT NULL DEFAULT '20',
-- `exp`              = 0,                                    int(9) NOT NULL DEFAULT '0',
-- `sp`               = 0,                                    int(9) NOT NULL DEFAULT '0',
-- `patk`             = 500,                                  decimal(12,5) DEFAULT NULL,
-- `pdef`             = 500,                                  decimal(12,5) DEFAULT NULL,
-- `matk`             = 500,                                  decimal(12,5) DEFAULT NULL,
-- `mdef`             = 500,                                  decimal(12,5) DEFAULT NULL,
-- `atkspd`           = 278,                                  smallint(4) NOT NULL DEFAULT '230',
-- `critical`         = 1,                                    tinyint(1) NOT NULL DEFAULT '1',
-- `matkspd`          = 333,                                  smallint(4) NOT NULL DEFAULT '333',
-- `rhand`            = 0,                                    smallint(5) unsigned NOT NULL DEFAULT '0',
-- `lhand`            = 0,                                    smallint(5) unsigned NOT NULL DEFAULT '0',
-- `enchant`          = 0,                                    tinyint(1) NOT NULL DEFAULT '0',
-- `walkspd`          = 60,                                   decimal(10,5) NOT NULL DEFAULT '60',
-- `runspd`           = 160,                                  tinyint(1) NOT NULL DEFAULT '0',
-- `dropHerbGroup`    = 0,                                    tinyint(1) NOT NULL DEFAULT '0',
-- `basestats`        = 1,                                    tinyint(1) NOT NULL DEFAULT '0',

-- UPDATE `npc` SET `idTemplate`=18960,`name`='Drake Lord',`serverSideName`=0,`title`='',`serverSideTitle`=0,`class`='LineageMonster6.transform_clodecus',`collision_radius`=25,`collision_height`=35,`level`=80,`sex`='male',`type`='L2Npc',`attackrange`=40,`hp`=2444,`mp`=2444,`hpreg`=0,`mpreg`=0,`str`=10,`con`=10,`dex`=10,`int`=10,`wit`=10,`men`=10,`exp`=0,`sp`=0,`patk`=500,`pdef`=500,`matk`=500,`mdef`=500,`atkspd`=278,`critical`=1,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=18960;
-- REPLACE INTO `npc` VALUES 
-- (18960,18960,'Drake Lord',0,'',0,'LineageMonster6.transform_clodecus',25,35,80,'male','L2Npc',40,2444,2444,0,0,10,10,10,10,10,10,0,0,500,500,500,500,278,1,333,0,0,0,60,160,0,1),

-- 增加NPC 龍之谷
UPDATE `npc` SET `collision_radius`=22,`collision_height`=29,`level`=85,`sex`='male',`type`='L2RaidBoss',`hp`=3902308,`mp`=18468,`hpreg`=240,`mpreg`=500,`str`=60,`con`=57,`dex`=73,`int`=76,`wit`=70,`men`=80,`exp`=6653170,`sp`=900069,`patk`=11094,`pdef`=1428,`matk`=1192,`mdef`=576,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=18960;
UPDATE `npc` SET `collision_radius`=22,`collision_height`=52,`level`=85,`sex`='male',`type`='L2RaidBoss',`hp`=3902308,`mp`=18468,`hpreg`=240,`mpreg`=500,`str`=60,`con`=57,`dex`=73,`int`=76,`wit`=70,`men`=80,`exp`=6653170,`sp`=900069,`patk`=11094,`pdef`=1428,`matk`=1192,`mdef`=576,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=18961;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=29,`level`=80,`sex`='male',`type`='L2Monster',`hp`=3290,`mp`=1777,`hpreg`=8.7,`mpreg`=3.1,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=41310,`sp`=4436,`patk`=1200,`pdef`=858,`matk`=677,`mdef`=500,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=79,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=1,`basestats`=1 WHERE `id`=22815;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=27,`level`=81,`sex`='male',`type`='L2Monster',`hp`=4039,`mp`=1812,`hpreg`=8.5,`mpreg`=3,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=25020,`sp`=2771,`patk`=1600,`pdef`=658,`matk`=478,`mdef`=500,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=1,`basestats`=1 WHERE `id`=22818;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=25,`level`=81,`sex`='male',`type`='L2Monster',`hp`=4039,`mp`=1812,`hpreg`=8.5,`mpreg`=3,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=25020,`sp`=2771,`patk`=1600,`pdef`=658,`matk`=478,`mdef`=500,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=1,`basestats`=1 WHERE `id`=22819;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=52,`level`=82,`sex`='male',`type`='L2Monster',`hp`=3643,`mp`=1743,`hpreg`=8,`mpreg`=3,`str`=43,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=27169,`sp`=2971,`patk`=2100,`pdef`=1400,`matk`=535,`mdef`=800,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22820;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=29,`level`=82,`sex`='male',`type`='L2Monster',`hp`=3643,`mp`=1743,`hpreg`=8,`mpreg`=3,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=27169,`sp`=2971,`patk`=739,`pdef`=796,`matk`=535,`mdef`=593,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22821;
UPDATE `npc` SET `collision_radius`=36,`collision_height`=58,`level`=83,`sex`='male',`type`='L2Monster',`hp`=18734,`mp`=1777,`hpreg`=8.5,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=417476,`sp`=42928,`patk`=2100,`pdef`=1300,`matk`=781,`mdef`=700,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=1,`basestats`=0 WHERE `id`=22822;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=29,`level`=83,`sex`='male',`type`='L2Monster',`hp`=18734,`mp`=1777,`hpreg`=8.5,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=289444,`sp`=29772,`patk`=1600,`pdef`=840,`matk`=378,`mdef`=526,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22823;
UPDATE `npc` SET `collision_radius`=36,`collision_height`=58,`level`=84,`sex`='male',`type`='L2Monster',`hp`=18684,`mp`=1777,`hpreg`=8.5,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=573020,`sp`=58196,`patk`=1700,`pdef`=1200,`matk`=517,`mdef`=700,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=1,`basestats`=0 WHERE `id`=22824;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=58,`level`=83,`sex`='male',`type`='L2Monster',`hp`=56202,`mp`=1777,`hpreg`=8.5,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=494068,`sp`=53357,`patk`=1700,`pdef`=1200,`matk`=538,`mdef`=1000,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=175,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22825;
UPDATE `npc` SET `collision_radius`=26,`collision_height`=24,`level`=83,`sex`='male',`type`='L2Monster',`hp`=18734,`mp`=1777,`hpreg`=8.5,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=286890,`sp`=29496,`patk`=2100,`pdef`=1200,`matk`=632,`mdef`=587,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22826;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=92,`level`=84,`sex`='male',`type`='L2Monster',`hp`=56054,`mp`=1777,`hpreg`=8.5,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=529071,`sp`=56448,`patk`=1700,`pdef`=1200,`matk`=581,`mdef`=1400,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22827;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=15,`level`=83,`sex`='male',`type`='L2Monster',`hp`=18734,`mp`=1777,`hpreg`=8.5,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=287945,`sp`=29610,`patk`=1700,`pdef`=1300,`matk`=587,`mdef`=700,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22828;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=92,`level`=82,`sex`='male',`type`='L2Monster',`hp`=56403,`mp`=1777,`hpreg`=8.5,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=500143,`sp`=54691,`patk`=1700,`pdef`=1200,`matk`=781,`mdef`=900,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22829;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=24,`level`=83,`sex`='male',`type`='L2Monster',`hp`=18734,`mp`=1777,`hpreg`=8.5,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=285853,`sp`=29384,`patk`=2100,`pdef`=658,`matk`=584,`mdef`=600,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22830;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=36,`level`=83,`sex`='male',`type`='L2Monster',`hp`=56202,`mp`=1777,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=593073,`sp`=64049,`patk`=2100,`pdef`=1400,`matk`=734,`mdef`=900,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22831;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=27,`level`=83,`sex`='male',`type`='L2Monster',`hp`=56202,`mp`=1777,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=582118,`sp`=62866,`patk`=2100,`pdef`=1300,`matk`=734,`mdef`=900,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22832;
UPDATE `npc` SET `collision_radius`=7,`collision_height`=92,`level`=83,`sex`='male',`type`='L2Monster',`hp`=56202,`mp`=1777,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=619381,`sp`=66891,`patk`=1900,`pdef`=1300,`matk`=734,`mdef`=900,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22833;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=29,`level`=84,`sex`='male',`type`='L2Monster',`hp`=56054,`mp`=1777,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=644700,`sp`=68785,`patk`=2100,`pdef`=1400,`matk`=734,`mdef`=900,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22834;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=42,`level`=83,`sex`='male',`type`='L2Monster',`hp`=3835,`mp`=1777,`hpreg`=8,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=41000,`sp`=27000,`patk`=1700,`pdef`=1400,`matk`=724,`mdef`=749,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22835;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=15,`level`=83,`sex`='male',`type`='L2Monster',`hp`=3835,`mp`=1777,`hpreg`=8,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=41000,`sp`=4600,`patk`=1700,`pdef`=876,`matk`=689,`mdef`=574,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22836;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=15,`level`=83,`sex`='male',`type`='L2Monster',`hp`=3835,`mp`=1777,`hpreg`=8.5,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=41000,`sp`=4600,`patk`=1700,`pdef`=854,`matk`=599,`mdef`=700,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22837;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=43,`level`=85,`sex`='male',`type`='L2Monster',`hp`=55817,`mp`=1846,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=555716,`sp`=58594,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22838;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=55,`level`=85,`sex`='male',`type`='L2Monster',`hp`=55817,`mp`=1846,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=537433,`sp`=56666,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22839;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=32,`level`=85,`sex`='male',`type`='L2Monster',`hp`=55817,`mp`=1846,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=203619,`sp`=20360,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22840;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=40,`level`=85,`sex`='female',`type`='L2Monster',`hp`=18605,`mp`=1846,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=336705,`sp`=33738,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22841;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=29,`level`=85,`sex`='female',`type`='L2Monster',`hp`=18605,`mp`=1846,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=336705,`sp`=33738,`patk`=934,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22842;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=27,`level`=85,`sex`='male',`type`='L2Monster',`hp`=55817,`mp`=1846,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=200088,`sp`=19988,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22843;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=35,`level`=85,`sex`='male',`type`='L2Monster',`hp`=88192,`mp`=2253,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=589013,`sp`=59033,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22844;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=48,`level`=85,`sex`='male',`type`='L2Monster',`hp`=88192,`mp`=2253,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=589013,`sp`=59033,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22845;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=48,`level`=85,`sex`='male',`type`='L2Monster',`hp`=18605,`mp`=1846,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=765812,`sp`=76753,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22846;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=32,`level`=85,`sex`='male',`type`='L2Monster',`hp`=32596,`mp`=1846,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=361543,`sp`=38120,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22847;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=48,`level`=85,`sex`='male',`type`='L2Monster',`hp`=55817,`mp`=1846,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=600571,`sp`=63323,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22848;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=39,`level`=85,`sex`='male',`type`='L2Monster',`hp`=18605,`mp`=1846,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=372672,`sp`=37354,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22849;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=36,`level`=85,`sex`='male',`type`='L2Monster',`hp`=32596,`mp`=1846,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=135650,`sp`=13605,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22850;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=39,`level`=85,`sex`='male',`type`='L2Monster',`hp`=32596,`mp`=1846,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=342513,`sp`=36114,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22851;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=55,`level`=85,`sex`='male',`type`='L2Monster',`hp`=55817,`mp`=1846,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=1031278,`sp`=103445,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22852;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=33,`level`=85,`sex`='male',`type`='L2Monster',`attackrange`=80,`hp`=55817,`mp`=1846,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=548640,`sp`=57848,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22853;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=55,`level`=81,`sex`='male',`type`='L2Monster',`hp`=333456,`mp`=1881,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=868728,`sp`=88089,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22854;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=42,`level`=86,`sex`='male',`type`='L2Monster',`hp`=333456,`mp`=1881,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=614011,`sp`=62855,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22855;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=35,`level`=86,`sex`='male',`type`='L2Monster',`hp`=333456,`mp`=1881,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=614011,`sp`=62855,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22856;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=40,`level`=85,`sex`='male',`type`='L2Monster',`hp`=334640,`mp`=1846,`hpreg`=8,`mpreg`=4,`str`=43,`con`=45,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=3301929,`sp`=348153,`patk`=1144,`pdef`=835,`matk`=523,`mdef`=625,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=1,`basestats`=0 WHERE `id`=22857;
UPDATE `npc` SET `collision_radius`=20,`collision_height`=27,`level`=82,`sex`='male',`type`='L2Monster',`hp`=3643,`mp`=1743,`hpreg`=8.5,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=26974,`sp`=2949,`patk`=943,`pdef`=740,`matk`=620,`mdef`=570,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22858;
UPDATE `npc` SET `collision_radius`=50,`collision_height`=15,`level`=82,`sex`='male',`type`='L2Monster',`hp`=18801,`mp`=1777,`hpreg`=8.5,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=289372,`sp`=30117,`patk`=1144,`pdef`=840,`matk`=700,`mdef`=580,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22860;
UPDATE `npc` SET `collision_radius`=12,`collision_height`=58,`level`=83,`sex`='male',`type`='L2Monster',`hp`=56202,`mp`=1777,`hpreg`=8.5,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=486444,`sp`=52534,`patk`=1700,`pdef`=1200,`matk`=700,`mdef`=800,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22861;
UPDATE `npc` SET `collision_radius`=36,`collision_height`=58,`level`=83,`sex`='male',`type`='L2Monster',`hp`=18734,`mp`=1777,`hpreg`=8.5,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=410695,`sp`=42195,`patk`=2100,`pdef`=1200,`matk`=650,`mdef`=700,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=22862;
UPDATE `npc` SET `collision_radius`=22,`collision_height`=48,`level`=85,`sex`='male',`type`='L2RaidBoss',`hp`=3902308,`mp`=18468,`hpreg`=240,`mpreg`=500,`str`=60,`con`=57,`dex`=73,`int`=76,`wit`=70,`men`=80,`exp`=6653170,`sp`=900069,`patk`=11094,`pdef`=1428,`matk`=1192,`mdef`=576,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=25725;
UPDATE `npc` SET `collision_radius`=22,`collision_height`=52,`level`=85,`sex`='male',`type`='L2RaidBoss',`hp`=3902308,`mp`=18468,`hpreg`=240,`mpreg`=500,`str`=60,`con`=57,`dex`=73,`int`=76,`wit`=70,`men`=80,`exp`=6653170,`sp`=900069,`patk`=11094,`pdef`=1428,`matk`=1192,`mdef`=576,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=120,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=25726;
UPDATE `npc` SET `collision_radius`=45,`collision_height`=85,`level`=85,`sex`='male',`type`='L2RaidBoss',`hp`=3902308,`mp`=18468,`hpreg`=190.745,`mpreg`=2.7,`str`=40,`con`=43,`dex`=50,`int`=21,`wit`=20,`men`=20,`exp`=0,`sp`=0,`patk`=15000,`pdef`=1500,`matk`=18000,`mdef`=1800,`atkspd`=253,`critical`=4,`matkspd`=500,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=110,`runspd`=180,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=25727;
UPDATE `npc` SET `collision_radius`=20,`collision_height`=30,`level`=80,`sex`='male',`type`='L2Npc',`hp`=3216,`mp`=37426,`hpreg`=8,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=0,`sp`=0,`patk`=635,`pdef`=743,`matk`=732,`mdef`=823,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=25733;
UPDATE `npc` SET `collision_radius`=8,`collision_height`=25,`level`=80,`sex`='male',`type`='L2Npc',`hp`=3567,`mp`=1777,`hpreg`=8,`mpreg`=3,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=0,`sp`=0,`patk`=123,`pdef`=123,`matk`=432,`mdef`=432,`atkspd`=253,`critical`=1,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=32864;
UPDATE `npc` SET `collision_radius`=8,`collision_height`=25,`level`=80,`sex`='male',`type`='L2Npc',`hp`=3567,`mp`=1777,`hpreg`=8,`mpreg`=3,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=0,`sp`=0,`patk`=123,`pdef`=123,`matk`=432,`mdef`=432,`atkspd`=253,`critical`=1,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=32865;
UPDATE `npc` SET `collision_radius`=8,`collision_height`=25,`level`=80,`sex`='male',`type`='L2Npc',`hp`=3567,`mp`=1777,`hpreg`=8,`mpreg`=3,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=0,`sp`=0,`patk`=123,`pdef`=123,`matk`=432,`mdef`=432,`atkspd`=253,`critical`=1,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=32866;
UPDATE `npc` SET `collision_radius`=8,`collision_height`=25,`level`=80,`sex`='male',`type`='L2Npc',`hp`=3567,`mp`=1777,`hpreg`=8,`mpreg`=3,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=0,`sp`=0,`patk`=123,`pdef`=123,`matk`=432,`mdef`=432,`atkspd`=253,`critical`=1,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=32867;
UPDATE `npc` SET `collision_radius`=8,`collision_height`=25,`level`=80,`sex`='male',`type`='L2Npc',`hp`=3567,`mp`=1777,`hpreg`=8,`mpreg`=3,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=0,`sp`=0,`patk`=123,`pdef`=123,`matk`=432,`mdef`=432,`atkspd`=253,`critical`=1,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=32868;
UPDATE `npc` SET `collision_radius`=8,`collision_height`=25,`level`=80,`sex`='male',`type`='L2Npc',`hp`=3567,`mp`=1777,`hpreg`=8,`mpreg`=3,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=0,`sp`=0,`patk`=123,`pdef`=123,`matk`=432,`mdef`=432,`atkspd`=253,`critical`=1,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=32869;
UPDATE `npc` SET `collision_radius`=8,`collision_height`=25,`level`=80,`sex`='male',`type`='L2Npc',`hp`=3567,`mp`=1777,`hpreg`=8,`mpreg`=3,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=0,`sp`=0,`patk`=123,`pdef`=123,`matk`=432,`mdef`=432,`atkspd`=253,`critical`=1,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=32870;
UPDATE `npc` SET `collision_radius`=8,`collision_height`=25,`level`=80,`sex`='male',`type`='L2Npc',`hp`=6342,`mp`=4738,`hpreg`=8,`mpreg`=4,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=0,`sp`=0,`patk`=494,`pdef`=494,`matk`=783,`mdef`=432,`atkspd`=253,`critical`=1,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=32871;
UPDATE `npc` SET `collision_radius`=8,`collision_height`=25,`level`=80,`sex`='male',`type`='L2Npc',`hp`=3567,`mp`=1777,`hpreg`=8,`mpreg`=3,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=0,`sp`=0,`patk`=123,`pdef`=123,`matk`=432,`mdef`=432,`atkspd`=253,`critical`=1,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=60,`runspd`=160,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=32891;

REPLACE INTO `droplist` VALUES
-- Drakos
('22815', '57', '2710', '6322', '0', '700000'),
('22815', '4039', '1', '1', '-1', '180000'),
('22815', '6622', '1', '1', '1', '5000'),
('22815', '9442', '1', '1', '1', '9'),
('22815', '9443', '1', '1', '1', '9'),
('22815', '9444', '1', '1', '1', '9'),
('22815', '9445', '1', '1', '1', '9'),
('22815', '9446', '1', '1', '1', '9'),
('22815', '9447', '1', '1', '1', '9'),
('22815', '9448', '1', '1', '1', '9'),
('22815', '9449', '1', '1', '1', '9'),
('22815', '9450', '1', '1', '1', '9'),
('22815', '9550', '1', '1', '1', '10000'),
('22815', '9573', '1', '1', '200', '10000'),
('22815', '9574', '1', '1', '200', '5000'),
('22815', '9575', '1', '1', '200', '500'),
('22815', '9628', '1', '1', '-1', '5000'),
('22815', '10218', '1', '1', '-1', '9'),
('22815', '10252', '1', '1', '1', '9'),
('22815', '10253', '1', '1', '1', '9'),
('22815', '10403', '1', '1', '-1', '10000'),
('22815', '15778', '1', '1', '-1', '5000'),
-- 
('22818', '57', '1624', '3794', '0', '700000'),
('22818', '1879', '1', '3', '2', '100000'),
('22818', '1885', '1', '3', '2', '100000'),
('22818', '4040', '1', '3', '-1', '100000'),
('22818', '6622', '1', '1', '1', '100'),
('22818', '9550', '1', '1', '2', '1000'),
('22818', '9573', '1', '1', '200', '1000'),
('22818', '9574', '1', '1', '200', '1000'),
('22818', '9575', '1', '1', '200', '100'),
('22818', '9628', '1', '1', '2', '1000'),
('22818', '9629', '1', '2', '2', '7000'),
('22818', '9630', '1', '2', '-1', '40000'),
('22818', '9630', '1', '1', '2', '1000'),
('22818', '10219', '1', '1', '-1', '9'),
('22818', '10402', '1', '1', '-1', '1000'),
('22818', '15695', '1', '1', '1', '50'),
('22818', '15703', '1', '1', '1', '50'),
('22818', '15704', '1', '1', '1', '50'),
('22818', '15705', '1', '1', '1', '50'),
('22818', '15781', '1', '1', '-1', '1000'),
-- 
('22819', '57', '1624', '3794', '0', '700000'),
('22819', '1895', '1', '3', '2', '100000'),
('22819', '4040', '1', '2', '2', '50000'),
('22819', '6622', '1', '1', '1', '100'),
('22819', '9550', '1', '1', '1', '1000'),
('22819', '9573', '1', '1', '200', '1000'),
('22819', '9574', '1', '1', '200', '1000'),
('22819', '9575', '1', '1', '200', '100'),
('22819', '9628', '1', '1', '1', '1000'),
('22819', '9630', '1', '1', '2', '1000'),
('22819', '10218', '1', '1', '-1', '9'),
('22819', '10403', '1', '1', '-1', '1000'),
('22819', '15706', '1', '1', '1', '50'),
('22819', '15707', '1', '1', '1', '50'),
('22819', '15708', '1', '1', '1', '50'),
('22819', '15768', '1', '1', '1', '50'),
('22819', '15778', '1', '1', '-1', '500'),
-- 
('22820', '57', '1724', '4029', '0', '700000'),
('22820', '1879', '1', '1', '2', '50000'),
('22820', '1885', '1', '1', '2', '30000'),
('22820', '4041', '1', '1', '-1', '40000'),
('22820', '6622', '1', '1', '1', '2000'),
('22820', '9550', '1', '1', '2', '5000'),
('22820', '9573', '1', '1', '200', '5000'),
('22820', '9574', '1', '1', '200', '500'),
('22820', '9575', '1', '1', '200', '50'),
('22820', '9628', '1', '1', '2', '5000'),
('22820', '9629', '1', '1', '-1', '20000'),
('22820', '9629', '1', '1', '2', '5000'),
('22820', '9630', '1', '1', '2', '5000'),
('22820', '10215', '1', '1', '1', '9'),
('22820', '10404', '1', '1', '-1', '5000'),
('22820', '13893', '1', '1', '1', '10'),
('22820', '15709', '1', '1', '1', '50'),
('22820', '15710', '1', '1', '1', '50'),
('22820', '15780', '1', '1', '-1', '5000'),
-- 
('22822', '57', '18619', '43478', '0', '700000'),
('22822', '1879', '1', '3', '2', '220000'),
('22822', '1885', '1', '1', '2', '250000'),
('22822', '4042', '1', '1', '-1', '470000'),
('22822', '6622', '1', '1', '1', '1000'),
('22822', '9546', '1', '1', '2', '30000'),
('22822', '9552', '1', '1', '1', '50'),
('22822', '9628', '1', '1', '-1', '220000'),
('22822', '9628', '1', '1', '2', '23000'),
('22822', '9629', '1', '1', '2', '13000'),
('22822', '9630', '1', '1', '2', '15000'),
('22822', '10221', '1', '1', '1', '5'),
('22822', '10373', '1', '1', '-1', '500'),
('22822', '10397', '1', '1', '-1', '12000'),
('22822', '10401', '1', '1', '-1', '15000'),
('22822', '10483', '1', '1', '200', '20000'),
('22822', '10484', '1', '1', '200', '500'),
('22822', '10485', '1', '1', '200', '50'),
('22822', '15697', '1', '1', '-1', '50'),
('22822', '15697', '1', '1', '1', '10'),
('22822', '15780', '1', '1', '-1', '1000'),
('22822', '17248', '1', '1', '1', '500'),
-- 
('22823', '57', '13033', '30434', '0', '700000'),
('22823', '959', '1', '1', '-1', '100'),
('22823', '1894', '1', '1', '2', '100000'),
('22823', '4039', '1', '1', '2', '100000'),
('22823', '4041', '1', '1', '2', '30000'),
('22823', '4043', '1', '1', '-1', '600000'),
('22823', '4044', '1', '1', '2', '100000'),
('22823', '6622', '1', '1', '1', '1000'),
('22823', '9546', '1', '1', '2', '20000'),
('22823', '9630', '1', '1', '-1', '100000'),
('22823', '10220', '1', '1', '-1', '5'),
('22823', '10223', '1', '1', '-1', '5'),
('22823', '10223', '1', '1', '1', '3'),
('22823', '10402', '1', '1', '-1', '1000'),
('22823', '10483', '1', '1', '200', '15000'),
('22823', '10484', '1', '1', '200', '1000'),
('22823', '10485', '1', '1', '200', '500'),
('22823', '15699', '1', '1', '1', '10'),
('22823', '15706', '1', '1', '1', '50'),
('22823', '15804', '1', '1', '-1', '12000'),
('22823', '15805', '1', '1', '-1', '13000'),
('22823', '15806', '1', '1', '-1', '12000'),
('22823', '17248', '1', '1', '1', '500'),
-- 
('22824', '57', '25780', '60169', '0', '700000'),
('22824', '1879', '3', '9', '2', '78000'),
('22824', '1885', '2', '6', '2', '60000'),
('22824', '1888', '1', '1', '2', '84000'),
('22824', '1890', '1', '1', '2', '43000'),
('22824', '4044', '1', '3', '-1', '550000'),
('22824', '5550', '1', '1', '2', '37000'),
('22824', '6622', '1', '1', '1', '10569'),
('22824', '9546', '1', '1', '2', '23000'),
('22824', '9552', '1', '1', '1', '1000'),
('22824', '9627', '1', '1', '1', '500'),
('22824', '9628', '1', '1', '2', '22000'),
('22824', '9629', '1', '1', '-1', '150000'),
('22824', '9629', '1', '1', '2', '13000'),
('22824', '9630', '1', '1', '2', '16000'),
('22824', '10216', '1', '1', '-1', '5'),
('22824', '10216', '1', '1', '1', '50'),
('22824', '10403', '1', '1', '-1', '14000'),
('22824', '10483', '1', '1', '200', '20000'),
('22824', '10484', '1', '1', '200', '5000'),
('22824', '10485', '1', '1', '200', '500'),
('22824', '15697', '1', '1', '1', '500'),
('22824', '15778', '1', '1', '-1', '10000'),
('22824', '15794', '1', '1', '-1', '20000'),
('22824', '15797', '1', '1', '-1', '10000'),
('22824', '15800', '1', '1', '-1', '16000'),
('22824', '17248', '1', '1', '1', '5000'),
-- 
('22825', '57', '24584', '57408', '0', '700000'),
('22825', '959', '1', '1', '1', '50'),
('22825', '1895', '3', '9', '2', '700000'),
('22825', '4039', '1', '3', '-1', '600000'),
('22825', '4040', '1', '1', '2', '80000'),
('22825', '4042', '1', '1', '2', '65000'),
('22825', '4043', '1', '1', '2', '130000'),
('22825', '6622', '1', '1', '1', '16000'),
('22825', '9549', '1', '1', '2', '32000'),
('22825', '9628', '1', '1', '-1', '300000'),
('22825', '10215', '1', '1', '1', '5'),
('22825', '10404', '1', '1', '-1', '16000'),
('22825', '10483', '1', '1', '200', '28000'),
('22825', '10484', '1', '1', '200', '1000'),
('22825', '10485', '1', '1', '200', '100'),
('22825', '15710', '1', '1', '1', '50'),
('22825', '15780', '1', '1', '-1', '15500'),
('22825', '15801', '1', '1', '-1', '31000'),
('22825', '15802', '1', '1', '-1', '32000'),
('22825', '15803', '1', '1', '-1', '32000'),
('22825', '17248', '1', '1', '1', '500'),
-- 
('22826', '57', '13579', '31708', '0', '700000'),
('22826', '959', '1', '1', '1', '10'),
('22826', '1895', '1', '3', '2', '320000'),
('22826', '4040', '1', '1', '-1', '430000'),
('22826', '4040', '1', '1', '2', '50000'),
('22826', '6622', '1', '1', '1', '1000'),
('22826', '9549', '1', '1', '2', '20000'),
('22826', '9628', '1', '1', '2', '17000'),
('22826', '9630', '1', '1', '-1', '110000'),
('22826', '9630', '1', '1', '2', '12000'),
('22826', '10216', '1', '1', '1', '5'),
('22826', '10397', '1', '1', '-1', '1000'),
('22826', '10398', '1', '1', '-1', '1000'),
('22826', '10399', '1', '1', '-1', '1000'),
('22826', '10402', '1', '1', '-1', '1000'),
('22826', '10483', '1', '1', '200', '15000'),
('22826', '10484', '1', '1', '200', '500'),
('22826', '10485', '1', '1', '200', '50'),
('22826', '15703', '1', '1', '1', '50'),
('22826', '15778', '1', '1', '-1', '1000'),
('22826', '17248', '1', '1', '1', '500'),
-- 
('22827', '57', '25908', '60468', '0', '700000'),
('22827', '1879', '3', '9', '2', '110000'),
('22827', '1885', '2', '6', '2', '85000'),
('22827', '6622', '1', '1', '1', '8000'),
('22827', '9548', '1', '1', '2', '32000'),
('22827', '9628', '1', '1', '2', '31000'),
('22827', '9629', '1', '1', '-1', '210000'),
('22827', '9629', '1', '1', '2', '17000'),
('22827', '9630', '1', '1', '2', '20000'),
('22827', '10215', '1', '1', '-1', '100'),
('22827', '10216', '1', '1', '-1', '100'),
('22827', '10217', '1', '1', '1', '50'),
('22827', '10399', '1', '1', '-1', '19000'),
('22827', '10402', '1', '1', '-1', '20000'),
('22827', '10483', '1', '1', '200', '27000'),
('22827', '10484', '1', '1', '200', '10000'),
('22827', '10485', '1', '1', '200', '1000'),
('22827', '15709', '1', '1', '1', '500'),
('22827', '15778', '1', '1', '-1', '14000'),
('22827', '17248', '1', '1', '1', '5000'),
-- 
('22828', '57', '13629', '31826', '0', '700000'),
('22828', '1879', '1', '3', '2', '180000'),
('22828', '1885', '1', '1', '2', '170000'),
('22828', '4042', '1', '1', '-1', '360000'),
('22828', '6622', '1', '1', '1', '1000'),
('22828', '9547', '1', '1', '2', '16000'),
('22828', '9553', '1', '1', '2', '50'),
('22828', '9628', '1', '1', '-1', '170000'),
('22828', '9628', '1', '1', '2', '17000'),
('22828', '9629', '1', '1', '2', '1000'),
('22828', '9630', '1', '1', '2', '1000'),
('22828', '10218', '1', '1', '-1', '5'),
('22828', '10218', '1', '1', '1', '5'),
('22828', '10397', '1', '1', '-1', '1000'),
('22828', '10401', '1', '1', '-1', '1000'),
('22828', '10483', '1', '1', '200', '14000'),
('22828', '10484', '1', '1', '200', '500'),
('22828', '10485', '1', '1', '200', '50'),
('22828', '13893', '1', '1', '-1', '50'),
('22828', '15704', '1', '1', '1', '50'),
('22828', '15781', '1', '1', '-1', '1000'),
('22828', '17248', '1', '1', '1', '500'),
-- 
('22829', '57', '25783', '60208', '0', '700000'),
('22829', '959', '1', '1', '-1', '500'),
('22829', '1895', '3', '9', '2', '200000'),
('22829', '4040', '1', '1', '2', '150000'),
('22829', '6622', '1', '1', '1', '15000'),
('22829', '9547', '1', '1', '2', '50000'),
('22829', '9555', '1', '1', '1', '100'),
('22829', '9628', '1', '1', '2', '30000'),
('22829', '9630', '1', '1', '-1', '350000'),
('22829', '9630', '1', '1', '2', '25000'),
('22829', '10217', '1', '1', '-1', '10'),
('22829', '10219', '1', '1', '1', '10'),
('22829', '10403', '1', '1', '-1', '30000'),
('22829', '10483', '1', '1', '200', '30000'),
('22829', '10484', '1', '1', '200', '1000'),
('22829', '10485', '1', '1', '200', '100'),
('22829', '15697', '1', '1', '1', '50'),
('22829', '15780', '1', '1', '-1', '25000'),
('22829', '17248', '1', '1', '1', '500'),
-- 
('22830', '57', '12867', '30047', '0', '700000'),
('22830', '959', '1', '1', '1', '10'),
('22830', '1879', '1', '1', '2', '250000'),
('22830', '1885', '1', '1', '2', '130000'),
('22830', '1888', '1', '1', '2', '60000'),
('22830', '1890', '1', '1', '2', '30000'),
('22830', '4044', '1', '1', '-1', '720000'),
('22830', '5550', '1', '1', '2', '20000'),
('22830', '6622', '1', '1', '1', '1000'),
('22830', '9546', '1', '1', '2', '15000'),
('22830', '9628', '1', '1', '2', '11000'),
('22830', '9629', '1', '1', '-1', '100000'),
('22830', '9629', '1', '1', '2', '1000'),
('22830', '9630', '1', '1', '2', '1000'),
('22830', '10215', '1', '1', '-1', '5'),
('22830', '10220', '1', '1', '1', '5'),
('22830', '10397', '1', '1', '-1', '1000'),
('22830', '10404', '1', '1', '-1', '1000'),
('22830', '10483', '1', '1', '200', '1000'),
('22830', '10484', '1', '1', '200', '500'),
('22830', '10485', '1', '1', '200', '50'),
('22830', '15703', '1', '1', '1', '50'),
('22830', '15781', '1', '1', '-1', '1000'),
('22830', '17248', '1', '1', '1', '100'),
-- 
('22831', '57', '27119', '63328', '0', '700000'),
('22831', '1895', '3', '9', '2', '170000'),
('22831', '4040', '1', '1', '2', '73000'),
('22831', '6622', '1', '1', '-1', '43000'),
('22831', '6622', '1', '1', '1', '14000'),
('22831', '9546', '1', '1', '-1', '90000'),
('22831', '9546', '1', '1', '2', '30000'),
('22831', '9554', '1', '1', '1', '100'),
('22831', '9628', '1', '1', '2', '30000'),
('22831', '9630', '1', '1', '2', '19000'),
('22831', '10218', '1', '1', '-1', '10'),
('22831', '10221', '1', '1', '1', '50'),
('22831', '10383', '1', '1', '-1', '1000'),
('22831', '10383', '1', '1', '1', '50'),
('22831', '10384', '1', '1', '-1', '1000'),
('22831', '10384', '1', '1', '1', '50'),
('22831', '10397', '1', '1', '-1', '25000'),
('22831', '10398', '1', '1', '-1', '25000'),
('22831', '10483', '1', '1', '200', '25000'),
('22831', '10484', '1', '1', '200', '10000'),
('22831', '10485', '1', '1', '200', '100'),
('22831', '13893', '1', '1', '-1', '500'),
('22831', '13893', '1', '1', '1', '10'),
('22831', '14052', '1', '3', '-1', '680000'),
('22831', '15699', '1', '1', '1', '500'),
('22831', '17248', '1', '1', '-1', '6000'),
('22831', '17248', '1', '1', '1', '2000'),
-- 
('22832', '57', '26621', '62165', '0', '700000'),
('22832', '1879', '3', '9', '2', '80000'),
('22832', '1885', '1', '1', '2', '240000'),
('22832', '6622', '1', '1', '1', '11000'),
('22832', '9546', '1', '1', '2', '23000'),
('22832', '9554', '1', '1', '1', '1000'),
('22832', '9628', '1', '1', '2', '22000'),
('22832', '9629', '1', '1', '2', '13000'),
('22832', '9630', '1', '1', '2', '15000'),
('22832', '10217', '1', '1', '-1', '100'),
('22832', '10222', '1', '1', '1', '50'),
('22832', '10373', '1', '1', '1', '500'),
('22832', '10374', '1', '1', '1', '500'),
('22832', '10377', '1', '1', '1', '500'),
('22832', '10378', '1', '1', '1', '300'),
('22832', '10399', '1', '1', '-1', '24000'),
('22832', '10401', '1', '1', '-1', '24000'),
('22832', '10483', '1', '1', '200', '20000'),
('22832', '10484', '1', '1', '200', '5000'),
('22832', '10485', '1', '1', '200', '500'),
('22832', '14052', '1', '3', '-1', '680000'),
('22832', '15694', '1', '1', '1', '500'),
('22832', '15709', '1', '1', '1', '500'),
('22832', '15778', '1', '1', '-1', '17000'),
('22832', '17248', '1', '1', '1', '2000'),
('22833', '57', '28329', '66153', '0', '700000'),
('22833', '1879', '3', '9', '2', '85000'),
('22833', '1885', '1', '1', '2', '270000'),
('22833', '6622', '1', '1', '1', '12000'),
('22833', '9549', '1', '1', '2', '24000'),
('22833', '9555', '1', '1', '1', '1000'),
('22833', '9628', '1', '1', '2', '24000'),
('22833', '9629', '1', '1', '2', '14000'),
('22833', '9630', '1', '1', '2', '17000'),
('22833', '10219', '1', '1', '-1', '50'),
('22833', '10223', '1', '1', '1', '50'),
('22833', '10375', '1', '1', '1', '500'),
('22833', '10376', '1', '1', '1', '500'),
('22833', '10379', '1', '1', '1', '500'),
('22833', '10380', '1', '1', '1', '500'),
('22833', '10402', '1', '1', '-1', '15000'),
('22833', '10483', '1', '1', '200', '22000'),
('22833', '10484', '1', '1', '200', '5000'),
('22833', '10485', '1', '1', '200', '500'),
('22833', '13893', '1', '1', '-1', '500'),
('22833', '13893', '1', '1', '1', '100'),
('22833', '14052', '1', '1', '-1', '960000'),
('22833', '15699', '1', '1', '1', '100'),
('22833', '15706', '1', '1', '1', '500'),
('22833', '15780', '1', '1', '-1', '15000'),
('22833', '15792', '1', '1', '-1', '22000'),
('22833', '15795', '1', '1', '-1', '1000'),
('22833', '15798', '1', '1', '-1', '13000'),
('22833', '17248', '1', '1', '1', '2000'),
-- 
('22834', '57', '29134', '67996', '0', '700000'),
('22834', '1895', '3', '9', '2', '170000'),
('22834', '4040', '1', '1', '2', '67000'),
('22834', '6622', '1', '1', '1', '13000'),
('22834', '9549', '1', '1', '2', '26000'),
('22834', '9555', '1', '1', '1', '1000'),
('22834', '9628', '1', '1', '2', '27000'),
('22834', '9630', '1', '1', '2', '18000'),
('22834', '10217', '1', '1', '-1', '100'),
('22834', '10217', '1', '1', '1', '50'),
('22834', '10218', '1', '1', '1', '50'),
('22834', '10381', '1', '1', '1', '500'),
('22834', '10382', '1', '1', '1', '500'),
('22834', '10383', '1', '1', '1', '500'),
('22834', '10384', '1', '1', '1', '500'),
('22834', '10403', '1', '1', '-1', '21000'),
('22834', '10483', '1', '1', '200', '23000'),
('22834', '10484', '1', '1', '200', '10000'),
('22834', '10485', '1', '1', '200', '1000'),
('22834', '14052', '1', '3', '-1', '620000'),
('22834', '15710', '1', '1', '1', '500'),
('22834', '15781', '1', '1', '-1', '23000'),
('22834', '15807', '1', '1', '-1', '42000'),
('22834', '15808', '1', '1', '-1', '41000'),
('22834', '17248', '1', '1', '1', '2000'),
-- 
('22835', '6577', '1', '1', '1', '100'),
('22835', '6578', '1', '1', '1', '500'),
-- 
('22836', '6577', '1', '1', '-1', '500'),
('22836', '6577', '1', '1', '1', '50'),
('22836', '6578', '1', '1', '-1', '1000'),
('22836', '6578', '1', '1', '1', '500'),
-- 
('22837', '6577', '1', '1', '1', '50'),
('22837', '6578', '1', '1', '1', '500'),
-- 
('22838', '57', '24809', '57874', '0', '700000'),
('22838', '1879', '3', '9', '2', '80000'),
('22838', '1885', '1', '1', '2', '230000'),
('22838', '4039', '1', '3', '-1', '680000'),
('22838', '6577', '1', '1', '1', '30'),
('22838', '6578', '1', '1', '1', '300'),
('22838', '9549', '1', '1', '2', '23000'),
('22838', '9556', '1', '1', '1', '1000'),
('22838', '9627', '1', '1', '1', '500'),
('22838', '9628', '1', '1', '2', '22000'),
('22838', '9629', '1', '1', '2', '11000'),
('22838', '9630', '1', '1', '-1', '230000'),
('22838', '9630', '1', '1', '2', '14000'),
('22838', '13457', '1', '1', '1', '50'),
('22838', '14105', '1', '1', '1', '50'),
('22838', '14111', '1', '1', '1', '500'),
('22838', '14113', '1', '1', '1', '500'),
('22838', '14116', '1', '1', '1', '500'),
('22838', '14166', '1', '1', '200', '13000'),
('22838', '14167', '1', '1', '200', '5000'),
('22838', '14168', '1', '1', '200', '500'),
('22838', '14169', '1', '1', '200', '100'),
('22838', '15634', '1', '1', '-1', '25000'),
('22838', '15635', '1', '1', '-1', '24000'),
('22838', '15636', '1', '1', '-1', '25000'),
('22838', '15638', '1', '1', '-1', '24000'),
('22838', '15669', '1', '1', '2', '18000'),
-- 
('22839', '57', '23997', '55980', '0', '700000'),
('22839', '959', '1', '1', '1', '100'),
('22839', '1879', '3', '9', '2', '60000'),
('22839', '1885', '1', '1', '2', '180000'),
('22839', '1888', '1', '1', '2', '67000'),
('22839', '1890', '1', '1', '2', '34000'),
('22839', '4040', '1', '1', '-1', '790000'),
('22839', '5550', '1', '1', '2', '29000'),
('22839', '9549', '1', '1', '2', '17000'),
('22839', '9627', '1', '1', '1', '500'),
('22839', '9628', '1', '1', '-1', '320000'),
('22839', '9628', '1', '1', '2', '18000'),
('22839', '9629', '1', '1', '2', '10000'),
('22839', '9630', '1', '1', '2', '12000'),
('22839', '13143', '1', '1', '1', '100'),
('22839', '13144', '1', '1', '1', '100'),
('22839', '13145', '1', '1', '1', '100'),
('22839', '13467', '1', '1', '1', '9'),
('22839', '13887', '1', '1', '1', '500'),
('22839', '14111', '1', '1', '1', '500'),
('22839', '14166', '1', '1', '200', '10000'),
('22839', '14167', '1', '1', '200', '5000'),
('22839', '14168', '1', '1', '200', '500'),
('22839', '15640', '1', '1', '-1', '25000'),
('22839', '15642', '1', '1', '-1', '25000'),
('22839', '15660', '1', '1', '2', '10000'),
('22839', '15661', '1', '1', '2', '10000'),
('22839', '15662', '1', '1', '2', '10000'),
('22839', '15669', '1', '1', '-1', '290000'),
('22839', '15669', '1', '1', '2', '15000'),
('22839', '15691', '1', '1', '2', '14000'),
('22839', '15825', '1', '1', '-1', '5000'),
-- 
('22840', '57', '8612', '20089', '0', '700000'),
('22840', '1895', '1', '1', '2', '275000'),
('22840', '4040', '1', '1', '2', '18000'),
('22840', '4041', '1', '1', '-1', '120000'),
('22840', '6578', '1', '1', '-1', '1000'),
('22840', '9549', '1', '1', '2', '10000'),
('22840', '9627', '1', '1', '1', '100'),
('22840', '9628', '1', '1', '-1', '110000'),
('22840', '9628', '1', '1', '2', '10000'),
('22840', '9630', '1', '1', '2', '5000'),
('22840', '13458', '1', '1', '-1', '50'),
('22840', '14109', '1', '1', '1', '50'),
('22840', '14110', '1', '1', '1', '50'),
('22840', '14113', '1', '1', '1', '50'),
('22840', '14114', '1', '1', '1', '50'),
('22840', '14116', '1', '1', '1', '50'),
('22840', '14117', '1', '1', '1', '50'),
('22840', '14166', '1', '1', '200', '5000'),
('22840', '14167', '1', '1', '200', '5000'),
('22840', '14168', '1', '1', '200', '500'),
('22840', '14169', '1', '1', '200', '50'),
('22840', '15637', '1', '1', '-1', '10000'),
('22840', '15644', '1', '1', '-1', '10000'),
('22840', '15667', '1', '1', '2', '10000'),
('22840', '15668', '1', '1', '2', '10000'),
('22840', '15671', '1', '1', '2', '10000'),
('22840', '15672', '1', '1', '2', '10000'),
('22840', '15674', '1', '1', '2', '10000'),
('22840', '15675', '1', '1', '2', '10000'),
('22840', '15819', '1', '1', '-1', '1000'),
-- 
('22841', '57', '14790', '34502', '0', '700000'),
('22841', '959', '1', '1', '1', '100'),
('22841', '1879', '1', '1', '2', '300000'),
('22841', '1885', '1', '1', '2', '150000'),
('22841', '4042', '1', '1', '-1', '440000'),
('22841', '9549', '1', '1', '2', '15000'),
('22841', '9627', '1', '1', '1', '500'),
('22841', '9628', '1', '1', '2', '15000'),
('22841', '9629', '1', '1', '-1', '110000'),
('22841', '9629', '1', '1', '2', '10000'),
('22841', '9630', '1', '1', '2', '10000'),
('22841', '13459', '1', '1', '-1', '50'),
('22841', '14107', '1', '1', '1', '100'),
('22841', '14115', '1', '1', '1', '500'),
('22841', '14166', '1', '1', '200', '10000'),
('22841', '14167', '1', '1', '200', '5000'),
('22841', '14168', '1', '1', '200', '500'),
('22841', '14169', '1', '1', '200', '50'),
('22841', '15637', '1', '1', '-1', '15000'),
('22841', '15639', '1', '1', '-1', '15000'),
('22841', '15644', '1', '1', '-1', '15000'),
('22841', '15665', '1', '1', '2', '5000'),
('22841', '15673', '1', '1', '2', '10000'),
-- 
('22842', '57', '14790', '34502', '0', '700000'),
('22842', '959', '1', '1', '-1', '1000'),
('22842', '1895', '1', '3', '2', '300000'),
('22842', '4040', '1', '1', '2', '40000'),
('22842', '4043', '1', '1', '-1', '720000'),
('22842', '9549', '1', '1', '2', '16000'),
('22842', '9556', '1', '1', '1', '500'),
('22842', '9627', '1', '1', '1', '500'),
('22842', '9628', '1', '1', '2', '15000'),
('22842', '9629', '1', '1', '-1', '100000'),
('22842', '9630', '1', '1', '2', '10000'),
('22842', '13458', '1', '1', '-1', '50'),
('22842', '13459', '1', '1', '-1', '50'),
('22842', '14106', '1', '1', '1', '100'),
('22842', '14112', '1', '1', '1', '500'),
('22842', '14166', '1', '1', '200', '10000'),
('22842', '14167', '1', '1', '200', '5000'),
('22842', '14168', '1', '1', '200', '500'),
('22842', '14169', '1', '1', '200', '50'),
('22842', '15640', '1', '1', '-1', '12000'),
('22842', '15642', '1', '1', '-1', '12000'),
('22842', '15664', '1', '1', '2', '5000'),
('22842', '15670', '1', '1', '2', '10000'),
-- 
('22843', '57', '8451', '19715', '0', '700000'),
('22843', '959', '1', '1', '1', '50'),
('22843', '1895', '1', '1', '2', '300000'),
('22843', '4040', '1', '1', '2', '22000'),
('22843', '4044', '1', '1', '-1', '470000'),
('22843', '6577', '1', '1', '-1', '50'),
('22843', '6577', '1', '1', '1', '9'),
('22843', '6578', '1', '1', '-1', '500'),
('22843', '6578', '1', '1', '1', '50'),
('22843', '9549', '1', '1', '-1', '27000'),
('22843', '9549', '1', '1', '2', '10000'),
('22843', '9627', '1', '1', '-1', '500'),
('22843', '9627', '1', '1', '1', '100'),
('22843', '9628', '1', '1', '2', '10000'),
('22843', '9630', '1', '1', '-1', '80000'),
('22843', '9630', '1', '1', '2', '5000'),
('22843', '14105', '1', '1', '1', '50'),
('22843', '14160', '1', '1', '1', '100'),
('22843', '14161', '1', '1', '1', '100'),
('22843', '14166', '1', '1', '200', '5000'),
('22843', '14167', '1', '1', '200', '5000'),
('22843', '14168', '1', '1', '200', '500'),
('22843', '15634', '1', '1', '-1', '10000'),
('22843', '15635', '1', '1', '-1', '10000'),
('22843', '15636', '1', '1', '-1', '10000'),
('22843', '15638', '1', '1', '-1', '10000'),
('22843', '15663', '1', '1', '-1', '10000'),
('22843', '15663', '1', '1', '2', '5000'),
('22843', '15666', '1', '1', '-1', '10000'),
('22843', '15666', '1', '1', '2', '5000'),
-- 
('22844', '57', '26239', '61210', '0', '700000'),
('22844', '959', '1', '1', '1', '500'),
('22844', '1879', '3', '9', '2', '90000'),
('22844', '1885', '1', '1', '2', '240000'),
('22844', '2134', '1', '1', '-1', '91000'),
('22844', '4039', '1', '3', '-1', '710000'),
('22844', '6577', '1', '1', '-1', '500'),
('22844', '6578', '1', '1', '-1', '5000'),
('22844', '9548', '1', '1', '2', '25000'),
('22844', '9554', '1', '1', '1', '1000'),
('22844', '9625', '1', '1', '1', '1000'),
('22844', '9628', '1', '1', '2', '24000'),
('22844', '9629', '1', '1', '2', '13000'),
('22844', '9630', '1', '1', '-1', '250000'),
('22844', '9630', '1', '1', '2', '16000'),
('22844', '13457', '1', '1', '-1', '100'),
('22844', '13461', '1', '1', '1', '50'),
('22844', '13462', '1', '1', '1', '50'),
('22844', '13893', '1', '1', '1', '100'),
('22844', '14162', '1', '1', '1', '500'),
('22844', '14166', '1', '1', '200', '13000'),
('22844', '14167', '1', '1', '200', '5000'),
('22844', '14168', '1', '1', '200', '500'),
('22844', '14169', '1', '1', '200', '100'),
('22844', '15635', '1', '1', '2', '5000'),
('22844', '15637', '1', '1', '2', '5000'),
--
('22847', '57', '17676', '41234', '0', '700000'),
('22847', '1895', '1', '3', '2', '280000'),
('22847', '4040', '1', '1', '2', '40000'),
('22847', '4044', '1', '1', '-1', '720000'),
('22847', '6577', '1', '1', '-1', '50'),
('22847', '6577', '1', '1', '1', '50'),
('22847', '6578', '1', '1', '-1', '500'),
('22847', '6578', '1', '1', '1', '100'),
('22847', '9548', '1', '1', '-1', '44000'),
('22847', '9548', '1', '1', '2', '15000'),
('22847', '9554', '1', '1', '-1', '5000'),
('22847', '9554', '1', '1', '1', '500'),
('22847', '9625', '1', '1', '-1', '5000'),
('22847', '9625', '1', '1', '2', '500'),
('22847', '9628', '1', '1', '2', '16000'),
('22847', '9630', '1', '1', '-1', '120000'),
('22847', '9630', '1', '1', '2', '10000'),
('22847', '13467', '1', '1', '-1', '50'),
('22847', '13467', '1', '1', '1', '50'),
('22847', '14052', '1', '1', '-1', '550000'),
('22847', '14111', '1', '1', '1', '500'),
('22847', '14166', '1', '1', '200', '10000'),
('22847', '14167', '1', '1', '200', '5000'),
('22847', '14168', '1', '1', '200', '500'),
('22847', '14169', '1', '1', '200', '50'),
('22847', '15634', '1', '1', '-1', '5000'),
('22847', '15634', '1', '1', '2', '5000'),
('22847', '15669', '1', '1', '-1', '37000'),
('22847', '15669', '1', '1', '2', '13000'),
-- 
('22848', '57', '30896', '72072', '0', '700000'),
('22848', '1895', '3', '9', '2', '180000'),
('22848', '2134', '1', '1', '-1', '125000'),
('22848', '4040', '1', '1', '2', '75000'),
('22848', '6577', '1', '1', '1', '50'),
('22848', '6578', '1', '1', '1', '500'),
('22848', '9548', '1', '1', '2', '30000'),
('22848', '9554', '1', '1', '1', '1000'),
('22848', '9625', '1', '1', '1', '1000'),
('22848', '9628', '1', '1', '2', '30000'),
('22848', '9629', '1', '1', '-1', '270000'),
('22848', '9630', '1', '1', '2', '20000'),
('22848', '13459', '1', '1', '-1', '100'),
('22848', '13459', '1', '1', '1', '50'),
('22848', '13893', '1', '1', '-1', '500'),
('22848', '13893', '1', '1', '1', '500'),
('22848', '14166', '1', '1', '200', '18000'),
('22848', '14167', '1', '1', '200', '5000'),
('22848', '14168', '1', '1', '200', '500'),
('22848', '15642', '1', '1', '-1', '38000'),
('22848', '15642', '1', '1', '2', '5000'),
('22848', '15644', '1', '1', '2', '5000'),
-- 
('22849', '57', '17732', '41364', '0', '700000'),
('22849', '959', '1', '1', '-1', '1000'),
('22849', '959', '1', '1', '1', '100'),
('22849', '1895', '1', '3', '2', '330000'),
('22849', '4040', '1', '1', '2', '48000'),
('22849', '4042', '1', '1', '-1', '430000'),
('22849', '9548', '1', '1', '2', '19000'),
('22849', '9626', '1', '1', '1', '500'),
('22849', '9628', '1', '1', '2', '19000'),
('22849', '9629', '1', '1', '-1', '120000'),
('22849', '9630', '1', '1', '2', '13000'),
('22849', '13457', '1', '1', '-1', '50'),
('22849', '13457', '1', '1', '1', '50'),
('22849', '13461', '1', '1', '1', '50'),
('22849', '13465', '1', '1', '1', '50'),
('22849', '14052', '1', '1', '-1', '620000'),
('22849', '14166', '1', '1', '200', '12000'),
('22849', '14167', '1', '1', '200', '5000'),
('22849', '14168', '1', '1', '200', '500'),
('22849', '14169', '1', '1', '200', '100'),
('22849', '15642', '1', '1', '2', '5000'),
('22849', '15644', '1', '1', '2', '5000'),
('22849', '15669', '1', '1', '-1', '180000'),
('22849', '15817', '1', '1', '-1', '5000'),
-- 
('22850', '57', '8361', '19504', '0', '700000'),
('22850', '1879', '1', '1', '2', '160000'),
('22850', '1885', '1', '1', '2', '80000'),
('22850', '2134', '1', '1', '-1', '25000'),
('22850', '2134', '1', '1', '1', '5000'),
('22850', '4041', '1', '1', '-1', '110000'),
('22850', '6577', '1', '1', '-1', '100'),
('22850', '6578', '1', '1', '-1', '700'),
('22850', '9548', '1', '1', '2', '10000'),
('22850', '9554', '1', '1', '-1', '5000'),
('22850', '9554', '1', '1', '1', '500'),
('22850', '9626', '1', '1', '1', '500'),
('22850', '9628', '1', '1', '-1', '100000'),
('22850', '9628', '1', '1', '2', '10000'),
('22850', '9629', '1', '1', '2', '5000'),
('22850', '9630', '1', '1', '2', '5000'),
('22850', '13458', '1', '1', '1', '9'),
('22850', '13459', '1', '1', '-1', '50'),
('22850', '13467', '1', '1', '1', '9'),
('22850', '14052', '1', '1', '1', '24000'),
('22850', '14166', '1', '1', '200', '5000'),
('22850', '14167', '1', '1', '200', '5000'),
('22850', '14168', '1', '1', '200', '500'),
('22850', '14169', '1', '1', '200', '50'),
('22850', '15638', '1', '1', '2', '1000'),
-- 
('22851', '57', '18219', '42501', '0', '700000'),
('22851', '959', '1', '1', '-1', '5000'),
('22851', '1895', '1', '3', '2', '385000'),
('22851', '4040', '1', '1', '2', '52000'),
('22851', '4042', '1', '1', '-1', '600000'),
('22851', '9548', '1', '1', '2', '20000'),
('22851', '9626', '1', '1', '1', '500'),
('22851', '9628', '1', '1', '2', '20000'),
('22851', '9629', '1', '1', '-1', '160000'),
('22851', '9630', '1', '1', '2', '13000'),
('22851', '13457', '1', '1', '1', '50'),
('22851', '13458', '1', '1', '-1', '50'),
('22851', '13461', '1', '1', '1', '50'),
('22851', '13465', '1', '1', '1', '50'),
('22851', '14166', '1', '1', '200', '12000'),
('22851', '14167', '1', '1', '200', '5000'),
('22851', '14168', '1', '1', '200', '500'),
('22851', '14169', '1', '1', '200', '100'),
('22851', '15642', '1', '1', '2', '5000'),
('22851', '15644', '1', '1', '2', '5000'),
('22851', '15815', '1', '1', '-1', '5000'),
-- 
('22852', '57', '45317', '105714', '0', '700000'),
('22852', '1879', '3', '9', '2', '160000'),
('22852', '1885', '2', '6', '2', '122000'),
('22852', '2134', '1', '1', '-1', '245000'),
('22852', '9548', '1', '1', '2', '50000'),
('22852', '9554', '1', '1', '1', '5000'),
('22852', '9626', '1', '1', '1', '1000'),
('22852', '9628', '1', '1', '-1', '950000'),
('22852', '9628', '1', '1', '2', '47000'),
('22852', '9629', '1', '1', '2', '27000'),
('22852', '9630', '1', '1', '2', '32000'),
('22852', '13459', '1', '1', '-1', '500'),
('22852', '13461', '1', '1', '1', '50'),
('22852', '13462', '1', '1', '1', '50'),
('22852', '13893', '1', '1', '1', '500'),
('22852', '14108', '1', '1', '1', '500'),
('22852', '14166', '1', '1', '200', '29000'),
('22852', '14167', '1', '1', '200', '10000'),
('22852', '14168', '1', '1', '200', '1000'),
('22852', '15642', '1', '1', '2', '5000'),
('22852', '15644', '1', '1', '2', '5000'),
('22852', '15669', '1', '1', '-1', '770000'),
-- 
('22853', '57', '24497', '57145', '0', '700000'),
('22853', '959', '1', '1', '1', '500'),
('22853', '1895', '3', '9', '2', '160000'),
('22853', '4040', '1', '1', '2', '65000'),
('22853', '4044', '1', '3', '-1', '800000'),
('22853', '6578', '1', '1', '-1', '5000'),
('22853', '9548', '1', '1', '2', '26000'),
('22853', '9626', '1', '1', '1', '500'),
('22853', '9628', '1', '1', '2', '26000'),
('22853', '9630', '1', '1', '-1', '270000'),
('22853', '9630', '1', '1', '2', '18000'),
('22853', '13460', '1', '1', '-1', '100'),
('22853', '13460', '1', '1', '1', '50'),
('22853', '13463', '1', '1', '1', '50'),
('22853', '14111', '1', '1', '1', '500'),
('22853', '14166', '1', '1', '200', '16000'),
('22853', '14167', '1', '1', '200', '5000'),
('22853', '14168', '1', '1', '200', '500'),
('22853', '14169', '1', '1', '200', '100'),
('22853', '15636', '1', '1', '2', '5000'),
('22853', '15637', '1', '1', '2', '5000'),
('22853', '15816', '1', '1', '-1', '5000'),
-- 
('22854', '57', '115052', '152755', '0', '700000'),
('22854', '1895', '72', '216', '2', '49000'),
('22854', '4040', '2', '6', '2', '99000'),
('22854', '9549', '3', '9', '2', '28000'),
('22854', '9628', '4', '12', '2', '24000'),
('22854', '9630', '1', '3', '-1', '600000'),
('22854', '9630', '1', '1', '2', '125000'),
('22854', '14166', '1', '3', '-1', '560000'),
('22854', '14166', '1', '1', '200', '110000'),
('22854', '14167', '1', '1', '-1', '290000'),
('22854', '14167', '1', '1', '200', '30000'),
('22854', '14168', '1', '1', '-1', '29000'),
('22854', '14168', '1', '1', '200', '5000'),
('22854', '14169', '1', '1', '-1', '10000'),
('22854', '15743', '1', '1', '1', '500'),
('22854', '15745', '1', '1', '1', '500'),
('22854', '15750', '1', '1', '1', '500'),
('22854', '15751', '1', '1', '1', '500'),
('22854', '15755', '1', '1', '1', '500'),
('22854', '15764', '1', '1', '1', '1000'),
-- 
('22855', '57', '65375', '152689', '0', '700000'),
('22855', '959', '1', '1', '1', '500'),
('22855', '1895', '12', '36', '2', '140000'),
('22855', '4040', '2', '6', '2', '45000'),
('22855', '9549', '1', '1', '2', '90000'),
('22855', '9628', '1', '3', '-1', '500000'),
('22855', '9628', '1', '1', '2', '87000'),
('22855', '9630', '1', '1', '2', '58000'),
('22855', '14166', '1', '1', '-1', '630000'),
('22855', '14166', '1', '1', '200', '54000'),
('22855', '14167', '1', '1', '-1', '165000'),
('22855', '14167', '1', '1', '200', '13000'),
('22855', '14168', '1', '1', '-1', '17000'),
('22855', '14168', '1', '1', '200', '5000'),
('22855', '14169', '1', '1', '-1', '3000'),
('22855', '14169', '1', '1', '200', '500'),
('22855', '15746', '1', '1', '1', '100'),
('22855', '15748', '1', '1', '1', '100'),
('22855', '15753', '1', '1', '1', '300'),
('22855', '15754', '1', '1', '1', '300'),
('22855', '15763', '1', '1', '1', '800'),
('22855', '15765', '1', '1', '1', '400'),
-- 
('22856', '57', '65375', '152689', '0', '700000'),
('22856', '959', '1', '1', '1', '500'),
('22856', '1879', '15', '45', '2', '56000'),
('22856', '1885', '12', '36', '2', '35000'),
('22856', '2134', '1', '1', '-1', '120000'),
('22856', '9549', '1', '1', '2', '81000'),
('22856', '9628', '1', '1', '2', '80000'),
('22856', '9629', '1', '1', '-1', '280000'),
('22856', '9629', '1', '1', '2', '43000'),
('22856', '9630', '1', '1', '2', '54000'),
('22856', '13459', '1', '1', '-1', '100'),
('22856', '13893', '1', '1', '-1', '500'),
('22856', '13893', '1', '1', '1', '100'),
('22856', '14166', '1', '1', '-1', '630000'),
('22856', '14166', '1', '1', '200', '48000'),
('22856', '14167', '1', '1', '-1', '170000'),
('22856', '14167', '1', '1', '200', '12000'),
('22856', '14168', '1', '1', '-1', '15000'),
('22856', '14168', '1', '1', '200', '5000'),
('22856', '14169', '1', '1', '-1', '3000'),
('22856', '14169', '1', '1', '200', '500'),
('22856', '15642', '1', '1', '-1', '37000'),
('22856', '15744', '1', '1', '1', '500'),
('22856', '15747', '1', '1', '1', '100'),
('22856', '15749', '1', '1', '1', '100'),
('22856', '15752', '1', '1', '1', '500'),
('22856', '15756', '1', '1', '1', '500'),
('22856', '15758', '1', '1', '1', '500'),
('22856', '15759', '1', '1', '1', '500'),
-- 
('22857', '57', '195846', '456860', '0', '700000'),
('22857', '959', '1', '1', '1', '3000'),
('22857', '1895', '108', '324', '2', '36000'),
('22857', '2134', '1', '1', '-1', '970000'),
('22857', '2134', '1', '1', '2', '56000'),
('22857', '4040', '3', '9', '2', '79000'),
('22857', '4042', '4', '12', '2', '57000'),
('22857', '4043', '27', '81', '2', '16000'),
('22857', '6577', '1', '1', '-1', '3000'),
('22857', '6578', '1', '1', '-1', '22000'),
('22857', '9549', '5', '15', '2', '22000'),
('22857', '13893', '1', '1', '1', '500'),
('22857', '14052', '1', '25', '-1', '980000'),
('22857', '14052', '3', '9', '1', '115000'),
('22857', '14166', '1', '1', '200', '11000'),
('22857', '14167', '1', '1', '200', '34000'),
('22857', '14168', '1', '1', '200', '5000'),
('22857', '14169', '1', '1', '200', '1000'),
('22857', '15558', '1', '1', '1', '50'),
('22857', '15559', '1', '1', '1', '50'),
('22857', '15560', '1', '1', '1', '50'),
('22857', '15561', '1', '1', '1', '50'),
('22857', '15562', '1', '1', '1', '50'),
('22857', '15563', '1', '1', '1', '50'),
('22857', '15564', '1', '1', '1', '50'),
('22857', '15565', '1', '1', '1', '50'),
('22857', '15566', '1', '1', '1', '50'),
('22857', '15567', '1', '1', '1', '50'),
('22857', '15568', '1', '1', '1', '50'),
('22857', '15569', '1', '1', '1', '50'),
('22857', '15570', '1', '1', '1', '50'),
('22857', '15571', '1', '1', '1', '50'),
-- 
('22858', '57', '1712', '4000', '0', '700000'),
('22858', '1895', '1', '1', '2', '200000'),
('22858', '4039', '1', '1', '-1', '150000'),
('22858', '4040', '1', '1', '2', '10000'),
('22858', '9549', '1', '1', '2', '10000'),
('22858', '9573', '1', '1', '200', '5000'),
('22858', '9574', '1', '1', '200', '1000'),
('22858', '9575', '1', '1', '200', '600'),
('22858', '9628', '1', '1', '-1', '50000'),
('22858', '9628', '1', '1', '2', '5000'),
('22858', '9630', '1', '1', '2', '5000'),
('22858', '10404', '1', '1', '-1', '1000'),
('22858', '15696', '1', '1', '1', '50'),
('22858', '15697', '1', '1', '1', '9'),
('22858', '15767', '1', '1', '1', '50'),
('22858', '15780', '1', '1', '-1', '500'),
-- 
('22860', '57', '13523', '31578', '0', '700000'),
('22860', '959', '1', '1', '1', '10'),
('22860', '1879', '1', '3', '2', '300000'),
('22860', '1888', '1', '1', '2', '100000'),
('22860', '1890', '1', '1', '2', '50000'),
('22860', '4044', '1', '2', '-1', '800000'),
('22860', '5550', '1', '1', '2', '30000'),
('22860', '9549', '1', '1', '2', '15000'),
('22860', '9628', '1', '1', '2', '13000'),
('22860', '9629', '1', '2', '-1', '100000'),
('22860', '9629', '1', '1', '2', '1000'),
('22860', '9630', '1', '1', '2', '1000'),
('22860', '10401', '1', '1', '-1', '1000'),
('22860', '10483', '1', '1', '200', '3000'),
('22860', '10484', '1', '1', '200', '1000'),
('22860', '10485', '1', '1', '200', '50'),
('22860', '15703', '1', '1', '1', '50'),
('22860', '15704', '1', '1', '1', '50'),
('22860', '15705', '1', '1', '1', '50'),
('22860', '15706', '1', '1', '1', '50'),
('22860', '15707', '1', '1', '1', '50'),
('22860', '15708', '1', '1', '1', '50'),
('22860', '15768', '1', '1', '1', '50'),
('22860', '15778', '1', '1', '-1', '1000'),
('22860', '15794', '1', '1', '-1', '1000'),
('22860', '15797', '1', '1', '-1', '1000'),
('22860', '15800', '1', '1', '-1', '1000'),
('22860', '17248', '1', '1', '1', '10'),
-- 
('22861', '57', '22245', '51946', '0', '700000'),
('22861', '959', '1', '1', '-1', '5000'),
('22861', '1895', '3', '9', '2', '180000'),
('22861', '4040', '1', '1', '-1', '630000'),
('22861', '4040', '1', '1', '2', '80000'),
('22861', '9546', '1', '1', '2', '30000'),
('22861', '9552', '1', '1', '1', '10000'),
('22861', '9628', '1', '1', '2', '30000'),
('22861', '9630', '1', '1', '-1', '170000'),
('22861', '10215', '1', '1', '1', '9'),
('22861', '10402', '1', '1', '-1', '15000'),
('22861', '10483', '1', '1', '200', '27000'),
('22861', '10484', '1', '1', '200', '10000'),
('22861', '10485', '1', '1', '200', '1000'),
('22861', '15699', '1', '1', '1', '50'),
('22861', '15701', '1', '1', '1', '100'),
('22861', '15702', '1', '1', '1', '100'),
('22861', '15709', '1', '1', '1', '500'),
('22861', '15710', '1', '1', '1', '500'),
('22861', '15766', '1', '1', '1', '500'),
('22861', '15793', '1', '1', '-1', '18000'),
('22861', '15796', '1', '1', '-1', '10000'),
('22861', '15799', '1', '1', '-1', '15000'),
('22861', '17248', '1', '1', '1', '5000'),
-- 
('22862', '57', '18307', '42751', '-1', '1000000'),
('22862', '57', '18307', '42751', '0', '700000'),
('22862', '1879', '3', '9', '2', '80000'),
('22862', '1885', '1', '1', '2', '250000'),
('22862', '4043', '1', '1', '-1', '900000'),
('22862', '9549', '1', '1', '2', '22000'),
('22862', '9555', '1', '1', '1', '100'),
('22862', '9628', '1', '1', '2', '23000'),
('22862', '9629', '1', '1', '2', '13000'),
('22862', '9630', '1', '1', '-1', '140000'),
('22862', '9630', '1', '1', '2', '16000'),
('22862', '10403', '1', '1', '-1', '12000'),
('22862', '10483', '1', '1', '200', '20000'),
('22862', '10484', '1', '1', '200', '500'),
('22862', '10485', '1', '1', '200', '50'),
('22862', '13893', '1', '1', '1', '5'),
('22862', '15706', '1', '1', '1', '50'),
('22862', '15707', '1', '1', '1', '50'),
('22862', '15708', '1', '1', '1', '50'),
('22862', '15768', '1', '1', '1', '50'),
('22862', '15778', '1', '1', '-1', '10000'),
('22862', '15792', '1', '1', '-1', '16000'),
('22862', '15795', '1', '1', '-1', '10000'),
('22862', '15798', '1', '1', '-1', '10000'),
('22862', '17248', '1', '1', '1', '500');

REPLACE INTO `npcskills` VALUES 
-- 
('22815', '141', '3'),
('22815', '142', '5'),
('22815', '4312', '4'),
('22815', '4408', '1'),
('22815', '4409', '1'),
('22815', '4410', '14'),
('22815', '4411', '11'),
('22815', '4412', '8'),
('22815', '4413', '11'),
('22815', '4417', '36'),
('22815', '6845', '1'),
-- 
('22818', '4276', '1'),
('22818', '4312', '9'),
('22818', '4408', '1'),
('22818', '4409', '1'),
('22818', '4410', '11'),
('22818', '4412', '11'),
('22818', '4413', '10'),
('22818', '6850', '1'),
-- 
('22819', '4276', '1'),
('22819', '4312', '1'),
('22819', '4408', '1'),
('22819', '4409', '1'),
('22819', '4410', '11'),
('22819', '4412', '11'),
('22819', '4413', '10'),
('22819', '4417', '36'),
('22819', '6851', '1'),
('22819', '6852', '1'),
-- 
('22820', '141', '3'),
('22820', '142', '5'),
('22820', '4312', '1'),
('22820', '4410', '11'),
('22820', '4412', '11'),
('22820', '6853', '1'),
('22820', '6854', '1'),
-- 
('22822', '141', '3'),
('22822', '142', '5'),
('22822', '4410', '11'),
('22822', '4412', '11'),
('22822', '4413', '7'),
('22822', '6858', '1'),
('22822', '6884', '1'),
('22822', '6885', '1'),
('22822', '6885', '2'),
('22822', '6885', '3'),
-- 
('22823', '141', '3'),
('22823', '142', '6'),
('22823', '4312', '5'),
('22823', '4410', '11'),
('22823', '4412', '11'),
('22823', '4413', '10'),
('22823', '4417', '36'),
('22823', '6884', '1'),
('22823', '6885', '1'),
('22823', '6885', '2'),
('22823', '6885', '3'),
-- 
('22824', '141', '5'),
('22824', '142', '5'),
('22824', '4285', '5'),
('22824', '4287', '5'),
('22824', '4312', '1'),
('22824', '4410', '14'),
('22824', '4411', '5'),
('22824', '4412', '14'),
('22824', '4413', '11'),
('22824', '4441', '5'),
('22824', '6884', '1'),
('22824', '6885', '1'),
('22824', '6885', '2'),
('22824', '6885', '3'),
('22824', '6861', '1'),
-- 
('22825', '141', '12'),
('22825', '142', '6'),
('22825', '4274', '5'),
('22825', '4285', '6'),
('22825', '4287', '6'),
('22825', '4312', '1'),
('22825', '4312', '5'),
('22825', '4410', '14'),
('22825', '4411', '7'),
('22825', '4412', '14'),
('22825', '4413', '9'),
('22825', '4441', '6'),
('22825', '6884', '1'),
('22825', '6885', '1'),
('22825', '6885', '2'),
('22825', '6885', '3'),
('22825', '6863', '1'),
('22825', '6864', '1'),
-- 
('22826', '141', '3'),
('22826', '142', '5'),
('22826', '4274', '5'),
('22826', '4312', '1'),
('22826', '4312', '5'),
('22826', '4410', '11'),
('22826', '4411', '10'),
('22826', '4412', '11'),
('22826', '4413', '10'),
('22826', '6884', '1'),
('22826', '6885', '1'),
('22826', '6885', '2'),
('22826', '6885', '3'),
('22826', '6865', '1'),
-- 
('22827', '141', '5'),
('22827', '142', '5'),
('22827', '4285', '5'),
('22827', '4287', '5'),
('22827', '4312', '5'),
('22827', '4410', '14'),
('22827', '4411', '5'),
('22827', '4412', '14'),
('22827', '4413', '5'),
('22827', '4441', '5'),
('22827', '6884', '1'),
('22827', '6885', '1'),
('22827', '6885', '2'),
('22827', '6885', '3'),
('22827', '6868', '1'),
('22827', '6869', '1'),
-- 
('22828', '141', '5'),
('22828', '142', '7'),
('22828', '4274', '5'),
('22828', '4312', '5'),
('22828', '4410', '14'),
('22828', '4411', '10'),
('22828', '4412', '14'),
('22828', '4413', '7'),
('22828', '6884', '1'),
('22828', '6885', '1'),
('22828', '6885', '2'),
('22828', '6885', '3'),
('22828', '6871', '1'),
('22828', '6872', '1'),
-- 
('22829', '141', '13'),
('22829', '142', '13'),
('22829', '4285', '15'),
('22829', '4287', '10'),
('22829', '4299', '1'),
('22829', '4408', '2'),
('22829', '4409', '2'),
('22829', '4410', '13'),
('22829', '4411', '3'),
('22829', '4412', '13'),
('22829', '4413', '9'),
('22829', '4441', '10'),
('22829', '6884', '1'),
('22829', '6885', '1'),
('22829', '6885', '2'),
('22829', '6885', '3'),
('22829', '6873', '1'),
('22829', '6873', '2'),
('22829', '6874', '1'),
('22829', '6875', '1'),
('22829', '6875', '2'),
-- 
('22830', '141', '3'),
('22830', '142', '5'),
('22830', '4285', '10'),
('22830', '4287', '5'),
('22830', '4312', '5'),
('22830', '4410', '11'),
('22830', '4411', '10'),
('22830', '4412', '15'),
('22830', '4413', '10'),
('22830', '4441', '10'),
('22830', '6884', '1'),
('22830', '6885', '1'),
('22830', '6885', '2'),
('22830', '6885', '3'),
-- 
('22831', '141', '3'),
('22831', '142', '5'),
('22831', '4285', '10'),
('22831', '4287', '10'),
('22831', '4312', '1'),
('22831', '4410', '11'),
('22831', '4411', '5'),
('22831', '4412', '11'),
('22831', '4441', '10'),
('22831', '6884', '1'),
('22831', '6885', '1'),
('22831', '6885', '2'),
('22831', '6885', '3'),
-- 
('22832', '141', '5'),
('22832', '142', '5'),
('22832', '4285', '10'),
('22832', '4287', '10'),
('22832', '4312', '1'),
('22832', '4410', '11'),
('22832', '4411', '5'),
('22832', '4412', '11'),
('22832', '4441', '10'),
('22832', '6884', '1'),
('22832', '6885', '1'),
('22832', '6885', '2'),
('22832', '6885', '3'),
-- 
('22833', '141', '5'),
('22833', '142', '5'),
('22833', '4285', '10'),
('22833', '4287', '10'),
('22833', '4312', '1'),
('22833', '4410', '11'),
('22833', '4412', '11'),
('22833', '4441', '10'),
('22833', '6884', '1'),
('22833', '6885', '1'),
('22833', '6885', '2'),
('22833', '6885', '3'),
-- 
('22834', '141', '6'),
('22834', '142', '5'),
('22834', '4312', '10'),
('22834', '4408', '3'),
('22834', '4409', '3'),
('22834', '4410', '11'),
('22834', '4411', '5'),
('22834', '4412', '11'),
('22834', '6884', '1'),
('22834', '6885', '1'),
('22834', '6885', '2'),
('22834', '6885', '3'),
('22834', '6881', '1'),
('22834', '6882', '1'),
-- 
('22835', '1450', '10'),
('22835', '4312', '5'),
('22835', '4412', '11'),
('22835', '4413', '5'),
-- 
('22836', '1450', '10'),
-- 
('22837', '1450', '5'),
-- 
('22838', '6748', '1'),
('22838', '6750', '1'),
-- 
('22839', '6752', '1'),
('22839', '6755', '1'),
-- 
('22840', '6753', '1'),
('22840', '6754', '1'),
-- 
('22841', '6749', '1'),
('22841', '6756', '1'),
-- 
('22842', '6757', '1'),
('22842', '6758', '1'),
('22842', '4032', '1'),
-- 
('22843', '6759', '1'),
-- 
('22844', '6761', '1'),
('22844', '6763', '1'),
-- 
('22845', '6761', '1'),
('22845', '6763', '1'),
-- 
('22846', '6761', '1'),
('22846', '6763', '1'),
-- 
('22847', '6760', '1'),
('22847', '6762', '1'),
-- 
('22848', '6758', '1'),
('22848', '6763', '1'),
('22848', '6818', '1'),
('22848', '6820', '1'),
('22848', '4032', '1'),
-- 
('22849', '6760', '1'),
-- 
('22850', '6761', '1'),
('22850', '6764', '1'),
('22851', '6765', '1'),
('22851', '6766', '1'),
-- 
('22852', '6768', '1'),
-- 
('22853', '6769', '1'),
('22853', '6770', '1'),
-- 
('22854', '6771', '1'),
('22854', '6772', '1'),
('22854', '6773', '1'),
-- 
('22855', '6775', '1'),
('22855', '6774', '1'),
-- 
('22856', '6776', '1'),
('22856', '6777', '1'),
('22856', '6778', '1'),
-- 
('22857', '6743', '1'),
-- 
('22858', '4032', '3'),
('22858', '4152', '9'),
('22858', '4160', '9'),
('22858', '4411', '11'),
('22858', '4415', '5'),
('22858', '4417', '36'),
('22858', '4789', '9'),
('22858', '6855', '1'),
('22858', '6855', '2'),
('22858', '6855', '3'),
-- 
('22860', '141', '5'),
('22860', '142', '5'),
('22860', '4274', '1'),
('22860', '4301', '1'),
('22860', '4408', '2'),
('22860', '4409', '2'),
('22860', '4410', '13'),
('22860', '4412', '13'),
('22860', '4413', '2'),
('22860', '6884', '1'),
('22860', '6885', '1'),
('22860', '6885', '2'),
('22860', '6885', '3'),
('22860', '6871', '1'),
('22860', '6870', '1'),
('22860', '6870', '2'),
-- 
('22861', '141', '5'),
('22861', '142', '5'),
('22861', '4274', '5'),
('22861', '4285', '9'),
('22861', '4287', '7'),
('22861', '4312', '1'),
('22861', '4410', '14'),
('22861', '4411', '5'),
('22861', '4412', '14'),
('22861', '4413', '11'),
('22861', '4441', '9'),
('22861', '6884', '1'),
('22861', '6885', '1'),
('22861', '6885', '2'),
('22861', '6885', '3'),
('22861', '6862', '1'),
('22861', '6863', '1'),
('22861', '6864', '1'),
-- 
('22862', '141', '5'),
('22862', '142', '6'),
('22862', '4312', '1'),
('22862', '4410', '12'),
('22862', '4412', '13'),
('22862', '4413', '10'),
('22862', '6884', '1'),
('22862', '6885', '1'),
('22862', '6885', '2'),
('22862', '6885', '3'),
('22862', '6857', '1'),
('22862', '6857', '2'),
('22862', '6858', '1');
-- 
REPLACE INTO `spawnlist` VALUES 
('giran03_2221_H5', '1', '32874', '-83097', '155527', '-3174', '0', '0', '50306', '10', '0', '0'),
('giran03_2221_H5', '1', '32875', '-15410', '124702', '-3115', '0', '0', '58498', '10', '0', '0'),
('giran03_2221_H5', '1', '32876', '19654', '143056', '-3025', '0', '0', '15712', '10', '0', '0'),
('giran03_2221_H5', '1', '32877', '77494', '148038', '-3596', '0', '0', '16383', '10', '0', '0'),
('giran03_2221_H5', '1', '32878', '108148', '218925', '-3656', '0', '0', '49441', '10', '0', '0'),
('giran03_2221_H5', '1', '32879', '83740', '55537', '-1512', '0', '0', '31654', '10', '0', '0'),
('giran03_2221_H5', '1', '32880', '150796', '28464', '-2248', '0', '0', '42593', '10', '0', '0'),
('giran03_2221_H5', '1', '32881', '146555', '-58945', '-2974', '0', '0', '10424', '10', '0', '0'),
('giran03_2221_H5', '1', '32882', '88248', '-139599', '-1534', '0', '0', '42781', '10', '0', '0'),
('giran03_2221_H5', '1', '32883', '45413', '-48480', '-798', '0', '0', '25977', '10', '0', '0'),
('giran03_2221_H5', '1', '32887', '117543', '75232', '-2650', '0', '0', '20274', '10', '0', '0'),
('giran03_2221_H5', '1', '22815', '76372', '117122', '-3726', '0', '0', '30857', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '77781', '117230', '-3741', '0', '0', '60889', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '79285', '116529', '-3718', '0', '0', '434', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '79454', '115023', '-3729', '0', '0', '52910', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '80467', '115758', '-3637', '0', '0', '11260', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '82016', '117020', '-3174', '0', '0', '7104', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '82900', '118205', '-3037', '0', '0', '42120', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '83589', '117326', '-3005', '0', '0', '54824', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '84237', '116885', '-3029', '0', '0', '56667', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '83779', '117938', '-2991', '0', '0', '22747', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '82719', '117181', '-3066', '0', '0', '57856', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '80313', '115185', '-3715', '0', '0', '62394', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '80083', '114279', '-3727', '0', '0', '45498', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '79941', '116008', '-3675', '0', '0', '15499', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '81022', '112811', '-3650', '0', '0', '55936', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '80402', '113371', '-3711', '0', '0', '58140', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '81534', '114329', '-3389', '0', '0', '64220', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '81827', '114332', '-3259', '0', '0', '60107', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '80640', '114606', '-3727', '0', '0', '26634', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '82232', '113470', '-3072', '0', '0', '50681', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '82621', '112978', '-3061', '0', '0', '57884', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '83249', '113348', '-3062', '0', '0', '4978', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '83638', '112793', '-3054', '0', '0', '51299', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '84458', '112491', '-3061', '0', '0', '56607', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '84588', '112222', '-3057', '0', '0', '53847', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '84932', '111178', '-3165', '0', '0', '47604', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '85309', '112086', '-3071', '0', '0', '8790', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '84606', '109237', '-3195', '0', '0', '45860', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '85683', '109010', '-3202', '0', '0', '24413', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '84950', '108594', '-3206', '0', '0', '37322', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '84130', '108928', '-3134', '0', '0', '28596', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '83295', '108514', '-3059', '0', '0', '36963', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '82861', '109217', '-3170', '0', '0', '19096', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '82369', '108887', '-3135', '0', '0', '47886', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '82277', '109463', '-3166', '0', '0', '18846', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '81637', '109105', '-3079', '0', '0', '35074', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '82530', '109038', '-3156', '0', '0', '7453', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '81577', '109850', '-3092', '0', '0', '23169', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '80869', '109534', '-3062', '0', '0', '59098', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '80146', '110349', '-3031', '0', '0', '31091', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '79427', '111102', '-2971', '0', '0', '17212', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '79023', '111937', '-3049', '0', '0', '20444', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '79178', '113169', '-3246', '0', '0', '8245', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '79488', '114186', '-3575', '0', '0', '52082', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '81329', '111974', '-3629', '0', '0', '56439', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '81876', '111809', '-3580', '0', '0', '59383', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '82152', '111202', '-3673', '0', '0', '51159', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '82676', '111737', '-3563', '0', '0', '7820', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '83093', '110983', '-3699', '0', '0', '50343', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '83257', '110323', '-3825', '0', '0', '51177', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '83825', '110724', '-3714', '0', '0', '7902', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '84805', '110694', '-3731', '0', '0', '64309', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '85252', '110309', '-3782', '0', '0', '58110', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '85808', '110775', '-3703', '0', '0', '4893', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '86028', '110251', '-3759', '0', '0', '52744', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '85386', '110655', '-3736', '0', '0', '23095', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '86806', '110846', '-3760', '0', '0', '9149', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '87011', '110322', '-3745', '0', '0', '53129', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '87875', '110503', '-3762', '0', '0', '5551', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '87875', '111087', '-3774', '0', '0', '16684', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '88414', '111091', '-3766', '0', '0', '63211', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '88882', '110778', '-3717', '0', '0', '51584', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '89293', '111278', '-3647', '0', '0', '6858', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '86539', '110155', '-3734', '0', '0', '2416', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '87757', '112158', '-3298', '0', '0', '29320', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '89022', '112087', '-3218', '0', '0', '53056', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '89383', '112773', '-3104', '0', '0', '8923', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '91455', '112993', '-3043', '0', '0', '29112', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '92190', '114623', '-3077', '0', '0', '34423', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '93389', '112477', '-3041', '0', '0', '59298', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '94117', '113204', '-3073', '0', '0', '7470', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '93242', '115078', '-3219', '0', '0', '18400', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '92071', '115889', '-3148', '0', '0', '28437', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '94755', '115537', '-3094', '0', '0', '3355', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '92961', '118685', '-3012', '0', '0', '22666', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '92459', '119213', '-2957', '0', '0', '29272', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '91074', '119268', '-3050', '0', '0', '20959', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '89468', '119743', '-3051', '0', '0', '19837', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '88748', '119764', '-3061', '0', '0', '34781', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '88905', '120482', '-3050', '0', '0', '21352', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '85308', '120825', '-3057', '0', '0', '24203', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '84957', '121027', '-3032', '0', '0', '27321', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '84694', '120296', '-2966', '0', '0', '46010', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '84041', '120670', '-3018', '0', '0', '26740', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '83986', '119942', '-2961', '0', '0', '46911', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '84653', '119470', '-2967', '0', '0', '58701', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '85210', '118702', '-3036', '0', '0', '42052', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '84895', '117855', '-3025', '0', '0', '47512', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '84903', '116878', '-3042', '0', '0', '49047', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '84750', '116182', '-3065', '0', '0', '46800', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '85695', '115757', '-3046', '0', '0', '63707', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '85954', '115357', '-3038', '0', '0', '49009', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '86524', '115159', '-3041', '0', '0', '20531', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '86986', '114504', '-3033', '0', '0', '50678', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '87469', '114694', '-2989', '0', '0', '7494', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '88001', '114614', '-2985', '0', '0', '2342', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '88985', '114832', '-3052', '0', '0', '2188', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '90509', '117263', '-3155', '0', '0', '10739', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '91369', '118879', '-3053', '0', '0', '8697', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '94908', '112597', '-3039', '0', '0', '29065', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '96346', '111849', '-3382', '0', '0', '58387', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '96648', '110681', '-3730', '0', '0', '47757', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '95764', '110027', '-3663', '0', '0', '31157', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '94760', '109617', '-3699', '0', '0', '55491', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '93908', '109931', '-3680', '0', '0', '28622', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '93704', '109369', '-3658', '0', '0', '39555', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '93547', '109514', '-3674', '0', '0', '59066', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '92775', '109330', '-3746', '0', '0', '35146', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '92265', '110025', '-3769', '0', '0', '27107', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '91725', '109721', '-3774', '0', '0', '37708', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '90650', '111231', '-3709', '0', '0', '23330', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '89809', '111136', '-3665', '0', '0', '30377', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '86829', '107760', '-3153', '0', '0', '7864', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '87933', '107302', '-3129', '0', '0', '53870', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '88169', '106192', '-3181', '0', '0', '51168', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '89283', '107306', '-3103', '0', '0', '14071', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '89077', '107838', '-3057', '0', '0', '61962', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '90316', '107296', '-3144', '0', '0', '57891', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '90074', '108436', '-3052', '0', '0', '18465', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '90709', '107045', '-3117', '0', '0', '51873', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '90826', '107777', '-3071', '0', '0', '30149', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '89120', '108511', '-3040', '0', '0', '30882', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '91650', '107543', '-3065', '0', '0', '10843', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '91807', '108800', '-3013', '0', '0', '12855', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '92121', '110476', '-3008', '0', '0', '14383', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '92234', '111554', '-3022', '0', '0', '13862', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '93004', '111999', '-2982', '0', '0', '11108', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '94627', '112603', '-3016', '0', '0', '61588', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '92527', '115553', '-3195', '0', '0', '21037', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '94397', '115053', '-3136', '0', '0', '1989', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '93123', '118296', '-3034', '0', '0', '29992', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '91629', '119214', '-2970', '0', '0', '22027', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '89587', '120053', '-3059', '0', '0', '26458', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '88234', '120070', '-3062', '0', '0', '39054', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '86200', '119647', '-3015', '0', '0', '36488', '60', '0', '0'),
('giran03_2221_H5', '1', '22830', '96859', '110037', '-3725', '0', '0', '59696', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '80484', '114457', '-3727', '0', '0', '336', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '91540', '107955', '-3059', '0', '0', '23431', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '93007', '107601', '-3028', '0', '0', '64958', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '93667', '107587', '-3021', '0', '0', '63721', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '94986', '107717', '-3055', '0', '0', '94', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '95736', '107894', '-3131', '0', '0', '8280', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '96597', '108644', '-3372', '0', '0', '9137', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '97056', '109697', '-3707', '0', '0', '14801', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '98104', '109649', '-3716', '0', '0', '28707', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '97982', '109328', '-3728', '0', '0', '44686', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '99015', '110046', '-3697', '0', '0', '11948', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '99830', '110332', '-3697', '0', '0', '15238', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '99799', '110770', '-3702', '0', '0', '37931', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '100810', '110829', '-3674', '0', '0', '2783', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '100843', '111862', '-3679', '0', '0', '15013', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '102318', '111425', '-3709', '0', '0', '60918', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '102167', '112225', '-3684', '0', '0', '20385', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '103109', '114791', '-3157', '0', '0', '16237', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '109311', '113763', '-3065', '0', '0', '11171', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '108750', '113317', '-3036', '0', '0', '40256', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '109369', '113024', '-3064', '0', '0', '731', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '108359', '112488', '-3047', '0', '0', '39655', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '109458', '112423', '-3047', '0', '0', '303', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '110044', '111858', '-3087', '0', '0', '52805', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '109977', '111500', '-3085', '0', '0', '49086', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '109417', '114670', '-3081', '0', '0', '17177', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '109012', '116130', '-3098', '0', '0', '17757', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '108492', '116706', '-3060', '0', '0', '19823', '60', '0', '0'),
('giran03_2221_H5', '1', '22830', '108581', '117880', '-3042', '0', '0', '23153', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '108438', '117589', '-3058', '0', '0', '58327', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '107439', '117907', '-3061', '0', '0', '31144', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '105963', '118009', '-3038', '0', '0', '31500', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '103394', '115683', '-3061', '0', '0', '2003', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '101523', '112413', '-3689', '0', '0', '25042', '60', '0', '0'),
('giran03_2221_H5', '1', '22830', '101447', '114214', '-3726', '0', '0', '17401', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '101211', '115531', '-3719', '0', '0', '17200', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '101203', '116156', '-3712', '0', '0', '16311', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '101577', '116446', '-3705', '0', '0', '9444', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '101146', '118199', '-3681', '0', '0', '22918', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '102038', '117712', '-3682', '0', '0', '10654', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '101739', '118921', '-3553', '0', '0', '54415', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '101847', '119885', '-3597', '0', '0', '20776', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '101322', '120987', '-3726', '0', '0', '18780', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '102260', '121688', '-3689', '0', '0', '56268', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '102248', '120948', '-3597', '0', '0', '49123', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '84644', '119184', '-2993', '0', '0', '60276', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '86044', '120503', '-3016', '0', '0', '60827', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '86649', '120425', '-3037', '0', '0', '61031', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '86922', '120163', '-3054', '0', '0', '57558', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '85478', '119710', '-2991', '0', '0', '53519', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '89987', '119094', '-3049', '0', '0', '55568', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '88044', '120539', '-3061', '0', '0', '29009', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '87475', '121286', '-3053', '0', '0', '20807', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '89996', '115764', '-3048', '0', '0', '9590', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '90342', '116631', '-3136', '0', '0', '10147', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '90151', '116423', '-3111', '0', '0', '41404', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '87592', '114615', '-2984', '0', '0', '34823', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '85625', '115645', '-3054', '0', '0', '28685', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '84505', '117673', '-3000', '0', '0', '18939', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '83549', '117680', '-2997', '0', '0', '37019', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '83530', '118612', '-2996', '0', '0', '14534', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '83972', '119452', '-2959', '0', '0', '8595', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '83972', '119452', '-2959', '0', '0', '8595', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '83972', '119452', '-2959', '0', '0', '8595', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '83946', '119336', '-2967', '0', '0', '46852', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '83946', '119336', '-2967', '0', '0', '46852', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '85082', '120108', '-2963', '0', '0', '6248', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '85860', '120107', '-2984', '0', '0', '65385', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '85534', '120533', '-3018', '0', '0', '21383', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '84892', '120644', '-3007', '0', '0', '32436', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '86654', '120785', '-3042', '0', '0', '475', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '87226', '121095', '-3063', '0', '0', '6141', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '87531', '120709', '-3061', '0', '0', '27149', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '87531', '120709', '-3061', '0', '0', '27149', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '87531', '120709', '-3061', '0', '0', '27149', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '87531', '120709', '-3061', '0', '0', '27149', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '87531', '120709', '-3061', '0', '0', '27149', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '91102', '120501', '-2996', '0', '0', '7241', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '91102', '120501', '-2996', '0', '0', '7241', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '91102', '120501', '-2996', '0', '0', '7241', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '91102', '120501', '-2996', '0', '0', '7241', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '91102', '120501', '-2996', '0', '0', '7241', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '91102', '120501', '-2996', '0', '0', '7241', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '91115', '119885', '-2991', '0', '0', '58533', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '90212', '120297', '-3060', '0', '0', '28603', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '90348', '119416', '-3061', '0', '0', '51556', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '93468', '118455', '-3008', '0', '0', '2289', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '91301', '110266', '-3788', '0', '0', '12899', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '91726', '110293', '-3777', '0', '0', '53412', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '117312', '110142', '-2963', '0', '0', '0', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '118195', '109860', '-2942', '0', '0', '62764', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '117964', '110179', '-2948', '0', '0', '21479', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '116412', '109987', '-3035', '0', '0', '32722', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '115487', '110219', '-3026', '0', '0', '33028', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '114017', '110210', '-3038', '0', '0', '39754', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '113597', '110881', '-3060', '0', '0', '11277', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '114098', '111558', '-3134', '0', '0', '9522', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '114129', '112677', '-3076', '0', '0', '18856', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '111834', '112174', '-2776', '0', '0', '17204', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '110686', '113013', '-2798', '0', '0', '13253', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '110834', '110711', '-3063', '0', '0', '59371', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '112004', '110579', '-3014', '0', '0', '60909', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '111871', '110321', '-3019', '0', '0', '44187', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '111467', '110739', '-3036', '0', '0', '22666', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '118812', '109606', '-2997', '0', '0', '29521', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '118738', '110439', '-2996', '0', '0', '18994', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '120034', '109433', '-2972', '0', '0', '48655', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '121027', '108366', '-2984', '0', '0', '62052', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '122644', '108050', '-3004', '0', '0', '56645', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '123029', '108700', '-3022', '0', '0', '8492', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '124089', '108856', '-3039', '0', '0', '63466', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '124677', '108991', '-3037', '0', '0', '9129', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '124685', '110679', '-3118', '0', '0', '25089', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '125172', '111673', '-3162', '0', '0', '6403', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '124738', '111501', '-3130', '0', '0', '36703', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '125493', '110945', '-3101', '0', '0', '42482', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '125170', '112273', '-3174', '0', '0', '26088', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '125086', '111187', '-3149', '0', '0', '50680', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '126773', '113371', '-3594', '0', '0', '9703', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '126512', '112739', '-3490', '0', '0', '46521', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '128880', '113376', '-3683', '0', '0', '54192', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '127231', '114236', '-3521', '0', '0', '30770', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '126411', '115045', '-3725', '0', '0', '23836', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '125298', '114349', '-3713', '0', '0', '37212', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '126389', '114435', '-3653', '0', '0', '56252', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '118997', '115925', '-3783', '0', '0', '35032', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '118229', '116266', '-3738', '0', '0', '61270', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '118858', '116272', '-3743', '0', '0', '248', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '118225', '117165', '-3726', '0', '0', '589', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '117453', '116889', '-3726', '0', '0', '43939', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '116608', '117159', '-3726', '0', '0', '24148', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '116114', '117576', '-3726', '0', '0', '56141', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '116704', '118311', '-3726', '0', '0', '14047', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '116404', '119112', '-3726', '0', '0', '13293', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '117194', '119720', '-3662', '0', '0', '6748', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '116247', '119574', '-3712', '0', '0', '28013', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '116188', '120285', '-3662', '0', '0', '15656', '60', '0', '0'),
('giran03_2221_H5', '1', '22830', '115518', '119637', '-3667', '0', '0', '42462', '60', '0', '0'),
('giran03_2221_H5', '1', '22830', '115089', '120183', '-3678', '0', '0', '22466', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '114622', '119648', '-3723', '0', '0', '41004', '60', '0', '0'),
('giran03_2221_H5', '1', '22830', '114973', '120370', '-3679', '0', '0', '1027', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '113820', '120092', '-3744', '0', '0', '43323', '60', '0', '0'),
('giran03_2221_H5', '1', '22830', '112875', '121718', '-3725', '0', '0', '23614', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '112661', '122190', '-3725', '0', '0', '20823', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '111663', '122183', '-3724', '0', '0', '40794', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '111378', '123259', '-3722', '0', '0', '20118', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '110590', '122903', '-3708', '0', '0', '38371', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '110626', '122239', '-3693', '0', '0', '46844', '60', '0', '0'),
('giran03_2221_H5', '1', '22830', '110584', '123914', '-3642', '0', '0', '29629', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '110197', '123457', '-3630', '0', '0', '33174', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '109595', '124328', '-3688', '0', '0', '27692', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '109638', '122726', '-3665', '0', '0', '56656', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '109762', '122025', '-3684', '0', '0', '49376', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '108930', '121959', '-3715', '0', '0', '44655', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '108766', '121129', '-3726', '0', '0', '54520', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '108345', '122358', '-3669', '0', '0', '52915', '60', '0', '0'),
('giran03_2221_H5', '1', '22830', '107914', '121747', '-3703', '0', '0', '42744', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '108244', '120621', '-3722', '0', '0', '51506', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '107534', '120300', '-3703', '0', '0', '31851', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '106589', '120769', '-3692', '0', '0', '31251', '60', '0', '0'),
('giran03_2221_H5', '1', '22830', '107009', '122506', '-3685', '0', '0', '11739', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '106417', '121754', '-3677', '0', '0', '37532', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '105414', '121561', '-3772', '0', '0', '38428', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '105063', '122680', '-3695', '0', '0', '18673', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '105733', '123513', '-3657', '0', '0', '61574', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '104473', '121947', '-3802', '0', '0', '36523', '60', '0', '0'),
('giran03_2221_H5', '1', '22830', '103778', '122288', '-3774', '0', '0', '26565', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '103214', '122619', '-3680', '0', '0', '26797', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '103384', '121386', '-3740', '0', '0', '56746', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '104043', '120622', '-3663', '0', '0', '56189', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '104758', '120315', '-3671', '0', '0', '61532', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '104302', '123719', '-3726', '0', '0', '15290', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '103220', '123864', '-3711', '0', '0', '33463', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '102605', '123478', '-3672', '0', '0', '39587', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '102146', '122678', '-3660', '0', '0', '43590', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '103816', '123838', '-3726', '0', '0', '10609', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '105112', '122249', '-3741', '0', '0', '59530', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '105823', '121133', '-3679', '0', '0', '51002', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '106701', '120341', '-3690', '0', '0', '59721', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '104611', '120961', '-3709', '0', '0', '30194', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '103445', '121670', '-3746', '0', '0', '27223', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '102467', '120617', '-3592', '0', '0', '45062', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '103258', '119818', '-3657', '0', '0', '59123', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '102706', '118736', '-3690', '0', '0', '42384', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '101217', '119485', '-3529', '0', '0', '27931', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '101212', '117126', '-3691', '0', '0', '28245', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '101417', '114859', '-3726', '0', '0', '21567', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '102320', '113610', '-3721', '0', '0', '55124', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '102612', '112672', '-3710', '0', '0', '58628', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '102781', '111867', '-3685', '0', '0', '50107', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '102931', '110998', '-3707', '0', '0', '58750', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '86210', '107268', '-3156', '0', '0', '45280', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '86973', '106990', '-3139', '0', '0', '60948', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '87588', '108224', '-3078', '0', '0', '11561', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '86522', '108463', '-3148', '0', '0', '27372', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '85962', '109104', '-3202', '0', '0', '26629', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '86122', '108207', '-3201', '0', '0', '52123', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '85508', '107985', '-3261', '0', '0', '31562', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '84676', '108224', '-3230', '0', '0', '34518', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '84676', '108224', '-3230', '0', '0', '34518', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '84676', '108224', '-3230', '0', '0', '34518', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '84676', '108224', '-3230', '0', '0', '34518', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '84676', '108224', '-3230', '0', '0', '34518', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '85774', '112059', '-3063', '0', '0', '2802', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '86949', '112134', '-3265', '0', '0', '1119', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '88217', '112540', '-3285', '0', '0', '6348', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '89561', '112428', '-3096', '0', '0', '61812', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '90248', '113151', '-2996', '0', '0', '38991', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '90577', '113360', '-2998', '0', '0', '5902', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '90577', '113360', '-2998', '0', '0', '5902', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '91198', '112420', '-2977', '0', '0', '49104', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '91806', '112304', '-2972', '0', '0', '63569', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '92456', '112750', '-3062', '0', '0', '6272', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '92982', '112981', '-3070', '0', '0', '4316', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '93304', '113596', '-3090', '0', '0', '15529', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '93304', '113596', '-3090', '0', '0', '15529', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '93304', '113596', '-3090', '0', '0', '15529', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '92391', '115062', '-3140', '0', '0', '34740', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '93143', '114294', '-3089', '0', '0', '48141', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '92143', '112832', '-3074', '0', '0', '29874', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '92213', '111659', '-3011', '0', '0', '53751', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '93054', '111762', '-2999', '0', '0', '1716', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '90982', '112644', '-3007', '0', '0', '64774', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '94091', '114568', '-3087', '0', '0', '19106', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '124687', '118859', '-3100', '0', '0', '25255', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '123421', '119021', '-3208', '0', '0', '29396', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '122870', '120171', '-3145', '0', '0', '22225', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '121082', '121475', '-2977', '0', '0', '3852', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '121522', '119348', '-3118', '0', '0', '58687', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '119960', '121837', '-3050', '0', '0', '17487', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '119327', '122585', '-3061', '0', '0', '27386', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '116120', '123107', '-3192', '0', '0', '34353', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '119962', '110943', '-3061', '0', '0', '46396', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '112164', '118398', '-3076', '0', '0', '24415', '60', '0', '0'),
('giran03_2221_H5', '1', '22825', '112148', '118009', '-3032', '0', '0', '48723', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '112776', '117809', '-3096', '0', '0', '62108', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '111864', '117288', '-3010', '0', '0', '34444', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '112370', '116939', '-3003', '0', '0', '59430', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '113398', '117221', '-3160', '0', '0', '2261', '60', '0', '0'),
('giran03_2221_H5', '1', '22825', '112962', '116953', '-3098', '0', '0', '38516', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '111827', '116391', '-3053', '0', '0', '41063', '60', '0', '0'),
('giran03_2221_H5', '1', '22825', '112636', '115944', '-3190', '0', '0', '56605', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '112851', '115204', '-3225', '0', '0', '52278', '60', '0', '0'),
('giran03_2221_H5', '1', '22825', '113617', '115361', '-3225', '0', '0', '1179', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '113724', '116062', '-3239', '0', '0', '12773', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '114725', '115435', '-3244', '0', '0', '62649', '60', '0', '0'),
('giran03_2221_H5', '1', '22825', '115309', '114857', '-3173', '0', '0', '58029', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '114216', '114972', '-3191', '0', '0', '31234', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '113763', '115310', '-3225', '0', '0', '26081', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '115634', '115019', '-3136', '0', '0', '62910', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '116520', '114383', '-3062', '0', '0', '58094', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '111218', '119314', '-3061', '0', '0', '26218', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '110076', '119427', '-3073', '0', '0', '29393', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '113043', '110360', '-3008', '0', '0', '659', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '113043', '110360', '-3008', '0', '0', '659', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '113043', '110360', '-3008', '0', '0', '659', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '113043', '110360', '-3008', '0', '0', '659', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '114201', '111074', '-3094', '0', '0', '7447', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '114201', '111074', '-3094', '0', '0', '7447', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '114201', '111074', '-3094', '0', '0', '7447', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '114201', '111074', '-3094', '0', '0', '7447', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '114924', '112264', '-3020', '0', '0', '12089', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '114924', '112264', '-3020', '0', '0', '12089', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '114924', '112264', '-3020', '0', '0', '12089', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '114924', '112264', '-3020', '0', '0', '12089', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '113465', '112632', '-3103', '0', '0', '40014', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '112153', '112802', '-2776', '0', '0', '37053', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '112153', '112802', '-2776', '0', '0', '37053', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '112153', '112802', '-2776', '0', '0', '37053', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '112153', '112802', '-2776', '0', '0', '37053', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '112153', '112802', '-2776', '0', '0', '37053', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '112102', '111538', '-2757', '0', '0', '52174', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '112102', '111538', '-2757', '0', '0', '52174', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '112102', '111538', '-2757', '0', '0', '52174', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '112102', '111538', '-2757', '0', '0', '52174', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '112102', '111538', '-2757', '0', '0', '52174', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '111147', '112737', '-2801', '0', '0', '25860', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '114471', '109799', '-3022', '0', '0', '21173', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '114471', '109799', '-3022', '0', '0', '21173', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '114471', '109799', '-3022', '0', '0', '21173', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '115760', '109933', '-3038', '0', '0', '63963', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '115760', '109933', '-3038', '0', '0', '63963', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '115760', '109933', '-3038', '0', '0', '63963', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '115760', '109933', '-3038', '0', '0', '63963', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '116896', '110556', '-2991', '0', '0', '3075', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '116896', '110556', '-2991', '0', '0', '3075', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '116896', '110556', '-2991', '0', '0', '3075', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '116896', '110556', '-2991', '0', '0', '3075', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '119269', '110605', '-3059', '0', '0', '61312', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '119269', '110605', '-3059', '0', '0', '61312', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '119269', '110605', '-3059', '0', '0', '61312', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '119269', '110605', '-3059', '0', '0', '61312', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '119619', '109712', '-3007', '0', '0', '53260', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '119619', '109712', '-3007', '0', '0', '53260', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '119619', '109712', '-3007', '0', '0', '53260', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '119619', '109712', '-3007', '0', '0', '53260', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '120457', '108550', '-2949', '0', '0', '56952', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '120457', '108550', '-2949', '0', '0', '56952', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '120457', '108550', '-2949', '0', '0', '56952', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '120457', '108550', '-2949', '0', '0', '56952', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '121546', '109017', '-2936', '0', '0', '5505', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '121546', '109017', '-2936', '0', '0', '5505', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '121546', '109017', '-2936', '0', '0', '5505', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '121546', '109017', '-2936', '0', '0', '5505', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '121546', '109017', '-2936', '0', '0', '5505', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '122225', '109202', '-2908', '0', '0', '7063', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '121472', '109078', '-2936', '0', '0', '50298', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '121472', '109078', '-2936', '0', '0', '50298', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '121472', '109078', '-2936', '0', '0', '50298', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '121472', '109078', '-2936', '0', '0', '50298', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '122557', '108865', '-2985', '0', '0', '51934', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '122557', '108865', '-2985', '0', '0', '51934', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '122557', '108865', '-2985', '0', '0', '51934', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '124560', '109377', '-3101', '0', '0', '10937', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '124560', '109377', '-3101', '0', '0', '10937', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '124560', '109377', '-3101', '0', '0', '10937', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '124560', '109377', '-3101', '0', '0', '10937', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '124882', '110603', '-3123', '0', '0', '15192', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '124882', '110603', '-3123', '0', '0', '15192', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '126220', '112397', '-3375', '0', '0', '3654', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '126220', '112397', '-3375', '0', '0', '3654', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '126220', '112397', '-3375', '0', '0', '3654', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '126220', '112397', '-3375', '0', '0', '3654', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '127401', '113083', '-3665', '0', '0', '4749', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '127401', '113083', '-3665', '0', '0', '4749', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '127401', '113083', '-3665', '0', '0', '4749', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '127401', '113083', '-3665', '0', '0', '4749', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '128507', '113776', '-3683', '0', '0', '451', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '129101', '113540', '-3692', '0', '0', '61387', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '129534', '113804', '-3730', '0', '0', '54593', '60', '0', '0'),
('giran03_2221_H5', '1', '22825', '129122', '114746', '-3763', '0', '0', '20279', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '128908', '115470', '-3807', '0', '0', '19381', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '128386', '115334', '-3780', '0', '0', '35426', '60', '0', '0'),
('giran03_2221_H5', '1', '22825', '127690', '115950', '-3754', '0', '0', '27422', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '126937', '115456', '-3726', '0', '0', '65006', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '126821', '114815', '-3726', '0', '0', '39836', '60', '0', '0'),
('giran03_2221_H5', '1', '22825', '125543', '115135', '-3726', '0', '0', '25711', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '124674', '114697', '-3699', '0', '0', '40226', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '124221', '115415', '-3676', '0', '0', '21907', '60', '0', '0'),
('giran03_2221_H5', '1', '22825', '123865', '116037', '-3644', '0', '0', '20759', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '123102', '116295', '-3630', '0', '0', '28920', '60', '0', '0'),
('giran03_2221_H5', '1', '22825', '122772', '116850', '-3653', '0', '0', '20324', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '121965', '116152', '-3624', '0', '0', '39304', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '121828', '114772', '-3737', '0', '0', '17127', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '122280', '113457', '-3802', '0', '0', '37061', '60', '0', '0'),
('giran03_2221_H5', '1', '22825', '121819', '112794', '-3796', '0', '0', '40557', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '122380', '114471', '-3774', '0', '0', '10672', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '123350', '114927', '-3679', '0', '0', '3427', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '123592', '114369', '-3728', '0', '0', '52374', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '122295', '115244', '-3714', '0', '0', '25575', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '121111', '115362', '-3611', '0', '0', '35188', '60', '0', '0'),
('giran03_2221_H5', '1', '22825', '120173', '114886', '-3672', '0', '0', '38212', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '119481', '115790', '-3784', '0', '0', '21096', '60', '0', '0'),
('giran03_2221_H5', '1', '22825', '119660', '116492', '-3762', '0', '0', '13052', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '120384', '116858', '-3647', '0', '0', '4882', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '121157', '116762', '-3628', '0', '0', '787', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '122005', '116860', '-3655', '0', '0', '18313', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '122874', '115474', '-3660', '0', '0', '58487', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '117933', '116736', '-3726', '0', '0', '29338', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '116397', '118406', '-3726', '0', '0', '22720', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '117569', '118749', '-3698', '0', '0', '55035', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '115623', '122705', '-3396', '0', '0', '7306', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '117292', '123057', '-3123', '0', '0', '1599', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '117292', '123057', '-3123', '0', '0', '1599', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '117292', '123057', '-3123', '0', '0', '1599', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '117292', '123057', '-3123', '0', '0', '1599', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '118939', '122402', '-3038', '0', '0', '59427', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '118939', '122402', '-3038', '0', '0', '59427', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '118939', '122402', '-3038', '0', '0', '59427', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '118939', '122402', '-3038', '0', '0', '59427', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '120128', '121991', '-3033', '0', '0', '55314', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '120048', '121981', '-3038', '0', '0', '34065', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '120020', '122074', '-3042', '0', '0', '19434', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '120117', '122105', '-3031', '0', '0', '3226', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '120303', '121032', '-3061', '0', '0', '45765', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '120254', '121043', '-3061', '0', '0', '30464', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '120221', '120803', '-3061', '0', '0', '47726', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '121493', '121344', '-2981', '0', '0', '8006', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '122505', '120931', '-3118', '0', '0', '58561', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '122458', '120842', '-3114', '0', '0', '44084', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '122419', '120873', '-3117', '0', '0', '25762', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '122399', '120922', '-3118', '0', '0', '20426', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '122301', '119734', '-3163', '0', '0', '49389', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '122237', '119660', '-3167', '0', '0', '41714', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '122238', '119742', '-3162', '0', '0', '16256', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '121134', '119671', '-3080', '0', '0', '24561', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '121270', '119567', '-3081', '0', '0', '3523', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '123644', '119589', '-3164', '0', '0', '64937', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '123591', '119571', '-3170', '0', '0', '36182', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '123665', '119517', '-3162', '0', '0', '58960', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '123757', '119546', '-3147', '0', '0', '3185', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '124557', '118579', '-3062', '0', '0', '57358', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '124536', '118646', '-3064', '0', '0', '19552', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '124429', '118610', '-3063', '0', '0', '36153', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '125531', '117958', '-3061', '0', '0', '63574', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '125474', '118044', '-3061', '0', '0', '22489', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '125358', '118062', '-3061', '0', '0', '31162', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '125357', '117950', '-3061', '0', '0', '49058', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '126070', '118715', '-3052', '0', '0', '18461', '60', '0', '0'),
('giran03_2221_H5', '1', '22770', '-113822', '-248878', '-2992', '0', '0', '49755', '60', '0', '0'),
('giran03_2221_H5', '1', '22830', '-113892', '-249025', '-2992', '0', '0', '52538', '60', '0', '0'),
('giran03_2221_H5', '1', '22835', '-113716', '-249233', '-2992', '0', '0', '55455', '60', '0', '0'),
('giran03_2221_H5', '1', '22829', '-113844', '-249912', '-2992', '0', '0', '49083', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '-113876', '-248708', '-2992', '0', '0', '11207', '60', '0', '0'),
('giran03_2221_H5', '1', '22818', '-113866', '-248514', '-2992', '0', '0', '59559', '60', '0', '0'),
('giran03_2221_H5', '1', '22819', '-113822', '-249082', '-2992', '0', '0', '46691', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '-113880', '-249226', '-2992', '0', '0', '45158', '60', '0', '0'),
('giran03_2221_H5', '1', '22826', '-113864', '-249417', '-2992', '0', '0', '48579', '60', '0', '0'),
('giran03_2221_H5', '1', '22828', '-113808', '-249618', '-2992', '0', '0', '53712', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '-113983', '-249347', '-2992', '0', '0', '60429', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '-114002', '-249251', '-2992', '0', '0', '2215', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '-113981', '-249500', '-2992', '0', '0', '1585', '60', '0', '0'),
('giran03_2221_H5', '1', '22823', '-113960', '-249752', '-2992', '0', '0', '59959', '60', '0', '0'),
('giran03_2221_H5', '1', '22861', '-113995', '-249664', '-2992', '0', '0', '61480', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '-114294', '-249502', '-2986', '0', '0', '22993', '60', '0', '0'),
('giran03_2221_H5', '1', '22825', '-114351', '-249249', '-2986', '0', '0', '20548', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '-114313', '-249041', '-2986', '0', '0', '50658', '60', '0', '0'),
('giran03_2221_H5', '1', '22820', '-114669', '-248997', '-2986', '0', '0', '21106', '60', '0', '0'),
('giran03_2221_H5', '1', '22831', '-114999', '-249270', '-2986', '0', '0', '24354', '60', '0', '0'),
('giran03_2221_H5', '1', '22832', '-114983', '-249585', '-2986', '0', '0', '53319', '60', '0', '0'),
('giran03_2221_H5', '1', '22833', '-115022', '-249457', '-2986', '0', '0', '36338', '60', '0', '0'),
('giran03_2221_H5', '1', '22834', '-115167', '-249776', '-2992', '0', '0', '7391', '60', '0', '0'),
('giran03_2221_H5', '1', '22833', '127966', '113296', '-3684', '0', '0', '36103', '60', '0', '0'),
('giran03_2221_H5', '1', '22834', '124317', '108984', '-3060', '0', '0', '45279', '60', '0', '0'),
('giran03_2221_H5', '1', '22834', '113545', '110038', '-2991', '0', '0', '38064', '60', '0', '0'),
('giran03_2221_H5', '1', '22820', '108237', '117632', '-3061', '0', '0', '22798', '60', '0', '0'),
('giran03_2221_H5', '1', '22831', '102111', '112686', '-3702', '0', '0', '21791', '60', '0', '0'),
('giran03_2221_H5', '1', '22832', '96475', '110320', '-3725', '0', '0', '38915', '60', '0', '0'),
('giran03_2221_H5', '1', '22820', '91598', '112950', '-3055', '0', '0', '37315', '60', '0', '0'),
('giran03_2221_H5', '1', '22833', '121759', '115735', '-3613', '0', '0', '29511', '60', '0', '0'),
('giran03_2221_H5', '1', '22834', '117753', '118999', '-3660', '0', '0', '16244', '60', '0', '0'),
('giran03_2221_H5', '1', '22820', '120931', '120199', '-3061', '0', '0', '52995', '60', '0', '0'),
('giran03_2221_H5', '1', '22831', '110086', '123221', '-3645', '0', '0', '32010', '60', '0', '0'),
('giran03_2221_H5', '1', '22832', '104890', '121742', '-3801', '0', '0', '40251', '60', '0', '0'),
('giran03_2221_H5', '1', '22832', '101350', '116236', '-3713', '0', '0', '46418', '60', '0', '0'),
('giran03_2221_H5', '1', '22820', '91093', '107742', '-3068', '0', '0', '32212', '60', '0', '0'),
('giran03_2221_H5', '1', '22820', '84479', '108685', '-3188', '0', '0', '33196', '60', '0', '0'),
('giran03_2221_H5', '1', '22820', '91477', '119807', '-2947', '0', '0', '62140', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '135354', '114402', '-3724', '0', '0', '34248', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '135928', '115056', '-3724', '0', '0', '33564', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '136580', '114619', '-3724', '0', '0', '52807', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '136365', '113894', '-3724', '0', '0', '41279', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '135736', '113884', '-3724', '0', '0', '24306', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '136541', '114046', '-3724', '0', '0', '52948', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '136486', '114743', '-3724', '0', '0', '18983', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '135865', '115076', '-3724', '0', '0', '32315', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '135368', '114502', '-3727', '0', '0', '44041', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '135602', '114796', '-3724', '0', '0', '47769', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '136685', '114683', '-3713', '0', '0', '11776', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '135624', '114462', '-3724', '0', '0', '18300', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '139626', '114351', '-3724', '0', '0', '30212', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '139950', '114630', '-3719', '0', '0', '7415', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '140036', '114377', '-3724', '0', '0', '10931', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '140387', '114602', '-3724', '0', '0', '13170', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '140453', '114355', '-3724', '0', '0', '53466', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '140900', '114664', '-3724', '0', '0', '15628', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '140799', '114773', '-3724', '0', '0', '30729', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '140649', '112935', '-3724', '0', '0', '48553', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '141724', '112686', '-3724', '0', '0', '55983', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '140935', '114351', '-3710', '0', '0', '58948', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '140777', '113947', '-3710', '0', '0', '45263', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '140470', '113760', '-3724', '0', '0', '38474', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '140921', '113194', '-3724', '0', '0', '56375', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '141640', '112368', '-3724', '0', '0', '50353', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '141468', '112866', '-3724', '0', '0', '19852', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '141238', '113033', '-3724', '0', '0', '58280', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '140733', '112506', '-3724', '0', '0', '47675', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '140646', '111990', '-3724', '0', '0', '46911', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '140763', '112911', '-3724', '0', '0', '57514', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '140829', '113489', '-3724', '0', '0', '64419', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '143535', '112221', '-3948', '0', '0', '9411', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '143219', '112402', '-3948', '0', '0', '27803', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '143850', '112760', '-3948', '0', '0', '5382', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '144361', '112428', '-3944', '0', '0', '54399', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '143867', '112152', '-3948', '0', '0', '37054', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '143594', '112117', '-3948', '0', '0', '23131', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '143786', '112825', '-3951', '0', '0', '11895', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '144219', '112633', '-3948', '0', '0', '58403', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '144094', '112219', '-3948', '0', '0', '37117', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '142663', '111203', '-3948', '0', '0', '14055', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '143484', '110431', '-3948', '0', '0', '8951', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '143834', '110035', '-3948', '0', '0', '56701', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '144003', '110326', '-3928', '0', '0', '10896', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '143690', '110324', '-3948', '0', '0', '32834', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '143743', '110126', '-3948', '0', '0', '51880', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '142162', '109376', '-3948', '0', '0', '1930', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '140610', '110739', '-3948', '0', '0', '18771', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '140688', '110387', '-3948', '0', '0', '53052', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '141019', '109911', '-3948', '0', '0', '51953', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '140492', '110147', '-3933', '0', '0', '27815', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '141073', '109208', '-3948', '0', '0', '61623', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '140584', '108582', '-3948', '0', '0', '41802', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '140623', '107630', '-3948', '0', '0', '51696', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '140947', '108499', '-3942', '0', '0', '5022', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '141360', '108956', '-3948', '0', '0', '12920', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '141101', '110189', '-3948', '0', '0', '18548', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '140645', '107943', '-3948', '0', '0', '5224', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '140540', '109353', '-3948', '0', '0', '26151', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '141847', '109335', '-3948', '0', '0', '59553', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '141224', '109586', '-3948', '0', '0', '23121', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '140614', '108685', '-3948', '0', '0', '4660', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '143007', '108819', '-3948', '0', '0', '63635', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '143050', '108636', '-3948', '0', '0', '51559', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '142679', '108833', '-3948', '0', '0', '27676', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '142539', '107201', '-3948', '0', '0', '37780', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '144449', '108131', '-3948', '0', '0', '12204', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '145035', '109256', '-3948', '0', '0', '12021', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '144839', '107823', '-3948', '0', '0', '50550', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '144765', '107470', '-3948', '0', '0', '42653', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '144576', '107600', '-3948', '0', '0', '28743', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '144863', '108900', '-3948', '0', '0', '32189', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '145316', '108834', '-3948', '0', '0', '985', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '145499', '108281', '-3948', '0', '0', '50751', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '144640', '108750', '-3948', '0', '0', '36947', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '145437', '109834', '-3932', '0', '0', '8157', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '147445', '109987', '-3948', '0', '0', '6040', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '147918', '110595', '-3948', '0', '0', '1881', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '147778', '109867', '-3948', '0', '0', '47170', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '147757', '109426', '-3948', '0', '0', '12012', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '148120', '109917', '-3935', '0', '0', '6205', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '148248', '110526', '-3948', '0', '0', '45470', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '148118', '110065', '-3944', '0', '0', '43004', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '142488', '107207', '-3948', '0', '0', '33600', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '143224', '108673', '-3948', '0', '0', '8492', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '141235', '109272', '-3948', '0', '0', '29699', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '140942', '108939', '-3936', '0', '0', '48765', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '140680', '115197', '-3724', '0', '0', '53250', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '140227', '117025', '-3916', '0', '0', '14339', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '140255', '117374', '-3919', '0', '0', '48591', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '140011', '117867', '-3916', '0', '0', '21177', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '140454', '117605', '-3916', '0', '0', '1464', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '140365', '117920', '-3916', '0', '0', '12096', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '140715', '118069', '-3916', '0', '0', '52938', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '140527', '118970', '-3916', '0', '0', '18529', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '140206', '119893', '-3916', '0', '0', '18524', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '140498', '118219', '-3916', '0', '0', '45690', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '140638', '118623', '-3916', '0', '0', '12904', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '140323', '119485', '-3916', '0', '0', '25319', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '140800', '119064', '-3916', '0', '0', '54481', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '140080', '119162', '-3902', '0', '0', '63593', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '140786', '118224', '-3916', '0', '0', '11443', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '140666', '117833', '-3916', '0', '0', '46046', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '140889', '118840', '-3916', '0', '0', '11406', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '141725', '117374', '-3916', '0', '0', '30041', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '142416', '117441', '-3916', '0', '0', '64394', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '143033', '117981', '-3913', '0', '0', '20340', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '143436', '117351', '-3916', '0', '0', '137', '60', '0', '0'),
('giran03_2221_H5', '1', '22838', '142625', '116422', '-3916', '0', '0', '5436', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '143364', '117638', '-3916', '0', '0', '5727', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '143271', '117381', '-3916', '0', '0', '37656', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '142700', '117036', '-3916', '0', '0', '15650', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '142890', '116304', '-3908', '0', '0', '58454', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '143195', '116316', '-3904', '0', '0', '410', '60', '0', '0'),
('giran03_2221_H5', '1', '22841', '142336', '116978', '-3916', '0', '0', '18521', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '142806', '117497', '-3916', '0', '0', '8740', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '143378', '117672', '-3916', '0', '0', '2941', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '141775', '117305', '-3916', '0', '0', '27175', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '140435', '120725', '-3916', '0', '0', '50565', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '140322', '121347', '-3916', '0', '0', '21075', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '140655', '120788', '-3902', '0', '0', '63732', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '141164', '121115', '-3916', '0', '0', '5956', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '141416', '121595', '-3916', '0', '0', '11341', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '141023', '121767', '-3916', '0', '0', '28465', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '140591', '121737', '-3916', '0', '0', '33491', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '140507', '120801', '-3916', '0', '0', '51124', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '140363', '120073', '-3916', '0', '0', '45756', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '141677', '121440', '-3916', '0', '0', '8191', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '142335', '121452', '-3916', '0', '0', '28839', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '142949', '121432', '-3916', '0', '0', '65495', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '143166', '120894', '-3916', '0', '0', '54764', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '143143', '120601', '-3916', '0', '0', '27131', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '142816', '120991', '-3916', '0', '0', '23661', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '143459', '121307', '-3916', '0', '0', '4764', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '143720', '120538', '-3916', '0', '0', '56061', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '143626', '120263', '-3916', '0', '0', '49330', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '143007', '120030', '-3916', '0', '0', '33985', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '143191', '120703', '-3916', '0', '0', '9131', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '144171', '119852', '-3916', '0', '0', '56170', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '144400', '119502', '-3916', '0', '0', '23543', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '141627', '119198', '-3916', '0', '0', '36034', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '142203', '119424', '-3916', '0', '0', '3781', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '142365', '119167', '-3916', '0', '0', '55018', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '142365', '118859', '-3908', '0', '0', '51453', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '142561', '119279', '-3916', '0', '0', '11829', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '142603', '119763', '-3916', '0', '0', '9485', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '143278', '120309', '-3916', '0', '0', '27055', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '144043', '119948', '-3916', '0', '0', '59760', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '143897', '120205', '-3916', '0', '0', '29449', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '144148', '121128', '-3910', '0', '0', '27610', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '145056', '121752', '-3916', '0', '0', '4032', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '144357', '121503', '-3916', '0', '0', '35409', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '143876', '121132', '-3901', '0', '0', '26579', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '144789', '118683', '-3916', '0', '0', '52703', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '145113', '118484', '-3916', '0', '0', '55774', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '145102', '118068', '-3916', '0', '0', '44782', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '144815', '118161', '-3916', '0', '0', '25950', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '144876', '117639', '-3916', '0', '0', '50365', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '145348', '117692', '-3916', '0', '0', '1166', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '145616', '117330', '-3916', '0', '0', '6190', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '145104', '117744', '-3916', '0', '0', '26161', '60', '0', '0'),
('giran03_2221_H5', '1', '22852', '147097', '120167', '-4535', '0', '0', '14217', '60', '0', '0'),
('giran03_2221_H5', '1', '22853', '147014', '119101', '-4220', '0', '0', '49347', '60', '0', '0'),
('giran03_2221_H5', '1', '22852', '146639', '118103', '-3927', '0', '0', '8125', '60', '0', '0'),
('giran03_2221_H5', '1', '22853', '146973', '119545', '-4341', '0', '0', '45632', '60', '0', '0'),
('giran03_2221_H5', '1', '22853', '147374', '121038', '-4743', '0', '0', '16478', '60', '0', '0'),
('giran03_2221_H5', '1', '22848', '148019', '121419', '-4794', '0', '0', '23827', '60', '0', '0'),
('giran03_2221_H5', '1', '22849', '148507', '121500', '-4866', '0', '0', '4410', '60', '0', '0'),
('giran03_2221_H5', '1', '22850', '148487', '120954', '-4866', '0', '0', '43990', '60', '0', '0'),
('giran03_2221_H5', '1', '22851', '148283', '121059', '-4804', '0', '0', '29287', '60', '0', '0'),
('giran03_2221_H5', '1', '22848', '148853', '121154', '-4866', '0', '0', '3162', '60', '0', '0'),
('giran03_2221_H5', '1', '22849', '149258', '121448', '-4866', '0', '0', '7665', '60', '0', '0'),
('giran03_2221_H5', '1', '22850', '149587', '121614', '-4866', '0', '0', '4873', '60', '0', '0'),
('giran03_2221_H5', '1', '22851', '149382', '120749', '-4866', '0', '0', '46429', '60', '0', '0'),
('giran03_2221_H5', '1', '22848', '148579', '120427', '-4866', '0', '0', '50373', '60', '0', '0'),
('giran03_2221_H5', '1', '22849', '148927', '120614', '-4866', '0', '0', '24373', '60', '0', '0'),
('giran03_2221_H5', '1', '22850', '149357', '120031', '-4866', '0', '0', '54447', '60', '0', '0'),
('giran03_2221_H5', '1', '22851', '149753', '119497', '-4866', '0', '0', '58498', '60', '0', '0'),
('giran03_2221_H5', '1', '22848', '148993', '119693', '-4866', '0', '0', '30597', '60', '0', '0'),
('giran03_2221_H5', '1', '22851', '149199', '121009', '-4866', '0', '0', '18051', '60', '0', '0'),
('giran03_2221_H5', '1', '22852', '150198', '118734', '-4847', '0', '0', '35098', '60', '0', '0'),
('giran03_2221_H5', '1', '22853', '150721', '118234', '-4977', '0', '0', '57001', '60', '0', '0'),
('giran03_2221_H5', '1', '22852', '151694', '117456', '-5236', '0', '0', '53988', '60', '0', '0'),
('giran03_2221_H5', '1', '22854', '152355', '117032', '-5258', '0', '0', '64841', '60', '0', '0'),
('giran03_2221_H5', '1', '22855', '153100', '116875', '-5258', '0', '0', '64101', '60', '0', '0'),
('giran03_2221_H5', '1', '22856', '153066', '116576', '-5258', '0', '0', '43630', '60', '0', '0'),
('giran03_2221_H5', '1', '22854', '152774', '116775', '-5258', '0', '0', '20045', '60', '0', '0'),
('giran03_2221_H5', '1', '22854', '153654', '116906', '-5258', '0', '0', '14637', '60', '0', '0'),
('giran03_2221_H5', '1', '22856', '154153', '116866', '-5250', '0', '0', '65275', '60', '0', '0'),
('giran03_2221_H5', '1', '22855', '153554', '116725', '-5258', '0', '0', '33439', '60', '0', '0'),
('giran03_2221_H5', '1', '22854', '153314', '116184', '-5258', '0', '0', '50289', '60', '0', '0'),
('giran03_2221_H5', '1', '22855', '153315', '115699', '-5258', '0', '0', '54360', '60', '0', '0'),
('giran03_2221_H5', '1', '22855', '153452', '114985', '-5258', '0', '0', '57629', '60', '0', '0'),
('giran03_2221_H5', '1', '22854', '153975', '114739', '-5244', '0', '0', '49870', '60', '0', '0'),
('giran03_2221_H5', '1', '22856', '154440', '114875', '-5258', '0', '0', '2967', '60', '0', '0'),
('giran03_2221_H5', '1', '22854', '154679', '115643', '-5258', '0', '0', '15848', '60', '0', '0'),
('giran03_2221_H5', '1', '22855', '154606', '116190', '-5258', '0', '0', '16383', '60', '0', '0'),
('giran03_2221_H5', '1', '22855', '154672', '114887', '-5258', '0', '0', '47412', '60', '0', '0'),
('giran03_2221_H5', '1', '22854', '153017', '115287', '-5258', '0', '0', '889', '60', '0', '0'),
('giran03_2221_H5', '1', '22854', '151728', '115193', '-5476', '0', '0', '33243', '60', '0', '0'),
('giran03_2221_H5', '1', '22855', '151277', '114580', '-5471', '0', '0', '5867', '60', '0', '0'),
('giran03_2221_H5', '1', '22856', '151280', '115137', '-5476', '0', '0', '16327', '60', '0', '0'),
('giran03_2221_H5', '1', '22854', '151255', '115643', '-5476', '0', '0', '16898', '60', '0', '0'),
('giran03_2221_H5', '1', '22855', '151165', '115305', '-5476', '0', '0', '62491', '60', '0', '0'),
('giran03_2221_H5', '1', '22856', '150635', '115617', '-5476', '0', '0', '24958', '60', '0', '0'),
('giran03_2221_H5', '1', '22854', '150005', '115307', '-5476', '0', '0', '38376', '60', '0', '0'),
('giran03_2221_H5', '1', '22855', '150228', '114705', '-5476', '0', '0', '203', '60', '0', '0'),
('giran03_2221_H5', '1', '22854', '150850', '114626', '-5476', '0', '0', '64556', '60', '0', '0'),
('giran03_2221_H5', '1', '22854', '149095', '114998', '-5476', '0', '0', '31728', '60', '0', '0'),
('giran03_2221_H5', '1', '22855', '149068', '114693', '-5476', '0', '0', '50174', '60', '0', '0'),
('giran03_2221_H5', '1', '22856', '148907', '114870', '-5476', '0', '0', '24755', '60', '0', '0'),
('giran03_2221_H5', '1', '22856', '149957', '114797', '-5476', '0', '0', '61025', '60', '0', '0'),
('giran03_2221_H5', '1', '22854', '150718', '114948', '-5472', '0', '0', '38727', '60', '0', '0'),
('giran03_2221_H5', '1', '22854', '150331', '115584', '-5476', '0', '0', '28482', '60', '0', '0'),
('giran03_2221_H5', '1', '22852', '152141', '113919', '-5524', '0', '0', '56703', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '152693', '113457', '-5524', '0', '0', '27432', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '153132', '113127', '-5524', '0', '0', '31045', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '153222', '112726', '-5524', '0', '0', '53412', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '153276', '113013', '-5524', '0', '0', '17412', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '153726', '112645', '-5524', '0', '0', '3190', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '153905', '111768', '-5524', '0', '0', '49823', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '153456', '111132', '-5524', '0', '0', '41371', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '153786', '111380', '-5516', '0', '0', '16119', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '153248', '111667', '-5524', '0', '0', '27418', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '153727', '112395', '-5524', '0', '0', '61234', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '154075', '111139', '-5514', '0', '0', '1117', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '154248', '111994', '-5524', '0', '0', '18284', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '152128', '111411', '-5524', '0', '0', '2171', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '151773', '112967', '-5524', '0', '0', '15332', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '151082', '112031', '-5524', '0', '0', '39080', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '150932', '111697', '-5524', '0', '0', '44749', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '150612', '111913', '-5524', '0', '0', '24525', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '150316', '112346', '-5510', '0', '0', '19887', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '150699', '112370', '-5520', '0', '0', '11894', '60', '0', '0'),
('giran03_2221_H5', '1', '22857', '153657', '112239', '-5524', '0', '0', '1147', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '150972', '111276', '-5524', '0', '0', '29859', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '150467', '111065', '-5524', '0', '0', '34752', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '150091', '111563', '-5524', '0', '0', '40648', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '150547', '112003', '-5524', '0', '0', '3110', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '149552', '111123', '-5490', '0', '0', '37519', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '149525', '109974', '-5256', '0', '0', '47547', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '149712', '109832', '-5224', '0', '0', '58761', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '151106', '109330', '-5141', '0', '0', '63665', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '152419', '109321', '-5156', '0', '0', '33374', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '153190', '109434', '-5156', '0', '0', '4058', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '153746', '109180', '-5156', '0', '0', '53757', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '153707', '108545', '-5156', '0', '0', '48512', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '153250', '108870', '-5156', '0', '0', '26320', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '153087', '109131', '-5156', '0', '0', '22206', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '154452', '108499', '-5156', '0', '0', '6246', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '154586', '108283', '-5156', '0', '0', '62935', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '153531', '108400', '-5156', '0', '0', '18423', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '152929', '107862', '-5156', '0', '0', '3089', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '153463', '107631', '-5156', '0', '0', '61885', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '152415', '107565', '-5074', '0', '0', '32958', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '151841', '107542', '-4973', '0', '0', '17823', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '150570', '107325', '-4748', '0', '0', '33496', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '149811', '108163', '-4556', '0', '0', '23215', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '148593', '107957', '-4242', '0', '0', '40181', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '147627', '107335', '-4041', '0', '0', '31854', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '147086', '107610', '-3948', '0', '0', '55539', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '149318', '108479', '-4429', '0', '0', '31956', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '146702', '108177', '-3737', '0', '0', '48530', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '146420', '109043', '-3485', '0', '0', '16383', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '150055', '116872', '-3705', '0', '0', '43548', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '150334', '117269', '-3702', '0', '0', '9803', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '150179', '117198', '-3699', '0', '0', '41718', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '150664', '117731', '-3708', '0', '0', '8683', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '150841', '118022', '-3695', '0', '0', '43568', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '151515', '118400', '-3893', '0', '0', '4637', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '151882', '118854', '-3839', '0', '0', '12984', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '152336', '119115', '-3802', '0', '0', '1547', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '152313', '119378', '-3796', '0', '0', '17293', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '152197', '119487', '-3795', '0', '0', '24900', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '152109', '119241', '-3802', '0', '0', '50338', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '152995', '119367', '-3801', '0', '0', '2234', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '153569', '119226', '-3808', '0', '0', '63023', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '153836', '118916', '-3808', '0', '0', '56568', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '154070', '118566', '-3808', '0', '0', '55298', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '154230', '118940', '-3808', '0', '0', '12167', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '154029', '119175', '-3808', '0', '0', '23764', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '153007', '119507', '-3808', '0', '0', '35467', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '152869', '119868', '-3808', '0', '0', '30992', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '152471', '120140', '-3808', '0', '0', '25700', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '152136', '120341', '-3808', '0', '0', '27131', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '151909', '120963', '-3808', '0', '0', '18744', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '152361', '120483', '-3808', '0', '0', '41185', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '152001', '121455', '-3798', '0', '0', '16049', '60', '0', '0'),
('giran03_2221_H5', '1', '22843', '152225', '121700', '-3808', '0', '0', '8658', '60', '0', '0'),
('giran03_2221_H5', '1', '22844', '152334', '121971', '-3808', '0', '0', '11612', '60', '0', '0'),
('giran03_2221_H5', '1', '22839', '152706', '121786', '-3808', '0', '0', '9777', '60', '0', '0'),
('giran03_2221_H5', '1', '22840', '153409', '121697', '-3808', '0', '0', '64293', '60', '0', '0'),
('giran03_2221_H5', '1', '22842', '153001', '121856', '-3808', '0', '0', '64550', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '104043', '120622', '-3663', '0', '0', '56189', '60', '0', '0'),
('giran03_2221_H5', '1', '22824', '104758', '120315', '-3671', '0', '0', '61532', '60', '0', '0'),
('giran03_2221_H5', '1', '22822', '104302', '123719', '-3726', '0', '0', '15290', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '103220', '123864', '-3711', '0', '0', '33463', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '102605', '123478', '-3672', '0', '0', '39587', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '102146', '122678', '-3660', '0', '0', '43590', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '103816', '123838', '-3726', '0', '0', '10609', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '105112', '122249', '-3741', '0', '0', '59530', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '105823', '121133', '-3679', '0', '0', '51002', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '106701', '120341', '-3690', '0', '0', '59721', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '104611', '120961', '-3709', '0', '0', '30194', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '103445', '121670', '-3746', '0', '0', '27223', '60', '0', '0'),
('giran03_2221_H5', '1', '22827', '102467', '120617', '-3592', '0', '0', '45062', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '103258', '119818', '-3657', '0', '0', '59123', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '102706', '118736', '-3690', '0', '0', '42384', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '101217', '119485', '-3529', '0', '0', '27931', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '101212', '117126', '-3691', '0', '0', '28245', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '101417', '114859', '-3726', '0', '0', '21567', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '102320', '113610', '-3721', '0', '0', '55124', '60', '0', '0'),
('giran03_2221_H5', '1', '22837', '102612', '112672', '-3710', '0', '0', '58628', '60', '0', '0'),
('giran03_2221_H5', '1', '22836', '102781', '111867', '-3685', '0', '0', '50107', '60', '0', '0'),
('giran03_2221_H5', '1', '22862', '102931', '110998', '-3707', '0', '0', '58750', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '86210', '107268', '-3156', '0', '0', '45280', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '86973', '106990', '-3139', '0', '0', '60948', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '87588', '108224', '-3078', '0', '0', '11561', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '86522', '108463', '-3148', '0', '0', '27372', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '85962', '109104', '-3202', '0', '0', '26629', '60', '0', '0'),
('giran03_2221_H5', '1', '22815', '86122', '108207', '-3201', '0', '0', '52123', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '85508', '107985', '-3261', '0', '0', '31562', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '84676', '108224', '-3230', '0', '0', '34518', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '84676', '108224', '-3230', '0', '0', '34518', '60', '0', '0'),
('giran03_2221_H5', '1', '22858', '-114318', '-249558', '-2987', '0', '0', '47395', '60', '0', '0'),
('giran03_2221_H5', '1', '22860', '-113721', '-249152', '-2993', '0', '0', '13797', '60', '0', '0');

-- 拍照NPC傳送拍照位置
DELETE FROM `teleport` WHERE `id` IN (12098, 12099, 12100, 12101, 12102, 12103, 12104, 12105, 12106, 12107); 
REPLACE INTO `teleport` VALUES ('Photo Snow House', '12098', '-57530', '-54527', '-1581', '0', '0', '57'); -- NPCID 4317
REPLACE INTO `teleport` VALUES ('Photo Snow Parade Tunnel b', '12099', '-57628', '-53278', '-1688', '0', '0', '57'); -- NPCID 4318
REPLACE INTO `teleport` VALUES ('Photo Snow Tuba 4', '12100', '-55739', '-56319', '-1338', '0', '0', '57'); -- NPCID 4319 1
REPLACE INTO `teleport` VALUES ('Photo Snow Tuba 3', '12101', '-55640', '-56313', '-1302', '0', '0', '57'); -- NPCID 4319 2
REPLACE INTO `teleport` VALUES ('Photo Snow Tuba 2', '12102', '-55540', '-56310', '-1266', '0', '0', '57'); -- NPCID 4319 3
REPLACE INTO `teleport` VALUES ('Photo Snow Tuba 1', '12103', '-55349', '-56301', '-1118', '0', '0', '57'); -- NPCID 4319 4
REPLACE INTO `teleport` VALUES ('Photo Snow Parade Tunnel a', '12104', '-55256', '-58839', '-1690', '0', '0', '57'); -- NPCID 4320
REPLACE INTO `teleport` VALUES ('Photo Snow Book House', '12105', '-58955', '-59573', '-1468', '0', '0', '57'); -- NPCID 4321
REPLACE INTO `teleport` VALUES ('Photo Snow Book Castle', '12106', '-61937', '-59448', '-1713', '0', '0', '57'); -- NPCID 4322
REPLACE INTO `teleport` VALUES ('Photo Snow Clock Tower', '12107', '-61265', '-57686', '-1610', '0', '0', '57'); -- NPCID 4323

-- 增加任務 10292 人物
-- DELETE FROM `npc` WHERE `id` IN (32784,32862,27422,27424);
UPDATE `npc` SET `collision_radius`=10,`collision_height`=27.5,`level`=79,`sex`='female',`type`='L2Monster',`hp`=1050.81652,`mp`=531,`hpreg`=5.5,`mpreg`=2.1,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=0,`sp`=0,`patk`=198.34591,`pdef`=164.88513,`matk`=135.44454,`mdef`=109.782377202178,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=80,`runspd`=135,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=27422;
UPDATE `npc` SET `collision_radius`=16,`collision_height`=27.5,`level`=79,`sex`='male',`type`='L2Monster',`hp`=1094.28943,`mp`=557.4,`hpreg`=5.5,`mpreg`=2.1,`str`=40,`con`=43,`dex`=30,`int`=21,`wit`=20,`men`=20,`exp`=0,`sp`=0,`patk`=210.04832,`pdef`=169.13417,`matk`=143.43577,`mdef`=112.611442266143,`atkspd`=253,`critical`=4,`matkspd`=333,`rhand`=0,`lhand`=0,`enchant`=0,`walkspd`=140,`runspd`=170,`dropHerbGroup`=0,`basestats`=1 WHERE `id`=27424;

DELETE FROM `spawnlist` WHERE `npc_templateid` IN (32862);
REPLACE INTO `spawnlist` VALUES ('unset', '1', '32862', '43347', '-87923', '-2825', '0', '0', '37163', '10', '0', '0');

UPDATE `npc` SET `type` = 'L2Warehouse' WHERE `id` = 31226; -- 修正競技場監察官 NPC類型

-- 嗨翻天版本 修正任務 NPC類型
UPDATE npc SET type = 'L2Monster' WHERE id = 22766;
UPDATE npcaidata SET aggro = 300 WHERE npcId = 22766;
UPDATE npc SET type = 'L2QuestGuard' WHERE id = 18846;

-- 嗨翻天版本 修正任務 10285 NPC類型
UPDATE npcaidata SET clan='freya_show_friends', enemyClan = 'freya_show_foes' WHERE npcId = 22767;
UPDATE npcaidata SET clan='freya_show_foes', enemyClan = 'freya_show_friends' WHERE npcId IN (18848, 18849, 18926);
UPDATE npcaidata SET enemyRange = 2000 WHERE npcId IN (18848, 18849, 18926);
UPDATE npcaidata SET enemyRange = 500, clanRange = 500 WHERE npcId = 22767;

UPDATE npc SET type = 'L2Monster' WHERE id IN (18847, 18848, 18849, 18850, 18851, 18853, 18854, 18855, 18856, 18926, 18930, 22767);
UPDATE npcaidata SET aggro = 300 WHERE npcId IN (18847, 18930, 22767);