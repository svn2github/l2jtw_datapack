package conquerablehalls.FortressOfTheDead;

import gnu.trove.TIntIntHashMap;

import java.util.concurrent.ScheduledFuture;
import java.util.logging.Logger;


import com.l2jserver.Config;
import com.l2jserver.gameserver.Announcements;
import com.l2jserver.gameserver.ThreadPoolManager;
import com.l2jserver.gameserver.datatables.ClanTable;
import com.l2jserver.gameserver.instancemanager.CHSiegeManager;
import com.l2jserver.gameserver.instancemanager.ClanHallManager;
import com.l2jserver.gameserver.instancemanager.CHSiegeManager.SiegeStatus;
import com.l2jserver.gameserver.model.L2Clan;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2DoorInstance;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.entity.ClanHall;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.network.serverpackets.SiegeInfo;

/**
 * @author BiggBoss
 * Fortress of the Dead siege script
 */
public class FortressOfTheDead extends Quest
{	
	private class SiegeStart implements Runnable
	{
		@Override
		public void run()
		{
			ClanHall hall = ClanHallManager.getInstance().getClanHallById(FDEAD);
			
			if(hall != null)
			{
				_inSiege = true;
				hall.banishForeigners();
				hall.spawnDoor();
				CHSiegeManager.getInstance().spawnGuards(FDEAD);
				
				final byte state = 1;
				for(L2Clan clan : CHSiegeManager.getInstance().getAttackerList(FDEAD))
					for(L2PcInstance pc : clan.getOnlineMembers(0))
					{
						if(pc != null)
						{
							pc.setSiegeState(state);
							pc.broadcastUserInfo();
						}
					}
								
				CHSiegeManager.getInstance().updateSiegeStatus(FDEAD, SiegeStatus.IN_SIEGE);
				Announcements.getInstance().announceToAll("The Siege of Fortress of the Dead has begun!");
				_siegeEnd = ThreadPoolManager.getInstance().scheduleGeneral(new SiegeEnd(false), Config.CHS_SIEGE_LENGTH * 60000);
			}
			else
				_log.warning("Fortress of the Dead (id: "+FDEAD+") appear to be null!, SIEGE CANCELED");
		}
	}
	
	private class SiegeEnd implements Runnable
	{		
		private boolean _isKilled;
		
		private SiegeEnd(boolean isKilled)
		{
			_isKilled = isKilled;
		}
		
		@Override
		public void run()
		{
			_inSiege = false;
			ClanHall hall = ClanHallManager.getInstance().getClanHallById(FDEAD);
			for(L2DoorInstance door : hall.getDoors())
			{
				door.deleteMe();
				door.spawnMe();
			}
			
			if(_isKilled)
			{
				L2Clan winner = getWinner();
				if(winner != null)
				{
					CHSiegeManager.getInstance().setCHOwner(winner, FDEAD);
					for(L2Character cha : hall.getZone().getCharactersInside().values())
						cha.setInsideZone(L2Character.ZONE_SIEGE, false);
				}
				hall.banishForeigners();
			}
			
			final long nextSiege = Config.CHS_SIEGE_INTERVAL * 24 * 60 * 60 * 1000 - (Config.CHS_SIEGE_LENGTH * 60000);
			ThreadPoolManager.getInstance().scheduleGeneral(new SiegeStart(), nextSiege);
			CHSiegeManager.getInstance().siegeEnds(FDEAD, nextSiege);
			Announcements.getInstance().announceToAll("The Fortress Of The Dead siege is over!");
		}
	}
	
	private static final Logger _log = Logger.getLogger(FortressOfTheDead.class.getName());
	private static final String qn = "FortressOfTheDead";
	
	private static final int FDEAD = 64;

	private static final int LIDIA = 35629;
	private static final int MESSENGER = 35639;
	
	private static TIntIntHashMap _damageToLidia = new TIntIntHashMap();
	private static boolean _inSiege = false;
	private ScheduledFuture<?> _siegeEnd;
	
	/**
	 * @param questId
	 * @param name
	 * @param descr
	 */
	public FortressOfTheDead(int questId, String name, String descr)
	{
		super(questId, name, descr);
		addKillId(LIDIA);
		addAttackId(LIDIA);
		addFirstTalkId(MESSENGER);
		long delay = CHSiegeManager.getInstance().getSiegeDate(FDEAD);
		if(delay == -1)
			_log.warning("CHSiegeManager: No date setted for Fortress of the Dead Siege!");
		else
		{
			delay -= System.currentTimeMillis();
			ThreadPoolManager.getInstance().scheduleGeneral(new SiegeStart(), delay);
			CHSiegeManager.getInstance().prepareOwnerForSiege(FDEAD);
		}
	}
	
	@Override
	public String onFirstTalk(L2Npc npc, L2PcInstance player)
	{
		final int npcId = npc.getNpcId();
		if(npcId == MESSENGER && !_inSiege)
		{
			ClanHall hall = ClanHallManager.getInstance().getClanHallById(FDEAD);
			if(hall != null)
				player.sendPacket(new SiegeInfo(hall));
		}	
		return super.onFirstTalk(npc, player);
	}
	
	@Override
	public String onAttack(L2Npc npc, L2PcInstance attacker, int damage, boolean isPet)
	{
		if(!_inSiege)
			return null;
		
		if(npc.getNpcId() == LIDIA)
		{
			synchronized(this)
			{
				final L2Clan clan = attacker.getClan();
				
				if(clan != null && CHSiegeManager.getInstance().isClanParticipating(FDEAD, clan))
				{
					final int id = clan.getClanId();
					if(_damageToLidia.containsKey(id))
					{
						int newDamage = _damageToLidia.get(id);
						newDamage += damage;
						_damageToLidia.put(id, newDamage);
					}
					else
						_damageToLidia.put(id, damage);
				}
			}
		}
		return super.onAttack(npc, attacker, damage, isPet);
	}
	
	@Override
	public String onKill(L2Npc npc, L2PcInstance killer, boolean isPet)
	{
		if(!_inSiege) return null;
		
		final int npcId = npc.getNpcId();
		
		if(npcId == LIDIA)
		{
			L2Clan clan = killer.getClan();
			if(clan != null && CHSiegeManager.getInstance().isClanParticipating(FDEAD, clan))
			{
				synchronized(this)
				{
					_siegeEnd.cancel(false);
					ThreadPoolManager.getInstance().executeTask(new SiegeEnd(true));
				}
			}
		}
			
		return super.onKill(npc, killer, isPet);
	}
				
	private L2Clan getWinner()
	{
		int counter = 0;
		int damagest = 0;
		for(int clan : _damageToLidia.keys())
		{
			final int damage = _damageToLidia.get(clan);
			if(damage > counter)
			{
				counter = damage;
				damagest = clan;
			}
		}
		L2Clan winner = ClanTable.getInstance().getClan(damagest);
		return winner;
	}
	
	public static void main(String[] args)
	{
		new FortressOfTheDead(-1, qn, "conquerablehalls");
	}
}
