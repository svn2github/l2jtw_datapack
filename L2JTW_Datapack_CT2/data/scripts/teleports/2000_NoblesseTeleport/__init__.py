# Created by Ham Wong on 2007.02.28
import sys
from net.sf.l2j.gameserver.model.quest        import State
from net.sf.l2j.gameserver.model.quest        import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "2000_NoblesseTeleport"
NPC=[30006,30059,30080,30134,30146,30177,30233,30256,30320,30540,30576,30836,30848,30878,30899,31275,31320,31964,32163]

html = '<html><body>啊，您是貴族呀，對貴族有提供特別的服務。<br><br>使用貴族通行證<br>\
        <a action="bypass -h %bypass%">傳送到狩獵場</a><br><br>不使用貴族通行證<br>\
        <a action="bypass -h npc_%objectId%_Chat 2">傳送到狩獵場</a><br><a action="bypass -h npc_%objectId%_Chat 0">返回</a></body></html>'

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onEvent (self,event,st):
    return event

 def onTalk (self,npc,player):
    st = player.getQuestState(qn)
    if player.isNoble() == 1 :
      bypass = 'Quest 2000_NoblesseTeleport noble-nopass.htm'
      if st.getQuestItemsCount(6651):
         bypass = 'npc_%objectId%_Chat 3'
      htmltext=html.replace("%bypass%",str(bypass)).replace("%objectId%",str(npc.getObjectId()))
    else :
      htmltext="nobleteleporter-no.htm"
    return htmltext

QUEST       = Quest(-1,qn,"Teleports")

for item in NPC:
   QUEST.addStartNpc(item)
   QUEST.addTalkId(item)