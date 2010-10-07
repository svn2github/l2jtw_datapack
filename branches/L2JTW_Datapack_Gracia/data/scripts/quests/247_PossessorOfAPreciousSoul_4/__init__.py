# Made by disKret
import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "247_PossessorOfAPreciousSoul_4"

#NPC
CARADINE = 31740
LADY_OF_LAKE = 31745

#QUEST ITEM
CARADINE_LETTER_LAST = 7679
NOBLESS_TIARA = 7694

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onAdvEvent (self,event,npc, player) :
   htmltext = event
   st = player.getQuestState(qn)
   if not st : return
   cond = st.getInt("cond") 
   if event == "31740-3.htm" :
     if cond == 0 :
       st.set("cond","1")
       st.setState(State.STARTED)
       st.playSound("ItemSound.quest_accept")
   elif event == "31740-5.htm" :
     if cond == 1 :
       st.set("cond","2")
       st.takeItems(CARADINE_LETTER_LAST,1)
       st.getPlayer().teleToLocation(143209,43968,-3038) #修正
   elif event == "31745-5.htm" :
     if cond == 2 :
       st.set("cond","0")
       st.getPlayer().setNoble(True)
       st.giveItems(NOBLESS_TIARA,1)
       st.playSound("ItemSound.quest_finish")
       st.exitQuest(False)
   return htmltext

 def onTalk (self,npc,player):
   htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
   st = player.getQuestState(qn)
   if not st : return htmltext
   npcId = npc.getNpcId()
   id = st.getState()
   if npcId != CARADINE and id != State.STARTED : return htmltext
   cond = st.getInt("cond")
   if id == State.CREATED :
     st.set("cond","0")
   if player.isSubClassActive() :
     if npcId == CARADINE :
         if st.getQuestItemsCount(CARADINE_LETTER_LAST) == 1 :
           if cond in [0,1] :
             if id == State.COMPLETED :
               htmltext = "<html><body>這是已經完成的任務。</body></html>"
             elif player.getLevel() < 75 : 
               htmltext = "31740-2.htm"
               st.exitQuest(1)
             elif player.getLevel() >= 75 :
               htmltext = "31740-1.htm"
         elif cond == 2 :
             htmltext = "31740-6.htm"
     elif npcId == LADY_OF_LAKE and cond == 2 :
         htmltext = "31745-1.htm"
   else :
     htmltext = "<html><body>（副職業等級50以上的角色才可以執行的任務。）</body></html>"
   return htmltext

QUEST       = Quest(247,qn,"擁有高貴靈魂之人，貴族  第四部")

QUEST.addStartNpc(CARADINE)
QUEST.addTalkId(CARADINE)
QUEST.addTalkId(LADY_OF_LAKE)