# Made by d0S
# Update by pmq 10-09-2010

import sys
from com.l2jserver.gameserver.ai                    import CtrlIntention
from com.l2jserver.gameserver.model.quest           import State
from com.l2jserver.gameserver.model.quest           import QuestState
from com.l2jserver.gameserver.model.quest.jython    import QuestJython as JQuest
from com.l2jserver.gameserver.network.serverpackets import CreatureSay
from com.l2jserver.gameserver.network.serverpackets import ExStartScenePlayer

qn = "10271_TheEnvelopingDarkness"

#NPCs 
Orby    = 32560
El      = 32556
Medibal = 32528
#ITEMS
documentmedibal = 13852

class Quest (JQuest):

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [documentmedibal]

	def onAdvEvent (self,event,npc, player):
		htmltext = event
		st = player.getQuestState(qn)
		if not st: return

		if event == "32560-03.htm":
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "32556-05.htm":
			st.set("cond","2")
		elif event == "32556-08.htm":
			st.set("cond","4")
		return htmltext

	def onTalk (self,npc,player):
		st = player.getQuestState(qn)
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>" 
		if not st: return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED:
			if npcId == Orby :
				htmltext = "<html><body>這是已經完成的任務。</body></html>"
			elif npcId == El :
				htmltext = "32556-10.htm"
		elif id == State.CREATED :
			if npcId == Orby and cond == 0 :
				if player.getLevel() >= 75 :
					htmltext = "32560-01.htm"
				else:
					htmltext = "32560-00.htm"  
					st.exitQuest(1)
		elif id == State.STARTED:
			if npcId == Orby :
				if cond == 1 :
					htmltext = "32560-04.htm" 
				elif cond in [2,3] :
					htmltext = "32560-05.htm" 
				elif cond == 4: 
					htmltext = "32560-06.htm" 
					st.addExpAndSp(377403,37867)
					st.giveItems(57,62516)
					st.unset("cond") 
					st.exitQuest(False)
					st.playSound("ItemSound.quest_finish")
			elif npcId == El:
				if cond == 1:
					htmltext = "32556-01.htm"
				elif cond == 2:
					htmltext = "32556-06.htm"
				elif cond == 3:
					htmltext = "32556-07.htm"
				elif cond == 4:
					htmltext = "32556-09.htm"
			elif npcId == Medibal:
				if cond == 2:
					htmltext = "32528-01.htm"
					st.giveItems(documentmedibal,1)
					st.set("cond","3")
				elif cond == 3:
					htmltext = "32528-02.htm"
		return htmltext

QUEST		= Quest(10271,qn,"籠罩的黑暗") 

QUEST.addStartNpc(Orby)

QUEST.addTalkId(Orby)
QUEST.addTalkId(El)
QUEST.addTalkId(Medibal)