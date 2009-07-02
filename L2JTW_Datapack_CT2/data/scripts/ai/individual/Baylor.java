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

import javolution.util.FastList;
import java.util.List;
import ai.group_template.L2AttackableAIScript;
import net.sf.l2j.gameserver.datatables.SkillTable;
import net.sf.l2j.gameserver.instancemanager.GrandBossManager;
import net.sf.l2j.gameserver.model.actor.L2Npc;
import net.sf.l2j.gameserver.model.actor.instance.L2GrandBossInstance;
import net.sf.l2j.gameserver.model.actor.instance.L2PcInstance;
import net.sf.l2j.gameserver.model.actor.L2Attackable;
import net.sf.l2j.gameserver.network.serverpackets.PlaySound;
import net.sf.l2j.gameserver.network.serverpackets.SocialAction;
import net.sf.l2j.gameserver.network.serverpackets.SpecialCamera;
import net.sf.l2j.gameserver.templates.StatsSet;
import net.sf.l2j.util.Rnd;
import net.sf.l2j.ExternalConfig;

/**
 * Baylor AI
 * Update by rocknow
 */
public class Baylor extends L2AttackableAIScript
{
	private static final int BAYLOR = 29099;
	private static final int GUARD = 29100;
	private static final int ORACLE = 32279;

	//Baylor Status Tracking :
	private static final byte DORMANT = 0;		//Baylor is spawned and no one has entered yet. Entry is unlocked
	private static final byte WAITING = 1;		//Baylor is spawend and someone has entered, triggering a 30 minute window for additional people to enter
												//before he unleashes his attack. Entry is unlocked
	private static final byte FIGHTING = 2; 	//Baylor is engaged in battle, annihilating his foes. Entry is locked
	private static final byte DEAD = 3;			//Baylor has been killed. Entry is locked

	private static long _LastAction = 0;
	private static int _SkillCycle = 0;
	private static int _SpawnMob = 0;
	private static int _SpawnNum = 0;
	private static int _SpawnDie = 29700;
	private static int _InstanceId = 0;
	private static int _Heading = 0;

	List<L2Attackable> Minions = new FastList<L2Attackable>();

	// Boss: Baylor
	public Baylor(int id,String name,String descr)
	{
		super(id,name,descr);
		int[] mob = {BAYLOR, GUARD};
		this.registerMobs(mob);
		addStartNpc(ORACLE);
		addTalkId(ORACLE);
		StatsSet info = GrandBossManager.getInstance().getStatsSet(BAYLOR);
		int status = GrandBossManager.getInstance().getBossStatus(BAYLOR);
		if (status == DEAD)
		{
			long temp = (info.getLong("respawn_time") - System.currentTimeMillis());
			if (temp > 0)
			{
				this.startQuestTimer("baylor_unlock", temp, null, null);
			}
			else
			{
				GrandBossManager.getInstance().setBossStatus(BAYLOR,DORMANT);
			}
		}
		else
		{
			GrandBossManager.getInstance().setBossStatus(BAYLOR,DORMANT);
		}
	}

	public String onAdvEvent (String event, L2Npc npc, L2PcInstance player)
	{
	if (npc != null)
	{
		long temp = 0;
		if (event.equalsIgnoreCase("spawn_minion"))
		{
			for (int i = 0; i < 12; i+=2)
			{
				int radius = 250;
				int x = (int) (radius*Math.cos(i*.52));
				int y = (int) (radius*Math.sin(i*.52));
				L2Npc mob = addSpawn(GUARD,npc.getX()+x,npc.getY()+y,npc.getZ(),32300+_Heading,false,0,false,_InstanceId);
				_Heading = _Heading + 65536/6;
				mob.setIsRaidMinion(true);
				Minions.add((L2Attackable)mob);
			}
		}
		else if (event.equalsIgnoreCase("spawn00"))
		{
			GrandBossManager.getInstance().setBossStatus(BAYLOR,FIGHTING);
			if (_SpawnNum < 12)
			{
				int radius = 300;
				int x = (int) (radius*Math.cos(_SpawnNum*.52));
				int y = (int) (radius*Math.sin(_SpawnNum*.52));
				L2Npc mob = addSpawn(GUARD,153569+x,142075+y,-12732,32300+_Heading,false,0,false,_InstanceId);
				_Heading = _Heading + 65536/12;
				_SpawnNum = _SpawnNum + 1;
				mob.doCast(SkillTable.getInstance().getInfo(5441,1));
				mob.setIsParalyzed(true);
				this.startQuestTimer("die",_SpawnDie, mob, null);
				_SpawnDie = _SpawnDie - 450;
				this.startQuestTimer("spawn00",450, mob, null);
			}
		}
		else if (event.equalsIgnoreCase("skill00"))
		{
			npc.setIsParalyzed(false);
			npc.doCast(SkillTable.getInstance().getInfo(5402,1));
			npc.setIsInvul(false);
			npc.setIsImmobilized(false);
		}
		else if (event.equalsIgnoreCase("skillcycle"))
		{
			_SkillCycle = 0;
		}
		else if (event.equalsIgnoreCase("die"))
		{
			npc.doDie(npc);
		}
		else if (event.equalsIgnoreCase("waiting"))
		{
			_SkillCycle = 0;
			_SpawnMob = 0;
			_SpawnNum = 0;
			_SpawnDie = 29700;
			L2Npc mob = addSpawn(29109,153569,142075,-12732,0,false,0,false,_InstanceId);
			this.startQuestTimer("camera_1",1000, mob, null);
		}
		else if (event.equalsIgnoreCase("waiting_boss"))
		{
			L2GrandBossInstance baylor = (L2GrandBossInstance) addSpawn(BAYLOR,153569,142075,-12732,60060,false,0,false,_InstanceId);
			GrandBossManager.getInstance().addBoss(baylor);
			baylor.setIsInvul(true);
			baylor.setIsParalyzed(true);
			baylor.setIsImmobilized(true);
			baylor.getSpawn().setLocx(153569);
			baylor.getSpawn().setLocy(142075);
			baylor.getSpawn().setLocz(-12732);
			_LastAction = System.currentTimeMillis();
			this.startQuestTimer("action",100, baylor, null);
			this.startQuestTimer("skill00",20000, baylor, null);
			this.startQuestTimer("baylor_despawn",30000, baylor, null, true);
		}
		else if (event.equalsIgnoreCase("action"))
		{
			npc.broadcastPacket(new SocialAction(npc.getObjectId(),1));
		}
		else if (event.equalsIgnoreCase("camera_1"))
		{
			this.startQuestTimer("camera_2",2000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),260,55,7,2000,3000));
		}
		else if (event.equalsIgnoreCase("camera_2"))
		{
			this.startQuestTimer("camera_3",2000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),260,325,6,2000,3000));
		}
		else if (event.equalsIgnoreCase("camera_3"))
		{
			this.startQuestTimer("camera_4",2000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),260,235,5,2000,3000));
		}
		else if (event.equalsIgnoreCase("camera_4"))
		{
			this.startQuestTimer("spawn00",500, npc, null);
			this.startQuestTimer("camera_5",2000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),340,145,4,2000,3000));
		}
		else if (event.equalsIgnoreCase("camera_5"))
		{
			this.startQuestTimer("camera_6",2000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),340,55,4,2000,3000));
		}
		else if (event.equalsIgnoreCase("camera_6"))
		{
			this.startQuestTimer("camera_7",2000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),700,55,30,2000,3000));
		}
		else if (event.equalsIgnoreCase("camera_7"))
		{
			L2Npc mob = addSpawn(29108,153021,142364,-12737,60025,false,0,false,_InstanceId);
			this.startQuestTimer("camera_8",500, mob, null);
			this.startQuestTimer("waiting_boss",1500, mob, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),80,55,30,500,550));
			npc.deleteMe();
		}
		else if (event.equalsIgnoreCase("camera_8"))
		{
			this.startQuestTimer("camera_9",0, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),0,209,0,0,100));
		}
		else if (event.equalsIgnoreCase("camera_9"))
		{
			this.startQuestTimer("camera_10",12500, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),90,209,0,12500,13000));
		}
		else if (event.equalsIgnoreCase("camera_10"))
		{
			this.startQuestTimer("camera_11",1000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),630,209,18,1000,2500));
		}
		else if (event.equalsIgnoreCase("camera_11"))
		{
			this.startQuestTimer("camera_12",6000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),630,209,0,1000,6500));
		}
		else if (event.equalsIgnoreCase("camera_12"))
		{
			this.startQuestTimer("camera_13",1000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),1200,209,3,0,1500));
		}
		else if (event.equalsIgnoreCase("camera_13"))
		{
			this.startQuestTimer("camera_14",2000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),630,209,0,1500,2500));
		}
		else if (event.equalsIgnoreCase("camera_14"))
		{
			this.startQuestTimer("camera_15",5000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),1200,209,7,0,6000));
		}
		else if (event.equalsIgnoreCase("camera_15"))
		{
			npc.deleteMe();
		}
		else if (event.equalsIgnoreCase("baylor_despawn"))
		{
			temp = (System.currentTimeMillis() - _LastAction);
			if (temp > 300000)
			{
				npc.deleteMe();
				GrandBossManager.getInstance().setBossStatus(BAYLOR,DORMANT);
				this.cancelQuestTimer("baylor_despawn", npc, null);
				this.startQuestTimer("spawn_cubes", 1000, npc, null);
				this.startQuestTimer("despawn_minions",1000, npc, null);
			}
		}
		else if (event.equalsIgnoreCase("despawn_minions"))
		{
			for (int i = 0; i < Minions.size(); i++)
			{
				L2Attackable mob = Minions.get(i);
				if (mob != null)
				mob.decayMe();
			}
			Minions.clear();
		}
		else if (event.equalsIgnoreCase("spawn_cubes"))
		{
			addSpawn(32280,153569,142075,-12732,0,false,300000,false,_InstanceId);
		}
		else if (event.equalsIgnoreCase("spawn_chest"))
		{
			addSpawn(29116,153706,142212,-12741,7579,false,300000,false,_InstanceId);
			addSpawn(29116,154192,142697,-12741,7894,false,300000,false,_InstanceId);
			addSpawn(29116,153763,142075,-12741,64792,false,300000,false,_InstanceId);
			addSpawn(29116,153701,141942,-12741,57739,false,300000,false,_InstanceId);
			addSpawn(29116,153573,141894,-12741,49471,false,300000,false,_InstanceId);
			addSpawn(29116,153445,141945,-12741,41113,false,300000,false,_InstanceId);
			addSpawn(29116,153381,142076,-12741,32767,false,300000,false,_InstanceId);
			addSpawn(29116,153441,142211,-12741,25730,false,300000,false,_InstanceId);
			addSpawn(29116,153573,142260,-12741,16185,false,300000,false,_InstanceId);
			addSpawn(29116,153571,142860,-12741,16716,false,300000,false,_InstanceId);
			addSpawn(29116,152783,142077,-12741,32176,false,300000,false,_InstanceId);
			addSpawn(29116,153571,141274,-12741,49072,false,300000,false,_InstanceId);
			addSpawn(29116,154365,142073,-12741,64149,false,300000,false,_InstanceId);
			addSpawn(29116,152924,142677,-12741,25072,false,300000,false,_InstanceId);
			addSpawn(29116,152907,141428,-12741,39590,false,300000,false,_InstanceId);
			addSpawn(29116,154243,141411,-12741,55500,false,300000,false,_InstanceId);
		}
	}
	else
	{
		if (event.equalsIgnoreCase("baylor_unlock"))
		{
			GrandBossManager.getInstance().setBossStatus(BAYLOR,DORMANT);
		}
	}
	return super.onAdvEvent(event, npc, player);
	}

	public String onTalk(L2Npc npc,L2PcInstance player)
	{
		String htmltext = "";
		if (GrandBossManager.getInstance().getBossStatus(BAYLOR) == DORMANT)
		{
			_InstanceId = player.getInstanceId();
			if (!player.isInParty())
			{
				if (player.getQuestState("baylor").getQuestItemsCount(9695) > 0 && player.getQuestState("baylor").getQuestItemsCount(9696) > 0 && player.getQuestState("baylor").getQuestItemsCount(9697) > 0)
				{
					player.getQuestState("baylor").takeItems(Rnd.get(9695, 9697),1);
					player.teleToLocation(153569 + Rnd.get(-150, 150),142075 + Rnd.get(-150, 150),-12732);
					htmltext = "";
					this.startQuestTimer("waiting",30000, npc, null);
					_LastAction = System.currentTimeMillis();
					GrandBossManager.getInstance().setBossStatus(BAYLOR,WAITING);
				}
				else
				{
					htmltext = "<html><body>神諭引導者：<br><font color=LEVEL>湛藍水晶、赤紅水晶、透明水晶</font>是挑戰巴爾勒必備的物品。</body></html>";
				}
			}
			else if (!player.getParty().isLeader(player)) 
			{
				htmltext = "<html><body>神諭引導者：<br><font color=LEVEL>只限隊長來試圖進入。</font></body></html>";
			}
			else
			{
				for (L2PcInstance mem : player.getParty().getPartyMembers())
				{
					if (mem.getInventory().getItemByItemId(9695) == null || mem.getInventory().getItemByItemId(9696) == null || mem.getInventory().getItemByItemId(9697) == null)
					{
						htmltext = "<html><body>神諭引導者：<br><font color=LEVEL>隊員「"+mem.getName()+"」缺少挑戰巴爾勒必備的：<br1>湛藍水晶、赤紅水晶、透明水晶。</font></body></html>";
						mem.sendMessage("神諭引導者: 湛藍水晶、赤紅水晶、透明水晶是挑戰巴爾勒必備的物品。");
						return htmltext;
					}
				}
				for (L2PcInstance mem : player.getParty().getPartyMembers())
				{
					mem.destroyItemByItemId("Quest", Rnd.get(9695, 9697), 1, mem, true);
					mem.teleToLocation(153569 + Rnd.get(-150, 150),142075 + Rnd.get(-150, 150),-12732);
					htmltext = "";
					this.startQuestTimer("waiting",30000, npc, null);
					_LastAction = System.currentTimeMillis();
					GrandBossManager.getInstance().setBossStatus(BAYLOR,WAITING);
				}
			}
		}
		else if (GrandBossManager.getInstance().getBossStatus(BAYLOR) == WAITING || GrandBossManager.getInstance().getBossStatus(BAYLOR) == FIGHTING)
			htmltext = "<html><body>神諭引導者：<br><font color=\"LEVEL\">已經有人進入巴爾勒巢穴。<br1>在他們與巴爾勒的對戰結束之前不能讓你們進入。</font></body></html>";
		else
			htmltext = "<html><body>神諭引導者：<br><font color=\"LEVEL\">巴爾勒目前沉睡中.....請回吧。</font></body></html>";
	return htmltext;
	}

	public String onAttack (L2Npc npc, L2PcInstance attacker, int damage, boolean isPet)
	{
		_LastAction = System.currentTimeMillis();
		if (npc.isInvul() && npc.getNpcId() == BAYLOR)
		{
			return null;
		}
		if (npc.getNpcId() == BAYLOR && _SkillCycle == 0 && GrandBossManager.getInstance().getBossStatus(BAYLOR) == FIGHTING)
		{
			if (Rnd.get(100) < 70)
			{
				_SkillCycle = 1;
				npc.doCast(SkillTable.getInstance().getInfo(Rnd.get(5227,5229),1));
				npc.setCurrentMp(npc.getMaxMp());
				this.startQuestTimer("skillcycle",7000, npc, null);
			}
			else if (npc.getCurrentHp() < npc.getMaxHp() / 2 && Rnd.get(100) < 30)
			{
				_SkillCycle = 1;
				npc.doCast(SkillTable.getInstance().getInfo(5224,1));
				this.startQuestTimer("skillcycle",7000, npc, null);
			}
			else if (npc.getCurrentHp() < npc.getMaxHp() / 4 && Rnd.get(100) < 10)
			{
				_SkillCycle = 1;
				npc.doCast(SkillTable.getInstance().getInfo(5225,1));
				this.startQuestTimer("skillcycle",7000, npc, null);
			}
			else
			{
				_SkillCycle = 1;
				this.startQuestTimer("skillcycle",1000, npc, null);
			}
		}
		if (npc.getNpcId() == BAYLOR && _SpawnMob == 0 && npc.getCurrentHp() < npc.getMaxHp() / 2 && GrandBossManager.getInstance().getBossStatus(BAYLOR) == FIGHTING)
		{
			this.startQuestTimer("spawn_minion",1000, npc, null);
			_SpawnMob = 1;
		}
		else if (npc.getNpcId() == BAYLOR && _SpawnMob == 1 && npc.getCurrentHp() < npc.getMaxHp() / 4 && GrandBossManager.getInstance().getBossStatus(BAYLOR) == FIGHTING)
		{
			this.startQuestTimer("spawn_minion",1000, npc, null);
			_SpawnMob = 2;
		}
		return super.onAttack(npc, attacker, damage, isPet);
	}

	public String onKill (L2Npc npc, L2PcInstance killer, boolean isPet)
	{ 
		if (npc.getNpcId() == BAYLOR && GrandBossManager.getInstance().getBossStatus(BAYLOR) == FIGHTING)
		{
			npc.broadcastPacket(new PlaySound(1, "BS01_D", 1, npc.getObjectId(), npc.getX(), npc.getY(), npc.getZ()));
			this.cancelQuestTimer("skillcycle", npc, null);
			this.cancelQuestTimer("baylor_despawn", npc, null);
			this.startQuestTimer("spawn_cubes", 5000, npc, null);
			this.startQuestTimer("spawn_chest",5000, npc, null);
			this.startQuestTimer("despawn_minions",20000, npc, null);
			GrandBossManager.getInstance().setBossStatus(BAYLOR,DEAD);
			long respawnTime = (ExternalConfig.Interval_Of_Baylor_Spawn + Rnd.get(ExternalConfig.Random_Of_Baylor_Spawn));
			this.startQuestTimer("baylor_unlock", respawnTime, null, null);
			// also save the respawn time so that the info is maintained past reboots
			StatsSet info = GrandBossManager.getInstance().getStatsSet(BAYLOR);
			info.set("respawn_time",(System.currentTimeMillis() + respawnTime));
			GrandBossManager.getInstance().setStatsSet(BAYLOR,info);
		}
	return super.onKill(npc,killer,isPet);
	}

	public static void main(String[] args)
	{
		// now call the constructor (starts up the ai)
		new Baylor(-1,"baylor","ai");
	}
}