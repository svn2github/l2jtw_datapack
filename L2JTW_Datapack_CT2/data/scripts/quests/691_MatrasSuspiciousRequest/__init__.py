#pmq
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "691_MatrasSuspiciousRequest"

# Npc
MATRAS = 32245

MOBS = [22363,22364,22365,22366,22367,22368,22369,22370,22371,22372]

# Quest Item
REDSTONE = 10372             # 紅石

ADENA = 57                   # 金幣
DYNASTICESSENCEII = 10413    # 王朝之魂II

class Quest (JQuest) :

  def __init__(self, id, name, descr) : 
    JQuest.__init__(self, id, name, descr)
    self.questItemIds = [REDSTONE]

  def onEvent (self, event, st) :
    htmltext = event
    RED = st.getQuestItemsCount(REDSTONE)
    if event == "32245-03.htm" :
      if st.getPlayer().getLevel() >= 76 :
        st.set("cond","1")
        st.setState(State.STARTED)
        st.playSound("ItemSound.quest_accept")
      else :
        htmltext = "32245-00.htm"
        st.exitQuest(1)
    elif event == "6" :
      if RED >= 744 :
        htmltext = "32245-06.htm"
        st.takeItems(REDSTONE,-744)
        st.giveItems(DYNASTICESSENCEII,1)
        st.playSound("ItemSound.quest_giveup")
      else :
        htmltext = "32245-09.htm"
    elif event == "32245-08.htm" :
        st.takeItems(RED,-1)
        st.giveItems(ADENA,RED*10000)
        st.exitQuest(1)
        st.playSound("ItemSound.quest_finish")
    return htmltext    

  def onTalk (self, npc, player) :
     htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
     st = player.getQuestState(qn)
     if st :
       id = st.getState()
       cond = st.getInt("cond")
       RED = st.getQuestItemsCount(REDSTONE)
       if id == State.CREATED :
         if player.getLevel() >= 76 :
           htmltext="32245-01.htm"
         else :
           htmltext="32245-00.htm"
           st.exitQuest(1)
       else :
         if cond == 1 and RED >= 1 :
           htmltext = "32245-05.htm"
         else :
           htmltext = "32245-04.htm"
     return htmltext

  def onKill(self, npc, player, isPet) :
    partyMember = self.getRandomPartyMember(player, "1")
    if not partyMember: return
    st = partyMember.getQuestState(qn)
    if st :
      if st.getState() == State.STARTED :
        if st.getRandom(100) < 80 :
          st.giveItems(REDSTONE, 1)
          st.playSound("ItemSound.quest_itemget")
    return

QUEST       = Quest(691, qn, "麻特拉斯可疑的委託")

QUEST.addStartNpc(32245)

QUEST.addTalkId(32245)

for mobId in MOBS:
  QUEST.addKillId(mobId)
