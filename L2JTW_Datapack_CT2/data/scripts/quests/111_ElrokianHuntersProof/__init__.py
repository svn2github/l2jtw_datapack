import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "111_ElrokianHuntersProof"

#NPC
32113

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onEvent (self,event,st) :
    htmltext = event
    if event == "32113-04.htm" :
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
   if npcId == 32113 and st.getInt("cond") == 0  :
     if st.getPlayer().getLevel() >= 42 :
       htmltext = "32113-00.htm"
       st.exitQuest(1)
     else :
       htmltext = "32113-00.htm"
       st.exitQuest(1)
   return htmltext

QUEST       = Quest(111,qn,"耶爾可羅獵人的證據")

QUEST.addStartNpc(32113)

QUEST.addTalkId(32113)
