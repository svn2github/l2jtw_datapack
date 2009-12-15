import sys
from net.sf.l2j.gameserver.model.quest        import State
from net.sf.l2j.gameserver.model.quest        import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "Kief"

# 32354	³Í¤Ò
# 10012	ÃÈ¤lªº¬r°w
# 9672	Å]ªk¸¬Äª

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onAdvEvent (self,event,npc,player):
   htmltext = event
   st = player.getQuestState(qn)
   if not st : return htmltext
   if event == "32354-2.htm" :
     if st.getQuestItemsCount(10012) >= 20 :
        st.takeItems(10012,20)
        st.giveItems(9672,1)
        htmltext = ""
        st.exitQuest(1) 
     else :
        htmltext = "32354-2.htm"
        st.exitQuest(1) 
   return htmltext

 def onTalk (Self,npc,player):
   st = player.getQuestState(qn)
   if not st: return
   npcId = npc.getNpcId()
   if npcId == 32354 :
      htmltext = "32354-1.htm"
   return htmltext

QUEST = Quest(-1, qn, "hellbound")

QUEST.addStartNpc(32354)
QUEST.addTalkId(32354)