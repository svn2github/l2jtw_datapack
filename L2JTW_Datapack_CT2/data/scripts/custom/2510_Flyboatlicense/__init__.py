# pmq

import sys
from net.sf.l2j.gameserver.model.quest        import State
from net.sf.l2j.gameserver.model.quest        import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "2510_Flyboatlicense"

class Quest (JQuest) :

 def __init__(self,id,name,descr) : JQuest.__init__(self,id,name,descr)

 def onAdvEvent (self,event,npc,player) :
  htmltext = event
  if event == "32557-0.htm" :
    if player.isClanLeader() and player.getClan() :
      if clan.getLevel() <= 5 :
         st.exitQuest(1)
      else :
         if st.getQuestItemsCount(13277) >= 10 :
            st.takeItems(13277,10)
            st.giveItems(13559,1)
            htmltext = ""
            st.exitQuest(1)
         else :
            htmltext = "32557-2.htm"
            st.exitQuest(1)
  return htmltext

 def onTalk (self,npc,player) :
  htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
  st = player.getQuestState(qn)
  if not st : return htmltext
  npcId = npc.getNpcId()
  id = st.getState()
  if npcId == 32557 :
    if st.getQuestItemsCount(13559) == 0 :
       htmltext =  "32557-1.htm"
    else :
       st.exitQuest(1)
       htmltext = "32557-3.htm"
  return htmltext

QUEST	    = Quest(2510,qn,"custom")

QUEST.addStartNpc(32557)
QUEST.addTalkId(32557)

