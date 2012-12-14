# Made by Mr. - Version 0.3 by DrLecter
# Update by pmq 13-07-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "327_ReclaimTheLand"

ADENA = 57
LEIKANS_LETTER = 5012

TUREK_DOGTAG,        TUREK_MEDALLION,     CLAY_URN_FRAGMENT,    \
BRASS_TRINKET_PIECE, BRONZE_MIRROR_PIECE, JADE_NECKLACE_BEAD,   \
ANCIENT_CLAY_URN,    ANCIENT_BRASS_TIARA, ANCIENT_BRONZE_MIRROR,\
ANCIENT_JADE_NECKLACE = range(1846,1856)

EXP = {
ANCIENT_CLAY_URN:913,
ANCIENT_BRASS_TIARA:1065,
ANCIENT_BRONZE_MIRROR:1065,
ANCIENT_JADE_NECKLACE:1294
}

DROPLIST = {
20501:[TUREK_MEDALLION,12],
20500:[TUREK_DOGTAG,7],
20499:[TUREK_DOGTAG,8],
20498:[TUREK_DOGTAG,10],
20497:[TUREK_MEDALLION,11],
20496:[TUREK_DOGTAG,9],
20495:[TUREK_MEDALLION,13]
}

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [CLAY_URN_FRAGMENT, BRASS_TRINKET_PIECE, BRONZE_MIRROR_PIECE, JADE_NECKLACE_BEAD, TUREK_DOGTAG, TUREK_MEDALLION, LEIKANS_LETTER]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		n = self.getRandom(100)
		if event == "30597-03.htm" :
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			st.setState(State.STARTED)
		elif event == "30382-03.htm" :
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			st.setState(State.STARTED)
			st.giveItems(LEIKANS_LETTER,1)
			st.set("cond","2")
		elif event == "30313-02.htm" :
			if st.getQuestItemsCount(CLAY_URN_FRAGMENT) >= 5 :
				st.takeItems(CLAY_URN_FRAGMENT,5)
				if n < 80 :
					htmltext = "30313-03.htm"
					st.giveItems(ANCIENT_CLAY_URN,1)
				else:
					htmltext = "30313-10.htm"
		elif event == "30313-04.htm" :
			if st.getQuestItemsCount(BRASS_TRINKET_PIECE) >= 5 :
				st.takeItems(BRASS_TRINKET_PIECE,5)
				if n < 80 :
					htmltext = "30313-05.htm"
					st.giveItems(ANCIENT_BRASS_TIARA,1)
				else:
					htmltext = "30313-10.htm"
		elif event == "30313-06.htm" :
			if st.getQuestItemsCount(BRONZE_MIRROR_PIECE) >= 5 :
				st.takeItems(BRONZE_MIRROR_PIECE,5)
				if n < 80 :
					htmltext = "30313-07.htm"
					st.giveItems(ANCIENT_BRONZE_MIRROR,1)
				else:
					htmltext = "30313-10.htm"
		elif event == "30313-08.htm" :
			if st.getQuestItemsCount(JADE_NECKLACE_BEAD) >= 5 :
				st.takeItems(JADE_NECKLACE_BEAD,5)
				if n < 80 :
					htmltext = "30313-09.htm"
					st.giveItems(ANCIENT_JADE_NECKLACE,1)
				else:
					htmltext = "30313-10.htm"
		elif event == "30034-03.htm" :
			n = st.getQuestItemsCount(CLAY_URN_FRAGMENT)
			if n == 0 :
				htmltext = "30034-02.htm"
			else:
				st.takeItems(CLAY_URN_FRAGMENT,n)
				st.addExpAndSp(n*152,0)
		elif event == "30034-04.htm" :
			n = st.getQuestItemsCount(BRASS_TRINKET_PIECE)
			if n == 0 :
				htmltext = "30034-02.htm"
			else:
				st.takeItems(BRASS_TRINKET_PIECE,n)
				st.addExpAndSp(n*182,0)
		elif event == "30034-05.htm" :
			n = st.getQuestItemsCount(BRONZE_MIRROR_PIECE)
			if n == 0 :
				htmltext = "30034-02.htm"
			else:
				st.takeItems(BRONZE_MIRROR_PIECE,n)
				st.addExpAndSp(n*182,0)
		elif event == "30034-06.htm" :
			n = st.getQuestItemsCount(JADE_NECKLACE_BEAD)
			if n < 1 :
				htmltext = "30034-02.htm"
			else:
				st.takeItems(JADE_NECKLACE_BEAD,n)
				st.addExpAndSp(n*182,0)
		elif event == "30034-07.htm" :
			n1 = 0
			for i in range(1852,1856) :
				n = st.getQuestItemsCount(i)
				if n :
					n1 = 1
					st.takeItems(i,n)
					st.addExpAndSp(n*EXP[i],0)
			if not n1 :
				htmltext = "30034-02.htm"
		elif event == "30314-03.htm" :
			if st.getQuestItemsCount(ANCIENT_CLAY_URN) >= 1 :
				st.takeItems(ANCIENT_CLAY_URN,1)
				st.giveItems(39,1)
				htmltext = "30314-03.htm"
			else:
				htmltext = "30314-07.htm"
		elif event == "30314-04.htm" :
			if st.getQuestItemsCount(ANCIENT_BRASS_TIARA) >= 1 :
				st.takeItems(ANCIENT_BRASS_TIARA,1)
				st.giveItems(40,1)
				htmltext = "30314-04.htm"
			else:
				htmltext = "30314-07.htm"
		elif event == "30314-05.htm" :
			if st.getQuestItemsCount(ANCIENT_BRONZE_MIRROR) >= 1 :
				st.takeItems(ANCIENT_BRONZE_MIRROR,1)
				st.giveItems(41,1)
				htmltext = "30314-05.htm"
			else:
				htmltext = "30314-07.htm"
		elif event == "30314-06.htm" :
			if st.getQuestItemsCount(ANCIENT_JADE_NECKLACE) >= 1 :
				st.takeItems(ANCIENT_JADE_NECKLACE,1)
				st.giveItems(42,1)
				htmltext = "30314-06.htm"
			else:
				htmltext = "30314-07.htm"
		elif event == "30314_08" :
			if st.getQuestItemsCount(ANCIENT_CLAY_URN) or st.getQuestItemsCount(ANCIENT_BRASS_TIARA) or st.getQuestItemsCount(ANCIENT_BRONZE_MIRROR) or st.getQuestItemsCount(ANCIENT_JADE_NECKLACE) >= 1 :
				htmltext = "30314-08.htm"
			else:
				htmltext = "30314-09.htm"
		elif event == "30597-06.htm" :
			st.exitQuest(1)
			st.playSound("ItemSound.quest_finish")
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		dogtag = st.getQuestItemsCount(TUREK_DOGTAG)
		medallion = st.getQuestItemsCount(TUREK_MEDALLION)

		if id == State.CREATED :
			if npcId == 30382 and cond == 0 :
				if player.getLevel() < 25 :
					htmltext = "30382-01.htm"
					st.exitQuest(1)
				else :
					htmltext = "30382-02.htm"
			elif npcId == 30597 and cond == 0 :
				if player.getLevel() < 25 :
					htmltext = "30597-01.htm"
					st.exitQuest(1)
				else :
					htmltext = "30597-02.htm"
		elif id == State.STARTED :
			if npcId == 30034 :
				if cond in [1,2,3,4,5] :
					htmltext = "30034-01.htm"
			elif npcId == 30313 :
				if cond in [1,2,3,4,5] :
					htmltext = "30313-01.htm"
			elif npcId == 30314 :
				if cond in [1,2,3,4,5] :
					htmltext = "30314-01.htm"
			elif npcId == 30382 :
				if cond in [1,3,4,5] :
					htmltext = "30382-05.htm"
					st.set("cond","5")
					st.playSound("ItemSound.quest_middle")
				elif cond == 2 :
					htmltext = "30382-04.htm"
			elif npcId == 30597 :
				if cond in [1,3] :
					if dogtag + medallion == 0 :
						htmltext = "30597-04.htm"
					else:
						htmltext = "30597-05.htm"
						st.takeItems(TUREK_DOGTAG,dogtag)
						st.takeItems(TUREK_MEDALLION,medallion)
						st.giveItems(ADENA,dogtag*40+medallion*50)
						st.set("cond","4")
						st.playSound("ItemSound.quest_middle")
				elif cond == 2 :
					if st.getQuestItemsCount(LEIKANS_LETTER) == 1 :
						st.takeItems(LEIKANS_LETTER,1)
						htmltext = "30597-03a.htm"
						st.set("cond","3")
						st.playSound("ItemSound.quest_middle")
					else:
						htmltext = "道具不符"
				elif cond in [4,5] :
					if dogtag + medallion == 0 :
						htmltext = "30597-04.htm"
					else:
						htmltext = "30597-05.htm"
						st.takeItems(TUREK_DOGTAG,dogtag)
						st.takeItems(TUREK_MEDALLION,medallion)
						st.giveItems(ADENA,dogtag*40+medallion*50)
		return htmltext

	def onKill(self,npc,player,isPet):
		st = player.getQuestState(qn)
		if not st : return 
		if st.getState() != State.STARTED : return 

		item,chance = DROPLIST[npc.getNpcId()]
		st.giveItems(item,1)
		st.playSound("ItemSound.quest_itemget")
		if self.getRandom(100)<chance :
			n = self.getRandom(100)
			if n < 25 :
				st.giveItems(CLAY_URN_FRAGMENT,1)
			elif n < 50 :
				st.giveItems(BRASS_TRINKET_PIECE,1)
			elif n < 75 :
				st.giveItems(BRONZE_MIRROR_PIECE,1)
			else:
				st.giveItems(JADE_NECKLACE_BEAD,1)
		return

QUEST		= Quest(327,qn,"奪回農地")

QUEST.addStartNpc(30382)
QUEST.addStartNpc(30597)

for n in [30034,30313,30314,30382,30597] :
    QUEST.addTalkId(n)

for i in range(20495,20502) :
    QUEST.addKillId(i)