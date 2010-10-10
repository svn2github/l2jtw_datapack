/************ Made in Taiwan ************/

/************ 刪除自定的NPC ************/
DELETE FROM `spawnlist` WHERE `id` > 820000 AND `id` < 880000;


/************ 修正32007加爾巴-釣魚會員 ************/
REPLACE INTO `spawnlist` VALUES ('','',1,32007,140967,-123600,-1905,0,0,11829,60,0,0);
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
UPDATE `armor` SET `skill` = '3263-1;' WHERE `item_id` IN (10621,10625,10629);
UPDATE `armor` SET `skill` = '3264-1;' WHERE `item_id` IN (10620,10624,10628,14753,14756,14759,14762);
UPDATE `armor` SET `skill` = '3265-1;' WHERE `item_id` IN (10623,10627,10631,14754,14757,14760,14763);
UPDATE `armor` SET `skill` = '3266-1;' WHERE `item_id` IN (10622,10626,10630,14755,14758,14761,14764);
UPDATE `armor` SET `skill` = '21005-3;' WHERE `item_id` IN (20016);
UPDATE `armor` SET `skill` = '21006-1;21007-1;' WHERE `item_id` IN (20018);
UPDATE `armor` SET `skill` = '21004-1;' WHERE `item_id` IN (20019);


/************ 增加/修正/刪除NPC ************/
UPDATE `npc` SET `type` = 'L2VillageMaster' WHERE `id` IN (32191); -- 修正漢娜琳  宗師的NPC類型
UPDATE `npc` SET `type` = 'L2Adventurer' WHERE `id` IN (32074); -- 修正古魯丁分會長的NPC類型
UPDATE `npc` SET `type` = 'L2Npc', `collision_radius` = '9', `collision_height` = '16.5', `rhand` = '0' WHERE `id` IN (35417,35418); -- 修正地獄守門人
UPDATE `spawnlist` SET `npc_templateid` = '35440' WHERE `id` = 33771; -- 修正NPC ID:丹尼爾(根據地守門人)
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (30880,30881,30882,30883,30884,30885,30886,30887,30888,30889); -- 刪除不存在的NPC
UPDATE `droplist` SET `mobId` = '21070' WHERE `mobId` IN (21071); -- 封印大天使

-- 加入維他命管理者
REPLACE INTO `spawnlist` VALUES
('','', '1', '32478', '17735', '169802', '-3495', '0', '0', '19465', '60', '0', '0'); -- 獵人村莊

-- 修正NPC位置
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (30134,31605,31092,31675,31679,31677,30767,31691,35601,35602,35603,35605,35623,35624,35628,35638,35639,35640,35641,35642); -- 刪除不正確位置的NPC
REPLACE INTO `spawnlist` VALUES
('','oren09_npc2018_010', '1', '30134', '9689', '15550', '-4574', '0', '0', '5892', '60', '0', '0'),     -- 傑斯密(黑暗精靈村莊)
('','oren16_npc2218_016', '1', '31605', '85692', '16400', '-2803', '0', '0', '38000', '60', '0', '0'),   -- 金斯雷(象牙塔)
('','innadril09_npc2324_23', '1', '31092', '114486', '217413', '-3631', '0', '0', '0', '60', '0', '0'),  -- 財富的地下商人(水上都市海音斯)
('','aden17_npc2317_01', '1', '31675', '111186', '-13261', '-1702', '0', '0', '13828', '60', '0', '0'),  -- 維克特 馮 德伊克(國境守備隊隊長)
('','aden17_npc2317_02', '1', '31679', '111532', '-17238', '-1702', '0', '0', '49586', '60', '0', '0'),  -- 尤斯特斯 馮 伊森(邊境警備隊隊長)
('','aden17_npc2317_03', '1', '31677', '111532', '-13266', '-1704', '0', '0', '14508', '60', '0', '0'),  -- 國境守備隊員
('','aden17_npc2317_03', '1', '31677', '111178', '-17234', '-1702', '0', '0', '46468', '60', '0', '0'),  -- 國境守備隊員
('','schuttgart', '1', '30767', '85792', '-142809', '-1341', '0', '0', '10508', '60', '0', '0');         -- 拍賣管理者(修加特城鎮)

-- 加入漏掉的NPC
INSERT INTO `spawnlist` VALUES
-- ('','', '1', '35644', '116178', '-181602', '-1365', '0', '0', '0', '60', '0', '0'),      -- 莊園管理員(矮人村莊)
-- ('','', '1', '35645', '-44159', '-112229', '-239', '0', '0', '39768', '60', '0', '0'),   -- 莊園管理員(半獸人村莊)
-- ('','', '1', '32321', '147271', '28647', '-2268', '0', '0', '53514', '60', '0', '0'),    -- 道具仲介商(亞丁城鎮)
-- ('','', '1', '32071', '84432', '-144032', '-1538', '0', '0', '8764', '60', '0', '0'),    -- 琳達(修加特城鎮)
('','', '1', '31691', '86123', '-145764', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('','', '1', '31691', '86123', '-145628', '-1295', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('','', '1', '31691', '86123', '-145492', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('','', '1', '31691', '86123', '-145356', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('','', '1', '31691', '86123', '-145220', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('','', '1', '31691', '86315', '-145764', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('','', '1', '31691', '86315', '-145628', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('','', '1', '31691', '86315', '-145492', '-1295', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('','', '1', '31691', '86315', '-145356', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
('','', '1', '31691', '86315', '-145220', '-1292', '0', '0', '0', '60', '0', '0'),       -- 訓練用草人(修加特城鎮的戰士公會)
-- ('','', '1', '32109', '23666', '-7144', '-1134', '0', '0', '46433', '60', '0', '0'),     -- 席琳聖像
('','', '1', '35601', '141152', '-124272', '-1864', '0', '0', '10000', '60', '0', '0'),  -- 守門人(虹彩泉根據地)
('','', '1', '35602', '140704', '-124020', '-1904', '0', '0', '34000', '60', '0', '0'),  -- 守門人(虹彩泉根據地)
('','', '1', '35602', '140732', '-123796', '-1904', '0', '0', '2000', '60', '0', '0'),   -- 守門人(虹彩泉根據地)
('','', '1', '35603', '152924', '-126604', '-2304', '0', '0', '33000', '60', '0', '0'),  -- 入場管理員(虹彩泉根據地)
-- ('','', '1', '35604', '143944', '-119196', '-2136', '0', '0', '1000', '60', '0', '0'),   -- 傳令(虹彩泉根據地)
('','', '1', '35605', '140824', '-124844', '-1864', '0', '0', '10000', '60', '0', '0'),  -- 安格特 執事(虹彩泉根據地)
('','', '1', '35623', '59884', '-94204', '-1344', '0', '0', '27000', '60', '0', '0'),    -- 內城守門人(野獸農莊根據地)
('','', '1', '35624', '59920', '-94336', '-1344', '0', '0', '60000', '60', '0', '0'),    -- 內城守門人(野獸農莊根據地)
-- ('','', '1', '35625', '55184', '-93040', '-1360', '0', '0', '35000', '60', '0', '0'),    -- 外城守門人(野獸農莊根據地)
-- ('','', '1', '35626', '55400', '-93008', '-1360', '0', '0', '30000', '60', '0', '0'),    -- 外城守門人(野獸農莊根據地)
-- ('','', '1', '35627', '53508', '-93776', '-1584', '0', '0', '36000', '60', '0', '0'),    -- 傳令(野獸農莊根據地)
('','', '1', '35628', '60880', '-94320', '-1344', '0', '0', '27000', '60', '0', '0'),    -- 奎比亞 農場管理員(野獸農莊根據地)
('','', '1', '35638', '56736', '-26400', '568', '0', '0', '49000', '60', '0', '0'),      -- 巴倫斯 飛龍管理員
('','', '1', '35639', '58128', '-32000', '296', '0', '0', '0', '60', '0', '0'),          -- 傑卡德 傳令
('','', '1', '35640', '58024', '-25744', '592', '0', '0', '49000', '60', '0', '0'),      -- 凡德羅 執事
('','', '1', '35641', '58080', '-29552', '568', '0', '0', '49000', '60', '0', '0'),      -- 要塞守門人
('','', '1', '35641', '58137', '-29223', '568', '0', '0', '16500', '60', '0', '0'),      -- 要塞守門人
('','', '1', '35642', '58024', '-26456', '592', '0', '0', '49000', '60', '0', '0'),      -- 要塞守門人
('','', '1', '35642', '58074', '-26325', '597', '0', '0', '15732', '60', '0', '0');      -- 要塞守門人

-- 加入地下競技場的入場管理員
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (32377); -- 刪除地下競技場重複的入場管理員
UPDATE `npc` SET `type` = 'L2Teleporter' WHERE `id` IN (32503); -- 入場管理員 柯雷塔的晶體
INSERT INTO `spawnlist` VALUES
('','', '1', '32491', '-82166', '-49176', '-10341', '0', '0', '31175', '60', '0', '0'),  -- 地下競技場助手
('','', '1', '32503', '-70661', '-71066', '-1419', '0', '0', '49151', '60', '0', '0'),   -- 入場管理員 柯雷塔的晶體
('','', '1', '32513', '-84640', '-45360', '-10728', '0', '0', '56156', '60', '0', '0'),  -- 孔     入場管理員
('','', '1', '32514', '-77408', '-50656', '-10728', '0', '0', '29664', '60', '0', '0'),  -- 塔里翁 入場管理員
('','', '1', '32515', '-81904', '-53904', '-10728', '0', '0', '17044', '60', '0', '0'),  -- 利歐   入場管理員
('','', '1', '32516', '-86359', '-50593', '-10728', '0', '0', '3704', '60', '0', '0'),   -- 康丁斯 入場管理員
('','', '1', '32377', '-79117', '-45433', '-10731', '0', '0', '40959', '60', '0', '0');  -- 庫朗   入場管理員

-- 加入移動到柯雷塔的晶體/各等級的地下競技場外面
REPLACE INTO `teleport` VALUES
('Fantasy Isle -> Underground Coliseum', '12060', '-82271', '-49196', '-10352', '0', '0', '57'),
('Underground Coliseum -> Underground Coliseum LV40', '3249140', '-84451', '-45452', '-10728', '0', '0', '57'),
('Underground Coliseum -> Underground Coliseum LV50', '3249150', '-86154', '-50429', '-10728', '0', '0', '57'),
('Underground Coliseum -> Underground Coliseum LV60', '3249160', '-82009', '-53652', '-10728', '0', '0', '57'),
('Underground Coliseum -> Underground Coliseum LV70', '3249170', '-77586', '-50503', '-10728', '0', '0', '57'),
('Underground Coliseum -> Underground Coliseum LV00', '3249100', '-79309', '-45561', '-10728', '0', '0', '57');


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
REPLACE INTO `npc` VALUES ('18328', '18328', 'Hall Alarm Device', '0', '', '0', 'NPC.grave_keeper_key', '8.00', '21.00', '80', 'male', 'L2Monster', '80', '1264000', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '0', '333', '0', '0', '0', '0', '0', '0', '0', '0',1);
REPLACE INTO `npc` VALUES ('18329', '18329', 'Hall Keeper Captain', '0', '', '0', 'Monster.death_lord', '21.00', '40.00', '80', 'male', 'L2Monster', '80', '23582', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '78', '0', '0', '0', '88', '132', '0', '0',1);
REPLACE INTO `npc` VALUES ('18330', '18330', 'Hall Keeper Wizard', '0', '', '0', 'Monster.vale_master', '12.00', '40.00', '80', 'male', 'L2Monster', '80', '18203', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '326', '0', '0', '0', '88', '132', '0', '0',1);
REPLACE INTO `npc` VALUES ('18331', '18331', 'Hall Keeper Guard', '0', '', '0', 'Monster.death_knight', '12.00', '29.00', '80', 'male', 'L2Monster', '80', '18655', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '142', '0', '0', '0', '88', '132', '0', '0',1);
REPLACE INTO `npc` VALUES ('18332', '18332', 'Hall Keeper Patrol', '0', '', '0', 'Monster.headless_knight', '21.00', '31.00', '80', 'male', 'L2Monster', '80', '18434', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '70', '0', '0', '0', '88', '132', '0', '0',1);
REPLACE INTO `npc` VALUES ('18333', '18333', 'Hall Keeper Suicidal Soldier', '0', '', '0', 'Monster3.self_blaster', '20.00', '23.00', '80', 'male', 'L2Monster', '80', '18203', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '0', '0', '0', '0', '88', '132', '0', '0',1);
REPLACE INTO `npc` VALUES ('18334', '18334', 'Dark Choir Captain', '0', '', '0', 'Monster2.erinyes_cmd', '21.00', '50.00', '85', 'male', 'L2Monster', '80', '24069', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '0', '333', '0', '0', '0', '0', '0', '0', '0', '0',1);
REPLACE INTO `npc` VALUES ('18335', '18335', 'Dark Choir Prima Donna', '0', '', '0', 'Monster3.portrait_spirit', '11.00', '30.00', '80', 'male', 'L2Monster', '80', '18655', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '0', '0', '0', '0', '88', '132', '0', '0',1);
REPLACE INTO `npc` VALUES ('18336', '18336', 'Dark Choir Lancer', '0', '', '0', 'Monster.death_blader', '15.00', '45.00', '80', 'male', 'L2Monster', '80', '18655', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '1472', '0', '0', '0', '88', '132', '0', '0',1);
REPLACE INTO `npc` VALUES ('18337', '18337', 'Dark Choir Archer', '0', '', '0', 'Monster.skeleton_archer_20_bi', '13.00', '33.00', '80', 'male', 'L2Monster', '80', '18655', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '279', '0', '0', '0', '88', '132', '0', '0',1);
REPLACE INTO `npc` VALUES ('18338', '18338', 'Dark Choir Witch Doctor', '0', '', '0', 'Monster3.portrait_spirit_winged', '11.00', '30.00', '80', 'male', 'L2Monster', '80', '13991', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '500', '333', '0', '0', '0', '0', '88', '132', '0', '0',1);
REPLACE INTO `npc` VALUES ('18339', '18339', 'Dark Choir Player', '0', '', '0', 'Monster.skeleton', '11.00', '25.00', '80', 'male', 'L2Monster', '80', '18203', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '440000', '40000', '9000', '5000', '6000', '6000', '300', '0', '333', '148', '103', '0', '0', '88', '132', '0', '0',1);
REPLACE INTO `npc` VALUES ('29045', '29045', 'Frintezza', '0', '', '0', 'Monster3.frintessa', '10.00', '42.00', '90', 'male', 'L2GrandBoss', '0', '23480000', '22197', '830.62', '3.09', '40', '43', '30', '21', '20', '10', '0', '0', '9182', '6214', '7133', '4191', '253', '0', '333', '0', '0', '0', '0', '1', '1', '0', '0',1);
REPLACE INTO `npc` VALUES ('29046', '29046', 'Scarlet van Halisha', '0', '', '0', 'Monster3.follower_of_frintessa', '29.00', '90.00', '85', 'male', 'L2GrandBoss', '50', '23480000', '22393', '823.48', '2.65', '60', '57', '73', '76', '70', '80', '0', '0', '10699', '5036', '5212', '4191', '278', '6000', '3819', '8204', '0', '0', '0', '55', '132', '0', '0',1);
REPLACE INTO `npc` VALUES ('29047', '29047', 'Scarlet van Halisha', '0', '', '0', 'Monster3.follower_of_frintessa_tran', '29.00', '110.00', '90', 'male', 'L2GrandBoss', '60', '23480000', '22393', '830.62', '3.09', '70', '67', '73', '79', '70', '80', '496960259', '40375148', '23813', '7000', '12680', '6238', '409', '6000', '3819', '8222', '0', '0', '0', '92', '187', '0', '14',1);
REPLACE INTO `npc` VALUES ('29048', '29048', 'Evil Spirit', '0', '', '0', 'Monster3.Evilate', '20.00', '56.00', '87', 'male', 'L2Monster', '70', '350000', '9999', '414.12', '3.09', '40', '43', '30', '21', '20', '10', '30', '2', '9000', '2350', '7133', '2045', '253', '6000', '333', '0', '0', '0', '0', '0', '0', '0', '0',1);
REPLACE INTO `npc` VALUES ('29049', '29049', 'Evil Spirit', '0', '', '0', 'Monster3.Evilate', '20.00', '56.00', '87', 'male', 'L2Monster', '70', '350000', '9999', '414.12', '3.09', '40', '43', '30', '21', '20', '10', '30', '2', '9000', '2350', '7133', '2045', '253', '6000', '333', '0', '0', '0', '0', '0', '0', '0', '0',1);
REPLACE INTO `npc` VALUES ('29050', '29050', 'Breath of Halisha', '0', '', '0', 'Monster3.portrait_spirit', '10.00', '20.00', '85', 'male', 'L2Monster', '40', '350000', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '30', '2', '9000', '2350', '7133', '2045', '253', '6000', '333', '0', '0', '0', '0', '55', '66', '0', '0',1);
REPLACE INTO `npc` VALUES ('29051', '29051', 'Breath of Halisha', '0', '', '0', 'Monster3.portrait_spirit_winged', '10.00', '20.00', '85', 'male', 'L2Monster', '40', '350000', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '30', '2', '9000', '2350', '7133', '2045', '253', '6000', '333', '0', '0', '0', '0', '55', '66', '0', '0',1);
REPLACE INTO `npc` VALUES ('29052', '29052', '', '0', '', '0', 'Monster3.Organ_Dummy', '1.00', '1.00', '99', 'male', 'L2Npc', '40', '400000', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '0', '0', '9000', '5000', '6000', '6000', '300', '0', '333', '0', '0', '0', '0', '88', '132', '0', '0',1);
REPLACE INTO `npc` VALUES ('29053', '29053', '', '0', '', '0', 'Monster3.Follower_Dummy', '1.00', '1.00', '99', 'male', 'L2Npc', '40', '400000', '9999', '13.43', '3.09', '40', '43', '30', '21', '20', '10', '0', '0', '9000', '5000', '6000', '6000', '300', '0', '333', '0', '0', '0', '0', '88', '132', '0', '0',1);
REPLACE INTO `npc` VALUES ('29061', '29061', 'Teleportation Cubic', '0', '', '0', 'NPC.teleport_npc_frin', '40.00', '80.00', '70', 'male', 'L2Teleporter', '40', '2444', '2444', '0.00', '0.00', '10', '10', '10', '10', '10', '10', '0', '0', '500', '500', '500', '500', '278', '0', '333', '0', '0', '0', '0', '88', '132', '0', '0',1);
DELETE FROM `npcskills` Where `skillid` IN (5014,5015,5016,5017,5018,5019);
REPLACE INTO `npcskills` VALUES
(29050,5010,1),
(29050,5013,1),
(29051,5009,1),
(29051,5013,1);
-- DELETE FROM `zone_vertices` WHERE `id` IN (12011);
-- REPLACE INTO `zone_vertices` (`id`,`order`,`x`,`y`) VALUES
-- (12011,0,172229,-74350),
-- (12011,1,176241,-90230);


/************ 其他修正 ************/
-- 修正傳送到不同的房間挑戰莉莉絲/亞納
REPLACE INTO `teleport` VALUES
('Disciples Necropolis -> Anakim',449,184467,-13102,-5500,0,0,57),
('Disciples Necropolis -> Lilith',450,184448,-10120,-5500,0,0,57);

-- 修正攻城時間
-- ALTER TABLE `castle` DROP PRIMARY KEY, ADD PRIMARY KEY (`id`);
-- UPDATE `castle` SET `siegeDate` = '978782400000' WHERE `siegeDate` = '0' AND `id` IN (1,2,5,8,9);
-- UPDATE `castle` SET `siegeDate` = '979459200000' WHERE `siegeDate` = '0' AND `id` IN (3,4,6,7);

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
-- DELETE FROM `etcitem` WHERE `item_id` IN (15436); -- 萬聖夜變身魔杖 (L2J錯誤設定為etcitem)
REPLACE INTO `armor` VALUES
(20497,'Mother\'s Wreath - Event Blessing of Love - 24 hours limited period','','hairall','false','none',120,'wood','none',0,-1,1440,0,0,0,0,0,'false','false','true','false','true','0-0','21086-1;'), -- 母親的花環-活動 愛的祝福(限時24小時)
(20498,'Mother\'s Wreath Blessing of Love - 3 day limited period','','hairall','false','none',120,'wood','none',0,-1,4320,0,0,0,0,0,'false','false','true','false','true','0-0','21086-1;'); -- 母親的花環-活動 愛的祝福(限時3日)
-- REPLACE INTO `weapon` VALUES (15436,'Halloween Transformation Stick','7 day limited period','rhand','false',1600,1,1,'steel','none',8,10,'sword',8,0.00000,0,0,0,379,0,6,-1,-1,590,0,'false','false','false','false','false',0,0,0,0,0,0,0,0,0,'0-0;');
-- 修正NPC
UPDATE `npc` SET `type` = 'L2Npc' WHERE `id` IN (32628,32629); -- 碼頭巡邏兵的類型改為一般NPC
UPDATE `npc` SET `type` = 'L2Teleporter' WHERE `id` IN (32540,32542,32602); -- 深淵的守門人/安定的再生種子/臨時傳送師的類型改為傳送
UPDATE `spawnlist` SET `heading` = '16383' WHERE `npc_templateid` = '32609' AND `heading` = '20771'; -- 修正飛空艇控制裝置的面向

-- 新傳送
REPLACE INTO `teleport` VALUES
('3254001', '3254001', '-212836', '209824', '4288', '0', '0', '57'),   -- 深淵的守門人
('3260201', '3260201', '-245833', '220174', '-12104', '0', '0', '57'), -- 臨時傳送師
('3260202', '3260202', '-251624', '213420', '-12072', '0', '0', '57'), -- 臨時傳送師
('3260203', '3260203', '-249774', '207316', '-11952', '0', '0', '57'); -- 臨時傳送師

-- NPC改成AI控制
Delete From `spawnlist` Where `npc_templateid` in (32628,32629); -- 碼頭巡邏兵

-- 防具修正
UPDATE `armor` SET `armor_type` = 'heavy' WHERE `item_id` IN (9821,10019,10020); -- 幻象裝備-盟誓盔甲/鎖子胸甲/鋼鐵脛甲
UPDATE `armor` SET `armor_type` = 'light' WHERE `item_id` IN (9824,10021,10022); -- 幻象裝備-盟誓禮服/水晶獅皮襯衫/水晶獅皮脛甲
UPDATE `armor` SET `armor_type` = 'magic' WHERE `item_id` IN (9827,10023,10024); -- 幻象裝備-盟誓長袍/受詛咒的外衣/受詛咒的長襪
UPDATE `armor` SET `time` = 0 WHERE `item_id` IN (20098); -- 禮服-活動 1小時幻象
UPDATE `armor` SET `time` = 43200 WHERE `item_id` IN (13544,13545); -- 壺精召喚手鐲-男生泰迪熊/壺精召喚手鐲-女生泰迪熊
UPDATE `armor` SET `time` = 43200 WHERE `item_id` IN (20503,20504); -- 黃鬃獅子/蒸汽甲蟲騎乘手鐲 限時30日 (L2J錯誤設定為etcitem)
UPDATE `armor` SET `duration` = 360 WHERE `item_id` IN (14753,14754,14755,14756,14757,14758,14759,14760,14761,14762,14763,14764); -- 幻象裝備

-- 武器修正
UPDATE `weapon` SET `bodypart` = 'lrhand', `weaponType` = 'bigblunt' WHERE `item_id` IN (9819,13530,13531,13532,13533,13534,13535,13536,13537,13538);  -- 鬥爭旗幟/古魯丁旗幟/狄恩旗幟/奇岩旗幟/歐瑞旗幟/亞丁旗幟/因納得立旗幟/高達特旗幟/魯因旗幟/修加特旗幟
UPDATE `weapon` SET `bodypart` = 'lrhand', `weaponType` = 'bigblunt' WHERE `item_id` IN (13539,13560,13561,13562,13563,13564,13565,13566,13567,13568); -- 大師余義的魔杖/古魯丁 守護之物/狄恩 守護之物/奇岩 守護之物/歐瑞 守護之物/亞丁 守護之物/因納得立 守護之物/高達特 守護之物/魯因 守護之物/修加特 守護之物
UPDATE `weapon` SET `bodypart` = 'lrhand', `weaponType` = 'bigblunt' WHERE `item_id` IN (13809,13981); -- 宮廷魔法師的魔法棒/怪物用(龍馬軍戰鬥兵)
UPDATE `weapon` SET `weaponType` = 'none' WHERE `item_id` IN (13525); -- 格勒西亞士兵盾牌

-- 其他物品修正
Delete From `items` Where (`item_id` > 708 and `item_id` < 725); -- 刪除和防具同樣名稱的其他物品
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
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (30840,31262,31413,31414,31415,31416,31417,31421,31422,31423,31424,31425,31426,31426,31429,31430,31431,31666,31667,31670,31951,31973,31980);
DELETE FROM `merchant_buylists` WHERE `shop_id` IN ( SELECT `shop_id` FROM `merchant_shopids` WHERE `npc_id` IN (30840,31262,31413,31414,31415,31416,31417,31421,31422,31423,31424,31425,31426,31427,31429,31430,31431,31666,31667,31670,31951,31973,31980));
DELETE FROM `merchant_shopids` WHERE `npc_id` IN (30840,31262,31413,31414,31415,31416,31417,31421,31422,31423,31424,31425,31426,31427,31429,31430,31431,31666,31667,31670,31951,31973,31980);

-- 刪除彩券商人
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (30990,30993,30994) AND `id` NOT IN (45033);

-- 刪除其中一隻轉職管理員
-- DELETE FROM `spawnlist` WHERE `npc_templateid` IN (31756);
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (31757);

-- 修正/更新任務128 菲拉卡-冰與火之歌
UPDATE `etcitem` SET `skill` = '2150-1;', `handler` = 'SoulShots', `item_type` = 'shot', `crystal_type` = 'd' WHERE `item_id` = 13037;
UPDATE `etcitem` SET `skill` = '2153-1;', `handler` = 'SoulShots', `item_type` = 'shot', `crystal_type` = 'a' WHERE `item_id` = 13045;
UPDATE `etcitem` SET `skill` = '2153-1;', `handler` = 'SoulShots', `item_type` = 'shot', `crystal_type` = 'a' WHERE `item_id` = 13055;
UPDATE `weapon` SET `skill` = '0-0;' WHERE `item_id` = 13042;
UPDATE `npc` SET `collision_radius` = 28, `collision_height` = 20, `level` = 61, `hp` = 3450, `mp` = 1365, `patk` = 991, `pdef` = 415, `matk` = 504, `mdef` = 388, `runspd` = 187 WHERE `id` = 14916;
UPDATE `npc` SET `collision_radius` = 28, `collision_height` = 20, `level` = 70, `hp` = 4025, `mp` = 1592, `patk` = 1156, `pdef` = 484, `matk` = 588, `mdef` = 452, `runspd` = 187 WHERE `id` = 14917;


/************ CT 2.5 聖翼使命修正 ************/
-- 斗篷改為通用,不再分重/輕/法/闇天使
UPDATE `items` SET `item_id` = 13687 WHERE `item_id` IN (13688,13689,13690); -- 輕/法/闇天使的騎士斗篷改通用斗篷
UPDATE `items` SET `item_id` = 13890 WHERE `item_id` IN (13889,13891,13892); -- 輕/法/闇天使的聖靈斗篷改通用斗篷
UPDATE `items` SET `item_id` = 14609 WHERE `item_id` IN (14601,14602,14608,14610); -- 輕/法/闇天使的古代斗篷改通用斗篷
DELETE FROM `merchant_buylists` WHERE `item_id` IN (13688,13689,13690,13889,13891,13892,14601,14602,14608,14610); -- 刪除輕/法/闇天使的斗篷的販賣

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


/************ CT 2.6 芙蕾雅修正 ************/
-- 新搜魂石-階段17.18

-- 新生命石-85.86級

-- 新壺精(三頭龍/格諾席安控球/奧羅德利爾控球/十二碼罰球)

-- 新頭飾(天使/冰結/骷髏頭箍/鯊魚/金角/銀角/企鵝/頭巾/烏龜/牛牛/龍舟帽/足球爆炸頭/京劇面具-劉備/關羽/張飛)
REPLACE INTO `armor` VALUES
(17033,'Circlet of Freeze - For Events','30 day limited period','none','false','none',10,'wood','none',0,-1,43200,0,0,0,0,0,'false','false','false','false','false','0-0','8497-1;');

-- 新飾品(殤曲/博佩斯/天命)

-- 新BOSS飾品(芙蕾雅項鍊)

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

-- 特別為泰森迪武器增加魂石效果
UPDATE `weapon` SET `skill` = '8297-1;' WHERE `item_id` = 15676;
UPDATE `weapon` SET `skill` = '8297-1;' WHERE `item_id` = 15677;
UPDATE `weapon` SET `skill` = '3568-1;' WHERE `item_id` = 15678;
UPDATE `weapon` SET `skill` = '3568-1;' WHERE `item_id` = 15679;
UPDATE `weapon` SET `skill` = '8297-1;' WHERE `item_id` = 15680;
UPDATE `weapon` SET `skill` = '8289-1;' WHERE `item_id` = 15681;
UPDATE `weapon` SET `skill` = '3599-1;8297-1;' WHERE `item_id` = 15682;
UPDATE `weapon` SET `skill` = '3047-3;' WHERE `item_id` = 15683;
UPDATE `weapon` SET `skill` = '3575-2;' WHERE `item_id` = 15684;
UPDATE `weapon` SET `skill` = '3047-3;' WHERE `item_id` = 15685;
UPDATE `weapon` SET `skill` = '8298-1;' WHERE `item_id` = 15686;
UPDATE `weapon` SET `skill` = '8297-1;' WHERE `item_id` = 15687;
UPDATE `weapon` SET `skill` = '8297-1;' WHERE `item_id` = 15688;
UPDATE `weapon` SET `skill` = '8296-1;' WHERE `item_id` = 15689;

-- 新防具(殤曲/博佩斯/天命)

-- 新盾牌(殤曲/博佩斯/天命)

-- 新防具的套裝效果

-- 新武器(S84上級/S84特級)

/************ Add by pmq *********/
-- 地獄道具
UPDATE `etcitem` SET `handler` = 'PaganKeys' WHERE `item_id` = '9685';  -- 黑暗之門的鑰匙
UPDATE `etcitem` SET `handler` = 'PaganKeys' WHERE `item_id` = '9686';  -- 破壞之門的鑰匙
UPDATE `etcitem` SET `handler` = 'PaganKeys' WHERE `item_id` = '9687';  -- 血之門的鑰匙
REPLACE INTO `etcitem` VALUES (9849,'Fiery Demon Blood','','false','herb',0,'normal','paper','none',-1,-1,0,0,'true','true','true','true','true','ItemSkills','2357-1;');  -- 惡魔溫熱的血

-- 肉體破壞者 靈魂蠶食者
REPLACE INTO `minions` VALUES (22363, 22364, 4, 4);
REPLACE INTO `minions` VALUES (22370, 22371, 4, 4);

-- 增加 SteelCitade 1/F 2/F
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (22363,22365,22367,22368,22369,22370,22372);
REPLACE INTO `spawnlist` VALUES
('','', 1, 22363, 16290, 282328, -9709, 0, 0, 15719, 120, 0, 0),
('','', 1, 22363, 16287, 281847, -9709, 0, 0, 50191, 120, 0, 0),
('','', 1, 22368, 18755, 280971, -9710, 0, 0, 381, 120, 0, 0),
('','', 1, 22367, 19884, 280967, -9710, 0, 0, 31385, 120, 0, 0),
('','', 1, 22365, 18389, 280744, -9710, 0, 0, 434, 120, 0, 0),
('','', 1, 22367, 19681, 280509, -9710, 0, 0, 32912, 120, 0, 0),
('','', 1, 22365, 17709, 280523, -9710, 0, 0, 1265, 120, 0, 0),
('','', 1, 22369, 18277, 280519, -9710, 0, 0, 65380, 120, 0, 0),
('','', 1, 22369, 18924, 280523, -9710, 0, 0, 32100, 120, 0, 0),
('','', 1, 22367, 19258, 279942, -9710, 0, 0, 65089, 120, 0, 0),
('','', 1, 22367, 13470, 282570, -9710, 0, 0, 16162, 120, 0, 0),
('','', 1, 22367, 18273, 279953, -9710, 0, 0, 406, 120, 0, 0),
('','', 1, 22365, 18362, 279668, -9710, 0, 0, 525, 120, 0, 0),
('','', 1, 22369, 18689, 279678, -9710, 0, 0, 448, 120, 0, 0),
('','', 1, 22365, 19120, 279672, -9710, 0, 0, 65149, 120, 0, 0),
('','', 1, 22369, 18902, 279414, -9710, 0, 0, 89, 120, 0, 0),
('','', 1, 22369, 13701, 282933, -9710, 0, 0, 17019, 120, 0, 0),
('','', 1, 22368, 19703, 279685, -9710, 0, 0, 31728, 120, 0, 0),
('','', 1, 22368, 19799, 279411, -9710, 0, 0, 31886, 120, 0, 0),
('','', 1, 22365, 19857, 278725, -9710, 0, 0, 32607, 120, 0, 0),
('','', 1, 22368, 19805, 278942, -9710, 0, 0, 34993, 120, 0, 0),
('','', 1, 22368, 19493, 278723, -9710, 0, 0, 34230, 120, 0, 0),
('','', 1, 22365, 19120, 278733, -9710, 0, 0, 33455, 120, 0, 0),
('','', 1, 22369, 18817, 278731, -9710, 0, 0, 32941, 120, 0, 0),
('','', 1, 22367, 19753, 278498, -9710, 0, 0, 32246, 120, 0, 0),
('','', 1, 22369, 19232, 278732, -9710, 0, 0, 896, 120, 0, 0),
('','', 1, 22365, 19244, 278045, -9709, 0, 0, 64735, 120, 0, 0),
('','', 1, 22369, 19190, 277515, -9710, 0, 0, 49267, 120, 0, 0),
('','', 1, 22365, 18543, 277340, -9710, 0, 0, 32767, 120, 0, 0),
('','', 1, 22369, 18757, 277083, -9710, 0, 0, 64442, 120, 0, 0),
('','', 1, 22367, 18377, 276792, -9710, 0, 0, 62597, 120, 0, 0),
('','', 1, 22368, 19526, 276891, -9709, 0, 0, 0, 120, 0, 0),
('','', 1, 22365, 19880, 276892, -9710, 0, 0, 29, 120, 0, 0),
('','', 1, 22367, 19518, 276690, -9710, 0, 0, 37501, 120, 0, 0),
('','', 1, 22365, 15419, 283358, -9710, 0, 0, 48804, 120, 0, 0),
('','', 1, 22367, 15199, 283193, -9710, 0, 0, 48866, 120, 0, 0),
('','', 1, 22368, 14958, 282490, -9710, 0, 0, 49264, 120, 0, 0),
('','', 1, 22368, 14380, 283653, -9710, 0, 0, 32372, 120, 0, 0),
('','', 1, 22365, 14379, 282802, -9710, 0, 0, 49139, 120, 0, 0),
('','', 1, 22367, 14170, 282812, -9710, 0, 0, 15109, 120, 0, 0),
('','', 1, 22369, 14170, 283242, -9710, 0, 0, 15986, 120, 0, 0),
('','', 1, 22368, 13946, 283012, -9710, 0, 0, 15955, 120, 0, 0),
('','', 1, 22365, 13932, 282531, -9710, 0, 0, 49238, 120, 0, 0),
('','', 1, 22368, 13459, 283155, -9710, 0, 0, 16749, 120, 0, 0),
('','', 1, 22365, 13475, 283672, -9710, 0, 0, 16061, 120, 0, 0),
('','', 1, 22369, 13248, 283522, -9709, 0, 0, 49310, 120, 0, 0),
('','', 1, 22367, 13249, 283068, -9709, 0, 0, 49381, 120, 0, 0),
('','', 1, 22369, 13235, 282705, -9710, 0, 0, 49151, 120, 0, 0),
('','', 1, 22365, 13000, 282703, -9710, 0, 0, 16726, 120, 0, 0),
('','', 1, 22368, 12772, 283174, -9710, 0, 0, 53514, 120, 0, 0),
('','', 1, 22367, 13003, 283655, -9710, 0, 0, 46111, 120, 0, 0),
('','', 1, 22365, 12734, 283802, -9710, 0, 0, 50338, 120, 0, 0),
('','', 1, 22368, 12748, 281470, -9710, 0, 0, 16123, 120, 0, 0),
('','', 1, 22367, 13648, 281478, -9710, 0, 0, 32478, 120, 0, 0),
('','', 1, 22368, 14285, 281484, -9710, 0, 0, 999, 120, 0, 0),
('','', 1, 22369, 14018, 281701, -9710, 0, 0, 30640, 120, 0, 0),
('','', 1, 22365, 13469, 281697, -9710, 0, 0, 32998, 120, 0, 0),
('','', 1, 22368, 14739, 281691, -9710, 0, 0, 49151, 120, 0, 0),
('','', 1, 22367, 14955, 281437, -9710, 0, 0, 49151, 120, 0, 0),
('','', 1, 22369, 15190, 281139, -9713, 0, 0, 47583, 120, 0, 0),
('','', 1, 22365, 15213, 281654, -9710, 0, 0, 49151, 120, 0, 0),
('','', 1, 22365, 15195, 280519, -9710, 0, 0, 15148, 120, 0, 0),
('','', 1, 22368, 14831, 280310, -9710, 0, 0, 63609, 120, 0, 0),
('','', 1, 22369, 14731, 280993, -9710, 0, 0, 16706, 120, 0, 0),
('','', 1, 22365, 13584, 281252, -9710, 0, 0, 34128, 120, 0, 0),
('','', 1, 22369, 13822, 281028, -9710, 0, 0, 0, 120, 0, 0),
('','', 1, 22369, 13173, 281029, -9710, 0, 0, 32824, 120, 0, 0),
('','', 1, 22368, 12750, 281018, -9713, 0, 0, 64923, 120, 0, 0),
('','', 1, 22365, 12969, 280740, -9710, 0, 0, 64856, 120, 0, 0),
('','', 1, 22367, 13616, 280744, -9710, 0, 0, 65045, 120, 0, 0),
('','', 1, 22365, 14322, 280744, -9710, 0, 0, 31587, 120, 0, 0),
('','', 1, 22369, 14174, 280528, -9710, 0, 0, 33019, 120, 0, 0),
('','', 1, 22368, 13699, 280524, -9710, 0, 0, 62180, 120, 0, 0),
('','', 1, 22369, 13905, 280305, -9710, 0, 0, 32614, 120, 0, 0),
('','', 1, 22367, 13182, 280316, -9710, 0, 0, 32393, 120, 0, 0),
('','', 1, 22368, 12720, 280289, -9710, 0, 0, 34630, 120, 0, 0),
('','', 1, 22368, 12963, 279970, -9713, 0, 0, 32854, 120, 0, 0),
('','', 1, 22369, 13002, 279682, -9710, 0, 0, 32767, 120, 0, 0),
('','', 1, 22365, 14423, 279946, -9710, 0, 0, 65290, 120, 0, 0),
('','', 1, 22368, 14089, 279699, -9710, 0, 0, 33316, 120, 0, 0),
('','', 1, 22367, 13554, 279691, -9710, 0, 0, 32835, 120, 0, 0),
('','', 1, 22369, 13893, 279438, -9710, 0, 0, 32344, 120, 0, 0),
('','', 1, 22365, 13375, 279445, -9710, 0, 0, 32677, 120, 0, 0),
('','', 1, 22367, 12881, 279449, -9710, 0, 0, 32516, 120, 0, 0),
('','', 1, 22368, 13459, 279196, -9710, 0, 0, 360, 120, 0, 0),
('','', 1, 22369, 13754, 278971, -9710, 0, 0, 553, 120, 0, 0),
('','', 1, 22367, 13310, 278975, -9710, 0, 0, 32658, 120, 0, 0),
('','', 1, 22365, 12920, 278977, -9710, 0, 0, 32635, 120, 0, 0),
('','', 1, 22369, 13727, 278723, -9709, 0, 0, 65259, 120, 0, 0),
('','', 1, 22369, 13164, 278733, -9710, 0, 0, 32426, 120, 0, 0),
('','', 1, 22368, 13152, 278517, -9713, 0, 0, 33241, 120, 0, 0),
('','', 1, 22367, 13144, 278274, -9709, 0, 0, 65349, 120, 0, 0),
('','', 1, 22368, 13647, 278278, -9710, 0, 0, 32914, 120, 0, 0),
('','', 1, 22369, 12852, 278056, -9710, 0, 0, 65082, 120, 0, 0),
('','', 1, 22368, 12839, 277811, -9710, 0, 0, 63532, 120, 0, 0),
('','', 1, 22369, 13862, 278060, -9710, 0, 0, 65031, 120, 0, 0),
('','', 1, 22365, 13381, 278064, -9713, 0, 0, 32681, 120, 0, 0),
('','', 1, 22367, 13971, 277821, -9710, 0, 0, 31622, 120, 0, 0),
('','', 1, 22368, 13381, 277819, -9710, 0, 0, 33388, 120, 0, 0),
('','', 1, 22369, 13716, 277594, -9710, 0, 0, 31113, 120, 0, 0),
('','', 1, 22367, 14399, 277473, -9710, 0, 0, 32691, 120, 0, 0),
('','', 1, 22367, 12896, 277352, -9710, 0, 0, 521, 120, 0, 0),
('','', 1, 22365, 13096, 277598, -9710, 0, 0, 64117, 120, 0, 0),
('','', 1, 22365, 13535, 277350, -9710, 0, 0, 32853, 120, 0, 0),
('','', 1, 22368, 13979, 277111, -9710, 0, 0, 25154, 120, 0, 0),
('','', 1, 22365, 13549, 276847, -9710, 0, 0, 49648, 120, 0, 0),
('','', 1, 22369, 12969, 276905, -9710, 0, 0, 65173, 120, 0, 0),
('','', 1, 22367, 13879, 276872, -9710, 0, 0, 32938, 120, 0, 0),
('','', 1, 22365, 14355, 276794, -9710, 0, 0, 32465, 120, 0, 0),
('','', 1, 22370, 19751, 277009, -7558, 0, 0, 49582, 120, 0, 0),
('','', 1, 22370, 19751, 278028, -7558, 0, 0, 49681, 120, 0, 0),
('','', 1, 22370, 19747, 279082, -7558, 0, 0, 49151, 120, 0, 0),
('','', 1, 22370, 19752, 280123, -7558, 0, 0, 48646, 120, 0, 0),
('','', 1, 22370, 19288, 280127, -7558, 0, 0, 16800, 120, 0, 0),
('','', 1, 22370, 19284, 279089, -7558, 0, 0, 15983, 120, 0, 0),
('','', 1, 22370, 19285, 278024, -7558, 0, 0, 17441, 120, 0, 0),
('','', 1, 22370, 19288, 276979, -7558, 0, 0, 15260, 120, 0, 0),
('','', 1, 22370, 18812, 276976, -7558, 0, 0, 49795, 120, 0, 0),
('','', 1, 22370, 18812, 278022, -7558, 0, 0, 49391, 120, 0, 0),
('','', 1, 22370, 18807, 279088, -7558, 0, 0, 49289, 120, 0, 0),
('','', 1, 22370, 18809, 280128, -7558, 0, 0, 48425, 120, 0, 0),
('','', 1, 22370, 18343, 280125, -7558, 0, 0, 16584, 120, 0, 0),
('','', 1, 22370, 18354, 279084, -7558, 0, 0, 14193, 120, 0, 0),
('','', 1, 22370, 18349, 278023, -7558, 0, 0, 16383, 120, 0, 0),
('','', 1, 22370, 18346, 276961, -7558, 0, 0, 16383, 120, 0, 0),
('','', 1, 22370, 16552, 276721, -7556, 0, 0, 1780, 120, 0, 0),
('','', 1, 22370, 16554, 277284, -7556, 0, 0, 65142, 120, 0, 0),
('','', 1, 22370, 16556, 277847, -7556, 0, 0, 65170, 120, 0, 0),
('','', 1, 22372, 15988, 277852, -7556, 0, 0, 512, 120, 0, 0),
('','', 1, 22372, 15990, 277285, -7556, 0, 0, 578, 120, 0, 0),
('','', 1, 22372, 15993, 276724, -7556, 0, 0, 64654, 120, 0, 0),
('','', 1, 22370, 14843, 277368, -7558, 0, 0, 49580, 120, 0, 0),
('','', 1, 22372, 14841, 277060, -7558, 0, 0, 16383, 120, 0, 0),
('','', 1, 22372, 14843, 277704, -7558, 0, 0, 16183, 120, 0, 0),
('','', 1, 22370, 13222, 276596, -7558, 0, 0, 32841, 120, 0, 0),
('','', 1, 22370, 13369, 277449, -7556, 0, 0, 49795, 120, 0, 0),
('','', 1, 22370, 13745, 277448, -7556, 0, 0, 49712, 120, 0, 0),
('','', 1, 22372, 13747, 277728, -7558, 0, 0, 48585, 120, 0, 0),
('','', 1, 22372, 13360, 277720, -7558, 0, 0, 47854, 120, 0, 0),
('','', 1, 22370, 13742, 279238, -7556, 0, 0, 15657, 120, 0, 0),
('','', 1, 22370, 13367, 279241, -7556, 0, 0, 15131, 120, 0, 0),
('','', 1, 22372, 13375, 279471, -7558, 0, 0, 17184, 120, 0, 0),
('','', 1, 22372, 13750, 279480, -7558, 0, 0, 15640, 120, 0, 0),
('','', 1, 22370, 13371, 280419, -7556, 0, 0, 13536, 120, 0, 0),
('','', 1, 22372, 13369, 280658, -7558, 0, 0, 16383, 120, 0, 0),
('','', 1, 22370, 13746, 280420, -7556, 0, 0, 16779, 120, 0, 0),
('','', 1, 22372, 13742, 280662, -7558, 0, 0, 16383, 120, 0, 0),
('','', 1, 32302, 13293, 282023, -7555, 0, 0, 38182, 120, 0, 0);

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

REPLACE INTO `minions` VALUES (22448, 22451, 2, 2); -- 雷歐達斯 反抗軍指揮官
REPLACE INTO `minions` VALUES (22449, 22450, 8, 8); -- 亞邁士康里 拷問專家

-- 刪除地獄NPC轉為AI出現
DELETE FROM `spawnlist` WHERE `npc_templateid` IN (32297,32354,32345,18463,18464,32355,32362,32363,32364,22341,22448,32314);
-- HBCE
REPLACE INTO `etcitem` VALUES (13787,'Bond','','false','potion',180,'stackable','paper','none',-1,-1,0,0,'true','true','true','true','true','ItemSkills','5849-1;');
REPLACE INTO `etcitem` VALUES (13788,'Land Mine','','false','potion',180,'stackable','paper','none',-1,-1,0,0,'true','true','true','true','true','ItemSkills','5851-1;');
UPDATE `npc` SET `type`='L2Block' where id='18672';      -- 方塊
UPDATE `npc` SET `type`='L2Block' where id='18676';      -- 方塊
-- 殤之大地守門人
INSERT INTO spawnlist VALUES
('','', 1, 18467, 21, 234997, -3272, 0, 0, 32767, 300, 0, 0),
('','', 1, 18467, 1, 234887, -3272, 0, 0, 32189, 300, 0, 0),
('','', 1, 18467, 0, 235109, -3272, 0, 0, 33989, 300, 0, 0);


-- Seed OF Destruction
REPLACE INTO `npc` VALUES 
(18678,18678,'Energy Seed - Water',0,'',0,'LineageNPC.seed_click_dummy_water',10.00,10.00,70,'male','L2Npc',40,2444,2444,0.00,0.00,10,10,10,10,10,10,0,0,500,500,500,500,278,0,333,0,0,0,0,60,60,0,0,1),
(18679,18679,'Energy Seed - Fire',0,'',0,'LineageNPC.seed_click_dummy_fire',10.00,10.00,70,'male','L2Npc',40,2444,2444,0.00,0.00,10,10,10,10,10,10,0,0,500,500,500,500,278,0,333,0,0,0,0,60,60,0,0,1),
(18680,18680,'Energy Seed - Wind',0,'',0,'LineageNPC.seed_click_dummy_wind',10.00,10.00,70,'male','L2Npc',40,2444,2444,0.00,0.00,10,10,10,10,10,10,0,0,500,500,500,500,278,0,333,0,0,0,0,60,60,0,0,1),
(18681,18681,'Energy Seed - Earth',0,'',0,'LineageNPC.seed_click_dummy_earth',10.00,10.00,70,'male','L2Npc',40,2444,2444,0.00,0.00,10,10,10,10,10,10,0,0,500,500,500,500,278,0,333,0,0,0,0,60,60,0,0,1),
(18682,18682,'Energy Seed - Divinity',0,'',0,'LineageNPC.seed_click_dummy_holy',10.00,10.00,70,'male','L2Npc',40,2444,2444,0.00,0.00,10,10,10,10,10,10,0,0,500,500,500,500,278,0,333,0,0,0,0,60,60,0,0,1),
(18683,18683,'Energy Seed - Darkness',0,'',0,'LineageNPC.seed_click_dummy_dark',10.00,10.00,70,'male','L2Npc',40,2444,2444,0.00,0.00,10,10,10,10,10,10,0,0,500,500,500,500,278,0,333,0,0,0,0,60,60,0,0,1),
(18696,18696,'Dimension Moving Device',0,'',0,'LineageNpcEV.teleport_gate_of_legion',44.50,7.00,85,'female','L2Monster',40,21338,2050,0.00,0.00,40,43,30,21,20,20,0,0,2462,3286,1146,511,253,0,333,0,0,0,0,60,60,0,0,1),
(18720,18720,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18721,18721,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18722,18722,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18723,18723,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18724,18724,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18725,18725,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18729,18729,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18730,18730,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18731,18731,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18732,18732,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18737,18737,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18739,18739,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18740,18740,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18741,18741,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18742,18742,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18743,18743,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18744,18744,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18745,18745,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18748,18748,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18749,18749,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18753,18753,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18754,18754,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18755,18755,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18756,18756,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18758,18758,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18771,18771,'Trap',0,'',0,'LineageNpc2.trap_mark',5.00,10.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,60,60,0,0,1),
(18776,18776,'Obelisk',0,'',0,'LineageNpcEV.obelisk_of_middle_square',229.00,177.50,82,'female','L2Monster',40,52055,1935,0.00,0.00,40,43,30,21,20,20,0,0,11789,1964,5477,2332,253,0,333,0,0,0,0,60,60,0,0,1),
(18777,18777,'Great Powerful Device',0,'',0,'LineageNpcEV.crystal_of_secret_door',57.00,74.00,82,'female','L2Monster',40,52055,1935,0.00,0.00,40,43,30,21,20,20,0,0,11789,1964,5477,2332,253,0,333,0,0,0,0,60,60,0,0,1),
(18778,18778,'Throne of Destruction Powerful Device',0,'',0,'LineageNpcEV.protector_of_seed',57.00,74.00,70,'male','L2Monster',40,52055,1935,0.00,0.00,40,43,30,21,20,20,0,0,11789,1964,5477,2332,253,0,333,0,0,0,0,60,60,0,0,1),
(22536,22536,'Royal Guard Captain',0,'',0,'LineageMonster4.Dragon_eliteguard_075p',40.00,55.00,84,'male','L2Monster',40,51737,2011,13.55,3.09,40,43,30,21,20,20,333644,33883,12017,1982,5587,2414,278,800,333,0,0,0,0,80,180,0,0,1),
(22537,22537,'Dragon Steed Troop Grand Magician',0,'',0,'LineageMonster4.Dragon_archmage_135p',25.00,49.90,84,'male','L2Monster',40,51737,2011,13.55,3.09,40,43,30,21,20,20,73171,7447,12017,1982,5587,2414,278,800,333,0,0,0,0,80,180,0,0,1),
(22538,22538,'Dragon Steed Troop Commander',0,'',0,'LineageMonster4.Dragon_centurion_135p',28.00,46.50,83,'male','L2Monster',40,51870,1973,13.55,3.09,40,43,30,21,20,20,96783,10083,11903,974,5534,2332,278,800,333,13978,0,0,0,80,180,0,0,1),
(22539,22539,'Dragon Steed Troops No 1 Battalion Commander',0,'',0,'LineageMonster4.Dragon_centurion_135p',28.00,46.50,82,'male','L2Monster',40,52055,1935,13.55,3.09,40,43,30,21,20,20,98080,10347,11789,1964,5477,2332,278,800,333,13978,0,0,0,80,180,0,0,1),
(22540,22540,'White Dragon Leader',0,'',0,'LineageMonster4.Dragon_centurion_120p',22.00,42.00,81,'male','L2Monster',40,52146,1897,13.55,3.09,40,43,30,21,20,20,82134,8708,11673,1880,5427,2290,278,800,333,13979,13980,0,0,80,180,0,0,1),
(22541,22541,'Dragon Steed Troop Infantry',0,'',0,'LineageMonster4.Dragon_centurion_120p',22.00,42.00,80,'male','L2Monster',40,52288,1859,13.55,3.09,40,43,30,21,20,20,83347,8955,11557,1846,5374,2250,278,800,333,13979,13980,0,0,80,180,0,0,1),
(22542,22542,'Dragon Steed Troop Magic Leader',0,'',0,'LineageMonster4.dragon_mage_075p',28.00,39.50,82,'male','L2Monster',40,52055,1935,13.55,3.09,40,43,30,21,20,20,193521,21161,11789,1964,5477,2332,278,800,333,0,0,0,0,80,180,0,0,1),
(22543,22543,'Dragon Steed Troop Magician',0,'',0,'LineageMonster4.dragon_mage_075p',28.00,39.50,81,'male','L2Monster',40,52146,1897,13.55,3.09,40,43,30,21,20,20,79493,8397,11673,1880,5427,2290,278,800,333,0,0,0,0,80,180,0,0,1),
(22544,22544,'Dragon Steed Troop Magic Soldier',0,'',0,'LineageMonster4.dragon_mage_065p',25.00,34.50,80,'male','L2Monster',40,52288,1859,13.55,3.09,40,43,30,21,20,20,84936,9090,11557,1846,5374,2250,278,800,333,13981,0,0,0,80,180,0,0,1),
(22546,22546,'Warrior of Light',0,'',0,'LineageMonster4.dragon_berserker_090p',50.00,55.00,79,'male','L2Monster',40,52385,1822,13.55,3.09,40,43,30,21,20,20,82511,8653,11354,1812,5279,2208,278,800,333,0,0,0,0,80,180,0,0,1),
(22547,22547,'Dragon Steed Troop Healer',0,'',0,'LineageMonster4.dragon_mage_065p',25.00,34.50,79,'male','L2Monster',40,52385,1822,13.55,3.09,40,43,30,21,20,20,59035,6215,11354,1812,5279,2208,278,800,333,13981,0,0,0,80,180,0,0,1),
(22548,22548,'Dragon Steed Troop Javelin Thrower',0,'',0,'LineageMonster4.dragon_peltast',25.00,46.50,80,'male','L2Monster',1100,52288,1859,13.55,3.09,40,43,30,21,20,20,94968,10260,11557,1846,5374,2250,278,800,333,13843,0,0,0,80,180,0,0,1),
(22549,22549,'Dragon Steed Troop Javelin Thrower',0,'',0,'LineageMonster4.dragon_peltast',25.00,46.50,80,'male','L2Monster',1100,52288,1859,13.55,3.09,40,43,30,21,20,20,94968,10260,11557,1846,5374,2250,278,800,333,13843,0,0,0,80,180,0,0,1),
(22550,22550,'Savage Warrior',0,'',0,'LineageMonster4.ravager_silen',27.00,48.50,77,'male','L2Monster',40,31011,1747,13.55,3.09,40,43,30,21,20,20,103619,10725,8198,1744,3808,2124,278,800,333,13987,0,0,0,80,180,0,0,1),
(22551,22551,'Priest of Darkness',0,'',0,'LineageMonster4.disciple_silen',19.00,44.00,76,'male','L2Monster',40,31021,1710,13.55,3.09,40,43,30,21,20,20,95778,9756,8031,1710,3734,2082,278,800,333,0,0,0,0,80,180,0,0,1),
(22552,22552,'Mutation Drake',0,'',0,'LineageMonster4.Mutant_drake',48.00,53.50,78,'male','L2Monster',40,52476,1784,0.00,0.00,40,43,30,21,20,20,92347,9614,11141,1778,5176,2166,278,800,333,0,0,0,0,80,180,0,0,1),
(22593,22593,'Dragon Steed Troop Magic Soldier',0,'',0,'LineageMonster4.dragon_mage_065p',25.00,34.50,81,'male','L2Monster',40,52385,1935,13.55,3.09,40,43,30,21,20,20,94968,10260,11557,1846,5374,2250,278,800,333,13981,0,0,0,80,180,0,0,1),
(22596,22596,'White Dragon Leader',0,'',0,'LineageMonster4.Dragon_centurion_120p',22.00,42.00,81,'male','L2Monster',40,52385,1935,13.55,3.09,40,43,30,21,20,20,94968,10260,11557,1846,5374,2250,278,800,333,13979,13980,0,0,80,180,0,0,1),
(22597,22597,'Dragon Steed Troop Infantry',0,'',0,'LineageMonster4.Dragon_centurion_120p',22.00,42.00,82,'male','L2Monster',40,52385,1935,13.55,3.09,40,43,30,21,20,20,94968,10260,11557,1846,5374,2250,278,800,333,13979,13980,0,0,80,180,0,0,1),
(29162,29162,'Soldiers of Bravery',0,'Tiat\'s Bodyguards',0,'LineageMonster4.dragon_rider',36.00,51.00,85,'male','L2Monster',80,528731,2050,13.00,3.00,40,43,30,21,20,20,1322725,139467,16366,2014,7605,2454,278,0,333,0,0,0,0,80,180,0,0,1),
(29163,29163,'Tiat',0,'Witch of the Dragon of Darkness',0,'LineageMonster4.tiat',55.00,104.00,85,'female','L2GrandBoss',40,8727677,204995,2856.00,265.32,60,57,73,76,70,80,0,0,6406,1846,2979,1344,278,0,333,0,0,0,0,80,180,0,0,1),
(29167,29167,'',0,'',0,'LineageNPC.clear_npc',0.10,0.10,70,'male','L2Monster',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,150,333,0,0,0,0,60,60,0,0,1),
(29175,29175,'Tiat',0,'Witch of the Dragon of Darkness',0,'LineageMonster4.tiat',55.00,104.00,85,'female','L2GrandBoss',40,8727677,204995,2856.00,265.32,60,57,73,76,70,80,0,0,6406,1846,2979,1344,278,0,333,0,0,0,0,80,180,0,0,1);
-- Seed OF Destruction
REPLACE INTO `npcaidata` VALUES
(22536,25,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'balanced'),
(22537,70,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'mage'),
(22538,25,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'balanced'),
(22539,25,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'balanced'),
(22540,25,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'balanced'),
(22541,25,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'balanced'),
(22542,25,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'balanced'),
(22543,70,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'mage'),
(22544,25,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'balanced'),
(22545,25,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'balanced'),
(22546,25,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'balanced'),
(22547,90,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'healer'),
(22548,40,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,15,'archer'),
(22549,40,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,15,'archer'),
(22550,25,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'balanced'),
(22551,25,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'balanced'),
(22552,25,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'balanced'),
(22593,25,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'balanced'),
(22596,25,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'balanced'),
(22597,25,NULL,NULL,NULL,NULL,NULL,NULL,50,25,20,20,NULL,'SeedOfDestruction',100,NULL,NULL,NULL,'balanced'),
(29162,50,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,'Tiat',900,NULL,NULL,NULL,'balanced'),
(29163,50,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,'Tiat',900,NULL,NULL,NULL,'balanced'),
(29175,50,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL,'Tiat',900,NULL,NULL,NULL,'balanced');

-- 菲拉卡-惡魔的遺產
UPDATE `npc` SET `type`='L2Monster', `hp`=100, `exp`=0, `sp`=0, `walkspd`=0, `runspd`=0 where id='32495';  -- 寶箱
UPDATE `npc` SET `type`='L2Monster', `hp`=100, `exp`=1521, `sp`=126, `walkspd`=0, `runspd`=0 where id='18622';  -- 火藥桶
UPDATE `npc` SET `hp`=4814, `exp`=9631, `sp`=819, `aggro`=400 where id='18623';  -- 怨恨的弓手
UPDATE `npc` SET `hp`=4225, `exp`=5655, `sp`=453, `aggro`=400 where id='18624';  -- 死者的怨恨
UPDATE `npc` SET `hp`=4344, `exp`=6255, `sp`=522, `aggro`=400 where id='18625';  -- 死者的怨恨
UPDATE `npc` SET `hp`=4530, `exp`=6886, `sp`=597, `aggro`=400 where id='18626';  -- 死者的怨恨
UPDATE `npc` SET `hp`=4530, `exp`=6886, `sp`=597, `aggro`=400 where id='18627';  -- 死者的怨恨
UPDATE `npc` SET `hp`=89279, `exp`=189547, `sp`=16686 where id='18629';  -- 卡姆士
UPDATE `npc` SET `hp`=89279, `exp`=189547, `sp`=16686 where id='18630';  -- 日比
UPDATE `npc` SET `hp`=89279, `exp`=189547, `sp`=16686 where id='18631';  -- 瓦克守
UPDATE `npc` SET `hp`=89279, `exp`=194641, `sp`=17856 where id='18632';  -- 格魯巴拉
UPDATE `npc` SET `hp`=176244, `exp`=953463, `sp`=69240 where id='18633';  -- 雷馬堂

REPLACE INTO npcskills VALUES
-- 龍馬軍 步兵
-- Dragon Steed Troop Infantry
(22541,4299,1),
(22541,4412,15),
(22541,5274,9),
(22541,5827,6),
(22541,5832,1),
-- 龍馬軍 步兵
-- Dragon Steed Troop Infantry
(22597,4299,1),
(22597,4412,15),
(22597,5274,9),
(22597,5827,6),
(22597,5832,1),
-- 龍馬軍 步兵
-- Dragon Steed Troop Infantry
(22589,4299,1),
(22589,4412,15),
(22589,5274,9),
(22589,5827,6),
(22589,5832,1),
-- 龍馬軍 步兵
-- Dragon Steed Troop Infantry
(22575,4299,1),
(22575,4412,15),
(22575,5274,9),
(22575,5827,6),
(22575,5832,1),
-- 黑暗祭司
-- Priest of Darkness
(22551,4295,1),
(22551,5828,6),
(22551,5839,1),
-- 龍馬軍 魔法師
-- Dragon Steed Troop Magician
(22543,5829,6),
(22543,5827,6),
(22543,5312,9),
(22543,4299,1),
(22543,5833,1),
-- 龍馬軍 魔法師
-- Dragon Steed Troop Magician
(22577,5829,6),
(22577,5827,6),
(22577,5312,9),
(22577,4299,1),
(22577,5833,1),
-- 龍馬軍 魔法師
-- Dragon Steed Troop Magician
(22584,5829,6),
(22584,5827,6),
(22584,5312,9),
(22584,4299,1),
(22584,5833,1),
-- 龍馬軍 魔法師
-- Dragon Steed Troop Magician
(22592,5829,6),
(22592,5827,6),
(22592,5312,9),
(22592,4299,1),
(22592,5833,1),
-- 突變龍獸
-- Mutation Drake
(22552,5274,9),
(22552,4299,1),
-- 龍馬軍 標槍兵
-- Dragon Steed Troop Javelin Thrower
(22549,4299,1),
(22549,4412,10),
(22549,4413,10),
(22549,5837,1),
(22549,5838,1),
-- 龍馬軍 標槍兵
-- Dragon Steed Troop Javelin Thrower
(22548,4299,1),
(22548,4412,10),
(22548,4413,10),
(22548,5837,1),
(22548,5838,1),
-- 龍馬軍 標槍兵
-- Dragon Steed Troop Javelin Thrower
(22581,4299,1),
(22581,4412,10),
(22581,4413,10),
(22581,5837,1),
(22581,5838,1),
-- 龍馬軍 標槍兵
-- Dragon Steed Troop Javelin Thrower
(22582,4299,1),
(22582,4412,10),
(22582,4413,10),
(22582,5837,1),
(22582,5838,1),
-- 龍馬軍 軍團長
-- Dragon Steed Troop Commander
(22538,4299,1),
(22538,5830,1),
(22538,5831,1),
(22538,5827,6),
(22538,4408,10),
(22538,4410,13),
(22538,4413,15),
(22538,4441,5),
(22538,4071,5),
-- 龍馬軍 軍團長
-- Dragon Steed Troop Commander
(22572,4299,1),
(22572,5830,1),
(22572,5831,1),
(22572,5827,6),
(22572,4408,10),
(22572,4410,13),
(22572,4413,15),
(22572,4441,5),
(22572,4071,5),
-- 龍馬軍 軍團長
-- Dragon Steed Troop Commander
(22586,4299,1),
(22586,5830,1),
(22586,5831,1),
(22586,5827,6),
(22586,4408,10),
(22586,4410,13),
(22586,4413,15),
(22586,4441,5),
(22586,4071,5),
-- 龍馬軍 軍團長
-- Dragon Steed Troop Commander
(22594,4299,1),
(22594,5830,1),
(22594,5831,1),
(22594,5827,6),
(22594,4408,10),
(22594,4410,13),
(22594,4413,15),
(22594,4441,5),
(22594,4071,5),
-- 親衛隊長
-- Royal Guard Captain
(22536,4299,1),
(22536,4410,13),
(22536,5826,3),
(22536,5274,9),
(22536,5362,9),
-- 親衛隊長
-- Royal Guard Captain
(22570,4299,1),
(22570,4410,13),
(22570,5826,3),
(22570,5274,9),
(22570,5362,9),
-- 敢死隊 蒂雅特親衛隊
-- Soldiers of Bravery (Tiats Bodyguards)
(29162,4299,1),
(29162,4410,13),
(29162,5259,12),
(29162,5309,9),
(29162,5826,3),
-- 敢死隊 蒂雅特親衛隊
-- Soldiers of Bravery (Tiats Bodyguards)
(22569,4299,1),
(22569,4410,13),
(22569,5259,12),
(22569,5309,9),
(22569,5826,3),
-- 龍馬軍 大魔法師
-- Dragon Steed Troop Grand Magician
(22537,4299,1),
(22537,4412,13),
(22537,5328,9),
(22537,5826,3),
(22537,5829,6),
-- 龍馬軍 大魔法師
-- Dragon Steed Troop Grand Magician
(22571,4299,1),
(22571,4412,13),
(22571,5328,9),
(22571,5826,3),
(22571,5829,6),
-- 龍馬軍 治療師
-- Dragon Steed Troop Healer
(22547,4299,1),
(22547,4608,2),
(22547,5835,1),
(22547,5836,1),
-- 龍馬軍 治療師
-- Dragon Steed Troop Healer
(22580,4299,1),
(22580,4608,2),
(22580,5835,1),
(22580,5836,1),
-- 狂戰士
-- Warrior of Light
(22546,4299,1),
(22546,4211,12),
(22546,5274,9),
-- 狂戰士
-- Warrior of Light
(22579,4299,1),
(22579,4211,12),
(22579,5274,9),
-- 闇龍的族人
-- Wife of the Dragon of Darkness
(22545,4299,1),
(22545,4412,17),
(22545,5827,6),
(22545,5828,6),
(22545,5328,9),
-- 被污染的莫列克戰士
-- Contaminated Morek Warrior
(22703,4410,15),
(22703,4411,15),
(22703,4413,17),
(22703,4444,4),
(22703,5620,9),
-- 被污染的巴吐戰士
-- Contaminated Batur Warrior
(22704,4410,17),
(22704,4411,15),
(22704,4412,15),
(22704,4413,17),
(22704,5620,9),
-- 被污染的巴吐指揮官
-- Contaminated Batur Commander
(22705,4410,17),
(22705,4412,15),
(22705,4413,17),
(22705,5620,9),
-- 圖魯卡部下怨靈
-- Turka Followers Ghost
(22706,4408,16),
(22706,4412,15),
(22706,4413,17),
(22706,4414,1),
(22706,5620,9),
-- 不死的狂信徒
-- Fanatic of Infinity
(22509,5909,1),
(22509,5884,1),
(22509,5886,1),
(22509,5889,1),
(22509,5465,1),
-- 腐敗的傳令
-- Rotten Messenger
(22510,5909,1),
(22510,5878,1),
(22510,5879,1),
(22510,5894,1),
-- 不死的狂信者
-- Zealot of Infinity
(22511,5910,1),
(22511,5897,1),
(22511,5904,1),
-- 屍體切割機
-- Body Severer
(22512,5909,1),
(22512,5884,1),
(22512,5898,1),
(22512,5895,1),
-- 屍體收割機
-- Body Harvester
(22513,5909,1),
(22513,5882,1),
(22513,5883,1),
(22513,5889,1),
-- 靈魂抽取者
-- Soul Exploiter
(22514,5910,1),
(22514,5892,1),
(22514,5905,1),
(22514,5903,1),
-- 靈魂掠食者
-- Soul Devourer
(22515,5909,1),
(22515,5888,1),
(22515,5899,1),
(22515,5937,1),
-- 艾罕 克羅迪庫斯 靈魂的破壞者
-- Yehan Klodekus (Soul Destroyer)
(25665,5933,1),
(25665,5936,1),
-- 艾罕 克蘭尼庫斯 黑暗的引導者
-- Yehan Klanikus (Guide of Darkness)
(25666,5932,1),
(25666,5935,1),
-- 羅格那獸人 被惡靈附身的
-- Ragna Orc (Spirit Infested)
(22691,4416,32),
(22691,4333,6),	
(22691,4312,1),
-- 羅格那獸人戰士 被惡靈附身的
-- Ragna Orc Warrior (Spirit Infested)
(22692,4416,32),
(22692,4333,6),
(22692,4312,1),
-- 羅格那獸人英雄 被惡靈附身的
-- Ragna Orc Hero (Spirit Infested)
(22693,4416,32),
(22693,4333,6),
(22693,4312,1),
-- 羅格那獸人司令官 被惡靈附身的
-- Ragna Orc Commander (Spirit Infested)
(22694,4416,32),
(22694,4333,6),
-- 羅格那獸人治療師 被惡靈附身的
-- Ragna Orc Healer (Spirit Infested)
(22695,4416,32),
(22695,4333,6),
-- 羅格那獸人咒術士 被惡靈附身的
-- Ragna Orc Shaman (Spirit Infested)
(22696,4416,32),
(22696,4333,6),
-- 羅格那獸人預言者 被惡靈附身的
-- Ragna Orc Seer (Spirit Infested)
(22697,4416,32),
(22697,4333,6),
-- 羅格那獸人射手 被惡靈附身的
-- Ragna Orc Archer (Spirit Infested)
(22698,4416,32),
(22698,4333,6),
(22698,4313,1),
-- 羅格那獸人狙擊手 被惡靈附身的
-- Ragna Orc Sniper (Spirit Infested)
(22699,4416,32),
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
REPLACE INTO `zone_vertices` VALUES
(25253,0,-251280,211765),
(25253,1,-250599,211765),
(25253,2,-250599,211571),
(25253,3,-251280,211571);

-- land zone before enter in SoD
REPLACE INTO `zone_vertices` VALUES
(25254,0,-249138,250114),
(25254,1,-246840,252076),
(25254,2,-246730,251982),
(25254,3,-248699,249660);

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
UPDATE `npc` SET `type`='L2Minion', `level`=71, `exp`=0, `sp`=0, `hp`=8318, `mp`=1377 where id='25574';  -- 哈爾庫的警衛
UPDATE `npc` SET `type`='L2Minion', `level`=71, `exp`=0, `sp`=0, `hp`=8318, `mp`=1377 where id='25573';  -- 哈爾庫的追隨者
REPLACE INTO `minions` VALUES (25572, 25574, 1, 1);
REPLACE INTO `minions` VALUES (25572, 25573, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=73, `exp`=2234730, `sp`=360602, `hp`=194342, `mp`=1442 where id='25575';  -- 透視者朗鐵 過去的囚犯
UPDATE `npc` SET `type`='L2Minion', `level`=72, `exp`=0, `sp`=0, `hp`=8383, `mp`=1410 where id='25577';  -- 朗鐵的水晶體
UPDATE `npc` SET `type`='L2Minion', `level`=72, `exp`=0, `sp`=0, `hp`=8383, `mp`=1410 where id='25576';  -- 朗鐵的虹膜
REPLACE INTO `minions` VALUES (25575, 25577, 1, 1);
REPLACE INTO `minions` VALUES (25575, 25576, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=73, `exp`=2234730, `sp`=360602, `hp`=388684, `mp`=1442 where id='25578';  -- 史克雷 過去的囚犯

UPDATE `npc` SET `type`='L2Monster', `level`=74, `exp`=2280800, `sp`=367102, `hp`=196619, `mp`=1475 where id='25579';  -- 海西奈爾 過去的囚犯
UPDATE `npc` SET `type`='L2Minion', `level`=73, `exp`=0, `sp`=0, `hp`=8444, `mp`=1442 where id='25581';  -- 海西奈爾的刺客
UPDATE `npc` SET `type`='L2Minion', `level`=73, `exp`=0, `sp`=0, `hp`=8444, `mp`=1442 where id='25580';  -- 海西奈爾的守護兵
REPLACE INTO `minions` VALUES (25579, 25581, 1, 1);
REPLACE INTO `minions` VALUES (25579, 25580, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=75, `exp`=2329613, `sp`=373311, `hp`=198851, `mp`=1507 where id='25582';  -- 加爾力安 過去的囚犯
UPDATE `npc` SET `type`='L2Minion', `level`=74, `exp`=0, `sp`=0, `hp`=8500, `mp`=1475 where id='25584';  -- 加爾力安的僕人
UPDATE `npc` SET `type`='L2Minion', `level`=74, `exp`=0, `sp`=0, `hp`=8500, `mp`=1475 where id='25583';  -- 加爾力安的女兒
REPLACE INTO `minions` VALUES (25582, 25584, 1, 1);
REPLACE INTO `minions` VALUES (25582, 25583, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=76, `exp`=2383518, `sp`=369370, `hp`=201046, `mp`=1540 where id='25585';  -- 麥以迪 過去的囚犯
UPDATE `npc` SET `type`='L2Minion', `level`=75, `exp`=0, `sp`=0, `hp`=8551, `mp`=1507 where id='25586';  -- 麥以迪之妹
UPDATE `npc` SET `type`='L2Minion', `level`=75, `exp`=0, `sp`=0, `hp`=8551, `mp`=1507 where id='25587';  -- 麥以迪之弟
REPLACE INTO `minions` VALUES (25585, 25586, 1, 1);
REPLACE INTO `minions` VALUES (25585, 25587, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=77, `exp`=2441393, `sp`=374864, `hp`=406426, `mp`=1574 where id='25588';  -- 無法阻止的幕烏士 過去的囚犯

UPDATE `npc` SET `type`='L2Monster', `level`=78, `exp`=2504377, `sp`=380180, `hp`=205362, `mp`=1607 where id='25589';  -- 被放逐的巴里達 過去的囚犯
UPDATE `npc` SET `type`='L2Minion', `level`=77, `exp`=0, `sp`=0, `hp`=8641, `mp`=1574 where id='25591';  -- 巴里達的侍女
UPDATE `npc` SET `type`='L2Minion', `level`=77, `exp`=0, `sp`=0, `hp`=8641, `mp`=1574 where id='25590';  -- 巴里達的侍從
REPLACE INTO `minions` VALUES (25589, 25591, 1, 1);
REPLACE INTO `minions` VALUES (25589, 25590, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=80, `exp`=2643172, `sp`=390090, `hp`=209635, `mp`=1674 where id='25593';  -- 掠食者凱爾格 過去的囚犯
UPDATE `npc` SET `type`='L2Minion', `level`=79, `exp`=0, `sp`=0, `hp`=8710, `mp`=1641 where id='25594';  -- 凱爾格的追隨者
UPDATE `npc` SET `type`='L2Minion', `level`=79, `exp`=0, `sp`=0, `hp`=8710, `mp`=1641 where id='25595';  -- 凱爾格的部下
REPLACE INTO `minions` VALUES (25593, 25594, 1, 1);
REPLACE INTO `minions` VALUES (25593, 25595, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=79, `exp`=2571288, `sp`=385228, `hp`=415001, `mp`=1641 where id='25592';  -- 大將軍卡拉隆 過去的囚犯

-- 增加城堡地監怪物資料 Update 23-08-2010
UPDATE `npc` SET `type`='L2Monster', `level`=75, `exp`=2329613, `sp`=373311, `hp`=198851, `mp`=1507 where id='25546';  -- 背信的拉尼安 過去的罪犯
UPDATE `npc` SET `type`='L2Minion', `level`=74, `exp`=0, `sp`=0, `hp`=8500, `mp`=1475 where id='25547';  -- 拉尼安的同夥
UPDATE `npc` SET `type`='L2Minion', `level`=74, `exp`=0, `sp`=0, `hp`=8500, `mp`=1475 where id='25548';  -- 拉尼安的治癒者
REPLACE INTO `minions` VALUES (25546, 25547, 1, 1);
REPLACE INTO `minions` VALUES (25546, 25548, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=75, `exp`=2329613, `sp`=373311, `hp`=198851, `mp`=1507 where id='25549';  -- 詐欺犯泰西亞 過去的罪犯
UPDATE `npc` SET `type`='L2Minion', `level`=74, `exp`=0, `sp`=0, `hp`=8500, `mp`=1475 where id='25550';  -- 泰西亞的大弟子
UPDATE `npc` SET `type`='L2Minion', `level`=74, `exp`=0, `sp`=0, `hp`=8500, `mp`=1475 where id='25551';  -- 泰西亞的跑腿
REPLACE INTO `minions` VALUES (25549, 25550, 1, 1);
REPLACE INTO `minions` VALUES (25549, 25551, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=76, `exp`=2383518, `sp`=369370, `hp`=402092, `mp`=1540 where id='25552';  -- 靈魂獵人查昆迪 過去的罪犯

UPDATE `npc` SET `type`='L2Monster', `level`=77, `exp`=2441393, `sp`=374864, `hp`=406426, `mp`=1574 where id='25553';  -- 岩石拳杜泰格 過去的罪犯

UPDATE `npc` SET `type`='L2Monster', `level`=78, `exp`=2504377, `sp`=380180, `hp`=205362, `mp`=1607 where id='25554';  -- 不屈的布魯泰齊歐 過去的罪犯
UPDATE `npc` SET `type`='L2Minion', `level`=77, `exp`=0, `sp`=0, `hp`=8641, `mp`=1574 where id='25555';  -- 布魯泰齊歐的右手
UPDATE `npc` SET `type`='L2Minion', `level`=77, `exp`=0, `sp`=0, `hp`=8641, `mp`=1574 where id='25556';  -- 布魯泰齊歐的左手
REPLACE INTO `minions` VALUES (25554, 25555, 1, 1);
REPLACE INTO `minions` VALUES (25554, 25556, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=79, `exp`=2571288, `sp`=385228, `hp`=207500, `mp`=1641 where id='25557';  -- 森林掠食者凱凱諾斯 過去的罪犯
UPDATE `npc` SET `type`='L2Minion', `level`=78, `exp`=0, `sp`=0, `hp`=8678, `mp`=1607 where id='25558';  -- 凱凱諾斯的側根
UPDATE `npc` SET `type`='L2Minion', `level`=78, `exp`=0, `sp`=0, `hp`=8678, `mp`=1607 where id='25559';  -- 凱凱諾斯的花
REPLACE INTO `minions` VALUES (25557, 25558, 1, 1);
REPLACE INTO `minions` VALUES (25557, 25559, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=79, `exp`=2571288, `sp`=385228, `hp`=207500, `mp`=1641 where id='25560';  -- 暴走劍士斯里卡德 過去的罪犯
UPDATE `npc` SET `type`='L2Minion', `level`=78, `exp`=0, `sp`=0, `hp`=8678, `mp`=1607 where id='25561';  -- 斯里卡德的鐘
UPDATE `npc` SET `type`='L2Minion', `level`=78, `exp`=0, `sp`=0, `hp`=8678, `mp`=1607 where id='25562';  -- 斯里卡德的見習生
REPLACE INTO `minions` VALUES (25560, 25561, 1, 1);
REPLACE INTO `minions` VALUES (25560, 25562, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=81, `exp`=2730278, `sp`=394141, `hp`=211731, `mp`=1708 where id='25563';  -- 美貌的奈茲里耶 過去的罪犯
UPDATE `npc` SET `type`='L2Minion', `level`=80, `exp`=0, `sp`=0, `hp`=8738, `mp`=1674 where id='25564';  -- 奈茲里耶的追隨者
UPDATE `npc` SET `type`='L2Minion', `level`=80, `exp`=0, `sp`=0, `hp`=8738, `mp`=1674 where id='25565';  -- 奈茲里耶的部下
REPLACE INTO `minions` VALUES (25563, 25564, 1, 1);
REPLACE INTO `minions` VALUES (25563, 25565, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=2819564, `sp`=398177, `hp`=213848, `mp`=1743 where id='25566';  -- 粗野的南龐 過去的罪犯
UPDATE `npc` SET `type`='L2Minion', `level`=81, `exp`=0, `sp`=0, `hp`=8760, `mp`=1708 where id='25567';  -- 南龐的至交
UPDATE `npc` SET `type`='L2Minion', `level`=81, `exp`=0, `sp`=0, `hp`=8760, `mp`=1708 where id='25568';  -- 南龐的老友
REPLACE INTO `minions` VALUES (25566, 25567, 1, 1);
REPLACE INTO `minions` VALUES (25566, 25568, 1, 1);

UPDATE `npc` SET `type`='L2Monster', `level`=82, `exp`=2819564, `sp`=398177, `hp`=213848, `mp`=1743 where id='25569';  -- 破壞者加斯 過去的罪犯
UPDATE `npc` SET `type`='L2Minion', `level`=81, `exp`=0, `sp`=0, `hp`=8760, `mp`=1708 where id='25570';  -- 加斯的偵查兵
UPDATE `npc` SET `type`='L2Minion', `level`=81, `exp`=0, `sp`=0, `hp`=8760, `mp`=1708 where id='25571';  -- 加斯的突擊兵
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
-- 方塊
REPLACE INTO `npc` VALUES (18672,18672,'Block',0,'',0,'LineageNPC2.block',16.00,17.00,70,'male','L2Block',400,2444,2444,0.00,0.00,10,10,10,10,10,10,0,0,500,500,500,500,278,0,333,0,0,0,0,60,60,0,0,1);
REPLACE INTO `npc` VALUES (18676,18676,'Block-Carrying Girl',0,'',0,'LineageNPC2.block_mother',12.00,31.00,70,'male','L2Npc',40,2444,2444,0.00,0.00,10,10,10,10,10,10,0,0,500,500,500,500,278,0,333,0,0,0,0,60,60,0,0,1);
REPLACE INTO `etcitem` VALUES (13787,'Bond','','false','potion',180,'stackable','paper','none',-1,-1,0,0,'true','true','true','true','true','ItemSkills','5849-1;');
REPLACE INTO `etcitem` VALUES (13788,'Land Mine','','false','potion',180,'stackable','paper','none',-1,-1,0,0,'true','true','true','true','true','ItemSkills','5851-1;');

-- new npc for 葫蘆
REPLACE INTO `npc` VALUES (12774,12774,'Young Squash',0,'',0,'LineageNPC.drop_gourd_50_sm',10.00,10.50,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,88,132,0,0,1);
REPLACE INTO `npc` VALUES (12775,12775,'High Quality Squash',0,'',0,'LineageNPC.drop_gourd',23.00,25.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,88,132,0,0,1);
REPLACE INTO `npc` VALUES (12776,12776,'Low Quality Squash',0,'',0,'LineageNPC.drop_gourd_25_sm',15.00,16.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,88,132,0,0,1);
REPLACE INTO `npc` VALUES (12777,12777,'Large Young Squash',0,'',0,'LineageNPC.drop_gourd',23.00,25.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,88,132,0,0,1);
REPLACE INTO `npc` VALUES (12778,12778,'High Quality Large Squash',0,'',0,'LineageNPC.drop_gourd_50_bi',34.00,40.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,88,132,0,0,1);
REPLACE INTO `npc` VALUES (12779,12779,'Low Quality Large Squash',0,'',0,'LineageNPC.drop_gourd_25_bi',28.00,31.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,88,132,0,0,1);
REPLACE INTO `npc` VALUES (13016,13016,'King Squash',0,'',0,'LineageNPC.drop_gourd',23.00,25.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,88,132,0,0,1);
REPLACE INTO `npc` VALUES (13017,13017,'Emperor Squash',0,'',0,'LineageNPC.drop_gourd_50_bi',34.00,40.00,70,'male','L2Npc',40,3862,1494,0.00,0.00,40,43,30,21,20,20,0,0,1303,471,607,382,253,0,333,0,0,0,0,88,132,0,0,1);

DELETE FROM npcskills             WHERE  npcid IN (12774,12775,12776,12777,12778,12779,13016,13017);
-- DELETE FROM npcAIData             WHERE npc_id IN (12774,12775,12776,12777,12778,12779,13016,13017);
UPDATE npc SET `type`='L2ChronoMonster' WHERE id IN (12774,12775,12776,12777,12778,12779,13016,13017);

UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=12774;  -- 未成熟的葫蘆
UPDATE npc SET level=1,hp=300 ,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=12775;  -- 優良的葫蘆
UPDATE npc SET level=1,hp=300 ,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=12776;  -- 不良的葫蘆
UPDATE npc SET level=1,hp=300 ,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=12777;  -- 未成熟的大葫蘆
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=12778;  -- 優良的大葫蘆
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=12779;  -- 不良的大葫蘆
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=13016;  -- 優良的葫蘆王
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=13017;  -- 優良的大葫蘆王

-- new npc for 西瓜
UPDATE etcitem SET handler='ItemSkills',skill='9029-1;' WHERE item_id=15366;
UPDATE etcitem SET handler='ItemSkills',skill='9030-1;' WHERE item_id=15367;
UPDATE etcitem SET handler='ItemSkills',skill='9031-1;' WHERE item_id=15368;
UPDATE etcitem SET handler='ItemSkills',skill='9032-1;' WHERE item_id=15369;

UPDATE etcitem SET consume_type='stackable' WHERE item_id IN (15366,15367,15368,15369);
UPDATE etcitem SET sellable='true',tradeable='true',depositable='true' WHERE item_id IN (15366,15367);

-- NPC
DELETE FROM npcskills             WHERE  npcid IN (13271,13272,13273,13274,13275,13276,13277,13278);
-- DELETE FROM npcAIData             WHERE npc_id IN (13271,13272,13273,13274,13275,13276,13277,13278);
UPDATE npc SET `type`='L2ChronoMonster' WHERE id IN (13271,13272,13273,13274,13275,13276,13277,13278);

UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=13271; -- 未成熟的西瓜
UPDATE npc SET level=1,hp=300 ,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=13272; -- 不良的西瓜
UPDATE npc SET level=1,hp=300 ,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=13273; -- 優良的西瓜
UPDATE npc SET level=1,hp=300 ,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=13274; -- 優良的西瓜王
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=13275; -- 未成熟的香甜西瓜
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=13276; -- 不良的香甜西瓜
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=13277; -- 優良的香甜西瓜
UPDATE npc SET level=1,hp=3000,mp=0,hpreg=0,mpreg=0,str=10,con=10,dex=10,`int`=10,wit=10,men=10,patk=0,pdef=15,matk=0,mdef=32 WHERE id=13278; -- 優良的香甜西瓜王

-- 武器
UPDATE weapon SET skill='0-0;' WHERE item_id=5817; -- 克魯諾杖鐘 參章紀念樂器 (3599-1;)
UPDATE weapon SET crystallizable='false' WHERE item_id=8350; -- 克魯諾瑪拉卡斯 伍章紀念樂器

-- 任務196 武器技能
REPLACE INTO `etcitem` VALUES (13808,'Elmoreden Holy Water','','false','none',0,'stackable','paper','none',-1,-1,0,0,'false','false','false','false','false','ItemSkills','2633-1;'); -- 艾爾摩亞丁的聖水
REPLACE INTO `weapon` VALUES (13809,'Court Magician\'s Magic Staff','','rhand','false',0,0,0,'fine_steel','none',0,0,'sword',0,0.00000,0,0,0,0,0,0,-1,-1,0,0,'false','false','false','false','false',0,0,0,0,0,0,0,0,0,'2634-1;'); -- 宮廷魔法師的魔法棒

-- 諾爾妮庭園首領怪物資料 
UPDATE `npc` SET `type`='L2RaidBoss' where id='25528';  -- 最終試練官 塔庇里歐斯
UPDATE `npc` SET `type`='L2Minion', `exp`=0,  `sp`=0 where id='25529';  -- 試練官的部下 庭園的警衛隊
UPDATE `npc` SET `type`='L2Minion', `exp`=0,  `sp`=0 where id='25530';  -- 試練官的部下 庭園的警衛隊
REPLACE INTO `minions` VALUES (25528, 25529, 3, 3);
REPLACE INTO `minions` VALUES (25528, 25530, 1, 1);

UPDATE etcitem SET handler='PaganKeys', skill='2343-1;' WHERE item_id=9703; -- 闇天使之門的鑰匙
UPDATE etcitem SET handler='PaganKeys', skill='2344-1;' WHERE item_id=9704; -- 紀錄之門的鑰匙
UPDATE etcitem SET handler='PaganKeys', skill='2345-1;' WHERE item_id=9705; -- 觀察之門的鑰匙
UPDATE etcitem SET handler='PaganKeys', skill='2346-1;' WHERE item_id=9706; -- 斯比裘拉之門的鑰匙
UPDATE etcitem SET handler='PaganKeys', skill='2347-1;' WHERE item_id=9707; -- 鑰匙-諸天之上
UPDATE etcitem SET handler='PaganKeys', skill='2348-1;' WHERE item_id=9708; -- 鑰匙-佛拉赫爾哈
UPDATE etcitem SET handler='PaganKeys', skill='2349-1;' WHERE item_id=9709; -- 亞爾比泰魯之門的鑰匙
UPDATE etcitem SET handler='PaganKeys', skill='2350-1;' WHERE item_id=9710; -- 鑰匙-雷歐波爾德
UPDATE etcitem SET handler='PaganKeys', skill='2351-1;' WHERE item_id=9711; -- 預測之門的鑰匙
UPDATE etcitem SET handler='PaganKeys', skill='2352-1;' WHERE item_id=9712; -- 大空洞之門的鑰匙
UPDATE etcitem SET handler='ItemSkills',skill='2353-1;' WHERE item_id=9713; -- 諾爾妮之力

UPDATE `npc` SET `type`='L2Monster', `exp`=720,  `sp`=32,  `hp`=720,  `mp`=213, `aggro`=400 where id='18347';  --  庭園的警衛兵
UPDATE `npc` SET `type`='L2Monster', `exp`=935,  `sp`=35,  `hp`=720,  `mp`=213, `aggro`=400 where id='18348';  --  庭園的警衛兵
UPDATE `npc` SET `type`='L2Monster', `exp`=920,  `sp`=40,  `hp`=720,  `mp`=213, `aggro`=600, `walkspd`=0, `runspd`=0 where id='18349';  --  庭園的警衛兵
UPDATE `npc` SET `type`='L2Monster', `exp`=980,  `sp`=40,  `hp`=720,  `mp`=213, `aggro`=400 where id='18350';  --  庭園的警衛兵
UPDATE `npc` SET `type`='L2Monster', `exp`=980,  `sp`=40,  `hp`=720,  `mp`=213, `aggro`=400 where id='18351';  --  庭園的警衛兵
UPDATE `npc` SET `type`='L2Monster', `exp`=1807, `sp`=68,  `hp`=1387, `mp`=218, `aggro`=400 where id='18352';  --  闇天使守護者
UPDATE `npc` SET `type`='L2Monster', `exp`=2401, `sp`=99,  `hp`=1387, `mp`=218, `aggro`=400 where id='18353';  --  紀錄守護者
UPDATE `npc` SET `type`='L2Monster', `exp`=1807, `sp`=68,  `hp`=1387, `mp`=218, `aggro`=400 where id='18354';  --  觀察守護者
UPDATE `npc` SET `type`='L2Monster', `exp`=2541, `sp`=99,  `hp`=1387, `mp`=218, `aggro`=400 where id='18355';  --  斯比裘拉守護者
UPDATE `npc` SET `type`='L2Monster', `exp`=2469, `sp`=111, `hp`=1387, `mp`=218, `aggro`=400 where id='18356';  --  諸天之上守門人
UPDATE `npc` SET `type`='L2Monster', `exp`=2401, `sp`=99,  `hp`=1387, `mp`=218, `aggro`=400 where id='18357';  --  羅丹彼裘拉守門人
UPDATE `npc` SET `type`='L2Monster', `exp`=1807, `sp`=68,  `hp`=1387, `mp`=218, `aggro`=400 where id='18358';  --  祕密守護者
UPDATE `npc` SET `type`='L2Monster', `exp`=1807, `sp`=68,  `hp`=1387, `mp`=218, `aggro`=400 where id='18359';  --  亞爾比泰魯守護者
UPDATE `npc` SET `type`='L2Monster', `exp`=1807, `sp`=68,  `hp`=1387, `mp`=218, `aggro`=400 where id='18360';  --  凱特奈特守門人
UPDATE `npc` SET `type`='L2Monster', `exp`=2401, `sp`=99,  `hp`=1387, `mp`=218, `aggro`=400 where id='18361';  --  預測守護者
UPDATE `npc` SET `type`='L2Monster', `exp`=850,  `sp`=35,  `hp`=582,  `mp`=185, `aggro`=400 where id='18362';  --  庭園的警衛兵
UPDATE `npc` SET `type`='L2Monster', `exp`=850,  `sp`=35,  `hp`=582,  `mp`=185, `aggro`=400 where id='18363';  --  庭園的警衛兵
UPDATE `npc` SET `type`='L2Monster', `exp`=1401, `sp`=72,  `hp`=780,  `mp`=185, `aggro`=400 where id='18444';  --  庭園的警衛兵
UPDATE `npc` SET `type`='L2Monster', `exp`=1757, `sp`=80,  `hp`=780,  `mp`=213, `aggro`=400 where id='18483';  --  庭園的警衛兵
UPDATE `npc` SET `type`='L2Monster', `exp`=0,    `sp`=0,   `hp`=100,  `mp`=0,   `walkspd`=0, `runspd`=0 where id='18478';  --  藥草甕
UPDATE `npc` SET `type`='L2Monster', `hp`=999999, `exp`=0, `sp`=0, `mp`=100000, `walkspd`=0, `runspd`=0, `aggro`=500 where id='18437';  --  

DELETE FROM npcskills WHERE npcid IN (18437);

REPLACE INTO `droplist` VALUES
(18478,8154,1,7,2,700000),-- 生命藥草
(18478,8155,1,7,2,700000);-- 瑪那藥草

-- etcitem for Vitality CT2.5
REPLACE INTO `etcitem` VALUES (20005,'活力紅蔘','','false','herb',0,'normal','paper','none',-1,-1,0,0,'true','true','true','true','true','ItemSkills','22005-1;');
REPLACE INTO `etcitem` VALUES (20214,'巧克力餅乾','','false','potion',5,'stackable','paper','none',-1,-1,0,0,'true','true','true','true','true','ItemSkills','22028-1;');
REPLACE INTO `etcitem` VALUES (13787,'強力膠','','false','potion',180,'stackable','paper','none',-1,-1,0,0,'true','true','true','true','true','ItemSkills','5849-1;');
REPLACE INTO `etcitem` VALUES (13788,'地雷','','false','potion',180,'stackable','paper','none',-1,-1,0,0,'true','true','true','true','true','ItemSkills','5851-1;');

UPDATE `etcitem` SET `item_type` = 'none' WHERE `item_id` = '13798';  -- 靈魂的片段

-- New ectitem 2009-08-26
REPLACE INTO `etcitem` VALUES (20602,'靈魂銀紙-活動','','false','none',0,'stackable','wood','none',-1,-1,0,0,'false','false','true','false','true','ItemSkills','22099-1;');
REPLACE INTO `etcitem` VALUES (20603,'靈魂香-活動','','false','none',0,'stackable','wood','none',-1,-1,0,0,'false','false','true','false','true','ItemSkills','22100-1;');
REPLACE INTO `etcitem` VALUES (20623,'靈魂銀紙-香組','','false','none',0,'stackable','wood','none',-1,-1,0,0,'false','false','true','false','true','ExtractableItems','0-0;');
REPLACE INTO `etcitem` VALUES (20630,'靈魂魔法箱','','false','none',0,'stackable','wood','none',-1,-1,0,0,'false','false','true','false','true','ItemSkills','22102-1;');

-- ----------------- --
-- Devastated Castle --
-- ----------------- --

-- Update siege npcs

UPDATE npc SET type = 'L2Defender' WHERE id = 35411;
UPDATE npc SET type = 'L2Defender' WHERE id = 35412;
UPDATE npc SET type = 'L2Defender' Where id = 35413;
UPDATE npc SET type = 'L2Defender' WHERE id = 35414;
UPDATE npc SET type = 'L2Defender' WHERE id = 35415;
UPDATE npc SET type = 'L2Defender' WHERE id = 35416;
UPDATE npc SET type = 'L2ClanHallDoormen', rhand = 0, lhand = 0 WHERE id = 35417;
UPDATE npc SET type = 'L2ClanHallDoormen', rhand = 0, lhand = 0 WHERE id = 35418;
UPDATE npc SET type = 'L2WyvernManager' WHERE id = 35419;

-- Delete mobs from normal spawnlist

DELETE FROM spawnlist WHERE npc_templateid = 35411;
DELETE FROM spawnlist WHERE npc_templateid = 35412;
DELETE FROM spawnlist WHERE npc_templateid = 35413;
DELETE FROM spawnlist WHERE npc_templateid = 35414;
DELETE FROM spawnlist WHERE npc_templateid = 35415;
DELETE FROM spawnlist WHERE npc_templateid = 35416;
DELETE FROM spawnlist WHERE npc_templateid = 35410;

-- Devastated castle doors

REPLACE INTO castle_door VALUES (34, 25170001, 'devastated_castle_outer_001', 178212, -15038, -2135, 178211, -15038, -2294, 178342, -15017, -1976, 158250, 644, 518, 'false');
REPLACE INTO castle_door VALUES (34, 25170002, 'devastated_castle_outer_002', 178468, -15038, -2135, 178339, -15038, -2295, 178469, -15017, -1977, 158250, 644, 518, 'false');
REPLACE INTO castle_door VALUES (34, 25170003, 'devastated_castle_inner_003', 178119, -18220, -2210, 178120, -18225, -2286, 178183, -18211, -1836, 79125, 644, 518, 'false');
REPLACE INTO castle_door VALUES (34, 25170004, 'devastated_castle_inner_004', 178247, -18220, -2210, 178182, -18225, -2286, 178245, -18211, -1836, 79125, 644, 518, 'false');
REPLACE INTO castle_door VALUES (34, 25170005, 'devastated_castle_inner_005', 178298, -18573, -2233, 178302, -18611, -2287, 178309, -18573, -1837, 79125, 644, 518, 'false');
REPLACE INTO castle_door VALUES (34, 25170006, 'devastated_castle_inner_006', 178298, -18650, -2233, 178302, -18648, -2287, 178309, -18610, -1837, 79125, 644, 518, 'false');

-- ---------------------- --
-- Fortress of Resistance --
-- ---------------------- --

-- -------------------- --
-- Fortress of the Dead --
-- -------------------- --

-- Update siege npcs

UPDATE npc SET type = 'L2WyvernManager' WHERE id = 35638;
UPDATE npc SET type = 'L2ClanHallDoormen', rhand = 0, lhand = 0 WHERE id = 35641;
UPDATE npc SET type = 'L2ClanHallDoormen', rhand = 0, lhand = 0 WHERE id = 35642;

-- Fortress of the Dead doors
REPLACE INTO castle_door VALUES (64, 21170001, 'Fortress_of_the_Dead_outer_001', 57857, -29480, 707, 57849, -29498, 543, 57969, -29465, 869, 158250, 644, 518, 'false');
REPLACE INTO castle_door VALUES (64, 21170002, 'Fortress_of_the_Dead_outer_002', 58061, -29479, 707, 57954, -29498, 543, 58071, -29465, 869, 158250, 644, 518, 'false');
REPLACE INTO castle_door VALUES (64, 21170003, 'Fortress_of_the_Dead_inner_003', 56977, -27193, 639, 56972, -27259, 550, 56982, -27188, 728, 158250, 644, 518, 'false');
REPLACE INTO castle_door VALUES (64, 21170004, 'Fortress_of_the_Dead_inner_004', 56977, -27318, 639, 56971, -27323, 550, 56981, -27251, 726, 158250, 644, 518, 'false');
REPLACE INTO castle_door VALUES (64, 21170005, 'Fortress_of_the_Dead_inner_005', 57902, -26392, 654, 57893, -26401, 563, 57976, -26382, 743, 158250, 644, 518, 'false');
REPLACE INTO castle_door VALUES (64, 21170006, 'Fortress_of_the_Dead_inner_006', 58024, -26391, 654, 57953, -26400, 563, 58037, -26383, 743, 158250, 644, 518, 'false');

-- ----------------------- --
-- Rainbow Springs Chateau --
-- ----------------------- --

-- Messenger
REPLACE INTO spawnlist VALUES (NULL, 'rainbowsprings_messenger', 1, 35604, 143944, -119196, -2136, 0, 0, 1000, 0, 0, 0); 

-- Caretaker
REPLACE INTO clanhall_siege_guards VALUES (62, NULL, 35603, 153337, -126441, -2270, 1, 1, 0);

-- Arena 1 npc / monsters
REPLACE INTO clanhall_siege_guards VALUES (62, NULL, 35596, 151774, -126861, -2218, 1, 1, 0);
REPLACE INTO clanhall_siege_guards VALUES (62, NULL, 35593, 151862, -127080, -2218, 1, 300000, 0);
REPLACE INTO clanhall_siege_guards VALUES (62, NULL, 35592, 151262, -127080, -2218, 1, 300000, 0);

-- Arena 2 npc / monsters
REPLACE INTO clanhall_siege_guards VALUES (62, NULL, 35597, 153404, -125576, -2218, 1, 1, 0);
REPLACE INTO clanhall_siege_guards VALUES (62, NULL, 35593, 153341, -125335, -2218, 1, 300000, 0);
REPLACE INTO clanhall_siege_guards VALUES (62, NULL, 35592, 152841, -125335, -2218, 1, 300000, 0);

-- Arena 3 npc / monsters
REPLACE INTO clanhall_siege_guards VALUES (62, NULL, 35598, 154132, -127301, -2218, 1, 1, 0);
REPLACE INTO clanhall_siege_guards VALUES (62, NULL, 35593, 154192, -127530, -2218, 1, 300000, 0);
REPLACE INTO clanhall_siege_guards VALUES (62, NULL, 35592, 153592, -127530, -2218, 1, 300000, 0);

-- Arena 4 npc / monsters
REPLACE INTO clanhall_siege_guards VALUES (62, NULL, 35598, 155390, -125489, -2218, 1, 1, 0);
REPLACE INTO clanhall_siege_guards VALUES (62, NULL, 35593, 155969, -125752, -2218, 1, 300000, 0);
REPLACE INTO clanhall_siege_guards VALUES (62, NULL, 35592, 155369, -125752, -2218, 1, 300000, 0);

-- Update siege npcs
UPDATE npc SET type = 'L2Monster' WHERE id = 35592;
UPDATE npc SET type = 'L2Monster' WHERE id = 35593;
UPDATE npc SET type = 'L2Monster' WHERE id = 35588;
UPDATE npc SET type = 'L2Monster' WHERE id = 35589;
UPDATE npc SET type = 'L2Monster' WHERE id = 35590;
UPDATE npc SET type = 'L2Monster' WHERE id = 35591;

-- Update siege items
UPDATE etcitem SET item_type = 'stackable', handler = 'QuestItems' WHERE item_id = 8030;
UPDATE etcitem SET item_type = 'stackable', handler = 'QuestItems' WHERE item_id = 8031;
UPDATE etcitem SET item_type = 'stackable', handler = 'QuestItems' WHERE item_id = 8032;
UPDATE etcitem SET item_type = 'stackable', handler = 'QuestItems' WHERE item_id = 8033;