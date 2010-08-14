# Made by d0S
import sys
from com.l2jserver.gameserver.ai                 import CtrlIntention
from com.l2jserver.gameserver.network.serverpackets import CreatureSay
from com.l2jserver.gameserver.model.quest			import State
from com.l2jserver.gameserver.model.quest			import QuestState
from com.l2jserver.gameserver.model.quest.jython	import QuestJython as JQuest
from com.l2jserver.gameserver.network.serverpackets	import ExStartScenePlayer

qn = "10271_TheEnvelopingDarkness"

# 任務資料
#	10271	1	籠罩的黑暗	調查官的護衛兵	柯塞勒斯同盟聯合基地的士兵奧勒布要求調查破滅之種，但說是那個地方不太好應付，於是建議先去找找曾以調查官的護衛身分前往那個地方後，倖存而歸的士兵埃爾取得情報。\n	0															0															-186252	242594	1679	75	0	3	士兵 埃爾	0	1	1	32560	-186072	241295	2613	沒有條件限制	柯塞勒斯同盟聯合基地的士兵奧勒布要求為他調查破滅之種，而且還建議去找負傷的士兵埃爾取得那裡的情報。然後，埃爾開始訴說在破滅之種所經歷的故事...	0																																																																						0						0	0	0	285	0	3	57	-1000	-1001									3	62516	377403	37867	
#	10271	2	籠罩的黑暗	調查官的文件	士兵埃爾回想過去失敗的任務，要求去翻找梅帝法的屍體，並拿回調查官梅帝法的文件。只要有這個文件的話，就能得到很多有關破滅之種的情報。到破滅之種內部找回文件。\n	1	13852														1	1														0	0	0	75	0	3	梅帝法的屍體	0	1	1	32560	-186072	241295	2613	沒有條件限制	柯塞勒斯同盟聯合基地的士兵奧勒布要求為他調查破滅之種，而且還建議去找負傷的士兵埃爾取得那裡的情報。然後，埃爾開始訴說在破滅之種所經歷的故事...	0																																																																						0						0	0	0	285	0	3	57	-1000	-1001									3	62516	377403	37867	
#	10271	3	籠罩的黑暗	回到埃爾身邊吧	從梅帝法的屍體得到了調查官梅帝法的文件。拿著這個文件回到柯塞勒斯同盟聯合基地的士兵埃爾之處。\n	0															0															-186252	242594	1679	75	0	3	士兵 埃爾	0	1	1	32560	-186072	241295	2613	沒有條件限制	柯塞勒斯同盟聯合基地的士兵奧勒布要求為他調查破滅之種，而且還建議去找負傷的士兵埃爾取得那裡的情報。然後，埃爾開始訴說在破滅之種所經歷的故事...	0																																																																						0						0	0	0	285	0	3	57	-1000	-1001									3	62516	377403	37867	
#	10271	4	籠罩的黑暗	回到奧勒布身邊吧	埃爾看到了從梅帝法的屍體取回來的調查官梅帝法的文件後，表示了謝意。然後說道，若將它拿去交給奧勒布就能得到報酬。把這個文件拿去交給士兵奧勒布，然後領取報酬。\n	0															0															-186072	241295	2613	75	0	3	士兵 奧勒布	0	1	1	32560	-186072	241295	2613	沒有條件限制	柯塞勒斯同盟聯合基地的士兵奧勒布要求為他調查破滅之種，而且還建議去找負傷的士兵埃爾取得那裡的情報。然後，埃爾開始訴說在破滅之種所經歷的故事...	0																																																																						0						0	0	0	285	0	3	57	-1000	-1001									3	62516	377403	37867	

#NPCs 
Orby = 32560
El = 32556
Medibal = 32528
#ITEMS
documentmedibal = 13852

class Quest (JQuest):

 def __init__(self,id,name,descr):
     JQuest.__init__(self,id,name,descr)
     self.questItemIds = [documentmedibal]

 def onAdvEvent (self,event,npc, player):
   htmltext = event
   st = player.getQuestState(qn)
   if not st: return
   if event == "32560-02.htm":
     st.set("cond","1")
     st.setState(State.STARTED)
     st.playSound("ItemSound.quest_accept")
   elif event == "32556-02.htm":
     st.set("cond","2")
   elif event == "32556-05.htm":
     st.set("cond","4")
   return htmltext

 def onTalk (self,npc,player):
   st = player.getQuestState(qn)
   htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>" 
   if not st: return htmltext
   npcId = npc.getNpcId()
   id = st.getState()
   cond = st.getInt("cond")
   if id == State.COMPLETED:
     htmltext = "<html><body>這是已經完成的任務。</body></html>"
   elif npcId == Orby:
     if cond == 0:
        if player.getLevel() >= 75: htmltext = "32560-01.htm"
        else:
           htmltext = "32560-00.htm"  
     elif cond >= 1and cond < 4: htmltext = "32560-03.htm" 
     elif cond == 4: 
        htmltext = "32560-04.htm" 
        st.addExpAndSp(377403,37867)
        st.giveItems(57,62516)
        st.unset("cond") 
        st.exitQuest(False)
        st.playSound("ItemSound.quest_finish")
   elif npcId == El:
     if cond == 1:
       htmltext = "32556-01.htm"
     elif cond == 2:
       htmltext = "32556-03.htm"
     elif cond == 3:
       htmltext = "32556-04.htm"
     elif cond == 4:
       htmltext = "32556-06.htm"
   elif npcId == Medibal:
     if cond == 2:
       htmltext = "32528-01.htm"
       st.giveItems(documentmedibal,1)
       st.set("cond","3")
     if cond == 3:
       htmltext = "32528-02.htm"
   return htmltext

QUEST     = Quest(10271,qn,"籠罩的黑暗") 

QUEST.addStartNpc(Orby)
QUEST.addTalkId(Orby)
QUEST.addTalkId(El)
QUEST.addTalkId(Medibal)