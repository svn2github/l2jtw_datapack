# Fix by Cromir for Kilah
# cleanup by DrLecter for the Official L2J Datapack Project.
# Visit http://www.l2jdp.com/forum/ for more details.

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "38_DragonFangs"

#Quest items
FEATHER_ORNAMENT,TOOTH_OF_TOTEM,TOOTH_OF_DRAGON,LETTER_OF_IRIS,LETTER_OF_ROHMER = range(7173,7178)

#Drop info:
DROPLIST = {21100:[1,FEATHER_ORNAMENT,100,100],20357:[1,FEATHER_ORNAMENT,100,100],21101:[6,TOOTH_OF_DRAGON,50,50],20356:[6,TOOTH_OF_DRAGON,50,50]}
#Rewards: item,adena
REWARDS  = [[45,5200],[627,1500],[1123,3200],[605,3200]]
#NPC
LUIS     = 30386
IRIS     = 30034
ROHMER   = 30344

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = range(7173,7178)

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "30386-02.htm" :
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			st.setState(State.STARTED)
		elif event == "30386-04.htm" :
			st.takeItems(FEATHER_ORNAMENT,100)
			st.giveItems(TOOTH_OF_TOTEM,1)
			st.set("cond","3")
			st.playSound("ItemSound.quest_middle")
		elif event == "30034-02a.htm" and st.getQuestItemsCount(TOOTH_OF_TOTEM) :
			htmltext = "30034-02.htm"
			st.takeItems(TOOTH_OF_TOTEM,1)
			st.giveItems(LETTER_OF_IRIS,1)
			st.set("cond","4")
			st.playSound("ItemSound.quest_middle")
		elif event == "30344-02a.htm" and st.getQuestItemsCount(LETTER_OF_IRIS) :
			htmltext = "30344-02.htm"
			st.takeItems(LETTER_OF_IRIS,1)
			st.giveItems(LETTER_OF_ROHMER,1)
			st.set("cond","5")
			st.playSound("ItemSound.quest_middle")
		elif event == "30034-04a.htm"and st.getQuestItemsCount(LETTER_OF_ROHMER) :
			st.takeItems(LETTER_OF_ROHMER,1)
			htmltext = "30034-04.htm"
			st.set("cond","6")
			st.playSound("ItemSound.quest_middle")
		elif event == "30034-06a.htm" and st.getQuestItemsCount(TOOTH_OF_DRAGON) == 50 :
			htmltext = "30034-06.htm"
			st.takeItems(TOOTH_OF_DRAGON,50)
			st.playSound("ItemSound.quest_finish")
			item,adena = REWARDS[self.getRandom(len(REWARDS))]
			st.giveItems(item,1)
			st.giveItems(57,adena)
			st.addExpAndSp(435117,23977)
			st.unset("cond")
			st.exitQuest(False)
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
			if npcId == LUIS and cond == 0 :
				if player.getLevel() >= 19 :
					htmltext = "30386-01.htm"
				else :
					htmltext = "30386-01a.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == LUIS :
				if cond == 1 :
					htmltext = "30386-02a.htm"
				elif cond == 2 :
					htmltext = "30386-03.htm"
				elif cond == 3 :
					htmltext = "30386-03a.htm"
			elif npcId == IRIS :
				if cond == 3 :
					htmltext = "30034-01.htm"
				elif cond == 4 :
					htmltext = "30034-02b.htm"
				elif cond == 5 :
					htmltext = "30034-03.htm"
				elif cond == 6 :
					htmltext = "30034-05a.htm"
				elif cond == 7 :
					htmltext = "30034-05.htm"
			elif npcId == ROHMER :
				if cond == 4 :
					htmltext = "30344-01.htm"
				elif cond == 5 :
					htmltext = "30344-03.htm"
		return htmltext

	def onKill(self,npc,player,isPet):
		st = player.getQuestState(qn)
		if not st : return
		if st.getState() != State.STARTED : return

		cond = st.getInt("cond")
		cond,item,max,chance = DROPLIST[npc.getNpcId()]
		count = st.getQuestItemsCount(item)
		if st.getInt("cond") == cond and count < max and self.getRandom(100) < chance :
			st.giveItems(item,1)
			if count == max-1 :
				st.playSound("ItemSound.quest_middle")
				st.set("cond",str(cond+1))
			else :
				st.playSound("ItemSound.quest_itemget")
		return

QUEST		= Quest(38,qn,"龍之牙")

QUEST.addStartNpc(LUIS)

QUEST.addTalkId(LUIS)
QUEST.addTalkId(IRIS)
QUEST.addTalkId(ROHMER)

for mob in DROPLIST.keys():
    QUEST.addKillId(mob)