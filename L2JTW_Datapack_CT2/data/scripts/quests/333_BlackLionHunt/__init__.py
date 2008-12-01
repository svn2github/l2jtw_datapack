#written by Rolarga
##################################FEEL FREE TO CHANGE IDs, REWARDS, PRICES, NPCs AND DROPDATAS THEY ARE JUST CUSTOM BY ME##################################

qn = "333_BlackLionHunt"

#Technical relatet Items
BLACK_LION_MARK = 1369
ADENA_ID = 57

#Drops & Rewards
CARGO_BOX1,CARGO_BOX2,CARGO_BOX3,CARGO_BOX4 = range(3440,3444)
UNDEAD_ASH,BLOODY_AXE_INSIGNIAS,DELU_FANG,STAKATO_TALONS = range(3848,3852)
SOPHIAS_LETTER1,SOPHIAS_LETTER2,SOPHIAS_LETTER3,SOPHIAS_LETTER4,LIONS_CLAW,LIONS_EYE,GUILD_COIN = range(3671,3678)
ALACRITY_POTION = 735
SCROLL_ESCAPE = 736
SOULSHOT_D = 1463
SPIRITSHOT_D = 2510
HEALING_POTION=1061
#Box rewards
GLUDIO_APPLE,CORN_MEAL,WOLF_PELTS,MONNSTONE,GLUDIO_WEETS_FLOWER,SPIDERSILK_ROPE,ALEXANDRIT,              \
SILVER_TEA,GOLEM_PART,FIRE_EMERALD,SILK_FROCK,PORCELAN_URN,IMPERIAL_DIAMOND,STATUE_SHILIEN_HEAD,         \
STATUE_SHILIEN_TORSO,STATUE_SHILIEN_ARM,STATUE_SHILIEN_LEG,COMPLETE_STATUE,FRAGMENT_ANCIENT_TABLE1,      \
FRAGMENT_ANCIENT_TABLE2,FRAGMENT_ANCIENT_TABLE3,FRAGMENT_ANCIENT_TABLE4,COMPLETE_TABLET = range(3444,3467)

#Price to Open a Box
OPEN_BOX_PRICE=650


#Lists
#List of all NPCs this Quest: Sophya,Redfoot,Rupio,Undinas(Shilien Temple),Lockirin(Dwarfen Village)
NPC=[30735,30736,30471,30130,30531,30737]
#List for some Item Groups
statue_list=[STATUE_SHILIEN_HEAD,STATUE_SHILIEN_TORSO,STATUE_SHILIEN_ARM,STATUE_SHILIEN_LEG]
tablet_list=[FRAGMENT_ANCIENT_TABLE1,FRAGMENT_ANCIENT_TABLE2,FRAGMENT_ANCIENT_TABLE3,FRAGMENT_ANCIENT_TABLE4]

#This Handels the Drop Datas npcId:[part,allowToDrop,ChanceForPartItem,ChanceForBox,PartItem]
#--Part, the Quest has 4 Parts 1=Execution Ground, 2=Partisan Hideaway 3=Near Giran Town, Delu Lizzards 4=Cruma Tower Area.
#--AllowToDrop --> if you will that the mob can drop, set allowToDrop==1. This is because not all mobs are really like official.
#--ChanceForPartItem --> set the dropchance for Ash in % for the mob with the npcId in same Line.
#--ChanceForBox --> set the dropchance for Boxes in % to the mob with the npcId in same Line. 
#--PartItem --> this defines wich Item should this Mob drop, because 4 Parts.. 4 Different Items.
DROPLIST={
#Execturion Ground - Part 1
20160:[1,1,67,29,UNDEAD_ASH],      #Neer Crawler
20171:[1,1,76,31,UNDEAD_ASH],      #Specter
20197:[1,1,89,25,UNDEAD_ASH],      #Sorrow Maiden
20200:[1,1,60,28,UNDEAD_ASH],      #Strain  
20201:[1,1,70,29,UNDEAD_ASH],      #Ghoul
20202:[1,0,60,24,UNDEAD_ASH],      #Dead Seeker (not official Monster for this Quest)
20198:[1,1,60,35,UNDEAD_ASH],      #Neer Ghoul Berserker
#Partisan Hideaway - Part 2
20207:[2,1,69,29,BLOODY_AXE_INSIGNIAS],  #Ol Mahum Guerilla
20208:[2,1,67,32,BLOODY_AXE_INSIGNIAS],  #Ol Mahum Raider
20209:[2,1,62,33,BLOODY_AXE_INSIGNIAS],  #Ol Mahum Marksman
20210:[2,1,78,23,BLOODY_AXE_INSIGNIAS],  #Ol Mahum Sergeant
20211:[2,1,71,22,BLOODY_AXE_INSIGNIAS],  #Ol Mahum Captain
#Delu Lizzardmans near Giran - Part 3
20251:[3,1,70,30,DELU_FANG],        #Delu Lizardman
20252:[3,1,67,28,DELU_FANG],        #Delu Lizardman Scout
20253:[3,1,65,26,DELU_FANG],        #Delu Lizardman Warrior
20781:[3,0,69,31,DELU_FANG],        #Delu Lizardman Shaman (not official Monster for this Quest)
#Cruma Area - Part 4
20157:[4,1,66,32,STAKATO_TALONS],    #Marsh Stakato
20230:[4,1,68,26,STAKATO_TALONS],    #Marsh Stakato Worker
20232:[4,1,67,28,STAKATO_TALONS],    #Marsh Stakato Soldier
20234:[4,1,69,32,STAKATO_TALONS]    #Marsh Stakato Drone
}

######################################## DO NOT MODIFY BELOW THIS LINE ####################################################################################

#Messages
#technical relatet messages
html        = "<html><body>"
htmlend        = "</body></html>"
back        = "<a action=\"bypass -h Quest 333_BlackLionHunt f_more_help\">返回</a>"
#Sophya
sophia        = "傭兵隊長索比亞:<br>"
#-Item information
p_redfoot      = html+sophia+"雷德普...我個人對他沒有什麼好感，但如果沒有這個人就覺得非常可惜。他的職責是傳達軍用品的負責人，但也是處理難脫手的戰利品的贓物之父。而且還是我們傭兵團的情報員。他收集很多有用的情報，有時你也可以去問問。<br><a action=\"bypass -h Quest 333_BlackLionHunt p_trader_info\">詢問關於商人公會的事宜</a><br><a action=\"bypass -h Quest 333_BlackLionHunt continue\">繼續執行任務</a><br><a action=\"bypass -h Quest 333_BlackLionHunt leave\">結束執行中的任務</a>"+htmlend
p_no_items      = html+sophia+"黑獅兄弟啊，你不應該是在這個村莊而是要在魔物們橫行霸的戰場吧！<br><a action=\"bypass -h Quest 333_BlackLionHunt continue\">繼續執行任務</a><br><a action=\"bypass -h Quest 333_BlackLionHunt leave\">結束執行中的任務</a>"+htmlend
p_trader_info    = html+sophia+"這箱子的確是亞丁商業同盟的貨物。看印在箱子上的印章就可以知道。如果想把貨箱還給他們，就去見見魔法雜貨商店的公會會員摩根。他是為亞丁商業如盟做事的人。 <br><a action=\"bypass -h Quest 333_BlackLionHunt p_redfoot\">詢問關於雷德普的事宜</a><br><a action=\"bypass -h Quest 333_BlackLionHunt continue\">繼續執行任務</a><br><a action=\"bypass -h Quest 333_BlackLionHunt leave\">結束執行中任務</a>"+htmlend
p_both_info      = html+sophia+"兄弟，為了完成任務，辛苦你了。我會根據你帶回來的憑證數量支付報酬。<br>不過，這箱子是...？看來是找回了商人公會的<font color=\"LEVEL\">貨物箱子</font>。我們的契約上沒有關於找回貨物箱子的內容，所以沒有義務把箱子還給商人們。但是如果還給商人公會，也許會有報酬之類的吧？<br>假如不想幫商人們，那就去見見雷德普吧。他是專門處理難脫手的戰利品的專家。<br><a action=\"bypass -h Quest 333_BlackLionHunt p_redfoot\">詢問關於雷德普的事宜 </a><br><a action=\"bypass -h Quest 333_BlackLionHunt p_trader_info\">詢問關於商人公會的事宜</a><br> <a action=\"bypass -h Quest 333_BlackLionHunt continue\">繼續執行任務</a><br><a action=\"bypass -h Quest 333_BlackLionHunt leave\">結束執行中的任務</a>"+htmlend
p_only_item_info  = html+sophia+"兄弟，為了完成任務，辛苦你了。我會根據你帶回來的憑證數量支付報酬。<br><a action=\"bypass -h Quest 333_BlackLionHunt continue\">繼續執行任務</a><br><a action=\"bypass -h Quest 333_BlackLionHunt leave\">結束執行中的任務</a>"+htmlend
p_leave_mission    = html+sophia+"這段時間辛苦你了。就算是獅子也需要休息。在村莊休息，補充能量吧。身為傭兵，管好自己的體力是基本要求。<br><a action=\"bypass -h Quest 333_BlackLionHunt start_chose_parts\">說想要執行新任務</a><br><a action=\"bypass -h Quest 333_BlackLionHunt r_exit\">退出傭兵團</a>"+htmlend
p_only_box_info    = html+sophia+"兄弟，為了完成任務，辛苦你了。我會根據你帶回來的憑證數量支付報酬。<br><a action=\"bypass -h Quest 333_BlackLionHunt continue\">繼續執行任務</a><br><a action=\"bypass -h Quest 333_BlackLionHunt leave\">結束執行中的任務</a>"+htmlend
p_first_eye      = html+sophia+"Wait a moment.  I present to you the <font color=\"LEVEL\">mark of the lions eye</font>. This is an award to recognize your distinguished services that you have demonstrated on the battlefield.  And new supplies have been issued for you.   Since they are expendable goods that will be useful in combat, store and guard them well!  Now, I expect you to continue to make great achievements."+htmlend
p_eye        = html+sophia+"Wait a moment.  I present to you the <font color=\"LEVEL\">mark of the lions eye</font>. This is an award to recognize your distinguished services that you have demonstrated on the battlefield.  And new supplies have been issued for you.   Since they are expendable goods that will be useful in combat, store and guard them well!  Now, I expect you to continue to make great achievements."+htmlend
#-exit messages
r_exit        = html+sophia+"你說想要退出黑獅傭兵團？當然每個人都有自己的想法，我也不會多問理由...但是有一點你要明白...像你這樣流著好戰之血的人，傭兵團是唯一的選擇。就算你去了其它地方，最終也一定會回到戰場。<br>總之，如果你一定要離開傭兵團，就要知道這件事。只要你一退出的話，就不再是黑獅的傭兵了，因此不僅要歸還黑獅的標誌，而且也不能再使用你在這段期間以黑獅的傭兵身分所利用的所有優惠。比如說像收集了貨物箱子、席琳雕像、古代黏土版碎片等後所得到的報酬之類的優惠，是不能再使用的。若想再使用這些優惠的話，得重新領取黑獅的標誌，所以再慎重考慮看看吧。<br>啊，還有根據你這段期間的成績，退休金還是會照付給你的。<br><a action=\"bypass -h Quest 333_BlackLionHunt continue\">繼續為傭兵團做事</a><br><a action=\"bypass -h Quest 333_BlackLionHunt exit\">確定退出傭兵團</a>"+htmlend
exit        = html+sophia+"如果你的意志這麼堅決，我也就不挽留你了。那麼把黑獅的標誌交出來吧。可惜我們之間的戰友關係也到此為止了。啊，離開之前請把這個收下。這是你在傭兵團立下功績的報酬。就當作是今後開始新生活的本錢吧。那麼，希望下次再並肩作戰，再見。"+htmlend
#-Start
start_error1    = html+sophia+"之前也說過，我們目前的任務是把這周邊的魔物消滅掉。但是目前傭兵團的主力被派遣到古魯丁，所以兵力方面非常不足。頂多也只能防止魔物們襲擊村莊而已。如果現在有一些謄大好戰的傢伙們，真想馬上雇用他們來補充兵力...！<br>(只有等級25以上並得到「黑獅的標誌」的角色才可以執行的任務。)"+htmlend
start_error2    = html+sophia+"之前也說過，我們目前的任務是把這周邊的魔物消滅掉。但是目前傭兵團的主力被派遣到古魯丁，所以兵力方面非常不足。頂多也只能防止魔物們襲擊村莊而已。如果現在有一些謄大好戰的傢伙們，真想馬上雇用他們來補充兵力...！<br>看來你好像有很多與魔物們戰鬥的經驗。以你這般程度的技倆，足以成為我們傭兵團的一員...但規則上，如果想成為傭兵團的一員，就必須要通過某種試糸。如果有興趣，就去見一下<font color=\"LEVEL\">古魯丁村莊的雷歐波爾德</font>隊長。得到他的認同並帶回黑獅的標誌，我們就會視你為兄弟並給你和我們共同戰鬥的機會。<br>(只有等級25以上並得到「黑獅的標誌」的角色才可以執行的任務。)"+htmlend
start_start      = html+sophia+"黑獅傭兵團兄弟們，目前我們的狀況是如此。如眾所皆知，我們的任務是把這周邊的魔物消滅掉。但是因為傭兵團主力部隊被派遣到古魯丁，所以掃蕩魔物實際上不可能了。頂多是能防止魔物們襲擊村莊而已。 <br>幸好古魯丁的雷歐波爾德隊長派來了鄗選拔的傭兵團兄弟，所以應該馬上可以向魔物們的基地發動攻擊了。兄弟啊，希望你也參加這次戰爭。<br><a action=\"bypass -h Quest 333_BlackLionHunt start\">答應參加戰爭</a>"+htmlend
start_explain    = html+sophia+"很好！沉浸了一段時間的黑獅們，將要張牙舞爪的重新開始尋找獵物了！<br>現在開始說明一下戰況。目前我們要攻略的地點有4處，就是刑場、帕提森根據地、南部海岸地區、還有克魯瑪沼澤地。目前我們還沒有和魔物們全面交鋒的實力，所以我們要往各地派遣以少數兵力構成的敢死隊，用游擊戰的方式消滅魔物們。<br><a action=\"bypass -h Quest 333_BlackLionHunt start_parts\">聽取各地區的戰鬥任務</a>"+htmlend
start_parts      = html+sophia+"想要知道哪項任務？<br><br><a action=\"bypass -h Quest 333_BlackLionHunt p1_explanation\">掃蕩在刑場上的不死生物</a><br><a action=\"bypass -h Quest 333_BlackLionHunt p2_explanation\">掃蕩在帕提森根據地上的豺狼</a><br><a action=\"bypass -h Quest 333_BlackLionHunt p3_explanation\">掃蕩在南部海邊地區的德魯蜥蝪人</a><br><a action=\"bypass -h Quest 333_BlackLionHunt p4_explanation\">掃蕩在克魯瑪沼澤地的沼澤司塔卡拓</a>"+htmlend
start_ask_again    = html+sophia+"黑獅兄弟啊，和魔物們的交戰已經開始了！在這次戰鬥中，你也應該表現一下吧？<br><a action=\"bypass -h Quest 333_BlackLionHunt start_parts\">聽取任務說明</a>"+htmlend
start_continue    = html+sophia+"趕緊到戰場消滅敵人，品嘗一下勝利的快感吧！"+htmlend
#-Part 1
p1_explanation    = html+sophia+"村莊東邊的刑場是冤魂悲叫聲不停的陰森之地。任務就是掃蕩那裡的不死生物們。據說是在農民軍叛亂時期，冤死的人們為了報復而復生的不死生物...雖然，我們只管完成自己的任務就可以了，但感覺還是有點毛毛的。 <br><a action=\"bypass -h Quest 333_BlackLionHunt p1_t\">接收任務</a><br><a action=\"bypass -h Quest 333_BlackLionHunt start_chose_parts\">聽取其它的任務說明</a>"+htmlend
p1_take        = html+sophia+"要消滅的不死生物有<font color=\"LEVEL\">幽靈鐮刀、幽魂、尼勒鋼爪、尼勒鋼爪弗雷克、倦靈、還有食屍鬼</font>。不知你曉不曉得，不死生物被消滅時會化成一把灰，把那些灰當作是勝利之憑證帶回來。將會根據所帶回來的<font color=\"LEVEL\">不死生物的灰</font>支付報酬。你曾在雷歐波爾德隊長手下做過事，對於憑證和報酬的規定應該已經清楚了吧？  <br> 那麼趕緊做好戰鬥準備，向刑場出發吧。一定要向所有人證明，即使是煉獄之中復生的亡靈，也不是我們黑獅傭兵團的對手！"+htmlend
#-Part 2
p2_explanation    = html+sophia+"任務就是掃蕩駐紮在西北邊馬蹄谷的格勒西亞軍隊。不能想成是單純殘存者的烏合之眾。對方是惡名昭彰的血腥君主奴爾卡帶領的血腥之斧部殮的豺狼。牠們絕對不是那麼容易對付的。<br><a action=\"bypass -h Quest 333_BlackLionHunt p2_t\">接收任務</a> <br> <a action=\"bypass -h Quest 333_BlackLionHunt start_chose_parts\">聽取其它的任務說明</a>"+htmlend
p2_take        = html+sophia+"你要消滅的敵人有<font color=\"LEVEL\">豺狼游擊隊、豺狼突擊兵、豺狼狙擊兵、豺狼副隊長，還有豺狼隊長</font>。<br>作為消滅敵人的憑證帶回游擊隊的標誌，<font color=\"LEVEL\">血腥之斧徽章</font>。將會根據帶回來的憑證數量支付報酬。你曾在雷歐波爾德隊長手下做過事，對於憑證和報酬的規定應該已經清楚了吧？<br>那麼趕緊向帕提森根據地出發吧。讓那些無法無天的豺狼，瞧瞧我們黑獅傭兵團的憤怒！"+htmlend
#-Part 3
p3_explanation    = html+sophia+"德魯蜥蝪人的基地原來是在奇岩南部的海邊。但是最近有很多侵入狄恩領地。雖然還不知道牠們只是為了討取食物，還是為了進行大規模的進攻準備，但可以確定的是牠們確實是因為某個目的而在行動。我們的任務就是，打垮牠們的每個部隊，讓他們具有恐懼感，並且不讓他們在這附近駐紮下來。<br><a action=\"bypass -h Quest 333_BlackLionHunt p3_t\">接收任務</a> <br> <a action=\"bypass -h Quest 333_BlackLionHunt start_chose_parts\">聽取其它的任務說明</a>"+htmlend
p3_take        = html+sophia+"你要消滅的傢伙有<font color=\"LEVEL\">德魯蜥蝪人、德魯蜥蝪人巡守、還有德魯蜥蝪人戰士</font>。作為消滅敵人的證券帶回<font color=\"LEVEL\">德魯蜥蝪人的牙</font>。但是要小心。牠們比古魯丁的菲林族或朗克族蜥蝪人更加兇猛好戰。<br>將會根據帶回來的憑證數量支付報酬。你曾在雷歐波爾德隊長手下做過事，對於憑證和報酬的規定應該已經清楚了吧？ <br>那麼，現在就向戰場出發吧。去徹底消滅那些不知天高地厚的蜥蝪人！"+htmlend
#-Part 4
p4_explanation    = html+sophia+"任務就是對付在克魯瑪沼澤地叫作「司塔卡拓」的奇怪的魔物。你有見過司塔卡拓嗎？牠們是長得像昆蟲一樣，是使人感到厭惡的種族。牠們的身體包裹在堅硬的甲殼裹，而手炎尖長著鋒利的爪子。而且動作非常地快。是不能小看的傢伙。 <br>再加上沼澤地有巨大水蛭或蜘蛛，還有很多徘徊在巨人之塔周邊的魔物們，是個很難執行任務的危險地帶。<br><a action=\"bypass -h Quest 333_BlackLionHunt p4_t\">接收任務</a><br><a action=\"bypass -h Quest 333_BlackLionHunt start_chose_parts\">聽取其它的任務說明</a>"+htmlend
p4_take        = html+sophia+"你要對付的敵人有<font color=\"LEVEL\">沼澤司塔卡拓、沼澤司塔卡拓工人、沼澤司塔卡拓士兵、還有雄性沼澤司塔卡拓</font>。作為勝利的憑證帶回司塔卡拓的爪。就如以往的規定，會根據你帶回來的憑證數量支付報酬。 <br>那麼趕緊做好戰鬥準備，向克魯瑪沼澤地出發吧。藉此機會讓司塔卡拓們知道我們黑獅傭兵團的厲害！"+htmlend
#Redfoot
redfoot        = "傭兵雷德普:<br>"
f_no_box      = html+redfoot+"喂！兄弟！你說現在正在執行任務是吧？辛苦你了！有什麼要我幫忙的事情嗎？<br><a action=\"bypass -h Quest 333_BlackLionHunt f_info\">詢問是否有可用的資訊</a>"+htmlend
f_give_box      = html+redfoot+"喂！兄弟！你說現在正在執行任務是吧？辛苦你了！有什麼要我幫忙的事情嗎？<br>箱子...？哦，原來是商人們的貨物箱子啊。拿到我這裡來是表示...你沒有想把箱子還給商人們的意思是吧？好，那我來幫你開這箱子。當然箱子裡面的東西全部歸你。但我要收取一點兒!酬勞。<font color=\"LEVEL\">650金幣</font>就差不多了。就當作是打開箱子的報酬，還有加上守住秘密的報酬。<br><a action=\"bypass -h Quest 333_BlackLionHunt f_give\">請求打開箱子</a><br>"+back+htmlend
f_rnd_list      = ["前幾天問過從古魯丁村莊回來的貿易商人，他們說最近那邊氣氛相當凶險。聽說豺狼殘存者虎視眈眈等著侵略村莊的機會，而且北邊土瑞克獸人常常肆行掠奪...<br>聽說古魯丁村莊警衛艾爾瓦哈，正在心焦地找著有本事的傭兵...<br>",
             "看過叫做回聲水晶的東西嗎？是可存放音樂的神奇的寶石。聽說叫做音樂巨匠的矮人負責製作那個回聲水晶。聽說在這狄恩城鎮也有一個...<br>不過要製作回聲水晶的話，就需要特別的樂譜。像樂譜這類的東西，見到音樂家就能得到吧？就是像巴爾巴杜或娜娜林這樣的人啊...<br>",
             "這個村莊有一名夢想成為王國最高級廚師的年輕人。他叫約拿斯，最近嚷著要參加烹飪大賽，正在準備當中呢。聽說他正在尋找能夠為他收集珍貴烹飪材料的冒險家...<br>",
             "聽過有關傲慢之塔的傳說嗎？有關睡在塔頂樓的皇帝巴溫的事呢？<br>你也知道，因此諸神封印了巴溫，所以誰也不能進去塔頂樓。但是根據最近聽到的傳聞，有人知道了如何進去那房間的方法。聽說是亞丁城鎮的黑暗精靈教師...<br>",
             "你打算去因納得立地區嗎？那我就告訴你幾個對傭兵有幫助的情報吧！<br>如果去水上都市海音斯，去見商人伊培倫或警衛苟斯塔！。應該能得到還算不錯的任務。對了，還有聽說有個名叫桃樂絲的鎖匠姑娘也正在找傭兵。<br>",
             "如果你是想擴張血盟勢力的君主，我會給你一個你會感興趣的資訊。各地血盟們的背後都有支援他們的貴族。就是奇岩城鎮的克里斯托洛德瑪依卿、還有歐瑞城鎮的古斯達夫亞太法特卿。當然，那些人也不是慈善機構的人，幫助血盟應該會有所要求吧？<br>",
             "這是不久前和黑暗精靈公會的人們聊天的時候聽到的消息...聽說黑暗精靈供奉席琳女神？什麼？大家都知道啊？我可是第一次聽說...<br>竟然崇死亡女神...我是真的很難理解。但是從去過黑暗精靈森林的人們那裡聽說，黑暗精靈們建造的席琳神殿確實是非常雄壯。聽說住在神殿裡的深淵祭司們正收集在各地發現的席琳女神的雕像？<br>",
             "Have you heard about the rumor?  Antharas, the earthdragon who had been sleeping in Dragon Valley has awoken.  This is terrible news  If it comes out of the Lair of Antharas and runs amok, all of Giran region will fall into a state of pandemonium in no time <br>However, there is someone who is recruiting people to form a militia force to catch Antharas.  It is a woman named Gabrielle in Giran Castle Town.  However, does she really think that they will have any chance against the dragon  Unfortunately, I think it is way beyond their power!<br>",
             "In this village, there is a young man who is dreaming of becoming the best chef in the kingdom.  His name is Jonas.  Lately he has been working hard to prepare himself to compete in a culinary competition.   He is looking for an adventurer who can find ingredients to make exotic dishes<br>",
             "In Giran Castle Town, there is a young man whose only aim in life is to take revenge.  Everybody has been telling him that its useless but he is determined to kill the earthdragon Antharas with his own hands.  Every day, he makes special arrows.  Furthermore, if anybody brings him the raw materials he needs to make the arrows, he will pay the person with an ample reward.  If you are interested, why dont you go see him?  His name is  Belton and he works as a guard in Giran Castle Town.<br>",
             "I will give you some information that will be useful to someone who travels a lot like yourself.  According to the law of the land, the traders of this kingdom are not allowed to deal with criminals.  But there are some traders who ignore this rule and sell their items to outlaws.  These people include, Grocer Pano of Floran Village and Twyla who has set up her trade in the western section of the Dark Forest.  Although they are business people, I think its shameless of them to deal with criminals just to make money.<br>",
             "Would you like me to introduce you to a job opportunity?  If you go to the northwestern area of Gludio, there is a farmer whose name is Peter.  He is currently hiring mercenaries to chase out turek orcs that have settled down near his farm  With your ability, you could deal with turek orcs with no problem, right?  <br>By the way, did you know that relics of ancient kingdoms are often found in that area?  While dealing with turek orcs, I heard that some people have discovered precious ancient relics by accident.<br>",
             "Have you heard of the Aden Business Guild?  It is an association of human traders.  Since they saw that dwarven traders and warehouse keepers were generating a lot of profit while engaging in their organizational activities, humans decided to imitate them by forming a guild of their own.  However, it seems to me that the business savvy of a dwarf is inborn  No matter how hard humans try, I dont think they can keep up with dwarves.<br>On top of that, adding insult to injury, evil spirits frequently attack the guilds cargo wagons and steal their valuable goods making the humans suffer great losses.<br>",
             "Some time ago, while I was talking with the members of the Dark Elf Guild, I found out that Dark Elves worship the Goddess Shilen!!   Are you saying that everybody already knows about that?   Well, I heard about it for the first time <br>Why would you want to worship a goddess of death  It doesnt make any sense to me.  But according to those who have been to the Dark Forest, the Temple of Shilen built by the Dark Elves is truly magnificent.  They told me that the Abyssal Celebrants at the temple are gathering fragments of the statue of Goddess Shilen from everywhere!<br>",
             "Have you ever heard of a hatchling?  It is a cute baby dragon that has been hatched from the egg of a wyrm or a drake.  Among pet handlers, I heard that there is someone who knows how to raise a hatchling as ones own pet  I think his name is Cooper or something like that.  If you are interested in keeping a hatchling as a pet, why dont you go see him!<br>",
             "I will give you the information that a clan leader, who wants to grow the power of his clan would be interested in obtaining.  In each area, there are aristocrats who give support to small clans.  These aristocrats would include Sir Kristof Rodemai in Giran Castle Town and Sir Gustaf Athebaldt of Oren Castle Town.  Of course they are not just philanthropists.  I would say they would want something in return for their support of a clan, wouldnt you agree?<br>",
             "Some time ago, I heard a rumor that there is a society of ancient coin collectors.  At first, I thought that they must be collectors of some anniversary coins that are not very valuable.  But later, I found out that the value of the coins they collect is extremely high.  And members of this society are very enthusiastic about their collection activities that whoever brings some rare coins to them, they will trade them for some high priced items!  I heard that in order to join the coin collection society, you have to go see a dwarf called Sorint at the Hunters Village.<br>",
             "I heard that if you go near the Ivory Tower in Oren, you will find a fake alchemist.  It is said that he goes around telling people that he can make some magic potion that will make peoples wishes come true  Many people have fallen victim to his fake potion.  But what is surprising is that once in a blue moon, after using the potion peoples wishes actually did come true.  The problem is that this only happens very very rarely<br>",
             "傭兵雷德普<br>",
             "Have you heard about the rumor?  Antharas, the earthdragon who had been sleeping in Dragon Valley has awoken.  This is terrible news  If it comes out of the Lair of Antharas and runs amok, all of Giran region will fall into a state of pandemonium in no time <br>However, there is someone who is recruiting people to form a militia force to catch Antharas.  It is a woman named Gabrielle in Giran Castle Town.  However, does she really think that they will have any chance against the dragon  Unfortunately, I think it is way beyond their power!<br>",
             ]
f_no_news      = html+redfoot+"對不起，現在還沒有新的資訊。下次再光臨吧。<br>"+back+htmlend
f_more_help      = html+redfoot+"還有事情要我幫忙嗎？<br><a action=\"bypass -h Quest 333_BlackLionHunt f_give\">請求打開箱子</a>"+htmlend
f_no_more_box    = html+redfoot+"這不是存心為難我嗎？沒有貨箱，還要我打開？<br><br><a action=\"bypass -h Quest 333_BlackLionHunt f_info\">詢問是否有可用的資訊</a>"+htmlend
f_more_help2    = html+redfoot+"還有事情要我幫忙嗎？<br><a action=\"bypass -h Quest 333_BlackLionHunt f_give\">請求打開箱子</a><br><a action=\"bypass -h Quest 333_BlackLionHunt f_info\">詢問是否有可用的資訊</a>"+htmlend
f_not_adena      = html+redfoot+"喂！老兄看來你不夠付酬勞啊：準備好650金幣再來吧。<br>"+back+htmlend
#Rupio
rupio        = "鐵匠魯皮奧:<br>"
r_no_items      = html+rupio+"你不是黑獅傭兵嗎？來我們的鐵舖做什麼呢...？是來委託製造武器的嗎？"+htmlend
r_items        = html+rupio+"有什麼事情要我幫忙的嗎？<br><a action=\"bypass -h Quest 333_BlackLionHunt r_give_statue\">要求組合雕像的碎片</a><br><a action=\"bypass -h Quest 333_BlackLionHunt r_give_tablet\">要求組合黏土版的碎片"+htmlend
r_statue_pieces    = html+rupio+"你怎麼知道我的興趣是復原遺物啊？但是如果想把石像恢復成原來的樣子，就不能缺少其中任何一片，你說是不是？比如說想完成女神像不就是要有<font color=\"LEVEL\">頭 身體 臂還有腿</font>)每個部位嗎？"+htmlend
r_statue_brockes  = html+rupio+"OK, shall I demonstrate my talents now? First... Attach the legs to the base... Then the torso above that... And if we match the joints of the arms and head properly... Huh? The statue just crumbled... I knew that it was really old and the material weak but.. When I just applied some pressure to connect... Oh, I'm really sorry."+htmlend
r_statue_complete  = html+rupio+"OK, shall I demonstrate my talents now? First... Attach the legs to the base... Then the torso above that... And if we match the joints of the arms and head properly... OK! It's finished! The joints of the connecting parts are still visible but overall, it looks perfect, don't you think? Hmm... Is it the image of the goddess of Shilen? Looking at it carefully, it's really a beautiful statue."+htmlend
r_tablet_pieces    = html+rupio+"你怎麼知道我的興趣是復原遺物啊？但是像黏土版這樣刻有文字的遺物，只要缺少一部份就無法知道內容，所以組合了也沒什麼用。以我的經驗，像黏土版這種四角形的遺物，通常會碎成<font color=\"LEVEL\">4片</font>..."+htmlend
r_tablet_brockes  = html+rupio+"OK, shall I demonstrate my talents now? Well, this fragment looks like it goes to the very bottom section of the stone tablet... And this piece is above that... Oh! The tablet just crumbled... I should have expected that the material would be really weak from having been exposed to the rain and wind for such a long time... Darn...! I'm really sorry for making such a big mistake."+htmlend
r_tablet_complete  = html+rupio+"OK, shall I demonstrate my talents now? Well, this fragment looks like it goes to the very bottom section of the stone tablet... And this piece is above that... It's like putting together a puzzle... OK... It's finished! It's an ancient stone tablet... I'm really curious whether some secrets of history are recorded on it! Hmm... But these letters look like writing of the titans... I've seen this somewhere before...! Where in the world could...?!"+htmlend
#Lockirin
lockirin      = "元老長拉克琳:<br>"
l_no_tablet      = html+lockirin+"我對巨人文明非常感興趣。尤其是那個以巨人文字記載的黏土版，即使要我付出高價也在所不惜。像你這樣常去旅行的人，可能會看過那種東西。據說，在狄恩地方常常會發現古代黏土版..."+htmlend
l_just_pieces    = html+lockirin+"這個黏土版是...？難道這個是...？雖然只是一部分，但是這是...柝芙的...！<br> 喂，年輕人！這些東西到底是從那裡找到的？如果找到所有的剩餘碎片，組合成完成品，我將會給你大筆!酬金！我以公會聯合元老長的名義，和你約定！"+htmlend
l_tablet      = html+lockirin+"This clay tablet... Where in the world could...?! It's just one part, but... Maphr...!  Where did such a precious thing...? Look at this, young fellow! I'll present to you a big gift of gratitude so please give this tablet to me!<br><a action=\"bypass -h Quest 333_BlackLionHunt l_give\">Hand over clay tablet.</a><br><a action=\"bypass -h Quest 333_BlackLionHunt l_info\">Don't hand over."+htmlend
l_give        = html+lockirin+"I'm really thankful! Finally the deep-rooted work of our guild federation...! Here, take this gift of gratitude! And if you find more of these clay tablets in the future, please bring those to me also! I'll express my thanks adequately!"+htmlend
l_info        = html+lockirin+"Huh...?! I said I'd express my thanks abundantly but you still refuse... Look here, young fellow. Do you really think you can sell that tablet somewhere else at a higher price? I guarantee that no matter how hard you look, you won't find anyone that will give you as much as I will. If your opinion changes, please come to me again. Turn over that tablet to me anytime and I'll give you a big gift of gratitude as I promised!"+htmlend
#Undiras
undiras        = "深淵祭司安德理亞斯:<br>"
u_no_statue      = html+undiras+"整個大陸中供奉席琳女神的寺院僅此一家。因人類歪曲的宗教改革，我們的女神被世人認為是帶來死亡和破壞的不祥的存在，但我們黑暗精靈依然認為席琳是我們的創造者及掌管生死的女神。<br>可惜的是被人類和精靈暟合軍侵領時，遺失了很多裝飾神殿的聖物。特別是製作精緻的席琳女神像大部分都不見了。不管是誰若幫我們找回那些雕像，我們深淵神官們一定給予大大的謝禮..."+htmlend
u_just_pieces    = html+undiras+"這個雕像是？雖然只是一部分...這是遺失的席琳雕像的一部分...！這東西到底是從哪裡找到的？如果找到所有的剩餘碎片，組合成完成品，我將會給你很大的謝禮金！"+htmlend
u_statue      = html+undiras+"Oh this piece must be?  Although its only part of it still this piece came from one of the statues of Shilen that were lost!  Where in the world did you find it?  Where did you find this sacred object?  This statue is a sacred object for us dark elves.  I will pay you a great sum of money if you will hand it over to me.  After all, it is not of much use to you any way,  right?<br><a action=\"bypass -h Quest 333_BlackLionHunt u_give\">Give him the statue of Shilen.</a><br><a action=\"bypass -h Quest 333_BlackLionHunt u_info\">Refuse to give him the statue of Shilen.</a>"+htmlend
u_give        = html+undiras+"Due to the humans distorted religious reformation, our goddess that we worship has been misunderstood to be a sinister being that brings death and destruction.  But we dark elves still worship Shilen as our creator and as a goddess who is in charge of life and death.  Unfortunately, when this place was invaded by the allied forces of humans and elves, many sacred objects which were decorating the temple were lost.  Especially, many statues of the goddess Shilen which were exquisitely crafted were stolen.  The statue you brought here is one of the statues that were lost at that time.  Thank you so much.  Here is the reward money I promised you.  If you find any more statues like this, please bring them to me.  Well,  then may the divine protection of abyss be with you!"+htmlend
u_info        = html+undiras+"That statue is a sacred object for us dark elves.  Anyway, if you keep it for yourself, you wont have much use for it.  Furthermore, if you carry a statue of Shilen with you and walk around among humans, people will accuse you of being a pagan.  You would be lucky if you are not burnt to death at the stake.  Anyway, if you change your mind, please come back and see me.  If you hand over the statue to me, I am willing to pay you a generous sum of reward money.  Well,  then may the divine protection of abyss be with you."+htmlend
#Morgan
morgan        = "公會會員摩根:<br>"
m_no_box      = html+morgan+"你是，黑獅團的傭兵吧？聽說最近為了掃蕩這一帶的魔物，因而非常辛苦啊。日後也拜託你們啦。"+htmlend
m_box        = html+morgan+"你是，黑獅團的傭兵吧？聽說最近為了掃蕩這一帶的魔物，因而非常辛苦啊。日後也拜託你們啦。不過找我有什麼事嗎...？<br><a action=\"bypass -h Quest 333_BlackLionHunt m_give\">交出箱子</a>"+htmlend
m_rnd_1        = html+morgan+"It's a freight box of our commercial guild!? It is freight that was stolen from our carts having been attacked by evil creatures recently. But there is a lot of freight that was looted and so our losses are really big. Still, it is really fortunate that you could recover this part.<br>As a representative of the commercial guild, I thank you for your efforts. Here, take this gift of gratitude, even though it's not much. And I present you with these (<font color=\"LEVEL\">coins from our guild</font>). It's like a plaque of appreciation that we give to people that have contributed to the commercial guild.<br><a action=\"bypass -h Quest 333_BlackLionHunt m_reward\">Go back.</a>"+htmlend
m_rnd_2        = html+morgan+"我們商業同盟的貨箱！？這是不久前被魔物襲擊後，從馬車上被搶走的貨物啊！最近被掠奪的貨物太多，正擔憂會損失慘重呢，現在能找回一部分也算是慶幸啦。<br>我代表商業同盟向你致謝。這裡，雖然不多就當作是我們的謝禮吧。還有這裡，送你一個我們<font color=\"LEVEL\">公會的貨幣</font>這是賦予對商業同盟貢獻者的一種感謝。<br><a action=\"bypass -h Quest 333_BlackLionHunt m_reward\">返回</a>"+htmlend
m_rnd_3        = html+morgan+"I really thank you for recovering so many freight boxes like this for us. If the financial situation of our commercial guild were a bit better, we would hire competent mercenaries such as yourself as bodyguards... In that case, the evil creatures would never be able to loot our stuff, no?<br>OK! Here, take the gift of gratitude! The amount of the gratitude money increased greatly after I spoke to my superiors about the hard work you have been doing for our guild. As this is appropriate acknowledgment for your hard work, please take it without refusing. And, as always, I present you with these <font color=\"LEVEL\">coins from our guild.</font><br><a action=\"bypass -h Quest 333_BlackLionHunt m_reward\">返回</a>"+htmlend
m_no_more_box       = html+morgan+"貨箱...？什麼箱子啊？你好像沒有這種東西啊...？"+htmlend
m_reward      = html+morgan+"有什麼事情要我幫忙的嗎...？<br><a action=\"bypass -h Quest 333_BlackLionHunt m_give\">交出貨箱</a>"+htmlend

import sys
from net.sf.l2j import Config 
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
#This Put all Mob Ids from dictionari in a list. So its possible to add new mobs, to one of this 4 Areas, without modification on the addKill Part.
MOBS=DROPLIST.keys()

def giveRewards(st,item,count):
  st.giveItems(ADENA_ID,35*count)
  st.takeItems(item,count)
  if count < 20:
    return
  if count<50:
    st.giveItems(LIONS_CLAW,1)
  elif count<100:
    st.giveItems(LIONS_CLAW,2)
  else:
    st.giveItems(LIONS_CLAW,3)
  return


class Quest (JQuest) :

  def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

  def onEvent (self,event,st) :
    part = st.getInt("part")
    if event == "start" :
      st.set("cond","1")
      st.setState(State.STARTED)
      st.playSound("ItemSound.quest_accept")
      #just to go with the official, until we have the option to make the take part invisible, like on officials.
      st.takeItems(BLACK_LION_MARK,1)
      st.giveItems(BLACK_LION_MARK,1)
      return start_explain
    elif event == "p1_t":
      st.set("part","1")
      st.giveItems(SOPHIAS_LETTER1,1)
      return p1_take
    elif event == "p2_t":
      st.set("part","2")
      st.giveItems(SOPHIAS_LETTER2,1)
      return p2_take
    elif event == "p3_t":
      st.set("part","3")
      st.giveItems(SOPHIAS_LETTER3,1)
      return p3_take
    elif event == "p4_t":
      st.set("part","4")
      st.giveItems(SOPHIAS_LETTER4,1)
      return p4_take
    elif event == "exit":
      st.takeItems(BLACK_LION_MARK,1)
      st.exitQuest(1)
      return exit
    elif event == "continue":
      claw=int(st.getQuestItemsCount(LIONS_CLAW)/10)
      check_eye=st.getQuestItemsCount(LIONS_EYE)
      if claw :
        st.giveItems(LIONS_EYE,claw)
        eye=st.getQuestItemsCount(LIONS_EYE)
        st.takeItems(LIONS_CLAW,claw*10)
        ala_count=3
        soul_count=100
        soe_count=20
        heal_count=20
        spir_count=50
        if eye > 9:
          ala_count=4
          soul_count=400
          soe_count=30
          heal_count=50
          spir_count=200
        elif eye > 4:
          spir_count=100
          soul_count=200
          heal_count=25
        while claw > 0:
          n = st.getRandom(5)
          if n < 1 :
            st.giveItems(ALACRITY_POTION, int(ala_count*Config.RATE_QUESTS_REWARD))
          elif n < 2 :
            st.giveItems(SOULSHOT_D, int(soul_count*Config.RATE_QUESTS_REWARD))
          elif n < 3:
            st.giveItems(SCROLL_ESCAPE, int(soe_count*Config.RATE_QUESTS_REWARD))
          elif n < 4:
            st.giveItems(SPIRITSHOT_D,int(spir_count*Config.RATE_QUESTS_REWARD))
          elif n == 4:
            st.giveItems(HEALING_POTION,int(heal_count*Config.RATE_QUESTS_REWARD))
          claw-=1
        if check_eye:
          return p_eye
        else:
          return p_first_eye
      else:
        return start_continue
    elif event == "leave":
      if part == 1:
        order = SOPHIAS_LETTER1
      elif part == 2:
        order = SOPHIAS_LETTER2
      elif part == 3:
        order = SOPHIAS_LETTER3
      elif part == 4:
        order = SOPHIAS_LETTER4
      else:
        order = 0
      st.set("part","0")
      if order:
        st.takeItems(order,1)
      return p_leave_mission
    elif event == "f_info":
      text = st.getInt("text")
      if text<4:
        rnd=int(st.getRandom(20))
        st.set("text",str(text+1))
        text_rnd = html+redfoot+f_rnd_list[rnd]+back+htmlend
        return text_rnd
      else:
        return f_no_news
    elif event == "f_give":
      if st.getQuestItemsCount(CARGO_BOX1) :
        if st.getQuestItemsCount(ADENA_ID)>=OPEN_BOX_PRICE:
          st.takeItems(CARGO_BOX1,1)
          st.takeItems(ADENA_ID,650)
          random = st.getRandom(162)
          standart = "好，那就來打開這箱子看一看...開這種鎖，小意思...好！這麼容易就打開了。那麼，看看裡面有什麼東西？<br>"
          statue = "這是...？石像的破片？哦呵...是席琳女神的模樣...怎麼會是死亡女神，覺得有點不吉利？但是如果不是破片而是完成品，就能夠賣得到不錯的價錢...倒是有一位專家是專門修補這種遺物的...他是叫<font color=\"LEVEL\">魯皮奧</font>的鐵匠。如果把石像的破片收集後拿過去，他會給你修補成完成品。<br>" 
          tablet = "這是...？石版的破片？哦呵...沒看過的文字。難道是巨人時代的遺物？如果不是破片，而是完好的物品就可以成為珍貴的資料了。如果能把所有的破片收集到就可以拼成原樣了...假如有興趣，就去找叫<font color=\"LEVEL\">魯皮奧</font>的鐵匠吧。他是復原遺物的專家。<br>"
          if random < 21 :
            st.giveItems(GLUDIO_APPLE,int(Config.RATE_QUESTS_REWARD))
            return html+redfoot+standart+"<br>Fruit?  Oh, they must be apples grown in Gludio!  Mmm they look delicious.  If you take them to the market before they go bad, I guess you will be able to make some money.<br>"+back+htmlend
          elif random < 41:
            st.giveItems(CORN_MEAL,int(Config.RATE_QUESTS_REWARD))
            return html+redfoot+standart+"Isnt this corn meal?  Isnt this used to feed pigs?  Well, anyhow, since its not anything you can use for yourself, you should take it to the market to sell it.<br>"+back+htmlend
          elif random < 61:
            st.giveItems(WOLF_PELTS,int(Config.RATE_QUESTS_REWARD))
            return html+redfoot+standart+"<br>這張皮革是...？惡狼之皮？皮革加工師已經加工過。但不是張很高級的皮革。可能製造皮帽時能用得著吧？反正，拿到市場上應該賣得了一點錢。<br>"+back+htmlend
          elif random < 74:
            st.giveItems(MONNSTONE,int(Config.RATE_QUESTS_REWARD))
            return html+redfoot+standart+"<br>寶石？這是月石！也是叫作月長石的寶石。應該能賣到不錯的價錢。<br>"+back+htmlend
          elif random < 86:
            st.giveItems(GLUDIO_WEETS_FLOWER,int(Config.RATE_QUESTS_REWARD))
            return html+redfoot+standart+"<br>Hmm?  Whats this powder?  Should I taste it?   Yes, this must be Gludio Wheat Flour!  It can be used for baking bread I guess.   Well, anyhow, you should be able to sell it for a decent price at the market.<br>"+back+htmlend
          elif random < 98:
            st.giveItems(SPIDERSILK_ROPE,int(Config.RATE_QUESTS_REWARD))
            return html+redfoot+standart+"這是...？是蜘蛛網的繩索！這是用士伯吟山脈的狼蛛巢中收集的蜘蛛網製造的，堅實輕便的繩索。拿到商店應該會賣到不錯的價錢吧。<br>"+back+htmlend
          elif random < 99:
            st.giveItems(ALEXANDRIT,int(Config.RATE_QUESTS_REWARD))
            return html+redfoot+standart+back+htmlend
          elif random < 109:
            st.giveItems(SILVER_TEA,int(Config.RATE_QUESTS_REWARD))
            return html+redfoot+standart+"Hmm?  A silver bowl?  And a teacup?  They seem to be of pretty high quality!  It seems like they were made by elven artisans.  I am not interested in such exquisite items but, anyway, if you take them to a store, you should be able to sell them for a fairly good price.<br>"+back+htmlend
          elif random < 119:
            st.giveItems(GOLEM_PART,int(Config.RATE_QUESTS_REWARD))
            return html+redfoot+standart+"Hmm?  Machine parts?  This Guild Mark seems to be that of the Black Anvil Guild what do you think?  Although I dont know for sure, these seem to be parts that are used by dwarves to do repair work on golems.  If you take them to a store, I think you will be able to sell them at a pretty reasonable price.<br>"+back+htmlend
          elif random < 123:
            st.giveItems(FIRE_EMERALD,int(Config.RATE_QUESTS_REWARD))
            return html+redfoot+standart+"寶石...？是綠寶石嗎？啊，不是。這是紫翠玉！你難道不知道？這是在陽光下呈現黃色，月光下呈紅色的珍頫的實石。應該是用在製造貴婦人裝飾品上的東西吧？拿到商店應該可以賣個好價錢。<br>"+back+htmlend
          elif random < 127:
            st.giveItems(SILK_FROCK,int(Config.RATE_QUESTS_REWARD))
            return html+redfoot+standart+"Isnt this a dress?!  This is a silk dress for a woman.  It looks pretty expensive, dont you think?  Take a look at this design.  This is an item that has been imported from Avella of the East.  At a time like this, who would use such a luxurious item?  This must be ordered by a noblewoman who has a liking for foreign products dont you think?  You should take this to a store and sell it off!  Im sure you will get a very high price for it.<br>"+back+htmlend
          elif random < 131:
            st.giveItems(PORCELAN_URN,int(Config.RATE_QUESTS_REWARD))
            return html+redfoot+standart+back+htmlend
          elif random < 132:
            st.giveItems(IMPERIAL_DIAMOND,int(Config.RATE_QUESTS_REWARD))
            return html+redfoot+standart+"Hmm?  Dont tell me!  I dont believe it!!!  Wow, an Imperial Diamond?  Isnt this the one that was used to decorate the crown of the king of Elmo-Aden?  Its truly beautiful!   You are extremely lucky!  You got yourself a priceless item.  If you take it to the market, Im sure you will be able to get a huge amount of money for it.<br>"+back+htmlend
          elif random < 147:
            random_stat=st.getRandom(4)
            if random_stat == 3 :
              st.giveItems(STATUE_SHILIEN_HEAD,1)
              return html+redfoot+standart+statue+back+htmlend
            elif random_stat == 0 :
              st.giveItems(STATUE_SHILIEN_TORSO,1)
              return html+redfoot+standart+statue+back+htmlend
            elif random_stat == 1 :
              st.giveItems(STATUE_SHILIEN_ARM,1)
              return html+redfoot+standart+statue+back+htmlend
            elif random_stat == 2 :
              st.giveItems(STATUE_SHILIEN_LEG,1)
              return html+redfoot+standart+statue+back+htmlend
          elif random < 162:
            random_tab=st.getRandom(4)
            if random_tab == 0 :
              st.giveItems(FRAGMENT_ANCIENT_TABLE1,1)
              return html+redfoot+standart+tablet+back+htmlend
            elif random_tab == 1:
              st.giveItems(FRAGMENT_ANCIENT_TABLE2,1)
              return html+redfoot+standart+tablet+back+htmlend
            elif random_tab == 2 :
              st.giveItems(FRAGMENT_ANCIENT_TABLE3,1)
              return html+redfoot+standart+tablet+back+htmlend
            elif random_tab == 3 :
              st.giveItems(FRAGMENT_ANCIENT_TABLE4,1)
              return html+redfoot+standart+tablet+back+htmlend
        else:
          return f_not_adena
      else:
        return f_no_more_box
    elif event in  ["r_give_statue","r_give_tablet"]:
      if event == "r_give_statue":
        items = statue_list
        item = COMPLETE_STATUE
        pieces = r_statue_pieces
        brockes = r_statue_brockes
        complete = r_statue_complete
      elif event == "r_give_tablet":
        items = tablet_list
        item = COMPLETE_TABLET
        pieces = r_tablet_pieces
        brockes = r_tablet_brockes
        complete = r_tablet_complete
      count=0
      for id in items:
        if st.getQuestItemsCount(id):
          count+=1
      if count>3:
        for id in items:
          st.takeItems(id,1)
        if st.getRandom(2)==1 :
          st.giveItems(item,1)
          return complete
        else:
          return brockes 
      elif count<4 and count!=0:
        return pieces
      else:
        return r_no_items
    elif event == "l_give" :
      if st.getQuestItemsCount(COMPLETE_TABLET):
        st.takeItems(COMPLETE_TABLET,1)
        st.giveItems(ADENA_ID,30000)
        return l_give
      else:
        return no_tablet
    elif event == "u_give" :
      if st.getQuestItemsCount(COMPLETE_STATUE) :
        st.takeItems(COMPLETE_STATUE,1)
        st.giveItems(ADENA_ID,30000)
        return u_give
      else:
        return no_statue
    elif event == "m_give":
      if st.getQuestItemsCount(CARGO_BOX1):
        coins = st.getQuestItemsCount(GUILD_COIN)
        count = int(coins/40)
        if count > 2 : count = 2
        st.giveItems(GUILD_COIN,1)
        st.giveItems(ADENA_ID,(1+count)*100)
        st.takeItems(CARGO_BOX1,1)
        random = st.getRandom(3)
        if random == 0:
          return m_rnd_1
        elif random == 1:
          return m_rnd_2
        else:
          return m_rnd_3
      else:
        return m_no_box
    elif event == "start_parts":
      return start_parts
    elif event == "m_reward":
      return m_reward
    elif event == "u_info":
      return u_info
    elif event == "l_info":
      return l_info
    elif event == "p_redfoot":
      return p_redfoot
    elif event == "p_trader_info":
      return p_trader_info
    elif event == "start_chose_parts":
      return start_parts
    elif event == "p1_explanation":
      return p1_explanation
    elif event == "p2_explanation":
      return p2_explanation
    elif event == "p3_explanation":
      return p3_explanation
    elif event == "p4_explanation":
      return p4_explanation
    elif event == "f_more_help":
      return f_more_help
    elif event == "r_exit":
      return r_exit
    
  def onTalk (self,npc,player):
    htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
    st = player.getQuestState(qn)
    if not st : return htmltext

    npcId = npc.getNpcId()
    id = st.getState()
    if npcId != NPC[0] and id != State.STARTED : return htmltext

    if id == State.CREATED :
      if npcId == NPC[0]:
        if st.getQuestItemsCount(BLACK_LION_MARK) :
          if player.getLevel() >24 :
            return  start_start
          else:
            st.exitQuest(1)
            return start_error1
        else:
          st.exitQuest(1)
          return start_error2
    else: 
      part=st.getInt("part")
      if npcId==NPC[0]:
          if part == 1:
            item = UNDEAD_ASH
          elif part == 2:
            item = BLOODY_AXE_INSIGNIAS
          elif part == 3:
            item = DELU_FANG
          elif part == 4:
            item = STAKATO_TALONS
          else:
            return start_ask_again
          count=st.getQuestItemsCount(item)
          box=st.getQuestItemsCount(CARGO_BOX1)
          if box and count:
            giveRewards(st,item,count)
            return p_both_info
          elif box:
            return p_only_box_info
          elif count:
            giveRewards(st,item,count)
            return p_only_item_info
          else:
            return p_no_items
      elif npcId==NPC[1]:
          if st.getQuestItemsCount(CARGO_BOX1):
            return f_give_box
          else:
            return f_no_box
      elif npcId==NPC[2]:
          count=0
          for items in statue_list:
            if st.getQuestItemsCount(items):
              count+=1
          for items in tablet_list:
            if st.getQuestItemsCount(items):
              count+=1
          if count:
            return r_items
          else:
            return r_no_items
      elif npcId==NPC[3]:
        if st.getQuestItemsCount(COMPLETE_STATUE):
          return u_statue
        else:
          count=0
          for items in statue_list:
            if st.getQuestItemsCount(items):
              count+=1
          if count:
            return u_just_pieces
          else:
            return u_no_statue
      elif npcId==NPC[4]:
        if st.getQuestItemsCount(COMPLETE_TABLET):
          return l_tablet
        else:
          count=0
          for items in tablet_list:
            if st.getQuestItemsCount(items):
              count+=1
          if count:
            return l_just_pieces
          else:
            return l_no_tablet
      elif npcId==NPC[5]:
        if st.getQuestItemsCount(CARGO_BOX1):
          return m_box
        else:
          return m_no_box
          
  def onKill(self,npc,player,isPet):
    st = player.getQuestState(qn)
    if not st : return 
    if st.getState() != State.STARTED : return 

    npcId = npc.getNpcId()
    part,allowDrop,chancePartItem,chanceBox,partItem=DROPLIST[npcId]
    random1 = st.getRandom(101)
    random2 = st.getRandom(101)
    mobLevel = npc.getLevel()
    playerLevel = player.getLevel()
    if playerLevel - mobLevel > 8:
      chancePartItem/=3
      chanceBox/=3
    if allowDrop and st.getInt("part")==part :
      if random1<chancePartItem :
        st.giveItems(partItem,1)
        st.playSound("ItemSound.quest_itemget")
      if random2<chanceBox :
        st.giveItems(CARGO_BOX1,1)
        if not random1<chancePartItem:
          st.playSound("ItemSound.quest_itemget") 
    return


QUEST       = Quest(333,qn,"黑獅的狩獵")


QUEST.addStartNpc(NPC[0])

for npcId in NPC:
  QUEST.addTalkId(npcId)

for mobId in MOBS:
  QUEST.addKillId(mobId)
