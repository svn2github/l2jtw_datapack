# Update by pmq 
import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "125_TheNameOfEvil-1"

# NPC
MUSHIKA     = 32114
KARAKAWEI   = 32117
ULU_KAIMU   = 32119
BALU_KAIMU  = 32120
CHUTA_KAIMU = 32121

# ITEM
EPITAPH_OF_WISDOM = 8781
GAZKH_FRAGMENT    = 8782
BONE_POWDER       = 8783

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "32114-05.htm" :
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			st.setState(State.STARTED)
		elif event == "32114-08.htm" :
			st.set("cond","2")
			st.playSound("ItemSound.quest_accept")
		elif event == "32117-08.htm" :
			st.set("cond","3")
			st.playSound("ItemSound.quest_accept")
		return htmltext


	def onTalk (self,npc,player) :
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st: return htmltext

		id = st.getState()
		npcId = npc.getNpcId()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == 32114 and cond == 0 :
				if st.getPlayer().getLevel() >= 76 and player.getQuestState("124_MeetingTheElroki") == State.COMPLETED :
					htmltext = "32114-01.htm"
				else :
					htmltext = "32114-00.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == 32114 :
				if cond == 1 :
					htmltext = "32114-05.htm"
				elif cond == 2 :
					htmltext = "32114-09.htm"
				elif cond in [3,4,5,6,7,8] :
					htmltext = "32114-10.htm"
				elif cond == 9 :
					htmltext = "32114-0.htm"
			elif npcId == 32117 :
				if cond == 2 :
					htmltext = "32117-01.htm"
				elif cond == 3 :
					htmltext = "32117-09.htm"
				elif cond == 4 :
					htmltext = "32117-0.htm"
				elif cond == 5 :
					htmltext = "32117-0.htm"
				elif cond in [6,7,8] :
					htmltext = "32117-0.htm"
				elif cond == 9 :
					htmltext = "32117-0.htm"
			elif npcId == 32119 :
				if cond == 6 :
					htmltext = "32119-01.htm"
			elif npcId == 32120 :
				if cond == 7 :
					htmltext = "32120-01.htm"
			elif npcId == 32121 :
				if cond == 8 :
					htmltext = "32121-01.htm"
		return htmltext

	def onKill(self,npc,player,isPet):
		st = player.getQuestState(qn)
		if not st: return
		npcId = npc.getNpcId()
		cond = st.getInt("cond")
		if cond == 3 :
			if npcId in [22200,22201,22202,22219] :
				if st.getRandom(100) < 75 :
					st.giveItems(8779,1)
					if st.getQuestItemsCount(8779) <= 1 :
						st.playSound("ItemSound.quest_itemget")
			elif npcId in [22203,22204,22205,22220] :
				if st.getRandom(100) < 75 :
					st.giveItems(8780,1)
					if st.getQuestItemsCount(8780) <= 1 :
						st.playSound("ItemSound.quest_itemget")
			if st.getQuestItemsCount(8779) >= 2 and st.getQuestItemsCount(8780) >= 2 :
				st.set("cond","4")  
				st.playSound("ItemSound.quest_middle")
		return

QUEST		= Quest(125,qn,"凶神之名為 第一部")

QUEST.addStartNpc(32114)

for i in [32114,32117,32119,32120,32121] :
    QUEST.addTalkId(i)
 
for i in [22200,22201,22202,22203,22204,22205,22219,22220] :
    QUEST.addKillId(i)