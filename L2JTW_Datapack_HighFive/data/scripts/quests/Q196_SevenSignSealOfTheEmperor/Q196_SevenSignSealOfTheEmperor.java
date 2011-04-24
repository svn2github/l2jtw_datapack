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
package quests.Q196_SevenSignSealOfTheEmperor;

import javolution.util.FastList;
import javolution.util.FastMap;

import com.l2jserver.gameserver.ai.CtrlIntention;
import com.l2jserver.gameserver.instancemanager.InstanceManager;
import com.l2jserver.gameserver.instancemanager.InstanceManager.InstanceWorld;
//import com.l2jserver.gameserver.model.actor.L2Attackable;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2DoorInstance;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.entity.Instance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.model.quest.State;
import com.l2jserver.gameserver.network.SystemMessageId;
//import com.l2jserver.gameserver.network.serverpackets.MagicSkillUse;
import com.l2jserver.gameserver.network.serverpackets.NpcSay;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;


/**
 * update pmq 23-04-2011
 *
 */
public class Q196_SevenSignSealOfTheEmperor extends Quest
{
	private static class SIGNSNpc
	{
		public L2Npc npc;
		public boolean isDead = false;
	}
	
	private static class SIGNSRoom
	{
		public FastList<SIGNSNpc> npcList = new FastList<SIGNSNpc>();
	}
	
	private class SIGNSWorld extends InstanceWorld
	{
		public FastMap<String,SIGNSRoom> rooms = new FastMap<String,SIGNSRoom>();
		public long[] storeTime = { 0, 0 };
		
		public SIGNSWorld()
		{
		}
	}
	
	private static boolean debug = false;
	private static boolean noRndWalk = true;

	public static final String qn = "196_SevenSignSealOfTheEmperor";
	private static final int INSTANCE_ID       = 112;

	// NPCs
	private static final int HEINE             = 30969;  // 艾森海內
	private static final int MAMMON            = 32584;  // 財富的商人
	private static final int SHUNAIMAN         = 32586;  // 艾爾摩亞丁皇帝 史奈曼
	private static final int MAGICAN           = 32598;  // 艾爾摩亞丁 宮廷魔法師
	private static final int WOOD              = 32593;  // 神官 巫德
	private static final int LEON              = 32587;  // 皇帝警衛 萊溫
	private static final int PROMICE_OF_MAMMON = 32585;  // 傳送師 財富的約定
	private static final int DISCIPLES_GK      = 32657;  // 使徒的守門人

	//FIGHTING NPCS
	private static final int LILITH        = 32715;  // 深淵的聖母 莉莉絲
	private static final int LILITH_GUARD0 = 32716;  // 莉莉絲的代言者
	private static final int LILITH_GUARD1 = 32717;  // 莉莉絲的親衛隊
	private static final int ANAKIM        = 32718;  // 聖火的火花 亞納
	private static final int ANAKIM_GUARD0 = 32719;  // 亞納的守護者
	private static final int ANAKIM_GUARD1 = 32720;  // 亞納的禁衛隊
	private static final int ANAKIM_GUARD2 = 32721;  // 亞納的執行者

	//DOOR
	//private static final int DOOR1  = 17240101; /** 第一房間門要用聖水開啟 */
	private static final int DOOR2  = 17240102; /** 第一房間怪全滅自動開門 */
	//private static final int DOOR3  = 17240103; /** 第二房間門要用魔法棒開啟 */
	private static final int DOOR4  = 17240104; /** 第二房間怪全滅自動開門 */
	//private static final int DOOR5  = 17240105; /** 第三房間門要用聖水開啟 */
	private static final int DOOR6  = 17240106; /** 第三房間怪全滅自動開門 */
	//private static final int DOOR7  = 17240107; /** 第四房間門要用魔法棒開啟 */
	private static final int DOOR8  = 17240108; /** 第四房間怪全滅自動開門 */
	//private static final int DOOR9  = 17240109; /** 第五房間門要用聖水開啟 */
	private static final int DOOR10 = 17240110; /** 第五房間怪全滅自動開門 */
	private static final int DOOR = 17240111;
	// INSTANCE TP
	private static final int[] TELEPORT = { -89559, 216030, -7488 };

	private static final int[] NPCS = { HEINE, WOOD, MAMMON, MAGICAN, SHUNAIMAN, LEON, PROMICE_OF_MAMMON, DISCIPLES_GK };

	// MOBs
	private static final int SEALDEVICE = 27384;  // 史奈曼皇帝的 封印裝置
	private static int[] TOKILL = {27371,27372,27373,27374,27375,27377,27378,27379,27384};

	// QUEST ITEMS
	private static final int WATER = 13808;  // 艾爾摩亞丁的聖水
	private static final int SWORD = 15310;  // 殷海薩聖劍
	private static final int SEAL  = 13846;  // 封印的印章
	private static final int STAFF = 13809;  // 宮廷魔法師的魔法棒

	private int mammonst = 0;
	
	protected void runStartRoom(SIGNSWorld world)
	{
		world.status = 0;
		SIGNSRoom StartRoom = new SIGNSRoom();
		SIGNSNpc thisnpc;
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(SHUNAIMAN, -89456, 216184, -7504, 40960, false, 0, false, world.instanceId);
		StartRoom.npcList.add(thisnpc);
		
		thisnpc.npc = addSpawn(LEON, -89400, 216125, -7504, 40960, false, 0, false, world.instanceId);
		StartRoom.npcList.add(thisnpc);
		
		thisnpc.npc = addSpawn(DISCIPLES_GK, -84389, 216038, -7490, 0, false, 0, false, world.instanceId);
		StartRoom.npcList.add(thisnpc);
		
		world.rooms.put("StartRoom", StartRoom);
		if (debug)
			_log.info("SevenSignSealOfTheEmperor: first room spawned in instance " + world.instanceId);
	}
	
/**
Room1 Mobs
27371
27372
27373
27374

*/
	protected void runFirstRoom(SIGNSWorld world)
	{
		SIGNSRoom FirstRoom = new SIGNSRoom();
		SIGNSNpc thisnpc;
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27371,0,0,0,0,false,0,false, world.instanceId);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		FirstRoom.npcList.add(thisnpc);
		
		world.rooms.put("FirstRoom", FirstRoom);
		world.status = 1;
		openDoor(DOOR2, world.instanceId);
		if (debug)
			_log.info("SevenSignSealOfTheEmperor: spawned First room");
	}
	
/**
Room2 Mobs
27371
27371
27372
27373
27373
27374
*/
	protected void runSecondRoom(SIGNSWorld world)
	{
		SIGNSRoom SecondRoom = new SIGNSRoom();
		SIGNSNpc thisnpc;
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27371,0,0,0,0,false,0,false, world.instanceId);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		SecondRoom.npcList.add(thisnpc);
		
		world.rooms.put("SecondRoom", SecondRoom);
		world.status = 2;
		openDoor(DOOR4, world.instanceId);
		if (debug)
			_log.info("SevenSignSealOfTheEmperor: spawned second room");
	}
	
/**
Room3 Mobs
27371
27371
27372
27372
27373
27373
27374
27374
*/
	protected void runThirdRoom(SIGNSWorld world)
	{
		SIGNSRoom ThirdRoom = new SIGNSRoom();
		SIGNSNpc thisnpc;
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27371,0,0,0,0,false,0,false, world.instanceId);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		ThirdRoom .npcList.add(thisnpc);
		
		world.rooms.put("ThirdRoom", ThirdRoom);
		world.status = 3;
		openDoor(DOOR6, world.instanceId);
		if (debug)
			_log.info("SevenSignSealOfTheEmperor: spawned Third room");
	}
	
/**
Room4 Mobs
27371
27372
27373
27374
27375
27377
27378
27379
*/
	protected void runForthRoom(SIGNSWorld world)
	{
		SIGNSRoom ForthRoom = new SIGNSRoom();
		SIGNSNpc thisnpc;
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27371,0,0,0,0,false,0,false, world.instanceId);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		ForthRoom.npcList.add(thisnpc);
		
		world.rooms.put("ForthRoom", ForthRoom);
		world.status = 4;
		openDoor(DOOR8, world.instanceId);
		if (debug)
			_log.info("SevenSignSealOfTheEmperor: spawned Forth room");
	}
	
/**
Room5 Mobs
27371
27372
27373
27374
27375
27375
27377
27377
27378
27378
27379
27379
*/
	protected void runFifthRoom(SIGNSWorld world)
	{
		SIGNSRoom FifthRoom = new SIGNSRoom();
		SIGNSNpc thisnpc;
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27371,0,0,0,0,false,0,false, world.instanceId);
		FifthRoom.npcList.add(thisnpc);
		
		world.rooms.put("FifthRoom", FifthRoom);
		world.status = 5;
		openDoor(DOOR10, world.instanceId);
		if (debug)
			_log.info("SevenSignSealOfTheEmperor: spawned Fifth room");
	}
	
	protected void runBossRoom(SIGNSWorld world)
	{
		SIGNSRoom BossRoom = new SIGNSRoom();
		SIGNSNpc thisnpc;
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(LILITH, -83175, 217021, -7504, 0, false, 0, false, world.instanceId);
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc.npc = addSpawn(LILITH_GUARD0, -83127, 217056, -7504, 0, false, 0, false, world.instanceId);
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc.npc = addSpawn(LILITH_GUARD1, -83222, 217055, -7504, 0, false, 0, false, world.instanceId);
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc.npc = addSpawn(ANAKIM, -83179, 216479, -7504, 0, false, 0, false, world.instanceId);
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc.npc = addSpawn(ANAKIM_GUARD0, -83227, 216443, -7504, 0, false, 0, false, world.instanceId);
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc.npc = addSpawn(ANAKIM_GUARD1, -83134, 216443, -7504, 0, false, 0, false, world.instanceId);
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc.npc = addSpawn(ANAKIM_GUARD2, -83179, 216432, -7504, 0, false, 0, false, world.instanceId);
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc.npc = addSpawn(SEALDEVICE, -83177, 217353, -7520, 32768, false, 0, false, world.instanceId);
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc.npc = addSpawn(SEALDEVICE, -83177, 216137, -7520, 32768, false, 0, false, world.instanceId);
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc.npc = addSpawn(SEALDEVICE, -82588, 216754, -7520, 32768, false, 0, false, world.instanceId);
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc.npc = addSpawn(SEALDEVICE, -83804, 216754, -7520, 32768, false, 0, false, world.instanceId);
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		//thisnpc.npc = addSpawn(32592, 0, 0, 0, 0, false, 0, false, world.instanceId);
		//BossRoom.npcList.add(thisnpc);
		//if (noRndWalk)
			//thisnpc.npc.setIsNoRndWalk(true);
		
		world.rooms.put("BossRoom", BossRoom);
		world.status = 6;
		if (debug)
			_log.info("SevenSignSealOfTheEmperor: spawned Boss room");
	}
	
	protected boolean checkKillProgress(L2Npc npc, SIGNSRoom room)
	{
		boolean cont = true;
		for (SIGNSNpc npcobj : room.npcList)
		{
			if (npcobj.npc == npc)
				npcobj.isDead = true;
			if (npcobj.isDead == false)
				cont = false;
		}
		
		return cont;
	}
	

	public Q196_SevenSignSealOfTheEmperor(int questId, String name, String descr)
	{
		super(questId, name, descr);

		addStartNpc(HEINE);
		addStartNpc(PROMICE_OF_MAMMON);

		for (int i : NPCS)
			addTalkId(i);

		for (int mob : TOKILL )
			addKillId(mob);

		questItemIds = new int[]
		{ SWORD, WATER, SEAL, STAFF };
	}

	private static final void teleportPlayer(L2PcInstance player, int[] coords, int instanceId)
	{
		player.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
		player.setInstanceId(instanceId);
		player.teleToLocation(coords[0], coords[1], coords[2], true);
	}

	private static final void openDoor(int doorId, int instanceId)
	{
		for (L2DoorInstance door : InstanceManager.getInstance().getInstance(instanceId).getDoors())
			if (door.getDoorId() == doorId)
				door.openMe();
	}

	private final synchronized void enterInstance(L2PcInstance player)
	{
		InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
		if (world != null)
		{
			if (world.templateId != INSTANCE_ID)
			{
				player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.ALREADY_ENTERED_ANOTHER_INSTANCE_CANT_ENTER));
				return;
			}
			Instance inst = InstanceManager.getInstance().getInstance(world.instanceId);
			if (inst != null)
				teleportPlayer(player, TELEPORT, world.instanceId);
			return;
		}
		else
		{
			final int instanceId = InstanceManager.getInstance().createDynamicInstance("SanctumSealOfTheEmperor.xml");

			world = new SIGNSWorld();
			world.instanceId = instanceId;
			world.templateId = INSTANCE_ID;
			InstanceManager.getInstance().addWorld(world);
			((SIGNSWorld) world).storeTime[0] = System.currentTimeMillis();
			runStartRoom((SIGNSWorld) world);
			world.allowed.add(player.getObjectId());
			teleportPlayer(player, TELEPORT, instanceId);

			_log.info("SevenSigns 5th epic quest " + instanceId + " created by player: " + player.getName());
		}
	}

	protected void exitInstance(L2PcInstance player)
	{
		player.setInstanceId(0);
		player.teleToLocation(171782, -17612, -4901);
	}

	@Override
	public final String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		QuestState st = player.getQuestState(qn);

		if (st == null)
			return "<html><body>目前沒有執行任務，或條件不符。</body></html>";

		if (event.equalsIgnoreCase("30969-05.htm"))
		{
			st.set("cond", "1");
			st.setState(State.STARTED);
			st.playSound("ItemSound.quest_accept");
		}
		else if (event.equalsIgnoreCase("32598-02.htm"))
		{
			st.giveItems(STAFF, 1);
			st.playSound("ItemSound.quest_middle");
		}
		else if (event.equalsIgnoreCase("30969-11.htm"))
		{
			st.set("cond", "6");
			st.playSound("ItemSound.quest_middle");

		}
		else if (event.equalsIgnoreCase("32584-05.htm"))
		{
			st.set("cond", "2");
			st.playSound("ItemSound.quest_middle");
			npc.deleteMe();
		}
		else if (event.equalsIgnoreCase("32586-06.htm"))
		{
			st.playSound("ItemSound.quest_middle");
			st.set("cond", "4");
			st.giveItems(SWORD, 1);
			st.giveItems(WATER, 1);
		}
		else if (event.equalsIgnoreCase("32586-12.htm"))
		{
			st.playSound("ItemSound.quest_middle");
			st.set("cond", "5");
			st.takeItems(SEAL, 4);
			st.takeItems(SWORD, 1);
			st.takeItems(WATER, 1);
			st.takeItems(STAFF, 1);
		}
		else if (event.equalsIgnoreCase("32593-02.htm"))
		{
			st.addExpAndSp(52518015, 5817676);
			//st.addExpAndSp(25000000, 2500000); // High Five
			st.setState(State.COMPLETED);
			st.exitQuest(false);
			st.playSound("ItemSound.quest_finish");
		}
		else if (event.equalsIgnoreCase("30969-06.htm"))
		{
			if (mammonst == 0)
			{
				mammonst = 1;
				L2Npc mammon = addSpawn(MAMMON, 109742, 219978, -3520, 0, false, 120000, true);
				mammon.broadcastPacket(new NpcSay(mammon.getObjectId(), 0, mammon.getNpcId(), "誰...是誰召喚我財富的商人啊..."));
				st.startQuestTimer("despawn", 120000, mammon);
			}
			else
				return "<html><body>艾森海內：<br>現在我可沒有跟你閒聊的時間！！！<br>（其他的玩家正在進行對話。）</body></html>";
		}
		else if (event.equalsIgnoreCase("despawn"))
		{
			mammonst = 0;
			npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), "與皇帝之間的長久約定終於達成了..."));
			return null;
		}
		else if (event.equalsIgnoreCase("DOORS"))
		{
			InstanceWorld tempworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tempworld instanceof SIGNSWorld)
			{
				SIGNSWorld world = (SIGNSWorld) tempworld;
				openDoor(DOOR, world.instanceId);
				player.showQuestMovie(12);
			}
		}
		return event;
	}

	@Override
	public final String onTalk(L2Npc npc, L2PcInstance player)
	{
		final QuestState st = player.getQuestState(qn);
		final QuestState qs = player.getQuestState("195_SevenSignSecretRitualOfThePriests");

		if (st == null)
			return "<html><body>目前沒有執行任務，或條件不符。</body></html>";
		final int cond = st.getInt("cond");

		switch (npc.getNpcId())
		{
			case HEINE:
				switch (st.getState())
				{
					case State.CREATED:
						if (cond == 0 && player.getLevel() >= 79 && qs.getState() == State.COMPLETED)
							return "30969-01.htm";
						else
							st.exitQuest(true);
							return "30969-00.htm";
					case State.STARTED:
						switch (st.getInt("cond"))
						{
							case 1:
								return "30969-05.htm";
							case 2:
								st.set("cond", "3");
								st.playSound("ItemSound.quest_middle");
								return "30969-07.htm";
							case 3:
								return "30969-08.htm";
							case 4:
								return "30969-08.htm";
							case 5:
								return "30969-09.htm";
							case 6:
								return "30969-12.htm";
						}
					case State.COMPLETED:
						return "<html><body>這是已經完成的任務。</body></html>";
				}
			case WOOD:
				if (cond == 6)
					return "32593-01.htm";
			case MAMMON:
				switch (st.getInt("cond"))
				{
					case 1:
						return "32584-01.htm";
				}
			case PROMICE_OF_MAMMON:
				switch (st.getInt("cond"))
				{
					case 0:
						return null;
					case 1:
						return null;
					case 2:
						return null;
					case 3:
						enterInstance(player);
						return null;
					case 4:
						enterInstance(player);
						return null;
					case 5:
						return null;
					case 6:
						return null;
				}
			case MAGICAN:
				switch (st.getInt("cond"))
				{
					case 4:
						if (st.getQuestItemsCount(STAFF) == 0)
							return "32598-01.htm";
						else if (st.getQuestItemsCount(STAFF) >= 1)
							return "32598-03.htm";
				}
			case SHUNAIMAN:
				switch (st.getInt("cond"))
				{
					case 3:
						return "32586-01.htm";
					case 4:
						if (st.getQuestItemsCount(SEAL) <= 3)
							return "32586-07.htm";
						else if (st.getQuestItemsCount(SEAL) == 4)
							return "32586-08.htm";
					case 5:
						return "32586-13.htm";
				}
			case DISCIPLES_GK:
				switch (st.getInt("cond"))
				{
					case 4:
						return "32657-01.htm";
				}
			case LEON:
				switch (st.getInt("cond"))
				{
					case 3:
						exitInstance(player);
						return "32587-02.htm";
					case 4:
						exitInstance(player);
						return "32587-02.htm";
					case 5:
						exitInstance(player);
						return "32587-02.htm";
				}

		}
		return "<html><body>目前沒有執行任務，或條件不符。</body></html>";
	}

	@Override
	public final String onKill(L2Npc npc, L2PcInstance player, boolean isPet)
	{
		QuestState st = player.getQuestState(qn);

		if (st == null)
			return null;

		if (npc.getNpcId() == SEALDEVICE)
		{
			if (st.getQuestItemsCount(SEAL) < 3)
			{
				st.playSound("ItemSound.quest_itemget");
				st.giveItems(SEAL, 1);
			}
			else
			{
				st.giveItems(SEAL, 1);
				//player.teleToLocation(-89528, 216056, -7516);
				st.playSound("ItemSound.quest_middle");
				player.showQuestMovie(13);

			}
		}
		InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
		SIGNSWorld world;
		if (tmpworld instanceof SIGNSWorld)
		{
			world = (SIGNSWorld)tmpworld;
			if (world.status == 0)
			{
				if (checkKillProgress(npc, world.rooms.get("FirstRoom")))
					runSecondRoom(world);
			}
			if (world.status == 1)
			{
				if (checkKillProgress(npc,world.rooms.get("SecondRoom")))
					runThirdRoom(world);
			}
			if (world.status == 2)
			{
				if (checkKillProgress(npc,world.rooms.get("ThirdRoom")))
					runForthRoom(world);
			}
			if (world.status == 3)
			{
				if (checkKillProgress(npc,world.rooms.get("ForthRoom")))
					runFifthRoom(world);
			}
			if (world.status == 4)
			{
				if (checkKillProgress(npc,world.rooms.get("FifthRoom")))
					runFifthRoom(world);
			}
		}
		return null;
	}

	public static void main(String[] args)
	{
		new Q196_SevenSignSealOfTheEmperor(196, qn, "七封印，皇帝的封印");
	}
}