import sys
from net.sf.l2j.gameserver.model.quest        import State
from net.sf.l2j.gameserver.model.quest        import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "Bernarde"

# 32300	ªi®³±o

class Quest (JQuest) :

	def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc,player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st: return

	def onFirstTalk (Self,npc,player):
		npcId = npc.getNpcId()
		if npcId == 32300 :
			if player.isTransformed() and player.getTransformationId()==101:
				htmltext = "32300-2.htm"
			else:
				htmltext = "32300.htm"
		return htmltext

QUEST = Quest(-1, qn, "hellbound")

QUEST.addStartNpc(32300)

QUEST.addFirstTalkId(32300)

QUEST.addTalkId(32300)