/**
 * @author by d0S
 */
package instances.ChamberOfDelusionGreat;

import java.util.Calendar;

import com.l2jserver.gameserver.ai.CtrlIntention;
import com.l2jserver.gameserver.instancemanager.InstanceManager;
import com.l2jserver.gameserver.instancemanager.InstanceManager.InstanceWorld;
import com.l2jserver.gameserver.model.L2Party;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.L2Summon;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.L2World;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;
import com.l2jserver.gameserver.util.Util;
import com.l2jserver.util.Rnd;

public class ChamberOfDelusionGreat extends Quest
{
	private class CDWorld extends InstanceWorld
	{
		private L2Npc manager,managera,managerb,managerc,managerd,managere,managerf,managerg,managerh,_aenkinel;
		public CDWorld()
		{
			//InstanceManager.getInstance().super();
		}
	}

	private static final String qn = "ChamberOfDelusionGreat";
	private static final int INSTANCEID = 131; // this is the client number
	private static final int RESET_HOUR = 6;
	private static final int RESET_MIN = 30;
	//NPCs
	private static final int GKSTART  = 32662;
	private static final int GKFINISH = 32668;
	private static final int AENKINEL = 25694;
	private static final int ROOM1    = 0;
	private static final int ROOM2    = 1;
	private static final int ROOM3    = 2;
	private static final int ROOM4    = 3;
	private static final int ROOM5    = 4;
	private static final int ROOM6    = 5;
	private static final int ROOM7    = 6;
	private static final int ROOM8    = 7;
	private int a;
	public int instId = 0;
	private int b;
	private int h = 0;
	private int g = 0;
	private int c;
	private int tp;
	private int m;
	private int r1 = 0;
	private int r2 = 0;
	private int r3 = 0;
	private int r4 = 0;
	private int r5 = 0;
	private int r6 = 0;
	private int r7 = 0;
	private int r8 = 0;
	private class teleCoord {int instanceId; int x; int y; int z;}

	private static final int[][] TELEPORT =
	{
		{-108992,-152624,-6752},
		{-108992,-153504,-6752},
		{-107120,-154304,-6752},
		{-107120,-155184,-6752},
		{-108064,-151328,-6752},
		{-107120,-153008,-6752},
		{-108992,-154800,-6752},
		{-108064,-153008,-6752}
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
		for (L2PcInstance partyMember : party.getPartyMembers())
		{
			if (partyMember.getLevel() < 80)
			{
				SystemMessage sm = SystemMessage.getSystemMessage(2097);
				sm.addPcName(partyMember);
				party.broadcastToPartyMembers(sm);
				return false;
			}
			if (!Util.checkIfInRange(1000, player, partyMember, true))
			{
				SystemMessage sm = SystemMessage.getSystemMessage(2096);
				sm.addPcName(partyMember);
				party.broadcastToPartyMembers(sm);
				return false;
			}
			Long reentertime = InstanceManager.getInstance().getInstanceTime(partyMember.getObjectId(), INSTANCEID);
			if (System.currentTimeMillis() < reentertime)
			{
				SystemMessage sm = SystemMessage.getSystemMessage(2100);
				sm.addPcName(partyMember);
				party.broadcastToPartyMembers(sm);
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

	public void penalty(InstanceWorld world)
	{
		if (world instanceof CDWorld)
		{
			Calendar reenter = Calendar.getInstance();
			reenter.add(Calendar.MINUTE, RESET_MIN);
			reenter.add(Calendar.HOUR_OF_DAY, RESET_HOUR);
			SystemMessage sm = SystemMessage.getSystemMessage(SystemMessageId.INSTANT_ZONE_S1_RESTRICTED);
			sm.addString(InstanceManager.getInstance().getInstanceIdName(world.templateId));
			// set instance reenter time for all allowed players
			for (int objectId : world.allowed)
			{
				L2PcInstance player = L2World.getInstance().getPlayer(objectId);
				if (player != null && player.isOnline())
				{
					InstanceManager.getInstance().setInstanceTime(objectId, world.templateId, reenter.getTimeInMillis());
					player.sendPacket(sm);
				}
			}
		}
	}

	private void teleportrnd(L2PcInstance player)
	{
		tp = Rnd.get(TELEPORT.length);
		m = player.getParty().getMemberCount();
		if (tp == ROOM1 && r1 != m)
		{
			for (int i = 0; i < TELEPORT.length; i++)
			{
				if (i == tp)
				{
					for (L2PcInstance partyMember : player.getParty().getPartyMembers())
					{
						r1++;
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
		else if (tp == ROOM2 && r2 != m)
		{
			for (int i = 0; i < TELEPORT.length; i++)
			{
				if (i == tp)
				{
					for (L2PcInstance partyMember : player.getParty().getPartyMembers())
					{
						r2++;
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
		else if (tp == ROOM3 && r3 != m)
		{
			for (int i = 0; i < TELEPORT.length; i++)
			{
				if (i == tp)
				{
					for (L2PcInstance partyMember : player.getParty().getPartyMembers())
					{
						r3++;
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
		else if (tp == ROOM4 && r4 != m)
		{
			for (int i = 0; i < TELEPORT.length; i++)
			{
				if (i == tp)
				{
					for (L2PcInstance partyMember : player.getParty().getPartyMembers())
					{
						r4++;
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
		else if (tp == ROOM5 && r5 !=m)
		{
			for (int i = 0; i < TELEPORT.length; i++)
			{
				if (i == tp)
				{
					for (L2PcInstance partyMember : player.getParty().getPartyMembers())
					{
						r5++;
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
		else if (tp == ROOM6 && r6 != m)
		{
			for (int i = 0; i < TELEPORT.length; i++)
			{
				if (i == tp)
				{
					for (L2PcInstance partyMember : player.getParty().getPartyMembers())
					{
						r6++;
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
		else if (tp == ROOM7 && r7 != m)
		{
			for (int i = 0; i < TELEPORT.length; i++)
			{
				if (i == tp)
				{
					for (L2PcInstance partyMember : player.getParty().getPartyMembers())
					{
						r7++;
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
		else if (tp == ROOM8 && r8 != m)
		{
			for (int i = 0; i < TELEPORT.length; i++)
			{
				if (i == tp)
				{
					for (L2PcInstance partyMember : player.getParty().getPartyMembers())
					{
						r8++;
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
		world._aenkinel = addSpawn(AENKINEL,-108064,-154688,-6752,0,false,0,false,world.instanceId);
		world._aenkinel.setIsNoRndWalk(false);
		world.manager = addSpawn(32668,-108064,-154688,-6752,0,false,0,false,world.instanceId);
		world.manager.setIsNoRndWalk(true);
		world.managerb = addSpawn(32668,-108992,-152624,-6752,0,false,0,false,world.instanceId);
		world.managerb.setIsNoRndWalk(true);
		world.managerc = addSpawn(32668,-108992,-153504,-6752,0,false,0,false,world.instanceId);
		world.managerc.setIsNoRndWalk(true);
		world.managerd = addSpawn(32668,-107120,-154304,-6752,0,false,0,false,world.instanceId);
		world.managerd.setIsNoRndWalk(true);
		world.managere = addSpawn(32668,-107120,-155184,-6752,0,false,0,false,world.instanceId);
		world.managere.setIsNoRndWalk(true);
		world.managerf = addSpawn(32668,-108064,-151328,-6752,0,false,0,false,world.instanceId);
		world.managerf.setIsNoRndWalk(true);
		world.managerg = addSpawn(32668,-107120,-153008,-6752,0,false,0,false,world.instanceId);
		world.managerg.setIsNoRndWalk(true);
		world.managerh = addSpawn(32668,-108992,-154800,-6752,0,false,0,false,world.instanceId);
		world.managerh.setIsNoRndWalk(true);
		world.managera = addSpawn(32668,-108064,-153008,-6752,0,false,0,false,world.instanceId);
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
		instanceId = InstanceManager.getInstance().createDynamicInstance(template);
		world = new CDWorld();
		world.instanceId = instanceId;
		world.templateId = INSTANCEID;
		world.status = 0;
		InstanceManager.getInstance().addWorld(world);
		_log.info("Chamber Of Delusion started " + template + " Instance: " + instanceId + " created by player: " + player.getName());
		spawnState((CDWorld)world);
		instId = world.instanceId;
		for (L2PcInstance partyMember : player.getParty().getPartyMembers())
		{
			teleportrnd(partyMember);
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
	public String onAdvEvent (String event, L2Npc npc, L2PcInstance player)
	{
		InstanceManager.getInstance().getPlayerWorld(player);
		L2Party party = player.getParty();
		instId = player.getInstanceId();
		if (event.equalsIgnoreCase("tproom"))
		{
			for (L2PcInstance partyMember : party.getPartyMembers())
			{
				teleportrnd(partyMember);
			}
			startQuestTimer("tproom1",480000,null,player);
			h++;
		}
		else if (event.equalsIgnoreCase("tproom1"))
		{
			for (L2PcInstance partyMember : party.getPartyMembers())
			{
				teleportrnd(partyMember);
			}
			startQuestTimer("tproom2",480000,null,player);
			h++;
		}
		else if (event.equalsIgnoreCase("tproom2"))
		{
			for (L2PcInstance partyMember : party.getPartyMembers())
			{
				teleportrnd(partyMember);
			}
			startQuestTimer("tproom3",480000,null,player);
			h++;
		}
		else if (event.equalsIgnoreCase("tproom3"))
		{
			teleCoord tele = new teleCoord();
			tele.instanceId = player.getInstanceId();
			tele.x = -108064; 
			tele.y = -154688;
			tele.z = -6752;
			for (L2PcInstance partyMember :  player.getParty().getPartyMembers())
			{
				teleportplayer(partyMember,tele);
			}
		}
		else if ("7".equalsIgnoreCase(event))
		{
			if (g == 0)
			{
				if (h == 0)
				{
					cancelQuestTimers("tproom");
					for (L2PcInstance partyMember : party.getPartyMembers())
					{
						teleportrnd(partyMember);
					}
					startQuestTimer("tproom1",480000,null,player);
					g = 1;
				}
				else if (h == 1)
				{
					cancelQuestTimers("tproom1");
					for (L2PcInstance partyMember : party.getPartyMembers())
					{
						teleportrnd(partyMember);
					}
					startQuestTimer("tproom2",480000,null,player);
					g = 1;
				}
				else if (h == 2)
				{
					cancelQuestTimers("tproom2");
					for (L2PcInstance partyMember : party.getPartyMembers())
					{
						teleportrnd(partyMember);
					}
					startQuestTimer("tproom3",480000,null,player);
					g = 1;
				}
				else if (h == 3)
				{
					cancelQuestTimers("tproom3");
					teleCoord tele = new teleCoord();
					tele.instanceId = player.getInstanceId();
					tele.x = -108064; 
					tele.y = -154688;
					tele.z = -6752;
					for (L2PcInstance partyMember :  player.getParty().getPartyMembers())
					{
						teleportplayer(partyMember,tele);
						g = 1;
					}
				}
			}
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
			enterInstance(player,"ChamberofDelusionGreat.xml");
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
			penalty(world);
			for (L2PcInstance partyMember :  player.getParty().getPartyMembers())
			{
				exitInstance(partyMember,tele);
			}
		}
		return "";
	}

	public ChamberOfDelusionGreat(int questId, String name, String descr)
	{
		super(questId, name, descr);

		addStartNpc(GKSTART);
		addTalkId(GKSTART);
		addStartNpc(GKFINISH);
		addFirstTalkId(GKFINISH);
		addTalkId(GKFINISH);
		
	}

	public static void main(String[] args)
	{
		new ChamberOfDelusionGreat(-1,qn,"instances");
	}
}