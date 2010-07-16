# Made by disKret
# Update by pmq 08-07-2010

import sys
from com.l2jserver.util import Rnd
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "35_FindGlitteringJewelry"

# ITEM
ROUGH_JEWEL   = 7162
ORIHARUKON    = 1893
SILVER_NUGGET = 1873
THONS         = 4044
JEWEL_BOX     = 7077

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [ROUGH_JEWEL]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "30091-1.htm" :
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			st.setState(State.STARTED)
		elif event == "30879-1.htm" :
			st.set("cond","2")
			st.playSound("ItemSound.quest_accept")
		elif event == "30091-3.htm" :
			st.takeItems(ROUGH_JEWEL,10)
			st.set("cond","4")
			st.playSound("ItemSound.quest_accept")
		elif event == "30091-5.htm" :
			if st.getQuestItemsCount(ORIHARUKON) >= 5 and st.getQuestItemsCount(SILVER_NUGGET) >= 500 and st.getQuestItemsCount(THONS) >= 150 :
				st.takeItems(ORIHARUKON,5)
				st.takeItems(SILVER_NUGGET,500)
				st.takeItems(THONS,150)
				st.giveItems(JEWEL_BOX,1)
				st.playSound("ItemSound.quest_finish")
				st.unset("cond")
				st.exitQuest(False)
			else :
				htmltext = "道具不足"
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
			if npcId == 30091 and cond == 0 and st.getQuestItemsCount(JEWEL_BOX) == 0 :
				fwear = player.getQuestState("37_PleaseMakeMeFormalWear")
				if fwear :
					if fwear.get("cond") == "6" :
						htmltext = "30091-0.htm"
					else:
						htmltext = "30091-6.htm"
						st.exitQuest(1)
				else:
					htmltext = "30091-6.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == 30091 :
				if cond [1,2,3] :
					if st.getQuestItemsCount(ROUGH_JEWEL) == 10 :
						htmltext = "30091-2.htm"
					else :
						htmltext = "30091-1a.htm"
				elif cond == 4 :
					if st.getQuestItemsCount(ORIHARUKON) >= 5 and st.getQuestItemsCount(SILVER_NUGGET) >= 500 and st.getQuestItemsCount(THONS) >= 150 :
						htmltext = "30091-4.htm"
					else :
						htmltext = "30091-3a.htm"
			elif npcId == 30879 :
				if cond == 1 :
					htmltext = "30879-0.htm"
				elif cond in [2,3] :
					htmltext = "30879-1a.htm"
		return htmltext

	def onKill(self,npc,player,isPet):
		partyMember1 = self.getRandomPartyMember(player,"1")
		partyMember2 = self.getRandomPartyMember(player,"2")
		partyMember = partyMember1 # initialize
		if not partyMember1 and not partyMember2: return
		elif not partyMember2 : partyMember = partyMember1
		elif not partyMember1 : partyMember = partyMember2
		else :
			if Rnd.get(2): partyMember = partyMember2

		if not partyMember : return
		st = partyMember.getQuestState(qn)
		if not st : return 
		if st.getState() != State.STARTED : return

		count = st.getQuestItemsCount(ROUGH_JEWEL)
		if count < 10 :
			st.giveItems(ROUGH_JEWEL,1)
			if count == 9 :
				st.playSound("ItemSound.quest_middle")
				st.set("cond","3")
			else :
				st.playSound("ItemSound.quest_itemget")
		return

QUEST		= Quest(35,qn,"尋找一閃一閃亮晶晶的寶石!")

QUEST.addStartNpc(30091)

QUEST.addTalkId(30091)
QUEST.addTalkId(30879)

QUEST.addKillId(20135)