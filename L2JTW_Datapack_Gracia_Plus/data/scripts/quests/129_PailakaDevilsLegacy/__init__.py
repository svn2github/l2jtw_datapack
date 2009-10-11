import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "129_PailakaDevilsLegacy"

#NPC
32498

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onEvent (self,event,st) :
    htmltext = event
    if event == "32498-04.htm" :
        st.set("cond","1")
        st.setState(State.STARTED)
        st.playSound("ItemSound.quest_accept")
    return htmltext


 def onTalk (self,npc,player) :
   npcId = npc.getNpcId()
   htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
   st = player.getQuestState(qn)
   if not st: return htmltext
   id = st.getState()
   if id == State.CREATED :
     st.set("cond","0")
   if npcId == 32498 and st.getInt("cond") == 0  :
     if st.getPlayer().getLevel() >= 67 :
       htmltext = "32498-00.htm"
       st.exitQuest(1)
     else :
       htmltext = "32498-01.htm"
       st.exitQuest(1)
   return htmltext

QUEST       = Quest(129,qn,"菲拉卡-惡魔的遺產")

QUEST.addStartNpc(32498)

QUEST.addTalkId(32498)
