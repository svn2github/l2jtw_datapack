import sys
from net.sf.l2j.gameserver.instancemanager       import InstanceManager
from net.sf.l2j.gameserver.model.entity          import Instance
from net.sf.l2j.gameserver.model.quest           import State
from net.sf.l2j.gameserver.model.quest           import QuestState
from net.sf.l2j.gameserver.model.quest.jython    import QuestJython as JQuest
from net.sf.l2j.gameserver.network               import SystemMessageId
from net.sf.l2j.gameserver.network.serverpackets import SystemMessage

qn = "Kamaloka_Tele"

def checkPrimaryConditions(player):
	if not player.getParty():
		player.sendPacket(SystemMessage(2101))
		return False
	if not player.getParty().isLeader(player):
		player.sendPacket(SystemMessage(2185))
		return True
	return True
	
class Kamaloka_Tele(JQuest) :

	def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)
 
	def onAdvEvent (self,event,npc,player) :
		return str(event)

	def onFirstTalk (self,npc,player):
		if not checkPrimaryConditions(player):
			return
		if player.getParty().isLeader(player):
			htmltext = "32496.htm"
			return htmltext
		else :
			htmltext = "32496-1.htm"
			return htmltext
	
QUEST = Kamaloka_Tele(-1, qn, "instances")

QUEST.addStartNpc(32496)
QUEST.addFirstTalkId(32496)
QUEST.addTalkId(32496)