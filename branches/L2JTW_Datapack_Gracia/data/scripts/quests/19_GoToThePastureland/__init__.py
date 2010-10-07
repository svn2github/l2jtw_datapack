# Made by disKret
# Update by pmq 03-07-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "19_GoToThePastureland"

# NPC
VLADIMIR   = 31302
TUNATUN    = 31537

# ITEMS
BEAST_MEAT = 7547

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [BEAST_MEAT]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "31302-1.htm" :
			st.giveItems(BEAST_MEAT,1)
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "31537-1.htm" :
			st.takeItems(BEAST_MEAT,1)
			st.giveItems(57,50000)
			st.addExpAndSp(136766,12688)
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
			if npcId == VLADIMIR and cond == 0 :
				if player.getLevel() >= 63 :
					htmltext = "31302-0.htm"
				else:
					htmltext = "31302-0a.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == VLADIMIR and cond == 1 :
				htmltext = "31302-2.htm"
			elif npcId == TUNATUN and cond == 1 :
				htmltext = "31537-0.htm"
		return htmltext

QUEST		= Quest(19,qn,"前往放牧場吧!")

QUEST.addStartNpc(VLADIMIR)

QUEST.addTalkId(VLADIMIR)
QUEST.addTalkId(TUNATUN)