# Made by Kerberos v1.0 on 2008/07/31
# this script is part of the Official L2J Datapack Project.
# Visit http://www.l2jdp.com/forum/ for more details.
# update by pmq
# High Five Part4 04-04-2011
import sys
from com.l2jserver.gameserver.ai import CtrlIntention
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest
from com.l2jserver.gameserver.network.serverpackets import NpcSay

qn = "60_GoodWorkReward"

BYPASS = {
1:"<a action=\"bypass -h Quest 60_GoodWorkReward WL\">傭兵</a><br><a action=\"bypass -h Quest 60_GoodWorkReward GL\">劍鬥士</a>",
4:"<a action=\"bypass -h Quest 60_GoodWorkReward PA\">聖騎士</a><br><a action=\"bypass -h Quest 60_GoodWorkReward DA\">闇騎士</a>",
7:"<a action=\"bypass -h Quest 60_GoodWorkReward TH\">寶藏獵人</a><br><a action=\"bypass -h Quest 60_GoodWorkReward HK\">鷹眼</a>",
11:"<a action=\"bypass -h Quest 60_GoodWorkReward SC\">術士</a><br><a action=\"bypass -h Quest 60_GoodWorkReward NM\">死靈法師</a><br><a action=\"bypass -h Quest 60_GoodWorkReward WA\">法魔</a>",
15:"<a action=\"bypass -h Quest 60_GoodWorkReward BS\">主教</a><br><a action=\"bypass -h Quest 60_GoodWorkReward PP\">先知</a>",
19:"<a action=\"bypass -h Quest 60_GoodWorkReward TK\">聖殿騎士</a><br><a action=\"bypass -h Quest 60_GoodWorkReward SS\">劍術詩人</a>",
22:"<a action=\"bypass -h Quest 60_GoodWorkReward PW\">大地行者</a><br><a action=\"bypass -h Quest 60_GoodWorkReward SR\">銀月遊俠</a>",
26:"<a action=\"bypass -h Quest 60_GoodWorkReward SP\">咒術詩人</a><br><a action=\"bypass -h Quest 60_GoodWorkReward ES\">元素使</a>",
29:"<a action=\"bypass -h Quest 60_GoodWorkReward EE\">長老</a>",
32:"<a action=\"bypass -h Quest 60_GoodWorkReward SK\">席琳騎士</a><br><a action=\"bypass -h Quest 60_GoodWorkReward BD\">劍刃舞者</a>",
35:"<a action=\"bypass -h Quest 60_GoodWorkReward AW\">深淵行者</a><br><a action=\"bypass -h Quest 60_GoodWorkReward PR\">闇影遊俠</a>",
39:"<a action=\"bypass -h Quest 60_GoodWorkReward SH\">狂咒術士</a><br><a action=\"bypass -h Quest 60_GoodWorkReward PS\">闇影召喚士</a>",
42:"<a action=\"bypass -h Quest 60_GoodWorkReward SE\">席琳長老</a>",
45:"<a action=\"bypass -h Quest 60_GoodWorkReward DT\">破壞者</a>",
47:"<a action=\"bypass -h Quest 60_GoodWorkReward TR\">暴君</a>",
50:"<a action=\"bypass -h Quest 60_GoodWorkReward OL\">霸主</a><br><a action=\"bypass -h Quest 60_GoodWorkReward WC\">戰狂</a>",
54:"<a action=\"bypass -h Quest 60_GoodWorkReward BH\">賞金獵人</a>",
56:"<a action=\"bypass -h Quest 60_GoodWorkReward WS\">戰爭工匠</a>"
}

CLASSES = {
"AW":[36,[2673,3172,2809]],
"BD":[34,[2627,3172,2762]],
"BH":[55,[2809,3119,3238]],
"BS":[16,[2721,2734,2820]],
"DA":[6,[2633,2734,3307]],
"DT":[46,[2627,3203,3276]],
"EE":[30,[2721,3140,2820]],
"ES":[28,[2674,3140,3336]],
"GL":[2,[2627,2734,2762]],
"HK":[9,[2673,2734,3293]],
"NM":[13,[2674,2734,3307]],
"OL":[51,[2721,3203,3390]],
"PA":[5,[2633,2734,2820]],
"PP":[17,[2721,2734,2821]],
"PR":[37,[2673,3172,3293]],
"PS":[41,[2674,3172,3336]],
"PW":[23,[2673,3140,2809]],
"SC":[12,[2674,2734,2840]],
"SE":[43,[2721,3172,2821]],
"SH":[40,[2674,3172,2840]],
"SK":[33,[2633,3172,3307]],
"SP":[27,[2674,3140,2840]],
"SR":[24,[2673,3140,3293]],
"SS":[21,[2627,3140,2762]],
"TH":[8,[2673,2734,2809]],
"TK":[20,[2633,3140,2820]],
"TR":[48,[2627,3203,2762]],
"WA":[14,[2674,2734,3336]],
"WC":[52,[2721,3203,2879]],
"WL":[3,[2627,2734,3276]],
"WS":[57,[2867,3119,3238]]
}

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [10867,10868]
		self.isNpcSpawned = 0

	def onAdvEvent (self,event,npc,player) :
		if event == "npc_cleanup" :
			self.isNpcSpawned = 0
			npc.broadcastPacket(NpcSay(27340,0,npc.getNpcId(),"你運氣真好，下次我會再來找你的。"))
			return
		st = player.getQuestState(qn)
		if not st: return
		htmltext = event
		if event == "31435-03.htm" :
			st.set("cond","1")
			st.playSound("ItemSound.quest_accept")
			st.setState(State.STARTED)
		elif event == "31435-05.htm" :
			st.set("cond","4")
			st.playSound("ItemSound.quest_middle")
		elif event == "31435-08.htm" :
			st.set("cond","9")
			st.playSound("ItemSound.quest_middle")
		elif event == "32487-02.htm" and self.isNpcSpawned == 0:
			npc = st.addSpawn(27340,72590,148100,-3312,60000)
			npc.broadcastPacket(NpcSay(npc.getObjectId(),0,npc.getNpcId(),"「" + player.getName() + "」" + "! 去死吧，要怪就怪你的好奇心。"))
			npc.setRunning()
			npc.addDamageHate(st.getPlayer(),0,999)
			npc.getAI().setIntention(CtrlIntention.AI_INTENTION_ATTACK, st.getPlayer())
			self.isNpcSpawned = 1
			self.startQuestTimer("npc_cleanup",59000,npc, None)
		elif event == "32487-06.htm" :
			st.set("cond","8")
			st.playSound("ItemSound.quest_middle")
			st.takeItems(10868,-1)
		elif event == "30081-03.htm" :
			st.set("cond","5")
			st.playSound("ItemSound.quest_middle")
			st.takeItems(10867,-1)
		elif event == "30081-05.htm" :
			st.set("cond","6")
			st.playSound("ItemSound.quest_middle")
		elif event == "30081-08.htm" :
			if st.getQuestItemsCount(57) >= 3000000 :
				st.takeItems(57,3000000)
				st.giveItems(10868,1)
				st.set("cond","7")
				st.playSound("ItemSound.quest_middle")
			else :
				htmltext = "30081-07.htm"
		elif event == "31092-05.htm" :
			st.exitQuest(False)
			st.playSound("ItemSound.quest_finish")
			text = BYPASS[player.getClassId().getId()]
			htmltext = "<html><body>財富的地下商人：<br>錢的事嘛，你還是把它忘了吧...<br>我說過會幫你轉職的嘛！你想要轉職為哪一種職業呢？挑挑看吧...<br>"+text+"</body></html>"
		elif event == "31092-06.htm" :
			text = BYPASS[player.getClassId().getId()]
			htmltext = "<html><body>財富的地下商人：<br>如果考慮好了，那就趕快選擇一下吧。你想要哪一種職業呢？<br>"+text+"</body></html>"
		elif event in CLASSES.keys():
			newclass,req_item=CLASSES[event]
			adena = 0
			for i in req_item :
				if not st.getQuestItemsCount(i):
					st.giveItems(i,1)
				else :
					adena = adena + 1
			if adena == 3 :
				return "31092-06.htm"
			if adena > 0 :
				st.giveAdena(adena*1000000,True)
			htmltext = "31092-05.htm"
			st.set("onlyone","1")
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			if npcId == 31435 :
				htmltext = "<html><body>這是已經完成的任務。</body></html>"
			elif npcId == 31092 :
				if player.getClassId().level() == 1 and not st.getInt("onlyone"):
					htmltext = "31092-04.htm"
				else:
					htmltext = "31092-07.htm"
		elif id == State.CREATED :
			if npcId == 31435 and cond == 0 :
				if player.getLevel() < 39 or player.getClassId().level() != 1 or player.getRace().ordinal() == 5 :
					htmltext = "31435-00.htm"
					st.exitQuest(1)
				else :
					htmltext = "31435-01.htm"
		elif id == State.STARTED:
			if npcId == 31435 :
				if cond in [1,2]:
					htmltext = "31435-03a.htm"
				elif cond == 3 :
					htmltext = "31435-04.htm"
				elif cond == 4 :
					htmltext = "31435-06.htm"
				elif cond in [5,6,7] :
					htmltext = "31435-06a.htm"
				elif cond == 8 :
					htmltext = "31435-07.htm"
				elif cond == 9 :
					htmltext = "31435-09.htm"
					st.set("cond","10")
					st.playSound("ItemSound.quest_middle")
				elif cond == 10 :
					htmltext = "31435-10.htm"
			elif npcId == 32487 :
				if cond == 1 :
					if self.isNpcSpawned == 0 :
						htmltext = "32487-01.htm"
					else:
						htmltext = "<html><body>瑪克：<br>後面..小心後面。</body></html>"
				elif cond == 2 :
					htmltext = "32487-03.htm"
					st.set("cond","3")
					st.playSound("ItemSound.quest_middle")
				elif cond == 3 :
					htmltext = "32487-04.htm"
				elif cond == 7 :
					htmltext = "32487-05.htm"
				elif cond == 8 :
					htmltext = "32487-06.htm"
			elif npcId == 30081 :
				if cond == 4 :
					htmltext = "30081-01.htm"
				elif cond == 5 :
					htmltext = "30081-04.htm"
				elif cond == 6 :
					htmltext = "30081-06.htm"
				elif cond == 7 :
					htmltext = "30081-09.htm"
			elif npcId == 31092 :
				if cond == 10 :
					if player.getClassId().level() == 1 :
						htmltext = "31092-01.htm"
					else:
						htmltext = "31092-06.htm"
						st.exitQuest(False)
						st.playSound("ItemSound.quest_finish")
						st.giveAdena(3000000, False)
						st.set("onlyone","1")
		return htmltext

	def onKill(self,npc,player,isPet):
		self.cancelQuestTimer("npc_cleanup", npc, None)
		self.isNpcSpawned = 0
		st = player.getQuestState(qn)
		if not st : return
		if st.getState() != State.STARTED : return
		npcId = npc.getNpcId()
		cond = st.getInt("cond")
		if npcId == 27340 and cond == 1 :
			string = "沒想到會這麼強，我失算了。"
			npc.broadcastPacket(NpcSay(npc.getObjectId(),0,npc.getNpcId(),string))
			st.giveItems(10867,1)
			st.set("cond","2")
			st.playSound("ItemSound.quest_middle")
		return

QUEST		= Quest(60,qn,"善行的報答")

QUEST.addStartNpc(31092)
QUEST.addStartNpc(31435)

QUEST.addTalkId(30081)
QUEST.addTalkId(31092)
QUEST.addTalkId(31435)
QUEST.addTalkId(32487)

QUEST.addKillId(27340)