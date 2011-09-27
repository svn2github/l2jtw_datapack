# Created by Bloodshed
# Update by pmq
# High Five 11-2-2011
import sys

from com.l2jserver.gameserver.model.quest           import State
from com.l2jserver.gameserver.model.quest           import QuestState
from com.l2jserver.gameserver.model.quest.jython    import QuestJython as JQuest
from com.l2jserver.gameserver.network.serverpackets import ExStartScenePlayer

qn = "192_SevenSignSeriesOfDoubt"

# NPCs
CROOP        = 30676  # 倉庫管理員老闆 庫羅普
HECTOR       = 30197  # 警衛 黑克
STAN         = 30200  # 警衛 史坦
CORPSE       = 32568  # 可疑的屍體 雅各
HOLLINT      = 30191  # 大神官 霍爾林特
# ITEMS
CROOP_INTRO  = 13813  # 庫羅普的推薦函
JACOB_NECK   = 13814  # 雅各的項鍊
CROOP_LETTER = 13815  # 庫羅普的慰靈祭邀請信函

# 倉庫管理員老闆 庫羅普 對話
# CROOP STARTED npc Html Diskplay NC Window
# 30676-03.htm
croop_03 = "<html><body>倉庫管理員老闆 庫羅普：<br>謝謝你！那麼我就毫不保留的全部說你聽吧。<br>不過，我還真怕有人聽到呢..你就靠過來一點..<br>其實，最近一直都在發生<font color=\"LEVEL\">可疑的連續死亡事件</font>。而那個可疑的連續死亡事件...就是<font color=\"LEVEL\">有個奇怪的怪人專殺矮人契約官們</font>...<br><a action=\"bypass -h Quest 192_SevenSignSeriesOfDoubt 8\">繼續聆聽庳羅普說的話</a></body></html>"
# 30676-04.htm
croop_04 = "<html><body>倉庫管理員老闆 庫羅普：<br>既然你要幫我尋找我的表弟雅各...那我就毫不保留的全部說你聽吧。<br>不過，我還真怕有人聽到呢..你就靠過來一點..<br>其實，最近一直都在發生<font color=\"LEVEL\">可疑的連續死亡事件</font>。而那個可疑的連續死亡事件...就是<font color=\"LEVEL\">有個奇怪的怪人專殺矮人契約官們</font>...<br><a action=\"bypass -h Quest 192_SevenSignSeriesOfDoubt 8\">繼續聆聽庳羅普說的話</a></body></html>"
# 30676-05.htm
croop_05 = "<html><body>倉庫管理員老闆 庫羅普：<br>這不是很奇怪嗎？？竟然會<font color=\"LEVEL\">有個奇怪的怪人專殺矮人契約官們</font>...因此，我也不能就這樣等待身為契約官的表弟雅各，所以到處去打聽了一下。<br>就這樣，我輾轉聽到了傳聞，說最近也有人在這附近目睹了那個怪人。<br>而且，有關那個傳聞，好像此地的<font color=\"LEVEL\">警衛黑克</font>很清楚。你去找他看看吧。他正在此地<font color=\"LEVEL\">歐瑞城鎮的北邊入口</font>看守..<br>他是個警衛，所以若空手去找他的話，他一定會提防你的，我來給你寫張推薦函吧..<br>啊...我只能祈禱，我的表弟雅各沒有處於那令人不敢想像的危險狀況裡。</body></html>"
# 30676-06.htm
croop_06 = "<html><body>倉庫管理員老闆 庫羅普：<br>還沒找到雅各啊...<br>那麼不要在此地耽擱，趕快出發去找我的表弟雅各的下落...<br>只要幫我找到我的表弟雅各，我一定會答謝你的..趕快出發吧....一刻也不能耽誤。</body></html>"
# 30676-07.htm
croop_07 = "<html><body>倉庫管理員老闆 庫羅普：<br>哦！！！是你呀。咦，我的表弟雅各在哪裡呢？我以為你們會一起來的..<br>咦！！你的臉色怎麼會這麼陰暗呢？難道，在雅各身上發生了什麼問題嗎？<br>到底發生了什麼事情，趕快告訴我。<br><a action=\"bypass -h Quest 192_SevenSignSeriesOfDoubt croop_08\">其實...當我發現雅各時，他已死去</a></body></html>"
# 30676-08.htm
croop_08 = "<html><body>倉庫管理員老闆 庫羅普：<br>啊...居然會發生如此悲傷的事情...不可以...<br>雅各竟然會死去...不可能的...那麼善良的傢伙竟然會死去...<br>那麼，雅各的屍體是在哪裡發現的呢？<br><a action=\"bypass -h Quest 192_SevenSignSeriesOfDoubt croop_09\">是在歐瑞城東方附近發現的</a></body></html>"
# 30676-09.htm
croop_09 = "<html><body>倉庫管理員老闆 庫羅普：<br>知道了...那麼我得遲早派人去收回屍體才行...<br>不過，怎麼會發生如此令人悲傷的事情！！！我該怎麼跟家人和親友交代...<br>唉..我這堅強的矮人，竟然會在你面前流淚...<br>雅各他是個特別開朗的傢伙...我一直認為他的前途會是明朗的...<br>莫非..你有帶回能證明那個屍體就是我們雅各的憑證嗎？或許..或許..那個屍體也有可能不是我們雅各的呀！！！<br><a action=\"bypass -h Quest 192_SevenSignSeriesOfDoubt croop_10\">我有帶回看似遺物的物品</a></body></html>"
# 30676-10.htm
croop_10 = "<html><body>倉庫管理員老闆 庫羅普：<br>噢..這確實是雅各的項鍊...這下連我的一絲希望也消失了..<br>這項鍊..其實是在雅各被任命為契約官的那一天，我送他的禮物。<br>還在這背面刻上了J這個字母。<br>總之，雖然是以悲劇收場..但我真不知該如何感謝你為我找到雅各..<br>不過...雖然對你..有點慚愧...但有件事我還想拜託你...你能接受我的要求嗎？<br><a action=\"bypass -h Quest 192_SevenSignSeriesOfDoubt croop_11\">請說說看</a></body></html>"
# 30676-11.htm
croop_11 = "<html><body>倉庫管理員老闆 庫羅普：<br>收回屍體可能需要花很長的時間。因為我得聯絡親人，而且還要派人過去。<br>所以在那之前，我想拜託你為雅各先舉行慰靈祭。<br>在收回屍體之前，如果我不做任何可以安撫那可憐傢伙的靈魂的事情...我會很傷心的...<br>舉行慰靈祭並不是件麻煩的事，<br>只要去找<font color=\"LEVEL\">殷海薩神殿的大神官霍爾林特</font>，向他拜託慰靈祭就可以了。<br>你能為雅各舉行慰靈祭嗎？<br><a action=\"bypass -h Quest 192_SevenSignSeriesOfDoubt croop_12\">好的，我會舉行慰靈祭的</a></body></html>"
# 30676-12.htm
croop_12 = "<html><body>倉庫管理員老闆 庫羅普：<br>真的非常感謝你。你不愧是個具有熱心腸的冒險家啊。我看人的眼光還真是出色。<br>那麼，雅各的項鍊就交給我吧。我會事先派個人轉交給此地<font color=\"LEVEL\">歐瑞城鎮</font>的<font color=\"LEVEL\">殷海薩神殿的大神官 霍爾林特</font>。<br>還有，有關你好心為我尋找雅各的酬勞，以及包括進行慰靈祭的酬勞，我都會轉交給霍爾林特。就算我是個矮人，在表示誠意方面，我也不會虧待像你這樣的冒險家，這你不用擔心。<br>為了找雅各你一定也筋疲力盡了..那麼找個地方解解渴，然後再去找<font color=\"LEVEL\">大神官 霍爾林特</font>吧。<br>那麼，雅各的慰靈祭就好好拜託你了。真是辛苦你了。</body></html>"
# 30676-13.htm
croop_13 = "<html><body>倉庫管理員老闆庫羅普：<br>我剛剛從神官凱因那裡聽到了消息，他說多虧有你的幫助，才能順利完成了我那可憐的表弟雅各的慰靈祭。<br>我那可憐的表弟--雅各的死亡，雖然以悲劇收場，但對於像你這樣的冒險家協助我們的事情，我們依然心存感激。<br>願你的前途充滿祝福。</body></html>"
# 警衛 黑克 對話
# HECTOR STARTED npc Html Diskplay NC Window
# 30197-01.htm
hector_01 = "<html><body>警衛 黑克：<br>陌生人啊..您為何事來找我搭話呢？！<br>我是守護這村莊關口的人...我們不是那種遊手好閒的人隨便就可交談的人。<br>那是其次，您倒是看來滿面都是疑惑。<br>不過，在出示任何一個可以證明自己身份的證據之前，我們不會輕易交出警衛的寶貴情報。<br><a action=\"bypass -h Quest 192_SevenSignSeriesOfDoubt hector_02\">我帶來了庳羅普的推薦函</a></body></html>"
# 30197-02.htm
hector_02 = "<html><body>警衛 黑克：<br>哦！！！這推薦函！！！一看這簽名，的確是我老朋友庫羅普的推薦函。<br>那麼，我把我所知道的告訴您好了。<br>不久前，我從我的警衛朋友那裡聽到了一個奇怪的事情。<br>他在前幾天的夜晚到歐瑞地附近散步，然後他說他看到了至今從未見過的怪人，在他眼前非常迅速的閃了過去。<br>如果雅各的失蹤和那怪人有連貫性的話...那最好還是去找我的朋友問問詳情。<br><a action=\"bypass -h Quest 192_SevenSignSeriesOfDoubt hector_03\">您那朋友是誰呢？</a></body></html>"
# 30197-03.htm
hector_03 = "<html><body>警衛 黑克：<br>那個朋友就是看守這<font color=\"LEVEL\">歐瑞城南邊</font>入口的<font color=\"LEVEL\">警衛史坦</font>。<br>可是，那個朋友說的是不是真的，我也不太確定。雖然他是個警衛，但嘴巴很輕浮..平常也很愛吹牛...所以說，或許他只不過是瞧見了被燈火照耀的狐狸後，吹牛說是看到了怪人也說不定呢。<br>不管怎麼樣，您去找他看看吧。還有，那個推薦函就請您交給我，那傢伙嘴巴很輕浮，就算您不給他推薦函，只要一問到怪人的事情，他就會馬上說漏嘴了。<br>那麼，請您趕快去找<font color=\"LEVEL\">歐瑞城南邊</font>入口的<font color=\"LEVEL\">警衛史坦</font>吧。</body></html>"
# 30197-04.htm
hector_04 = "<html><body>警衛 黑克：<br>我剛才也有說過..我的朋友<font color=\"LEVEL\">警衛史坦</font>在看守<font color=\"LEVEL\">歐瑞城南邊</font>的入口。<br>其他的我也沒辦法再告訴您了。反正我也不是親眼目睹那怪人的人，<br>所以，您就不要再來煩我了。</body></html>"
# 警衛 史坦 對話
# STAN STARTED npc Html Diskplay NC Window
# 30200-01.htm
stan_01 = "<html><body>警衛 史坦：<br>哎呀，嚇死我了！！！怎麼會突然出現在眼前啊！！！我還以為我的心臟要停住了呢。<br>什麼？黑克？是我的朋友黑克介紹我的？<br>黑克他到底是為了什麼事，會把我介紹給你啊？你就別嚇人了，趕快說吧。<br><a action=\"bypass -h Quest 192_SevenSignSeriesOfDoubt stan_02\">聽說在前幾天您目睹了怪人，所以才會來拜訪的</a></body></html>"
# 30200-02.htm
stan_02 = "<html><body>警衛 史坦：<br>怪人？你是怎麼知道的啊？我看啊，一定是黑克說的..<br>反正，也沒什麼不能說的，我就把我看到的全都告訴你吧。其實，我本來就有點小家子氣，<br>但這樣的我，竟然喜歡上了一個人。不過呢，由於我的個性，要向他人表白實在是不簡單。<br>所以，在前幾天的晚上，因為煩惱如何向她表白的事，沒能輕易地入睡。<br>所以想到，若能看到月光下的<font color=\"LEVEL\">歐瑞城</font>，或許會讓我靜下心來，而且也能想得出浪漫的表白方式，於是就到城堡附近散步去了。<br><a action=\"bypass -h Quest 192_SevenSignSeriesOfDoubt stan_03\">請繼續說下去</a></body></html>"
# 30200-03.htm
stan_03 = "<html><body>警衛 史坦：<br>那天晚上，我到了<font color=\"LEVEL\">歐瑞城</font>，正望著那雄壯的城堡。但是，突然在黑暗之中感覺到了詭異的動靜。<br>就在那時，突然在我眼前出現了一個，在我做警衛的這段時間從未見過的怪人，他就在我眼前迅速的閃了過去...<br>當他與我擦肩而過時，從他身上所散發的黑間氣息，讓我感到毛骨悚然。<br>再加上，他的行動不知有多快...我把這件事告訴過黑克，但他卻玩弄我，說我看到的是幻覺呢。但是，我肯定那天晚上看到的絕對不是幻覺。<br><a action=\"bypass -h Quest 192_SevenSignSeriesOfDoubt stan_04\">大概在歐瑞城的什麼地方？</a></body></html>"
# 30200-04.htm
stan_04 = "<html><body>警衛 史坦：<br>是在<font color=\"LEVEL\">歐瑞城東方的周圍</font>。<br>不知道你是為何會問起有關怪人的事情，但若是要前往那個地方的話，你可千萬要小心啊。不知道他會躲在哪裡，很有可能會突然蹦出來的。<br>以我身為警衛這個職業的特性上，我對人和怪物的感覺是很正確的..那個怪人讓我感覺到了近乎極度邪惡的氣息。<br>總之，我所目睹的那個怪人，是在<font color=\"LEVEL\">歐瑞城東方的周圍</font>。<br>那麼，我的話就說到這裡，我得集中精神來維護這個村莊。</body></html>"
# 30200-05.htm
stan_05 = "<html><body>警衛 史坦：<br>還有話要問我嗎？但我可不是那麼悠閒的人喔。<br>我不是說過了嗎？！！那天晚上，我是在<font color=\"LEVEL\">歐瑞城東方的周圍</font>目睹了那個怪人。其他的情報我就不知道了。<br>所以，如果你問完了，那就請你趕快離開我的視線範圍。<br>我是個非常忙碌的人。</body></html>"
# 可疑的屍體 雅各 對話
# CORPSE STARTED npc Html Diskplay NC Window
# 32568-01.htm
corpse_01 = "<html><body>可疑的屍體：<br>調查過屍體，但沒有找到可以代表身分的物品。<br>再次詳細地查看屍體，屍體緊握的右手進入了我的視線。<br>好像是在緊握著某種東西。<br><a action=\"bypass -h Quest 192_SevenSignSeriesOfDoubt corpse_02\">打開緊握的右手</a></body></html>"
# 32568-02.htm
corpse_02 = "<html><body>可疑的屍體：<br>一打開緊握的右手，發現手中有個沾血的項鍊。<br>查看項鍊的背面，發現明顯地刻有雅各這名字的第一個字母J。<br>這好像就是雅各的屍體。<br>從屍體拿起項鍊作為證據。</body></html>"
# 大神官 霍爾林特 對話
# HOLLINT STARTED npc Html Diskplay NC Window
# 30191-01.htm
hollint_01 = "<html><body>大神官 霍爾林特：<br>願殷海薩的祝福與你同在...你來找我有什麼事？<br><a action=\"bypass -h Quest 192_SevenSignSeriesOfDoubt hollint_02\">出示庫羅普的慰靈祭邀請信函</a></body></html>"
# 30191-02.htm
hollint_02 = "<html><body>大神官 霍爾林特：<br>哦！！！我從我的老友--庫羅普剛接到通知。<br>聽說您找到了庫羅普的表弟雅各的屍體啊...年輕的朋友，能力還真是了不起啊。<br>對了，您看看我這個老人家多沒精神。庫羅普交代過我，等您到達之後，首先要我對您表示謝意，就是有關找回表弟雅各和舉行慰靈祭的事情...<br>但是，在那之前還是先給我庫羅普的邀請信函吧。不管什麼事情，清楚一點是最好的。<br><a action=\"bypass -h Quest 192_SevenSignSeriesOfDoubt hollint_03\">轉達慰靈祭邀請信函</a></body></html>"
# 30191-03.htm
hollint_03 = "<html><body>大神官 霍爾林特：<br>來，這裡有庫羅普表示謝意而寄給我的東西。<br>您能為我的老友減輕了很大的擔憂，我也是非常的感激。<br>只不過，舉行慰靈祭需要花很長的時間，所以等你有空的時候再來找我吧。<br>不過，希望您不要來得太晚。</body></html>"

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [CROOP_INTRO, JACOB_NECK, CROOP_LETTER]

	def onAdvEvent (self,event,npc,player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		if event == "croop_03" :
			htmltext = croop_03
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event.isdigit() :
			if int(event) == 8 :
				st.set("cond","2")
				st.playSound("ItemSound.quest_middle")
				player.showQuestMovie(int(event))
				self.startQuestTimer("playertele", 32000, None, player) # 修正動畫後看不到NPC
				return ""
		elif event == "playertele" :
			player.teleToLocation(81654,54848,-1514) # 修正動畫後看不到NPC傳送
			return ""
		elif event == "hector_03" :
			htmltext = hector_03
			st.set("cond","4")
			st.takeItems(CROOP_INTRO,1)
			st.playSound("ItemSound.quest_middle")
		elif event == "stan_04" :
			htmltext = stan_04
			st.set("cond","5")
			st.playSound("ItemSound.quest_middle")
		elif event == "corpse_02" :
			htmltext = corpse_02
			st.set("cond","6")
			st.giveItems(JACOB_NECK,1)
			st.playSound("ItemSound.quest_middle")
		elif event == "croop_12" :
			htmltext = croop_12
			st.set("cond","7")
			st.takeItems(JACOB_NECK,1)
			st.giveItems(CROOP_LETTER,1)
			st.playSound("ItemSound.quest_middle")
		elif event == "hollint_03" :
			htmltext = hollint_03
			if player.getLevel() < 79 :
				htmltext = "<html><body>大神官 霍爾林特：<br>等級達到79以上，且正在進行「七封印，可疑的連續死亡事件」任務的角色才有權限查看。</body></html>"
			else :
				st.takeItems(CROOP_LETTER,1)
				st.addExpAndSp(52518015,5817677)
				#st.addExpAndSp(25000000,2500000)  # 嗨翻天 經驗值
				st.unset("cond")
				st.setState(State.COMPLETED)
				st.exitQuest(False)
				st.playSound("ItemSound.quest_finish")
		#  倉庫管理員老闆 庫羅普
		elif event == "croop_04" :
			htmltext = croop_04
		elif event == "croop_05" :
			htmltext = croop_05
		elif event == "croop_06" :
			htmltext = croop_06
		elif event == "croop_07" :
			htmltext = croop_07
		elif event == "croop_08" :
			htmltext = croop_08
		elif event == "croop_09" :
			htmltext = croop_09
		elif event == "croop_10" :
			htmltext = croop_10
		elif event == "croop_11" :
			htmltext = croop_11
		elif event == "croop_12" :
			htmltext = croop_12
		# 警衛 黑克
		elif event == "hector_01" :
			htmltext = hector_01
		elif event == "hector_02" :
			htmltext = hector_02
		elif event == "hector_03" :
			htmltext = hector_03
		elif event == "hector_04" :
			htmltext = hector_04
		# 警衛 史坦
		elif event == "stan_01" :
			htmltext = stan_01
		elif event == "stan_02" :
			htmltext = stan_02
		elif event == "stan_03" :
			htmltext = stan_03
		elif event == "stan_04" :
			htmltext = stan_04
		elif event == "stan_05" :
			htmltext = stan_05
		# 可疑的屍體 雅各
		elif event == "corpse_01" :
			htmltext = corpse_01
		elif event == "corpse_02" :
			htmltext = corpse_02
		# 大神官 霍爾林特
		elif event == "hollint_01" :
			htmltext = hollint_01
		elif event == "hollint_02" :
			htmltext = hollint_02
		elif event == "hollint_03" :
			htmltext = hollint_03
		return htmltext

	def onTalk (self,npc,player) :
		htmltext = Quest.getNoQuestMsg(player) 
		st = player.getQuestState(qn) 
		if not st : return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond")

		if id == State.COMPLETED :
			if npcId == CROOP :
				htmltext = croop_13
		elif id == State.CREATED :
			if npcId == CROOP and cond == 0:
				if player.getLevel() >= 79 :
					htmltext = "30676-01.htm"
				else :
					htmltext = "30676-00.htm"
					st.exitQuest(True)
			elif npcId == CORPSE and cond == 0:
				htmltext = "32568-03.htm"
				st.exitQuest(True)
		elif id == State.STARTED :
			if npcId == CROOP :
				if cond == 1 :
					htmltext = croop_04
				elif cond == 2 :
					htmltext = croop_05
					st.set("cond","3")
					st.playSound("ItemSound.quest_middle")
					st.giveItems(CROOP_INTRO,1)
				elif cond in [3,4,5] :
					htmltext = croop_06
				elif cond == 6 :
					htmltext = croop_07
			elif npcId == HECTOR :
				if cond == 3 :
					htmltext = hector_01
				elif cond in [4,5,6,7] :
					htmltext = hector_04
			elif npcId == STAN :
				if cond == 4 :
					htmltext = stan_01
				elif cond in [5,6,7] :
					htmltext = stan_05
			elif npcId == CORPSE :
				if cond in [1,2,3,4] :
					htmltext = "32568-04.htm"
				elif cond == 5 :
					htmltext = corpse_01
			elif npcId == HOLLINT :
				if cond == 7 :
					htmltext = hollint_01
		return htmltext

QUEST	= Quest(192,qn,"七封印，可疑的連續死亡事件")

QUEST.addStartNpc(CROOP)
QUEST.addStartNpc(CORPSE)

QUEST.addTalkId(CROOP)
QUEST.addTalkId(HECTOR)
QUEST.addTalkId(STAN)
QUEST.addTalkId(CORPSE)
QUEST.addTalkId(HOLLINT)