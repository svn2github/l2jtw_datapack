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
/**
 * 波拿得
 */
package hellbound.Bernarde;

import com.l2jserver.gameserver.instancemanager.HellboundManager;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;

/**
 * @author theOne
 */
public class Bernarde extends Quest
{
	private static final int Bernarde = 32300;

	private int condition = 0;

	public Bernarde(int id, String name, String descr)
	{
		super(id, name, descr);
		addStartNpc(Bernarde);
		addTalkId(Bernarde);
		addFirstTalkId(Bernarde);
	}

	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		QuestState st = player.getQuestState(getName());
		if (st == null)
			st = newQuestState(player);

		if (event.equalsIgnoreCase("HolyWater"))
		{
			long BadgesCount = st.getQuestItemsCount(9674);
			if (BadgesCount < 5)
				return "<html><body>波拿得:<br>很抱歉，你沒有足夠達里昂的許可證。</body></html>";
			st.takeItems(9674, 5);
			st.giveItems(9673, 1);
			return "<html><body>波拿得:<br>在這裡。現在，請說明我們沉睡的祖先和安息的世界！</body></html>";
		}
		else if (event.equalsIgnoreCase("Treasure"))
		{
			if (condition == 1)
				return "<html><body>波拿得:<br>看來你已經賜予我的財富嗎？</body></html>";
			long treasures = st.getQuestItemsCount(9684);
			if (treasures < 1)
				return "<html><body>波拿得:<br>哦，寶物在哪裡嗎？</body></html>";
			st.takeItems(9684, 1);
			condition = 1;
			return "<html><body>波拿得:<br>謝謝你！這珍惜當地人很說明。</body></html>";
		}
		else if (event.equalsIgnoreCase("rumors"))
		{
			int hLevel = HellboundManager.getInstance().getLevel();
			if (hLevel == 6)
				return "<html><body>波拿得:<br>最近惡魔都非常積極的魔法陣。一定有什麼地方會為他們增加這方面的安全。你會調查嗎？也許你會發現一些能夠幫助我們減少巴列斯的力量。</body></html>";
			if (hLevel == 7)
				return "<html><body>波拿得:<br>我知道，為什麼地政剩下虐待，甚至大篷車為什麼放棄希望都不敢去那裡。也許，當你將準備好了，你會想找出是否獨立？說話時，卻是可以使用魔法瓶，收集靈魂的怪物的魔法在同一隊列是非常重視的海外魔法師。為什麼不能讓你嘗試？</body></html>";
			if (hLevel == 8)
				return "<html><body>波拿得:<br>我聽說原住民居住的大陸已被迫離開回到外部鋼鐵之城！阿門是通過違反現在只是時間的問題。誠然，一前豎立一個敵對隊長加強門，但協會的力量，必須有足夠的，甚至與他的管理！</body></html>";
			if (hLevel == 9)
				return "<html><body>波拿得:<br>有很多的達里昂的追隨者在鋼鐵之城，我們更容易從它不會成為。我們必須找到一個方法來殺死所有的他們！</body></html>";
			if (hLevel == 10)
				return "<html><body>波拿得:<br>我聽說居民中的大陸和阻力都深深感動了，鋼鐵之城內部。哦，這該死地球最終可以看到夕陽的一個新的時代！在我眼中的淚水就從一個被堆積起來的想法啦！但是，儘管它是慶祝的時候 - 我們必須去幫助我們的兄弟在一座城堡。</body></html>";
			if (hLevel == 11)
				return "<html><body>波拿得:<br>現在，我們必須打敗巴列斯和達里昂。而且，是為了恢復這片大地的和平。</body></html>";
		}
		else if (event.equalsIgnoreCase("alreadysaid"))
			return "<html><body>波拿得:<br>我說夠了，現在我必須回去工作。請幫助把其餘的我的祖先是在廢墟中發酵的古剎。</body></html>";
		else if (event.equalsIgnoreCase("abouthelp"))
			return "<html><body>波拿得:<br>初代祭司長 戴瑞克是顯而易見的，不時出現在廢墟中的古剎。如何悲慘，他的精神仍漫遊在那裡，不能休息！雖然他發酵，我很害怕，但永遠不會成為世界之間的寺廟和當地村莊 ...</body></html>";
		else if (event.equalsIgnoreCase("quarry"))
			return "<html><body>波拿得:<br>他們說的是採石場奴隸被迫工作生涯。如果您將能夠拯救他們，而不是一個馬幫是在所有同意進入當地。請幫助我們採石場奴隸得到自由！</body></html>";

		return null;
	}

	@Override
	public String onFirstTalk(L2Npc npc, L2PcInstance player)
	{
		QuestState st = player.getQuestState(getName());
		if (st == null)
			st = newQuestState(player);

		int hellboundLevel = HellboundManager.getInstance().getLevel();
		if (hellboundLevel < 2)
			return "<html><body>波拿得:<br>你是誰？你們是從大陸地方來的。你已經拿走了我們的所有，還要什麼呢！快點滾吧，回復我們地方的寧靜！</body></html>";
		else if (hellboundLevel == 2)
		{
			if (!player.isTransformed())
				return "<html><body>波拿得:<br>你是誰？你們是從大陸地方來的。你已經拿走了我們的所有，還要什麼呢！快點滾吧，回復我們地方的寧靜！</body></html>";
			if (player.getTransformation().getId() != 101)
				return "<html><body>波拿得:<br>你是誰？你們是從大陸地方來的。你已經拿走了我們的所有，還要什麼呢！快點滾吧，回復我們地方的寧靜！</body></html>";
			return "32300.htm";
		}
		else if (hellboundLevel == 3)
		{
			if (!player.isTransformed())
				return "<html><body>波拿得:<br>是他啊，從大陸來到我們的土地。看來你的實力相當強大。</body></html>";
			if (player.getTransformation().getId() != 101)
				return "<html><body>波拿得:<br>是他啊，從大陸來到我們的土地。看來你的實力相當強大。</body></html>";
			return "32300-2.htm";
		}
		else if (hellboundLevel == 4)
		{
			if (!player.isTransformed())
				return "32300-5.htm";
			if (player.getTransformation().getId() != 101)
				return "32300-5.htm";
			return "32300-4.htm";
		}
		else if (hellboundLevel == 5)
		{
			if (!player.isTransformed())
				return "32300-6.htm";
			if (player.getTransformation().getId() != 101)
				return "32300-6.htm";
			return "<html><body>波拿得:<br>啊，很高興上次的幫助，我的朋友！謝謝你們，超度戴瑞克的心靈，達到涅槃。現在原住民村莊在居民的守護下。</body></html>";
		}
		else if (hellboundLevel >= 6)
		{
			if (!player.isTransformed())
				return "32300-3.htm";
			if (player.getTransformation().getId() != 101)
				return "32300-3.htm";
			return "32300-7.htm";
		}

		return null;
	}

	public static void main(String[] args)
	{
		new Bernarde(-1, "Bernarde", "hellbound");
	}
}
