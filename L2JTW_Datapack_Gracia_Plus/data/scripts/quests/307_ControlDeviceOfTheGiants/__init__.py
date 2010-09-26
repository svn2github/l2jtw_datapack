# Created by pmq 20-09-2010

import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

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
				x,y,z = RADAR1[npcId]
				st.addRadar(x,y,z)
				htmltext = "32711-07.htm"
			elif npcId in RADAR2.keys():
				x,y,z = RADAR2[npcId]
				st.addRadar(x,y,z)
				htmltext = "32711-08.htm"
			elif npcId in RADAR3.keys():
				x,y,z = RADAR3[npcId]
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

		if id == State.CREATED :
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