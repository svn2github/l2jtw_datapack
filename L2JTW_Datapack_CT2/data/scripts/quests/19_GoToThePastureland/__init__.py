# Made by disKret
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "19_GoToThePastureland"

#NPC
VLADIMIR = 31302
TUNATUN = 31537

#ITEMS
BEAST_MEAT = 7547

class Quest (JQuest) :

 def __init__(self,id,name,descr):
     JQuest.__init__(self,id,name,descr)
     self.questItemIds = [BEAST_MEAT]

 def onEvent (self,event,st) :
   htmltext = event
   if event == "31302-1.htm" :
     st.giveItems(BEAST_MEAT,1)
     st.set("cond","1")
     st.setState(State.STARTED)
     st.playSound("ItemSound.quest_accept")
   if event == "31537-1.htm" :
     st.takeItems(BEAST_MEAT,1)
     st.giveItems(57,30000)
     st.unset("cond")
     st.exitQuest(False)
     st.playSound("ItemSound.quest_finish")
   return htmltext

 def onTalk (self,npc,player):
   htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
   st = player.getQuestState(qn)
   if not st : return htmltext

   npcId = npc.getNpcId()
   id = st.getState()
   cond = st.getInt("cond")
   if npcId == VLADIMIR :
     if cond == 0 :
       if id == State.COMPLETED :
         htmltext = "<html><body>這是已經完成的任務。</body></html>"

       elif player.getLevel() >= 63 :
         htmltext = "31302-0.htm"
       else:
         htmltext = "31302-0a.htm"
         st.exitQuest(1)
     else :
       htmltext = "31302-2.htm"
   elif id == State.STARTED :
       htmltext = "31537-0.htm"
   return htmltext

QUEST       = Quest(19,qn,"前往放牧場吧!")

QUEST.addStartNpc(VLADIMIR)

QUEST.addTalkId(VLADIMIR)
QUEST.addTalkId(TUNATUN)
