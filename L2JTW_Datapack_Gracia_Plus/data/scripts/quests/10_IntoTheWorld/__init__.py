# Created by CubicVirtuoso
# Any problems feel free to drop by #l2j-datapack on irc.freenode.net
# Update by pmq 30-06-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "10_IntoTheWorld"

# ITEM
VERY_EXPENSIVE_NECKLACE = 7574

# REWARDS
SCROLL_OF_ESCAPE_GIRAN  = 7559
MARK_OF_TRAVELER        = 7570

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [VERY_EXPENSIVE_NECKLACE]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "30533-03.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "30520-02.htm" :
			st.set("cond","2")
			st.giveItems(VERY_EXPENSIVE_NECKLACE,1)
			st.playSound("ItemSound.quest_accept")
		elif event == "30650-02.htm" :
			st.set("cond","3")
			st.takeItems(VERY_EXPENSIVE_NECKLACE,1)
			st.playSound("ItemSound.quest_accept")
		elif event == "30520-05.htm" :
			st.set("cond","4")
			st.playSound("ItemSound.quest_accept")
		elif event == "30533-06.htm" :
			st.rewardItems(SCROLL_OF_ESCAPE_GIRAN,1)
			st.giveItems(MARK_OF_TRAVELER, 1)
			st.unset("cond")
			st.exitQuest(False)
			st.playSound("ItemSound.quest_finish")
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st: return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == 30533 and cond == 0 :
				if player.getRace().ordinal() == 4 :
					if player.getLevel() >= 3 :
						htmltext = "30533-02.htm"
					else :
						htmltext = "30533-01.htm"
						st.exitQuest(1)
				else :
					htmltext = "30533-01.htm"
					st.exitQuest(1)
		elif id == State.STARTED: 
			if npcId == 30533 :
				if cond == 1 :
					htmltext = "30533-04.htm"
				elif cond == 4 :
					htmltext = "30533-05.htm"
			elif npcId == 30520 :
				if cond == 1 :
					htmltext = "30520-01.htm"
				elif cond == 2 :
					htmltext = "30520-03.htm"
				elif cond == 3 :
					htmltext = "30520-04.htm"
				elif cond == 4 :
					htmltext = "30520-06.htm"
			elif npcId == 30650 :
				if cond == 2 :
					if st.getQuestItemsCount(VERY_EXPENSIVE_NECKLACE) == 1 :
						htmltext = "30650-01.htm"
				elif cond == 3 :
					htmltext = "30650-03.htm"
		return htmltext

QUEST		= Quest(10,qn,"迎向世界")

QUEST.addStartNpc(30533)

QUEST.addTalkId(30533)
QUEST.addTalkId(30520)
QUEST.addTalkId(30650)