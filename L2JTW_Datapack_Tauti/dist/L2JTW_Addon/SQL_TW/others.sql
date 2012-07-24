/********** Made in Taiwan **********/

/***** 貳幕-嗨翻天 2011.4.28 *****/
/***** GAME *****/ 
/***** auto_announcements.sql *****/
/*
REPLACE INTO `auto_announcements` VALUES
(1,900000,9000000,36000,'突然變成無法移動的狀態時，請先點選畫面左上角自己的名字或血條，再按鍵盤的「Esc」取消目標。','false'),
(2,1800000,9000000,36000,'掉入地獄或是卡點的的玩家，請輸入「/脫逃」的自救指令 - 需5分鐘。','false'),
(3,2700000,9000000,36000,'叫喊買賣時，請至交易頻道發言，勿使用一般頻道影響他人。','false'),
(4,3600000,9000000,36000,'請玩家遵守官網公告之遊戲管理規章相關內容，並配合GM進行遊戲。','false'),
(5,4500000,9000000,36000,'玩家可以使用「/GM」來查詢目前正在線上服務的GM名單。','false'),
(6,5400000,9000000,36000,'請玩家注意個人商店設定金額，視窗右下顯示金額即為販售獲利之金額。','false'),
(7,6300000,9000000,36000,'請大家發揮良好遊戲道德，互相尊重禮讓，共同打造天堂II優良文化。','false'),
(8,7200000,9000000,36000,'提醒您慎重保管個人帳號、密碼；養成良好的網路使用環境，以確保你的帳號資料安全。','false'),
(9,8100000,9000000,36000,'過度沉溺遊戲易造成身體及精神狀況不佳，請適度的休息，確保您的健康。','false'),
(10,9000000,9000000,36000,'不論是在進行交易或是買賣物品的時候，請多加確認數量及所要交易的角色名稱，以避免交易錯誤造成您不必要的損失。','false');
*/

/***** GAME *****/ 
/***** auto_chat_text.sql *****/
UPDATE `auto_chat_text` SET `chatText` = '%player_cabal_loser%！大家等著絕望吧！死亡女神即將要降臨了！' WHERE `chatText` = '%player_cabal_loser%! All is lost! Prepare to meet the goddess of death!';
UPDATE `auto_chat_text` SET `chatText` = '%player_cabal_loser%！你已經遭遇不幸！' WHERE `chatText` = '%player_cabal_loser%! You bring an ill wind!';
UPDATE `auto_chat_text` SET `chatText` = '%player_cabal_loser%！還不如快點放棄！' WHERE `chatText` = '%player_cabal_loser%! You might as well give up!';
UPDATE `auto_chat_text` SET `chatText` = '失敗者將遭受詛咒！' WHERE `chatText` = 'A curse upon you!';
UPDATE `auto_chat_text` SET `chatText` = '大家等著絕望吧！死亡女神即將要降臨了！' WHERE `chatText` = 'All is lost! Prepare to meet the goddess of death!';
UPDATE `auto_chat_text` SET `chatText` = '大家等著絕望吧！滅亡的預言即將就要實現了！' WHERE `chatText` = 'All is lost! The prophecy of destruction has been fulfilled!';
UPDATE `auto_chat_text` SET `chatText` = '聆聽滅亡的預言吧！末日時代即將要來臨了！' WHERE `chatText` = 'The prophecy of doom has awoken!';
UPDATE `auto_chat_text` SET `chatText` = '這個世界即將滅亡！' WHERE `chatText` = 'This world will soon be annihilated!';
UPDATE `auto_chat_text` SET `chatText` = '%player_cabal_winner%！施予你啟示的祝福！' WHERE `chatText` = '%player_cabal_winner%! I bestow on you the authority of the abyss!';
UPDATE `auto_chat_text` SET `chatText` = '%player_cabal_winner%！黑暗將會被放逐！' WHERE `chatText` = '%player_cabal_winner%, Darkness shall be banished forever!';
UPDATE `auto_chat_text` SET `chatText` = '%player_cabal_winner%！榮耀時刻就在眼前！' WHERE `chatText` = '%player_cabal_winner%, the time for glory is at hand!';
UPDATE `auto_chat_text` SET `chatText` = '迎接勝利的到來吧！' WHERE `chatText` = 'All hail the eternal twilight!';
UPDATE `auto_chat_text` SET `chatText` = '聆聽黑暗的啟示吧！混沌的時代已經開始了！' WHERE `chatText` = 'As foretold in the prophecy of darkness, the era of chaos has begun!';
UPDATE `auto_chat_text` SET `chatText` = '審判的日子即將來臨！' WHERE `chatText` = 'The day of judgment is near!';
UPDATE `auto_chat_text` SET `chatText` = '聆聽黑暗的啟示吧！死亡的樂園即將來臨了！' WHERE `chatText` = 'The prophecy of darkness has been fulfilled!';
UPDATE `auto_chat_text` SET `chatText` = '聆聽黑暗的啟示吧！沉睡中的黑暗甦醒了！' WHERE `chatText` = 'The prophecy of darkness has come to pass!';

/***** sysstring-tw *****/ 
/***** char_templates.sql *****/
UPDATE `char_templates` SET `ClassName` = '戰士' WHERE `ClassId` = 0;
UPDATE `char_templates` SET `ClassName` = '鬥士' WHERE `ClassId` = 1;
UPDATE `char_templates` SET `ClassName` = '劍鬥士' WHERE `ClassId` = 2;
UPDATE `char_templates` SET `ClassName` = '傭兵' WHERE `ClassId` = 3;
UPDATE `char_templates` SET `ClassName` = '騎士' WHERE `ClassId` = 4;
UPDATE `char_templates` SET `ClassName` = '聖騎士' WHERE `ClassId` = 5;
UPDATE `char_templates` SET `ClassName` = '闇騎士' WHERE `ClassId` = 6;
UPDATE `char_templates` SET `ClassName` = '盜賊' WHERE `ClassId` = 7;
UPDATE `char_templates` SET `ClassName` = '寶藏獵人' WHERE `ClassId` = 8;
UPDATE `char_templates` SET `ClassName` = '鷹眼' WHERE `ClassId` = 9;
UPDATE `char_templates` SET `ClassName` = '法師' WHERE `ClassId` = 10;
UPDATE `char_templates` SET `ClassName` = '巫師' WHERE `ClassId` = 11;
UPDATE `char_templates` SET `ClassName` = '術士' WHERE `ClassId` = 12;
UPDATE `char_templates` SET `ClassName` = '死靈法師' WHERE `ClassId` = 13;
UPDATE `char_templates` SET `ClassName` = '法魔' WHERE `ClassId` = 14;
UPDATE `char_templates` SET `ClassName` = '牧師' WHERE `ClassId` = 15;
UPDATE `char_templates` SET `ClassName` = '主教' WHERE `ClassId` = 16;
UPDATE `char_templates` SET `ClassName` = '先知' WHERE `ClassId` = 17;
UPDATE `char_templates` SET `ClassName` = '精靈戰士' WHERE `ClassId` = 18;
UPDATE `char_templates` SET `ClassName` = '精靈騎士' WHERE `ClassId` = 19;
UPDATE `char_templates` SET `ClassName` = '聖殿騎士' WHERE `ClassId` = 20;
UPDATE `char_templates` SET `ClassName` = '劍術詩人' WHERE `ClassId` = 21;
UPDATE `char_templates` SET `ClassName` = '精靈巡守' WHERE `ClassId` = 22;
UPDATE `char_templates` SET `ClassName` = '大地行者' WHERE `ClassId` = 23;
UPDATE `char_templates` SET `ClassName` = '銀月遊俠' WHERE `ClassId` = 24;
UPDATE `char_templates` SET `ClassName` = '精靈法師' WHERE `ClassId` = 25;
UPDATE `char_templates` SET `ClassName` = '精靈巫師' WHERE `ClassId` = 26;
UPDATE `char_templates` SET `ClassName` = '咒術詩人' WHERE `ClassId` = 27;
UPDATE `char_templates` SET `ClassName` = '元素使' WHERE `ClassId` = 28;
UPDATE `char_templates` SET `ClassName` = '神使' WHERE `ClassId` = 29;
UPDATE `char_templates` SET `ClassName` = '長老' WHERE `ClassId` = 30;
UPDATE `char_templates` SET `ClassName` = '黑暗戰士' WHERE `ClassId` = 31;
UPDATE `char_templates` SET `ClassName` = '沼澤騎士' WHERE `ClassId` = 32;
UPDATE `char_templates` SET `ClassName` = '席琳騎士' WHERE `ClassId` = 33;
UPDATE `char_templates` SET `ClassName` = '劍刃舞者' WHERE `ClassId` = 34;
UPDATE `char_templates` SET `ClassName` = '暗殺者' WHERE `ClassId` = 35;
UPDATE `char_templates` SET `ClassName` = '深淵行者' WHERE `ClassId` = 36;
UPDATE `char_templates` SET `ClassName` = '闇影遊俠' WHERE `ClassId` = 37;
UPDATE `char_templates` SET `ClassName` = '黑暗法師' WHERE `ClassId` = 38;
UPDATE `char_templates` SET `ClassName` = '黑暗巫師' WHERE `ClassId` = 39;
UPDATE `char_templates` SET `ClassName` = '狂咒術士' WHERE `ClassId` = 40;
UPDATE `char_templates` SET `ClassName` = '闇影召喚士' WHERE `ClassId` = 41;
UPDATE `char_templates` SET `ClassName` = '席琳神使' WHERE `ClassId` = 42;
UPDATE `char_templates` SET `ClassName` = '席琳長老' WHERE `ClassId` = 43;
UPDATE `char_templates` SET `ClassName` = '半獸人戰士' WHERE `ClassId` = 44;
UPDATE `char_templates` SET `ClassName` = '半獸人突襲者' WHERE `ClassId` = 45;
UPDATE `char_templates` SET `ClassName` = '破壞者' WHERE `ClassId` = 46;
UPDATE `char_templates` SET `ClassName` = '半獸人武者' WHERE `ClassId` = 47;
UPDATE `char_templates` SET `ClassName` = '暴君' WHERE `ClassId` = 48;
UPDATE `char_templates` SET `ClassName` = '半獸人法師' WHERE `ClassId` = 49;
UPDATE `char_templates` SET `ClassName` = '半獸人巫醫' WHERE `ClassId` = 50;
UPDATE `char_templates` SET `ClassName` = '霸主' WHERE `ClassId` = 51;
UPDATE `char_templates` SET `ClassName` = '戰狂' WHERE `ClassId` = 52;
UPDATE `char_templates` SET `ClassName` = '矮人戰士' WHERE `ClassId` = 53;
UPDATE `char_templates` SET `ClassName` = '收集者' WHERE `ClassId` = 54;
UPDATE `char_templates` SET `ClassName` = '賞金獵人' WHERE `ClassId` = 55;
UPDATE `char_templates` SET `ClassName` = '工匠' WHERE `ClassId` = 56;
UPDATE `char_templates` SET `ClassName` = '戰爭工匠' WHERE `ClassId` = 57;
UPDATE `char_templates` SET `ClassName` = '決鬥者' WHERE `ClassId` = 88;
UPDATE `char_templates` SET `ClassName` = '猛將' WHERE `ClassId` = 89;
UPDATE `char_templates` SET `ClassName` = '聖凰騎士' WHERE `ClassId` = 90;
UPDATE `char_templates` SET `ClassName` = '煉獄騎士' WHERE `ClassId` = 91;
UPDATE `char_templates` SET `ClassName` = '人馬' WHERE `ClassId` = 92;
UPDATE `char_templates` SET `ClassName` = '冒險英豪' WHERE `ClassId` = 93;
UPDATE `char_templates` SET `ClassName` = '大魔導士' WHERE `ClassId` = 94;
UPDATE `char_templates` SET `ClassName` = '魂狩術士' WHERE `ClassId` = 95;
UPDATE `char_templates` SET `ClassName` = '祕儀召主' WHERE `ClassId` = 96;
UPDATE `char_templates` SET `ClassName` = '樞機主教' WHERE `ClassId` = 97;
UPDATE `char_templates` SET `ClassName` = '昭聖者' WHERE `ClassId` = 98;
UPDATE `char_templates` SET `ClassName` = '伊娃神殿騎士' WHERE `ClassId` = 99;
UPDATE `char_templates` SET `ClassName` = '伊娃吟遊詩人' WHERE `ClassId` = 100;
UPDATE `char_templates` SET `ClassName` = '疾風浪人' WHERE `ClassId` = 101;
UPDATE `char_templates` SET `ClassName` = '月光箭靈' WHERE `ClassId` = 102;
UPDATE `char_templates` SET `ClassName` = '伊娃祕術詩人' WHERE `ClassId` = 103;
UPDATE `char_templates` SET `ClassName` = '元素支配者' WHERE `ClassId` = 104;
UPDATE `char_templates` SET `ClassName` = '伊娃聖者' WHERE `ClassId` = 105;
UPDATE `char_templates` SET `ClassName` = '席琳冥殿騎士' WHERE `ClassId` = 106;
UPDATE `char_templates` SET `ClassName` = '幽冥舞者' WHERE `ClassId` = 107;
UPDATE `char_templates` SET `ClassName` = '魅影獵者' WHERE `ClassId` = 108;
UPDATE `char_templates` SET `ClassName` = '幽冥箭靈' WHERE `ClassId` = 109;
UPDATE `char_templates` SET `ClassName` = '暴風狂嘯者' WHERE `ClassId` = 110;
UPDATE `char_templates` SET `ClassName` = '闇影支配者' WHERE `ClassId` = 111;
UPDATE `char_templates` SET `ClassName` = '席琳聖者' WHERE `ClassId` = 112;
UPDATE `char_templates` SET `ClassName` = '泰坦' WHERE `ClassId` = 113;
UPDATE `char_templates` SET `ClassName` = '卡巴塔里宗師' WHERE `ClassId` = 114;
UPDATE `char_templates` SET `ClassName` = '君主' WHERE `ClassId` = 115;
UPDATE `char_templates` SET `ClassName` = '末日戰狂' WHERE `ClassId` = 116;
UPDATE `char_templates` SET `ClassName` = '財富獵人' WHERE `ClassId` = 117;
UPDATE `char_templates` SET `ClassName` = '巨匠' WHERE `ClassId` = 118;
UPDATE `char_templates` SET `ClassName` = '闇天使士兵' WHERE `ClassId` = 123;
UPDATE `char_templates` SET `ClassName` = '闇天使士兵' WHERE `ClassId` = 124;
UPDATE `char_templates` SET `ClassName` = '裝甲突襲兵' WHERE `ClassId` = 125;
UPDATE `char_templates` SET `ClassName` = '狙擊衛士' WHERE `ClassId` = 126;
UPDATE `char_templates` SET `ClassName` = '狂戰士' WHERE `ClassId` = 127;
UPDATE `char_templates` SET `ClassName` = '碎魂者' WHERE `ClassId` = 128;
UPDATE `char_templates` SET `ClassName` = '碎魂者' WHERE `ClassId` = 129;
UPDATE `char_templates` SET `ClassName` = '弩弓遊俠' WHERE `ClassId` = 130;
UPDATE `char_templates` SET `ClassName` = '末日使者' WHERE `ClassId` = 131;
UPDATE `char_templates` SET `ClassName` = '追魂使' WHERE `ClassId` = 132;
UPDATE `char_templates` SET `ClassName` = '追魂使' WHERE `ClassId` = 133;
UPDATE `char_templates` SET `ClassName` = '魔彈射手' WHERE `ClassId` = 134;
UPDATE `char_templates` SET `ClassName` = '戰鬥巡官' WHERE `ClassId` = 135;
UPDATE `char_templates` SET `ClassName` = '軍武判官' WHERE `ClassId` = 136;
UPDATE `char_templates` SET `ClassName` = '席格爾騎士' WHERE `ClassId` = 139;
UPDATE `char_templates` SET `ClassName` = '提爾鬥士' WHERE `ClassId` = 140;
UPDATE `char_templates` SET `ClassName` = '歐瑟遊俠' WHERE `ClassId` = 141;
UPDATE `char_templates` SET `ClassName` = '尤爾弓手' WHERE `ClassId` = 142;
UPDATE `char_templates` SET `ClassName` = '菲歐巫師' WHERE `ClassId` = 143;
UPDATE `char_templates` SET `ClassName` = '伊斯法師' WHERE `ClassId` = 144;
UPDATE `char_templates` SET `ClassName` = '維因召喚士' WHERE `ClassId` = 145;
UPDATE `char_templates` SET `ClassName` = '艾羅牧師' WHERE `ClassId` = 146;

/***** castlename-tw *****/ 
/***** auction.sql *****/
UPDATE `auction` SET `itemName` = '古魯丁城鎮月長石廳' WHERE `itemId` = 22;
UPDATE `auction` SET `itemName` = '古魯丁城鎮瑪瑙廳' WHERE `itemId` = 23;
UPDATE `auction` SET `itemName` = '古魯丁城鎮黃玉廳' WHERE `itemId` = 24;
UPDATE `auction` SET `itemName` = '古魯丁城鎮紅寶石廳' WHERE `itemId` = 25;
UPDATE `auction` SET `itemName` = '古魯丁村莊水晶廳' WHERE `itemId` = 26;
UPDATE `auction` SET `itemName` = '古魯丁村莊瑪瑙廳' WHERE `itemId` = 27;
UPDATE `auction` SET `itemName` = '古魯丁村莊藍寶石廳' WHERE `itemId` = 28;
UPDATE `auction` SET `itemName` = '古魯丁村莊月長石廳' WHERE `itemId` = 29;
UPDATE `auction` SET `itemName` = '古魯丁村莊綠寶石廳' WHERE `itemId` = 30;
UPDATE `auction` SET `itemName` = '狄恩黑之公館' WHERE `itemId` = 31;
UPDATE `auction` SET `itemName` = '狄恩紅之公館' WHERE `itemId` = 32;
UPDATE `auction` SET `itemName` = '狄恩綠之公館' WHERE `itemId` = 33;
UPDATE `auction` SET `itemName` = '亞丁黃金接待室' WHERE `itemId` = 36;
UPDATE `auction` SET `itemName` = '亞丁白銀接待室' WHERE `itemId` = 37;
UPDATE `auction` SET `itemName` = '亞丁米索莉接待室' WHERE `itemId` = 38;
UPDATE `auction` SET `itemName` = '亞丁銀色小屋' WHERE `itemId` = 39;
UPDATE `auction` SET `itemName` = '亞丁金色小屋' WHERE `itemId` = 40;
UPDATE `auction` SET `itemName` = '亞丁青銅接待室' WHERE `itemId` = 41;
UPDATE `auction` SET `itemName` = '奇岩黃金接待室' WHERE `itemId` = 42;
UPDATE `auction` SET `itemName` = '奇岩白銀接待室' WHERE `itemId` = 43;
UPDATE `auction` SET `itemName` = '奇岩米索莉接待室' WHERE `itemId` = 44;
UPDATE `auction` SET `itemName` = '奇岩青銅接待室' WHERE `itemId` = 45;
UPDATE `auction` SET `itemName` = '奇岩銀色小屋' WHERE `itemId` = 46;
UPDATE `auction` SET `itemName` = '高達特月長石廳' WHERE `itemId` = 47;
UPDATE `auction` SET `itemName` = '高達特瑪瑙廳' WHERE `itemId` = 48;
UPDATE `auction` SET `itemName` = '高達特綠寶石廳' WHERE `itemId` = 49;
UPDATE `auction` SET `itemName` = '高達特藍寶石廳' WHERE `itemId` = 50;
UPDATE `auction` SET `itemName` = '魯因蒙特接待室' WHERE `itemId` = 51;
UPDATE `auction` SET `itemName` = '魯因修特倫接待室' WHERE `itemId` = 52;
UPDATE `auction` SET `itemName` = '魯因維納斯接待室' WHERE `itemId` = 53;
UPDATE `auction` SET `itemName` = '魯因瑪爾斯接待室' WHERE `itemId` = 54;
UPDATE `auction` SET `itemName` = '魯因雅蒂斯接待室' WHERE `itemId` = 55;
UPDATE `auction` SET `itemName` = '魯因普魯托接待室' WHERE `itemId` = 56;
UPDATE `auction` SET `itemName` = '魯因特拉潘接待室' WHERE `itemId` = 57;
UPDATE `auction` SET `itemName` = '修加特鋼鐵之廳' WHERE `itemId` = 58;
UPDATE `auction` SET `itemName` = '修加特冷鑄之廳' WHERE `itemId` = 59;
UPDATE `auction` SET `itemName` = '修加特熱煉之廳' WHERE `itemId` = 60;
UPDATE `auction` SET `itemName` = '修加特鈦金之聽' WHERE `itemId` = 61;

/***** castlename-tw *****/ 
/***** clanhall.sql *****/
UPDATE `clanhall` SET `name` = '反抗軍要塞', `location` = '狄恩', `desc` = '有豺狼游擊隊的根據地' WHERE `id` = 21;
UPDATE `clanhall` SET `name` = '古魯丁城鎮月長石廳', `location` = '古魯丁城鎮', `desc` = '在古魯丁城鎮的根據地' WHERE `id` = 22;
UPDATE `clanhall` SET `name` = '古魯丁城鎮瑪瑙廳', `location` = '古魯丁城鎮', `desc` = '在古魯丁城鎮的根據地' WHERE `id` = 23;
UPDATE `clanhall` SET `name` = '古魯丁城鎮黃玉廳', `location` = '古魯丁城鎮', `desc` = '在古魯丁城鎮的根據地' WHERE `id` = 24;
UPDATE `clanhall` SET `name` = '古魯丁城鎮紅寶石廳', `location` = '古魯丁城鎮', `desc` = '在古魯丁城鎮的根據地' WHERE `id` = 25;
UPDATE `clanhall` SET `name` = '古魯丁村莊水晶廳', `location` = '古魯丁村莊', `desc` = '在古魯丁村莊的根據地' WHERE `id` = 26;
UPDATE `clanhall` SET `name` = '古魯丁村莊瑪瑙廳', `location` = '古魯丁村莊', `desc` = '在古魯丁村莊的根據地' WHERE `id` = 27;
UPDATE `clanhall` SET `name` = '古魯丁村莊藍寶石廳', `location` = '古魯丁村莊', `desc` = '在古魯丁村莊的根據地' WHERE `id` = 28;
UPDATE `clanhall` SET `name` = '古魯丁村莊月長石廳', `location` = '古魯丁村莊', `desc` = '在古魯丁村莊的根據地' WHERE `id` = 29;
UPDATE `clanhall` SET `name` = '古魯丁村莊綠寶石廳', `location` = '古魯丁村莊', `desc` = '在古魯丁村莊的根據地' WHERE `id` = 30;
UPDATE `clanhall` SET `name` = '狄恩黑之公館', `location` = '狄恩', `desc` = '在狄恩城鎮的根據地' WHERE `id` = 31;
UPDATE `clanhall` SET `name` = '狄恩紅之公館', `location` = '狄恩', `desc` = '在狄恩城鎮的根據地' WHERE `id` = 32;
UPDATE `clanhall` SET `name` = '狄恩綠之公館', `location` = '狄恩', `desc` = '在狄恩城鎮的根據地' WHERE `id` = 33;
UPDATE `clanhall` SET `name` = '毀壞的城堡', `location` = '亞丁', `desc` = '' WHERE `id` = 34;
UPDATE `clanhall` SET `name` = '山賊城寨', `location` = '歐瑞', `desc` = '' WHERE `id` = 35;
UPDATE `clanhall` SET `name` = '亞丁黃金接待室', `location` = '亞丁', `desc` = '在亞丁城鎮的高級根據地' WHERE `id` = 36;
UPDATE `clanhall` SET `name` = '亞丁白銀接待室', `location` = '亞丁', `desc` = '在亞丁城鎮的高級根據地' WHERE `id` = 37;
UPDATE `clanhall` SET `name` = '亞丁米索莉接待室', `location` = '亞丁', `desc` = '在亞丁城鎮的高級根據地' WHERE `id` = 38;
UPDATE `clanhall` SET `name` = '亞丁銀色小屋', `location` = '亞丁', `desc` = '在亞丁城鎮的高級根據地' WHERE `id` = 39;
UPDATE `clanhall` SET `name` = '亞丁金色小屋', `location` = '亞丁', `desc` = '在亞丁城鎮的高級根據地' WHERE `id` = 40;
UPDATE `clanhall` SET `name` = '亞丁青銅接待室', `location` = '亞丁', `desc` = '在亞丁城鎮的高級根據地' WHERE `id` = 41;
UPDATE `clanhall` SET `name` = '奇岩黃金接待室', `location` = '奇岩', `desc` = '在奇岩城鎮的高級根據地' WHERE `id` = 42;
UPDATE `clanhall` SET `name` = '奇岩白銀接待室', `location` = '奇岩', `desc` = '在奇岩城鎮的高級根據地' WHERE `id` = 43;
UPDATE `clanhall` SET `name` = '奇岩米索莉接待室', `location` = '奇岩', `desc` = '在奇岩城鎮的高級根據地' WHERE `id` = 44;
UPDATE `clanhall` SET `name` = '奇岩青銅接待室', `location` = '奇岩', `desc` = '在奇岩城鎮的高級根據地' WHERE `id` = 45;
UPDATE `clanhall` SET `name` = '奇岩銀色小屋', `location` = '奇岩', `desc` = '在奇岩城鎮的高級根據地' WHERE `id` = 46;
UPDATE `clanhall` SET `name` = '高達特月長石廳', `location` = '高達特', `desc` = '在高達特城鎮的高級根據地' WHERE `id` = 47;
UPDATE `clanhall` SET `name` = '高達特瑪瑙廳', `location` = '高達特', `desc` = '在高達特城鎮的高級根據地' WHERE `id` = 48;
UPDATE `clanhall` SET `name` = '高達特綠寶石廳', `location` = '高達特', `desc` = '在高達特城鎮的高級根據地' WHERE `id` = 49;
UPDATE `clanhall` SET `name` = '高達特藍寶石廳', `location` = '高達特', `desc` = '在高達特城鎮的高級根據地' WHERE `id` = 50;
UPDATE `clanhall` SET `name` = '魯因蒙特接待室', `location` = '魯因', `desc` = '在魯因城鎮的高級根據地' WHERE `id` = 51;
UPDATE `clanhall` SET `name` = '魯因修特倫接待室', `location` = '魯因', `desc` = '在魯因城鎮的高級根據地' WHERE `id` = 52;
UPDATE `clanhall` SET `name` = '魯因維納斯接待室', `location` = '魯因', `desc` = '在魯因城鎮的高級根據地' WHERE `id` = 53;
UPDATE `clanhall` SET `name` = '魯因瑪爾斯接待室', `location` = '魯因', `desc` = '在魯因城鎮的高級根據地' WHERE `id` = 54;
UPDATE `clanhall` SET `name` = '魯因雅蒂斯接待室', `location` = '魯因', `desc` = '在魯因城鎮的高級根據地' WHERE `id` = 55;
UPDATE `clanhall` SET `name` = '魯因普魯托接待室', `location` = '魯因', `desc` = '在魯因城鎮的高級根據地' WHERE `id` = 56;
UPDATE `clanhall` SET `name` = '魯因特拉潘接待室', `location` = '魯因', `desc` = '在魯因城鎮的高級根據地' WHERE `id` = 57;
UPDATE `clanhall` SET `name` = '修加特鋼鐵之廳', `location` = '修加特', `desc` = '在修加特城鎮的高級根據地' WHERE `id` = 58;
UPDATE `clanhall` SET `name` = '修加特冷鑄之廳', `location` = '修加特', `desc` = '在修加特城鎮的高級根據地' WHERE `id` = 59;
UPDATE `clanhall` SET `name` = '修加特熱煉之廳', `location` = '修加特', `desc` = '在修加特城鎮的高級根據地' WHERE `id` = 60;
UPDATE `clanhall` SET `name` = '修加特鈦金之聽', `location` = '修加特', `desc` = '在修加特城鎮的高級根據地' WHERE `id` = 61;
UPDATE `clanhall` SET `name` = '虹彩之泉', `location` = '高達特', `desc` = '' WHERE `id` = 62;
UPDATE `clanhall` SET `name` = '野獸農莊', `location` = '魯因', `desc` = '' WHERE `id` = 63;
UPDATE `clanhall` SET `name` = '亡者的要塞', `location` = '魯因', `desc` = '' WHERE `id` = 64;

/***** castlename-tw *****/ 
/***** fort.sql *****/
-- UPDATE `fort` SET `name` = '野營要塞' WHERE `id` = 101;
-- UPDATE `fort` SET `name` = '古魯丁南部要塞' WHERE `id` = 102;
-- UPDATE `fort` SET `name` = '蜂窩要塞' WHERE `id` = 103;
-- UPDATE `fort` SET `name` = '峽谷要塞' WHERE `id` = 104;
-- UPDATE `fort` SET `name` = '象牙塔要塞' WHERE `id` = 105;
-- UPDATE `fort` SET `name` = '湖泊要塞' WHERE `id` = 106;
-- UPDATE `fort` SET `name` = '盆地要塞' WHERE `id` = 107;
-- UPDATE `fort` SET `name` = '白沙灘要塞' WHERE `id` = 108;
-- UPDATE `fort` SET `name` = '前哨基地要塞' WHERE `id` = 109;
-- UPDATE `fort` SET `name` = '沼澤要塞' WHERE `id` = 110;
-- UPDATE `fort` SET `name` = '遺蹟要塞' WHERE `id` = 111;
-- UPDATE `fort` SET `name` = '芙羅蘭邊境要塞' WHERE `id` = 112;
-- UPDATE `fort` SET `name` = '薄霧山脈邊境要塞' WHERE `id` = 113;
-- UPDATE `fort` SET `name` = '塔諾邊境要塞' WHERE `id` = 114;
-- UPDATE `fort` SET `name` = '巨龍士伯吟邊境要塞' WHERE `id` = 115;
-- UPDATE `fort` SET `name` = '地龍的邊境要塞' WHERE `id` = 116;
-- UPDATE `fort` SET `name` = '西部國境邊境要塞' WHERE `id` = 117;
-- UPDATE `fort` SET `name` = '獵人的邊境要塞' WHERE `id` = 118;
-- UPDATE `fort` SET `name` = '平原邊境要塞' WHERE `id` = 119;
-- UPDATE `fort` SET `name` = '死靈的邊境要塞' WHERE `id` = 120;
-- UPDATE `fort` SET `name` = '聖者邊境要塞' WHERE `id` = 121;

/***** skillname-tw *****/ 
/***** helper_buff_list.sql *****/
UPDATE `helper_buff_list` SET `name` = '冒險家用治癒晶體' WHERE `skill_id` = 4338;
UPDATE `helper_buff_list` SET `name` = '冒險家用 風之疾走' WHERE `skill_id` = 5627;
UPDATE `helper_buff_list` SET `name` = '冒險家用 保護盾' WHERE `skill_id` = 5628;
UPDATE `helper_buff_list` SET `name` = '冒險家用 神佑之體' WHERE `skill_id` = 5629;
UPDATE `helper_buff_list` SET `name` = '冒險家用 吸血怒擊' WHERE `skill_id` = 5630;
UPDATE `helper_buff_list` SET `name` = '冒險家用 強癒術' WHERE `skill_id` = 5631;
UPDATE `helper_buff_list` SET `name` = '冒險家用 速度激發' WHERE `skill_id` = 5632;
UPDATE `helper_buff_list` SET `name` = '冒險家用 神佑之魂' WHERE `skill_id` = 5633;
UPDATE `helper_buff_list` SET `name` = '冒險家用 靈活思緒' WHERE `skill_id` = 5634;
UPDATE `helper_buff_list` SET `name` = '冒險家用 精神專注' WHERE `skill_id` = 5635;
UPDATE `helper_buff_list` SET `name` = '冒險家用 魔力催化' WHERE `skill_id` = 5636;
UPDATE `helper_buff_list` SET `name` = '冒險家用 魔法屏障' WHERE `skill_id` = 5637;

/***** Done by vdmyagami！ *****/