package quests.Q195_SevenSignSecretRitualOfThePriests;

import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.model.quest.State;

/**
 * @author Plim
 * Update by pmq High Five 12-06-2011
 */

public class Q195_SevenSignSecretRitualOfThePriests extends Quest
{
	private static final String qn = "195_SevenSignSecretRitualOfThePriests";
	
	//NPCs
	private static final int CLAUDIA       = 31001;
	private static final int JOHN          = 32576;
	private static final int RAYMOND       = 30289;
	private static final int IASON_HEINE   = 30969;
	private static final int SHELF         = 32580;  // 黎明的書櫃
	
	//ITEMS
	private static final int SHUNAIMAN_CONTRACT = 13823;
	private static final int IDENTITY_CARD = 13822;
	
	//SKILLS
	private static final int GUARD_DAWN = 6204;
	
	@Override
	public final String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		QuestState st = player.getQuestState(qn);
		
		if (st == null)
			return "<html><body>目前沒有執行任務，或條件不符。</body></html>";
		
		final int cond = st.getInt("cond");
		if (event.equalsIgnoreCase("31001-05.htm"))
		{
			if (cond == 0)
			{
				st.set("cond", "1");
				st.setState(State.STARTED);
				st.playSound("ItemSound.quest_accept");
			}
		}
		else if (event.equalsIgnoreCase("32576-02.htm"))
		{
			if (cond == 1)
			{
				st.giveItems(IDENTITY_CARD,1);
				st.set("cond","2");
				st.playSound("ItemSound.quest_middle");
			}
		}
		else if (event.equalsIgnoreCase("30289-04.htm"))
		{
			if (cond == 2)
			{
				st.set("cond","3");
				player.stopAllEffects();
				SkillTable.getInstance().getInfo(GUARD_DAWN,1).getEffects(player,player);
			}
		}
		else if (event.equalsIgnoreCase("30289-07.htm"))
		{
			if (cond == 3)
			{
				SkillTable.getInstance().getInfo(GUARD_DAWN,1).getEffects(player,player);
			}
		}
		else if (event.equalsIgnoreCase("30289-08.htm"))
		{
			if (cond == 3)
			{
				player.stopAllEffects();
			}
		}
		else if (event.equalsIgnoreCase("30289-11.htm"))
		{
			if (cond == 3)
			{
				st.set("cond","4");
				st.playSound("ItemSound.quest_middle");
				player.stopAllEffects();
			}
		}
		else if (event.equalsIgnoreCase("30969-03.htm"))
		{
			if (cond == 4)
			{
				st.addExpAndSp(25000000, 2500000);
				st.unset("cond"); 
				st.exitQuest(false);
				st.playSound("ItemSound.quest_finish");
			}
		}
		else if (event.equalsIgnoreCase("32580-02.htm"))
		{
			if (cond == 3 && !st.hasQuestItems(SHUNAIMAN_CONTRACT))
			{
				st.giveItems(SHUNAIMAN_CONTRACT,1);
				st.playSound("ItemSound.quest_middle");
			}
		}
		
		return event;
	}

	@Override
	public final String onTalk(L2Npc npc, L2PcInstance player)
	{
		final QuestState st = player.getQuestState(qn);
		final QuestState contractOfMammon = player.getQuestState("194_SevenSignContractOfMammon");
		
		if (st == null)
			return "<html><body>目前沒有執行任務，或條件不符。</body></html>";
		
		final int cond = st.getInt("cond");
		switch (npc.getNpcId())
		{
			case CLAUDIA:
				switch (st.getState())
				{
					case State.CREATED:
						if(cond == 0 && player.getLevel() >= 79 && contractOfMammon.getState() == State.COMPLETED)
							return "31001-01.htm";
						else
							st.exitQuest(true);
							return "31001-00.htm";
					case State.STARTED:
						if (cond == 1)
							return "31001-06.htm";
					case State.COMPLETED:
						return "<html><body>這是已經完成的任務。</body></html>";
				}
				break;
			case JOHN:
				switch (st.getInt("cond"))
				{
					case 1:
						return "32576-01.htm";
					case 2:
						return "32576-03.htm";
				}
				break;
			case RAYMOND:
				switch (st.getInt("cond"))
				{
					case 1:
					case 2:
						return "30289-01.htm";
					case 3:
						if (st.hasQuestItems(SHUNAIMAN_CONTRACT))
							return "30289-09.htm";
						else
							return "30289-06.htm";
					case 4:
						return "30289-12.htm";
				}
				break;
			case IASON_HEINE:
				if (cond == 4)
					return "30969-01.htm";
				break;
			case SHELF:
				if (cond == 3)
					return "32580-01.htm";
				break;
		}
		return "<html><body>目前沒有執行任務，或條件不符。</body></html>";
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