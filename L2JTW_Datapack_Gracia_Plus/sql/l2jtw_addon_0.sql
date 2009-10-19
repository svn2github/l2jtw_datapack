/************ Made in Taiwan ************/

/************ CT 2.5 聖翼使命修正 ************/

-- 斗篷改為通用,不再分重/輕/法/闇天使
UPDATE `armor` SET `armor_type` = 'none' WHERE `item_id` IN (13687,13890,14609); -- 重裝斗篷改通用斗篷
UPDATE `items` SET `item_id` = 13687 WHERE `item_id` IN (13688,13689,13690); -- 輕/法/闇天使的騎士斗篷改通用斗篷
UPDATE `items` SET `item_id` = 13890 WHERE `item_id` IN (13889,13891,13892); -- 輕/法/闇天使的聖靈斗篷改通用斗篷
UPDATE `items` SET `item_id` = 14609 WHERE `item_id` IN (14601,14602,14608,14610); -- 輕/法/闇天使的古代斗篷改通用斗篷
DELETE FROM `merchant_buylists` WHERE `item_id` IN (13688,13689,13690,13889,13891,13892,14601,14602,14608,14610); -- 刪除輕/法/闇天使的斗篷的販賣
