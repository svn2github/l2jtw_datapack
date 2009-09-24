# Script by Psychokiller1888
import sys
from net.sf.l2j.gameserver.model.quest		       import State
from net.sf.l2j.gameserver.model.quest		       import QuestState
from net.sf.l2j.gameserver.model.quest.jython	   import QuestJython as JQuest
from net.sf.l2j.util							   import Rnd

ORACLE_GUIDE = 32280

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

class oracle7(JQuest):
	def __init__(self,id,name,descr):
		self.isSpawned = False
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc,player):
		if event == "out":
			tele = PyObject()
			tele.x = 149361+Rnd.get(-100,100)
			tele.y = 172327+Rnd.get(-100,100)
			tele.z = -945
			st = player.getQuestState("oracle7")
			if not st :
				st = self.newQuestState(player)
			st.takeItems(9694,-1)
			st.takeItems(9698,-1)
			st.takeItems(9699,-1)
			exitInstance(player,tele)
		return

	def onTalk (self,npc,player):
		npcId = npc.getNpcId()
		htmltext = "<html><body>神諭引導者：<br><a action=\"bypass -h Quest oracle7 out\">離開這裡</a></body></html>"
		return htmltext

QUEST = oracle7(-1, "oracle7", "ai")

QUEST.addStartNpc(ORACLE_GUIDE)

QUEST.addTalkId(ORACLE_GUIDE)