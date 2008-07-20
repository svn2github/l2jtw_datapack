# version 0.1
# by Fulminus
# L2J_JP EDIT SANDMAN

import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
from net.sf.l2j.gameserver.instancemanager import BaiumManager

# Boss: Baium
class baium (JQuest):

  def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

  def onTalk (self,npc,player):
    st = player.getQuestState("baium")
    if not st : return "<html><head><body>無任何事件可以進行</body></html>"
    npcId = npc.getNpcId()
    if npcId == 29025 :
      if st.getInt("ok"):
        if not npc.isBusy():
           npc.onBypassFeedback(player,"wake_baium")
           npc.setBusy(True)
           npc.setBusyMessage("正在接受其他玩家的要求")
      else:
        st.exitQuest(1)
        return "Conditions are not right to wake up Baium"
    elif npcId == 31862 :
      if BaiumManager.getInstance().isEnableEnterToLair() :
        if player.isFlying() :
          return "<html><body>天使界點：<br>無法在騎乘飛龍狀態下進入此區域。</body></html>"
        if st.getQuestItemsCount(4295) : # bloody fabric
          st.takeItems(4295,1)
          player.teleToLocation(113100,14500,10077)
          BaiumManager.getInstance().addPlayerToLair(player)
          st.set("ok","1")
        else :
          return "<html><body>天使界點：<br>天使界點散發朦朧的光。可是那光線一下子就消失了。天使界點再也沒有任何反應。若想移動到天使界點所顯示的地方，好像需要某種特別的東西。</body></html>"
      else :
        return "<html><body>天使界點：<br>天使界點散發朦朧的光，在其中浮現某種影像。寬廣的空間…在那裡面看不到平時可看到的巨大人形石像。<br>而且無法看到石像形狀的此刻，好像無法移動至那地方。</body></html>"
    return

  def onKill (self,npc,player,isPet):
    st = player.getQuestState("baium")
    if not st: return
    BaiumManager.getInstance().setCubeSpawn()
    st.exitQuest(1)

  def onAttack(self,npc,player,damage,isPet):
    st = player.getQuestState("baium")
    if not st: return
    BaiumManager.getInstance().setLastAttackTime()

# Quest class and state definition
QUEST = baium(-1, "baium", "ai")
# Quest NPC starter initialization
QUEST.addStartNpc(29025)
QUEST.addStartNpc(31862)
QUEST.addTalkId(29025)
QUEST.addTalkId(31862)
QUEST.addKillId(29020)
QUEST.addAttackId(29020)
