import sys
from com.l2jserver.gameserver.ai import CtrlIntention
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest
from com.l2jserver.util import Rnd

FLOUROS = 18559  # 卡納斯 預言者 普勞羅素
GUARD1  = 18560  # 普勞羅素的手下
GUARD2  = 18560  # 普勞羅素的手下

class PyObject:
	pass

class Quest (JQuest) :
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.npcobject = {}

	def SpawnMobs(self,npc):
		newNpc = self.addSpawn(GUARD1,-41978,-213036,-8117,0,False,0,False, npc.getInstanceId())
		newNpc = self.addSpawn(GUARD2,-41971,-213245,-8118,0,False,0,False, npc.getInstanceId())

	def onAttack(self, npc, player, damage, isPet, skill):
		npcId = npc.getNpcId()
		if npcId == FLOUROS:
			try:
				test = self.npcobject[npc.getObjectId()]
			except:
				self.npcobject[npc.getObjectId()] = PyObject()
				self.npcobject[npc.getObjectId()].started = False
				self.npcobject[npc.getObjectId()].killed = False
				self.npcobject[npc.getObjectId()].hp_to_spawn = {}
				self.npcobject[npc.getObjectId()].hp_to_spawn[80]=False
				self.npcobject[npc.getObjectId()].hp_to_spawn[60]=False
				self.npcobject[npc.getObjectId()].hp_to_spawn[40]=False
				self.npcobject[npc.getObjectId()].hp_to_spawn[30]=False
				self.npcobject[npc.getObjectId()].hp_to_spawn[20]=False
				self.npcobject[npc.getObjectId()].hp_to_spawn[10]=False
				self.npcobject[npc.getObjectId()].hp_to_spawn[5]=False
			maxHp = npc.getMaxHp()
			nowHp = npc.getStatus().getCurrentHp()
			if (nowHp < maxHp*0.8) and not self.npcobject[npc.getObjectId()].hp_to_spawn[80]:
				self.npcobject[npc.getObjectId()].hp_to_spawn[80] = True
				self.SpawnMobs(npc)
			if (nowHp < maxHp*0.6) and not self.npcobject[npc.getObjectId()].hp_to_spawn[60]:
				self.npcobject[npc.getObjectId()].hp_to_spawn[60] = True
				self.SpawnMobs(npc)
			if (nowHp < maxHp*0.4) and not self.npcobject[npc.getObjectId()].hp_to_spawn[40]:
				self.npcobject[npc.getObjectId()].hp_to_spawn[40] = True
				self.SpawnMobs(npc)
			if (nowHp < maxHp*0.3) and not self.npcobject[npc.getObjectId()].hp_to_spawn[30]:
				self.npcobject[npc.getObjectId()].hp_to_spawn[30] = True
				self.SpawnMobs(npc)
			if (nowHp < maxHp*0.2) and not self.npcobject[npc.getObjectId()].hp_to_spawn[20]:
				self.npcobject[npc.getObjectId()].hp_to_spawn[20] = True
				self.SpawnMobs(npc)
			if (nowHp < maxHp*0.1) and not self.npcobject[npc.getObjectId()].hp_to_spawn[10]:
				self.npcobject[npc.getObjectId()].hp_to_spawn[10] = True
				self.SpawnMobs(npc)
			if (nowHp < maxHp*0.05) and not self.npcobject[npc.getObjectId()].hp_to_spawn[5]:
				self.npcobject[npc.getObjectId()].hp_to_spawn[5] = True
				self.SpawnMobs(npc)

QUEST = Quest(-1,"Flouros","ai")

QUEST.addKillId(FLOUROS)

QUEST.addAttackId(FLOUROS)