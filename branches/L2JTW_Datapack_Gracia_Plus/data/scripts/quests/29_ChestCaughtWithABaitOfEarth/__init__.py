# Create by Skeleton!!!
# Update by pmq 08-07-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "29_ChestCaughtWithABaitOfEarth"

# NPC List
Willie = 31574
Anabel = 30909

# ITEM
SmallPurpleTreasureChest = 6507
SmallGlassBox            = 7627
PlatedLeatherGloves      = 2455

class Quest (JQuest) :
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "31574-04.htm" :
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
		elif event == "31574-07.htm" :
			if st.getQuestItemsCount(SmallPurpleTreasureChest) :
				st.set("cond","2")
				st.playSound("ItemSound.quest_accept")
				st.takeItems(SmallPurpleTreasureChest,1)
				st.giveItems(SmallGlassBox,1)
			else :
				htmltext = "31574-08.htm"
		elif event == "30909-02.htm" :
			if st.getQuestItemsCount(SmallGlassBox)==1 :
				st.takeItems(SmallGlassBox,-1)
				st.giveItems(PlatedLeatherGloves,1)
				st.unset("cond")
				st.exitQuest(False)
				st.playSound("ItemSound.quest_finish")
			else :
				htmltext = "30909-03.htm"
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			htmltext ="<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == Willie and cond == 0 :
				if player.getLevel() >= 48 :
					WilliesSpecialBait = player.getQuestState("52_WilliesSpecialBait")
					if WilliesSpecialBait :
						if WilliesSpecialBait.getState() == State.COMPLETED :
							htmltext = "31574-01.htm"
						else :
							htmltext = "31574-02.htm"
							st.exitQuest(1)
					else :
						htmltext = "31574-03.htm"
						st.exitQuest(1)
				else :
					htmltext = "31574-02.htm"
					st.exitQuest(1) 
		elif id == State.STARTED :
			if npcId == Willie :
				if cond == 1 :
					htmltext = "31574-05.htm"
					if st.getQuestItemsCount(SmallPurpleTreasureChest) == 0 :
						htmltext = "31574-06.htm"
				elif cond == 2 :
					htmltext = "31574-09.htm"
			elif npcId == Anabel :
				if cond == 2 :
					htmltext = "30909-01.htm"
		return htmltext

QUEST		= Quest(29,qn,"以地魚餌釣的箱子")

QUEST.addStartNpc(Willie)

QUEST.addTalkId(Willie)
QUEST.addTalkId(Anabel)