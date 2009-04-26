import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "1109_Gracia_Flyboatwharf"

class Quest (JQuest) :

 def __init__(self,id,name,descr):
     JQuest.__init__(self,id,name,descr)

 def onTalk (self,npc,player):
   st = player.getQuestState("1109_Gracia_Flyboatwharf")
   htmltext = ""
   if player.getLevel() < 75 :
      htmltext = "32632-0.htm"
      st.exitQuest(1)
   else :
      if st.getQuestItemsCount(57) < 150000 :
         htmltext = "ª÷¿ú¤£¨¬¡C"
      else:
         st.takeItems(57,150000)
         player.teleToLocation(-149406,255247,-80)
         st.exitQuest(1)
   return htmltext

QUEST       = Quest(1109,qn,"Teleports")

QUEST.addStartNpc(32632)
QUEST.addTalkId(32632)
