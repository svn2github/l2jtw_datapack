import sys
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
from net.sf.l2j.gameserver.network.serverpackets import NpcSay
from net.sf.l2j.util import Rnd

# Random Message
TEXT = [ "下次一定讓你下地獄！",\
         "今天受到恥辱，下次一定奉還給你！",\
         "就算殺了我，你也得不到什麼",\
         "不要再打了！"]

# 土瑞克獸人步兵
# turek_orc_footman
class turek_orc_footman(JQuest) :

    # init function.  Add in here variables that you'd like to be inherited by subclasses (if any)
    def __init__(self, id, name, descr) :
        self.turek_orc_footman = 20499
        self.FirstAttacked = False
        # finally, don't forget to call the parent constructor to prepare the event triggering
        # mechanisms etc.
        JQuest.__init__(self, id, name, descr)

    def onAttack (self, npc, player, damage, isPet, skill) :
        objId = npc.getObjectId()
        if self.FirstAttacked :
           if Rnd.get(40) : return
           npc.broadcastPacket(NpcSay(objId, 0, npc.getNpcId(), TEXT[Rnd.get(3)]))
        else :
           self.FirstAttacked = True
           npc.broadcastPacket(NpcSay(objId, 0, npc.getNpcId(), TEXT[Rnd.get(3)]))
        return 

    def onKill (self, npc, player, isPet):
        npcId = npc.getNpcId()
        if npcId == self.turek_orc_footman :
            objId = npc.getObjectId()
            self.FirstAttacked = False
        elif self.FirstAttacked :
            self.addSpawn(npcId, npc.getX(), npc.getY(), npc.getZ(), npc.getHeading(), True, 0)
        return 

QUEST = turek_orc_footman(-1, "turek_orc_footman", "ai")

QUEST.addKillId(QUEST.turek_orc_footman)

QUEST.addAttackId(QUEST.turek_orc_footman)