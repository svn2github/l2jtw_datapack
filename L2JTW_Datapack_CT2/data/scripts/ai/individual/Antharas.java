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

import net.sf.l2j.gameserver.ai.CtrlIntention;
import net.sf.l2j.gameserver.instancemanager.GrandBossManager;
import net.sf.l2j.gameserver.model.L2CharPosition;
import net.sf.l2j.gameserver.model.actor.instance.L2GrandBossInstance;
import net.sf.l2j.gameserver.model.actor.instance.L2NpcInstance;
import net.sf.l2j.gameserver.model.actor.instance.L2PcInstance;
import net.sf.l2j.gameserver.model.zone.type.L2BossZone;
import net.sf.l2j.gameserver.network.serverpackets.Earthquake;
import net.sf.l2j.gameserver.network.serverpackets.PlaySound;
import net.sf.l2j.gameserver.network.serverpackets.SpecialCamera;
import net.sf.l2j.gameserver.templates.StatsSet;
import net.sf.l2j.util.Rnd;
import ai.group_template.L2AttackableAIScript;
import net.sf.l2j.gameserver.datatables.SkillTable;
import net.sf.l2j.gameserver.model.L2Effect;
import net.sf.l2j.gameserver.network.serverpackets.SocialAction;
import static net.sf.l2j.gameserver.ai.CtrlIntention.AI_INTENTION_FOLLOW;
import static net.sf.l2j.gameserver.ai.CtrlIntention.AI_INTENTION_IDLE;
import java.util.Collection;
import javolution.util.FastList;
import net.sf.l2j.gameserver.GeoData;
import net.sf.l2j.gameserver.model.L2Character;
import net.sf.l2j.gameserver.model.L2Object;
import net.sf.l2j.gameserver.model.L2Skill;
import net.sf.l2j.gameserver.model.L2Summon;
import net.sf.l2j.gameserver.model.actor.instance.L2DecoyInstance;
import net.sf.l2j.gameserver.model.quest.QuestTimer;
import net.sf.l2j.gameserver.util.Util;
import ExternalConfig;

/**
 * Antharas AI
 * @author Emperorc
 */
public class Antharas extends L2AttackableAIScript
{
	private L2Character _target;
	private L2Skill _skill;
	private static final int ANTHARAS = 29019;

	//Antharas Status Tracking :
	private static final byte DORMANT = 0;     	//Antharas is spawned and no one has entered yet. Entry is unlocked
	private static final byte WAITING = 1;     	//Antharas is spawend and someone has entered, triggering a 30 minute window for additional people to enter
	                							//before he unleashes his attack. Entry is unlocked
	private static final byte FIGHTING = 2;    	//Antharas is engaged in battle, annihilating his foes. Entry is locked
	private static final byte DEAD = 3;        	//Antharas has been killed. Entry is locked
    
	private static long _LastAction = 0;
	
	private static L2BossZone _Zone;
	
	// Boss: Antharas
	public Antharas(int id,String name,String descr)
	{
		
		ExternalConfig.loadconfig();
        super(id,name,descr);
        int[] mob = {ANTHARAS};
        this.registerMobs(mob);
        _Zone = GrandBossManager.getInstance().getZone(181323,114850,-7618);
        StatsSet info = GrandBossManager.getInstance().getStatsSet(ANTHARAS);
        int status = GrandBossManager.getInstance().getBossStatus(ANTHARAS);
        if (status == DEAD)
        {
            // load the unlock date and time for antharas from DB
            long temp = (info.getLong("respawn_time") - System.currentTimeMillis());
            // if antharas is locked until a certain time, mark it so and start the unlock timer
            // the unlock time has not yet expired.  Mark Antharas as currently locked.  Setup a timer
            // to fire at the correct time (calculate the time between now and the unlock time,
            // setup a timer to fire after that many msec)
            if (temp > 0)
            {
                this.startQuestTimer("antharas_unlock", temp, null, null);
            }
            else
            {
                // the time has already expired while the server was offline. Immediately spawn antharas in his cave.
                // also, the status needs to be changed to DORMANT
                L2GrandBossInstance antharas = (L2GrandBossInstance) addSpawn(ANTHARAS,-105820,-237310,-15529,32768,false,0);
                GrandBossManager.getInstance().setBossStatus(ANTHARAS,DORMANT);
                GrandBossManager.getInstance().addBoss(antharas);
            }
        }
        else
        {
            int loc_x = info.getInteger("loc_x");
            int loc_y = info.getInteger("loc_y");
            int loc_z = info.getInteger("loc_z");
            int heading = info.getInteger("heading");
            int hp = info.getInteger("currentHP");
            int mp = info.getInteger("currentMP");
            L2GrandBossInstance antharas = (L2GrandBossInstance) addSpawn(ANTHARAS,loc_x,loc_y,loc_z,heading,false,0);
            GrandBossManager.getInstance().addBoss(antharas);
            antharas.setCurrentHpMp(hp,mp);
            if (status == WAITING)
            {
                // Start timer to lock entry after 30 minutes

                this.startQuestTimer("waiting",ExternalConfig.Antharas_Wait_Time, antharas, null);

            }
            else if (status == FIGHTING)
            {
                _LastAction = System.currentTimeMillis();
                // Start repeating timer to check for inactivity
                this.startQuestTimer("antharas_despawn",60000, antharas, null, true);
                antharas.setIsInvul(false);
                antharas.setIsImmobilized(false);
                antharas.setRunning();
            }
        }
	}

	public String onAdvEvent (String event, L2NpcInstance npc, L2PcInstance player)
	{
        if (npc != null)
        {
        	long temp = 0;     	
			if (event.equalsIgnoreCase("waiting"))
            {
                npc.teleToLocation(185452,114850,-8221);
                npc.setIsInvul(true);
                npc.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, new L2CharPosition(181323,114850,-7618,0));
                this.startQuestTimer("antharas_has_arrived",1000, npc, null, true);
                npc.broadcastPacket(new PlaySound(1, "BS02_A", 1, npc.getObjectId(), 181323, 114850, -7618));
                npc.broadcastPacket(new Earthquake(181323,114850,-7618,20,10));
            }
            else if (event.equalsIgnoreCase("skill_range"))
            {
                callSkillAI(npc);
            }
            else if (event.equalsIgnoreCase("clean_player"))
            {   
                _target = getRandomTarget(npc);
            }
            else if (event.equalsIgnoreCase("camera_1"))
            {
                npc.broadcastPacket(new SocialAction(npc.getObjectId(),1));
                this.startQuestTimer("camera_2",3000, npc, null);
                npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),700,13,-19,0,10000));
            }
            else if (event.equalsIgnoreCase("camera_2"))
            {
                this.startQuestTimer("camera_3",10000, npc, null);
                npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),700,13,0,6000,10000));
            }
            else if (event.equalsIgnoreCase("camera_3"))
            {
                this.startQuestTimer("camera_4",200, npc, null);
                npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),3800,0,0,0,10000));
            }
            else if (event.equalsIgnoreCase("camera_4"))
            {
                npc.broadcastPacket(new SocialAction(npc.getObjectId(),2));
                this.startQuestTimer("camera_5",10800, npc, null);
                npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),1200,0,0,22000,11000));
            }
            else if (event.equalsIgnoreCase("camera_5"))
            {
                this.startQuestTimer("camera_5b",1900, npc, null);
                npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),1200,0,0,300,2000));
                _LastAction = System.currentTimeMillis();
            }
            else if (event.equalsIgnoreCase("camera_5b"))
            {
                this.startQuestTimer("antharas_despawn",60000, npc, null, true);
                this.startQuestTimer("skill_range", 500, npc, null, true);
                npc.setIsInvul(false);
                npc.setIsImmobilized(false);
                npc.setRunning();
                GrandBossManager.getInstance().setBossStatus(ANTHARAS,FIGHTING);
            }
            else if (event.equalsIgnoreCase("antharas_despawn"))
            {
                _Zone = GrandBossManager.getInstance().getZone(181323,114850,-7618);
                temp = (System.currentTimeMillis() - _LastAction);
                if (temp > 900000)
                {
                    npc.getAI().setIntention(AI_INTENTION_IDLE);
                    npc.teleToLocation(-105820,-237310,-15529);
                    GrandBossManager.getInstance().setBossStatus(ANTHARAS,DORMANT);
                    npc.setCurrentHpMp(npc.getMaxHp(),npc.getMaxMp());
                    _Zone.oustAllPlayers();
                    this.cancelQuestTimer("antharas_despawn", npc, null);
                }
                else if (!_Zone.isInsideZone(npc))
                    npc.teleToLocation(181323,114850,-7618);
                else if (npc.getCurrentHp() > ( ( npc.getMaxHp() * 3 ) / 4 ) )
                {
                        npc.setIsCastingNow(false);
                        npc.setTarget(npc);
                        npc.doCast(SkillTable.getInstance().getInfo(4239,1));
                        npc.setIsCastingNow(true);
            }
                else if (npc.getCurrentHp() > ( ( npc.getMaxHp() * 2 ) / 4 ) )
                {
                        npc.setIsCastingNow(false);
                        npc.setTarget(npc);
                        npc.doCast(SkillTable.getInstance().getInfo(4240,1));
                        npc.setIsCastingNow(true);
                }
                else if (npc.getCurrentHp() > ( ( npc.getMaxHp() * 1 ) / 4 ) )
                {
                        npc.setIsCastingNow(false);
                        npc.setTarget(npc);
                        npc.doCast(SkillTable.getInstance().getInfo(4241,1));
                        npc.setIsCastingNow(true);
                }
            }
            else if (event.equalsIgnoreCase("antharas_has_arrived"))
            {
               int dx = Math.abs(npc.getX() - 181323);
               int dy = Math.abs(npc.getY() - 114850);
               if (dx <= 20 && dy <= 20)
               {
                   npc.setIsImmobilized(true);
                   this.startQuestTimer("camera_1",500, npc, null);
                   npc.getSpawn().setLocx(181323);
                   npc.getSpawn().setLocy(114850);
                   npc.getSpawn().setLocz(-7618);
                   npc.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
                   this.cancelQuestTimer("antharas_has_arrived", npc, null);
               }
               else
               {
                   npc.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,new L2CharPosition(181323,114850,-7618,0));
               }
            }
            else if (event.equalsIgnoreCase("spawn_cubes"))
            {
                addSpawn(31859,177615,114941,-7709,0,false,900000);
                int radius = 1500;
                for (int i=0; i < 19;i++)
                {
                    int x = (int) (radius*Math.cos(i*.331)); //.331~2pi/19
                    int y = (int) (radius*Math.sin(i*.331));
                    addSpawn(31859,177615+x,114941+y,-7709,0,false,900000);
                }
                this.cancelQuestTimer("antharas_despawn", npc, null);
                this.startQuestTimer("remove_players",900000, null, null);
            }
        }
        else
        {
            if (event.equalsIgnoreCase("antharas_unlock"))
            {
                L2GrandBossInstance antharas = (L2GrandBossInstance) addSpawn(ANTHARAS,-105820,-237310,-15529,32768,false,0);
                GrandBossManager.getInstance().addBoss(antharas);
                GrandBossManager.getInstance().setBossStatus(ANTHARAS,DORMANT);
            }
            else if (event.equalsIgnoreCase("remove_players"))
            {
                _Zone.oustAllPlayers();
            }
        }
        return super.onAdvEvent(event, npc, player);
	}
    
    public String onSpellFinished(L2NpcInstance npc, L2PcInstance player, L2Skill skill)
    {
    	if (npc.isInvul())
		{
			npc.getAI().setIntention(AI_INTENTION_IDLE);
			return null;
		}
		else if (npc.getNpcId() == ANTHARAS && !npc.isInvul())
    	{
    		callSkillAI(npc);
    	}
    	return super.onSpellFinished(npc, player, skill);
    }
	public String onAttack (L2NpcInstance npc, L2PcInstance attacker, int damage, boolean isPet)
	{		
        _LastAction = System.currentTimeMillis();
        if (GrandBossManager.getInstance().getBossStatus(ANTHARAS) != FIGHTING)
        {
            _Zone.oustAllPlayers();
        }
		if (npc.isInvul())
		{
			npc.getAI().setIntention(AI_INTENTION_IDLE);
			return null;
		}
		else if (npc.getNpcId() == ANTHARAS && !npc.isInvul())
    	{
    		if (attacker.getMountType() == 1)
        	{
    			int sk_4258 = 0;
    			L2Effect[] effects = attacker.getAllEffects();
    			if (effects.length != 0 || effects != null)
    			{
    				for (L2Effect e : effects)
    				{
    					if (e.getSkill().getId() == 4258)
    						sk_4258 = 1;
    				}
    	        }
    			if (sk_4258 == 0)
    			{
    				npc.setTarget(attacker);
    				npc.doCast(SkillTable.getInstance().getInfo(4258,1));
    			}
        	}
    		callSkillAI(npc);
    	}
		return super.onAttack(npc, attacker, damage, isPet);
    }

    public String onKill (L2NpcInstance npc, L2PcInstance killer, boolean isPet) 
    { 
        npc.broadcastPacket(new PlaySound(1, "BS01_D", 1, npc.getObjectId(), npc.getX(), npc.getY(), npc.getZ()));
        this.startQuestTimer("spawn_cubes", 10000, npc, null);
        GrandBossManager.getInstance().setBossStatus(ANTHARAS,DEAD);
        long respawnTime = ((192 + Rnd.get(145) ) * 3600000);
        this.startQuestTimer("antharas_unlock", respawnTime, null, null);
        // also save the respawn time so that the info is maintained past reboots
        StatsSet info = GrandBossManager.getInstance().getStatsSet(ANTHARAS);
        info.set("respawn_time",(System.currentTimeMillis() + respawnTime));
        GrandBossManager.getInstance().setStatsSet(ANTHARAS,info);
		if (getQuestTimer("skill_range", npc, null) != null)
			getQuestTimer("skill_range", npc, null).cancel();
        return super.onKill(npc,killer,isPet);
    }

	public L2Character getRandomTarget(L2NpcInstance npc)
	{
		FastList<L2Character> result = new FastList<L2Character>();
		Collection<L2Object> objs = npc.getKnownList().getKnownObjects().values();
		{
			for (L2Object obj : objs)
			{
				if (obj instanceof L2Character)
				{
					if (((L2Character) obj).getZ() < ( npc.getZ() - 100 ) && ((L2Character) obj).getZ() > ( npc.getZ() + 100 )
							|| !(GeoData.getInstance().canSeeTarget(((L2Character) obj).getX(), ((L2Character) obj).getY(), ((L2Character) obj).getZ(), npc.getX(), npc.getY(), npc.getZ())))
						continue;
				}
				if (obj instanceof L2PcInstance || obj instanceof L2Summon || obj instanceof L2DecoyInstance)
				{
					if (Util.checkIfInRange(5000, npc, obj, true) && !((L2Character) obj).isDead())
						result.add((L2Character) obj);
				}
			}
		}
		if (!result.isEmpty() && result.size() != 0)
		{
			Object[] characters = result.toArray();
			QuestTimer timer = getQuestTimer("clean_player", npc, null);
			if (timer != null)
				timer.cancel();
			startQuestTimer("clean_player", 20000, npc, null);
			return (L2Character) characters[Rnd.get(characters.length)];
		}
		return null;
	}

	public synchronized void callSkillAI(L2NpcInstance npc)
	{
		if (npc.isInvul() || npc.isCastingNow()) return;

		if (_target == null || _target.isDead() || !(_Zone.isInsideZone(_target)))
		{
			_target = getRandomTarget(npc);
			if (_target != null)
				_skill = SkillTable.getInstance().getInfo(getRandomSkill(npc),1);
		}

		L2Character target = _target;
		L2Skill skill = _skill;
		if (skill == null)
			skill = SkillTable.getInstance().getInfo(getRandomSkill(npc),1);
		if (target == null || target.isDead() || !(_Zone.isInsideZone(target)))
		{
			npc.setIsCastingNow(false);
			return;
		}

		if (Util.checkIfInRange(skill.getCastRange(), npc, target, true))
		{
			npc.getAI().setIntention(AI_INTENTION_IDLE);
			npc.setTarget(target);
			npc.setIsCastingNow(true);
			_target = null;
			_skill = null;
			npc.doCast(skill);
		}
		else
		{
			npc.getAI().setIntention(AI_INTENTION_FOLLOW, target, null);
			npc.setIsCastingNow(false);
		}
	}

	public int getRandomSkill(L2NpcInstance npc)
	{
		int skill;
		if( npc.getCurrentHp() > ( ( npc.getMaxHp() * 3 ) / 4 ) )
		{
			if( Rnd.get(100) < 20 )
				skill = 4113;
			else if( Rnd.get(100) < 3 )
				skill = 4110;
			else if( Rnd.get(100) < 3 )
				skill = 4108;
			else if( Rnd.get(100) < 5 )
				skill = 4107;
			else if( Rnd.get(100) < 5 )
				skill = 4106;
			else
				skill = 4112;
		}
		else if( npc.getCurrentHp() > ( ( npc.getMaxHp() * 2 ) / 4) )
		{
			if( Rnd.get(100) < 20 )
				skill = 4113;
			else if( Rnd.get(100) < 5 )
				skill = 4110;
			else if( Rnd.get(100) < 10 )
				skill = 4109;
			else if( Rnd.get(100) < 5 )
				skill = 4108;
			else if( Rnd.get(100) < 10 )
				skill = 4107;
			else if( Rnd.get(100) < 10 )
				skill = 4106;
			else
				skill = 4112;
		}
		else if( npc.getCurrentHp() > ( ( npc.getMaxHp() * 1 ) / 4 ) )
		{
			if( Rnd.get(100) < 5 )
				skill = 5093;
			else if( Rnd.get(100) < 20 )
				skill = 4113;
			else if( Rnd.get(100) < 15 )
				skill = 4111;
			else if( Rnd.get(100) < 10 )
				skill = 4110;
			else if( Rnd.get(100) < 15 )
				skill = 4109;
			else if( Rnd.get(100) < 10 )
				skill = 4108;
			else if( Rnd.get(100) < 15 )
				skill = 4107;
			else if( Rnd.get(100) < 15 )
				skill = 4106;
			else
				skill = 4112;
		}
		else if( Rnd.get(100) < 10 )
			skill = 5093;
		else if( Rnd.get(100) < 10 )
			skill = 5092;
		else if( Rnd.get(100) < 20 )
			skill = 4113;
		else if( Rnd.get(100) < 20 )
			skill = 4111;
		else if( Rnd.get(100) < 15 )
			skill = 4110;
		else if( Rnd.get(100) < 20 )
			skill = 4109;
		else if( Rnd.get(100) < 15 )
			skill = 4108;
		else if( Rnd.get(100) < 20 )
			skill = 4107;
		else if( Rnd.get(100) < 20 )
			skill = 4106;
		else
			skill = 4112;
		return skill;
	}

	public String onSkillSee (L2NpcInstance npc, L2PcInstance caster, L2Skill skill, L2Object[] targets, boolean isPet)
	{
		if (npc.isInvul())
		{
			npc.getAI().setIntention(AI_INTENTION_IDLE);
			return null;
		}
		npc.setTarget(caster);
		return super.onSkillSee(npc, caster, skill, targets, isPet);
	}

    public static void main(String[] args)
    {
    	// now call the constructor (starts up the ai)
    	new Antharas(-1,"antharas","ai");
    }
}