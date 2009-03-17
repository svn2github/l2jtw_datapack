# Made by disKret
import sys
from net.sf.l2j.util import Rnd
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "34_InSearchOfClothes"

SPINNERET = 7528
SUEDE = 1866
THREAD = 1868
SPIDERSILK = 1493
MYSTERIOUS_CLOTH = 7076

class Quest (JQuest) :

 def __init__(self,id,name,descr):
     JQuest.__init__(self,id,name,descr)
     self.questItemIds = [SPINNERET,SPIDERSILK]

 def onEvent (self,event,st) :
   htmltext = event
   cond = st.getInt("cond")
   if event == "30088-1.htm" and cond == 0:
     st.set("cond","1")
     st.setState(State.STARTED)
     st.playSound("ItemSound.quest_accept")
   if event == "30294-1.htm" and cond == 1 :
     st.set("cond","2")
     st.playSound("ItemSound.quest_accept")   #pmq修改
   if event == "30088-3.htm" and cond == 2:
     st.set("cond","3")
     st.playSound("ItemSound.quest_accept")   #pmq修改
   if event == "30165-1.htm" and cond == 3:
     st.set("cond","4")
     st.playSound("ItemSound.quest_accept")   #pmq修改
   if event == "30165-3.htm" and cond == 5:
     if st.getQuestItemsCount(SPINNERET) == 10 :
       st.takeItems(SPINNERET,10)
       st.giveItems(SPIDERSILK,1)
       st.set("cond","6")
       st.playSound("ItemSound.quest_accept") #pmq修改
     else :
       htmltext = "30165-1a.htm"              #pmq修改
   if event == "30088-5.htm" and cond == 6 :
     if st.getQuestItemsCount(SUEDE) >= 3000 and st.getQuestItemsCount(THREAD) >= 5000 and st.getQuestItemsCount(SPIDERSILK) == 1 :
       st.takeItems(SUEDE,3000)
       st.takeItems(THREAD,5000)
       st.takeItems(SPIDERSILK,1)
       st.giveItems(MYSTERIOUS_CLOTH,1)
       st.playSound("ItemSound.quest_finish")
       st.exitQuest(False)
       st.unset("cond")
     else :
       htmltext = "30088-4a.htm"              #pmq修改
   return htmltext

 def onTalk (self,npc,player):
   htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
   st = player.getQuestState(qn)
   if not st : return htmltext
   npcId = npc.getNpcId()
   id = st.getState()
   cond = st.getInt("cond")
   if id == State.COMPLETED:
     htmltext = "<html><body>這是已經完成的任務。</body></html>"
   elif npcId == 30088 and cond == 0 and st.getQuestItemsCount(MYSTERIOUS_CLOTH) == 0 :
     fwear=player.getQuestState("37_PleaseMakeMeFormalWear")
     if fwear :
       if fwear.get("cond") == "6" :
         htmltext = "30088-0.htm"
       else :
         htmltext = "30088-6.htm"   #pmq增加對話
         st.exitQuest(1)
     else :
       htmltext = "30088-6.htm"     #pmq增加對話
       st.exitQuest(1)
   elif id == State.STARTED :    
       if npcId == 30294 and cond == 1 :
         htmltext = "30294-0.htm"
       elif npcId == 30088 and cond == 1 :
         htmltext = "30088-1a.htm"  #pmq增加對話
       elif npcId == 30088 and cond == 2 :
         htmltext = "30088-2.htm"
       elif npcId == 30294 and cond == 2 :
         htmltext = "30294-1a.htm"  #pmq增加對話
       elif npcId == 30165 and cond == 3 :
         htmltext = "30165-0.htm"
       elif npcId == 30165 and cond == 4 :
         htmltext = "30165-1a.htm"  #pmq增加對話
       elif npcId == 30088 and cond == 3 :
         htmltext = "30088-3a.htm"  #pmq增加對話
       elif npcId == 30165 and cond == 5 :
         htmltext = "30165-2.htm"
       elif npcId == 30165 and cond == 6 :
         htmltext = "30165-3a.htm"  #pmq增加對話
       elif npcId == 30088 and cond == 6 :
          htmltext = "30088-4.htm"
   return htmltext

 def onKill(self,npc,player,isPet):
   partyMember = self.getRandomPartyMember(player,"4")
   if not partyMember : return
   st = partyMember.getQuestState(qn)
   if not st : return 
   if st.getState() != State.STARTED : return

   count = st.getQuestItemsCount(SPINNERET)
   if count < 10 :
     st.giveItems(SPINNERET,1)
     if count == 9 :
       st.playSound("ItemSound.quest_middle")
       st.set("cond","5")
     else :
       st.playSound("ItemSound.quest_itemget")
   return

QUEST = Quest(34,qn,"尋找布料")

QUEST.addStartNpc(30088)
QUEST.addTalkId(30088)

QUEST.addTalkId(30165)
QUEST.addTalkId(30294)
QUEST.addKillId(20560)
QUEST.addKillId(20561)