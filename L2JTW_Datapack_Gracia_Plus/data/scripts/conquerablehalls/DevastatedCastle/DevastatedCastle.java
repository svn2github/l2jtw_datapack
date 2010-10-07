package conquerablehalls.DevastatedCastle;

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
 * Devastated Castle siege script
 */
public class DevastatedCastle extends Quest
{	
	private class SiegeStart implements Runnable
	{
		@Override
		public void run()
		{
			ClanHall devastated = ClanHallManager.getInstance().getClanHallById(DEVASTATED);
			
			if(devastated != null)
			{
				_inSiege = true;
				devastated.banishForeigners();
				devastated.spawnDoor();
				CHSiegeManager.getInstance().spawnGuards(DEVASTATED);
				
				final byte state = 1;
				for(L2Clan clan : CHSiegeManager.getInstance().getAttackerList(DEVASTATED))
					for(L2PcInstance pc : clan.getOnlineMembers(0))
					{
						if(pc != null)
						{
							pc.setSiegeState(state);
							pc.broadcastUserInfo();
						}
					}
								
				CHSiegeManager.getInstance().updateSiegeStatus(DEVASTATED, SiegeStatus.IN_SIEGE);
				Announcements.getInstance().announceToAll("The Siege of Devastated Castle has begun!");
				_siegeEnd = ThreadPoolManager.getInstance().scheduleGeneral(new SiegeEnd(false), Config.CHS_SIEGE_LENGTH * 60000);
			}
			else
				_log.warning("DevastatedCaslte (id: "+DEVASTATED+") appear to be null!, SIEGE CANCELED");
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
			ClanHall hall = ClanHallManager.getInstance().getClanHallById(DEVASTATED);
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
					CHSiegeManager.getInstance().setCHOwner(winner, DEVASTATED);
					for(L2Character cha : hall.getZone().getCharactersInside().values())
						cha.setInsideZone(L2Character.ZONE_SIEGE, false);
				}
				hall.banishForeigners();
			}
			
			final long nextSiege = Config.CHS_SIEGE_INTERVAL * 24 * 60 * 60 * 1000 - (Config.CHS_SIEGE_LENGTH * 60000);
			ThreadPoolManager.getInstance().scheduleGeneral(new SiegeStart(), nextSiege);
			CHSiegeManager.getInstance().siegeEnds(DEVASTATED, nextSiege);
			Announcements.getInstance().announceToAll("The Devastated Castle siege is over!");
		}
	}
	
	private static final Logger _log = Logger.getLogger(DevastatedCastle.class.getName());
	private static final String qn = "DevastatedCastle";
	
	private static final int DEVASTATED = 34;

	private static final int GUSTAV = 35410;
	private static final int MESSENGER = 35420;
	
	private static TIntIntHashMap _damageToGustav = new TIntIntHashMap();
	private static boolean _inSiege = false;
	private ScheduledFuture<?> _siegeEnd;
	
	/**
	 * @param questId
	 * @param name
	 * @param descr
	 */
	public DevastatedCastle(int questId, String name, String descr)
	{
		super(questId, name, descr);
		addKillId(GUSTAV);
		addAttackId(GUSTAV);
		addFirstTalkId(MESSENGER);
		long delay = CHSiegeManager.getInstance().getSiegeDate(DEVASTATED);
		if(delay == -1)
			_log.warning("Devastated Castle: No date setted for Devastated Castle Siege!");
		else
		{
			delay -= System.currentTimeMillis();
			ThreadPoolManager.getInstance().scheduleGeneral(new SiegeStart(), delay);
			CHSiegeManager.getInstance().prepareOwnerForSiege(DEVASTATED);
		}
	}
	
	@Override
	public String onFirstTalk(L2Npc npc, L2PcInstance player)
	{
		final int npcId = npc.getNpcId();
		if(npcId == MESSENGER && !_inSiege)
		{
			ClanHall hall = ClanHallManager.getInstance().getClanHallById(DEVASTATED);
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
		
		if(npc.getNpcId() == GUSTAV)
		{
			synchronized(this)
			{
				final L2Clan clan = attacker.getClan();
				
				if(clan != null && CHSiegeManager.getInstance().isClanParticipating(DEVASTATED, clan))
				{
					final int id = clan.getClanId();
					if(_damageToGustav.containsKey(id))
					{
						int newDamage = _damageToGustav.get(id);
						newDamage += damage;
						_damageToGustav.put(id, newDamage);
					}
					else
						_damageToGustav.put(id, damage);
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
		
		if(npcId == GUSTAV)
		{
			L2Clan clan = killer.getClan();
			if(clan != null && CHSiegeManager.getInstance().isClanParticipating(DEVASTATED, clan))
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
		double counter = 0;
		int damagest = 0;
		for(int clan : _damageToGustav.keys())
		{
			final double damage = _damageToGustav.get(clan);
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
		new DevastatedCastle(-1, qn, "conquerablehalls");
	}
}
