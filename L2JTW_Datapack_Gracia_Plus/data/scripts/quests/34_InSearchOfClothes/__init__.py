# Made by disKret
# Update by pmq 08-07-2010

import sys
from com.l2jserver.util import Rnd
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "34_InSearchOfClothes"

# ITEM
SPINNERET        = 7528
SUEDE            = 1866
THREAD           = 1868
SPIDERSILK       = 1493
MYSTERIOUS_CLOTH = 7076

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [SPINNERET,SPIDERSILK]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "30088-1.htm" :
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			st.setState(State.STARTED)
		elif event == "30294-1.htm" :
			st.set("cond","2")
			st.playSound("ItemSound.quest_accept")
		elif event == "30088-3.htm" :
			st.set("cond","3")
			st.playSound("ItemSound.quest_accept")
		elif event == "30165-1.htm" :
			st.set("cond","4")
			st.playSound("ItemSound.quest_accept")
		elif event == "30165-3.htm" :
			if st.getQuestItemsCount(SPINNERET) == 10 :
				st.takeItems(SPINNERET,10)
				st.giveItems(SPIDERSILK,1)
				st.set("cond","6")
				st.playSound("ItemSound.quest_accept")
			else :
				htmltext = "30165-1a.htm"
		elif event == "30088-5.htm" :
			if st.getQuestItemsCount(SUEDE) >= 3000 and st.getQuestItemsCount(THREAD) >= 5000 and st.getQuestItemsCount(SPIDERSILK) == 1 :
				st.takeItems(SUEDE,3000)
				st.takeItems(THREAD,5000)
				st.takeItems(SPIDERSILK,1)
				st.giveItems(MYSTERIOUS_CLOTH,1)
				st.unset("cond")
				st.exitQuest(False)
				st.playSound("ItemSound.quest_finish")
			else :
				htmltext = "30088-4a.htm"
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED:
			htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == 30088 and cond == 0 and st.getQuestItemsCount(MYSTERIOUS_CLOTH) == 0 :
				fwear=player.getQuestState("37_PleaseMakeMeFormalWear")
				if fwear :
					if fwear.get("cond") == "6" :
						htmltext = "30088-0.htm"
					else :
						htmltext = "30088-6.htm"
						st.exitQuest(1)
				else :
					htmltext = "30088-6.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == 30294 :
				if cond == 1 :
					htmltext = "30294-0.htm"
				elif cond == 2 :
					htmltext = "30294-1a.htm"
			elif npcId == 30088 :
				if cond == 1 :
					htmltext = "30088-1a.htm"
				elif cond == 2 :
					htmltext = "30088-2.htm"
				elif cond in [3,4,5] :
					htmltext = "30088-3a.htm"
				elif cond == 6 :
					htmltext = "30088-4.htm"
			elif npcId == 30165 :
				if cond == 3 :
					htmltext = "30165-0.htm"
				elif cond == 4 :
					htmltext = "30165-1a.htm"
				elif cond == 5 :
					htmltext = "30165-2.htm"
				elif cond == 6 :
					htmltext = "30165-3a.htm"
		return htmltext

	def onKill(self,npc,player,isPet):
		partyMember = self.getRandomPartyMember(player,"4")
		if not partyMember : return
		st = partyMember.getQuestState(qn)
		if not st : return 
		if st.getState() != State.STARTED : return

		count = st.getQuestItemsCount(SPINNERET)
		if count <= 10 :
			st.giveItems(SPINNERET,1)
			if count == 9 :
				st.playSound("ItemSound.quest_middle")
				st.set("cond","5")
			else :
				st.playSound("ItemSound.quest_itemget")
		return

QUEST		= Quest(34,qn,"尋找布料")

QUEST.addStartNpc(30088)

QUEST.addTalkId(30088)
QUEST.addTalkId(30165)
QUEST.addTalkId(30294)

QUEST.addKillId(20560)
QUEST.addKillId(20561)