import sys
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest
from com.l2jserver.gameserver.network.serverpackets import NpcSay
from com.l2jserver.util import Rnd

# Random Message
TEXT = [ "竟敢妨礙神聖的決鬥！絕對饒不了你們！",\
         "將卑劣者處死吧！",\
         "卑劣者！去死吧！",\
         "犯規！大家快給我處決卑劣者！",\
         "比武結束了！大家進攻！"]

TEXT1 = [ "！竟敢妨礙我們比武！各位！",\
          "！竟敢妨礙我們比武！大家幫幫我！"]
		 
# 德魯蜥蜴人指揮官
# delu_lizardman_special_commander
class delu_lizardman_special_commander(JQuest) :

    # init function.  Add in here variables that you'd like to be inherited by subclasses (if any)
    def __init__(self, id, name, descr) :
        self.delu_lizardman_special_commander = 21107
        self.FirstAttacked = False
        # finally, don't forget to call the parent constructor to prepare the event triggering
        # mechanisms etc.
        JQuest.__init__(self, id, name, descr)

    def onAttack (self, npc, player, damage, isPet, skill) :
        objId = npc.getObjectId()
        if self.FirstAttacked :
           if Rnd.get(40) : return
           npc.broadcastPacket(NpcSay(objId, 0, npc.getNpcId(), TEXT[Rnd.get(4)]))
        else :
           self.FirstAttacked = True
           npc.broadcastPacket(NpcSay(objId, 0, npc.getNpcId(), player.getName() + TEXT1[Rnd.get(1)]))
        return 

    def onKill (self, npc, player, isPet) :
        npcId = npc.getNpcId()
        if npcId == self.delu_lizardman_special_commander :
            objId = npc.getObjectId()
            self.FirstAttacked = False
        elif self.FirstAttacked :
            self.addSpawn(npcId, npc.getX(), npc.getY(), npc.getZ(), npc.getHeading(), True, 0)
        return 

QUEST = delu_lizardman_special_commander(-1, "delu_lizardman_special_commander", "ai")

QUEST.addKillId(QUEST.delu_lizardman_special_commander)

QUEST.addAttackId(QUEST.delu_lizardman_special_commander)