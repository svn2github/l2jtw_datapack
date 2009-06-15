# Made by Surion 
import sys
from net.sf.l2j.gameserver.instancemanager       import InstanceManager
from net.sf.l2j.gameserver.model.entity          import Instance
from net.sf.l2j.gameserver.model.quest           import State
from net.sf.l2j.gameserver.model.quest           import QuestState
from net.sf.l2j.gameserver.model.quest.jython    import QuestJython as JQuest
from net.sf.l2j.gameserver.network               import SystemMessageId
from net.sf.l2j.gameserver.network.serverpackets import SystemMessage

qn = "Kamaloka_81"

KamalokaLevel = 81
InstanceTemplate = "Kamaloka_81.xml"
KamaLevels       = [81                     ]
KamaPartySize    = [9                      ]
KamaNPC          = [31340,32496            ]
KamaTemplate     = ["Kamaloka_81.xml"      ]
KamaMob          = [22503,22504,22505      ]
KamaMinion       = [29148,29149            ]
KamaBoss         = [29147                  ]
KamaBoss1        = [25622                  ]
KamaPorts        = [[22010,-174869,-10904] ]
ReturnPort       = [[42673,-47988,-797]    ]
dataIndex = 0

def getKamaIndex(level):
	if level == 81:
		return 0

def isPartySizeOk(player):
	members = player.getParty().getMemberCount()
	if members > KamaPartySize[dataIndex]:
		return False
	return True

def isWithinLevel(player):
	if player.getLevel() > KamaLevels[dataIndex]+5:
		return False
	if player.getLevel() < KamaLevels[dataIndex]-5:
		return False
	return True

def checkPrimaryConditions(player):
	if not player.getParty():
		player.sendPacket(SystemMessage(2101))
		return False
	if not player.getParty().isLeader(player):
		player.sendPacket(SystemMessage(2185))
		return False
	if not isPartySizeOk(player):
		player.sendPacket(SystemMessage(2102))
	if not isWithinLevel(player):
		sm = SystemMessage(SystemMessageId.C1_LEVEL_REQUIREMENT_NOT_SUFFICIENT)
		sm.addCharName(player)
		player.sendPacket(sm)
		return False
	for partyMember in player.getParty().getPartyMembers().toArray():
		if not partyMember.isInsideRadius(player, 500, False, False):
			sm = SystemMessage(SystemMessageId.C1_IS_IN_LOCATION_THAT_CANNOT_BE_ENTERED)
			sm.addCharName(partyMember)
			player.sendPacket(sm)
			return False
	return True

def checkNewInstanceConditions(player):
	#if not player.checkKamaDate():
	#	sm = SystemMessage(SystemMessageId.C1_MAY_NOT_REENTER_YET)
	#	sm.addCharName(player)
	#	player.sendPacket(sm)
	#	return False
	if not player.getParty().isLeader(player):
		player.sendPacket(SystemMessage(2185))
		return False
	party = player.getParty()
	if party == None:
		return True
	for partyMember in party.getPartyMembers().toArray():
		if not isWithinLevel(partyMember):
			sm = SystemMessage(SystemMessageId.C1_LEVEL_REQUIREMENT_NOT_SUFFICIENT)
			sm.addCharName(partyMember)
			player.sendPacket(sm)
			return False
	for partyMember in player.getParty().getPartyMembers().toArray():
		if not partyMember.isInsideRadius(player, 500, False, False):
			sm = SystemMessage(SystemMessageId.C1_IS_IN_LOCATION_THAT_CANNOT_BE_ENTERED)
			sm.addCharName(partyMember)
			player.sendPacket(sm)
			return False
	#	if not partyMember.checkKamaDate():
	#		sm = SystemMessage(SystemMessageId.C1_MAY_NOT_REENTER_YET)
	#		sm.addCharName(player)
	#		player.sendPacket(sm)
	#		return False
	return True

def getExistingInstanceId(player):
	instanceId = 0
	party = player.getParty()
	if party == None:
		return 0
	for partyMember in party.getPartyMembers().toArray():
		if partyMember.getInstanceId()!=0:
			instanceId = partyMember.getInstanceId()
	return instanceId

def teleportPlayer(self,player,teleto):
	player.setInstanceId(teleto.instanceId)
	player.teleToLocation(teleto.x,teleto.y,teleto.z)
	pet = player.getPet()
	if pet != None :
		pet.setInstanceId(teleto.instanceId)
		pet.teleToLocation(teleto.x,teleto.y,teleto.z)
	return

def exitInstance(player,tele):
	tele.x = ReturnPort[dataIndex][0]
	tele.y = ReturnPort[dataIndex][1]
	tele.z = ReturnPort[dataIndex][2]
	player.setInstanceId(0)
	player.teleToLocation(tele.x,tele.y,tele.z)
	pet = player.getPet()
	if pet != None :
		pet.setInstanceId(0)
		pet.teleToLocation(tele.x,tele.y,tele.z)

def checkKillProgress(npc,room):
	cont = True
	if room.npclist.has_key(npc):
		room.npclist[npc] = True
	for npc in room.npclist.keys():
		if room.npclist[npc] == False:
			cont = False
	return cont

def runStartRoom(self, world):
	world.status = 0
	world.startRoom = PyObject()
	world.startRoom.npclist = {}
	newNpc = self.addSpawn(KamaMob[1], 20620,-174887,-10921, 0, False, 0, False, world.instanceId)
	world.startRoom.npclist[newNpc] = False
	newNpc = self.addSpawn(KamaMob[1], 20593,-174815,-10921, 0, False, 0, False, world.instanceId)
	world.startRoom.npclist[newNpc] = False
	newNpc = self.addSpawn(KamaMob[0], 20599,-174957,-10921, 0, False, 0, False, world.instanceId)
	world.startRoom.npclist[newNpc] = False
	newNpc = self.addSpawn(KamaMob[1], 20493,-174885,-10921, 0, False, 0, False, world.instanceId)
	world.startRoom.npclist[newNpc] = False
	newNpc = self.addSpawn(KamaMob[1], 20496,-174759,-10921, 0, False, 0, False, world.instanceId)
	world.startRoom.npclist[newNpc] = False
	newNpc = self.addSpawn(KamaMob[1], 20497,-175015,-10921, 0, False, 0, False, world.instanceId)
	world.startRoom.npclist[newNpc] = False
	newNpc = self.addSpawn(KamaMob[1], 20374,-174887,-10921, 0, False, 0, False, world.instanceId)
	world.startRoom.npclist[newNpc] = False
	newNpc = self.addSpawn(KamaMob[1], 20397,-174815,-10921, 0, False, 0, False, world.instanceId)
	world.startRoom.npclist[newNpc] = False
	newNpc = self.addSpawn(KamaMob[1], 20395,-174957,-10921, 0, False, 0, False, world.instanceId)
	world.startRoom.npclist[newNpc] = False
	print "欲界-深淵迷宮：進入即時地區"

def runFirstRoom(self, world):
	world.status = 1
	world.FirstRoom = PyObject()
	world.FirstRoom.npclist = {}
	newNpc = self.addSpawn(KamaMob[2], 18287,-174887,-10658, 0, False, 0, False, world.instanceId)
	world.FirstRoom.npclist[newNpc] = False
	newNpc = self.addSpawn(KamaMob[2], 18163,-174763,-10658, 0, False, 0, False, world.instanceId)
	world.FirstRoom.npclist[newNpc] = False
	newNpc = self.addSpawn(KamaMob[2], 18038,-174889,-10658, 0, False, 0, False, world.instanceId)
	world.FirstRoom.npclist[newNpc] = False
	newNpc = self.addSpawn(KamaMob[2], 18162,-175011,-10658, 0, False, 0, False, world.instanceId)
	world.FirstRoom.npclist[newNpc] = False
	newNpc = self.addSpawn(KamaMob[2], 18160,-174885,-10658, 0, False, 0, False, world.instanceId)
	world.FirstRoom.npclist[newNpc] = False
	print "欲界-深淵迷宮：第一區域怪物清除"

def runSecondRoom(self, world):
	world.status = 2
	world.SecondRoom = PyObject()
	world.SecondRoom.npclist = {}
	newNpc = self.addSpawn(KamaBoss1[0], 15829,-174885,-10395, 0, False, 0, False, world.instanceId)  # Boss
	world.SecondRoom.npclist[newNpc] = False
	print "欲界-深淵迷宮：第二區域怪物清除"

def runThirdRoom(self, world):
	world.status = 3
	world.ThirdRoom = PyObject()
	world.ThirdRoom.npclist = {}
	newNpc = self.addSpawn(KamaBoss[0], 12050,-174887,-9951, 0, False, 0, False, world.instanceId)  # Boss
	world.ThirdRoom.npclist[newNpc] = False
	print "欲界-深淵迷宮：第三區域怪物清除"

def endInstance(self, world):
	world.status = 4
	world.startRoom = None
	world.FirstRoom = None
	world.SecondRoom = None
	world.ThirdRoom = None
	print "欲界-深淵迷宮：任務完成。（5分鐘後關閉即時地區）"
		
class PyObject:
	pass
	
class Quest (JQuest) :

	def __init__(self,id,name,desc):
		JQuest.__init__(self,id,name,desc)
		self.worlds = {}
		self.world_ids = []
		self.currentWorld = 0

	def onAdvEvent (self,event,npc,player) :
		return str(event)

	def onTalk (self,npc,player):
		if not checkPrimaryConditions(player):
			return
		tele = PyObject()
		dataIndex = getKamaIndex(KamalokaLevel)
		tele.x = KamaPorts[dataIndex][0]
		tele.y = KamaPorts[dataIndex][1]
		tele.z = KamaPorts[dataIndex][2]
		instanceId = getExistingInstanceId(player)
		if instanceId == 0:
			#brand new instance
			if not checkNewInstanceConditions(player):
				return
			instanceId = InstanceManager.getInstance().createDynamicInstance(KamaTemplate[dataIndex])
			if not self.worlds.has_key(instanceId):
				world = PyObject()
				world.rewarded = []
				world.instanceId = instanceId
				self.worlds[instanceId] = world
				self.world_ids.append(instanceId)
				self.currentWorld = instanceId
				instanceObj = InstanceManager.getInstance().getInstance(instanceId)
				instanceObj.setAllowSummon(False)
				instanceObj.setReturnTeleport(ReturnPort[dataIndex][0],ReturnPort[dataIndex][1],ReturnPort[dataIndex][2])
				print "欲界-深淵迷宮：使用 " + InstanceTemplate + " 即時地區：" + str(instanceId) + " 創造玩家：" + str(player.getName()) 
				runStartRoom(self, world)
				tele.instanceId = instanceId
				#player.setKamaDate()
				teleportPlayer(self,player,tele)
				party = player.getParty()
				if party != None:
					for partyMember in party.getPartyMembers().toArray():
						#partyMember.setKamaDate()
						teleportPlayer(self,partyMember,tele)
		else:
			#party already in kamaloka
			foundworld = False
			for worldid in self.world_ids:
				if worldid == instanceId:
					foundworld = True
			if not foundworld:
				player.sendPacket(SystemMessage.sendString("你的隊員已進入其它的即時地區。"))
				return
			tele.instanceId = instanceId
			teleportPlayer(self,player,tele)
		return

	def onAttack(self,npc,player,damage,isPet,skill):
		return
		
	def onKill(self,npc,player,isPet):
		npcId = npc.getNpcId()
		if self.worlds.has_key(npc.getInstanceId()):
			world = self.worlds[npc.getInstanceId()]
			if world.status == 0 :
				if npcId == 22503 :
					runFirstRoom(self, world)
			elif world.status == 1 :
				if checkKillProgress(npc, world.FirstRoom) :
					runSecondRoom(self, world)
			elif world.status == 2 :
				if checkKillProgress(npc, world.SecondRoom) :
					runThirdRoom(self, world)
			elif world.status == 3 :
				if npcId == 29147 :
					instanceObj = InstanceManager.getInstance().getInstance(self.currentWorld)
					instanceObj.setDuration(5)
					instanceObj.removeNpcs()
					endInstance(self, world)
		return

QUEST = Quest(-1, qn, "Kamaloka")

QUEST.addStartNpc(31340)

QUEST.addTalkId(32496)
QUEST.addTalkId(31340)

for mob in [22503,22504,22505,25622,29147,29148,29149]:
	QUEST.addKillId(mob)