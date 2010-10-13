package conquerablehalls.RainbowSpringsChateau;

import gnu.trove.TIntLongHashMap;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ScheduledFuture;
import java.util.logging.Logger;

import javolution.util.FastList;
import javolution.util.FastMap;

import com.l2jserver.Config;
import com.l2jserver.L2DatabaseFactory;
import com.l2jserver.gameserver.Announcements;
import com.l2jserver.gameserver.ThreadPoolManager;
import com.l2jserver.gameserver.datatables.ClanTable;
import com.l2jserver.gameserver.datatables.NpcTable;
import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.datatables.SpawnTable;
import com.l2jserver.gameserver.datatables.MapRegionTable.TeleportWhereType;
import com.l2jserver.gameserver.instancemanager.CHSiegeManager;
import com.l2jserver.gameserver.instancemanager.ClanHallManager;
import com.l2jserver.gameserver.instancemanager.ZoneManager;
import com.l2jserver.gameserver.instancemanager.CHSiegeManager.SiegeStatus;
import com.l2jserver.gameserver.model.L2Clan;
import com.l2jserver.gameserver.model.L2ItemInstance;
import com.l2jserver.gameserver.model.L2Object;
import com.l2jserver.gameserver.model.L2Skill;
import com.l2jserver.gameserver.model.L2Spawn;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.entity.ClanHall;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.model.quest.State;
import com.l2jserver.gameserver.model.zone.L2ZoneType;
import com.l2jserver.gameserver.network.clientpackets.Say2;
import com.l2jserver.gameserver.network.serverpackets.NpcHtmlMessage;
import com.l2jserver.gameserver.network.serverpackets.NpcSay;
import com.l2jserver.gameserver.templates.item.L2Item;
import com.l2jserver.util.Rnd;

/**
 * @author BiggBoss
 * Rainbow Springs Cheateau clan hall siege script
 */
public class RainbowSpringsChateau extends Quest
{
	private static final Logger _log = Logger.getLogger(RainbowSpringsChateau.class.getName());
	
	private class SetFinalAttackers implements Runnable
	{ 
		@Override
		public void run()
		{
			ClanHall rainbow = ClanHallManager.getInstance().getClanHallById(RAINBOW_SPRINGS);
			
			if(rainbow != null)
			{
				int spotLeft = 4;
				if(rainbow.getOwnerId() > 0)
				{
					L2Clan owner = ClanTable.getInstance().getClan(rainbow.getOwnerId());
					if(owner != null)
					{
						rainbow.free();
						owner.setHasHideout(0);
						_acceptedClans.add(owner);
						--spotLeft;
					}
					
					for(int i = 0; i < spotLeft; i++)
					{
						long counter = 0;
						L2Clan clan = null;
						for(int clanId : _warDecreesCount.keys())
						{
							L2Clan actingClan = ClanTable.getInstance().getClan(clanId);
							if(actingClan == null || actingClan.getDissolvingExpiryTime() > 0)
							{
								_warDecreesCount.remove(clanId);
								continue;
							}
							final long count = _warDecreesCount.get(clanId);
							if(count > counter)
							{
								counter = count;
								clan = actingClan;
							}
						}
						if(_acceptedClans.size() < 4)
						{
							_acceptedClans.add(clan);
							L2PcInstance leader = clan.getLeader().getPlayerInstance();
							if(leader != null)
								leader.sendMessage("Your clan has been accepted to join the RainBow Srpings Chateau siege!");
						}
					}
					if(_acceptedClans.size() >= 2)
					{
						ThreadPoolManager.getInstance().scheduleGeneral(new SiegeStart(), 3600000);
						CHSiegeManager.getInstance().updateSiegeStatus(RAINBOW_SPRINGS, SiegeStatus.WATING_BATTLE);
					}
					else
						Announcements.getInstance().announceToAll("Rainbow Springs Chateau siege aborted due lack of population");
				}
			}
			else
				_log.warning("Rainbow Spring Chateau clan hall (id: "+RAINBOW_SPRINGS+") seems to be null, SIEGE CANCELED!");
		}
	}
	
	private class SiegeStart implements Runnable
	{		
		@Override
		public void run()
		{
			Announcements.getInstance().announceToAll("Rainbow Springs Chateau Siege has begun!");
			Announcements.getInstance().announceToAll("Accepted clans go to the Rainbow Spring east arenas!");
			_inSiege = true;
			CHSiegeManager.getInstance().spawnGuards(RAINBOW_SPRINGS);
			spawnGourds();
			_siegeEnd = ThreadPoolManager.getInstance().scheduleGeneral(new SiegeEnd(null), 3600000 - 120000);
		}
	}
		
	private class SiegeEnd implements Runnable
	{
		private L2Clan _winner;
		
		private SiegeEnd(L2Clan winner)
		{
			_winner = winner;
		}
		
		@Override
		public void run()
		{
			_inSiege = false;
			Announcements.getInstance().announceToAll("Rainbow Spring Chateau Siege is over!");
			unSpawnGourds();
			if(_winner != null)
			{
				CHSiegeManager.getInstance().setCHOwner(_winner, RAINBOW_SPRINGS);
			}
			long nextSiege = (Config.CHS_SIEGE_INTERVAL * 60 * 1000) - 3600000;
			CHSiegeManager.getInstance().siegeEnds(RAINBOW_SPRINGS, nextSiege);
			ThreadPoolManager.getInstance().scheduleGeneral(new SetFinalAttackers(), nextSiege);
			setRegistrationEndString(nextSiege + System.currentTimeMillis());
			ThreadPoolManager.getInstance().scheduleGeneral(new TeleportBack(), 120000);
		}
	}
	
	private class TeleportBack implements Runnable
	{		
		@Override
		public void run()
		{
			for(int arenaId : ARENA_ZONES)
			{
				L2ZoneType zone = ZoneManager.getInstance().getZoneById(arenaId);
				for(L2Character cha : zone.getCharactersInside().values())
					cha.teleToLocation(TeleportWhereType.Town);
			}
		}
	}
	
	private static final String qn = "RainbowSpringsChateau";
	
	private static final int RAINBOW_SPRINGS = 62;
	
	private static final int WAR_DECREES = 8034;
	private static final int RAINBOW_NECTAR= 8030;
	private static final int RAINBOW_MWATER = 8031;
	private static final int RAINBOW_WATER = 8032;
	private static final int RAINBOW_SULFUR = 8033;
	
	private static final int MESSENGER = 35604;
	private static final int CARETAKER = 35603;
	private static final int CHEST = 35593;
	
	private static final int[] GOURDS = { 35588, 35589, 35590, 35591 };
	private static L2Spawn[] _gourds = new L2Spawn[4];
	
	private static final int[] YETIS = { 35596, 35597, 35598, 35599 };
	
	private static final int[][] ARENAS =
	{
		{ 151562, -127080, -2214 }, // Arena 1
		{ 153141, -125335, -2214 }, // Arena 2
		{ 153892, -127530, -2214 }, // Arena 3
		{ 155657, -125752, -2214 }, // Arena 4
	};
	
	private static final int[] ARENA_ZONES = { 112081, 112082, 112083, 112084 };
	
	private static final String[] _textPassages =
	{
		"Text Passage 1",
		"Passage Text 2",
		"Im getting out of ideas",
		"But i can write few more",
		"Are five sentences",
		"enough for this f*** siege?",
		"i think ill add few more",
		"like this one",
		"Please, if you know the true passages",
		"Contact me at L2JForum =)"
	};
	
	private static final L2Skill[] DEBUFFS =
	{
		SkillTable.getInstance().getInfo(0, 1)
	};
		
	private static TIntLongHashMap _warDecreesCount = new TIntLongHashMap();
	private static List<L2Clan> _acceptedClans = new ArrayList<L2Clan>(4);
	private static Map<String, FastList<L2Clan>> _usedTextPassages = new FastMap<String, FastList<L2Clan>>();
	private static ArrayList<Integer> _pendingItemToGet = new ArrayList<Integer>(4);
	
	private static boolean _inSiege = false;
	private static ScheduledFuture<?> _siegeEnd;
	private static String _registrationEnds;
	
	
	/**
	 * @param questId
	 * @param name
	 * @param descr
	 */
	public RainbowSpringsChateau(int questId, String name, String descr)
	{
		super(questId, name, descr);
		addFirstTalkId(MESSENGER);
		addTalkId(MESSENGER);
		addFirstTalkId(CARETAKER);
		addTalkId(CARETAKER);
		for(int npc : YETIS)
		{
			addFirstTalkId(npc);
			addTalkId(npc);
		}
		
		loadAttackers();
		
		long delay = CHSiegeManager.getInstance().getSiegeDate(RAINBOW_SPRINGS);
		if(delay > -1)
		{
			delay -=  3600000;
			setRegistrationEndString(delay);
			ThreadPoolManager.getInstance().scheduleGeneral(new SetFinalAttackers(), delay - System.currentTimeMillis());
		}
		else
			_log.warning("CHSiegeManager: No Date setted for RainBow Springs Chateau Clan hall siege!. SIEGE CANCELED!");
	}
	
	@Override
	public String onFirstTalk(L2Npc npc, L2PcInstance player)
	{
		if(player.getQuestState(qn) == null)
		{
			QuestState state = newQuestState(player);
			state.setState(State.STARTED);
		}

		int npcId = npc.getNpcId();
		String html = "";
		
		if(npcId == MESSENGER)
		{
			sendMessengerMain(player);
		}
		else if(npcId == CARETAKER)
		{
			html = "caretaker_main.htm";
		}
		else if(_inSiege)
		{
			if(!player.isClanLeader())
				html = "no_clan_leader.htm";
			else
			{
				L2Clan clan = player.getClan();
				if(clan != null && _acceptedClans.contains(clan))
				{
					int index = _acceptedClans.indexOf(clan);
					if(npcId == YETIS[index])
						html = "yeti_main.htm";
				}
			}
		}
		player.setLastQuestNpcObject(npc.getObjectId());
		return html;
	}
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		String html = event;

		if(event.equals("register"))
		{
			if(!player.isClanLeader())
				return "no_clan_leader.htm";

			final L2Clan clan = player.getClan();
			final int clanId = clan.getClanId();
			if(_warDecreesCount.containsKey(clanId))
				html = "messenger_alredy_registered.htm";
			else if(clan.getLevel() < 3 || clan.getMembersCount() < 5)
				html = "messenger_no_level.htm";
			else
			{
				L2ItemInstance warDecrees = player.getInventory().getItemByItemId(WAR_DECREES);
				if(warDecrees == null)
					html = "messenger_nowardecrees.htm";
				else
				{
					player.destroyItem("Rainbow Springs Registration", warDecrees, npc, true);
					long count = warDecrees.getCount();
					_warDecreesCount.put(clanId, count);
					updateAttacker(clanId, count, false);
					html = "messenger_registered.htm";
				}
			}
		}
		else if(event.equals("unregister"))
		{
			final L2Clan clan = player.getClan();
			final int clanId = clan.getClanId();
			if(!_warDecreesCount.containsKey(clanId))
				html = "messenger_notinlist.htm";
			else
			{
				if(CHSiegeManager.getInstance().isHallRegistering(RAINBOW_SPRINGS))
				{
					String[] split = event.split("_");
					int step = Integer.parseInt(split[1]);
					
					switch(step)
					{
						case 0:
							html = "messenger_unregister_confirmation.htm";
						case 1:
							html = "messenger_retrive_wardecrees.htm";
							updateAttacker(clanId, 0, true);
						case 2:
							html = "messenger_unregistered.htm";
							long toRetrive = _warDecreesCount.get(clanId) / 2;
							player.addItem("Rainbow Spring unregister", WAR_DECREES, toRetrive, npc, true);
							_warDecreesCount.remove(clanId);
					}
				}
			}
		}
		else if(event.equals("portToArena"))
		{
			final L2Clan clan = player.getClan();
			if(_acceptedClans.contains(clan))
				html = "caretaker_not_allowed.htm";
			else if(player.getParty() == null)
				html = "caretaker_no_party.htm";
			else
			{
				int index = _acceptedClans.indexOf(clan);
				portToArena(player, index);
			}
		}
		else if(event.startsWith("enterText"))
		{
			final L2Clan clan = player.getClan();
			final int clanId = clan.getClanId();
			if(!_acceptedClans.contains(clan))
				return null;
			
			String[] split = event.split("_");
			if(split.length < 2)
				return null;
			
			final String passage = split[1];
			
			if(!isValidPassage(passage))
				return null;
			
			if(_usedTextPassages.containsKey(passage))
			{
				FastList<L2Clan> list = _usedTextPassages.get(passage);
				
				if(list.contains(clan))
					return "yeti_passage_used.htm";
				else
					list.add(clan);
			}
			else
			{
				_usedTextPassages.put(passage, new FastList<L2Clan>());
			}
			// Dunno if they can talk to the npc to exchange items or the window pop up 1 time
			// Ill do it in this way, so i dont need to use a map to store avaliable items
			synchronized(_pendingItemToGet)
			{
				_pendingItemToGet.add(clanId);
			}
			html = "yeti_item_exchange.htm";
		}
		else if(event.startsWith("getItem"))
		{
			final L2Clan clan = player.getClan();
			final int clanId = clan.getClanId();
			if(!_pendingItemToGet.contains(clanId))
				return null;
				
			_pendingItemToGet.remove(clanId);
			int itemId = Integer.parseInt(event.split("_")[1]);
			player.addItem("Rainbow Spring Chateau Siege", itemId, 1, npc, true);
		}
		
		return html;
	}
	
	@Override
	public String onKill(L2Npc npc, L2PcInstance killer, boolean isPet)
	{
		if(!_inSiege)
			return null;
		
		final L2Clan clan = killer.getClan();
		if(clan == null || !_acceptedClans.contains(clan))
			return null;
		
		final int npcId = npc.getNpcId();
		final int index = _acceptedClans.indexOf(clan);
		
		if(npcId == CHEST)
		{
			shoutRandomText(npc);
		}
		else if(npcId == GOURDS[index])
		{
			synchronized(this)
			{
				_siegeEnd.cancel(false);
				ThreadPoolManager.getInstance().executeTask(new SiegeEnd(clan));
			}
		}
		
		return super.onKill(npc, killer, isPet);
	}
	
	@Override
	public String onItemUse(L2PcInstance player, L2Item item)
	{
		if(!_inSiege)
			return null;
		
		L2Object target = player.getTarget();
		
		if(target == null || !(target instanceof L2Npc))
			return null;
		
		int yeti = ((L2Npc)target).getNpcId();
		
		if(!isYetiTarget(yeti))
			return null;
		
		final L2Clan clan = player.getClan();
		
		if(clan == null || !_acceptedClans.contains(clan))
			return null;
		
		final int itemId = item.getItemId();
		
		// Nectar must spawn the enraged yeti. Dunno if it makes any other thing
		// Also, the items must execute:
		// - Reduce gourd hpb ( reduceGourdHp(int, L2PcInstance) )
		// - Cast debuffs on enemy clans ( castDebuffsOnEnemies(int) )
		// - Change arena gourds ( moveGourds() )
		// - Increase gourd hp ( increaseGourdHp(int) )
		
		if(itemId == RAINBOW_NECTAR)
		{
			// Spawn enraged (where?)
			reduceGourdHp(_acceptedClans.indexOf(clan), player);
		}
		else if(itemId == RAINBOW_MWATER)
		{
			increaseGourdHp(_acceptedClans.indexOf(clan));
		}
		else if(itemId == RAINBOW_WATER)
		{
			moveGourds();
		}
		else if(itemId == RAINBOW_SULFUR)
		{
			castDebuffsOnEnemies(_acceptedClans.indexOf(clan));
		}
		return super.onItemUse(player, item);
	}
	
	private void portToArena(L2PcInstance leader, int arena)
	{
		if(arena < 0 || arena > 3)
		{
			_log.warning("RainbowSptringChateau siege: Wrong arena id passed: "+arena);
			return;
		}
		for(L2PcInstance pc : leader.getParty().getPartyMembers())
			if(pc != null)
			{
				pc.stopAllEffects();
				if(pc.getPet() != null)
					pc.getPet().unSummon(pc);
				pc.teleToLocation(ARENAS[arena][0], ARENAS[arena][1], ARENAS[arena][2]);
			}	
	}
	
	private void spawnGourds()
	{
		for(int i = 0; i < _acceptedClans.size(); i++)
		{
			if(_gourds[i] == null)
			{
				try
				{
					_gourds[i] = new L2Spawn(NpcTable.getInstance().getTemplate(GOURDS[i]));
					_gourds[i].setLocx(ARENAS[i][0] + 150);
					_gourds[i].setLocy(ARENAS[i][1] + 150);
					_gourds[i].setLocz(ARENAS[i][2]);
					_gourds[i].setHeading(1);
					_gourds[i].setAmount(1);
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
			SpawnTable.getInstance().addNewSpawn(_gourds[i], false);
			_gourds[i].init();
		}
	}
	
	private void unSpawnGourds()
	{
		for(int i = 0; i < _acceptedClans.size(); i++)
		{
			_gourds[i].getLastSpawn().deleteMe();
			SpawnTable.getInstance().deleteSpawn(_gourds[i], false);
		}
	}
	
	private void moveGourds()
	{
		L2Spawn[] tempArray = _gourds;
		int iterator = _acceptedClans.size();
		for(int i = 0; i < iterator; i++)
		{
			L2Spawn oldSpawn = _gourds[(iterator-1)-i];
			L2Spawn curSpawn = tempArray[i];
			
			_gourds[(iterator -1) - i] = curSpawn;
			
			int newX = oldSpawn.getLocx();
			int newY = oldSpawn.getLocy();
			int newZ = oldSpawn.getLocz();
			
			curSpawn.getLastSpawn().teleToLocation(newX, newY, newZ);
		}
	}
	
	private void reduceGourdHp(int index, L2PcInstance player)
	{
		L2Spawn gourd = _gourds[index];
		gourd.getLastSpawn().reduceCurrentHp(1000, player, null);
	}
	
	private void increaseGourdHp(int index)
	{
		L2Spawn gourd = _gourds[index];
		L2Npc gourdNpc = gourd.getLastSpawn();
		gourdNpc.setCurrentHp(gourdNpc.getCurrentHp() + 1000);
	}
	
	private void castDebuffsOnEnemies(int myArena)
	{
		for(int id : ARENA_ZONES)
		{
			if(id == myArena)
				continue;
			
			for(L2Character plr : ZoneManager.getInstance().getZoneById(id).getCharactersInside().values())
			{
				for(L2Skill sk : DEBUFFS)
					sk.getEffects(plr, plr);
			}
		}
	}
	
	private void shoutRandomText(L2Npc npc)
	{
		int length = _textPassages.length;
		
		if(_usedTextPassages.size() >= length)
			return;

		int randomPos = Rnd.get(length);
		String message = _textPassages[randomPos];
		
		if(_usedTextPassages.containsKey(message))
			shoutRandomText(npc);
		else
		{
			_usedTextPassages.put(message, new FastList<L2Clan>());
			int shout = Say2.SHOUT;
			int objId = npc.getObjectId();
			NpcSay say = new NpcSay(objId, shout, npc.getNpcId(), message);
			npc.broadcastPacket(say);
		}
	}
	
	private boolean isValidPassage(String text)
	{
		for(String st : _textPassages)
			if(st.equalsIgnoreCase(text))
				return true;
		return false;
	}
	
	private boolean isYetiTarget(int npcId)
	{
		for(int yeti : YETIS)
			if(yeti == npcId)
				return true;
		return false;
	}
	
	private void updateAttacker(int clanId, long count, boolean remove)
	{
		Connection con = null;
		try
		{
			con = L2DatabaseFactory.getInstance().getConnection();
			PreparedStatement statement;
			if(remove)
			{
				statement = con.prepareStatement("DELETE FROM rainbowsprings_attacker_list WHERE clanId = ?");
				statement.setInt(1, clanId);
			}
			else
			{
				statement = con.prepareStatement("INSERT INTO rainbowsprings_attacker_list VALUES (?,?)");
				statement.setInt(1, clanId);
				statement.setLong(2, count);
			}
			statement.execute();
			statement.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			L2DatabaseFactory.close(con);
		}
	}
	
	private void loadAttackers()
	{
		Connection con = null;
		try
		{
			con = L2DatabaseFactory.getInstance().getConnection();
			PreparedStatement statement = con.prepareStatement("SELECT * FROM rainbowsprings_attacker_list");
			ResultSet rset = statement.executeQuery();
			while(rset.next())
			{
				int clanId = rset.getInt("clan_id");
				long count = rset.getLong("decrees_count");
				_warDecreesCount.put(clanId, count);
			}
			rset.close();
			statement.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			L2DatabaseFactory.close(con);
		}
	}
	
	private void setRegistrationEndString(long time)
	{
		Calendar c = Calendar.getInstance();
		c.setTime(new Date(time));
		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH) + 1;
		int day = c.get(Calendar.DAY_OF_MONTH);
		int hour = c.get(Calendar.HOUR);
		int mins = c.get(Calendar.MINUTE);
		
		_registrationEnds = year+"-"+month+"-"+day+" "+hour+":"+mins;
	}
	
	private void sendMessengerMain(L2PcInstance player)
	{
		ClanHall rainbow = ClanHallManager.getInstance().getClanHallById(RAINBOW_SPRINGS);
		L2Clan owner = ClanTable.getInstance().getClan(rainbow.getOwnerId());
		if (owner == null)
		{
			NpcHtmlMessage message = new NpcHtmlMessage(5);
			message.setFile(null, "data/scripts/conquerablehalls/RainbowSpringsChateau/messenger_main.htm");
			message.replace("%time%", _registrationEnds);
			player.sendPacket(message);
		}
		else
		{
			NpcHtmlMessage message = new NpcHtmlMessage(5);
			message.setFile(null, "data/scripts/conquerablehalls/RainbowSpringsChateau/messenger_main1.htm");
			message.replace("%clanname%", owner.getName());
			message.replace("%time%", _registrationEnds);
			player.sendPacket(message);
		}
	}
	
	public static void main(String[] args)
	{
		new RainbowSpringsChateau(-1, qn, "conquerablehalls");
	}
}