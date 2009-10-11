# Made by Vice 
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
from net.sf.l2j.gameserver.network.serverpackets import SystemMessage

qn = "1202_GardenGuard"

#NPC'S
GARDENGUARD = 32330

class Quest (JQuest) :

  def __init__(self, id, name, descr) :
    JQuest.__init__(self, id, name, descr)

  def onEvent(self, event, st) :
    htmltext = event
    player = st.getPlayer()
    return htmltext

  def onTalk(self, npc, player) :
    html = "fine"
    npcId = npc.getNpcId()
    st = player.getQuestState(qn)
    if not st : st = self.newQuestState(player)

    party = player.getParty() 
    if not party :
      html = "32330-01.htm"
    else :
      have_quest = False
      wrong_Level = False
      for partyMember in party.getPartyMembers().toArray() :
        pst = partyMember.getQuestState("179_IntoTheLargeCavern")
        if pst : have_quest = True
        if partyMember.getLevel() < 15 or partyMember.getLevel() > 22 or partyMember.getClassId().level() != 0 : 
          wrong_Level = True
          player_name = partyMember.getName()
      if not have_quest :
        html = "32330-02.htm"
      elif player != party.getLeader() :
        party.broadcastToPartyMembers(SystemMessage(2185))
        html = "32330-03.htm"
      elif wrong_Level :
        party.broadcastToPartyMembers(SystemMessage(2097).addString(player_name))
        html = "32330-03.htm"
      else :
        for partyMember in party.getPartyMembers().toArray() :
          partyMember.teleToLocation(-111188, 74555, -12432)
          html = ""
    st.exitQuest(1) 
    return html          

QUEST       = Quest(-1, qn, "Teleports")

QUEST.addStartNpc(GARDENGUARD)

QUEST.addTalkId(GARDENGUARD)
