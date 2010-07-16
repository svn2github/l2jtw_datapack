# Made by disKret, Ancient Legion Server
# Update by pmq 03-07-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "16_TheComingDarkness"

# NPC
HIERARCH     = 31517
EVIL_ALTAR_1 = 31512
EVIL_ALTAR_2 = 31513
EVIL_ALTAR_3 = 31514
EVIL_ALTAR_4 = 31515
EVIL_ALTAR_5 = 31516

# ITEMS
CRYSTAL_OF_SEAL = 7167

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "31517-2.htm" :
			st.giveItems(CRYSTAL_OF_SEAL,5)
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "31512-1.htm" :
			st.takeItems(CRYSTAL_OF_SEAL,1)
			st.set("cond","2")
			st.playSound("ItemSound.quest_middle")
		elif event == "31513-1.htm" :
			st.takeItems(CRYSTAL_OF_SEAL,1)
			st.set("cond","3")
			st.playSound("ItemSound.quest_middle")
		elif event == "31514-1.htm" :
			st.takeItems(CRYSTAL_OF_SEAL,1)
			st.set("cond","4")
			st.playSound("ItemSound.quest_middle")
		elif event == "31515-1.htm" :
			st.takeItems(CRYSTAL_OF_SEAL,1)
			st.set("cond","5")
			st.playSound("ItemSound.quest_middle")
		elif event == "31516-1.htm" :
			st.takeItems(CRYSTAL_OF_SEAL,1)
			st.set("cond","6")
			st.playSound("ItemSound.quest_middle")
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		st2 = player.getQuestState("17_LightAndDarkness")

		if id == State.COMPLETED :
			htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == HIERARCH:
				if st2 and st2.getState() == State.COMPLETED :
					if player.getLevel() >= 62 :
						htmltext = "31517-0.htm"
					else:
						htmltext = "<html><body>（等級62以上的角色才可以執行的任務。）</body></html>"
						st.exitQuest(1)
				else:
					htmltext = "<html><body>必須先完成「光輝染上黑暗」的任務。</body></html>"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == EVIL_ALTAR_1 and cond == 1 :
				htmltext = "31512-0.htm"
			elif npcId == EVIL_ALTAR_2 and cond == 2 :
				htmltext = "31513-0.htm"
			elif npcId == EVIL_ALTAR_3 and cond == 3 :
				htmltext = "31514-0.htm"
			elif npcId == EVIL_ALTAR_4 and cond== 4 :
				htmltext = "31515-0.htm"
			elif npcId == EVIL_ALTAR_5 and cond == 5 :
				htmltext = "31516-0.htm"
			elif npcId == HIERARCH and cond == 6 :
				htmltext = "31517-3.htm"
				st.addExpAndSp(865187,69172)
				st.unset("cond")
				st.exitQuest(False)
				st.playSound("ItemSound.quest_finish")
		return htmltext

QUEST		= Quest(16,qn,"即將來臨的黑暗")

QUEST.addStartNpc(31517)

QUEST.addTalkId(31517)

for altars in range(31512,31517):
  QUEST.addTalkId(altars)