# Create by Skeleton!!!
# Update by pmq 08-07-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "28_ChestCaughtWithABaitOfIcyAir"

# NPC
OFulle = 31572
Kiki   = 31442
# ITEM
BigYellowTreasureChest = 6503
KikisLetter            = 7626
ElvenRing              = 881

class Quest (JQuest) :
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "31572-04.htm" :
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			st.setState(State.STARTED)
		elif event == "31572-07.htm" :
			if st.getQuestItemsCount(BigYellowTreasureChest) :
				st.set("cond","2")
				st.playSound("ItemSound.quest_middle")
				st.takeItems(BigYellowTreasureChest,1)
				st.giveItems(KikisLetter,1)
			else :
				htmltext = "31572-08.htm"
		elif event == "31442-02.htm" :
			if st.getQuestItemsCount(KikisLetter) == 1 :
				htmltext = "31442-02.htm"
				st.takeItems(KikisLetter,-1)
				st.giveItems(ElvenRing,1)
				st.unset("cond")
				st.exitQuest(False)
				st.playSound("ItemSound.quest_finish")
			else :
				htmltext = "31442-03.htm"
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			htmltext="<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == OFulle and cond == 0 :
				if player.getLevel() >= 36 :
					OFullesSpecialBait = player.getQuestState("51_OFullesSpecialBait")
					if OFullesSpecialBait :
						if OFullesSpecialBait.getState() == State.COMPLETED :
							htmltext = "31572-01.htm"
						else :
							htmltext = "31572-02.htm"
							st.exitQuest(1)
					else :
						htmltext = "31572-03.htm"
						st.exitQuest(1)
				else :
					htmltext = "31572-02.htm"
		elif id == State.STARTED:
			if npcId == OFulle :
				if cond == 1 :
					if st.getQuestItemsCount(BigYellowTreasureChest) == 0 :
						htmltext = "31572-06.htm"
					else :
						htmltext = "31572-05.htm"
				elif cond == 2 :
					htmltext = "31572-09.htm"
			elif npcId == Kiki :
				if cond == 2 :
					htmltext="31442-01.htm"
		return htmltext

QUEST		= Quest(28,qn,"以冰魚餌釣的箱子")

QUEST.addStartNpc(OFulle)

QUEST.addTalkId(OFulle)
QUEST.addTalkId(Kiki)
