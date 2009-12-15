import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
from net.sf.l2j.gameserver.model.actor.instance import L2PcInstance
from net.sf.l2j.gameserver.instancemanager import AntharasManager

# NPCS
HEART           = 13001 # 結界的心臟
ANTHARAS_OLD    = 29019 # 安塔瑞斯 (舊版)
ANTHARAS_WEAK   = 29066 # 安塔瑞斯 (弱化版)
ANTHARAS_NORMAL = 29067 # 安塔瑞斯 (普通版)
ANTHARAS_STRONG = 29068 # 安塔瑞斯 (強化版)
TELECUBE	= 31859 # 傳送晶體

# ITEM
PORTAL_STONE    = 3865

MSG1 = "<html><body>耳邊聽到悄悄細語的訴說聲：<br><font color=\"LEVEL\">現在還不能允許你跟安塔瑞斯對戰。請回吧。</font></body></html>"
MSG2 = "<html><body>耳邊聽到悄悄細語的訴說聲：<br><font color=\"LEVEL\">擁有傳送石之人才能與安塔瑞斯對戰。請回吧。</font></body></html>"
MSG3 = "<html><body>耳邊聽到悄悄細語的訴說聲：<br><font color=\"LEVEL\">已經有人進入安塔瑞斯巢穴。在他們與地龍的對戰結束之前不能讓你們進入。</font></body></html>"

# Boss: Antharas
class antharas(JQuest) :
  def __init__(self,id,name,descr):
     self.antharas = 29019
     JQuest.__init__(self,id,name,descr)

  def onTalk (self,npc,player):
     st = player.getQuestState("antharas")
     if not st : return
     npcId = npc.getNpcId()
     if npcId == HEART :
        if AntharasManager.getInstance().isEnableEnterToLair():
           if st.getQuestItemsCount(PORTAL_STONE) > 0 :
              st.takeItems(PORTAL_STONE,1)
              AntharasManager.getInstance().setAntharasSpawnTask()
              AntharasManager.getInstance().addPlayerToLair(st.player)
              st.player.teleToLocation(180226,114979,-7704)
              return
           else:
              st.exitQuest(1)
              return MSG2
        else:
           st.exitQuest(1)
           return MSG1
     return

  def onKill (self,npc,player,isPet):
     st = player.getQuestState("antharas")
     if not st: return
     AntharasManager.getInstance().setCubeSpawn()
     st.exitQuest(1)
     return

QUEST      = antharas(-1,"antharas","ai")

QUEST.addStartNpc(HEART)
QUEST.addTalkId(HEART)
QUEST.addKillId(ANTHARAS_OLD)
QUEST.addKillId(ANTHARAS_WEAK)
QUEST.addKillId(ANTHARAS_NORMAL)
QUEST.addKillId(ANTHARAS_STRONG)
