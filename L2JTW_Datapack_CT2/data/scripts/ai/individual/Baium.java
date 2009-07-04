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
import net.sf.l2j.gameserver.model.zone.type.L2BossZone;
import net.sf.l2j.gameserver.model.actor.L2Attackable;
import net.sf.l2j.gameserver.network.serverpackets.Earthquake;
import net.sf.l2j.gameserver.network.serverpackets.PlaySound;
import net.sf.l2j.gameserver.network.serverpackets.SocialAction;
import net.sf.l2j.gameserver.templates.StatsSet;
import net.sf.l2j.util.Rnd;
import net.sf.l2j.gameserver.network.serverpackets.NpcSay;
import net.sf.l2j.ExternalConfig;

/**
 * Baium AI
 * @author Fulminus version 0.1
 */
public class Baium extends L2AttackableAIScript
{
	private static final int[][] Pos = 
		{
		{ 113004, 16209, 10076, 60242 },
		{ 114053, 16642, 10076, 4411  }, 
		{ 114563, 17184, 10076, 49241 },
		{ 116356, 16402, 10076, 31109 },
		{ 115015, 16393, 10076, 32760 },
		{ 115481, 15335, 10076, 16241 },
		{ 114680, 15407, 10051, 32485 },
		{ 114886, 14437, 10076, 16868 },
		{ 115391, 17593, 10076, 55346 },
		{ 115245, 17558, 10076, 35536 } 
		};

	private static final int STONE_BAIUM = 29025;
	private static final int ANGELIC_VORTEX = 31862;
	private static final int LIVE_BAIUM = 29020;
	private static final int Angel = 29021;

	//Baium status tracking
	private static final byte ASLEEP = 0;	// baium is in the stone version, waiting to be woken up.  Entry is unlocked
	private static final byte AWAKE = 1;	// baium is awake and fighting.  Entry is locked.
	private static final byte DEAD = 2;		// baium has been killed and has not yet spawned.  Entry is locked

	private static long _LastAttackVsBaiumTime = 0;
	private static L2BossZone _Zone;

	private static int _SkillCycle = 0;

	List<L2Attackable> Minions = new FastList<L2Attackable>();

	// Boss: Baium
	public Baium (int questId, String name, String descr)
	{
		super(questId, name, descr);
		
		int[] mob = {LIVE_BAIUM, Angel};
		this.registerMobs(mob);
		
		addStartNpc(STONE_BAIUM);
		addStartNpc(ANGELIC_VORTEX);
		addTalkId(STONE_BAIUM);
		addTalkId(ANGELIC_VORTEX);
		_Zone = GrandBossManager.getInstance().getZone(113100,14500,10077);
		StatsSet info = GrandBossManager.getInstance().getStatsSet(LIVE_BAIUM);
		int status = GrandBossManager.getInstance().getBossStatus(LIVE_BAIUM);
		if (status == DEAD)
		{
			long temp = (info.getLong("respawn_time") - System.currentTimeMillis());
			if (temp > 0)
			{
				this.startQuestTimer("baium_unlock", temp, null, null);
			}
			else
			{
				addSpawn(STONE_BAIUM,116067,17484,10110,41740,false,0);
				GrandBossManager.getInstance().setBossStatus(LIVE_BAIUM,ASLEEP);
			}
		}
		else
		{
			addSpawn(STONE_BAIUM,116067,17484,10110,41740,false,0);
			GrandBossManager.getInstance().setBossStatus(LIVE_BAIUM,ASLEEP);
		}
	}

	public String onAdvEvent (String event, L2Npc npc, L2PcInstance player)
	{
		if (event.equalsIgnoreCase("baium_wakeup_first"))
		{
			npc.broadcastPacket(new SocialAction(npc.getObjectId(),3));
			this.startQuestTimer("baium_wakeup", 9000, npc, null);
		}
		else if (event.equalsIgnoreCase("baium_wakeup"))
		{
			npc.broadcastPacket(new NpcSay(npc.getObjectId(),1,npc.getNpcId(),"竟敢妨礙我的睡眠！去死吧！"));
			npc.broadcastPacket(new SocialAction(npc.getObjectId(),1));
			npc.broadcastPacket(new Earthquake(npc.getX(), npc.getY(), npc.getZ(),40,5));
			this.startQuestTimer("baium_despawn", 60000, npc, null, true);
			this.startQuestTimer("action", 10000, npc, null);
			this.startQuestTimer("spawn_angel", 20000, npc, null);
		}
		else if (event.equalsIgnoreCase("skillcycle"))
		{
			_SkillCycle = 0;
		}
		else if (event.equalsIgnoreCase("loc_check"))
		{
			if (GrandBossManager.getInstance().getBossStatus(LIVE_BAIUM) == AWAKE)
			{
				if (!_Zone.isInsideZone(npc))
					npc.teleToLocation(116067,17484,10110);
				if (npc.getZ() < 10070)
					npc.teleToLocation(116067,17484,10110);
			}
		}
		else if (event.equalsIgnoreCase("social"))
		{
			npc.broadcastPacket(new SocialAction(npc.getObjectId(),2));
		}
		else if (event.equalsIgnoreCase("action"))
		{
			npc.setIsInvul(false);
			npc.setIsParalyzed(false);
			npc.setIsImmobilized(false);
			this.startQuestTimer("loc_check", 15000, npc, null, true);
		}
		else if (event.equalsIgnoreCase("baium_despawn") )
		{
			if (_Zone == null)
				_Zone = GrandBossManager.getInstance().getZone(113100,14500,10077);
			if (_LastAttackVsBaiumTime + 900000 < System.currentTimeMillis())
			{
				npc.deleteMe();
				addSpawn(STONE_BAIUM,116067,17484,10110,41740,false,0);
				GrandBossManager.getInstance().setBossStatus(LIVE_BAIUM,ASLEEP);
				_Zone.oustAllPlayers();
				this.cancelQuestTimer("baium_despawn", npc, null);
				this.startQuestTimer("minions_despawn", 20000, npc, null);
			}
			else if (!_Zone.isInsideZone(npc))
				npc.teleToLocation(116067,17484,10110);
		}
		else if (event.equalsIgnoreCase("minions_despawn"))
		{
			for (int i = 0; i < Minions.size(); i++)
			{
				L2Attackable mob = Minions.get(i);
				if (mob != null)
				mob.decayMe();
			}
			Minions.clear();
		}
		else if (event.equalsIgnoreCase("spawn_minion"))
		{
			int i = Rnd.get(9);
			L2Npc mob = addSpawn(Angel,Pos[i][0],Pos[i][1],Pos[i][2],Pos[i][3],false,0);
			mob.setIsRaidMinion(true);
			Minions.add((L2Attackable)mob);
		}
		else if (event.equalsIgnoreCase("spawn_cubes"))
		{
			addSpawn(29055,115203,16620,10078,0,false,900000);
		}
		else if (event.equalsIgnoreCase("spawn_angel"))
		{
			int j = Rnd.get(1);
			for (int i = j; i < 10; i = i + 2)
			{
			L2Npc mob = addSpawn(Angel,Pos[i][0],Pos[i][1],Pos[i][2],Pos[i][3],false,0);
			mob.setIsRaidMinion(true);
			Minions.add((L2Attackable)mob);
			}
		}
		else if (event.equalsIgnoreCase("baium_unlock"))
		{
			GrandBossManager.getInstance().setBossStatus(LIVE_BAIUM,ASLEEP);
			addSpawn(STONE_BAIUM,116067,17484,10110,41740,false,0);
		}
		else if (event.equalsIgnoreCase("remove_players"))
		{
			_Zone.oustAllPlayers();
		}
		return super.onAdvEvent(event, npc, player);
	}

	public String onTalk(L2Npc npc,L2PcInstance player)
	{
		String htmltext = "";
		if (_Zone == null)
			_Zone = GrandBossManager.getInstance().getZone(113100,14500,10077);
		if (_Zone == null)
			return "<html><body>天使界點：<br>此區已被管理者關閉。</body></html>";
		if (npc.getNpcId() == STONE_BAIUM && GrandBossManager.getInstance().getBossStatus(LIVE_BAIUM) == ASLEEP)
		{
			if (_Zone.isPlayerAllowed(player))
			{
				GrandBossManager.getInstance().setBossStatus(LIVE_BAIUM,AWAKE);
				npc.deleteMe();
				L2GrandBossInstance baium = (L2GrandBossInstance) addSpawn(LIVE_BAIUM,npc);
				GrandBossManager.getInstance().addBoss(baium);
				baium.setRunning();
				baium.setIsInvul(true);
				baium.setIsParalyzed(true);
				baium.setIsImmobilized(true);
				_SkillCycle = 0;
				_LastAttackVsBaiumTime = System.currentTimeMillis();
				this.startQuestTimer("social", 100, baium, null);
				this.startQuestTimer("baium_wakeup_first", 12000, baium, null);
			}
			else
				htmltext = "無法喚醒巴溫。";
		}
		else if (npc.getNpcId() == ANGELIC_VORTEX)
		{
			if (GrandBossManager.getInstance().getBossStatus(LIVE_BAIUM) == ASLEEP)
			{
				if (player.isFlying())
				{
					htmltext = "<html><body>天使界點：<br>騎乘飛龍的狀態下無法讓你進入。</body></html>";
				}
				else if (player.getQuestState("baium").getQuestItemsCount(4295) > 0)
				{
					player.getQuestState("baium").takeItems(4295,1);
					_Zone.allowPlayerEntry(player,30);
					player.teleToLocation(113100,14500,10077);
					htmltext = "";
				}
				else
					htmltext = "<html><body>天使界點：<br>天使界點散發朦朧的光。可是那光線一下子就消失了。天使界點再也沒有任何反應。若想移動到天使界點所顯示的地方，好像需要某種特別的東西。</body></html>";
			}
			else if (GrandBossManager.getInstance().getBossStatus(LIVE_BAIUM) == AWAKE)
				htmltext = "<html><body>天使界點：<br>天使界點散發朦朧的光，在其中浮現某種影像。寬廣的空間…在那裡面看不到平時可看到的巨大人形石像。<br>而且無法看到石像形狀的此刻，好像無法移動至那地方。</body></html>";
			else 
				htmltext = "<html><body>天使界點：<br><font color=\"LEVEL\">巴溫目前沉睡中.....請回吧。</font></body></html>";
		}
		return htmltext;
	}

	public String onAttack (L2Npc npc, L2PcInstance attacker, int damage, boolean isPet)
	{
		_LastAttackVsBaiumTime = System.currentTimeMillis();
		if (npc.isInvul() && npc.getNpcId() == LIVE_BAIUM)
		{
			return null;
		}
		if (npc.getNpcId() == LIVE_BAIUM && _SkillCycle == 0 && GrandBossManager.getInstance().getBossStatus(LIVE_BAIUM) == AWAKE)
		{
			int x = 40;
			if (npc.getCurrentHp() > npc.getMaxHp() / 4 * 3)
				x = 100;
			if (npc.getCurrentHp() > npc.getMaxHp() / 2)
				x = 80;
			if (npc.getCurrentHp() > npc.getMaxHp() / 4)
				x = 60;
			int y = Rnd.get(x);
			if (y < 20 && npc.isAttackingNow())
			{
				_SkillCycle = 1;
				npc.doCast(SkillTable.getInstance().getInfo(Rnd.get(4128,4131),1));
				this.startQuestTimer("skillcycle", Rnd.get(5000,8000), npc, null);
			}
			else if (Rnd.get(100) < 40 && npc.isAttackingNow())
			{
				_SkillCycle = 1;
				npc.doCast(SkillTable.getInstance().getInfo(4127,1));
				this.startQuestTimer("skillcycle", Rnd.get(3000,5000), npc, null);
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
		if (npc.getNpcId() == LIVE_BAIUM && GrandBossManager.getInstance().getBossStatus(LIVE_BAIUM) == AWAKE)
		{
			npc.broadcastPacket(new PlaySound(1, "BS01_D", 1, npc.getObjectId(), npc.getX(), npc.getY(), npc.getZ()));
			this.cancelQuestTimer("loc_check", npc, null);
			this.cancelQuestTimer("baium_despawn", npc, null);
			this.startQuestTimer("spawn_cubes", 12000, npc, null);
			this.startQuestTimer("minions_despawn", 20000, npc, null);
			this.startQuestTimer("remove_players", 900000, npc, null);
			GrandBossManager.getInstance().setBossStatus(LIVE_BAIUM,DEAD);
			long respawnTime = (ExternalConfig.Interval_Of_Baium_Spawn + Rnd.get(ExternalConfig.Random_Of_Baium_Spawn));
			this.startQuestTimer("baium_unlock", respawnTime, npc, null);
			// also save the respawn time so that the info is maintained past reboots
			StatsSet info = GrandBossManager.getInstance().getStatsSet(LIVE_BAIUM);
			info.set("respawn_time",(System.currentTimeMillis()) + respawnTime);
			GrandBossManager.getInstance().setStatsSet(LIVE_BAIUM,info);
		}	
		else if (Minions != null && Minions.contains(npc) && GrandBossManager.getInstance().getBossStatus(LIVE_BAIUM) == AWAKE)
		{
			Minions.remove(npc);
			this.startQuestTimer("spawn_minion", 60000, npc, null);
		}
		return super.onKill(npc,killer,isPet);
	}

	public static void main(String[] args)
	{
		// Quest class and state definition
		new Baium(-1, "baium", "ai");
	}
}