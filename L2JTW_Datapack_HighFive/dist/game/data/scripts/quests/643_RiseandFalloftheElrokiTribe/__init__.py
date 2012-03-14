# Created by Gigiikun
# Update by pmq 16-09-2010

import sys
from com.l2jserver import Config
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "643_RiseandFalloftheElrokiTribe"
#Npc
Singsing = 32106
Karakawei = 32117
#Settings: drop chance in %
DROP_CHANCE = 75
#Mobs
PLAIN_DINOSAURS = [22200,22201,22202,22219,22203,22204,22205,22220,22208,22209,22210,22211,22212,22213,22221,22222,22226,22227]
#Item
BONES_OF_A_PLAINS_DINOSAUR = 8776
REWARDS = range(8712,8723)
# Singsing npc Html
# 32106-00
Singsing_A = "<html><body>辛刑：<br>啊~冒險家啊~在找尋可做的事情嗎？這次這裡發現原始之島，亞丁港口在這裡開設了一個碼頭。<br>找尋這地方的冒險家漸漸增加，關心這裡的魔法師也逐漸增加。<br>我們除了準備船隻，也提供便利的服務給來訪此地的人，而且也與原住民交易。<br>現在提供冒險家們與委託者們的聯繫業務。<br>對了。現在有收到一個委託...<br>哦...<br>看來這委託對冒險家您有點困難喔。<br>(只有達到等級75以上才能執行任務。)</body></html>"
# 32106-01
Singsing_B = "<html><body>辛刑：<br>啊~冒險家啊~在找尋可做的事情嗎？這次這裡發現原始之島，亞丁港口在這裡開設了一個碼頭。<br>找尋這地方的冒險家漸漸增加，關心這裡的魔法師也逐漸增加。<br>我們除了準備船隻，也提供便利的服務給來訪此地的人，而且也與原住民交易。<br>同時也提供冒險家們與委託者們的聯繫業務。<br>對了。現在有收到一個委託...<br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Singsing_C\">是什麼委託呢？</a></body></html>"
# 32106-02
Singsing_C = "<html><body>辛刑：<br>在這原始之島棲息著太古的生物-恐龍，是在亞丁大陸看不到的。有知識的魔法師們說因為連諸神都怕牠們強悍的力量，因此曾與巨人並肩作戰過。因某種原因在亞丁大陸已經消失的這些生物竟在此地被發現了。<br>在碼頭附近只有發現比較微弱的生物，<br>叫做畢菲格的魔法師說為了研究需要此生物的骨頭。如果擊敗恐龍帶回它的骨頭，我將它購買轉達給委託人。您要接受委託嗎？<br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Singsing_D\">區區那種小事...我很樂意幫您</a><br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Singsing_I\">不好意思...我對爬蟲類有恐懼症...對不起</a></body></html>"
# 32106-03
Singsing_D = "<html><body>辛刑：<br>啊，果然是個冒險家啊。狩獵<font color=\"LEVEL\">恐爪龍、似鳥龍、厚頭龍、野生座龍</font>們之後，拿回<font color=\"LEVEL\">平原恐龍的骨頭</font>我就會轉達給畢菲格。<br>對了，與這島的原住民交易的朋友說，原住民的咒術士也在尋找這恐龍的骨頭。如果您有興趣去見原住民咒術士吧。<br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Singsing_E\">原住民咒術士所在的位置是？</a></body></html>"
# 32106-04
Singsing_E = "<html><body>辛刑：<br>原住民的咒術士在此地南方的原始之平原南部有一個孤島。因為排斥外來者，所以只能透過原始平原南部海岸與失落的巢穴之間的山麓角落，叫做<font color=\"LEVEL\">歐拉奇恩</font>的原住民戰士才能進入那孤島。</body></html>"
# 32106-05
Singsing_F = "<html><body>辛刑：<br>趕快把恐龍的骨頭收集回來吧，畢菲格一直在催呢。<br>好像是因為沒有恐龍的骨頭無法進行研究...<br>說是即將要在米茲巴帝魔法協會發表研究內容呢。<br>請您再多努力！<br>狩獵<font color=\"LEVEL\">恐爪龍、似鳥龍、厚頭龍、野生座龍</font>們之後，拿回<font color=\"LEVEL\">平原恐龍的骨頭</font>就可以了。</body></html>"
# 32106-05a
Singsing_G = "<html><body>辛刑：<br>哦！您收回<font color=\"LEVEL\">平原恐龍的骨頭</font>啦。收集回來的<font color=\"LEVEL\">平原恐龍的骨頭</font>，對畢菲格的研究會有很大的幫助。<br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Singsing_H\">將收回的平原恐龍的骨頭交換成金幣</a><br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Singsing_J\">說「將收集到的平原恐龍的骨頭直接交給原住民咒術士」</a></body></html>"
# 32106-06
Singsing_H = "<html><body>辛刑：<br>啊，這個我會好好收藏。一定會轉達給畢菲格的。畢菲格一定會很喜歡。<br>這是委託的費用。雖然不多但也請您收下。<br>要繼續接受委託嗎？<br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Singsing_L\">繼續工作</a><br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Singsing_I\">不做了</a></body></html>"
# 32106-07
Singsing_I = "<html><body>辛刑：<br>啊，是嗎。對冒險家您來說，這座島好像不是個令您舒服的地方。這裡有很多您討厭的爬蟲類出沒喔... (這樣也叫冒險家啊？)</body></html>"
# 32106-08
Singsing_J = "<html><body>辛刑：<br>啊~原來這樣啊...哦...把<font color=\"LEVEL\">平原恐龍的骨頭</font>交給誰其實是冒險家您自己可做的決定...但是哪邊比較有利請您重新考慮一下。<br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Singsing_E\">原住民咒術士在哪裡？</a><br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Singsing_K\">透過原住民咒術士可以得到些什麼？</a><br></body></html>"
# 32106-08a
Singsing_K = "<html><body>辛刑：<br>聽說向原住民的咒術士們交付平原恐龍的骨頭300個的話，就能隨機得到<font color=\"LEVEL\">為了製作A級特級武器的材料</font>。<br>而且，最近還說是會給<font color=\"LEVEL\">S80卷軸</font>作為獎勵品呢。這些東西依照物品將會要求平原恐龍的骨頭100~300個左右。<br>但是，如果透過我的話，就不需經過麻煩的手續，只要以<font color=\"LEVEL\">金幣</font>就能交換了。所以請您慎重考慮，別做出讓自己後悔的選擇。</body></html>"
# 32106-09
Singsing_L = "<html><body>辛刑：<br>那麻煩您繼續努力。狩獵<font color=\"LEVEL\">恐爪龍、似鳥龍、厚頭龍、野生座龍</font>之後，拿回<font color=\"LEVEL\">平原恐龍的骨頭</font>就可以了。</body></html>"
# Singsing npc Html
# 32117-01
Karakawei_A = "<html><body>卡拉卡維：<br>據說我們一族是為了監視連神都會懼怕的太古強力生命體-恐龍，偉大的女神席琳所挑選出的堅強種族。但是不知從何時起席琳對我們的祈禱沒有回應。<br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Karakawei_B\">詢問為什麼沒有回應</a></body></html>"
# 32117-02
Karakawei_B = "<html><body>卡拉卡維：<br>那個我們也不太清楚。難道我們一族有做到什麼不忠的事情嗎？不管怎樣，我們種族一定要恢復席琳的恩寵。失去恩寵的我們一族變的越來越懦弱...生病...還被我們所監視的恐龍擊敗...種族本身漸漸衰竭。<br>外來的冒險家啊，我們為了治癒我們漸漸深重的病，以及為了舉行恢復席琳之恩寵的儀式，需要祭品...<br>為了我們，你可以捐出<font color=\"LEVEL\">平原恐龍的骨頭</font>嗎？如果協助我們完成恢復恩寵的儀式，那麼我會給你們用於製作武器的材料，而為了治療病情協助我們製作藥材的話，我會給你用於製作武器的製作卷軸來報答你。<br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Karakawei_D\">請將平原恐龍的骨頭300個用於「祭祀」上</a><br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Karakawei_F\">請將平原恐龍的骨頭用為「藥材」</a><br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Karakawei_H\">對你們那原始種族的興亡沒什麼興趣，隨你便吧</a></body></html>"
# 32117-02a
Karakawei_C = "<html><body>卡拉卡維：<br>是那時候的冒險家啊...你來找我們一族是為何事？<br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Karakawei_A\">詢問有關耶爾可羅一族的興盛衰亡</a><br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Karakawei_D\">請將平原恐龍的骨頭300個用於「祭祀」上</a><br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Karakawei_F\">請將平原恐龍的骨頭用為「藥材」</a><br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe Karakawei_H\">對你們那原始種族的興亡沒什麼興趣隨你便吧</a></body></html>"
# 32117-03
Karakawei_D = "<html><body>卡拉卡維：<br>Thank you, adventurer...<br>I can now perform the ritual.<br>(Karakawei softly chants and seems to lose consciousness.)<br>....<br>....<br>....<br>....<br>(Suddenly, his eyes open!)<br>Ah, I feel that Shilen is satisfied with the ritual!<br>Thank you, adventurer...<br>Please accept this as a token of our appreciation. I also ask that you bring back those bones of the dinosaurs from the plains so that we may continue with these rituals!</body></html>"
# 32117-04
Karakawei_E = "<html><body>卡拉卡維：<br>為了祭祀需要<font color=\"LEVEL\">300個平原恐龍的骨頭</font>。如果將祭祀疏忽了事，不用說是得到席琳的恩寵，可能會受到災難！！！<br>快點去狩獵<font color=\"LEVEL\">恐爪龍、似鳥龍、厚頭龍、野生座龍</font>之後，帶回<font color=\"LEVEL\">平原恐龍的骨頭300個</font>回來！！！</body></html>"
# 32117-05
Karakawei_F = "<html><body>卡拉卡維：<br>如果為了治療我們的病，捐出平原恐龍的骨頭的話，我會按照那個數量支付你合理的酬勞。<br>你想要選擇什麼呢？<br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe 1\">捐出平原恐龍的骨頭400個後，領取「製作卷軸-封印的王朝外衣（60%）」</a><br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe 2\">捐出平原恐龍的骨頭250個後，領取「製作卷軸-封印的王朝長襪（60%）」</a><br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe 3\">捐出平原恐龍的骨頭200個後，領取「製作卷軸-封印的王朝頭箍（60%）」</a><br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe 4\">捐出平原恐龍的骨頭134個後，領取「製作卷軸-封印的王朝手套（60%）」</a><br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe 5\">捐出平原恐龍的骨頭134個後，領取「製作卷軸-封印的王朝鞋（60%）」</a><br><a action=\"bypass -h Quest 643_RiseandFalloftheElrokiTribe 6\">捐出平原恐龍的骨頭287個後，領取「製作卷軸-封印的王朝符印（60%）」</a></body></html>"
# 32117-06
Karakawei_G = "<html><body>卡拉卡維：<br>為了製作藥劑，需要用到足夠的平原恐龍的骨頭。我們不是為了利益，而是為了生存才會進行交易的，因此，休想與我們討價還價。如果沒有確保正確的數量，那就沒有所謂的交易。<br>趕快去狩獵<font color=\"LEVEL\">恐爪龍、似鳥龍、厚頭龍、野生座龍</font>之後，收集足夠的<font color=\"LEVEL\">平原恐龍的骨頭</font>回來！！！</body></html>"
# 32117-08
Karakawei_H = "<html><body>卡拉卡維：<br>哦...是個囂張的外來者...如果能恢復我們種族從前的力量...就不會受到這種待遇...<br>啊，啊，席琳啊...<br>如果沒事趕快離開這裡！！！</body></html>"

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [BONES_OF_A_PLAINS_DINOSAUR]

	def onAdvEvent (self,event,npc,player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		count = st.getQuestItemsCount(BONES_OF_A_PLAINS_DINOSAUR)
		if event == "Singsing_D" :
			htmltext = Singsing_D
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "Singsing_H" :
			htmltext = Singsing_H
			st.takeItems(BONES_OF_A_PLAINS_DINOSAUR,-1)
			st.giveItems(57,count*1374)
		elif event == "Singsing_I" :
			htmltext = Singsing_I
			st.playSound("ItemSound.quest_finish")
			st.exitQuest(1)
		elif event == "Karakawei_D" :
			if count >= 300 :
				st.takeItems(BONES_OF_A_PLAINS_DINOSAUR,300)
				st.rewardItems(REWARDS[st.getRandom(len(REWARDS))],5)
				htmltext = Karakawei_D
			else :
				htmltext = Karakawei_E
		elif event == "1" :
			if count >= 400 :
				st.takeItems(BONES_OF_A_PLAINS_DINOSAUR,400)
				st.giveItems(9492,1)
				htmltext = Karakawei_F
			else :
				htmltext = Karakawei_G
		elif event == "2" :
			if count >= 250 :
				st.takeItems(BONES_OF_A_PLAINS_DINOSAUR,250)
				st.giveItems(9493,1)
				htmltext = Karakawei_F
			else :
				htmltext = Karakawei_G
		elif event == "3" :
			if count >= 200 :
				st.takeItems(BONES_OF_A_PLAINS_DINOSAUR,200)
				st.giveItems(9494,1)
				htmltext = Karakawei_F
			else :
				htmltext = Karakawei_G
		elif event == "4" :
			if count >= 134 :
				st.takeItems(BONES_OF_A_PLAINS_DINOSAUR,134)
				st.giveItems(9495,1)
				htmltext = Karakawei_F
			else :
				htmltext = Karakawei_G
		elif event == "5" :
			if count >= 134 :
				st.takeItems(BONES_OF_A_PLAINS_DINOSAUR,134)
				st.giveItems(9496,1)
				htmltext = Karakawei_F
			else :
				htmltext = Karakawei_G
		elif event == "6" :
			if count >= 287 :
				st.takeItems(BONES_OF_A_PLAINS_DINOSAUR,287)
				st.giveItems(10115,1)
				htmltext = Karakawei_F
			else :
				htmltext = Karakawei_G
		elif event == "Singsing_A" :
			htmltext = Singsing_A
		elif event == "Singsing_B" :
			htmltext = Singsing_B
		elif event == "Singsing_C" :
			htmltext = Singsing_C
		elif event == "Singsing_D" :
			htmltext = Singsing_D
		elif event == "Singsing_E" :
			htmltext = Singsing_E
		elif event == "Singsing_F" :
			htmltext = Singsing_F
		elif event == "Singsing_G" :
			htmltext = Singsing_G
		elif event == "Singsing_H" :
			htmltext = Singsing_H
		#elif event == "Singsing_I" :
		#	htmltext = Singsing_I
		elif event == "Singsing_J" :
			htmltext = Singsing_J
		elif event == "Singsing_K" :
			htmltext = Singsing_K
		elif event == "Singsing_L" :
			htmltext = Singsing_L
		elif event == "Karakawei_A" :
			htmltext = Karakawei_A
		elif event == "Karakawei_B" :
			htmltext = Karakawei_B
		elif event == "Karakawei_C" :
			htmltext = Karakawei_C
		elif event == "Karakawei_D" :
			htmltext = Karakawei_D
		elif event == "Karakawei_E" :
			htmltext = Karakawei_E
		elif event == "Karakawei_F" :
			htmltext = Karakawei_F
		elif event == "Karakawei_G" :
			htmltext = Karakawei_G
		elif event == "Karakawei_H" :
			htmltext = Karakawei_H
		return htmltext

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st: return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		count = st.getQuestItemsCount(BONES_OF_A_PLAINS_DINOSAUR)
		if id == State.CREATED :
			if npcId == 32106 and cond == 0 :
				if player.getLevel() >= 75 :
					htmltext = Singsing_B
				else :
					htmltext = Singsing_A
					st.exitQuest(1)
		elif id == State.STARTED :
			if npcId == 32106 and cond == 1 :
				if count == 0 :
					htmltext = Singsing_F
				else :
					htmltext = Singsing_G
			elif npcId == 32117 and cond == 1 :
				if count == 0 :
					htmltext = Karakawei_A
				else :
					htmltext = Karakawei_C
		return htmltext

	def onKill (self, npc, player,isPet):
		partyMember = self.getRandomPartyMember(player,"1")
		if not partyMember: return
		st = partyMember.getQuestState(qn)
		if st :
			if st.getState() == State.STARTED :
				npcId = npc.getNpcId()
				cond = st.getInt("cond")
				count = st.getQuestItemsCount(BONES_OF_A_PLAINS_DINOSAUR)
				if cond == 1 :
					chance = DROP_CHANCE*Config.RATE_QUEST_DROP
					numItems, chance = divmod(chance,100)
					if self.getRandom(100) < chance : 
						numItems += 1
					if numItems :
						st.playSound("ItemSound.quest_itemget")
						st.giveItems(BONES_OF_A_PLAINS_DINOSAUR,int(numItems))
		return

QUEST		= Quest(643,qn,"耶爾可羅一族的興盛衰亡")

QUEST.addStartNpc(32106)

QUEST.addTalkId(32106)
QUEST.addTalkId(32117)

for mob in PLAIN_DINOSAURS :
	QUEST.addKillId(mob)