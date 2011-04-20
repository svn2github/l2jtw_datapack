# Update by pmq
import sys
from com.l2jserver.gameserver.model.quest          import State
from com.l2jserver.gameserver.model.quest          import QuestState
from com.l2jserver.gameserver.model.quest.jython   import QuestJython as JQuest
from com.l2jserver.gameserver.model.actor.instance import L2PcInstance

qn = "HB_Deltuva"

DELTUVA = 32313  # 道爾土巴

class Quest (JQuest) :

	def __init__(self,id,name,descr):
		JQuest.__init__(self,id,name,descr)

	def onTalk (self,npc,player):
		st = player.getQuestState(qn)
		if not st: return

		npcId = npc.getNpcId()
		if npcId == DELTUVA :
			st1 = player.getQuestState("132_MatrasCuriosity")
			if st1 :
				if st1.getState() == State.COMPLETED :
					player.teleToLocation(17957, 283361, -9705)
					htmltext = "<html><body>道爾土巴：<br><font color=\"FF0000\">（這是測試傳送尚未實裝！）</font></body></html>"
					st.exitQuest(1)
				else :
					htmltext = "<html><body>道爾土巴：<br>看來你們還沒有進去過鋼鐵之城喔。因為太過危險，所以無法讓你們進去。</body></html>"
					st.exitQuest(1)
			else :
				htmltext = "<html><body>道爾土巴：<br>看來你們還沒有進去過鋼鐵之城喔。因為太過危險，所以無法讓你們進去。</body></html>"
				st.exitQuest(1)
		return htmltext

QUEST = Quest(-1, qn, "hellbound")

QUEST.addStartNpc(DELTUVA)
QUEST.addTalkId(DELTUVA)