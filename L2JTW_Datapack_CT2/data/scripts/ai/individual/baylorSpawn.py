# By Umbrella HanWik
# Chests by Psychokill1888 and yes I removed that statue thing, the statue is the one for Sailren, so if i'm wrong just correct
import sys
from net.sf.l2j.gameserver.model.quest        import State
from net.sf.l2j.gameserver.model.quest        import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

#NPC
STATUE          =   32109
CRYSTALINE      =   29100
BAYLOR          =   29099
CHEST           =   29116

# Boss: baylor
class baylor (JQuest):

    def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

    def onKill (self,npc,player,isPet):
        st = player.getQuestState("baylorSpawn")
        npcId = npc.getNpcId()
        if npcId == BAYLOR :
            instanceId = npc.getInstanceId()
            self.addSpawn(29116, 153763, 142075, -12741, 64792, False, 300000, False, instanceId)
            self.addSpawn(29116, 153701, 141942, -12741, 57739, False, 300000, False, instanceId)
            self.addSpawn(29116, 153573, 141894, -12741, 49471, False, 300000, False, instanceId)
            self.addSpawn(29116, 153445, 141945, -12741, 41113, False, 300000, False, instanceId)
            self.addSpawn(29116, 153381, 142076, -12741, 32767, False, 300000, False, instanceId)
            self.addSpawn(29116, 153441, 142211, -12741, 25730, False, 300000, False, instanceId)
            self.addSpawn(29116, 153573, 142260, -12741, 16185, False, 300000, False, instanceId)
            self.addSpawn(29116, 153706, 142212, -12741, 7579, False, 300000, False, instanceId)
            self.addSpawn(29116, 153571, 142860, -12741, 16716, False, 300000, False, instanceId)
            self.addSpawn(29116, 152783, 142077, -12741, 32176, False, 300000, False, instanceId)
            self.addSpawn(29116, 153571, 141274, -12741, 49072, False, 300000, False, instanceId)
            self.addSpawn(29116, 154365, 142073, -12741, 64149, False, 300000, False, instanceId)
            self.addSpawn(29116, 154192, 142697, -12741, 7894, False, 300000, False, instanceId)
            self.addSpawn(29116, 152924, 142677, -12741, 25072, False, 300000, False, instanceId)
            self.addSpawn(29116, 152907, 141428, -12741, 39590, False, 300000, False, instanceId)
            self.addSpawn(29116, 154243, 141411, -12741, 55500, False, 300000, False, instanceId)
            if not st: return
            st.exitQuest(1)
        return

QUEST = baylor(-1, "baylorSpawn", "ai")

QUEST.addStartNpc(STATUE)

QUEST.addKillId(BAYLOR)