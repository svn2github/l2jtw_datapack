# author Korvin
import sys
from com.l2jserver.gameserver.model.quest.jython   import QuestJython as JQuest
from com.l2jserver.gameserver.model.actor.instance import L2PcInstance

#¦h§Q¦w

qn = "Tully"

class Quest(JQuest):
	def __init__(self, id, name, descr) :
		JQuest.__init__(self, id, name, descr)

	def onTalk (self,npc,player):
		return "It doesn't work yet!"

	def onAdvEvent (self,event,npc,player) :
		npcID = npc.getNpcId()
		return "onAdvEvent works"

	def onKill(self,npc,player,isPet) :
		return "onKill works"

QUEST = Quest(-1, qn, "hellbound")

QUEST.addStartNpc(32373)