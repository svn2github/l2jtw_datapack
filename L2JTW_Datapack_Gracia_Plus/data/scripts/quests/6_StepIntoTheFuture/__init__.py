# Created by CubicVirtuoso
# Any problems feel free to drop by #l2j-datapack on irc.freenode.net
# Update by pmq 02-07-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "6_StepIntoTheFuture"

# NPCs
ROXXY      = 30006
BAULRO     = 30033
SIR_COLLIN = 30311

# ITEM
BAULRO_LETTER = 7571

# REWARDS
SCROLL_OF_ESCAPE_GIRAN = 7559
MARK_OF_TRAVELER       = 7570

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [BAULRO_LETTER]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "30006-03.htm" :
			st.set("cond","1")
			st.set("id","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "30033-02.htm" :
			st.giveItems(BAULRO_LETTER,1)
			st.set("cond","2")
			st.set("id","2")
			st.playSound("ItemSound.quest_middle")
		elif event == "30311-03.htm" :
			st.takeItems(BAULRO_LETTER,-1)
			st.set("cond","3")
			st.set("id","3")
			st.playSound("ItemSound.quest_middle")
		elif event == "30006-06.htm" :
			st.giveItems(SCROLL_OF_ESCAPE_GIRAN,1)
			st.giveItems(MARK_OF_TRAVELER, 1)
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
			if npcId == ROXXY :
				if player.getRace().ordinal() != 0 :
					htmltext = "30006-00.htm"
					st.exitQuest(1)
				elif player.getLevel() >= 3 :
					htmltext = "30006-02.htm"
				else :
					htmltext = "30006-01.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == ROXXY :
				if cond == 1 :
					htmltext = "30006-04.htm"
				elif cond == 3 :
					htmltext = "30006-05.htm"
			elif npcId == BAULRO :
				if cond == 1 :
					htmltext = "30033-01.htm"
				elif cond == 2 and st.getQuestItemsCount(BAULRO_LETTER):
					htmltext = "30033-03.htm"
			elif npcId == SIR_COLLIN :
				if cond == 2 and st.getQuestItemsCount(BAULRO_LETTER) :
					htmltext = "30311-02.htm"
				elif cond == 3 :
					htmltext = "30311-04.htm"
		return htmltext

QUEST		= Quest(6,qn,"朝向未來的第一步")

QUEST.addStartNpc(ROXXY)

QUEST.addTalkId(ROXXY)
QUEST.addTalkId(BAULRO)
QUEST.addTalkId(SIR_COLLIN)