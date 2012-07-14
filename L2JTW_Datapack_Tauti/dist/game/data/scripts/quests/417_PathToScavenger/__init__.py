# Made by Mr. Have fun! Version 0.2
# Shadow Weapon Coupons contributed by BiTi for the Official L2J Datapack Project
# Visit http://www.l2jdp.com/forum/ for more details
# Update by pmq 12-11-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest
from com.l2jserver.gameserver.network.serverpackets import SocialAction

qn = "417_PathToScavenger"

RING_OF_RAVEN   = 1642
PIPIS_LETTER    = 1643
ROUTS_TP_SCROLL = 1644
SUCCUBUS_UNDIES = 1645
MIONS_LETTER    = 1646
BRONKS_INGOT    = 1647
CHALIS_AXE      = 1648
ZIMENFS_POTION  = 1649
BRONKS_PAY      = 1650
CHALIS_PAY      = 1651
ZIMENFS_PAY     = 1652
BEAR_PIC        = 1653
TARANTULA_PIC   = 1654
HONEY_JAR       = 1655
BEAD            = 1656
BEAD_PARCEL     = 1657

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = range(1643,1658)

	def onEvent (self,event,st) :
		htmltext = event
		level = st.getPlayer().getLevel()
		classId = st.getPlayer().getClassId().getId()
		if event == "1" :
			st.set("id","0")
			if level >= 18 and classId == 0x35 and st.getQuestItemsCount(RING_OF_RAVEN) == 0 :
				st.set("cond","1")
				st.setState(State.STARTED)
				st.playSound("ItemSound.quest_accept")
				st.giveItems(PIPIS_LETTER,1)
				htmltext = "30524-05.htm"
			elif classId != 0x35 :
				if classId == 0x36 :
					htmltext = "30524-02a.htm"
				else:
					htmltext = "30524-08.htm"
			elif level < 18 and classId == 0x35 :
				htmltext = "30524-02.htm"
			elif level >= 18 and classId == 0x35 and st.getQuestItemsCount(RING_OF_RAVEN) == 1 :
				htmltext = "30524-04.htm"
		elif event == "30519_1" :
			if st.getQuestItemsCount(PIPIS_LETTER):
				st.takeItems(PIPIS_LETTER,1)
				st.set("cond","2")
				st.playSound("ItemSound.quest_accept")
				n = self.getRandom(3)
				if n == 0:
					htmltext = "30519-02.htm"
					st.giveItems(ZIMENFS_POTION,1)
					st.playSound("ItemSound.quest_accept")
				if n == 1:
					htmltext = "30519-03.htm"
					st.giveItems(CHALIS_AXE,1)
					st.playSound("ItemSound.quest_accept")
				if n == 2:
					htmltext = "30519-04.htm"
					st.giveItems(BRONKS_INGOT,1)
			else:
				htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		elif event == "30519_2" :
			htmltext = "30519-06.htm"
		elif event == "30519_3" :
			htmltext = "30519-07.htm"
			st.set("id",str(st.getInt("id")+1))
		elif event == "30519_4" :
			n = self.getRandom(2)
			if n == 0:
				htmltext = "30519-06.htm"
			if n == 1:
				htmltext = "30519-11.htm"
		elif event == "30519_5" :
			if st.getQuestItemsCount(ZIMENFS_POTION) or st.getQuestItemsCount(CHALIS_AXE) or st.getQuestItemsCount(BRONKS_INGOT):
				if st.getInt("id") / 10 < 2 :
					htmltext = "30519-07.htm"
					st.set("id",str(st.getInt("id")+1))
				if st.getInt("id") / 10 >= 2 and st.getInt("cond") == 2 :
					htmltext = "30519-09.htm"
					if st.getInt("id") / 10 < 3 :
						st.set("id",str(st.getInt("id")+1))
				if st.getInt("id") / 10 >= 3 and st.getInt("cond") >= 2 :
					st.set("cond","3")
					htmltext = "30519-10.htm"
					st.giveItems(MIONS_LETTER,1)
					st.takeItems(CHALIS_AXE,1)
					st.takeItems(ZIMENFS_POTION,1)
					st.takeItems(BRONKS_INGOT,1)
					st.set("cond","4")
					st.playSound("ItemSound.quest_accept")
			else:
				htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		elif event == "30519_6" :
			if st.getQuestItemsCount(ZIMENFS_PAY) or st.getQuestItemsCount(CHALIS_PAY) or st.getQuestItemsCount(BRONKS_PAY):
				n = self.getRandom(3)
				st.takeItems(ZIMENFS_PAY,1)
				st.takeItems(CHALIS_PAY,1)
				st.takeItems(BRONKS_PAY,1)
				st.playSound("ItemSound.quest_accept")
				if n == 0:
					htmltext = "30519-02.htm"
					st.giveItems(ZIMENFS_POTION,1)
					st.playSound("ItemSound.quest_accept")
				if n == 1:
					htmltext = "30519-03.htm"
					st.giveItems(CHALIS_AXE,1)
					st.playSound("ItemSound.quest_accept")
				if n == 2:
					htmltext = "30519-04.htm"
					st.giveItems(BRONKS_INGOT,1)
					st.playSound("ItemSound.quest_accept")
			else:
				htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		elif event == "30316_1" :
			if st.getQuestItemsCount(BEAD_PARCEL):
				htmltext = "30316-02.htm"
				st.takeItems(BEAD_PARCEL,1)
				st.giveItems(ROUTS_TP_SCROLL,1)
				st.set("cond","10")
				st.playSound("ItemSound.quest_accept")
			else:
				htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		elif event == "30316_2" :
			if st.getQuestItemsCount(BEAD_PARCEL):
				htmltext = "30316-03.htm"
				st.takeItems(BEAD_PARCEL,1)
				st.giveItems(ROUTS_TP_SCROLL,1)
				st.set("cond","10")
				st.playSound("ItemSound.quest_accept")
			else:
				htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		elif event == "30557_1" :
			htmltext = "30557-02.htm"
		elif event == "30557_2" :
			if st.getQuestItemsCount(ROUTS_TP_SCROLL):
				htmltext = "30557-03.htm"
				st.takeItems(ROUTS_TP_SCROLL,1)
				st.giveItems(SUCCUBUS_UNDIES,1)
				st.set("cond","11")
				st.playSound("ItemSound.quest_accept")
			else:
				htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		elif event == "a" :
			htmltext = "30556-05a.htm"
			st.takeItems(BEAD,st.getQuestItemsCount(BEAD))
			st.takeItems(TARANTULA_PIC,1)
			st.giveItems(BEAD_PARCEL,1)
			st.set("cond","9")
			st.playSound("ItemSound.quest_accept")
		elif event == "b" :
			htmltext = "30556-05b.htm"
			st.takeItems(BEAD,st.getQuestItemsCount(BEAD))
			st.takeItems(TARANTULA_PIC,1)
			st.giveItems(BEAD_PARCEL,1)
			st.set("cond","12")
			st.playSound("ItemSound.quest_accept")
		elif event == "c" :
			if st.getQuestItemsCount(BEAD_PARCEL):
				htmltext = "31958-02.htm"
				st.takeItems(BEAD_PARCEL,1)
				st.giveItems(RING_OF_RAVEN,1)
				st.giveItems(57,81900)
				st.addExpAndSp(295862,24404)
				st.set("cond","0")
				st.exitQuest(False)
				st.saveGlobalQuestVar("1ClassQuestFinished","1")
				st.playSound("ItemSound.quest_finish")
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if npcId != 30524 and id != State.STARTED : return htmltext

		if npcId == 30524 :
			if cond == 0 :
				htmltext = "30524-01.htm"
			elif cond == 1 and st.getQuestItemsCount(PIPIS_LETTER) :
				htmltext = "30524-06.htm"
			elif cond in [2,3,4,5,6,7,8,9,10,11,12] and st.getQuestItemsCount(PIPIS_LETTER) == 0 :
				htmltext = "30524-07.htm"
		elif npcId == 30517 :
			if cond == 2 and st.getQuestItemsCount(CHALIS_AXE) == 1 and st.getInt("id") < 20 :
				htmltext = "30517-01.htm"
				st.takeItems(CHALIS_AXE,1)
				st.giveItems(CHALIS_PAY,1)
				if st.getInt("id") >= 50 :
					st.set("cond","3")
					st.playSound("ItemSound.quest_accept")
				st.set("id",str(st.getInt("id")+10))
			elif cond == 2 and st.getQuestItemsCount(CHALIS_AXE) == 1 and st.getInt("id") >= 20 :
				htmltext = "30517-02.htm"
				st.takeItems(CHALIS_AXE,1)
				st.giveItems(CHALIS_PAY,1)
				if st.getInt("id") >= 50 :
					st.set("cond","3")
					st.playSound("ItemSound.quest_accept")
				st.set("id",str(st.getInt("id")+10))
			elif cond in [2,3]and st.getQuestItemsCount(CHALIS_PAY) == 1 :
				htmltext = "30517-03.htm"
		elif npcId == 30519 :
			if cond == 1 and st.getQuestItemsCount(PIPIS_LETTER) :
				htmltext = "30519-01.htm"
			elif cond == 2 and ((st.getQuestItemsCount(CHALIS_AXE)+st.getQuestItemsCount(BRONKS_INGOT)+st.getQuestItemsCount(ZIMENFS_POTION)) == 1) and ((st.getInt("id") / 10) == 0) :
				htmltext = "30519-05.htm"
			elif cond == 2 and ((st.getQuestItemsCount(CHALIS_AXE)+st.getQuestItemsCount(BRONKS_INGOT)+st.getQuestItemsCount(ZIMENFS_POTION)) == 1) and ((st.getInt("id") / 10)) :
				htmltext = "30519-08.htm"
			elif cond == 2 and ((st.getQuestItemsCount(CHALIS_PAY)+st.getQuestItemsCount(BRONKS_PAY)+st.getQuestItemsCount(ZIMENFS_PAY)) == 1) and (st.getInt("id") < 50) :
				htmltext = "30519-12.htm"
			elif cond == 2 and ((st.getQuestItemsCount(CHALIS_PAY)+st.getQuestItemsCount(BRONKS_PAY)+st.getQuestItemsCount(ZIMENFS_PAY)) == 1) and (st.getInt("id") >= 50) :
				htmltext = "30519-15.htm"
				st.giveItems(MIONS_LETTER,1)
				st.takeItems(CHALIS_PAY,1)
				st.takeItems(ZIMENFS_PAY,1)
				st.takeItems(BRONKS_PAY,1)
				st.set("cond","4")
				st.playSound("ItemSound.quest_accept")
			elif cond == 4 and st.getQuestItemsCount(MIONS_LETTER) :
				htmltext = "30519-13.htm"
			elif cond > 4 and (st.getQuestItemsCount(BEAR_PIC) or st.getQuestItemsCount(TARANTULA_PIC) or st.getQuestItemsCount(BEAD_PARCEL) or st.getQuestItemsCount(ROUTS_TP_SCROLL) or st.getQuestItemsCount(SUCCUBUS_UNDIES)) :
				htmltext = "30519-14.htm"
		elif npcId == 30525 :
			if cond == 2 and st.getQuestItemsCount(BRONKS_INGOT) == 1 and st.getInt("id") < 20 :
				htmltext = "30525-01.htm"
				st.takeItems(BRONKS_INGOT,1)
				st.giveItems(BRONKS_PAY,1)
				if st.getInt("id") >= 50 :
					st.set("cond","3")
					st.playSound("ItemSound.quest_accept")
				st.set("id",str(st.getInt("id")+10))
			elif cond == 2 and st.getQuestItemsCount(BRONKS_INGOT) == 1 and st.getInt("id") >= 20 :
				htmltext = "30525-02.htm"
				st.takeItems(BRONKS_INGOT,1)
				st.giveItems(BRONKS_PAY,1)
				if st.getInt("id") >= 50 :
					st.set("cond","3")          
					st.playSound("ItemSound.quest_accept")
				st.set("id",str(st.getInt("id")+10))
			elif cond in [2,3] and st.getQuestItemsCount(BRONKS_PAY) == 1 :
				htmltext = "30525-03.htm"
		elif npcId == 30538 :
			if cond ==2 and st.getQuestItemsCount(ZIMENFS_POTION) == 1 and st.getInt("id") < 20 :
				htmltext = "30538-01.htm"
				st.takeItems(ZIMENFS_POTION,1)
				st.giveItems(ZIMENFS_PAY,1)
				if st.getInt("id") >= 50 :
					st.set("cond","3")
					st.playSound("ItemSound.quest_accept")
				st.set("id",str(st.getInt("id")+10))
			elif cond == 2 and st.getQuestItemsCount(ZIMENFS_POTION) == 1 and st.getInt("id") >= 20 :
				htmltext = "30538-02.htm"
				st.takeItems(ZIMENFS_POTION,1)
				st.giveItems(ZIMENFS_PAY,1)
				if st.getInt("id") >= 50 :
					st.set("cond","3")
					st.playSound("ItemSound.quest_accept")
				st.set("id",str(st.getInt("id")+10))
			elif cond in [2,3] and st.getQuestItemsCount(ZIMENFS_PAY) == 1 :
				htmltext = "30538-03.htm"
		elif npcId == 30556 :
			if cond == 4 and st.getQuestItemsCount(MIONS_LETTER) == 1 :
				htmltext = "30556-01.htm"
				st.takeItems(MIONS_LETTER,1)
				st.giveItems(BEAR_PIC,1)
				st.set("cond","5")
				st.set("id",str(0))
				st.playSound("ItemSound.quest_accept")
			elif cond == 5 and st.getQuestItemsCount(BEAR_PIC) == 1 and st.getQuestItemsCount(HONEY_JAR) < 5 :
				htmltext = "30556-02.htm"
			elif cond == 6 and st.getQuestItemsCount(BEAR_PIC) == 1 and st.getQuestItemsCount(HONEY_JAR) >= 5 :
				htmltext = "30556-03.htm"
				st.takeItems(HONEY_JAR,st.getQuestItemsCount(HONEY_JAR))
				st.takeItems(BEAR_PIC,1)
				st.giveItems(TARANTULA_PIC,1)
				st.set("cond","7")
				st.playSound("ItemSound.quest_accept")
			elif cond == 7 and st.getQuestItemsCount(TARANTULA_PIC) == 1 and st.getQuestItemsCount(BEAD) < 20 :
				htmltext = "30556-04.htm"
			elif cond == 8 and st.getQuestItemsCount(TARANTULA_PIC) == 1 and st.getQuestItemsCount(BEAD) >= 20 :
				htmltext = "30556-05.htm"
			elif cond and (st.getQuestItemsCount(ROUTS_TP_SCROLL) or st.getQuestItemsCount(SUCCUBUS_UNDIES)) :
				htmltext = "30556-07.htm"
			elif cond == 9 and st.getQuestItemsCount(BEAD_PARCEL) == 1 : 
				htmltext = "30556-06.htm"
			elif cond == 12 and st.getQuestItemsCount(BEAD_PARCEL) == 1 :
				htmltext = "30556-06b.htm"
		elif npcId == 30316 :
			if cond == 9 and st.getQuestItemsCount(BEAD_PARCEL) == 1 :
				htmltext = "30316-01.htm"
			elif cond == 10 and st.getQuestItemsCount(ROUTS_TP_SCROLL) == 1 :
				htmltext = "30316-04.htm"
			elif cond == 11 and st.getQuestItemsCount(SUCCUBUS_UNDIES) == 1 :
				htmltext = "30316-05.htm"
				st.takeItems(SUCCUBUS_UNDIES,1)
				isFinished = st.getGlobalQuestVar("1ClassQuestFinished")
				if isFinished == "" : 
					if player.getLevel() >= 20 :
						st.addExpAndSp(160267, 17706)
					elif player.getLevel() == 19 :
						st.addExpAndSp(228064, 21055)
					else:
						st.addExpAndSp(295862, 24404)
						st.giveItems(RING_OF_RAVEN,1)
					st.giveItems(57, 163800)
				st.set("cond","0")
				st.exitQuest(False)
				st.saveGlobalQuestVar("1ClassQuestFinished","1")
				st.playSound("ItemSound.quest_finish")
				player.sendPacket(SocialAction(player.getObjectId(),3))
		elif npcId == 30557 :
			if cond == 10 and st.getQuestItemsCount(ROUTS_TP_SCROLL) == 1 :
				htmltext = "30557-01.htm"
		elif npcId == 31958 :
			if cond == 12 and st.getQuestItemsCount(BEAD_PARCEL) == 1 :
				htmltext = "31958-01.htm"
		return htmltext

	def onKill(self,npc,player,isPet):
		st = player.getQuestState(qn)
		if not st : return 
		if st.getState() != State.STARTED : return 
   
		npcId = npc.getNpcId()
		if npcId == 20777 :
			if st.getInt("cond") and st.getQuestItemsCount(BEAR_PIC) == 1 and st.getQuestItemsCount(HONEY_JAR) < 5 :
				if st.getInt("id") > 20 :
					n = ((st.getInt("id")-20)*10)
					if self.getRandom(100) <= n :
						st.addSpawn(27058)
						st.set("id","0")
					else:
						st.set("id",str(st.getInt("id")+1))
				else:
					st.set("id",str(st.getInt("id")+1))
		elif npcId == 27058 :
			if st.getInt("cond") and st.getQuestItemsCount(BEAR_PIC) == 1 and st.getQuestItemsCount(HONEY_JAR) < 5 :
				if npc.isSpoil() :
					st.giveItems(HONEY_JAR,1)
					if st.getQuestItemsCount(HONEY_JAR) == 5 :
						st.playSound("ItemSound.quest_middle")
						st.set("cond","6")
					else:
						st.playSound("ItemSound.quest_itemget")
		elif npcId == 20403 :
			if st.getInt("cond") and st.getQuestItemsCount(TARANTULA_PIC) == 1 and st.getQuestItemsCount(BEAD) < 20 :
				if npc.isSpoil() :
					if self.getRandom(2) == 0 :
						st.giveItems(BEAD,1)
						if st.getQuestItemsCount(BEAD) == 20 :
							st.playSound("ItemSound.quest_middle")
							st.set("cond","8")
						else:
							st.playSound("ItemSound.quest_itemget")
		elif npcId == 20508 :
			if st.getInt("cond") and st.getQuestItemsCount(TARANTULA_PIC) == 1 and st.getQuestItemsCount(BEAD) < 20 :
				if npc.isSpoil() :
					if self.getRandom(10) < 6 :
						st.giveItems(BEAD,1)
						if st.getQuestItemsCount(BEAD) == 20 :
							st.playSound("ItemSound.quest_middle")
							st.set("cond","8")
						else:
							st.playSound("ItemSound.quest_itemget")
		return

QUEST		= Quest(417,qn,"成為收集者的路")

QUEST.addStartNpc(30524)
QUEST.addTalkId(30524)

QUEST.addTalkId(30316)
QUEST.addTalkId(30517)
QUEST.addTalkId(30519)
QUEST.addTalkId(30525)
QUEST.addTalkId(30538)
QUEST.addTalkId(30556)
QUEST.addTalkId(30557)
QUEST.addTalkId(31958)

QUEST.addKillId(20403)
QUEST.addKillId(27058)
QUEST.addKillId(20508)
QUEST.addKillId(20777)