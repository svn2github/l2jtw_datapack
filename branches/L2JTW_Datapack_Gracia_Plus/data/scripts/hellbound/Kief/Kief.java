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
 * 凱夫
 */
package hellbound.Kief;

import com.l2jserver.gameserver.instancemanager.HellboundManager;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;

/**
 * @author theOne
 */
public class Kief extends Quest
{
	private static final int Kief = 32354;

	private boolean checked = false;
	private int points = 0;

	public Kief(int id, String name, String descr)
	{
		super(id, name, descr);
		addStartNpc(Kief);
		addTalkId(Kief);
		addFirstTalkId(Kief);

		try
		{
			points = Integer.valueOf(loadGlobalQuestVar("life_points"));
		}
		catch (Exception e)
		{
		}

		saveGlobalQuestVar("life_points", String.valueOf(points));
		int hellboundLevel = HellboundManager.getInstance().getLevel();
		if (hellboundLevel == 7)
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

		if (event.equalsIgnoreCase("Badges"))
		{
			long badges = st.getQuestItemsCount(9674);    // 達里昂的許可證
			if (badges >= 1)
			{
				long trustam = (10 * badges);
				st.takeItems(9674, badges);
				HellboundManager.getInstance().increaseTrust((int) trustam);
				htmltext = "32354-7.htm";
			}
			else
				htmltext = "32354-8.htm";
		}
		else if (event.equalsIgnoreCase("bottle"))
		{
			htmltext = "32354-2.htm";
		}
		else if (event.equalsIgnoreCase("getbottle"))
		{
			long stinger = st.getQuestItemsCount(10012);  // 蠍子的毒針
			if (stinger >= 20)
			{
				st.takeItems(10012, 20);
				st.giveItems(9672, 1);                    // 魔法葫蘆
				htmltext = "32354-9.htm";
			}
			else
				htmltext = "32354-10.htm";
		}
		else if (event.equalsIgnoreCase("dlf"))
		{
			long dimlf = st.getQuestItemsCount(9680);     // 稀薄的魔法精氣
			if (dimlf >= 1)
			{
				long trustam = (10 * dimlf);
				st.takeItems(9680, dimlf);
				HellboundManager.getInstance().increaseTrust((int) trustam);
				points += trustam;
				saveGlobalQuestVar("life_points", String.valueOf(points));
				htmltext = "32354-7.htm";
			}
			else
				htmltext = "32354-11.htm";
		}
		else if (event.equalsIgnoreCase("lf"))
		{
			long lifef = st.getQuestItemsCount(9681);     // 魔法精氣
			if (lifef >= 1)
			{
				long trustam = (20 * lifef);
				st.takeItems(9681, lifef);
				HellboundManager.getInstance().increaseTrust((int) trustam);
				points += trustam;
				saveGlobalQuestVar("life_points", String.valueOf(points));
				htmltext = "32354-7.htm";
			}
			else
				htmltext = "32354-11.htm";
		}
		else if (event.equalsIgnoreCase("clf"))
		{
			long conlf = st.getQuestItemsCount(9682);     // 保存的魔法精氣
			if (conlf >= 1)
			{
				long trustam = (50 * conlf);
				st.takeItems(9682, conlf);
				HellboundManager.getInstance().increaseTrust((int) trustam);
				points += trustam;
				saveGlobalQuestVar("life_points", String.valueOf(points));
				htmltext = "32354-7.htm";
			}
			else
				htmltext = "32354-11.htm";
		}
		else if (event.equalsIgnoreCase("CheckPoints"))
		{
			if (!checked && points >= 1000000)
			{
				checked = true;
				HellboundManager.getInstance().changeLevel(8);
				points = 0;
				saveGlobalQuestVar("life_points", String.valueOf(points));
				cancelQuestTimers("CheckPoints");
			}
		}

		return htmltext;
	}

	@Override
	public String onFirstTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = "";
		QuestState st = player.getQuestState(getName());
		if (st == null)
			st = newQuestState(player);

		int hellboundLevel = HellboundManager.getInstance().getLevel();
		if (hellboundLevel < 2)
			htmltext = "32354-3.htm";
		else if (hellboundLevel == 2 || hellboundLevel == 3)
			htmltext = "32354.htm";
		else if (hellboundLevel == 4)
			htmltext = "32354-4.htm";
		else if (hellboundLevel == 5)
			htmltext = "32354-5.htm";
		else if (hellboundLevel == 6)
			htmltext = "32354-6.htm";
		else if (hellboundLevel == 7)
			htmltext = "32354-1.htm";
		else if (hellboundLevel >= 8)
			htmltext = "32354-2.htm";

		return htmltext;
	}

	public static void main(String[] args)
	{
		new Kief(-1, "Kief", "hellbound");
	}
}