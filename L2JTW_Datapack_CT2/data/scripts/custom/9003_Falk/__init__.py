import sys
from net.sf.l2j.gameserver.model.quest        import State
from net.sf.l2j.gameserver.model.quest        import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "9003_Falk"

# 32297	ºÖº¸§J

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onAdvEvent (self,event,npc,player):
   htmltext = event
   st = player.getQuestState(qn)
   if not st : return htmltext
   if event == "32297-2.htm" :
     if st.getQuestItemsCount(9674) >= 20 :
        st.takeItems(9674,20)
        st.giveItems(9850,1)
        htmltext = "32297-2.htm"
        st.exitQuest(1) 
     else :
        htmltext = "32297-4.htm"
        st.exitQuest(1) 
   return htmltext

 def onTalk (Self,npc,player):
   st = player.getQuestState(qn)
   if not st: return
   npcId = npc.getNpcId()
   if npcId == 32297 :
     if st.getQuestItemsCount(9850) >= 1 :
        htmltext = "32297-3.htm"
        st.exitQuest(1) 
     else:
        htmltext = "32297-1.htm"
   return htmltext


QUEST = Quest(-1,qn,"custom")

QUEST.addStartNpc(32297)
QUEST.addTalkId(32297)
