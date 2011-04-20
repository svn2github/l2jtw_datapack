/*
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 */
package custom.FortuneTelling;

import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.network.serverpackets.NpcHtmlMessage;

/**
 * @authors Kerberos (python), Nyaran (java)
 */
public class FortuneTelling extends Quest
{
	private static final String qn = "FortuneTelling";

	private static final int ADENA = 57;
	private static final int COST = 1000;

	private static final int NPC = 32616;

	private static final String[] FORTUNE =
	{
			"不得放鬆。",
			"笑容招來福氣。",
			"好消息正在等候。",
			"智謀雙全，事事順心。",
			"將會對周圍帶來幸運。",
			"從芝麻小事也可尋找快樂。",
			"自己的功勞將會轉讓給別人。",
			"休息，將會承諾更大的成長。",
			"自愛、謙虛才會帶來好結果。",
			"香甜口味的飲食將會帶來幸運。",
			"擅自處理事情，將會招來糾紛。",
			"可以期待明朗且有希望的未來。",
			"在偶然的機會下可以獲得好運。",
			"事情將會按照計畫的方向進行。",
			"人山人海之處，將會有幸運來臨。",
			"失去物質，卻得到精神方面的東西。",
			"窘困的生活中，紜會帶來滾滾財源。",
			"面對異性須保持風度，並踏上正道。",
			"就算一無所有，也可豐衣足食地過活。",
			"事情進展不順利，會造成煩躁和不安。",
			"徹底管理時間，便能得到期盼的結果。",
			"夙夜匪懈的促進工作，便能達到目標。",
			"待人忠厚，不論對同事，皆大歡喜之數。",
			"易於受到誘惑，需要注意感情上的控制。",
			"偶然相遇貴人，將會得到生活上的活力。",
			"或許會遇到困難，宜慎重考慮並堅定意志。",
			"過度的貪婪，伯將至今所累積的一掃而空。",
			"平常順利的事，經常也會有不如意的時候。",
			"獨自處理事情時，很容易陷入誘惑，須謹慎。",
			"不管面臨多麼困難的事情，萬事皆迎刃而解。",
			"光是發呆，只會引向自己不願意面對的狀況。",
			"得到精神上和物質上的幫助，馬到成功之運。",
			"和睦安定的生活中，期盼的事情將會圓滿如意。",
			"在意想不到的地方，將會得到金錢或新的機會。",
			"容易發生小小的意外和口角，須抱以寬容的心。",
			"遇到困境時，得到突如其來的幫助，將重尋希望。",
			"不投機取巧或耍手段而正當行事，便會得到幫助。",
			"不顧一切貪心地張羅事情，將會得到意外的結果。",
			"無法明確表達自己的意思，因此很容易產生誤會。",
			"稍一失神或過於安心便會失算，須保持冷靜的態度。",
			"保持圓滿的人際關係，便會遇上能讓你提高身價的人。",
			"播下多少的種，便會收穫多少，須按照計畫認真行事。",
			"中途放棄，便會導致難以妥善處理善後，須堅持到底。",
			"朝目標邁進的過程當中，或許會發生意想不到的問題。",
			"如果留戀眼前的小小利益，便會容易造成不自在的關係。",
			"事情逐漸好轉，但不得因此囂張，否則好運將離你而去。",
			"認真完成自己份內的事，便能羸得信賴，且能更上一層樓。",
			"與其滿足自己的貪念，不如先關懷他人，便會得到好結果。",
			"不論事情、興趣、職業、家人和戀人方面，皆會充滿幸運。",
			"若將自己的過失合理化，便會犯下無可挽回的更大的錯誤。",
			"因心軟可能會陷入困境，需要固執已見的時候，宜採取堅持態度。",
			"隨興決定的事情，只會造成精神上和金錢上的損失，需要有徹底的準備。",
			"若是為了脫離危險而使出的臨機應變，那麼須花費更大的心思來處理善後。",
			"就算進行的事情發生問題，亦勿採用權宜之計，須從問題的根本慢慢理清。",
			"若待人過度計較利害關係且沒風度，便會遭口舌之災，並扁低自己的價值。",
			"抱欲悠閒的心情，最好不要干涉不必要的他人問題。積少成多，芝麻小事也得珍惜。",
			"若面臨需要定下重要決策的時候，別在意他人的看法，宜正確掌握自己的意願來做決定。",
			"與熟人的交易，不僅讓你不好開口，還會造成頭痛因素，鄭重地推辭，並接受其他的機會。"
	};

	public FortuneTelling(int questId, String name, String descr)
	{
		super(questId, name, descr);
		addStartNpc(NPC);
		addTalkId(NPC);
	}

	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		QuestState st = player.getQuestState(qn);
		NpcHtmlMessage html = new NpcHtmlMessage(1);
		String PARENT_DIR = "data/scripts/custom/FortuneTelling/";
		
		if (st == null)
			return null;

		if (st.getQuestItemsCount(ADENA) < COST)
			html.setFile(player.getHtmlPrefix(), PARENT_DIR + "lowadena.htm");
		else
		{
			st.takeItems(ADENA, COST);
			html.setFile(player.getHtmlPrefix(), PARENT_DIR + "fortune.htm");
			html.replace("%fortune%", FORTUNE[st.getRandom(FORTUNE.length)]);
		}
		st.exitQuest(true);
		player.sendPacket(html);
		return null;
	}

	public static void main(String args[])
	{
		new FortuneTelling(-1, qn, "custom");
	}
}
