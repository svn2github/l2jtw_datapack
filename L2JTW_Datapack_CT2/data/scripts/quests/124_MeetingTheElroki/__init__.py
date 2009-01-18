#Made by Kerb
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "124_MeetingTheElroki"

#Npc
MARQUEZ = 32113
MUSHIKA = 32114
ASAMAH = 32115
KARAKAWEI = 32117
MANTARASA = 32118
#Items
M_EGG = 8778

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onEvent (self,event,st) :
   cond = st.getInt("cond")
   htmltext = event
   if st.getState() != State.COMPLETED :
    if event == "32113-02.htm" :
       st.setState(State.STARTED) 
    elif event == "32113-03.htm" :
         st.set("cond","1")
         st.playSound("ItemSound.quest_accept")
    elif event == "32113-04.htm" :
         st.set("cond","2")
         st.playSound("ItemSound.quest_itemget")
    elif event == "32114-02.htm" :
         st.set("cond","3")
         st.playSound("ItemSound.quest_itemget")
    elif event == "32115-04.htm" :
         st.set("cond","4")
         st.playSound("ItemSound.quest_itemget")
    elif event == "32117-02.htm" :
         st.set("progress","MIDDLE")
    elif event == "32117-03.htm" :
         st.set("cond","5")
         st.playSound("ItemSound.quest_itemget")
    elif event == "32118-02.htm" :
         st.giveItems(M_EGG,1)
         st.set("cond","6")
         st.playSound("ItemSound.quest_middle")
   return htmltext

 def onTalk (self,npc,player):
   htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
   st = player.getQuestState(qn)
   if not st : return htmltext
   npcId = npc.getNpcId()
   id = st.getState()
   cond = st.getInt("cond")
   if npcId == MARQUEZ and cond == 0 :
      if id == State.COMPLETED :
         htmltext = "<html><body>這是已經完成的任務。</body></html>"
      elif player.getLevel() < 75 :
          htmltext = "32113-01a.htm"
          st.exitQuest(1)
      else :
          htmltext = "32113-01.htm"
   elif id == State.STARTED :    
      if npcId == MARQUEZ and cond == 1 :
          htmltext = "32113-03.htm"
      elif npcId == MARQUEZ and cond == 2 :
          htmltext = "32113-04a.htm"
      elif npcId == MARQUEZ and cond == 3 :    #pmq增加對話
          htmltext = "32113-05.htm"
      elif npcId == MARQUEZ and cond == 4 :    #pmq增加對話
          htmltext = "32113-05.htm"
      elif npcId == MARQUEZ and cond == 5 :    #pmq增加對話
          htmltext = "32113-05.htm"
      elif npcId == MARQUEZ and cond == 6 :    #pmq增加對話
          htmltext = "32113-05.htm"
      elif npcId == MUSHIKA and cond == 2 :
          htmltext = "32114-01.htm"
      elif npcId == MUSHIKA and cond == 3 :    #pmq增加對話
          htmltext = "32114-03.htm"
      elif npcId == MUSHIKA and cond == 4 :    #pmq增加對話
          htmltext = "32114-03.htm"
      elif npcId == MUSHIKA and cond == 5 :    #pmq增加對話
          htmltext = "32114-03.htm"
      elif npcId == MUSHIKA and cond == 6 :    #pmq增加對話
          htmltext = "32114-03.htm"
      elif npcId == ASAMAH and cond == 2 :     #pmq增加對話
          htmltext = "32115-00.htm"
      elif npcId == ASAMAH and cond == 3 :
          htmltext = "32115-01.htm"
      elif npcId == ASAMAH and cond == 4 :     #pmq增加對話
          htmltext = "32115-06.htm"
      elif npcId == ASAMAH and cond == 5 :     #pmq增加對話
          htmltext = "32115-07.htm"
      elif npcId == ASAMAH and cond == 6 :
          htmltext = "32115-08.htm"            # pmq修正
          st.takeItems(M_EGG,1)
          st.giveItems(57,100013)
          st.addExpAndSp(301922,30294)
          st.set("cond","0")
          st.exitQuest(False)
          st.playSound("ItemSound.quest_finish")
      elif npcId == KARAKAWEI and cond == 2 :  #pmq增加對話
          htmltext = "32117-00.htm"
      elif npcId == KARAKAWEI and cond == 3 :  #pmq增加對話
          htmltext = "32117-00.htm"
      elif npcId == KARAKAWEI and cond == 4 :
          htmltext = "32117-01.htm"
          if st.get("progress") : #check if the variable has been set
             if st.get("progress")== "MIDDLE": #if set, check its value...
                htmltext = "32117-02.htm"
      elif npcId == KARAKAWEI and cond == 5 :  #pmq增加對話
          htmltext = "32117-04.htm"
      elif npcId == KARAKAWEI and cond == 6 :  #pmq增加對話
          htmltext = "32117-05.htm"
      elif npcId == MANTARASA and cond == 5 :
          htmltext = "32118-01.htm"
      elif npcId == MANTARASA and cond == 6 :  #pmq增加對話
          htmltext = "32118-03.htm"
   return htmltext

QUEST       = Quest(124,qn,"與耶爾可羅的相遇")

QUEST.addStartNpc(MARQUEZ)
QUEST.addTalkId(MARQUEZ)
QUEST.addTalkId(MUSHIKA)
QUEST.addTalkId(ASAMAH)
QUEST.addTalkId(KARAKAWEI)
QUEST.addTalkId(MANTARASA)
