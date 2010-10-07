# pmq
import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "10270_BirthOfTheSeed"

# 任務資料
#	10270	1	種子的受胎	調查不滅之種	柯塞勒斯同盟聯合基地的士兵普雷諾斯要求有關不滅之種地區的調查，並交代在前往那個地方之前，先去拜訪柯塞勒斯同盟聯合基地的戰鬥法師爾堤吾斯了解詳情。\n	0															0															-186109	242500	2550	75	0	3	戰鬥法師 爾堤吾斯	0	1	1	32563	-186692	243539	2613	沒有條件限制	柯塞勒斯同盟聯合基地的士兵普雷諾斯，正在尋找負責執行有關不滅之種調查的冒險家，而且還說須要擊倒戰鬥法師爾堤吾斯所提及的破滅之種主要地區的守門人，然後帶回憑證。	0																																																																						0						0	0	0	285	0	3	57	-1000	-1001									3	41677	251602	25244	
#	10270	2	種子的受胎	邪惡的證據	柯塞勒斯同盟聯合基地的戰鬥法師爾堤吾斯說道，為了得到有關不滅之種的情報，須要去狩獵不滅之種的怪物，並收集憑證。\n\n要獵殺的目標怪物-艾罕 克羅迪庫斯、艾罕 克蘭尼庫斯、克海梅納斯\n	3	13868	13869	13870												3	1	1	1												0	0	0	75	0	3	不滅之種	1	1	1	32563	-186692	243539	2613	沒有條件限制	柯塞勒斯同盟聯合基地的士兵普雷諾斯，正在尋找負責執行有關不滅之種調查的冒險家，而且還說須要擊倒戰鬥法師爾堤吾斯所提及的破滅之種主要地區的守門人，然後帶回憑證。	0																																																																						0						0	0	0	285	0	3	57	-1000	-1001									3	41677	251602	25244	
#	10270	3	種子的受胎	爾堤吾斯的故事	戰鬥法師爾堤吾斯說是需要一些時間來調查從不滅之種帶回來的憑證。這些時間應該就差不多了，再去找他交談看看。\n	0															0															-186109	242500	2550	75	0	3	戰鬥法師 爾堤吾斯	0	1	1	32548	-186399	242412	2550	沒有條件限制	柯塞勒斯同盟聯合基地的士兵普雷諾斯，正在尋找負責執行有關不滅之種調查的冒險家，而且還說須要擊倒戰鬥法師爾堤吾斯所提及的破滅之種主要地區的守門人，然後帶回憑證。	0																																																																						0						0	0	0	285	0	3	57	-1000	-1001									3	41677	251602	25244	
#	10270	4	種子的受胎	與神秘者的相遇	柯塞勒斯同盟聯合基地的戰鬥法師爾堤吾斯說道，為了得到有關不滅之種更關鍵的情報，須要去找躲在秘密場所的席琳的祭司瑞爾齊亞。柯塞勒斯同盟聯合基地的士兵津比知道如何到達他的所在之處，去找他吧。\n	0															0															-185090	242809	1577	75	0	3	士兵 津比	0	1	1	32563	-186692	243539	2613	沒有條件限制	柯塞勒斯同盟聯合基地的士兵普雷諾斯，正在尋找負責執行有關不滅之種調查的冒險家，而且還說須要擊倒戰鬥法師爾堤吾斯所提及的破滅之種主要地區的守門人，然後帶回憑證。	0																																																																						0						0	0	0	285	0	3	57	-1000	-1001									3	41677	251602	25244	
#	10270	5	種子的受胎	不滅的君主	透過席琳的祭司瑞爾齊亞得到了想要的情報。回去向柯塞勒斯同盟聯合基地的戰鬥法師爾堤吾斯報告這個內容。\n	0															0															-186109	242500	2550	75	0	3	戰鬥法師 爾堤吾斯	0	1	1	32563	-186692	243539	2613	沒有條件限制	柯塞勒斯同盟聯合基地的士兵普雷諾斯，正在尋找負責執行有關不滅之種調查的冒險家，而且還說須要擊倒戰鬥法師爾堤吾斯所提及的破滅之種主要地區的守門人，然後帶回憑證。	0																																																																						0						0	0	0	285	0	3	57	-1000	-1001									3	41677	251602	25244	

#NPC
NPC = 32563

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = []

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			if npcId == 32563 :
				htmltext = "32563-0a.htm"
		elif id == State.CREATED :
			if npcId == 32563 and cond == 0 :
				if player.getLevel() >= 75 :
					htmltext = "32563-01.htm"
					st.exitQuest(1) 
				else :
					htmltext = "32563-00.htm"
					st.exitQuest(1) 
		return htmltext

QUEST		= Quest(10270,qn,"種子的受胎")

QUEST.addStartNpc(NPC)

QUEST.addTalkId(NPC)
