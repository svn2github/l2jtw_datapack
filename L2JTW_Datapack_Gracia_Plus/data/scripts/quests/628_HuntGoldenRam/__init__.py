# Hunt of the Golden Ram Mercenary Force
# Made by Polo - Have fun!..... fix & addition by t0rm3nt0r and LEX
# update by pmq
# High Five 20-02-2011
import sys
from com.l2jserver import Config 
from com.l2jserver.gameserver.datatables import SkillTable
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "628_HuntGoldenRam"

# 傭兵 卡姆恩
# 31554-c1.htm
#kahman_c1 = "<html><body>傭兵卡姆恩：<br>我們是黃金羊傭兵團！曾經和齊格海特一起在傲慢之塔打過仗！我的兄弟，卡姆恩風雨神那魯加，身為一名戰士在那裡倒下。它的靈魂現在一定在帕格立歐的火焰燃燒著。<br>為讚頌光榮面對死亡的兄長之名，今日我仍在戰鬥。你想不想當榮耀的黃金羊弟兄，和我們一起戰鬥啊？<br><a action=\"bypass -h npc_%objectId%_Quest\">任務</a></body></html>"
# 31554-c2.htm
#kahman_c2 = "<html><body>傭兵卡姆恩：<br>哦，你來啦！你，不愧黃金羊之名立了優秀的戰果。本卡姆恩真心佩服你的本事！<br>把這兒沼澤地帶的所有蟲子都燒掉的那一天為止，希望你繼續加油！<br><a action=\"bypass -h npc_%objectId%_Quest\">任務</a></body></html>"
# 31554-04.htm
kahman_04 = "<html><body>傭兵卡姆恩：<br>到底在幹什麼！若想成為光榮的黃金羊傭兵團之成員的話，就得去悲嗚的沼澤獵殺思布林特司塔卡拓後，收集<font color=\"LEVEL\">100個思布林特司塔卡拓的甲殼</font>才行！去吧，士兵啊！</body></html>"
# 31554-05.htm
kahman_05 = "<html><body>傭兵卡姆恩：<br>回來啦，士兵啊！嗯，完成司塔卡拓的討伐了嗎？沒有實力的人是絕對不能成為黃金羊傭兵團的兄弟的！<br><a action=\"bypass -h Quest 628_HuntGoldenRam kahman_06\">將100個思布林特司塔卡拓的甲殼交給他</a></body></html>"
# 31554-06.htm
kahman_06 = "<html><body>傭兵卡姆恩：<br>辛苦了，士兵啊！若是你，就有成為黃金羊傭兵團之兄弟的充分資格！<br>好，拿去這<font color=\"LEVEL\">黃金羊的標誌 - 新兵</font>吧！從現在起，你就是我們黃金羊傭兵團的兄弟了。恭喜你！<br>不過士兵啊，若想成為精銳兵的話，要變的更強才行！進去悲嗚的沼澤討伐思布林特司塔卡拓與尼多司塔卡拓後，必須收集<font color=\"LEVEL\">""100""個思布林特司塔卡拓的甲殼與100個尼多司塔卡拓後的甲殼</font>才行！<br>連這種程度的任務也不能完成的話，就不配成為精銳兵！<br></body></html>"
# 31554-07.htm
kahman_07 = "<html><body>傭兵卡姆恩：<br>想成為黃金羊的精銳兵的話，要變的更強才行！進去悲嗚的沼澤討伐思布林特司塔卡拓與尼多司塔卡拓後，必須收集<font color=\"LEVEL\">100個思布林特司塔卡拓的甲殼與100個尼多司塔卡拓後的甲殼</font>才行！<br>連這種程度的任務也不能完成的話，就不配成為精銳兵！<br><a action=\"bypass -h Quest 628_HuntGoldenRam kahman_08\">「現在要上戰場！」</a><br><a action=\"bypass -h Quest 628_HuntGoldenRam kahman_09\">「放棄精銳兵的考驗，並退出黃金羊傭兵團。」</a></body></html>"
# 31554-08.htm
kahman_08 = "<html><body>傭兵卡姆恩：<br>就是這種精神！把敵方打倒吧再打倒吧！以黃金羊之名揚名立萬吧！</body></html>"
# 31554-09.htm
kahman_09 = "<html><body>傭兵卡姆恩：<br>要成為光榮的黃金羊傭兵團一員，不是那麼簡單的事情！若現在放棄的話，你以後肯定會後悔！也可能要重新參加入團考試！即使這樣也想要退出我們的傭兵團嗎？<br><a action=\"bypass -h Quest 628_HuntGoldenRam kahman_10\">確定要退出</a></body></html>"
# 31554-10.htm
kahman_10 = "<html><body>傭兵卡姆恩：<br>那麼真重。</body></html>"
# 31554-11.htm
kahman_11 = "<html><body>傭兵卡姆恩：<br>真了不起！果然是歷經百戰的勇士！若是你，就有十分具有成為黃金羊傭兵團精銳的資格！<br>好，拿去這<font color=\"LEVEL\">黃金羊的標誌 - 精銳兵</font>吧！恭喜你，戰友啊！</body></html>"
# 31554-12.htm
kahman_12 = "<html><body>傭兵卡姆恩：<br>戰友啊，在你執行任務時若需要幫忙的話，就去找醫務兵瑟麗娜與補給兵亞柏克隆比吧！<br>瑟麗娜會用魔法，亞柏克隆比會用物資來幫助你。<br>這段時間你的功績相當出色，如果想放棄傭兵職位的話，就跟我卡姆恩說吧。<br><a action=\"bypass -h Quest 628_HuntGoldenRam kahman_08\">「現在要上戰場！」</a><br><a action=\"bypass -h Quest 628_HuntGoldenRam kahman_09\">「我要放棄傭兵職位。」</a></body></html>"
#
# 傭兵隊補給兵 亞柏克隆比
# 31555-c1.htm
#abercrombie_c1 = "<html><body>傭兵隊補給兵亞柏克隆比：<br>哎呀，真讓人麻煩！你沒看見我忙嗎？！現在光應付傭兵隊員就已經夠頭疼啦。我可沒空應付像你這樣的外來人！<br>如果想加入我們黃金羊傭兵團，去找那邊的卡姆恩吧。到底~待在這可惡的沼澤地帶有什麼錢好賺的。唉喲~命苦啊！<br><a action=\"bypass -h npc_%objectId%_Quest\">任務</a></body></html>"
# 31555-01.htm
#abercrombie_01 = "<html><body>傭兵隊補給兵亞柏克隆比：<br>歡迎光臨！通常都是這樣，在這可惡的沼澤地帶總是不容易收到補給品，所以就這麼辛苦。該面對的怪物也都是令人頭疼之頖~當初到這北邊邊緣的時候早該料想到的。到底~那些小錢還能值多少~呆在這樣窮鄉僻壤有完沒完的~真不明白上頭的想法啦？<br>齊格海特親自指揮傭兵隊的時候不是這樣的！雖所謂凡事皆難，但是至少給手下準備一下能夠愉快地打仗的條件嘛！<br>好，有要找的東西嗎？等一下，我看看目錄。對了，把銅幣帶來了吧？<br><a action=\"bypass -h npc_%objectId%_multisell 6281\">將黃金羊的銅幣交換成補給品</a><br><a action=\"bypass -h npc_%objectId%_Quest\">任務</a></body></html>"
# 31555-02.htm
#abercrombie_02 = "<html><body>傭兵隊補給兵亞柏克隆比：<br>聽說今天也很厲害吧？哎呀，這傭兵團的額外賞金都~被你拿走了？呵呵，不過連在這種頭疼的地方都立了戰功，太幸運了。<br>好，有想要的東西嗎？儘管說吧。所謂這些該死的補給品雖然沒有多少，但是本亞柏完隆比會盡力而為的。對了，把銅幣帶來了吧？<br><a action=\"bypass -h npc_%objectId%_multisell 6282\">將黃金羊的銅幣交換成補給品</a><br><a action=\"bypass -h npc_%objectId%_Quest\">任務</a></body></html>"
#
# 傭兵隊醫務兵 瑟麗娜
# 31556-c1.htm
#selina_c1 = "<html><body>傭兵隊醫務兵瑟麗娜：<br>嗯...你呀。你既不屬於這黃金羊傭兵團，又不是我的男朋友吧？別煩我好嗎？哦？<br>你想支援傭兵隊嗎？那麼，去找看起來面惡的半獸人那裡吧。</body></html>"
# 31556-c2.htm
#selina_c2 = "<html><body>傭兵隊醫務兵瑟麗娜：<br>噢，你加入我們部隊了嗎？呵呵...<br>我叫瑟麗娜，是醫務兵。請多指教。<br><a action=\"bypass -h npc_%objectId%_Quest\">任務</a></body></html>"
# 31556-c3.htm
#selina_c3 = "<html><body>傭兵隊醫務兵瑟麗娜：<br>你呀，勇敢也好，但也要照顧身體吧。你這樣渾身是傷的回來的話，連見到的人都覺得不好意思啦...！<br>不過，辛苦你了。幸虧有你，大家都覺得有一點的希望。我也想用魔法幫你小小的忙...有需要東西的話儘管說。<br><a action=\"bypass -h npc_%objectId%_Quest\">任務</a></body></html>"
# 31556-01.htm
selina_01 = "<html><body>傭兵隊醫務兵瑟麗娜：<br>你呀，勇敢也好，但也要照顧身體吧。你這樣渾身是傷的回來的話，連見到的人都覺得不好意思啦...！<br>不過，辛苦你了。幸虧有你，大家都覺得有一點的希望。我也想用魔法幫你小小的忙...有需要東西的話儘管說。<br><a action=\"bypass -h Quest 628_HuntGoldenRam 1\">弱點偵測：需要黃金羊的銅幣 2個</a><br><a action=\"bypass -h Quest 628_HuntGoldenRam 2\">死之呢喃：需要黃金羊的銅幣 2個</a><br><a action=\"bypass -h Quest 628_HuntGoldenRam 3\">力量強化：需要黃金羊的銅幣 3個</a><br><a action=\"bypass -h Quest 628_HuntGoldenRam 4\">靈活思緒：需要黃金羊的銅幣 3個</a><br><a action=\"bypass -h Quest 628_HuntGoldenRam 5\">狂戰士魂：需要黃金羊的銅幣 3個</a><br><a action=\"bypass -h Quest 628_HuntGoldenRam 6\">吸血怒擊：需要黃金羊的銅幣 3個</a><br><a action=\"bypass -h Quest 628_HuntGoldenRam 7\">魔力催化：需要黃金羊的銅幣 6個</a><br><a action=\"bypass -h Quest 628_HuntGoldenRam 8\">速度激發：需要黃金羊的銅幣 6個</a><br><a action=\"bypass -h npc_%objectId%_Quest\">任務</a></body></html>"
# 31556-02.htm
selina_02 = "<html><body>傭兵隊醫務兵瑟麗娜：<br>我所運用的魔力是傭兵團財源之一部分。所以說，不能免費的為您施展輔助魔法。得支付<font color=\"LEVEL\">黃金羊的銅幣</font>做為代價。若執行比斯隊長給的任務，就會得到銅幣做為報酬。請做參考。</body></html>"

#Npcs
KAHMAN      = 31554  # 傭兵 卡姆恩
ABERCROMBIE = 31555  # 傭兵隊補給兵 亞柏克隆比
SELINA      = 31556  # 傭兵隊醫務兵 瑟麗娜
NPCS        = range(31554,31557)

#Items
RECRUIT         = 7246  # 黃金羊的標誌-新兵
SOLDIER         = 7247  # 黃金羊的標誌-精銳兵
CHITIN          = 7248  # 思布林特司塔卡拓的甲殼
CHITIN2         = 7249  # 尼多司塔卡拓的甲殼
GOLDEN_RAM_COIN = 7251  # 黃金羊的銅幣

#chances
MAX = 100
CHANCE={
    21508:50, # 思布林特司塔卡拓
    21509:43, # 思布林特司塔卡拓工人
    21510:52, # 思布林特司塔卡拓士兵
    21511:57, # 陽性思布林特司塔卡拓
    21512:75, # 陽性思布林特司塔卡拓
    21513:50, # 尼多司塔卡拓
    21514:43, # 尼多司塔卡拓工人
    21515:52, # 尼多司塔卡拓士兵
    21516:53, # 陽性尼多司塔卡拓
    21517:74  # 陽性尼多司塔卡拓
}
#"event number":[Buff Id,Buff Level,Cost]
BUFF={
"1":[4404,2,2], # 弱點偵測：需要黃金羊的銅幣 2個
"2":[4405,2,2], # 死之呢喃：需要黃金羊的銅幣 2個
"3":[4393,3,3], # 力量強化：需要黃金羊的銅幣 3個
"4":[4400,2,3], # 靈活思緒：需要黃金羊的銅幣 3個
"5":[4397,1,3], # 狂戰士魂：需要黃金羊的銅幣 3個
"6":[4399,2,3], # 吸血怒擊：需要黃金羊的銅幣 3個
"7":[4401,1,6], # 魔力催化：需要黃金羊的銅幣 6個
"8":[4402,2,6], # 速度激發：需要黃金羊的銅幣 6個
}

#needed count
count = 100

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = range(7246,7250)

	def onAdvEvent (self,event,npc,player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		if str(event) in BUFF.keys():
			skillId,level,coins=BUFF[event]
			if st.getQuestItemsCount(GOLDEN_RAM_COIN) >= coins :
				st.takeItems(GOLDEN_RAM_COIN,coins)
				npc.setTarget(player)
				npc.doCast(SkillTable.getInstance().getInfo(skillId,level))
				htmltext = selina_01
			else :
				htmltext = selina_02
		elif event == "31554-03.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "kahman_06" :
			htmltext = kahman_06
			st.takeItems(CHITIN,-1)
			st.giveItems(RECRUIT,1)
			st.set("cond","2")
			st.playSound("ItemSound.quest_middle")
		elif event == "kahman_10" :
			htmltext = kahman_10
			st.exitQuest(1)
			st.playSound("ItemSound.quest_giveup")
		# 傭兵 卡姆恩
#		elif event == "kahman_c1" :
#			htmltext = kahman_c1
#		elif event == "kahman_c2" :
#			htmltext = kahman_c2
		elif event == "kahman_04" :
			htmltext = kahman_04
		elif event == "kahman_05" :
			htmltext = kahman_05
		elif event == "kahman_06" :
			htmltext = kahman_06
		elif event == "kahman_07" :
			htmltext = kahman_07
		elif event == "kahman_08" :
			htmltext = kahman_08
		elif event == "kahman_09" :
			htmltext = kahman_09
		elif event == "kahman_10" :
			htmltext = kahman_10
		elif event == "kahman_11" :
			htmltext = kahman_11
		elif event == "kahman_12" :
			htmltext = kahman_12
		# 傭兵隊補給兵 亞柏克隆比
#		elif event == "abercrombie_c1" :
#			htmltext = abercrombie_c1
#		elif event == "abercrombie_01" :
#			htmltext = abercrombie_01
#		elif event == "abercrombie_02" :
#			htmltext = abercrombie_02
		# 傭兵隊醫務兵 瑟麗娜
#		elif event == "selina_c1" :
#			htmltext = selina_c1
#		elif event == "selina_c2" :
#			htmltext = selina_c2
#		elif event == "selina_c3" :
#			htmltext = selina_c3
		elif event == "selina_01" :
			htmltext = selina_01
		elif event == "selina_02" :
			htmltext = selina_02
		return htmltext

	def onTalk(self, npc, player) :
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st :return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		chitin1 = st.getQuestItemsCount(CHITIN)
		chitin2 = st.getQuestItemsCount(CHITIN2)

		if id == State.CREATED :
			if npcId == KAHMAN and cond == 0 :
				if player.getLevel() >= 66 :
					htmltext = "31554-02.htm"
				else :
					htmltext = "31554-01.htm"
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == KAHMAN :
				if cond == 1 :
					if chitin1 >= 100 :
						htmltext = kahman_05
					else:
						htmltext = kahman_04
				elif cond == 2 :
					if chitin1 >= 100 and chitin2 >= 100 :
						htmltext = kahman_11
						st.takeItems(RECRUIT,-1)
						st.giveItems(SOLDIER,1)
						st.takeItems(CHITIN,-1)
						st.takeItems(CHITIN2,-1)
						st.set("cond","3")
						st.playSound("ItemSound.quest_middle")
					else :
						htmltext = kahman_07
				elif cond == 3 :
					htmltext = kahman_12
#			elif npcId == ABERCROMBIE :
#				if cond == 2 :
#					htmltext = abercrombie_01
#				elif cond == 3 :
#					htmltext = abercrombie_02
			elif npcId == SELINA :
				if cond == 3 :
					htmltext = selina_01
		return htmltext

	def onFirstTalk(self, npc, player) :
		st = player.getQuestState(qn)
		if not st :
			st = self.newQuestState(player)

		npcId = npc.getNpcId()
		cond = st.getInt("cond")

		if npcId == KAHMAN :
#			if cond in [1] :
#				return "31554-c1.htm"
			if cond in [2,3] :
				return "31554-c2.htm"
		elif npcId == ABERCROMBIE :
			if cond in [1] :
				return "31555-c1.htm"
			elif cond == 2 :
				return "31555-01.htm"
			elif cond == 3 :
				return "31555-02.htm"
		elif npcId == SELINA :
			if cond in [1] :
				return "31556-c1.htm"
			elif cond == 2 :
				return "31556-c2.htm"
			elif cond == 3 :
				return "31556-c3.htm"
		player.setLastQuestNpcObject(npc.getObjectId())
		npc.showChatWindow(player)
		return ""

	def onKill(self,npc,player,isPet):
		partyMember = self.getRandomPartyMemberState(player, State.STARTED)
		if not partyMember : return
		st = partyMember.getQuestState(qn)
		if st :
			if st.getState() == State.STARTED :
				npcId = npc.getNpcId()
				cond = st.getInt("cond")
				chance = CHANCE[npcId]*Config.RATE_QUEST_DROP
				numItems, chance = divmod(chance,MAX)
				if st.getRandom(100) <chance :
					numItems = numItems + 1
				item = 0
				if cond in [1,2] and npcId in range(21508,21513):
					item = CHITIN       
				elif cond == 2 and npcId in range(21513,21518):
					item = CHITIN2
				if item != 0 and numItems >= 1 :
					prevItems = st.getQuestItemsCount(item)
					if count > prevItems :
						if count <= (prevItems + numItems) :
							numItems = count - prevItems
							st.playSound("ItemSound.quest_middle")
						else :
							st.playSound("ItemSound.quest_itemget")
						st.giveItems(item,int(numItems))
		return

QUEST		= Quest(628,qn,"黃金羊的狩獵")

QUEST.addStartNpc(KAHMAN)

for i in NPCS:
	QUEST.addFirstTalkId(i)
for i in NPCS:
	QUEST.addTalkId(i)

for mob in range(21508,21518):
	QUEST.addKillId(mob)