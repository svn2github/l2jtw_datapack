#Made by Ethernaly ethernaly@email.it
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "117_OceanOfDistantStar"

#NPC
ABEY = 32053
GHOST = 32055
GHOST_F = 32054
OBI = 32052
BOX = 32076
#QUEST ITEM, CHANCE and REWARD
GREY_STAR  = 8495
ENGRAVED_HAMMER = 8488
CHANCE = 38

class Quest (JQuest) :

  def __init__(self,id,name,descr):
    JQuest.__init__(self,id,name,descr)
    self.questItemIds = [GREY_STAR]
  
  def onAdvEvent (self,event,npc, player) :
    htmltext = event
    st = player.getQuestState(qn)
    if not st : return
    if event == "1" :
      htmltext = "0a.htm"
      st.set("cond","1")
      st.setState(State.STARTED)
      st.playSound("ItemSound.quest_accept")
    if event == "2" :#and cond == 1
      htmltext="1a.htm"
      st.set("cond","2")
      st.playSound("ItemSound.quest_accept") #修改 pmq 增加
    if event == "3" :#and cond == 2
      htmltext="2a.htm"
      st.set("cond","3")
      st.playSound("ItemSound.quest_accept") #修改 pmq 增加
    if event == "4" :#and cond == 3
      htmltext="3a.htm"
      st.set("cond","4")
      st.playSound("ItemSound.quest_accept") #修改 pmq 增加
    if event == "5" :#and cond == 4
      htmltext="4a.htm"
      st.set("cond","5")
      st.giveItems(ENGRAVED_HAMMER,1)
      st.playSound("ItemSound.quest_accept") #修改 pmq 增加
    if event == "6" and st.getQuestItemsCount(ENGRAVED_HAMMER) :
      htmltext="5a.htm"
      st.set("cond","6")
      st.playSound("ItemSound.quest_accept") #修改 pmq 增加
    if event == "7" and st.getQuestItemsCount(ENGRAVED_HAMMER) :
      htmltext="6a.htm"
      st.set("cond","7")
      st.playSound("ItemSound.quest_accept") #修改 pmq 增加
    if event == "8" and st.getQuestItemsCount(GREY_STAR) :
      htmltext="7a.htm"
      st.takeItems(GREY_STAR,1)
      st.set("cond","9")
      st.playSound("ItemSound.quest_accept") #修改 pmq 增加
    if event == "9" and st.getQuestItemsCount(ENGRAVED_HAMMER) :
      htmltext="8a.htm"
      st.takeItems(ENGRAVED_HAMMER,1)
      st.set("cond","10")
      st.playSound("ItemSound.quest_accept") #修改 pmq 增加
    if event == "10" :
      htmltext="9b.htm"
      st.giveItems(57,17647)
      st.addExpAndSp(107387,7369)
      st.playSound("ItemSound.quest_finish")
      st.exitQuest(False)
    return htmltext

  def onTalk(self, npc, player):
    st = player.getQuestState(qn)
    if not st : return htmltext    
    npcId=npc.getNpcId()
    htmltext="<html><body>目前沒有執行任務，或條件不符。</body></html>"
    id = st.getState()
    if id == State.COMPLETED:
      htmltext = "<html><body>這是已經完成的任務。</body></html>"
    elif id == State.CREATED and npcId == ABEY :
      if st.getPlayer().getLevel() >= 39 :
        htmltext = "0.htm" #event 1
      else:
        st.exitQuest(1)
        htmltext = "00.htm"   #修改 pmq 增加對話
    elif id == State.STARTED :
      cond = int(st.get("cond"))
      if npcId == ABEY :      #修改 pmq 增加對話
        if cond == 1 :        #修改 pmq 增加對話
          htmltext = "0b.htm" #修改 pmq 增加對話
      if npcId == GHOST :
        if cond == 1 :
          htmltext = "1.htm" #to event 2
        if cond == 2 :        #修改 pmq 增加對話
          htmltext = "1b.htm" #修改 pmq 增加對話
        elif cond == 9 and st.getQuestItemsCount(ENGRAVED_HAMMER) :
          htmltext = "8.htm" #to event 9
        if cond == 10 :       #修改 pmq 增加對話
          htmltext = "8b.htm" #修改 pmq 增加對話
      if npcId == BOX :       #修改 pmq 增加對話
        if cond == 5 :        #修改 pmq 增加對話
          htmltext = "4b.htm" #修改 pmq 增加對話
      if npcId == OBI :
        if cond == 2 :
          htmltext = "2.htm" #to event 3
        if cond == 3 :        #修改 pmq 增加對話
          htmltext = "2b.htm" #修改 pmq 增加對話
        elif cond == 6 and st.getQuestItemsCount(ENGRAVED_HAMMER) :
          htmltext = "6.htm" #to event 7
        elif cond == 7 and st.getQuestItemsCount(ENGRAVED_HAMMER) :
          htmltext = "6a.htm" #to event 7
        elif cond == 8 and st.getQuestItemsCount(GREY_STAR) :
          htmltext = "7.htm" #to event 8
        if cond == 9 :        #修改 pmq 增加對話
          htmltext = "7b.htm" #修改 pmq 增加對話
      if npcId == ABEY :
        if cond == 3 :
          htmltext = "3.htm" #to event 4
        if cond == 4 :        #修改 pmq 增加對話
          htmltext = "3b.htm" #修改 pmq 增加對話
        elif cond == 5 and st.getQuestItemsCount(ENGRAVED_HAMMER) :
          htmltext = "5.htm" #to event 6
        elif cond == 6 and st.getQuestItemsCount(ENGRAVED_HAMMER) :
          htmltext = "5a.htm" #to event 6
        if cond == 7 :        #修改 pmq 增加對話
          htmltext = "5b.htm" #修改 pmq 增加對話
      if npcId == BOX and cond == 4 :
            htmltext = "4.htm" #to event 5
      if npcId == GHOST_F and cond == 10 :
            htmltext = "9.htm" #link to 9a.htm so link to event 10
    return htmltext

  def onKill(self,npc,player,isPet):
   st = player.getQuestState(qn)
   if st :
     if st.getState() == State.STARTED :
       count = st.getQuestItemsCount(GREY_STAR)
       if st.getInt("cond") == 7 and count < 1 and st.getRandom(100)<CHANCE :
          st.giveItems(GREY_STAR,1)
          st.playSound("ItemSound.quest_itemget")
          st.set("cond","8")
   return

QUEST=Quest(117,qn,"無法抵達的星之海")

QUEST.addStartNpc(ABEY)
QUEST.addTalkId (ABEY)

QUEST.addTalkId(GHOST)
QUEST.addTalkId(OBI)
QUEST.addTalkId(BOX)
QUEST.addTalkId(GHOST_F)

for MOBS in [22023,22024]:
  QUEST.addKillId(MOBS)