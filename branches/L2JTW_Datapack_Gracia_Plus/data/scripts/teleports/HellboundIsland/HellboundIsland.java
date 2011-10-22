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
package teleports.HellboundIsland;

import com.l2jserver.gameserver.instancemanager.HellboundManager;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.model.quest.State;

public class HellboundIsland extends Quest
{
	private final static int[] npcIds = {
			32314, 32315, 32316, 32317, 32318, 32319
	};

	public HellboundIsland(int questId, String name, String descr)
	{
		super(questId, name, descr);
		for (int id : npcIds)
		{
			addStartNpc(id);
			addFirstTalkId(id);
			addTalkId(id);
		}
	}

	@Override
	public String onFirstTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = "";
		boolean hellboundLock = HellboundManager.getInstance().isLocked();
		QuestState st1 = player.getQuestState("133_ThatsBloodyHot");
		QuestState st2 = player.getQuestState("130_PathToHellbound");
		if (st1 != null)
			npc.showChatWindow(player);
		else if (st2 != null)
		{
			if (hellboundLock)
				npc.showChatWindow(player);
			else
				htmltext = "warpgate-locked.htm";
		}
		else if (!hellboundLock)
			htmltext = "warpgate-locked.htm";
		else if (hellboundLock)
			npc.showChatWindow(player);
		return htmltext;
	}

	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = "";
		boolean hellboundLock = HellboundManager.getInstance().isLocked();
		QuestState st1 = player.getQuestState("133_ThatsBloodyHot");
		QuestState st2 = player.getQuestState("130_PathToHellbound");
		if (st1 != null)
		{
			if (st1.getState() == State.COMPLETED)
				player.teleToLocation(-11272, 236464, -3248);
			else
				htmltext = "cant-port.htm";
		}
		else if (st2 != null)
		{
			if (st2.getState() == State.COMPLETED && hellboundLock)
				player.teleToLocation(-11272, 236464, -3248);
			else
				htmltext = "cant-port.htm";
		}
		else
			htmltext = "cant-port.htm";
		return htmltext;
	}

	public static void main(String[] args)
	{
		new HellboundIsland(-1, "HellboundIsland", "teleports");
	}
}