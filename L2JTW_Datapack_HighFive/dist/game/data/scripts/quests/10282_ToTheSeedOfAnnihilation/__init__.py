# 2010-08-13 by Gnacik
# Based on Freya PTS
import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "10282_ToTheSeedOfAnnihilation"

# NPC
KBALDIR = 32733
KLEMIS = 32734

# ITEMS
SOA_ORDERS = 15512

class Quest (JQuest) :
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [SOA_ORDERS]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		if event == "32733-07.html" :
			st.setState(State.STARTED)
			st.set("cond","1")
			st.giveItems(SOA_ORDERS,1)
			st.playSound("ItemSound.quest_accept")
		elif event == "32734-02.html" :
			st.unset("cond")
			st.rewardItems(57,212182)
			st.takeItems(SOA_ORDERS,-1)
			st.addExpAndSp(1148480,99110)
			st.exitQuest(False)
			st.playSound("ItemSound.quest_finish")
		return htmltext

	def onTalk (self,npc,player):
		htmltext = Quest.getNoQuestMsg(player)
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			if npcId == KBALDIR :
				htmltext = "32733-09.html"
			elif npcId == KLEMIS:
				htmltext = "32734-03.html"
		elif id == State.CREATED :
			if player.getLevel() >= 84 :
				htmltext = "32733-01.htm"
			else :
				htmltext = "32733-00.htm"
		else :
			if cond == 1 :
				if npcId == KBALDIR :
					htmltext = "32733-08.html"
				elif npcId == KLEMIS :
					htmltext = "32734-01.html"
		return htmltext

QUEST = Quest(10282,qn,"To the Seed of Annihilation")

QUEST.addStartNpc(KBALDIR)
QUEST.addTalkId(KBALDIR)
QUEST.addTalkId(KLEMIS)
