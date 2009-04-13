Set Names utf8;
-- ----------------------------
-- Table structure for auto_announcements
-- ----------------------------
DROP TABLE IF EXISTS `autoannouncements`;
DROP TABLE IF EXISTS `auto_announcements`;
CREATE TABLE `auto_announcements` (
  `id` INT(11) NOT NULL,
  `initial` BIGINT(20) NOT NULL,
  `delay` BIGINT(20) NOT NULL,
  `cycle` INT(11) NOT NULL,
  `memo` TEXT DEFAULT NULL,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8;

INSERT INTO `auto_announcements` VALUES
(1,900,9000,0,'突然變成無法移動的狀態時，請先點選畫面左上角自己的名字或血條，再按鍵盤的「Esc」取消目標。'),
(2,1800,9000,0,'掉入地獄或是卡點的的玩家，請輸入「/脫逃」的自救指令 - 需5分鐘。'),
(3,2700,9000,0,'叫喊買賣時，請至交易頻道發言，勿使用一般頻道影響他人。'),
(4,3600,9000,0,'請玩家遵守官網公告之遊戲管理規章相關內容，並配合GM進行遊戲。'),
(5,4500,9000,0,'玩家可以使用「/GM」來查詢目前正在線上服務的GM名單。'),
(6,5400,9000,0,'請玩家注意個人商店設定金額，視窗右下顯示金額即為販售獲利之金額。'),
(7,6300,9000,0,'請大家發揮良好遊戲道德，互相尊重禮讓，共同打造天堂II優良文化。'),
(8,7200,9000,0,'提醒您慎重保管個人帳號、密碼；養成良好的網路使用環境，以確保你的帳號資料安全。'),
(9,8100,9000,0,'過度沉溺遊戲易造成身體及精神狀況不佳，請適度的休息，確保您的健康。'),
(10,9000,9000,0,'不論是在進行交易或是買賣物品的時候，請多加確認數量及所要交易的角色名稱，以避免交易錯誤造成您不必要的損失。');