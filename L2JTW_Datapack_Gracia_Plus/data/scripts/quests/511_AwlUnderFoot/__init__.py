# Quest 511 Awl Under Foot - Fortress - v1.1
# Made by CAMMARO for l2openProject
# Date: 10.23.2009

import sys
from java.lang                                      import System
from com.l2jserver                                  import Config
from com.l2jserver.gameserver                       import ThreadPoolManager
from com.l2jserver.gameserver.datatables            import NpcTable
from com.l2jserver.gameserver.datatables            import SpawnTable
from com.l2jserver.gameserver.instancemanager       import FortManager
from com.l2jserver.gameserver.instancemanager       import InstanceManager
from com.l2jserver.gameserver.model.actor.instance  import L2PcInstance
from com.l2jserver.gameserver.model.entity          import Fort
from com.l2jserver.gameserver.model.entity          import Instance
from com.l2jserver.gameserver.model.quest           import State
from com.l2jserver.gameserver.model.quest           import QuestState
from com.l2jserver.gameserver.model.quest.jython    import QuestJython as JQuest
from com.l2jserver.gameserver.network               import SystemMessageId
from com.l2jserver.gameserver.network.serverpackets import SystemMessage
from com.l2jserver.gameserver.util                  import Util
from com.l2jserver.util                             import Rnd

qn = "511_AwlUnderFoot"

QuestId = 511
QuestName = "AwlUnderFoot"
QuestDesc = "Fortress Dungeon"

#NPC
WARDEN = [ 35666, 35698, 35735, 35767, 35804, 35835, 35867, 35904, 35936, 35974, 36011, 36043, 36081, 36118, 36149, 36181, 36219, 36257, 36294, 36326, 36364 ]
ESCAPE = [ 32496 ]

#MONSTER TO KILL -- Only last 3 Raids (lvl ordered) from 136, drop DL_MARK
RAIDS1 = [ 25572, 25575, 25578 ]
RAIDS2 = [ 25579, 25582, 25585, 25588 ]
RAIDS3 = [ 25589, 25592, 25593 ]

#QUEST ITEMS
DL_MARK = 9797

#REWARDS
KNIGHT_EPALUETTE = 9912

#MESSAGES
default = "<html><body>收容所管理人：<br>目前沒有執行任務，或條件不符。</body></html>"
nolvl = "<html><body>收容所管理人：<br>我很感謝冒險家您想要協助的心意，但我也是身為要塞的一員，可不希望讓實力不符的血盟成員陷入險境。<br>如此之類的管理責任也是我的職務。<br>在接任這職務之前，我也曾是個叱吒風雲的冒險家。<br以前輩的立場來看，冒險家您的實力還不足接任征討任務。<br>去磨練實力後再來找我吧。<br>(只有等級60以上才可以執行的任務。)</body></html>"
noitem = "<html><body>收容所管理人：<br>你已經回來嗎？<br1>你做不到了我的要求。你沒有收容所罪犯首領的標章。</body></html>"
wrongfortress = "<html><body>收容所管理人：<br>(擁有此要塞的血盟之血盟成員才能執行的任務。)</body></html>"
noclan = "<html><body>收容所管理人：<br>你是誰？好像不在血盟成員的名單內...<br>(擁有此要塞的血盟之血盟成員才能執行的任務。)</body></html>"
finish = "<html><body>收容所管理人：<br>啊，我明白。果然，我沒有看錯人...<br>謝謝你為這裡做的一切。<br>如果你想再次伸出援手的話，我們會非常感激。<br>祝你旅途愉快！</body></html>"

class PyObject:
	pass

def Reward(st) :
	if st.getState() == State.STARTED :
		if st.getRandom(9) > 5 : #No retail info about drop quantity. Guesed 1-2. 60% for 1 and 40% for 2 
			st.giveItems(DL_MARK, int(2 * Config.RATE_QUEST_DROP))
			st.playSound("ItemSound.quest_itemget")
		elif st.getRandom(9) < 6  :
			st.giveItems(DL_MARK, int(1 * Config.RATE_QUEST_DROP))
			st.playSound("ItemSound.quest_itemget") 

def checkConditions(player, new):
	party = player.getParty()
	if not party:
		player.sendPacket(SystemMessage.sendString("You are not currently in a party, so you cannot enter."))
		return False
	for partyMember in party.getPartyMembers().toArray():
		if not partyMember.getLevel() >= 60:
			player.sendPacket(SystemMessage.sendString(partyMember.getName() + "s level requirement is not sufficient and cannot be entered."))
			return False
		if not Util.checkIfInRange(1000, player, partyMember, True) and new:
			player.sendPacket(SystemMessage.sendString(partyMember.getName() + " is in a location which cannot be entered, therefore it cannot be processed."))
			return False
	return True

def teleportplayer(self, player, teleto):
	player.setInstanceId(teleto.instanceId)
	player.teleToLocation(teleto.x, teleto.y, teleto.z)
	pet = player.getPet()
	if pet != None :
		pet.setInstanceId(teleto.instanceId)
		pet.teleToLocation(teleto.x, teleto.y, teleto.z)
	return

def enterInstance(self, player, template, teleto):
	instanceId = 0
	if not checkEnter(self, player) :
		return 0
	party = player.getParty()
	#check for other instances of party members
	if party :
		for partyMember in party.getPartyMembers().toArray():
			st = partyMember.getQuestState(qn)
			if st :
				id = st.getState()
				if not id == State.STARTED :
					player.sendPacket(SystemMessage.sendString(partyMember.getName() + " not take Awl under foot quest."))
					return 0
			else :
				player.sendPacket(SystemMessage.sendString(partyMember.getName() + " not take Awl under foot quest."))
				return 0
			if partyMember.getInstanceId() != 0:
				instanceId = partyMember.getInstanceId()
				if debug: print "Rim Pailaka: found party member in instance:" + str(instanceId)
		else :
			if player.getInstanceId() != 0:
				instanceId = player.getInstanceId()
	#exising instance
	if instanceId != 0:
		if not checkConditions(player, False):
			return 0
		foundworld = False
		for worldid in self.world_ids:
			if worldid == instanceId:
				foundworld = True
		if not foundworld:
			player.sendPacket(SystemMessage.sendString("You have entered another instance zone, therefore you cannot enter corresponding dungeon."))
			return 0
		teleto.instanceId = instanceId
		teleportplayer(self, player, teleto)
		return instanceId
	#new instance
	else:
		if not checkConditions(player, True):
			return 0
		instanceId = InstanceManager.getInstance().createDynamicInstance(template)
		if not instanceId in self.world_ids:
			world = PyObject()
			world.rewarded = []
			world.instanceId = instanceId
			self.worlds[instanceId] = world
			self.world_ids.append(instanceId)
			self.currentWorld = instanceId
			print "Rim Pailaka: started. " + template + " Instance: " + str(instanceId) + " created by player: " + str(player.getName())
			self.saveGlobalQuestVar("511_NextEnter", str(System.currentTimeMillis() + 14400000))
			raidid = 1
			spawnRaid(self, world, raidid)
		#teleports player
		teleto.instanceId = instanceId
		for partyMember in party.getPartyMembers().toArray():
			st = partyMember.getQuestState(qn)
			st.set("cond", "1")
			playerName = partyMember.getName()
			teleportplayer(self, partyMember, teleto)
		return instanceId
	return instanceId

def exitInstance(self, npc) :
	if self.worlds.has_key(npc.getInstanceId()):
		world = self.worlds[npc.getInstanceId()]
		instanceObj = InstanceManager.getInstance().getInstance(self.currentWorld)
		instanceObj.setDuration(60000)
		instanceObj.removeNpcs()

def spawnRaid(self, world, raid) :
	if raid == 1 :
		spawnid = RAIDS1[Rnd.get(0, 2)]
	elif raid == 2 :
		spawnid = RAIDS2[Rnd.get(0, 3)]
	elif raid == 3 :
		spawnid = RAIDS3[Rnd.get(0, 2)]
	spawnedNpc = self.addSpawn(spawnid, 12161, -49144, -3000, 0, False, 0, False, world.instanceId)

def checkEnter(self, player) :
	entertime = self.loadGlobalQuestVar("511_NextEnter")
	if entertime.isdigit() :
		remain = long(entertime) - System.currentTimeMillis()
		if remain <= 0 :
			return True
		else :
			timeleft = remain / 60000
			player.sendPacket(SystemMessage.sendString("Cant enter now. Check back in: " + str(timeleft) + " min."))
			return False
	else :
		return True

def checkLeader(player) :
	party = player.getParty()
	if not party:
		player.sendPacket(SystemMessage.sendString("為了進入收容所，得先組織2人以上的隊伍才行。"))
		return False
	elif not player.getParty().isLeader(player):
		player.sendPacket(SystemMessage(2185))
		return False
	else :
		return True

class Quest (JQuest) :
	def __init__(self, id, name, descr):
		JQuest.__init__(self, id, name, descr)
		self.questItemIds = [DL_MARK]
		self.worlds = {}
		self.world_ids = []
		self.currentWorld = 0

	def onAdvEvent (self, event, npc, player) :  
		htmltext = event
		st = player.getQuestState(qn)
		cond = st.getInt("cond")
		if event == "warden_yes.htm" :
			if cond == 0:
				st.set("cond", "1")
				st.setState(State.STARTED)
				st.playSound("ItemSound.quest_accept")
			else:
				htmltext = event
		elif event == "quit" :
			htmltext = finish
			st.playSound("ItemSound.quest_finish")
			st.exitQuest(1)
		elif event == "continue" :
			st.set("cond", "1")
			htmltext = "warden_yes.htm"
		elif event == "warden_no.htm" :
			st.set("cond", "0")
			htmltext = "warden_no.htm"
		elif event == "default" :
			htmltext = default
		elif event == "rumor" :
			htmltext = "rumor.htm"
		elif event == "leave" :
			htmltext = ""
			if checkLeader(player) :
				exitInstance(self, npc)
				htmltext = "Instance deleted!"
		elif event == "status" :
			entertime = self.loadGlobalQuestVar("511_NextEnter")
			if entertime.isdigit() :
				remain = long(entertime) - System.currentTimeMillis()
				if remain <= 0 :
					text = "The dungeon is empty and you can enter now."
				else :
					timeleft = remain / 60000
					if timeleft > 180 :
						text = "The dungeon is under other party control. Wait for them to get out and try again."
					else :
						text = "You cant enter now. Check again in: " + str(timeleft) + " min."
			else :
				text = "The dungeon is empty and you can enter now."
				htmltext = st.showHtmlFile("status.htm").replace("%text%", text)
		elif event == "enter" :
			if checkLeader(player) :
				tele = PyObject()
				tele.x = 11740
				tele.y = -49148
				tele.z = -3000
				enterInstance(self, player, "RimPailakaFort.xml", tele)
				htmltext = ""
			else :
				htmltext = ""
		else :
			htmltext = ""
		return htmltext

	def onTalk (self, npc, player):
		htmltext = default
		st = player.getQuestState(qn)
		FORT = npc.getFort().getOwnerClan()
		CLAN = player.getClan()
		if CLAN :
			CLANID = CLAN.getClanId()
		else :
			htmltext = noclan
			return htmltext
		if FORT :
			FORTID = FORT.getClanId()
			if not int(FORTID) == int(CLANID) :
				htmltext = wrongfortress
				return htmltext
		else :
			htmltext = wrongfortress
			return htmltext
		if st :
			npcId = npc.getNpcId()
			id = st.getState()
			if id == State.CREATED :
				st.set("cond", "0")
			cond = st.getInt("cond")
			if npcId in WARDEN and cond == 0 :
				if player.getLevel() >= 60 :
					htmltext = "warden_quest.htm"
				else :
					htmltext = nolvl
					st.exitQuest(1)
			elif npcId in WARDEN and id == State.STARTED and cond > 0 :
				count = st.getQuestItemsCount(DL_MARK)
				if cond == 1 and count > 0 :
					htmltext = "warden_exchange.htm"
					st.takeItems(DL_MARK, count)
					st.giveItems(KNIGHT_EPALUETTE, count * 136)
				elif cond == 1 and count == 0 :
					htmltext = "warden_yes.htm"
		return htmltext

	def onKill(self, npc, player, isPet) :
		npcId = npc.getNpcId()
		partyMembers = [player]
		party = player.getParty()
		if npc.getInstanceId() in self.worlds:
			world = self.worlds[npc.getInstanceId()]
		if npcId in RAIDS3 :
			#If is party, give item to all party member who have quest
			if party :
				partyMembers = party.getPartyMembers().toArray()
				for player in partyMembers :
					st = player.getQuestState(qn)
					if st :
						Reward(st)
			else :
				st = player.getQuestState(qn)
				if st :
					Reward(st)
			if self.worlds.has_key(npc.getInstanceId()):
				world = self.worlds[npc.getInstanceId()]
				instanceObj = InstanceManager.getInstance().getInstance(self.currentWorld)
				instanceObj.setDuration(60000)
				instanceObj.removeNpcs()
		elif npcId in RAIDS1 :
			spawnRaid(self, world, 2)
		elif npcId in RAIDS2 :
			spawnRaid(self, world, 3)
		return

	def onFirstTalk(self, npc, player) :
		npcId = npc.getNpcId()
		if npcId in WARDEN :
			htmltext = "ForressWarden.htm"
		return htmltext

# Quest class and state definition
QUEST = Quest(QuestId, str(QuestId) + "_" + QuestName, QuestDesc)

for npcId in WARDEN:
	QUEST.addStartNpc(npcId)
	QUEST.addTalkId(npcId)
	QUEST.addFirstTalkId(npcId)

for mobId in RAIDS1 :
	QUEST.addKillId(mobId)
for mobId in RAIDS2 :
	QUEST.addKillId(mobId)
for mobId in RAIDS3 :
	QUEST.addKillId(mobId)