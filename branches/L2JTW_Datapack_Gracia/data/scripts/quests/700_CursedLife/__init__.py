# pmq
import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "700_CursedLife"

#NPC
NPC = 32560

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = []

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "32560-00.htm" :
			st2 = player.getQuestState("10273_GoodDayToFly")
			if st2 and st2.getState() == State.COMPLETED and player.getLevel() >= 75 :
				htmltext = "32560-01.htm"
			else :
				htmltext = "32560-00.htm"
				st.exitQuest(1) 
		elif event == "32560-04.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.CREATED :
			if npcId == 32560 and cond == 0 :
				htmltext = "32560-01.htm"
		elif id == State.STARTED :
			if npcId == 32560 and cond == 1 :
				htmltext = "32560-05.htm"
		return htmltext

QUEST		= Quest(700,qn,"受詛咒的生命")

QUEST.addStartNpc(NPC)

QUEST.addTalkId(NPC)
