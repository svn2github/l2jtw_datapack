/**
 * authors d0S
 */
package instances.SanctumOftheLordsOfDawn;

import com.l2jserver.gameserver.ai.CtrlIntention;
import com.l2jserver.gameserver.instancemanager.InstanceManager;
import com.l2jserver.gameserver.instancemanager.InstanceManager.InstanceWorld;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.L2World;
import com.l2jserver.gameserver.model.L2CharPosition;
import com.l2jserver.gameserver.model.actor.instance.L2DoorInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.*;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;

public class SanctumOftheLordsOfDawn extends Quest
{
	private class HSWorld extends InstanceWorld
	{
		public long[] storeTime = {0,0}; // 0: instance start, 1: finish time
		private L2Npc npc1f,npc2a,npc2b,npc2c,npc2d,npc5,npc6,npc7,npc8,npc9,npca,npcb,npc4e,npc4f,npc5a,npc5b,npc5c,npc5d,npc5e,npc5f,npc6a,npc6b;
		public HSWorld()
		{
			//InstanceManager.getInstance().super();
		}
	}

	private static final String qn = "SanctumOftheLordsOfDawn";
	private static final int INSTANCEID = 111; // this is the client number

	//NPCs
	private static final int LIGHTOFDAWN = 32575;  // 傳送師 黎明之光
	private static final int PWDEVICE    = 32577;  // 暗號輸入裝置
	private static final int DEVICE      = 32578;  // 身份確認裝置
	private static final int BLACK       = 32579;  // 傳送師 黎明的黑暗
	private static final int PRIESTS     = 18828;  // 黎明的上位祭司
	private static final int MGUARD      = 27348;  // 黎明的神諭處 警衛隊員
	private static final int MPRIEST     = 27349;  // 黎明的神諭處 警衛隊員
	private static final int WPRIEST     = 27350;  // 黎明的神諭處 警衛隊員
	private static final int WGUARD      = 27351;  // 黎明的警衛隊員
	private              int doorst      = 0;
	private static final int ONE         = 17240001;
	private static final int TWO         = 17240003;
	private static final int THREE       = 17240005;

	private static boolean noRndWalk = true;

	private static final L2CharPosition MOVE_TO_1  = new L2CharPosition(-76394, 207956, -7602, 0);
	private static final L2CharPosition MOVE_TO_2  = new L2CharPosition(-76420, 208409, -7602, 0);
	private static final L2CharPosition MOVE_TO_3  = new L2CharPosition(-76398, 208748, -7601, 0);
	private static final L2CharPosition MOVE_TO_4  = new L2CharPosition(-76894, 209401, -7601, 0);
	private static final L2CharPosition MOVE_TO_5  = new L2CharPosition(-77285, 209395, -7602, 0);
	private static final L2CharPosition MOVE_TO_6  = new L2CharPosition(-74950, 212475, -7312, 0);
	private static final L2CharPosition MOVE_TO_7  = new L2CharPosition(-75592, 211870, -7312, 0);
	private static final L2CharPosition MOVE_TO_8  = new L2CharPosition(-74266, 211863, -7312, 0);
	private static final L2CharPosition MOVE_TO_9  = new L2CharPosition(-75230, 211141, -7314, 0);
	private static final L2CharPosition MOVE_TO_10 = new L2CharPosition(-74671, 211139, -7314, 0);
	private static final L2CharPosition MOVE_TO_11 = new L2CharPosition(-74672, 210154, -7410, 0);
	private static final L2CharPosition MOVE_TO_12 = new L2CharPosition(-75243, 209826, -7410, 0);
	private static final L2CharPosition MOVE_TO_13 = new L2CharPosition(-76606, 207967, -7602, 0);
	private static final L2CharPosition MOVE_TO_14 = new L2CharPosition(-76603, 208409, -7602, 0);
	private static final L2CharPosition MOVE_TO_15 = new L2CharPosition(-76590, 208749, -7602, 0);
	private static final L2CharPosition MOVE_TO_16 = new L2CharPosition(-76891, 209223, -7601, 0);
	private static final L2CharPosition MOVE_TO_17 = new L2CharPosition(-77276, 209238, -7602, 0);
	private static final L2CharPosition MOVE_TO_18 = new L2CharPosition(-74949, 212300, -7312, 0);
	private static final L2CharPosition MOVE_TO_19 = new L2CharPosition(-75368, 211886, -7312, 0);
	private static final L2CharPosition MOVE_TO_20 = new L2CharPosition(-74549, 211689, -7315, 0);
	private static final L2CharPosition MOVE_TO_21 = new L2CharPosition(-75220, 211453, -7312, 0);
	private static final L2CharPosition MOVE_TO_22 = new L2CharPosition(-74717, 211457, -7315, 0);
	private static final L2CharPosition MOVE_TO_23 = new L2CharPosition(-75230, 210142, -7413, 0);
	private static final L2CharPosition MOVE_TO_24 = new L2CharPosition(-74653, 209824, -7410, 0);
	private static final L2CharPosition MOVE_TO_25 = new L2CharPosition(-75411, 207143, -7511, 0);
	private static final L2CharPosition MOVE_TO_26 = new L2CharPosition(-75658, 207144, -7511, 0);
	private static final L2CharPosition MOVE_TO_27 = new L2CharPosition(-75442, 207969, -7511, 0);
	private static final L2CharPosition MOVE_TO_28 = new L2CharPosition(-75667, 207955, -7511, 0);
	private static final L2CharPosition MOVE_TO_29 = new L2CharPosition(-78707, 206182, -7893, 0);
	private static final L2CharPosition MOVE_TO_30 = new L2CharPosition(-78832, 206084, -7893, 0);
	private static final L2CharPosition MOVE_TO_31 = new L2CharPosition(-79653, 206549, -7893, 0);
	private static final L2CharPosition MOVE_TO_32 = new L2CharPosition(-79547, 206401, -7893, 0);

	private class teleCoord {int instanceId; int x; int y; int z;}

	private void teleportplayer(L2PcInstance player, teleCoord teleto)
	{
		player.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
		player.setInstanceId(teleto.instanceId);
		player.teleToLocation(teleto.x, teleto.y, teleto.z);
		return;
	}

	protected void exitInstance(L2PcInstance player, teleCoord tele)
	{
		player.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
		player.setInstanceId(0);
		player.teleToLocation(tele.x, tele.y, tele.z);
	}

	public String onAdvEvent (String event, L2Npc npc, L2PcInstance player)
	{
		if (event.equalsIgnoreCase("Part1"))
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				world.npc1f.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_13);
				world.npc2a.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_14); 
				world.npc2b.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_15);
				world.npc2c.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_16);
				world.npc2d.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_17);
				world.npc5.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_18);
				world.npc6.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_19);
				world.npc7.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_20);
				world.npc8.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_21);
				world.npc9.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_22);
				world.npca.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_23);
				world.npcb.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_24);
				world.npc4e.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_25);
				world.npc4f.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_27);
				world.npc5a.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_29);
				world.npc5b.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_31);
				startQuestTimer("Part2",3000, world.npc1f,null);
			}
		}
		else if (event.equalsIgnoreCase("Part2"))
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				world.npc1f.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_1);
				world.npc2a.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_2);
				world.npc2b.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_3);
				world.npc2c.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_4);
				world.npc2d.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_5);
				world.npc5.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_6);
				world.npc6.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_7);
				world.npc7.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_8);
				world.npc8.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_9);
				world.npc9.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_10);
				world.npca.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_11);
				world.npcb.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_12);
				world.npc4e.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_26);
				world.npc4f.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_28);
				world.npc5a.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_30);
				world.npc5b.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,MOVE_TO_32);
				startQuestTimer("Part1",3000,world.npc1f,null);
			}
		}
		else if (event.equalsIgnoreCase("Part3"))
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				world.npc5c = addSpawn(PRIESTS, -79361, 206020, -7903, 0, false, 0, false, world.instanceId);
				if (noRndWalk)
					world.npc5c.setIsNoRndWalk(true);
				world.npc5d = addSpawn(PRIESTS, -79501, 205936, -7905, 0, false, 0, false, world.instanceId);
				if (noRndWalk)
					world.npc5d.setIsNoRndWalk(true);
				world.npc5e = addSpawn(PRIESTS, -79500, 205774, -7909, 0, false, 0, false, world.instanceId);
				if (noRndWalk)
					world.npc5e.setIsNoRndWalk(true);
				world.npc5f = addSpawn(PRIESTS, -79359, 205696, -7905, 0, false, 0, false, world.instanceId);
				if (noRndWalk)
					world.npc5f.setIsNoRndWalk(true);
				world.npc6a = addSpawn(PRIESTS, -79213, 205770, -7903, 0, false, 0, false, world.instanceId);
				if (noRndWalk)
					world.npc6a.setIsNoRndWalk(true);
				world.npc6b = addSpawn(PRIESTS, -79214, 205940, -7903, 0, false, 0, false, world.instanceId);
				if (noRndWalk)
					world.npc6b.setIsNoRndWalk(true);
			}
		}
		else if (event.equalsIgnoreCase("Part4"))
		{
			doorst = 0;
		}
		else if (event.equalsIgnoreCase("Part5"))
		{
			doorst++;
		}
		return "";
	}

	protected int enterInstance(L2PcInstance player, String template, teleCoord teleto)
	{
		int instanceId = 0;
		//check for existing instances for this player
		InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
		//existing instance
		if (world != null)
		{
			if (!(world instanceof HSWorld))
			{
				player.sendPacket(new SystemMessage(SystemMessageId.ALREADY_ENTERED_ANOTHER_INSTANCE_CANT_ENTER));
				return 0;
			}
			teleto.instanceId = world.instanceId;
			teleportplayer(player,teleto);
			return instanceId;
		}
		//New instance
		else
		{
			instanceId = InstanceManager.getInstance().createDynamicInstance(template);
			world = new HSWorld();
			world.instanceId = instanceId;
			world.templateId = INSTANCEID;
			world.status = 0;
			((HSWorld)world).storeTime[0] = System.currentTimeMillis();
			InstanceManager.getInstance().addWorld(world);
			spawnState((HSWorld)world);
			_log.info("SevenSign started " + template + " Instance: " + instanceId + " created by player: " + player.getName());
			// teleport players
			teleto.instanceId = instanceId;
			teleportplayer(player,teleto);
			world.allowed.add(player.getObjectId());
			return instanceId;
		}
	}

	private void sendScreenMessage(HSWorld world, ExShowScreenMessage message)
	{
		for(int objId : world.allowed)
		{
			L2PcInstance player = L2World.getInstance().getPlayer(objId);
			if (player != null)
				player.sendPacket(message);
		}
	}

	protected void spawnState(HSWorld world)
	{
		L2Npc npc = addSpawn(DEVICE, -75710, 213535, -7126, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc.setIsNoRndWalk(true);
		L2Npc npc1 = addSpawn(DEVICE, -78355, 205781, -7892, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc1.setIsNoRndWalk(true);
		L2Npc npc2 = addSpawn(PWDEVICE, -80133, 205743, -7888, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc2.setIsNoRndWalk(true);
		L2Npc npc3 = addSpawn(32580, -81386, 205562, -7992, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc3.setIsNoRndWalk(true);
		L2Npc npc4 = addSpawn(BLACK, -76003, 213413, -7124, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc4.setIsNoRndWalk(true);
		world.npc5 = addSpawn(MPRIEST, -74949, 212300, -7312, 0, false, 0, false, world.instanceId);
		world.npc6 = addSpawn(MPRIEST, -75368, 211886, -7312, 0, false, 0, false, world.instanceId);
		world.npc7 = addSpawn(MPRIEST, -74549, 211689, -7315, 0, false, 0, false, world.instanceId);
		world.npc8 = addSpawn(MPRIEST, -75220, 211453, -7312, 0, false, 0, false, world.instanceId);
		world.npc9 = addSpawn(MPRIEST, -74717, 211457, -7315, 0, false, 0, false, world.instanceId);
		world.npca = addSpawn(MGUARD, -75230, 210142, -7413, 0, false, 0, false, world.instanceId);
		world.npcb = addSpawn(MGUARD, -74653, 209824, -7410, 0, false, 0, false, world.instanceId);
		L2Npc npcc = addSpawn(27347, -74948, 213468, -7218, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npcc.setIsNoRndWalk(true);
		L2Npc npcd = addSpawn(WPRIEST, -74948, 211869, -7314, 0, false, 0, false, world.instanceId); //
		if (noRndWalk)
			npcd.setIsNoRndWalk(true);
		L2Npc npce = addSpawn(WGUARD, -75329, 209990, -7412, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npce.setIsNoRndWalk(true);
		L2Npc npcf = addSpawn(WGUARD, -74568, 209981, -7410, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npcf.setIsNoRndWalk(true);
		L2Npc npc1a = addSpawn(WGUARD, -74279, 208794, -7506, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc1a.setIsNoRndWalk(true);
		L2Npc npc1b = addSpawn(WGUARD, -75638, 208763, -7506, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc1b.setIsNoRndWalk(true);
		L2Npc npc1c = addSpawn(WGUARD, -74959, 207618, -7506, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc1c.setIsNoRndWalk(true);
		L2Npc npc1d = addSpawn(WGUARD, -73877, 206617, -7506, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc1d.setIsNoRndWalk(true);
		L2Npc npc1e = addSpawn(WGUARD, -74526, 206618, -7506, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc1e.setIsNoRndWalk(true);
		world.npc1f = addSpawn(MGUARD, -76606, 207967, -7602, 0, false, 0, false, world.instanceId);
		world.npc2a = addSpawn(MGUARD, -76603, 208409, -7602, 0, false, 0, false, world.instanceId);
		world.npc2b = addSpawn(MGUARD, -76590, 208749, -7602, 0, false, 0, false, world.instanceId);
		world.npc2c = addSpawn(MGUARD, -76891, 209223, -7601, 0, false, 0, false, world.instanceId);
		world.npc2d = addSpawn(MGUARD, -77276, 209238, -7602, 0, false, 0, false, world.instanceId);
		L2Npc npc2e = addSpawn(WGUARD, -77703, 208112, -7696, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc2e.setIsNoRndWalk(true);
		L2Npc npc2f = addSpawn(WGUARD, -77705, 207457, -7696, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc2f.setIsNoRndWalk(true);
		L2Npc npc3a = addSpawn(WPRIEST, -78258, 207303, -7698, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc3a.setIsNoRndWalk(true);
		L2Npc npc3b = addSpawn(WPRIEST, -77129, 207269, -7698, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc3b.setIsNoRndWalk(true);
		L2Npc npc3c = addSpawn(WPRIEST, -77131, 208328, -7698, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc3c.setIsNoRndWalk(true);
		L2Npc npc3d = addSpawn(WPRIEST, -78196, 208337, -7698, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc3d.setIsNoRndWalk(true);
		L2Npc npc3e = addSpawn(WPRIEST, -78947, 206257, -7893, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc3e.setIsNoRndWalk(true);
		L2Npc npc3f = addSpawn(WPRIEST, -79364, 206453, -7893, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc3f.setIsNoRndWalk(true);
		L2Npc npc4a = addSpawn(WPRIEST, -79782, 206287, -7893, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc4a.setIsNoRndWalk(true);
		L2Npc npc4b = addSpawn(WPRIEST, -79791, 205431, -7893, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc4b.setIsNoRndWalk(true);
		L2Npc npc4c = addSpawn(WPRIEST, -79358, 205244, -7893, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc4c.setIsNoRndWalk(true);
		L2Npc npc4d = addSpawn(WPRIEST, -78934, 205430, -7893, 0, false, 0, false, world.instanceId);
		if (noRndWalk)
			npc4d.setIsNoRndWalk(true);
		world.npc4e = addSpawn(MGUARD, -75411, 207143, -7511, 0, false, 0, false, world.instanceId);
		world.npc4f = addSpawn(MGUARD, -75442, 207969, -7511, 0, false, 0, false, world.instanceId);
		world.npc5a = addSpawn(MGUARD, -78707, 206182, -7893, 0, false, 0, false, world.instanceId);
		world.npc5b = addSpawn(MGUARD, -79653, 206549, -7893, 0, false, 0, false, world.instanceId);
		startQuestTimer("Part2",3000,world.npc1f,null);
	}

	protected void openDoor(int doorId,int instanceId)
	{
		for (L2DoorInstance door : InstanceManager.getInstance().getInstance(instanceId).getDoors())
			if (door.getDoorId() == doorId)
				door.openMe();
	} 

	public String onTalk ( L2Npc npc, L2PcInstance player)
	{
		String htmltext = "";
		int npcId = npc.getNpcId();
		QuestState st = player.getQuestState(qn);
		if (st == null)
			st = newQuestState(player);
		if (npcId == LIGHTOFDAWN)
		{
			if (!player.isTransformed())
			{
				return "<html><body>傳送師 黎明之光：<br>好像從發著藍色光芒的球體中，聽到人的聲音。<br>「...您 不 是 得 到 黎 明 允 許 的 人。此 地 是 得 到 黎 明 允 許 者...<br>也 就 是，僅 限 <font color=\"LEVEL\">擁 有 黎 明 身 分 證 的 黎 明 警 衛 隊 員</font> 進 出 的 地 方...」</body></html>";
			}
			else if (player.getTransformation().getId() != 6204)
			{
				teleCoord tele = new teleCoord();
				tele.x = -76156;
				tele.y = 213409;
				tele.z = -7120;
				enterInstance(player, "SanctumoftheLordsofDawn.xml", tele);
				return "<html><body>傳送師 黎明之光：<br>好像從發著藍色光芒的球體中，聽到人的聲音。<br>「...您 是 得 到 黎 明 允 許 的 人。即 將 會 移 動 到 內 部...」</body></html>";
			}
		}
		else if (npcId == DEVICE)
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				if (doorst == 0)
				{
					openDoor(ONE,world.instanceId);
					startQuestTimer("Part5",60000,null,null);
					ExShowScreenMessage message1 = new ExShowScreenMessage(1,0,2,0,0,0,0,false,10000,1,"使用警衛隊員的隱身技能後，潛入黎明的文件儲藏室內！");  //(黃色字體)
					sendScreenMessage(world, message1);
					player.sendMessage("使用警衛隊員的隱身技能後，潛入到黎明的文件儲藏室內！男性警衛隊員可以察覺隱身，而女性警衛隊員無法察覺隱身。");  //(黃色字體)
					player.sendMessage("女性警衛隊員比男性警衛隊員可以在更遠的地方就能察覺到變身術，所以要非常小心。"); //(黃色字體)
					return "<html><body>身份確認裝置：<br>您 的 身 分 已 確 認 完 畢，<br>門 即 將 開 啟。</body></html>";
				}
				else if (doorst >= 1)
				{
					openDoor(TWO,world.instanceId);
					for(int objId : world.allowed)
					{
						L2PcInstance pl = L2World.getInstance().getPlayer(objId);
						if (pl != null)
							pl.showQuestMovie(11);
							startQuestTimer("Part4",30000,null,player);
					}
					startQuestTimer("Part3",30000,world.npc1f,null);
				}
			}
		}
		else if (npcId == PWDEVICE)
		{
			InstanceWorld tmworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmworld;
				openDoor(THREE,world.instanceId);
			}
		}
		else if (npcId == BLACK)
		{
			InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
			world.allowed.remove(world.allowed.indexOf(player.getObjectId()));
			teleCoord tele = new teleCoord();
			tele.instanceId = 0;
			tele.x = -12585;
			tele.y = 122305;
			tele.z = -2989;
			exitInstance(player,tele);
			return "<html><body>傳送師 黎明之光：<br>好像從發著藍色光芒的球體中，聽到人的聲音。<br>「...您 是 得 到 黎 明 允 許 的 人。即 將 會 移 動 到 外 部...」</body></html>";
		}
		return htmltext;
	}

	public String onAggroRangeEnter(L2Npc npc, L2PcInstance player, boolean isPet)
	{
		if (isPet == false && player != null)
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(player.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				int npcId = npc.getNpcId();
				if (npcId == MPRIEST || npcId == MGUARD || npcId == WGUARD || npcId == WPRIEST)
				{
					for(int objId : world.allowed)
					{
						L2PcInstance pl = L2World.getInstance().getPlayer(objId);
						if (pl != null)
							//pl.teleToLocation(-77708, 205854, -7806);
							pl.teleToLocation(-75782, 213410, -7125);
					}
				}
				return "";
			}
		}
		//return "";
		return super.onAggroRangeEnter(npc, player, isPet);
	}

	public SanctumOftheLordsOfDawn(int questId, String name, String descr)
	{
		super(questId, name, descr);

		addStartNpc(LIGHTOFDAWN);
		addTalkId(LIGHTOFDAWN);
		addTalkId(DEVICE);
		addTalkId(PWDEVICE);
		addTalkId(BLACK);
		addAggroRangeEnterId(MPRIEST);
		addAggroRangeEnterId(MGUARD);
		addAggroRangeEnterId(WPRIEST);
		addAggroRangeEnterId(WGUARD);
	}

	public static void main(String[] args)
	{
		// now call the constructor (starts up the)
		new SanctumOftheLordsOfDawn(-1,qn,"instances");
	}
}