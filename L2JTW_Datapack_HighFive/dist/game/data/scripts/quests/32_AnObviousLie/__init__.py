# Made by disKret
import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "32_AnObviousLie"

# NPC
MAXIMILIAN      = 30120
GENTLER         = 30094
MIKI_THE_CAT    = 31706

# MOBS
ALLIGATOR       = 20135

# CHANCE FOR DROP
CHANCE_FOR_DROP = 30

# ITEMS
MAP             = 7165
MEDICINAL_HERB  = 7166
SPIRIT_ORES     = 3031
THREAD          = 1868
SUEDE           = 1866

# REWARDS
RACCOON_EAR     = 7680
CAT_EAR         = 6843
RABBIT_EAR      = 7683

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [MEDICINAL_HERB, MAP]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "30120-1.htm" :
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			st.setState(State.STARTED)
		elif event == "30094-1.htm" :
			st.giveItems(MAP,1)
			st.set("cond","2")
			st.playSound("ItemSound.quest_accept")
		elif event == "31706-1.htm" :
			st.takeItems(MAP,1)
			st.set("cond","3")
			st.playSound("ItemSound.quest_accept")
		elif event == "30094-4.htm" :
			if st.getQuestItemsCount(MEDICINAL_HERB) > 19 :
				st.takeItems(MEDICINAL_HERB,20)
				st.set("cond","5")
				st.playSound("ItemSound.quest_accept")
			else:
				htmltext="材料或道具不足。"
				st.set("cond","3")
		elif event == "30094-7.htm" :
			if st.getQuestItemsCount(SPIRIT_ORES) >= 500:
				st.takeItems(SPIRIT_ORES,500)
				st.set("cond","6")
				st.playSound("ItemSound.quest_accept")
			else:
				htmltext="材料或道具不足。"
		elif event == "31706-4.htm" :
			st.set("cond","7")
			st.playSound("ItemSound.quest_accept")
		elif event == "30094-10.htm" :
			st.set("cond","8")
			st.playSound("ItemSound.quest_accept")
		elif event == "30094-13.htm" :
			if st.getQuestItemsCount(THREAD) >= 1000 and st.getQuestItemsCount(SUEDE) >= 500 :
				st.takeItems(THREAD,1000)
				st.takeItems(SUEDE,500)
			else:
				htmltext = "材料或道具不足。"
		elif event in ["cat","racoon","rabbit"] :
			if st.getInt("cond") == 8 :
				if event == "cat" :
					item = CAT_EAR
				elif event == "racoon":
					item = RACCOON_EAR
				elif event == "rabbit":
					item = RABBIT_EAR
				st.giveItems(item,1)
				htmltext = "30094-14.htm"
				st.unset("cond")
				st.exitQuest(False)
				st.playSound("ItemSound.quest_finish")
			else :
				htmltext = "???"
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
			if npcId == MAXIMILIAN and cond == 0 :
				if player.getLevel() >= 45 :
					htmltext = "30120-0.htm"
				else:
					htmltext = "30120-0a.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == MAXIMILIAN :
				if cond == 1 :
					htmltext = "30120-2.htm"
			elif npcId == GENTLER :
				if cond == 1 :
					htmltext = "30094-0.htm"
				elif cond == 2 :
					htmltext = "30094-2.htm"
				elif cond == 4 :
					htmltext = "30094-3.htm"
				elif cond == 5 and st.getQuestItemsCount(SPIRIT_ORES) < 500 :
					htmltext = "30094-5.htm"
				elif cond == 5 and st.getQuestItemsCount(SPIRIT_ORES) >= 500 :
					htmltext = "30094-6.htm"
				elif cond == 6 :
					htmltext = "30094-8.htm"
				elif cond == 7 :
					htmltext = "30094-9.htm"
				elif cond == 8 and (st.getQuestItemsCount(THREAD) < 1000 or st.getQuestItemsCount(SUEDE) < 500) :
					htmltext = "30094-11.htm"
				elif cond == 8 and st.getQuestItemsCount(THREAD) >= 1000 and st.getQuestItemsCount(SUEDE) >= 500 :
					htmltext = "30094-12.htm"
			elif npcId == MIKI_THE_CAT :
				if cond == 2 :
					htmltext = "31706-0.htm"
				elif cond == 3 :
					htmltext = "31706-2.htm"
				elif cond == 6 :
					htmltext = "31706-3.htm"
				elif cond == 7 :
					htmltext = "31706-5.htm"
		return htmltext

	def onKill(self,npc,player,isPet):
		st = player.getQuestState(qn)
		if not st : return
		if st.getState()!=State.STARTED : return

		chance = st.getRandom(100)
		count = st.getQuestItemsCount(MEDICINAL_HERB)
		if chance < CHANCE_FOR_DROP and st.getInt("cond") == 3 :
			if count < 20 :
				st.giveItems(MEDICINAL_HERB,1)
				if count == 19 :
					st.set("cond","4")
					st.playSound("ItemSound.quest_middle")
				else:
					st.playSound("ItemSound.quest_itemget")
		return

QUEST		= Quest(32,qn,"謊言也能看的見")

QUEST.addStartNpc(MAXIMILIAN)

QUEST.addTalkId(MAXIMILIAN)
QUEST.addTalkId(GENTLER)
QUEST.addTalkId(MIKI_THE_CAT)

QUEST.addKillId(ALLIGATOR)