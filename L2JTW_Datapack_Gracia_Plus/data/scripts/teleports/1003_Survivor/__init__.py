#made by Kerberos
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "1003_Survivor"
# pmq 補充
# 破滅對話
# MSG1 = ["目前破滅之種為目前在敵群的佔領之下，而且我軍正在進行攻擊。。"]
# 不滅對話
# MSG2 = ["目前不滅之種為目前在敵群的佔領之下，而且我軍正在進行攻擊。。"]
       # ["目前不滅之種為目前在敵群的佔領之下，但冒險家和柯塞勒斯同盟聯合的軍勢正在攻擊苦痛棺室和侵蝕棺室。。"]
       # ["目前不滅之種為目前在敵群的佔領之下，但我方的強悍攻勢已清理了前往不滅的心臟部的路，剩下的也就只有解決伊卡姆士！。" ]

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onAdvEvent (self,event,npc,player):
    st = player.getQuestState(qn)
    if not st: return
    if event:
       if player.getLevel() < 75:
          return "32632-3.htm"
       if st.getQuestItemsCount(57) >= 150000 :
          st.takeItems(57,150000)
          player.teleToLocation(-149406, 255247, -80)
          return
    return event

 def onTalk (self,npc,player):
   st = player.getQuestState(qn)
   if not st :
      return ""
   return "32632-1.htm"

QUEST       = Quest(-1,qn,"Teleports")
QUEST.addStartNpc(32632)
QUEST.addTalkId(32632)