# Made by Cromir Version 0.1
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "130_PathToHellbound"

#NPCs
GALATE = 32292
CASIAN = 30612

#ITEMS
CASIAN_BLUE_CRY = 12823

class Quest (JQuest) :

 def __init__(self,id,name,descr):
     JQuest.__init__(self,id,name,descr)
     self.questItemIds = [CASIAN_BLUE_CRY]

 def onEvent (self,event,st) :
   htmltext = event
   if event == "30612-04.htm" :    #pmq 修改
     st.set("cond","1")
     st.setState(State.STARTED)
     st.playSound("ItemSound.quest_accept")
   elif event == "32292-03.htm" :
	 st.set("cond","2")
	 st.playSound("ItemSound.quest_middle")
   elif event == "30612-07.htm" :  #pmq 修改 
	 st.set("cond","3")
	 st.giveItems(CASIAN_BLUE_CRY,1)
	 st.playSound("ItemSound.quest_middle")
   elif event == "32292-07.htm" :
	 st.takeItems(CASIAN_BLUE_CRY,-1)
	 st.playSound("ItemSound.quest_finish")
	 st.exitQuest(False)
   return htmltext

 def onTalk (self,npc,player):
   st = player.getQuestState(qn)
   htmltext = "<html><body>目前沒有執行任務，或條件不符合。</body></html>"
   if not st: return htmltext

   npcId = npc.getNpcId()
   id = st.getState()
   cond = st.getInt("cond")

   if id == State.COMPLETED :
     htmltext = "<html><body>這是已經完成的任務。</body></html>"

   elif npcId == CASIAN and cond == 0 :
     if player.getLevel() >= 78 :
       htmltext = "30612-01.htm"
     else :
       htmltext = "30612-00.htm"
       st.exitQuest(1)
   elif npcId == GALATE and cond == 1 :
       htmltext = "32292-01.htm"
   elif npcId == CASIAN and cond == 1 :
       htmltext = "30612-05.htm"    #修改 pmq 增加對話
   elif npcId == CASIAN and cond == 2 :
       htmltext = "30612-06.htm"    #修改 pmq 增加對話
   elif npcId == GALATE and cond == 2 :
       htmltext = "32292-04.htm"    #修改 pmq 增加對話
   elif npcId == CASIAN and cond == 3 :
       htmltext = "30612-08.htm"    #修改 pmq 增加對話
   elif npcId == GALATE and cond == 3 :
     if st.getQuestItemsCount(CASIAN_BLUE_CRY) == 1 :
       htmltext = "32292-05.htm"
     else :
       htmltext = "32292-04.htm"
   return htmltext

QUEST     = Quest(130,qn,"往地獄邊界的路")

QUEST.addStartNpc(CASIAN)

QUEST.addTalkId(CASIAN)
QUEST.addTalkId(GALATE)