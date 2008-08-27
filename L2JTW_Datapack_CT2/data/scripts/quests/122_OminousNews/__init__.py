# Made by Polo
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "122_OminousNews"

#Npc
MOIRA = 31979
KARUDA = 32017

default="<html><body>目前沒有執行任務，或條件不符。</body></html>"

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onEvent (self,event,st) :
   htmltext = default
   id = st.getState()
   cond = st.getInt("cond")
   if id != State.COMPLETED :
     htmltext = event
     if htmltext == "31979-03.htm" and cond == 0 :
       st.set("cond","1")
       st.setState(State.STARTED)
       st.playSound("ItemSound.quest_accept")
     elif htmltext == "32017-02.htm" :
       if cond == 1 and st.getInt("ok") :
         st.giveItems(57,1695)
         st.unset("cond")
         st.unset("ok")
         st.exitQuest(False)
         st.playSound("ItemSound.quest_finish")
       else :
         htmltext=default
   return htmltext

 def onTalk (self,npc,player):
   npcId = npc.getNpcId()
   htmltext = default
   st = player.getQuestState(qn)
   if not st : return htmltext

   id = st.getState()
   cond = st.getInt("cond")
   if id == State.COMPLETED :
      htmltext="<html><body>這是已經完成的任務。</body></html>"
   elif npcId == MOIRA :
      if cond == 0 :
         if player.getLevel()>=20 :
            htmltext = "31979-02.htm"
         else :
            htmltext = "31979-01.htm"
            st.exitQuest(1)
      else:
         htmltext = "31979-03.htm"
   elif npcId == KARUDA and cond==1 and id == State.STARTED:
      htmltext = "32017-01.htm"
      st.set("ok","1")
   return htmltext

QUEST       = Quest(122,qn,"不祥的消息")


QUEST.addStartNpc(MOIRA)

QUEST.addTalkId(MOIRA)

QUEST.addTalkId(KARUDA)
