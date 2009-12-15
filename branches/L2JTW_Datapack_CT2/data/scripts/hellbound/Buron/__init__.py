import sys
from net.sf.l2j.gameserver.model.quest        import State
from net.sf.l2j.gameserver.model.quest        import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "Buron"

# 32345	布隆	裁縫師

# Item
# 9669 土著頭巾
# 9670 土著上衣
# 9671 土著下衣

class Quest (JQuest) :

	def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)
	
	def onAdvEvent (self,event,npc,player):
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return htmltext
		if event == "A" :
			if st.getQuestItemsCount(9674) >= 10 :
				st.takeItems(9674,10)
				st.giveItems(9669,1)
				htmltext = ""
				st.exitQuest(1) 
			else :
				htmltext = "no.htm"
				st.exitQuest(1) 
		elif event == "B" :
			if st.getQuestItemsCount(9674) >= 10 :
				st.takeItems(9674,10)
				st.giveItems(9670,1)
				htmltext = ""
				st.exitQuest(1) 
			else :
				htmltext = "no.htm"
				st.exitQuest(1) 
		elif event == "C" :
			if st.getQuestItemsCount(9674) >= 10 :
				st.takeItems(9674,10)
				st.giveItems(9671,1)
				htmltext = ""
				st.exitQuest(1) 
			else :
				htmltext = "no.htm"
				st.exitQuest(1) 
		return htmltext
		
	def onFirstTalk (self,npc,player):
		st = player.getQuestState(qn)
		if not st :
			st = self.newQuestState(player)
		player.setLastQuestNpcObject(npc.getObjectId())
		npc.showChatWindow(player)
		return None
		
QUEST = Quest(-1, qn, "hellbound")

QUEST.addStartNpc(32345)
QUEST.addFirstTalkId(32345)
QUEST.addTalkId(32345)