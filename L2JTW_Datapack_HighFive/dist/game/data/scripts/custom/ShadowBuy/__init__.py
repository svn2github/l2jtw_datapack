import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "ShadowBuy"

NPC =[30084,30085,30178,30684,30837,30890,30891,31256,31257,31300,31301,31945,31946]

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onTalk (Self,npc,player):
    st = player.getQuestState(qn)
    if not st: return
    if player.getLevel() > 39:
       return "shadow_01.htm"
       st.exitQuest(1)
    else:
       return "00.htm"
       st.exitQuest(1)
    return

QUEST       = Quest(-1,qn,"custom")

for item in NPC:
   QUEST.addStartNpc(item)
   QUEST.addTalkId(item)
