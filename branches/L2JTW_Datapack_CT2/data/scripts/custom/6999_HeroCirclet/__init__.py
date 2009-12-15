# Made by L2Emu Team
import sys
from net.sf.l2j.gameserver.model.quest        import State
from net.sf.l2j.gameserver.model.quest        import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "6999_HeroCirclet"

MONUMENTS = [31690]+range(31769,31773)

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onTalk (Self,npc,player) :
   st = player.getQuestState(qn)
   htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
   if player.isHero() :
     if st.getQuestItemsCount(6842) :
       htmltext = "你已經擁有「命運之翼」了。"
     else:
       st.giveItems(6842,1)
       htmltext = "請好好享受「命運之翼」的魅力吧。"
     st.exitQuest(1)
   else :
     html = "<html><body>紀念塔：<br>因為您不是英雄，所以無法獲得命運之翼。下次請務必為了英雄之名而奮戰。<br><a action=\"bypass -h npc_%objectId%_Chat 0\">返回</a></body></html>"
     htmltext = html.replace("%objectId%",str(npc.getObjectId()))
     st.exitQuest(1)
   return htmltext

QUEST = Quest(-1,qn,"Hero Items")

for i in MONUMENTS:
    QUEST.addStartNpc(i)
    QUEST.addTalkId(i)