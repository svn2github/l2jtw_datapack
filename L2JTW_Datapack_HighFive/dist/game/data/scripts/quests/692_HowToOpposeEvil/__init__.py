# Made by Gigiikun v1.0 on 2010/05/06
# this script is part of the Official L2J Datapack Project.
# Visit http://www.l2jdp.com/forum for more details.
# Update By pmq 27-09-2010

import sys
from com.l2jserver import Config
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest
from com.l2jserver.util import Rnd

qn = "692_HowToOpposeEvil"

# NPCs
DILIOS = 32549
KUTRAN = 32550
# ITEMS
LEKONS_CERTIFICATE       = 13857  # 雷坤的證明書
NUCLEUS_OF_A_FREED_SOUL  = 13796  # 解放的靈魂之核
FLEET_STEED_TROUPS_CHARM = 13841  # 龍馬團護身符
RAGING_HUNSHI_DEBRIS     = 15486  # 靈魂石碎片
# QUEST DROP
PORTION                  = 13798  # 靈魂的片段
NUCLEUS                  = 13863  # 不完整的靈魂之核
FLEET                    = 13865  # 龍馬團圖騰
BREATH                   = 13867  # 蒂雅特氣息
CONDENSATION             = 15535  # 凝縮的生命能量
SOULSTONE                = 15536  # 靈魂石碎片粉末
DESTRUCTION_DROP = [FLEET,BREATH]
IMMORTALITY_DROP = [NUCLEUS]
EXTERMINTE_DROP  = [CONDENSATION,SOULSTONE]
ENERGY_SEED = [ 18678,18679,18680,18681,18682,18683 ]
# MOBs
DESTRUCTION_MOBS = [ 22537, 22538, 22539, 22540, 22541, 22542, 22543, 22544, 22546, 22547, 22548, 22549, 22550, 22551, 22552, 22593, 22596, 22597 ]
IMMORTALITY_MOBS = [ 22510, 22511, 22512, 22513, 22514, 22515 ]
EXTERMINTE_MOBS  = [ 22746, 22747, 22748, 22749, 22750, 22751, 22752, 22753, 22754, 22755, 22756, 22757, 22758, 22759, 22760, 22761, 22762, 22763, 22764, 22765 ]
# ETC(100%=1000)
DROP_CHANCE = 50
# SKILL
FLASH_WORM = 5870

class Quest (JQuest) :
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [PORTION,NUCLEUS,FLEET,BREATH,CONDENSATION,SOULSTONE]

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		if event == "32549-03.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "32550-09.htm" :
			st.set("cond","3")
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.CREATED :
			if npcId == DILIOS and cond == 0 :
				if player.getLevel() >= 75 :
					htmltext = "32549-01.htm"
				else :
					htmltext = "32549-00.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == DILIOS :
				if cond == 1 :
					first = player.getQuestState("10273_GoodDayToFly")
					if first and first.getState() == State.COMPLETED or st.getQuestItemsCount(LEKONS_CERTIFICATE) >= 1 :
						if player.getLevel() >= 75 :
							htmltext = "32549-04.htm"
							st.set("cond","2")
						else :
							htmltext = "32549-00.htm"
					else :
						htmltext = "32549-03.htm"
				elif cond == 2 :
					htmltext = "32549-05.htm"
				elif cond == 3 :
					htmltext = "32549-06.htm"
			elif npcId == KUTRAN :
				if cond == 2 :
					htmltext = "32550-01.htm"
				elif cond == 3 :
					if st.getQuestItemsCount(13798) or st.getQuestItemsCount(13863) or st.getQuestItemsCount(13867) or st.getQuestItemsCount(13865) or st.getQuestItemsCount(15535) or st.getQuestItemsCount(15536) < 0 :
						htmltext = "32550-16.htm"
					else :
						htmltext = "32550-10.htm"
		return htmltext

	def onSkillSee(self, npc, caster, skill, targets, isPet):
		npcID = npc.getNpcId()
		if not npc in targets: return
		if skill.getId() not in FLASH_WORM : return
		n = st.getRandom(100)

		if npcID == ENERGY_SEED :
			if n < 80 :
				st.giveItems(PORTION,1)
		return

	def onKill(self,npc,player,isPet):
		partyMember = self.getRandomPartyMember(player,"3")
		if not partyMember: return
		st = partyMember.getQuestState(qn)
		if st :
			chance = DROP_CHANCE * Config.RATE_QUEST_DROP
			numItems, chance = divmod(chance,1000)
			if st.getRandom(1000) < chance : 
				numItems += 1
			if numItems : 
				if npc.getNpcId() in DESTRUCTION_MOBS :
					st.giveItems(DESTRUCTION_DROP[Rnd.get(len(DESTRUCTION_DROP))],int(numItems))
					st.playSound("ItemSound.quest_itemget")
				elif npc.getNpcId() in IMMORTALITY_MOBS :
					st.giveItems(NUCLEUS,int(numItems))
					st.playSound("ItemSound.quest_itemget")
				elif npc.getNpcId() in EXTERMINTE_MOBS :
					st.giveItems(EXTERMINTE_DROP[Rnd.get(len(EXTERMINTE_DROP))],int(numItems))
					st.playSound("ItemSound.quest_itemget")
		return

QUEST		= Quest(692,qn,"對抗惡的方法")

QUEST.addStartNpc(DILIOS)
QUEST.addTalkId(DILIOS)
QUEST.addTalkId(KUTRAN)

for i in DESTRUCTION_MOBS :
	QUEST.addKillId(i)

for i in IMMORTALITY_MOBS :
	QUEST.addKillId(i)

for i in EXTERMINTE_MOBS :
	QUEST.addKillId(i)