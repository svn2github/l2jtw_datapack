# Created by Gigiikun
# Update by pmq 17-09-2010
import sys
from com.l2jserver import Config
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "642_APowerfulPrimevalCreature"

#Settings: drop chance in %
EGG_DROP_CHANCE = 1
TISSUE_DROP_CHANCE = 33

#Set this to non-zero to use 100% recipes as reward instead of default 60%
ALT_RP_100=0

DINOSAUR_TISSUE = 8774
DINOSAUR_EGG = 8775
#DINOSAURS = [22196,22197,22198,22199,22200,22201,22202,22203,22204,22205,22218,22219,22220,22223,22224,22225,18344] OLD MOB
DINOSAURS = [22199,22215,22216,22217,22196,22197,22198,22218,18344]
REWARDS = [8690,8692,8694,8696,8698,8700,8702,8704,8706,8708,8710]
REWARDS_W = {
    "1" : [9967 , 1], # 製作卷軸(王朝劍60%)
    "2" : [9968 , 1], # 製作卷軸(王朝之刃60%)
    "3" : [9969 , 1], # 製作卷軸(王朝幻影劍60%)
    "4" : [9970 , 1], # 製作卷軸(王朝弓60%)
    "5" : [9971 , 1], # 製作卷軸(王朝小刀60%)
    "6" : [9972 , 1], # 製作卷軸(王朝長柄戰戟60%)
    "7" : [9973 , 1], # 製作卷軸(王朝戰鎚60%)
    "8" : [9974 , 1], # 製作卷軸(王朝釘鎚60%)
    "9" : [9975 , 1], # 製作卷軸(王朝拳套爪60%)
    }

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [DINOSAUR_TISSUE, DINOSAUR_EGG]

	def onAdvEvent (self,event,npc,player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		count_tissue = st.getQuestItemsCount(DINOSAUR_TISSUE)
		count_egg = st.getQuestItemsCount(DINOSAUR_EGG)
		if event == "32105-04.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "32105-06a.htm" :
			st.takeItems(DINOSAUR_TISSUE,-1)
			st.giveItems(57,count_tissue*5000)
		elif event == "32105-07.htm" :
			if count_tissue < 150 or count_egg == 0 :
				htmltext = "32105-07a.htm"
			elif ALT_RP_100 != 0 :
				htmltext = st.showHtmlFile("32105-07.htm").replace("60%","100%")
		elif event.isdigit() and int(event) in REWARDS :
			if count_tissue >= 150 and count_egg >= 1 :
				htmltext = "32105-08.htm"
				st.takeItems(DINOSAUR_TISSUE,150)
				st.takeItems(DINOSAUR_EGG,1)
				st.giveItems(57,44000)
				if ALT_RP_100 != 0 :
					st.giveItems(int(event)+1,1)
				else :
					st.giveItems(int(event),1)
			else :
				htmltext = "32105-07a.htm"
		elif event == "32105-10.htm" :
			if count_tissue >= 450 :
				htmltext = "32105-10.htm"
			else :
				htmltext = "32105-11.htm"
		elif event in REWARDS_W.keys() :
			if count_tissue >= 450 :
				item, amount = REWARDS_W[event]
				st.takeItems(DINOSAUR_TISSUE,450)
				st.rewardItems(item, amount)
				st.playSound("ItemSound.quest_itemget")
				htmltext = "32105-10.htm"
			else :
				htmltext = "32105-11.htm"
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st: return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		count = st.getQuestItemsCount(DINOSAUR_TISSUE)
		if id == State.CREATED :
			if npcId == 32105 and cond == 0 :
				if player.getLevel() >= 75 :
					htmltext = "32105-01.htm"
				else :
					htmltext = "32105-00.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == 32105 and cond == 1 :
				if count == 0 :
					htmltext = "32105-05.htm"
				else :
					htmltext = "32105-06.htm"
		return htmltext

	def onKill (self, npc, player,isPet):
		partyMember = self.getRandomPartyMember(player,"1")
		if not partyMember: return
		st = partyMember.getQuestState(qn)
		if st :
			if st.getState() == State.STARTED :
				npcId = npc.getNpcId()
				cond = st.getInt("cond")
				count = st.getQuestItemsCount(DINOSAUR_TISSUE)
				if cond == 1 :
					if npcId == 18344 :
						itemId = DINOSAUR_EGG
						chance = EGG_DROP_CHANCE*Config.RATE_QUEST_DROP
						numItems, chance = divmod(chance,100)
					else :
						itemId = DINOSAUR_TISSUE
						chance = TISSUE_DROP_CHANCE*Config.RATE_QUEST_DROP
						numItems, chance = divmod(chance,100)
					if st.getRandom(100) < chance : 
						numItems += 1
					if numItems :
						if int(count + numItems) and itemId == DINOSAUR_TISSUE :
							st.playSound("ItemSound.quest_itemget")
							st.giveItems(itemId,int(numItems))
		return

QUEST		= Quest(642,qn,"有關太古強力生物的研究")

QUEST.addStartNpc(32105)

QUEST.addTalkId(32105)

for mob in DINOSAURS :
   QUEST.addKillId(mob)