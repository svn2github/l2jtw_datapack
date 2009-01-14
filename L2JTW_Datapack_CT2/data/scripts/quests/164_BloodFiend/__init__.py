# Made by Mr. Have fun! Version 0.2
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "164_BloodFiend"

KIRUNAK_SKULL_ID = 1044
ADENA_ID = 57

class Quest (JQuest) :

 def __init__(self,id,name,descr):
     JQuest.__init__(self,id,name,descr)
     self.questItemIds = [KIRUNAK_SKULL_ID]

 def onEvent (self,event,st) :
    htmltext = event
    if event == "1" :
        st.set("id","0")
        htmltext = "30149-04.htm"
        st.set("cond","1")
        st.setState(State.STARTED)
        st.playSound("ItemSound.quest_accept")
    return htmltext


 def onTalk (self,npc,player):
   htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
   st = player.getQuestState(qn)
   if not st : return htmltext

   npcId = npc.getNpcId()
   id = st.getState()
   if npcId == 30149 and st.getInt("cond")==0 and st.getInt("onlyone")==0 :
     if player.getRace().ordinal() == 2 :
       htmltext = "30149-00.htm"
     elif player.getLevel() >= 21 :
       htmltext = "30149-03.htm"
       return htmltext
     else:
       htmltext = "30149-02.htm"
       st.exitQuest(1)
   elif npcId == 30149 and st.getInt("cond")==0 and st.getInt("onlyone")==1 :
      htmltext = "<html><body>這是已經完成的任務。</body></html>"

   elif npcId == 30149 and st.getInt("cond") :
      if st.getQuestItemsCount(KIRUNAK_SKULL_ID)<1 :
        htmltext = "30149-05.htm"
      elif st.getQuestItemsCount(KIRUNAK_SKULL_ID) >= 1 and st.getInt("onlyone") == 0 :
          if st.getInt("id") != 164 :
            st.set("id","164")
            htmltext = "30149-06.htm"
            st.giveItems(ADENA_ID,42000)
            st.addExpAndSp(35637,1854)
            st.takeItems(KIRUNAK_SKULL_ID,1)
            st.set("cond","0")
            st.exitQuest(False)
            st.playSound("ItemSound.quest_finish")
            st.set("onlyone","1")
   return htmltext

 def onKill(self,npc,player,isPet):
   st = player.getQuestState(qn)
   if not st : return
   if st.getState() != State.STARTED: return

   npcId = npc.getNpcId()
   if npcId == 27021 :
        st.set("id","0")
        if st.getInt("cond") == 1 and st.getQuestItemsCount(KIRUNAK_SKULL_ID) == 0 :
          st.giveItems(KIRUNAK_SKULL_ID,1)
          st.playSound("ItemSound.quest_middle")
   return

QUEST       = Quest(164,qn,"血腥的惡魔")

QUEST.addStartNpc(30149)

QUEST.addTalkId(30149)

QUEST.addKillId(27021)
