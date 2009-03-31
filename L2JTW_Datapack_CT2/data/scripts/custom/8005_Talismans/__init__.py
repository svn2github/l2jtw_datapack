# Made by Krunch, Psychokiller1888
import sys
from net.sf.l2j.gameserver.model.quest        import State
from net.sf.l2j.gameserver.model.quest        import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "8005_Talismans"

KNIGHT_EPAULETTES = 9912
TALISMANS = [9956,9923,9959,9922,9957,9958,9955,9926,9930,9924,9932,9920,9927,9914,9919,9921,9915,10142,9951,10158,9950,10141,9954,9952,9953,9918,9931,9928,9917,9963,9964,9960,9966,9962,9961,9965,9938,9940,9935,9937,9936,9947,9944,9943,9942,9939,9945,9946,9949,9948,9933,9941,9934]

class Quest (JQuest) :

    def __init__(self, id, name, descr): 
        JQuest.__init__(self, id, name, descr)

    def onTalk(self, npc, player):
        htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
        st = player.getQuestState(qn)
        if not st :
            st = self.newQuestState(player)
        if st.getQuestItemsCount(KNIGHT_EPAULETTES) >= 10 :
            length = len(TALISMANS)
            pos = st.getRandom(length)
            talisman = TALISMANS[pos]
            st.takeItems(KNIGHT_EPAULETTES, 10)
            st.giveItems(talisman, 1)
            htmltext = "<html><body>宮廷魔法師：<br>做得很好。請繼續努力！<br><center><font color=\"FF0000\">（護身符的功能尚未實裝！）</font></center></body></html>"
        else :
            npcId = npc.getNpcId()
            if npcId >= 35648 and npcId <= 35656:
                htmltext = st.showHtmlFile("no-KE.htm").replace("LINKBACK", "castlemagician/magician.htm")
            else:
                htmltext = st.showHtmlFile("no-KE.htm").replace("LINKBACK", "fortress/support_unit_captain.htm")
        st.exitQuest(1)
        return htmltext

QUEST = Quest(8005, qn, "custom")

for npc in [35648,35649,35650,35651,35652,35653,35654,35655,35656,35662,35694,35731,35763,35800,35831,35863,35900,35932,35970,36007,36039,36114,36145,36177,36215,36253,36290,36322,36360]:
    QUEST.addStartNpc(npc)
    QUEST.addTalkId(npc)
