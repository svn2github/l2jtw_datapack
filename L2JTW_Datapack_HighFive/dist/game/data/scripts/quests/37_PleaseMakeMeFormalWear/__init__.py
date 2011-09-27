# Made by disKret
# Update by pmq 08-07-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "37_PleaseMakeMeFormalWear"

# ITEM
MYSTERIOUS_CLOTH = 7076
JEWEL_BOX        = 7077
SEWING_KIT       = 7078
DRESS_SHOES_BOX  = 7113
FORMAL_WEAR      = 6408
SIGNET_RING      = 7164
ICE_WINE         = 7160
BOX_OF_COOKIES   = 7159

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "30842-1.htm" :
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			st.setState(State.STARTED)
		elif event == "31520-1.htm" :
			st.giveItems(SIGNET_RING,1)
			st.set("cond","2")
			st.playSound("ItemSound.quest_accept")
		elif event == "31521-1.htm" :
			st.giveItems(ICE_WINE,1)
			st.set("cond","3")
			st.playSound("ItemSound.quest_accept")
		elif event == "31627-1.htm" :
			if st.getQuestItemsCount(ICE_WINE):
				st.takeItems(ICE_WINE,1)
				st.set("cond","4")
				st.playSound("ItemSound.quest_accept")
			else:
				htmltext = "道具不符。"
		elif event == "31521-3.htm" :
			st.giveItems(BOX_OF_COOKIES,1)
			st.set("cond","5")
			st.playSound("ItemSound.quest_accept")
		elif event == "31520-3.htm" :
			st.set("cond","6")
			st.playSound("ItemSound.quest_accept")
		elif event == "31520-5.htm" :
			if st.getQuestItemsCount(MYSTERIOUS_CLOTH) and st.getQuestItemsCount(JEWEL_BOX) and st.getQuestItemsCount(SEWING_KIT) :
				st.takeItems(MYSTERIOUS_CLOTH,1)
				st.takeItems(JEWEL_BOX,1)
				st.takeItems(SEWING_KIT,1)
				st.set("cond","7")
				st.playSound("ItemSound.quest_accept")
			else :
				htmltext = "道具不符。"
		elif event == "31520-7.htm" :
			if st.getQuestItemsCount(DRESS_SHOES_BOX) :
				st.takeItems(DRESS_SHOES_BOX,1)
				st.giveItems(FORMAL_WEAR,1)
				st.unset("cond")
				st.exitQuest(False)
				st.playSound("ItemSound.quest_finish")
			else :
				htmltext = "道具不符。"
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
			if npcId == 30842 and cond == 0 :
				if player.getLevel() >= 60 :
					htmltext = "30842-0.htm"
				else:
					htmltext = "30842-2.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == 30842 :
				if cond == 1 :
					htmltext = "30842-2a.htm"
			elif npcId == 31520 :
				if cond == 1 :
					htmltext = "31520-0.htm"
				elif cond in [2,3,4,5] :
					if st.getQuestItemsCount(BOX_OF_COOKIES) :
						st.takeItems(BOX_OF_COOKIES,1)
						htmltext = "31520-2.htm"
					else :
						htmltext = "31520-1a.htm"
				elif cond == 6 :
					if st.getQuestItemsCount(MYSTERIOUS_CLOTH) and st.getQuestItemsCount(JEWEL_BOX) and st.getQuestItemsCount(SEWING_KIT) :
						htmltext = "31520-4.htm"
					else :
						htmltext = "31520-3a.htm"
				elif cond == 7 :
					if st.getQuestItemsCount(DRESS_SHOES_BOX) :
						htmltext = "31520-6.htm"
					else :
						htmltext = "31520-5a.htm"
			elif npcId == 31521 :
				if st.getQuestItemsCount(SIGNET_RING) :
					st.takeItems(SIGNET_RING,1)
					htmltext = "31521-0.htm"
				if cond == 3 :
					htmltext = "31521-1a.htm"
				elif cond == 4 :
					htmltext = "31521-2.htm"
				elif cond == 5 :
					htmltext = "31521-3a.htm"
			elif npcId == 31627 :
				if st.getQuestItemsCount(ICE_WINE) :
					htmltext = "31627-0.htm"
				if cond == 4 :
					htmltext = "31627-1a.htm"
		return htmltext

QUEST		= Quest(37,qn,"請幫我做禮服!")

QUEST.addStartNpc(30842)

QUEST.addTalkId(30842)
QUEST.addTalkId(31520)
QUEST.addTalkId(31521)
QUEST.addTalkId(31627)