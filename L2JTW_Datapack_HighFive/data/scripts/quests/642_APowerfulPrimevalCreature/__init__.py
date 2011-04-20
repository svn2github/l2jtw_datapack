# Created by Gigiikun
# Update by pmq 17-09-2010
import sys
from com.l2jserver import Config
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "642_APowerfulPrimevalCreature"

#Npc
Dinn = 32105
#Settings: drop chance in %
EGG_DROP_CHANCE = 1
TISSUE_DROP_CHANCE = 33

#Set this to non-zero to use 100% recipes as reward instead of default 60%
ALT_RP_100 = 0

DINOSAUR_TISSUE = 8774
DINOSAUR_EGG = 8775
#DINOSAURS = [22196,22197,22198,22199,22200,22201,22202,22203,22204,22205,22218,22219,22220,22223,22224,22225,18344] OLD MOB
DINOSAURS = [22199,22215,22216,22217,22196,22197,22198,22218,22223,18344]
REWARDS = [8690,8692,8694,8696,8698,8700,8702,8704,8706,8708,8710]
REWARDS_W = {
    "1" : [9967 , 1], # 製作卷軸(王朝劍60%)
    "2" : [9968 , 1], # 製作卷軸(王朝之刃60%)
    "3" : [9969 , 1], # 製作卷軸(王朝幻影劍60%)
    "4" : [9970 , 1], # 製作卷軸(王朝弓60%)
    "5" : [9971 , 1], # 製作卷軸(王朝小刀60%)
    "6" : [9972 , 1], # 製作卷軸(王朝長柄戰戟60%)
    "7" : [9973 , 1], # 製作卷軸(王朝戰鎚60%)
    "8" : [9974 , 1], # 製作卷軸(王朝釘鎚60%)
    "9" : [9975 , 1], # 製作卷軸(王朝拳套爪60%)
    }
# Dinn Html
# 32105-00
Dinn_A = "<html><body>丁定：<br>哦，您看來不像是適合這危險孤島的客人耶...這裡是非常危險的地方，離開此地對您會有幫助的。<br>(只有達到等級75以上才能執行任務。)</body></html>"
# 32105-01
Dinn_B = "<html><body>丁定：<br>哦，好久沒有客人來到這危險的孤島耶...冒險家閣下也是聽到消息來的吧...<br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature Dinn_C\">您說的是什麼消息？</a></body></html>"
# 32105-02
Dinn_C = "<html><body>丁定：<br>這原始之島是最近才被發現的...不久後查明出，這兒不是一般的島嶼。在其他地方見不到的巨大且強力的生命體生存於此。<br>許多人對有關那全新的生命體感到莫大的興趣。<br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature Dinn_D\">詢問哪些人們對什麼東西感到興趣</a></body></html>"
# 32105-03
Dinn_D = "<html><body>丁定：<br>滿腹學識的魔法師們將那些生命稱為恐龍，還說牠們不是被目前所知的亞丁諸神創造的生命。<br>現在各地的魔法師都在研究有關恐龍們的起源，以及恐龍出現的意義。<br>此外，各地的工匠對於能否利用這新出現的強力生物來製造新武器或是各種材料的事情，也感到莫大的興趣。<br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature Dinn_E\">我想為這些人助一臂之力</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature Dinn_L\">自己的事應該自己去做，我沒興趣</a></body></html>"
# 32105-04
Dinn_E = "<html><body>丁定：<br>哦，是這樣嗎？真是太好了。對於恐龍感到莫大興趣的魔法師們以及矮人工匠們，為了收集他們工作時需要的材料，很想獲得冒險家們的幫助。因為這原始之島是個危險之地。<br>他們還拜託過我，為他們推薦能夠接手此事的冒險家呢。<br>去擊倒<font color=\"LEVEL\">喙嘴龍、暴龍、迅猛龍</font>後，收集牠們的活體組織來吧。<br>對了，將1顆<font color=\"LEVEL\">古代之卵</font>與150個恐龍活體組織組為一套的話，也可透過實驗來加工喔。<br>關於古代之卵，只要搜尋恐龍們的棲息地就能找得到。但是非常危險，可要小心喔。觸碰古代之卵的話，<font color=\"LEVEL\">周圍的恐龍們為了保護古代之卵，全部都會跑來的。古代之卵不像恐龍活體組織一樣需要很多，所以請考慮清楚後再做決定吧！</font><br>那麼，祝您好運。</body></html>"
# 32105-05
Dinn_F = "<html><body>丁定：<br>許多人正等待著冒險家大人的幫助啦。<br>去擊倒<font color=\"LEVEL\">喙嘴龍、暴龍、迅猛龍</font>後，收集牠們的活體組織來吧。<br>對了，將1顆<font color=\"LEVEL\">古代之卵</font>與150個恐龍活體組織組為一套的話，也可透過實驗來加工喔。<br>只要搜尋恐龍們的棲息地就能找得到古代之卵。但是非常危險，可要小心喔。觸碰古代之卵的話，<font color=\"LEVEL\">周圍的恐龍們為了保護古代之卵，通通都會跑來的。古代之卵不像恐龍活體組織一樣需要很多，所以請考慮清楚後再做決定！</font><br>那麼快去收集一些回來吧。</body></html>"
# 32105-06
Dinn_G = "<html><body>丁定：<br>哦~您收集來啦。大家一定會很高興的。<br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature Dinn_H\">交出恐龍活體組織</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature Dinn_I\">將1顆古代之卵和150個恐龍活體組織透過實驗加工</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature Dinn_M\">說想查看其他物品</a></body></html>"
# 32105-06a
Dinn_H = "<html><body>丁定：<br>辛苦了。往後會有許多研究將開始進行。希望能有好成果，如果能有許多人來這原始之島就好了...這是我小小的心意。請收下...要繼續幫忙嗎？<br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature Dinn_K\">說要繼續做</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature Dinn_L\">說要放棄</a></body></html>"
# 32105-07
Dinn_I = "<html><body>丁定：<br>By processing 1 Ancient Egg and 150 dinosaur biological tissues, it's possible to create some truly special materials.<br>These materials will be of great help to the scholars studying these creatures.<br>If you give me the ingredients that you've collected in order to make the processed material, I'll trade you the following items：<br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 8690\">製作卷軸(希露冰刃60%)</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 8692\">製作卷軸(伊波斯巨劍60%)</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 8694\">製作卷軸(貝拉凱爾聖斧60%)</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 8696\">製作卷軸(貝希莫斯巨叉60%)</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 8698\">製作卷軸(那卡風暴60%)</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 8700\">製作卷軸(岱依封長戟60%)</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 8702\">製作卷軸(夏伊德獵弓60%)</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 8704\">製作卷軸(索貝克颶風60%)</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 8706\">製作卷軸(緹米絲之舌60%)</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 8708\">製作卷軸(卡布里歐之手60%)</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 8710\">製作卷軸(惡魔結晶60%)</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature Dinn_K\">現在不想加工</a></body></html>"
# 32105-07a
Dinn_J = "<html><body>丁定：<br>要進行實驗的話，需要有1顆古代之卵與150個恐龍活體組織為一組的套件。去擊倒<font color=\"LEVEL\">喙嘴龍、暴龍、迅猛龍</font>後，將牠們的活體組織來...還有別忘了搜尋恐龍們的棲息地，將<font color=\"LEVEL\">古代之卵</font>拿來吧...</body></html>"
# 32105-08
Dinn_K = "<html><body>丁定：<br>謝謝！<br>那麼繼續去擊倒<font color=\"LEVEL\">喙嘴龍、暴龍、迅猛龍</font>後，收集牠們的活體組織來吧。<br>對了，將1顆<font color=\"LEVEL\">古代之卵</font>與150個恐龍活體組織組為一套的話，也可透過實驗來加工喔。<br>只要搜尋恐龍們的棲息地就能找得到古代之卵。但是非常危險，可要小心喔。觸碰古代之卵的話，<font color=\"LEVEL\">周圍的恐龍們為了保護古代之卵，會全部跑來的。古代之卵不像恐龍活體組織一樣需要很多，所以請考慮清楚後再做決定吧！</font><br>那麼，繼續辛苦您了。</body></html>"
# 32105-09
Dinn_L = "<html><body>丁定：<br>是的，我不是說過了嗎？儘管去忙您的事情吧。</body></html>"
# 32105-10
Dinn_M = "<html><body>卡拉卡維：<br>用活體組織450個的話，我會按照那個數量支付你合理的酬勞。<br>你想要選擇什麼呢？<br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 1\">換取「製作卷軸-（王朝劍60%）」</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 2\">換取「製作卷軸-（王朝之刃60%）」</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 3\">換取「製作卷軸-（王朝幻影劍60%）」</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 4\">換取「製作卷軸-（王朝弓60%）」</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 5\">換取「製作卷軸-（王朝小刀60%）」</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 6\">換取「製作卷軸-（王朝長柄戰戟60%）」</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 7\">換取「製作卷軸-（王朝戰鎚60%）」</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 8\">換取「製作卷軸-（王朝釘鎚60%）」</a><br><a action=\"bypass -h Quest 642_APowerfulPrimevalCreature 9\">換取「製作卷軸-（王朝拳套爪60%）」</a></body></html>"
# 32105-11
Dinn_N = "<html><body>丁定：<br>若想得到新的物品，需要有活體組織450個。再去狩獵一些<font color=\"LEVEL\">喙嘴龍、暴龍、迅猛龍</font>後，帶回足夠的恐龍活體組織吧。</body></html>"

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [DINOSAUR_TISSUE, DINOSAUR_EGG]

	def onAdvEvent (self,event,npc,player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		count_tissue = st.getQuestItemsCount(DINOSAUR_TISSUE)
		count_egg = st.getQuestItemsCount(DINOSAUR_EGG)
		if event == "Dinn_E" :
			htmltext = Dinn_E
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "Dinn_H" :
			htmltext = Dinn_H
			st.takeItems(DINOSAUR_TISSUE,-1)
			st.giveItems(57,count_tissue*5000)
		elif event == "Dinn_I" :
			if count_tissue < 150 or count_egg == 0 :
				htmltext = Dinn_J
			elif ALT_RP_100 != 0 :
				#htmltext = st.showHtmlFile("Dinn_I").replace("60%","100%")
				htmltext = Dinn_I
		elif event.isdigit() and int(event) in REWARDS :
			if count_tissue >= 150 and count_egg >= 1 :
				htmltext = Dinn_K
				st.takeItems(DINOSAUR_TISSUE,150)
				st.takeItems(DINOSAUR_EGG,1)
				st.giveItems(57,44000)
				if ALT_RP_100 != 0 :
					st.giveItems(int(event)+1,1)
				else :
					st.giveItems(int(event),1)
			else :
				htmltext = Dinn_J
		elif event == "Dinn_M" :
			if count_tissue >= 450 :
				htmltext = Dinn_M
			else :
				htmltext = Dinn_N
		elif event in REWARDS_W.keys() :
			if count_tissue >= 450 :
				item, amount = REWARDS_W[event]
				st.takeItems(DINOSAUR_TISSUE,450)
				st.rewardItems(item, amount)
				st.playSound("ItemSound.quest_itemget")
				htmltext = Dinn_M
			else :
				htmltext = Dinn_N
		elif event == "Dinn_A" :
			htmltext = Dinn_A
		elif event == "Dinn_B" :
			htmltext = Dinn_B
		elif event == "Dinn_C" :
			htmltext = Dinn_C
		elif event == "Dinn_D" :
			htmltext = Dinn_D
		elif event == "Dinn_E" :
			htmltext = Dinn_E
		elif event == "Dinn_F" :
			htmltext = Dinn_F
		elif event == "Dinn_G" :
			htmltext = Dinn_G
		elif event == "Dinn_H" :
			htmltext = Dinn_H
		elif event == "Dinn_I" :
			htmltext = Dinn_I
		elif event == "Dinn_J" :
			htmltext = Dinn_J
		elif event == "Dinn_K" :
			htmltext = Dinn_K
		elif event == "Dinn_L" :
			htmltext = Dinn_L
		elif event == "Dinn_M" :
			htmltext = Dinn_M
		elif event == "Dinn_N" :
			htmltext = Dinn_N
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st: return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		count = st.getQuestItemsCount(DINOSAUR_TISSUE)
		if id == State.CREATED :
			if npcId == 32105 and cond == 0 :
				if player.getLevel() >= 75 :
					htmltext = Dinn_B
				else :
					htmltext = Dinn_A
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == 32105 and cond == 1 :
				if count == 0 :
					htmltext = Dinn_F
				else :
					htmltext = Dinn_G
		return htmltext

	def onKill (self, npc, player,isPet):
		partyMember = self.getRandomPartyMember(player,"1")
		if not partyMember: return
		st = partyMember.getQuestState(qn)
		if st :
			if st.getState() == State.STARTED :
				npcId = npc.getNpcId()
				cond = st.getInt("cond")
				count = st.getQuestItemsCount(DINOSAUR_TISSUE)
				if cond == 1 :
					if npcId == 18344 :
						itemId = DINOSAUR_EGG
						chance = EGG_DROP_CHANCE*Config.RATE_QUEST_DROP
						numItems, chance = divmod(chance,100)
					else :
						itemId = DINOSAUR_TISSUE
						chance = TISSUE_DROP_CHANCE*Config.RATE_QUEST_DROP
						numItems, chance = divmod(chance,100)
					if st.getRandom(100) < chance : 
						numItems += 1
					if numItems :
						if int(count + numItems) and itemId == DINOSAUR_TISSUE :
							st.playSound("ItemSound.quest_itemget")
						st.giveItems(itemId,int(numItems))
		return

QUEST		= Quest(642,qn,"有關太古強力生物的研究")

QUEST.addStartNpc(32105)

QUEST.addTalkId(32105)

for mob in DINOSAURS :
   QUEST.addKillId(mob)