# Created by Mephisto [Koryn]
# for my friend Johan and his server iCeOnline.eu
import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "690_JudesRequest"

# NPC
JUDE = 32356
# Mob
MOBS = [22398, 22399]
# Items
REWARDS  = [9975,9968,9970,10545,9972,9971,9974,9969,10544,9967,10374,10380,10378,10379,10376,10373,10375,10381,10382,10377,10383]
REWARDS2 = [9984,9977,9979,9981,9980,9983,9978,9976,10386,10392,10390,10391,10388,10385,10387,10393,10394,10389,10395]
MAT = [9624,9617,9619,9621,9620,9623,9618,9616,10547,10546,10398,10404,10402,10403,10400,10397,10399,10405,10406,10401,10407]
EVIL = 10327
#Change this value to 1 if you wish 100% recipes, default 60%
ALT_RP100 = 0

class Quest (JQuest) :

	def __init__(self, id, name, descr) : 
		JQuest.__init__(self, id, name, descr)
		self.questItemIds = [EVIL]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		evil = st.getQuestItemsCount(EVIL)
		if event == "32356-03.htm" :
			if st.getPlayer().getLevel() >= 78 :
				st.set("cond","1")
				st.setState(State.STARTED)
				st.playSound("ItemSound.quest_accept")
			else :
				htmltext = "32356-02.htm"
				st.exitQuest(1)
		elif event == "32356-07.htm" :
			if evil >= 200 :
				htmltext = "32356-07.htm"
				st.takeItems(EVIL, 200)
				if ALT_RP100 == 1 :
					st.giveItems(REWARDS2[self.getRandom(len(REWARDS2))], 1)
				else:
					st.giveItems(REWARDS[self.getRandom(len(REWARDS))], 1)
			else :
				htmltext = "32356-05.htm"
		elif event == "32356-08.htm" :
			st.exitQuest(1)
			st.playSound("ItemSound.quest_giveup")
		elif event == "32356-09.htm" :
			if evil >= 5 :
				htmltext = "32356-09.htm"
				st.takeItems(EVIL,5)
				st.giveItems(MAT[self.getRandom(len(MAT))], 1)
				st.giveItems(MAT[self.getRandom(len(MAT))], 1)
				st.giveItems(MAT[self.getRandom(len(MAT))], 1)
		return htmltext    

	def onTalk (self, npc, player) :
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")
		evil = st.getQuestItemsCount(EVIL)

		if id == State.CREATED :
			if npcId == JUDE and cond == 0 :
				if player.getLevel() >= 78 :
					htmltext="32356-01.htm"
				else :
					htmltext="32356-02.htm"
					st.exitQuest(1)
		elif id == State.STARTED:
			if npcId == JUDE and cond == 1 :
				if evil >= 200 :
					htmltext = "32356-04.htm"
				elif evil >= 5 and evil <= 200 :
					htmltext = "32356-05.htm"
				else :
					htmltext = "32356-05a.htm"
		return htmltext

	def onKill(self, npc, player, isPet) :
		partyMember = self.getRandomPartyMember(player, "1")
		if not partyMember: return
		st = partyMember.getQuestState(qn)
		if st :
			if st.getState() == State.STARTED :
				if self.getRandom(100) < 55 :
					st.giveItems(EVIL, 2)
					st.playSound("ItemSound.quest_itemget")
		return

QUEST		= Quest(690, qn, "朱德的要求")

QUEST.addStartNpc(JUDE)

QUEST.addTalkId(JUDE)

for mobId in MOBS :
  QUEST.addKillId(mobId)