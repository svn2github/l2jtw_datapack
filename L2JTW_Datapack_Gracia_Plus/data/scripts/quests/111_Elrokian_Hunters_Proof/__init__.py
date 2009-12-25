# 111 Elrokian Hunter's Proof by TheOne

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest
from com.l2jserver.gameserver.network.serverpackets import PlaySound

qn = "111_Elrokian_Hunters_Proof"

#NPCS
MARQUEZ = 32113
MUSHIKA = 32114
ASHAMAH = 32115
KIRIKASHIN = 32116
 
#QUEST ITEM
FRAGMENT = 8768
ADENA = 57

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onEvent (self,event,st) :
    htmltext = event
    if event == "32113-05" :
        st.set("cond","1")
        st.setState(State.STARTED)
        htmltext = "32113-05.htm"
        st.playSound("ItemSound.quest_accept")
    elif event == "32113-04.htm" :
        st.exitQuest(1)
    elif event == "32115-03.htm" :
        st.set("cond","3")
        st.playSound("ItemSound.quest_accept")
    elif event == "32113-13.htm" :
        st.set("cond","4")
        st.playSound("ItemSound.quest_accept")
    return htmltext

 def onTalk (self,npc,player) :
    htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
    st = player.getQuestState(qn)
    if not st: return htmltext
    state = st.getState()
    npcId = npc.getNpcId()
    cond = st.getInt("cond")
    if state == State.COMPLETED :
       htmltext = "<html><body>這是已經完成的任務。</body></html>"
    elif npcId == MARQUEZ :
       if state == State.CREATED :
          if st.getPlayer().getLevel() >= 75 :
             htmltext = "32113-01.htm"
          else :
             htmltext = "32113-00.htm"
             st.exitQuest(1)
       elif cond == 1 :
            htmltext = "32113-06.htm"
       elif cond == 3 :
            htmltext = "32113-07.htm"
       elif cond == 4 :
            htmltext = "32113-14.htm"
       elif cond == 5 :
          if st.getQuestItemsCount(FRAGMENT) >= 50 :
             st.takeItems(FRAGMENT,-1)
             st.set("cond","6")
             st.playSound("ItemSound.quest_middle")
             htmltext = "32113-15.htm"
    elif npcId == MUSHIKA :
       if cond == 1 :
          htmltext = "32114-01.htm"
          st.set("cond","2")
          st.playSound("ItemSound.quest_accept")
       elif cond in [2,3] :
            htmltext = "32114-02.htm"
    elif npcId == ASHAMAH :
       if cond == 1 :
          htmltext = "32115-01.htm"
       elif cond == 2 :
            htmltext = "32115-02.htm"
       elif cond == 3 :
            htmltext = "32115-04.htm"
       elif cond == 8 :
            st.set("cond","9")
            st.playSound("ItemSound.quest_middle")
            htmltext = "32115-05.htm"
       elif cond == 9 :
            st.set("cond","10")
            st.playSound("ItemSound.quest_middle")
            htmltext = "32115-06.htm"
       elif cond == 11 :
            st.takeItems(8770,-1)
            st.takeItems(8771,-1)
            st.takeItems(8772,-1)
            st.giveItems(8773,1)
            st.set("cond","12")
            st.playSound("ItemSound.quest_middle")
            htmltext = "32115-07.htm"
    elif npcId == KIRIKASHIN :
       if cond == 6 :
          st.set("cond","8")
          st.playSound("EtcSound.elcroki_song_full")
          htmltext = "32116-01.htm"
       elif cond == 12 :
          if st.getQuestItemsCount(8773) >= 1 :
             st.takeItems(8773,1)
             st.giveItems(8763,1)
             st.giveItems(8764,100)
             st.giveItems(ADENA,1022636)
             st.playSound("ItemSound.quest_finish")
             htmltext = "32116-02.htm"
             st.exitQuest(False)
    return htmltext

 def onKill(self,npc,player,isPet):
    st = player.getQuestState(qn)
    if not st: return
    npcId = npc.getNpcId()
    cond = st.getInt("cond")
 
    if npcId in [22196,22197,22198,22218] and cond == 4 :
       if st.getRandom(100) < 25 :
          st.giveItems(FRAGMENT,1)
          if st.getQuestItemsCount(FRAGMENT) <= 49 :
             st.playSound("ItemSound.quest_itemget")
          else:
             st.set("cond","5")  
             st.playSound("ItemSound.quest_middle")
    elif npcId in [22200,22201,22202,22219] and cond == 10 :
         if st.getRandom(100) < 75 :
            st.giveItems(8770,1)
            if st.getQuestItemsCount(8770) <= 9 :
               st.playSound("ItemSound.quest_itemget")
    elif npcId in [22208,22209,22210,22221] and cond == 10 :
         if st.getRandom(100) < 75 :
            st.giveItems(8772,1)
            if st.getQuestItemsCount(8772) <= 9 :
               st.playSound("ItemSound.quest_itemget")
    elif npcId in [22203,22204,22205,22220] and cond == 10 :
         if st.getRandom(100) < 75 :
            st.giveItems(8771,1)
            if st.getQuestItemsCount(8771) <= 9 :
               st.playSound("ItemSound.quest_itemget")
         if st.getQuestItemsCount(8770) >= 10 and st.getQuestItemsCount(8771) >= 10 and st.getQuestItemsCount(8772) >= 10 :
            st.set("cond","11")  
            st.playSound("ItemSound.quest_middle")
    return

QUEST       = Quest(111,qn,"耶爾可羅獵人的證據")
 
QUEST.addStartNpc(32113)
 
for i in [32113,32114,32115,32116] :
    QUEST.addTalkId(i)
 
for i in [22196,22197,22198,22200,22201,22203,22204,22205,22208,22209,22210,22218,22222] :
    QUEST.addKillId(i)