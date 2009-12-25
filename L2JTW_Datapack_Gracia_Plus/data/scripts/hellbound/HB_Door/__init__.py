import sys
from com.l2jserver.gameserver.model.quest          import State
from com.l2jserver.gameserver.model.quest          import QuestState
from com.l2jserver.gameserver.model.quest.jython   import QuestJython as JQuest
from com.l2jserver.gameserver.model.actor.instance import L2PcInstance
from com.l2jserver.util                            import Rnd
from com.l2jserver.gameserver.datatables           import ItemTable
from com.l2jserver.gameserver.datatables           import DoorTable

qn = "HB_Door"

D1 = 20250001 # 鋼鐵之城外城門
D2 = 20250002 # 殤之大地門
D3 = 19250001 # 布隆 門

class Quest (JQuest):
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
	
	def onAdvEvent (self,event,npc,player):
		if event == "Close_Door1":
			DoorTable.getInstance().getDoor(D1).closeMe()
		elif event == "Close_Door2":
			DoorTable.getInstance().getDoor(D3).closeMe()
		elif event == "Close_Door3":
			DoorTable.getInstance().getDoor(D2).closeMe()
		return
		
	def onKill (self,npc,player,isPet):
		npcId = npc.getNpcId()
		if npcId == 18466 :
			DoorTable.getInstance().getDoor(D1).openMe()
			self.startQuestTimer("Close_Door1",6000000,None,None)
		elif npcId in [22327,22328,22329]:
			DoorTable.getInstance().getDoor(D3).openMe()
			self.startQuestTimer("Close_Door2",6000000,None,None)
		elif npcId == 22326 :
			DoorTable.getInstance().getDoor(D2).openMe()
			self.startQuestTimer("Close_Door3",6000000,None,None)
		return
	
QUEST = Quest(-1, qn, "ai")

for i in [18466,22327,22328,22326,22329]:
  QUEST.addKillId(i)