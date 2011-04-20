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
 * 加勒蒂
 */
package hellbound.Galate;

import com.l2jserver.gameserver.instancemanager.HellboundManager;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;

/**
 * @author theOne
 */
public class Galate extends Quest
{
	private static final int Galate = 32292;

	private boolean checked = false;
	private int points = 0;

	public Galate(int id, String name, String descr)
	{
		super(id, name, descr);
		addStartNpc(Galate);
		addTalkId(Galate);
		addFirstTalkId(Galate);

		try
		{
			points = Integer.valueOf(loadGlobalQuestVar("life_points"));
		}
		catch (Exception e)
		{
		}

		saveGlobalQuestVar("life_points", String.valueOf(points));
		int hellboundLevel = HellboundManager.getInstance().getLevel();
		if (hellboundLevel == 0)
			startQuestTimer("CheckPoints", 180000, null, null, true);
	}

	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{

		String htmltext = "";
		QuestState st = null;

		if (player != null)
		{
			st = player.getQuestState(getName());

			if (st == null)
				st = newQuestState(player);
		}

		if (event.equalsIgnoreCase("cf"))
		{
			long CF = st.getQuestItemsCount(9693);  // 水晶碎片
			if (CF >= 1)
			{
				long trustam = (10 * CF);
				st.takeItems(9693, CF);
				HellboundManager.getInstance().increaseTrust((int) trustam);
				points += trustam;
				saveGlobalQuestVar("life_points", String.valueOf(points));
				htmltext = "<html><body>加勒蒂：<br>多謝您的貢獻，解開地獄邊界之路不遠了！</body></html>";
			}
			else
				htmltext = "<html><body>加勒蒂：<br>很抱歉，您好像沒有這個東西呢？</body></html>";
		}
		else if (event.equalsIgnoreCase("bc"))
		{
			long BC = st.getQuestItemsCount(9695);  // 湛藍水晶
			if (BC >= 1)
			{
				long trustam = (200 * BC);
				st.takeItems(9695, BC);
				HellboundManager.getInstance().increaseTrust((int) trustam);
				points += trustam;
				saveGlobalQuestVar("life_points", String.valueOf(points));
				htmltext = "<html><body>加勒蒂：<br>多謝您的貢獻，解開地獄邊界之路不遠了！</body></html>";
			}
			else
				htmltext = "<html><body>加勒蒂：<br>很抱歉，您好像沒有這個東西呢？</body></html>";
		}
		else if (event.equalsIgnoreCase("rc"))
		{
			long RC = st.getQuestItemsCount(9696);  // 赤紅水晶
			if (RC >= 1)
			{
				long trustam = (200 * RC);
				st.takeItems(9696, RC);
				HellboundManager.getInstance().increaseTrust((int) trustam);
				points += trustam;
				saveGlobalQuestVar("life_points", String.valueOf(points));
				htmltext = "<html><body>加勒蒂：<br>多謝您的貢獻，解開地獄邊界之路不遠了！</body></html>";
			}
			else
				htmltext = "<html><body>加勒蒂：<br>很抱歉，您好像沒有這個東西呢？</body></html>";
		}
		else if (event.equalsIgnoreCase("cc"))
		{
			long CC = st.getQuestItemsCount(9697);  // 透明水晶
			if (CC >= 1)
			{
				long trustam = (200 * CC);
				st.takeItems(9697, CC);
				HellboundManager.getInstance().increaseTrust((int) trustam);
				points += trustam;
				saveGlobalQuestVar("life_points", String.valueOf(points));
				htmltext = "<html><body>加勒蒂：<br>多謝您的貢獻，解開地獄邊界之路不遠了！</body></html>";
			}
			else
				htmltext = "<html><body>加勒蒂：<br>很抱歉，您好像沒有這個東西呢？</body></html>";
		}
		else if (event.equalsIgnoreCase("CheckPoints"))
		{
			if (!checked && points >= 100000)
			{
				checked = true;
				HellboundManager.getInstance().changeLevel(1);
				points = 0;
				saveGlobalQuestVar("life_points", String.valueOf(points));
				cancelQuestTimers("CheckPoints");
			}
		}

		return htmltext;
	}
	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = "";
		int hellboundLevel = HellboundManager.getInstance().getLevel();
		if (hellboundLevel == 0)
			htmltext = "32292-2.htm";

		return htmltext;
	}

	@Override
	public String onFirstTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = "";

		int hellboundLevel = HellboundManager.getInstance().getLevel();
		if (hellboundLevel == 0)
			htmltext = "32292.htm";
		else if (hellboundLevel >= 1)
			htmltext = "32292-1.htm";

		return htmltext;
	}

	public static void main(String[] args)
	{
		new Galate(-1, "Galate", "hellbound");
	}
}