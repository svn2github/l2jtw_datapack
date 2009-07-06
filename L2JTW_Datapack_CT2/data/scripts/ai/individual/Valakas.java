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
package ai.individual;

import ai.group_template.L2AttackableAIScript;
import net.sf.l2j.gameserver.datatables.SkillTable;
import net.sf.l2j.gameserver.instancemanager.GrandBossManager;
import net.sf.l2j.gameserver.model.actor.L2Npc;
import net.sf.l2j.gameserver.model.actor.instance.L2GrandBossInstance;
import net.sf.l2j.gameserver.model.actor.instance.L2PcInstance;
import net.sf.l2j.gameserver.model.zone.type.L2BossZone;
import net.sf.l2j.gameserver.network.serverpackets.PlaySound;
import net.sf.l2j.gameserver.network.serverpackets.SocialAction;
import net.sf.l2j.gameserver.network.serverpackets.SpecialCamera;
import net.sf.l2j.gameserver.templates.StatsSet;
import net.sf.l2j.util.Rnd;
import net.sf.l2j.ExternalConfig;

/**
 * Valakas AI
 * @author Kerberos
 */
public class Valakas extends L2AttackableAIScript
{

	private static final int VALAKAS = 29028;

	//Valakas Status Tracking :
	private static final byte DORMANT = 0;	 	//Valakas is spawned and no one has entered yet. Entry is unlocked
	private static final byte WAITING = 1;	 	//Valakas is spawend and someone has entered, triggering a 30 minute window for additional people to enter
												//before he unleashes his attack. Entry is unlocked
	private static final byte FIGHTING = 2;		//Valakas is engaged in battle, annihilating his foes. Entry is locked
	private static final byte DEAD = 3;			//Valakas has been killed. Entry is locked

	private static L2BossZone _Zone;

	private static long _LastAction = 0;
	private static int _SkillCycle = 0;

	// Boss: Valakas
	public Valakas(int id,String name,String descr)
	{
		super(id,name,descr);
		int[] mob = {VALAKAS};
		this.registerMobs(mob);
		_Zone = GrandBossManager.getInstance().getZone(212852,-114842,-1632);
		StatsSet info = GrandBossManager.getInstance().getStatsSet(VALAKAS);
		int status = GrandBossManager.getInstance().getBossStatus(VALAKAS);
		if (status == DEAD)
		{
			long temp = (info.getLong("respawn_time") - System.currentTimeMillis());
			if (temp > 0)
			{
				this.startQuestTimer("valakas_unlock", temp, null, null);
			}
			else
			{
				GrandBossManager.getInstance().setBossStatus(VALAKAS,DORMANT);
			}
		}
		else
		{
			GrandBossManager.getInstance().setBossStatus(VALAKAS,DORMANT);
		}
	}

	public String onAdvEvent (String event, L2Npc npc, L2PcInstance player)
	{
		long temp = 0;
		if (event.equalsIgnoreCase("1001"))
		{
			GrandBossManager.getInstance().setBossStatus(VALAKAS,WAITING);
			this.startQuestTimer("waiting", ExternalConfig.Valakas_Wait_Time, npc, null);
		}
		else if (event.equalsIgnoreCase("waiting"))
		{
			GrandBossManager.getInstance().setBossStatus(VALAKAS,FIGHTING);
			L2GrandBossInstance valakas = (L2GrandBossInstance) addSpawn(VALAKAS,212852,-114842,-1632,833,false,0);
			GrandBossManager.getInstance().addBoss(valakas);
			valakas.setRunning();
			valakas.setIsInvul(true);
			valakas.setIsParalyzed(true);
			valakas.setIsImmobilized(true);
			this.startQuestTimer("social", 100, valakas, null);
			this.startQuestTimer("camera", 1500, valakas, null);
			valakas.broadcastPacket(new SpecialCamera(npc.getObjectId(),1800,180,-1,1500,15000));
		}
		else if (event.equalsIgnoreCase("skillcycle"))
		{
			_SkillCycle = 0;
		}
		else if (event.equalsIgnoreCase("loc_check"))
		{
			if (GrandBossManager.getInstance().getBossStatus(VALAKAS) == FIGHTING)
			{
				if (!_Zone.isInsideZone(npc))
					npc.teleToLocation(212852,-114842,-1632);
				if (npc.getX() < 209400 || npc.getX() > 216600 || npc.getY() < -118600 || npc.getY() > -111400 || npc.getZ() < -1650)
					npc.teleToLocation(212852,-114842,-1632);
			}
		}
		else if (event.equalsIgnoreCase("social"))
		{
			npc.broadcastPacket(new SocialAction(npc.getObjectId(),3));
		}
		else if (event.equalsIgnoreCase("camera"))
		{
			this.startQuestTimer("camera_02", 3300, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),1300,180,-5,3000,15000));
		}
		else if (event.equalsIgnoreCase("camera_02"))
		{
			this.startQuestTimer("camera_03", 1300, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),500,180,-8,600,15000));
		}
		else if (event.equalsIgnoreCase("camera_03"))
		{
			this.startQuestTimer("camera_04", 1600, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),1200,180,-5,300,15000));
		}
		else if (event.equalsIgnoreCase("camera_04"))
		{
			this.startQuestTimer("camera_05", 200, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),2800,250,70,0,15000));
		}
		else if (event.equalsIgnoreCase("camera_05"))
		{
			this.startQuestTimer("camera_06", 5700, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),2600,30,60,3400,15000));
		}
		else if (event.equalsIgnoreCase("camera_06"))
		{
			this.startQuestTimer("camera_07", 1400, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),700,150,-65,0,15000));
		}
		else if (event.equalsIgnoreCase("camera_07"))
		{
			this.startQuestTimer("camera_08", 6700, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),1200,150,-55,2900,15000));
		}
		else if (event.equalsIgnoreCase("camera_08"))
		{
			this.startQuestTimer("camera_09", 3700, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),750,170,-10,1700,5700));
		}
		else if (event.equalsIgnoreCase("camera_09"))
		{
			this.startQuestTimer("camera_10", 2000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),840,170,0,1200,2000));
		}
		else if (event.equalsIgnoreCase("camera_10"))
		{
			npc.setIsInvul(false);
			npc.setIsParalyzed(false);
			npc.setIsImmobilized(false);
			_SkillCycle = 0;
			_LastAction = System.currentTimeMillis();
			this.startQuestTimer("loc_check", 15000, npc, null, true);
			this.startQuestTimer("valakas_despawn", 60000, npc, null, true);
		}
		else if (event.equalsIgnoreCase("die_camera"))
		{
			this.startQuestTimer("die_camera_02", 3500, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),210,-5,3000,15000,10000));
		}
		else if (event.equalsIgnoreCase("die_camera_02"))
		{
			this.startQuestTimer("die_camera_03", 4500, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),200,-8,3000,15000,10000));
		}
		else if (event.equalsIgnoreCase("die_camera_03"))
		{
			this.startQuestTimer("die_camera_04", 500, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),190,0,500,15000,10000));
		}
		else if (event.equalsIgnoreCase("die_camera_04"))
		{
			this.startQuestTimer("die_camera_05", 4600, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),120,0,2500,15000,10000));
		}
		else if (event.equalsIgnoreCase("die_camera_05"))
		{
			this.startQuestTimer("die_camera_06", 750, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),20,0,700,15000,10000));
		}
		else if (event.equalsIgnoreCase("die_camera_06"))
		{
			this.startQuestTimer("die_camera_07", 2500, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),10,0,1000,15000,10000));
		}
		else if (event.equalsIgnoreCase("die_camera_07"))
		{
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),10,0,300,15000,250));
		}
		else if (event.equalsIgnoreCase("skill_hp"))
		{
			npc.doCast(SkillTable.getInstance().getInfo(5862,1));
		}
		else if (event.equalsIgnoreCase("skill_mp"))
		{
			npc.doCast(SkillTable.getInstance().getInfo(5863,1));
		}
		else if (event.equalsIgnoreCase("valakas_despawn"))
		{
			temp = (System.currentTimeMillis() - _LastAction);
			if (temp > 900000)
			{
				npc.deleteMe();
				GrandBossManager.getInstance().setBossStatus(VALAKAS,DORMANT);
				_Zone.oustAllPlayers();
				this.cancelQuestTimer("valakas_despawn", npc, null);
			}
		}
		else if (event.equalsIgnoreCase("spawn_cubes"))
		{
			addSpawn(31759,212852,-114842,-1632,0,false,900000);
			int radius = 1500;
			for (int i = 0; i < 19; i++)
			{
				int x = (int) (radius*Math.cos(i*.331)); //.331~2pi/19
				int y = (int) (radius*Math.sin(i*.331));
				addSpawn(31759,212852+x,-114842+y,-1632,0,false,900000);
			}
		}
		else if (event.equalsIgnoreCase("valakas_unlock"))
		{
			GrandBossManager.getInstance().setBossStatus(VALAKAS,DORMANT);
		}
		else if (event.equalsIgnoreCase("remove_players"))
		{
			_Zone.oustAllPlayers();
		}
		return super.onAdvEvent(event, npc, player);
	}

	public String onAttack (L2Npc npc, L2PcInstance attacker, int damage, boolean isPet)
	{
		_LastAction = System.currentTimeMillis();
		if (npc.isInvul() && npc.getNpcId() == VALAKAS)
		{
			return null;
		}
		else if (npc.getNpcId() == VALAKAS && _SkillCycle == 0 && GrandBossManager.getInstance().getBossStatus(VALAKAS) == FIGHTING)
		{
			int x = 40;
			if (npc.getCurrentHp() > npc.getMaxHp() / 4 * 3)
				x = 100;
			if (npc.getCurrentHp() > npc.getMaxHp() / 2)
				x = 80;
			if (npc.getCurrentHp() > npc.getMaxHp() / 4)
				x = 60;
			int y = Rnd.get(x);
			int z = (100 - x) / 10;
			if (Rnd.get(100) < z && npc.isAttackingNow())
			{
				_SkillCycle = 1;
				if (Rnd.get(4) < 1)
				{
					npc.doCast(SkillTable.getInstance().getInfo(5860,1));
					this.startQuestTimer("skill_hp", 10000, npc, null);
				}
				else
				{
					npc.doCast(SkillTable.getInstance().getInfo(5861,1));
					this.startQuestTimer("skill_mp", 10000, npc, null);
				}
				this.startQuestTimer("skillcycle", Rnd.get(15000,20000), npc, null);
			}
			else if (y < 10 && npc.isAttackingNow())
			{
				_SkillCycle = 1;
				npc.doCast(SkillTable.getInstance().getInfo(4690,1));
				this.startQuestTimer("skillcycle", Rnd.get(6000,9000), npc, null);
			}
			else if (y < 15 && npc.isAttackingNow())
			{
				_SkillCycle = 1;
				npc.doCast(SkillTable.getInstance().getInfo(Rnd.get(4688,4689),1));
				this.startQuestTimer("skillcycle", Rnd.get(5000,8000), npc, null);
			}
			else if (y < 25 && npc.isAttackingNow())
			{
				_SkillCycle = 1;
				npc.doCast(SkillTable.getInstance().getInfo(Rnd.get(4683,4685),1));
				this.startQuestTimer("skillcycle", Rnd.get(5000,8000), npc, null);
			}
			else if (y < 35 && npc.isAttackingNow())
			{
				_SkillCycle = 1;
				npc.doCast(SkillTable.getInstance().getInfo(Rnd.get(4681,4682),1));
				this.startQuestTimer("skillcycle", Rnd.get(4000,6000), npc, null);
			}
			else 
			{
				_SkillCycle = 1;
				this.startQuestTimer("skillcycle", 1000, npc, null);
			}
		}
		return super.onAttack(npc, attacker, damage, isPet);
	}

	public String onKill (L2Npc npc, L2PcInstance killer, boolean isPet) 
	{ 
		if (npc.getNpcId() == VALAKAS && GrandBossManager.getInstance().getBossStatus(VALAKAS) == FIGHTING)
		{
			npc.broadcastPacket(new PlaySound(1, "B03_D", 1, npc.getObjectId(), npc.getX(), npc.getY(), npc.getZ()));
			this.cancelQuestTimer("loc_check", npc, null);
			this.cancelQuestTimer("valakas_despawn", npc, null);
			//this.startQuestTimer("die_camera", 0, npc, null);
			this.startQuestTimer("spawn_cubes", 10000, npc, null);
			this.startQuestTimer("remove_players", 900000, npc, null);
			GrandBossManager.getInstance().setBossStatus(VALAKAS,DEAD);
			long respawnTime = (ExternalConfig.Interval_Of_Valakas_Spawn + Rnd.get(ExternalConfig.Random_Of_Valakas_Spawn));
			this.startQuestTimer("valakas_unlock", respawnTime, npc, null);
			// also save the respawn time so that the info is maintained past reboots
			StatsSet info = GrandBossManager.getInstance().getStatsSet(VALAKAS);
			info.set("respawn_time",System.currentTimeMillis() + respawnTime);
			GrandBossManager.getInstance().setStatsSet(VALAKAS,info);
		}
		return super.onKill(npc,killer,isPet);
	}

	public static void main(String[] args)
	{
		// now call the constructor (starts up the ai)
		new Valakas(-1,"valakas","ai");
	}
}