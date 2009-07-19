import sys
from net.sf.l2j.gameserver.ai import CtrlIntention
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
from net.sf.l2j.gameserver.network.serverpackets import NpcSay
from net.sf.l2j.util import Rnd

# Random Message
TEXT = [ "各位！出來吧！",\
         "兄弟們啊，消滅敵人吧！",\
         "黑暗的軍勢啊，跟隨我吧！",\
         "出來！黑暗的孩子們！"]

# 提瑪克獸人突擊隊隊長
# timak_orc_troop_leader
class timak_orc_troop_leader(JQuest) :

    # init function.  Add in here variables that you'd like to be inherited by subclasses (if any)
    def __init__(self, id, name, descr):
        self.timak_orc_troop_leader = 20767
        self.FirstAttacked = False
        # finally, don't forget to call the parent constructor to prepare the event triggering
        # mechanisms etc.
        JQuest.__init__(self, id, name, descr)

    def onAttack (self, npc, player, damage, isPet, skill) :
        objId = npc.getObjectId()
        if self.FirstAttacked :
           if Rnd.get(50) : return
           npc.broadcastPacket(NpcSay(objId, 0, npc.getNpcId(), TEXT[Rnd.get(4)]))
        else :
           self.FirstAttacked = True
        return 

    def onKill (self, npc, player, isPet) :
        npcId = npc.getNpcId()
        if npcId == self.timak_orc_troop_leader :
            objId = npc.getObjectId()
            self.FirstAttacked = False
        elif self.FirstAttacked :
            self.addSpawn(npcId, npc.getX(), npc.getY(), npc.getZ(), npc.getHeading(), True, 0)
        return 

QUEST = timak_orc_troop_leader(-1, "timak_orc_troop_leader", "ai")

QUEST.addKillId(QUEST.timak_orc_troop_leader)

QUEST.addAttackId(QUEST.timak_orc_troop_leader)