# Made by disKret
# Update by pmq
# High Five 26-03-2011
import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "246_PossessorOfAPreciousSoul_3"

#NPC
LADD     = 30721  # 教師 拉德
CARADINE = 31740  # 凱拉蒂
OSSIAN   = 31741  # 歐夏恩

#QUEST ITEM
CARADINE_LETTER      = 7678  # 凱拉蒂的信
CARADINE_LETTER_LAST = 7679  # 凱拉蒂的信
WATERBINDER          = 7591  # 女神的戒指-水之羈絆
EVERGREEN            = 7592  # 女神的項鍊-綠之永恆
RAIN_SONG            = 7593  # 女神的手杖-雨之詩歌
RELIC_BOX            = 7594  # 聖物箱子
#                    = 21725 # 女神的手杖-雨之詩歌碎片

#MOBS
PILGRIM_OF_SPLENDOR = 21541  # 輝煌的求道者
JUDGE_OF_SPLENDOR   = 21544  # 輝煌的審判官
BARAKIEL            = 25325  # 狩獵首領 輝煌之炎 貝拉凱爾
# = 21535  # 輝煌的印記
# = 21536  # 輝煌的王冕
# = 21537  # 輝煌的獸牙
# = 21538  # 輝煌的獸牙
# = 21539  # 輝煌的苦痛
# = 21540  # 輝煌的苦痛
MOBS = [21535,21536,21537,21538,21539,21540]

#CHANCE FOR DROP
CHANCE_FOR_DROP = 5
CHANCE_FOR_DROP_FRAGMENTS = 30 # Not verifed!

class Quest (JQuest) :

 def __init__(self,id,name,descr):
     JQuest.__init__(self,id,name,descr)
     self.questItemIds = [WATERBINDER, EVERGREEN, RAIN_SONG, RELIC_BOX]

 def onAdvEvent (self,event,npc, player) :
   htmltext = event
   st = player.getQuestState(qn)
   if not st : return
   cond = st.getInt("cond")
   if event == "31740-3.htm" :
     if cond == 0 :
       st.setState(State.STARTED)
       st.takeItems(CARADINE_LETTER,1)
       st.set("cond","1")
       st.playSound("ItemSound.quest_accept")
   elif event == "31741-2.htm" :
     if cond == 1 :
       st.set("cond","2")
       st.set("awaitsWaterbinder","1")
       st.set("awaitsEvergreen","1")
       st.playSound("ItemSound.quest_middle")
   elif event == "31741-5.htm" :
     if cond == 3 :
       st.set("cond","4")
       st.takeItems(WATERBINDER,1)
       st.takeItems(EVERGREEN,1)
       st.playSound("ItemSound.quest_middle")
   elif event == "31741-8.htm" :
     if cond == 5 :
       st.set("cond","6")
       if st.getQuestItemsCount(RAIN_SONG) == 1:
          st.takeItems(RAIN_SONG,1)
       if st.getQuestItemsCount(FRAGMENTS) >= 100:
          st.takeItems(FRAGMENTS,-1)
       st.giveItems(RELIC_BOX,1)
       st.playSound("ItemSound.quest_middle")
   elif event == "30721-2.htm" :
     if cond == 6 :
       st.set("cond","0")
       st.takeItems(RELIC_BOX,1)
       st.giveItems(CARADINE_LETTER_LAST,1)
       st.addExpAndSp(719843,0)
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
   cond=st.getInt("cond")
   if player.isSubClassActive() :
     if npcId == CARADINE :
         if cond == 0 and st.getQuestItemsCount(CARADINE_LETTER) == 1 :
           if id == State.COMPLETED :
             htmltext = "<html><body>這是已經完成的任務。</body></html>"
           elif player.getLevel() < 65 : 
             htmltext = "31740-2.htm"
             st.exitQuest(1)
           elif player.getLevel() >= 65 :
             htmltext = "31740-1.htm"
         elif cond == 1 :
             htmltext = "31740-4.htm"
     elif npcId == OSSIAN:
         if cond == 1 :
             htmltext = "31741-1.htm"
         elif cond == 2 :
           htmltext = "31741-4.htm"
         elif cond == 3 and st.getQuestItemsCount(WATERBINDER) == 1 and st.getQuestItemsCount(EVERGREEN) == 1 :
           htmltext = "31741-3.htm"
         elif cond == 4 :
           htmltext = "31741-6.htm"
         elif cond == 5 and st.getQuestItemsCount(RAIN_SONG) == 1 or st.getQuestItemsCount(FRAGMENTS) >= 100:
           htmltext = "31741-7.htm"
         elif cond == 6 and st.getQuestItemsCount(RELIC_BOX) == 1 :
           htmltext = "31741-9.htm"
     elif npcId == LADD and cond == 6 :
       htmltext = "30721-1.htm"
   else :
     htmltext = "<html><body>（副職業等級50以上的角色才可以執行的任務。）</body></html>"
   return htmltext

 def onKill(self,npc,player,isPet):
   npcId = npc.getNpcId()
   if npcId == PILGRIM_OF_SPLENDOR :  # 輝煌的求道者
     #get a random party member who is doing this quest and needs this drop 
     partyMember = self.getRandomPartyMember(player,"awaitsWaterbinder","1")
     if partyMember :
         st = partyMember.getQuestState(qn)
         chance = st.getRandom(100)
         cond = st.getInt("cond")
         if st.getQuestItemsCount(WATERBINDER) < 1 :
           if chance < CHANCE_FOR_DROP :
             st.giveItems(WATERBINDER,1)
             st.unset("awaitsWaterbinder")
             if st.getQuestItemsCount(EVERGREEN) < 1 :
               st.playSound("ItemSound.quest_itemget")
             else:
               st.playSound("ItemSound.quest_middle")
               st.set("cond","3")
   elif npcId == JUDGE_OF_SPLENDOR :  # 輝煌的審判官
     #get a random party member who is doing this quest and needs this drop 
     partyMember = self.getRandomPartyMember(player,"awaitsEvergreen","1")
     if partyMember :
         st = partyMember.getQuestState(qn)
         chance = st.getRandom(100)
         cond = st.getInt("cond")
         if cond == 2 and st.getQuestItemsCount(EVERGREEN) < 1 :
           if chance < CHANCE_FOR_DROP :
             st.giveItems(EVERGREEN,1)
             st.unset("awaitsEvergreen")
             if st.getQuestItemsCount(WATERBINDER) < 1 :
               st.playSound("ItemSound.quest_itemget")
             else:
               st.playSound("ItemSound.quest_middle")
               st.set("cond","3")
   elif npcId == BARAKIEL :  # 狩獵首領 輝煌之炎 貝拉凱爾
     #give the quest item and update variables for ALL PARTY MEMBERS who are doing the quest,
     #so long as they each qualify for the drop (cond == 4 and item not in inventory)
     #note: the killer WILL participate in the loop as a party member (no need to handle separately)
     party = player.getParty()
     if party :
        for partyMember in party.getPartyMembers().toArray() :
            pst = partyMember.getQuestState(qn)
            if pst :
                if pst.getInt("cond") == 4 and pst.getQuestItemsCount(RAIN_SONG) < 1 :
                    pst.giveItems(RAIN_SONG,1)
                    pst.playSound("ItemSound.quest_middle")
                    pst.set("cond","5")
     else :
        pst = player.getQuestState(qn)
        if pst :
            if pst.getInt("cond") == 4 and pst.getQuestItemsCount(RAIN_SONG) < 1 :
                pst.giveItems(RAIN_SONG,1)
                pst.playSound("ItemSound.quest_middle")
                pst.set("cond","5")
   else :
        st = player.getQuestState(qn)
        if not st or st.getQuestItemsCount(FRAGMENTS) >= 100 or st.getInt("cond") != 4:
            return
        for id in MOBS:
            if npcId == id and st.getRandom(100) < CHANCE_FOR_DROP_FRAGMENTS:
                st.giveItems(FRAGMENTS,1)
                if st.getQuestItemsCount(FRAGMENTS) >= 100:
                    st.set("cond","5")
                
   return 

QUEST       = Quest(246,qn,"擁有高貴靈魂之人，貴族  第三部")

QUEST.addStartNpc(CARADINE)
QUEST.addTalkId(CARADINE)

QUEST.addTalkId(OSSIAN)
QUEST.addTalkId(LADD)

QUEST.addKillId(PILGRIM_OF_SPLENDOR)
QUEST.addKillId(JUDGE_OF_SPLENDOR)
QUEST.addKillId(BARAKIEL)


for id in MOBS:
    QUEST.addKillId(id)