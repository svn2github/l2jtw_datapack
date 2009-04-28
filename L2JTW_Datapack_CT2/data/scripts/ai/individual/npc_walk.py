# Update by rocknow
import sys
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

class NPC_Walk(JQuest) :
  def __init__(self,id,name,descr):
     JQuest.__init__(self,id,name,descr)
     self.addSpawn(31356,-81681,241109,-3712,0,False,0)
     self.addSpawn(31357,-86328,241120,-3734,0,False,0)
     self.addSpawn(31358,47015,51278,-2992,0,False,0)
     self.addSpawn(31359,45744,50561,-3065,0,False,0)
     self.addSpawn(31360,10826,14777,-4240,0,False,0)
     self.addSpawn(31361,22418,10249,-3648,0,False,0)
     self.addSpawn(31362,114847,-180066,-877,0,False,0)
     self.addSpawn(31363,116731,-182477,-1512,0,False,0)
     self.addSpawn(31364,-46506,-109402,-238,0,False,0)
     self.addSpawn(31365,-48807,-113489,-241,0,False,0)
     self.addSpawn(32070,90271,-143869,-1547,0,False,0)
     self.addSpawn(32072,84429,-144065,-1542,0,False,0)

QUEST       = NPC_Walk(-1, "NPC_Walk", "ai")
