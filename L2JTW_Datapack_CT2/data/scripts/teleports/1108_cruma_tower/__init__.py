# Made by Michiru
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "1108_cruma_tower"

MOZELLA = 30483

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onTalk (Self,npc,player):
   st = player.getQuestState(qn)
   npcId = npc.getNpcId()
   if npcId == MOZELLA :
     if st.getPlayer().getLevel() < 56 :
       player.teleToLocation(17724,114004,-11672)
       st.exitQuest(1)
     else :
       htmltext = "<html><body>守門人莫查雷拉：<br>啊...！因為您的力量太強，所以無法開啟時空之門。看來好像是超越了塔的磁場所能接受的界限。<br>（等級56以上的角色無法進入克魯瑪高塔。）</body></html>"
       return htmltext
       st.exitQuest(1)

QUEST       = Quest(1108,qn,"Teleports")

QUEST.addStartNpc(MOZELLA)

QUEST.addTalkId(MOZELLA)
