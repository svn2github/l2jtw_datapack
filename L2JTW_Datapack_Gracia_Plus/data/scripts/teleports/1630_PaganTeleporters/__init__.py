# Script for Pagan Temple Teleporters
# Needed for Quests 636 and 637
# v1.1 Done by BiTi

import sys
from com.l2jserver.gameserver.datatables import DoorTable
from com.l2jserver.gameserver.model.actor.instance import L2PcInstance
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest
qn = "1630_PaganTeleporters"
NPCS=[32034,32035,32036,32037,32039,32040]

# Main Quest Code
class Quest (JQuest):

  def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

  def onAdvEvent (self,event,npc,pc) :
    if event == "Close_Door1" :
       DoorTable.getInstance().getDoor(19160001).closeMe()
    elif event == "Close_Door2" :
       DoorTable.getInstance().getDoor(19160010).closeMe()
       DoorTable.getInstance().getDoor(19160011).closeMe()
    return

  def onFirstTalk (self,npc,player):
    npcId = npc.getNpcId()
    if npcId == 32039 :
       player.teleToLocation(-12766,-35840,-10856)
    elif npcId == 32040 :
       player.teleToLocation(36640,-51218,718)
    return ""

  def onTalk (self,npc,player):
    st = player.getQuestState(qn)
    npcId = npc.getNpcId()
    htmltext = None
    if npcId == 32034 :
      if st.getQuestItemsCount(8064) == 0 and st.getQuestItemsCount(8065) == 0 and st.getQuestItemsCount(8067) == 0:
          return "<html><body>神殿守門人:<br>沒有東西可出示給守門人看。<br>(只有手持見習生標章、變色的見習生標章或主教標章的人才可以打開這扇門。)</body></html>"
      if st.getQuestItemsCount(8064) :
         st.takeItems(8064,1) # TODO: this part must happen when u walk through doors >.<
         st.giveItems(8065,1)
      htmltext = "<html><body>神殿守門人:<br>將標章一插入插槽，隨著疑似機關啟動的聲音，門也同時開了起來。</body></html>"
      DoorTable.getInstance().getDoor(19160001).openMe()
      self.startQuestTimer("Close_Door1",10000,None,None)
    elif npcId == 32035:
      DoorTable.getInstance().getDoor(19160001).openMe()
      self.startQuestTimer("Close_Door1",10000,None,None)
      htmltext = "<html><body>神殿守門人:<br>一按下骷髏，隨著機關啟動的聲音，門也同時開了起來。</body></html>"
    elif npcId == 32036:
      if not st.getQuestItemsCount(8067) :
        htmltext = "<html><body>神殿守門人:<br>沒有東西可出示給守門人看。<br>(只有手持主教標章的人才可以打開這扇門。)</body></html>"
      else:
        htmltext = "<html><body>神殿守門人:<br>出示主教標章後，那東西表示確認過似的眼睛重新回到了原位。<br>傳來像是機關啟動的聲音之後，門就打開了。</body></html>"
        self.startQuestTimer("Close_Door2",10000,None,None)
        DoorTable.getInstance().getDoor(19160010).openMe()
        DoorTable.getInstance().getDoor(19160011).openMe()
    elif npcId == 32037:
      DoorTable.getInstance().getDoor(19160010).openMe()
      DoorTable.getInstance().getDoor(19160011).openMe()
      self.startQuestTimer("Close_Door2",10000,None,None)
      htmltext = "<html><body>神殿守門人:<br>一按下骷髏，隨著機關啟動的聲音，門也同時開了起來。</body></html>"
    st.exitQuest(1)
    return htmltext

# Quest class and state definition
QUEST       = Quest(-1, qn, "Teleports")

# Quest NPC starter initialization
for npc in NPCS :
    QUEST.addStartNpc(npc)
    QUEST.addTalkId(npc)
QUEST.addFirstTalkId(32039)
QUEST.addFirstTalkId(32040)