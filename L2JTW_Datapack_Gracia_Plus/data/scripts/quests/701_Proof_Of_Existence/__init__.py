# 2010-06-26 by Gnacik
# Based on official server Franz

import sys
from com.l2jserver import Config
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "701_Proof_Of_Existence"

# 任務資料
# 701	1	存在的反證	擊退魔物	柯塞勒斯同盟聯合基地的戰鬥法師爾堤吾斯說道，降低士兵士氣的原因是來自於班席女王--愛尼拉這個魔物。狩獵她之後，證明她不是士兵們需要如此感到恐懼的對象。作為成功獵捕的憑證，帶回班席女王的眼球、亡者遺骸。\n\n要獵殺的目標怪物-班席女王--愛尼拉、浮游骨骸、浮游殭屍\n	2	13875	13876													2	0	0													-181958	208968	4424	78	0	0	不滅之種 東邊空域	1	1	1	32559	-186109	242500	2550	沒有條件限制	在不滅之種地區附近交接任務後回來的士兵們目睹了魔物，因此鬧得整個軍團降低了士氣，而柯塞勒斯同盟聯合基地的戰鬥法師爾堤吾斯正為此擔心，於是正在尋找冒險家來解決此事...	0																																																																						0						0	10273	0	285	1	1	57											1	0											

# NPCs
ARTIUS = 32559

# ITEMS
DEADMANS_REMAINS = 13875

# MOBS
MOBS = [22606,22607,22608,22609]

# SETTINGS
DROP_CHANCE = 80

class Quest (JQuest) :
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [DEADMANS_REMAINS]

	def onAdvEvent(self, event, npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		if event == "32559-03.htm" :
			st.setState(State.STARTED)
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
		elif event == "32559-quit.htm" :
			st.unset("cond")
			st.exitQuest(True)
			st.playSound("ItemSound.quest_finish")
		return htmltext

	def onTalk (self, npc, player) :
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		cond = st.getInt("cond")

		if npc.getNpcId() == ARTIUS :
			first = player.getQuestState("10273_GoodDayToFly")
			if first and first.getState() == State.COMPLETED and st.getState() == State.CREATED and player.getLevel() >= 78 :
				htmltext = "32559-01.htm"
			elif cond == 1 :
				itemcount = st.getQuestItemsCount(DEADMANS_REMAINS)
				if itemcount > 0 :
					st.takeItems(DEADMANS_REMAINS, -1)
					st.rewardItems(57,itemcount * 2500)
					st.playSound("ItemSound.quest_itemget")
					htmltext = "32559-06.htm"
				else :
					htmltext = "32559-04.htm"
			elif cond == 0 :
				htmltext = "32559-00.htm"
		return htmltext

	def onKill(self, npc, player, isPet) :
		st = player.getQuestState(qn)
		if not st : return

		if st.getInt("cond") == 1 and npc.getNpcId() in MOBS :
			numItems, chance = divmod(DROP_CHANCE * Config.RATE_QUEST_DROP,100)
			if st.getRandom(100) < chance :
				numItems += 1
			if numItems :
				st.giveItems(DEADMANS_REMAINS,1)
				st.playSound("ItemSound.quest_itemget")
		return

QUEST	= Quest(701,qn,"存在的反證")

QUEST.addStartNpc(ARTIUS)
QUEST.addTalkId(ARTIUS)

for i in MOBS :
	QUEST.addKillId(i)