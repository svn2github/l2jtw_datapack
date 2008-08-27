# By L2J_JP SANDMAN
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "654_JourneytoaSettlement"

#NPC
SPIRIT      = 31453     #無名的靈魂

#TARGET
TARGET_1    = 21294     #山谷羚羊
TARGET_2    = 21295     #山谷羚羊奴隸

#ITEM
ITEM        = 8072      #羚羊皮革

#REWARD
SCROLL      = 8073      #芙琳泰沙的結界破咒書

class Quest (JQuest) :

  def __init__(self,id,name,descr): 
      JQuest.__init__(self,id,name,descr)
      self.questItemIds = [ITEM]

  def onEvent (self,event,st) :
    htmltext = event
    if event == "31453-2.htm" :
       st.set("cond","1")
       st.setState(State.STARTED)
       st.playSound("ItemSound.quest_accept")
    elif event == "31453-3.htm" :
       st.set("cond","2")
       st.playSound("ItemSound.quest_middle")
    elif event == "31453-5.htm" :
       st.giveItems(SCROLL,1)
       st.takeItems(ITEM,1)
       st.playSound("ItemSound.quest_finish")
       st.exitQuest(1)
    return htmltext

  def onTalk (Self,npc,player):
    htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
    st = player.getQuestState(qn)
    if not st: return htmltext
    cond = st.getInt("cond")
    npcId = npc.getNpcId()
    id = st.getState()
    if id == State.CREATED or id == State.COMPLETED:
       preSt = player.getQuestState("119_LastImperialPrince")
       if preSt: preId = preSt.getState()
       if player.getLevel() < 74 :
          htmltext = "31453-0.htm"
          st.exitQuest(1)
       elif not preSt:
          htmltext = "<html><body><font color=\"LEVEL\">最後的皇子</font>任務尚未完成。</body></html>"
          st.exitQuest(1)
       elif preId != State.COMPLETED :
          htmltext = "<html><body><font color=\"LEVEL\">最後的皇子</font>任務尚未完成。</body></html>"
          st.exitQuest(1)
       else :
          htmltext = "31453-1.htm"
    elif npcId == SPIRIT :
       if cond == 1 :
          htmltext = "31453-2.htm"
       elif cond == 3 :
          htmltext = "31453-4.htm"
    return htmltext

  def onKill (self,npc,player,isPet) :
    st = player.getQuestState(qn)
    if not st: return
    npcId = npc.getNpcId()
    if st.getInt("cond") == 2 and  st.getRandom(100) < 5 :
       st.set("cond","3")
       st.giveItems(ITEM,1)
       st.playSound("ItemSound.quest_middle")
    return

QUEST = Quest(654,qn,"迎接最終的結局")

QUEST.addStartNpc(SPIRIT)

QUEST.addTalkId(SPIRIT)

QUEST.addKillId(TARGET_1)
QUEST.addKillId(TARGET_2)
