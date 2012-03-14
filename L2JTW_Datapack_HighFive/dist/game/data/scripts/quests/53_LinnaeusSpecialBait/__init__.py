# Linnaeus Special Bait - a seamless merge from Next and DooMita contributions
# Update by pmq 09-07-2010

import sys
from com.l2jserver import Config
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "53_LinnaeusSpecialBait"

# NPC
LINNAEUS             = 31577
# MOB
CRIMSON_DRAKE        = 20670
# ITEM
CRIMSON_DRAKE_HEART  = 7624
FLAMING_FISHING_LURE = 7613

class Quest (JQuest):

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [CRIMSON_DRAKE_HEART]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "31577-1.htm":
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			st.setState(State.STARTED)
		elif event == "31577-4.htm":
			if st.getQuestItemsCount(CRIMSON_DRAKE_HEART) == 100:
				st.takeItems(CRIMSON_DRAKE_HEART, 100)
				st.giveItems(FLAMING_FISHING_LURE, 4)
				st.unset("cond")
				st.exitQuest(False)
				st.playSound("ItemSound.quest_finish")
				htmltext = "31577-4.htm"
			else :
				htmltext = "31577-5.htm"
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
			if npcId == LINNAEUS and cond == 0 :
				if player.getLevel() >= 60 :
					htmltext= "31577-0.htm"
				else:
					htmltext = "31577-0a.htm"
					st.exitQuest(1)
		elif id == State.STARTED:
			if npcId == LINNAEUS :
				if cond == 1 :
					htmltext = "31577-3.htm"
				elif cond == 2 :
					htmltext = "31577-2.htm"
		return htmltext

	def onKill(self,npc,player,isPet):
		partyMember = self.getRandomPartyMember(player,"1")
		if not partyMember : return
		st = partyMember.getQuestState(qn)
		if st :
			count = st.getQuestItemsCount(CRIMSON_DRAKE_HEART)
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
					st.giveItems(CRIMSON_DRAKE_HEART,int(numItems))
		return

QUEST		= Quest(53, qn, "里奈歐斯的特製魚餌")

QUEST.addStartNpc(LINNAEUS)

QUEST.addTalkId(LINNAEUS)

QUEST.addKillId(CRIMSON_DRAKE)