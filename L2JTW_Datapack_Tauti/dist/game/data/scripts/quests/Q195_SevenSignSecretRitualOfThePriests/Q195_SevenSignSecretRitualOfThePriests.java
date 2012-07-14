package quests.Q195_SevenSignSecretRitualOfThePriests;

import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.model.quest.State;

/**
 * @author Plim
 * Update by pmq High Five 24-10-2011
 */

public class Q195_SevenSignSecretRitualOfThePriests extends Quest
{
	private static final String qn = "195_SevenSignSecretRitualOfThePriests";
	
	//NPCs
	private static final int CLAUDIA = 31001;
	private static final int JOHN = 32576;
	private static final int RAYMOND = 30289;
	private static final int IASON_HEINE = 30969;
	private static final int SHELF = 32580;
	
	//ITEMS
	private static final int SHUNAIMAN_CONTRACT = 13823;
	private static final int IDENTITY_CARD = 13822;
	
	//SKILLS
	private static final int GUARD_DAWN = 6204;
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		String htmltext = event;
		QuestState st = player.getQuestState(qn);
		
		if (st == null)
			return "<html><body>目前沒有執行任務，或條件不符。</body></html>";
		
		if (event.equalsIgnoreCase("31001-05.htm"))
		{
			if (st.getInt("cond") == 0)
			{
				st.set("cond", "1");
				st.setState(State.STARTED);
				st.playSound("ItemSound.quest_accept");
			}
		}
		else if (event.equalsIgnoreCase("32576-02.htm"))
		{
			if (st.getInt("cond") == 1)
			{
				st.giveItems(IDENTITY_CARD,1);
				st.set("cond","2");
				st.playSound("ItemSound.quest_middle");
			}
		}
		else if (event.equalsIgnoreCase("30289-04.htm"))
		{
			if (st.getInt("cond") == 2)
			{
				st.set("cond","3");
				player.stopAllEffects();
				SkillTable.getInstance().getInfo(GUARD_DAWN,1).getEffects(player,player);
			}
		}
		else if (event.equalsIgnoreCase("30289-07.htm"))
		{
			if (st.getInt("cond") == 3)
			{
				SkillTable.getInstance().getInfo(GUARD_DAWN,1).getEffects(player,player);
			}
		}
		else if (event.equalsIgnoreCase("30289-08.htm"))
		{
			if (st.getInt("cond") == 3)
			{
				player.stopAllEffects();
			}
		}
		else if (event.equalsIgnoreCase("30289-11.htm"))
		{
			if (st.getInt("cond") == 3)
			{
				st.set("cond","4");
				st.playSound("ItemSound.quest_middle");
				player.stopAllEffects();
			}
		}
		else if (event.equalsIgnoreCase("30969-03.htm"))
		{
			if (st.getInt("cond") == 4)
			{
				st.addExpAndSp(25000000, 2500000);
				st.unset("cond"); 
				st.exitQuest(false);
				st.playSound("ItemSound.quest_finish");
			}
		}
		else if (event.equalsIgnoreCase("32580-02.htm"))
		{
			if (st.getInt("cond") == 3 && !st.hasQuestItems(SHUNAIMAN_CONTRACT))
			{
				st.giveItems(SHUNAIMAN_CONTRACT,1);
				st.playSound("ItemSound.quest_middle");
			}
		}
		
		return htmltext;
	}

	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>";
		QuestState st = player.getQuestState(qn);
		QuestState contractOfMammon = player.getQuestState("194_SevenSignContractOfMammon");
		
		if (st == null)
			return htmltext;
		
		if (npc.getNpcId() == CLAUDIA)
		{
			switch (st.getState())
			{
				case State.CREATED:
					if (contractOfMammon.getState() == State.COMPLETED && st.getInt("cond") == 0 && player.getLevel() >= 79)
						htmltext = "31001-01.htm";
					else
					{
						htmltext = "31001-00.htm";
						st.exitQuest(true);
					}
					break;
				case State.STARTED:
					if (st.getInt("cond") == 1)
						htmltext = "31001-06.htm";
					break;
				case State.COMPLETED:
					htmltext = "<html><body>這是已經完成的任務。</body></html>";
			}
		}
		else if (npc.getNpcId() == JOHN)
		{
			if (st.getInt("cond") == 1)
				htmltext = "32576-01.htm";
			else if (st.getInt("cond") == 2)
				htmltext = "32576-03.htm";
		}
		else if (npc.getNpcId() == RAYMOND)
		{
			if (st.getInt("cond") == 1 || st.getInt("cond") == 2)
				htmltext = "30289-01.htm";
			else if (st.getInt("cond") == 3)
			{
				if (st.hasQuestItems(SHUNAIMAN_CONTRACT))
					htmltext = "30289-09.htm";
				else
					htmltext = "30289-06.htm";
			}
			else if (st.getInt("cond") == 4)
				htmltext = "30289-12.htm";
		}
		else if (npc.getNpcId() == IASON_HEINE)
		{
			if (st.getInt("cond") == 4)
				htmltext = "30969-01.htm";
		}
		else if (npc.getNpcId() == SHELF)
		{
			if (st.getInt("cond") == 3)
				htmltext = "32580-01.htm";
		}
		return htmltext;
	}

	public Q195_SevenSignSecretRitualOfThePriests(int questId, String name, String descr)
	{
		super(questId, name, descr);
		
		addStartNpc(CLAUDIA);
		addTalkId(CLAUDIA);
		addTalkId(JOHN);
		addTalkId(RAYMOND);
		addTalkId(IASON_HEINE);
		addTalkId(SHELF);

		questItemIds = new int[]
		{ SHUNAIMAN_CONTRACT, IDENTITY_CARD };
	}
	
	public static void main(String[] args)
	{
		new Q195_SevenSignSecretRitualOfThePriests(195, qn, "七封印，祭司們的祕密儀式");
	}
}