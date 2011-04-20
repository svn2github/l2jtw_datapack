# Made by Mr. Have fun! - Version 0.3 by DrLecter

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "2_WhatWomenWant1"

# NPCs
ARUJIEN = 30223
MIRABEL = 30146
HERBIEL = 30150
GREENIS = 30157

# ITEMS
ARUJIENS_LETTER1 = 1092
ARUJIENS_LETTER2 = 1093
ARUJIENS_LETTER3 = 1094
POETRY_BOOK      = 689
GREENIS_LETTER   = 693

# REWARDS
ADENA            = 57
BEGINNERS_POTION = 1073

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [GREENIS_LETTER, ARUJIENS_LETTER3, ARUJIENS_LETTER1, ARUJIENS_LETTER2, POETRY_BOOK]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "30223-04.htm" :
			if st.getQuestItemsCount(ARUJIENS_LETTER1) == 0 and st.getQuestItemsCount(ARUJIENS_LETTER2) == 0 and st.getQuestItemsCount(ARUJIENS_LETTER3) == 0 :
				st.giveItems(ARUJIENS_LETTER1,1)
			st.set("cond","1")
			st.set("id","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "30223-08.htm" :
			st.takeItems(ARUJIENS_LETTER3,-1)
			st.giveItems(POETRY_BOOK,1)
			st.set("cond","4")
			st.set("id","4")
			st.playSound("ItemSound.quest_middle")
		elif event == "30223-10.htm" :
			st.takeItems(ARUJIENS_LETTER3,-1)
			st.giveItems(ADENA,1850)
			st.addExpAndSp(4254,335)
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
			if npcId == ARUJIEN and cond == 0 :
				if player.getRace().ordinal() != 1 and player.getRace().ordinal() != 0 :
					htmltext = "30223-00.htm"
					st.exitQuest(1)
				elif player.getLevel() >= 2 :
					htmltext = "30223-02.htm"
				else:
					htmltext = "30223-01.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == ARUJIEN and cond >= 1 :
				if st.getQuestItemsCount(ARUJIENS_LETTER1) :
					htmltext = "30223-05.htm"
				elif st.getQuestItemsCount(ARUJIENS_LETTER2) :
					htmltext = "30223-06.htm"
				elif st.getQuestItemsCount(ARUJIENS_LETTER3) :
					htmltext = "30223-07.htm"
				elif st.getQuestItemsCount(POETRY_BOOK) :
					htmltext = "30223-11.htm"
				elif st.getQuestItemsCount(GREENIS_LETTER) :
					htmltext = "30223-10.htm"
					st.takeItems(GREENIS_LETTER,-1)
					st.giveItems(57,1850)
					st.giveItems(113,1)
					st.addExpAndSp(4254,335)
					st.unset("cond")
					st.exitQuest(False)
					st.playSound("ItemSound.quest_finish")
			elif npcId == MIRABEL and cond == 1 :
				if st.getQuestItemsCount(ARUJIENS_LETTER1) :
					htmltext = "30146-01.htm"
					st.takeItems(ARUJIENS_LETTER1,-1)
					st.giveItems(ARUJIENS_LETTER2,1)
					st.set("cond","2")
					st.set("id","2")
					st.playSound("ItemSound.quest_middle")
				elif st.getQuestItemsCount(ARUJIENS_LETTER2) or st.getQuestItemsCount(ARUJIENS_LETTER3) or st.getQuestItemsCount(POETRY_BOOK) or st.getQuestItemsCount(GREENIS_LETTER) :
					htmltext = "30146-02.htm"
			elif npcId == HERBIEL and cond == 2 and st.getQuestItemsCount(ARUJIENS_LETTER1) == 0 :
				if st.getQuestItemsCount(ARUJIENS_LETTER2) :
					htmltext = "30150-01.htm"
					st.takeItems(ARUJIENS_LETTER2,-1)
					st.giveItems(ARUJIENS_LETTER3,1)
					st.set("cond","3")
					st.set("id","3")
					st.playSound("ItemSound.quest_middle")
				elif st.getQuestItemsCount(ARUJIENS_LETTER3) or st.getQuestItemsCount(POETRY_BOOK) or st.getQuestItemsCount(GREENIS_LETTER) :
					htmltext = "30150-02.htm"
			elif npcId == GREENIS and cond == 4 :
				if st.getQuestItemsCount(POETRY_BOOK) :
					htmltext = "30157-02.htm"
					st.takeItems(POETRY_BOOK,-1)
					st.giveItems(GREENIS_LETTER,1)
					st.set("cond","5")
					st.set("id","5")
					st.playSound("ItemSound.quest_middle")
			elif npcId == GREENIS and st.getQuestItemsCount(GREENIS_LETTER) :
				htmltext = "30157-03.htm"
			elif npcId == GREENIS and (st.getQuestItemsCount(ARUJIENS_LETTER1) or st.getQuestItemsCount(ARUJIENS_LETTER2) or st.getQuestItemsCount(ARUJIENS_LETTER3)) :
				htmltext = "30157-01.htm"
		return htmltext

QUEST		= Quest(2,qn,"女人的心")

QUEST.addStartNpc(ARUJIEN)

QUEST.addTalkId(ARUJIEN)

QUEST.addTalkId(MIRABEL)
QUEST.addTalkId(HERBIEL)
QUEST.addTalkId(GREENIS)
QUEST.addTalkId(ARUJIEN) 