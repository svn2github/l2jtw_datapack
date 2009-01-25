import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "185_NikolasCooperationConsideration"

#NPC
30621

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onEvent (self,event,st) :
    htmltext = event
    if event == "30621-04.htm" :
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
   if npcId == 30621 and st.getInt("cond") == 0  :
     if st.getPlayer().getLevel() >= 42 :
       htmltext = "30621-00.htm"
       st.exitQuest(1)
     else :
       htmltext = "30621-00.htm"
       st.exitQuest(1)
   return htmltext

QUEST       = Quest(185,qn,"尼古拉的協助-關懷篇")

QUEST.addStartNpc(30621)

QUEST.addTalkId(30621)
