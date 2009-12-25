# pmq

import sys
from com.l2jserver.gameserver.model.quest        import State
from com.l2jserver.gameserver.model.quest        import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "2510_Flyboatlicense"

# ITEM
POWERSTARSTONE = 13277
LICENSE = 13559

class Quest (JQuest) :

 def __init__(self,id,name,descr) : JQuest.__init__(self,id,name,descr)

 def onAdvEvent (self,event,npc,player) :
  st = player.getQuestState(qn)
  if not st: return
  htmltext = event
  if event == "32557-0.htm" :
    if player.isClanLeader() :
      if player.getClan().getLevel() < 5 :
          st.exitQuest(1)
      else :
         if st.getQuestItemsCount(POWERSTARSTONE) >= 10 :
            st.takeItems(POWERSTARSTONE,10)
            st.giveItems(LICENSE,1)
            htmltext = ""
            st.exitQuest(1)
         else :
            htmltext = "32557-2.htm"
            st.exitQuest(1)
  return htmltext

 def onTalk (self,npc,player) :
  htmltext = ""
  st = player.getQuestState(qn)
  if not st : return htmltext
  npcId = npc.getNpcId()
  id = st.getState()
  if npcId == 32557 :
    if st.getQuestItemsCount(LICENSE) == 0 :
       htmltext =  "32557-1.htm"
    else :
       st.exitQuest(1)
       htmltext = "32557-3.htm"
  return htmltext

QUEST	    = Quest(2510,qn,"custom")

QUEST.addStartNpc(32557)
QUEST.addTalkId(32557)

