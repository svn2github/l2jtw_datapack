# By L2J_JP SANDMAN
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "119_LastImperialPrince"

#NPC
SPIRIT   = 31453    #無名的靈魂
DEVORIN  = 32009    #黛芙琳

#ITEM
BROOCH   = 7262     #破舊的胸針

#REWARD
ADENA    = 57       #金幣
AMOUNT   = 68787    #數量

class Quest (JQuest) :

  def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

  def onEvent (self,event,st) :
    htmltext = event
    if event == "31453-4.htm" :
       st.set("cond","1")
       st.setState(State.STARTED)
       st.playSound("ItemSound.quest_accept")
    elif event == "32009-2.htm" :
       if st.getQuestItemsCount(BROOCH) < 1 :
          htmltext = "<html><body><font color=\"LEVEL\">四聖杯</font>任務尚未完成。</body></html>"
          st.exitQuest(1)
    elif event == "32009-3.htm" :
       st.set("cond","2")
       st.playSound("ItemSound.quest_middle")
    elif event == "31453-7.htm" :
       st.giveItems(ADENA,AMOUNT)
       st.setState(State.COMPLETED)
       st.playSound("ItemSound.quest_finish")
       st.exitQuest(1)
    return htmltext

  def onTalk (Self,npc,player):
    st = player.getQuestState(qn)
    htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
    if not st: return htmltext
    cond = st.getInt("cond")
    npcId = npc.getNpcId()
    id = st.getState()
    if st.getQuestItemsCount(BROOCH) < 1 :
       htmltext = "<html><body><font color=\"LEVEL\">四聖杯</font>任務尚未完成。</body></html>"
       st.exitQuest(1)
    elif id == State.CREATED :
       if player.getLevel() < 74 :
          htmltext = "31453-0.htm"
          st.exitQuest(1)
       else :
          htmltext = "31453-1.htm"
    elif id == State.COMPLETED :
       htmltext = "<html><body>這是已經完成的任務。</body></html>"
       st.exitQuest(1)
    elif npcId == SPIRIT :
       if cond == 1 :
          htmltext = "31453-4.htm"
       elif cond == 2 :
          htmltext = "31453-5.htm"
    elif npcId == DEVORIN :
       if cond == 1 :
          htmltext = "32009-1.htm"
       elif cond == 2:
          htmltext = "32009-3.htm"
    return htmltext

QUEST = Quest(119,qn,"最後的皇子")

QUEST.addStartNpc(SPIRIT)

QUEST.addTalkId(SPIRIT)
QUEST.addTalkId(DEVORIN)
