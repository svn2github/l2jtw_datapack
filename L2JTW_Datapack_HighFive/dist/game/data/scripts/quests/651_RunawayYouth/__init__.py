# Made by Polo & DrLecter
import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "651_RunawayYouth"
#Npc
IVAN = 32014
BATIDAE = 31989

#Items
SOE = 736

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc,player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		if event == "32014-03.htm" :
			if st.getQuestItemsCount(SOE):
				st.set("cond","1")
				st.setState(State.STARTED)
				st.playSound("ItemSound.quest_accept")
				st.takeItems(SOE,1)
				npc.deleteMe()
			else :
				htmltext = "32014-04.htm"
		elif event == "32014-04a.htm" :
			st.exitQuest(1)
			st.playSound("ItemSound.quest_giveup")
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.CREATED:
			if npcId == IVAN and cond == 0 :
				if player.getLevel() >= 26 :
					htmltext = "32014-02.htm"
				else:
					htmltext = "32014-01.htm"
					st.exitQuest(1)
		elif id == State.STARTED:
			if npcId == BATIDAE and cond == 1 :
				htmltext = "31989-01.htm"
				st.giveItems(57,2883)
				st.playSound("ItemSound.quest_finish")
				st.exitQuest(1)
		return htmltext

QUEST		= Quest(651,qn,"離家少年")

QUEST.addStartNpc(IVAN)

QUEST.addTalkId(IVAN)
QUEST.addTalkId(BATIDAE)