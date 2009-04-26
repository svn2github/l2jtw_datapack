# pmq

import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "1110_Gracia_Heart"

class Quest (JQuest) :

 def __init__(self,id,name,descr):
     JQuest.__init__(self,id,name,descr)

 def onTalk (self,npc,player):
   st = player.getQuestState("1110_Gracia_Heart")
   npcId = npc.getNpcId()
   id = st.getState()
   if npcId == 36570 :
     if player.getLevel() < 75 :
        htmltext = "36570-0.htm"
        st.exitQuest(1)
     else :
        player.teleToLocation(-204288,242026,1744)
        htmltext = ""
        st.exitQuest(1)
   return htmltext

QUEST       = Quest(1110,qn,"Teleports")

QUEST.addStartNpc(36570)
QUEST.addTalkId(36570)