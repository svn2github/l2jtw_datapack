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
package quests.Q182_NewRecruits;

import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.model.quest.State;

/**
 ** @author Gnacik
 **
 ** 2010-10-15 Based on official server Naia
 */

public class Q182_NewRecruits extends Quest
{
	private static final String qn = "182_NewRecruits";
	// NPC's
	private static final int _kekropus = 32138;
	private static final int _nornil = 32258;
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		String htmltext = event;
		QuestState st = player.getQuestState(qn);
		
		if (st == null)
			return htmltext;
		
		if (npc.getNpcId() == _kekropus)
		{
			if (event.equalsIgnoreCase("32138-03.htm"))
			{
				st.setState(State.STARTED);
				st.set("cond", "1");
				st.playSound("ItemSound.quest_accept");
			}
		}
		else if (npc.getNpcId() == _nornil)
		{
			if (event.equalsIgnoreCase("32258-04.htm"))
			{
				st.giveItems(847, 2);
				st.playSound("ItemSound.quest_finish");
				st.exitQuest(false);
			}
			else if (event.equalsIgnoreCase("32258-05.htm"))
			{
				st.giveItems(890, 2);
				st.playSound("ItemSound.quest_finish");
				st.exitQuest(false);
			}
		}
		return htmltext;
	}
	
	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>";
		QuestState st = player.getQuestState(qn);
		if (st == null)
			return htmltext;
		
		if(player.getRace().ordinal() == 5)
			return "32138-00.htm";

		if (player.getLevel() < 17)
		{
			return "<html><body>長老凱克洛普斯：<br>我在尋找外來者來幫助我們一族的年輕人，您周圍有人選嗎？<br>（只有等級17以上、21以下且尚未完成一次轉職的闇天使種族以外的角色，才可以執行的任務。）</body></html>";
		}
		else
		{
			if (npc.getNpcId() == _kekropus)
			{
				switch(st.getState())
				{
					case State.CREATED :
							htmltext = "32138-01.htm";
						break;
					case State.STARTED :
						if (st.getInt("cond") == 1)
							htmltext = "32138-04.htm";
						break;
					case State.COMPLETED :
						htmltext = getAlreadyCompletedMsg(player);
						break;
				}
			}
			else if (npc.getNpcId() == _nornil && st.getState() == State.STARTED)
			{
				htmltext = "32258-01.htm";
			}
			else if (npc.getNpcId() == _nornil && st.getState() == State.COMPLETED)
			{
				htmltext = "32258-exit.htm";
			}
		}
		
		return htmltext;
	}
	
	public Q182_NewRecruits(int questId, String name, String descr)
	{
		super(questId, name, descr);
		
		addStartNpc(_kekropus);
		addTalkId(_kekropus);
		addTalkId(_nornil);
	}
	
	public static void main(String[] args)
	{
		new Q182_NewRecruits(182, qn, "募集幫手");
	}
}