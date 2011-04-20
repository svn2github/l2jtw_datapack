# Made by disKret
# Update by pmq 03-07-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "15_SweetWhisper"

# NPC
VLADIMIR      = 31302
HIERARCH      = 31517
M_NECROMANCER = 31518

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "31302-1.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "31518-1.htm" :
			st.set("cond","2")
			st.playSound("ItemSound.quest_middle")
		elif event == "31517-1.htm" :
			st.addExpAndSp(350531,28204)
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
			if player.getLevel() >= 60 :
				htmltext = "31302-0.htm"
			else:
				htmltext = "31302-0a.htm"
				st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == VLADIMIR :
				if cond == 1:
					htmltext = "31302-1a.htm"
			elif npcId == M_NECROMANCER :
				if cond == 1 :
					htmltext = "31518-0.htm"
				elif cond == 2 :
					htmltext = "31518-1a.htm"
			elif npcId == HIERARCH :
				if cond == 2 :
					htmltext = "31517-0.htm"
		return htmltext

QUEST		= Quest(15,qn,"甜美的細語")

QUEST.addStartNpc(31302)

QUEST.addTalkId(31302)
QUEST.addTalkId(31517)
QUEST.addTalkId(31518)