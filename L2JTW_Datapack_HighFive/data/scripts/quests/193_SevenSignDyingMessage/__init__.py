# 2010-06-26 by Gnacik
# Based on official server Franz
# update by pmq
# High Five 12-2-2011
import sys
from com.l2jserver.gameserver.ai                    import CtrlIntention
from com.l2jserver.gameserver.model.quest           import State
from com.l2jserver.gameserver.model.quest           import QuestState
from com.l2jserver.gameserver.model.quest.jython    import QuestJython as JQuest
from com.l2jserver.gameserver.network.serverpackets import ExStartScenePlayer
from com.l2jserver.gameserver.network.serverpackets import NpcSay

qn = "193_SevenSignDyingMessage"

# NPCs
HOLLINT       = 30191  # 大神官 霍爾林特
CAIN          = 32569  # 神官 凱因
ERIC          = 32570  # 採藥師 艾力克
ATHEBALDT     = 30760  # 古斯達夫 亞太法特卿
SHILENSEVIL   = 27343  # 席琳的邪念
# ITEMS
JACOB_NECK    = 13814  # 雅各的項鍊
DEADMANS_HERB = 13816  # 死者的藥草
SCULPTURE     = 14353  # 疑問的雕像

# 大神官 霍爾林特
# 30191-03.htm
hollint_03 = "<html><body>大神官 霍爾林特：<br>負責慰靈祭的是<font color=\"LEVEL\">神官凱因</font>。<br>他在<font color=\"LEVEL\">歐瑞城鎮湖水附近的慰靈祭祭壇</font>附近。<br>還有，我在那項鍊已有融入祝福的祈禱，這事情也請您別忘了轉告神官凱因。<br>願殷海薩的祝福與您同在...</body></html>"
#
# 神官 凱因
# 32569-01.htm
cain_01 = "<html><body>神官 凱因：<br>竟然會有個陌生人來找我，看來在這世上的某個角落，又有一個生命失去了他的光芒...<br>嗯，你是來為誰舉行慰靈祭的呢？告訴我來龍去脈吧。<br><a action=\"bypass -h Quest 193_SevenSignDyingMessage cain_02\">我是前來舉行雅各的慰靈祭</a></body></html>"
# 32569-02.htm
cain_02 = "<html><body>神官 凱因：<br>契約官？真是奇怪啊...前幾天才剛剛結束了一個慰靈祭，也是與財富的商人交易過的另一個矮人契約官..<br>你說又有一個契約官死了是嗎？！..嗯..<br>是誰介紹你過來的？<br><a action=\"bypass -h Quest 193_SevenSignDyingMessage cain_03\">我是經由大神官霍爾林特介紹過來的</a></body></html>"
# 32569-03.htm
cain_03 = "<html><body>神官 凱因：<br>你說的是歐瑞城鎮的大神官霍爾林特嗎？<br>這麼說，這次死的契約官是在負責締結歐瑞城鎮與財富的商人之間的契約囉。<br>上次死的是高達特城的契約官呢..<br>既然是由你來舉行慰靈祭，那麼第一個發現屍體的人應該就是你吧。<br><a action=\"bypass -h Quest 193_SevenSignDyingMessage cain_04\">是的，沒錯</a></body></html>"
# 32569-04.htm
cain_04 = "<html><body>神官 凱因：<br>你真是替人行善啊..不過在進行慰靈祭之前，我們有個問題存在。<br>為了在慰靈祭祭壇點香的話，就要用到叫做<font color=\"LEVEL\">「死者的藥草」</font>的東西...但最近舉行的慰靈祭太多，所以藥草也都用完了。<br>再加上，答應要送來死者的藥草的<font color=\"LEVEL\">採藥師艾力克</font>又遲遲未到...<br>他肯定是為了採集神奇的藥草，忘了我的委託。<br>你去找艾力克，幫我領取<font color=\"LEVEL\">「死者的藥草」</font>好嗎？為了舉行慰靈祭，必須要有死者的藥草才行。<br><a action=\"bypass -h Quest 193_SevenSignDyingMessage cain_05\">我會幫你領取死者的藥草回來</a></body></html>"
# 32569-05.htm
cain_05 = "<html><body>神官 凱因：<br>謝謝你！那麼，趕緊去找<font color=\"LEVEL\">採藥師艾力克</font>，<br>然後，盡量多領取一些<font color=\"LEVEL\">「死者的藥草」</font>。<br>我想他應該會在<font color=\"LEVEL\">妖精谷</font>的附近，因為那個地方以出產珍貴的藥草而聞名。<br>還有，如果你有帶來死者的遺物，就把它交給我吧。<br>哦！！！在遺物上散發著神聖的氣息，看來霍爾林特已將為死者祝福的祈禱融入了其中。不愧是霍爾林特。<br>那麼，你就快去領回藥草吧。</body></html>"
# 32569-06.htm
cain_06 = "<html><body>神官 凱因：<br>不要耽擱，快去找在<font color=\"LEVEL\">妖精谷</font>附近的<font color=\"LEVEL\">採藥師艾力克</font>，<br>而且不要忘了領回<font color=\"LEVEL\">「死者的藥草」</font>！！！</body></html>"
# 32569-07.htm
cain_07 = "<html><body>神官 凱因：<br>帶回<font color=\"LEVEL\">死者的藥草</font>啦，把它交給我吧。<br>真是辛苦你了。那麼我們就來正式地舉行慰靈祭。<br>靠過來一點，然後以虔誠的心開始舉行慰靈祭吧。那麼，準備好了嗎？<br><a action=\"bypass -h Quest 193_SevenSignDyingMessage 9\">是的，準備好了</a></body></html>"
# 32569-08.htm
cain_08 = "<html><body>神官 凱因：<br>真奇怪...你也看到了嗎？<br>當我把遺物獻到祭壇時。往祭壇上方直衝的充滿邪惡的黑色火焰...<br>自從舉行慰靈祭以來，從來沒有發生過這樣的事情！！！<br>真想不透那黑色火焰的意義..如果不是含有死者強烈的心願...那就表示殺人犯的邪惡氣息融進了遺物之中...<br>總之，最好還是得仔細觀察這個項鍊。<br>咦！！！那個怪人是誰？！！<br><a action=\"bypass -h Quest 193_SevenSignDyingMessage cain_09\">環視周圍</a></body></html>"
# 32569-09.htm
cain_09 = "<html><body>神官 凱因：<br>突然冒出來的那個怪人是什麼？<br>要來攻擊我們了！！！事情我們稍後再談！！！<br>當務之急是要處理掉那個怪人！！！</body></html>"
# 32569-10.htm
cain_10 = "<html><body>神官 凱因：<br>竟然會被怪人突襲...從項鍊中散發黑色氣息後，怪人就出現了。<br>可能在這死亡的背後，有個需要查明的訊息..沒錯，好像是有個<font color=\"LEVEL\">死前的訊息</font>。<br>我在想，當我將這項鍊獻上祭壇時，那股具有邪惡氣息且直衝的黑色火焰，好像就與那個來歷不明的怪人有連貫性。<br>我認為這是雅各想要揭發有關自己和<font color=\"LEVEL\">契約官們死亡</font>的真相，所以他那含有堅強意願的項鍊，才會引來那個怪手。<br>而那個怪人就是為了阻止那個真相被揭發，所以才會來搶奪那個項鍊。<br><a action=\"bypass -h Quest 193_SevenSignDyingMessage cain_11\">繼續聽故事</a></body></html>"
# 32569-11.htm
cain_11 = "<html><body>神官 凱因：<br>契約官們的連續死亡事件和那個怪人..以及連那個出現在慰靈祭的不吉利的氣息...<br>而且至今我所調查的結果，和你會被牽扯到這件事情...或許也不能說是個純粹的偶然..<br>不過，你有聽說過關於<font color=\"LEVEL\">七封印</font>的事情嗎？<br>沒錯，就是為了封印石，<font color=\"LEVEL\">黎明和黃昏之間的競爭</font>。<br><a action=\"bypass -h Quest 193_SevenSignDyingMessage cain_12\">我有聽說過</a></body></html>"
# 32569-12.htm
cain_12 = "<html><body>神官 凱因：<br>其實，我是隸屬於黎明的秘密幹員。<br>現在會由我來擔任慰靈祭的神官，也是因為黎明的首腦部認為，最近發生的可疑的連續死亡事件和七封印有連貫性。<br>而且，不枉費這段期間的等待，那個來歷不明的怪人，終於在今天出現了。<br>然後，殺掉那個怪人的你，就是我們黎明這一方非擁有不可的人。<br>怎麼樣...要不要和我們黎明一起合作？總覺得要是就這樣錯過你，我一定會非常後悔的。<br><a action=\"bypass -h Quest 193_SevenSignDyingMessage cain_13\">我想要一起合作</a></body></html>"
# 32569-13.htm
cain_13 = "<html><body>神官 凱因：<br>太好了！！！！你一定是個最佳人選，來揭發連續死亡事件和七封印之間的連貫性。<br>以我這微弱的預知能力也能夠感受到呢。<br>來，那麼去拜訪負責我們黎明軍事的<font color=\"LEVEL\">古斯達夫 亞太法特卿</font>，他在離這裡不遠的<font color=\"LEVEL\">歐瑞城鎮</font>。<br>去找他，並告訴他是由我介紹過來的。<br>有關留在項鍊的死前的訊息和怪人的事情，我會再做點研究，然後另外向亞太法特卿提交調查報告。<br>那麼，趕快去找<font color=\"LEVEL\">古斯達夫 亞太法特卿</font>吧。<br>還有一點！！！那個怪人或許會跟蹤你，所以務必要加緊防備後方！！！！</body></html>"
#
# 採藥師 艾力克
# 32570-01.htm
eric_01 = "<html><body>採藥師 艾力克：<br>有何貴幹？找我這貧窮的採藥師有事嗎？<br>若想要劫財，我看你是白跑一趟。我擁有的，也只不過是這幾根草罷了。<br><a action=\"bypass -h Quest 193_SevenSignDyingMessage eric_02\">我是受神官凱因的委託而來的</a></body></html>"
# 32570-02.htm
eric_02 = "<html><body>採藥師 艾力克：<br>神官凱因？哎呀！！！！糟糕，我竟然忘得一乾二淨。<br>一上年紀啊，事情自然就記不清了...<br>我一心尋找「精靈的含淚草」..竟然把它給忘了。<br>那你就是來領取凱因委託的「死者的藥草」的嗎？<br>來，「死者的藥草」在這裡。趕快拿去交給凱因，然後順便跟他說聲抱歉。</body></html>"
# 32570-03.htm
eric_03 = "<html><body>採藥師 艾力克：<br>上年紀了，隨時都會有記不清事情的時候...<br>你還沒出發啊？<br>趕快將藥草轉交給凱因。</body></html>"
#
# 古斯達夫 亞太法特卿
# 30760-01.htm
athebaldt_01 = "<html><body>古斯達夫 亞太法特卿：<br>你是神官凱因介紹過來的？哦！！原來是你啊。我從凱因那裡已有聽到消息，<br>凱因還說了很多有關你的好話呢。<br>我有很多事情想要聽你說，而且也想說給你聽。<br>但是在那之前，我想先表示謝意，感謝你曾協助神官凱因，幫了我們黎明需要調查的事情。<br>你會接受我們黎明的答謝嗎？<br><a action=\"bypass -h Quest 193_SevenSignDyingMessage athebaldt_02\">我會誠心接受</a></body></html>"
# 30760-02.htm
athebaldt_02 = "<html><body>古斯達夫 亞太法特卿：<br>來，接受我們的答謝吧。<br>那麼，我想你也該累了，放鬆旅途的勞頓後，再來找我吧。<br>有關七封印的事情，我有很多話要對你說。</body></html>"

class Quest (JQuest) :
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [JACOB_NECK, DEADMANS_HERB, SCULPTURE]

	def onAdvEvent(self, event, npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		if event == "30191-02.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.giveItems(JACOB_NECK, 1)
			st.playSound("ItemSound.quest_accept")
		elif event == "cain_05" :
			htmltext = cain_05
			st.set("cond","2")
			st.takeItems(JACOB_NECK,1)
			st.playSound("ItemSound.quest_middle")
		elif event == "eric_02" :
			htmltext = eric_02
			st.set("cond","3")
			st.giveItems(DEADMANS_HERB, 1)
			st.playSound("ItemSound.quest_middle")
		elif event.isdigit() :
			if int(event) == 9 :
				st.takeItems(DEADMANS_HERB,1)
				st.set("cond","4")
				st.playSound("ItemSound.quest_middle")
				player.showQuestMovie(int(event))
				return ""
		elif event == "cain_09" :
			htmltext = cain_09
			npc.broadcastPacket(NpcSay(npc.getObjectId(),0,npc.getNpcId(),"「" + player.getName() + "」！我們得擊倒那個怪人，我會盡全力來幫你的！"))
			monster = self.addSpawn(SHILENSEVIL, 82624, 47422, -3220, 0, False, 60000, True)
			monster.broadcastPacket(NpcSay(monster.getObjectId(),0,monster.getNpcId(),"那個物品的主人不是你們..."))
			monster.setRunning()
			monster.addDamageHate(player,0,999)
			monster.getAI().setIntention(CtrlIntention.AI_INTENTION_ATTACK, st.getPlayer())
		elif event == "cain_13" :
			htmltext = cain_13
			st.set("cond","6")
			st.takeItems(SCULPTURE,1)
			st.playSound("ItemSound.quest_middle")
		elif event == "athebaldt_02" :
			htmltext = athebaldt_02
			st.addExpAndSp(52518015,5817677)
			#st.addExpAndSp(25000000,2500000)  # 嗨翻天 經驗值
			st.unset("cond")
			st.setState(State.COMPLETED)
			st.exitQuest(False)
			st.playSound("ItemSound.quest_finish")
		#  大神官 霍爾林特
		elif event == "hollint_03" :
			htmltext = hollint_03
		#  神官 凱因
		elif event == "cain_01" :
			htmltext = cain_01
		elif event == "cain_02" :
			htmltext = cain_02
		elif event == "cain_03" :
			htmltext = cain_03
		elif event == "cain_04" :
			htmltext = cain_04
		elif event == "cain_05" :
			htmltext = cain_05
		elif event == "cain_06" :
			htmltext = cain_06
		elif event == "cain_07" :
			htmltext = cain_07
		elif event == "cain_08" :
			htmltext = cain_08
		elif event == "cain_09" :
			htmltext = cain_09
		elif event == "cain_10" :
			htmltext = cain_10
		elif event == "cain_11" :
			htmltext = cain_11
		elif event == "cain_12" :
			htmltext = cain_12
		elif event == "cain_13" :
			htmltext = cain_13
		#  採藥師 艾力克
		elif event == "eric_01" :
			htmltext = eric_01
		elif event == "eric_02" :
			htmltext = eric_02
		elif event == "eric_03" :
			htmltext = eric_03
		#  古斯達夫 亞太法特卿
		elif event == "athebaldt_01" :
			htmltext = athebaldt_01
		elif event == "athebaldt_02" :
			htmltext = athebaldt_02
		return htmltext

	def onTalk (self, npc, player) :
		htmltext = Quest.getNoQuestMsg(player)
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			htmltext = Quest.getAlreadyCompletedMsg(player)
		elif id == State.CREATED :
			if npcId == HOLLINT and cond == 0 :
				first = player.getQuestState("192_SevenSignSeriesOfDoubt")
				if first and first.getState() == State.COMPLETED and player.getLevel() >= 79 :
					htmltext = "30191-01.htm"
				else :
					htmltext = "30191-00.htm"
					st.exitQuest(True)
		elif id == State.STARTED :
			if npcId == HOLLINT :
				if cond == 1 :
					htmltext = hollint_03
			elif npcId == CAIN :
				if cond == 1 :
					htmltext = cain_01
				elif cond == 2 :
					htmltext = cain_06
				elif cond == 3 :
					htmltext = cain_07
				elif cond == 4 :
					htmltext = cain_08
				elif cond == 5 :
					htmltext = cain_10
			elif npcId == ERIC :
				if cond == 2 :
					htmltext = eric_01
				elif cond == 3 :
					htmltext = eric_03
			elif npcId == ATHEBALDT :
				if cond == 6:
					htmltext = athebaldt_01
		return htmltext

	def onKill(self, npc, player, isPet) :
		st = player.getQuestState(qn)
		if not st : return
		if npc.getNpcId() == SHILENSEVIL and st.getInt("cond") == 4 :
			npc.broadcastPacket(NpcSay(npc.getObjectId(),0,npc.getNpcId(),"「" + player.getName() + "」！現在我就讓你一步..不過，我一定會抓到你的。"))
			npc.broadcastPacket(NpcSay(32569,0,32569,"很好，「" + player.getName() + "」。很高興能幫得上你。"))
			st.giveItems(SCULPTURE, 1)
			st.set("cond", "5")
			st.playSound("ItemSound.quest_middle")
		return

QUEST	= Quest(193,qn,"七封印，死前的訊息")

QUEST.addStartNpc(HOLLINT)
QUEST.addTalkId(HOLLINT)
QUEST.addTalkId(CAIN)
QUEST.addTalkId(ERIC)
QUEST.addTalkId(ATHEBALDT)
QUEST.addKillId(SHILENSEVIL)