# This is essentially a DrLecter's copy&paste from
# a Kilkenny's contribution to the Official L2J Datapack Project.
# Visit http://www.l2jdp.com/trac if you find a bug.
# Update by pmq 09-07-2010

import sys
from com.l2jserver import Config
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "52_WilliesSpecialBait"

# NPC
WILLIE             = 31574
# ITEMS
TARLK_EYE          = 7623
# REWARDS
EARTH_FISHING_LURE = 7612
# MOB
TARLK_BASILISK     = 20573

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [TARLK_EYE]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "31574-03.htm" :
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			st.setState(State.STARTED)
		elif event == "31574-07.htm" :
			if st.getQuestItemsCount(TARLK_EYE) == 100 :
				htmltext = "31574-06.htm"
				st.giveItems(EARTH_FISHING_LURE,4)
				st.takeItems(TARLK_EYE,-1)
				st.unset("cond")
				st.exitQuest(False)
				st.playSound("ItemSound.quest_finish")
			else :
				htmltext = "31574-07.htm"
		return htmltext

	def onTalk (Self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == WILLIE and cond == 0 :
				if player.getLevel() >= 48 :
					htmltext = "31574-01.htm"
				else:
					htmltext = "31574-02.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == WILLIE :
				if cond == 1 :
					htmltext = "31574-05.htm"
				elif cond == 2 :
					htmltext = "31574-04.htm"
		return htmltext

	def onKill(self,npc,player,isPet):
		partyMember = self.getRandomPartyMember(player,"1")
		if not partyMember : return
		st = partyMember.getQuestState(qn)
		if st :
			count = st.getQuestItemsCount(TARLK_EYE)
			if st.getInt("cond") == 1 and count < 100 :
				chance = 33 * Config.RATE_QUEST_DROP
				numItems, chance = divmod(chance,100)
				if self.getRandom(100) < chance : 
					numItems += 1
				if numItems :
					if count + numItems >= 100 :
						numItems = 100 - count
						st.set("cond","2")
						st.playSound("ItemSound.quest_middle")
					else:
						st.playSound("ItemSound.quest_itemget")
					st.giveItems(TARLK_EYE,int(numItems))
		return

QUEST		= Quest(52,qn,"威樂利的特製魚餌")

QUEST.addStartNpc(WILLIE)

QUEST.addTalkId(WILLIE)

QUEST.addKillId(TARLK_BASILISK)