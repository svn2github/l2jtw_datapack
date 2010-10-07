/**
 * 
 */
package conquerablehalls.FortressOfResistance;

import java.util.concurrent.ScheduledFuture;
import java.util.logging.Logger;

import com.l2jserver.Config;
import com.l2jserver.gameserver.Announcements;
import com.l2jserver.gameserver.GameTimeController;
import com.l2jserver.gameserver.ThreadPoolManager;
import com.l2jserver.gameserver.datatables.ClanTable;
import com.l2jserver.gameserver.datatables.NpcTable;
import com.l2jserver.gameserver.datatables.SpawnTable;
import com.l2jserver.gameserver.instancemanager.CHSiegeManager;
import com.l2jserver.gameserver.instancemanager.ClanHallManager;
import com.l2jserver.gameserver.instancemanager.CHSiegeManager.SiegeStatus;
import com.l2jserver.gameserver.model.L2Clan;
import com.l2jserver.gameserver.model.L2Spawn;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2DoorInstance;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.entity.ClanHall;
import com.l2jserver.gameserver.model.quest.Quest;

/**
 * @author BiggBoss
 * Fortress of Resistance siege Script
 */
public class FortressOfResistance extends Quest
{
	private static final Logger _log = Logger.getLogger(FortressOfResistance.class.getName());
	
	private class SiegeStart implements Runnable
	{
		/* (non-Javadoc)
		 * @see java.lang.Runnable#run()
		 */
		@Override
		public void run()
		{
			int hoursLeft = (GameTimeController.getInstance().getGameTime() / 60) % 24;
			
			if(hoursLeft < 0 || hoursLeft > 6)
			{
				long scheduleTime = (24 - hoursLeft) * 10 * 60000;
				ThreadPoolManager.getInstance().scheduleGeneral(new SiegeStart(), scheduleTime);
				return;
			}
						
			ClanHall hall = ClanHallManager.getInstance().getClanHallById(FORTRESS);
			
			if(hall != null)
			{				
				if(_bloodyLordNuka == null)
				{
					_log.warning("CHSiegeManager: Raid Boss is null!");
					return;
				}
				_bloodyLordNuka.init();
				_inSiege = true;
				hall.banishForeigners();
				
				final byte state = 1;
				for(L2Clan clan : CHSiegeManager.getInstance().getAttackerList(FORTRESS))
					for(L2PcInstance pc : clan.getOnlineMembers(0))
					{
						if(pc != null)
						{
							pc.setSiegeState(state);
							pc.broadcastUserInfo();
						}
					}
								
				CHSiegeManager.getInstance().updateSiegeStatus(FORTRESS, SiegeStatus.IN_SIEGE);
				Announcements.getInstance().announceToAll("The Siege of Fortress Of Ressistance has begun!");
				_siegeEnd = ThreadPoolManager.getInstance().scheduleGeneral(new SiegeEnd(null), Config.CHS_SIEGE_LENGTH * 60000);
			}
			else
				_log.warning("ClanHall Fortress of Resistance (id: "+FORTRESS+") seems to be Null. SIEGE CANCELED!");
		}
	}
	
	private class SiegeEnd implements Runnable
	{
		private L2Clan _winner;
		
		private SiegeEnd(L2Clan winner)
		{
			_winner = winner;
		}
		
		/* (non-Javadoc)
		 * @see java.lang.Runnable#run()
		 */
		@Override
		public void run()
		{
			_inSiege = false;
			ClanHall hall = ClanHallManager.getInstance().getClanHallById(FORTRESS);
			for(L2DoorInstance door : hall.getDoors())
			{
				door.deleteMe();
				door.spawnMe();
			}
			
			if(_winner != null)
			{
				int oldOwnerId = hall.getOwnerId();
				L2Clan oldOwner = ClanTable.getInstance().getClan(oldOwnerId);
				if(oldOwner != null)
				{
					hall.free();
					oldOwner.setHasHideout(0);
					oldOwner.broadcastClanStatus();
				}
				CHSiegeManager.getInstance().setCHOwner(_winner, FORTRESS);
				for(L2Character cha : hall.getZone().getCharactersInside().values())
					cha.setInsideZone(L2Character.ZONE_SIEGE, false);
			}
			
			hall.banishForeigners();
			final long nextSiege = Config.CHS_SIEGE_INTERVAL * 24 * 60 * 60 * 1000 - (Config.CHS_SIEGE_LENGTH * 60000);
			ThreadPoolManager.getInstance().scheduleGeneral(new SiegeStart(), nextSiege);
			CHSiegeManager.getInstance().siegeEnds(FORTRESS, nextSiege);
			Announcements.getInstance().announceToAll("The Fortress of Resistance siege is over!");
		}
	}
	
	private static final String qn = "FortressOfResistance";
	private static final int FORTRESS = 21;
	
	private static final int BLOODY_LORD_NURKA = 35375;
	
	private static boolean _inSiege = false;
	private static ScheduledFuture<?> _siegeEnd;
	private L2Spawn _bloodyLordNuka;
	
	/**
	 * @param questId
	 * @param name
	 * @param descr
	 */
	public FortressOfResistance(int questId, String name, String descr)
	{
		super(questId, name, descr);
		addKillId(BLOODY_LORD_NURKA);
		long siegeTime = CHSiegeManager.getInstance().getSiegeDate(FORTRESS);
		if(siegeTime == -1)
		{
			_log.warning("CHSiegeManager: No date setted for Fortress of Ressistance siege!");
		}
		else
		{
			siegeTime -= System.currentTimeMillis();
			ThreadPoolManager.getInstance().scheduleGeneral(new SiegeStart(), siegeTime);
			setSpawn();
		}
	}
	
	private void setSpawn()
	{
		try
		{
			_bloodyLordNuka = new L2Spawn(NpcTable.getInstance().getTemplate(BLOODY_LORD_NURKA));
			_bloodyLordNuka.setLocx(44525);
			_bloodyLordNuka.setLocy(108867);
			_bloodyLordNuka.setLocz(-2020);
			_bloodyLordNuka.setHeading(1);
			_bloodyLordNuka.setAmount(1);
			_bloodyLordNuka.setRespawnDelay(10800000);
			SpawnTable.getInstance().addNewSpawn(_bloodyLordNuka, false);
		}
		catch(Exception e)
		{
			_log.warning("FortressOfResistance: Couldn't set the Bloody Lord Nuka");
		}
	}
	
	@Override
	public String onKill(L2Npc npc, L2PcInstance killer, boolean isPet)
	{
		if(!_inSiege)
			return null;
		
		if(npc.getNpcId() == BLOODY_LORD_NURKA)
		{
			L2Clan clan = killer.getClan();
			if(clan != null && CHSiegeManager.getInstance().isClanParticipating(FORTRESS, clan))
			{
				synchronized(this)
				{
					_siegeEnd.cancel(false);
					ThreadPoolManager.getInstance().executeTask(new SiegeEnd(clan));
				}
			}
		}
		return super.onKill(npc, killer, isPet);
	}
		
	public static void main(String[] args)
	{
		new FortressOfResistance(-1, qn, "conquerablehalls");
	}
}
