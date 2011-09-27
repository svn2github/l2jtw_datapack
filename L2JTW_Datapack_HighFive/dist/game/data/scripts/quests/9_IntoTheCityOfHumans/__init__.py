# Created by CubicVirtuoso
# Any problems feel free to drop by #l2j-datapack on irc.freenode.net

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "9_IntoTheCityOfHumans"

# NPCs
PETUKAI = 30583
TANAPI  = 30571
TAMIL   = 30576

# REWARDS
ADENA = 57
SCROLL_OF_ESCAPE_GIRAN = 7559
MARK_OF_TRAVELER = 7570

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "30583-03.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "30571-02.htm" :
			st.set("cond","2")
			st.playSound("ItemSound.quest_middle")
		elif event == "30576-02.htm" :
			st.giveItems(MARK_OF_TRAVELER, 1)
			st.giveItems(SCROLL_OF_ESCAPE_GIRAN,1)
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
			if npcId == PETUKAI and cond == 0 :
				if player.getRace().ordinal() == 3 :
					htmltext = "30583-01.htm"
					st.exitQuest(1)
					if player.getLevel() >= 3 :
						htmltext = "30583-02.htm"
					else:
						htmltext = "30583-01.htm"
						st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == TANAPI :
				if cond == 1 :
					htmltext = "30571-01.htm"
				elif cond == 2 :
					htmltext = "30571-03.htm"
			elif npcId == PETUKAI :
				if cond == 1 :
					htmltext = "30583-04.htm"
			elif npcId == TAMIL :
				if cond == 2 :
					htmltext = "30576-01.htm"
		return htmltext

QUEST		= Quest(9,qn,"往人類的都市")

QUEST.addStartNpc(PETUKAI)

QUEST.addTalkId(PETUKAI)
QUEST.addTalkId(TANAPI)
QUEST.addTalkId(TAMIL)