import sys
from com.l2jserver.gameserver.model.quest           import State
from com.l2jserver.gameserver.model.quest           import QuestState
from com.l2jserver.gameserver.model.quest.jython    import QuestJython as JQuest
from com.l2jserver.gameserver.model.itemcontainer   import PcInventory
from com.l2jserver.gameserver.model                 import L2ItemInstance
from com.l2jserver.gameserver.network.serverpackets import InventoryUpdate
from com.l2jserver.util                             import Rnd
from com.l2jserver.gameserver.datatables            import ItemTable

# 22349	大地奇美拉
# 22350	黑暗奇美拉
# 22351	風之奇美拉
# 22352	火焰奇美拉
# 9681	魔法精氣
# 9672	魔法葫蘆

qn = "Chimera"

reward = 9681
QUEST_RATE = 5

def dropItem(player,npc,itemId,count):
	ditem = ItemTable.getInstance().createItem("Loot", itemId, count, player)
	ditem.dropMe(npc, npc.getX(), npc.getY(), npc.getZ()); 

class Quest (JQuest):
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
	
	#def onSpawn(self, npc):
		#npc.setQuestDropable(False)

	def onKill (self,npc,player,isPet):
		item = player.getInventory().getItemByItemId(9672)
		if item:
			dropItem(player,npc,reward,QUEST_RATE)
		return
	
QUEST = Quest(-1, qn, "ai")

QUEST.addKillId(22349)
QUEST.addKillId(22350)
QUEST.addKillId(22351)
QUEST.addKillId(22352)

QUEST.addSpawnId(22349)
QUEST.addSpawnId(22350)
QUEST.addSpawnId(22351)
QUEST.addSpawnId(22352)