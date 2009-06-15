import sys
from net.sf.l2j.gameserver.model.quest        import State
from net.sf.l2j.gameserver.model.quest        import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "9004_Bernarde"

# 32300	ªi®³±o

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onFirstTalk (Self,npc,player):
	if player.isTransformed() and player.getTransformationId()==101:
		return "32300-2.htm"
	else:
		return "32300.htm"


QUEST = Quest(-1,qn,"custom")

QUEST.addStartNpc(32300)
QUEST.addFirstTalkId(32300)
QUEST.addTalkId(32300)
