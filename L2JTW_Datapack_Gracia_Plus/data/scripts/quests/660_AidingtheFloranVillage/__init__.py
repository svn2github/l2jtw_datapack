# made by Kerb
# Update by pmq

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "660_AidingtheFloranVillage"

# NPC
MARIA = 30608
ALEX  = 30291
# MOBS
CARSED_SEER                  = 21106
PLAIN_WATCMAN                = 21102
ROUGH_HEWN_ROCK_GOLEM        = 21103
DELU_LIZARDMAN_SHAMAN        = 20781
DELU_LIZARDMAN_SAPPLIER      = 21104
DELU_LIZARDMAN_COMMANDER     = 21107
DELU_LIZARDMAN_SPESIAL_AGENT = 21105
# QUEST ITEMS
WATCHING_EYES                 = 8074
DELU_LIZARDMAN_SCALE          = 8076
ROUGHLY_HEWN_ROCK_GOLEM_SHARD = 8075
# REWARDS
ADENA                 = 57
SCROLL_ENCANT_ARMOR   = 956
SCROLL_ENCHANT_WEAPON = 955

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [WATCHING_EYES, DELU_LIZARDMAN_SCALE, ROUGHLY_HEWN_ROCK_GOLEM_SHARD]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		EYES  = st.getQuestItemsCount(WATCHING_EYES)
		SCALE = st.getQuestItemsCount(DELU_LIZARDMAN_SCALE)
		SHARD = st.getQuestItemsCount(ROUGHLY_HEWN_ROCK_GOLEM_SHARD)

		if event == "30608-04.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "30291-02a.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.set("cond","2")
			st.playSound("ItemSound.quest_middle")
		elif event == "30291-05.htm" :
			if EYES + SCALE + SHARD >= 45 :
				st.giveItems(ADENA, EYES*100+SCALE*100+SHARD*100+9000)
				st.takeItems(WATCHING_EYES,-1)
				st.takeItems(DELU_LIZARDMAN_SCALE,-1)
				st.takeItems(ROUGHLY_HEWN_ROCK_GOLEM_SHARD,-1)
			else :
				st.giveItems(ADENA,EYES*100+SCALE*100+SHARD*100)
				st.takeItems(WATCHING_EYES,-1)
				st.takeItems(DELU_LIZARDMAN_SCALE,-1)
				st.takeItems(ROUGHLY_HEWN_ROCK_GOLEM_SHARD,-1)
			st.playSound("ItemSound.quest_finish")
		elif event == "30291-11.htm" :
			if EYES + SCALE + SHARD >= 99 :
				n = 100 - EYES
				t = 100 - SCALE - EYES
				if EYES >= 100 :
					st.takeItems(WATCHING_EYES,100)
				else :
					st.takeItems(WATCHING_EYES,-1)
					if SCALE >= n :
						st.takeItems(DELU_LIZARDMAN_SCALE,n)
					else :
						st.takeItems(DELU_LIZARDMAN_SCALE,-1)
						st.takeItems(ROUGHLY_HEWN_ROCK_GOLEM_SHARD,t)
				if st.getRandom(10)<8 :
					st.giveItems(ADENA,13000)
					st.giveItems(SCROLL_ENCANT_ARMOR,1)
				else :
					st.giveItems(ADENA,1000)
				st.playSound("ItemSound.quest_finish")
			else :
				htmltext = "30291-16.htm"
		elif event == "30291-12.htm" :
			if EYES + SCALE + SHARD >= 199 :
				n = 200 - EYES
				t = 200 - SCALE - EYES
				luck = st.getRandom(15)
				if EYES >= 200 :
					st.takeItems(WATCHING_EYES,200)
				else :
					st.takeItems(WATCHING_EYES,-1)
					if SCALE >= n :
						st.takeItems(DELU_LIZARDMAN_SCALE,n)
					else :
						st.takeItems(DELU_LIZARDMAN_SCALE,-1)
						st.takeItems(ROUGHLY_HEWN_ROCK_GOLEM_SHARD,t)
				if luck in range (0,8) :
					st.giveItems(ADENA,20000)
					st.giveItems(SCROLL_ENCANT_ARMOR,1)
				elif luck in range (8,12) :
					st.giveItems(SCROLL_ENCHANT_WEAPON,1)
				elif luck in range (12,15) :
					st.giveItems(ADENA,2000)
				st.playSound("ItemSound.quest_finish")
			else :
				htmltext = "30291-17.htm"
		elif event == "30291-13.htm" :
			if EYES + SCALE + SHARD >= 499 :
				n = 500 - EYES
				t = 500 - SCALE - EYES
				if EYES >= 500 :
					st.takeItems(WATCHING_EYES,500)
				else :
					st.takeItems(WATCHING_EYES,-1)
					if SCALE >= n :
						st.takeItems(DELU_LIZARDMAN_SCALE,n)
					else :
						st.takeItems(DELU_LIZARDMAN_SCALE,-1)
						st.takeItems(ROUGHLY_HEWN_ROCK_GOLEM_SHARD,t)
				if st.getRandom(10)<8 :
					st.giveItems(ADENA,45000)
					st.giveItems(SCROLL_ENCHANT_WEAPON,1)
				else :
					st.giveItems(ADENA,5000)
				st.playSound("ItemSound.quest_finish")
			else :
				htmltext = "30291-18.htm"
		elif event == "30291-06.htm" :
			st.unset("cond")
			st.exitQuest(True)
			st.playSound("ItemSound.quest_finish")
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st: return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		SHARD = st.getQuestItemsCount(ROUGHLY_HEWN_ROCK_GOLEM_SHARD)
		SCALE = st.getQuestItemsCount(DELU_LIZARDMAN_SCALE)
		EYES  = st.getQuestItemsCount(WATCHING_EYES)

		if id == State.CREATED :
			if npcId in [ALEX,MARIA] and cond == 0 :
				if st.getPlayer().getLevel() >= 30 :
					htmltext = str(npcId)+"-02.htm"
				else :
					htmltext = str(npcId)+"-01.htm"
					st.exitQuest(1)
		elif id == State.STARTED:
			if npcId == MARIA :
				if cond == 1 :
					htmltext = "30608-06.htm"
				elif cond == 2 :
					htmltext = "30608-06.htm"
			elif npcId == ALEX :
				if cond == 1 :
					htmltext = "30291-01a.htm"
					st.playSound("ItemSound.quest_middle")
					st.set("cond","2")
				elif cond == 2 :
					if EYES + SCALE + SHARD == 0 :
						htmltext = "30291-03.htm"
					else :
						htmltext = "30291-04.htm"
		return htmltext

	def onKill(self,npc,player,isPet):
		st = player.getQuestState(qn)
		if not st: return

		npcId = npc.getNpcId()
		chance = st.getRandom(100)

		if st.getInt("cond") == 2 :
			if npcId in [21106,21102] and chance < 79 :
				st.giveItems(WATCHING_EYES,1)
				st.playSound("ItemSound.quest_itemget")
			elif npcId == ROUGH_HEWN_ROCK_GOLEM and chance < 75 :
				st.giveItems(ROUGHLY_HEWN_ROCK_GOLEM_SHARD,1)
				st.playSound("ItemSound.quest_itemget")
			elif npcId in [20781,21104,21107,21105] and chance < 67 :
				st.giveItems(DELU_LIZARDMAN_SCALE,1)
				st.playSound("ItemSound.quest_itemget")
		return

QUEST		= Quest(660,qn,"幫助芙羅蘭村莊吧")

for npc in [30291,30608]:
	QUEST.addStartNpc(npc)
	QUEST.addTalkId(npc)

QUEST.addKillId(CARSED_SEER)
QUEST.addKillId(PLAIN_WATCMAN)
QUEST.addKillId(ROUGH_HEWN_ROCK_GOLEM)
QUEST.addKillId(DELU_LIZARDMAN_SHAMAN)
QUEST.addKillId(DELU_LIZARDMAN_SAPPLIER)
QUEST.addKillId(DELU_LIZARDMAN_COMMANDER)
QUEST.addKillId(DELU_LIZARDMAN_SPESIAL_AGENT)