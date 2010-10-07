# Made by Vice [L2JOneo]
import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "641_AttackSailren"

#NPC
STATUE = 32109

#MOBS
VEL1 = 22196
VEL2 = 22197
VEL3 = 22198
VEL4 = 22218
VEL5 = 22223
PTE = 22199

#ITEMS
FRAGMENTS = 8782
GAZKH = 8784

class Quest (JQuest):

 def __init__(self,id,name,descr): 
     JQuest.__init__(self,id,name,descr)
     self.questItemIds = []

 def onEvent (self,event,st):
   htmltext = event
   if event == "32109-03.htm" :
     st.set("cond","1")
     st.setState(State.STARTED)
     st.playSound("ItemSound.quest_accept")
   if event == "32109-05.htm" :
     st.playSound("ItemSound.quest_finish")
     st.takeItems(FRAGMENTS,30)
     st.giveItems(GAZKH,1)
     st.exitQuest(1)
   return htmltext

 def onTalk (self,npc,player):
   st = player.getQuestState(qn)
   htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
   if not st : return htmltext
   npcId = npc.getNpcId()
   id = st.getState()
   cond = st.getInt("cond")
   if npcId == STATUE :
     if id == State.CREATED :
       if player.getLevel() >= 77 :
         htmltext = "32109-01.htm"
       else :
         htmltext = "<html><body>席琳聖像：<br>放肆！連觸摸神聖的席琳聖像都不夠資格的人，竟敢搖晃席琳的思念並把它叫醒來！毫無意義的觸摸神像就如同是對神的侮辱。<br>愚蠢的人啊：這次饒恕你一次，趕快離開這裡吧！(只有完成「凶神之名為第二部」的角色才能執行的任務。)</body></html>"
         st.exitQuest(1)
         return
     elif cond == 1 :
       htmltext = "32109-03.htm"
     elif cond == 2 :
       htmltext = "32109-04.htm"
   return htmltext

 def onKill (self,npc,player,isPet):
   partyMember = self.getRandomPartyMember(player,"1")
   if not partyMember: return
   st = partyMember.getQuestState(qn)
   if not st : return
   if st.getState() == State.STARTED :
     npcId = npc.getNpcId()
     if npcId in [VEL1,VEL2,VEL3,VEL4,VEL5,PTE] :
       if st.getQuestItemsCount(FRAGMENTS) < 30 :
         st.giveItems(FRAGMENTS,1)
         if st.getQuestItemsCount(FRAGMENTS) == 30 :
           st.playSound("ItemSound.quest_middle")
           st.set("cond","2")
         else:
           st.playSound("ItemSound.quest_itemget")
   return

QUEST       = Quest(641,qn,"向賽爾蘭進攻！")

QUEST.addStartNpc(STATUE)

QUEST.addTalkId(STATUE)

QUEST.addKillId(VEL1)
QUEST.addKillId(VEL2)
QUEST.addKillId(VEL3)
QUEST.addKillId(VEL4)
QUEST.addKillId(VEL5)
QUEST.addKillId(PTE)