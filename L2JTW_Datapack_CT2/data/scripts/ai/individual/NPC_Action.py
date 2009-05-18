# Update by rocknow
import sys
from net.sf.l2j.gameserver.ai import CtrlIntention
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
from net.sf.l2j.gameserver.network.serverpackets import ActionFailed
from net.sf.l2j.gameserver.network.serverpackets import NpcSay
from net.sf.l2j.gameserver.network.serverpackets import SocialAction

REPORTS={
"REPORT1":[0,"傳令，告知柯塞勒斯同盟聯合的夥伴們！目前我們正在募集勇猛的冒險家們，準備攻擊霸佔破滅之種的蒂雅特的龍馬團！","REPORT2"],
"REPORT2":[0,"傳令，告知柯塞勒斯同盟聯合的夥伴們！多虧勇猛的冒險家們，目前正在剷除散佈在不滅之種的苦痛棺室和侵蝕棺室的不死生物們。","REPORT3"],
"REPORT3":[4,"傳令，告知柯塞勒斯同盟聯合的夥伴們！目前破滅之種在同盟聯合的旗幟下維護得很安全！","REPORT4"],
"REPORT4":[4,"傳令，告知柯塞勒斯同盟聯合的夥伴們！目前已掃蕩不滅之種的種子心臟部，正在對伊卡姆士展開直接的攻擊！","REPORT1"],
}

class NPC_Action(JQuest) :
  def __init__(self,id,name,descr):
     JQuest.__init__(self,id,name,descr)
     self.isCheck = 0
     self.startQuestTimer("actions",1000, None, None)
     
  def onFirstTalk (self,npc,player):
    npc.showChatWindow(player,self.isCheck)
    return None

  def onAdvEvent (self,event,npc,pc) :
    if event == "actions" :
       sayNpc = self.addSpawn(32549,-185612,240750,1569,0,False,0)
       self.startQuestTimer("say",60000, sayNpc, None, True)
       self.startQuestTimer("REPORT1",40000, sayNpc, None)
       yy = -31
       for x in range(-184975, -185530, -95) :
         yy += 31
         xx = 0
         for y in range(240860, 241085, 88) :
           actNpc = self.addSpawn(32619,x-xx,y-yy,1570,37600,False,0)
           xx += 27
           actNpc.setIsParalyzed(True)
           self.startQuestTimer("act",60000, actNpc, None, True)
    elif event == "say" :
       npc.broadcastPacket(NpcSay(npc.getObjectId(),0,npc.getNpcId(),"實施3次刺擊！"))
    elif event in REPORTS.keys() :
       check,report,nextEvent=REPORTS[event]
       self.isCheck = check
       npc.broadcastPacket(NpcSay(npc.getObjectId(),1,npc.getNpcId(),report))
       self.startQuestTimer(nextEvent,300000, npc, None)
    elif event == "act" :
       self.startQuestTimer("act1",3000, npc, None)
       self.startQuestTimer("act2",7000, npc, None)
       self.startQuestTimer("act3",11000, npc, None)
    elif event == "act1" :
       npc.broadcastPacket(SocialAction(npc.getObjectId(),4))
    elif event == "act2" :
       npc.broadcastPacket(SocialAction(npc.getObjectId(),4))
    elif event == "act3" :
       npc.broadcastPacket(SocialAction(npc.getObjectId(),4))
    return


QUEST = NPC_Action(-1, "NPC_Action", "ai")

QUEST.addFirstTalkId(32549)
