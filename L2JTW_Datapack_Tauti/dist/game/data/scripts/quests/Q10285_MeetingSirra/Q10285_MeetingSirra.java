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
package quests.Q10285_MeetingSirra;

import handlers.bypasshandlers.QuestLink;

import com.l2jserver.gameserver.instancemanager.InstanceManager;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.entity.Instance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.model.quest.State;

/**
 ** @author GKR
 **
 ** 2011-03-24
 */
public class Q10285_MeetingSirra extends Quest
{
	private static final String qn = "10285_MeetingSirra";
	// NPC's
	private static final int RAFFORTY = 32020;
	private static final int STEWARD = 32029;
	private static final int JINIA = 32760;
	private static final int KEGOR = 32761;
	private static final int SIRRA = 32762;
	private static final int JINIA2 = 32781;
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		String htmltext = event;
		QuestState st = player.getQuestState(qn);
		
		if (st == null)
			return htmltext;
		
		if (npc.getNpcId() == RAFFORTY)
		{
			if (event.equalsIgnoreCase("32020-05.htm"))
			{
				st.setState(State.STARTED);
				st.set("cond", "1");
				st.set("progress", "1");
				st.set("Ex", "0");
				st.playSound("ItemSound.quest_accept");
			}
		}
		
		else if (npc.getNpcId() == JINIA)
		{
			if (event.equalsIgnoreCase("32760-02.htm"))
			{
				st.set("Ex", "1");
				st.set("cond", "3");
				st.playSound("ItemSound.quest_middle");
			}
			
			else if (event.equalsIgnoreCase("spawn"))
			{
				st.set("Ex", "3");
				addSpawn(SIRRA, -23905,-8790,-5384,56238, false, 0, false, npc.getInstanceId());
				st.set("cond", "5");
				st.playSound("ItemSound.quest_middle");
				htmltext = "";
			}
			
			else if (event.equalsIgnoreCase("32760-12.htm"))
			{
				st.set("Ex", "5");
				st.set("cond", "7");
				st.playSound("ItemSound.quest_middle");
			}
			
			else if (event.equalsIgnoreCase("32760-14.htm"))
			{
				st.set("Ex", "0");
				st.set("progress", "2");
				st.playSound("ItemSound.quest_middle");
				
				// destroy instance after 1 min
				Instance inst = InstanceManager.getInstance().getInstance(npc.getInstanceId());
				inst.setDuration(60000);
				inst.setEmptyDestroyTime(0);
			}
		}
		
		else if (npc.getNpcId() == KEGOR)
		{
			if (event.equalsIgnoreCase("32761-02.htm"))
			{
				st.set("Ex", "2");
				st.set("cond", "4");
				st.playSound("ItemSound.quest_middle");
			}
		}
		
		else if (npc.getNpcId() == SIRRA)
		{
			if (event.equalsIgnoreCase("32762-08.htm"))
			{
				st.set("Ex", "4");
				st.set("cond", "6");
				st.playSound("ItemSound.quest_middle");
				npc.decayMe();
			}
		}
		
		else if (npc.getNpcId() == STEWARD)
		{
			if (event.equalsIgnoreCase("go"))
			{
				if (player.getLevel() >= 82)
				{
					player.teleToLocation(103045,-124361,-2768);
					htmltext = "";
				}
				else
					htmltext = "32029-01a";
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
		
		if (npc.getNpcId() == RAFFORTY)
		{
			switch (st.getState())
			{
				case State.CREATED:
					QuestState _prev = player.getQuestState("10284_AcquisitionOfDivineSword");
					if ((_prev != null) && (_prev.getState() == State.COMPLETED) && (player.getLevel() >= 82))
						htmltext = "32020-01.htm";
					else
						htmltext = "32020-03.htm";
					break;
				case State.STARTED:
					if (st.getInt("progress") == 1)
						htmltext = "32020-06.htm";
					else if (st.getInt("progress") == 2)
						htmltext = "32020-09.htm";
					else if (st.getInt("progress") == 3)
					{
						st.giveItems(57, 283425);
						st.addExpAndSp(939075, 83855);
						st.playSound("ItemSound.quest_finish");
						st.exitQuest(false);
						htmltext = "32020-10.htm";
					}
					break;
				case State.COMPLETED:
					htmltext = "32020-02.htm";
					break;
			}
		}
		
		else if (npc.getNpcId() == JINIA && st.getInt("progress") == 1)
		{
			switch (st.getInt("Ex"))
			{
				case 0:
					return "32760-01.htm";
				case 1:
					return "32760-03.htm";
				case 2:
					return "32760-04.htm";
				case 3:
					return "32760-07.htm";
				case 4:
					return "32760-08.htm";
				case 5:
					return "32760-13.htm";
			}
		}
		
		else if (npc.getNpcId() == KEGOR && st.getInt("progress") == 1)
		{
			switch (st.getInt("Ex"))
			{
				case 1:
					return "32761-01.htm";
				case 2:
					return "32761-03.htm";
				case 3:
					return "32761-04.htm";
			}
		}
		
		else if (npc.getNpcId() == SIRRA && st.getInt("progress") == 1)
		{
			switch (st.getInt("Ex"))
			{
				case 3:
					return "32762-01.htm";
				//case 4:
					//return "32762-09.htm";
			}
		}
		
		else if (npc.getNpcId() == STEWARD && st.getInt("progress") == 2)
		{
			htmltext = "32029-01.htm";
			st.set("cond", "8");
			st.playSound("ItemSound.quest_middle");
		}
		
		else if (npc.getNpcId() == JINIA2 && st.getInt("progress") == 2)
		{
			htmltext = "32781-01.htm";
			st.playSound("ItemSound.quest_middle");
		}
		
		return htmltext;
	}
	
	@Override
	public String onFirstTalk(L2Npc npc, L2PcInstance player)
	{
		if (npc.getNpcId() == SIRRA)
			QuestLink.showQuestWindow(player, npc);
		
		return null;
	}
	
	public Q10285_MeetingSirra(int questId, String name, String descr)
	{
		super(questId, name, descr);
		
		addStartNpc(RAFFORTY);
		addFirstTalkId(SIRRA);
		addTalkId(RAFFORTY);
		addTalkId(JINIA);
		addTalkId(JINIA2);
		addTalkId(KEGOR);
		addTalkId(SIRRA);
		addTalkId(STEWARD);
	}
	
	public static void main(String[] args)
	{
		new Q10285_MeetingSirra(10285, qn, "與希露見面");
	}
}