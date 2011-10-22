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
 * ­μ¦ν₯Α₯£Αυ
 */
package hellbound.InnerOasis;

import com.l2jserver.gameserver.instancemanager.HellboundManager;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;

/**
 * @author theOne
 */
public class InnerOasis extends Quest
{
	private static final int Native = 32357;

	private int badgesAmount = 0;

	public InnerOasis(int id, String name, String descr)
	{
		super(id, name, descr);
		addStartNpc(Native);
		addTalkId(Native);
		addFirstTalkId(Native);
	}

	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		QuestState st = player.getQuestState(getName());
		if (st == null)
			st = newQuestState(player);

		if (event.equalsIgnoreCase("FreeSlaves"))
		{
			long badges = st.getQuestItemsCount(9674);
			if (badges >= 5)
			{
				st.takeItems(9674, 5);
				badgesAmount++;
				if (badgesAmount == 6)
				{
					HellboundManager.getInstance().changeLevel(10);
					return "32357-4.htm";
				}
			}
			else
				return "32357-3.htm";
		}

		return null;
	}

	@Override
	public String onFirstTalk(L2Npc npc, L2PcInstance player)
	{
		QuestState st = player.getQuestState(getName());

		if (st == null)
			st = newQuestState(player);

		int hellboundLevel = HellboundManager.getInstance().getLevel();
		int x = npc.getX();
		int y = npc.getY();

		if (hellboundLevel == 9)
		{
			boolean xIsOk = false;
			for (int i = 4475; i <= 10960; i++)
			{
				if (i == x)
					xIsOk = true;
			}
			boolean yIsOk = false;
			for (int i = 247925; i <= 254415; i++)
			{
				if (i == y)
					yIsOk = true;
			}
			if (xIsOk && yIsOk)
				return "32357.htm";
		}
		else if (hellboundLevel < 9)
			return "32357-1.htm";
		else if (hellboundLevel > 9)
			return "32357-2.htm";

		return null;
	}

	public static void main(String[] args)
	{
		new InnerOasis(-1, "InnerOasis", "hellbound");
	}
}