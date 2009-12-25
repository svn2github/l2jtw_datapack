# Script by Psychokiller1888
import sys
from com.l2jserver.gameserver.instancemanager    import InstanceManager
from com.l2jserver.gameserver.model.quest        import State
from com.l2jserver.gameserver.model.quest        import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

ORACLE_GUIDE = 32278
DOOR1        = 24220061
DOOR2        = 24220023

class PyObject:
	pass

def openDoor(doorId,instanceId):
	for door in InstanceManager.getInstance().getInstance(instanceId).getDoors():
		if door.getDoorId() == doorId:
			door.openMe()

class oracle6(JQuest):
	def __init__(self,id,name,descr):
		self.isSpawned = False
		JQuest.__init__(self,id,name,descr)

	def onFirstTalk (self,npc,player):
		npcId = npc.getNpcId()
		if npcId == ORACLE_GUIDE:
			instanceId = npc.getInstanceId()
			openDoor(DOOR1,instanceId)
			openDoor(DOOR2,instanceId)
		return ""

QUEST = oracle6(-1, "oracle6", "ai")

QUEST.addStartNpc(ORACLE_GUIDE)

QUEST.addFirstTalkId(ORACLE_GUIDE)