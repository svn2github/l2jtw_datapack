# Created by CubicVirtuoso
# Any problems feel free to drop by #l2j-datapack on irc.freenode.net
# Update by pmq 09-07-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "46_OnceMoreInTheArmsOfTheMotherTree"

# NPC
JEWELER_SANDRA_ID               = 30090
MAGIC_TRADER_GENTLER_ID         = 30094
TRADER_GALLADUCCI_ID            = 30097
PRIEST_DUSTIN_ID                = 30116
# ITEM
SCROLL_OF_ESCAPE_SPECIAL        = 7555
GALLADUCCIS_ORDER_DOCUMENT_ID_1 = 7563
GALLADUCCIS_ORDER_DOCUMENT_ID_2 = 7564
GALLADUCCIS_ORDER_DOCUMENT_ID_3 = 7565
PURIFIED_MAGIC_NECKLACE_ID      = 7566
GEMSTONE_POWDER_ID              = 7567
MAGIC_SWORD_HILT_ID             = 7568
MARK_OF_TRAVELER_ID             = 7570
ADENA_ID                        = 57
# RACE
RACE = 1

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [GALLADUCCIS_ORDER_DOCUMENT_ID_1, GALLADUCCIS_ORDER_DOCUMENT_ID_2, GALLADUCCIS_ORDER_DOCUMENT_ID_3,
			MAGIC_SWORD_HILT_ID, GEMSTONE_POWDER_ID, PURIFIED_MAGIC_NECKLACE_ID]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "1" :
			st.giveItems(GALLADUCCIS_ORDER_DOCUMENT_ID_1,1)
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			htmltext = "30097-03.htm"
			st.setState(State.STARTED)
		elif event == "2" :
			st.takeItems(GALLADUCCIS_ORDER_DOCUMENT_ID_1,1)
			st.giveItems(MAGIC_SWORD_HILT_ID,1)
			st.set("cond","2")
			st.playSound("ItemSound.quest_accept")
			htmltext = "30094-02.htm"
		elif event == "3" :
			st.takeItems(MAGIC_SWORD_HILT_ID,1)
			st.giveItems(GALLADUCCIS_ORDER_DOCUMENT_ID_2,1)
			st.set("cond","3")
			st.playSound("ItemSound.quest_accept")
			htmltext = "30097-06.htm"
		elif event == "4" :
			st.takeItems(GALLADUCCIS_ORDER_DOCUMENT_ID_2,1)
			st.giveItems(GEMSTONE_POWDER_ID,1)
			st.set("cond","4")
			st.playSound("ItemSound.quest_accept")
			htmltext = "30090-02.htm"
		elif event == "5" :
			st.takeItems(GEMSTONE_POWDER_ID,1)
			st.giveItems(GALLADUCCIS_ORDER_DOCUMENT_ID_3,1)
			st.set("cond","5")
			st.playSound("ItemSound.quest_accept")
			htmltext = "30097-09.htm"
		elif event == "6" :
			st.takeItems(GALLADUCCIS_ORDER_DOCUMENT_ID_3,1)
			st.giveItems(PURIFIED_MAGIC_NECKLACE_ID,1)
			st.set("cond","6")
			st.playSound("ItemSound.quest_accept")
			htmltext = "30116-02.htm"
		elif event == "7" :
			st.giveItems(SCROLL_OF_ESCAPE_SPECIAL,1)
			st.takeItems(PURIFIED_MAGIC_NECKLACE_ID,1)
			st.takeItems(MARK_OF_TRAVELER_ID,-1)
			htmltext = "30097-12.htm"
			st.unset("cond")
			st.exitQuest(False)
			st.playSound("ItemSound.quest_finish")
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == 30097 and cond == 0 :
				if player.getRace().ordinal() == RACE and st.getQuestItemsCount(MARK_OF_TRAVELER_ID) > 0 :
					htmltext = "30097-02.htm"
				else :
					htmltext = "30097-01.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == 30097 :
				if cond == 1 :
					htmltext = "30097-04.htm"
				elif cond == 2 :
					htmltext = "30097-05.htm"
				elif cond == 3 :
					htmltext = "30097-07.htm"
				elif cond == 4 :
					htmltext = "30097-08.htm"
				elif cond == 5 :
					htmltext = "30097-10.htm"
				elif cond == 6 :
					htmltext = "30097-11.htm"
			elif npcId == 30094 :
				if cond == 1 :
					htmltext = "30094-01.htm"
				elif cond == 2 :
					htmltext = "30094-03.htm"
			elif npcId == 30090 :
				if cond == 3 :
					htmltext = "30090-01.htm"
				elif cond == 4 :
					htmltext = "30090-03.htm"
			elif npcId == 30116 :
				if cond == 5 :
					htmltext = "30116-01.htm"
				elif cond == 6 :
					htmltext = "30116-03.htm"
		return htmltext

QUEST		= Quest(46,qn,"回到世界樹的懷抱")

QUEST.addStartNpc(30097)

QUEST.addTalkId(30097)
QUEST.addTalkId(30094)
QUEST.addTalkId(30090)
QUEST.addTalkId(30116)