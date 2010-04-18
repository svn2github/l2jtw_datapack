# By: evill33t & vital

from com.l2jserver.gameserver.instancemanager        import InstanceManager
from com.l2jserver.gameserver.model                  import L2ItemInstance
from com.l2jserver.gameserver.model.actor            import L2Summon
from com.l2jserver.gameserver.model.entity           import Instance
from com.l2jserver.gameserver.model.itemcontainer    import PcInventory
from com.l2jserver.gameserver.model.quest            import State
from com.l2jserver.gameserver.model.quest            import QuestState
from com.l2jserver.gameserver.model.quest.jython     import QuestJython as JQuest
from com.l2jserver.gameserver.network                import SystemMessageId
from com.l2jserver.gameserver.network.serverpackets  import InventoryUpdate
from com.l2jserver.gameserver.network.serverpackets  import MagicSkillUse
from com.l2jserver.gameserver.network.serverpackets  import NpcSay
from com.l2jserver.gameserver.network.serverpackets  import SystemMessage
from com.l2jserver.gameserver.network                import SystemMessageId
from com.l2jserver.gameserver.util                   import Util
from com.l2jserver.util                              import Rnd

qn = "HBTown"

debug = False

#NPCs
KANAF      = 32346  # 卡納夫
MOONSTONE  = 32343  # 月光石碑

#Mobs
AMARAKIS   = 22449  # 亞邁士康里 拷問專家
KEYMASTER  = 22361  # 鋼鐵之城 鑰匙守衛
KEYEVILEYE = 9714   # 惡魔刻紋鑰匙

#ReturnPort = [[13093,282097,-9699]]
dataIndex  = 0

class PyObject :
	pass

def checkConditions(player, new) :
	party = player.getParty()
	if not party :
		player.sendPacket(SystemMessage(SystemMessageId.NOT_IN_PARTY_CANT_ENTER))
		return False
	if not player.getParty().isLeader(player) :
		player.sendPacket(SystemMessage(SystemMessageId.ONLY_PARTY_LEADER_CAN_ENTER))
		return False
	if party and party.getMemberCount() < 2 :
		player.sendPacket(SystemMessage(SystemMessageId.PARTY_EXCEEDED_THE_LIMIT_CANT_ENTER))
		return False
	for partyMember in party.getPartyMembers().toArray():
		if not partyMember.getLevel() >= 78 :
			sm = SystemMessage(SystemMessageId.C1_LEVEL_REQUIREMENT_NOT_SUFFICIENT)
			sm.addCharName(partyMember)
			player.sendPacket(sm)
			return False
		if not Util.checkIfInRange(1000, player, partyMember, True) and new :
			sm = SystemMessage(SystemMessageId.C1_IS_IN_LOCATION_THAT_CANNOT_BE_ENTERED)
			sm.addCharName(partyMember)
			player.sendPacket(sm)
			return False
	return True

def teleportPlayer(self, player, teleto) :
	player.setInstanceId(teleto.instanceId)
	player.teleToLocation(teleto.x, teleto.y, teleto.z)
	pet = player.getPet()
	if pet != None :
		pet.setInstanceId(teleto.instanceId)
		pet.teleToLocation(teleto.x, teleto.y, teleto.z)
	return

def teleportParty(self, player, teleto, out = False) :
	if out : teleto.instanceId = 0
	else : teleto.instanceId = player.getInstanceId()
	if not player.isInParty() : 
		teleportPlayer(self, player, teleto)
		return
	for pm in player.getParty().getPartyMembers() :
		teleportPlayer(self, pm, teleto)

def enterInstance(self, player, template, teleto) :
	instanceId = 0
	party = player.getParty()
	#check for existing instances of party members
	if party :
		for partyMember in party.getPartyMembers().toArray() :
			st = partyMember.getQuestState(qn)
			if not st : st = self.newQuestState(partyMember)
			if partyMember.getInstanceId()!= 0 :
				instanceId = partyMember.getInstanceId()
				if debug: print "HBTown : found party member in instance:"+str(instanceId)
	else :
		if player.getInstanceId()!=0 :
			instanceId = player.getInstanceId()
	#existing instance
	if instanceId != 0 :
		if not checkConditions(player, False) :
			return 0
		foundworld = False
		for worldid in self.world_ids :
			if worldid == instanceId :
				foundworld = True
		if not foundworld:
			player.sendPacket(SystemMessage(SystemMessageId.ALREADY_ENTERED_ANOTHER_INSTANCE_CANT_ENTER))
			return 0
		teleto.instanceId = instanceId
		teleportPlayer(self, player, teleto)
		return instanceId
	#new instance
	else:
		if not checkConditions(player, True) :
			return 0
		instanceId = InstanceManager.getInstance().createDynamicInstance(template)
		if not instanceId in self.world_ids :
			world = PyObject()
			world.rewarded = []
			world.instanceId = instanceId
			self.worlds[instanceId] = world
			self.world_ids.append(instanceId)
			self.currentWorld = instanceId
			instanceObj = InstanceManager.getInstance().getInstance(instanceId)
			print "地獄舊市區：使用 " + template + " 即時地區：" +str(instanceId) + " 創造玩家：" + str(player.getName())
			runStartRoom(self, world)
		# teleports player
		teleto.instanceId = instanceId
		for partyMember in party.getPartyMembers().toArray() :
			teleportPlayer(self, partyMember, teleto)
		return instanceId
	return instanceId

def exitInstance(player, tele) :
	player.setInstanceId(0)
	player.teleToLocation(tele.x, tele.y, tele.z)
	pet = player.getPet()
	if pet != None :
		pet.setInstanceId(0)
		pet.teleToLocation(tele.x, tele.y, tele.z)
	return

def runStartRoom(self, world) :
	world.status = 0
	world.startRoom = PyObject()
	world.startRoom.npclist = {}
	newNpc = self.addSpawn(22361, 19936, 253360, -2033, 0, False, 0, False, world.instanceId)
	world.startRoom.npclist[newNpc] = False
	if debug : print "HBTown : hall spawned"

def runFirstRoom(self, world) :
	world.status = 1
	world.FirstRoom = PyObject()
	world.FirstRoom.npclist = {}
	newNpc = self.addSpawn(22449, 19936, 253360, -2033, 0, False, 0, False, world.instanceId)
	world.FirstRoom.npclist[newNpc] = False
	if debug : print "HBTown : spawned first room"

def runSecondRoom(self, world) :
	world.status = 2
	world.SecondRoom = PyObject()
	world.SecondRoom.npclist = {}
	newNpc = self.addSpawn(32343, 22838, 253206, -2021, 0, False, 0, False, world.instanceId)
	world.SecondRoom.npclist[newNpc] = False
	if debug : print "HBTown : spawned Second room"
  
def checkKillProgress(npc, room) :
	cont = True
	if room.npclist.has_key(npc) :
		room.npclist[npc] = True
	for npc in room.npclist.keys() :
		if room.npclist[npc] == False :
			cont = False
	if debug : print str(room.npclist)
	return cont

class Quest(JQuest) :

	def __init__(self, id, name, desc) :
		JQuest.__init__(self, id, name, desc)
		self.worlds = {}
		self.world_ids = []
		self.currentWorld = 0

	def onTalk (self, npc, player) :
		npcId = npc.getNpcId()
		st = player.getQuestState(qn)
		if not st :
			st = self.newQuestState(player)
		if npcId == 32346 :
			party = player.getParty()
			if not party:
				htmltext = "<html><body>卡納夫：<br>獨自進入市區，簡直就是自殺行為。與夥伴們一起吧。</body></html>" 
				return htmltext
			else :
				tele = PyObject()
				tele.x = 14205
				tele.y = 255451
				tele.z = -2025
				enterInstance(self, player, "HBTown.xml", tele)
		if npc.getInstanceId() in self.worlds:
			world = self.worlds[npc.getInstanceId()]
			if npcId == 32343 :
				if not st.getQuestItemsCount(KEYEVILEYE) >= 1 :
					htmltext = "<html><body>月光石碑：<br>任務道具不符。</body></html>" 
					return htmltext
				else :
					st.takeItems(KEYEVILEYE,1)
					tele = PyObject()
					tele.x = 13093
					tele.y = 282097
					tele.z = -9699
					instanceObj = InstanceManager.getInstance().getInstance(self.currentWorld)
					#instanceObj.setReturnTeleport(ReturnPort[dataIndex][0],ReturnPort[dataIndex][1],ReturnPort[dataIndex][2])
					instanceObj.setDuration(300000)
					return
		return ""

	def onAttack(self, npc, player, damage, isPet, skill) :
		npcId = npc.getNpcId()
		if self.worlds.has_key(npc.getInstanceId()) :
			world = self.worlds[player.getInstanceId()]
			if world.status == 0 :
				if npcId == 22361 :
					runFirstRoom(self, world)

	def onKill(self, npc, player, isPet) :
		npcId = npc.getNpcId()
		if self.worlds.has_key(npc.getInstanceId()) :
			world = self.worlds[npc.getInstanceId()]
			if world.status == 1 :
				if npcId == 22449 :
					runSecondRoom(self, world)
			return

QUEST = Quest(-1, qn, "hellbound")

QUEST.addStartNpc(32346)

QUEST.addTalkId(32346)
QUEST.addTalkId(32343)

for mob in [22361,22449] :
	QUEST.addAttackId(mob)

for mob in [22359,22360,22361,22449,22450] :
	QUEST.addKillId(mob)