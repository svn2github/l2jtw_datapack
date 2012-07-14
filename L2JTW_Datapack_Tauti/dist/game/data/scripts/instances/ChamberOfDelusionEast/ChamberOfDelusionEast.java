/**
 * @author by d0S
 */
package instances.ChamberOfDelusionEast;

import com.l2jserver.gameserver.ai.CtrlIntention;
import com.l2jserver.gameserver.instancemanager.InstanceManager;
import com.l2jserver.gameserver.instancemanager.InstanceManager.InstanceWorld;
import com.l2jserver.gameserver.model.L2Party;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.L2Summon;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;
import com.l2jserver.gameserver.util.Util;
import com.l2jserver.util.Rnd;

public class ChamberOfDelusionEast extends Quest
{
	private class CDWorld extends InstanceWorld
	{
		private L2Npc manager,managera,managerb,managerc,managerd,managere,managerf,managerg,managerh,_aenkinel;
		public CDWorld()
		{
			//InstanceManager.getInstance().super();
		}
	}

	private static final String qn = "ChamberOfDelusionEast";
	private static final int INSTANCEID = 127; // this is the client number
	//NPCs
	private static final int GKSTART  = 32658;
	private static final int GKFINISH = 32664;
	private static final int AENKINEL = 25690;
	private static final int ROOMRB   = 4;
	private int rb = 0;
	private int a;
	public int instId = 0;
	private int b;
	private int g = 0;
	private int h = 0;
	private int c;
	private class teleCoord {int instanceId; int x; int y; int z;}

	private static final int[][] TELEPORT =
	{
		{ -122368,-152624,-6752},
		{ -122368,-153504,-6752},
		{ -120496,-154304,-6752},
		{ -120496,-155184,-6752},
		{ -121440,-154688,-6752},
		{ -121440,-151328,-6752},
		{ -120496,-153008,-6752},
		{ -122368,-154800,-6752},
		{ -121440,-153008,-6752}
	};

	private boolean checkConditions(L2PcInstance player)
	{
		L2Party party = player.getParty();
		if (party == null)
		{
			player.sendPacket(SystemMessage.getSystemMessage(2101));
			return false;
		}
		if (party.getLeader() != player)
		{
			player.sendPacket(SystemMessage.getSystemMessage(2185));
			return false;
		}
		for (L2PcInstance partyMember : party.getMembers())
		{
			if (partyMember.getLevel() < 80)
			{
				SystemMessage sm = SystemMessage.getSystemMessage(2097);
				sm.addPcName(partyMember);
				party.broadcastPacket(sm);
				return false;
			}
			if (!Util.checkIfInRange(1000, player, partyMember, true))
			{
				SystemMessage sm = SystemMessage.getSystemMessage(2096);
				sm.addPcName(partyMember);
				party.broadcastPacket(sm);
				return false;
			}
		}
		return true;
	}

	private void teleportplayer(L2PcInstance player, teleCoord teleto)
	{
		player.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
		player.setInstanceId(teleto.instanceId);
		player.teleToLocation(teleto.x, teleto.y, teleto.z);
		return;
	}

	private void teleportrnd(L2PcInstance player, CDWorld world)
	{
		int tp = Rnd.get(TELEPORT.length);
		if (rb == 1 && tp == ROOMRB)
		{
			tp = Rnd.get(TELEPORT.length);
			for (int i = 0; i < TELEPORT.length; i++)
			{
				if (i == tp)
				{
					for (L2PcInstance partyMember : player.getParty().getMembers())
					{
						partyMember.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
						partyMember.setInstanceId(instId);
						partyMember.teleToLocation(TELEPORT[i][0], TELEPORT[i][1], TELEPORT[i][2]);
					}
				}
			}
			a = player.getX();
			b = player.getY();
			c = player.getZ();
		}
		else
		{
			for (int i = 0; i < TELEPORT.length; i++)
			{
				if (i == tp)
				{
					for (L2PcInstance partyMember : player.getParty().getMembers())
					{
						partyMember.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
						partyMember.setInstanceId(instId);
						partyMember.teleToLocation(TELEPORT[i][0], TELEPORT[i][1], TELEPORT[i][2]);
					}
				}
			}
			a = player.getX();
			b = player.getY();
			c = player.getZ();
		}
		return;
	}

	protected void spawnState(CDWorld world)
	{
		world._aenkinel = addSpawn(AENKINEL,-121463,-155094,-6752,0,false,0,false,world.instanceId);
		world._aenkinel.setIsNoRndWalk(false);
		world.manager = addSpawn(32664,-121440,-154688,-6752,0,false,0,false,world.instanceId);
		world.manager.setIsNoRndWalk(true);
		world.managerb = addSpawn(32664,-122368,-153504,-6752,0,false,0,false,world.instanceId);
		world.managerb.setIsNoRndWalk(true);
		world.managerc = addSpawn(32664,-120496,-154304,-6752,0,false,0,false,world.instanceId);
		world.managerc.setIsNoRndWalk(true);
		world.managerd = addSpawn(32664,-120496,-155184,-6752,0,false,0,false,world.instanceId);
		world.managerd.setIsNoRndWalk(true);
		world.managere = addSpawn(32664,-121440,-151328,-6752,0,false,0,false,world.instanceId);
		world.managere.setIsNoRndWalk(true);
		world.managerf = addSpawn(32664,-120496,-153008,-6752,0,false,0,false,world.instanceId);
		world.managerf.setIsNoRndWalk(true);
		world.managerg = addSpawn(32664,-122368,-154800,-6752,0,false,0,false,world.instanceId);
		world.managerg.setIsNoRndWalk(true);
		world.managerh = addSpawn(32664,-121440,-153008,-6752,0,false,0,false,world.instanceId);
		world.managerh.setIsNoRndWalk(true);
		world.managera = addSpawn(32664,-122368,-152624,-6752,0,false,0,false,world.instanceId);
		world.managera.setIsNoRndWalk(true);
	}

	protected int enterInstance(L2PcInstance player, String template)
	{
		int instanceId = 0;
		//check for existing instances for this player
		InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
		//existing instance
		if (world != null)
		{
			if (!(world instanceof CDWorld))
			{
				player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.ALREADY_ENTERED_ANOTHER_INSTANCE_CANT_ENTER));
				return 0;
			}
			teleCoord tele = new teleCoord();
			tele.x = a;
			tele.y = b;
			tele.z = c;
			tele.instanceId = world.instanceId;
			teleportplayer(player,tele);
			return instanceId;
		}
		//New instance
		if (!checkConditions(player))
			return 0;
		L2Party party = player.getParty();
		instanceId = InstanceManager.getInstance().createDynamicInstance(template);
		world = new CDWorld();
		world.instanceId = instanceId;
		world.templateId = INSTANCEID;
		world.status = 0;
		InstanceManager.getInstance().addWorld(world);
		_log.info("Chamber Of Delusion started " + template + " Instance: " + instanceId + " created by player: " + player.getName());
		spawnState((CDWorld)world);
		instId = world.instanceId;
		for (L2PcInstance partyMember : party.getMembers())
		{
			teleportrnd(partyMember,(CDWorld)world);
			world.allowed.add(partyMember.getObjectId());
		}
		return instanceId;
	}

	protected void exitInstance(L2PcInstance player, teleCoord tele)
	{
		player.setInstanceId(0);
		player.teleToLocation(tele.x, tele.y, tele.z);
		L2Summon pet = player.getPet();
		if (pet != null)
		{
			pet.setInstanceId(0);
			pet.teleToLocation(tele.x, tele.y, tele.z);
		}
	}

	@Override
	@SuppressWarnings("cast")
	public String onAdvEvent (String event, L2Npc npc, L2PcInstance player)
	{
		InstanceWorld tmpworld = InstanceManager.getInstance().getPlayerWorld(player);
		if (tmpworld instanceof CDWorld)
		{
			CDWorld world = (CDWorld) tmpworld;
			L2Party party = player.getParty();
			instId = player.getInstanceId();
			if (event.equalsIgnoreCase("tproom"))
			{
				for (L2PcInstance partyMember : party.getMembers())
				{
					teleportrnd(partyMember,(CDWorld)world);
				}

				startQuestTimer("tproom1",480000,null,player);
				h++;
			}
			else if (event.equalsIgnoreCase("tproom1"))
			{
				for (L2PcInstance partyMember : party.getMembers())
				{
					teleportrnd(partyMember,(CDWorld)world);
				}

				startQuestTimer("tproom2",480000,null,player);
				h++;
			}
			else if (event.equalsIgnoreCase("tproom2"))
			{
				for (L2PcInstance partyMember : party.getMembers())
				{
					teleportrnd(partyMember,(CDWorld)world);
				}

				startQuestTimer("tproom3",480000,null,player);
				h++;
			}
			else if (event.equalsIgnoreCase("tproom3"))
			{
				for (L2PcInstance partyMember : party.getMembers())
				{
					teleportrnd(partyMember,(CDWorld)world);
				}
			}
			else if ("7".equalsIgnoreCase(event))
			{
				if (g == 0)
				{
					if (h == 0)
					{
						cancelQuestTimers("tproom");
						for (L2PcInstance partyMember : party.getMembers())
						{
							teleportrnd(partyMember,(CDWorld)world);
						}
						startQuestTimer("tproom1",480000,null,player);
						g = 1;
					}
					else if (h == 1)
					{
						cancelQuestTimers("tproom1");
						for (L2PcInstance partyMember : party.getMembers())
						{
							teleportrnd(partyMember,(CDWorld)world);
						}
						startQuestTimer("tproom2",480000,null,player);
						g = 1;
					}
					else if (h == 2)
					{
						cancelQuestTimers("tproom2");
						for (L2PcInstance partyMember : party.getMembers())
						{
							teleportrnd(partyMember,(CDWorld)world);
						}
						startQuestTimer("tproom3",480000,null,player);
						g = 1;
					}
					else if (h == 3)
					{
						cancelQuestTimers("tproom3");
						for (L2PcInstance partyMember : party.getMembers())
						{
							teleportrnd(partyMember,(CDWorld)world);
						}
						g = 1;
					}
				}
			}

		}
		return "";
	}

	public String onKill( L2Npc npc, L2PcInstance player)
	{
		int npcId = npc.getNpcId();
		if (rb == 0 && npcId == AENKINEL)
		{
			_log.info("kill");
			rb = 1;

		}
		return "";
	}

	@Override
	public final String onFirstTalk (L2Npc npc, L2PcInstance player)
	{
		return npc.getNpcId() + ".htm";
	}

	@Override
	public String onTalk (L2Npc npc, L2PcInstance player)
	{
		int npcId = npc.getNpcId();
		QuestState st = player.getQuestState(qn);
		if (st == null)
			st = newQuestState(player);
		if (npcId == GKSTART)
		{
			enterInstance(player,"ChamberofDelusionEast.xml");
			startQuestTimer("tproom",480000,null,player);
			return "";
		}
		else if (npcId == GKFINISH)
		{
			InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
			world.allowed.remove(world.allowed.indexOf(player.getObjectId()));
			teleCoord tele = new teleCoord();
			tele.instanceId = 0;
			tele.x = -114592;
			tele.y = -152509;
			tele.z = -6723;
			cancelQuestTimers("tproom");
			cancelQuestTimers("tproom1");
			cancelQuestTimers("tproom2");
			cancelQuestTimers("tproom3");
			for (L2PcInstance partyMember :  player.getParty().getMembers())
			{
				exitInstance(partyMember,tele);
			}
		}
		return "";
	}

	public ChamberOfDelusionEast(int questId, String name, String descr)
	{
		super(questId, name, descr);

		addStartNpc(GKSTART);
		addTalkId(GKSTART);
		addStartNpc(GKFINISH);
		addFirstTalkId(GKFINISH);
		addTalkId(GKFINISH);
		addKillId(AENKINEL);
	}

	public static void main(String[] args)
	{
		new ChamberOfDelusionEast(-1,qn,"instances");
	}
}