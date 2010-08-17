#authoor by d0S

import sys

from com.l2jserver.gameserver.datatables import SkillTable
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "695_DefendTheHallOfSuffering"

# 任務資料
# 695	1	苦痛棺室防禦	防衛苦痛棺室	在不滅之種內部的等候室，軍官特普歐司交代了防衛苦痛棺室的任務。先阻擋所有房間內的破損的腫瘤體復活，然後再去處理雙胞胎死亡騎士。\n\n要獵殺的目標怪物-艾罕 克蘭尼庫斯、艾罕 克羅迪庫斯\n	0															0															0	0	0	75	82	0	苦痛棺室	1	1	1	32603	-183296	205715	-12896	沒有條件限制	不死軍團試圖找回被冒險家們所佔領的苦痛棺室，然後藉此想要恢復力量。因此在不滅之種地區的等候室，軍官特普歐司正在尋找冒險家來阻止此事發生。	0																																																																						0						0	0	0	285	1	2	-1002	736										2	0	1										

#NPCs
Keucereus     = 32548
Tepios        = 32603
Tepiosinst    = 32530
Mouthofekimus = 32537

#items
Mark = 13691

class Quest (JQuest) :
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [Mark]
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
		elif id == State.CREATED and npcId == Tepios and cond == 0:
			if player.getLevel() >= 75 and player.getLevel() <= 82 and st.getQuestItemsCount(Mark) == 1:
				htmltext = "32603-01.htm"
			elif player.getLevel() >= 75 and player.getLevel() <= 82 and st.getQuestItemsCount(Mark) == 0:
				htmltext = "32603-05.htm"
			else :
				htmltext = "32603-00.htm"
		elif id == State.STARTED and npcId == Mouthofekimus and cond == 1:
			htmltext = "32537-01.htm"
		elif id == State.STARTED and npcId == Tepiosinst and cond == 1:
			htmltext = "32530-01.htm"
			self.Lock = 1
		elif id == State.STARTED and npcId == Tepios and cond == 1:
			if self.Lock == 1:
				if st.getQuestItemsCount(Mark) == 1:
					htmltext = "32603-04.htm"
					st.exitQuest(True)
					st.giveItems(736,1)
				else :
					htmltext = "32603-04.htm"
					st.exitQuest(True)
					st.giveItems(736,1)
				st.playSound("ItemSound.quest_finish")
				self.Lock = 0
			else :
				htmltext = "32603-04.htm"
		return htmltext

QUEST		= Quest(695,qn,"苦痛棺室防禦")

QUEST.addStartNpc(Tepios)
QUEST.addTalkId(Tepios)
QUEST.addStartNpc(Mouthofekimus)
QUEST.addTalkId(Mouthofekimus)
QUEST.addTalkId(Tepiosinst)