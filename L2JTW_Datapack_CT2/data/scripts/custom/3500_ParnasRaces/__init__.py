#Grand Isle Of Prayer Races
import sys
from net.sf.l2j.gameserver.model.quest           import State
from net.sf.l2j.gameserver.model.quest           import QuestState
from net.sf.l2j.gameserver.model.quest           import Quest
from net.sf.l2j.gameserver.model.quest.jython    import QuestJython as JQuest
from net.sf.l2j.gameserver.templates.chars       import L2NpcTemplate
from net.sf.l2j.gameserver.datatables            import NpcTable
from net.sf.l2j.gameserver.datatables            import SpawnTable
from net.sf.l2j.gameserver.model                 import L2Spawn
from net.sf.l2j.gameserver.model                 import L2Object
from net.sf.l2j.gameserver.network.serverpackets import NpcHtmlMessage
from javolution.text                             import TextBuilder
from net.sf.l2j.gameserver.model.actor.instance  import L2PcInstance
from net.sf.l2j.gameserver.model.actor.instance  import L2NpcInstance

qn = "3500_ParnasRaces"

# Settings
#QuestId = 3500

qtn = "Race"
ftime = 30 * 60 * 1000
interval = 5 * 60 * 1000

RACE_STAMP = 10013
SKEY = 9694
MOB1 = 18367
MOB2 = 18368

CI_DROP_CHANCE = 70

class PyObject :
  pass

def Clean (pl) :
  st = pl.getQuestState(qn)
  ic = st.getQuestItemsCount(RACE_STAMP);
  st.takeItems(RACE_STAMP, ic);

def SpawnNPC (q,st,house) :
  if st.getRandom(100) < 50 : MOB = MOB1
  else : MOB = MOB2
  if(house == 1) : q.addSpawn(MOB, 160560, 184915, -3705, 0, True, ftime)
  if(house == 2) : q.addSpawn(MOB, 134968, 172112, -3707, 0, True, ftime)
  if(house == 3) : q.addSpawn(MOB, 146588, 151601, -2876, 0, True, ftime)
  if(house == 4) : q.addSpawn(MOB, 155578, 160177, -3353, 0, True, ftime)

def CheckHouse(cond,x,y) :
  if(cond == 1) :
    if x > 160000 and x < 161000 and y > 184300 and y < 185500 : return 1
    else : return 0
  if(cond == 2) :
    if x > 134410 and x < 135470 and y > 171560 and y < 172622 : return 1
    else : return 0
  if(cond == 3) : 
    if x > 146050 and x < 147110 and y > 151070 and y < 152145 : return 1
    else : return 0
  if(cond == 4) : 
    if x > 155080 and x < 156130 and y > 159620 and y < 160700 : return 1
    else : return 0

def anounce (pl,cond) :
  st = pl.getQuestState(qn)
  ic = st.getQuestItemsCount(RACE_STAMP)
  time = st.getInt("time")/60/1000
  rep = NpcHtmlMessage(5);

  if(cond == 0) : rep.setFile("data/scripts/custom/3500_ParnasRaces/3500_progress_0.htm");
  if(cond == 1) : rep.setFile("data/scripts/custom/3500_ParnasRaces/3500_progress_1.htm");
  if(cond == 2) : rep.setFile("data/scripts/custom/3500_ParnasRaces/3500_progress_2.htm");
  if(cond == 3) : rep.setFile("data/scripts/custom/3500_ParnasRaces/3500_progress_3.htm");
  if(cond == 4) : rep.setFile("data/scripts/custom/3500_ParnasRaces/3500_progress_4.htm");
  if(cond == 5) : rep.setFile("data/scripts/custom/3500_ParnasRaces/3500_progress_5.htm");
  
  rep.replace("%stamps%",str(ic));
  rep.replace("%time%",str(time));

  pl.sendPacket(rep)

class Quest (JQuest) :

  def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

  def onAdvEvent (self,event,npc,player) :
    htmltext = ""
    st = player.getQuestState(qn)
    if not st: return
    time = st.getInt("time")
    cond = st.getInt("cond")
    ic = st.getQuestItemsCount(RACE_STAMP);
    if event == "finish" :
      if cond == 5 and ic == 4 :
        Clean(player)
        st.giveItems(SKEY,4)
        st.playSound("ItemSound.quest_finish")
        self.cancelQuestTimer(qtn,npc,player)
        st.unset("time")
        st.unset("cond")
        st.exitQuest(1)
      else :
        if ic >= cond :
          anounce(player,0)
          self.cancelQuestTimer(qtn,npc,player)
          Clean(player)
          st.unset("time")
          st.unset("cond")
          st.exitQuest(1)
          return
        else :
          anounce(player,cond)
    elif event == "break" :
      self.cancelQuestTimer(qtn,npc,player)
      Clean(player)
      st.unset("time")
      st.unset("cond")
      st.exitQuest(1)
      htmltext="3500_break.htm"
    elif event == qtn :
      time = time + interval
      st.set("time",str(time))
      if(time < ftime) :
        htmltext = "Grand Parnassus Race: " + str(time/60/1000) + " minutes left from race."
        anounce(player,cond)
      else :
        player.sendMessage("Grand Parnassus Race: Time is out!")
        self.cancelQuestTimer(qtn,npc,player)
        st.unset("time")
        st.unset("cond")
        st.exitQuest(1)
        htmltext = "3500_off.htm"
    return htmltext

  def onTalk (self,npc,player):
    htmltext = "<html><body>Ringos:<br><br>You are either not on a quest that involves this NPC, or you don't meet this NPC's minimum quest requirements.</body></html>"
    st = player.getQuestState(qn)
    if not st : return
    if player.getLevel() < 78 : 
      htmltext = "<html><body>Ringos:<br><br>You must have level 78 to join this race.</body></html>"
      st.exitQuest(1)
      return htmltext
    else :
      ic = st.getQuestItemsCount(RACE_STAMP)
      if st.getState() == State.COMPLETED:
        htmltext = "<html><body>Error! Please find any GM, and report this error.</body></html>"
        return htmltext
      elif st.getState() == State.CREATED:
        if ic > 0 : Clean(player)
        st.setState(State.STARTED)
        self.startQuestTimer(qtn,interval,npc,player,True)
        st.set("time","0")
        st.set("cond","1")
        SpawnNPC(self,st,1)
        anounce(player,1)
      elif st.getState() == State.STARTED:
        if not self.getQuestTimer(qtn,npc,player) : 
          anounce(player,0)
          if ic > 0 : Clean(player)
          st.unset("time")
          st.unset("cond")
          st.exitQuest(1)
          return
        htmltext = "3500_intermediate.htm"
        return htmltext
    return

  def onKill(self,npc,player,isPet):
    st = player.getQuestState(qn)
    if not st : return
    if st.getState() != State.STARTED : return
    cond = st.getInt("cond");
    ic = st.getQuestItemsCount(RACE_STAMP)
    if ic >= cond :
      anounce(player,0)
      self.cancelQuestTimer(qtn,npc,player)
      Clean(player)
      st.unset("time")
      st.unset("cond")
      st.exitQuest(1)
      return
    if CheckHouse(cond,player.getX(),player.getY()) :
      if st.getRandom(100) < CI_DROP_CHANCE :
        if ic < 4 :
          st.giveItems(RACE_STAMP,1)
          cond = cond + 1
          st.set("cond",str(cond))
          anounce(player,cond)
          if cond < 5 : SpawnNPC(self,st,cond)
          if st.getQuestItemsCount(RACE_STAMP) == 4 :
            st.playSound("ItemSound.quest_middle")
          else :
            st.playSound("Itemsound.quest_itemget")
      else :
        SpawnNPC(self,st,cond)
    return

QUEST = Quest(-1, qn, "custom")

QUEST.addStartNpc(32349)
QUEST.addTalkId(32349)

QUEST.addKillId(MOB1)
QUEST.addKillId(MOB2)