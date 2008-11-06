#made by ethernaly
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "650_ABrokenDream"

#NPC
GHOST = 32054

#MOBS
CREWMAN = 22027
VAGABOND = 22028

#DROP
DREAM_FRAGMENT_ID = 8514

CHANCE = 68


class Quest (JQuest) :

 def __init__(self,id,name,descr):
     JQuest.__init__(self,id,name,descr)
     self.questItemIds = [DREAM_FRAGMENT_ID]

 def onEvent (self,event,st) :
    htmltext = event
    if event == "32054-02.htm" :    #pmq 修改
      st.setState(State.STARTED)
      st.playSound("ItemSound.quest_accept")
      st.set("cond","1")
    elif event == "32054-05.htm" :  #pmq 修改
      st.playSound("ItemSound.quest_finish")
      st.exitQuest(1)
    return htmltext

 def onTalk (self,npc,player):
   st = player.getQuestState(qn)
   if st :
	npcId = npc.getNpcId()
	htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
	id = st.getState()
	if id == State.CREATED :
	    st2 = player.getQuestState("117_OceanOfDistantStar")    #pmq 修改
	    if st.getPlayer().getLevel() < 39:                      #pmq 修改
		    htmltext = "32054-00.htm"                           #pmq 修改
		    st.exitQuest(1)
	    elif st2:	 #pmq 修改
		if not st2.getState() == 'state.Completed' :  #pmq 修改
		    htmltext = "32054-01.htm"                 #pmq 修改
		else :
		    htmltext = "32054-00a.htm"                #pmq 修改
		    st.exitQuest(1)
	elif id == State.STARTED :
	    if st.getQuestItemsCount(DREAM_FRAGMENT_ID):
	       htmltext = "32054-03.htm"                  #pmq 修改
	    else :
	       htmltext = "32054-02a.htm"                 #pmq 修改
   return htmltext

 def onKill(self,npc,player,isPet):
   partyMember = self.getRandomPartyMember(player,"1")
   if not partyMember : return
   st = partyMember.getQuestState(qn)
   if st :
	if st.getState() == State.STARTED and st.getInt("cond") == 1 :
	    if st.getRandom(100)<CHANCE :
		st.giveItems(DREAM_FRAGMENT_ID,1)
		st.playSound("ItemSound.quest_itemget")
   return

QUEST	    = Quest(650, qn, "對未完成夢想的執著")

QUEST.addStartNpc(GHOST)
QUEST.addTalkId(GHOST)
QUEST.addKillId(CREWMAN)
QUEST.addKillId(VAGABOND)
