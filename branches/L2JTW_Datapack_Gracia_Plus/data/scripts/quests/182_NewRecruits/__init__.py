# Update By pmq 14-09-2010

import sys
from com.l2jserver.gameserver.instancemanager      import InstanceManager
from com.l2jserver.gameserver.model.actor.instance import L2PcInstance
from com.l2jserver.gameserver.model.entity         import Instance
from com.l2jserver.gameserver.model.quest          import State
from com.l2jserver.gameserver.model.quest          import QuestState
from com.l2jserver.gameserver.model.quest.jython   import QuestJython as JQuest

qn = "182_NewRecruits"

#NPC'S
KEKROPUS             = 32138 # 長老 凱克洛普斯
MENACING_MACHINE     = 32258 # 巨大機械裝置
#ITEM
RED_CRESCENT_EARRING = 10122 # 紅新月耳環
RING_OF_DEVOTION     = 10124 # 奉獻戒指

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
 
	def onAdvEvent (self,event,npc,player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		if event == "32138-03.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "32258-04.htm" :
			st.giveItems(RED_CRESCENT_EARRING, 2)
			st.unset("cond")
			st.exitQuest(False)
			st.playSound("ItemSound.quest_finish")
		elif event == "32258-05.htm" :
			st.giveItems(RING_OF_DEVOTION, 2)
			st.unset("cond")
			st.exitQuest(False)
			st.playSound("ItemSound.quest_finish")
		elif event == "quit" :
			instanceId = player.getInstanceId()
			instance = InstanceManager.getInstance().getInstance(instanceId)
			player.setInstanceId(0)
			player.teleToLocation(-74058,52040,-3680)
			htmltext = ""
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st: return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		classId = int(st.getPlayer().getClassId().getId())

		if id == State.COMPLETED :
			if npcId == KEKROPUS :
				htmltext = "<html><body>這是已經完成的任務。</body></html>"
			elif npcId == MENACING_MACHINE :
				htmltext = "32258-06.htm"
		elif id == State.CREATED :
			if npcId == KEKROPUS and cond == 0 :
				if not player.getRace().ordinal() == 5 :
					if st.getPlayer().getLevel() >= 17 and classId in [0,10,18,25,31,38,44,49,53]:
						htmltext = "32138-01.htm"
					else :
						htmltext = "32138-01a.htm"
						st.exitQuest(1)
				else :
					htmltext = "32138-00.htm"
					st.exitQuest(1)
		elif id == State.STARTED:
			if npcId == KEKROPUS and cond == 1 :
				htmltext = "32138-04.htm"
			elif npcId == MENACING_MACHINE and cond == 1 :
				htmltext = "32258-01.htm"
		return htmltext

QUEST		= Quest(182,qn,"募集幫手")

QUEST.addStartNpc(KEKROPUS)

QUEST.addTalkId(KEKROPUS)
QUEST.addTalkId(MENACING_MACHINE)