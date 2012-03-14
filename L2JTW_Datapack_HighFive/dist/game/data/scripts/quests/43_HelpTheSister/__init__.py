# quest by zerghase
# Update by pmq 09-07-2010

import sys
from com.l2jserver import Config 
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "43_HelpTheSister"

# NPC
COOPER         = 30829
GALLADUCCI     = 30097
# ITEM
CRAFTED_DAGGER = 220
MAP_PIECE      = 7550
MAP            = 7551
PET_TICKET     = 7584
# MOBs
SPECTER        = 20171
SORROW_MAIDEN  = 20197
# ETC
MAX_COUNT = 30

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "1" :
			htmltext = "30829-01.htm"
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			st.setState(State.STARTED)
		elif event == "3" and st.getQuestItemsCount(CRAFTED_DAGGER):
			htmltext = "30829-03.htm"
			st.takeItems(CRAFTED_DAGGER,1)
			st.set("cond","2")
			st.playSound("ItemSound.quest_accept")
		elif event == "4" and st.getQuestItemsCount(MAP_PIECE) >= MAX_COUNT:
			htmltext = "30829-05.htm"
			st.takeItems(MAP_PIECE,MAX_COUNT)
			st.giveItems(MAP,1)
			st.set("cond","4")
			st.playSound("ItemSound.quest_accept")
		elif event == "5" and st.getQuestItemsCount(MAP):
			htmltext = "30097-06.htm"
			st.takeItems(MAP,1)
			st.set("cond","5")
			st.playSound("ItemSound.quest_accept")
		elif event == "7" :
			htmltext = "30829-07.htm"
			st.giveItems(PET_TICKET,1)
			st.unset("cond")
			st.exitQuest(False)
			st.playSound("ItemSound.quest_finish")
		return htmltext

	def onTalk(self, npc, player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED:
			if npcId == COOPER and cond == 0 :
				if player.getLevel() >= 26 :
					htmltext = "30829-00.htm"
				else:
					htmltext = "30829-00a.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == COOPER :
				if cond == 1:
					if not st.getQuestItemsCount(CRAFTED_DAGGER):
						htmltext = "30829-01a.htm"
					else:
						htmltext = "30829-02.htm"
				elif cond == 2:
					htmltext = "30829-03a.htm"
				elif cond == 3:
					htmltext = "30829-04.htm"
				elif cond == 4:
					htmltext = "30829-05a.htm"
				elif cond == 5:
					htmltext = "30829-06.htm"
			elif npcId == GALLADUCCI :
				if cond == 4 and st.getQuestItemsCount(MAP):
					htmltext = "30097-05.htm"
				elif cond == 5:
					htmltext = "30097-06a.htm"
		return htmltext

	def onKill(self,npc,player,isPet):
		st = player.getQuestState(qn)
		if not st : return 
		if st.getState() != State.STARTED : return

		npcId = npc.getNpcId()
		cond = st.getInt("cond")
		if cond == 2 :
			numItems,chance = divmod(100*Config.RATE_QUEST_DROP,100)
			if self.getRandom(100) < chance :
				numItems = numItems +1  
			pieces = st.getQuestItemsCount(MAP_PIECE)
			if pieces + numItems >= MAX_COUNT :
				numItems = MAX_COUNT - pieces
				if numItems != 0 :
					st.set("cond","3")
					st.playSound("ItemSound.quest_middle")
			else :
				st.playSound("ItemSound.quest_itemget")
			st.giveItems(MAP_PIECE,int(numItems))
		return

QUEST		= Quest(43,qn,"幫幫妹妹吧!")

QUEST.addStartNpc(COOPER)

QUEST.addTalkId(COOPER)
QUEST.addTalkId(GALLADUCCI)

QUEST.addKillId(SPECTER)
QUEST.addKillId(SORROW_MAIDEN)