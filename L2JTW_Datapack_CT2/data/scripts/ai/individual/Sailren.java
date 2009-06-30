package ai.individual;

import static net.sf.l2j.gameserver.ai.CtrlIntention.AI_INTENTION_IDLE;

import ai.group_template.L2AttackableAIScript;
import net.sf.l2j.gameserver.ai.CtrlIntention;
import net.sf.l2j.gameserver.datatables.SkillTable;
import net.sf.l2j.gameserver.instancemanager.GrandBossManager;
import net.sf.l2j.gameserver.model.L2CharPosition;
import net.sf.l2j.gameserver.model.actor.L2Npc;
import net.sf.l2j.gameserver.model.actor.instance.L2GrandBossInstance;
import net.sf.l2j.gameserver.model.actor.instance.L2PcInstance;
import net.sf.l2j.gameserver.network.serverpackets.PlaySound;
import net.sf.l2j.gameserver.network.serverpackets.SocialAction;
import net.sf.l2j.gameserver.network.serverpackets.SpecialCamera;
import net.sf.l2j.gameserver.templates.StatsSet;
import net.sf.l2j.util.Rnd;
import net.sf.l2j.ExternalConfig;

/**
 * Sailren AI
 * Update by rocknow
 */
public class Sailren extends L2AttackableAIScript
{
	private static final int SAILREN = 29065;
	private static final int VELOCIRAPTOR = 22218;
	private static final int PTEROSAUR = 22199;
	private static final int TYRANNOSAURUS = 22217;
	private static final int STATUE = 32109;

	//Sailren Status Tracking :
	private static final byte DORMANT = 0;		//Sailren is spawned and no one has entered yet. Entry is unlocked
	private static final byte WAITING = 1;		//Sailren is spawend and someone has entered, triggering a 30 minute window for additional people to enter
												//before he unleashes his attack. Entry is unlocked
	private static final byte FIGHTING = 2; 	//Sailren is engaged in battle, annihilating his foes. Entry is locked
	private static final byte DEAD = 3;			//Sailren has been killed. Entry is locked
	
	private static long _LastAction = 0;

	// Boss: Sailren
	public Sailren(int id,String name,String descr)
	{
		super(id,name,descr);
		int[] mob = {SAILREN, VELOCIRAPTOR, PTEROSAUR, TYRANNOSAURUS};
		this.registerMobs(mob);
		addStartNpc(STATUE);
		addTalkId(STATUE);
		StatsSet info = GrandBossManager.getInstance().getStatsSet(SAILREN);
		int status = GrandBossManager.getInstance().getBossStatus(SAILREN);
		if (status == DEAD)
		{
			long temp = (info.getLong("respawn_time") - System.currentTimeMillis());
			if (temp > 0)
			{
				this.startQuestTimer("sailren_unlock", temp, null, null);
			}
			else
			{
				GrandBossManager.getInstance().setBossStatus(SAILREN,DORMANT);
			}
		}
		else
		{
			GrandBossManager.getInstance().setBossStatus(SAILREN,DORMANT);
		}
	}

	public String onAdvEvent (String event, L2Npc npc, L2PcInstance player)
	{
	if (npc != null)
	{
		long temp = 0;
		if (event.equalsIgnoreCase("waiting"))
		{
			GrandBossManager.getInstance().setBossStatus(SAILREN,FIGHTING);
			L2Npc mob1 = addSpawn(VELOCIRAPTOR,27852,-5536,-1983,44732,false,0);
			this.startQuestTimer("start",0, mob1, null);
		}
		if (event.equalsIgnoreCase("waiting2"))
		{
			L2Npc mob2 = addSpawn(PTEROSAUR,27852,-5536,-1983,44732,false,0);
			this.startQuestTimer("start",0, mob2, null);
		}
		if (event.equalsIgnoreCase("waiting3"))
		{
			L2Npc mob3 = addSpawn(TYRANNOSAURUS,27852,-5536,-1983,44732,false,0);
			this.startQuestTimer("start",0, mob3, null);
		}
		if (event.equalsIgnoreCase("waiting_boss"))
		{
			L2GrandBossInstance sailren = (L2GrandBossInstance) addSpawn(SAILREN,27734,-6938,-1982,44732,false,0);
			GrandBossManager.getInstance().addBoss(sailren);
			this.startQuestTimer("start2",0, sailren, null);
		}
		if (event.equalsIgnoreCase("start"))
		{
			_LastAction = System.currentTimeMillis();
			npc.setRunning();
			npc.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, new L2CharPosition(27628,-6109,-1982,44732));
			this.startQuestTimer("mob_has_arrived",200, npc, null, true);
		}
		if (event.equalsIgnoreCase("start2"))
		{
			_LastAction = System.currentTimeMillis();
			npc.setRunning();
			npc.setIsInvul(true);
			npc.setIsParalyzed(true);
			npc.setIsImmobilized(true);
			this.startQuestTimer("camera_1",2000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),300,0,32,2000,11000));
		}
		else if (event.equalsIgnoreCase("action_1"))
		{
			npc.broadcastPacket(new SocialAction(npc.getObjectId(),2));
			this.startQuestTimer("camera_6",2500, npc, null);
		}
		else if (event.equalsIgnoreCase("camera_1"))
		{
			npc.setTarget(npc);
			npc.setIsParalyzed(false);
			npc.doCast(SkillTable.getInstance().getInfo(5118,1));
			npc.setIsParalyzed(true);
			this.startQuestTimer("camera_2",4000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),300,90,24,4000,11000));
		}
		else if (event.equalsIgnoreCase("camera_2"))
		{
			npc.setTarget(npc);
			npc.setIsParalyzed(false);
			npc.doCast(SkillTable.getInstance().getInfo(5118,1));
			npc.setIsParalyzed(true);
			this.startQuestTimer("camera_3",4000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),300,160,16,4000,11000));
		}
		else if (event.equalsIgnoreCase("camera_3"))
		{
			npc.setTarget(npc);
			npc.setIsParalyzed(false);
			npc.doCast(SkillTable.getInstance().getInfo(5118,1));
			npc.setIsParalyzed(true);
			this.startQuestTimer("camera_4",4000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),300,250,8,4000,11000));
		}
		else if (event.equalsIgnoreCase("camera_4"))
		{
			npc.setTarget(npc);
			npc.setIsParalyzed(false);
			npc.doCast(SkillTable.getInstance().getInfo(5118,1));
			npc.setIsParalyzed(true);
			this.startQuestTimer("camera_5",4000, npc, null);
			npc.broadcastPacket(new SpecialCamera(npc.getObjectId(),300,340,0,4000,11000));
		}
		else if (event.equalsIgnoreCase("camera_5"))
		{
			npc.broadcastPacket(new SocialAction(npc.getObjectId(),2));
			this.startQuestTimer("camera_6",5000, npc, null);
		}
		else if (event.equalsIgnoreCase("camera_6"))
		{
			this.startQuestTimer("sailren_despawn",30000, npc, null, true);
			npc.setIsInvul(false);
			npc.setIsParalyzed(false);
			npc.setIsImmobilized(false);
		}
		else if (event.equalsIgnoreCase("sailren_despawn"))
		{
			temp = (System.currentTimeMillis() - _LastAction);
			if (temp > 600000)
			{
				npc.getAI().setIntention(AI_INTENTION_IDLE);
				npc.deleteMe();
				GrandBossManager.getInstance().setBossStatus(SAILREN,DORMANT);
				this.cancelQuestTimer("sailren_despawn", npc, null);
			}
		}
		else if (event.equalsIgnoreCase("mob_has_arrived"))
		{
			int dx = Math.abs(npc.getX() - 27628);
			int dy = Math.abs(npc.getY() + 6109);
			if (dx <= 10 && dy <= 10)
			{
				npc.setIsImmobilized(true);
				this.startQuestTimer("action_1",500, npc, null);
				npc.getSpawn().setLocx(27628);
				npc.getSpawn().setLocy(-6109);
				npc.getSpawn().setLocz(-1982);
				npc.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
				this.cancelQuestTimer("mob_has_arrived", npc, null);
			}
			else
			{
				npc.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,new L2CharPosition(27628,-6109,-1982,44732));
			}
		}
		else if (event.equalsIgnoreCase("spawn_cubes"))
		{
			addSpawn(32107,27734,-6838,-1982,0,false,600000);
		}
	}
	else
	{
		if (event.equalsIgnoreCase("sailren_unlock"))
		{
			GrandBossManager.getInstance().setBossStatus(SAILREN,DORMANT);
		}
	}
	return super.onAdvEvent(event, npc, player);
	}

	public String onTalk(L2Npc npc,L2PcInstance player)
	{
	String htmltext = "";
	if (GrandBossManager.getInstance().getBossStatus(SAILREN) == DORMANT || GrandBossManager.getInstance().getBossStatus(SAILREN) == WAITING)
		{
			if (player.isFlying())
			{
				htmltext = "<html><body>席琳聖像：<br>騎乘飛龍的狀態下無法讓你進入。</body></html>";
			}
			else if (player.getQuestState("sailren").getQuestItemsCount(8784) > 0)
			{
				player.getQuestState("sailren").takeItems(8784,1);
				player.teleToLocation(27734 + Rnd.get(-80, 80),-6938 + Rnd.get(-80, 80),-1982);
				htmltext = "";
				if (GrandBossManager.getInstance().getBossStatus(SAILREN) == DORMANT)
				{
					this.startQuestTimer("waiting",60000, npc, null);
					GrandBossManager.getInstance().setBossStatus(SAILREN,WAITING);
				}
			}
			else
				htmltext = "<html><body>席琳聖像：<br><font color=LEVEL>卡茲克</font>是封印賽爾蘭必備的物品。</body></html>";
		}
	else if (GrandBossManager.getInstance().getBossStatus(SAILREN) == FIGHTING)
		htmltext = "<html><body>席琳聖像：<br><font color=\"LEVEL\">已經有人進入賽爾蘭巢穴。在他們與賽爾蘭的對戰結束之前不能讓你們進入。</font></body></html>";
	else
		htmltext = "<html><body>席琳聖像：<br><font color=\"LEVEL\">賽爾蘭目前沉睡中.....請回吧。</font></body></html>";
	return htmltext;
	}

	public String onAttack (L2Npc npc, L2PcInstance attacker, int damage, boolean isPet)
	{
		_LastAction = System.currentTimeMillis();
		if (npc.isInvul() && npc.getNpcId() == SAILREN)
		{
			npc.getAI().setIntention(AI_INTENTION_IDLE);
			return null;
		}
		if (npc.getNpcId() == VELOCIRAPTOR || npc.getNpcId() == PTEROSAUR || npc.getNpcId() == TYRANNOSAURUS)
		{
			if (getQuestTimer("mob_has_arrived", npc, null) != null)
			{
				getQuestTimer("mob_has_arrived", npc, null).cancel();
				npc.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,new L2CharPosition(npc.getX(),npc.getY(),npc.getZ(),npc.getHeading()));
				this.startQuestTimer("camera_6",0, npc, null);
			}
		}
		return super.onAttack(npc, attacker, damage, isPet);
	}

	public String onKill (L2Npc npc, L2PcInstance killer, boolean isPet)
	{
		if (GrandBossManager.getInstance().getBossStatus(SAILREN) == FIGHTING && npc.getNpcId() == SAILREN)
		{
			npc.broadcastPacket(new PlaySound(1, "BS01_D", 1, npc.getObjectId(), npc.getX(), npc.getY(), npc.getZ()));
			this.cancelQuestTimer("sailren_despawn", npc, null);
			this.startQuestTimer("spawn_cubes", 5000, npc, null);
			GrandBossManager.getInstance().setBossStatus(SAILREN,DEAD);
			long respawnTime = (ExternalConfig.Interval_Of_Sailren_Spawn + Rnd.get(ExternalConfig.Random_Of_Sailren_Spawn));
			this.startQuestTimer("sailren_unlock", respawnTime, null, null);
			// also save the respawn time so that the info is maintained past reboots
			StatsSet info = GrandBossManager.getInstance().getStatsSet(SAILREN);
			info.set("respawn_time",(System.currentTimeMillis() + respawnTime));
			GrandBossManager.getInstance().setStatsSet(SAILREN,info);
		}
		else if (GrandBossManager.getInstance().getBossStatus(SAILREN) == FIGHTING && npc.getNpcId() == VELOCIRAPTOR)
		{
			this.cancelQuestTimer("sailren_despawn", npc, null);
			this.startQuestTimer("waiting2",30000,npc,null);
		}
		else if (GrandBossManager.getInstance().getBossStatus(SAILREN) == FIGHTING && npc.getNpcId() == PTEROSAUR)
		{
			this.cancelQuestTimer("sailren_despawn", npc, null);
			this.startQuestTimer("waiting3",30000,npc,null);
		}
		else if (GrandBossManager.getInstance().getBossStatus(SAILREN) == FIGHTING && npc.getNpcId() == TYRANNOSAURUS)
		{
			this.cancelQuestTimer("sailren_despawn", npc, null);
			this.startQuestTimer("waiting_boss",30000,npc,null);
		}
		return super.onKill(npc,killer,isPet);
	}

	public static void main(String[] args)
	{
		// now call the constructor (starts up the ai)
		new Sailren(-1,"sailren","ai");
	}
}