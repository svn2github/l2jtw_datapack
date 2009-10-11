# Made by DrLecter
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
from net.sf.l2j.gameserver.datatables import ItemTable
qn = "7000_HeroItems"
MONUMENTS=[31690]+range(31769,31773)

HERO_ITEMS={
6611:["weapon_the_sword_of_hero_i00","無限聖劍","致命攻擊時使目標防禦力下降。賦予裝備者還擊、提升HP/MP/CP最大值、提升盾牌防禦力的功能。提升PvP傷害。","379/169","單手劍"],
6612:["weapon_the_two_handed_sword_of_hero_i00","無限滅斬","致命攻擊時追加額外傷害。賦予裝備者機率性反射技能、提升HP/CP最大值、提升致命攻擊率與致命攻擊威力的功能。提升PvP傷害。","461/169","雙手劍"],
6613:["weapon_the_axe_of_hero_i00","無限霸斧","致命攻擊時使目標陷入混亂。賦予裝備者還擊、提升HP/MP/CP最大值、提升盾牌防禦機率的功能。提升PvP傷害。","379/169","單手鈍器"],
6614:["weapon_the_mace_of_hero_i00","無限神杖","施展魔法技能時將完全恢復目標的HP。賦予裝備者提升MP/CP最大值、施法速度、MP恢復速度的功能。PvP時提升所造成的傷害。","303/226","單手法杖"],
6615:["weapon_the_hammer_of_hero_i00","無限巨鎚","致命攻擊時使目標陷入休克。賦予裝備者機率性反射技能、提升HP/CP最大值、攻擊速度的功能。提升PvP傷害。","461/169","雙手鈍器"],
6616:["weapon_the_staff_of_hero_i00","無限魔杖","施展魔法技能時以一定的機率完全恢復目標的HP。賦予裝備者提升MP/CP最大值、魔法攻擊力、降低MP消耗量、提升魔法致命攻擊率、降低施法被中斷機率的功能。PvP時提升所造成的傷害。","369/226","雙手法杖"],
6617:["weapon_the_dagger_of_hero_i00","無限鬼殺","致命攻擊時使目標陷入沉默。賦予裝備者吸血怒擊、背擊時提升致命系列技能成功率、提升MP/CP最大值、提升攻擊速度、提升MP自然恢復能力的功能。提升PvP傷害。","332/169","匕首"],
6618:["weapon_the_fist_of_hero_i00","無限殛牙","致命攻擊時使目標陷入休克。賦予裝備者機率性反射技能、提升HP/MP/CP最大值、迴避能力的功能。提升PvP傷害。","461/169","拳套"],
6619:["weapon_the_bow_of_hero_i00","無限斷空","致命攻擊時使目標陷入移動速度下降的狀態。賦予裝備者節射、快速恢復、提升MP最大值的功能。提升PvP傷害。","707/169","弓"],
6620:["weapon_the_dualsword_of_hero_i00","無限鬥翼","致命攻擊時封印目標的物理技能。賦予裝備者機率性反射技能、提升HP/MP/CP最大值、致命攻擊率的功能。提升PvP傷害。","461/169","雙刀"],
6621:["weapon_the_pole_of_hero_i00","無限烈槍","致命攻擊時消除目標輔助狀態。賦予裝備者機率性反射技能、提升HP最大值、攻擊速度、命中能力的功能。提升PvP傷害。","379/169","槍"],
9388:["weapon_infinity_rapier_i00","無限瞬閃","致命攻擊時可向對方施展物理防禦力降低的詛咒魔法，並提升還擊護盾、提升 HP/CP最大值。PvP時提升所造成的傷害。\n致命攻擊時將會以一定的機率提升自己和隊伍成員們的物理攻擊力、魔法攻擊力和所受的治癒量，並發揮使用技能時降低MP消耗量的效果。","344/169","細劍"],
9389:["weapon_infinity_sword_i00","無限岩裂","致命攻擊時追加額外傷害。賦予裝備者機率性反射技能、提升HP/CP最大值、提升致命攻擊率與致命攻擊威力的功能。PvP時提升所造成的傷害。","410/169","古代劍"],
9390:["weapon_infinity_shooter_i00","無限追魂","致命攻擊時可向對方施展緩速魔法，使用技能時降低MP消耗量、提升 MP/CP 最大值。PvP時提升所造成的傷害。","405/169","弩"]
}

def render_list(mode,item) :
    html = "<html><body><font color=\"LEVEL\">英雄物品列表：</font><table border=0 width=120>"
    if mode == "list" :
       for i in HERO_ITEMS.keys() :
          html += "<tr><td width=35 height=45><img src=icon."+HERO_ITEMS[i][0]+" width=32 height=32 align=left></td><td valign=top><a action=\"bypass -h Quest 7000_HeroItems "+str(i)+"\"><font color=\"FFFFFF\">"+HERO_ITEMS[i][1]+"</font></a></td></tr>"
    else :
       html += "<tr><td align=left><font color=\"LEVEL\">物品名稱：</font></td><td align=right>\
<button value=返回 action=\"bypass -h Quest 7000_HeroItems buy\" width=40 height=15 back=L2UI_ct1.button_df fore=L2UI_ct1.button_df>\
</td><td width=5><br></td></tr></table><table border=0 bgcolor=\"000000\" width=500 height=160><tr><td valign=top>\
<table border=0><tr><td valign=top width=35><img src=icon."+HERO_ITEMS[item][0]+" width=32 height=32 align=left></td>\
<td valign=top width=400><table border=0 width=100%><tr><td><font color=\"FFFFFF\">"+HERO_ITEMS[item][1]+"</font></td>\
</tr></table></td></tr></table><br><font color=\"LEVEL\">物品資訊：</font>\
<table border=0 bgcolor=\"000000\" width=290 height=150><tr><td valign=top><font color=\"B09878\">"+HERO_ITEMS[item][2]+"</font>\
</td></tr><tr><td><br>類型："+HERO_ITEMS[item][4]+"<br>物攻/魔攻："+HERO_ITEMS[item][3]+"<br><br>\
<table border=0 width=300><tr><td align=center><button value=獲得 action=\"bypass -h Quest 7000_HeroItems _"+str(item)+"\" width=60 height=15 back=L2UI_ct1.button_df fore=L2UI_ct1.button_df></td></tr></table></td></tr></table></td></tr>"
    html += "</table></body></html>"
    return html

class Quest (JQuest) :

 def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

 def onAdvEvent (self,event,npc, player) :
     st = player.getQuestState(qn)
     if not st : return
     if player.isHero():
       if event == "buy" :
          htmltext=render_list("list",0)
       elif event.isdigit() and int(event) in HERO_ITEMS.keys():
          htmltext=render_list("item",int(event))
       elif event.startswith("_") :
          item = int(event.split("_")[1])
          if item == 6842:
            if st.getQuestItemsCount(6842):
               htmltext = "你已經擁有「命運之翼」了。"
            else :
               st.giveItems(item,1)
               htmltext = "請好好享受「命運之翼」的魅力吧。"
          else :
             for i in range(6611,6622)+range(9388,9391):
                if st.getQuestItemsCount(i):
                   st.exitQuest(1)
                   return "你已經擁有「"+HERO_ITEMS[i][1]+"」了。"
             st.giveItems(item,1)
             htmltext = "請好好享受「"+HERO_ITEMS[item][1]+"」的魅力吧。"
             st.playSound("ItemSound.quest_fanfare_2")
          st.exitQuest(1)
     return htmltext

 def onTalk (Self,npc,player):
     st = player.getQuestState(qn)
     htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
     if player.isHero():
        htmltext=render_list("list",0)
     elif player.isNoble():
        html = "<html><body>紀念塔：<br>因為你不是英雄，所以無法獲得神器。下次請務必為了英雄之名而奮戰。<br><a action=\"bypass -h npc_%objectId%_Chat 0\">返回</a></body></html>"
        htmltext = html.replace("%objectId%",str(npc.getObjectId()))
        st.exitQuest(1)
     else :
        st.exitQuest(1)
     return htmltext

QUEST       = Quest(-1,qn,"Hero Items")



for i in MONUMENTS:
    QUEST.addStartNpc(i)
    QUEST.addTalkId(i)
