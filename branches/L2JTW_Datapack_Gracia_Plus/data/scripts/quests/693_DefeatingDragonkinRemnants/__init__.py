# pmq
import sys
from com.l2jserver.gameserver.model.quest import State
from com.l2jserver.gameserver.model.quest import QuestState
from com.l2jserver.gameserver.model.quest.jython import QuestJython as JQuest

qn = "693_DefeatingDragonkinRemnants"

# 任務資料
# 693	1	處決龍族殘存者	處決殘存者	破滅之種地區的殘存者管理員--軍官艾德瑞，交代了在限制時間內處決龍族殘存者的任務。與夥伴們齊心協力有效率地消滅殘存者之後，在限制時間內破壞封鎖入口的裝置。\n\n要獵殺的目標怪物-殘敗軍 軍團長、殘敗軍 第1隊隊長、殘敗軍 百龍隊長、殘敗軍 步兵、殘敗軍 魔法隊長、殘敗軍 魔法師、殘敗軍 魔法士兵、殘敗軍 治療師、殘敗軍 標槍兵\n	0															0															0	0	0	75	0	0	破滅的入口	1	1	1	32527	-248525	250048	4307	沒有條件限制	士兵時期的軍官艾德瑞曾是個忠誠的軍人，升任之後退出了戰場，目前正在負責管理殘存者的職務。由於他早已厭煩這個任務，於是提出了另類的建議。那個建議就是要與龍族殘存者對戰...	0																																																																						0						0	0	0	285	1	1	-1002											1	0											

# NPC
Edric = 32527  # 軍官 艾德瑞

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onAdvEvent (self,event,npc, player) :
		htmltext = event
		st = player.getQuestState(qn)
		if not st : return

	def onTalk (self,npc,player):
		htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
		st = player.getQuestState(qn)
		if not st: return htmltext

		npcId = npc.getNpcId()
		id = st.getState()
		cond = st.getInt("cond") 

		if id == State.CREATED :
			if npcId == Edric and cond == 0 :
				if player.getLevel() >= 75 :
					htmltext = "32527-01.htm"
					st.exitQuest(1)
				else :
					htmltext = "<html><body><br><center><font color=\"FF0000\">（任務尚未實裝！）</font></center></body></html>"
					st.exitQuest(1)
		return htmltext

QUEST		= Quest(693,qn,"處決龍族殘存者")

QUEST.addStartNpc(Edric)

QUEST.addTalkId(Edric)