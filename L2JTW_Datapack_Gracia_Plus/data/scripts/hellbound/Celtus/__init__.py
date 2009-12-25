import sys
from com.l2jserver.gameserver.model.quest        import State
from com.l2jserver.gameserver.model.quest        import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest
from com.l2jserver.util                          import Rnd
from com.l2jserver.gameserver.datatables         import ItemTable

# 9672	魔法葫蘆
# 9682	保存的魔法精氣
# 22353	西爾德斯	奇美拉

qn = "Celtus"

rewards = [9682]
QUEST_RATE = 5

def dropItem(player,npc,itemId,count):
	ditem = ItemTable.getInstance().createItem("Quest", itemId, count, player)
	ditem.dropMe(npc, npc.getX(), npc.getY(), npc.getZ()); 

def autochat(npc,text):
	if npc: npc.broadcastPacket(CreatureSay(npc.getObjectId(),0,npc.getName(),text))
	return

class Quest (JQuest):
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
	
	#def onSpawn(self, npc):
		#npc.setQuestDropable(False)

	def onKill (self,npc,player,isPet):
		item = player.getInventory().getItemByItemId(9672)
		if item:
			dropid = Rnd.get(len(rewards))
			dropItem(player,npc,rewards[dropid],QUEST_RATE)
		return
		
QUEST = Quest(-1, qn, "ai")

QUEST.addKillId(22353)
QUEST.addSpawnId(22353)