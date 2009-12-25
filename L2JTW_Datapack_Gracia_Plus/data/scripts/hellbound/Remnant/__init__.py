import sys
from com.l2jserver.gameserver.model.quest        import State
from com.l2jserver.gameserver.model.quest        import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

# 18463 舊神殿的戰士
# 18464 舊神殿的祭司長

qn = "Remnant"

class Quest (JQuest):
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onKill (self,npc,player,isPet):
		return
		
	def onSpawn(self, npc):
		self.isSpawned = False
		npc.setKillable(False)
	
QUEST = Quest(-1, qn, "ai")

QUEST.addKillId(18463)
QUEST.addSpawnId(18463)
QUEST.addKillId(18464)
QUEST.addSpawnId(18464)