import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "1109_Gracia_Flyboatwharf"

# 破滅對話
#MSG1 = ["目前破滅之種為目前在敵群的佔領之下，而且我軍正在進行攻擊。。"]
# 不滅對話
#MSG2 = ["目前不滅之種為目前在敵群的佔領之下，而且我軍正在進行攻擊。。"]
       #["目前不滅之種為目前在敵群的佔領之下，但冒險家和柯塞勒斯同盟聯合的軍勢正在攻擊苦痛棺室和侵蝕棺室。。"]
       #["目前不滅之種為目前在敵群的佔領之下，但我方的強悍攻勢已清理了前往不滅的心臟部的路，剩下的也就只有解決伊卡姆士！。" ]

class Quest (JQuest) :

 def __init__(self,id,name,descr):
     JQuest.__init__(self,id,name,descr)

 def onTalk (self,npc,player):
   st = player.getQuestState("1109_Gracia_Flyboatwharf")
   htmltext = ""
   if player.getLevel() < 75 :
      htmltext = "32632-0.htm"
      st.exitQuest(1)
   else :
      if st.getQuestItemsCount(57) < 150000 :
         htmltext = "32632-1.htm"
      else:
         st.takeItems(57,150000)
         player.teleToLocation(-149406,255247,-80)
         st.exitQuest(1)
   return htmltext

QUEST       = Quest(1109,qn,"Teleports")

QUEST.addStartNpc(32632)
QUEST.addTalkId(32632)