import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "183_RelicExploration"

# NPC
30512

# Items

class Quest (JQuest) :

  def __init__(self, id, name, descr) : 
    JQuest.__init__(self, id, name, descr)

  def onEvent (self, event, st) :
    htmltext = event
    if event == "30512-02.htm" :
      if st.getPlayer().getLevel() >= 40 :
        st.set("cond","1")
        st.setState(State.STARTED)
        st.playSound("ItemSound.quest_accept")
        st.exitQuest(1)
    return htmltext    

  def onTalk (self, npc, player) :
     htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
     st = player.getQuestState(qn)
     if st :
       id = st.getState()
       cond = st.getInt("cond")
       if id == State.CREATED :
         if player.getLevel() >= 40 :
           htmltext="30512-00.htm"
           st.exitQuest(1)
         else :
           htmltext="30512-00.htm"
           st.exitQuest(1)
       else :
         if cond == 1 :
           htmltext = "30512-03.htm"
     return htmltext

  def onKill(self, npc, player, isPet) :
    partyMember = self.getRandomPartyMember(player, "1")
    if not partyMember: return
    st = partyMember.getQuestState(qn)
    if st :
      if st.getState() == State.STARTED :
          st.playSound("ItemSound.quest_itemget")
    return

QUEST       = Quest(183, qn, "探查巨人的遺蹟")

QUEST.addStartNpc(30512)

QUEST.addTalkId(30512)
