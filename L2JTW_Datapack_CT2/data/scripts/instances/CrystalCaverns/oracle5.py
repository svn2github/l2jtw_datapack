# Script by Psychokiller1888
import sys
from net.sf.l2j.gameserver.model.quest		       import State
from net.sf.l2j.gameserver.model.quest		       import QuestState
from net.sf.l2j.gameserver.model.quest.jython	       import QuestJython as JQuest

ORACLE_GUIDE = 32279

class PyObject:
	pass

def exitInstance(player,teleto):
	player.setInstanceId(0)
	player.teleToLocation(teleto.x, teleto.y, teleto.z)
	pet = player.getPet()
	if pet != None :
		pet.setInstanceId(0)
		pet.teleToLocation(teleto.x, teleto.y, teleto.z)

def teleportplayer(player,teleto):
	player.teleToLocation(teleto.x, teleto.y, teleto.z)
	pet = player.getPet()
	if pet != None :
		pet.teleToLocation(teleto.x, teleto.y, teleto.z)
	return	

class oracle5(JQuest):
	def __init__(self,id,name,descr):
		self.isSpawned = False
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc,player):
		if event == "out":
			tele = PyObject()
			tele.x = 149361
			tele.y = 172327
			tele.z = -945
			st = player.getQuestState("oracle5")
			if not st :
				st = self.newQuestState(player)
			st.takeItems(9694,-1)
			st.takeItems(9698,-1)
			st.takeItems(9699,-1)
			exitInstance(player,tele)
		elif event == "meet":
			tele = PyObject()
			tele.x = 153586
			tele.y = 145934
			tele.z = -12589
			teleportplayer(player,tele)
		return

	def onTalk (self,npc,player):
		npcId = npc.getNpcId()
		htmltext = "<html><body>神諭引導者：<br><a action=\"bypass -h Quest oracle5 out\">離開這裡</a></body></html>"
		return htmltext

QUEST = oracle5(-1, "oracle5", "ai")

QUEST.addStartNpc(ORACLE_GUIDE)

QUEST.addTalkId(ORACLE_GUIDE)