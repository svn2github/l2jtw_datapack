# Exploration of Giants Cave, part 2 version 0.1 
# by DrLecter
import sys
from net.sf.l2j import Config
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

#Quest info
QUEST_NUMBER,QUEST_NAME,QUEST_DESCRIPTION = 377,"GiantsExploration2","巨人洞穴的探險-下篇"
qn = "377_GiantsExploration2"

#Variables
#Titan Ancient Books drop rate in %
DROP_RATE=15*Config.RATE_DROP_QUEST
MAX = 100
#Alternative rewards. Set this to a non-zero value and recipes will be 100% instead of 60%
ALT_RP_100=0

#Quest items
ANC_BOOK = 5955
DICT2    = 5892

#Quest collections
EXCHANGE = [
[5945, 5946, 5947, 5948, 5949], #science basis
[5950, 5951, 5952, 5953, 5954]  #culture
]

#Messages
efault   = "<html><head><body>我沒有什麼話可以跟你說的。</body></html>"
error_1   = "<html><head><body>首席調查員蕭伯霖：<br>謝謝你的好意，等你等級再高一點的時候，再來找我吧。<br><font color=\"LEVEL\">(等級達到57以上才能執行此任務)</font></body></html>"
start     = "<html><head><body>首席調查員蕭伯霖：<br>所以，克里弗叫你將這本辭典拿給我們，嗯‧‧‧這樣我可以來看一下這本書的內容。這真是令人驚奇阿‧‧‧原來還有更多的古代遺物是我們還沒發現的，也許你還願意幫我們繼續找尋這些還未尋獲的古代遺物，我們現在要找的是<font color=\"LEVEL\">巨人的科學理論、下巨人文化年鑑</font>。<br>我們的報償是你無法拒絕的<font color=\"LEVEL\">A級制捲</font>，當然你如果找到其他的遺物，我們是不會接受的，我們只接受有關下巨人的書籍。<br><a action=\"bypass -h Quest 377_GiantsExploration2 yes\">我願意尋找古代文獻</a><br><a action=\"bypass -h Quest 377_GiantsExploration2 0\">現在我沒有時間幫你</a><br></body></html>"
starting  = "Starting.htm"
checkout  = "<html><head><body>首席調查員蕭伯霖：<br>太好了！你終於回來了！找尋文獻的過程有遇到困難嗎？<br>讓我看看你找到了些什麼‧‧‧<br><a action=\"bypass -h Quest 377_GiantsExploration2 show\">讓他觀看找到的文獻</a></body></html>"
checkout2 = "<html><head><body>首席調查員蕭伯霖：<br>太好了！你終於回來了！找尋文獻的過程有遇到困難嗎？<br>嗯‧‧‧這是什麼？這一些古代的文獻，除非你能將內容翻譯出來，不然這對於我是沒有用處的，我沒有時間去了解內容，這就是為什麼我給你那本古代的中級辭典的用意。也許你還有其他的文獻是我所需要的‧‧‧<br><br><a action=\"bypass -h Quest 377_GiantsExploration2 show\">讓他觀看其他的文獻</a></body></html>"
no_items  = "<html><head><body>首席調查員蕭伯霖：<br>嗯‧‧‧這裡沒有我想要的東西，你應該繼續你的冒險了。我相信你可以做的更好只要你再努力一點‧‧‧你覺得呢？<br><a action=\"bypass -h Quest 377_GiantsExploration2 Starting.htm\">我會繼續找尋文獻</a><br><a action=\"bypass -h Quest 377_GiantsExploration2 0\">我想要休息</a></body></html>"
tnx4items = "<html><head><body>首席調查員蕭伯霖：<br>真是太好了！這些就是我在尋找的東西‧‧‧拿去吧，這是我的一點心意。不管怎樣，我相信在巨人洞穴裡還有更多的文獻還沒被發現，你願意繼續去尋找嗎？<br><a action=\"bypass -h Quest 377_GiantsExploration2 Starting.htm\">我願意繼續找尋文獻</a><br><a action=\"bypass -h Quest 377_GiantsExploration2 0\">我想要休息</a></body></html>"
ext_msg   = "Quest aborted"

#NPCs
HR_SOBLING = 31147

#Mobs
MOBS = [ 20654,20656,20657,20658 ]

class Quest (JQuest) :

 def __init__(self,id,name,descr):
     JQuest.__init__(self,id,name,descr)
     self.questItemIds = [DICT2]

 def onEvent (self,event,st) :
    id = st.getState() 
    htmltext = event
    if event == "yes" :
       htmltext = starting
       st.setState(State.STARTED)
       st.set("cond","1")
       st.playSound("ItemSound.quest_accept")
    elif event == "0" :
       htmltext = ext_msg
       st.playSound("ItemSound.quest_finish")
       st.takeItems(DICT2,1)
       st.exitQuest(1)
    elif event == "show" :
       htmltext = no_items
       for i in range(len(EXCHANGE)) :
           dec=2**len(EXCHANGE[i])
           for j in range(len(EXCHANGE[i])) :
               if st.getQuestItemsCount(EXCHANGE[i][j]) > 0 :
                  dec = dec >> 1
           if dec == 1 :
              htmltext = tnx4items
              for k in range(len(EXCHANGE[i])) :
                  st.takeItems(EXCHANGE[i][k], 1)
              luck = st.getRandom(100) 
              if luck > 75   : item=5420 #nightmare leather 60%
              elif luck > 50 : item=5422 #majestic plate 60%
              elif luck > 25 : item=5336 #nightmare armor 60%
              else           : item=5338 #majestic leather 60%
              if ALT_RP_100 != 0 : item +=1
              st.giveItems(item,1)
    return htmltext

 def onTalk (self,npc,player):
   htmltext = default
   st = player.getQuestState(qn)
   if not st : return htmltext

   npcId = npc.getNpcId()
   id = st.getState()
   if st.getQuestItemsCount(DICT2) != 1 :
      st.exitQuest(1) 
   elif id == State.CREATED :
      st.set("cond","0")
      htmltext = start
      if player.getLevel() < 57 :
         st.exitQuest(1)
         htmltext = error_1
   elif id == State.STARTED :
      if st.getQuestItemsCount(ANC_BOOK) == 0 :
         htmltext = checkout
      else :
         htmltext = checkout2
   return htmltext

 def onKill(self,npc,player,isPet) :
     partyMember = self.getRandomPartyMemberState(player,State.STARTED)
     if not partyMember : return
     st = partyMember.getQuestState(qn)
     numItems, chance = divmod(DROP_RATE,MAX)
     drop = st.getRandom(MAX)
     if drop < chance :
        numItems = numItems +1
     if int(numItems) != 0 :
        st.giveItems(ANC_BOOK,int(numItems))
        st.playSound("ItemSound.quest_itemget")
     return  

# Quest class and state definition
QUEST       = Quest(QUEST_NUMBER, str(QUEST_NUMBER)+"_"+QUEST_NAME, QUEST_DESCRIPTION)

# Quest NPC starter initialization
QUEST.addStartNpc(HR_SOBLING)
# Quest initialization
QUEST.addTalkId(HR_SOBLING)

for i in MOBS :
  QUEST.addKillId(i)