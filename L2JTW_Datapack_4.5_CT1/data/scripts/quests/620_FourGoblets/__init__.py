# Made in Taiwan

import sys
from net.sf.l2j import Config
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
from net.sf.l2j.gameserver.instancemanager import FourSepulchersManager

# NPCS
NS      = 31453 # 無名的靈魂
WGA     = 31452 # 威格特的亡靈
WGB     = 31454 # 威格特的亡靈
CSM     = 31921 # 征服者陵墓管理員
ESM     = 31922 # 統治者陵墓管理員
GSM     = 31923 # 大賢者陵墓管理員
JSM     = 31924 # 審判者陵墓管理員
COEA    = 31919 # 艾爾摩亞丁侍衛隊長的亡靈
COEB    = 31920 # 艾爾摩亞丁侍衛的亡靈
HGKB    = [31925,31930,31935,31940] # 男爵禮拜堂守門人
HGKV    = [31926,31931,31936,31941] # 子爵禮拜堂守門人
HGKC    = [31927,31932,31937,31942] # 伯爵禮拜堂守門人
HGKM    = [31928,31933,31938,31943] # 侯爵禮拜堂守門人
HGKD    = [31929,31934,31939,31944] # 公爵禮拜堂守門人

# ITEMS
ALECTIA         = 7256 # 亞雷提雅的聖杯
TISHAS          = 7257 # 帝夏思的聖杯
MEKARA          = 7258 # 梅卡拉的聖杯
MORIGUL         = 7259 # 莫利格爾的聖杯
ENT_PASS        = 7075 # 陵墓通行證
USED_PASS       = 7261 # 使用過的陵墓通行證
BROOCH          = 7262 # 破舊的胸針
SEALED_BOX      = 7255 # 封印的箱子
RELIC_PART      = 7254 # 破碎的遺物碎片
HALLS_KEY       = 7260 # 禮拜堂的鑰匙

# MSG
HGKB_MSG = "<html><body>男爵禮拜堂守門人︰<br>沒有鑰匙。</body></html>"
HGKV_MSG = "<html><body>子爵禮拜堂守門人︰<br>沒有鑰匙。</body></html>"
HGKC_MSG = "<html><body>伯爵禮拜堂守門人︰<br>沒有鑰匙。</body></html>"
HGKM_MSG = "<html><body>侯爵禮拜堂守門人︰<br>沒有鑰匙。</body></html>"
HGKD_MSG = "<html><body>公爵禮拜堂守門人︰<br>沒有鑰匙。</body></html>"

MOBS = range(18120,18256)

# REWARDS
REWARDS = [81,151,959,1895,2500,4040,4042,4043,5529,5545,5546]

qn = "620_FourGoblets"

class Quest (JQuest) :

 def __init__(self,id,name,descr):
     JQuest.__init__(self,id,name,descr)
     self.questItemIds = [ALECTIA,TISHAS,MEKARA,MORIGUL]

 def onAdvEvent (self,event,npc,player) :
    st = player.getQuestState(qn)
    if not st : return htmltext
    npcId = npc.getNpcId()
    htmltext = event

    if htmltext == "START" : # 無名的靈魂 - 任務觸發
       st.set("four","1")
       st.set("cond","1")
       st.set("box","1")
       st.setState(State.STARTED)
       st.playSound("ItemSound.quest_accept")
       return "31453-12.htm"

    elif event == "FINISH" : # 無名的靈魂 - 任務完成
       st.set("four","2")
       st.takeItems(ALECTIA,-1)
       st.takeItems(TISHAS,-1)
       st.takeItems(MEKARA,-1)
       st.takeItems(MORIGUL,-1)
       st.giveItems(BROOCH,1)
       st.playSound("ItemSound.quest_finish")
       return "31453-18.htm"

    elif event == "ABORT" : # 無名的靈魂 - 任務放棄
       st.playSound("ItemSound.quest_finish")
       st.exitQuest(1)
       return "31453-14.htm"

    elif event == "CONTINUE" : # 無名的靈魂 - 任務繼續
       if st.getInt("cond")==1 and st.getInt("four")==2 :
          st.set("cond","2")
          st.playSound("ItemSound.quest_accept")
          return "31453-15.htm"
       else:
          return "31453-15.htm"

    elif event == "OUT" : # 威格特的亡靈 - 傳送至巡禮者寺院
       st.player.teleToLocation(169590,-90218,-2914)
       return str(npcId)+"-06.htm"

    elif event == "1" : # 威格特的亡靈 - 交換製作卷軸
       st.giveItems(6881,1)
       st.takeItems(RELIC_PART,1000)
       return str(npcId)+"-10.htm"
    elif event == "2" :
       st.giveItems(6883,1)
       st.takeItems(RELIC_PART,1000)
       return str(npcId)+"-10.htm"
    elif event == "3" :
       st.giveItems(6885,1)
       st.takeItems(RELIC_PART,1000)
       return str(npcId)+"-10.htm"
    elif event == "4" :
       st.giveItems(6887,1)
       st.takeItems(RELIC_PART,1000)
       return str(npcId)+"-10.htm"
    elif event == "5" :
       st.giveItems(6889,1)
       st.takeItems(RELIC_PART,1000)
       return str(npcId)+"-10.htm"
    elif event == "6" :
       st.giveItems(6891,1)
       st.takeItems(RELIC_PART,1000)
       return str(npcId)+"-10.htm"
    elif event == "7" :
       st.giveItems(6893,1)
       st.takeItems(RELIC_PART,1000)
       return str(npcId)+"-10.htm"
    elif event == "8" :
       st.giveItems(6895,1)
       st.takeItems(RELIC_PART,1000)
       return str(npcId)+"-10.htm"
    elif event == "9" :
       st.giveItems(6897,1)
       st.takeItems(RELIC_PART,1000)
       return str(npcId)+"-10.htm"
    elif event == "10" :
       st.giveItems(6899,1)
       st.takeItems(RELIC_PART,1000)
       return str(npcId)+"-10.htm"

    elif event == "OPENBOX1" : # 威格特的亡靈 - 開封印箱子
       if st.getInt("box") != 2 : return "任務尚未完成。"
       if st.getQuestItemsCount(SEALED_BOX) :
          st.takeItems(SEALED_BOX,1)
          if st.getRandom(100) < 35 :
             st.giveItems(REWARDS[st.getRandom(len(REWARDS))],1)
             return str(npcId)+"-11.htm"
          else:
             if st.getRandom(100) < 40 :
                return str(npcId)+"-12.htm"
             else:
                return str(npcId)+"-13.htm"

    elif event == "OPENBOX2" : # 艾爾摩亞丁侍衛的亡靈 - 開封印的箱子
       if st.getInt("box") != 2 : return "任務尚未完成。"
       if st.getQuestItemsCount(SEALED_BOX) :
          st.takeItems(SEALED_BOX,1)
          if st.getRandom(100) < 20 :
             st.giveItems(REWARDS[st.getRandom(len(REWARDS))],1)
             return str(npcId)+"-02.htm"
          else:
             if st.getRandom(100) < 40 :
                return str(npcId)+"-03.htm"
             else:
                return str(npcId)+"-04.htm"
       elif st.getQuestItemsCount(SEALED_BOX)==0 :
          return str(npcId)+"-05.htm"

    elif event == "INTOFS" : # 陵墓管理員 - 進入四大陵墓條件
       npc.onBypassFeedback(player,"Entry")
       return

    return htmltext

 def onTalk (self,npc,player):
    htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
    st = player.getQuestState(qn)
    npcId = npc.getNpcId()
    id = st.getState()
    cond = st.getInt("cond")
    four = st.getInt("four")
    wigoth = st.getInt("wigoth")
    box = st.getInt("box")
    if not st : return htmltext

    if id == State.CREATED :
       if npcId == NS : # 無名的靈魂
          if st.getPlayer().getLevel() > 73 :
             htmltext = str(npcId)+"-01.htm"
          else:
             htmltext = str(npcId)+"-00.htm"
             st.exitQuest(1)

    elif id == State.STARTED :
       if npcId == NS : # 無名的靈魂
          if cond == 1 :
             if st.getQuestItemsCount(ALECTIA) and st.getQuestItemsCount(TISHAS) and st.getQuestItemsCount(MEKARA) and st.getQuestItemsCount(MORIGUL) :
                htmltext = str(npcId)+"-16.htm"
             else :
                htmltext = str(npcId)+"-13.htm"
          elif four == 2 or cond == 2 :
             htmltext = str(npcId)+"-19.htm"

       elif npcId == WGA : # 威格特的亡靈 - 皇帝陵墓(擊敗哈里夏的影子後)
          st.set("box","2")
          if st.getQuestItemsCount(ALECTIA) + st.getQuestItemsCount(TISHAS) + st.getQuestItemsCount(MEKARA) + st.getQuestItemsCount(MORIGUL) <= 1:
             htmltext = str(npcId)+"-01.htm"
             st.set("wigoth","1")
          elif st.getQuestItemsCount(ALECTIA) + st.getQuestItemsCount(TISHAS) + st.getQuestItemsCount(MEKARA) + st.getQuestItemsCount(MORIGUL) == 2:
             htmltext = str(npcId)+"-02.htm"
             st.set("wigoth","2")
          elif st.getQuestItemsCount(ALECTIA) + st.getQuestItemsCount(TISHAS) + st.getQuestItemsCount(MEKARA) + st.getQuestItemsCount(MORIGUL) == 3:
             htmltext = str(npcId)+"-04.htm"
             st.set("wigoth","3")
          elif st.getQuestItemsCount(ALECTIA) + st.getQuestItemsCount(TISHAS) + st.getQuestItemsCount(MEKARA) + st.getQuestItemsCount(MORIGUL) == 4:
             htmltext = str(npcId)+"-05.htm"
             st.set("wigoth","4")
          elif st.getQuestItemsCount(ALECTIA) + st.getQuestItemsCount(TISHAS) + st.getQuestItemsCount(MEKARA) + st.getQuestItemsCount(MORIGUL) > 4:
             htmltext = str(npcId)+"-05.htm"

       elif npcId == WGB : # 威格特的亡靈 - 巡禮者寺院
          if st.getInt("box") != 2 : return "任務尚未完成。"
          if four==1 :
             if st.getQuestItemsCount(RELIC_PART) < 1000 and st.getQuestItemsCount(SEALED_BOX) > 0 :
                htmltext = str(npcId)+"-02.htm"
             elif st.getQuestItemsCount(RELIC_PART) > 999 and st.getQuestItemsCount(SEALED_BOX) == 0 :
                htmltext = str(npcId)+"-03.htm"
             elif st.getQuestItemsCount(RELIC_PART) > 999 and st.getQuestItemsCount(SEALED_BOX) > 0 :
                htmltext = str(npcId)+"-04.htm"
             elif st.getQuestItemsCount(RELIC_PART) == 0 and st.getQuestItemsCount(SEALED_BOX) == 0 :
                htmltext = str(npcId)+"-01.htm"
          elif four==2 :
             if st.getQuestItemsCount(RELIC_PART) < 1000 and st.getQuestItemsCount(SEALED_BOX) > 0 :
                htmltext = str(npcId)+"-06.htm"
             elif st.getQuestItemsCount(RELIC_PART) > 999 and st.getQuestItemsCount(SEALED_BOX) == 0 :
                htmltext = str(npcId)+"-07.htm"
             elif st.getQuestItemsCount(RELIC_PART) > 999 and st.getQuestItemsCount(SEALED_BOX) > 0 :
                htmltext = str(npcId)+"-08.htm"
             elif st.getQuestItemsCount(RELIC_PART) == 0 and st.getQuestItemsCount(SEALED_BOX) == 0 :
                htmltext = str(npcId)+"-05.htm"

       elif npcId in [COEA,COEB] : # 艾爾摩亞丁侍衛的亡靈
          htmltext = str(npcId)+"-01.htm"

       elif npcId in [CSM,ESM,GSM,JSM]: # 陵墓管理員
         if FourSepulchersManager.getInstance().IsEntryTime() :
             if not player.isInParty():
                  return "組滿5人隊伍的隊長才可以申請。"
             elif not player.getParty().isLeader(player):
                  return "組滿5人隊伍的隊長才可以申請。"
             elif player.getParty().getMemberCount() != 5:
                  return "組滿5人隊伍的隊長才可以申請。"
             else :
                  htmltext = str(npcId)+"-01.htm"
         else :
             htmltext = str(npcId)+"-02.htm"

       elif npcId in HGKB : # 男爵禮拜堂守門人
        if not player.isInParty():
             return "組滿5人隊伍的隊長才可以申請。"
        elif not player.getParty().isLeader(player):
             return "組滿5人隊伍的隊長才可以申請。"
        elif player.getParty().getMemberCount() != 5:
             return "組滿5人隊伍的隊長才可以申請。"
        elif FourSepulchersManager.getInstance().IsAttackTime() :
             if st.getQuestItemsCount(HALLS_KEY) :
                npc.onBypassFeedback(player,"open_gate")
                partyMembers = [player]
                party = player.getParty()
                if party :
                   partyMembers = party.getPartyMembers().toArray()
                   for player in partyMembers :
                       pst = player.getQuestState(qn)
                       pst.takeItems(HALLS_KEY,-1)
                return
             else :
                return HGKB_MSG
        else :
            return "條件不符，無法進入。"
       elif npcId in HGKV : # 子爵禮拜堂守門人
        if not player.isInParty():
             return "組滿5人隊伍的隊長才可以申請。"
        elif not player.getParty().isLeader(player):
             return "組滿5人隊伍的隊長才可以申請。"
        elif player.getParty().getMemberCount() != 5:
             return "組滿5人隊伍的隊長才可以申請。"
        elif FourSepulchersManager.getInstance().IsAttackTime() :
             if st.getQuestItemsCount(HALLS_KEY) :
                npc.onBypassFeedback(player,"open_gate")
                partyMembers = [player]
                party = player.getParty()
                if party :
                   partyMembers = party.getPartyMembers().toArray()
                   for player in partyMembers :
                       pst = player.getQuestState(qn)
                       pst.takeItems(HALLS_KEY,-1)
                return
             else :
                return HGKV_MSG
        else :
            return "條件不符，無法進入。"
       elif npcId in HGKC : # 伯爵禮拜堂守門人
        if not player.isInParty():
             return "組滿5人隊伍的隊長才可以申請。"
        elif not player.getParty().isLeader(player):
             return "組滿5人隊伍的隊長才可以申請。"
        elif player.getParty().getMemberCount() != 5:
             return "組滿5人隊伍的隊長才可以申請。"
        elif FourSepulchersManager.getInstance().IsAttackTime() :
             if st.getQuestItemsCount(HALLS_KEY) :
                npc.onBypassFeedback(player,"open_gate")
                partyMembers = [player]
                party = player.getParty()
                if party :
                   partyMembers = party.getPartyMembers().toArray()
                   for player in partyMembers :
                       pst = player.getQuestState(qn)
                       pst.takeItems(HALLS_KEY,-1)
                return
             else :
                return HGKC_MSG
        else :
            return "條件不符，無法進入。"
       elif npcId in HGKM : # 侯爵禮拜堂守門人
        if not player.isInParty():
             return "組滿5人隊伍的隊長才可以申請。"
        elif not player.getParty().isLeader(player):
             return "組滿5人隊伍的隊長才可以申請。"
        elif player.getParty().getMemberCount() != 5:
             return "組滿5人隊伍的隊長才可以申請。"
        elif FourSepulchersManager.getInstance().IsAttackTime() :
             if st.getQuestItemsCount(HALLS_KEY) :
                npc.onBypassFeedback(player,"open_gate")
                partyMembers = [player]
                party = player.getParty()
                if party :
                   partyMembers = party.getPartyMembers().toArray()
                   for player in partyMembers :
                       pst = player.getQuestState(qn)
                       pst.takeItems(HALLS_KEY,-1)
                return
             else :
                return HGKM_MSG
        else :
            return "條件不符，無法進入。"
       elif npcId in HGKD : # 公爵禮拜堂守門人
        if not player.isInParty():
             return "組滿5人隊伍的隊長才可以申請。"
        elif not player.getParty().isLeader(player):
             return "組滿5人隊伍的隊長才可以申請。"
        elif player.getParty().getMemberCount() != 5:
             return "組滿5人隊伍的隊長才可以申請。"
        elif FourSepulchersManager.getInstance().IsAttackTime() :
             if st.getQuestItemsCount(HALLS_KEY) :
                npc.onBypassFeedback(player,"open_gate")
                partyMembers = [player]
                party = player.getParty()
                if party :
                   partyMembers = party.getPartyMembers().toArray()
                   for player in partyMembers :
                       pst = player.getQuestState(qn)
                       pst.takeItems(HALLS_KEY,-1)
                return
             else :
                return HGKD_MSG
        else :
            return "條件不符，無法進入。"

    return htmltext

 def onKill(self,npc,player,isPet):
    st = player.getQuestState(qn)
    npcId = npc.getNpcId()
    if not st : return
    if st.getState() == State.STARTED :
       if st.getInt("cond")==1 or st.getInt("cond")==2 :
          if npcId in MOBS :
             if st.getRandom(100) < 30 :
                st.giveItems(SEALED_BOX,1)
                st.set("box","1")
                st.playSound("ItemSound.quest_itemget")
    return

QUEST       = Quest(620,qn,"四聖杯")

QUEST.addStartNpc(NS)
QUEST.addTalkId(NS)
QUEST.addTalkId(WGA)
QUEST.addTalkId(WGB)
QUEST.addTalkId(CSM)
QUEST.addTalkId(ESM)
QUEST.addTalkId(GSM)
QUEST.addTalkId(JSM)
QUEST.addTalkId(COEA)
QUEST.addTalkId(COEB)

for npc1 in HGKB:
    QUEST.addTalkId(npc1)

for npc2 in HGKV:
    QUEST.addTalkId(npc2)

for npc3 in HGKC:
    QUEST.addTalkId(npc3)

for npc4 in HGKM:
    QUEST.addTalkId(npc4)

for npc5 in HGKD:
    QUEST.addTalkId(npc5)

for mob in MOBS:
    QUEST.addKillId(mob)
