# Made by Ethernaly ethernaly@email.it
# Update by pmq 10-09-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "117_OceanOfDistantStar"

#NPC
ABEY    = 32053
GHOST   = 32055
GHOST_F = 32054
OBI     = 32052
BOX     = 32076
#QUEST ITEM, CHANCE and REWARD
GREY_STAR       = 8495
ENGRAVED_HAMMER = 8488
CHANCE          = 38

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [GREY_STAR]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		if event == "1" :
			htmltext = "0a.htm"
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "2" :
			htmltext="1a.htm"
			st.set("cond","2")
			st.playSound("ItemSound.quest_accept")
		elif event == "3" :
			htmltext="2a.htm"
			st.set("cond","3")
			st.playSound("ItemSound.quest_accept")
		elif event == "4" :
			htmltext="3a.htm"
			st.set("cond","4")
			st.playSound("ItemSound.quest_accept")
		elif event == "5" :
			htmltext="4a.htm"
			st.set("cond","5")
			st.giveItems(ENGRAVED_HAMMER,1)
			st.playSound("ItemSound.quest_accept")
		elif event == "6" and st.getQuestItemsCount(ENGRAVED_HAMMER) :
			htmltext="5a.htm"
			st.set("cond","6")
			st.playSound("ItemSound.quest_accept")
		elif event == "7" and st.getQuestItemsCount(ENGRAVED_HAMMER) :
			htmltext="6a.htm"
			st.set("cond","7")
			st.playSound("ItemSound.quest_accept")
		elif event == "8" and st.getQuestItemsCount(GREY_STAR) :
			htmltext="7a.htm"
			st.takeItems(GREY_STAR,1)
			st.set("cond","9")
			st.playSound("ItemSound.quest_accept")
		elif event == "9" and st.getQuestItemsCount(ENGRAVED_HAMMER) :
			htmltext="8a.htm"
			st.takeItems(ENGRAVED_HAMMER,1)
			st.set("cond","10")
			st.playSound("ItemSound.quest_accept")
		elif event == "10" :
			htmltext="9b.htm"
			st.giveItems(57,17647)
			st.addExpAndSp(107387,7369)
			st.playSound("ItemSound.quest_finish")
			st.exitQuest(False)
		return htmltext

	def onTalk(self, npc, player):
		htmltext="<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED:
			htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == ABEY and cond == 0 :
				if st.getPlayer().getLevel() >= 39 :
					htmltext = "0.htm"
				else:
					htmltext = "00.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == ABEY :
				if cond == 1 :
					htmltext = "0b.htm" 
				elif cond == 3 :
					htmltext = "3.htm"
				elif cond == 4 :
					htmltext = "3b.htm"
				elif cond == 5 and st.getQuestItemsCount(ENGRAVED_HAMMER) :
					htmltext = "5.htm"
				elif cond == 6 and st.getQuestItemsCount(ENGRAVED_HAMMER) :
					htmltext = "5a.htm"
				elif cond == 7 :
					htmltext = "5b.htm"
			elif npcId == GHOST :
				if cond == 1 :
					htmltext = "1.htm"
				elif cond == 2 :
					htmltext = "1b.htm"
				elif cond == 9 and st.getQuestItemsCount(ENGRAVED_HAMMER) :
					htmltext = "8.htm"
				elif cond == 10 :
					htmltext = "8b.htm"
			elif npcId == BOX :
				if cond == 4 :
					htmltext = "4.htm"
				elif cond == 5 :
					htmltext = "4b.htm"
			elif npcId == OBI :
				if cond == 2 :
					htmltext = "2.htm"
				elif cond == 3 :
					htmltext = "2b.htm"
				elif cond == 6 and st.getQuestItemsCount(ENGRAVED_HAMMER) :
					htmltext = "6.htm"
				elif cond == 7 and st.getQuestItemsCount(ENGRAVED_HAMMER) :
					htmltext = "6a.htm"
				elif cond == 8 and st.getQuestItemsCount(GREY_STAR) :
					htmltext = "7.htm"
				elif cond == 9 :
					htmltext = "7b.htm"
			elif npcId == GHOST_F :
				if cond == 10 :
					htmltext = "9.htm" #link to 9a.htm so link to event 10
		return htmltext

	def onKill(self,npc,player,isPet):
		st = player.getQuestState(qn)
		if st :
			if st.getState() == State.STARTED :
				count = st.getQuestItemsCount(GREY_STAR)
				if st.getInt("cond") == 7 and count < 1 and self.getRandom(100)<CHANCE :
					st.giveItems(GREY_STAR,1)
					st.playSound("ItemSound.quest_itemget")
					st.set("cond","8")
		return

QUEST		= Quest(117,qn,"無法抵達的星之海")

QUEST.addStartNpc(ABEY)

QUEST.addTalkId (ABEY)
QUEST.addTalkId(GHOST)
QUEST.addTalkId(OBI)
QUEST.addTalkId(BOX)
QUEST.addTalkId(GHOST_F)

for MOBS in [22023,22024]:
  QUEST.addKillId(MOBS)