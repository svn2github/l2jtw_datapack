# Made by disKret
# Update by pmq 03-07-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "13_ParcelDelivery"

# NPC
FUNDIN  = 31274
VULCAN  = 31539

# ITEM
PACKAGE = 7263

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [PACKAGE]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "31274-2.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.giveItems(PACKAGE,1)
			st.playSound("ItemSound.quest_accept")
		elif event == "31539-1.htm" :
			if st.getQuestItemsCount(PACKAGE) == 1 :
				st.takeItems(PACKAGE,1)
				st.giveItems(57,157834)
				st.addExpAndSp(589092,58794)
				st.unset("cond")
				st.exitQuest(False)
				st.playSound("ItemSound.quest_finish")
			else :
				htmltext = "任務道具不符"
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == FUNDIN and cond == 0 :
				if player.getLevel() < 74 :
					htmltext = "31274-1.htm"
					st.exitQuest(1)
				else : 
					htmltext = "31274-0.htm"
		elif id == State.STARTED :
			if npcId == FUNDIN :
				if cond == 1 :
					htmltext = "31274-3.htm"
			elif npcId == VULCAN :
				if cond == 1 :
					htmltext = "31539-0.htm"
		return htmltext

QUEST		= Quest(13,qn,"運送小貨物")

QUEST.addStartNpc(31274)

QUEST.addTalkId(31274)
QUEST.addTalkId(31539)