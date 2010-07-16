# Made by disKret
# Update by pmq 08-07-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "36_MakeASewingKit"

# ITEM
REINFORCED_STEEL = 7163
ARTISANS_FRAME   = 1891
ORIHARUKON       = 1893
SEWING_KIT       = 7078

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [REINFORCED_STEEL]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "30847-1.htm" :
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			st.setState(State.STARTED)
		elif event == "30847-3.htm" :
			st.takeItems(REINFORCED_STEEL,5)
			st.set("cond","3")
		elif event == "30847-4a.htm" :
			st.takeItems(ORIHARUKON,10)
			st.takeItems(ARTISANS_FRAME,10)
			st.giveItems(SEWING_KIT,1)
			st.playSound("ItemSound.quest_finish")
			st.unset("cond")
			st.exitQuest(False)
		return htmltext

	def onTalk (self,npc,player) :
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED:
			htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == 30847 and cond == 0 and st.getQuestItemsCount(SEWING_KIT) == 0 :
				fwear = player.getQuestState("37_PleaseMakeMeFormalWear")
				if fwear:
					if fwear.get("cond") == "6" and st.getPlayer().getLevel() >= 60 :
						htmltext = "30847-0.htm"
					else:
						htmltext = "30847-5.htm"
						st.exitQuest(1)
				else:
					htmltext = "30847-5.htm"
					st.exitQuest(1)
			elif st.getQuestItemsCount(REINFORCED_STEEL) == 5 :
				htmltext = "30847-2.htm"
		elif id == State.STARTED :
			if npcId == 30847 :
				if cond == 1 :
					htmltext = "30847-1a.htm"
				elif cond == 3 :
					if st.getQuestItemsCount(ORIHARUKON) >= 10 and st.getQuestItemsCount(ARTISANS_FRAME) >= 10 :
						htmltext = "30847-4.htm"
						st.takeItems(ORIHARUKON,10)
						st.takeItems(ARTISANS_FRAME,10)
						st.giveItems(SEWING_KIT,1)
						st.playSound("ItemSound.quest_finish")
						st.unset("cond")
						st.exitQuest(False)
					else :
						htmltext = "30847-3a.htm"
		return htmltext

	def onKill(self,npc,player,isPet):
		partyMember = self.getRandomPartyMember(player,"1")
		if not partyMember : return
		st = partyMember.getQuestState(qn)
   
		count = st.getQuestItemsCount(REINFORCED_STEEL)
		if count < 5 :
			st.giveItems(REINFORCED_STEEL,1)
			if count == 4 :
				st.playSound("ItemSound.quest_middle")
				st.set("cond","2")
			else:
				st.playSound("ItemSound.quest_itemget")
		return

QUEST		= Quest(36,qn,"請幫我做針線盒!")

QUEST.addStartNpc(30847)

QUEST.addTalkId(30847)

QUEST.addKillId(20566)