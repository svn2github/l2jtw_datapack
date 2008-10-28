# By L2J_JP SANDMAN

import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
from net.sf.l2j.gameserver.serverpackets import SocialAction
from net.sf.l2j.gameserver.instancemanager import SailrenManager
from net.sf.l2j.gameserver.instancemanager import GrandBossManager

#NPC
STATUE          =   32109
VELOCIRAPTOR    =   22218
PTEROSAUR       =   22199
TYRANNOSAURUS   =   22217
SAILREN         =   29065

#ITEM
GAZKH   =   8784    #卡茲克

# Boss: sailren
class sailren (JQuest):

  def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

  def onTalk (self,npc,player):
    st = player.getQuestState("sailren")
    if not st : return "<html><head><body>沒有任何事件可以進行。</body></html>"
    npcId = npc.getNpcId()
    if npcId == STATUE :
      if player.isFlying() :
        return "<html><body>席琳聖像：<br><font color=\"LEVEL\">騎乘飛龍的狀態下無法讓你進入。</font></body></html>"
      if st.getQuestItemsCount(GAZKH) :
        ENTRY_SATAT = SailrenManager.getInstance().canIntoSailrenLair(player)
        if ENTRY_SATAT == 1 or ENTRY_SATAT == 2 :
          st.exitQuest(1)
          return "<html><body>席琳聖像：<br><font color=\"LEVEL\">已經有人進入賽爾蘭巢穴。在他們與賽爾蘭的對戰結束之前不能讓你們進入。</font></body></html>"
        elif ENTRY_SATAT == 3 :
          st.exitQuest(1)
          return "<html><body>席琳聖像：<br>等等。你似乎不是約定要在這戰鬥做先鋒的人啊。我只會對一個隊伍的隊伍隊長打開通往賽爾蘭山寨之門，如果你想傳送就將隊伍的隊伍隊長帶來，或者你也可以得到隊伍隊長資格再回來。</body></html>"
        elif ENTRY_SATAT == 4 :
          st.exitQuest(1)
          return "<html><head><body>席琳聖像：<br>想一個人封印賽爾蘭？你別想了！請把隊伍帶過來吧。</body></html>"
        elif ENTRY_SATAT == 0 :
          st.takeItems(GAZKH,1)
          SailrenManager.getInstance().setSailrenSpawnTask(VELOCIRAPTOR)
          SailrenManager.getInstance().entryToSailrenLair(player)
          return "<html><head><body>席琳聖像：<br>請用你的技巧把賽爾蘭給封印。</body></html>"
      else :
        st.exitQuest(1)
        return "<html><head><body>席琳聖像：<br><font color=LEVEL>卡茲克</font>是封印賽爾蘭必備的物品。</body></html>"

  def onKill (self,npc,player,isPet):
    st = player.getQuestState("sailren")
    if not st: return
    if GrandBossManager.getInstance().checkIfInZone("LairofSailren", player) :
      npcId = npc.getNpcId()
      if npcId == VELOCIRAPTOR :
        SailrenManager.getInstance().setSailrenSpawnTask(PTEROSAUR)
      elif npcId == PTEROSAUR :
        SailrenManager.getInstance().setSailrenSpawnTask(TYRANNOSAURUS)
      elif npcId == TYRANNOSAURUS :
        SailrenManager.getInstance().setSailrenSpawnTask(SAILREN)
      elif npcId == SAILREN :
        SailrenManager.getInstance().setCubeSpawn()
        st.exitQuest(1)
    return

# Quest class and state definition
QUEST = sailren(-1, "sailren", "ai")
# Quest NPC starter initialization
QUEST.addStartNpc(STATUE)
QUEST.addTalkId(STATUE)
QUEST.addKillId(VELOCIRAPTOR)
QUEST.addKillId(PTEROSAUR)
QUEST.addKillId(TYRANNOSAURUS)
QUEST.addKillId(SAILREN)
