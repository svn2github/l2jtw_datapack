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
package quests.Q00512_AwlUnderFoot;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

import com.l2jserver.gameserver.ThreadPoolManager;
import com.l2jserver.gameserver.instancemanager.FortManager;
import com.l2jserver.gameserver.instancemanager.InstanceManager;
import com.l2jserver.gameserver.instancemanager.InstanceManager.InstanceWorld;
import com.l2jserver.gameserver.model.L2Party;
import com.l2jserver.gameserver.model.Location;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.L2Playable;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.actor.instance.L2RaidBossInstance;
import com.l2jserver.gameserver.model.entity.Castle;
import com.l2jserver.gameserver.model.entity.Fort;
import com.l2jserver.gameserver.model.entity.Instance;
import com.l2jserver.gameserver.model.holders.SkillHolder;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.model.quest.State;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.util.Util;

/**
 * @author Gigiikun, rewrited to castle by centrio
 */
public final class Q00512_AwlUnderFoot extends Quest
{
	protected static final Logger log = Logger.getLogger(Q00512_AwlUnderFoot.class.getName());
	
	protected class CAUWorld extends InstanceWorld
	{
	}
	
	public static class CastleDungeon
	{
		private final int INSTANCEID;
		private long _reEnterTime = 0;
		
		public CastleDungeon(int iId)
		{
			INSTANCEID = iId;
		}
		
		public int getInstanceId()
		{
			return INSTANCEID;
		}
		
		public long getReEnterTime()
		{
			return _reEnterTime;
		}
		
		public void setReEnterTime(long time)
		{
			_reEnterTime = time;
		}
	}
	
	private static final boolean debug = false;
	private static final long REENTERTIME = 14400000;
	private static final long RAID_SPAWN_DELAY = 120000;
	
	private final Map<Integer, CastleDungeon> _castleDungeons = new HashMap<>(9);
	
	// QUEST ITEMS
	private static final int DL_MARK = 9798;
	
	// REWARDS
	private static final int KNIGHT_EPALUETTE = 9912;
	
	// MONSTER TO KILL -- Only last 3 Raids (lvl ordered) give DL_MARK
	protected static final int[] RAIDS1 =
	{
		25546,
		25549,
		25552
	};
	protected static final int[] RAIDS2 =
	{
		25553,
		25554,
		25557,
		25560
	};
	protected static final int[] RAIDS3 =
	{
		25563,
		25566,
		25569
	};
	
	private static final SkillHolder RAID_CURSE = new SkillHolder(5456, 1);
	
	private String checkConditions(L2PcInstance player)
	{
		if (debug)
		{
			return null;
		}
		L2Party party = player.getParty();
		if (party == null)
		{
			return "CastleWarden-03.htm";
		}
		if (party.getLeader() != player)
		{
			return getHtm(player.getHtmlPrefix(), "CastleWarden-04.htm").replace("%leader%", party.getLeader().getName());
		}
		for (L2PcInstance partyMember : party.getMembers())
		{
			QuestState st = partyMember.getQuestState(qn);
			if ((st == null) || (st.getInt("cond") < 1))
			{
				return getHtm(player.getHtmlPrefix(), "CastleWarden-05.htm").replace("%player%", partyMember.getName());
			}
			if (!Util.checkIfInRange(1000, player, partyMember, true))
			{
				return getHtm(player.getHtmlPrefix(), "CastleWarden-06.htm").replace("%player%", partyMember.getName());
			}
		}
		return null;
	}
	
	private void teleportPlayer(L2PcInstance player, int[] coords, int instanceId)
	{
		player.setInstanceId(instanceId);
		player.teleToLocation(coords[0], coords[1], coords[2]);
	}
	
	protected String enterInstance(L2PcInstance player, String template, int[] coords, CastleDungeon dungeon, String ret)
	{
		// check for existing instances for this player
		InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
		// existing instance
		if (world != null)
		{
			if (!(world instanceof CAUWorld))
			{
				player.sendPacket(SystemMessageId.ALREADY_ENTERED_ANOTHER_INSTANCE_CANT_ENTER);
				return "";
			}
			teleportPlayer(player, coords, world.instanceId);
			return "";
		}
		// New instance
		if (ret != null)
		{
			return ret;
		}
		ret = checkConditions(player);
		if (ret != null)
		{
			return ret;
		}
		L2Party party = player.getParty();
		int instanceId = InstanceManager.getInstance().createDynamicInstance(template);
		Instance ins = InstanceManager.getInstance().getInstance(instanceId);
		ins.setSpawnLoc(new Location(player));
		world = new CAUWorld();
		world.instanceId = instanceId;
		world.templateId = dungeon.getInstanceId();
		world.status = 0;
		dungeon.setReEnterTime(System.currentTimeMillis() + REENTERTIME);
		InstanceManager.getInstance().addWorld(world);
		_log.info("Castle AwlUnderFoot started " + template + " Instance: " + instanceId + " created by player: " + player.getName());
		ThreadPoolManager.getInstance().scheduleGeneral(new spawnRaid((CAUWorld) world), RAID_SPAWN_DELAY);
		
		// teleport players
		if (player.getParty() == null)
		{
			teleportPlayer(player, coords, instanceId);
			world.allowed.add(player.getObjectId());
		}
		else
		{
			for (L2PcInstance partyMember : party.getMembers())
			{
				teleportPlayer(partyMember, coords, instanceId);
				world.allowed.add(partyMember.getObjectId());
				if (partyMember.getQuestState(getName()) == null)
				{
					newQuestState(partyMember);
				}
			}
		}
		return getHtm(player.getHtmlPrefix(), "CastleWarden-08.htm").replace("%clan%", player.getClan().getName());
	}
	
	private class spawnRaid implements Runnable
	{
		private CAUWorld _world;
		
		public spawnRaid(CAUWorld world)
		{
			_world = world;
		}
		
		@Override
		public void run()
		{
			try
			{
				int spawnId;
				if (_world.status == 0)
				{
					spawnId = RAIDS1[getRandom(RAIDS1.length)];
				}
				else if (_world.status == 1)
				{
					spawnId = RAIDS2[getRandom(RAIDS2.length)];
				}
				else
				{
					spawnId = RAIDS3[getRandom(RAIDS3.length)];
				}
				L2Npc raid = addSpawn(spawnId, 53319, 245814, -6576, 0, false, 0, false, _world.instanceId);
				if (raid instanceof L2RaidBossInstance)
				{
					((L2RaidBossInstance) raid).setUseRaidCurse(false);
				}
			}
			catch (Exception e)
			{
				log.warning("Castle AwlUnderFoot Raid Spawn error: " + e);
			}
		}
	}
	
	private String checkFortCondition(L2PcInstance player, L2Npc npc, boolean isEnter)
	{
		boolean noContract = true;
		Castle castle = npc.getCastle();
		CastleDungeon dungeon = _castleDungeons.get(npc.getNpcId());
		if ((player == null) || (castle == null) || (dungeon == null))
		{
			return "CastleWarden-01.htm";
		}
		if ((player.getClan() == null) || (player.getClan().getCastleId() != castle.getCastleId()))
		{
			return "CastleWarden-01.htm";
		}
		for (Fort fortress : FortManager.getInstance().getForts())
		{
			if (fortress.getCastleId() > 0)
			{
				noContract = false;
				break;
			}
		}
		if (noContract)
		{
			return "CastleWarden-02.htm";
		}
		else if (isEnter && dungeon.getReEnterTime() > System.currentTimeMillis())
		{
			return "CastleWarden-07.htm";
		}
		
		L2Party party = player.getParty();
		if (party == null)
		{
			return "CastleWarden-03.htm";
		}
		for (L2PcInstance partyMember : party.getMembers())
		{
			if ((partyMember.getClan() == null) || (partyMember.getClan().getCastleId() != castle.getCastleId()))
			{
				return getHtm(player.getHtmlPrefix(), "CastleWarden-05.htm").replace("%player%", partyMember.getName());
			}
		}
		
		return null;
	}
	
	private void rewardPlayer(L2PcInstance player)
	{
		QuestState st = player.getQuestState(getName());
		if (st.getInt("cond") == 1)
		{
			st.giveItems(DL_MARK, 140);
			st.playSound("ItemSound.quest_itemget");
		}
	}
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		String htmltext = event;
		if (event.equalsIgnoreCase("enter"))
		{
			int[] tele = new int[3];
			tele[0] = 53322;
			tele[1] = 246380;
			tele[2] = -6580;
			return enterInstance(player, "castledungeon.xml", tele, _castleDungeons.get(npc.getNpcId()), checkFortCondition(player, npc, true));
		}
		QuestState st = player.getQuestState(getName());
		if (st == null)
		{
			st = newQuestState(player);
		}
		
		int cond = st.getInt("cond");
		if (event.equalsIgnoreCase("CastleWarden-10.htm"))
		{
			if (cond == 0)
			{
				st.set("cond", "1");
				st.setState(State.STARTED);
				st.playSound("ItemSound.quest_accept");
			}
		}
		else if (event.equalsIgnoreCase("CastleWarden-15.htm"))
		{
			st.playSound("ItemSound.quest_finish");
			st.exitQuest(true);
		}
		return htmltext;
	}
	
	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = Quest.getNoQuestMsg(player);
		QuestState st = player.getQuestState(getName());
		String ret = checkFortCondition(player, npc, false);
		if (ret != null)
		{
			return ret;
		}
		else if (st != null)
		{
			int npcId = npc.getNpcId();
			int cond = 0;
			if (st.getState() == State.CREATED)
			{
				st.set("cond", "0");
			}
			else
			{
				cond = st.getInt("cond");
			}
			if (_castleDungeons.containsKey(npcId) && cond == 0)
			{
				if (player.getLevel() >= 70)
				{
					htmltext = "CastleWarden-09.htm";
				}
				else
				{
					htmltext = "CastleWarden-00.htm";
					st.exitQuest(true);
				}
			}
			else if (_castleDungeons.containsKey(npcId) && (cond > 0) && (st.getState() == State.STARTED))
			{
				long count = st.getQuestItemsCount(DL_MARK);
				if ((cond == 1) && (count > 0))
				{
					htmltext = "CastleWarden-14.htm";
					st.takeItems(DL_MARK, -1);
					st.rewardItems(KNIGHT_EPALUETTE, count);
				}
				else if ((cond == 1) && (count == 0))
				{
					htmltext = "CastleWarden-10.htm";
				}
			}
		}
		return htmltext;
	}
	
	@Override
	public String onAttack(L2Npc npc, L2PcInstance player, int damage, boolean isPet)
	{
		L2Playable attacker = (isPet ? player.getPet() : player);
		if ((attacker.getLevel() - npc.getLevel()) >= 9)
		{
			if ((attacker.getBuffCount() > 0) || (attacker.getDanceCount() > 0))
			{
				npc.setTarget(attacker);
				npc.doSimultaneousCast(RAID_CURSE.getSkill());
			}
			else if (player.getParty() != null)
			{
				for (L2PcInstance pmember : player.getParty().getMembers())
				{
					if ((pmember.getBuffCount() > 0) || (pmember.getDanceCount() > 0))
					{
						npc.setTarget(pmember);
						npc.doSimultaneousCast(RAID_CURSE.getSkill());
					}
				}
			}
		}
		return super.onAttack(npc, player, damage, isPet);
	}
	
	@Override
	public String onKill(L2Npc npc, L2PcInstance player, boolean isPet)
	{
		InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
		if (tmpworld instanceof CAUWorld)
		{
			CAUWorld world = (CAUWorld) tmpworld;
			if (Util.contains(RAIDS3, npc.getNpcId()))
			{
				if (player.getParty() != null)
				{
					for (L2PcInstance pl : player.getParty().getMembers())
					{
						rewardPlayer(pl);
					}
				}
				else
				{
					rewardPlayer(player);
				}
				
				Instance instanceObj = InstanceManager.getInstance().getInstance(world.instanceId);
				instanceObj.setDuration(360000);
				instanceObj.removeNpcs();
			}
			else
			{
				world.status++;
				ThreadPoolManager.getInstance().scheduleGeneral(new spawnRaid(world), RAID_SPAWN_DELAY);
			}
		}
		return null;
	}

	public Q00512_AwlUnderFoot(int questId, String name, String descr)
	{
		super(questId, name, descr);
		_castleDungeons.put(36403, new CastleDungeon(13));
		_castleDungeons.put(36404, new CastleDungeon(14));
		_castleDungeons.put(36405, new CastleDungeon(15));
		_castleDungeons.put(36406, new CastleDungeon(16));
		_castleDungeons.put(36407, new CastleDungeon(17));
		_castleDungeons.put(36408, new CastleDungeon(18));
		_castleDungeons.put(36409, new CastleDungeon(19));
		_castleDungeons.put(36410, new CastleDungeon(20));
		_castleDungeons.put(36411, new CastleDungeon(21));

		for (int i : _castleDungeons.keys())
		{
			addStartNpc(i);
			addTalkId(i);
		}
		
		for (int i : RAIDS1)
		{
			addKillId(i);
		}
		for (int i : RAIDS2)
		{
			addKillId(i);
		}
		for (int i : RAIDS3)
		{
			addKillId(i);
		}
		
		for (int i = 25546; i <= 25571; i++)
		{
			addAttackId(i);
		}
	}
	
	public static void main(String[] args)
	{
		// now call the constructor (starts up the)
		new Q00512_AwlUnderFoot(512, Q00512_AwlUnderFoot.class.getSimpleName(), "instances");
	}
}