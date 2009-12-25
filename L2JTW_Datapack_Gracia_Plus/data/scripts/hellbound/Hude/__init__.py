import sys
from com.l2jserver.gameserver.model.quest           import State
from com.l2jserver.gameserver.model.quest           import QuestState
from com.l2jserver.gameserver.model.quest.jython    import QuestJython as JQuest
from com.l2jserver.util                             import Rnd
from com.l2jserver.gameserver.model.itemcontainer   import PcInventory
from com.l2jserver.gameserver.model                 import L2ItemInstance
from com.l2jserver.gameserver.network.serverpackets import InventoryUpdate
from com.l2jserver.gameserver.network.serverpackets import SystemMessage
from com.l2jserver.gameserver.network               import SystemMessageId

qn = "Hude"

# 32298	亨德				商隊商人
# 9628	雷那特				矮人製作道具時使用的材料。可以賣給一般商店。
# 9629	亞德曼合金			矮人製作道具時使用的材料。可以賣給一般商店。
# 9630	奧里哈魯根合金		矮人製作道具時使用的材料。可以賣給一般商店。
# 9631	最高級皮革			矮人製作道具時使用的材料。可以賣給一般商店。
# 9674	達里昂的許可證
# 9676	背叛者的憑證
# 9681	魔法精氣			從奇美拉吸收的魔法精氣。
# 9682	保存的魔法精氣		從奇美拉西爾德斯吸收的魔法精氣。
# 9683	沙亞龍的尖牙		沙亞龍的牙齒，對商隊來說是個很好的交易道具
# 9850	商隊初級認證書		與商隊開始建立友情時領取的憑證。
# 9851	商隊中級認證書		與商隊正式進行交易時所需的憑證。
# 9852	商隊高級認證書		證明與商隊已有建立深厚友情的憑證。
# 9853	友情與信賴的憑證	證明與商隊的關係已達到最高境界的的憑證。
# 10012	蠍子的毒針

# items = [9628,9629,9630]
# badge = 9674

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onAdvEvent (self,event,npc,player) :
    htmltext = event
    st = player.getQuestState(qn)
    if not st: return
    if event == "1" :
       if st.getQuestItemsCount(9850) == 1 :
          if st.getQuestItemsCount(10012) >= 60 and st.getQuestItemsCount(9676) >= 30 :
              st.takeItems(10012,60)
              st.takeItems(9676,30)
              st.takeItems(9850,-1)
              st.giveItems(9851,1)
              htmltext = ""
              st.set("talk","1")
          else :
              htmltext = "no1.htm"
    if event == "2" :
       if st.getQuestItemsCount(9851) == 1 :
          if st.getQuestItemsCount(9681) >= 80 and st.getQuestItemsCount(9682) >= 20 :
              st.takeItems(9681,80)
              st.takeItems(9682,20)
              st.takeItems(9851,-1)
              st.giveItems(9994,1)
              st.giveItems(9852,1)
              htmltext = ""
              st.set("talk","2")
          else :
              htmltext = "no2.htm"
#    if event == "3" :
#       if st.getQuestItemsCount(9852) == 1 :
#          if st.getQuestItemsCount(9681) >= 80 and st.getQuestItemsCount(9682) >= 20 :
#              st.takeItems(9852,-1)
#              st.giveItems(9853,1)
#              htmltext = "trade.htm"
#              st.set("talk","3")
#          else :
#              htmltext = "no3.htm"
#    if event == "4" :
#       if st.getQuestItemsCount(9853) == 1 :
#          if st.getQuestItemsCount(9681) >= 80 and st.getQuestItemsCount(9682) >= 20 :
#              htmltext = "trade.htm"
#              st.set("talk","4")
#          else :
#              htmltext = "no4.htm"
    return htmltext

 def onFirstTalk (self,npc,player):
    npcId = npc.getNpcId()
    st = player.getQuestState(qn)
    if not st :
       st = self.newQuestState(player)
    talk = st.getInt("talk")
    if talk == 0 :
        if st.getQuestItemsCount(9850) == 1 :
           htmltext = "32298-1.htm"
        else :
           htmltext = "32298.htm"
    if talk == 1 :
        if st.getQuestItemsCount(9851) == 1 :
           htmltext = "32298-2.htm"
        else :
           htmltext = "32298.htm"
    if talk == 2 :
       if st.getQuestItemsCount(9852) == 1 :
          htmltext = "32298-3.htm"
       else :
          htmltext = "32298.htm"
    if talk == 3 :
       if st.getQuestItemsCount(9853) == 1 :
          htmltext = "32298-4.htm"
       else :
          htmltext = "32298.htm"
    return htmltext

QUEST = Quest(-1, qn, "hellbound")

QUEST.addFirstTalkId(32298)
QUEST.addStartNpc(32298)
QUEST.addTalkId(32298)