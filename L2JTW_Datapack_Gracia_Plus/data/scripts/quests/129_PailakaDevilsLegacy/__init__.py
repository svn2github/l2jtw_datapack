# By Psycho(killer1888) / L2jFree
# 中文化 pmq
import sys
from com.l2jserver.gameserver.datatables             import ItemTable
from com.l2jserver.gameserver.instancemanager        import InstanceManager
from com.l2jserver.gameserver.model.actor            import L2Summon
from com.l2jserver.gameserver.model.entity           import Instance
from com.l2jserver.gameserver.model.quest            import State
from com.l2jserver.gameserver.model.quest            import QuestState
from com.l2jserver.gameserver.model.quest.jython     import QuestJython as JQuest
from com.l2jserver.gameserver.model.actor.instance   import L2PcInstance
from com.l2jserver.gameserver.network                import SystemMessageId
from com.l2jserver.gameserver.network.serverpackets  import CreatureSay
from com.l2jserver.gameserver.network.serverpackets  import NpcSay
from com.l2jserver.gameserver.network.serverpackets  import SystemMessage
from com.l2jserver.util                              import Rnd
from com.l2jserver.gameserver.model.zone             import L2ZoneType

# 129 1 【菲拉卡-惡魔的遺產 惡魔島的菲拉卡】
# 129 2 【菲拉卡-惡魔的遺產 菲拉卡的嚮導】
# 129 3 【菲拉卡-惡魔的遺產 淨化惡魔島】
# 129 4 【菲拉卡-惡魔的遺產 淨化的惡魔島】

qn = "129_PailakaDevilsLegacy"

debug = False

#NPC
SURVUVOR                       = 32498    # 惡魔島的復活者
SUPPORTER                      = 32501    # 惡魔島的協助者
DWARF                          = 32508    # 矮人探險家
DWARF2                         = 32511    # 矮人探險家 最後出現的矮人

#MOBs
POWER_KEG                      = 18622    # 火藥桶
BEGRUDGED_ARCHER               = 18623    # 怨恨的弓手
DEADMAN_S_GRUDGE_1             = 18624    # 死者的怨恨
DEADMAN_S_GRUDGE_2             = 18625    # 死者的怨恨
DEADMAN_S_GRUDGE_3             = 18626    # 死者的怨恨
DEADMAN_S_GRUDGE_4             = 18627    # 死者的怨恨
ATAN                           = 18628    # 亞唐          守望者
KAMS                           = 18629    # 卡姆士        帕奴卡
HIKORO                         = 18630    # 日比          帕奴卡
ALKASO                         = 18631    # 瓦克守        帕奴卡
GERBERA                        = 18632    # 格魯巴拉      帕奴卡
LEMATAN                        = 18633    # 雷馬堂
LEMATAN_S_FOLLOWER             = 18634    # 雷馬堂的手下
TREASURE_BOX                   = 32495    # 寶箱

#ITEM
PAILAKA_INSTANT_SHIELD         = 13032    # 菲拉卡即時盾
QUICK_HEALING_POTION           = 13033    # 瞬間體力治癒藥水
ANCIENT_LEGACY_SWORD           = 13042    # 古代遺產之劍
ENHANCED_ANCIENT_LEGACY_SWORD  = 13043    # 強化古代遺產之劍
COMPLETE_ANCIENT_LEGACY_SWORD  = 13044    # 完全化古代遺產之劍
PAILAKA_WEAPON_UPGRADE_STAGE_1 = 13046    # 菲拉卡武器升級 階段1        與「古代遺產之劍」一同交給矮人探險家，就能交換成「古代遺產之劍 階段2」。
PAILAKA_WEAPON_UPGRADE_STAGE_2 = 13047    # 菲拉卡武器升級 階段2        與「古代遺產之劍」一同交給矮人探險家的話，就能交換成「古代遺產之劍 階段3」。
PAILAKA_ANTIDOTE               = 13048    # 菲拉卡解毒劑                可解除麻痺中毒的解毒劑。無法交易或丟棄。僅限在菲拉卡即時洞窟使用。
DIVINE_SOUL                    = 13049    # 神聖武器加持                可感受神聖氣息的藥水。無法交易或丟棄。僅限在菲拉卡即時洞窟使用。
LONG_RANGEDEFENSE_POTION       = 13059    # 遠距離防禦能力提升藥水      使用後，可以增加對遠距離攻擊的防禦能力。無法交易或丟棄。僅限在菲拉卡即時洞窟使用。
PSOE                           = 736      # 返回卷軸
PAILAKA_ALL_PURPOSE_KEY        = 13150    # 菲拉卡萬能鑰匙              開啟菲拉卡惡魔島內所有門扇的鑰匙，但只要使用一次就會粉碎消失。無法交易或丟棄。
PAILAKA_BRACELET               = 13295    # 菲拉卡手鐲

#Pailaka Energy Replenishing Potion (100%)13151 菲拉卡活力充能藥水(100%) 菲拉卡獎勵品。補充活力100%的充能藥水。
#Pailaka Energy Replenishing Potion (50%) 13152 菲拉卡活力充能藥水 (50%) 菲拉卡獎勵品。補充活力50%的充能藥水。

REWARDS1 = [13032,13033,13048,13049,13059]

RNDCOUNT = [1,2,3,4,5,6,7,8,9,10]

class PyObject:
	pass

def dropItem(npc,itemId,count):
	ditem = ItemTable.getInstance().createItem("Loot", itemId, count, None)
	ditem.dropMe(npc, npc.getX(), npc.getY(), npc.getZ())

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
	# Create instance
	instanceId = InstanceManager.getInstance().createDynamicInstance(template)
	if not self.worlds.has_key(instanceId):
		world = PyObject()
		world.instanceId = instanceId
		self.worlds[instanceId] = world
		self.world_ids.append(instanceId)
		instance = InstanceManager.getInstance().getInstance(instanceId)
		instance.setAllowSummon(False)
		print "菲拉卡-惡魔的遺產 (等級 61-67)："+ template +"  即時地區：" + str(instanceId) + " 創造玩家：" + str(player.getName())
	# Teleports player
	teleto.instanceId = instanceId
	teleportplayer(self,player,teleto)
	return instanceId

def exitInstance(player,tele):
	player.setInstanceId(0)
	player.teleToLocation(teleto.x, teleto.y, teleto.z)
	pet = player.getPet()
	if pet != None :
		pet.setInstanceId(0)
		pet.teleToLocation(teleto.x, teleto.y, teleto.z)

class Quest(JQuest):
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [COMPLETE_ANCIENT_LEGACY_SWORD,ENHANCED_ANCIENT_LEGACY_SWORD,ANCIENT_LEGACY_SWORD,PAILAKA_INSTANT_SHIELD,QUICK_HEALING_POTION,PAILAKA_WEAPON_UPGRADE_STAGE_1,PAILAKA_WEAPON_UPGRADE_STAGE_2,PAILAKA_ANTIDOTE,DIVINE_SOUL,LONG_RANGEDEFENSE_POTION,PAILAKA_ALL_PURPOSE_KEY]
		self.worlds = {}
		self.world_ids = []
		self.Lock = 0

	def onAdvEvent(self,event,npc,player):
		htmltext = event
		st = player.getQuestState(qn)
		if not st: return
		if event == "32498-03.htm":
			if player.getLevel() < 61:
				htmltext = "32498-01.htm"
			elif player.getLevel() >= 67:
				htmltext = "32498-00.htm"
		elif event == "32498-06.htm":
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "accept":
			tele = PyObject()
			tele.x = 76438
			tele.y = -219035
			tele.z = -3752
			enterInstance(self, player, "PailakaDevilsLegacy.xml", tele, self)
			htmltext = "32498-08.htm"
			st.playSound("ItemSound.quest_accept")
			st.set("cond","2")
		elif event == "accept1":
			tele = PyObject()
			tele.x = 76438
			tele.y = -219035
			tele.z = -3752
			enterInstance(self, player, "PailakaDevilsLegacy.xml", tele, self)
			htmltext = "32498-10.htm"
		elif event == "32501-05.htm":
			st.set("cond","2")
			st.playSound("ItemSound.quest_middle")
		elif event == "32501-03.htm":
			st.playSound("ItemSound.quest_middle")
			st.giveItems(ANCIENT_LEGACY_SWORD, 1)
			st.set("cond","3")
		elif event == "1":
			pet = player.getPet()
			if pet != None :
				htmltext = "32508-03.htm"
			else:
				if self.Lock == 0:
					if st.getQuestItemsCount(ANCIENT_LEGACY_SWORD) == 1 and st.getQuestItemsCount(PAILAKA_WEAPON_UPGRADE_STAGE_1) == 1:
						st.playSound("ItemSound.quest_itemget")
						st.takeItems(ANCIENT_LEGACY_SWORD, -1)
						st.takeItems(PAILAKA_WEAPON_UPGRADE_STAGE_1, -1)
						st.giveItems(ENHANCED_ANCIENT_LEGACY_SWORD, 1)
						htmltext = "32508-01.htm"
						self.Lock = 1
					else :
						htmltext = "32508-02.htm"
				elif self.Lock == 1:
					if st.getQuestItemsCount(ENHANCED_ANCIENT_LEGACY_SWORD) == 1 and st.getQuestItemsCount(PAILAKA_WEAPON_UPGRADE_STAGE_2) == 1:
						st.playSound("ItemSound.quest_itemget")
						st.takeItems(ENHANCED_ANCIENT_LEGACY_SWORD, -1)
						st.takeItems(PAILAKA_WEAPON_UPGRADE_STAGE_2, -1)
						st.giveItems(COMPLETE_ANCIENT_LEGACY_SWORD, 1)
						htmltext = "32508-04.htm"
						self.Lock = 2
					else :
						htmltext = "32508-02.htm"
				elif self.Lock == 2:
					if st.getQuestItemsCount(COMPLETE_ANCIENT_LEGACY_SWORD) == 1:
						htmltext = "32508-05.htm"
		elif event == "32511-01.htm":
			pet = player.getPet()
			if pet != None:
				htmltext = "32511-03.htm"
			else:
				st.playSound("ItemSound.quest_finish")
				st.giveItems(PSOE, 1)
				st.giveItems(PAILAKA_BRACELET, 1)
				player.setVitalityPoints(20000, True)
				st.addExpAndSp(10800000, 950000)
				st.exitQuest(False)
				instanceId = player.getInstanceId()
				instance = InstanceManager.getInstance().getInstance(instanceId)
				instance.setDuration(300000)
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			if npcId == SURVUVOR:
				htmltext = "32498-11.htm"
			elif npcId == DWARF2:
				htmltext = "32511-02.htm"
		elif id == State.CREATED :
			if npcId == SURVUVOR:
				if cond == 0:
					htmltext = "32498-02.htm"
		elif id == State.STARTED :
			if npcId == SURVUVOR:
				if cond == 1:
					htmltext = "32498-07.htm"
				elif cond in [2,3,4]:
					htmltext = "32498-09.htm"
			elif npcId == SUPPORTER:
				if cond == 2:
					htmltext = "32501-01.htm"
				elif cond in [3,4]:
					htmltext = "32501-04.htm"
		return htmltext

	def onFirstTalk (self,npc,player):
		st = player.getQuestState(qn)
		if not st :
			st = self.newQuestState(player)

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			if npcId == DWARF2:
				return "32511-02.htm"
		elif id == State.STARTED :
			if npcId == DWARF:
				if cond == 3:
					return "32508.htm"
			elif cond == 4:
				if npcId == DWARF2:
					return "32511.htm"
		return

	def onKill(self,npc,player,isPet):
		st = player.getQuestState(qn)
		if not st : return
		if st.getState() != State.STARTED : return

		npcId = npc.getNpcId()
		cond = st.getInt("cond")
		if self.worlds.has_key(npc.getInstanceId()):
			world = self.worlds[npc.getInstanceId()]

			if cond == 3:
				if npcId == KAMS:
					st.playSound("ItemSound.quest_itemget")
					st.giveItems(PAILAKA_WEAPON_UPGRADE_STAGE_1, 1)
				elif npcId == HIKORO:
					st.playSound("ItemSound.quest_middle")
				elif npcId == ALKASO:
					st.playSound("ItemSound.quest_itemget")
					st.giveItems(PAILAKA_WEAPON_UPGRADE_STAGE_2, 1)
				elif npcId == GERBERA:
					st.playSound("ItemSound.quest_middle")
				elif npcId == LEMATAN:
					st.set("cond","4")
					st.playSound("ItemSound.quest_middle")
					newNpc = self.addSpawn(DWARF2, 84990, -208376, -3342, 55000, False, 0, False, world.instanceId)
		return

QUEST = Quest(129, qn, "菲拉卡-惡魔的遺產")

QUEST.addStartNpc(SURVUVOR)

QUEST.addFirstTalkId(DWARF)

QUEST.addFirstTalkId(DWARF2)

for i in [32498,32501,32508,32511]:
	QUEST.addTalkId(i)

for mob in [18622,18623,18624,18625,18626,18627,18628,18629,18630,18631,18632,18633,18634]:
	QUEST.addKillId(mob)