# Made in Taiwan

import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "9002_1stClassChangeInfo"

NPCS = [30026,30031,30154,30358,30520,30525,30565,32139,32140,32147,32150,32153,\
32154,32157,32158,32160,30373,30288,30066,32094,30037,30289,30070,32095,32098,30290,\
30297,30462,32096,30500,30505,30508,32097,30498,30503,30594,32092,30499,30504,30595,\
32093,32196,32199,32193,32202,32171,32191]

# 轉職情報 - 村莊
VHF = [30026,32154] # 村莊 - 人類戰士
VHH = [30031,32153] # 村莊 - 人類法師
VEL = [30154,32147] # 村莊 - 精靈
VDK = [30358,32160] # 村莊 - 黑暗精靈
VOC = [30565,32150] # 村莊 - 半獸人
VDF = [30520,30525,32157,32158,32171] # 村莊 - 矮人戰士
VKM = [32139,32140] # 村莊 - 闇天使

# 轉職情報 - 城鎮
THF = [30373,30288,30066,32094] # 戰士公會 (人類戰士/精靈戰士)
THH = [30037,30289,30070,32095,32098] # 殷海薩 (人類法師/精靈法師)
TDK = [30290,30297,30462,32096] # 黑暗精靈公會 (黑暗精靈戰士/法師)
TOC = [30500,30505,30508,32097] # 半獸人公會 (半獸人戰士/法師)
TFW = [30498,30503,30594,32092] # 矮人倉庫 (矮人戰士)
TFB = [30499,30504,30595,32093] # 矮人鐵舖 (矮人戰士)
TKF = [32196,32199] # 闇天使戰士 - 男
TKM = [32193,32202,32191] # 闇天使戰士 - 女

# 轉職道具
MEDALLION_OF_WARRIOR    = 1145 # 鬥士的勳章
SWORD_OF_RITUAL         = 1161 # 儀式劍
BEZIQUES_RECOMMENDATION = 1190 # 貝茲庫的推薦函
ELVEN_KNIGHT_BROOCH     = 1204 # 精靈騎士胸針
REORIA_RECOMMENDATION   = 1217 # 雷奧利亞的推薦函
MARK_OF_FAITH           = 1201 # 信仰憑證
ETERNITY_DIAMOND        = 1230 # 不朽鑽石
LEAF_OF_ORACLE          = 1235 # 神諭之葉
BEAD_OF_SEASON          = 1292 # 季節之珠
GAZE_OF_ABYSS           = 1244 # 深淵凝視
IRON_HEART              = 1252 # 鋼鐵之心
JEWEL_OF_DARKNESS       = 1261 # 黑暗寶石
ORB_OF_ABYSS            = 1270 # 深淵之珠
MARK_OF_RAIDER          = 1592 # 突襲者標章
KHAVATARI_TOTEM         = 1615 # 卡巴塔里之圖騰
MASK_OF_MEDIUM          = 1631 # 施咒者的面具
SCAV_MARKS              = 1642 # 掠奪者之戒
ARTI_MARKS              = 1635 # 最終合格證書
GWAINS_RECOMMENTADION   = 9753 # 特巴音的推薦函
STEELRAZOR_EVALUATION   = 9772 # 特殊部隊竊取檔案的評價報告書

# 獎勵道具 - 幻象武器交換券
SHADOW_WEAPON_COUPON_DGRADE = 8869

# event:[newclass,[html],item]
EVENTS={
"class_change_1":[1,["HF-hae1.htm","HF-hae2.htm","HF-hae3.htm","HF-hae4.htm","HF-1st.htm","HF-2nd.htm"],MEDALLION_OF_WARRIOR],
"class_change_4":[4,["HF-hbe1.htm","HF-hbe2.htm","HF-hbe3.htm","HF-hbe4.htm","HF-1st.htm","HF-2nd.htm"],SWORD_OF_RITUAL],
"class_change_7":[7,["HF-hce1.htm","HF-hce2.htm","HF-hce3.htm","HF-hce4.htm","HF-1st.htm","HF-2nd.htm"],BEZIQUES_RECOMMENDATION],
"class_change_19":[19,["HF-eae1.htm","HF-eae2.htm","HF-eae3.htm","HF-eae4.htm","HF-1st.htm","HF-2nd.htm"],ELVEN_KNIGHT_BROOCH],
"class_change_22":[22,["HF-ebe1.htm","HF-ebe2.htm","HF-ebe3.htm","HF-ebe4.htm","HF-1st.htm","HF-2nd.htm"],REORIA_RECOMMENDATION],
"class_change_11":[11,["HH-hae1.htm","HH-hae2.htm","HH-hae3.htm","HH-hae4.htm","HH-1st.htm","HH-2nd.htm"],BEAD_OF_SEASON],
"class_change_15":[15,["HH-hbe1.htm","HH-hbe2.htm","HH-hbe3.htm","HH-hbe4.htm","HH-1st.htm","HH-2nd.htm"],MARK_OF_FAITH],
"class_change_26":[26,["HH-eae1.htm","HH-eae2.htm","HH-eae3.htm","HH-eae4.htm","HH-1st.htm","HH-2nd.htm"],ETERNITY_DIAMOND],
"class_change_29":[29,["HH-ebe1.htm","HH-ebe2.htm","HH-ebe3.htm","HH-ebe4.htm","HH-1st.htm","HH-2nd.htm"],LEAF_OF_ORACLE],
"class_change_32":[32,["DK-fae1.htm","DK-fae2.htm","DK-fae3.htm","DK-fae4.htm","DK-1st.htm","DK-2nd.htm"],GAZE_OF_ABYSS],
"class_change_35":[35,["DK-fbe1.htm","DK-fbe2.htm","DK-fbe3.htm","DK-fbe4.htm","DK-1st.htm","DK-2nd.htm"],IRON_HEART],
"class_change_39":[39,["DK-mae1.htm","DK-mae2.htm","DK-mae3.htm","DK-mae4.htm","DK-1st.htm","DK-2nd.htm"],JEWEL_OF_DARKNESS],
"class_change_42":[42,["DK-mbe1.htm","DK-mbe2.htm","DK-mbe3.htm","DK-mbe4.htm","DK-1st.htm","DK-2nd.htm"],ORB_OF_ABYSS],
"class_change_45":[45,["ORC-fae1.htm","ORC-fae2.htm","ORC-fae3.htm","ORC-fae4.htm","ORC-1st.htm","ORC-2nd.htm"],MARK_OF_RAIDER],
"class_change_47":[47,["ORC-fbe1.htm","ORC-fbe2.htm","ORC-fbe3.htm","ORC-fbe4.htm","ORC-1st.htm","ORC-2nd.htm"],KHAVATARI_TOTEM],
"class_change_50":[50,["ORC-me1.htm","ORC-me2.htm","ORC-me3.htm","ORC-me4.htm","ORC-1st.htm","ORC-2nd.htm"],MASK_OF_MEDIUM],
"class_change_54":[54,["DFW-e1.htm","DFW-e2.htm","DFW-e3.htm","DFW-e4.htm","DFW-1st.htm","DFW-2nd.htm"],SCAV_MARKS],
"class_change_56":[56,["DFB-e1.htm","DFB-e2.htm","DFB-e3.htm","DFB-e4.htm","DFB-1st.htm","DFB-2nd.htm"],ARTI_MARKS],
"class_change_125":[125,["KF-e1.htm","KF-e1.htm","KF-e1.htm","KF-e2.htm","KF-1st.htm","KF-1st.htm"],GWAINS_RECOMMENTADION],
"class_change_126":[126,["KM-e1.htm","KM-e1.htm","KM-e1.htm","KM-e2.htm","KF-1st.htm","KF-1st.htm"],STEELRAZOR_EVALUATION]
}

class Quest (JQuest) :
   def __init__(self,id,name,descr):
       JQuest.__init__(self,id,name,descr)

   def onEvent (self,event,st) :
      htmltext = event
      if event in ["class_change_1","class_change_4","class_change_7","class_change_19","class_change_22","class_change_11","class_change_15","class_change_26","class_change_29","class_change_32","class_change_35","class_change_39","class_change_42","class_change_45","class_change_47","class_change_50","class_change_54","class_change_56","class_change_125","class_change_126"] :
         newclass,html,item = EVENTS[event]
         htmltext = html
         if st.player.getClassId().getId() in [1,4,7,19,22,11,15,26,29,32,35,39,42,45,47,50,54,56,125,126] :
               htmltext = html[4]
               st.exitQuest(1)
         elif st.player.getClassId().getId() in [2,3,5,6,8,9,88,89,90,91,92,93,20,21,23,24,99,100,101,102,12,13,14,16,17,94,95,96,97,98,27,28,30,103,104,105,33,34,36,37,106,107,108,109,40,41,43,110,111,112,46,48,113,114,51,52,115,116,55,57,117,118,127,128,131,132,129,130,135,133,134,136] :
               htmltext = html[5]
               st.exitQuest(1)
         else :
            if st.player.getLevel() > 19:
               if st.getQuestItemsCount(item) :
                  st.takeItems(item,1)
                  st.giveItems(SHADOW_WEAPON_COUPON_DGRADE,15)
                  st.playSound("ItemSound.quest_fanfare_2")
                  st.player.setClassId(newclass)
                  st.player.setBaseClass(newclass)
                  st.player.broadcastUserInfo()
                  htmltext = html[3]
                  st.exitQuest(1)
               else :
                  htmltext = html[2]
                  st.exitQuest(1)
            else :
               if st.getQuestItemsCount(item) :
                  htmltext = html[1]
                  st.exitQuest(1)
               else :
                  htmltext = html[0]
                  st.exitQuest(1)
      return htmltext

   def onTalk (self,npc,player) :
      htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
      st = player.getQuestState(qn)
      npcId = npc.getNpcId()
      classId = player.getClassId().getId()
      raceId = player.getRace().ordinal()
############################################################################
      if npcId in VHF : # 村莊 - 人類戰士
         if raceId == 0 :
            if classId in [0,1,4,7,2,3,5,6,8,9,88,89,90,91,92,93] :
               htmltext = str(npcId)+"-01f.htm"
            else :
               htmltext = str(npcId)+"-00.htm"
         else :
            htmltext = str(npcId)+"-00.htm"
############################################################################
      elif npcId in VHH : # 村莊 - 人類法師
         if raceId == 0 :
            if classId in [10,11,15,12,13,14,16,17,94,95,96,97,98] :
               htmltext = str(npcId)+"-01m.htm"
            else :
               htmltext = str(npcId)+"-00.htm"
         else :
            htmltext = str(npcId)+"-00.htm"
############################################################################
      elif npcId in VEL : # 村莊 - 精靈
         if raceId == 1 :
            if classId in [18,19,22,20,21,23,24,99,100,101,102] :
               htmltext = str(npcId)+"-01f.htm"
            elif classId in [25,26,29,27,28,30,103,104,105] :
               htmltext = str(npcId)+"-01m.htm"
         else :
            htmltext = str(npcId)+"-00.htm"
############################################################################
      elif npcId in VDK : # 村莊 - 黑暗精靈
         if raceId == 2 :
            if classId in [31,32,35,33,34,36,37,106,107,108,109] :
               htmltext = str(npcId)+"-01f.htm"
            elif classId in [38,39,42,40,41,43,110,111,112] :
               htmltext = str(npcId)+"-01m.htm"
         else :
            htmltext = str(npcId)+"-00.htm"
############################################################################
      elif npcId in VOC : # 村莊 - 半獸人
         if raceId == 3 :
            if classId in [44,45,47,46,48,113,114] :
               htmltext = str(npcId)+"-01f.htm"
            elif classId in [49,50,51,52,115,116] :
               htmltext = str(npcId)+"-01m.htm"
         else :
            htmltext = str(npcId)+"-00.htm"
############################################################################
      elif npcId in VDF : # 村莊 - 矮人
         if raceId == 4 :
            if classId in [53,54,56,55,57,117,118] :
               htmltext = str(npcId)+"-01.htm"
         else :
            htmltext = str(npcId)+"-00.htm"
############################################################################
      elif npcId in VKM : # 村莊 - 闇天使
         htmltext = str(npcId)+"-01.htm"
############################################################################
      elif npcId in THF : # 戰士公會 - 人類戰士/精靈戰士
         if raceId in [0,1] :
            if classId in [0,1,4,7,2,3,5,6,8,9,88,89,90,91,92,93] :
               htmltext = "HF-01h.htm"
            elif classId in [18,19,22,20,21,23,24,99,100,101,102] :
               htmltext = "HF-01e.htm"
            else :
               htmltext = "HF-00.htm"
         else :
            htmltext = "HF-00.htm"
############################################################################
      elif npcId in THH : # 殷海薩 - 人類法師/精靈法師
         if raceId in [0,1] :
            if classId in [10,11,15,12,13,14,16,17,94,95,96,97,98] :
               htmltext = "HH-01h.htm"
            elif classId in [25,26,29,27,28,30,103,104,105] :
               htmltext = "HH-01e.htm"
            else :
               htmltext = "HH-00.htm"
         else :
            htmltext = "HH-00.htm"
############################################################################
      elif npcId in TDK : # 黑暗精靈公會 - 黑暗精靈戰士/黑暗精靈法師
         if raceId == 2 :
            if classId in [31,32,35,33,34,36,37,106,107,108,109] :
               htmltext = "DK-01f.htm"
            elif classId in [38,39,42,40,41,43,110,111,112] :
               htmltext = "DK-01m.htm"
         else :
            htmltext = "DK-00.htm"
############################################################################
      elif npcId in TOC : # 半獸人公會 - 半獸人戰士/半獸人法師
         if raceId == 3 :
            if classId in [44,45,47,46,48,113,114] :
               htmltext = "ORC-01f.htm"
            elif classId in [49,50,51,52,115,116] :
               htmltext = "ORC-01m.htm"
         else :
            htmltext = "ORC-00.htm"
############################################################################
      elif npcId in TFW : # 倉庫 - 矮人戰士 
         if raceId == 4 :
            if classId in [53,54,56,55,57,117,118] :
               htmltext = "DFW-01.htm"
         else :
            htmltext = "DFW-00.htm"
############################################################################
      elif npcId in TFB : # 鐵舖 - 矮人戰士 
         if raceId == 4 :
            if classId in [53,54,56,55,57,117,118] :
               htmltext = "DFB-01.htm"
         else :
            htmltext = "DFB-00.htm"
############################################################################
      elif npcId in TKF : # 闇天使公會 - 闇天使戰士(男)
         if raceId == 5 :
            if classId in [123,125,127,128,131,132] :
               htmltext = "KF-01.htm"
            else :
               htmltext = "KFF-00.htm"
         else :
            htmltext = "KF-00.htm"
############################################################################
      elif npcId in TKM : # 闇天使公會 - 闇天使戰士(女)
         if raceId == 5 :
            if classId in [124,126,129,130,135,133,134,136] :
               htmltext = "KM-01.htm"
            else :
               htmltext = "KFM-00.htm"
         else :
            htmltext = "KF-00.htm"
############################################################################
      return htmltext

QUEST      = Quest(9002,qn,"village_master")

for i in NPCS:
  QUEST.addStartNpc(i)
  QUEST.addTalkId(i)
