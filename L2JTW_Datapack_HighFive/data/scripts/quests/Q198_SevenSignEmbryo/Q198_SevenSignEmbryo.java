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
package quests.Q198_SevenSignEmbryo;

import quests.Q197_SevenSignTheSacredBookOfSeal.Q197_SevenSignTheSacredBookOfSeal;

import com.l2jserver.gameserver.ai.CtrlIntention;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2MonsterInstance;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.model.quest.State;
import com.l2jserver.gameserver.network.serverpackets.NpcSay;

/**
 * @author Plim
 */

public class Q198_SevenSignEmbryo extends Quest
{
	private static final String qn = "198_SevenSignEmbryo";
	
	//NPCs
	private static final int WOOD = 32593;
	private static final int FRANZ = 32597;
	private static final int SHILENSEVIL1 = 27346;
	private static final int SHILENSEVIL2 = 27343;
	
	//ITEMS
	private static final int SCULPTURE = 14360;
	private static final int BRACELET = 15312;
	private static final int AA = 5575;
	
	//AA reward rate
	private static final int AARATE = 1;
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		String htmltext = event;
		QuestState st = player.getQuestState(qn);
		
		if (st == null)
			return htmltext;
		
		if (npc.getNpcId() == WOOD)
		{
			if (event.equalsIgnoreCase("32593-02.htm"))
			{
				st.setState(State.STARTED);
				st.set("cond", "1");
				st.playSound("ItemSound.quest_accept");
			}
		}
		
		else if (npc.getNpcId() == FRANZ)
		{
			if (event.equalsIgnoreCase("32597-10.htm"))
			{
				st.set("cond", "3");
				st.takeItems(SCULPTURE, 1);
				st.playSound("ItemSound.quest_middle");
			}
			
			else if (event.equalsIgnoreCase("32597-05.htm"))
			{
				L2MonsterInstance monster = (L2MonsterInstance) addSpawn(SHILENSEVIL1, -23801, -9004, -5385, 0, false, 0, false, npc.getInstanceId());
				monster.broadcastPacket(new NpcSay(monster.getObjectId(), 0, monster.getNpcId(), "You are not the owner of that item!"));
				monster.setRunning();
				monster.addDamageHate(player, 0, 999);
				monster.getAI().setIntention(CtrlIntention.AI_INTENTION_ATTACK, st.getPlayer());
				L2MonsterInstance monster1 = (L2MonsterInstance) addSpawn(SHILENSEVIL2, -23801, -9004, -5385, 0, false, 0, false, npc.getInstanceId());
				monster1.setRunning();
				monster1.addDamageHate(player, 0, 999);
				monster1.getAI().setIntention(CtrlIntention.AI_INTENTION_ATTACK, st.getPlayer());
				L2MonsterInstance monster2 = (L2MonsterInstance) addSpawn(SHILENSEVIL2, -23801, -9004, -5385, 0, false, 0, false, npc.getInstanceId());
				monster2.setRunning();
				monster2.addDamageHate(player, 0, 999);
				monster2.getAI().setIntention(CtrlIntention.AI_INTENTION_ATTACK, st.getPlayer());
			}
		}
		
		return htmltext;
	}
	
	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>";
		QuestState st = player.getQuestState(qn);
		QuestState fifth = player.getQuestState("197_SevenSignTheSacredBookOfSeal");
		
		if (st == null)
			return htmltext;
		
		if (npc.getNpcId() == WOOD)
		{
			switch (st.getState())
			{
				case State.CREATED:
					if (fifth != null && fifth.getState() == State.COMPLETED && player.getLevel() >= 79)
						htmltext = "32593-01.htm";
					else
					{
						htmltext = "32593-00.htm";
						st.exitQuest(true);
					}
					break;
				
				case State.STARTED:
					if (st.getInt("cond") == 1)
						htmltext = "32593-02.htm";
					
					else if (st.getInt("cond") == 3)
					{
						htmltext = "32593-04.htm";
						st.addExpAndSp(315108096,34906059);
						st.giveItems(BRACELET, 1);
						st.giveItems(AA, 1500000*AARATE);
						st.unset("cond");
						st.takeItems(SCULPTURE, 1);
						st.setState(State.COMPLETED);
						st.exitQuest(false);
						st.playSound("ItemSound.quest_finish");
					}
					break;
			}
		}
		
		else if (npc.getNpcId() == FRANZ)
		{
			if (st.getState() == State.STARTED)
			{
				if (st.getInt("cond") == 1)
					htmltext = "32597-01.htm";
				
				else if (st.getInt("cond") == 2)
					htmltext = "32597-06.htm";
				
				else if (st.getInt("cond") == 3)
					htmltext = "32597-11.htm";
			}
		}
		
		return htmltext;
	}
	
	@Override
	public String onKill(L2Npc npc, L2PcInstance player, boolean isPet)
	{
		QuestState st = player.getQuestState(qn);
		
		if (st == null)
			return super.onKill(npc, player, isPet);
		
		if (npc.getNpcId() == SHILENSEVIL1 && st.getInt("cond") == 1)
		{
			npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), player.getName() + "... You may have won this time... But next time, I will surely capture you!"));
			st.giveItems(SCULPTURE, 1);
			st.set("cond", "2");
			player.showQuestMovie(14);
		}
		
		return super.onKill(npc, player, isPet);
	}
	
	public Q198_SevenSignEmbryo(int questId, String name, String descr)
	{
		super(questId, name, descr);
		
		addStartNpc(WOOD);
		addTalkId(WOOD);
		addTalkId(FRANZ);
		addKillId(SHILENSEVIL1);
		addKillId(SHILENSEVIL2);
	}
	
	public static void main(String[] args)
	{
		new Q197_SevenSignTheSacredBookOfSeal(107, qn, "七封印，胚胎");
	}
}
