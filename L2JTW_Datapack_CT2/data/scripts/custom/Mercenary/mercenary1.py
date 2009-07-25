import sys
from net.sf.l2j.gameserver.model              import L2Multisell
from net.sf.l2j.gameserver.model.quest        import State
from net.sf.l2j.gameserver.model.quest        import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "mercenary1"

# NPC 
NPCS = [36481,36482,36483,36484,36485,36486,36487,36488,36489]

class mercenary1 (JQuest) :

	def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

	def onTalk (Self,npc,player):
		st = player.getQuestState(qn)
		npcId = npc.getNpcId()
		L2Multisell.getInstance().separateAndSend(npcId*10000+1, player, npc.getNpcId(), False, 0.0);
		return 
	
QUEST = mercenary1(-1, qn, "Custom")

for item in NPCS :
	QUEST.addStartNpc(item)
	QUEST.addTalkId(item)