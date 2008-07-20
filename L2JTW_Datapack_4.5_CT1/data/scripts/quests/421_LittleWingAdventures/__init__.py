# Upgrade your Hatchling to Strider version 0.2
# by DrLecter & DraX_

#Quest info
QUEST_NUMBER      = 421
QUEST_NAME        = "LittleWingAdventures"
QUEST_DESCRIPTION = "小翅膀的冒險"
qn = "421_LittleWingAdventures"

#Configuration

#Minimum pet and player levels required to complete the quest (defaults 55 and 45)
MIN_PET_LEVEL = 55
MIN_PLAYER_LEVEL = 45
# Maximum distance allowed between pet and owner; if it's reached while talking to any NPC, quest is aborted
MAX_DISTANCE = 100

#Messages
default = "<html><head><body>沒進行任務或條件不符合。</body></html>"
event_1 = "<html><head><body>克洛諾斯：<br>我當然不知道啦~！不，不算是知道...反正啊。我對幼龍...所以說...<br>那個...這樣吧，我覺得去找住在妖精古的<font color=\"LEVEL\">妖精米莫</font>問比較好。當初給你幼龍的也是他呀...對呀對，上次那件事之後，我跟他都互相透過信保持聯繫，可以算是友情嗎？反正我們倆的關係很好。所以說，我會寫信給他，讓他對你和你的幼龍好一點...明白了嗎？你明白我的意思嗎？</body></html>" 
error_1 = "<html><head><body>你需要擁有一頭幼龍，並且將他召喚出來，以完成這個任務。</body></html>"
error_2 = "<html><head><body>嘿！發生了什麼事？為什麼又有另外一條幼龍？這不是原本的幼龍吧？</body></html>"
error_3 = "<html><head><body>克洛諾斯：<br>你的等級需求"+str(MIN_PLAYER_LEVEL)+"以上才能解此任務。</body></html>"
error_4 = "<html><head><body>克洛諾斯：<br>你的寵物等級需求"+str(MIN_PET_LEVEL)+"以上才能解此任務。</body></html>"
error_5 = "你的寵物不是幼龍，任務中斷。"
error_6 = "你的寵物不在身邊，任務中斷。"
qston_1 = "<html><head><body>克洛諾斯：<br>嘿，你不就是之前吵著要養幼龍的那個人嗎？如何？我跟你說過養幼龍是很難的，所以叫你別養，你卻那麼固執...後悔了吧？！就算是跟牠有緣，把它養成座龍如何？你帶著的小鬼，現在應該長大了吧...？你要不要把那小鬼變成座龍...？<br><a action=\"bypass -h Quest "+str(QUEST_NUMBER)+"_"+QUEST_NAME+" 16\">詢問是否知道其方法</a></body></html>"
qston_2 = "<html><head><body>克洛諾斯：<br>我已經跟你說去請教<font color=\"LEVEL\">妖精米莫</font>！！說的夠清楚嗎！？</body></html>"
qston_3 = "<html><head><body>妖精米莫：<br>什麼！你找不到<font color=\"LEVEL\">風、星、黃昏、深淵的妖精木</font>。 別放棄！ 他們全都在<font color=\"LEVEL\">獵人村莊</font>。</body></html>"
order_1 = "<html><head><body>妖精米莫：<br>你的幼龍必須喝下<font color=\"LEVEL\">風、星、黃昏、深淵的妖精木</font>的汁液來幫助牠的成長。別傷害到願意幫助你的妖精木，拿著這些妖精的葉子，在幼龍喝完樹液之後將它貼在妖精木的傷口上吧。</body></html>"
ftm_11  = "<html><head><body>風的妖精木：<br>我會讓你的幼龍飲用我的汁液，但是在這期間你必須保護你的寵物並且給我一片你擁有妖精的葉子，<br><br><a action=\"bypass -h Quest "+str(QUEST_NUMBER)+"_"+QUEST_NAME+" 1\">沒問題</a></body></html>"
ftm_12  = "幼龍已喝下風的妖精木的樹汁！"
ftm_21  = "<html><head><body>星的妖精木：<br>噢！那些骯髒的鬼魂傷害了我的樹皮... 看！只有妖精的葉子能夠治療我的傷 ... <br><br><a action=\"bypass -h Quest "+str(QUEST_NUMBER)+"_"+QUEST_NAME+" 2\">貼上葉子</a></body></html>"
ftm_22  = "幼龍已喝下星的妖精木的樹汁！"
ftm_31  = "<html><head><body>黃昏的妖精木：<br>好，我想這應該是沒問題的，但是我們沒時間等待你的幼龍等上個把小時... 動作快點吧！<br><br><a action=\"bypass -h Quest "+str(QUEST_NUMBER)+"_"+QUEST_NAME+" 4\">好，拿取葉子</a></body></html>"
ftm_32  = "幼龍已喝下黃昏的妖精木的樹汁！"
ftm_41  = "<html><head><body>深淵的妖精木：<br>你的寵物會咬我，以及你會放上一片妖精的葉子在傷口？你別想！不！等等！... 啊 ... 如果我可以像黑柳路克一樣的奔跑... <br><br><a action=\"bypass -h Quest "+str(QUEST_NUMBER)+"_"+QUEST_NAME+" 8\">說抱歉</a></body></html>"
ftm_42  = "幼龍已喝下深淵的妖精木的樹汁！"
end_msg = "<html><head><body>妖精米莫：<br>做的很好，你的幼龍"
end_msg2= "已經蛻變為座龍了，恭喜你。</body></html>"


#Quest items
FT_LEAF = 4325
CONTROL_ITEMS = { 3500:4422, 3501:4423, 3502:4424 }

#NPCs
SG_CRONOS = 30610
FY_MYMYU  = 30747
#NpcId, bitmask, spawnX,spawnY,spawnZ,msg1,msg2
FAIRY_TREES = [ [27185,1,113356,93848,-2072,ftm_11,ftm_12],
                [27186,2,117733,94108,-2068,ftm_21,ftm_22],
                [27187,4,127714,90495,-2095,ftm_31,ftm_32],
                [27188,8,106671,93905,-2070,ftm_41,ftm_42] ]
#Mobs
GUARDIAN = 27189

import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

def get_control_item(st) :
  item = st.getPlayer().getPet().getControlItemId()
  if st.getState() == State.CREATED :
      st.set("item",str(item))
  else :
      if  st.getInt("item") != item : item = 0
  return item  

def get_distance(player) :
    is_far = False
    if abs(player.getPet().getX() - player.getX()) > MAX_DISTANCE :
        is_far = True
    if abs(player.getPet().getY() - player.getY()) > MAX_DISTANCE :
        is_far = True
    if abs(player.getPet().getZ() - player.getZ()) > MAX_DISTANCE :
        is_far = True
    return is_far

class Quest (JQuest) :

 def __init__(self,id,name,descr):
   JQuest.__init__(self,id,name,descr)
   self.questItemIds = [FT_LEAF]

 def onEvent (self,event,st) :
    htmltext = event
    leafs = st.getQuestItemsCount(FT_LEAF) 
    for i in range(4) :
       if event == str(FAIRY_TREES[i][1]) :
           st.set("id", str(st.getInt("id") | FAIRY_TREES[i][1]))
           htmltext = FAIRY_TREES[i][6]
           st.takeItems(FT_LEAF,1)
           if 1 < leafs <= 4 :
              st.playSound("ItemSound.quest_itemget")
           elif leafs == 1 and st.getInt("id") == 15:
              st.playSound("ItemSound.quest_middle")
              st.set("cond","3")
    if event == "16" :
       htmltext = event_1
       st.setState(State.STARTED)
       st.set("id","0")
       st.set("cond","1")
       st.playSound("ItemSound.quest_accept")
    return htmltext

 def onTalk (self,npc,player):
   htmltext = default
   st = player.getQuestState(qn)
   if not st : return htmltext
   id = st.getState()
   cond = st.getInt("cond")
   if id == State.COMPLETED :
      st.setState(State.CREATED)
      id = State.CREATED
   npcId = npc.getNpcId()
   if player.getPet() == None :
       htmltext = error_1
       st.exitQuest(1)
   elif player.getPet().getTemplate().npcId not in [12311,12312,12313] : #npcIds for hatchlings
       htmltext = error_5
       st.exitQuest(1)
   elif player.getPet().getLevel() < MIN_PET_LEVEL :
       st.exitQuest(1)
       htmltext = error_4
   elif get_distance(player) :
       st.exitQuest(1)
       htmltext = error_6
   elif get_control_item(st) == 0 :
       st.exitQuest(1)
       htmltext = error_2
   elif npcId == SG_CRONOS :
      if id == State.CREATED :
         if player.getLevel() < MIN_PLAYER_LEVEL :
            st.exitQuest(1)
            htmltext = error_3
         else :   
            htmltext = qston_1
      else :
         htmltext = qston_2
   elif npcId == FY_MYMYU :
     if id == State.STARTED and cond < 3 :
        if st.getQuestItemsCount(FT_LEAF) == 0 and st.getInt("id") == 0 :
           st.set("cond","2")
           st.giveItems(FT_LEAF,4)
           st.playSound("ItemSound.quest_itemget")
           htmltext = order_1
        else :
            htmltext = qston_3
     elif id == State.STARTED and cond >= 3:
        name = player.getPet().getName()
        if name == None : name = " "
        else : name = " "+name+" "
        htmltext = end_msg+name+end_msg2
        item=CONTROL_ITEMS[player.getInventory().getItemByObjectId(player.getPet().getControlItemId()).getItemId()]
        player.getPet().deleteMe(player) #both despawn pet and delete controlitem
        st.giveItems(item,1)
        st.exitQuest(1)
        st.playSound("ItemSound.quest_finish")
   elif id == State.STARTED and cond < 3 :
     leafs = st.getQuestItemsCount(FT_LEAF)
     if 0 < leafs :
        for i in range(4) :
           if npcId == FAIRY_TREES[i][0] and (st.getInt("id") | FAIRY_TREES[i][1] != st.getInt("id")) :
              for j in range(2):
                 for k in range(2): 
                    st.addSpawn(GUARDIAN,FAIRY_TREES[i][2]+70*pow(-1,j%2),FAIRY_TREES[i][3]+70*pow(-1,k%2),FAIRY_TREES[i][4])
              htmltext = FAIRY_TREES[i][5]
   return htmltext

 def onKill(self,npc,player,isPet) :
   return  

# Quest class and state definition
QUEST       = Quest(QUEST_NUMBER, str(QUEST_NUMBER)+"_"+QUEST_NAME, QUEST_DESCRIPTION)

# Quest NPC starter initialization
QUEST.addStartNpc(SG_CRONOS)
# Quest initialization
QUEST.addTalkId(SG_CRONOS)

QUEST.addTalkId(FY_MYMYU)

for i in range(4) :
  QUEST.addTalkId(FAIRY_TREES[i][0])