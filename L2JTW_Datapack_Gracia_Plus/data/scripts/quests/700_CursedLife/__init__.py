# pmq
import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "700_CursedLife"

# 任務資料
# 700	1	受詛咒的生命	解放受詛咒的生命	柯塞勒斯同盟聯合基地的碼頭管理兵--士兵奧勒布，要求擊倒出現在不滅之種地區上空的路克和他的手下怪物們，來解放那些受到詛咒而失去自由的生命們。\n\n要獵殺的目標怪物-路克、突變鷹、龍鷹\n	3	13872	13873	13874												3	0	0	0												-174600	219711	4424	75	0	0	不滅之種 東邊空域	1	1	1	32560	-186072	241295	2613	沒有條件限制	柯塞勒斯同盟聯合基地的碼頭管理員--士兵奧勒布正在尋找冒險家，因為過去曾是他憧憬的對象，現在卻成了受詛咒的魔物，因此希望藉由剷除他們，然後為他們找回自由。聽說那個魔物居然會吞食出現在周圍的任何一個生命...	0																																																																						0						0	10273	0	285	1	1	57											1	0											

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
