import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

from com.l2jserver.gameserver.util import Broadcast
from com.l2jserver.gameserver.network.serverpackets import NpcSay
from com.l2jserver.gameserver.network.clientpackets import Say2
from com.l2jserver.gameserver.network import NpcStringId
from com.l2jserver.gameserver.datatables import SpawnTable
from com.l2jserver.util import Rnd

selfTalkData = {
	32975:[[1811294]]
	,33025:[[1032340],[1032341],[1032342]]
	,33026:[[1032319],[1032320],[1032321]]
	,33116:[[1811244]]
	,33124:[[17178345]]
	,33199:[[1811312]]
	,33223:[[1811243]]
	,33229:[[1032318]]
	,33238:[[1811252]]
	,33271:[[1811245]]
	,33284:[[1811248]]
	,33285:[[1811247]]
	,33487:[[11021702],[11021704],[11021706],[11021708]]
	,33581:[[1811313],[1811314],[1811315]]
}

class Quest(JQuest):
	qID = -1
	qn = "npcSelfTalk"
	qDesc = "custom"
	
	def myBroadcast(self, npc, npcstring):
		for player in npc.getKnownList().getKnownPlayers().values():
			if npc.isInsideRadius(player, 1000, False, False):
				player.sendPacket(NpcSay(npc.getObjectId(), Say2.NPC_SAY, npc.getNpcId(), NpcStringId.getNpcStringId(npcstring)))

	def __init__(self, id = qID, name = qn, descr = qDesc):
		self.qID, self.qn, self.qDesc = id, name, descr
		JQuest.__init__(self, id, name, descr)
		for npcid in selfTalkData:
			delay = Rnd.get(8, 18)
			self.startQuestTimer("say_%d_%d" % (npcid, 0), 1000 * delay, None, None, False)
		print "%s loaded" % self.qn

	def onAdvEvent(self, event, npc, player):
		if event.startswith("say_"):
			dummy, npcid, index = event.split("_")
			npcid, index = int(npcid), int(index)
			for spawn in SpawnTable.getInstance().getSpawnTable():
				if npcid == spawn.getNpcid():
					self.myBroadcast(spawn.getLastSpawn(), selfTalkData[npcid][index][0])
			newindex = [index + 1, 0][index + 1 >= len(selfTalkData[npcid])]
			delay = Rnd.get(8, 18)
			self.startQuestTimer("say_%d_%d" % (npcid, newindex), 1000 * delay, None, None, False)

Quest()