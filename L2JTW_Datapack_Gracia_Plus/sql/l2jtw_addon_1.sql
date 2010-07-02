/************ Made in Taiwan ************/

/************ 刪除自定的NPC ************/
DELETE FROM `spawnlist` WHERE `id` > 820000 AND `id` < 880000;


/************ 修正32007加爾巴-釣魚會員 ************/
INSERT INTO `spawnlist` VALUES ('820001', '', '1', '32007', '140967', '-123600', '-1905', '0', '0', '11829', '60', '0', '0');
UPDATE `npc` SET `type` = 'L2Fisherman' WHERE `id` IN (32007);
UPDATE `npc` SET `rhand` = '7560' WHERE `id` IN (32007);
REPLACE INTO `merchant_shopids` VALUES (3200700,32007);
DELETE FROM `merchant_buylists` WHERE shop_id IN (3200700);
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


/************ 增加頭飾的附加技能(祝福復活/祝福返回/大頭/煙火) ************/
UPDATE `armor` SET `skill` = '3263-1;' WHERE `item_id` IN (9177,9178,9179,9180,9181,9182,9183,10621,10625,10629);
UPDATE `armor` SET `skill` = '3264-1;' WHERE `item_id` IN (9184,9185,9186,9187,9188,9189,9190,10620,10624,10628,14753,14756,14759,14762);
UPDATE `armor` SET `skill` = '3265-1;' WHERE `item_id` IN (9191,9192,9193,9194,9195,9196,9197,10623,10627,10631,14754,14757,14760,14763);
UPDATE `armor` SET `skill` = '3266-1;' WHERE `item_id` IN (9198,9199,9200,9201,9202,9203,9204,9890,9891,9892,9893,9894,9895,9896,10622,10626,10630,14755,14758,14761,14764);
UPDATE `armor` SET `skill` = '21005-3;' WHERE `item_id` IN (20016);
UPDATE `armor` SET `skill` = '21006-1;21007-1;' WHERE `item_id` IN (20018);
UPDATE `armor` SET `skill` = '21004-1;' WHERE `item_id` IN (20019);


/************ 增加/修正/刪除NPC ************/
UPDATE `npc` SET `collision_radius` = '13.5', `collision_height` = '36.5' WHERE `id` IN (27323); -- 修正神的密使(任務怪物)
UPDATE `npc` SET `type` = 'L2VillageMaster' WHERE `id` IN (32191); -- 修正漢娜琳  宗師的NPC類型
UPDATE `npc` SET `type` = 'L2Adventurer' WHERE `id` IN (32074); -- 修正古魯丁分會長的NPC類型
UPDATE `npc` SET `type` = 'L2Npc', `collision_radius` = '9', `collision_height` = '16.5', `rhand` = '0' WHERE `id` IN (35417,35418); -- 修正地獄守門人
UPDATE `spawnlist` SET `npc_templateid` = '35440' WHERE `id` = 33771; -- 修正NPC ID:丹尼爾(根據地守門人)
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (30880,30881,30882,30883,30884,30885,30886,30887,30888,30889); -- 刪除不存在的NPC
UPDATE `droplist` SET `mobId` = '21070' WHERE `mobId` IN (21071); -- 封印大天使

-- 加入維他命管理者
REPLACE INTO `spawnlist` VALUES
('810001', '', '1', '32478', '17735', '169802', '-3495', '0', '0', '19465', '60', '0', '0'); -- 獵人村莊

-- 修正NPC位置
REPLACE INTO `spawnlist` VALUES
('33472', 'oren16_npc2218_016', '1', '31605', '85692', '16400', '-2803', '0', '0', '38000', '60', '0', '0'),   -- 金斯雷(象牙塔)
('33485', 'oren17_npc2219_009', '1', '30676', '81655', '54737', '-1509', '0', '0', '24576', '60', '0', '0'),   -- 庫羅普(歐瑞倉庫)
('33594', 'innadril09_npc2324_23', '1', '31092', '114486', '217413', '-3631', '0', '0', '0', '60', '0', '0'),  -- 財富的地下商人(水上都市海音斯)
('33613', 'aden17_npc2317_01', '1', '31675', '111186', '-13261', '-1702', '0', '0', '13828', '60', '0', '0'),  -- 維克特 馮 德伊克(國境守備隊隊長)
('33614', 'aden17_npc2317_02', '1', '31679', '111532', '-17238', '-1702', '0', '0', '49586', '60', '0', '0'),  -- 尤斯特斯 馮 伊森(邊境警備隊隊長)
('33628', 'aden17_npc2317_03', '1', '31677', '111532', '-13266', '-1704', '0', '0', '14508', '60', '0', '0'),  -- 國境守備隊員
('33635', 'aden17_npc2317_03', '1', '31677', '111178', '-17234', '-1702', '0', '0', '46468', '60', '0', '0'),  -- 國境守備隊員
('51231', 'schuttgart', '1', '30767', '85792', '-142809', '-1341', '0', '0', '10508', '60', '0', '0'),         -- 拍賣管理者(修加特城鎮)
('51232', 'schuttgart', '1', '35558', '89344', '-141591', '-1541', '0', '0', '64817', '60', '0', '0');         -- 莊園管理員(修加特城鎮)

-- 加入漏掉的NPC
INSERT INTO `spawnlist` VALUES
('820002', '', '1', '35644', '116178', '-181602', '-1365', '0', '0', '0', '60', '0', '0'),      -- 莊園管理員(矮人村莊)
('820003', '', '1', '35645', '-44159', '-112229', '-239', '0', '0', '39768', '60', '0', '0'),   -- 莊園管理員(半獸人村莊)
('820004', '', '1', '32321', '147271', '28647', '-2268', '0', '0', '53514', '60', '0', '0'),    -- 道具仲介商(亞丁城鎮)
('820005', '', '1', '32071', '84432', '-144032', '-1538', '0', '0', '8764', '60', '0', '0'),    -- 琳達(修加特城鎮)
('820006', '', '1', '31691', '86123', '-145764', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('820007', '', '1', '31691', '86123', '-145628', '-1295', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('820008', '', '1', '31691', '86123', '-145492', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('820009', '', '1', '31691', '86123', '-145356', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('820010', '', '1', '31691', '86123', '-145220', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('820011', '', '1', '31691', '86315', '-145764', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('820012', '', '1', '31691', '86315', '-145628', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('820013', '', '1', '31691', '86315', '-145492', '-1295', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('820014', '', '1', '31691', '86315', '-145356', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('820015', '', '1', '31691', '86315', '-145220', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('820016', '', '1', '32119', '23707', '-19108', '-2815', '0', '0', '37776', '60', '0', '0'),    -- 烏魯 凱莫
('820017', '', '1', '32120', '27716', '-11685', '-2281', '0', '0', '31470', '60', '0', '0'),    -- 巴魯 凱莫
('820018', '', '1', '32121', '18714', '-9635', '-2790', '0', '0', '54407', '60', '0', '0'),     -- 裘太 凱莫
('820019', '', '1', '32109', '23666', '-7144', '-1134', '0', '0', '46433', '60', '0', '0'),     -- 席琳聖像
('820020', '', '1', '35601', '141085', '-124316', '-1868', '0', '0', '44789', '60', '0', '0'),  -- 守門人(虹彩泉根據地)
('820021', '', '1', '35601', '141152', '-124272', '-1864', '0', '0', '10000', '60', '0', '0'),  -- 守門人(虹彩泉根據地)
('820022', '', '1', '35602', '140704', '-124020', '-1904', '0', '0', '34000', '60', '0', '0'),  -- 守門人(虹彩泉根據地)
('820023', '', '1', '35602', '140732', '-123796', '-1904', '0', '0', '2000', '60', '0', '0'),   -- 守門人(虹彩泉根據地)
('820024', '', '1', '35603', '152924', '-126604', '-2304', '0', '0', '33000', '60', '0', '0'),  -- 入場管理員(虹彩泉根據地)
('820025', '', '1', '35604', '143944', '-119196', '-2136', '0', '0', '1000', '60', '0', '0'),   -- 傳令(虹彩泉根據地)
('820026', '', '1', '35605', '140824', '-124844', '-1864', '0', '0', '10000', '60', '0', '0'),  -- 安格特 執事(虹彩泉根據地)
('820027', '', '1', '35623', '59884', '-94204', '-1344', '0', '0', '27000', '60', '0', '0'),    -- 內城守門人(野獸農莊根據地)
('820028', '', '1', '35624', '59920', '-94336', '-1344', '0', '0', '60000', '60', '0', '0'),    -- 內城守門人(野獸農莊根據地)
('820029', '', '1', '35625', '55184', '-93040', '-1360', '0', '0', '35000', '60', '0', '0'),    -- 外城守門人(野獸農莊根據地)
('820030', '', '1', '35626', '55400', '-93008', '-1360', '0', '0', '30000', '60', '0', '0'),    -- 外城守門人(野獸農莊根據地)
('820031', '', '1', '35627', '53508', '-93776', '-1584', '0', '0', '36000', '60', '0', '0'),    -- 傳令(野獸農莊根據地)
('820032', '', '1', '35628', '60880', '-94320', '-1344', '0', '0', '27000', '60', '0', '0'),    -- 奎比亞 農場管理員(野獸農莊根據地)
('820033', '', '1', '35638', '56736', '-26400', '568', '0', '0', '49000', '60', '0', '0'),      -- 巴倫斯 飛龍管理員
('820034', '', '1', '35639', '58128', '-32000', '296', '0', '0', '0', '60', '0', '0'),          -- 傑卡德 傳令
('820035', '', '1', '35640', '58024', '-25744', '592', '0', '0', '49000', '60', '0', '0'),      -- 凡德羅 執事
('820036', '', '1', '35641', '58080', '-29552', '568', '0', '0', '49000', '60', '0', '0'),      -- 要塞守門人
('820037', '', '1', '35641', '58137', '-29223', '568', '0', '0', '16500', '60', '0', '0'),      -- 要塞守門人
('820038', '', '1', '35642', '58024', '-26456', '592', '0', '0', '49000', '60', '0', '0'),      -- 要塞守門人
('820039', '', '1', '35642', '58074', '-26325', '597', '0', '0', '15732', '60', '0', '0');      -- 要塞守門人

-- 加入地下競技場的入場管理員
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (32377); -- 刪除地下競技場重複的入場管理員
UPDATE `npc` SET `type` = 'L2Teleporter' WHERE `id` IN (32503); -- 入場管理員 柯雷塔的晶體
INSERT INTO `spawnlist` VALUES
('830001', '', '1', '32491', '-82166', '-49176', '-10341', '0', '0', '31175', '60', '0', '0'),  -- 地下競技場助手
('830002', '', '1', '32503', '-70661', '-71066', '-1419', '0', '0', '49151', '60', '0', '0'),   -- 入場管理員 柯雷塔的晶體
('830003', '', '1', '32513', '-84640', '-45360', '-10728', '0', '0', '56156', '60', '0', '0'),  -- 孔     入場管理員
('830004', '', '1', '32514', '-77408', '-50656', '-10728', '0', '0', '29664', '60', '0', '0'),  -- 塔里翁 入場管理員
('830005', '', '1', '32515', '-81904', '-53904', '-10728', '0', '0', '17044', '60', '0', '0'),  -- 利歐   入場管理員
('830006', '', '1', '32516', '-86359', '-50593', '-10728', '0', '0', '3704', '60', '0', '0'),   -- 康丁斯 入場管理員
('830007', '', '1', '32377', '-79117', '-45433', '-10731', '0', '0', '40959', '60', '0', '0');  -- 庫朗   入場管理員

-- 加入移動到柯雷塔的晶體/各等級的地下競技場外面
REPLACE INTO `teleport` VALUES
('Fantasy Isle -> Underground Coliseum', '12060', '-82271', '-49196', '-10352', '0', '0', '57'),
('Underground Coliseum -> Underground Coliseum LV40', '3249140', '-84451', '-45452', '-10728', '0', '0', '57'),
('Underground Coliseum -> Underground Coliseum LV50', '3249150', '-86154', '-50429', '-10728', '0', '0', '57'),
('Underground Coliseum -> Underground Coliseum LV60', '3249160', '-82009', '-53652', '-10728', '0', '0', '57'),
('Underground Coliseum -> Underground Coliseum LV70', '3249170', '-77586', '-50503', '-10728', '0', '0', '57'),
('Underground Coliseum -> Underground Coliseum LV00', '3249100', '-79309', '-45561', '-10728', '0', '0', '57');

-- 加入地獄邊界的NPC (感謝 pmq 提供)
REPLACE INTO spawnlist VALUES
('850001', '', 1, 18466, 4681, 243922, -1930, 0, 0, 37373, 10, 0, 0),    -- 外廓警衛隊長
('850002', '', 1, 22326, -23961, 245615, -3138, 0, 0, 129600, 10, 0, 0), -- 海琳納克
('850003', '', 1, 32344, 13278, 282253, -9705, 0, 0, 49686, 10, 0, 0),   -- 陰沉碑石
('850004', '', 1, 32302, 13219, 282021, -7547, 0, 0, 50484, 10, 0, 0),   -- 塞良
('850005', '', 1, 32373, 17938, 283202, -9700, 0, 0, 9914, 10, 0, 0);    -- 多利安

REPLACE INTO `npc` VALUES
(22326, 22326, 'Hellinark', 0, 'Guardian of Naia', 0, 'LineageMonster.karik', 19.00, 90.00, 84, 'male', 'L2Monster', 60, 465488, 4355, 202.00, 10.00, 64, 66, 68, 62, 61, 58, 2629657, 267913, 28564, 3856, 12487, 5647, 590, 0, 3819, 0, 0, 0, 0, 40, 290, 0, 13, 'FULL_PARTY', 'false'),
(32362, 32362, 'Hellbound Native', 0, '', 0, 'LineageNPC.a_common_peopleC_Mhuman', 8.00, 23.50, 1, 'male', 'L2Npc', 40, 2444, 2444, 0.00, 0.00, 10, 10, 10, 10, 10, 10, 0, 0, 500, 500, 500, 500, 253, 0, 253, 0, 0, 0, 0, 80, 120, 0, 0, 'LAST_HIT', 'false');
REPLACE INTO `minions` VALUES (22448, 22451, 2, 2); -- 雷歐達斯 反抗軍指揮官
REPLACE INTO `minions` VALUES (22449, 22450, 8, 8); -- 亞邁士康里 拷問專家

                                  
/************ 修正BOSS ************/
REPLACE INTO `grandboss_data` VALUES
(29001, -21610, 181594, -5734, 0, 0, 152622, 334, 0),          -- 巨蟻女王
(29006, 17726, 108915, -6480, 0, 0, 413252, 1897, 0),          -- 核心
(29014, 55024, 17368, -5412, 10126, 0, 413252, 1897, 0),       -- 奧爾芬
(29019, 181323, 114850, -7618, 32542, 0, 13090000, 39960, 0),  -- 安塔瑞斯
(29020, 116067, 17484, 10110, 41740, 0, 3698520, 39960, 0),    -- 巴溫
(29022, 55312, 219168, -3223, 0, 0, 569941, 199800, 0),        -- 札肯
(29028, 212852, -114842, -1632, 833, 0, 16660000, 39960, 0),   -- 巴拉卡斯
(29065, -123348, -248881, -15537, 44732, 0, 1532678, 4255, 0), -- 賽爾蘭
(29099, 153569, 142075, -12732, 60025, 0, 1448567, 3718, 0);   -- 巴爾勒
UPDATE `npc` SET `aggro` = 500 WHERE `id` IN (29020,29022,29065);
UPDATE `npc` SET `aggro` = 800 WHERE `id` IN (29019,29028);
UPDATE `npc` SET `hp` = '13090000', `mp` = '39960' WHERE `id` IN (29019);
UPDATE `npc` SET `hp` = '3698520', `mp` = '39960' WHERE `id` IN (29020);
UPDATE `npc` SET `hp` = '16660000', `mp` = '39960' WHERE `id` IN (29028);
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
(29020,4127,1),
(29020,4128,1),
(29020,4129,1),
(29020,4130,1),
(29020,4131,1),
(29020,4256,1),
(29021,4133,1),
(29022,4216,1),
(29022,4217,1),
(29022,4218,1),
(29022,4219,1),
(29022,4220,1),
(29022,4221,1),
(29022,4222,1),
(29022,4223,1),
(29022,4224,1),
(29022,4227,1),
(29022,4242,1),
(29022,4258,1),
(29028,4679,1),
(29028,4681,1),
(29028,4682,1),
(29028,4683,1),
(29028,4684,1),
(29028,4685,1),
(29028,4688,1),
(29028,4689,1),
(29028,4690,1),
(29099,4298,1),
(29099,4422,5),
(29099,4789,1),
(29100,4305,1),
(25532,733,1),
(25532,734,1),
(25532,4418,5),
(25534,4419,5);


/************ 修正芙琳泰沙 ************/
REPLACE INTO `grandboss_data` VALUES (29045, 0, 0, 0, 0, 0, 0, 0, 0);
REPLACE INTO `npc` VALUES ('18328', '18328', 'Hall Alarm Device', '0', '', '0', 'NPC.grave_keeper_key', '8.00', '21.00', '80', 'male', 'L2Monster', '80', '1264000', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '0', '333', '0', '0', '0', '0', '0', '0', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('18329', '18329', 'Hall Keeper Captain', '0', '', '0', 'Monster.death_lord', '21.00', '40.00', '80', 'male', 'L2Monster', '80', '23582', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '78', '0', '0', '0', '88', '132', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('18330', '18330', 'Hall Keeper Wizard', '0', '', '0', 'Monster.vale_master', '12.00', '40.00', '80', 'male', 'L2Monster', '80', '18203', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '326', '0', '0', '0', '88', '132', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('18331', '18331', 'Hall Keeper Guard', '0', '', '0', 'Monster.death_knight', '12.00', '29.00', '80', 'male', 'L2Monster', '80', '18655', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '142', '0', '0', '0', '88', '132', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('18332', '18332', 'Hall Keeper Patrol', '0', '', '0', 'Monster.headless_knight', '21.00', '31.00', '80', 'male', 'L2Monster', '80', '18434', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '70', '0', '0', '0', '88', '132', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('18333', '18333', 'Hall Keeper Suicidal Soldier', '0', '', '0', 'Monster3.self_blaster', '20.00', '23.00', '80', 'male', 'L2Monster', '80', '18203', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '0', '0', '0', '0', '88', '132', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('18334', '18334', 'Dark Choir Captain', '0', '', '0', 'Monster2.erinyes_cmd', '21.00', '50.00', '85', 'male', 'L2Monster', '80', '24069', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '0', '333', '0', '0', '0', '0', '0', '0', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('18335', '18335', 'Dark Choir Prima Donna', '0', '', '0', 'Monster3.portrait_spirit', '11.00', '30.00', '80', 'male', 'L2Monster', '80', '18655', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '0', '0', '0', '0', '88', '132', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('18336', '18336', 'Dark Choir Lancer', '0', '', '0', 'Monster.death_blader', '15.00', '45.00', '80', 'male', 'L2Monster', '80', '18655', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '1472', '0', '0', '0', '88', '132', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('18337', '18337', 'Dark Choir Archer', '0', '', '0', 'Monster.skeleton_archer_20_bi', '13.00', '33.00', '80', 'male', 'L2Monster', '80', '18655', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '279', '0', '0', '0', '88', '132', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('18338', '18338', 'Dark Choir Witch Doctor', '0', '', '0', 'Monster3.portrait_spirit_winged', '11.00', '30.00', '80', 'male', 'L2Monster', '80', '13991', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '0', '0', '0', '0', '88', '132', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('18339', '18339', 'Dark Choir Player', '0', '', '0', 'Monster.skeleton', '11.00', '25.00', '80', 'male', 'L2Monster', '80', '18203', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '0', '333', '148', '103', '0', '0', '88', '132', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('29045', '29045', 'Frintezza', '0', '', '0', 'Monster3.frintessa', '10.00', '42.00', '90', 'male', 'L2GrandBoss', '0', '23480000', '22197', '830.62', '3.09', '40', '43', '30', '21', '20', '10', '0', '0', '9182', '6214', '7133', '4191', '253', '0', '333', '0', '0', '0', '0', '1', '1', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('29046', '29046', 'Scarlet van Halisha', '0', '', '0', 'Monster3.follower_of_frintessa', '29.00', '90.00', '85', 'male', 'L2GrandBoss', '50', '23480000', '22393', '823.48', '2.65', '60', '57', '73', '76', '70', '80', '0', '0', '10699', '5036', '5212', '4191', '278', '6000', '3819', '8204', '0', '0', '0', '55', '132', '0', '0', 'FULL_PARTY', 'false');
REPLACE INTO `npc` VALUES ('29047', '29047', 'Scarlet van Halisha', '0', '', '0', 'Monster3.follower_of_frintessa_tran', '29.00', '110.00', '90', 'male', 'L2GrandBoss', '60', '23480000', '22393', '830.62', '3.09', '70', '67', '73', '79', '70', '80', '496960259', '40375148', '23813', '7000', '12680', '6238', '409', '6000', '3819', '8222', '0', '0', '0', '92', '187', '0', '14', 'FULL_PARTY', 'false');
REPLACE INTO `npc` VALUES ('29048', '29048', 'Evil Spirit', '0', '', '0', 'Monster3.Evilate', '20.00', '56.00', '87', 'male', 'L2Monster', '70', '350000', '9999', '414.12', '3.09', '40', '43', '30', '21', '20', '10', '30', '2', '9000', '2350', '7133', '2045', '253', '6000', '333', '0', '0', '0', '0', '0', '0', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('29049', '29049', 'Evil Spirit', '0', '', '0', 'Monster3.Evilate', '20.00', '56.00', '87', 'male', 'L2Monster', '70', '350000', '9999', '414.12', '3.09', '40', '43', '30', '21', '20', '10', '30', '2', '9000', '2350', '7133', '2045', '253', '6000', '333', '0', '0', '0', '0', '0', '0', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('29050', '29050', 'Breath of Halisha', '0', '', '0', 'Monster3.portrait_spirit', '10.00', '20.00', '85', 'male', 'L2Monster', '40', '350000', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '30', '2', '9000', '2350', '7133', '2045', '253', '6000', '333', '0', '0', '0', '0', '55', '66', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('29051', '29051', 'Breath of Halisha', '0', '', '0', 'Monster3.portrait_spirit_winged', '10.00', '20.00', '85', 'male', 'L2Monster', '40', '350000', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '30', '2', '9000', '2350', '7133', '2045', '253', '6000', '333', '0', '0', '0', '0', '55', '66', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('29052', '29052', '', '0', '', '0', 'Monster3.Organ_Dummy', '1.00', '1.00', '99', 'male', 'L2Npc', '40', '400000', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '0', '0', '9000', '5000', '6000', '6000', '300', '0', '333', '0', '0', '0', '0', '88', '132', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('29053', '29053', '', '0', '', '0', 'Monster3.Follower_Dummy', '1.00', '1.00', '99', 'male', 'L2Npc', '40', '400000', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '0', '0', '9000', '5000', '6000', '6000', '300', '0', '333', '0', '0', '0', '0', '88', '132', '0', '0', 'LAST_HIT', 'false');
REPLACE INTO `npc` VALUES ('29061', '29061', 'Teleportation Cubic', '0', '', '0', 'NPC.teleport_npc_frin', '40.00', '80.00', '70', 'male', 'L2Teleporter', '40', '2444', '2444', '0.00', '0.00', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '278', '0', '333', '0', '0', '0', '0', '88', '132', '0', '0', 'LAST_HIT', 'false');
DELETE FROM `npcskills` Where `skillid` IN (5014,5015,5016,5017,5018,5019);
REPLACE INTO `npcskills` VALUES
(29050,5010,1),
(29050,5013,1),
(29051,5009,1),
(29051,5013,1);
DELETE FROM `zone_vertices` WHERE `id` IN (12011);
REPLACE INTO `zone_vertices` (`id`,`order`,`x`,`y`) VALUES
(12011,0,172229,-74350),
(12011,1,176241,-90230);


/************ 其他修正 ************/
-- 修正傳送到不同的房間挑戰莉莉絲/亞納
REPLACE INTO `teleport` VALUES
('Disciples Necropolis -> Anakim',449,184467,-13102,-5500,0,0,57),
('Disciples Necropolis -> Lilith',450,184448,-10120,-5500,0,0,57);

-- 修正攻城時間
ALTER TABLE `castle` DROP PRIMARY KEY, ADD PRIMARY KEY (`id`);
UPDATE `castle` SET `siegeDate` = '978782400000' WHERE `siegeDate` = '0' AND `id` IN (1,2,5,8,9);
UPDATE `castle` SET `siegeDate` = '979459200000' WHERE `siegeDate` = '0' AND `id` IN (3,4,6,7);

-- 修正奇岩港口的傳送價格
UPDATE `teleport` SET `price` = '5200' WHERE `id` IN (63);
UPDATE `teleport` SET `price` = '7100' WHERE `id` IN (107);

-- 修正獵捕石的道具類型
UPDATE `etcitem` SET `item_type` = 'none' WHERE `item_id` IN (8764);

-- 修正價格
UPDATE `etcitem` SET `price` = '1550000' WHERE `item_id` = '729';  -- 武器強化卷軸-A級
UPDATE `etcitem` SET `price` = '2250000' WHERE `item_id` = '959';  -- 武器強化卷軸-S級
UPDATE `etcitem` SET `price` = '2700000' WHERE `item_id` = '6569'; -- 祝福的武器強化卷軸-A級
UPDATE `etcitem` SET `price` = '5000000' WHERE `item_id` = '6577'; -- 祝福的武器強化卷軸-S級

-- 修正首領重生時，HP/MP全滿 (感謝 wolo 提供)
Update `npc`, `raidboss_spawnlist` SET `raidboss_spawnlist`.`heading`=0, `raidboss_spawnlist`.`currentHp`=`npc`.`hp`,`raidboss_spawnlist`.`currentMp`=`npc`.`mp` WHERE `npc`.`type`='L2RaidBoss' AND `npc`.`id`=`raidboss_spawnlist`.`boss_id`;

-- 修正根據地投標價
UPDATE `auction` SET `startingBid` = '20000000' WHERE `id` IN (58,59,60,61) AND `sellerId` = '0';

-- 修正武器
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


/************ 加入破滅國境的道具 ************/
-- 新頭飾
DELETE FROM `etcitem` WHERE `item_id` IN (20497,20498); -- 母親的花環 (L2J錯誤設定為etcitem)
REPLACE INTO `armor` VALUES
(20497,'Mother\'s Wreath - Event Blessing of Love - 24 hours limited period','','hairall','false','none',120,'wood','none',0,-1,1440,0,0,0,0,0,'false','false','true','false','true','0-0','21086-1;'), -- 母親的花環-活動 愛的祝福(限時24小時)
(20498,'Mother\'s Wreath Blessing of Love - 3 day limited period','','hairall','false','none',120,'wood','none',0,-1,4320,0,0,0,0,0,'false','false','true','false','true','0-0','21086-1;'); -- 母親的花環-活動 愛的祝福(限時3日)

-- 修正NPC
UPDATE `npc` SET `type` = 'L2Npc' WHERE `id` IN (32628,32629); -- 碼頭巡邏兵的類型改為一般NPC
UPDATE `npc` SET `type` = 'L2Teleporter' WHERE `id` IN (32540,32542,32602); -- 深淵的守門人/安定的再生種子/臨時傳送師的類型改為傳送
UPDATE `spawnlist` SET `heading` = '16383' WHERE `npc_templateid` = '32609' AND `heading` = '20771'; -- 修正飛空艇控制裝置的面向

-- 新傳送
REPLACE INTO `teleport` VALUES
('3254001', '3260203', '-212836', '209824', '4288', '0', '0', '57'),   -- 深淵的守門人
('3260201', '3260201', '-245833', '220174', '-12104', '0', '0', '57'), -- 臨時傳送師
('3260202', '3260202', '-251624', '213420', '-12072', '0', '0', '57'), -- 臨時傳送師
('3260203', '3260203', '-249774', '207316', '-11952', '0', '0', '57'); -- 臨時傳送師

-- NPC改成AI控制
Delete From `spawnlist` Where `npc_templateid` in (32549,32619,32628,32629); -- 狄里歐斯/刺槍兵/碼頭巡邏兵

-- 防具修正
UPDATE `armor` SET `armor_type` = 'heavy' WHERE `item_id` IN (9821,9831,10019,10020); -- 幻象裝備-盟誓盔甲/進階型阿貝拉盔甲/鎖子胸甲/鋼鐵脛甲
UPDATE `armor` SET `armor_type` = 'light' WHERE `item_id` IN (9824,9834,10021,10022); -- 幻象裝備-盟誓禮服/進階型阿貝拉禮服/水晶獅皮襯衫/水晶獅皮脛甲
UPDATE `armor` SET `armor_type` = 'magic' WHERE `item_id` IN (9827,9837,10023,10024); -- 幻象裝備-盟誓長袍/進階型阿貝拉長袍/受詛咒的外衣/受詛咒的長襪
UPDATE `armor` SET `time` = 0 WHERE `item_id` IN (20098); -- 禮服-活動 1小時幻象
UPDATE `armor` SET `time` = 43200 WHERE `item_id` IN (13544,13545); -- 壺精召喚手鐲-男生泰迪熊/壺精召喚手鐲-女生泰迪熊
UPDATE `armor` SET `time` = 43200 WHERE `item_id` IN (20503,20504); -- 黃鬃獅子/蒸汽甲蟲騎乘手鐲 限時30日 (L2J錯誤設定為etcitem)
UPDATE `armor` SET `duration` = 360 WHERE `item_id` IN (14753,14754,14755,14756,14757,14758,14759,14760,14761,14762,14763,14764); -- 幻象裝備

-- 武器修正
UPDATE `weapon` SET `bodypart` = 'rhand' WHERE `item_id` IN (13556,13557,20114,20126,20128,20140,20142,20154,20156,20168,20170,20258,20264); -- 飛空艇操控舵/飛空艇大砲/祭司釘鎚-活動/夜叉釘鎚-活動/月蝕斧-活動/工藝戰斧-活動/卡倚巴奴之骨-活動/樂園-活動/火龍之首-活動/玄武岩戰鎚-活動/祕儀權杖-活動/法國麵包吐司鎚/法國麵包香郁/
UPDATE `weapon` SET `bodypart` = 'lrhand', `weaponType` = 'bigblunt' WHERE `item_id` IN (9819,13530,13531,13532,13533,13534,13535,13536,13537,13538);  -- 鬥爭旗幟/古魯丁旗幟/狄恩旗幟/奇岩旗幟/歐瑞旗幟/亞丁旗幟/因納得立旗幟/高達特旗幟/魯因旗幟/修加特旗幟
UPDATE `weapon` SET `bodypart` = 'lrhand', `weaponType` = 'bigblunt' WHERE `item_id` IN (13539,13560,13561,13562,13563,13564,13565,13566,13567,13568);  -- 大師余義的魔杖/古魯丁 守護之物/狄恩 守護之物/奇岩 守護之物/歐瑞 守護之物/亞丁 守護之物/因納得立 守護之物/高達特 守護之物/魯因 守護之物/修加特 守護之物
UPDATE `weapon` SET `bodypart` = 'lrhand', `weaponType` = 'bigblunt' WHERE `item_id` IN (13809,13981); -- 宮廷魔法師的魔法棒/怪物用(龍馬軍戰鬥兵)
UPDATE `weapon` SET `weaponType` = 'none' WHERE `item_id` IN (13525); -- 格勒西亞士兵盾牌

-- 其他物品修正
Delete From `items` Where (`item_id` > 708 and `item_id` < 725); -- 和防具同名稱的其他物品
UPDATE `etcitem` SET `consume_type` = 'normal' WHERE `item_id` IN (731,732,949,950,953,954,957,958,961,962); -- 武器強化結晶卷軸/防具強化結晶卷軸
UPDATE `etcitem` SET `consume_type` = 'normal' WHERE `item_id` IN (10117,10118); -- 渾沌的封印的王朝符印/渾沌的 王朝符印
UPDATE `etcitem` SET `consume_type` = 'normal' WHERE `item_id` IN (10414,10607,13382); -- 壺精交換券/壺精封印手鐲-麋鹿/格蘭肯的禮盒-活動用
UPDATE `etcitem` SET `consume_type` = 'stackable' WHERE `item_id` IN (13420,13421,20025,20026,20027,20028,20033); -- 點心/蛋糕/自由傳送卷軸/追加入場券-欲界(深淵之廳)/追加入場券-近緣欲界/追加入場券-欲界(深淵迷宮)/自由傳送旗
UPDATE `etcitem` SET `time` = 1440 WHERE `item_id` IN (20320); -- 生日蛋糕
UPDATE `etcitem` SET `time` = 10080 WHERE `item_id` IN (20339,20340,20345,20346,20351,20352); -- 經驗值古文/SP古文/結晶型古文
UPDATE `etcitem` SET `time` = 21600 WHERE `item_id` IN (20190); -- 情人節裝飾品
UPDATE `etcitem` SET `time` = 43200 WHERE `item_id` IN (13027,14728,20199); -- 格蘭肯的禮盒/活動-礦石晶體/夢幻的情人節蛋糕

-- 增加物品效果
UPDATE `armor` SET `skill` = '3407-1;' WHERE `item_id` = '9900';                               -- 靜音之步戒指
UPDATE `etcitem` SET `skill` = '2309-1;', `handler` = 'ItemSkills' WHERE `item_id` = '9144';   -- 豬豬禮盒
UPDATE `etcitem` SET `skill` = '2422-1;', `handler` = 'ItemSkills' WHERE `item_id` = '10254';  -- 1級寶袋
UPDATE `etcitem` SET `skill` = '2423-2;', `handler` = 'ItemSkills' WHERE `item_id` = '10255';  -- 2級寶袋
UPDATE `etcitem` SET `skill` = '2424-3;', `handler` = 'ItemSkills' WHERE `item_id` = '10256';  -- 3級寶袋
UPDATE `etcitem` SET `skill` = '2425-4;', `handler` = 'ItemSkills' WHERE `item_id` = '10257';  -- 4級寶袋
UPDATE `etcitem` SET `skill` = '2426-5;', `handler` = 'ItemSkills' WHERE `item_id` = '10258';  -- 5級寶袋
UPDATE `etcitem` SET `skill` = '2427-6;', `handler` = 'ItemSkills' WHERE `item_id` = '10259';  -- 6級寶袋
UPDATE `etcitem` SET `skill` = '2487-1;', `handler` = 'ItemSkills' WHERE `item_id` = '10520';  -- 回聲水晶-倉木麻衣
UPDATE `etcitem` SET `skill` = '2670-1;', `handler` = 'ItemSkills' WHERE `item_id` = '13794';  -- 變身體-翻滾方塊變身卷軸
UPDATE `etcitem` SET `skill` = '2671-1;', `handler` = 'ItemSkills' WHERE `item_id` = '13795';  -- 變身體-翻滾方塊變身卷軸
UPDATE `etcitem` SET `skill` = '2631-1;', `handler` = 'ItemSkills' WHERE `item_id` = '13800';  -- 青蛙變身卷軸
UPDATE `etcitem` SET `skill` = '2632-1;', `handler` = 'ItemSkills' WHERE `item_id` = '13801';  -- 小孩變身卷軸

-- 刪除魔法書商人
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (30840,31262,31413,31414,31415,31416,31417,31421,31422,31423,31424,31425,31426,31427,31429,31430,31431,31666,31667,31670,31951,31973,31980);
DELETE FROM `merchant_buylists` WHERE `shop_id` IN ( SELECT `shop_id` FROM `merchant_shopids` WHERE `npc_id` IN (30840,31262,31413,31414,31415,31416,31417,31421,31422,31423,31424,31425,31426,31427,31429,31430,31431,31666,31667,31670,31951,31973,31980));
DELETE FROM `merchant_shopids` WHERE `npc_id` IN (30840,31262,31413,31414,31415,31416,31417,31421,31422,31423,31424,31425,31426,31427,31429,31430,31431,31666,31667,31670,31951,31973,31980);

-- 刪除彩券商人
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (30990,30994) AND `id` NOT IN (45033);

-- 刪除其中一隻轉職管理員
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (31756);
-- DELETE FROM `spawnlist` WHERE `npc_templateid` IN (31757);

-- 修正/更新任務128 菲拉卡-冰與火之歌
UPDATE `etcitem` SET `skill` = '2150-1;', `handler` = 'SoulShots', `item_type` = 'shot', `crystal_type` = 'd' WHERE `item_id` = 13037;
UPDATE `etcitem` SET `skill` = '2153-1;', `handler` = 'SoulShots', `item_type` = 'shot', `crystal_type` = 'a' WHERE `item_id` = 13045;
UPDATE `etcitem` SET `skill` = '2153-1;', `handler` = 'SoulShots', `item_type` = 'shot', `crystal_type` = 'a' WHERE `item_id` = 13055;
UPDATE `weapon` SET `skill` = '0-0;' WHERE `item_id` = 13042;
UPDATE `npc` SET `collision_radius` = 28, `collision_height` = 20, `level` = 61, `hp` = 3450, `mp` = 1365, `patk` = 991, `pdef` = 415, `matk` = 504, `mdef` = 388, `runspd` = 187 WHERE `id` = 14916;
UPDATE `npc` SET `collision_radius` = 28, `collision_height` = 20, `level` = 70, `hp` = 4025, `mp` = 1592, `patk` = 1156, `pdef` = 484, `matk` = 588, `mdef` = 452, `runspd` = 187 WHERE `id` = 14917;

DELETE FROM `accounts` WHERE `login` = 'l2jtwdev';
DELETE FROM `characters` WHERE `account_name` = 'l2jtwdev';


/************ CT 2.5 聖翼使命修正 ************/
-- 斗篷改為通用,不再分重/輕/法/闇天使
UPDATE `items` SET `item_id` = 13687 WHERE `item_id` IN (13688,13689,13690); -- 輕/法/闇天使的騎士斗篷改通用斗篷
UPDATE `items` SET `item_id` = 13890 WHERE `item_id` IN (13889,13891,13892); -- 輕/法/闇天使的聖靈斗篷改通用斗篷
UPDATE `items` SET `item_id` = 14609 WHERE `item_id` IN (14601,14602,14608,14610); -- 輕/法/闇天使的古代斗篷改通用斗篷
DELETE FROM `merchant_buylists` WHERE `item_id` IN (13688,13689,13690,13889,13891,13892,14601,14602,14608,14610); -- 刪除輕/法/闇天使的斗篷的販賣

-- 新傳送
REPLACE INTO `teleport` VALUES
('3265201', '3265201', '175499', '-181586', '-904', '0', '0', '57'); -- 往米索莉礦山的傳送水晶

-- 新頭飾
UPDATE `armor` SET `skill` = '21090-1;' WHERE `item_id` = 20601;         -- 回魂帽
UPDATE `armor` SET `skill` = '21092-1;' WHERE `item_id` = 20613;         -- 耳機
UPDATE `armor` SET `skill` = '21093-1;' WHERE `item_id` = 20614;         -- 耳機
UPDATE `armor` SET `skill` = '21094-1;' WHERE `item_id` = 20615;         -- 耳機
UPDATE `armor` SET `skill` = '21092-1;21111-1;' WHERE `item_id` = 20616; -- 耳機
UPDATE `armor` SET `skill` = '21093-1;21112-1;' WHERE `item_id` = 20617; -- 耳機
UPDATE `armor` SET `skill` = '21094-1;21113-1;' WHERE `item_id` = 20618; -- 耳機
UPDATE `armor` SET `skill` = '21095-1;' WHERE `item_id` = 20626;         -- 回魂帽
UPDATE `armor` SET `skill` = '21096-1;' WHERE `item_id` = 20633;         -- 西瓜帽
UPDATE `armor` SET `skill` = '21098-1;' WHERE `item_id` = 20667;         -- 女武神帽
UPDATE `armor` SET `skill` = '21099-1;' WHERE `item_id` = 20669;         -- 老虎帽
UPDATE `armor` SET `skill` = '21100-1;' WHERE `item_id` = 20671;         -- 女僕髮飾
UPDATE `armor` SET `skill` = '21101-1;' WHERE `item_id` = 20673;         -- 寶寶貓熊帽
UPDATE `armor` SET `skill` = '21103-1;' WHERE `item_id` = 20675;         -- 團團貓熊帽
UPDATE `armor` SET `skill` = '21102-1;' WHERE `item_id` = 20677;         -- 圓圓貓熊帽
UPDATE `armor` SET `skill` = '21104-1;' WHERE `item_id` = 20679;         -- 守門人帽
UPDATE `armor` SET `skill` = '21120-1;' WHERE `item_id` = 20711;         -- 傑克南瓜面具-活動
UPDATE `armor` SET `skill` = '21120-1;' WHERE `item_id` = 20723;         -- 黃金傑克南瓜面具
UPDATE `armor` SET `skill` = '21120-1;21136-1;' WHERE `item_id` = 20724; -- 黃金傑克南瓜面具
UPDATE `armor` SET `skill` = '21137-1;' WHERE `item_id` = 20743;         -- 閃耀的科學怪人面具
UPDATE `armor` SET `skill` = '21138-1;' WHERE `item_id` = 20744;         -- 閃耀的驚聲尖叫面具
UPDATE `armor` SET `skill` = '21139-1;' WHERE `item_id` = 20745;         -- 閃耀的憤怒精靈面具
UPDATE `armor` SET `skill` = '21140-1;' WHERE `item_id` = 20746;         -- 閃耀的不朽骸骨面具
UPDATE `armor` SET `skill` = '21141-1;' WHERE `item_id` = 20747;         -- 閃耀的X235行星面具
UPDATE `armor` SET `skill` = '21152-1;' WHERE `item_id` = 20789;         -- 火箭炮帽

-- 新手鐲
UPDATE `armor` SET `bodypart` = 'lbracelet', `skill` = '8358-1;3267-1;' WHERE `item_id` = 15351;                           -- 封印解除手鐲-托貝
UPDATE `armor` SET `bodypart` = 'lbracelet' WHERE `item_id` IN (20658,20659);                                              -- 壺精封印手鐲-舞動幸運兒
UPDATE `armor` SET `skill` = '8464-1;3267-1;' WHERE `item_id` = 17004;                                                     -- 壺精封印手鐲-麋鹿寶寶
UPDATE `armor` SET `bodypart` = 'lbracelet', `skill` = '21191-1;23171-1;23173-1;3267-1;' WHERE `item_id` = 20941;          -- 鳳凰壺精封印手鐲-有鳳來儀
UPDATE `armor` SET `bodypart` = 'hairall' WHERE `item_id` IN (20942,20944);                                                -- 狐狸面具/排灣族帽子

-- 其它
UPDATE `etcitem` SET `skill` = '2869-1;', `handler` = 'ItemSkills' WHERE `item_id` = 14724;                                -- 活動-哞哞牛召喚卷軸
UPDATE `etcitem` SET `skill` = '2870-1;', `handler` = 'ItemSkills' WHERE `item_id` = 14725;                                -- 活動-超神牛召喚卷軸
UPDATE `etcitem` SET `skill` = '2880-1;', `handler` = 'ItemSkills' WHERE `item_id` = 14726;                                -- 活動-憂鬱哞哞牛召喚卷軸
UPDATE `etcitem` SET `skill` = '2881-1;', `handler` = 'ItemSkills' WHERE `item_id` = 14727;                                -- 活動-憂鬱超神牛召喚卷軸
UPDATE `etcitem` SET `consume_type` = 'stackable' WHERE `item_id` = 20597;                                                 -- 少女的精靈石
UPDATE `etcitem` SET `skill` = '22105-1;', `handler` = 'ItemSkills', `consume_type` = 'stackable' WHERE `item_id` = 20707; -- 兀兒德召喚卷軸
UPDATE `etcitem` SET `skill` = '22106-1;', `handler` = 'ItemSkills', `consume_type` = 'stackable' WHERE `item_id` = 20708; -- 貝爾丹蒂召喚卷軸
UPDATE `etcitem` SET `skill` = '22107-1;', `handler` = 'ItemSkills', `consume_type` = 'stackable' WHERE `item_id` = 20709; -- 斯庫迪召喚卷軸
UPDATE `etcitem` SET `skill` = '22110-1;', `handler` = 'ItemSkills', `consume_type` = 'stackable' WHERE `item_id` = 20728; -- 吉祥天燈召喚書
UPDATE `etcitem` SET `skill` = '22111-1;', `handler` = 'ItemSkills', `consume_type` = 'stackable' WHERE `item_id` = 20729; -- 歡慶天燈召喚書
UPDATE `etcitem` SET `skill` = '22112-1;', `handler` = 'ItemSkills', `consume_type` = 'stackable' WHERE `item_id` = 20730; -- 祈福天燈召喚書
UPDATE `etcitem` SET `skill` = '22113-1;', `handler` = 'ItemSkills', `consume_type` = 'stackable' WHERE `item_id` = 20731; -- 平安天燈召喚書
UPDATE `etcitem` SET `consume_type` = 'stackable' WHERE `item_id` IN (20904,20905,20906,20907);                            -- 玫瑰精華/玫瑰花
UPDATE `etcitem` SET `sellable` = 'true', `dropable` = 'true' WHERE `item_id` IN (20904,20905,20906,20907);                -- 玫瑰精華/玫瑰花
UPDATE `etcitem` SET `destroyable` = 'true', `tradeable` = 'true' WHERE `item_id` IN (20904,20905,20906,20907);            -- 玫瑰精華/玫瑰花

-- 新特殊武器
UPDATE `weapon` SET `skill` = '8357-1;' WHERE `item_id` = 15310;          -- 殷海薩聖劍
UPDATE `weapon` SET `skill` = '21089-1;' WHERE `item_id` = 20600;         -- 招魂杖
UPDATE `weapon` SET `skill` = '21169-1;23154-1;' WHERE `item_id` = 20867; -- 門松變身魔杖

-- 修正結婚管理員的武器
UPDATE `custom_npc` SET `rhand` = 316 WHERE `id` = 50007;


/************ CT 2.6 芙蕾雅修正 ************/
-- 新搜魂石-階段17.18
REPLACE INTO `etcitem` VALUES
(15541,'Red Soul Crystal - Stage 17','','false','scroll',20,'normal','paper','none',-1,-1,0,0,'true','true','true','true','true','SoulCrystals','0-0;'),
(15542,'Blue Soul Crystal - Stage 17','','false','scroll',20,'normal','paper','none',-1,-1,0,0,'true','true','true','true','true','SoulCrystals','0-0;'),
(15543,'Green Soul Crystal - Stage 17','','false','scroll',20,'normal','paper','none',-1,-1,0,0,'true','true','true','true','true','SoulCrystals','0-0;'),
(15826,'Red Soul Crystal - Stage 18','','false','scroll',20,'normal','paper','none',-1,-1,0,0,'true','true','true','true','true','SoulCrystals','0-0;'),
(15827,'Blue Soul Crystal - Stage 18','','false','scroll',20,'normal','paper','none',-1,-1,0,0,'true','true','true','true','true','SoulCrystals','0-0;'),
(15828,'Green Soul Crystal - Stage 18','','false','scroll',20,'normal','paper','none',-1,-1,0,0,'true','true','true','true','true','SoulCrystals','0-0;'),

-- 新生命石-85.86級
(16160,'Life Stone - level 85','','false','none',2,'stackable','paper','none',-1,-1,0,0,'true','true','true','true','true','none','0-0;'),
(16161,'Mid-Grade Life Stone - level 85','','false','none',2,'stackable','paper','none',-1,-1,0,0,'true','true','true','true','true','none','0-0;'),
(16162,'High-Grade Life Stone - level 85','','false','none',2,'stackable','paper','none',-1,-1,0,0,'true','true','true','true','true','none','0-0;'),
(16163,'Top-Grade Life Stone - level 85','','false','none',2,'stackable','paper','none',-1,-1,0,0,'true','true','true','true','true','none','0-0;'),
(16164,'Life Stone - level 86','','false','none',2,'stackable','paper','none',-1,-1,0,0,'true','true','true','true','true','none','0-0;'),
(16165,'Mid-Grade Life Stone - level 86','','false','none',2,'stackable','paper','none',-1,-1,0,0,'true','true','true','true','true','none','0-0;'),
(16166,'High-Grade Life Stone - level 86','','false','none',2,'stackable','paper','none',-1,-1,0,0,'true','true','true','true','true','none','0-0;'),
(16167,'Top-Grade Life Stone - level 86','','false','none',2,'stackable','paper','none',-1,-1,0,0,'true','true','true','true','true','none','0-0;');

-- 新壺精(三頭龍/格諾席安控球/奧羅德利爾控球/十二碼罰球)
REPLACE INTO `armor` VALUES
(20970,'20970','','lbracelet','false','none',150,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','21194-1;23181-1;3267-1;'),
(20983,'20983','','lbracelet','false','none',150,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','21202-1;23201-1;3267-1;'),
(20984,'20984','','lbracelet','false','none',150,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','21203-1;23202-1;3267-1;'),
(20985,'20985','','lbracelet','false','none',150,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','21204-1;23203-1;3267-1;'),
(20986,'20986','','lbracelet','false','none',150,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','21205-1;23204-1;3267-1;'),
(20987,'20987','','lbracelet','false','none',150,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','21206-1;23205-1;3267-1;'),
(20988,'20988','','lbracelet','false','none',150,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','21207-1;23206-1;3267-1;'),
(20989,'20989','','lbracelet','false','none',150,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','21208-1;23207-1;3267-1;'),
(20990,'20990','','lbracelet','false','none',150,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','21209-1;23208-1;3267-1;'),
(20991,'20991','','lbracelet','false','none',150,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','21210-1;23209-1;3267-1;');

-- 新頭飾(天使/冰結/骷髏頭箍/鯊魚/金角/銀角/企鵝/頭巾/烏龜/牛牛/龍舟帽/足球爆炸頭/京劇面具-劉備/關羽/張飛)
REPLACE INTO `armor` VALUES
(15484,'15484','','hairall','false','none',10,'wood','none',0,-1,10080,0,0,0,0,0,'false','false','true','false','true','0-0','8509-1;'),
(16098,'16098','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(16099,'16099','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(16100,'16100','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(16101,'16101','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(16102,'16102','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(16103,'16103','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(16104,'16104','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(16105,'16105','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(16106,'16106','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(16107,'16107','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(16108,'16108','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(16109,'16109','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(17033,'17033','','hairall','false','none',10,'wood','none',0,-1,43200,0,0,0,0,0,'false','false','true','false','true','0-0','8497-1;'),
(20973,'20973','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(20974,'20974','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(20975,'20975','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(20981,'20981','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(21009,'21009','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(21010,'21010','','hairall','false','none',10,'wood','none',0,-1,-1,0,0,0,0,0,'false','false','true','false','true','0-0','0-0;'),
(21011,'21011','','hairall','false','none',10,'wood','none',0,-1,10080,0,0,0,0,0,'false','false','true','false','true','0-0','21211-1;');

-- 新飾品(殤曲/博佩斯/天命)
REPLACE INTO `armor` VALUES
(15717,'15717','','rfinger,lfinger','true','none',150,'gold','s84',0,-1,-1,0,69,27,0,523,'true','true','true','true','true','0-0','0-0;'),
(15718,'15718','','rear,lear','true','none',150,'gold','s84',0,-1,-1,0,104,39,0,785,'true','true','true','true','true','0-0','0-0;'),
(15719,'15719','','neck','true','none',150,'gold','s84',0,-1,-1,0,138,52,0,1046,'true','true','true','true','true','0-0','0-0;'),
(15720,'15720','','rfinger,lfinger','true','none',150,'gold','s84',0,-1,-1,0,65,26,0,436,'true','true','true','true','true','0-0','0-0;'),
(15721,'15721','','rear,lear','true','none',150,'gold','s84',0,-1,-1,0,98,38,0,654,'true','true','true','true','true','0-0','0-0;'),
(15722,'15722','','neck','true','none',150,'gold','s84',0,-1,-1,0,131,51,0,872,'true','true','true','true','true','0-0','0-0;'),
(15723,'15723','','rfinger,lfinger','true','none',150,'gold','s80',0,-1,-1,0,61,24,0,263,'true','true','true','true','true','0-0','0-0;'),
(15724,'15724','','rear,lear','true','none',150,'gold','s80',0,-1,-1,0,86,36,0,395,'true','true','true','true','true','0-0','0-0;'),
(15725,'15725','','neck','true','none',150,'gold','s80',0,-1,-1,0,115,48,0,526,'true','true','true','true','true','0-0','0-0;');

-- 新BOSS飾品(芙蕾雅項鍊)
REPLACE INTO `armor` VALUES
(16025,'16025','','neck','true','none',150,'gold','s84',0,-1,-1,0,125,50,0,729,'true','true','true','true','true','0-0','8459-1;'),
(16026,'16026','','neck','true','none',150,'gold','s84',0,-1,-1,0,132,50,0,729,'true','true','true','true','true','0-0','8460-1;');

-- 新泰森迪武器(王朝武器的變色版+薄暮武器的能力)
REPLACE INTO `weapon` VALUES
(15676,'15676','','rhand','true',1520,1,1,'fine_steel','s84',396,10,'sword',8,0.00000,0,0,0,379,0,183,-1,-1,0,0,'true','true','true','true','true',0,0,0,0,0,0,0,0,15687,'0-0;'),
(15677,'15677','','rhand','true',1520,1,1,'fine_steel','s84',346,5,'dagger',12,-3.00000,0,0,0,433,0,183,-1,-1,0,0,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'0-0;'),
(15678,'15678','','rhand','true',1740,1,1,'fine_steel','s84',396,20,'blunt',4,4.00000,0,0,0,379,0,183,-1,-1,0,0,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'0-0;'),
(15679,'15679','','lrhand','true',1740,1,1,'fine_steel','s84',482,20,'bigblunt',4,4.00000,0,0,0,325,0,183,-1,-1,0,0,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'0-0;'),
(15680,'15680','','lrhand','true',1740,1,1,'fine_steel','s84',482,10,'bigsword',8,0.00000,0,0,0,325,0,183,-1,-1,0,0,'true','true','true','true','true',0,0,0,0,0,0,0,0,15688,'0-0;'),
(15681,'15681','','lrhand','true',1550,1,1,'fine_steel','s84',482,5,'dualfist',4,4.00000,0,0,0,325,0,183,-1,-1,0,0,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'0-0;'),
(15682,'15682','','lrhand','true',2010,1,1,'fine_steel','s84',396,10,'pole',8,-3.00000,0,0,0,325,0,183,-1,-1,0,0,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3599-1;'),
(15683,'15683','','rhand','true',1080,1,1,'fine_steel','s84',317,20,'blunt',4,4.00000,0,0,0,379,0,244,-1,-1,0,0,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'0-0;'),
(15684,'15684','','lrhand','true',1080,1,1,'fine_steel','s84',386,20,'bigblunt',4,4.00000,0,0,0,325,0,268,-1,-1,0,0,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'0-0;'),
(15685,'15685','','rhand','true',1520,1,1,'fine_steel','s84',317,10,'sword',8,0.00000,0,0,0,379,0,244,-1,-1,0,0,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'0-0;'),
(15686,'15686','','lrhand','true',1520,1,1,'fine_steel','s84',724,5,'bow',12,-3.00000,0,0,0,293,12,183,-1,-1,0,0,'true','true','true','true','true',0,0,0,0,0,0,0,0,15689,'0-0;'),
(15687,'15687','','rhand','true',1280,1,1,'fine_steel','s84',359,40,'rapier',10,-1.00000,0,0,0,406,0,183,-1,-1,0,0,'true','true','true','true','true',3426,1,0,0,0,0,0,0,15676,'0-0;'),
(15688,'15688','','lrhand','true',1800,1,1,'fine_steel','s84',429,15,'ancient',8,2.00000,0,0,0,350,0,183,-1,-1,0,0,'true','true','true','true','true',0,0,0,0,0,0,0,0,15680,'0-0;'),
(15689,'15689','','rhand','true',1580,1,1,'fine_steel','s84',444,10,'crossbow',10,-1.00000,0,0,0,303,0,183,-1,-1,0,0,'true','true','true','true','true',0,0,0,0,0,0,0,0,15686,'0-0;');

-- 新防具(殤曲/博佩斯/天命)
REPLACE INTO `armor` VALUES
(15572,'15572','','head','true','none',530,'fine_steel','s84',0,-1,-1,110,0,0,0,1205,'true','true','true','true','true','0-0','0-0;'),
(15573,'15573','','head','true','none',530,'wood','s84',0,-1,-1,110,0,0,0,1205,'true','true','true','true','true','0-0','0-0;'),
(15574,'15574','','head','true','none',530,'cloth','s84',0,-1,-1,110,0,0,0,1205,'true','true','true','true','true','0-0','0-0;'),
(15575,'15575','','chest','true','heavy',7520,'fine_steel','s84',0,-1,-1,272,0,0,0,3214,'true','true','true','true','true','0-0','0-0;'),
(15576,'15576','','chest','true','light',4140,'wood','s84',0,-1,-1,204,0,0,0,2410,'true','true','true','true','true','0-0','0-0;'),
(15577,'15577','','chest','true','magic',1750,'cloth','s84',0,-1,-1,136,0,661,0,2410,'true','true','true','true','true','0-0','0-0;'),
(15578,'15578','','legs','true','heavy',3170,'fine_steel','s84',0,-1,-1,170,0,0,0,2009,'true','true','true','true','true','0-0','0-0;'),
(15579,'15579','','legs','true','light',1320,'wood','s84',0,-1,-1,128,0,0,0,1506,'true','true','true','true','true','0-0','0-0;'),
(15580,'15580','','legs','true','magic',850,'cloth','s84',0,-1,-1,85,0,439,0,1506,'true','true','true','true','true','0-0','0-0;'),
(15581,'15581','','gloves','true','none',510,'fine_steel','s84',0,-1,-1,74,0,0,0,803,'true','true','true','true','true','0-0','0-0;'),
(15582,'15582','','gloves','true','none',510,'wood','s84',0,-1,-1,74,0,0,0,803,'true','true','true','true','true','0-0','0-0;'),
(15583,'15583','','gloves','true','none',510,'cloth','s84',0,-1,-1,74,0,0,0,803,'true','true','true','true','true','0-0','0-0;'),
(15584,'15584','','feet','true','none',1070,'fine_steel','s84',0,-1,-1,74,0,0,0,803,'true','true','true','true','true','0-0','0-0;'),
(15585,'15585','','feet','true','none',1070,'wood','s84',0,-1,-1,74,0,0,0,803,'true','true','true','true','true','0-0','0-0;'),
(15586,'15586','','feet','true','none',1070,'cloth','s84',0,-1,-1,74,0,0,0,803,'true','true','true','true','true','0-0','0-0;'),
(15588,'15588','','lhand','false','sigil',920,'silver','s84',0,-1,-1,21,0,0,0,844,'true','true','true','true','true','0-0','0-0;'),
(15589,'15589','','head','true','none',530,'fine_steel','s84',0,-1,-1,107,0,0,0,1005,'true','true','true','true','true','0-0','0-0;'),
(15590,'15590','','head','true','none',530,'wood','s84',0,-1,-1,107,0,0,0,1005,'true','true','true','true','true','0-0','0-0;'),
(15591,'15591','','head','true','none',530,'cloth','s84',0,-1,-1,107,0,0,0,1005,'true','true','true','true','true','0-0','0-0;'),
(15592,'15592','','chest','true','heavy',7520,'fine_steel','s84',0,-1,-1,263,0,0,0,2680,'true','true','true','true','true','0-0','0-0;'),
(15593,'15593','','chest','true','light',4140,'wood','s84',0,-1,-1,197,0,0,0,2010,'true','true','true','true','true','0-0','0-0;'),
(15594,'15594','','chest','true','magic',1750,'cloth','s84',0,-1,-1,132,0,649,0,2010,'true','true','true','true','true','0-0','0-0;'),
(15595,'15595','','legs','true','heavy',3170,'fine_steel','s84',0,-1,-1,164,0,0,0,1675,'true','true','true','true','true','0-0','0-0;'),
(15596,'15596','','legs','true','light',1320,'wood','s84',0,-1,-1,123,0,0,0,1256,'true','true','true','true','true','0-0','0-0;'),
(15597,'15597','','legs','true','magic',850,'cloth','s84',0,-1,-1,82,0,427,0,1256,'true','true','true','true','true','0-0','0-0;'),
(15598,'15598','','gloves','true','none',510,'fine_steel','s84',0,-1,-1,71,0,0,0,670,'true','true','true','true','true','0-0','0-0;'),
(15599,'15599','','gloves','true','none',510,'wood','s84',0,-1,-1,71,0,0,0,670,'true','true','true','true','true','0-0','0-0;'),
(15600,'15600','','gloves','true','none',510,'cloth','s84',0,-1,-1,71,0,0,0,670,'true','true','true','true','true','0-0','0-0;'),
(15601,'15601','','feet','true','none',1070,'fine_steel','s84',0,-1,-1,71,0,0,0,670,'true','true','true','true','true','0-0','0-0;'),
(15602,'15602','','feet','true','none',1070,'wood','s84',0,-1,-1,71,0,0,0,670,'true','true','true','true','true','0-0','0-0;'),
(15603,'15603','','feet','true','none',1070,'cloth','s84',0,-1,-1,71,0,0,0,670,'true','true','true','true','true','0-0','0-0;'),
(15605,'15605','','lhand','false','sigil',920,'silver','s84',0,-1,-1,19,0,0,0,704,'true','true','true','true','true','0-0','0-0;'),
(15606,'15606','','head','true','none',530,'fine_steel','s80',0,-1,-1,96,0,0,0,606,'true','true','true','true','true','0-0','0-0;'),
(15607,'15607','','head','true','none',530,'wood','s80',0,-1,-1,96,0,0,0,606,'true','true','true','true','true','0-0','0-0;'),
(15608,'15608','','head','true','none',530,'cloth','s80',0,-1,-1,96,0,0,0,606,'true','true','true','true','true','0-0','0-0;'),
(15609,'15609','','chest','true','heavy',7520,'fine_steel','s80',0,-1,-1,238,0,0,0,1616,'true','true','true','true','true','0-0','0-0;'),
(15610,'15610','','chest','true','light',4140,'wood','s80',0,-1,-1,178,0,0,0,1212,'true','true','true','true','true','0-0','0-0;'),
(15611,'15611','','chest','true','magic',1750,'cloth','s80',0,-1,-1,119,0,614,0,1212,'true','true','true','true','true','0-0','0-0;'),
(15612,'15612','','legs','true','heavy',3170,'fine_steel','s80',0,-1,-1,149,0,0,0,1010,'true','true','true','true','true','0-0','0-0;'),
(15613,'15613','','legs','true','light',1320,'wood','s80',0,-1,-1,111,0,0,0,758,'true','true','true','true','true','0-0','0-0;'),
(15614,'15614','','legs','true','magic',850,'cloth','s80',0,-1,-1,74,0,392,0,758,'true','true','true','true','true','0-0','0-0;'),
(15615,'15615','','gloves','true','none',510,'fine_steel','s80',0,-1,-1,64,0,0,0,404,'true','true','true','true','true','0-0','0-0;'),
(15616,'15616','','gloves','true','none',510,'wood','s80',0,-1,-1,64,0,0,0,404,'true','true','true','true','true','0-0','0-0;'),
(15617,'15617','','gloves','true','none',510,'cloth','s80',0,-1,-1,64,0,0,0,404,'true','true','true','true','true','0-0','0-0;'),
(15618,'15618','','feet','true','none',1070,'fine_steel','s80',0,-1,-1,64,0,0,0,404,'true','true','true','true','true','0-0','0-0;'),
(15619,'15619','','feet','true','none',1070,'wood','s80',0,-1,-1,64,0,0,0,404,'true','true','true','true','true','0-0','0-0;'),
(15620,'15620','','feet','true','none',1070,'cloth','s80',0,-1,-1,64,0,0,0,404,'true','true','true','true','true','0-0','0-0;'),
(15622,'15622','','lhand','false','sigil',920,'silver','s80',0,-1,-1,16,0,0,0,424,'true','true','true','true','true','0-0','0-0;');

-- 新盾牌(殤曲/博佩斯/天命)
REPLACE INTO `weapon` VALUES
(15587,'15587','','lhand','true',1190,0,0,'fine_steel','s84',0,0,'none',0,0.00000,-8,413,20,0,0,0,-1,-1,0,844,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'0-0;'),
(15604,'15604','','lhand','true',1190,0,0,'fine_steel','s84',0,0,'none',0,0.00000,-8,399,20,0,0,0,-1,-1,0,704,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'0-0;'),
(15621,'15621','','lhand','true',1190,0,0,'fine_steel','s80',0,0,'none',0,0.00000,-8,355,20,0,0,0,-1,-1,0,424,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'0-0;');

-- 新武器(S84上級/S84特級)
REPLACE INTO `weapon` VALUES
(15829,'15829','','rhand','true',1520,1,1,'fine_steel','s84',415,10,'sword',8,0.00000,0,0,0,379,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,15863,'3013-5;'),
(15830,'15830','','rhand','true',1520,1,1,'fine_steel','s84',415,10,'sword',8,0.00000,0,0,0,379,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,15864,'8289-2;'),
(15831,'15831','','rhand','true',1520,1,1,'fine_steel','s84',415,10,'sword',8,0.00000,0,0,0,379,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,15862,'8297-1;'),
(15832,'15832','','rhand','true',1520,1,1,'fine_steel','s84',363,5,'dagger',12,-3.00000,0,0,0,433,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3568-1;'),
(15833,'15833','','rhand','true',1520,1,1,'fine_steel','s84',363,5,'dagger',12,-3.00000,0,0,0,433,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'8297-1;'),
(15834,'15834','','rhand','true',1520,1,1,'fine_steel','s84',363,5,'dagger',12,-3.00000,0,0,0,433,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3572-3;'),
(15835,'15835','','rhand','true',1740,1,1,'fine_steel','s84',415,20,'blunt',4,4.00000,0,0,0,379,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3013-4;'),
(15836,'15836','','rhand','true',1740,1,1,'fine_steel','s84',415,20,'blunt',4,4.00000,0,0,0,379,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3569-1;'),
(15837,'15837','','rhand','true',1740,1,1,'fine_steel','s84',415,20,'blunt',4,4.00000,0,0,0,379,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3599-1;3568-1;'),
(15838,'15838','','lrhand','true',1740,1,1,'fine_steel','s84',505,20,'bigblunt',4,4.00000,0,0,0,325,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3013-5;'),
(15839,'15839','','lrhand','true',1740,1,1,'fine_steel','s84',505,20,'bigblunt',4,4.00000,0,0,0,325,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3568-1;'),
(15840,'15840','','lrhand','true',1740,1,1,'fine_steel','s84',505,20,'bigblunt',4,4.00000,0,0,0,325,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3569-1;'),
(15841,'15841','','lrhand','true',1740,1,1,'fine_steel','s84',505,10,'bigsword',8,0.00000,0,0,0,325,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,15866,'3013-5;'),
(15842,'15842','','lrhand','true',1740,1,1,'fine_steel','s84',505,10,'bigsword',8,0.00000,0,0,0,325,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,15867,'8289-2;'),
(15843,'15843','','lrhand','true',1740,1,1,'fine_steel','s84',505,10,'bigsword',8,0.00000,0,0,0,325,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,15865,'8297-1;'),
(15844,'15844','','lrhand','true',1550,1,1,'fine_steel','s84',505,5,'dualfist',4,4.00000,0,0,0,325,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3013-5;'),
(15845,'15845','','lrhand','true',1550,1,1,'fine_steel','s84',505,5,'dualfist',4,4.00000,0,0,0,325,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,3571,1,43,0,'3552-1;'),
(15846,'15846','','lrhand','true',1550,1,1,'fine_steel','s84',505,5,'dualfist',4,4.00000,0,0,0,325,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'8289-2;'),
(15847,'15847','','lrhand','true',2010,1,1,'fine_steel','s84',415,10,'pole',8,-3.00000,0,0,0,325,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3602-7;'),
(15848,'15848','','lrhand','true',2010,1,1,'fine_steel','s84',415,10,'pole',8,-3.00000,0,0,0,325,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3599-1;8297-1;'),
(15849,'15849','','lrhand','true',2010,1,1,'fine_steel','s84',415,10,'pole',8,-3.00000,0,0,0,325,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3013-4;'),
(15850,'15850','','rhand','true',1080,1,1,'fine_steel','s84',332,20,'blunt',4,4.00000,0,0,0,379,0,244,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3576-2;'),
(15851,'15851','','rhand','true',1080,1,1,'fine_steel','s84',332,20,'blunt',4,4.00000,0,0,0,379,0,244,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3014-3;'),
(15852,'15852','','rhand','true',1080,1,1,'fine_steel','s84',332,20,'blunt',4,4.00000,0,0,0,379,0,244,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3047-3;'),
(15853,'15853','','lrhand','true',1080,1,1,'fine_steel','s84',404,20,'bigblunt',4,4.00000,0,0,0,325,0,268,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3576-2;'),
(15854,'15854','','lrhand','true',1080,1,1,'fine_steel','s84',404,20,'bigblunt',4,4.00000,0,0,0,325,0,268,-1,-1,0,8233,'true','true','true','true','true',0,0,3577,1,20,0,0,0,0,'3552-1;'),
(15855,'15855','','lrhand','true',1080,1,1,'fine_steel','s84',404,20,'bigblunt',4,4.00000,0,0,0,325,0,268,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3575-3;'),
(15856,'15856','','rhand','true',1520,1,1,'fine_steel','s84',332,10,'sword',8,0.00000,0,0,0,379,0,244,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3047-3;'),
(15857,'15857','','rhand','true',1520,1,1,'fine_steel','s84',332,10,'sword',8,0.00000,0,0,0,379,0,244,-1,-1,0,8233,'true','true','true','true','true',0,0,3577,1,20,0,0,0,0,'3552-1;'),
(15858,'15858','','rhand','true',1520,1,1,'fine_steel','s84',332,10,'sword',8,0.00000,0,0,0,379,0,244,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3014-3;'),
(15859,'15859','','lrhand','true',1520,1,1,'fine_steel','s84',768,5,'bow',12,-3.00000,0,0,0,293,12,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,15869,'8289-3;'),
(15860,'15860','','lrhand','true',1520,1,1,'fine_steel','s84',768,5,'bow',12,-3.00000,0,0,0,293,12,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,3574,3,33,15870,'3552-1;'),
(15861,'15861','','lrhand','true',1520,1,1,'fine_steel','s84',768,5,'bow',12,-3.00000,0,0,0,293,12,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,15868,'3552-1;'),
(15862,'15862','','rhand','true',1280,1,1,'fine_steel','s84',376,40,'rapier',10,-1.00000,0,0,0,406,0,183,-1,-1,0,8233,'true','true','true','true','true',3426,1,0,0,0,0,0,0,15830,'3013-5;'),
(15863,'15863','','rhand','true',1280,1,1,'fine_steel','s84',376,40,'rapier',10,-1.00000,0,0,0,406,0,183,-1,-1,0,8233,'true','true','true','true','true',3426,1,0,0,0,0,0,0,15831,'8289-3;'),
(15864,'15864','','rhand','true',1280,1,1,'fine_steel','s84',376,40,'rapier',10,-1.00000,0,0,0,406,0,183,-1,-1,0,8233,'true','true','true','true','true',3426,1,0,0,0,0,0,0,15829,'8297-1;'),
(15865,'15865','','lrhand','true',1800,1,1,'fine_steel','s84',449,15,'ancient',8,2.00000,0,0,0,350,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,15842,'3013-5;'),
(15866,'15866','','lrhand','true',1800,1,1,'fine_steel','s84',449,15,'ancient',8,2.00000,0,0,0,350,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,15843,'8289-2;'),
(15867,'15867','','lrhand','true',1800,1,1,'fine_steel','s84',449,15,'ancient',8,2.00000,0,0,0,350,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,15841,'8297-1;'),
(15868,'15868','','rhand','true',1580,1,1,'fine_steel','s84',471,10,'crossbow',10,-1.00000,0,0,0,303,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,15860,'8289-3;'),
(15869,'15869','','rhand','true',1580,1,1,'fine_steel','s84',471,10,'crossbow',10,-1.00000,0,0,0,303,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,3574,3,20,15861,'3552-1;'),
(15870,'15870','','rhand','true',1580,1,1,'fine_steel','s84',471,10,'crossbow',10,-1.00000,0,0,0,303,0,183,-1,-1,0,8233,'true','true','true','true','true',0,0,0,0,0,0,0,0,15859,'3552-1;'),
(15871,'15871','','rhand','true',1520,1,1,'fine_steel','s84',437,10,'sword',8,0.00000,0,0,0,379,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,15906,'8289-2;'),
(15872,'15872','','rhand','true',1520,1,1,'fine_steel','s84',437,10,'sword',8,0.00000,0,0,0,379,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,15904,'8297-1;'),
(15873,'15873','','rhand','true',1520,1,1,'fine_steel','s84',437,10,'sword',8,0.00000,0,0,0,379,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,15905,'3013-5;'),
(15874,'15874','','rhand','true',1520,1,1,'fine_steel','s84',382,5,'dagger',12,-3.00000,0,0,0,433,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'8297-1;'),
(15875,'15875','','rhand','true',1520,1,1,'fine_steel','s84',382,5,'dagger',12,-3.00000,0,0,0,433,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3572-4;'),
(15876,'15876','','rhand','true',1520,1,1,'fine_steel','s84',382,5,'dagger',12,-3.00000,0,0,0,433,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3568-1;'),
(15877,'15877','','rhand','true',1740,1,1,'fine_steel','s84',437,20,'blunt',4,4.00000,0,0,0,379,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3569-1;'),
(15878,'15878','','rhand','true',1740,1,1,'fine_steel','s84',437,20,'blunt',4,4.00000,0,0,0,379,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3599-1;3568-1;'),
(15879,'15879','','rhand','true',1740,1,1,'fine_steel','s84',437,20,'blunt',4,4.00000,0,0,0,379,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3013-4;'),
(15880,'15880','','lrhand','true',1740,1,1,'fine_steel','s84',532,20,'bigblunt',4,4.00000,0,0,0,325,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3568-1;'),
(15881,'15881','','lrhand','true',1740,1,1,'fine_steel','s84',532,20,'bigblunt',4,4.00000,0,0,0,325,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3569-1;'),
(15882,'15882','','lrhand','true',1740,1,1,'fine_steel','s84',532,20,'bigblunt',4,4.00000,0,0,0,325,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3013-5;'),
(15883,'15883','','lrhand','true',1740,1,1,'fine_steel','s84',532,10,'bigsword',8,0.00000,0,0,0,325,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,15909,'8289-2;'),
(15884,'15884','','lrhand','true',1740,1,1,'fine_steel','s84',532,10,'bigsword',8,0.00000,0,0,0,325,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,15907,'8297-1;'),
(15885,'15885','','lrhand','true',1740,1,1,'fine_steel','s84',532,10,'bigsword',8,0.00000,0,0,0,325,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,15908,'3013-5;'),
(15886,'15886','','lrhand','true',1550,1,1,'fine_steel','s84',532,5,'dualfist',4,4.00000,0,0,0,325,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,3571,1,43,0,'3552-1;'),
(15887,'15887','','lrhand','true',1550,1,1,'fine_steel','s84',532,5,'dualfist',4,4.00000,0,0,0,325,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'8289-2;'),
(15888,'15888','','lrhand','true',1550,1,1,'fine_steel','s84',532,5,'dualfist',4,4.00000,0,0,0,325,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3013-5;'),
(15889,'15889','','lrhand','true',2010,1,1,'fine_steel','s84',437,10,'pole',8,-3.00000,0,0,0,325,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3599-1;8297-1;'),
(15890,'15890','','lrhand','true',2010,1,1,'fine_steel','s84',437,10,'pole',8,-3.00000,0,0,0,325,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3013-4;'),
(15891,'15891','','lrhand','true',2010,1,1,'fine_steel','s84',437,10,'pole',8,-3.00000,0,0,0,325,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3602-7;'),
(15892,'15892','','rhand','true',1080,1,1,'fine_steel','s84',350,20,'blunt',4,4.00000,0,0,0,379,0,256,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3014-3;'),
(15893,'15893','','rhand','true',1080,1,1,'fine_steel','s84',350,20,'blunt',4,4.00000,0,0,0,379,0,256,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3047-3;'),
(15894,'15894','','rhand','true',1080,1,1,'fine_steel','s84',350,20,'blunt',4,4.00000,0,0,0,379,0,256,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3576-2;'),
(15895,'15895','','lrhand','true',1080,1,1,'fine_steel','s84',426,20,'bigblunt',4,4.00000,0,0,0,325,0,281,-1,-1,0,9872,'true','true','true','true','true',0,0,3577,1,20,0,0,0,0,'3552-1;'),
(15896,'15896','','lrhand','true',1080,1,1,'fine_steel','s84',426,20,'bigblunt',4,4.00000,0,0,0,325,0,281,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3575-4;'),
(15897,'15897','','lrhand','true',1080,1,1,'fine_steel','s84',426,20,'bigblunt',4,4.00000,0,0,0,325,0,281,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3576-2;'),
(15898,'15898','','rhand','true',1520,1,1,'fine_steel','s84',350,10,'sword',8,0.00000,0,0,0,379,0,256,-1,-1,0,9872,'true','true','true','true','true',0,0,3577,1,20,0,0,0,0,'3552-1;'),
(15899,'15899','','rhand','true',1520,1,1,'fine_steel','s84',350,10,'sword',8,0.00000,0,0,0,379,0,256,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3014-3;'),
(15900,'15900','','rhand','true',1520,1,1,'fine_steel','s84',350,10,'sword',8,0.00000,0,0,0,379,0,256,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,0,'3047-3;'),
(15901,'15901','','lrhand','true',1520,1,1,'fine_steel','s84',794,5,'bow',12,-3.00000,0,0,0,293,12,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,3574,3,44,15912,'3552-1;'),
(15902,'15902','','lrhand','true',1520,1,1,'fine_steel','s84',794,5,'bow',12,-3.00000,0,0,0,293,12,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,15910,'3552-1;'),
(15903,'15903','','lrhand','true',1520,1,1,'fine_steel','s84',794,5,'bow',12,-3.00000,0,0,0,293,12,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,15911,'8289-3;'),
(15904,'15904','','rhand','true',1280,1,1,'fine_steel','s84',396,40,'rapier',10,-1.00000,0,0,0,406,0,192,-1,-1,0,9872,'true','true','true','true','true',3426,1,0,0,0,0,0,0,15873,'8289-3;'),
(15905,'15905','','rhand','true',1280,1,1,'fine_steel','s84',396,40,'rapier',10,-1.00000,0,0,0,406,0,192,-1,-1,0,9872,'true','true','true','true','true',3426,1,0,0,0,0,0,0,15871,'8297-1;'),
(15906,'15906','','rhand','true',1280,1,1,'fine_steel','s84',396,40,'rapier',10,-1.00000,0,0,0,406,0,192,-1,-1,0,9872,'true','true','true','true','true',3426,1,0,0,0,0,0,0,15872,'3013-5;'),
(15907,'15907','','lrhand','true',1800,1,1,'fine_steel','s84',473,15,'ancient',8,2.00000,0,0,0,350,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,15885,'8289-2;'),
(15908,'15908','','lrhand','true',1800,1,1,'fine_steel','s84',473,15,'ancient',8,2.00000,0,0,0,350,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,15883,'8297-1;'),
(15909,'15909','','lrhand','true',1800,1,1,'fine_steel','s84',473,15,'ancient',8,2.00000,0,0,0,350,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,15884,'3013-5;'),
(15910,'15910','','rhand','true',1580,1,1,'fine_steel','s84',487,10,'crossbow',10,-1.00000,0,0,0,303,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,3574,3,24,15903,'3552-1;'),
(15911,'15911','','rhand','true',1580,1,1,'fine_steel','s84',487,10,'crossbow',10,-1.00000,0,0,0,303,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,15901,'3552-1;'),
(15912,'15912','','rhand','true',1580,1,1,'fine_steel','s84',487,10,'crossbow',10,-1.00000,0,0,0,303,0,192,-1,-1,0,9872,'true','true','true','true','true',0,0,0,0,0,0,0,0,15902,'8289-3;'),
(16152,'16152','','lrhand','true',2050,1,1,'fine_steel','s84',415,10,'dualdagger',12,-3.00000,0,0,0,433,0,183,-1,-1,0,9872,'true','true','true','true','true',3044,20,0,0,0,0,0,0,0,'0-0;'),
(16154,'16154','','lrhand','true',1520,1,1,'fine_steel','s84',505,10,'dual',8,0.00000,0,0,0,325,0,183,-1,-1,0,8233,'true','true','true','true','true',3411,1,0,0,0,0,0,0,0,'0-0;'),
(16156,'16156','','lrhand','true',2050,1,1,'fine_steel','s84',437,10,'dualdagger',12,-3.00000,0,0,0,433,0,192,-1,-1,0,11421,'true','true','true','true','true',3044,20,0,0,0,0,0,0,0,'0-0;'),
(16158,'16158','','lrhand','true',1520,1,1,'fine_steel','s84',532,10,'dual',8,0.00000,0,0,0,325,0,192,-1,-1,0,9872,'true','true','true','true','true',3411,1,0,0,0,0,0,0,0,'0-0;');
