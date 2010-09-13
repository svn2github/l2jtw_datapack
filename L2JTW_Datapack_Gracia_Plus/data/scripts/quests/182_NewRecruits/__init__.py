# Update By pmq 14-09-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "182_NewRecruits"

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

		classId = int(st.getPlayer().getClassId().getId())

		if id == State.COMPLETED :
			htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == KEKROPUS and cond == 0 :
				if player.getRace().ordinal() != 5 :
					htmltext = "32138-00.htm"
					st.exitQuest(1)
				elif st.getPlayer().getLevel() >= 17 and classId in [0,10,18,25,31,38,44,49,53]:
					htmltext = "32138-01.htm"
				else :
					htmltext = "<center><font color=\"FF0000\">（功能尚未實裝！）</font></center>"
					st.exitQuest(1)
		elif id == State.STARTED:
			if npcId == KEKROPUS and cond == 1 :
				htmltext = "32138-04.htm"
		return htmltext

QUEST		= Quest(182,qn,"募集幫手")

QUEST.addStartNpc(32138)

QUEST.addTalkId(32138)