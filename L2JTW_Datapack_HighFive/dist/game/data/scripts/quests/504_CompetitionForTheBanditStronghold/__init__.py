# L2JTeon
import sys
from com.l2jserver.gameserver.instancemanager.clanhallsiege import BanditStrongholdSiege
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "504_CompetitionForTheBanditStronghold"

# npcId
Messenger = 35437

# itemId list
TarlkAmulet = 4332
AlianceTrophey = 5009

# Quest mobs
TarlkBugbear = 20570
TarlkBugbearWarrior = 20571
TarlkBugbearHighWarrior = 20572
TarlkBasilisk = 20573
ElderTarlkBasilisk = 20574

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return
		if event == "a2.htm" :
			st.set("cond", "1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "a4.htm" :
			if st.getQuestItemsCount(TarlkAmulet) == 30 :
				st.takeItems(TarlkAmulet,-30)
				st.giveItems(AlianceTrophey,1)
				st.playSound("ItemSound.quest_finish")
				st.exitQuest(1)
			else :
				htmltext = "a5.htm"
		return htmltext

	def onTalk (self,npc,player) :
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")
		clan = player.getClan()
		clanhall = player.getClanhall()

		if id == State.CREATED :
			if npcId == Messenger and cond == 0 :
				if clan == None:
					htmltext = "<html><body>使者：<br>你怎麼會以這麼微弱的實力就想跟我們奧耶瑪夫結盟呢？<br>(血盟等級4以上的血盟盟主才可以執行。)</body></html>"
					st.exitQuest(1)
					return htmltext
				if clan.getLevel() < 4:
					htmltext = "a6.htm"
					st.exitQuest(1)
					return htmltext
				if not clan.getLeaderName() == player.getName():
					htmltext = "a6.htm"
					st.exitQuest(1)
					return htmltext
				if clanhall == 1 :
					htmltext = "<html><body>使者：<br>嘿，你在幹嗎？你已經有了根據地！過分的貪慾會帶來不幸。那就告辭了。</body></html>"
					st.exitQuest(1)
					return htmltext
				if BanditStrongholdSiege.getInstance().isRegistrationPeriod():
					if st.getQuestItemsCount(TarlkAmulet) > 1 :
						htmltext = "<html><body>使者：<br>你挑戰過上次的預賽嗎？那麼把那個憑證交給我之後再繼續作戰吧！</body></html>"
						st.takeItems(TarlkAmulet,30)
						st.exitQuest(1)
					else :
						htmltext = "a1.htm"
		elif id == State.STARTED :
			if npcId == Messenger and cond == 1 :
				if st.getQuestItemsCount(TarlkAmulet) == 30 :
					htmltext = "a3.htm"
				else:
					htmltext = "a5.htm"
					npc.showChatWindow(player,3)
		return htmltext

	def onKill(self,npc,player,isPet): 
		st = player.getQuestState(qn) 
		if not st : return 
		if st.getState() != State.STARTED : return 
		npcId = npc.getNpcId() 
		if st.getQuestItemsCount(TarlkAmulet) < 30 :
			st.giveItems(TarlkAmulet,1)
			st.playSound("ItemSound.quest_itemget")

QUEST = Quest(504,qn,"山寨爭奪戰")

QUEST.addStartNpc(Messenger)
QUEST.addTalkId(Messenger)
QUEST.addKillId(TarlkBugbear)
QUEST.addKillId(TarlkBugbearWarrior)
QUEST.addKillId(TarlkBugbearHighWarrior)
QUEST.addKillId(TarlkBasilisk)
QUEST.addKillId(ElderTarlkBasilisk)