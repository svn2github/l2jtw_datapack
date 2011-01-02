# author: Psycho(killer1888) / L2jFree
# By: evill33t & vital
# Update by pmq 10-07-2010
import sys
from java.lang                                       import System
from com.l2jserver.gameserver.ai                     import CtrlIntention
from com.l2jserver.gameserver.datatables             import DoorTable
from com.l2jserver.gameserver.datatables             import ItemTable
from com.l2jserver.gameserver.datatables             import SpawnTable
from com.l2jserver.gameserver.instancemanager        import HellboundManager
from com.l2jserver.gameserver.instancemanager        import InstanceManager
from com.l2jserver.gameserver.model                  import L2ItemInstance
from com.l2jserver.gameserver.model.actor            import L2Summon
from com.l2jserver.gameserver.model.entity           import Instance
from com.l2jserver.gameserver.model.itemcontainer    import PcInventory
from com.l2jserver.gameserver.model.quest            import State
from com.l2jserver.gameserver.model.quest            import QuestState
from com.l2jserver.gameserver.model.quest.jython     import QuestJython as JQuest
from com.l2jserver.gameserver.network                import SystemMessageId
from com.l2jserver.gameserver.network.serverpackets  import CreatureSay
from com.l2jserver.gameserver.network.serverpackets  import InventoryUpdate
from com.l2jserver.gameserver.network.serverpackets  import MagicSkillUse
from com.l2jserver.gameserver.network.serverpackets  import NpcSay
from com.l2jserver.gameserver.network.serverpackets  import SystemMessage
from com.l2jserver.gameserver.util                   import Util
from com.l2jserver.util                              import Rnd

qn = "HBTown"

debug = False

# NPCs
KANAF          = 32346  # 卡納夫
PRISONER       = 32358  # 原住民俘虜
STELE          = 32343  # 月光石碑

# Mobs
AMASKARI       = 22449  # 亞邁士康里 拷問專家
KEYMASTER      = 22361  # 鋼鐵之城 鑰匙守衛
GUARD          = 22359  # 市區警衛兵
NATIVE         = 22450  # 被拷問的原住民
LIST = [22359, 22360]   # 市區警衛兵 / 市區巡邏兵

# Items
KEY            = 9714   # 惡魔刻紋鑰匙

AMASKARI_TEXT = ["蠢材，死亡等待著你！","小人，真讓人驚奇","首先，我殺了你來換取當地人自由","主人巴列斯不會很高興","原來是你..."]

LOCS = [
		[14479,250398,-1940],
		[15717,252399,-2013],
		[19800,256230,-2091],
		[17214,252770,-2015],
		[21967,254035,-2010]
]

ReturnPort = [[16278,283633,-9709]]

dataIndex  = 0

class PyObject :
	pass

def callGuards(self,npc,player,world):
	guardList = []
	newNpc = self.addSpawn(GUARD,npc.getX()+50,npc.getY(),npc.getZ(),0,False,0,10,world.instanceId)
	guardList.append(newNpc)
	newNpc = self.addSpawn(GUARD,npc.getX()-50,npc.getY(),npc.getZ(),0,False,0,10,world.instanceId)
	guardList.append(newNpc)
	newNpc = self.addSpawn(GUARD,npc.getX(),npc.getY()+50,npc.getZ(),0,False,0,10,world.instanceId)
	guardList.append(newNpc)
	newNpc = self.addSpawn(GUARD,npc.getX(),npc.getY()-50,npc.getZ(),0,False,0,10,world.instanceId)
	guardList.append(newNpc)
	for mob in guardList:
		mob.setRunning()
		mob.addDamageHate(player, 0, 999)
		mob.getAI().setIntention(CtrlIntention.AI_INTENTION_ATTACK, player)

def autochat(npc,text) :
	if npc: npc.broadcastPacket(NpcSay(npc.getObjectId(),0,npc.getNpcId(),text))
	return

def dropItem(player,npc,itemId,count):
	ditem = ItemTable.getInstance().createItem("Loot", itemId, count, player)
	ditem.dropMe(npc, npc.getX(), npc.getY(), npc.getZ()); 

def checkCondition(player):
	if not player.getLevel() >= 78:
		sm = SystemMessage.getSystemMessage(SystemMessageId.C1_LEVEL_REQUIREMENT_NOT_SUFFICIENT)
		sm.addCharName(player)
		player.sendPacket(sm)
		return False
	return True

def teleportplayer(self,player,teleto):
	player.setInstanceId(teleto.instanceId)
	player.teleToLocation(teleto.x, teleto.y, teleto.z)
	pet = player.getPet()
	if pet != None :
		pet.setInstanceId(teleto.instanceId)
		pet.teleToLocation(teleto.x, teleto.y, teleto.z)
	return

def enterInstance(self,player,template,teleto,quest):
	instanceId = 0
	if not checkCondition(player):
		return instanceId
	party = player.getParty()
	if party != None :
		channel = party.getCommandChannel()
		if channel != None :
			members = channel.getMembers().toArray()
		else:
			members = party.getPartyMembers().toArray()
	else:
		members = []
	#check for exising instances of party members or channel members
	for member in members :
		if member.getInstanceId()!= 0 :
			instanceId = member.getInstanceId()
	#exising instance
	if instanceId != 0:
		foundworld = False
		for worldid in self.world_ids:
			if worldid == instanceId:
				foundworld = True
		if not foundworld:
			player.sendPacket(SystemMessage.sendString("你的隊員已進入其它的即時地區。"))
			return 0
		teleto.instanceId = instanceId
		teleportplayer(self,player,teleto)
		return instanceId
	else:
		instanceId = InstanceManager.getInstance().createDynamicInstance(template)
		if not self.worlds.has_key(instanceId):
			world = PyObject()
			world.rewarded=[]
			world.instanceId = instanceId
			world.instanceFinished = False
			world.guardsSpawned = False
			world.status = 0
			self.worlds[instanceId] = world
			self.world_ids.append(instanceId)
			print "地獄舊市區：使用 " + template + "  即時地區：" +str(instanceId) + " 創造玩家：" + str(player.getName())
			newNpc = self.addSpawn(AMASKARI,19496,253125,-2030,0,False,0,False,instanceId)
			quest.amaskari = newNpc
			quest.amaskariattacked = False
			loc = LOCS[Rnd.get(len(LOCS))]
			newNpc = self.addSpawn(KEYMASTER,loc[0],loc[1],loc[2],0,False,0,False,instanceId)
			quest.keymaster = newNpc
			quest.startQuestTimer("keySpawn1", 300000, None, None)
			quest.keymasterattacked = False
		# teleports player
		teleto.instanceId = instanceId
		teleportplayer(self,player,teleto)
		return instanceId
	return instanceId

def exitInstance(player, tele):
	player.setInstanceId(0)
	player.teleToLocation(tele.x, tele.y, tele.z)
	pet = player.getPet()
	if pet != None :
		pet.setInstanceId(0)
		pet.teleToLocation(tele.x, tele.y, tele.z)

class Quest(JQuest) :

	def __init__(self, id, name, descr):
		JQuest.__init__(self, id, name, descr)
		self.worlds = {}
		self.world_ids = []
		self.Slaves = {}
		self.currentWorld = 0
		self.Lock = 0
		self.NATIVELock = 0
		self.hellboundLevel = 0
		self.trustp = 0
		try:
			self.trustp = int(self.loadGlobalQuestVar("trust10p"))
		except:
			pass
		self.saveGlobalQuestVar("trust10p", str(self.trustp))
		if HellboundManager.getInstance().getLevel() == 10: self.startQuestTimer("CheckTrustP", 60000, None, None, True)

	def onAdvEvent (self, event, npc, player) :
		if event == "CheckTrustP":
			if self.trustp >= 500000:
				HellboundManager.getInstance().changeLevel(11)
				self.trustp = 0
				self.saveGlobalQuestVar("trust10p", str(self.trustp))
				self.cancelQuestTimers("CheckTrustP")
		elif event == "keySpawn1" or event == "keySpawn2":
			self.startQuestTimer("keySpawn2", 300000, None, None)
			loc = LOCS[Rnd.get(len(LOCS))]
			self.keymaster.teleToLocation(loc[0],loc[1],loc[2])
			if event == "keySpawn1":
				self.startQuestTimer("keySpawn2", 300000, None, None)
			else:
				self.startQuestTimer("keySpawn1", 300000, None, None)
		elif event == "decayNpc":
			npc.decayMe()
		elif event == "NATIVESay":
			world = self.worlds[npc.getInstanceId()]
			npc.broadcastPacket(NpcSay(22450, 0, 22450, "我會...將...全部...打死...！"))
			npc.broadcastPacket(NpcSay(22450, 0, 22450, "我會...將...全部...打死...！"))
			npc.broadcastPacket(NpcSay(22450, 0, 22450, "我會...將...全部...打死...！"))
		elif event == "freeprisoner":
			world = self.worlds[npc.getInstanceId()]
			sayNpc = npc.getObjectId()
			npc.broadcastPacket(NpcSay(sayNpc, 0, npc.getNpcId(), "多謝幫助！看守者馬上就要來了快躲起來..."))
			self.startQuestTimer("decayNpc", 15000, npc, None)
			chance = Rnd.get(100)
			if chance <= 30:
				if not world.guardsSpawned:
					callGuards(self,npc,player,world)
					world.guardsSpawned = True
					npc.broadcastPacket(NpcSay(22359, 0, 22359, "發.現.入.侵.者...！"))
					hellboundLevel = HellboundManager.getInstance().getLevel()
					if hellboundLevel == 10:
						HellboundManager.getInstance().increaseTrust(50)
						self.trustp += 50
						self.saveGlobalQuestVar("trust10p", str(self.trustp))
		elif event == "key":
			world = self.worlds[npc.getInstanceId()]
			if not world.instanceFinished:
				key = player.getInventory().getItemByItemId(KEY);
				if key != None:
					world.instanceFinished = True
					player.destroyItemByItemId("Moonlight Stone", KEY, 1, player, True);
					instance = InstanceManager.getInstance().getInstance(npc.getInstanceId())
					if instance != None:
						instance.setDuration(30000)
						instance.setReturnTeleport(ReturnPort[dataIndex][0],ReturnPort[dataIndex][1],ReturnPort[dataIndex][2])
				else :
					return "32343-2.htm"
			else :
				return "32343-1.htm"
		return

	def onSpawn(self, npc):
		npcId = npc.getNpcId()
		objId = npc.getObjectId()
		if npcId == AMASKARI:
			self.Prisonslaves = []
			self.Slaves[objId] = []
			self.Slaves[objId].append("noSlaves")
			xx, yy, zz = npc.getX(), npc.getY(), npc.getZ()
			self.Slaves[objId] = []
			for i in range(9):
				offsetX = xx + (50 - Rnd.get(250))
				offsetY = yy + (50 - Rnd.get(250))
				newSlave = self.addSpawn(22450, offsetX, offsetY, zz, 0, False, 0, False, npc.getInstanceId())
				newSlave.setRunning()
				newSlave.getAI().setIntention(CtrlIntention.AI_INTENTION_FOLLOW, npc)
				self.Slaves[objId].append(newSlave)

	def onTalk (self, npc, player) :
		npcId = npc.getNpcId()
		st = player.getQuestState(qn)
		if not st :
			st = self.newQuestState(player)
		hellboundLevel = HellboundManager.getInstance().getLevel()
		if hellboundLevel < 10: return "<html><body>卡納夫：<br>你是誰？...<br>快滾開，我不想和你說話！</body></html>"
		if npcId == 32346 :
			party = player.getParty()
			if not party:
				return "32346-0.htm"
			else :
				tele = PyObject()
				tele.x = 14205
				tele.y = 255451
				tele.z = -2025
				enterInstance(self, player, "HBTown.xml", tele, self)
				party = player.getParty()
				if party :
					for partyMember in party.getPartyMembers().toArray() :
						st = partyMember.getQuestState(qn)
						if not st : st = self.newQuestState(partyMember)
		return

	def onFirstTalk (self, npc, player) :
		world = self.worlds[npc.getInstanceId()]
		npcId = npc.getNpcId()
		party = player.getParty()
		if party :
			for partyMember in party.getPartyMembers().toArray() :
				st = partyMember.getQuestState(qn)
				if not st : st = self.newQuestState(partyMember)
				if npcId == STELE :
					return "32343.htm" 

	def onAttack(self, npc, player, damage, isPet, skill):
		st = player.getQuestState(qn)
		npcId = npc.getNpcId()
		objId = npc.getObjectId()
		maxHp = npc.getMaxHp()
		nowHp = npc.getStatus().getCurrentHp()
		if npcId == AMASKARI:
			if (nowHp < maxHp * 0.1):
				if self.Lock == 0:
					npc.broadcastPacket(CreatureSay(objId, 0, npc.getName(), "我將讓大家和我一樣的痛苦！"))
					self.Lock = 1
		elif npcId == KEYMASTER :
			if not self.keymasterattacked:
				self.keymasterattacked = True
				self.amaskari.teleToLocation(player.getX(),player.getY(),player.getZ())
				self.amaskari.setTarget(player)
				objId = self.amaskari.getObjectId()
				self.amaskari.broadcastPacket(NpcSay(objId, 0, self.amaskari.getNpcId(), AMASKARI_TEXT[Rnd.get(len(AMASKARI_TEXT))]))
				self.startQuestTimer("NATIVESay", 5000, npc, None)
		elif npcId == NATIVE :
			if self.NATIVELock == 0:
				npc.broadcastPacket(CreatureSay(objId, 0, npc.getName(), "嘿...好痛...好痛...啊！"))
				self.NATIVELock = 1
		if self.worlds.has_key(npc.getInstanceId()):
			world = self.worlds[npc.getInstanceId()]
		return

	def onKill(self, npc, player, isPet):
		npcId = npc.getNpcId()
		objId = npc.getObjectId()
		if npcId == KEYMASTER:
			HellboundManager.getInstance().increaseTrust(250)
			self.trustp += 250
			self.saveGlobalQuestVar("trust10p", str(self.trustp))
			chance = Rnd.get(100)
			if chance <= 75:
				npc.broadcastPacket(NpcSay(objId, 0, npc.getNpcId(), "我的天呀！我.的..鑰...匙......."))
				dropItem(player,npc,9714,1)
			else:
				npc.broadcastPacket(NpcSay(objId, 0, npc.getNpcId(), "你永遠都不能得到我的..鑰匙！"))
		elif npcId == AMASKARI:
			if HellboundManager.getInstance().getLevel() <= 11:
				HellboundManager.getInstance().increaseTrust(500)
				self.trustp += 500
				self.saveGlobalQuestVar("trust10p", str(self.trustp))
			try:
				if self.Slaves[objId][0] != "noSlaves":
					for i in self.Slaves[objId]:
						try:
							i.setIsInvul(1)
							i.broadcastPacket(CreatureSay(i.getObjectId(), 0, i.getName(), "謝謝你救我！"))
							i.decayMe()
						except:
							pass
					self.Slaves[objId] = []
			except:
				pass
		elif npcId == NATIVE:
			HellboundManager.getInstance().increaseTrust(-10)
			self.trustp -= 10
			self.saveGlobalQuestVar("trust10p", str(self.trustp))
		elif npcId == PRISONER:
			HellboundManager.getInstance().increaseTrust(-10)
			self.trustp -= 10
			self.saveGlobalQuestVar("trust10p", str(self.trustp))
		elif npcId in LIST:
			HellboundManager.getInstance().increaseTrust(20)
			self.trustp += 20
			self.saveGlobalQuestVar("trust10p", str(self.trustp))
		if self.worlds.has_key(npc.getInstanceId()):
			world = self.worlds[npc.getInstanceId()]
		return

QUEST = Quest(-1, qn, "hellbound")

QUEST.addStartNpc(32346)
QUEST.addStartNpc(32358)

QUEST.addFirstTalkId(32343)

QUEST.addTalkId(32346)
QUEST.addTalkId(32343)
QUEST.addTalkId(32358)

for mob in [22361,22449,22450] :
	QUEST.addAttackId(mob)

for mob in [22359,22360,22361,22449,22450] :
	QUEST.addKillId(mob)