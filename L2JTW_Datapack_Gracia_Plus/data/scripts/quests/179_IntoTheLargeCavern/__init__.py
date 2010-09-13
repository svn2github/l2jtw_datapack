# Update by pmq 14-09-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "179_IntoTheLargeCavern"

#NPC'S
KEKROPUS = 32138

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
 
	def onAdvEvent (self,event,npc,player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		if event == "32138-03.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st: return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")
		st1 = player.getQuestState("178_IconicTrinity")

		if id == State.COMPLETED :
			htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == KEKROPUS and cond == 0 :
				if not player.getRace().ordinal() != 5 :
					htmltext = "32138-00.htm"
					st.exitQuest(1)
				elif st.getPlayer().getLevel() >= 17 and st1.getState() == State.COMPLETED :
					htmltext = "32138-01.htm"
				else :
					htmltext = "32138-01a.htm"
					st.exitQuest(1)
		elif id == State.STARTED:
			if npcId == KEKROPUS and cond == 1 :
				htmltext = "32138-05.htm"
		return htmltext

QUEST		= Quest(179,qn,"進入大空洞")

QUEST.addStartNpc(32138)

QUEST.addTalkId(32138)