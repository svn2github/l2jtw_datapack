import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "132_MatrasCuriosity"

# NPC
32245
MOBS = [25540, 25542]

# Items
STONE = [10521,10522,10523,10524,10525,10526]

PAPER1 = 9800
PAPER2 = 9801

class Quest (JQuest) :

  def __init__(self, id, name, descr) : 
    JQuest.__init__(self, id, name, descr)

  def onEvent (self, event, st) :
    htmltext = event
    if event == "32245-02.htm" :
      if st.getPlayer().getLevel() >= 76 :
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
         if player.getLevel() >= 76 :
           htmltext="32245-00.htm"
           st.exitQuest(1)
         else :
           htmltext="32245-00.htm"
           st.exitQuest(1)
       else :
         if cond == 1 :
           htmltext = "32245-03.htm"
     return htmltext

  def onKill(self, npc, player, isPet) :
    partyMember = self.getRandomPartyMember(player, "1")
    if not partyMember: return
    st = partyMember.getQuestState(qn)
    if st :
      if st.getState() == State.STARTED :
          st.playSound("ItemSound.quest_itemget")
    return

QUEST       = Quest(132, qn, "麻特拉斯的好奇心")

QUEST.addStartNpc(32245)

QUEST.addTalkId(32245)

for mobId in MOBS :
  QUEST.addKillId(mobId)