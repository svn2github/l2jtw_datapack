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
import ai.group_template.L2AttackableAIScript;

import net.sf.l2j.gameserver.ThreadPoolManager;
import net.sf.l2j.gameserver.instancemanager.GrandBossManager;
import net.sf.l2j.gameserver.model.actor.L2Npc;
import net.sf.l2j.gameserver.model.actor.instance.L2GrandBossInstance;
import net.sf.l2j.gameserver.model.actor.instance.L2PcInstance;
import net.sf.l2j.gameserver.model.zone.type.L2BossZone;
import net.sf.l2j.gameserver.network.serverpackets.Earthquake;
import net.sf.l2j.gameserver.network.serverpackets.PlaySound;
import net.sf.l2j.gameserver.network.serverpackets.SocialAction;
import net.sf.l2j.gameserver.network.serverpackets.NpcSay;
import net.sf.l2j.gameserver.templates.StatsSet;
import net.sf.l2j.util.Rnd;
import net.sf.l2j.gameserver.model.actor.L2Attackable;
import java.util.List;
import net.sf.l2j.ExternalConfig;

/**
 * Baium AI
 * 
 * Note1: if the server gets rebooted while players are still fighting Baium, there is no lock, but
 *   players also lose their ability to wake baium up.  However, should another person
 *   enter the room and wake him up, the players who had stayed inside may join the raid.
 *   This can be helpful for players who became victims of a reboot (they only need 1 new player to
 *   enter and wake up baium) and is not too exploitable since any player wishing to exploit it
 *   would have to suffer 5 days of being parked in an empty room.
 * Note2: Neither version of Baium should be a permanent spawn.  This script is fully capable of
 *   spawning the statue-version when the lock expires and switching it to the mob version promptly.
 *
 * Additional notes ( source http://aleenaresron.blogspot.com/2006_08_01_archive.html ):
 *   * Baium only first respawns five days after his last death. And from those five days he will
 *       respawn within 1-8 hours of his last death. So, you have to know his last time of death.
 *   * If by some freak chance you are the only one in Baium's chamber and NO ONE comes in
 *       [ha, ha] you or someone else will have to wake Baium. There is a good chance that Baium
 *       will automatically kill whoever wakes him. There are some people that have been able to
 *       wake him and not die, however if you've already gone through the trouble of getting the
 *       bloody fabric and camped him out and researched his spawn time, are you willing to take that 
 *       chance that you'll wake him and not be able to finish your quest? Doubtful.
 *       [ this powerful attack vs the player who wakes him up is NOT yet implemented here]
 *   * once someone starts attacking Baium no one else can port into the chamber where he is.
 *       Unlike with the other raid bosses, you can just show up at any time as long as you are there
 *       when they die. Not true with Baium. Once he gets attacked, the port to Baium closes. byebye,
 *       see you in 5 days.  If nobody attacks baium for 30 minutes, he auto-despawns and unlocks the 
 *       vortex
 * 
 * @author Fulminus version 0.1
 */
public class Baium extends L2AttackableAIScript
{
    private static final int[][] Pos = 
        {
           { 113004, 16209, 10076, 60242 },
           { 114053, 16642, 10076, 4411 }, 
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
	private static final byte ASLEEP = 0;  // baium is in the stone version, waiting to be woken up.  Entry is unlocked
	private static final byte AWAKE = 1;   // baium is awake and fighting.  Entry is locked.
	private static final byte DEAD = 2;    // baium has been killed and has not yet spawned.  Entry is locked
	private static L2BossZone _Zone;
	
	List<L2Attackable> Minions = new FastList<L2Attackable>();
		
	public Baium (int questId, String name, String descr)
	{
		super(questId, name, descr);
		
        int[] mob = {LIVE_BAIUM, Angel};
        this.registerMobs(mob);
        
        // Quest NPC starter initialization
        addStartNpc(STONE_BAIUM);
        addStartNpc(ANGELIC_VORTEX);
        addTalkId(STONE_BAIUM);
        addTalkId(ANGELIC_VORTEX);
        _Zone = GrandBossManager.getInstance().getZone(113100,14500,10077);
        StatsSet info = GrandBossManager.getInstance().getStatsSet(LIVE_BAIUM);
        int status = GrandBossManager.getInstance().getBossStatus(LIVE_BAIUM);
        if (status == DEAD)
        {
            // load the unlock date and time for baium from DB
            long temp = (info.getLong("respawn_time") - System.currentTimeMillis());
            if (temp > 0)
            {
                // the unlock time has not yet expired.  Mark Baium as currently locked (dead).  Setup a timer
                // to fire at the correct time (calculate the time between now and the unlock time,
                // setup a timer to fire after that many msec)
                startQuestTimer("baium_unlock", temp, null, null);
            }
            else
            {
                // the time has already expired while the server was offline.  Delete the saved time and
                // immediately spawn the stone-baium.  Also the state need not be changed from ASLEEP
                addSpawn(STONE_BAIUM,116067,17484,10110,41740,false,0);
                GrandBossManager.getInstance().setBossStatus(LIVE_BAIUM,ASLEEP);
            }
        }
        else if (status == AWAKE)
        {
            int loc_x = info.getInteger("loc_x");
            int loc_y = info.getInteger("loc_y");
            int loc_z = info.getInteger("loc_z");
            int heading = info.getInteger("heading");
            final int hp = info.getInteger("currentHP");
            final int mp = info.getInteger("currentMP");
            L2GrandBossInstance baium = (L2GrandBossInstance) addSpawn(LIVE_BAIUM,loc_x,loc_y,loc_z,heading,false,0);
            GrandBossManager.getInstance().addBoss(baium);
            final L2Npc _baium = baium;
            ThreadPoolManager.getInstance().scheduleGeneral(new Runnable() {
				public void run()
				{
					try
		            {
						_baium.setCurrentHpMp(hp,mp);
						_baium.setIsInvul(true);
						_baium.setIsImmobilized(true);
		                _baium.setRunning();
						_baium.broadcastPacket(new SocialAction(_baium.getObjectId(),2));
			            startQuestTimer("baium_wakeup_first",12000, _baium, null);
		            }
		            catch (Exception e)
		            {
		            	e.printStackTrace();
		            }
				}
			},100L);
        }
        else
            addSpawn(STONE_BAIUM,116067,17484,10110,41740,false,0);
	}

	public String onAdvEvent (String event, L2Npc npc, L2PcInstance player)
	{
        if (event.equalsIgnoreCase("baium_unlock"))
        {
            GrandBossManager.getInstance().setBossStatus(LIVE_BAIUM,ASLEEP);
            addSpawn(STONE_BAIUM,116067,17484,10110,41740,false,0);
        }
        else if (event.equalsIgnoreCase("baium_wakeup_first") && npc != null)
        {
            if (npc.getNpcId() == LIVE_BAIUM)
            {
                npc.broadcastPacket(new SocialAction(npc.getObjectId(),3));
                startQuestTimer("baium_wakeup", 9000, npc, null);
            }
        }
        else if (event.equalsIgnoreCase("baium_wakeup") && npc != null)
        {
            if (npc.getNpcId() == LIVE_BAIUM)
            {
                npc.broadcastPacket(new NpcSay(npc.getObjectId(),1,npc.getNpcId(),"竟敢妨礙我的睡眠！去死吧！"));
                npc.broadcastPacket(new SocialAction(npc.getObjectId(),1));
                npc.broadcastPacket(new Earthquake(npc.getX(), npc.getY(), npc.getZ(),40,5));
                // start monitoring baium's inactivity
                startQuestTimer("baium_despawn", 60000, npc, null, true);
                startQuestTimer("skill_range", 500, npc, null, true);
                startQuestTimer("angel",30000, npc, null);
                final L2Npc baium = npc;
                ThreadPoolManager.getInstance().scheduleGeneral(new Runnable() {
    				public void run()
    				{
    					try
    		            {
    						baium.setIsInvul(false);
    						baium.setIsImmobilized(false);
    		            }
    		            catch (Exception e)
    		            {
    		            	e.printStackTrace();
    		            }
    				}
    			},11100L);
                // TODO: the person who woke baium up should be knocked across the room, onto a wall, and
                // lose massive amounts of HP.
            }
        // despawn the live baium after 30 minutes of inactivity
        // also check if the players are cheating, having pulled Baium outside his zone...
        }
        else if (event.equalsIgnoreCase("baium_despawn") && npc != null)
        {
            if (npc.getNpcId() == LIVE_BAIUM)
            {
                // just in case the zone reference has been lost (somehow...), restore the reference
                if (_Zone == null)
                    _Zone = GrandBossManager.getInstance().getZone(113100,14500,10077);
                if (!_Zone.isInsideZone(npc))
                    npc.teleToLocation(116067,17484,10110);
            }
        }
		else if (event.equalsIgnoreCase("spawn_minion"))
        {
		    int i = Rnd.get(9);
            L2Npc mob = addSpawn(Angel,Pos[i][0],Pos[i][1],Pos[i][2],Pos[i][3],false,0);
            mob.setIsRaidMinion(true);
            Minions.add((L2Attackable)mob);
        }
        else if (event.equalsIgnoreCase("angel"))
        {
			int j = Rnd.get(1);
			for (int i = j; i < 10; i = i + 2)
            {
            L2Npc mob = addSpawn(Angel,Pos[i][0],Pos[i][1],Pos[i][2],Pos[i][3],false,0);
            mob.setIsRaidMinion(true);
            Minions.add((L2Attackable)mob);
			}
        }
        else if (event.equalsIgnoreCase("despawn_minions"))
        {
            for (int i=0;i<Minions.size();i++)
            {
                L2Attackable mob = Minions.get(i);
                if (mob != null)
                mob.decayMe();
            }
            Minions.clear();
        }
        return super.onAdvEvent(event, npc, player);
	}
    public String onTalk(L2Npc npc,L2PcInstance player)
    {
        int npcId = npc.getNpcId();
        String htmltext = "";
        if (_Zone == null)
            _Zone = GrandBossManager.getInstance().getZone(113100,14500,10077);
        if (_Zone == null)
        	return "<html><body>天使界點：<br>此區已被管理者關閉。</body></html>";
        if (npcId == STONE_BAIUM && GrandBossManager.getInstance().getBossStatus(LIVE_BAIUM) == ASLEEP)
        {
            if (_Zone.isPlayerAllowed(player))
            {
                // once Baium is awaken, no more people may enter until he dies, the server reboots, or 
                // 30 minutes pass with no attacks made against Baium.
                GrandBossManager.getInstance().setBossStatus(LIVE_BAIUM,AWAKE);
                npc.deleteMe();
                L2GrandBossInstance baium = (L2GrandBossInstance) addSpawn(LIVE_BAIUM,npc);
                GrandBossManager.getInstance().addBoss(baium);
                final L2Npc _baium = baium;
                ThreadPoolManager.getInstance().scheduleGeneral(new Runnable() {
    				public void run()
    				{
    					try
    		            {
    						_baium.setIsInvul(true);
    		                _baium.setRunning();
    						_baium.broadcastPacket(new SocialAction(_baium.getObjectId(),2));
    						startQuestTimer("baium_wakeup_first",12000, _baium, null);
    		            }
    		            catch (Throwable e)
    		            {
    		            }
    				}
    			},100L);
            }
            else
                htmltext = "無法喚醒巴溫。";
        }
        else if (npcId == ANGELIC_VORTEX)
        {
            if (GrandBossManager.getInstance().getBossStatus(LIVE_BAIUM) == ASLEEP)
            {
                if (player.isFlying())
                {
                    //print "Player "+player.getName()+" attempted to enter Baium's lair while flying!";
                    htmltext = "<html><body>天使界點：<br>騎乘飛龍的狀態下無法讓你進入。</body></html>";
                }
                else if (player.getQuestState("baium").getQuestItemsCount(4295) > 0) // bloody fabric
                {
                    player.getQuestState("baium").takeItems(4295,1);
                    // allow entry for the player for the next 30 secs (more than enough time for the TP to happen)
                    // Note: this just means 30secs to get in, no limits on how long it takes before we get out.
                    _Zone.allowPlayerEntry(player,30);
                    player.teleToLocation(113100,14500,10077);
                }
                else
                    htmltext = "<html><body>天使界點：<br>天使界點散發朦朧的光。可是那光線一下子就消失了。天使界點再也沒有任何反應。若想移動到天使界點所顯示的地方，好像需要某種特別的東西。</body></html>";
            }
            else
                htmltext = "<html><body>天使界點：<br>天使界點散發朦朧的光，在其中浮現某種影像。寬廣的空間…在那裡面看不到平時可看到的巨大人形石像。<br>而且無法看到石像形狀的此刻，好像無法移動至那地方。</body></html>";
        }
        return htmltext;
    }
    

    
    public String onKill (L2Npc npc, L2PcInstance killer, boolean isPet) 
    { 
	    if (GrandBossManager.getInstance().getBossStatus(LIVE_BAIUM) == AWAKE && npc.getNpcId() == LIVE_BAIUM)
        {
        cancelQuestTimer("baium_despawn", npc, null);
        npc.broadcastPacket(new PlaySound(1, "BS01_D", 1, npc.getObjectId(), npc.getX(), npc.getY(), npc.getZ()));
        // spawn the "Teleportation Cubic" for 15 minutes (to allow players to exit the lair)
        addSpawn(29055,115203,16620,10078,0,false,900000); ////should we teleport everyone out if the cubic despawns??
        // "lock" baium for 5 days and 1 to 8 hours [i.e. 432,000,000 +  1*3,600,000 + random-less-than(8*3,600,000) millisecs]
        long respawnTime = (ExternalConfig.Interval_Of_Baium_Spawn + Rnd.get(ExternalConfig.Random_Of_Baium_Spawn));
        GrandBossManager.getInstance().setBossStatus(LIVE_BAIUM,DEAD);
        startQuestTimer("baium_unlock", respawnTime, null, null);
        // also save the respawn time so that the info is maintained past reboots
        StatsSet info = GrandBossManager.getInstance().getStatsSet(LIVE_BAIUM);
        info.set("respawn_time",(System.currentTimeMillis()) + respawnTime);
        GrandBossManager.getInstance().setStatsSet(LIVE_BAIUM,info);
		startQuestTimer("despawn_minions",20000,null,null);
        cancelQuestTimers("spawn_minion");
		if (getQuestTimer("skill_range", npc, null) != null)
			getQuestTimer("skill_range", npc, null).cancel();
		}	
		else if (GrandBossManager.getInstance().getBossStatus(LIVE_BAIUM) == AWAKE && Minions != null && Minions.contains(npc))
        {
            Minions.remove(npc);
            startQuestTimer("spawn_minion",60000,npc,null);
        }
        return super.onKill(npc,killer,isPet);
    }







	public static void main(String[] args)
	{
		// Quest class and state definition
		new Baium(-1, "baium", "ai");
	}
}