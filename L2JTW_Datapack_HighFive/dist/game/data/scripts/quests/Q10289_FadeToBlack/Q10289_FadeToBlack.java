package quests.Q10289_FadeToBlack;

import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.model.quest.State;

/**
 * @author Plim
 */

public class Q10289_FadeToBlack extends Quest
{
	private static final String qn = "10289_FadeToBlack";
	
	// NPCs
	private static final int GREYMORE = 32757;
	
	// Items
	private static final int MARK_OF_DARKNESS = 15528;
	private static final int MARK_OF_SPLENDOR = 15527;

	//MOBs
	private static final int ANAYS = 25701;
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		String htmltext = event;
		QuestState st = player.getQuestState(qn);
		
		if (st == null)
			return htmltext;
		
		if (npc.getNpcId() == GREYMORE)
		{
			if (event.equalsIgnoreCase("32757-04.htm"))
			{
				st.setState(State.STARTED);
				st.set("cond", "1");
				st.playSound("ItemSound.quest_accept");
			}
			else if(isNumber(event) && st.getQuestItemsCount(MARK_OF_SPLENDOR) > 0)
			{
				int itemId = Integer.parseInt(event);
				st.takeItems(MARK_OF_SPLENDOR, 1);
				st.giveItems(itemId, 1);
				st.playSound("ItemSound.quest_finish");
				st.exitQuest(true);
				htmltext = "32757-08.htm";
			}
		}
		return htmltext;
	}
	
	private boolean isNumber(String str)
	{
		if (str == null || str.length() == 0)
			return false;
		
		for (int i = 0; i < str.length(); i++)
		{
			if (!Character.isDigit(str.charAt(i)))
				return false;
		}
		
		return true;
	}

	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = getNoQuestMsg(player);
		QuestState st = player.getQuestState(qn);
		QuestState secretMission = player.getQuestState("10288_SecretMission");
		if (st == null)
			return htmltext;
		
		if (npc.getNpcId() == GREYMORE)
		{
			switch(st.getState())
			{
				case State.CREATED :
					if (player.getLevel() >= 82 && secretMission != null && secretMission.getState() == State.COMPLETED)
						htmltext = "32757-02.htm";
					else if (player.getLevel() < 82)
						htmltext = "32757-00.htm";
					else
						htmltext = "32757-01.htm";
					break;
				case State.STARTED :
					if (st.getInt("cond") == 1)
						htmltext = "32757-04b.htm";
					if (st.getInt("cond") == 2)
					{
						htmltext = "32757-05.htm";
						player.addExpAndSp(55983, 136500);
						st.set("cond","1");
						st.playSound("ItemSound.quest_middle");
					}
					else if (st.getInt("cond") == 3)
						htmltext = "32757-06.htm";
					break;
			}
		}
		return htmltext;
	}
	
	@Override
	public String onKill(L2Npc npc, L2PcInstance player, boolean isPet)
	{
		if(player.getParty() == null)
		{
			QuestState st = player.getQuestState(qn);
			st.giveItems(MARK_OF_SPLENDOR, 1);
			st.playSound("ItemSound.quest_itemget");
			st.set("cond","3");
		}
		else
		{
			L2PcInstance partyMember = getRandomPartyMember(player,"1");
			QuestState st1 = partyMember.getQuestState(qn);
			st1.giveItems(MARK_OF_SPLENDOR, 1);
			st1.playSound("ItemSound.quest_itemget");
			st1.set("cond","3");
			
			
			QuestState st2;
			for(L2PcInstance pmember : player.getParty().getPartyMembers())
			{
				if(pmember.getObjectId() != partyMember.getObjectId() && st1.getInt("cond") == 1)
				{
					st2 = pmember.getQuestState(qn);
					st2.giveItems(MARK_OF_DARKNESS, 1);
					st2.playSound("ItemSound.quest_itemget");
					st2.set("cond","2");
				}
			}
		}

		return super.onKill(npc, player, isPet);
	}
	
	public Q10289_FadeToBlack(int questId, String name, String descr)
	{
		super(questId, name, descr);
		
		addStartNpc(GREYMORE);
		addTalkId(GREYMORE);
		addKillId(ANAYS);
	}
	
	public static void main(String[] args)
	{
		new Q10289_FadeToBlack(10289, qn, "消滅光明之人");
	}
}
