package instances.Pailaka;

import com.l2jserver.gameserver.ThreadPoolManager;
import com.l2jserver.gameserver.ai.CtrlIntention;
import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.instancemanager.InstanceManager;
import com.l2jserver.gameserver.instancemanager.InstanceManager.InstanceWorld;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2MonsterInstance;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.entity.Instance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.model.quest.State;
import com.l2jserver.gameserver.model.zone.L2ZoneType;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;
import com.l2jserver.util.Rnd;

public class PailakaInjuredDragon extends Quest {

	private static final String qn = "144_PailakaInjuredDragon";
	
	private static final int MIN_LEVEL   = 73;
	private static final int MAX_LEVEL   = 77;
	private static final int EXIT_TIME   = 5;
	private static final int INSTANCE_ID = 45;
	private static final int[] TELEPORT  = { 125757, -40928, -3736 };
	//private static final int ZONE = ???;
	
	// NPCS
	private static final int KETRA_ORC_SHAMAN              = 32499;
	private static final int KETRA_ORC_SUPPORTER           = 32502;
	private static final int KETRA_ORC_SUPPORTER2          = 32512;
	private static final int KETRA_ORC_INTELIGENCE_OFFICER = 32509;

	// MOBS
	private static final int VARKAS_COMMANDER          = 18654;
	private static final int VARKA_SILENOS_GREAT_MAGUS = 18649;
	private static final int ANTYLOPE_1                = 18637;
	private static final int ANTYLOPE_2                = 18643;
	private static final int ANTYLOPE_3                = 18647;
	private static final int ANTYLOPE_4                = 18651;
	
	// BOSS
	private static final int LATANA = 18660;

	// ITEMS
	private static final int SPEAR     = 13052;
	private static final int ENCHSPEAR = 13053;
	private static final int LASTSPEAR = 13054;
	private static final int STAGE1    = 13056;
	private static final int STAGE2    = 13057;
	
	private static final int SHIELD_POTION = 13032;
	private static final int HEAL_POTION   = 13033;

	// Rewards
	private static final int PSHIRT = 13296;
	private static final int SCROLL_OF_ESCAPE = 736;
	
	private static final String EMPTY = "<html><body>目前沒有執行任務，或條件不符。</body></html>";
	
	private static int buff_counter = 5; 

	// Arrays
	private static final int[] NPCS = 
	{ KETRA_ORC_SHAMAN, KETRA_ORC_SUPPORTER, KETRA_ORC_INTELIGENCE_OFFICER, KETRA_ORC_SUPPORTER2 };
	private static final int[] MONSTERS =
	{ 18635, 18636, 18638, 18639, 18640, 18641, 18642,
		18644, 18645, 18646, 18648, VARKA_SILENOS_GREAT_MAGUS, 18650, 18652,
		18653, VARKAS_COMMANDER, 18655, 18656, 18657, 18658, 18659, 
		ANTYLOPE_1, ANTYLOPE_2, ANTYLOPE_3, ANTYLOPE_4 };
	private static final int[] ITEMS = { SPEAR, ENCHSPEAR, LASTSPEAR, STAGE1, STAGE2, SHIELD_POTION, HEAL_POTION };
	private static final int[][] BUFFS = 
	{
		{4357,2}, // Haste Lv2
		{4342,2}, // Wind Walk Lv2
		{4356,3}, // Empower Lv3
		{4355,3}, // Acumen Lv3
		{4351,6}, // Concentration Lv6
		{4345,3}, // Might Lv3
		{4358,3}, // Guidance Lv3
		{4359,3}, // Focus Lv3
		{4360,3}, // Death Wisper Lv3
		{4352,2}, // Berserker Spirit Lv2
		{4354,4}, // Vampiric Rage Lv4
		{4347,6}  // Blessed Body Lv6
	};
	private static final int[][] DROPLIST =
	{
		// must be sorted by npcId !
		// npcId, itemId, chance
		{ HEAL_POTION, 80 },
		{ SHIELD_POTION, 30 }
	};

	private static final int[][] HP_HERBS_DROPLIST = 
	{
		// itemId, count, chance
		{ 8601, 1, 40 }, { 8600, 1, 70 }
	};
	private static final int[][] MP_HERBS_DROPLIST =
	{
		// itemId, count, chance
		{ 8604, 1, 40 }, { 8603, 1, 70 }
	};
	
	private static final void dropHerb(L2Npc mob, L2PcInstance player, int[][] drop)
	{
		final int chance = Rnd.get(100);
		for (int i = 0; i < drop.length; i++)
		{
			if (chance < drop[i][2])
			{
				((L2MonsterInstance)mob).dropItem(player, drop[i][0], drop[i][1]);
				return;
			}
		}
	}

	private static final void dropItem(L2Npc mob, L2PcInstance player)
	{
		final int chance = Rnd.get(100);
		for (int i = 0; i < DROPLIST.length; i++)
		{
			int[] drop = DROPLIST[i];
			if (chance < drop[1])
			{
				((L2MonsterInstance)mob).dropItem(player, drop[0], Rnd.get(1,6));
				return;
			}
		}
	}

	private static void giveBuff(L2Npc npc, L2PcInstance player, int skillId, int level)
	{
		npc.setTarget(player);
		npc.doCast(SkillTable.getInstance().getInfo(skillId,level));
		buff_counter--;
		return;
	}

	private static final void teleportPlayer(L2PcInstance player, int[] coords, int instanceId)
	{
		player.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
		player.setInstanceId(instanceId);
		player.teleToLocation(coords[0], coords[1], coords[2], true);
	}

	private final synchronized void enterInstance(L2PcInstance player)
	{
		//check for existing instances for this player
		InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
		if (world != null)
		{
			if (world.templateId != INSTANCE_ID)
			{
				player.sendPacket(new SystemMessage(SystemMessageId.ALREADY_ENTERED_ANOTHER_INSTANCE_CANT_ENTER));
				return;
			}
			Instance inst = InstanceManager.getInstance().getInstance(world.instanceId);
			if (inst != null)
				teleportPlayer(player, TELEPORT, world.instanceId);
			return;
		}
		//New instance
		else
		{
			final int instanceId = InstanceManager.getInstance().createDynamicInstance("PailakaInjuredDragon.xml");

			world = new InstanceWorld();
			world.instanceId = instanceId;
			world.templateId = INSTANCE_ID;
			InstanceManager.getInstance().addWorld(world);

			world.allowed.add(player.getObjectId());
			teleportPlayer(player, TELEPORT, instanceId);
		}
	}

	public final String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		final QuestState st = player.getQuestState(qn);
		if (st == null)
			return EMPTY;

		final int cond = st.getInt("cond");
		if (event.equalsIgnoreCase("enter"))
		{
			enterInstance(player);
			return null;
		}
		else if (event.equalsIgnoreCase("32499-02.htm")) // Shouldn't be 32499-04.htm ???
		{
			if (cond == 0)
			{
				st.set("cond","1");
				st.setState(State.STARTED);
				st.playSound("ItemSound.quest_accept");
			}
		}
		else if (event.equalsIgnoreCase("32499-05.htm"))
		{
			if (cond == 1)
			{
				st.set("cond","2");
				st.playSound("ItemSound.quest_accept"); // double quest accept ???
			}
		}
		else if (event.equalsIgnoreCase("32502-05.htm"))
		{
			if (cond == 2)
			{
				st.set("cond","3");
				st.playSound("ItemSound.quest_itemget");
				st.giveItems(SPEAR,1);
			}
		}
		else if (event.equalsIgnoreCase("32509-02.htm"))
		{
			switch (cond)
			{
				case 2:
				case 3:
					return "32509-07.htm";
				case 4:
					st.set("cond","5");
					st.takeItems(SPEAR,1);
				    st.takeItems(STAGE1,1);
				    st.giveItems(ENCHSPEAR,1);
					//st.playSound("ItemSound.quest_itemget");
					return "32509-02.htm";
				case 5:
					return "32509-01.htm";
				case 6:
					st.set("cond","7");
					st.takeItems(ENCHSPEAR,1);
				    st.takeItems(STAGE2,1);
				    st.giveItems(LASTSPEAR,1);
				    addSpawn(LATANA, 105732, -41787, -1782, 35742, false, 0, false, npc.getInstanceId());
					//st.playSound("ItemSound.quest_itemget");
					return "32509-03.htm";
				case 7:
					return "32509-03.htm";
				default:
					break;
			}
		}
		else if (event.equalsIgnoreCase("32509-06.htm"))
		{
			if(buff_counter < 1)
				return "32509-05.htm";
		}
		else if (event.equalsIgnoreCase("32512-02.htm"))
		{
			st.unset("cond");
			st.playSound("ItemSound.quest_finish");
			st.exitQuest(false);

			Instance inst = InstanceManager.getInstance().getInstance(npc.getInstanceId());
			inst.setDuration(EXIT_TIME * 60000);
			inst.setEmptyDestroyTime(0);

			if (inst.containsPlayer(player.getObjectId()))
			{
				player.setVitalityPoints(20000, true);
				st.addExpAndSp(28000000, 2850000);
				st.giveItems(SCROLL_OF_ESCAPE,1);
				st.giveItems(PSHIRT, 1);
			}
		}
		else if (event.startsWith("buff"))
		{
			if(buff_counter > 0)
			{
				int _nr = Integer.parseInt(event.split("buff")[1]);
				giveBuff(npc, player, BUFFS[_nr - 1][0], BUFFS[_nr - 1][1]);
				return "32509-06.htm";
			} else
				return "32509-05.htm";
		}
		return event;
	}

	//public final String onFirstTalk(L2Npc npc, L2PcInstance player)
	//{
	//	return npc.getNpcId() + ".htm";
	//}

	public final String onTalk(L2Npc npc, L2PcInstance player)
	{
		final QuestState st = player.getQuestState(qn);
		if (st == null)
			return EMPTY;

		final int cond = st.getInt("cond");
		switch (npc.getNpcId())
		{
			case KETRA_ORC_SHAMAN:
				switch (st.getState())
				{
					case State.CREATED:
						if (player.getLevel() < MIN_LEVEL)
							return "32499-no.htm";
						if (player.getLevel() > MAX_LEVEL)
							return "32499-over.htm";
						return "32499-00.htm";
					case State.STARTED:
						if (cond > 1)
							return "32499-06.htm";
					case State.COMPLETED:
						return "32499-no.htm";
					default:
						return "32499-no.htm";
				}
			case KETRA_ORC_SUPPORTER:
				if (cond > 2)
					return "32502-05.htm";
				else
					return "32502-00.htm";
			case KETRA_ORC_INTELIGENCE_OFFICER:
				return "32509-00.htm";
			case KETRA_ORC_SUPPORTER2:
				if (st.getState() == State.COMPLETED)
					return "32512-03.htm";
				else if (cond == 8)
					return "32512-01.htm";
		}
		return EMPTY;
	}

	public final String onAttack(L2Npc npc, L2PcInstance attacker, int damage, boolean isPet)
	{
		if (!npc.isDead())
			npc.doDie(attacker);

		return super.onAttack(npc, attacker, damage, isPet);
	}

	public final String onKill(L2Npc npc, L2PcInstance player, boolean isPet)
	{
		QuestState st = player.getQuestState(qn);
		if (st == null || st.getState() != State.STARTED)
			return null;

		final int cond = st.getInt("cond");
		switch (npc.getNpcId())
		{
			case VARKAS_COMMANDER:
				dropHerb(npc, player, HP_HERBS_DROPLIST);
				if (cond == 3 && st.hasQuestItems(SPEAR) && !st.hasQuestItems(STAGE1))
				{
					st.set("cond","4");
					st.giveItems(STAGE1,1);
					st.playSound("ItemSound.quest_itemget");
				}
				break;
			case VARKA_SILENOS_GREAT_MAGUS:
				dropHerb(npc, player, HP_HERBS_DROPLIST);
				if (cond == 5 && st.hasQuestItems(ENCHSPEAR) && !st.hasQuestItems(STAGE2))
				{
					st.set("cond","6");
					st.giveItems(STAGE2,1);
					st.playSound("ItemSound.quest_itemget");
				}
				break;
			case LATANA:
				st.set("cond","8");
				st.playSound("ItemSound.quest_middle");
				addSpawn(KETRA_ORC_SUPPORTER2, npc.getX(), npc.getY(), npc.getZ(), npc.getHeading(), false, 0, false, npc.getInstanceId());
			case ANTYLOPE_1:
			case ANTYLOPE_2:
			case ANTYLOPE_3:
			case ANTYLOPE_4:
				dropItem(npc, player);
				break;
			default:
				// hardcoded herb drops
				dropHerb(npc, player, HP_HERBS_DROPLIST);
				dropHerb(npc, player, MP_HERBS_DROPLIST);
				break;
		}
		return super.onKill(npc, player, isPet);
	}

	public String onExitZone(L2Character character, L2ZoneType zone)
	{
		if (character instanceof L2PcInstance
				&& !character.isDead()
				&& !character.isTeleporting()
				&& ((L2PcInstance)character).isOnline())
		{
			InstanceWorld world = InstanceManager.getInstance().getWorld(character.getInstanceId());
			if (world != null && world.templateId == INSTANCE_ID)
				ThreadPoolManager.getInstance().scheduleGeneral(new Teleport(character, world.instanceId), 1000);
		}
		return super.onExitZone(character,zone);
	}

	static final class Teleport implements Runnable
	{
		private final L2Character _char;
		private final int _instanceId;

		public Teleport(L2Character c, int id)
		{
			_char = c;
			_instanceId = id;
		}

		public void run()
		{
			try
			{
				teleportPlayer((L2PcInstance)_char, TELEPORT, _instanceId);
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
	}

	public PailakaInjuredDragon(int questId, String name, String descr) {
		super(questId, name, descr);
		addStartNpc(KETRA_ORC_SHAMAN);
		for (int npcId : NPCS)
			addTalkId(npcId);

		addKillId(LATANA);
		for (int mobId : MONSTERS)
			addKillId(mobId);
		//addExitZoneId(ZONE);
		questItemIds = ITEMS;
	}

	public static void main(String[] args)
	{
		new PailakaInjuredDragon(144, qn, "菲拉卡-受傷的龍");
	}
}