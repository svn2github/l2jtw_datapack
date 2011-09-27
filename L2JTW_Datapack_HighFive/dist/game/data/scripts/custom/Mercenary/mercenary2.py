import sys
from com.l2jserver.gameserver.model              import L2Multisell
from com.l2jserver.gameserver.model.quest        import State
from com.l2jserver.gameserver.model.quest        import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "mercenary2"

# NPC 
NPCS = [36481,36482,36483,36484,36485,36486,36487,36488,36489]

# ITEM
Elite_Mercenary_Certificate = 13767
Exalted_Mercenary_Certificate = 13768

class mercenary2 (JQuest) :

	def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

	def onTalk (Self,npc,player):
		st = player.getQuestState(qn)
		if not st: return
		npcId = npc.getNpcId()
		EMC = st.getQuestItemsCount(Elite_Mercenary_Certificate)
		HEMC = st.getQuestItemsCount(Exalted_Mercenary_Certificate)
		npcId = npc.getNpcId()
		if EMC or HEMC :
			L2Multisell.getInstance().separateAndSend(npcId*10000+2, player, npc.getNpcId(), False, 0.0);
			htmltext = ""
		else :
			htmltext = "<html><body>你要拿給我看的資格證在哪裡？你是瞧不起我嗎？</body></html>"
		return htmltext

QUEST = mercenary2(-1,qn,"Custom")

for item in NPCS :
	QUEST.addStartNpc(item)
	QUEST.addTalkId(item)