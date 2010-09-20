# Created by pmq 20-09-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

# 307 1 巨人們的統治裝置	洞穴的管理者	在巨人洞穴內部正在探索洞穴的矮人冒險家--德洛夫想要擊敗黑卡特原型後，重新回到探索洞穴的工作。如果擊敗統治巨人的裝置--黑卡特原型的話，應該就能幫助他。只不過，若想引出黑卡特原型的話，在那之前，需要先擊敗替他管理此地區的主要怪物們後，收集書籍回來才行。\n\n要獵殺的目標怪物 - 高爾勾倫司、最後的下巨人 猶特努斯、巨人 拿爾帕拿克\n	0		0		174473	52854	-4360	79	0	0	巨人洞穴	1	1	1	32711	191391	57074	-7616	沒有條件限制	在巨人洞穴內部正在探索洞穴的矮人冒險家--德洛夫想要擊敗黑卡特原型後，重新回到探索洞穴的工作。為此須要擊敗統治洞穴內所有巨人的黑卡特原型...	0		0		0	0	0	97	1	1	14850	1	1	
# 307 2 巨人們的統治裝置	黑卡特原型擊敗完畢	擊敗了黑卡特原型。將此消息告知德洛夫，就能得到報酬。\n	0		0		191391	57074	-7616	79	0	0	矮人探險家 德洛夫	0	1	1	32711	191391	57074	-7616	沒有條件限制	在巨人洞穴內部正在探索洞穴的矮人冒險家--德洛夫想要擊敗黑卡特原型後，重新回到探索洞穴的工作。為此須要擊敗統治洞穴內所有巨人的黑卡特原型...	0		0		0	0	0	97	1	1	14850	1	1	

qn = "307_ControlDeviceOfTheGiants"

# NPC
DROPH = 32711               # 矮人探險家 德洛夫
# L2RaidBoss
GORGOLOS          = 25467   # 狩獵首領 高爾勾倫司
LAST_TITAN_UTENUS = 25470   # 狩獵首領 最後的下巨人 猶特努斯
GIANT_MARPANAK    = 25680   # 狩獵首領 巨人 拿爾帕拿克
HEKATON_PRIME     = 25687   # 狩獵首領 黑卡特原型
# ITEM
CET_1_SHEET = 14829         # 洞窟探險之書 第1章
CET_2_SHEET = 14830         # 洞窟探險之書 第2章
CET_3_SHEET = 14831         # 洞窟探險之書 第3章
# NpcId:[x,y,z] # name
RADAR  = { 25467:[0,0,0] }  # 狩獵首領 高爾勾倫司
RADAR1 = { 25470:[0,0,0] }  # 狩獵首領 最後的下巨人 猶特努斯
RADAR2 = { 25680:[0,0,0] }  # 狩獵首領 巨人 拿爾帕拿克
RADAR3 = { 25687:[0,0,0] }  # 狩獵首領 黑卡特原型

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc,player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st: return

		if event == "32711-03.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		if event.isdigit() :
			htmltext = None
			npcId = int(event)
			if npcId in RADAR.keys():
				x,y,z = RADAR[npcId]
				st.addRadar(x,y,z)
				htmltext = "32711-06.htm"
			elif npcId in RADAR1.keys():
				x,y,z = RADAR[npcId]
				st.addRadar(x,y,z)
				htmltext = "32711-07.htm"
			elif npcId in RADAR2.keys():
				x,y,z = RADAR[npcId]
				st.addRadar(x,y,z)
				htmltext = "32711-08.htm"
			elif npcId in RADAR3.keys():
				x,y,z = RADAR[npcId]
				st.addRadar(x,y,z)
				htmltext = "MISS"
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st: return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			htmltext = "<html><body>這是已經完成的任務。</body></html>"
		elif id == State.CREATED :
			if npcId == DROPH and cond == 0 :
				if player.getLevel() >= 79 :
					htmltext = "32711-01.htm"
				else :
					htmltext = "32711-00.htm"
					st.exitQuest(1)
		elif id == State.STARTED:
			if npcId == DROPH :
				if cond == 1 :
					htmltext = "32711-09.htm"
		return htmltext

	def onKill (self,npc,player,isPet) :
		st = player.getQuestState(qn)
		if not st : return
		if st.getState() != State.STARTED : return
		npcId = npc.getNpcId()
		cond = st.getInt("cond")
		if cond == 1 :
			if npcId == GORGOLOS :
				st.giveItems(CET_1_SHEET,1)
				st.playSound("ItemSound.quest_itemget")
			elif npcId == LAST_TITAN_UTENUS :
				st.giveItems(CET_2_SHEET,1)
				st.playSound("ItemSound.quest_itemget")
			elif npcId == GIANT_MARPANAK :
				st.giveItems(CET_3_SHEET,1)
				st.playSound("ItemSound.quest_itemget")
			if st.getQuestItemsCount(CET_1_SHEET) >= 1 or st.getQuestItemsCount(CET_2_SHEET) >= 1 or st.getQuestItemsCount(CET_3_SHEET) >= 1 :
				st.set("cond","2")
				st.playSound("ItemSound.quest_accept")
		return

QUEST = Quest(307, qn, "巨人們的統治裝置")

QUEST.addStartNpc(DROPH)
QUEST.addTalkId(DROPH)

QUEST.addKillId(GORGOLOS)
QUEST.addKillId(LAST_TITAN_UTENUS)
QUEST.addKillId(GIANT_MARPANAK)
#QUEST.addKillId(HEKATON_PRIME)