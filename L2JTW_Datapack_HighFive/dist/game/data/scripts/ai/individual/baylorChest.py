# By Psychokiller1888
import sys
from com.l2jserver.gameserver.datatables  import ItemTable
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest
from com.l2jserver.util import Rnd

# ¤Úº¸°ÇªºÄ_½c
BOX = 29116

def dropItem(npc,itemId,count):
	ditem = ItemTable.getInstance().createItem("quest", itemId, count, None)
	ditem.dropMe(npc, npc.getX(), npc.getY(), npc.getZ()); 

class baylorChest(JQuest):
	def __init__(self,id,name,descr):
		self.isSpawned = False
		JQuest.__init__(self,id,name,descr)

	def onKill (self,npc,player,isPet):
		chance = Rnd.get(100)
		if chance <= 5:
			dropItem(npc,9422,1)
		elif chance >= 6 and chance <= 10:
			dropItem(npc,9429,1)
		elif chance >= 11 and chance <= 15:
			dropItem(npc,9438,1)
		elif chance >= 16 and chance <= 30:
			dropItem(npc,Rnd.get(9455,9457),1)
		elif chance >= 31 and chance <= 50:
			dropItem(npc,Rnd.get(6577,6578),2)
		return

QUEST = baylorChest(-1, "baylorChest", "ai")

QUEST.addKillId(BOX)