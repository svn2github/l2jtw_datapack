import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
from net.sf.l2j.gameserver.model.actor.instance import L2PcInstance
from net.sf.l2j.gameserver.datatables import SkillTable
from net.sf.l2j import L2DatabaseFactory
from java.util import Iterator

qn = "7001_Protection"

NPCS=[30598,30599,30600,30601,30602,31076,31077,32135,32327]

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onEvent (self,event,st) :
    htmltext = event
    if htmltext == "01" :
       if st.getPlayer().getLevel() < 40 :
          st.getPlayer().setTarget(st.getPlayer())
          st.getPlayer().useMagic(SkillTable.getInstance().getInfo(5182,1),False,False)
          st.exitQuest(1)
          return
       else:
          st.exitQuest(1)
          return "00.htm"
    return

 def onTalk (self, npc, player):
    return "01.htm" 

QUEST       = Quest(7001,qn,"custom")

for i in NPCS:
   QUEST.addStartNpc(i)
   QUEST.addTalkId(i)
