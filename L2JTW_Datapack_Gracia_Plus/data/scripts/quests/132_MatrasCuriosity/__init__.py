# pmq
import sys
from java.lang                                   import System
from com.l2jserver                                  import Config 
from com.l2jserver.gameserver.model.quest           import State
from com.l2jserver.gameserver.model.quest           import QuestState
from com.l2jserver.gameserver.model.quest.jython    import QuestJython as JQuest

qn = "132_MatrasCuriosity"

# NPC
MATRAS = 32245

# MOB
DEMONPRINCE = 25540
RANKU = 25542

# Items
RANKUSBLUEPRINT = 9800
PRINCESBLUEPRINT = 9801

ROUGHOREOFFIRE = 10521
ROUGHOREOFWATER = 10522
ROUGHOREOFTHEEARTH = 10523
ROUGHOREOFWIND = 10524
ROUGHOREOFDARKNESS = 10525
ROUGHOREOFDIVINITY = 10526

class Quest (JQuest) :

	def __init__(self, id, name, descr) : 
		JQuest.__init__(self, id, name, descr)

	def onAdvEvent (self, event, npc, player) :
		st = player.getQuestState(qn)
		if not st: return
		htmltext = event
		if event == "32245-02.htm" :
			if st.getPlayer().getLevel() >= 76 :
				st.setState(State.STARTED)
				st.giveItems(ROUGHOREOFFIRE,1)
				st.giveItems(ROUGHOREOFWATER,1)
				st.giveItems(ROUGHOREOFTHEEARTH,1)
				st.giveItems(ROUGHOREOFWIND,1)
				st.giveItems(ROUGHOREOFDARKNESS,1)
				st.giveItems(ROUGHOREOFDIVINITY,1)
				st.set("cond","1")
				st.playSound("ItemSound.quest_accept")
		return htmltext

	def onTalk (self, npc, player) :
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext
		cond = st.getInt("cond") 
		npcId = npc.getNpcId()
		id = st.getState()
		if id == State.COMPLETED :
			if npcId == MATRAS :
				htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED and npcId == MATRAS :
			if player.getLevel() >= 76 :
				htmltext="32245-01.htm"
			else :
				htmltext="32245-00.htm"
				st.exitQuest(1)
		else :
			if cond == 1 :
				if st.getQuestItemsCount(PRINCESBLUEPRINT) == 1 and st.getQuestItemsCount(RANKUSBLUEPRINT) == 1 :
					st.set("cond","2")
					htmltext = ""
					st.playSound("ItemSound.quest_middle")
				else :
					htmltext = "32245-03.htm"
			elif cond == 2 :
				htmltext = "32245-04.htm"
				st.takeItems(RANKUSBLUEPRINT,-1)
				st.takeItems(PRINCESBLUEPRINT,-1)
				st.set("cond","3")
				st.playSound("ItemSound.quest_middle")
			elif cond == 3 :
				htmltext = "32245-05.htm"
				st.giveItems(57,65884)
				st.addExpAndSp(50541,5094)
				st.exitQuest(False)
				st.playSound("ItemSound.quest_finish")
		return htmltext

	def onKill(self, npc, player, isPet) :
		npcId = npc.getNpcId()
		if npcId == DEMONPRINCE :
			party = player.getParty()
			if party :
				for partyMember in player.getParty().getPartyMembers().toArray():
					st = partyMember.getQuestState(qn)
					if not st :
						st = self.newQuestState(partyMember)
					st.giveItems(PRINCESBLUEPRINT,1);
					st.playSound("ItemSound.quest_itemget")
		if npcId == RANKU :
			party = player.getParty()
			if party :
				for partyMember in player.getParty().getPartyMembers().toArray():
					st = partyMember.getQuestState(qn)
					if not st :
						st = self.newQuestState(partyMember)
					st.giveItems(RANKUSBLUEPRINT,1);
					st.playSound("ItemSound.quest_itemget")
		if st.getQuestItemsCount(PRINCESBLUEPRINT) >= 1 and st.getQuestItemsCount(RANKUSBLUEPRINT) >= 1 :
			st.set("cond","2")
			st.playSound("ItemSound.quest_middle")
		return

QUEST       = Quest(132, qn, "麻特拉斯的好奇心")

QUEST.addStartNpc(MATRAS)

QUEST.addTalkId(MATRAS)

QUEST.addKillId(DEMONPRINCE)
QUEST.addKillId(RANKU)