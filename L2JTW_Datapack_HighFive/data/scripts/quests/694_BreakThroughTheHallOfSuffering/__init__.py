#authoor by d0S

import sys

from com.l2jserver.gameserver.datatables import SkillTable
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "694_BreakThroughTheHallOfSuffering"

# 任務資料
# 694	1	苦痛棺室突破	處決雙胞胎死亡騎士	在不滅之種內部的等候室，軍官特普歐司交代了突破苦痛棺室的任務。突破5個房間之後，消滅守護最後一個房間的雙胞胎死亡騎士。\n\n要獵殺的目標怪物-艾罕 克蘭尼庫斯、艾罕 克羅迪庫斯\n	0															0															0	0	0	75	82	0	苦痛棺室	1	1	1	32603	-183296	205715	-12896	沒有條件限制	在不滅之種地區的等候室，軍官特普歐司正在尋找冒險家來處理守護苦痛棺室的殘酷雙胞胎--不死生物死亡騎士。	0																																																																						0						0	0	0	285	1	3	-1002	736	13691									3	0	1	1									

#NPCs
Keucereus     = 32548
Tepios        = 32603
Tepiosinst    = 32530
Mouthofekimus = 32537
Klodekus      = 25665
Klanikus      = 25666

#items
Mark = 13691

class Quest (JQuest) :
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		#self.questItemIds = [Mark]
		self.Lock = 0

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "32603-02.htm" :
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

		if id == State.COMPLETED :
			htmltext = "32603-03.htm"
		elif id == State.CREATED :
			if npcId == Tepios and cond == 0 :
				if player.getLevel() >= 75 and player.getLevel() <= 82:
					htmltext = "32603-01.htm"
				elif player.getLevel() > 82 and st.getQuestItemsCount(Mark) == 0:
					st.giveItems(13691,1)
					st.playSound("ItemSound.quest_middle")
					st.setState(State.COMPLETED)
					htmltext = "32603-05.htm"
				else :
					htmltext = "32603-00.htm"
		elif id == State.STARTED and npcId == Mouthofekimus and cond == 1:
			htmltext = "32537-01.htm"
		elif id == State.STARTED and npcId == Tepiosinst and cond == 1:
			htmltext = "32530-1.htm"
			self.Lock = 1
		elif id == State.STARTED and npcId == Tepios and cond == 1:
			if self.Lock == 1:
				if st.getQuestItemsCount(Mark) == 0:
					htmltext = "32603-04.htm"
					st.exitQuest(True)
					st.giveItems(13691,1)
					st.giveItems(736,1)
				else :
					htmltext = "32603-04.htm"
					st.exitQuest(True)
					st.giveItems(736,1)
				st.playSound("ItemSound.quest_finish")
			else :
				htmltext = "32603-04.htm"
		return htmltext

QUEST		= Quest(694,qn,"苦痛棺室突破")

QUEST.addStartNpc(Tepios)
QUEST.addTalkId(Tepios)
QUEST.addStartNpc(Mouthofekimus)
QUEST.addTalkId(Mouthofekimus)
QUEST.addTalkId(Tepiosinst)