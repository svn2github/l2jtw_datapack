Set Names utf8;
/************ Made in Taiwan ************/

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

/***** 闇天使版資料 *****/ 
/***** walker_routes.sql *****/
/***** 黑暗精靈村莊 *****/
/***** 31361 長老執行者 克里德 *****/
UPDATE `walker_routes` SET `chatText` = '幾天後將開始黑暗儀式，需要更注重警備工作！' WHERE `route_id` = '1' AND `move_point` = 5;
/***** 31360 長老代理人艾爾海娜 *****/
UPDATE `walker_routes` SET `chatText` = '您很辛苦。萊伊爾拉！' WHERE `route_id` = '2' AND `move_point` = 5;
UPDATE `walker_routes` SET `chatText` = '多勞您辛苦了！' WHERE `route_id` = '2' AND `move_point` = 11;

/***** 矮人村莊 *****/
/***** 31362 使者 泰特 *****/
UPDATE `walker_routes` SET `chatText` = '里德！ 摩普琳！ 艾兒黎！ 你們大家都好嗎？' WHERE `route_id` = '3' AND `move_point` = 1;
UPDATE `walker_routes` SET `chatText` = '好！那麼就開始轉一轉？' WHERE `route_id` = '3' AND `move_point` = 7;
UPDATE `walker_routes` SET `chatText` = '卡黎塔！ 米恩！ 很愉快的一天！' WHERE `route_id` = '3' AND `move_point` = 12;
/***** 31363 信使 洛金 *****/
UPDATE `walker_routes` SET `chatText` = '那個鼠輩！ 到底躲在哪兒？' WHERE `route_id` = '4' AND `move_point` = 1;
UPDATE `walker_routes` SET `chatText` = '今天你沒看到吐魯克嗎？' WHERE `route_id` = '4' AND `move_point` = 7;
UPDATE `walker_routes` SET `chatText` = '你沒看到吐魯克嗎？' WHERE `route_id` = '4' AND `move_point` = 10;

/***** 精靈村莊 *****/
/***** 31359 世界樹守護者 傑洛迪 *****/
UPDATE `walker_routes` SET `chatText` = '為了救活世界樹該怎麼做？' WHERE `route_id` = '5' AND `move_point` = 3;
UPDATE `walker_routes` SET `chatText` = '世界樹在逐漸凋零枯萎...' WHERE `route_id` = '5' AND `move_point` = 4;
UPDATE `walker_routes` SET `chatText` = '世界樹在逐漸凋零枯萎...' WHERE `route_id` = '5' AND `move_point` = 10;
UPDATE `walker_routes` SET `chatText` = '為了救活世界樹該怎麼做？' WHERE `route_id` = '5' AND `move_point` = 11;
/***** 31358 吟遊詩人 卡斯爾 *****/
UPDATE `walker_routes` SET `chatText` = '米帝爾，湖水的和平與你同在..' WHERE `route_id` = '6' AND `move_point` = 1;
UPDATE `walker_routes` SET `chatText` = '無論何時凝視世界樹都是如此美麗..' WHERE `route_id` = '6' AND `move_point` = 5;
UPDATE `walker_routes` SET `chatText` = '無論何時凝視世界樹都是如此美麗..' WHERE `route_id` = '6' AND `move_point` = 13;

/***** 說話之島村莊 *****/
/***** 31357 書記官 萊安德路 *****/
UPDATE `walker_routes` SET `chatText` = '他到底在哪裡呢？' WHERE `route_id` = '7' AND `move_point` = 1;
UPDATE `walker_routes` SET `chatText` = '你有看到溫達伍德嗎？' WHERE `route_id` = '7' AND `move_point` = 4;
UPDATE `walker_routes` SET `chatText` = '到底去哪裡呢？' WHERE `route_id` = '7' AND `move_point` = 6;
UPDATE `walker_routes` SET `chatText` = '到底去哪裡呢？' WHERE `route_id` = '7' AND `move_point` = 16;
UPDATE `walker_routes` SET `chatText` = '你有看到溫達伍德嗎？' WHERE `route_id` = '7' AND `move_point` = 18;
/***** 31356 使者 雷米 *****/
UPDATE `walker_routes` SET `chatText` = '運送給雷克特？好好，知道了~' WHERE `route_id` = '8' AND `move_point` = 1;
UPDATE `walker_routes` SET `chatText` = '哎呀！要稍微休息一下~' WHERE `route_id` = '8' AND `move_point` = 5;
UPDATE `walker_routes` SET `chatText` = '你好！雷克特！傑克森也好久不見！' WHERE `route_id` = '8' AND `move_point` = 9;
UPDATE `walker_routes` SET `chatText` = '啦啦啦啦~' WHERE `route_id` = '8' AND `move_point` = 14;
UPDATE `walker_routes` SET `chatText` = '啦啦啦啦~' WHERE `route_id` = '8' AND `move_point` = 15;
UPDATE `walker_routes` SET `chatText` = '啦啦啦啦~' WHERE `route_id` = '8' AND `move_point` = 16;

/***** Done by vdmyagami！ *****/