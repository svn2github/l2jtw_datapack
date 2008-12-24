# Script is used for preventing displaying html for npcs that dont have html on retail
# Visit http://forum.l2jdp.com for more details.
import sys
from net.sf.l2j.gameserver.model.quest import Quest as JQuest
from net.sf.l2j.gameserver.network.serverpackets      import ActionFailed

NPCs = [31557,31606,32026,32030,32031,32032, \
        31671,31672,31673,31674,30733,31032,31033,31034,31035,31036] # 補充NPC,但是L2Guard的類型無效,如改為L2Npc,會導致不會走動不會反擊

class Quest (JQuest) :
    def __init__(self,id,name,descr):
        JQuest.__init__(self,id,name,descr)

    def onFirstTalk (self,npc,player):
        player.sendPacket(ActionFailed.STATIC_PACKET)
        return None

QUEST      = Quest(-1,".","custom")
for i in NPCs :
  QUEST.addFirstTalkId(i)
