# Exploration of Giants Cave, part 1 version 0.1 
# by DrLecter
import sys
from com.l2jserver import Config
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest
#Quest info
QUEST_NUMBER,QUEST_NAME,QUEST_DESCRIPTION = 376,"GiantsExploration1","巨人洞穴的探險-上篇"
qn = "376_GiantsExploration1"

#Variables
#Ancient parchment drop rate in %
DROP_RATE   = 15*Config.RATE_QUEST_DROP
MAX = 100
#Mysterious Book drop rate in %
DROP_RATE_2 = 5*Config.RATE_QUEST_DROP
#By changing this setting you can make a group of recipes harder to get
RP_BALANCE = 50
#Changing this value to non-zero, will turn recipes to 100% instead of 60%
ALT_RP_100 = 0


#Quest items
ANC_SCROLL = 5944
DICT1  = 5891 
DICT2  = 5892 #Given as a proof for 2nd part
MST_BK = 5890

#Quest items vs rewards (recipes for low sealed armor parts, 60%)
EXCHANGE = [
 #collection items list,     rnd_1, rnd_2
[[5937,5938,5939,5940,5941], 5346, 5354], #medical theory, tallum_tunic,     tallum_hose
[[5932,5933,5934,5935,5936], 5332, 5334], #architecture,   drk_crstl_leather,tallum_leather
[[5922,5923,5924,5925,5926], 5416, 5418], #golem plans,    drk_crstl_breastp,tallum_plate
[[5927,5928,5929,5930,5931], 5424, 5340]  #basics of magic,drk_crstl_gaiters,dark_crystal_legg
]

#Messages
default   = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
error_1   = "<html><body>首席調查員蕭伯霖：<br>謝謝你的好意，等你等級再高一點的時候，再來找我吧。<br><font color=\"LEVEL\">(等級達到51以上才能執行此任務)</font></body></html>"
start     = "<html><body>首席調查員蕭伯霖：<br>身為首席調查員的我正在尋找有經驗的冒險家，來加入我們探查巨人洞穴古代遺物的團隊，到目前為止，我們仍有四份文獻尚未找尋到，包括<font color=\"LEVEL\">巨人的高崙設計圖、巨人的魔法理論、巨人的建築指南、巨人的醫學理論</font><br>如果你願意加入尋找文獻，我將給予你一些報償。<br><a action=\"bypass -h Quest 376_GiantsExploration1 yes\">我願意加入尋找文獻</a><br><a action=\"bypass -h Quest 376_GiantsExploration1 0\">我沒有興趣</a><br></body></html>"
starting  = "Starting.htm"
checkout  = "<html><body>首席調查員蕭伯霖：<br>太好了！你終於回來了！找尋文獻的過程有遇到困難嗎？<br>讓我看看你找到了什麼‧‧‧<br><a action=\"bypass -h Quest 376_GiantsExploration1 show\">讓他觀看找到的文獻</a><br><a action=\"bypass -h Quest 376_GiantsExploration1 myst\">讓他觀看找到的其他物品</a></body></html>"
checkout2 = "<html><body>首席調查員蕭伯霖：<br>太好了！你終於回來了！找尋文獻的過程有遇到困難嗎？<br>嗯‧‧‧這是什麼？這一些古代的文獻，除非你能將內容翻譯出來，不然這對於我是沒有用處的，我沒有時間去了解內容，這就是為什麼我給你那本古代的基礎辭典的用意。也許你還有其他的文獻是我所需要的‧‧‧<br><a action=\"bypass -h Quest 376_GiantsExploration1 show\">讓他觀看其他的文獻</a><br><a action=\"bypass -h Quest 376_GiantsExploration1 myst\">讓他觀看其他的物品</a><br></body></html>"
no_items  = "<html><body>首席調查員蕭伯霖：<br>嗯‧‧‧這裡沒有我想要的東西，你應該繼續你的冒險了。我相信你可以做的更好只要你再努力一點‧‧‧你覺得呢？<br><a action=\"bypass -h Quest 376_GiantsExploration1 Starting.htm\">我會繼續找尋文獻</a><br><a action=\"bypass -h Quest 376_GiantsExploration1 0\">我想要休息</a></body></html>"
tnx4items = "<html><body>首席調查員蕭伯霖：<br>真是太好了！這些就是我在尋找的東西‧‧‧拿去吧，這是我的一點心意。不管怎樣，我相信在巨人洞穴裡還有更多的文獻還沒被發現，你願意繼續去尋找嗎？<br><a action=\"bypass -h Quest 376_GiantsExploration1 Starting.htm\">我願意繼續</a><br><a action=\"bypass -h Quest 376_GiantsExploration1 0\">我想要休息</a><br></body></html>"
go_part2  = "<html><body>首席調查員蕭伯霖：<br>真是令人感興趣，這本究竟是什麼書？我想如果沒有其他人的幫忙，我們是無法得知它的內容。不過別擔心，我知道有一個人可以幫我們，請你去詢問<font color=\"LEVEL\">歐瑞城鎮的倉庫管理員克里弗</font>，他應該了解這本書的內容。<br></body></html>"
no_part2  = "<html><body>首席調查員蕭伯霖：<br>我並沒有發現任何有用的文獻‧‧‧據我們所知，巨人之間的活動並沒有證據來證明你所發現的信件或是手稿是真的，就如同我告訴你的，我們主要是在找尋<font color=\"LEVEL\">巨人的高崙設計圖、巨人的魔法理論、巨人的建築指南、巨人的醫學理論</font>這些文獻，你必須帶來完整的文獻，我們才能進一步來研究。</body></html>"
ok_part2  = "<html><body>倉庫管理員克里弗：<br>咦，這是什麼書？蕭柏霖叫你帶來給我看看的嗎？嗯‧‧‧我看看‧‧‧這本書是用非常古老的文字寫成的‧‧‧嗯‧‧‧對了，你把這本古代的中級辭典拿去給<font color=\"LEVEL\">蕭柏霖</font>看看。有了這本辭典，他就可以了解這本書，快拿去給他吧。</body></html>"
gogogo_2  = "<html><body>首席調查員蕭伯霖：<br>你還帶著這本書在這做什麼？以我們現有的知識是無法了解這本書的內容，帶著這本書去找<font color=\"LEVEL\">歐瑞城鎮的倉庫管理員克里弗</font>。</body></html>"
ext_msg   = "Quest aborted"

#NPCs
HR_SOBLING = 31147
WF_CLIFF   = 30182

#Mobs
MOBS = range(20647,20651)

class Quest (JQuest) :

 def __init__(self,id,name,descr):
     JQuest.__init__(self,id,name,descr)
     self.questItemIds = [DICT1, MST_BK]

 def onEvent (self,event,st) :
    id = st.getState() 
    htmltext = event
    if event == "yes" :
       htmltext = starting
       st.setState(State.STARTED)
       st.set("progress","PART1")
       st.set("cond","1")
       st.set("awaitBook","1")
       st.giveItems(DICT1,1)
       st.playSound("ItemSound.quest_accept")
    elif event == "0" :
       htmltext = ext_msg
       st.playSound("ItemSound.quest_finish")
       st.takeItems(DICT1,-1)
       st.takeItems(MST_BK,-1)
       st.exitQuest(1)
    elif event == "show" :
       htmltext = no_items
       for i in range(len(EXCHANGE)) :
           dec=2**len(EXCHANGE[i][0])
           for j in range(len(EXCHANGE[i][0])) :
               if st.getQuestItemsCount(EXCHANGE[i][0][j]) :
                  dec = dec >> 1
           if dec == 1 :
              htmltext = tnx4items
              for k in range(len(EXCHANGE[i][0])) :
                  st.takeItems(EXCHANGE[i][0][k], 1)
              if st.getRandom(100) < RP_BALANCE :
                 item = EXCHANGE[i][1]
              else :
                 item = EXCHANGE[i][2]
              if ALT_RP_100 != 0 : item += 1
              st.giveItems(item,1)
    elif event == "myst" :
       if st.getQuestItemsCount(MST_BK) :
          if id == State.STARTED and st.get("progress") == "PART1" :
             st.set("progress","PART2")
             st.set("cond","2")
             htmltext = go_part2
          elif id == State.STARTED and st.get("progress") == "PART2":
             htmltext = gogogo_2
       else :
           htmltext = no_part2
    return htmltext

 def onTalk (self,npc,player):
   htmltext = default
   st = player.getQuestState(qn)
   if not st : return htmltext

   npcId = npc.getNpcId()
   id = st.getState()
   if npcId == HR_SOBLING:
      if id == State.CREATED :
         st.set("cond","0")
         htmltext = start
         if player.getLevel() < 51 :
            st.exitQuest(1)
            htmltext = error_1
      elif id == State.STARTED :
         if st.getQuestItemsCount(ANC_SCROLL) == 0 :
            htmltext = checkout
         else :
            htmltext = checkout2
   elif npcId == WF_CLIFF :
      if id == State.STARTED and st.getQuestItemsCount(MST_BK) and st.get("progress") == "PART2" :
            htmltext = ok_part2
            st.takeItems(MST_BK,1)
            st.giveItems(DICT2,1)
            st.set("cond","3")
            st.playSound("ItemSound.quest_middle")
   return htmltext

 def onKill(self,npc,player,isPet) :
     # a Mysterious Book may drop to any party member that still hasn't gotten it
     partyMember = self.getRandomPartyMember(player,"awaitBook","1")
     if partyMember :
        st = partyMember.getQuestState(qn)
        drop = st.getRandom(100)
        if drop < DROP_RATE_2  and not st.getQuestItemsCount(MST_BK):
           st.giveItems(MST_BK,1)
           st.unset("awaitBook")
           st.playSound("ItemSound.quest_middle")
     # In addition, drops go to one party member among those who are either in
     # progress PART1 or in PART2
     partyMember = self.getRandomPartyMemberState(player, State.STARTED)
     if not partyMember : return
     st = partyMember.getQuestState(qn)  
     numItems, chance = divmod(DROP_RATE,MAX)
     if st.getRandom(MAX) < chance :
        numItems = numItems + 1
     if int(numItems) != 0 :
        st.giveItems(ANC_SCROLL,int(numItems))
        st.playSound("ItemSound.quest_itemget")
     return  

# Quest class and state definition
QUEST       = Quest(QUEST_NUMBER, str(QUEST_NUMBER)+"_"+QUEST_NAME, QUEST_DESCRIPTION)

# Quest NPC starter initialization
QUEST.addStartNpc(HR_SOBLING)
# Quest initialization
QUEST.addTalkId(HR_SOBLING)

QUEST.addTalkId(WF_CLIFF)

for i in MOBS :
  QUEST.addKillId(i)