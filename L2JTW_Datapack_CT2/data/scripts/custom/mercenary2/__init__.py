import sys
from net.sf.l2j.gameserver.model.quest        import State
from net.sf.l2j.gameserver.model.quest        import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "mercenary2"

# NPC 
NPCS = [36481,36482,36483,36484,36485,36486,36487,36488,36489]

# ITEM
Elite_Mercenary_Certificate = 13767

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onTalk (Self,npc,player):
    st = player.getQuestState(qn)
    if not st: return
    npcId = npc.getNpcId()
    EMC = st.getQuestItemsCount(Elite_Mercenary_Certificate)
    npcId = npc.getNpcId()
    if EMC :
       multisell = npcId
       htmltext = st.showHtmlFile("license.htm").replace("%msid%",str(multisell))
    else :
       htmltext = "license-no.htm"
    return htmltext
	
QUEST       = Quest(-1,qn,"Custom")

for item in NPCS :
   QUEST.addStartNpc(item)
   QUEST.addTalkId(item)
