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
package custom.PinsAndPouchUnseal;

import net.sf.l2j.gameserver.model.actor.L2Npc;
import net.sf.l2j.gameserver.model.actor.instance.L2PcInstance;
import net.sf.l2j.gameserver.model.quest.Quest;
import net.sf.l2j.gameserver.model.quest.QuestState;

public class PinsAndPouchUnseal extends Quest
{
	private final static int[] NPCs =
	{
		32610,32612
	};

	private final static int[] PINS_C =
	{
		13902,13903,13904,13905
	};

	private final static int[] PINS_B =
	{
		13906, 13907, 13908, 13909
	};

	private final static int[] PINS_A =
	{
		13910, 13911, 13912, 13913
	};

	private final static int[] PINS_S =
	{
		13914, 13915, 13916, 13917
	};

	private final static int[] POUCHS_C =
	{
		13922, 13923, 13924, 13925
	};

	private final static int[] POUCHS_B =
	{
		13926, 13927, 13928, 13929
	};

	private final static int[] POUCHS_A =
	{
		13930, 13931, 13932, 13933
	};

	private final static int[] POUCHS_S =
	{
		13934, 13935, 13936, 13937
	};

	public PinsAndPouchUnseal(int questId, String name, String descr)
	{
		super(questId, name, descr);
		for (int id : NPCs)
		{
			addStartNpc(id);
			addTalkId(id);
		}
	}

	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		String htmltext = "";
		QuestState st = player.getQuestState(getName());

		htmltext = event;
		if (event.equalsIgnoreCase("c_grade_pin"))
		{
			if (st.getQuestItemsCount(13898) > 0)
			{
				if (st.getQuestItemsCount(57) > 3200)
				{
					st.takeItems(57, 3200);
					st.takeItems(13898, 1);
					st.giveItems(PINS_C[st.getRandom((PINS_C).length)], 1);
					htmltext = "";
				}
				else
					htmltext = npc.getNpcId() + "-5.htm";
			}
			else
				htmltext = npc.getNpcId() + "-4.htm";
			st.exitQuest(true);
		}
		else if (event.equalsIgnoreCase("b_grade_pin"))
		{
			if (st.getQuestItemsCount(13899) > 0)
			{
				if (st.getQuestItemsCount(57) > 11800)
				{
					st.takeItems(57, 11800);
					st.takeItems(13899, 1);
					st.giveItems(PINS_C[st.getRandom((PINS_B).length)], 1);
					htmltext = "";
				}
				else
					htmltext = npc.getNpcId() + "-5.htm";
			}
			else
				htmltext = npc.getNpcId() + "-4.htm";
			st.exitQuest(true);
		}
		else if (event.equalsIgnoreCase("a_grade_pin"))
		{
			if (st.getQuestItemsCount(13900) > 0)
			{
				if (st.getQuestItemsCount(57) > 26500)
				{
					st.takeItems(57, 26500);
					st.takeItems(13900, 1);
					st.giveItems(PINS_C[st.getRandom((PINS_A).length)], 1);
					htmltext = "";
				}
				else
					htmltext = npc.getNpcId() + "-5.htm";
			}
			else
				htmltext = npc.getNpcId() + "-4.htm";
			st.exitQuest(true);
		}
		else if (event.equalsIgnoreCase("s_grade_pin"))
		{
			if (st.getQuestItemsCount(13901) > 0)
			{
				if (st.getQuestItemsCount(57) > 136600)
				{
					st.takeItems(57, 136600);
					st.takeItems(13901, 1);
					st.giveItems(PINS_C[st.getRandom((PINS_S).length)], 1);
					htmltext = "";
				}
				else
					htmltext = npc.getNpcId() + "-5.htm";
			}
			else
				htmltext = npc.getNpcId() + "-4.htm";
			st.exitQuest(true);
		}
		else if (event.equalsIgnoreCase("c_grade_pouch"))
		{
			if (st.getQuestItemsCount(13918) > 0)
			{
				if (st.getQuestItemsCount(57) > 2600)
				{
					st.takeItems(57, 2600);
					st.takeItems(13918, 1);
					st.giveItems(PINS_C[st.getRandom((POUCHS_C).length)], 1);
					htmltext = "";
				}
				else
					htmltext = npc.getNpcId() + "-5.htm";
			}
			else
				htmltext = npc.getNpcId() + "-4.htm";
			st.exitQuest(true);
		}
		else if (event.equalsIgnoreCase("b_grade_pouch"))
		{
			if (st.getQuestItemsCount(13919) > 0)
			{
				if (st.getQuestItemsCount(57) > 9400)
				{
					st.takeItems(57, 9400);
					st.takeItems(13919, 1);
					st.giveItems(PINS_C[st.getRandom((POUCHS_B).length)], 1);
					htmltext = "";
				}
				else
					htmltext = npc.getNpcId() + "-5.htm";
			}
			else
				htmltext = npc.getNpcId() + "-4.htm";
			st.exitQuest(true);
		}
		else if (event.equalsIgnoreCase("a_grade_pouch"))
		{
			if (st.getQuestItemsCount(13920) > 0)
			{
				if (st.getQuestItemsCount(57) > 21200)
				{
					st.takeItems(57, 21200);
					st.takeItems(13920, 1);
					st.giveItems(PINS_C[st.getRandom((POUCHS_A).length)], 1);
					htmltext = "";
				}
				else
					htmltext = npc.getNpcId() + "-5.htm";
			}
			else
				htmltext = npc.getNpcId() + "-4.htm";
			st.exitQuest(true);
		}
		else if (event.equalsIgnoreCase("s_grade_pouch"))
		{
			if (st.getQuestItemsCount(13921) > 0)
			{
				if (st.getQuestItemsCount(57) > 109300)
				{
					st.takeItems(57, 109300);
					st.takeItems(13921, 1);
					st.giveItems(PINS_C[st.getRandom((POUCHS_S).length)], 1);
					htmltext = "";
				}
				else
					htmltext = npc.getNpcId() + "-5.htm";
			}
			else
				htmltext = npc.getNpcId() + "-4.htm";
			st.exitQuest(true);
		}

		return htmltext;
	}

	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = "";
		htmltext = npc.getNpcId() + "-1.htm";

		return htmltext;
	}

	public static void main(String[] args)
	{
		new PinsAndPouchUnseal(-1, "PinsAndPouchUnseal", "custom");
	}
}