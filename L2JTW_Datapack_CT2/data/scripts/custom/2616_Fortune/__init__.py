# pmq
import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "2616_Fortune"

#NPC
TELL = 32616

#ITEM
ADENA = 57

#Messages
TELL_MSG = ["和睦安定的生活中，期盼的事情將會圓滿如意。",\
            "不論事情、興趣、職業、家人和戀人方面，皆會充滿幸運。",\
            "香甜口味的飲食將會帶來幸運。",\
            "事情逐漸好轉，但不得因此囂張，否則好運將離你而去。",\
            "在意想不到的地方，將會得到金錢或新的機會。",\
            "待人忠厚，不論對同事，皆大歡喜之數。",\
            "智謀雙全，事事順心。",\
            "獨自處理事情時，很容易陷入誘惑，須謹慎。",\
            "若是為了脫離危險而使出的臨機應變，那麼須花費更大的心思來處理善後。",\
            "保持圓滿的人際關係，便會遇上能讓你提高身價的人。",\
            "遇到困境時，得到突如其來的幫助，將重尋希望。",\
            "因心軟可能會陷入困境，需要固執已見的時候，宜採取堅持態度。",\
            "中途放棄，便會導致難以妥善處理善後，須堅持到底。",\
            "就算進行的事情發生問題，亦勿採用權宜之計，須從問題的根本慢慢理清。",\
            "如果留戀眼前的小小利益，便會容易造成不自在的關係。",\
            "好消息正在等候。",\
            "或許會遇到困難，宜慎重考慮並堅定意志。",\
            "不管面臨多麼困難的事情，萬事皆迎刃而解。",\
            "自己的功勞將會轉讓給別人。",\
            "就算一無所有，也可豐衣足食地過活。",\
            "笑容招來福氣。",\
            "從芝麻小事也可尋找快樂。",\
            "事情進展不順利，會造成煩躁和不安。",\
            "休息，將會承諾更大的成長。",\
            "窘困的生活中，紜會帶來滾滾財源。",\
            "擅自處理事情，將會招來糾紛。",\
            "不得放鬆。",\
            "稍一失神或過於安心便會失算，須保持冷靜的態度。",\
            "隨興決定的事情，只會造成精神上和金錢上的損失，需要有徹底的準備。",\
            "可以期待明朗且有希望的未來。",\
            "若將自己的過失合理化，便會犯下無可挽回的更大的錯誤。",\
            "抱欲悠閒的心情，最好不要干涉不必要的他人問題。積少成多，芝麻小事也得珍惜。",\
            "不投機取巧或耍手段而正當行事，便會得到幫助。",\
            "與熟人的交易，不僅讓你不好開口，還會造成頭痛因素，鄭重地推辭，並接受其他的機會。",\
            "自愛、謙虛才會帶來好結果。",\
            "在偶然的機會下可以獲得好運。",\
            "不顧一切貪心地張羅事情，將會得到意外的結果。",\
            "若待人過度計較利害關係且沒風度，便會遭口舌之災，並扁低自己的價值。",\
            "徹底管理時間，便能得到期盼的結果。",\
            "人山人海之處，將會有幸運來臨。",\
            "認真完成自己份內的事，便能羸得信賴，且能更上一層樓。",\
            "失去物質，卻得到精神方面的東西。",\
            "易於受到誘惑，需要注意感情上的控制。",\
            "與其滿足自己的貪念，不如先關懷他人，便會得到好結果。",\
            "面對異性須保持風度，並踏上正道。",\
            "光是發呆，只會引向自己不願意面對的狀況。",\
            "容易發生小小的意外和口角，須抱以寬容的心。",\
            "將會對周圍帶來幸運。",\
            "播下多少的種，便會收穫多少，須按照計畫認真行事。",\
            "夙夜匪懈的促進工作，便能達到目標。",\
            "過度的貪婪，伯將至今所累積的一掃而空。",\
            "偶然相遇貴人，將會得到生活上的活力。",\
            "朝目標邁進的過程當中，或許會發生意想不到的問題。",\
            "事情將會按照計畫的方向進行。",\
            "得到精神上和物質上的幫助，馬到成功之運。",\
            "無法明確表達自己的意思，因此很容易產生誤會。",\
            "平常順利的事，經常也會有不如意的時候。",\
            "若面臨需要定下重要決策的時候，別在意他人的看法，宜正確掌握自己的意願來做決定。"]


class Quest (JQuest) :

 def __init__(self, id, name, descr) :
   JQuest.__init__(self, id, name, descr)

 def onEvent(self, event, st) :
   htmltext = event
   if event == "1" :
     if st.getQuestItemsCount(ADENA) >= 1000 :
        st.setState(State.STARTED) 
        st.takeItems(ADENA,1000)
        htmltext = st.showHtmlFile("32616-2.htm").replace("%msg%", str(TELL_MSG[st.getRandom(57)]))
        st.exitQuest(1)
     else :
        htmltext = "32616-0.htm"
        st.exitQuest(1)
   if event == "2" :
        htmltext = "32616-3.htm"
        st.exitQuest(1)
   return htmltext

 def onTalk(self, npc, player) :
   st = player.getQuestState(qn)
   htmltext = ""
   if not st: return htmltext

   npcId = npc.getNpcId()
   id = st.getState()
   if npcId == TELL :
     if id == State.CREATED :
        htmltext = "32616-1.htm"
   return htmltext

QUEST = Quest(2616,qn,"custom")

QUEST.addStartNpc(TELL)

QUEST.addTalkId(TELL)