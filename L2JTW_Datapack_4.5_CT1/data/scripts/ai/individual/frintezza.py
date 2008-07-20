# 測試用腳本

import sys
import time
from net.sf.l2j.gameserver.ai import CtrlIntention
from net.sf.l2j.gameserver.datatables import SkillTable
from net.sf.l2j.gameserver.instancemanager import FrintezzaManager
from net.sf.l2j.gameserver.model import L2Character
from net.sf.l2j.gameserver.model.actor.instance import L2NpcInstance 
from net.sf.l2j.gameserver.model.actor.instance import L2PcInstance
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
from net.sf.l2j.gameserver.serverpackets import NpcSay
from net.sf.l2j.gameserver.serverpackets import Earthquake
from net.sf.l2j.gameserver.serverpackets import MagicSkillUse
from net.sf.l2j.gameserver.serverpackets import PlaySound
from net.sf.l2j.gameserver.serverpackets import SocialAction

# NPCS
IMPERIAL_TOMB_GUIDE = 32011 # 皇陵引導者
HALISHWEAK = 29046 # 哈里夏
HALISHSTRONG = 29047 # 哈里夏變身
TELECUBE = 29061 # 最後的皇陵 - 轉移晶體

# ITEMS
SCROLL = 8073 # 芙琳泰沙的結界破咒書

MSG1 = "<html><body>在結界那一邊感覺不到任何東西。下次再來吧。<br>（現在芙琳泰沙不在皇陵內部，所以不能進去。）</body></html>"
MSG2 = "<html><body>沒有反應。我看還是得由指揮頻道主人接觸才行。</body></html>"

class frintezza(JQuest) :
  def __init__(self,id,name,descr) :
      JQuest.__init__(self,id,name,descr)

  def onTalk (self,npc,player):
     st = player.getQuestState("frintezza")
     st2 = player.getQuestState("654_JourneytoaSettlement")
     if not st : return
     Enable = FrintezzaManager.getInstance().isEnableEnterToLair() and st.getQuestItemsCount(SCROLL)
     npcId = npc.getNpcId()
     if st2:
        if st2.getState() == State.COMPLETED :
           if Enable :
              FrintezzaManager.getInstance().setScarletSpawnTask()
              FrintezzaManager.getInstance().addPlayerToLair(st.player)
              st.player.teleToLocation(174243,-86318,-5107) # 測試傳送位置
           else:
              st.exitQuest(1)
              return MSG1
        else:
           st.exitQuest(1)
           return MSG1
     else:
        st.exitQuest(1)
        return MSG1
     return

  def onAttack (self,npc,player,damage,isPet):
     npcId = npc.getNpcId()
     objId = npc.getObjectId()
     heading = npc.getHeading()
     if npcId == HALISHWEAK :
        if npc.getCurrentHp() < npc.getMaxHp() * 0.25 :
           npc.reduceCurrentHp(9999999,npc)
           newNpc = self.addSpawn(HALISHSTRONG, npc)
           newNpc.setHeading(heading)
           newNpc.broadcastPacket(SocialAction(objId,3))
           newNpc.getAI().setIntention(CtrlIntention.AI_INTENTION_ATTACK, player);
     return

  def onKill(self,npc,player,isPet):
     st = player.getQuestState("frintezza")
     if not st: return
     npcId = npc.getNpcId()
     objId = npc.getObjectId()
     heading = npc.getHeading()
     if npcId == HALISHSTRONG :
        FrintezzaManager.getInstance().setBossDead()
        self.addSpawn(TELECUBE,npc.getX(),npc.getY(),npc.getZ(),0,False,600000)
        st.exitQuest(1)
     return

QUEST       = frintezza(-1,"frintezza","ai")

QUEST.addStartNpc(IMPERIAL_TOMB_GUIDE)
QUEST.addTalkId(IMPERIAL_TOMB_GUIDE)
QUEST.addKillId(HALISHSTRONG)
QUEST.addAttackId(HALISHWEAK)
QUEST.addAttackId(HALISHSTRONG)

