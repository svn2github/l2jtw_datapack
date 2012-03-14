# by minlexx
# cleanup by Emperorc
import sys
from com.l2jserver import Config
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "662_AGameOfCards"

KLUMP = 30845
MOBS = [20677,21109,21112,21116,21114,21004,21002,21006,21008,21010,18001,20672,20673,20674,20955,\
        20962,20961,20959,20958,20966,20965,20968,20973,20972,21278,21279,21280,21281,21286,21287,\
        21288,21289,21520,21526,21530,21535,21508,21510,21513,21515]
RED_GEM = 8765
DROP_CHANCE = 60 # Drop chance for Red Gems

# 14 cards; index 0 is for closed card, displayed as '?'
CARD_VALUES = ["?","A","1","2","3","4","5","6","7","8","9","10","J","Q","K"]

# Reward items
ZIGGOS_GEMSTONE = 8868
EWS = 959 # Scroll: Enchant Weapon S
EWA = 729 # Scroll: Enchant Weapon A
EWB = 947 # Scroll: Enchant Weapon B
EWC = 951 # Scroll: Enchant Weapon C
EWD = 955 # Scroll: Enchant Weapon D
EAD = 956 # Scroll: Enchant Armor D

#Rewards format - level : [[item1, amt1],[item2, amt2],...]
REWARDS = {
    1 : [[EAD,2]],
    2 : [[EWC,2]],
    3 : [[EWS,2],[EWC,2]],
    4 : [[ZIGGOS_GEMSTONE,43],[EWS,3],[EWA,1]],
    5 : [[EWC,1]],
    6 : [[EWA,1],[EWB,2],[EWD,1]]
}

REWARDS_TEXT = [
    "嗯？這是？無對？來，沒有獎金。",
    "嗯？這是？一對？來，這是獎金。",
    "嗯？這是？三條？你的運氣還不錯嘛。這是獎金。",
    "嗯？這是？四條！漂亮！你真是了不起！托你的福！竟看到數年難得一見的四條。來，這是獎金。",
    "嗯？這是？五條？沒想到竟能看到五條！你真是太了不起！難道說勝利女神在保佑你不成？來，這是獎金！這獎金一點都不可惜啊。哈哈哈~",
    "嗯？這是？兩對？來，這是獎金。",
    "嗯？這是？葫蘆？來，這是獎金。"
]

class Quest (JQuest) :

 def __init__(self,id,name,descr):
   JQuest.__init__(self,id,name,descr)
   self.questItemIds = []
   self.games = {}

 def onEvent (self,event,st) :
     htmltext = event
     name = st.getPlayer().getName()
     if event == "Klump_AcceptQuest.htm": # quest accepted
         st.setState(State.STARTED)
         st.playSound("ItemSound.quest_accept")
         st.set("cond","1")
     elif event == "Klump_ExitQuest.htm": # quest finished
         st.playSound("ItemSound.quest_finish")
         st.exitQuest(1)
     elif event == "Klump_QuestInProgress.htm": # does player have 50 gems or not, different progress dialogs
         if st.getQuestItemsCount(RED_GEM) >= 50 :
             htmltext = "Klump_QuestInProgress_Have50Gems.htm" # this dialog allows playing
     elif event == "Klump_PlayBegin.htm":
         if st.getQuestItemsCount(RED_GEM) < 50:    # Not enough gems!!
             return "Klump_NoGems.htm"
         # on play begin remove 50 red gems
         st.takeItems(RED_GEM,50) # take gems ...
         self.games[name] = [0,0,0,0,0]
     elif event == "Klump_PlayField.htm":
         # get vars
         card1,card2,card3,card4,card5 = self.games[name]
         prize = 0
         link1 = link2 = link3 = link4 = link5 = prizestr = ""
         # if all cards are open, game ends and prize is given
         if card1 and card2 and card3 and card4 and card5 : # Game ends
             # make array of card indexes and sort it
             ca = self.games[name]
             ca.sort()
             # now in sorted array all equal elements are near each other, for example [5,5, 3,3, 2] or [5, 4,4, 3,2]
             # this makes much easier conditions checking
             match = []
             for i in range(len(ca)-1) :
                 if ca[i] == ca[i+1] :
                     prize += 1
                     if not ca[i] in match :
                         match.append(ca[i])
             if len(match) == 2 :
                 prize += 3
             # prize = 1 : 1 pair (XX). 4 variants [XX---] [-XX--] [--XX-] [---XX]
             # prize = 2 : 3 cards (XXX). 3 variants [XXX--] [-XXX-] [--XXX]
             # prize = 3 : 4 cards (XXXX). 2 variants [XXXX-] [-XXXX]
             # prize = 4 : 5 cards (XXXXX). 1 variant [XXXXX]
             # prize = 5 : 2 pairs (XXYY). 3 variants [XXYY-] [XX-YY] [-XXYY]
             # prize = 6 : Fullhouse (XXXYY). 2 variants [XXXYY] [YYXXX]
             link1 = "<a action=\"bypass -h Quest 662_AGameOfCards Klump_QuestInProgress.htm\">再來一次</a><br>"
             prizestr = REWARDS_TEXT[prize]
         else : # game still in progress, display links
           link1 = "翻開第一張紙牌<br>"
           link2 = "翻開第二張紙牌<br>"
           link3 = "翻開第三張紙牌<br>"
           link4 = "翻開第四張紙牌<br>"
           link5 = "翻開第五張紙牌<br>"
           if card1 == 0: link1 = "<a action=\"bypass -h Quest 662_AGameOfCards Klump_openCard1.htm\">翻開第一張紙牌</a><br>"
           if card2 == 0: link2 = "<a action=\"bypass -h Quest 662_AGameOfCards Klump_openCard2.htm\">翻開第二張紙牌</a><br>"
           if card3 == 0: link3 = "<a action=\"bypass -h Quest 662_AGameOfCards Klump_openCard3.htm\">翻開第三張紙牌</a><br>"
           if card4 == 0: link4 = "<a action=\"bypass -h Quest 662_AGameOfCards Klump_openCard4.htm\">翻開第四張紙牌</a><br>"
           if card5 == 0: link5 = "<a action=\"bypass -h Quest 662_AGameOfCards Klump_openCard5.htm\">翻開第五張紙牌</a><br>"
         htmltext = self.getHtm(st.getPlayer().getHtmlPrefix(), "Klump_PlayField.htm")
         htmltext = htmltext.replace("CARD1",CARD_VALUES[card1]).replace("CARD2",CARD_VALUES[card2]).replace("CARD3",CARD_VALUES[card3]).replace("CARD4",CARD_VALUES[card4]).replace("CARD5",CARD_VALUES[card5])
         htmltext = htmltext.replace("LINK1",link1).replace("LINK2",link2).replace("LINK3",link3).replace("LINK4",link4).replace("LINK5",link5).replace("PRIZE",prizestr)
         if prize :
             for item,amt in REWARDS[prize] :
                 st.rewardItems(item,amt)
     elif event.startswith("Klump_openCard") : # 'Open' card
         num = int(event[14])
         self.games[name][num-1] = self.getRandom(14) + 1 # generate index of random card, except index 0, which means 'card is closed'
         htmltext = self.onEvent("Klump_PlayField.htm",st)
     return htmltext

 def onTalk (self,npc,player):
     st = player.getQuestState(qn)
     htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
     if not st : return htmltext
     npcId = npc.getNpcId()
     id = st.getState()
     # first talk to Klump, all quest begins here
     if id == State.CREATED:
         if player.getLevel() >= 61 : # check player level
             htmltext = "Klump_FirstTalk.htm"
         else:
             htmltext = "Klump_QuestLevel.htm" #pmq 修改
             st.exitQuest(1)
     # talk to Klump when quest already in progress
     elif id == State.STARTED :
         htmltext = "Klump_QuestInProgress.htm"
         if st.getQuestItemsCount(RED_GEM) >= 50 :
             htmltext = "Klump_QuestInProgress_Have50Gems.htm"
     return htmltext

 def onKill(self,npc,player,isPet):
     st = player.getQuestState(qn)
     if not st : return
     if st.getState() != State.STARTED : return
     npcId = npc.getNpcId()
     if npcId in MOBS:
         numItems, chance = divmod(DROP_CHANCE*Config.RATE_QUEST_DROP,100)
         if self.getRandom(100) < chance :
             numItems += 1
         if numItems :
             st.giveItems(RED_GEM,int(numItems))
             st.playSound("ItemSound.quest_itemget")
     return

QUEST = Quest(662,qn,"來玩撲克牌遊戲")

QUEST.addStartNpc(KLUMP)
QUEST.addTalkId(KLUMP)

for mobId in MOBS:
  QUEST.addKillId(mobId)