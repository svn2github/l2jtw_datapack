# Made in Taiwan for CT1

import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "7002_NewbieGuide"

NPCS = [30598,30599,30600,30601,30602,32135]

FIGHTER = [0x00,0x12,0x1f,0x2c,0x35,0x7b,0x7c]
MAGE = [0x0a,0x19,0x26,0x31]

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onEvent (self,event,st):
     htmltext = event
     return htmltext

 def onTalk (Self,npc,player):
    htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
    st = player.getQuestState(qn)
    if not st : return htmltext
    npcId = npc.getNpcId()
    Level = st.getPlayer().getLevel()
    ClassId = player.getClassId().getId()

    if npcId == 30598 : # 人類
       if player.getRace().ordinal() == 0 :
          if Level < 20 :
             if ClassId in FIGHTER :
                htmltext = str(npcId)+"-f.htm"
             elif ClassId in MAGE :
                htmltext = str(npcId)+"-m.htm"
             else:
                htmltext = str(npcId)+"-lv.htm"
          elif Level > 19 :
             htmltext = str(npcId)+"-lv.htm"
       else:
          htmltext = str(npcId)+"-00.htm"

    elif npcId == 30599 : # 精靈
       if player.getRace().ordinal() == 1 :
          if Level < 20 :
             if ClassId in FIGHTER :
                htmltext = str(npcId)+"-f.htm"
             elif ClassId in MAGE :
                htmltext = str(npcId)+"-m.htm"
             else:
                htmltext = str(npcId)+"-lv.htm"
          elif Level > 19 :
             htmltext = str(npcId)+"-lv.htm"
       else:
          htmltext = str(npcId)+"-00.htm"

    elif npcId == 30600 : # 黑暗精靈
       if player.getRace().ordinal() == 2 :
          if Level < 20 :
             if ClassId in FIGHTER :
                htmltext = str(npcId)+"-f.htm"
             elif ClassId in MAGE :
                htmltext = str(npcId)+"-m.htm"
             else:
                htmltext = str(npcId)+"-lv.htm"
          elif Level > 19 :
             htmltext = str(npcId)+"-lv.htm"
       else:
          htmltext = str(npcId)+"-00.htm"

    elif npcId == 30601 : # 矮人
       if player.getRace().ordinal() == 4 :
          if Level < 20 :
             if ClassId in FIGHTER :
                htmltext = str(npcId)+"-f.htm"
             else:
                htmltext = str(npcId)+"-lv.htm"
          elif Level > 19 :
             htmltext = str(npcId)+"-lv.htm"
       else:
          htmltext = str(npcId)+"-00.htm"

    elif npcId == 30602 : # 半獸人
       if player.getRace().ordinal() == 3 :
          if Level < 20 :
             if ClassId in FIGHTER :
                htmltext = str(npcId)+"-f.htm"
             elif ClassId in MAGE :
                htmltext = str(npcId)+"-m.htm"
             else:
                htmltext = str(npcId)+"-lv.htm"
          elif Level > 19 :
             htmltext = str(npcId)+"-lv.htm"
       else:
          htmltext = str(npcId)+"-00.htm"

    elif npcId == 32135 : # 闇天使
       if player.getRace().ordinal() == 5 :
          if Level < 20 :
             if ClassId in FIGHTER :
                htmltext = str(npcId)+"-f.htm"
             else:
                htmltext = str(npcId)+"-lv.htm"
          elif Level > 19 :
             htmltext = str(npcId)+"-lv.htm"
       else:
          htmltext = str(npcId)+"-00.htm"

    return htmltext

QUEST       = Quest(7002,qn,"custom")

for i in NPCS:
    QUEST.addStartNpc(i)
    QUEST.addTalkId(i)
