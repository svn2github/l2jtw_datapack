# L2J_JP CREATE SANDMAN
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
from net.sf.l2j.gameserver.instancemanager import ValakasManager

# Main Quest Code
class valakas(JQuest):

  def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

  def onTalk (self,npc,player):
    st = player.getQuestState("valakas")
    if not st : return "<html><head><body>你找我有什麼事情？</body></html>"
    npcId = npc.getNpcId()
    if npcId == 31385 :    # Heart of Volcano
      if player.isFlying() :
        return "<html><body>耳邊聽到悄悄細語的訴說聲：<br>騎乘飛龍的狀態下無法讓你進入。</body></html>"
      if st.getInt("ok"):
        if ValakasManager.getInstance().isEnableEnterToLair():
          ValakasManager.getInstance().setValakasSpawnTask()
          ValakasManager.getInstance().addPlayerToLair(st.player)
          st.player.teleToLocation(203940,-111840,66)
          return
        else:
          st.exitQuest(1)
          return "<html><body>耳邊聽到悄悄細語的訴說聲：<br><font color=\"LEVEL\">巴拉卡斯已經醒了。目前沒辦法進去。</font></body></html>"
      else:
        st.exitQuest(1)
        return "狀態不符，無法進入。"
    elif npcId == 31540 :
      if st.getQuestItemsCount(7267) > 0 :
        st.takeItems(7267,1)
        player.teleToLocation(183831,-115457,-3296)
        st.set("ok","1")
      else :
        st.exitQuest(1)
        return "<html><body>巴拉卡斯的監視者克雷因：<br>為了進入火焰迴廊需要浮游石。若想得到浮游石的話，去完成我給你的小小任務就行了。</body></html>"
    return

  def onKill (self,npc,player,isPet):
    st = player.getQuestState("valakas")
    if not st: return
    ValakasManager.getInstance().setCubeSpawn()
    st.exitQuest(1)

# Quest class and state definition
QUEST = valakas(-1,"valakas","ai")
# Quest NPC starter initialization
QUEST.addStartNpc(31540)
QUEST.addStartNpc(31385)
QUEST.addTalkId(31540)
QUEST.addTalkId(31385)
QUEST.addKillId(29028)
