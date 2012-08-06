/************ Made in Taiwan ************/

REPLACE INTO `auto_announcements` VALUES
(1,900000,9000000,36000,'此測試伺服器的各種功能，目前仍然不完整和不穩定，如有發現任何錯誤或Bug，麻煩請回報至論壇。','false');

DELETE FROM `spawnlist` WHERE `npc_templateid` IN (30484,30487);
INSERT INTO `spawnlist` (location,count,npc_templateid,locx,locy,locz,randomx,randomy,heading,respawn_delay,loc_id,periodOfDay) VALUES
('dion05_npc2021_02',1,30484,17627,114750,-11688,0,0,16384,60,0,0),
('dion05_npc2021_03',1,30487,17821,114750,-11688,0,0,16384,60,0,0);
REPLACE INTO `teleport` VALUES
('Cruma Tower 2nd floor -> Cruma Tower 1st floor',24,17728,114750,-11688,0,0,57);

DELETE FROM `merchant_buylists` WHERE `shop_id` > 10015 and `shop_id` < 10033;

DELETE FROM `items` WHERE `item_id` > 17624 and `item_id` < 17715;
DELETE FROM `items` WHERE `item_id` > 18550 and `item_id` < 18563;
DELETE FROM `items` WHERE `item_id` > 19400 and `item_id` < 19440;
DELETE FROM `items` WHERE `item_id` > 19443 and `item_id` < 19447;
DELETE FROM `items` WHERE `item_id` > 19448 and `item_id` < 19451;
DELETE FROM `items` WHERE `item_id` > 19464 and `item_id` < 19470;
DELETE FROM `items` WHERE `item_id` > 19481 and `item_id` < 19500;
DELETE FROM `items` WHERE `item_id` > 19585 and `item_id` < 19650;
DELETE FROM `items` WHERE `item_id` > 30231 and `item_id` < 30274;
DELETE FROM `items` WHERE `item_id` > 32315 and `item_id` < 32317;
DELETE FROM `items` WHERE `item_id` > 33518 and `item_id` < 33521;

UPDATE `items` SET `item_id` = 19527 WHERE `item_id` = 19655;
UPDATE `items` SET `item_id` = 19543 WHERE `item_id` = 19671;
UPDATE `items` SET `item_id` = 19559 WHERE `item_id` = 19687;
UPDATE `items` SET `item_id` = 19575 WHERE `item_id` = 19703;
UPDATE `items` SET `item_id` = 19730 WHERE `item_id` = 19858;
UPDATE `items` SET `item_id` = 19731 WHERE `item_id` = 19859;
UPDATE `items` SET `item_id` = 19732 WHERE `item_id` = 19860;
UPDATE `items` SET `item_id` = 19733 WHERE `item_id` = 19861;
UPDATE `items` SET `item_id` = 19734 WHERE `item_id` = 19862;
UPDATE `items` SET `item_id` = 19735 WHERE `item_id` = 19863;
UPDATE `items` SET `item_id` = 19736 WHERE `item_id` = 19864;
UPDATE `items` SET `item_id` = 19737 WHERE `item_id` = 19865;
UPDATE `items` SET `item_id` = 19738 WHERE `item_id` = 19866;
UPDATE `items` SET `item_id` = 19739 WHERE `item_id` = 19867;
UPDATE `items` SET `item_id` = 19740 WHERE `item_id` = 19868;
UPDATE `items` SET `item_id` = 19741 WHERE `item_id` = 19869;
UPDATE `items` SET `item_id` = 19742 WHERE `item_id` = 19870;
UPDATE `items` SET `item_id` = 19743 WHERE `item_id` = 19871;
UPDATE `items` SET `item_id` = 19744 WHERE `item_id` = 19872;
UPDATE `items` SET `item_id` = 19745 WHERE `item_id` = 19873;
UPDATE `items` SET `item_id` = 19746 WHERE `item_id` = 19874;
UPDATE `items` SET `item_id` = 19747 WHERE `item_id` = 19875;
UPDATE `items` SET `item_id` = 19748 WHERE `item_id` = 19876;
UPDATE `items` SET `item_id` = 19749 WHERE `item_id` = 19877;
UPDATE `items` SET `item_id` = 19750 WHERE `item_id` = 19878;
UPDATE `items` SET `item_id` = 19751 WHERE `item_id` = 19879;
UPDATE `items` SET `item_id` = 19752 WHERE `item_id` = 19880;
UPDATE `items` SET `item_id` = 19753 WHERE `item_id` = 19881;
UPDATE `items` SET `item_id` = 19754 WHERE `item_id` = 19882;
UPDATE `items` SET `item_id` = 19755 WHERE `item_id` = 19883;
UPDATE `items` SET `item_id` = 19756 WHERE `item_id` = 19884;
UPDATE `items` SET `item_id` = 19757 WHERE `item_id` = 19885;
UPDATE `items` SET `item_id` = 19758 WHERE `item_id` = 19886;
UPDATE `items` SET `item_id` = 19759 WHERE `item_id` = 19887;
UPDATE `items` SET `item_id` = 19760 WHERE `item_id` = 19888;
UPDATE `items` SET `item_id` = 19761 WHERE `item_id` = 19889;
UPDATE `items` SET `item_id` = 19762 WHERE `item_id` = 19890;
UPDATE `items` SET `item_id` = 19763 WHERE `item_id` = 19891;
UPDATE `items` SET `item_id` = 19764 WHERE `item_id` = 19892;
UPDATE `items` SET `item_id` = 19765 WHERE `item_id` = 19893;
UPDATE `items` SET `item_id` = 19766 WHERE `item_id` = 19894;
UPDATE `items` SET `item_id` = 19767 WHERE `item_id` = 19895;
UPDATE `items` SET `item_id` = 19768 WHERE `item_id` = 19896;
UPDATE `items` SET `item_id` = 19769 WHERE `item_id` = 19897;
UPDATE `items` SET `item_id` = 19770 WHERE `item_id` = 19898;
UPDATE `items` SET `item_id` = 19771 WHERE `item_id` = 19899;
UPDATE `items` SET `item_id` = 19772 WHERE `item_id` = 19900;
UPDATE `items` SET `item_id` = 19773 WHERE `item_id` = 19901;
UPDATE `items` SET `item_id` = 19774 WHERE `item_id` = 19902;
UPDATE `items` SET `item_id` = 19775 WHERE `item_id` = 19903;
UPDATE `items` SET `item_id` = 19776 WHERE `item_id` = 19904;
UPDATE `items` SET `item_id` = 19777 WHERE `item_id` = 19905;
UPDATE `items` SET `item_id` = 19778 WHERE `item_id` = 19906;
UPDATE `items` SET `item_id` = 19779 WHERE `item_id` = 19907;
UPDATE `items` SET `item_id` = 19780 WHERE `item_id` = 19908;
UPDATE `items` SET `item_id` = 19781 WHERE `item_id` = 19909;
UPDATE `items` SET `item_id` = 19782 WHERE `item_id` = 19910;
UPDATE `items` SET `item_id` = 19783 WHERE `item_id` = 19911;
UPDATE `items` SET `item_id` = 19784 WHERE `item_id` = 19912;
UPDATE `items` SET `item_id` = 19785 WHERE `item_id` = 19913;
UPDATE `items` SET `item_id` = 19786 WHERE `item_id` = 19914;
UPDATE `items` SET `item_id` = 19787 WHERE `item_id` = 19915;
UPDATE `items` SET `item_id` = 19788 WHERE `item_id` = 19916;
UPDATE `items` SET `item_id` = 19789 WHERE `item_id` = 19917;
UPDATE `items` SET `item_id` = 19790 WHERE `item_id` = 19918;
UPDATE `items` SET `item_id` = 19791 WHERE `item_id` = 19919;
UPDATE `items` SET `item_id` = 19792 WHERE `item_id` = 19920;
UPDATE `items` SET `item_id` = 19793 WHERE `item_id` = 19921;

REPLACE INTO `merchant_shopids` VALUES (10016, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(19730, 0, 10016, 1),
(19731, 0, 10016, 2),
(19732, 0, 10016, 3),
(19733, 0, 10016, 4),
(19734, 0, 10016, 5),
(19735, 0, 10016, 6),
(19736, 0, 10016, 7),
(19737, 0, 10016, 8),
(19738, 0, 10016, 9),
(19739, 0, 10016, 10),
(19740, 0, 10016, 11),
(17754, 0, 10016, 12),
(19741, 0, 10016, 13),
(19742, 0, 10016, 14),
(19743, 0, 10016, 15),
(19744, 0, 10016, 16),
(19745, 0, 10016, 17),
(19442, 0, 10016, 18),
(19522, 0, 10016, 19),
(19523, 0, 10016, 20),
(19524, 0, 10016, 21),
(19525, 0, 10016, 22),
(19526, 0, 10016, 23),
(19527, 0, 10016, 24),
(19528, 0, 10016, 25),
(19529, 0, 10016, 26),
(19530, 0, 10016, 27),
(19531, 0, 10016, 28),
(19532, 0, 10016, 29),
(18550, 0, 10016, 30),
(19533, 0, 10016, 31),
(19534, 0, 10016, 32),
(19535, 0, 10016, 33),
(19536, 0, 10016, 34),
(19537, 0, 10016, 35),
(17320, 0, 10016, 36);

REPLACE INTO `merchant_shopids` VALUES (10017, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(19762, 0, 10017, 1),
(19763, 0, 10017, 2),
(19764, 0, 10017, 3),
(19765, 0, 10017, 4),
(19766, 0, 10017, 5),
(19767, 0, 10017, 6),
(19768, 0, 10017, 7),
(19769, 0, 10017, 8),
(19770, 0, 10017, 9),
(19771, 0, 10017, 10),
(19772, 0, 10017, 11),
(17754, 0, 10017, 12),
(19773, 0, 10017, 13),
(19774, 0, 10017, 14),
(19775, 0, 10017, 15),
(19776, 0, 10017, 16),
(19777, 0, 10017, 17),
(19442, 0, 10017, 18),
(19554, 0, 10017, 19),
(19555, 0, 10017, 20),
(19556, 0, 10017, 21),
(19557, 0, 10017, 22),
(19558, 0, 10017, 23),
(19559, 0, 10017, 24),
(19560, 0, 10017, 25),
(19561, 0, 10017, 26),
(19562, 0, 10017, 27),
(19563, 0, 10017, 28),
(19564, 0, 10017, 29),
(18550, 0, 10017, 30),
(19565, 0, 10017, 31),
(19566, 0, 10017, 32),
(19567, 0, 10017, 33),
(19568, 0, 10017, 34),
(19569, 0, 10017, 35),
(17412, 0, 10017, 36);

REPLACE INTO `merchant_shopids` VALUES (10018, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(19778, 0, 10018, 1),
(19779, 0, 10018, 2),
(19780, 0, 10018, 3),
(19781, 0, 10018, 4),
(19782, 0, 10018, 5),
(19783, 0, 10018, 6),
(19784, 0, 10018, 7),
(19785, 0, 10018, 8),
(19786, 0, 10018, 9),
(19787, 0, 10018, 10),
(19788, 0, 10018, 11),
(17754, 0, 10018, 12),
(19789, 0, 10018, 13),
(19790, 0, 10018, 14),
(19791, 0, 10018, 15),
(19792, 0, 10018, 16),
(19793, 0, 10018, 17),
(19442, 0, 10018, 18),
(19570, 0, 10018, 19),
(19571, 0, 10018, 20),
(19572, 0, 10018, 21),
(19573, 0, 10018, 22),
(19574, 0, 10018, 23),
(19575, 0, 10018, 24),
(19576, 0, 10018, 25),
(19577, 0, 10018, 26),
(19578, 0, 10018, 27),
(19579, 0, 10018, 28),
(19580, 0, 10018, 29),
(18550, 0, 10018, 30),
(19581, 0, 10018, 31),
(19582, 0, 10018, 32),
(19583, 0, 10018, 33),
(19584, 0, 10018, 34),
(19585, 0, 10018, 35),
(17446, 0, 10018, 36);

REPLACE INTO `merchant_shopids` VALUES (10019, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(33717, 0, 10019, 1),
(33718, 0, 10019, 2),
(33719, 0, 10019, 3),
(33720, 0, 10019, 4),
(33721, 0, 10019, 5),
(33722, 0, 10019, 6),
(33723, 0, 10019, 7),
(33724, 0, 10019, 8),
(33725, 0, 10019, 9),
(33726, 0, 10019, 10),
(33727, 0, 10019, 11),
(33728, 0, 10019, 12),
(33729, 0, 10019, 13),
(33730, 0, 10019, 14),
(33731, 0, 10019, 15),
(33732, 0, 10019, 16),
(33733, 0, 10019, 17),
(33734, 0, 10019, 18),
(33735, 0, 10019, 19),
(33736, 0, 10019, 20),
(33737, 0, 10019, 21),
(33738, 0, 10019, 22),
(33739, 0, 10019, 23),
(33740, 0, 10019, 24),
(33741, 0, 10019, 25),
(33742, 0, 10019, 26),
(33743, 0, 10019, 27),
(33744, 0, 10019, 28),
(33745, 0, 10019, 29),
(33746, 0, 10019, 30),
(33747, 0, 10019, 31),
(33760, 0, 10019, 32),
(33761, 0, 10019, 33),
(33762, 0, 10019, 34),
(33763, 0, 10019, 35),
(33765, 0, 10019, 36);

REPLACE INTO `merchant_shopids` VALUES (10021, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(19451, 0, 10021, 1),
(19452, 0, 10021, 2),
(19453, 0, 10021, 3),
(19454, 0, 10021, 4),
(19455, 0, 10021, 5),
(19456, 0, 10021, 6),
(19457, 0, 10021, 7),
(19458, 0, 10021, 8),
(19459, 0, 10021, 9),
(19460, 0, 10021, 10),
(19461, 0, 10021, 11),
(19462, 0, 10021, 12),
(19463, 0, 10021, 13),
(19464, 0, 10021, 14);

REPLACE INTO `merchant_shopids` VALUES (10022, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(17321, 0, 10022, 1),
(17322, 0, 10022, 2),
(17323, 0, 10022, 3),
(19470, 0, 10022, 4),
(19471, 0, 10022, 5),
(19472, 0, 10022, 6),
(17355, 0, 10022, 7),
(17356, 0, 10022, 8),
(17357, 0, 10022, 9),
(19473, 0, 10022, 10),
(19474, 0, 10022, 11),
(19475, 0, 10022, 12),
(17413, 0, 10022, 13),
(17414, 0, 10022, 14),
(17415, 0, 10022, 15),
(19476, 0, 10022, 16),
(19477, 0, 10022, 17),
(19478, 0, 10022, 18),
(17447, 0, 10022, 19),
(17448, 0, 10022, 20),
(17449, 0, 10022, 21),
(19479, 0, 10022, 22),
(19480, 0, 10022, 23),
(19481, 0, 10022, 24),
(17481, 0, 10022, 25),
(17482, 0, 10022, 26),
(17483, 0, 10022, 27),
(30307, 0, 10022, 28),
(30308, 0, 10022, 29),
(30309, 0, 10022, 30);

REPLACE INTO `merchant_shopids` VALUES (10023, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(30392, 0, 10023, 1),
(30393, 0, 10023, 2),
(30394, 0, 10023, 3),
(30395, 0, 10023, 4),
(30396, 0, 10023, 5),
(30397, 0, 10023, 6),
(30398, 0, 10023, 7),
(30399, 0, 10023, 8),
(30400, 0, 10023, 9),
(30401, 0, 10023, 10),
(30402, 0, 10023, 11),
(30403, 0, 10023, 12),
(30404, 0, 10023, 13),
(30405, 0, 10023, 14);

REPLACE INTO `merchant_shopids` VALUES (10024, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(17290, 0, 10024, 1),
(17291, 0, 10024, 2),
(17292, 0, 10024, 3),
(17293, 0, 10024, 4),
(17294, 0, 10024, 5),
(17295, 0, 10024, 6),
(17296, 0, 10024, 7),
(17297, 0, 10024, 8),
(17298, 0, 10024, 9),
(17299, 0, 10024, 10),
(17300, 0, 10024, 11),
(17301, 0, 10024, 12),
(17302, 0, 10024, 13),
(17303, 0, 10024, 14);

REPLACE INTO `merchant_shopids` VALUES (10025, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(17324, 0, 10025, 1),
(17325, 0, 10025, 2),
(17326, 0, 10025, 3),
(17327, 0, 10025, 4),
(17328, 0, 10025, 5),
(17329, 0, 10025, 6),
(17330, 0, 10025, 7),
(17331, 0, 10025, 8),
(17332, 0, 10025, 9),
(17333, 0, 10025, 10),
(17334, 0, 10025, 11),
(17335, 0, 10025, 12),
(17336, 0, 10025, 13),
(17337, 0, 10025, 14);

REPLACE INTO `merchant_shopids` VALUES (10026, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(17382, 0, 10026, 1),
(17383, 0, 10026, 2),
(17384, 0, 10026, 3),
(17385, 0, 10026, 4),
(17386, 0, 10026, 5),
(17387, 0, 10026, 6),
(17388, 0, 10026, 7),
(17389, 0, 10026, 8),
(17390, 0, 10026, 9),
(17391, 0, 10026, 10),
(17392, 0, 10026, 11),
(17393, 0, 10026, 12),
(17394, 0, 10026, 13),
(17395, 0, 10026, 14);

REPLACE INTO `merchant_shopids` VALUES (10027, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(17416, 0, 10027, 1),
(17417, 0, 10027, 2),
(17418, 0, 10027, 3),
(17419, 0, 10027, 4),
(17420, 0, 10027, 5),
(17421, 0, 10027, 6),
(17422, 0, 10027, 7),
(17423, 0, 10027, 8),
(17424, 0, 10027, 9),
(17425, 0, 10027, 10),
(17426, 0, 10027, 11),
(17427, 0, 10027, 12),
(17428, 0, 10027, 13),
(17429, 0, 10027, 14);

REPLACE INTO `merchant_shopids` VALUES (10028, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(17754, 0, 10028, 1),
(19441, 0, 10028, 2),
(19442, 0, 10028, 3),
(18550, 0, 10028, 4),
(19443, 0, 10028, 5),
(17526, 0, 10028, 6),
(17527, 0, 10028, 7),
(19447, 0, 10028, 8),
(19448, 0, 10028, 9),
(17371, 0, 10028, 10),
(19440, 0, 10028, 11),
(18564, 0, 10028, 12),
(18565, 0, 10028, 13),
(18566, 0, 10028, 14),
(18569, 0, 10028, 15),
(18570, 0, 10028, 16),
(18571, 0, 10028, 17),
(18574, 0, 10028, 18),
(18575, 0, 10028, 19),
(18576, 0, 10028, 20),
(19166, 0, 10028, 21),
(19167, 0, 10028, 22),
(19168, 0, 10028, 23);

REPLACE INTO `merchant_shopids` VALUES (10029, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(17450, 0, 10029, 1),
(17451, 0, 10029, 2),
(17452, 0, 10029, 3),
(17453, 0, 10029, 4),
(17454, 0, 10029, 5),
(17455, 0, 10029, 6),
(17456, 0, 10029, 7),
(17457, 0, 10029, 8),
(17458, 0, 10029, 9),
(17459, 0, 10029, 10),
(17460, 0, 10029, 11),
(17461, 0, 10029, 12),
(17462, 0, 10029, 13),
(17463, 0, 10029, 14);

REPLACE INTO `merchant_shopids` VALUES (10030, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(19714, 0, 10030, 1),
(19715, 0, 10030, 2),
(19716, 0, 10030, 3),
(19717, 0, 10030, 4),
(19718, 0, 10030, 5),
(19719, 0, 10030, 6),
(19720, 0, 10030, 7),
(19721, 0, 10030, 8),
(19722, 0, 10030, 9),
(19723, 0, 10030, 10),
(19724, 0, 10030, 11),
(17754, 0, 10030, 12),
(19725, 0, 10030, 13),
(19726, 0, 10030, 14),
(19727, 0, 10030, 15),
(19728, 0, 10030, 16),
(19729, 0, 10030, 17),
(19442, 0, 10030, 18),
(19922, 0, 10030, 19),
(19923, 0, 10030, 20),
(19924, 0, 10030, 21),
(19925, 0, 10030, 22),
(19926, 0, 10030, 23),
(19927, 0, 10030, 24),
(19928, 0, 10030, 25),
(19929, 0, 10030, 26),
(19930, 0, 10030, 27),
(19931, 0, 10030, 28),
(19932, 0, 10030, 29),
(18550, 0, 10030, 30),
(19933, 0, 10030, 31),
(19934, 0, 10030, 32),
(19935, 0, 10030, 33),
(19936, 0, 10030, 34),
(19937, 0, 10030, 35),
(17480, 0, 10030, 36);

REPLACE INTO `merchant_shopids` VALUES (10031, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(19746, 0, 10031, 1),
(19747, 0, 10031, 2),
(19748, 0, 10031, 3),
(19749, 0, 10031, 4),
(19750, 0, 10031, 5),
(19751, 0, 10031, 6),
(19752, 0, 10031, 7),
(19753, 0, 10031, 8),
(19754, 0, 10031, 9),
(19755, 0, 10031, 10),
(19756, 0, 10031, 11),
(17754, 0, 10031, 12),
(19757, 0, 10031, 13),
(19758, 0, 10031, 14),
(19759, 0, 10031, 15),
(19760, 0, 10031, 16),
(19761, 0, 10031, 17),
(19442, 0, 10031, 18),
(19538, 0, 10031, 19),
(19539, 0, 10031, 20),
(19540, 0, 10031, 21),
(19541, 0, 10031, 22),
(19542, 0, 10031, 23),
(19543, 0, 10031, 24),
(19544, 0, 10031, 25),
(19545, 0, 10031, 26),
(19546, 0, 10031, 27),
(19547, 0, 10031, 28),
(19548, 0, 10031, 29),
(18550, 0, 10031, 30),
(19549, 0, 10031, 31),
(19550, 0, 10031, 32),
(19551, 0, 10031, 33),
(19552, 0, 10031, 34),
(19553, 0, 10031, 35),
(17354, 0, 10031, 36);

REPLACE INTO `merchant_shopids` VALUES (10032, 'gm');
REPLACE INTO `merchant_buylists` (`item_id`,`price`,`shop_id`,`order`) VALUES
(30310, 0, 10032, 1),
(30311, 0, 10032, 2),
(30312, 0, 10032, 3),
(30313, 0, 10032, 4),
(30314, 0, 10032, 5),
(30315, 0, 10032, 6),
(30316, 0, 10032, 7),
(30317, 0, 10032, 8);