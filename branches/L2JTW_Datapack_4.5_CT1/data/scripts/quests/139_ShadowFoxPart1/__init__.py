# Made by Kerberos
# this script is part of the Official L2J Datapack Project.
# Visit http://forum.l2jdp.com for more details.
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "139_ShadowFoxPart1"

# NPCs
MIA = 30896

# ITEMs
FRAGMENT = 10345
CHEST = 10346
# MONSTERs
NPC=[20784,20785,21639,21640]

class Quest (JQuest) :

 def __init__(self,id,name,descr):
    JQuest.__init__(self,id,name,descr)
    self.questItemIds = [FRAGMENT,CHEST]

 def onEvent (self,event,st) :
    htmltext = event
    id = st.getState()
    cond = st.getInt("cond")
    if event == "30896-03.htm" :
       st.set("cond","1")
       st.playSound("ItemSound.quest_accept")
    elif event == "30896-11.htm" :
       st.set("cond","2")
       st.playSound("ItemSound.quest_middle")
    elif event == "30896-14.htm" :
       st.takeItems(FRAGMENT, -1)
       st.takeItems(CHEST, -1)
       st.set("talk","1")
    elif event == "30896-16.htm" :
       st.playSound("ItemSound.quest_finish")
       st.unset("talk")
       st.exitQuest(False)
       st.giveItems(57, 14050)
       if st.getPlayer().getLevel() >= 37 and st.getPlayer().getLevel() <= 42:
          st.addExpAndSp(30000,2000)
    return htmltext

 def onTalk (self,npc,player):
    htmltext = "<html><body>沒進行任務或條件不符合。</body></html>"
    st = player.getQuestState(qn)
    if not st : return htmltext

    npcId = npc.getNpcId()
    id = st.getState()
    cond = st.getInt("cond")
    if id == State.CREATED : return htmltext
    if id == State.COMPLETED :
       htmltext = "<html><body>這是已經完成的任務。</body></html>"
    elif npcId == MIA :
       if cond == 0 :
          if player.getLevel() >= 37:
             htmltext = "30896-01.htm"
          else:
             htmltext = "30896-00.htm"
             st.exitQuest(1)
       elif cond == 1 :
          htmltext = "30896-03.htm"
       elif cond == 2 :
          if st.getQuestItemsCount(FRAGMENT) >= 10 and st.getQuestItemsCount(CHEST) >= 1:
             htmltext = "30896-13.htm"
          elif st.getInt("talk"):
             htmltext = "30896-14.htm"
          else:
             htmltext = "30896-12.htm"
    return htmltext

 def onKill(self,npc,player,isPet):
    st = player.getQuestState(qn)
    if not st : return
    if st.getState() != State.STARTED : return
    if st.getInt("cond")==2 :
       st.playSound("ItemSound.quest_itemget")
       st.giveItems(FRAGMENT,1)
       if st.getRandom(100) <= 2 :
          st.giveItems(CHEST,1)
    return

 def onFirstTalk (self,npc,player):
   st = player.getQuestState(qn)
   if not st :
      st = self.newQuestState(player)
   qs = st.getPlayer().getQuestState("138_TempleChampionPart2")
   if qs :
      if qs.getState() == State.COMPLETED and st.getState() == State.CREATED :
          st.setState(State.STARTED)
   npc.showChatWindow(player)
   return

QUEST       = Quest(139,qn,"影狐-1")

QUEST.addFirstTalkId(MIA) #this quest doesnt have starter npc, quest will appear in list only when u finish quest 137
QUEST.addTalkId(MIA)
for mob in NPC :
   QUEST.addKillId(mob)