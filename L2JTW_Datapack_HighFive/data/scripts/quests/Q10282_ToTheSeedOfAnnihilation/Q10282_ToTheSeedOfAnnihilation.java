package quests.Q10282_ToTheSeedOfAnnihilation;

import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.model.quest.State;

/**
 * To The Seed Of Annihilation (10282)
 * @author pmq
 */
public class Q10282_ToTheSeedOfAnnihilation extends Quest
{
	private static final String qn = "Q10282_ToTheSeedOfAnnihilation";
	// NPC
	private static final int KBALDIR = 32733;
	private static final int KLEMIS = 32734;
	// Item
	private static final int SOA_ORDERS = 15512;
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		String htmltext = event;
		QuestState st = player.getQuestState(qn);
		
		if (st == null)
			return htmltext;
		
		if (event.equalsIgnoreCase("32733-07.html"))
		{
			st.setState(State.STARTED);
			st.set("cond", "1");
			st.giveItems(SOA_ORDERS, 1);
			st.playSound("ItemSound.quest_accept");
		}
		if (event.equalsIgnoreCase("32734-02.html"))
		{
			st.giveItems(57, 212182);
			st.takeItems(SOA_ORDERS, 1);
			st.addExpAndSp(1148480, 99110);
			st.unset("cond");
			st.exitQuest(false);
			st.playSound("ItemSound.quest_finish");
		}
		return htmltext;
	}
	
	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = getNoQuestMsg(player);
		QuestState st = player.getQuestState(qn);
		
		if (st == null)
			return htmltext;
		
		if (npc.getNpcId() == KBALDIR)
		{
			switch (st.getState())
			{
				case State.CREATED:
				{
					if (player.getLevel() >= 84)
						htmltext = "32733-01.htm";
					else
						htmltext = "32733-00.htm";
					break;
				}
				case State.STARTED:
					htmltext = "32733-08.html";
					break;
				case State.COMPLETED:
					htmltext = "32733-09.html";
					break;
			}
		}
		
		if (npc.getNpcId() == KLEMIS)
		{
			switch (st.getState())
			{
				case State.COMPLETED:
					htmltext = "32734-03.html";
					break;
			}
			if (st.getInt("cond") == 1)
				htmltext = "32734-01.html";
		}
		return htmltext;
	}
	
	public Q10282_ToTheSeedOfAnnihilation(int questId, String name, String descr)
	{
		super(questId, name, descr);
		addStartNpc(KBALDIR);
		addTalkId(KBALDIR);
		addTalkId(KLEMIS);
		
		questItemIds = new int[] { SOA_ORDERS };
	}
	
	public static void main(String[] args)
	{
		new Q10282_ToTheSeedOfAnnihilation(10282, qn, "To the Seed of Annihilation");
	}
}