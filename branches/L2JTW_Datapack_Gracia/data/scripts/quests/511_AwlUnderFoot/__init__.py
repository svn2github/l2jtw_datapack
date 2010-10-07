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
warden_exchange = "<html><body>收容所管理人：<br>你已經處理掉地下怪物收容所罪犯了嗎？幹得好！<br>謝謝您的幫助，解除了對我們的威脅。<br>這裡是騎士的肩章的承諾。<br>你可以向魔法師交換要塞血盟補給品。<br>...<br>您想繼續挑戰嗎？<br><br><a action=\"bypass -h Quest 511_AwlUnderFoot continue\">說想繼續</a><br><a action=\"bypass -h Quest 511_AwlUnderFoot quit\">我要放棄</a></body></html>"
warden_no = "<html><body>收容所管理人：<br>那您先準備一下，回來時，請來找我吧...</body></html>"
default = "<html><body>收容所管理人：<br>目前沒有執行任務，或條件不符。</body></html>"
warden_ask = "<html><body>收容所管理人：<br>哦...<br>因為長久歲月被放置的緣故，過去被囚禁的怪物-地下怪物收容所的罪犯-們，目前各自形成勢力。<br>在地下怪物收容所獄內，怪物們使用只有他們能夠接近、移動的秘密通道，而這些秘密通道如蜘蛛網般的錯綜連接。<br>還聽說這些通道也與地上怪物們掌控的地區連接在一起呢。<br>如此掌握要塞地下世界之主導權的勢力組織，是由過去被囚禁的怪物們所組成的，而且還存在自定的階級；聽說城堡地下怪物收容所是由更高地位的魔物們掌握的，而要塞地下則由較低地位的魔物們佔領。<br><a action=\"bypass -h Quest 511_AwlUnderFoot warden_ask1\">之所以地下怪物收容所內怪物們不斷出沒，就算再怎麼征討...</a></body></html>"
warden_ask1 = "<html><body>收容所管理人：<br>沒錯。<br>所以我們才會向血盟的冒險家們求助...<br>當然，聽說高等職位的戰略家與學者、魔法師們，正在尋求可永久性解決這問題的方法。<br>但是因為勢力各異的城堡間之協力成了問題，所以進行的不太順利。<br>總之，在解決方案出來之前，只好繼續去征討了。<br><a action=\"bypass -h Quest 511_AwlUnderFoot warden_ask2\">我該做些什麼呢？</a></body></html>"
warden_ask2 = "<html><body>收容所管理人：<br>過去在這地下怪物收容所的魔物們和征討部隊之間，曾有過大規模的戰鬥。<br>真是場激烈的戰鬥...<br>雙方都死傷慘重。<br>所以感到恐懼的魔物們也不敢輕易的將城地下怪物收容所當成自家般的進出了。<br>不過近來要塞地下怪物收容所內持續有流入曾是過去罪犯的強悍魔物，以三人組組成為一群的地下怪物收容所罪犯族群。<br>雖不明緣由，但一定是在搞什麼陰謀吧。<br>就麻煩冒險家您將<font color=\"LEVEL\">三人組</font>都擊退後，擊倒組成地下怪物收容所罪犯族群的所有魔物吧。<br>將font color=\"LEVEL\">最後一組</font>的首領怪物殺死後帶回<font color=\"LEVEL\">收容所罪犯首領的標章</font>的話，我就支付騎士肩章給您。<br>利用騎士肩章可以向支援隊長交換要塞血盟補給品。<br>對了，還有...<br>到目前為止得到報告的收容所罪犯首領有<font color=\"LEVEL\">被放逐的巴里達、大將軍卡拉隆、掠食者凱爾格</font>。<br>可透過我進入要塞地下怪物收容所。<br>那就拜託您了。<br><a action=\"bypass -h Quest 511_AwlUnderFoot status\">詢問要塞地下怪物收容所情況</a></body></html>"
nolvl = "<html><body>收容所管理人：<br>我很感謝冒險家您想要協助的心意，但我也是身為要塞的一員，可不希望讓實力不符的血盟成員陷入險境。<br>如此之類的管理責任也是我的職務。<br>在接任這職務之前，我也曾是個叱吒風雲的冒險家。<br以前輩的立場來看，冒險家您的實力還不足接任征討任務。<br>去磨練實力後再來找我吧。<br>(只有等級60以上才可以執行的任務。)</body></html>"
noitem = "<html><body>收容所管理人：<br>你已經回來嗎？<br1>你做不到了我的要求。你沒有收容所罪犯首領的標章。</body></html>"
wrongfortress = "<html><body>收容所管理人：<br>(擁有此要塞的血盟之血盟成員才能執行的任務。)</body></html>"
noclan = "<html><body>收容所管理人：<br>你是誰？好像不在血盟成員的名單內...<br>(擁有此要塞的血盟之血盟成員才能執行的任務。)</body></html>"
finish = "<html><body>收容所管理人：<br>啊，我明白。果然，我沒有看錯人...<br>謝謝你為這裡做的一切。<br>如果你想再次伸出援手的話，我們會非常感激。<br>祝你旅途愉快！</body></html>"
noparty = "<html><body>為了進入收容所，得先組織2人以上的隊伍才行。</body></html>"
#noleader = "<html><body>收容所管理人：<br>為了在戰鬥中生存，最重要的是隊伍的隊長如何領導自己的隊伍，當然，在菲拉卡內將領導您的人，也會是隊長。所以，我非常尊重隊伍的領導人物。您的隊長是" + str(pln) + "，去將您的隊長請來這邊吧。<br>(只有隊長才能試圖進入。)</body></html>"
warden_quest = "<html><body>收容所管理人：<br>我是這個要塞的地下怪物收容所管理人。這個地下怪物收容所怪物陣營最近被發現的。<br>我知道其他要塞也有這樣的地下怪物收容所。我的責任是要保持這個地下怪物收容所區安全。<br>畢竟，這將幾乎是可取的怪物出現和消失在地牢的一座要塞，不是嗎？<br>不幸的是，我們根本無法單獨處理這個工作。<br>我們需要冒險家的幫助。<br>當然，我們會支付給您酬勞。<br><br><a action=\"bypass -h Quest 511_AwlUnderFoot start\">我會幫你的</a><br><a action=\"bypass -h Quest 511_AwlUnderFoot warden_no\">我不是現在</a></body></html>"
warden_yes = "<html><body>收容所管理人：<br>進入要塞地下怪物收容所後，將地下怪物收容所罪犯擊退吧。<br>冒險家您必須要將<font color=\"LEVEL\">三人組</font>都擊退後，擊倒組成地下怪物收容所罪犯族群的所有魔物才行。<br>將最後一組的首領怪物殺死後，帶回城地下怪物收容所魔物的階級章碎片的話，我就支付騎士肩章給您。<br>利用騎士肩章可以向宮廷魔法師交換城堡血盟補給品。<br>對了，還有...<br>到目前為止得到報告的地下怪物收容所罪犯首領有<font color=\"LEVEL\">美貌的奈茲里耶、粗野的南龐、破壞者加斯</font>。<br>可透過我進入城地下怪物收容所。<br>那就拜託您了。<br><a action=\"bypass -h Quest 511_AwlUnderFoot enter\">知道了，現在就出發</a><br><a action=\"bypass -h Quest 511_AwlUnderFoot warden_ask\">地下怪物收容所的怪物們是何方神聖？</a></body></html>"

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
		player.sendPacket(SystemMessage(SystemMessageId.NOT_IN_PARTY_CANT_ENTER))
		return False
	for partyMember in party.getPartyMembers().toArray():
		if not partyMember.getLevel() >= 60:
			player.sendPacket(SystemMessage(SystemMessageId.PARTY_EXCEEDED_THE_LIMIT_CANT_ENTER))
			return False
		if not partyMember.isInsideRadius(player, 1000, False, False):
			sm = SystemMessage(SystemMessageId.C1_IS_IN_LOCATION_THAT_CANNOT_BE_ENTERED)
			sm.addCharName(partyMember)
			player.sendPacket(sm)
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
					player.sendPacket(SystemMessage.sendString(partyMember.getName() + "隊伍成員沒有進行任務。"))
					return 0
			else :
				player.sendPacket(SystemMessage.sendString(partyMember.getName() + "隊伍成員沒有進行任務。"))
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
			player.sendPacket(SystemMessage.sendString("你的隊員已進入其它的即時地區。"))
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
			player.sendPacket(SystemMessage.sendString("從現在起將會限制進入即時地區：「要塞地下怪物收容所」。下一次的進場時間還剩" + str(timeleft) + "分鐘。"))
			return False
	else :
		return True

def checkLeader(player) :
	party = player.getParty()
	if not party:
		player.sendPacket(SystemMessage(SystemMessageId.NOT_IN_PARTY_CANT_ENTER))
		return False
	elif not player.getParty().isLeader(player):
		player.sendPacket(SystemMessage(SystemMessageId.ONLY_PARTY_LEADER_CAN_ENTER))
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

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "start" :
			htmltext = warden_yes
			st.set("cond", "1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "quit" :
			htmltext = finish
			st.playSound("ItemSound.quest_finish")
			st.exitQuest(1)
		elif event == "continue" :
			htmltext = warden_yes
		elif event == "warden_no" :
			st.set("cond", "0")
			htmltext = warden_no
		elif event == "default" :
			htmltext = default
		elif event == "warden_yes" :
			htmltext = warden_yes
		elif event == "warden_ask" :
			htmltext = warden_ask
		elif event == "warden_ask1" :
			htmltext = warden_ask1
		elif event == "warden_ask2" :
			htmltext = warden_ask2
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
					htmltext = "<html><body>收容所管理人：<br>地下怪物收容所閒置中，你現在可以進入。<br><a action=\"bypass -h Quest 511_AwlUnderFoot warden_yes\">返回</a></body></html>"
				else :
					timeleft = remain / 60000
					if timeleft > 180 :
						htmltext = "<html><body>收容所管理人：<br>地下怪物收容所現在有人挑戰中。待他們離開時，然後再試一次。<br><a action=\"bypass -h Quest 511_AwlUnderFoot warden_yes\">返回</a></body></html>"
					else :
						htmltext = "<html><body>收容所管理人：<br>從現在起將會限制進入即時地區：「要塞地下怪物收容所」。下一次的進場時間還剩 <font color=\"LEVEL\">" + str(timeleft) + "</font> 分鐘。<br><a action=\"bypass -h Quest 511_AwlUnderFoot warden_yes\">返回</a></body></html>"
			else :
				htmltext = "<html><body>收容所管理人：<br>地下怪物收容所閒置中，你現在可以進入。<br><a action=\"bypass -h Quest 511_AwlUnderFoot warden_yes\">返回</a></body></html>"
				#htmltext = st.showHtmlFile("status.htm").replace("%text%", text)
		elif event == "enter" :
			party = player.getParty()
			if not party:
				htmltext = noparty
			elif not player.getParty().isLeader(player):
				pln = player.getParty().getLeader().getName()
				htmltext = "<html><body>收容所管理人：<br>為了在戰鬥中生存，最重要的是隊伍的隊長如何領導自己的隊伍，當然，在菲拉卡內將領導您的人，也會是隊長。所以，我非常尊重隊伍的領導人物。您的隊長是" + str(pln) + "，去將您的隊長請來這邊吧。<br>(只有隊長才能試圖進入。)</body></html>"
			else :
				tele = PyObject()
				tele.x = 11740
				tele.y = -49148
				tele.z = -3000
				enterInstance(self, player, "RimPailakaFort.xml", tele)
				htmltext = ""
		return htmltext

	def onTalk (self, npc, player):
		htmltext = default
		st = player.getQuestState(qn)
		if not st : return htmltext
	
		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		FORT = npc.getFort().getOwnerClan()
		CLAN = player.getClan()

		if id == State.CREATED :
			if npcId in WARDEN and cond == 0 :
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
					if player.getLevel() >= 60 :
						htmltext = warden_quest
					else :
						htmltext = nolvl
						st.exitQuest(1)
		elif id == State.STARTED :
			if npcId in WARDEN :
				if cond == 1 :
					count = st.getQuestItemsCount(DL_MARK)
					if count > 0 :
						htmltext = warden_exchange
						st.takeItems(DL_MARK, count)
						st.giveItems(KNIGHT_EPALUETTE, count * 136)
					elif count == 0 :
						htmltext = warden_yes
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
		st = player.getQuestState(qn)
		if not st :
			st = self.newQuestState(player)
		npcId = npc.getNpcId()
		if npcId in WARDEN :
			htmltext = "ForressWarden.htm"
		return htmltext

# Quest class and state definition
QUEST = Quest(QuestId, str(QuestId) + "_" + QuestName, QuestDesc)

for npcId in WARDEN :
	QUEST.addStartNpc(npcId)
	QUEST.addTalkId(npcId)
	QUEST.addFirstTalkId(npcId)

for mobId in RAIDS1 :
	QUEST.addKillId(mobId)
for mobId in RAIDS2 :
	QUEST.addKillId(mobId)
for mobId in RAIDS3 :
	QUEST.addKillId(mobId)