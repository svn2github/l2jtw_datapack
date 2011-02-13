# 2010-06-26 by Gnacik
# Based on official server Franz
# update by pmq
# High Five 13-02-2011
import sys
import time
from com.l2jserver.gameserver.datatables            import SkillTable
from com.l2jserver.gameserver.model.actor.instance  import L2PcInstance
from com.l2jserver.gameserver.model.quest           import State
from com.l2jserver.gameserver.model.quest           import QuestState
from com.l2jserver.gameserver.model.quest.jython    import QuestJython as JQuest
from com.l2jserver.gameserver.network.serverpackets import ExStartScenePlayer

qn = "194_SevenSignContractOfMammon"

# NPCs
ATHEBALDT = 30760  # 古斯達夫 亞太法特 卿
COLIN     = 32571  # 祕密調查員 革琳
FROG      = 32572  # 青蛙大王
TESS      = 32573  # 泰絲祖母
KUTA      = 32574  # 村民庫達
CLAUDIA   = 31001  # 克勞迪雅 亞太法特

# ITEMS
INTRODUCTION   = 13818  # 亞太法特卿的推薦函
FROG_KING_BEAD = 13820  # 青蛙大王的珠子
CANDY_POUCH    = 13821  # 泰絲奶奶的糖果包
NATIVES_GLOVE  = 13819  # 村民的手套

# 古斯達夫 亞太法特 卿
# 30760-03.htm
athebaldt_03 ="<html><body>古斯達夫 亞太法特卿：<br><font color=\"LEVEL\">七封印</font>通常被叫做<font color=\"LEVEL\">席琳的七封印而</font>而廣為人知。<br>如你所知，就是透過分布在大陸各地的<font color=\"LEVEL\">古代公墓和地下墓穴</font>。<br>對夢想改革的人們，或想要保住既得權力的人們來說，現在這些地方依然用途廣泛。尤其，現在各個血盟還掛上了自己的旗幟，圍繞著<font color=\"LEVEL\">封印石</font>引起了激烈的競爭。<br>可是，這只不過是有關七封印極微的真相而已，隱藏的真相才是深不可測呢。<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon athebaldt_04\">我想知道關於那個真相</a></body></html>"
# 30760-04.htm
athebaldt_04 ="<html><body>古斯達夫 亞太法特卿：<br>如果想要知道關於七封印的真相，就是先了解它的起源。世上發生的所有事情，它的開端就會告訴你整件事情的根源。<br>七封印的開始，起源於<font color=\"LEVEL\">艾爾摩亞丁時代的史奈曼皇帝</font>。史奈曼皇帝是個偉大且勇猛的聖君，但他活著的年代是個渾沌橫行的天下。<br>不過，他還是平息了那些渾沌，然後被譽為建立現今亞丁世界和平的人物。而那平穩的治世，就隨著<font color=\"LEVEL\">史奈曼皇帝的即位大典</font>而正式展開了。<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon 10\">繼續聆聽亞太法特卿所說的話</a></body></html>"
# 30760-05.htm
athebaldt_05 ="<html><body>古斯達夫 亞太法特卿：<br>在這個故事中，我們黎明所重視的，就是<font color=\"LEVEL\">與財富的商人們有關的契約書</font>。<br>我們認為最近與財富的商人進行過交易的契約官矮人們，關於他們的死亡事件是和那個契約書有關的。<br>根據調查，殺死契約官的那個謎之殺人魔--怪人..好像就是在尋找這個東西...<br>而我們猜想這個東西，就是<font color=\"LEVEL\">史奈曼皇帝和財富的商人之間的契約書</font>。<br>所以，我們黎明認為必須在那些傢伙們找到那個契約書之前，先要由我們找到才行。<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon athebaldt_06\">我想知道有關契約書的下落</a></body></html>"
# 30760-06.htm
athebaldt_06 ="<html><body>古斯達夫 亞太法特卿：<br>契約書的正本，我們拜託過財富的商人們，因此拿到手了，但它並不是很完整。因為記載著契約書特別條款的契約書末頁不在那裡...<br>矮人們說在很久以前，他們也遭到莫名的襲擊，遺失了那個末頁。但是我們黎明透過鍥而不捨的調查，終於找到了那末頁的下落。那契約書的末頁就在<font color=\"LEVEL\">黎明的祭司團</font>手中。<br>我們認為最近的連續死亡事件，關係到<font color=\"LEVEL\">尋找財富的契約書的黎明的祭司團</font>，這一點就是決定性的證據。<br>怎麼樣..你肯為我們找來史奈曼皇帝和財富的商人的契約書末頁嗎？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon athebaldt_07\">我會去找來契約書..</a></body></html>"
# 30760-07.htm
athebaldt_07 ="<html><body>古斯達夫 亞太法特卿：<br>你的個性真是豪爽啊，真合我意。<br>但是，契約書的末頁的所在之處，是在一個以現在的你絕對無法觸及的地方。<br>所以，為了前往那個地方，你得去接受訓練，而那個訓練並不是如你想像般，與戰鬥力有關。你的戰鬥實力再怎麼出色，還是沒辦法嬴過祭司團的。<br>需要接受更加秘密的訓練才行。因此，我就介紹<font color=\"LEVEL\">黎明的秘密調查員革琳</font>給你。說到秘密調查方面，他可說是一流的。<br>來，這裡有推薦函。帶著這個推薦函去找革琳，他會在<font color=\"LEVEL\">亞丁城鎮南邊入口</font>。</body></html>"
# 30760-08.htm
athebaldt_08 ="<html><body>古斯達夫 亞太法特卿：<br>帶著我給的推薦函，去找<font color=\"LEVEL\">祕密調查員革琳</font>。<br>說到祕密調查這一方面，他可說是一流的。<br>他會在<font color=\"LEVEL\">亞丁城鎮</font>，快點，時間緊迫。沒時間在路上耽擱了。</body></html>"
#
# 祕密調查員 革琳
# 32571-01.htm
colin_01 = "<html><body>祕密調查員 革琳：<br>你是亞太法特卿派遣過來的？原來你就是那個冒險家啊，就是遇見可疑的怪人後，擊倒他的..<br>能夠見到你，真是很高興。那麼，我來正式介紹一下自己吧。我是隸屬於黎明的<font color=\"LEVEL\">秘密調查員革琳</font>。真高興見到你。<br>那麼不必耽擱，我們就直接進入正題，因為我們沒有很多時間了。而且我們也不知道那個怪人何時會再進行攻擊。<br>為了找回<font color=\"LEVEL\">契約書</font>，首先你得潛入黎明的高層祭司們求取神諭的<font color=\"LEVEL\">黎明君主的聖殿</font>。<br>但是以你現在這個打扮，根本就無法靠近那個地方。<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon colin_02\">那我該怎麼做呢？</a></body></html>"
# 32571-02.htm
colin_02 = "<html><body>祕密調查員 革琳：<br>你必須要<font color=\"LEVEL\">變身</font>後潛入那裡。但是這變身呢，只要有變身卷軸的話，任務人都可以變身。<br>所以真正重要的是，<font color=\"LEVEL\">在變身狀態下的應變能力</font>。變身這東西本身就不是很完美，所以在變身狀態下盡可能要發揮最大的應變能力，且動作要迅速。<br>因為，<font color=\"LEVEL\">過了一段時間的話，將會有解除變身的時間限制</font>。<br>所以一到變身狀態的話，必須在<font color=\"LEVEL\">技能</font>視窗好好利用加快移動速度的<font color=\"LEVEL\">奔跑</font>技能。<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon colin_03\">利用技能？</a></body></html>"
# 32571-03.htm
colin_03 = "<html><body>祕密調查員 革琳：<br>哈哈哈！！！沒錯。<br>那麼，現在就來進行一次訓練吧。首先去找<font color=\"LEVEL\">青蛙大王</font>，然後與牠交談並帶給我一個牠的物品。<br>我再說一次，變身不是個完美的東西，一到變身狀態的話，就得在<font color=\"LEVEL\">技能</font>視窗好好利用可以加快移動速度的<font color=\"LEVEL\">奔跑</font>技能，然後發揮應變能力再接近青蛙大王。<br>那麼，準備好了嗎？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon colin_04\">是的，請把我變身為青蛙</a><br><br><font color=\"LEVEL\">（「變身時，在有關移動速度的輔助魔法當中，除了活力輔助魔法之外，將會刪除所有其他的移動速度輔助魔法（包括活動輔助魔法）」）</font></body></html>"
# 32571-04.htm
colin_04 = "<html><body>祕密調查員 革琳：<br>來，已變身完畢，趕快去找<font color=\"LEVEL\">青蛙大王</font>吧。<br>但是，以你現在的變身時間來說，將會在靠近青蛙大王之前就會解除變身的。<br>所以，在<font color=\"LEVEL\">技能</font>視窗好好利用加快移動速度的<font color=\"LEVEL\">青蛙疾走</font>，以最快的速度去找青蛙大王吧。<br>離解除青蛙變身的時間剩下沒多久了。快點，時間緊迫。<br>還有，<font color=\"LEVEL\">在變身狀態下進入水中的話，就會解除變身</font>，所以小心，途中可千萬不要進水裡！</body></html>"
# 32571-05.htm
colin_05 = "<html><body>祕密調查員 革琳：<br>那麼趕快去找青蛙大王，帶回憑證吧。<br>你已經變身為青蛙了，幹嘛還來找我？！！！<br>如果是因為青蛙的變身時間剩下不多，而想要重新變身的話，需要先解除變身後，才能再來變身...知道了嗎？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon colin_06\">請解除青蛙的變身</a></body></html>"
# 32571-06.htm
colin_06 = "<html><body>祕密調查員 革琳：<br>如果想要再次變身為青蛙後，繼續接受訓練的話，隨時都來告訴我一聲。我們的訓練時間並不很多。</body></html>"
# 32571-07.htm
colin_07 = "<html><body>祕密調查員 革琳：<br>趕快接近<font color=\"LEVEL\">青蛙大王</font>後，帶給我青蛙大王的一個物品吧。<br>咦，你到底去哪裡做了些什麼，怎麼青蛙變身這麼快就被解除啦？好吧，需要再次變身嗎？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon colin_08\">是的，請再次為我變身為青商會</a><br><br><font color=\"LEVEL\">（「變身時，在有關移動速度的輔助魔法當中，除了活力輔助魔法之外，將會刪除所有其他的移動速度輔助魔法（包括活動輔助魔法）」）</font></body></html>"
# 32571-08.htm
colin_08 = "<html><body>祕密調查員 革琳：<br>來，我已再次為你變身為青蛙，那麼，趕快去帶回青蛙大王的物品吧。<br>我再說一次，變身並不一定是個完美的東西。尤其是變身為青蛙的時間並不是那麼充裕，你要銘記在心。<br>所以，在<font color=\"LEVEL\">技能</font>視窗好好利用加快移動速度的<font color=\"LEVEL\">青蛙疾走</font>，以最快的速度去找<font color=\"LEVEL\">青蛙大王</font>吧。<br>離解除青蛙的變身時間沒剩多少了。快點，時間緊迫。<br>還有，<font color=\"LEVEL\">在變身狀態下進入水中的話，就會解除變身</font>，所以小心，途中可千萬不要進水裡！</body></html>"
# 32571-09.htm
colin_09 = "<html><body>祕密調查員 革琳：<br>終於回來啦？！！自從你離開以後，花費了那麼久的時間，我還以為出了什麼事呢！<br>那麼，青蛙大王的物品有帶回來嗎？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon colin_10\">是的，帶回來了</a></body></html>"
# 32571-10.htm
colin_10 = "<html><body>祕密調查員 革琳：<br>哦！！！是<font color=\"LEVEL\">青蛙大王的珠子</font>啊。辛苦了。<br>那麼，當你有精神接受下一個二次訓練時，再來找我交談吧。<br>接下來的二次訓練，會比現在要求更進一步的應變能力。<br>還有，不要忘了，我們的訓練時間並不多，所以盡快行動。</body></html>"
# 32571-11.htm
colin_11 = "<html><body>祕密調查員 革琳：<br>透過一次訓練的青蛙變身訓練後，我想你應該察覺到了變身後發揮應變能力來接近對方，是比想像中還要難的。<br>二次訓練是要變身為<font color=\"LEVEL\">小孩</font>，然後在更短的時間內去找小孩的奶奶--<font color=\"LEVEL\">泰絲奶奶</font>後，領取某個憑證回來。<br>這次也一樣，可以變身為小孩的時間是有限制的。<br>所以，在<font color=\"LEVEL\">技能</font>視窗好好利用加快移動速度的<font color=\"LEVEL\">快跑</font>，以最快的速度去找奶奶吧。<br>那麼，準備好要變身了嗎？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon colin_12\">是的，準備好了</a><br><br><font color=\"LEVEL\">（「變身時，在有關移動速度的輔助魔法當中，除了活力輔助魔法之外，將會刪除所有其他的移動速度輔助魔法（包括活動輔助魔法）」）</font></body></html>"
# 32571-12.htm
colin_12 = "<html><body>祕密調查員 革琳：<br>來！！！已經變身為小孩了，那麼趕快向<font color=\"LEVEL\">泰絲奶奶</font>領取憑證回來吧。<br>還剩下一個訓練，我們不能在這裡耽誤時間，趕快動身吧。</body></html>"
# 32571-13.htm
colin_13 = "<html><body>祕密調查員 革琳：<br>那麼趕快去找<font color=\"LEVEL\">泰絲奶奶</font>，帶回憑證吧。<br>你已經變身為小孩了，幹嘛還來找我？！！！<br>如果是因為小孩的變身時間剩下不多，而想要重新變身的話，需要先解除變身後，才能再來變身...知道了嗎？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon colin_14\">請為我解除變身</a></body></html>"
# 32571-14.htm
colin_14 = "<html><body>祕密調查員 革琳：<br>如果想要再次變身為小孩後，繼續接受二次訓練的話，隨時都來告訴我一聲。我們的訓練時間並不是很多。</body></html>"
# 32571-15.htm
colin_15 = "<html><body>祕密調查員 革琳：<br>趕快接近奶奶後，帶給我<font color=\"LEVEL\">泰絲奶奶</font>的一個物品吧。<br>咦，你到底去哪裡做了些什麼，怎麼小孩變身這麼快就被解除啦？好吧，需要再次變身嗎？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon colin_16\">請再次為我變身</a><br><br><font color=\"LEVEL\">（「變身時，在有關移動速度的輔助魔法當中，除了活力輔助魔法之外，將會刪除所有其他的移動速度輔助魔法（包括活動輔助魔法）」）</font></body></html>"
# 32571-16.htm
colin_16 = "<html><body>祕密調查員 革琳：<br>來，我已再次為你變身為小孩，那麼，趕快去帶回<font color=\"LEVEL\">泰絲奶奶</font>的物品吧。<br>我再說一次，變身並不一定是完美的。尤其是維持變身為小孩的時間並不是那麼充裕，你要銘記在心。<br>所以，在<font color=\"LEVEL\">技能</font>視窗好好利用加快移動速度的<font color=\"LEVEL\">快跑</font>，以最快的速度去找奶奶吧。<br>小孩的變身時間沒剩多少了。快點，時間緊迫。<br>還有，<font color=\"LEVEL\">在變身狀態下進入水中的話，就會解除變身</font>，所以小心，途中可千萬不要進水裡！</body></html>"
# 32571-17.htm
colin_17 = "<html><body>祕密調查員 革琳：<br>終於回來啦？！！自從你離開以後，花費了那麼久的時間，我還以為出了什麼事呢！<br>那麼，奶奶的物品有帶回來嗎？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon colin_18\">是的，帶回來了</a></body></html>"
# 32571-18.htm
colin_18 = "<html><body>祕密調查員 革琳：<br>哦！！！是<font color=\"LEVEL\">泰絲奶奶的糖果</font>啊。辛苦了。<br>那麼，當你有精神接受下一個三次訓練時，再來找我交談吧。<br>接下來的三次訓練，會比現在要求更進一步的應變能力。<br>還有，不要忘了，我們的訓練時間並不多，所以盡快行動。</body></html>"
# 32571-19.htm
colin_19 = "<html><body>祕密調查員 革琳：<br>那麼，這次利用高級變身技能後，變身為成人形態看看吧。<br>比起變身為青蛙或小孩，變身為人體變身的時間更加短促。<br>剛才我在等你的時候，剛好有個村民在我面前經過，我聽到他說要到<font color=\"LEVEL\">大圓形競技場</font>進行維修工作。你去接近那個村民後，帶回他的物品吧。<br>這次也一樣，在<font color=\"LEVEL\">技能</font>視窗好好利用加快移動速度的<font color=\"LEVEL\">急速快跑</font>，以最快的速度去找村民吧。準備好了嗎？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon colin_20\">是的，請把我變身為村民</a><br><br><font color=\"LEVEL\">（「變身時，在有關移動速度的輔助魔法當中，除了活力輔助魔法之外，將會刪除所有其他的移動速度輔助魔法（包括活動輔助魔法）」）</font></body></html>"
# 32571-20.htm
colin_20 = "<html><body>祕密調查員 革琳：<br>來！！！已經變身為村民了，那麼趕快向大圓形競技場附近的村民領取憑證回來吧。<br>還有，那個村民名叫<font color=\"LEVEL\">村民庫達</font>。<br>來，趕快上路吧，沒有時間在這裡耽擱了。趕快動身吧。<br>另外，我已強調好幾次了，<font color=\"LEVEL\">在變身狀態下進入水中的話，就會解除變身</font>，所以小心，途中可千萬不要進水裡！</body></html>"
# 32571-21.htm
colin_21 = "<html><body>祕密調查員 革琳：<br>那麼趕快去找<font color=\"LEVEL\">村民庫達</font>，帶回憑證吧。<br>你已經變身為村民了，幹嘛還來找我？！！！<br>如果是因為村民的變身時間剩下不多，而想要重新變身的話，需要先解除變身後，才能再來變身...知道了嗎？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon colin_22\">請解除村民的變身</a></body></html>"
# 32571-22.htm
colin_22 = "<html><body>祕密調查員 革琳：<br>如果想要再次變身為村民後，繼續接受三次訓練的話，隨時都來告訴我一聲。我們的訓練時間並不是很多。<br>而且這是最後一個訓練，所以盡快行動。</body></html>"
# 32571-23.htm
colin_23 = "<html><body>祕密調查員 革琳：<br>那麼，趕快接近<font color=\"LEVEL\">村民庫達</font>，帶回村民的物品吧。<br>咦，你到底去哪裡做了些什麼，怎麼村民變身這麼快就被解除啦？好吧，需要再次變身嗎？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon colin_24\">請再為我變身</a><br><br><font color=\"LEVEL\">（「變身時，在有關移動速度的輔助魔法當中，除了活力輔助魔法之外，將會刪除所有其他的移動速度輔助魔法（包括活動輔助魔法）」）</font></body></html>"
# 32571-24.htm
colin_24 = "<html><body>祕密調查員 革琳：<br>來，我已再次為你變身為村民，那麼，趕快去帶回<font color=\"LEVEL\">村民庫達</font>的物品吧。<br>我再說一次，變身並不一定是完美的。尤其是變身為人體的時間並不是那麼充裕，你要銘記在心。<br>所以，在<font color=\"LEVEL\">技能</font>視窗好好利用加快移動速度的<font color=\"LEVEL\">急速快跑</font>，以最快的速度去找村民吧。<br>村民的變身時間沒剩多少了。快點，時間緊迫。<br>另外，我已強調好幾次了，<font color=\"LEVEL\">在變身狀態下進入水中的話，就會解除變身</font>，所以小心，途中可千萬不要進入水裡！</body></html>"
# 32571-25.htm
colin_25 = "<html><body>祕密調查員 革琳：<br>終於回來啦？！！回來得還真快！！！果然能看得出一、二次訓練的成果。<br>那麼，村民的物品有帶回來嗎？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon colin_26\">是的，帶回來了</a></body></html>"
# 32571-26.htm
colin_26 = "<html><body>祕密調查員 革琳：<br>哦！！！是<font color=\"LEVEL\">村民手套</font>啊。辛苦了。<br>因為你的熱誠，三次訓練全都可以順利完成了。在你為三次訓練離開的那段時間，古斯達夫 亞太法特卿的夫人--<font color=\"LEVEL\">克勞迪雅 亞太法特</font>夫人傳來了消息。<br>她說等你結束訓練後，要我把你送到她那裡去。<br>夫人將會代替她的先生--亞太法特卿，對你至今接受訓練所得的成果支付酬勞，並且會告訴你往後黎明首腦部的計畫。<br>克勞迪雅夫人就在與此地相近的<font color=\"LEVEL\">亞丁城外圍</font>。<br>那麼你就去拜訪夫人，替我向她問好，並且領取酬勞和聽取有關往後計畫的說明吧。這段期間辛苦你了。</body></html>"
# 32571-27.htm
colin_27 = "<html><body>祕密調查員 革琳：<br>趕快到<font color=\"LEVEL\">亞丁城外圍</font>拜訪<font color=\"LEVEL\">克勞迪雅 亞太法特</font>夫人吧。<br>夫人將會代替她的先生--亞太法特卿，對你至今接受訓練所得的成果支付酬勞，並且會告訴你往後黎明首腦部的計畫。<br>克勞迪雅夫人就在與此地相近的<font color=\"LEVEL\">亞丁城外圍</font>。<br>那麼你就去拜訪夫人，替我向她問好，並且領取酬勞和聽取有關往後計畫的說明吧。這段期間辛苦你了。</body></html>"
#
# 青蛙大王
# 32572-00.htm
frog_00 = "<html><body>青蛙大王：<br>是誰在吵醒我啊？！！！哎呀..一個人類傢伙竟然會向我搭起話來了...<br>嘓嘓...還不快滾開..嘓嘓！！！叫你不要來煩我！！！</body></html>"
# 32572-01.htm
frog_01 = "<html><body>青蛙大王：<br>是誰？..喔..原來是你啊..我稍微打盹了一下...<br>你這傢伙！！！怎麼會這麼晚啊？嘓嘓..就因為你不回來。害我等個半死。嘓嘓嘓嘓..<br>我那充滿愛意的情書，你可有幫私轉達給她？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon frog_02\">情..情書？啊..我已順利的轉達過了</a></body></html>"
# 32572-02.htm
frog_02 = "<html><body>青蛙大王：<br>好，你做得很好。嘓嘓嘓嘓...好，那她的反應如何？她有紅著臉表示喜歡嗎？還是，很生氣？<br>趕快告訴我！！！<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon frog_03\">她..她喜歡的很呢..只不過..她說是光用書信，不足以當作愛的憑證..</a></body></html>"
# 32572-03.htm
frog_03 = "<html><body>青蛙大王：<br>什麼？不夠？嘓嘓嘓嘓..唉呀..女人的心啊..果然無法以區區一個情書來打動..嘓嘓嘓嘓...<br>那麼..我該送她什麼好呢？嘓嘓..你說送花好？<br>還是送去美味的蟲兒？嘓嘓嘓嘓...<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon frog_04\">您...您就隨便...</a></body></html>"
# 32572-04.htm
frog_04 = "<html><body>大王 青蛙：<br>什麼！！！你說隨便？哼！！！那可不行。<br>好吧！！！那還是送上我的寶物""1""號-藍色球珠吧。<br>那個球珠是在我小時候，偶然在湖底撿到的東西...嘓嘓嘓嘓...<br>這個球珠色澤很美，應該可以博得她的好感..嘓嘓..<br>來，收下我的球珠！！！然後拿去交給她。還有，也仔細觀察一下，看她是不是很喜歡..嘓嘓...</body></html>"
# 32572-05.htm
frog_05 = "<html><body>青蛙大王：<br>趕快把球珠轉達給她！！嘓嘓嘓嘓..<br>我會在這裡先睡個午覺...嘓嘓...<br></body></html>"
#
# 泰絲祖母
# 32573-00.htm
tess_00 = "<html><body>泰絲奶奶：<br>請問..您有沒有在這附近見到我的孫子們呢？孩子們去釣魚..<br>不知跑去了多遠的地方，我這老人家的眼睛實在不中用。<br>哎呀..我的腰啊..路過時，如果見到我的孫子們，麻煩轉告一下我正在找他們。</body></html>"
# 32573-01.htm
tess_01 = "<html><body>泰絲奶奶：<br>唉喲~嚇死我了。嚇壞老人家可不行喔..不過，你是誰呢...<br>奶奶我老了，眼睛也花了...連你的名字也記不太起來了呢..<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon tess_02\">奶奶，我很難過耶</a></body></html>"
# 32573-02.htm
tess_02 = "<html><body>泰絲奶奶：<br>唉，你這小傢伙...奶奶老了，所以才會記不得...竟然就為這點小究而難過...<br>可是，你怎麼沒跟其他孩子們一起去釣魚呢？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon tess_03\">嗯...因為我想吃點心啊</a></body></html>"
# 32573-03.htm
tess_03 = "<html><body>泰絲奶奶：<br>呼呼呼..你是為了想吃這奶奶做的糖果，所以才回來的吧..給你。收下這泰絲奶奶做的<font color=\"LEVEL\">糖果</font>吧。<br>多帶一點回去分給其他的孩子們...叫他們不要走太遠，早點回來...哎呀..我的腰啊..</body></html>"
# 32573-04.htm
tess_04 = "<html><body>泰絲奶奶：<br>趕快帶著奶奶的糖果，去分給孩子們..<br>還有，叫他們不要走太遠，早點回來...哎呀..我的腰啊..</body></html>"
#
# 村民庫達
# 32574-00.htm
kuta_00 = "<html><body>村民 庫達：<br>你有沒有見到一個在這附近閒逛的年輕村民啊？<br>今天本來說好要一起進行大圓形競技場的維修工程...<br>如果過路的時候，看到一個年輕的村民的話，就幫忙轉告我「庫達」會在大圓形競技場入口等他。拜託你。</body></html>"
# 32574-01.htm
kuta_01 = "<html><body>村民 庫達：<br>喂，你怎麼這麼晚啊！！！這可是我們第一次要合夥做事呢！！！！年輕人竟然會這麼散漫...<br>這是第一次，所以我就饒你一回，從下次開始，動作要快一點。<br>首先，我來個自我介紹，我叫庫達。<br>你就是由我老友--塔努的介紹，今天為了協助維修大圓形競技場而來的吧？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon kuta_02\">什麼？是的，沒錯</a><br></body></html>"
# 32574-02.htm
kuta_02 = "<html><body>村民 庫達：<br>太好了。<br>由於最近事情變多了，一個人還真應付不過來。不過，既然你要從今天起幫我做木工的事情，那真是太感謝你啦。<br>那麼，趕快進入大圓形競技場後動工吧。<br>咦，不過你沒帶手套來嗎？這是個粗糙的工作，很容易傷手的..<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon kuta_03\">我忘記帶來了...</a></body></html>"
# 32574-03.htm
kuta_03 = "<html><body>村民 庫達：<br>哎呀..年輕人把精神丟到哪裡去了？！真沒心...<br>今天就先用我多餘的手套吧。或許尺寸會有點不合，所以明天起就帶你的手套來。<br>那麼，還有沒有什麼忘了帶的啊？<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon kuta_04\">沿路，我好像掉了一個東西</a></body></html>"
# 32574-04.htm
kuta_04 = "<html><body>村民 庫達：<br>你還真嫌麻煩不少啊。遲到還不夠，竟然還會掉東西...<br>遺失的東西又不能不找..那麼快去快回吧。<br>首先，先用我多餘的手套。你該不會逅這個也丟了吧？<br>時間已經不早了，我先進去大圓形競技場，開始進行維修工作。趕快，用跑的。</body></html>"
#
# 克勞迪雅夫人
# 31001-01.htm
claudia_01 = "<html><body>克勞迪雅夫人：<br>喔，是你啊？<br>我從我先生--亞太法特卿那裡已聽到有關你的事情。<br>根據革琳傳來的報告內容，提到你以真誠和熱情完成了訓練。<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon claudia_02\">繼續聽故事</a></body></html>"
# 31001-02.htm
claudia_02 = "<html><body>克勞迪雅夫人：<br>像你這樣既誠實又有能力的人能夠站在我們黎明這一方，真是謝謝你。<br>而且，我想我先生--亞太法特卿應該有跟你說過，我們的目標與計畫已很確定。<br>但是，在那之前我想先付你酬勞，你很優秀地完成了革琳的訓練。<br><a action=\"bypass -h Quest 194_SevenSignContractOfMammon claudia_03\">謝謝</a></body></html>"
# 31001-03.htm
claudia_03 = "<html><body>克勞迪雅夫人：<br>不，辛苦你了...那麼，聽聽我們黎明的下一個計畫後，等到準備好參與的話，再來找我吧。</body></html>"

def transformPlayer(npc, player, transid) :
	if player.isTransformed() == True :
		player.untransform()
		time.sleep(2)
	for effect in player.getAllEffects() :
		if effect.getStackType() == "speed_up":
			effect.exit()
	npc.setTarget(player)
	npc.doCast(SkillTable.getInstance().getInfo(transid,1))
	return

def checkPlayer(player, transid) :
	effect = player.getFirstEffect(transid)
	if effect :
		return True
	return False

class Quest (JQuest) :
	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)
		self.questItemIds = [INTRODUCTION, FROG_KING_BEAD, CANDY_POUCH, NATIVES_GLOVE]

	def onAdvEvent(self, event, npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

		if event == "30760-02.htm" :
			st.set("cond","1")
			st.setState(State.STARTED)
			st.playSound("ItemSound.quest_accept")
		elif event == "athebaldt_07" :
			htmltext = athebaldt_07
			st.set("cond","3")
			st.giveItems(INTRODUCTION, 1)
			st.playSound("ItemSound.quest_middle")
		elif event == "colin_04" :
			htmltext = colin_04
			st.set("cond","4")
			st.takeItems(INTRODUCTION,1)
			transformPlayer(npc, player, 6201)
			st.playSound("ItemSound.quest_middle")
		elif event == "colin_06" :
			htmltext = colin_06
			if player.isTransformed() == True:
				player.untransform()
		elif event == "colin_14" :
			htmltext = colin_14
			if player.isTransformed() == True:
				player.untransform()
		elif event == "colin_22":
			htmltext = colin_22
			if player.isTransformed() == True:
				player.untransform()
		elif event == "colin_08" :
			htmltext = colin_08
			transformPlayer(npc, player, 6201)
		elif event == "frog_04" :
			htmltext = frog_04
			st.set("cond","5")
			st.giveItems(FROG_KING_BEAD,1)
			st.playSound("ItemSound.quest_middle")
		elif event == "colin_10" :
			htmltext = colin_10
			st.set("cond","6")
			st.takeItems(FROG_KING_BEAD,1)
			st.playSound("ItemSound.quest_middle")
		elif event == "colin_12" :
			htmltext = colin_12
			st.set("cond","7")
			transformPlayer(npc, player, 6202)
			st.playSound("ItemSound.quest_middle")
		elif event == "colin_16" :
			htmltext = colin_16
			transformPlayer(npc, player, 6202)
		elif event == "tess_03" :
			htmltext = tess_03
			st.set("cond","8")
			st.giveItems(CANDY_POUCH,1)
			st.playSound("ItemSound.quest_middle")
		elif event == "colin_18" :
			htmltext = colin_18
			st.set("cond","9")
			st.takeItems(CANDY_POUCH,1)
			st.playSound("ItemSound.quest_middle")
		elif event == "colin_20" :
			htmltext = colin_20
			st.set("cond","10")
			transformPlayer(npc, player, 6203)
			st.playSound("ItemSound.quest_middle")
		elif event == "colin_24" :
			htmltext = colin_24
			transformPlayer(npc, player, 6203)
		elif event == "kuta_04" :
			htmltext = kuta_04
			st.set("cond","11")
			st.giveItems(NATIVES_GLOVE,1)
			st.playSound("ItemSound.quest_middle")
		elif event == "colin_26" :
			htmltext = colin_26
			st.set("cond","12")
			st.takeItems(NATIVES_GLOVE,1)
			st.playSound("ItemSound.quest_middle")
		elif event.isdigit() :
			if int(event) == 10 :
				st.set("cond","2")
				st.playSound("ItemSound.quest_middle")
				player.showQuestMovie(int(event))
				return ""
		elif event == "claudia_03" :
			htmltext = claudia_03
			st.addExpAndSp(52518015,5817677)
			#st.addExpAndSp(25000000,2500000)  # 嗨翻天 經驗值
			st.unset("cond")
			st.setState(State.COMPLETED)
			st.exitQuest(False)
			st.playSound("ItemSound.quest_finish")
		# 古斯達夫 亞太法特 卿
		elif event == "athebaldt_03" :
			htmltext = athebaldt_03
		elif event == "athebaldt_04" :
			htmltext = athebaldt_04
		elif event == "athebaldt_05" :
			htmltext = athebaldt_05
		elif event == "athebaldt_06" :
			htmltext = athebaldt_06
		elif event == "athebaldt_07" :
			htmltext = athebaldt_07
		elif event == "athebaldt_08" :
			htmltext = athebaldt_08
		# 祕密調查員 革琳
		elif event == "colin_01" :
			htmltext = colin_01
		elif event == "colin_02" :
			htmltext = colin_02
		elif event == "colin_03" :
			htmltext = colin_03
		elif event == "colin_04" :
			htmltext = colin_04
		elif event == "colin_05" :
			htmltext = colin_05
		elif event == "colin_06" :
			htmltext = colin_06
		elif event == "colin_07" :
			htmltext = colin_07
		elif event == "colin_08" :
			htmltext = colin_08
		elif event == "colin_09" :
			htmltext = colin_09
		elif event == "colin_10" :
			htmltext = colin_10
		elif event == "colin_11" :
			htmltext = colin_11
		elif event == "colin_12" :
			htmltext = colin_12
		elif event == "colin_13" :
			htmltext = colin_13
		elif event == "colin_14" :
			htmltext = colin_14
		elif event == "colin_15" :
			htmltext = colin_15
		elif event == "colin_16" :
			htmltext = colin_16
		elif event == "colin_17" :
			htmltext = colin_17
		elif event == "colin_18" :
			htmltext = colin_18
		elif event == "colin_19" :
			htmltext = colin_19
		elif event == "colin_20" :
			htmltext = colin_20
		elif event == "colin_21" :
			htmltext = colin_21
		elif event == "colin_22" :
			htmltext = colin_22
		elif event == "colin_23" :
			htmltext = colin_23
		elif event == "colin_24" :
			htmltext = colin_24
		elif event == "colin_25" :
			htmltext = colin_25
		elif event == "colin_26" :
			htmltext = colin_26
		elif event == "colin_27" :
			htmltext = colin_27
		# 青蛙大王
		elif event == "frog_00" :
			htmltext = frog_00
		elif event == "frog_01" :
			htmltext = frog_01
		elif event == "frog_02" :
			htmltext = frog_02
		elif event == "frog_03" :
			htmltext = frog_03
		elif event == "frog_04" :
			htmltext = frog_04
		elif event == "frog_05" :
			htmltext = frog_05
		# 泰絲祖母
		elif event == "tess_00" :
			htmltext = tess_00
		elif event == "tess_01" :
			htmltext = tess_01
		elif event == "tess_02" :
			htmltext = tess_02
		elif event == "tess_03" :
			htmltext = tess_03
		elif event == "tess_04" :
			htmltext = tess_04
		# 村民庫達
		elif event == "kuta_00" :
			htmltext = kuta_00
		elif event == "kuta_01" :
			htmltext = kuta_01
		elif event == "kuta_02" :
			htmltext = kuta_02
		elif event == "kuta_03" :
			htmltext = kuta_03
		elif event == "kuta_04" :
			htmltext = kuta_04
		# 克勞迪雅夫人
		elif event == "claudia_01" :
			htmltext = claudia_01
		elif event == "claudia_02" :
			htmltext = claudia_02
		elif event == "claudia_03" :
			htmltext = claudia_03
		return htmltext

	def onTalk (self, npc, player) :
		htmltext = Quest.getNoQuestMsg(player)
		st = player.getQuestState(qn)
		if not st : return htmltext

		npcId = npc.getNpcId()
		cond = st.getInt("cond")
		id = st.getState()

		if st.getState() == State.COMPLETED :
			htmltext = Quest.getAlreadyCompletedMsg(player)
		elif id == State.CREATED :
			# 古斯達夫 亞太法特 卿
			if npcId == ATHEBALDT and cond == 0 :
				second = player.getQuestState("193_SevenSignDyingMessage")
				if second and second.getState() == State.COMPLETED and player.getLevel() >= 79 :
					htmltext = "30760-01.htm"
				else:
					htmltext = "30760-00.htm"
					st.exitQuest(True)
		elif id == State.STARTED :
			# 古斯達夫 亞太法特 卿
			if npcId == ATHEBALDT :
				if cond == 1 :
					htmltext = athebaldt_03
				elif cond == 2 :
					htmltext = athebaldt_05
				elif cond == 3 :
					htmltext = athebaldt_08
			# 祕密調查員 革琳
			elif npcId == COLIN :
				if cond == 3 :
					htmltext = colin_01
				elif cond == 4 :
					if checkPlayer(player, 6201):
						htmltext = colin_05
					else :
						htmltext = colin_07
				elif cond == 5 :
					htmltext = colin_09
				elif cond == 6 :
					htmltext = colin_11
				elif cond == 7 :
					if checkPlayer(player, 6202):
						htmltext = colin_13
					else :
						htmltext = colin_15
				elif cond == 8 :
					htmltext = colin_17
				elif cond == 9 :
					htmltext = colin_19
				elif cond == 10 :
					if checkPlayer(player, 6203):
						htmltext = colin_21
					else :
						htmltext = colin_23
				elif cond == 11 :
					htmltext = colin_25
				elif cond == 12 :
					htmltext = colin_27
			# 青蛙大王
			elif npcId == FROG :
				if cond == 4:
					if checkPlayer(player, 6201):
						htmltext = frog_01
					else :
						htmltext = frog_00
				elif cond == 5:
					if checkPlayer(player, 6201):
						htmltext = frog_05
					else :
						htmltext = ""
			# 泰絲祖母
			elif npcId == TESS :
				if cond in [4,5,6] :
					if checkPlayer(player, 6202):
						htmltext = tess_00
					else :
						htmltext = tess_00
				elif cond == 7:
					if checkPlayer(player, 6202):
						htmltext = tess_01
					else :
						htmltext = tess_00
				elif cond == 8:
					if checkPlayer(player, 6202):
						htmltext = tess_04
					else :
						htmltext = ""
			# 村民庫達
			elif npcId == KUTA :
				if cond in [4,5,6,7,8,9] :
					if checkPlayer(player, 6203):
						htmltext = kuta_00
					else :
						htmltext = kuta_00
				elif cond == 10:
					if checkPlayer(player, 6203):
						htmltext = kuta_01
					else :
						htmltext = kuta_00
			# 克勞迪雅 亞太法特
			elif npcId == CLAUDIA :
				if cond == 12 :
					htmltext = claudia_01
		return htmltext

QUEST	= Quest(194,qn,"七封印，財富的契約書")

QUEST.addStartNpc(ATHEBALDT)
QUEST.addTalkId(ATHEBALDT)
QUEST.addTalkId(COLIN)
QUEST.addTalkId(FROG)
QUEST.addTalkId(TESS)
QUEST.addTalkId(KUTA)
QUEST.addTalkId(CLAUDIA)