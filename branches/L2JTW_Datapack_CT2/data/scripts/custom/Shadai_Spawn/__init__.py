#Shadai Spawn Script 

import sys
from net.sf.l2j.gameserver import GameTimeController
from net.sf.l2j.gameserver.ai import CtrlIntention
from net.sf.l2j.gameserver.model import L2CharPosition
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
from net.sf.l2j.gameserver.network.serverpackets import NpcSay
from net.sf.l2j.gameserver.network.serverpackets import PlaySound
from net.sf.l2j.gameserver.network.serverpackets import SocialAction


qn = "Shadai_Spawn" 

REPORTS={
"REPORT1":[0,"誰會成為今晚的幸運兒呢？哈哈！真是好奇，真是好奇！","REPORT2"],
"REPORT2":[0,"誰會成為今晚的幸運兒呢？哈哈！真是好奇，真是好奇！","REPORT3"],
"REPORT3":[4,"誰會成為今晚的幸運兒呢？哈哈！真是好奇，真是好奇！","REPORT4"],
"REPORT4":[4,"今天到此為止啦！下次再見...拜拜，不要太想我！","timer_check"],
}

def autochat(npc,text) :
	if npc: npc.broadcastPacket(NpcSay(npc.getObjectId(),1,npc.getNpcId(),text))
	return

class Shadai_Spawn(JQuest) :
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.SHADAI = 32347
		self.isCheck = 0
		self.startQuestTimer("timer_check",2400000, None, None)

	def onAdvEvent (self,event,npc,pc) :
		if event == "timer_check" :
			sayNpc = self.addSpawn(self.SHADAI,9041,253010,-1938,49909,False,2410000)
			autochat(sayNpc,"誰會成為今晚的幸運兒呢？哈哈！真是好奇，真是好奇！")
			self.startQuestTimer("REPORT1",600000, sayNpc, None)
		elif event in REPORTS.keys() :
			check,report,nextEvent=REPORTS[event]
			self.isCheck = check
			npc.broadcastPacket(NpcSay(npc.getObjectId(),1,npc.getNpcId(),report))
			self.startQuestTimer(nextEvent,600000, npc, None)
		return

QUEST = Shadai_Spawn(-1, qn, "Custom")