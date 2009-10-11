import sys
from net.sf.l2j.gameserver.model.quest        import State
from net.sf.l2j.gameserver.model.quest        import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "Falk"

# 32297	福爾克

# 9674	達里昂的許可證
# 9850	商隊初級認證書		與商隊開始建立友情時領取的憑證。
# 9851	商隊中級認證書		與商隊正式進行交易時所需的憑證。
# 9852	商隊高級認證書		證明與商隊已有建立深厚友情的憑證。
# 9853	友情與信賴的憑證	證明與商隊的關係已達到最高境界的的憑證。

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onAdvEvent (self,event,npc,player):
   htmltext = event
   st = player.getQuestState(qn)
   if not st : return htmltext
   if event == "32297-2.htm" :
     if st.getQuestItemsCount(9674) >= 20 :
        st.takeItems(9674,20)
        st.giveItems(9850,1)
        htmltext = "32297-2.htm"
        st.exitQuest(1) 
     else :
        htmltext = "32297-4.htm"
        st.exitQuest(1) 
   return htmltext

 def onTalk (Self,npc,player):
   st = player.getQuestState(qn)
   if not st: return
   npcId = npc.getNpcId()
   if npcId == 32297 :
     if st.getQuestItemsCount(9850) >= 1 or st.getQuestItemsCount(9851) >= 1 or st.getQuestItemsCount(9852) >= 1 or st.getQuestItemsCount(9853) >= 1 :
        htmltext = "32297-3.htm"
        st.exitQuest(1) 
     else:
        htmltext = "32297-1.htm"
   return htmltext

QUEST = Quest(-1, qn, "hellbound")

QUEST.addStartNpc(32297)
QUEST.addTalkId(32297)