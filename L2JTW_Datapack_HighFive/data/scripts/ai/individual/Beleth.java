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

/**
 * ¬¼Ây­º»â ¤Ú¦C´µ
 * @author: Unkown
 * @Thanks to: Appocalipse
 */

package ai.individual;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ScheduledFuture;

import javolution.util.FastList;
import javolution.util.FastMap;

import ai.group_template.L2AttackableAIScript;

import com.l2jserver.gameserver.ThreadPoolManager;
import com.l2jserver.gameserver.ai.CtrlIntention;
import com.l2jserver.gameserver.datatables.DoorTable;
import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.instancemanager.GrandBossManager;
import com.l2jserver.gameserver.instancemanager.ZoneManager;
import com.l2jserver.gameserver.model.L2CommandChannel;
import com.l2jserver.gameserver.model.L2ItemInstance;
import com.l2jserver.gameserver.model.L2Party;
import com.l2jserver.gameserver.model.L2Skill;
import com.l2jserver.gameserver.model.L2Spawn;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.L2Decoy;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.L2Summon;
import com.l2jserver.gameserver.model.actor.instance.L2GrandBossInstance;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.zone.type.L2BossZone;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.ExShowScreenMessage;
import com.l2jserver.gameserver.network.serverpackets.MagicSkillUse;
import com.l2jserver.gameserver.network.serverpackets.SocialAction;
import com.l2jserver.gameserver.network.serverpackets.SpecialCamera;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;
import com.l2jserver.gameserver.templates.StatsSet;
import com.l2jserver.gameserver.util.Util;
import com.l2jserver.util.Rnd;

/**
 * Beleth AI
 * 
 * @author Probe <br>
 * @Description <li>As retail like as possible Beleth AI. Includes fully working
 *              Beleth raid, with clones. <li>Ring is rewarded by Beleth's
 *              coffin.</li>
 * 
 * @TODO <li>Complete entry movie. <li>Minor bug fixing.
 * 
 * @Notes <li>Skill handling (chances and decisions) isn't 100% retail like.
 */

public class Beleth extends L2AttackableAIScript
{
	// Quest name
	private static final String qn = "Beleth";

	// Debug
	private static boolean debug = true;

	// Reward Item: Beleth's Ring
	private static final int RING = 10314;

	// Chamber of Beleth Zone ID
	private static final int BELETHZONEID = 8003;

	// NPC Id's
	private static final int BELETH = 29118; // Beleth.
	private static final int CLONE = 29119; // Beleth's clone.
	private static final int[] INCARNATION = {
			29126, 29127
	};
	//Runable vars
	private ScheduledFuture<?> _BelethRespawnClone;
	private ScheduledFuture<?> _BelethDespawn;

	// Beleth's incarnations.
	private static final int VORTEX = 29125; // Vortex.
	private static final int ELF = 29128; // Elf corpse.
	private static final int COFFIN = 32470; // Beleth's coffin.
	private static final int SLAVE = 18490; // Start npc - Beleth's Slave
	private static final int CAMERA = 29120; // Cameras

	// Doors
	private static final int DOOR = 20240001; // Throne door
	private static final int CORRDOOR = 20240002; // Corridor door
	private static final int COFFDOOR = 20240003; // Tomb door

	// Status indicators
	private static boolean _entryLocked = false;
	private static boolean _awaitingDeath = false;

	private static final int AVAILABLE = 0;
	private static final int ALIVE = 1;
	private static final int DEAD = 2;

	// Triggers
	private static boolean _spawnTrigger = false; // Trigger for clone respawn
	private static long _spawnTime = 0;
	private static final long _spawnInterval = 20000;

	// Time variables
	private static long _lastAction = 0;
	private static long _relocationTime = 0;
	private static final int _doorWaitTimeDuration = 300000; // Time before door
															// to beleth opens.
															// Default: 5
															// minutes.
	private static final int _spawnWaitTimeDuration = 300000; // Time before
																// beleth spawns
																// (since door
																// opens)
																// Default: 5
																// minutes.

	// Zone
	private static L2BossZone _chamberOfBeleth = null;

	// NPC List
	private List<L2Npc> _npcList = new FastList<L2Npc>();

	// Clones
	private Map<L2GrandBossInstance, Boolean> _clones = new FastMap<L2GrandBossInstance, Boolean>();
	private static Location[] _cloneLoc = new Location[56];

	// Beleth
	private static L2GrandBossInstance _beleth = null;
	private static double _belethHp = 0;
	private static double _belethMp = 0;
	private static final int[] BELSPAWN = {
			16325, 214614, - 9353, 49152
	};
	private static double _relocatePercent = 0.8;
	private static int _lastCloneReplaced = - 1;

	// Spawn Locations
	private static final int centerX = 16325; // Center of the room
	private static final int centerY = 213135;
	private static final int locZ = - 9353; // Z value for all of npcs

	// Camera locations
	private static final int[] camX = {
			16194, 16568, 16896, 16325, 16327, 16325, 16073
	};
	private static final int[] camY = {
			212718, 212897, 213183, 214614, 213135, 214101, 213738
	};

	private static final int[] VORTEXSPAWN = {
			16325, 214983, - 9353
	};
	private static final int[] COFFSPAWN = {
			12471, 215602, - 9360, 49152
	};
	private static final int[] EXITLOC = {
			- 24095, 251617, - 3374
	};
	
	protected class Location
	{
		final public int x,y,h;
		
		public Location(int newX, int newY, int newH)
		{
			x = newX;
			y = newY;
			h = newH;
		}
	}

	private enum Event
	{
		none, start, open_door, close_door, relocate_beleth, beleth_spawn, beleth_despawn, clone_despawn, camera_handler, clone_spawn, incarnation_spawn, incarnation_spawn2, beleth_disappear, beleth_reappear, relocation_check, mobilize_clones, respawn_clone, respawn_clones, spawn_ring, spawn_extras, beleth_unlock, beleth_dead, death_camera, camera
	}

	public class eventExecutor implements Runnable
	{
		Event _event;
		L2Npc _npc;
		final int _cameraId;

		eventExecutor(String event, L2Npc npc)
		{
			if (! event.startsWith("camera"))
			{
				_event = Event.valueOf(event);
				_npc = npc;
				_cameraId = - 1;
				return;
			}
			_event = Event.camera;
			_npc = npc;
			_cameraId = Integer.parseInt(event.substring(7));
		}

		eventExecutor(Event event, L2Npc npc)
		{
			_event = event;
			_npc = npc;
			_cameraId = - 1;
		}

		public void run()
		{
			switch (_event)
			{
			case start:
				_chamberOfBeleth.broadcastPacket(new ExShowScreenMessage(1, -1, 0x01, 0, 0, 0, 0, true, 10000, 0, "The door to Beleth will open in 5 minutes."));
				ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor(Event.open_door, null), _doorWaitTimeDuration);
				break;
			case open_door:
				DoorTable.getInstance().getDoor(DOOR).openMe();
				ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor(Event.beleth_spawn, null), _spawnWaitTimeDuration);
				break;
			case close_door:
				DoorTable.getInstance().getDoor(DOOR).closeMe();
				_entryLocked = true;
				break;
			case camera:
				if (_cameraId == - 1)
					return;
				handleCamera(_npc, _cameraId);
				break;
			case beleth_spawn:
				L2Npc temp = addSpawn(VORTEX, VORTEXSPAWN[0], VORTEXSPAWN[1], VORTEXSPAWN[2], 0, false, 0);
				_npcList.add(temp);
				_beleth = (L2GrandBossInstance) addSpawn(BELETH, BELSPAWN[0], BELSPAWN[1], BELSPAWN[2], BELSPAWN[3], false, 0);
				_beleth.setIsInvul(true);
				_beleth.setIsNoRndWalk(true);
				_beleth.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
				GrandBossManager.getInstance().addBoss(_beleth);
				GrandBossManager.getInstance().setBossStatus(BELETH, ALIVE);
				ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor(Event.clone_spawn, null), 60000);
				break;
			case clone_spawn:
				L2GrandBossInstance clone;
				for (int i = 0; i < 32; i++)
				{
					clone = (L2GrandBossInstance) addSpawn(CLONE, _cloneLoc[i].x, _cloneLoc[i].y, locZ,  _cloneLoc[i].h, false, 0, true);
					clone.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
					clone.setIsNoRndWalk(true);
					clone.setIsImmobilized(true);
					clone.setIsInvul(true);
					_clones.put(clone, false);
				}
				break;
			case incarnation_spawn:
				int newX = centerX + 100;
				temp = addSpawn(INCARNATION[0], newX, centerY, locZ, BELSPAWN[3], false, 0, true);
				_npcList.add(temp);
				break;
			case incarnation_spawn2:
				newX = centerX - 100;
				temp = addSpawn(INCARNATION[1], newX, centerY, locZ, BELSPAWN[3], false, 0, true);
				_npcList.add(temp);
				break;
			case beleth_disappear:
				ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor(Event.mobilize_clones, null), 10);
				_beleth.teleToLocation(COFFSPAWN[0], COFFSPAWN[1], COFFSPAWN[2]);
				for (L2Npc npc : _npcList)
					npc.deleteMe();
				_npcList.clear();
				ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor(Event.beleth_reappear, null), 60000);
				break;
			case mobilize_clones:
				if (_clones.isEmpty() || _clones.size() == 0)
					return;
				for (L2GrandBossInstance cl : _clones.keySet())
				{
					cl.setIsImmobilized(false);
					cl.setIsInvul(false);
				}
				for (L2Npc npc : _npcList)
					npc.deleteMe();
				_npcList.clear();
				break;
			case beleth_reappear:
				_beleth.setIsInvul(false);
				_beleth.teleToLocation(centerX, centerY, locZ);
				performSocialAction(_beleth, 4);
				break;
			case respawn_clone:
				// Make sure that beleth is alive (if he's dead then so are the
				// clones)
				if (GrandBossManager.getInstance().getBossStatus(BELETH) != ALIVE)
					return;
				L2Spawn spawn = _npc.getSpawn();
				int id = getCloneId(spawn);
				deleteClone(_cloneLoc[id].x, _cloneLoc[id].y);
				if (_awaitingDeath) // Respawn beleth and not the clone
				{
					respawnLastReplaced(id);
					relocateBeleth(id);
					return;
				}
				if (debug)
					System.err.println("got to clone respawn");
				spawnClone(id);
				break;
			case respawn_clones:
				for (L2GrandBossInstance cl : _clones.keySet())
				{
					if (_clones.get(cl))
					{
						id = getCloneId(cl.getSpawn());
						deleteClone(_cloneLoc[id].x, _cloneLoc[id].y);
						spawnClone(id);
					}
				}
				_spawnTime = System.currentTimeMillis();
				break;
			case relocate_beleth:
				/*
				 * Beleth's hp\mp are stored, and then we delete it, setting the
				 * boolean trigger to be true. when the "respawn_clone" event
				 * sees that boolean trigger is true, it will simply spawn
				 * beleth instead of that clone, so players won't notice any
				 * difference.
				 */
				_belethHp = _beleth.getCurrentHp();
				_belethMp = _beleth.getCurrentMp();
				_beleth.deleteMe();
				_beleth = null;
				id = getRndClone();
				if (id != - 1)
				{
					deleteClone(_cloneLoc[id].x, _cloneLoc[id].y);
					respawnLastReplaced(id);
					relocateBeleth(id);
					return;
				}
				_awaitingDeath = true;
				_relocationTime = System.currentTimeMillis();
				ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor(Event.relocation_check, _npc), 60000);
				break;
			case relocation_check:
				// Checks if a clone hasn't died for over 30 seconds, meaning
				// beleth has yet to be spawned
				// If it's still dead, respawn it in the center of the room.
				if (_relocationTime + 30000 < System.currentTimeMillis() && _beleth == null)
				{
					_beleth = (L2GrandBossInstance) addSpawn(BELETH, centerX, centerY, locZ, BELSPAWN[3], false, 0);
					_beleth.setCurrentHp(_belethHp);
					_beleth.setCurrentMp(_belethMp);
					_beleth.setIsNoRndWalk(true);
					_awaitingDeath = false;
				}
				break;
			case spawn_ring:
				for (int i = 32; i < 48; i++)
					spawnClone(i);
				break;
			case spawn_extras:
				for (int i = 48; i < 56; i++)
					spawnClone(i);
				break;
			case beleth_dead:
				// To make sure that clones that died won't respawn after 30
				// seconds
				boolean bool;
				do
				{
					//bool = ThreadPoolManager.getInstance().removeGeneral(_BelethRespawnClone);
					bool = false;
					_BelethRespawnClone.cancel(false);
					_BelethRespawnClone = null;
				}
				while (bool);

				ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor(Event.death_camera, _npc), 10);
				;
				temp = addSpawn(ELF, centerX, centerY, locZ, BELSPAWN[3], false, 0);
				_npcList.add(temp);
				temp = addSpawn(COFFIN, COFFSPAWN[0], COFFSPAWN[1], COFFSPAWN[2], COFFSPAWN[3], false, 0);
				_npcList.add(temp);
				DoorTable.getInstance().getDoor(CORRDOOR).openMe();
				DoorTable.getInstance().getDoor(COFFDOOR).openMe();
				GrandBossManager.getInstance().setBossStatus(BELETH, DEAD);
				// int respawnTime = 172800000; // Respawn time set to 2 days
				int respawnTime = 5000;
				StatsSet info = GrandBossManager.getInstance().getStatsSet(BELETH);
				info.set("respawn_time", (System.currentTimeMillis()) + respawnTime);
				GrandBossManager.getInstance().setStatsSet(BELETH, info);
				ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor(Event.clone_despawn, null), 10);
				break;
			case death_camera:
				int angle = (int) Util.convertHeadingToDegree(_npc.getHeading());
				_chamberOfBeleth.broadcastPacket(new SpecialCamera(_npc.getObjectId(), 0, angle + 180, - 70, 5000, 8000));
				break;
			case beleth_despawn:
				int despawnDelay = 300000; // Time for inactivity (beleth\clones
											// haven't been attacked for this
											// long)
				if (_lastAction + despawnDelay < System.currentTimeMillis())
				{
					// Despawn NPCs
					for (L2Npc n : _npcList)
						if (n != null)
							n.deleteMe();
					_npcList.clear();

					// Despawn Beleth
					if (_beleth != null)
						_beleth.deleteMe();
					_beleth = null;

					// Despawn clones (they should all be dead, this is just to
					// make sure)
					ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor(Event.clone_despawn, null), 10);

					// Close coffin and corridor doors
					DoorTable.getInstance().getDoor(CORRDOOR).closeMe();
					DoorTable.getInstance().getDoor(COFFDOOR).closeMe();

					// Remove players from zone
					_chamberOfBeleth.oustAllPlayers();
					_chamberOfBeleth = null;

					// If event was called and beleth is still alive (meaning
					// players died),
					// set beleth to AVAILABLE so that it can be accessed by
					// others.
					if (GrandBossManager.getInstance().getBossStatus(BELETH) == ALIVE)
						ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor(Event.beleth_unlock, null), 10);

					do
					{
						//bool = ThreadPoolManager.getInstance().removeGeneral(new eventExecutor(Event.beleth_despawn, null));
						bool = false;
						_BelethDespawn.cancel(false);
						_BelethDespawn = null;
					}
					while (bool);
				}
				else
				{
					do
					{
						//bool = ThreadPoolManager.getInstance().removeGeneral(_BelethRespawnClone);
						bool = false;
						_BelethRespawnClone.cancel(false);
						_BelethRespawnClone = null;
					}
					while (bool);
					long time = _lastAction + despawnDelay - System.currentTimeMillis();
					if (time >= 0)
						_BelethDespawn = ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor(Event.beleth_despawn, null), time);
				}
				break;
			case clone_despawn:
				if (_clones.isEmpty() || _clones.size() == 0)
					return;
				for (L2GrandBossInstance cl : _clones.keySet())
					if (cl != null)
						cl.deleteMe();
				_clones.clear();
				break;
			case beleth_unlock:
				GrandBossManager.getInstance().setBossStatus(BELETH, AVAILABLE);
				_entryLocked = false;
				break;
			}
		}
	}

	private void handleCamera(L2Npc npc, int cameraId)
	{
		L2Npc temp;
		switch (cameraId)
		{
		case 0: // Initial camera handler
			temp = this.addSpawn(CAMERA, camX[1], camY[1], locZ, 0, false, 0);
			_npcList.add(temp);
			_chamberOfBeleth.broadcastPacket(new SpecialCamera(temp.getObjectId(), 1500, 0, 85, 0, 1000));
			ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("camera_1", temp), 700);
			break;
		case 1: // Camera 1 - Swirling down
			_chamberOfBeleth.broadcastPacket(new SpecialCamera(npc.getObjectId(), 1500, 0, 95, 1400, 2000, 0, 180, 0, 0));
			ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("camera_11", npc), 1800);
			break;
		case 11:
			_chamberOfBeleth.broadcastPacket(new SpecialCamera(npc.getObjectId(), 1300, 270, 120, 4500, 4800, 0, 180, 0, 0));
			ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("camera_12", npc), 4500);
			break;
		case 12:
			_chamberOfBeleth.broadcastPacket(new SpecialCamera(npc.getObjectId(), 1000, 180, 135, 4500, 4800, 0, 180, 0, 0));
			ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("camera_13", npc), 4500);
			break;
		case 13:
			_chamberOfBeleth.broadcastPacket(new SpecialCamera(npc.getObjectId(), 600, 75, 140, 4500, 4800, 0, 180, 0, 0));
			ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("camera_14", npc), 4000);
			break;
		case 14:
			_chamberOfBeleth.broadcastPacket(new SpecialCamera(npc.getObjectId(), 300, 90, 170, 1000, 2000, 0, 180, 0, 0));
			temp = this.addSpawn(CAMERA, camX[1], camY[1], locZ, 0, false, 0);
			_npcList.add(temp);
			ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("camera_15", temp), 1700);
			break;
		case 15:
			_chamberOfBeleth.broadcastPacket(new SpecialCamera(npc.getObjectId(), 0, 90, 1, 2000, 3500, 0, 0, 0, 0));
			ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("close_door", npc), 2500);
			break;
		case 2: // Camera 2 - Beleth appearance
			_chamberOfBeleth.broadcastPacket(new SpecialCamera(npc.getObjectId(), 700, 0, 1, 0, 500));
			ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("camera_21", npc), 500);
			break;
		case 21:
			_chamberOfBeleth.broadcastPacket(new SpecialCamera(npc.getObjectId(), 700, 265, 1, 6000, 7000));
			ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("beleth_spawn", npc), 6500);
			ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("camera_22", npc), 6900);
			break;
		}
	}

	/**
	 * Initializes spawn locations of all 56 clones <li>Inner octagon <li>Outer
	 * square <li>Middle octagon <li>8 Extras
	 */
	private void initSpawnLocs()
	{
		// Variables for Calculations
		double angle = Math.toRadians(22.5);
		int radius = 700;

		// Inner clone circle
		for (int i = 0; i < 16; i++)
		{
			if (i % 2 == 0)
				radius -= 50;
			else
				radius += 50;
			_cloneLoc[i] = new Location(centerX + (int) (radius * Math.sin(i * angle)),
					centerY + (int) (radius * Math.cos(i * angle)),
					Util.convertDegreeToClientHeading(270 - i * 22.5));
		}
		// Outer clone square
		radius = 1340;
		angle = Math.asin(1 / Math.sqrt(3));
		int mulX = 1, mulY = 1, addH = 3;
		double decX = 1.0, decY = 1.0;
		for (int i = 0; i < 16; i++)
		{
			if (i % 8 == 0)
				mulX = 0;
			else if (i < 8)
				mulX = - 1;
			else
				mulX = 1;
			if (i == 4 || i == 12)
				mulY = 0;
			else if (i > 4 && i < 12)
				mulY = - 1;
			else
				mulY = 1;
			if (i % 8 == 1 || i == 7 || i == 15)
				decX = 0.5;
			else
				decX = 1.0;
			if (i % 10 == 3 || i == 5 || i == 11)
				decY = 0.5;
			else
				decY = 1.0;
			if ((i + 2) % 4 == 0)
				addH++;
			_cloneLoc[i + 16] = new Location(centerX + (int) (radius * decX * mulX),
							centerY + (int) (radius * decY * mulY),
							Util.convertDegreeToClientHeading(180 + addH * 90));
		}
		// Octagon #2 - Another ring of clones like the inner square, that
		// spawns after some time
		angle = Math.toRadians(22.5);
		radius = 1000;
		for (int i = 0; i < 16; i++)
		{
			if (i % 2 == 0)
				radius -= 70;
			else
				radius += 70;
			_cloneLoc[i + 32] = new Location(centerX + (int) (radius * Math.sin(i * angle)),
						centerY + (int) (radius * Math.cos(i * angle)),
						_cloneLoc[i].h);
		}
		// Extra clones - Another 8 clones that spawn when beleth is close to
		// dying
		int order = 48;
		radius = 650;
		for (int i = 1; i < 16; i += 2)
		{
			if (i == 1 || i == 15)
			{
				_cloneLoc[order] = new Location(_cloneLoc[i].x, _cloneLoc[i].y + radius, _cloneLoc[i+16].h);
			}
			else if (i == 3 || i == 5)
			{
				_cloneLoc[order] = new Location(_cloneLoc[i].x + radius, _cloneLoc[i].y, _cloneLoc[i].h);
			}
			else if (i == 7 || i == 9)
			{
				_cloneLoc[order] = new Location(_cloneLoc[i].x, _cloneLoc[i].y - radius, _cloneLoc[i+16].h);
			}
			else if (i == 11 || i == 13)
			{
				_cloneLoc[order] = new Location(_cloneLoc[i].x - radius, _cloneLoc[i].y, _cloneLoc[i].h);
			}
			order++;
		}
	}

	/**
	 * @param player
	 *            : The player instance trying to get inside the raid.
	 * @return if player is qualified to start the raid
	 */
	private boolean checkConditions(L2PcInstance player)
	{
		if (debug)
			return true;
		L2Party party = player.getParty();
		if (party == null)
		{
			player.sendMessage("You are not in a party.");
			return false;
		}
		L2CommandChannel channel = party.getCommandChannel();
		if (channel == null)
		{
			player.sendMessage("Your party is not in a command channel.");
			return false;
		}
		if ((channel.getChannelLeader() == player))
		{
			player.sendMessage("Only the leader of the command channel may approach me.");
			return false;
		}
		// Custom
		if ((channel.getPartys().size() > 1) && (channel.getPartys().size() < 4) && (channel.getMemberCount() > 17) && (channel.getMemberCount() < 28))
		{
			player.sendMessage("Your command channel must consist of a minimum of 18 players.");
			return false;
		}
		return true;
	}

	/**
	 * Sends a skill cast packet from npc
	 * 
	 * @param npc
	 * @param skillId
	 * @param hittime
	 */
	@SuppressWarnings("unused")
	private void performSkillUse(L2Character npc, int skillId, int hittime)
	{
		try
		{
			int level = 1;
			_chamberOfBeleth.broadcastPacket(new MagicSkillUse(npc, npc, skillId, level, hittime, 0));
		}
		catch (Exception e)
		{
		}
	}

	/**
	 * Sends a social action packet by npc
	 * 
	 * @param npc
	 * @param socialId
	 */
	private void performSocialAction(L2Npc npc, int socialId)
	{
		try
		{
			_chamberOfBeleth.broadcastPacket(new SocialAction(npc.getObjectId(), socialId));
		}
		catch (Exception e)
		{
		}
	}

	/**
	 * Respawns a clone according to id
	 * 
	 * @param id
	 */
	private void spawnClone(int id)
	{
		if (debug)
			System.err.println("got to spawnClone");
		if (id == - 1)
			return;
		for (L2GrandBossInstance clone : _clones.keySet())
			if (clone.getSpawn().getLocx() == _cloneLoc[id].x && clone.getSpawn().getLocy() == _cloneLoc[id].y)
			{
				if (debug)
					System.err.println("x,y existed");
				return;
			}
		L2GrandBossInstance clone = (L2GrandBossInstance) this.addSpawn(CLONE, _cloneLoc[id].x, _cloneLoc[id].y, locZ, _cloneLoc[id].h, false, 0, true);
		clone.getAI().setIntention(CtrlIntention.AI_INTENTION_ACTIVE);
		clone.setIsNoRndWalk(true);
		if (debug)
			System.err.println("spawned new clone");
		_clones.put(clone, false);
	}

	private void deleteClone(int x, int y)
	{
		int size = _clones.size();
		L2GrandBossInstance[] clones = new L2GrandBossInstance[size];
		_clones.keySet().toArray(clones);
		for (int i = 0; i < size; i++)
			if (x == clones[i].getSpawn().getLocx() && y == clones[i].getSpawn().getLocy())
			{
				_clones.remove(clones[i]);
				clones[i].deleteMe();
			}
	}

	/**
	 * Relocates beleth to a certain clone position
	 * 
	 * @param id
	 */
	private void relocateBeleth(int id)
	{
		_awaitingDeath = false;
		_beleth = (L2GrandBossInstance) this.addSpawn(BELETH,  _cloneLoc[id].x, _cloneLoc[id].y, locZ, _cloneLoc[id].h, false, 0);
		_beleth.setCurrentHp(_belethHp);
		_beleth.setCurrentMp(_belethMp);
		_beleth.setIsNoRndWalk(true);
		_beleth.getAI().setIntention(CtrlIntention.AI_INTENTION_ACTIVE);
	}

	/**
	 * Respawn the clone previously replaced by Beleth
	 * 
	 * @param id
	 */
	private void respawnLastReplaced(int id)
	{
		if (debug)
			System.err.println("got to respawnLastReplaced");
		if (id == - 1)
			return;
		if (_lastCloneReplaced == - 1)
		{
			_lastCloneReplaced = id;
			return;
		}
		if (debug)
			System.err.println("passed respawnLast checks");
		spawnClone(_lastCloneReplaced);
		_lastCloneReplaced = id;
		if (debug)
			System.err.println("lastCloneReplaced = " + id);
	}

	/**
	 * @return a random clone id that is not dead or in combat
	 */
	private int getRndClone()
	{
		int id, i = 0, size = _clones.size();
		L2GrandBossInstance[] clones = new L2GrandBossInstance[size];
		_clones.keySet().toArray(clones);
		do
		{
			id = Rnd.get(size);
			i++;
		}
		while (i < size && (clones[id].isInCombat() || clones[id].isDead()));
		if (i == size)
			return - 1;
		return id;
	}

	/**
	 * @param clone
	 * @return The numeral id of the clone.
	 */
	private int getCloneId(L2Spawn spawn)
	{
		if (spawn == null)
			return - 1;
		for (int i = 0; i < 56; i++)
		{
			if (spawn.getLocx() == _cloneLoc[i].x && spawn.getLocy() == _cloneLoc[i].y)
				return i;
		}
		return - 1;
	}

	/**
	 * @param npc
	 * @return skill cast target, if conditions are met, else null.
	 * 
	 */
	private L2Character castAOE(L2Npc npc)
	{
		FastList<L2Character> result = new FastList<L2Character>();
		Collection<L2Character> chars = npc.getKnownList().getKnownCharactersInRadius(250);
		// Adds players \ summons \ decoys to the result list
		for (L2Character ch : chars)
		{
			if (ch instanceof L2PcInstance || ch instanceof L2Summon || ch instanceof L2Decoy)
				result.add(ch);
		}
		// If there are more than 4 players around the npc, cast AOE skill
		if (result.size() > 2 && Rnd.get(100) < 90)
		{
			L2Character[] inRange = new L2Character[result.size()];
			result.toArray(inRange);
			return inRange[Rnd.get(inRange.length)];
		}
		return null;
	}

	/**
	 * Handles skill casting for beleth and his clones.
	 * 
	 * @param npc
	 */
	private void callSkillAI(L2Npc npc)
	{
		int npcId = npc.getNpcId();
		if ((npcId != BELETH) && (npcId != CLONE))
			return; // These are the only NPCs which require casting.
		if (npc.isInvul() || npc.isCastingNow())
			return;
		int skillId = - 1;
		L2Character target;
		target = castAOE(npc);
		if (target != null)
		{
			skillId = 5495;
		}
		else
			target = ((L2GrandBossInstance) npc).getMostHated();
		if (target == null || target.isDead())
		{
			npc.setIsCastingNow(false);
			return;
		}
		if (skillId == - 1)
		{
			if (Util.checkIfInRange(250, npc, target, false) && npcId != BELETH)
			{
				if (Rnd.get(100) < 50)
					skillId = 5499;
				else
					skillId = 5496;
			}
			else
			{
				if (Rnd.get(100) < 20)
					skillId = 5497;
				else
					skillId = 5496;
			}
		}
		L2Skill skill = SkillTable.getInstance().getInfo(skillId, 1);
		if (Util.checkIfInRange(skill.getCastRange(), npc, target, true))
		{
			npc.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
			npc.setTarget(target);
			npc.setIsCastingNow(true);
			try
			{
				Thread.sleep(1000);
				npc.stopMove(null);
				npc.doCast(skill);
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
			// npc.getAI().setIntention(CtrlIntention.AI_INTENTION_CAST,target);
		}
		else
		{
			npc.getAI().setIntention(CtrlIntention.AI_INTENTION_FOLLOW, target, null);
			npc.setIsCastingNow(false);
		}

	}

	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor(event, npc), 5);
		return super.onAdvEvent(event, npc, player);
	}

	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		int npcId = npc.getNpcId();
		if (npcId == SLAVE)
		{
			if (_entryLocked)
				return "<html><body>Either there is another group in the Beleth's Chamber or Beleth cannot be visited at this moment. </html></body>";
			if (checkConditions(player))
			{
				ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("open_door", null), _doorWaitTimeDuration);
				_chamberOfBeleth.allowPlayerEntry(player, 7200);
				if (debug)
					_chamberOfBeleth.allowPlayerEntry(player, 7200);
				else
				{
					L2CommandChannel channel = player.getParty().getCommandChannel();
					for (L2PcInstance chMember : channel.getMembers())
						_chamberOfBeleth.allowPlayerEntry(chMember, 7200);
				}
			}
		}
		else if (npcId == ELF)
		{
			player.teleToLocation(EXITLOC[0], EXITLOC[1], EXITLOC[2]);
			if (player.getPet() != null)
				player.getPet().teleToLocation(EXITLOC[0], EXITLOC[1], EXITLOC[2]);
		}
		else if (npcId == COFFIN)
		{
			if (debug)
			{
				L2ItemInstance ring = player.getInventory().addItem("Admin", RING, 1, player, null);
				SystemMessage sm = SystemMessage.getSystemMessage(SystemMessageId.YOU_PICKED_UP_S1);
				sm.addItemName(ring);
				player.sendPacket(sm);
				sm = SystemMessage.getSystemMessage(SystemMessageId.C1_OBTAINED_S2);
				sm.addCharName(player);
				sm.addItemName(ring);
				_chamberOfBeleth.broadcastPacket(sm);
				npc.deleteMe();
				return "";
			}
			L2Party party = player.getParty();
			L2CommandChannel channel = party.getCommandChannel();
			if (channel.getChannelLeader() == player)
			{
				L2ItemInstance ring = player.getInventory().addItem("Admin", RING, 1, player, null);
				SystemMessage sm = SystemMessage.getSystemMessage(SystemMessageId.C1_OBTAINED_S2);
				sm.addCharName(player);
				sm.addItemName(ring);
				channel.broadcastToChannelMembers(sm);
				npc.deleteMe();
			}
			else
				return "32470-1.htm";
		}
		return "";
	}

	public String onKill(L2Npc npc, L2PcInstance killer, boolean isPet)
	{
		int npcId = npc.getNpcId();
		if (npcId == CLONE)
		{
			int size = _clones.size();
			L2GrandBossInstance[] clones = new L2GrandBossInstance[size];
			_clones.keySet().toArray(clones);
			for (int i = 0; i < size; i++)
				if (npc.getSpawn() == clones[i].getSpawn())
					_clones.put(clones[i], true);
			_BelethRespawnClone = ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("respawn_clone", npc), 30000);
		}
		else if (npcId == BELETH)
		{
			ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("beleth_dead", npc), 10);
		}
		return "";
	}

	public String onAttack(L2Npc npc, L2PcInstance attacker, int damage, boolean isPet, L2Skill skill)
	{
		int npcId = npc.getNpcId();
		if (npcId == BELETH)
		{
			if (_spawnTrigger && System.currentTimeMillis() > _spawnTime + _spawnInterval)
				_BelethRespawnClone = ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("respawn_clones", npc), 10);
		}
		if ((npcId == BELETH) && (npc.getCurrentHp() <= (npc.getMaxHp() * _relocatePercent)) && (_relocatePercent > 0))
		{
			if (debug)
				System.err.println("relocatePercent was" + _relocatePercent);
			if (_relocatePercent >= 0.6 && _relocatePercent < 0.8)
			{
				_spawnTrigger = true;
				ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("spawn_ring", npc), 10);
				_BelethRespawnClone = ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("respawn_clones", npc), 10);
			}
			else if (_relocatePercent >= 0.2 && _relocatePercent < 0.4)
			{
				ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("spawn_extras", npc), 10);
				_BelethRespawnClone = ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("respawn_clones", npc), 10);
			}
			ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("relocate_beleth", npc), 10);
			_relocatePercent -= 0.2;
			_lastAction = System.currentTimeMillis();
			return "";
		}
		if ((npcId == BELETH) || (npcId == CLONE))
		{
			_lastAction = System.currentTimeMillis();
			callSkillAI(npc);
		}
		return "";
	}

	public String onFactionCall(L2Npc npc, L2Npc caller, L2PcInstance attacker, boolean isPet)
	{
		// Starts casting skills on a target if not already casting
		// helps avoid "dead" moments
		if (! npc.isCastingNow())
		{
			callSkillAI(npc);
		}
		return "";
	}

	/**
	 * <b>Constructor of the AI</b> <br>
	 * <li>Registers all relevant npcs.</li> <li>Initializes spawn locations for
	 * all of the clones.</li> <li>Determines if Beleth is available.</li> <li>
	 * Initializes zone for chamber of beleth.</li>
	 */
	public Beleth(int id, String name, String descr)
	{
		super(id, name, descr);

		// Add talk npcs
		addStartNpc(SLAVE);
		addTalkId(SLAVE);
		addTalkId(ELF);
		addTalkId(COFFIN);

		// Add mobs
		int[] mobs = {
				BELETH, CLONE
		};
		registerMobs(mobs);

		// Initialize clone spawn locations
		initSpawnLocs();

		// Close all doors
		DoorTable.getInstance().getDoor(DOOR).closeMe();
		DoorTable.getInstance().getDoor(CORRDOOR).closeMe();
		DoorTable.getInstance().getDoor(COFFDOOR).closeMe();

		// Get zone
		_chamberOfBeleth = (L2BossZone) ZoneManager.getInstance().getZoneById(BELETHZONEID);
		if (_chamberOfBeleth == null)
			System.err.println("ZONE NOT WORKING!");

		// Get Beleth's status
		StatsSet info = GrandBossManager.getInstance().getStatsSet(BELETH);
		int status = GrandBossManager.getInstance().getBossStatus(BELETH);
		if (status == DEAD)
		{
			long time = (info.getLong("respawn_time") - System.currentTimeMillis());
			if (time > 0)
			{
				ThreadPoolManager.getInstance().scheduleGeneral(new eventExecutor("beleth_unlock", null), time);
				_entryLocked = true;
			}
			else
			{
				// the time has already expired while the server was offline.
				// Allow entry.
				_entryLocked = false;
				GrandBossManager.getInstance().setBossStatus(BELETH, AVAILABLE);
			}
		}
		else
		{
			if (status == ALIVE)
				GrandBossManager.getInstance().setBossStatus(BELETH, AVAILABLE);
			_entryLocked = false;
		}
	}

	public static void main(String[] args)
	{
		// Call the constructor to start up the AI.
		new Beleth(- 1, qn, "ai");
	}
}
