# By Psychokiller1888

import sys
from net.sf.l2j.gameserver.model.quest           import State
from net.sf.l2j.gameserver.model.quest           import QuestState
from net.sf.l2j.gameserver.model.quest.jython    import QuestJython as JQuest
from net.sf.l2j.gameserver.model.itemcontainer   import PcInventory
from net.sf.l2j.gameserver.model                 import L2ItemInstance
from net.sf.l2j.gameserver.network.serverpackets import InventoryUpdate
from net.sf.l2j.gameserver.network.serverpackets import SystemMessage
from net.sf.l2j.gameserver.network               import SystemMessageId

qn = "WanderingCaravan"

SAND_SCORPION           = 22334   # 沙蠍
DESERT_SCORPION         = 22335   # 沙漠蠍
WANDERING_CARAVAN       = 22339   # 被放逐的商隊
BASIC_CERTIFICATE       = 9850    # 商隊初級認證書
STANDARD_CERTIFICATE    = 9851    # 商隊中級認證書
MARK_BETRAYAL           = 9676    # 背叛者的憑證
SCORPION_POISON_STINGER = 10012   # 蠍子的毒針

class Quest (JQuest):
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onKill (self,npc,player,isPet):
		npcId = npc.getNpcId()
		if npcId == WANDERING_CARAVAN:
			bcertificate = player.getInventory().getItemByItemId(BASIC_CERTIFICATE)
			scertificate = player.getInventory().getItemByItemId(STANDARD_CERTIFICATE)
			if bcertificate and not scertificate:
				item = player.getInventory().addItem("Quest", MARK_BETRAYAL, 1, player, None)
				iu = InventoryUpdate()
				iu.addItem(item)
				player.sendPacket(iu);
				sm = SystemMessage(SystemMessageId.YOU_PICKED_UP_S1_S2)
				sm.addItemName(item)
				sm.addNumber(1)
				player.sendPacket(sm)
		if npcId in [22334,22335]:
			bcertificate = player.getInventory().getItemByItemId(BASIC_CERTIFICATE)
			scertificate = player.getInventory().getItemByItemId(STANDARD_CERTIFICATE)
			if bcertificate and not scertificate:
				item = player.getInventory().addItem("Quest", SCORPION_POISON_STINGER, 1, player, None)
				iu = InventoryUpdate()
				iu.addItem(item)
				player.sendPacket(iu);
				sm = SystemMessage(SystemMessageId.YOU_PICKED_UP_S1_S2)
				sm.addItemName(item)
				sm.addNumber(1)
				player.sendPacket(sm)
		return

QUEST = Quest(-1, qn, "hellbound")

QUEST.addKillId(22339)
QUEST.addKillId(22334)
QUEST.addKillId(22335)