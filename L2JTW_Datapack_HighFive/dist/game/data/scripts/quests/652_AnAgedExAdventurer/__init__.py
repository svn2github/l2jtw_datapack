# Made by Kerb
import sys
from com.l2jserver import Config
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "652_AnAgedExAdventurer"
#Npc
TANTAN = 32012
SARA = 30180

#Items
CSS = 1464

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		if event == "32012-02.htm" :
			if st.getQuestItemsCount(CSS) > 99 :
				st.set("cond","1")
				st.setState(State.STARTED)
				st.playSound("ItemSound.quest_accept")
				st.takeItems(CSS,100)
				npc.deleteMe()
			else :
				htmltext = "32012-02a.htm"
			
		elif event == "32012-03.htm" :
			st.exitQuest(1)
			st.playSound("ItemSound.quest_giveup")
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st: return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.CREATED :
			if npcId == TANTAN and cond == 0 :
				if st.getPlayer().getLevel() >= 46 :
					htmltext = "32012-01.htm"
				else:
					htmltext = "32012-00.htm"
					st.exitQuest(1)
		elif id == State.STARTED:
			if npcId == SARA and cond == 1 :
				htmltext = "30180-01.htm"
				EAD_CHANCE = self.getRandom(100)
				st.giveItems(57,5026)
				if EAD_CHANCE <= 50:
					st.rewardItems(956,1)
				st.playSound("ItemSound.quest_finish")
				st.exitQuest(1)
		return htmltext

QUEST		= Quest(652,qn,"以前曾是冒險家的老人")

QUEST.addStartNpc(TANTAN)

QUEST.addTalkId(TANTAN)
QUEST.addTalkId(SARA)