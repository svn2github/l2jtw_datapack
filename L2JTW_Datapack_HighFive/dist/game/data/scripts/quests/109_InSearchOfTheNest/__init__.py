# Created by pmq
# High Five 22-02-2011
import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "109_InSearchOfTheNest"

# Npc
PIERCE  = 31553  # 傭兵隊長 比斯
CORPSE  = 32015  # 偵查兵的屍體
KAHMAN  = 31554  # 傭兵 卡姆恩
# Item
MEMO    = 8083   # 偵查兵的偵查記錄

class Quest (JQuest):

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [MEMO]

	def onAdvEvent (self,event,npc,player):
		htmltext = event
		st = player.getQuestState(qn)
		if not st: return

		if event == "31553-02.htm":
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "32015-02.htm":
			st.giveItems(MEMO,1)
			st.set("cond","2")
			st.playSound("ItemSound.quest_itemget")
		elif event == "31553-05.htm":
			st.takeItems(MEMO,-1)
			st.set("cond","3")
			st.playSound("ItemSound.quest_middle")
		elif event == "31554-02.htm":
			st.giveItems(57,161500)
			st.addExpAndSp(701500,50000)
			st.unset("cond")
			st.exitQuest(False)
			st.playSound("ItemSound.quest_finish")
		return htmltext

	def onTalk(self, npc, player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st :return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == PIERCE :
				if st.getPlayer().getLevel() >= 81 :
					htmltext = "31553-01.htm"
				else :
					htmltext = "31553-00.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == PIERCE :
				if cond == 1 :
					htmltext = "31553-03.htm"
				elif cond == 2 :
					htmltext = "31553-04.htm"
				elif cond == 3 :
					htmltext = "31553-06.htm"
			elif npcId == CORPSE :
				if cond == 1 :
					htmltext = "32015-01.htm"
				elif cond == 2 :
					htmltext = "32015-03.htm"
			elif npcId == KAHMAN :
				if cond == 3 :
					htmltext = "31554-01.htm"
		return htmltext

QUEST		= Quest(109,qn,"尋找巢穴")

QUEST.addStartNpc(PIERCE)

QUEST.addTalkId(PIERCE)
QUEST.addTalkId(CORPSE)
QUEST.addTalkId(KAHMAN)