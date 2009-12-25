# pmq 2009-05-22

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

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
    elif event == "32245-05.htm" :
        htmltext = st.showHtmlFile("32245-05.htm").replace("%pmq%",str(RED))
        st.set("talk","1")
    elif event == "32245-06.htm" :
      if RED >= 744 :
        htmltext = "32245-06.htm"
        st.takeItems(REDSTONE,744)
        st.giveItems(DYNASTICESSENCEII,1)
        st.playSound("ItemSound.quest_giveup")
        st.set("talk","1")
      else :
        htmltext = st.showHtmlFile("32245-09.htm").replace("%pmq%",str(RED))
        st.set("talk","1")
    elif event == "32245-07.htm" :
        st.set("talk","1")
    elif event == "32245-08.htm" :
        st.takeItems(RED,-1)
        st.giveItems(ADENA,RED*10000)
        st.exitQuest(1)
        st.playSound("ItemSound.quest_finish")
    return htmltext    
	
  def onTalk (self,npc,player):
    htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
    st = player.getQuestState(qn)
    if not st : return htmltext
    id = st.getState()
    cond = st.getInt("cond")
    talk = st.getInt("talk")
    RED = st.getQuestItemsCount(REDSTONE)
    if id == State.CREATED :
      if player.getLevel() >= 76 :
         htmltext="32245-01.htm"
      else :
         htmltext="32245-00.htm"
         st.exitQuest(1)
    else :
      if RED >= 1 :
        if talk == 0 :
           htmltext = "32245-04a.htm"  # 備註：官服麻特拉斯進入 32245-05 這段時會收取你身上全部紅石 但32245-05 32245-50a 32245-09 這幾個 htm 會顯示收取紅石數量 但不會給回你的
        else :
           htmltext = "32245-04.htm"
           st.set("talk","0")
      if RED >= 1 :
        if talk >= 1 :
           htmltext = st.showHtmlFile("32245-05a.htm").replace("%pmq%",str(RED))
      else :
           htmltext = "32245-04.htm"
           st.set("talk","0")
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
