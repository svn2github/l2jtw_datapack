# Made by disKret
# Update by pmq 03-07-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "14_WhereaboutsOfTheArchaeologist"

# NPC
LIESEL              = 31263
GHOST_OF_ADVENTURER = 31538

# ITEM
LETTER              = 7253

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [LETTER]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "31263-2.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.giveItems(LETTER,1)
			st.playSound("ItemSound.quest_accept")
		elif event == "31538-1.htm" :
			if st.getQuestItemsCount(LETTER) == 1 :
				st.takeItems(LETTER,1)
				st.giveItems(57,136928)
				st.addExpAndSp(325881,32524)
				st.unset("cond")
				st.exitQuest(False)
				st.playSound("ItemSound.quest_finish")
			else :
				htmltext = "任務道具不符"
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
			if npcId == LIESEL and cond == 0 :
				if player.getLevel() < 74 : 
					htmltext = "31263-1.htm"
					st.exitQuest(1)
				else :
					htmltext = "31263-0.htm"
		elif id == State.STARTED :
			if npcId == LIESEL and cond == 1 :
				htmltext = "31263-2.htm"
			elif npcId == GHOST_OF_ADVENTURER and cond == 1 :
				htmltext = "31538-0.htm"
		return htmltext

QUEST		= Quest(14,qn,"考古學者的行蹤")

QUEST.addStartNpc(LIESEL)

QUEST.addTalkId(LIESEL)
QUEST.addTalkId(GHOST_OF_ADVENTURER)