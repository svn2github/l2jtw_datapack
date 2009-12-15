import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
from net.sf.l2j.gameserver.model.actor.instance import L2PcInstance

qn = "1204_ElmoredenCemetery"

class Quest (JQuest):

  def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

  def onTalk (self,npc,player):
    st = player.getQuestState(qn)
    npcId = npc.getNpcId()
    if npcId == 31919 :
       if st.getQuestItemsCount(7261) or st.getQuestItemsCount(7262) :
          st.player.teleToLocation(188191,-74959,-2738)
       else:
          return "01.htm"
    if npcId == 31920 :
       if st.getQuestItemsCount(7261) or st.getQuestItemsCount(7262) :
          st.player.teleToLocation(188191,-74959,-2738)
       else:
          return "02.htm"
    return

QUEST       = Quest(1204, qn, "Teleports")

QUEST.addStartNpc(31919)
QUEST.addStartNpc(31920)

QUEST.addTalkId(31919)
QUEST.addTalkId(31920)
