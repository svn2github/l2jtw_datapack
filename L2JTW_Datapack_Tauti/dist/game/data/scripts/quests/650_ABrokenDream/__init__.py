# made by ethernaly
# Update by pmq

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "650_ABrokenDream"

# NPC
GHOST    = 32054
# MOBS
CREWMAN  = 22027
VAGABOND = 22028
# DROP
DREAM_FRAGMENT_ID = 8514
# CHANCE
CHANCE = 68

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [DREAM_FRAGMENT_ID]

	def onAdvEvent (self,event,npc,player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		if event == "2a.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "500.htm" :
			st.playSound("ItemSound.quest_finish")
			st.exitQuest(1)
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.CREATED :
			Ocean = player.getQuestState("117_OceanOfDistantStar")
			if npcId == GHOST and cond == 0 :
				if Ocean.getState() == State.COMPLETED :
					if st.getPlayer().getLevel() >= 39:
						htmltext = "200.htm"
					else :
						htmltext = "100.htm"
						st.exitQuest(1)
				else :
					htmltext = "600.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == GHOST and cond == 1 :
				if st.getQuestItemsCount(DREAM_FRAGMENT_ID):
					htmltext = "2b.htm"
				else :
					htmltext = "400b.htm"
		return htmltext

	def onKill(self,npc,player,isPet):
		partyMember = self.getRandomPartyMember(player,"1")
		if not partyMember : return
		st = partyMember.getQuestState(qn)
		if st :
			if st.getState() == State.STARTED :
				if self.getRandom(100) < CHANCE :
					st.giveItems(DREAM_FRAGMENT_ID,1)
					st.playSound("ItemSound.quest_itemget")
		return

QUEST		= Quest(650, qn, "對未完成夢想的執著")

QUEST.addStartNpc(GHOST)

QUEST.addTalkId(GHOST)
QUEST.addKillId(CREWMAN)
QUEST.addKillId(VAGABOND)