import sys
from net.sf.l2j.gameserver.model.quest           import State
from net.sf.l2j.gameserver.model.quest           import QuestState
from net.sf.l2j.gameserver.model.quest.jython    import QuestJython as JQuest
from net.sf.l2j.gameserver.instancemanager       import InstanceManager

qn = "MoonlightStone"

def checkPrimaryConditions(player):
  if not player.getParty():
    return False
  if not player.getParty().isLeader(player):
    return False
  return True

class Quest (JQuest) :

  def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)
 
  def onTalk (self,npc,player):
    htmltext = ""
    if not checkPrimaryConditions(player):
      htmltext = "<html><body>月光石碑：<br>你不是隊長！</body></html>"
    else:
        instanceId = player.getInstanceId()
        instance = InstanceManager.getInstance().getInstance(instanceId)
        instance.removePlayers()
    return htmltext

QUEST = Quest(-1, qn, "hellbound")

QUEST.addStartNpc(32343)
QUEST.addTalkId(32343)