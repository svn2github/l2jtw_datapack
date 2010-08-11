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
 * ºÖº¸§J
 */
package hellbound.Falk;

import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;

/**
 * @author theOne
 */
public class Falk extends Quest
{
	private static final int Falk = 32297;

	private static final int[] CaravanCertificates = {
			9850, 9851, 9852
	};

	public Falk(int id, String name, String descr)
	{
		super(id, name, descr);
		addStartNpc(Falk);
		addTalkId(Falk);
	}

	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		QuestState st = player.getQuestState(getName());

		if (st == null)
			st = newQuestState(player);

		boolean haveCertificates = false;
		for (int i : CaravanCertificates)
		{
			if (st.getQuestItemsCount(i) >= 1)
				haveCertificates = true;
		}

		if (haveCertificates)
			return "32297-1.htm";

		if (st.getQuestItemsCount(9674) >= 20)
		{
			st.takeItems(9674, 20);
			st.giveItems(9850, 1);
			return "32297-3.htm";
		}
		else
			return "32297-2.htm";
	}

	public static void main(String[] args)
	{
		new Falk(-1, "Falk", "hellbound");
	}
}