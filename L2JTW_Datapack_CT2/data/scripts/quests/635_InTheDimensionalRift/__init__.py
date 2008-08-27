import sys
from net.sf.l2j.gameserver.model.actor.instance import L2PcInstance
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "635_InTheDimensionalRift"

# 黎明的祭司
TOWN_DAWN = [31078,31079,31080,31081,31083,31084,31082,31692,31694,31997,31168]
# 黃昏的祭司
TOWN_DUSK = [31085,31086,31087,31088,31090,31091,31089,31693,31695,31998,31169]
# 祭典的引導者
FESTIVALGUIDE = [31127,31128,31129,31130,31131,31137,31138,31139,31140,31141]
# 裂痕守備隊
RIFTPOST = [31488,31489,31490,31491,31492,31493]
# 次元裂痕守門人
DIM_GK = [31494,31495,31496,31497,31498,31499,31500,31501,31502,31503,31504,31505,31506,31507]
# 廟塔守門人
GK_ZIGGURAT = [31095,31096,31097,31098,31099,31100,31101,31102,31103,31104,31105,31106,31107,31108,31109,31110,31114,31115,31116,31117,31118,31119,31120,31121,31122,31123,31124,31125]

# 次元的碎片 7079

NO_ADENA = "金錢不足。"

class Quest (JQuest) :

 def __init__(self, id, name, descr): JQuest.__init__(self, id, name, descr)

 def onEvent (self,event,st) :
    htmltext = event
    Level = st.player.getLevel()
    xx = st.getInt("X")
    yy = st.getInt("Y")
    zz = st.getInt("Z")

    if event == "DIMST" :
       st.set("X",str(int(st.getPlayer().getX())))
       st.set("Y",str(int(st.getPlayer().getY())))
       st.set("Z",str(int(st.getPlayer().getZ())))
       st.setState(State.STARTED)
       st.set("cond","1")
       st.playSound("ItemSound.quest_accept")
       st.getPlayer().teleToLocation(-114787,-180935,-6752)
       return "dim-04.htm"

    elif event == "GLZST" :
       if Level > 19 and Level < 30 :
          if st.getQuestItemsCount(57) > 1999 :
             st.set("X",str(int(st.getPlayer().getX())))
             st.set("Y",str(int(st.getPlayer().getY())))
             st.set("Z",str(int(st.getPlayer().getZ())))
             st.setState(State.STARTED)
             st.set("cond","1")
             st.playSound("ItemSound.quest_accept")
             st.getPlayer().teleToLocation(-114796,-179334,-6752)
             return "gkz-04.htm"
          else :
             return NO_ADENA
       elif Level > 29 and Level < 40 :
          if st.getQuestItemsCount(57) > 4499 :
             st.takeItems(57,4500)
             st.set("X",str(int(st.getPlayer().getX())))
             st.set("Y",str(int(st.getPlayer().getY())))
             st.set("Z",str(int(st.getPlayer().getZ())))
             st.setState(State.STARTED)
             st.set("cond","1")
             st.playSound("ItemSound.quest_accept")
             st.getPlayer().teleToLocation(-114796,-179334,-6752)
             return "gkz-04.htm"
          else :
               return NO_ADENA
       elif Level > 39 and Level < 50 :
          if st.getQuestItemsCount(57) > 7999 :
             st.takeItems(57,8000)
             st.set("X",str(int(st.getPlayer().getX())))
             st.set("Y",str(int(st.getPlayer().getY())))
             st.set("Z",str(int(st.getPlayer().getZ())))
             st.setState(State.STARTED)
             st.set("cond","1")
             st.playSound("ItemSound.quest_accept")
             st.getPlayer().teleToLocation(-114796,-179334,-6752)
             return "gkz-04.htm"
          else :
             return NO_ADENA
       elif Level > 49 and Level < 60 :
          if st.getQuestItemsCount(57) > 12499 :
             st.takeItems(57,12500)
             st.set("X",str(int(st.getPlayer().getX())))
             st.set("Y",str(int(st.getPlayer().getY())))
             st.set("Z",str(int(st.getPlayer().getZ())))
             st.setState(State.STARTED)
             st.set("cond","1")
             st.playSound("ItemSound.quest_accept")
             st.getPlayer().teleToLocation(-114796,-179334,-6752)
             return "gkz-04.htm"
          else :
             return NO_ADENA
       elif Level > 59 and Level < 70 :
          if st.getQuestItemsCount(57) > 12499 :
             st.takeItems(57,18000)
             st.set("X",str(int(st.getPlayer().getX())))
             st.set("Y",str(int(st.getPlayer().getY())))
             st.set("Z",str(int(st.getPlayer().getZ())))
             st.setState(State.STARTED)
             st.set("cond","1")
             st.playSound("ItemSound.quest_accept")
             st.getPlayer().teleToLocation(-114796,-179334,-6752)
             return "gkz-04.htm"
          else :
             return NO_ADENA
       elif Level > 69 :
          if st.getQuestItemsCount(57) > 24499 :
             st.takeItems(57,24500)
             st.set("X",str(int(st.getPlayer().getX())))
             st.set("Y",str(int(st.getPlayer().getY())))
             st.set("Z",str(int(st.getPlayer().getZ())))
             st.setState(State.STARTED)
             st.set("cond","1")
             st.playSound("ItemSound.quest_accept")
             st.getPlayer().teleToLocation(-114796,-179334,-6752)
             return "gkz-04.htm"
          else :
             return NO_ADENA

    elif event == "FIND" :
       return "dim-05.htm"

    return

 def onTalk (Self, npc, player):
    st = player.getQuestState(qn)
    st2 = player.getQuestState("505_BloodOffering")
    if not st: return
    npcId = npc.getNpcId()
    Level = st.player.getLevel()
    xx = st.getInt("X")
    yy = st.getInt("Y")
    zz = st.getInt("Z")

# 黎明的祭司陣營紀錄位置移至黑暗祭典
    if npcId in TOWN_DAWN : 
       st.set("X",str(int(st.getPlayer().getX())))
       st.set("Y",str(int(st.getPlayer().getY())))
       st.set("Z",str(int(st.getPlayer().getZ())))
       st.playSound("ItemSound.quest_accept")
       st.getPlayer().teleToLocation(-80157,111344,-4901)
       if st2 :
          st2.setState(State.STARTED)
          st2.set("cond","1")

# 黃昏的祭司陣營紀錄位置移至黑暗祭典
    elif npcId in TOWN_DUSK : 
       st.set("X",str(int(st.getPlayer().getX())))
       st.set("Y",str(int(st.getPlayer().getY())))
       st.set("Z",str(int(st.getPlayer().getZ())))
       st.playSound("ItemSound.quest_accept")
       st.getPlayer().teleToLocation(-81261,86531,-5157)
       if st2 :
          st2.setState(State.STARTED)
          st2.set("cond","1")

    elif npcId in DIM_GK :
       if Level > 19 :
          if st.getQuestItemsCount(7079) :
             return "dim-01.htm"
          else :
             return "dim-02.htm"
       else :
          return "dim-03.htm"

    elif npcId in GK_ZIGGURAT :
       if Level > 19 :
          if st.getQuestItemsCount(7079) :
             return "gkz-01.htm"
          else :
             return "gkz-02.htm"
       else :
          return "gkz-03.htm"

# 祭典的引導者回到原來的世界
    elif npcId in FESTIVALGUIDE :
       if xx+yy+zz :
          st.getPlayer().teleToLocation(xx,yy,zz) 
          if st2 :
             st2.exitQuest(1)
          st.exitQuest(1)

# 裂痕守備隊回到原來的世界
    elif npcId in RIFTPOST :
       if xx+yy+zz :
          st.getPlayer().teleToLocation(xx,yy,zz)
          st.exitQuest(1)
          return "riftpost.htm"

    return


QUEST      = Quest(635, qn, "在次元的裂痕")

for i in TOWN_DAWN + TOWN_DUSK + DIM_GK + GK_ZIGGURAT + FESTIVALGUIDE + RIFTPOST :
    QUEST.addStartNpc(i)
    QUEST.addTalkId(i)
