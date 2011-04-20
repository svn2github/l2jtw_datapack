# Created by t0rm3nt0r
# Drop rates and last reorganization by DrLecter
# for the Official L2J Datapack Project.
# Visit http://www.l2jdp.com/forum/ for more details.
# update by pmq
# High Five 16-02-2011
import sys
from com.l2jserver import Config
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest
from com.l2jserver.gameserver.network.serverpackets import NpcSay

qn = "617_GatherTheFlames"

TORCH  = 7264

HILDA  = 31271
VULCAN = 31539
ROONEY = 32049

DROPLIST = {21381:51,21653:51,21387:53,21655:53,21390:56,21656:69,21389:55,21388:53,\
            21383:51,21392:56,21382:60,21654:52,21384:64,21394:51,21395:56,21385:52,\
            21391:55,21393:58,21657:57,21386:52,21652:49,21378:49,21376:48,21377:48,\
            21379:59,21380:49}

REWARDS = [ 6881,6883,6885,6887,6891,6893,6895,6897,6899,7580 ]  # 60%卷軸
REWARDS2= [ 6882,6884,6886,6888,6892,6894,6896,6898,6900,7581 ]  # 100%卷軸

#Change this value to 1 if you wish 100% recipes, default 60%
ALT_RP100 = 0

def AutoChat(npc,text) :
	chars = npc.getKnownList().getKnownPlayers().values().toArray()
	if chars != None:
		for pc in chars :
			sm = NpcSay(npc.getObjectId(), 0, npc.getNpcId(), text)
			pc.sendPacket(sm)

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [TORCH]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		torches = st.getQuestItemsCount(TORCH)
		if event == "31539-03.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "31271-03.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "31539-07.htm" :
			if torches < 1000 :
				htmltext = None
			else:
				htmltext = "31539-07.htm"
				st.takeItems(TORCH,1000)
				if ALT_RP100 == 1:
					st.giveItems(REWARDS2[st.getRandom(len(REWARDS2))],1)
				else:
					st.giveItems(REWARDS[st.getRandom(len(REWARDS))],1)
		elif event == "31539-08.htm" :
			st.takeItems(TORCH,-1)
			st.exitQuest(1)
			st.playSound("ItemSound.quest_finish")
		elif event.isdigit() and int(event) in REWARDS :
			if torches < 1200 :
				htmltext = None
			else:
				htmltext = "32049-03.htm"
				st.takeItems(TORCH,1200)
				if ALT_RP100 == 1:
					st.giveItems(int(event)+1,1)
					htmltext = "32049-03.htm"
				else:
					st.giveItems(int(event),1)
					htmltext = "32049-03.htm"
		return htmltext

	def onTalk (self,npc,player):
		htmltext = Quest.getNoQuestMsg(player)
		st = player.getQuestState(qn)
		if not st : return htmltext

		id = st.getState()
		npcId = npc.getNpcId()
		cond = st.getInt("cond")

		torches = st.getQuestItemsCount(TORCH)

		if id == State.CREATED :
			if npcId == VULCAN and cond == 0:
				if player.getLevel() < 74 :
					htmltext = "31539-02.htm"
					st.exitQuest(1)
				else :
					htmltext = "31539-01.htm"
			elif npcId == HILDA and cond == 0:
				if player.getLevel() < 74 :
					htmltext = "31271-01.htm"
					st.exitQuest(1)
				else :
					htmltext = "31271-02.htm"
		elif id == State.STARTED :
			if npcId == VULCAN and cond == 1:
				if torches < 1000 :
					htmltext = "31539-05.htm"
				else :
					htmltext = "31539-04.htm"
			elif npcId == HILDA and cond == 1:
				htmltext = "31271-04.htm"
			elif npcId == ROONEY and cond == 1:
				if torches >= 1200 :
					htmltext = "32049-01.htm"
				else :
					htmltext = "32049-02.htm"
				AutoChat(npc,"歡迎歡迎！")
				#AutoChat(npc,"快點，快點，趕快。")
				#AutoChat(npc,"我不喜歡長期待在同一個地方。")
				#AutoChat(npc,"這樣站著會很累的。")
				#AutoChat(npc,"這次就往那邊看看吧？！")
		return htmltext

	def onKill(self,npc,player,isPet):
		partyMember = self.getRandomPartyMemberState(player, State.STARTED)
		if not partyMember: return
		st = partyMember.getQuestState(qn)
		if not st : return

		torches = st.getQuestItemsCount(TORCH)
		chance = DROPLIST[npc.getNpcId()]
		drop = st.getRandom(100)
		qty,chance = divmod(chance*Config.RATE_QUEST_DROP,100)
		if drop < chance : qty += 1
		qty = int(qty)
		if qty :
			st.giveItems(TORCH,qty)
			if divmod(torches+1,1000)[1] == 0  or divmod(torches+1,1200)[1] == 0 :
				st.playSound("ItemSound.quest_middle")
			else :
				st.playSound("ItemSound.quest_itemget")
		return

QUEST		= Quest(617, qn, "凝聚火焰")

QUEST.addStartNpc(VULCAN)
QUEST.addStartNpc(HILDA)

QUEST.addTalkId(VULCAN)
QUEST.addTalkId(ROONEY)
QUEST.addTalkId(HILDA)

for mob in DROPLIST.keys() :
  QUEST.addKillId(mob)