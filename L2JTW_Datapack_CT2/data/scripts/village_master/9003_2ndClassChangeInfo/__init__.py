# Made in Taiwan

import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "9003_2ndClassChangeInfo"

NPCS = [30109,30900,30849,31276,31965,31321,30187,30689,30120,30905,30857,31279,31968,31328,30191,30115,30854,31755,31996,30694,30474,30910,30862,31285,31974,30195,30699,30513,30913,30865,31288,31977,30681,30704,30511,30894,30845,31269,31958,31314,30676,30685,30512,30897,30847,31272,31961,31317,30677,30687,32213,32209,32221,32225,32233,32229,32205,32217,32214,32210,32222,32226,32234,32230,32206,32218,31331,31334,30175,31324,31326,31336,30176,30174,32145,32146]

# 轉職情報 - 城鎮
THF = [30109,30900,30849,31276,31965,31321,30187,30689] # 戰士公會
THH = [30120,30905,30857,31279,31968,31328,30191] # 殷海薩
THW = [30115,30854,31755,31996,30694] # 魔法師公會
TDK = [30474,30910,30862,31285,31974,30195,30699] # 黑暗精靈公會
TOC = [30513,30913,30865,31288,31977,30681,30704] # 半獸人公會
TFW = [30511,30894,30845,31269,31958,31314,30676,30685] # 矮人倉庫
TFB = [30512,30897,30847,31272,31961,31317,30677,30687] # 矮人鐵舖
TKF = [32213,32209,32221,32225,32233,32229,32205,32217,32146] # 闇天使戰士 - 男
TKM = [32214,32210,32222,32226,32234,32230,32206,32218,32145] # 闇天使戰士 - 女

# 其他宗師
RHW = 31331 # 人類/精靈 (魯因)
RDK = 31324 # 黑暗精靈戰士 (魯因)
ROF = 31326 # 半獸人戰士 (魯因)
ROM = 31336 # 半獸人法師 (魯因)
RDW = [31334,30175] # 黑暗精靈巫師 (魯因) / (象牙塔)
IHW = 30176 # 人類巫師 (象牙塔)
IEW = 30174 # 精靈巫師 (象牙塔)

# 轉職道具
MARK_OF_CHALLENGER       = 2627 # 挑戰者標章
MARK_OF_DUTY             = 2633 # 使命標章
MARK_OF_SEEKER           = 2673 # 巡守者標章
MARK_OF_SCHOLAR          = 2674 # 探求者標章
MARK_OF_PILGRIM          = 2721 # 求道者標章
MARK_OF_TRUST            = 2734 # 信賴標章
MARK_OF_DUELIST          = 2762 # 決鬥者標章
MARK_OF_SEARCHER         = 2809 # 探索者標章
MARK_OF_HEALER           = 2820 # 治癒者標章
MARK_OF_REFORMER         = 2821 # 變革者標章
MARK_OF_MAGUS            = 2840 # 巫師標章
MARK_OF_MAESTRO          = 2867 # 巨匠標章
MARK_OF_WARSPIRIT        = 2879 # 戰爭靈標章
MARK_OF_GUILDSMAN        = 3119 # 公會會員標章
MARK_OF_LIFE             = 3140 # 生命標章
MARK_OF_FATE             = 3172 # 命運標章
MARK_OF_GLORY            = 3203 # 榮譽標章
MARK_OF_PROSPERITY       = 3238 # 繁榮標章
MARK_OF_CHAMPION         = 3276 # 優勝標章
MARK_OF_SAGITTARIUS      = 3293 # 人馬標章
MARK_OF_WITCHCRAFT       = 3307 # 黑魔法標章
MARK_OF_SUMMONER         = 3336 # 元素使標章
MARK_OF_LORD             = 3390 # 君主標章
ORKURUS_RECOMMENDATION   = 9760 # 奧克魯斯的推薦函
KAMAEL_INQUISITOR_MARK   = 9782 # 闇天使秘密團體審問者的徽章
SOUL_BREAKER_CERTIFICATE = 9806 # 碎魂者認證書
NULL                     = 0

# 獎勵道具 - 幻象武器交換券
SHADOW_WEAPON_COUPON_CGRADE = 8870

# event:[newclass,[html],item1,item2,item3]
EVENTS={
"class_change_2":[2,["HFHWA-e1.htm","HFHWA-e2.htm","HFHWA-e3.htm","HFHWA-e4.htm","HF-2nd.htm"],MARK_OF_CHALLENGER, MARK_OF_TRUST, MARK_OF_DUELIST],
"class_change_3":[3,["HFHWB-e1.htm","HFHWB-e2.htm","HFHWB-e3.htm","HFHWB-e4.htm","HF-2nd.htm"],MARK_OF_CHALLENGER, MARK_OF_TRUST, MARK_OF_CHAMPION],
"class_change_5":[5,["HFHPA-e1.htm","HFHPA-e2.htm","HFHPA-e3.htm","HFHPA-e4.htm","HF-2nd.htm"],MARK_OF_DUTY, MARK_OF_TRUST, MARK_OF_HEALER],
"class_change_6":[6,["HFHPB-e1.htm","HFHPB-e2.htm","HFHPB-e3.htm","HFHPB-e4.htm","HF-2nd.htm"],MARK_OF_DUTY, MARK_OF_TRUST, MARK_OF_WITCHCRAFT],
"class_change_8":[8,["HFHRA-e1.htm","HFHRA-e2.htm","HFHRA-e3.htm","HFHRA-e4.htm","HF-2nd.htm"],MARK_OF_SEEKER, MARK_OF_TRUST, MARK_OF_SEARCHER],
"class_change_9":[9,["HFHRB-e1.htm","HFHRB-e2.htm","HFHRB-e3.htm","HFHRB-e4.htm","HF-2nd.htm"],MARK_OF_SEEKER, MARK_OF_TRUST, MARK_OF_SAGITTARIUS],
"class_change_20":[20,["HFEPA-e1.htm","HFEPA-e2.htm","HFEPA-e3.htm","HFEPA-e4.htm","HF-2nd.htm"],MARK_OF_DUTY, MARK_OF_LIFE, MARK_OF_HEALER],
"class_change_21":[21,["HFEPB-e1.htm","HFEPB-e2.htm","HFEPB-e3.htm","HFEPB-e4.htm","HF-2nd.htm"],MARK_OF_CHALLENGER, MARK_OF_LIFE, MARK_OF_DUELIST],
"class_change_23":[23,["HFESA-e1.htm","HFESA-e2.htm","HFESA-e3.htm","HFESA-e4.htm","HF-2nd.htm"],MARK_OF_SEEKER, MARK_OF_LIFE, MARK_OF_SEARCHER],
"class_change_24":[24,["HFESB-e1.htm","HFESB-e2.htm","HFESB-e3.htm","HFESB-e4.htm","HF-2nd.htm"],MARK_OF_SEEKER, MARK_OF_LIFE, MARK_OF_SAGITTARIUS],
"class_change_12":[12,["HWHWA-e1.htm","HWHWA-e2.htm","HWHWA-e3.htm","HWHWA-e4.htm","HW-2nd.htm"],MARK_OF_SCHOLAR, MARK_OF_TRUST, MARK_OF_MAGUS],
"class_change_13":[13,["HWHWB-e1.htm","HWHWB-e2.htm","HWHWB-e3.htm","HWHWB-e4.htm","HW-2nd.htm"],MARK_OF_SCHOLAR, MARK_OF_TRUST, MARK_OF_WITCHCRAFT],
"class_change_14":[14,["HWHWC-e1.htm","HWHWC-e2.htm","HWHWC-e3.htm","HWHWC-e4.htm","HW-2nd.htm"],MARK_OF_SCHOLAR, MARK_OF_TRUST, MARK_OF_SUMMONER],
"class_change_27":[27,["HWEWA-e1.htm","HWEWA-e2.htm","HWEWA-e3.htm","HWEWA-e4.htm","HW-2nd.htm"],MARK_OF_SCHOLAR, MARK_OF_LIFE, MARK_OF_MAGUS],
"class_change_28":[28,["HWEWB-e1.htm","HWEWB-e2.htm","HWEWB-e3.htm","HWEWB-e4.htm","HW-2nd.htm"],MARK_OF_SCHOLAR, MARK_OF_LIFE, MARK_OF_SUMMONER],
"class_change_40":[40,["HWDWA-e1.htm","HWDWA-e2.htm","HWDWA-e3.htm","HWDWA-e4.htm","HW-2nd.htm"],MARK_OF_SCHOLAR, MARK_OF_FATE, MARK_OF_MAGUS],
"class_change_41":[41,["HWDWB-e1.htm","HWDWB-e2.htm","HWDWB-e3.htm","HWDWB-e4.htm","HW-2nd.htm"],MARK_OF_SCHOLAR, MARK_OF_FATE, MARK_OF_SUMMONER],
"class_change_16":[16,["HHHMA-e1.htm","HHHMA-e2.htm","HHHMA-e3.htm","HHHMA-e4.htm","HH-2nd.htm"],MARK_OF_PILGRIM, MARK_OF_TRUST, MARK_OF_HEALER],
"class_change_17":[17,["HHHMB-e1.htm","HHHMB-e2.htm","HHHMB-e3.htm","HHHMB-e4.htm","HH-2nd.htm"],MARK_OF_PILGRIM, MARK_OF_TRUST, MARK_OF_REFORMER],
"class_change_30":[30,["HHEM-e1.htm","HHEM-e2.htm","HHEM-e3.htm","HHEM-e4.htm","HH-2nd.htm"],MARK_OF_PILGRIM, MARK_OF_LIFE, MARK_OF_HEALER],
"class_change_33":[33,["DKDPA-e1.htm","DKDPA-e2.htm","DKDPA-e3.htm","DKDPA-e4.htm","DK-2nd.htm"],MARK_OF_DUTY, MARK_OF_FATE, MARK_OF_WITCHCRAFT],
"class_change_34":[34,["DKDPB-e1.htm","DKDPB-e2.htm","DKDPB-e3.htm","DKDPB-e4.htm","DK-2nd.htm"],MARK_OF_CHALLENGER, MARK_OF_FATE, MARK_OF_DUELIST],
"class_change_36":[36,["DKDSA-e1.htm","DKDSA-e2.htm","DKDSA-e3.htm","DKDSA-e4.htm","DK-2nd.htm"],MARK_OF_SEEKER, MARK_OF_FATE, MARK_OF_SEARCHER],
"class_change_37":[37,["DKDSB-e1.htm","DKDSB-e2.htm","DKDSB-e3.htm","DKDSB-e4.htm","DK-2nd.htm"],MARK_OF_SEEKER, MARK_OF_FATE, MARK_OF_SAGITTARIUS],
"class_change_43":[43,["DKDM-e1.htm","DKDM-e2.htm","DKDM-e3.htm","DKDM-e4.htm","DK-2nd.htm"],MARK_OF_PILGRIM, MARK_OF_FATE, MARK_OF_REFORMER],
"class_change_46":[46,["OCOR-e1.htm","OCOR-e2.htm","OCOR-e3.htm","OCOR-e4.htm","ORC-2nd.htm"],MARK_OF_CHALLENGER, MARK_OF_GLORY, MARK_OF_CHAMPION],
"class_change_48":[48,["OCOF-e1.htm","OCOF-e2.htm","OCOF-e3.htm","OCOF-e4.htm","ORC-2nd.htm"],MARK_OF_CHALLENGER, MARK_OF_GLORY, MARK_OF_DUELIST],
"class_change_51":[51,["OCOMA-e1.htm","OCOMA-e2.htm","OCOMA-e3.htm","OCOMA-e4.htm","ORC-2nd.htm"],MARK_OF_PILGRIM, MARK_OF_GLORY, MARK_OF_LORD],
"class_change_52":[52,["OCOMB-e1.htm","OCOMB-e2.htm","OCOMB-e3.htm","OCOMB-e4.htm","ORC-2nd.htm"],MARK_OF_PILGRIM, MARK_OF_GLORY, MARK_OF_WARSPIRIT],
"class_change_55":[55,["DFW-e1.htm","DFW-e2.htm","DFW-e3.htm","DFW-e4.htm","DFW-2nd.htm"],MARK_OF_SEARCHER, MARK_OF_GUILDSMAN, MARK_OF_PROSPERITY],
"class_change_57":[57,["DFB-e1.htm","DFB-e2.htm","DFB-e3.htm","DFB-e4.htm","DFB-2nd.htm"],MARK_OF_MAESTRO, MARK_OF_GUILDSMAN, MARK_OF_PROSPERITY],
"class_change_127":[127,["KFKTA-e1.htm","KFKTA-e2.htm","KFKTA-e3.htm","KFKTA-e4.htm","KAM-2nd.htm"],ORKURUS_RECOMMENDATION, NULL, NULL],
"class_change_128":[128,["KFKTB-e1.htm","KFKTB-e2.htm","KFKTB-e3.htm","KFKTB-e4.htm","KAM-2nd.htm"],SOUL_BREAKER_CERTIFICATE, NULL, NULL],
"class_change_130":[130,["KMKWA-e1.htm","KMKWA-e2.htm","KMKWA-e3.htm","KMKWA-e4.htm","KAM-2nd.htm"],KAMAEL_INQUISITOR_MARK, NULL, NULL],
"class_change_129":[129,["KMKWB-e1.htm","KMKWB-e2.htm","KMKWB-e3.htm","KMKWB-e4.htm","KAM-2nd.htm"],SOUL_BREAKER_CERTIFICATE, NULL, NULL]
}

class Quest (JQuest) :
   def __init__(self,id,name,descr):
       JQuest.__init__(self,id,name,descr)

   def onEvent (self,event,st) :
      htmltext = event
      if event in ["class_change_2","class_change_3","class_change_5","class_change_6","class_change_8","class_change_9","class_change_12","class_change_13","class_change_14","class_change_16","class_change_17","class_change_20","class_change_21","class_change_23","class_change_24","class_change_27","class_change_28","class_change_30","class_change_33","class_change_34","class_change_36","class_change_37","class_change_40","class_change_41","class_change_43","class_change_46","class_change_48","class_change_51","class_change_52","class_change_55","class_change_57"] :
         newclass,html,item1,item2,item3 = EVENTS[event]
         htmltext = html
         if st.player.getClassId().getId() in [2,3,5,6,8,9,88,89,90,91,92,93,20,21,23,24,99,100,101,102,12,13,14,16,17,94,95,96,97,98,27,28,30,103,104,105,33,34,36,37,106,107,108,109,40,41,43,110,111,112,46,48,113,114,51,52,115,116,55,57,117,118] :
               htmltext = html[4]
               st.exitQuest(1)
         else :
            if st.player.getLevel() > 39:
               if st.getQuestItemsCount(item1) and st.getQuestItemsCount(item2) and st.getQuestItemsCount(item3) :
                  st.takeItems(item1,-1)
                  st.takeItems(item2,-1)
                  st.takeItems(item3,-1)
                  st.giveItems(SHADOW_WEAPON_COUPON_CGRADE,15)
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
               if st.getQuestItemsCount(item1) and st.getQuestItemsCount(item2) and st.getQuestItemsCount(item3) :
                  htmltext = html[1]
                  st.exitQuest(1)
               else :
                  htmltext = html[0]
                  st.exitQuest(1)
      elif event in ["class_change_127","class_change_128","class_change_129","class_change_130"] :
         newclass,html,item1,item2,item3 = EVENTS[event]
         htmltext = html
         if st.player.getClassId().getId() in [127,128,131,132,129,130,135,133,134,136] :
               htmltext = html[4]
               st.exitQuest(1)
         else :
            if st.player.getLevel() > 39:
               if st.getQuestItemsCount(item1) :
                  st.takeItems(item1,-1)
                  st.giveItems(SHADOW_WEAPON_COUPON_CGRADE,15)
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
               if st.getQuestItemsCount(item1) :
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
      if npcId in THF : # 戰士公會
         if raceId in [0,1] :
            if classId in [1,2,3,88,89] :
               htmltext = "HFHW-01.htm"
            elif classId in [4,5,6,90,91] :
               htmltext = "HFHP-01.htm"
            elif classId in [7,8,9,92,93] :
               htmltext = "HFHR-01.htm"
            elif classId in [19,20,21,99,100] :
               htmltext = "HFEP-01.htm"
            elif classId in [22,23,24,101,102] :
               htmltext = "HFES-01.htm"
            elif classId in [0,18] :
               htmltext = "HF-1st.htm"
               st.exitQuest(1)
            else :
               htmltext = "HF-00.htm"
               st.exitQuest(1)
         else :
            htmltext = "HF-00.htm"
            st.exitQuest(1)
############################################################################
      elif npcId in THH : # 殷海薩
         if raceId in [0,1] :
            if classId in [15,16,17,97,98] :
               htmltext = "HHHM-01.htm"
            elif classId in [29,30,105] :
               htmltext = "HHEM-01.htm"
            elif classId in [10,25] :
               htmltext = "HH-1st.htm"
               st.exitQuest(1)
            else :
               htmltext = "HH-00.htm"
               st.exitQuest(1)
         else :
            htmltext = "HH-00.htm"
            st.exitQuest(1)
############################################################################
      elif npcId in THW : # 魔法師公會
         if raceId in [0,1,2] :
            if classId in [11,12,13,14,94,95,96] :
               htmltext = "HWHW-01.htm"
            elif classId in [26,27,28,103,104] :
               htmltext = "HWEW-01.htm"
            elif classId in [39,40,41,110,111] :
               htmltext = "HWDW-01.htm"
            elif classId in [10,25,38] :
               htmltext = "HH-1st.htm"
               st.exitQuest(1)
            else :
               htmltext = "HW-00.htm"
               st.exitQuest(1)
         else :
            htmltext = "HW-00.htm"
            st.exitQuest(1)
############################################################################
      elif npcId in TDK : # 黑暗精靈公會
         if raceId == 2 :
            if classId in [32,33,34,106,107] :
               htmltext = "DKDP-01.htm"
            elif classId in [35,36,37,108,109] :
               htmltext = "DKDS-01.htm"
            elif classId in [42,43,112] :
               htmltext = "DKDM-01.htm"
            elif classId in [31,38] :
               htmltext = "DK-1st.htm"
               st.exitQuest(1)
         else :
            htmltext = "DK-00.htm"
            st.exitQuest(1)
############################################################################
      elif npcId in TOC : # 半獸人公會
         if raceId == 3 :
            if classId in [45,46,113] :
               htmltext = "OCOR-01.htm"
            elif classId in [47,48,114] :
               htmltext = "OCOF-01.htm"
            elif classId in [50,51,52,115,116] :
               htmltext = "OCOM-01.htm"
            elif classId in [44,49] :
               htmltext = "ORC-1st.htm"
               st.exitQuest(1)
         else :
            htmltext = "ORC-00.htm"
            st.exitQuest(1)
############################################################################
      elif npcId in TFW : # 倉庫
         if raceId == 4 :
            if classId in [54,55,117] :
               htmltext = "DFW-01.htm"
            elif classId == 53 :
               htmltext = "DFW-1st.htm"
               st.exitQuest(1)
            else :
               htmltext = "DFW-00.htm"
               st.exitQuest(1)
         else :
            htmltext = "DFW-00.htm"
            st.exitQuest(1)
############################################################################
      elif npcId in TFB : # 鐵舖
         if raceId == 4 :
            if classId in [56,57,118] :
               htmltext = "DFB-01.htm"
            elif classId == 53 :
               htmltext = "DFB-1st.htm"
               st.exitQuest(1)
            else :
               htmltext = "DFB-00.htm"
               st.exitQuest(1)
         else :
            htmltext = "DFW-00.htm"
            st.exitQuest(1)
############################################################################
      elif npcId in TKF : # 闇天使公會 - 男
         if raceId == 5 :
            if classId in [125,127,128,131,132] :
               htmltext = "KFKT-01.htm"
            elif classId == 123 :
               htmltext = "KF-1st.htm"
               st.exitQuest(1)
            else :
               htmltext = "KF-00.htm"
               st.exitQuest(1)
         else :
            htmltext = "KAM-00.htm"
            st.exitQuest(1)
############################################################################
      elif npcId in TKM : # 闇天使公會 - 女
         if raceId == 5 :
            if classId in [126,129,130,133,134] :
               htmltext = "KMKW-01.htm"
            elif classId == 124 :
               htmltext = "KM-1st.htm"
               st.exitQuest(1)
            else :
               htmltext = "KM-00.htm"
               st.exitQuest(1)
         else :
            htmltext = "KAM-00.htm"
            st.exitQuest(1)
############################################################################
      elif npcId == RHW : # 人類/精靈魔法師 (魯因)
         if raceId in [0,1] :
            if classId in [11,12,13,14,94,95,96] :
               htmltext = "HWHW-01.htm"
            elif classId in [26,27,28,103,104] :
               htmltext = "HWEW-01.htm"
            elif classId in [10,25] :
               htmltext = "HH-1st.htm"
               st.exitQuest(1)
            else :
               htmltext = str(npcId)+"-00.htm"
               st.exitQuest(1)
         else :
            htmltext = str(npcId)+"-00.htm"
            st.exitQuest(1)
############################################################################
      elif npcId in RDW : # 黑暗精靈魔法師 (魯因/象牙塔)
         if raceId == 2 :
            if classId in [39,40,41,110,111] :
               htmltext = "HWDW-01.htm"
            elif classId == 38 :
               htmltext = "HH-1st.htm"
               st.exitQuest(1)
            else :
               htmltext = str(npcId)+"-00.htm"
               st.exitQuest(1)
         else :
            htmltext = str(npcId)+"-00.htm"
            st.exitQuest(1)
############################################################################
      elif npcId == IHW : # 人類魔法師 (象牙塔)
         if raceId == 0 :
            if classId in [11,12,13,14,94,95,96] :
               htmltext = "HWHW-01.htm"
            elif classId == 10 :
               htmltext = "HH-1st.htm"
               st.exitQuest(1)
            else :
               htmltext = str(npcId)+"-00.htm"
               st.exitQuest(1)
         else :
            htmltext = str(npcId)+"-00.htm"
            st.exitQuest(1)
############################################################################
      elif npcId == IEW : # 精靈魔法師 (象牙塔)
         if raceId == 1 :
            if classId in [26,27,28,103,104] :
               htmltext = "HWEW-01.htm"
            elif classId == 25 :
               htmltext = "HH-1st.htm"
               st.exitQuest(1)
            else :
               htmltext = str(npcId)+"-00.htm"
               st.exitQuest(1)
         else :
            htmltext = str(npcId)+"-00.htm"
            st.exitQuest(1)
############################################################################
      elif npcId == RDK : # 黑暗精靈戰士 (魯因)
         if raceId == 2 :
            if classId in [32,33,34,106,107] :
               htmltext = "DKDP-01.htm"
            elif classId in [35,36,37,108,109] :
               htmltext = "DKDS-01.htm"
            elif classId == 31 :
               htmltext = "DK-1st.htm"
               st.exitQuest(1)
            else :
               htmltext = str(npcId)+"-00.htm"
               st.exitQuest(1)
         else :
            htmltext = str(npcId)+"-00.htm"
            st.exitQuest(1)
############################################################################
      elif npcId == ROF : # 半獸人戰士 (魯因)
         if raceId == 3 :
            if classId in [45,46,113] :
               htmltext = "OCOR-01.htm"
            elif classId in [47,48,114] :
               htmltext = "OCOF-01.htm"
            elif classId == 44 :
               htmltext = "ORC-1st.htm"
               st.exitQuest(1)
            else :
               htmltext = str(npcId)+"-00.htm"
               st.exitQuest(1)
         else :
            htmltext = str(npcId)+"-00.htm"
            st.exitQuest(1)
############################################################################
      elif npcId == ROM : # 半獸人巫醫 (魯因)
         if raceId == 3 :
            if classId in [50,51,52,115,116] :
               htmltext = "OCOM-01.htm"
            elif classId == 49 :
               htmltext = "ORC-1st.htm"
               st.exitQuest(1)
            else :
               htmltext = str(npcId)+"-00.htm"
               st.exitQuest(1)
         else :
            htmltext = str(npcId)+"-00.htm"
            st.exitQuest(1)
############################################################################
      return htmltext

QUEST      = Quest(9003,qn,"village_master")

for i in NPCS:
  QUEST.addStartNpc(i)
  QUEST.addTalkId(i)
