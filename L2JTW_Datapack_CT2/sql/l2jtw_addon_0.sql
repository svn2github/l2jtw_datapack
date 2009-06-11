/************ Made in Taiwan ************/

/***** 防具-錯誤資料修正 *****/
/***** ↓NC修正後可移除資料↓ *****/
-- NC設定`crystallizable` = 'true'錯誤，修正 = 'false' --
UPDATE `armor` SET `crystallizable` = 'false'   WHERE `item_id` IN (9826); -- 幻象武器-盟誓禮鞋 輕裝用
/***** ↑NC修正後可移除資料↑ *****/

/***** 武器-錯誤資料修正 *****/
/***** ↓NC修正後可移除資料↓ *****/
-- NC設定`critical` = '8'錯誤?，修正 = '6' --
UPDATE `weapon` SET `critical` = '6' WHERE `weaponType` = '13'; -- 古代劍(致命追加)

-- NC設定`atk_speed` = '379'，修正 = '325' --
UPDATE `weapon` SET `atk_speed` = '325' WHERE `item_id` IN (10252,10527,10528,10529); -- 王朝魔杖(攻擊速度)
UPDATE `weapon` SET `atk_speed` = '325' WHERE `item_id` IN (10530,10531,10532); -- 王朝毀滅者(攻擊速度)

/*** 闇天使專用武器：細劍 ***/
/*** 強化4以上的話，致命攻擊時將會以一定的機率提升自己和隊伍成員們的物理攻擊力、魔法攻擊力和所受的治癒量，並發揮使用技能時降低MP消耗量的效果。 ***/
UPDATE `weapon` SET `enchant4_skill_id` = '3426', `enchant4_skill_lvl` = '1' WHERE `weaponType` = 'rapier'; --  所有細劍
/*** 不用強化4以上，直接賦予 ***/
UPDATE `weapon` SET `enchant4_skill_id` = '0', `enchant4_skill_lvl` = '0', `skill` = '3427-1;3426-1;' WHERE `item_id` = '9388'; --  無限瞬閃

/***** Done by vdmyagami！ *****/