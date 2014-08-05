# Made by DooMIta (ethernaly@email.it) and DrLecter.
# Visit http://www.l2jdp.com/trac if you find a bug and wish to report it.
# Visit http://www.l2jdp.com/forum/ for more details about our community and the project.
import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "27_ChestCaughtWithABaitOfWind"

#NPC
LANOSCO = 31570
SHALING = 31434

#QUEST ITEMs and REWARD
BLUE_TREASURE_BOX    = 6500
STRANGE_BLUESPRINT   = 7625
BLACK_PEARL_RING     = 880

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event== "31570-03.htm" :
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			st.setState(State.STARTED)
		elif event == "31570-05.htm" and st.getQuestItemsCount(BLUE_TREASURE_BOX) :
			htmltext="31570-06.htm"
			st.giveItems(STRANGE_BLUESPRINT, 1)
			st.takeItems(BLUE_TREASURE_BOX,-1)
			st.set("cond","2")
			st.playSound("ItemSound.quest_middle")
		elif event == "31434-02.htm" and st.getQuestItemsCount(BLACK_PEARL_RING) :
			htmltext = "31434-01.htm"
			st.giveItems(BLACK_PEARL_RING, 1)
			st.takeItems(STRANGE_BLUESPRINT,-1)
			st.unset("cond")
			st.exitQuest(False)
			st.playSound("ItemSound.quest_finish")
		return htmltext

	def onTalk(self, npc, player):
		htmltext="<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == LANOSCO and cond == 0 :
				if player.getLevel() >= 27 :
					LanoscosSpecialBait = player.getQuestState("50_LanoscosSpecialBait")
					if LanoscosSpecialBait.getState() == State.COMPLETED :
						htmltext = "31570-01.htm"
					else :
						htmltext = "31570-02.htm"
						st.exitQuest(1)
				else :
					htmltext = "31570-02.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == LANOSCO :
				if cond == 1 :
					if st.getQuestItemsCount(BLUE_TREASURE_BOX) :
						htmltext = "31570-03.htm"
					else :
						htmltext = "31570-04.htm"
				else :
					htmltext = "31570-05.htm"
			elif npcId == SHALING :
				if cond == 1:
					htmltext = "31434-00.htm"
		return htmltext

QUEST		=Quest(27,qn,"以風魚餌釣的箱子")

QUEST.addStartNpc(LANOSCO)

QUEST.addTalkId(LANOSCO)
QUEST.addTalkId(SHALING)