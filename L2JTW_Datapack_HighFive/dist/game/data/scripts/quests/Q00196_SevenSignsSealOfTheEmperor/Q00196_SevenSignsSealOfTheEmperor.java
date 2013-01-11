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
package quests.Q00196_SevenSignsSealOfTheEmperor;

import quests.Q00195_SevenSignsSecretRitualOfThePriests.Q00195_SevenSignsSecretRitualOfThePriests;
import javolution.util.FastList;
import javolution.util.FastMap;

import com.l2jserver.gameserver.ai.CtrlIntention;
import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.instancemanager.InstanceManager;
import com.l2jserver.gameserver.model.actor.L2Attackable;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.effects.L2Effect;
import com.l2jserver.gameserver.model.entity.Instance;
import com.l2jserver.gameserver.model.instancezone.InstanceWorld;
import com.l2jserver.gameserver.model.L2Object;
import com.l2jserver.gameserver.model.L2World;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.model.quest.State;
import com.l2jserver.gameserver.model.skills.L2Skill;
import com.l2jserver.gameserver.network.NpcStringId;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.*;
//import com.l2jserver.util.Rnd;

/**
 * update by pmq 16-05-2011
 *
 */
public class Q00196_SevenSignsSealOfTheEmperor extends Quest
{
	protected static class SIGNSNpc
	{
		public L2Npc npc;
	
		public boolean isDead = false;
	}
	
	protected static class SIGNSRoom
	{
		public FastList<SIGNSNpc> npcList = new FastList<>();
	}
	
	private class SIGNSWorld extends InstanceWorld
	{
		public FastMap<String,SIGNSRoom> rooms = new FastMap<>();
		public long[] storeTime = { 0, 0 };
		public SIGNSWorld() {}
	}
	
	private static boolean debug = false;
	private static boolean noRndWalk = true;
	
	private static final int INSTANCEID        = 112;
	
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
	private static final int[] TOKILL = {27371,27372,27373,27374,27375,27377,27378,27379,27384};
	private static final int[] TOCHAT = {27371,27372,27373,27377,27378,27379};
	
	// QUEST ITEMS
	private static final int WATER = 13808;  // 艾爾摩亞丁的聖水
	private static final int SWORD = 15310;  // 殷海薩聖劍
	private static final int SEAL  = 13846;  // 封印的印章
	private static final int STAFF = 13809;  // 宮廷魔法師的魔法棒
	
	//Skills
	private static final int EINHASAD_STRIKE = 8357;
	
	private int mammonst = 0;
	
	private int _numAtk = 0;
	
	/**
	【備註】：【1~3】 是開場白只會出一次，【4~12】 是亂數出對話，【END】 是最後才會出的對話。
	【字顏色】	【對話次序】	【人物】	【對話編號】	【對話內容】
	【Orange】	【1】			【ANAKIM】	【19606】		【為了殷海薩的永恆！！！】
	【Pink】	【2】			【ANAKIM】	【19611】		【我的力量在變弱，請趕快啟動封印裝置吧！！！】
	【Orange】	【3】			【LILITH】	【19615】		【愚蠢的東西！這場戰爭的勝利是歸席琳的！！！】
	【Orange】	【4】			【ANAKIM】	【19609】		【光明軍勢啊！擊敗席琳的孩子們吧！！！】
	【Pink】	【5】			【ANAKIM】	【19614】		【「$s1」啊，請您再..加點力。】
	【Orange】	【7】			【ANAKIM】	【19608】		【我讓你們瞧瞧殷海薩真正的力量！】
	【Pink】	【8】			【ANAKIM】	【19613】		【莉莉絲的攻擊變得更加兇猛了！請趕快啟動！】
	【Orange】	【11】			【ANAKIM】	【19607】		【席琳的孩子們啊！你們無法成為我們的對手！】
	【Pink】	【12】			【ANAKIM】	【19612】		【4個封印裝置必須要全部啟動！！！】
	【Orange】	【END】			【ANAKIM】	【19610】		【這全都是託「$s1」的福，謝謝！】
	【Orange】	【6】			【LILITH】	【19617】		【亞納！以偉大的席琳之名，我將了斷你的生命！】
	【Orange】	【9】			【LILITH】	【19616】		【竟敢想要和我比武？真是可笑。】
	【Orange】	【10】			【LILITH】	【19618】		【你無法成為我--莉莉絲的對手，讓你瞧瞧我的厲害！】
	【Orange】	【END】			【LILITH】	【19619】		【竟然就這樣回到席琳的懷抱..真是氣憤..】
	*/
	/**
	 * @param ch
	 */
	private static final void removeBuffs(L2Character ch)
	{
		for (L2Effect e : ch.getAllEffects())
		{
			if (e == null)
				continue;
			L2Skill skill = e.getSkill();
			if (skill.isDebuff() || skill.isStayAfterDeath())
				continue;
			e.exit();
		}
	}
	
	@Override
	public String onAggroRangeEnter(L2Npc npc, L2PcInstance player, boolean isPet)
	{
		InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(player.getInstanceId());
		if (tmpworld instanceof SIGNSWorld)
		{
			if (npc.getNpcId() == 27371)
			{
				((L2Attackable) npc).abortAttack();
				npc.setTarget(player);
				npc.setIsRunning(true);
				npc.getAI().setIntention(CtrlIntention.AI_INTENTION_ATTACK, player);
				npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.THIS_PLACE_ONCE_BELONGED_TO_LORD_SHILEN));
			}
			if (npc.getNpcId() == 27372)
			{
				((L2Attackable) npc).abortAttack();
				npc.setTarget(player);
				npc.setIsRunning(true);
				npc.getAI().setIntention(CtrlIntention.AI_INTENTION_ATTACK, player);
				npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.WHO_DARES_ENTER_THIS_PLACE));
			}
			if (npc.getNpcId() == 27373 || npc.getNpcId() == 27379)
			{
				((L2Attackable) npc).abortAttack();
				npc.setTarget(player);
				npc.setIsRunning(true);
				npc.getAI().setIntention(CtrlIntention.AI_INTENTION_ATTACK, player);
				npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.THOSE_WHO_ARE_AFRAID_SHOULD_GET_AWAY_AND_THOSE_WHO_ARE_BRAVE_SHOULD_FIGHT));
			}
			if (npc.getNpcId() == 27377)
			{
				((L2Attackable) npc).abortAttack();
				npc.setTarget(player);
				npc.setIsRunning(true);
				npc.getAI().setIntention(CtrlIntention.AI_INTENTION_ATTACK, player);
				npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.LEAVE_NOW));
			}
			if (npc.getNpcId() == 27378)
			{
				((L2Attackable) npc).abortAttack();
				npc.setTarget(player);
				npc.setIsRunning(true);
				npc.getAI().setIntention(CtrlIntention.AI_INTENTION_ATTACK, player);
				npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.WHO_DARES_ENTER_THIS_PLACE));
			}
		}
		return null;
	}
	
	protected void runStartRoom(SIGNSWorld world)
	{
		world.setStatus(0);
		SIGNSRoom StartRoom = new SIGNSRoom();
		SIGNSNpc thisnpc;
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(SHUNAIMAN, -89456, 216184, -7504, 40960, false, 0, false, world.getInstanceId());
		StartRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(LEON, -89400, 216125, -7504, 40960, false, 0, false, world.getInstanceId());
		StartRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(DISCIPLES_GK, -84385, 216117, -7497, 0, false, 0, false, world.getInstanceId());
		StartRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(MAGICAN, -84945, 220643, -7495, 0, false, 0, false, world.getInstanceId());
		StartRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(MAGICAN, -89563, 220647, -7491, 0, false, 0, false, world.getInstanceId());
		StartRoom.npcList.add(thisnpc);
		
		world.rooms.put("StartRoom", StartRoom);
		if (debug)
			_log.info("SevenSignsSealOfTheEmperor: first room spawned in instance " + world.getInstanceId());
	}
	
	/**
	 * Room1 Mobs 27371 27372 27373 27374
	 * @param world 
	 */
	protected void runFirstRoom(SIGNSWorld world)
	{
		SIGNSRoom FirstRoom = new SIGNSRoom();
		SIGNSNpc thisnpc;
		thisnpc = new SIGNSNpc();
		thisnpc.isDead = false;
		thisnpc.npc = addSpawn(27371,-89049, 217979, -7495, 0, false, 0, false, world.getInstanceId());
		FirstRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27372,-89049, 217979, -7495, 0, false, 0, false, world.getInstanceId());
		FirstRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27373,-89049, 217979, -7495, 0, false, 0, false, world.getInstanceId());
		FirstRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27374,-89049, 217979, -7495, 0, false, 0, false, world.getInstanceId());
		FirstRoom.npcList.add(thisnpc);
		
		world.rooms.put("FirstRoom", FirstRoom);
		world.setStatus(1);

		if (debug)
			_log.info("SevenSignsSealOfTheEmperor: spawned First room");
	}
	
	/**
	 * Room2 Mobs 27371 27371 27372 27373 27373 27374
	 * @param world 
	 */
	protected void runSecondRoom(SIGNSWorld world)
	{
		SIGNSRoom SecondRoom = new SIGNSRoom();
		SIGNSNpc thisnpc;
		thisnpc = new SIGNSNpc();
		thisnpc.isDead = false;
		thisnpc.npc = addSpawn(27371, -88599, 220071, -7495, 0, false, 0, false, world.getInstanceId());
		SecondRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27371, -88599, 220071, -7495, 0, false, 0, false, world.getInstanceId());
		SecondRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27372, -88599, 220071, -7495, 0, false, 0, false, world.getInstanceId());
		SecondRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27373, -88599, 220071, -7495, 0, false, 0, false, world.getInstanceId());
		SecondRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27373, -88599, 220071, -7495, 0, false, 0, false, world.getInstanceId());
		SecondRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27374, -88599, 220071, -7495, 0, false, 0, false, world.getInstanceId());
		SecondRoom.npcList.add(thisnpc);
		
		world.rooms.put("SecondRoom", SecondRoom);
		world.setStatus(2);
		
		if (debug)
			_log.info("SevenSignsSealOfTheEmperor: spawned second room");
	}
	
	/**
	 * Room3 Mobs 27371 27371 27372 27372 27373 27373 27374 27374
	 * @param world 
	 */
	protected void runThirdRoom(SIGNSWorld world)
	{
		SIGNSRoom ThirdRoom = new SIGNSRoom();
		SIGNSNpc thisnpc;
		thisnpc = new SIGNSNpc();
		thisnpc.isDead = false;
		thisnpc.npc = addSpawn(27371, -86846, 220639, -7495, 0, false, 0, false, world.getInstanceId());
		ThirdRoom .npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27371, -86846, 220639, -7495, 0, false, 0, false, world.getInstanceId());
		ThirdRoom .npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27372, -86846, 220639, -7495, 0, false, 0, false, world.getInstanceId());
		ThirdRoom .npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27372, -86846, 220639, -7495, 0, false, 0, false, world.getInstanceId());
		ThirdRoom .npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27373, -86846, 220639, -7495, 0, false, 0, false, world.getInstanceId());
		ThirdRoom .npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27373, -86846, 220639, -7495, 0, false, 0, false, world.getInstanceId());
		ThirdRoom .npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27374, -86846, 220639, -7495, 0, false, 0, false, world.getInstanceId());
		ThirdRoom .npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27374, -86846, 220639, -7495, 0, false, 0, false, world.getInstanceId());
		ThirdRoom .npcList.add(thisnpc);
		
		world.rooms.put("ThirdRoom", ThirdRoom);
		world.setStatus(3);
		
		if (debug)
			_log.info("SevenSignsSealOfTheEmperor: spawned Third room");
	}
	
	/**
	 * Room4 Mobs 27371 27372 27373 27374 27375 27377 27378 27379
	 * @param world 
	 */
	protected void runForthRoom(SIGNSWorld world)
	{
		SIGNSRoom ForthRoom = new SIGNSRoom();
		SIGNSNpc thisnpc;
		thisnpc = new SIGNSNpc();
		thisnpc.isDead = false;
		thisnpc.npc = addSpawn(27371, -85463, 219227, -7495, 0, false, 0, false, world.getInstanceId());
		ForthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27372, -85463, 219227, -7495, 0, false, 0, false, world.getInstanceId());
		ForthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27373, -85463, 219227, -7495, 0, false, 0, false, world.getInstanceId());
		ForthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27374, -85463, 219227, -7495, 0, false, 0, false, world.getInstanceId());
		ForthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27375, -85463, 219227, -7495, 0, false, 0, false, world.getInstanceId());
		ForthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27377, -85463, 219227, -7495, 0, false, 0, false, world.getInstanceId());
		ForthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27378, -85463, 219227, -7495, 0, false, 0, false, world.getInstanceId());
		ForthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27379, -85463, 219227, -7495, 0, false, 0, false, world.getInstanceId());
		ForthRoom.npcList.add(thisnpc);
		
		world.rooms.put("ForthRoom", ForthRoom);
		world.setStatus(4);
		
		if (debug)
			_log.info("SevenSignsSealOfTheEmperor: spawned Forth room");
	}
	
	/**
	 * Room5 Mobs 27371 27372 27373 27374 27375 27375 27377 27377 27378 27378 27379 27379
	 * @param world 
	 */
	protected void runFifthRoom(SIGNSWorld world)
	{
		SIGNSRoom FifthRoom = new SIGNSRoom();
		SIGNSNpc thisnpc;
		thisnpc = new SIGNSNpc();
		thisnpc.isDead = false;
		thisnpc.npc = addSpawn(27371, -87441, 217623, -7495, 0, false, 0, false, world.getInstanceId());
		FifthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27372, -87441, 217623, -7495, 0, false, 0, false, world.getInstanceId());
		FifthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27373, -87441, 217623, -7495, 0, false, 0, false, world.getInstanceId());
		FifthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27374, -87441, 217623, -7495, 0, false, 0, false, world.getInstanceId());
		FifthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27375, -87441, 217623, -7495, 0, false, 0, false, world.getInstanceId());
		FifthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27375, -87441, 217623, -7495, 0, false, 0, false, world.getInstanceId());
		FifthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27377, -87441, 217623, -7495, 0, false, 0, false, world.getInstanceId());
		FifthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27377, -87441, 217623, -7495, 0, false, 0, false, world.getInstanceId());
		FifthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27378, -87441, 217623, -7495, 0, false, 0, false, world.getInstanceId());
		FifthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27378, -87441, 217623, -7495, 0, false, 0, false, world.getInstanceId());
		FifthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27379, -87441, 217623, -7495, 0, false, 0, false, world.getInstanceId());
		FifthRoom.npcList.add(thisnpc);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(27379, -87441, 217623, -7495, 0, false, 0, false, world.getInstanceId());
		FifthRoom.npcList.add(thisnpc);
		
		world.rooms.put("FifthRoom", FifthRoom);
		world.setStatus(5);
		
		if (debug)
			_log.info("SevenSignsSealOfTheEmperor: spawned Fifth room");
	}
	
	protected void runBossRoom(SIGNSWorld world)
	{
		SIGNSRoom BossRoom = new SIGNSRoom();
		SIGNSNpc thisnpc;
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(LILITH, -83175, 217021, -7504, 0, false, 0, false, world.getInstanceId());
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(LILITH_GUARD0, -83127, 217056, -7504, 0, false, 0, false, world.getInstanceId());
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(LILITH_GUARD1, -83222, 217055, -7504, 0, false, 0, false, world.getInstanceId());
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(ANAKIM, -83179, 216479, -7504, 0, false, 0, false, world.getInstanceId());
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(ANAKIM_GUARD0, -83227, 216443, -7504, 0, false, 0, false, world.getInstanceId());
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(ANAKIM_GUARD1, -83134, 216443, -7504, 0, false, 0, false, world.getInstanceId());
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(ANAKIM_GUARD2, -83179, 216432, -7504, 0, false, 0, false, world.getInstanceId());
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(SEALDEVICE, -83177, 217353, -7520, 32768, false, 0, false, world.getInstanceId());
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(SEALDEVICE, -83177, 216137, -7520, 32768, false, 0, false, world.getInstanceId());
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(SEALDEVICE, -82588, 216754, -7520, 32768, false, 0, false, world.getInstanceId());
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(SEALDEVICE, -83804, 216754, -7520, 32768, false, 0, false, world.getInstanceId());
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(32592, -83176, 216753, -7497, 0, false, 0, false, world.getInstanceId());
		BossRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
		
		world.rooms.put("BossRoom", BossRoom);
		world.setStatus(6);
		if (debug)
			_log.info("SevenSignsSealOfTheEmperor: spawned Boss room");
	}
	
	protected void runSDRoom(SIGNSWorld world)
	{
		SIGNSRoom SDRoom = new SIGNSRoom();
		SIGNSNpc thisnpc;
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(SEALDEVICE, -83177, 217353, -7520, 32768, false, 0, false, world.getInstanceId());
		SDRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
			thisnpc.npc.setIsImmobilized(true);
			thisnpc.npc.setIsMortal(false);
			thisnpc.npc.setRHandId(15281);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(SEALDEVICE, -83177, 216137, -7520, 32768, false, 0, false, world.getInstanceId());
		SDRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
			thisnpc.npc.setIsImmobilized(true);
			thisnpc.npc.setIsMortal(false);
			thisnpc.npc.setRHandId(15281);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(SEALDEVICE, -82588, 216754, -7520, 32768, false, 0, false, world.getInstanceId());
		SDRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
			thisnpc.npc.setIsImmobilized(true);
			thisnpc.npc.setIsMortal(false);
			thisnpc.npc.setRHandId(15281);
		
		thisnpc = new SIGNSNpc();
		thisnpc.npc = addSpawn(SEALDEVICE, -83804, 216754, -7520, 32768, false, 0, false, world.getInstanceId());
		SDRoom.npcList.add(thisnpc);
		if (noRndWalk)
			thisnpc.npc.setIsNoRndWalk(true);
			thisnpc.npc.setIsImmobilized(true);
			thisnpc.npc.setIsMortal(false);
			thisnpc.npc.setRHandId(15281);
		
		world.rooms.put("SDRoom", SDRoom);
		if (debug)
			_log.info("SevenSignsSealOfTheEmperor: spawned SD room");
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
	
	private static final void teleportPlayer(L2PcInstance player, int[] coords, int instanceId)
	{
		removeBuffs(player);
		if (player.getSummon() != null)
		{
			removeBuffs(player.getSummon());
		}
		player.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
		player.setInstanceId(instanceId);
		player.teleToLocation(coords[0], coords[1], coords[2], true);
	}
	
	private final synchronized void enterInstance(L2PcInstance player)
	{
		InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
		if (world != null)
		{
			if (world.getTemplateId() != INSTANCEID)
			{
				player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.ALREADY_ENTERED_ANOTHER_INSTANCE_CANT_ENTER));
				return;
			}
			Instance inst = InstanceManager.getInstance().getInstance(world.getInstanceId());
			if (inst != null)
				teleportPlayer(player, TELEPORT, world.getInstanceId());
			return;
		}
		final int instanceId = InstanceManager.getInstance().createDynamicInstance("SanctumSealOfTheEmperor.xml");
		
		_numAtk = 0;
		world = new SIGNSWorld();
		world.setInstanceId(instanceId);
		world.setTemplateId(INSTANCEID);
		InstanceManager.getInstance().addWorld(world);
		((SIGNSWorld) world).storeTime[0] = System.currentTimeMillis();
		runStartRoom((SIGNSWorld) world);
		runFirstRoom((SIGNSWorld) world);
		world.addAllowed(player.getObjectId());
		teleportPlayer(player, TELEPORT, instanceId);
		
		_log.info("SevenSigns 5th epic quest " + instanceId + " created by player: " + player.getName());
	}
	
	protected void exitInstance(L2PcInstance player)
	{
		player.setInstanceId(0);
		player.teleToLocation(171782, -17612, -4901);
	}
	
	@Override
	public String onAttack(L2Npc npc, L2PcInstance attacker, int damage, boolean isPet, L2Skill skill)
	{
		InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
		if (tmpworld instanceof SIGNSWorld)
		{
			SIGNSWorld world = (SIGNSWorld) tmpworld;
			
			if (world.getStatus() == 6 && npc.getNpcId() == SEALDEVICE)
			{
				npc.doCast(SkillTable.getInstance().getInfo(5980, 3));
			}
		}
		return super.onAttack(npc, attacker, damage, isPet, skill);
	}
	
	@Override
	public String onSkillSee(L2Npc npc, L2PcInstance caster, L2Skill skill, L2Object[] targets, boolean isPet)
	{
		InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
		if (tmpworld instanceof SIGNSWorld)
		{
			SIGNSWorld world = (SIGNSWorld) tmpworld;
			
			if (world.getStatus() == 6 && skill.getId() == EINHASAD_STRIKE && npc.getNpcId() == SEALDEVICE)
			{
				npc.doCast(SkillTable.getInstance().getInfo(5980, 3));
			}
		}
		return super.onSkillSee(npc, caster, skill, targets, isPet);
	}
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		String htmltext = event;
		QuestState st = player.getQuestState(getName());
		
		if (st == null)
			return htmltext;
		
		if (event.equalsIgnoreCase("30969-05.htm"))
		{
			st.set("cond", "1");
			st.setState(State.STARTED);
			st.playSound("ItemSound.quest_accept");
		}
		else if (event.equalsIgnoreCase("32598-02.htm"))
		{
			st.giveItems(STAFF, 1);
			player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId._3040));
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
			mammonst = 0;
		}
		else if (event.equalsIgnoreCase("32586-06.htm"))
		{
			player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId._3031));
			player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId._3039));
			st.playSound("ItemSound.quest_middle");
			st.set("cond", "4");
			st.giveItems(SWORD, 1);
			st.giveItems(WATER, 1);
		}
		else if (event.equalsIgnoreCase("32586-12.htm"))
		{
			st.playSound("ItemSound.quest_middle");
			st.set("cond", "5");
			st.takeItems(SEAL, -1);
			st.takeItems(SWORD, 1);
			st.takeItems(WATER, 1);
			st.takeItems(STAFF, 1);
		}
		else if (event.equalsIgnoreCase("32593-02.htm"))
		{
			st.addExpAndSp(25000000, 2500000);
			st.unset("cond");
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
				mammon.broadcastPacket(new NpcSay(mammon.getObjectId(), 0, mammon.getNpcId(), NpcStringId.WHO_DARES_SUMMON_THE_MERCHANT_OF_MAMMON));
				st.startQuestTimer("despawn", 120000, mammon);
			}
			else
				return "30969-06a.htm";
		}
		else if (event.equalsIgnoreCase("despawn"))
		{
			mammonst = 0;
			npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.THE_ANCIENT_PROMISE_TO_THE_EMPEROR_HAS_BEEN_FULFILLED));
			return null;
		}
		else if (event.equalsIgnoreCase("DOORS"))
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof SIGNSWorld)
			{
				SIGNSWorld world = (SIGNSWorld) tmpworld;
				openDoor(DOOR, world.getInstanceId());
				for(int objId : world.getAllowed())
				{
					L2PcInstance pl = L2World.getInstance().getPlayer(objId);
					if (pl != null)
						pl.showQuestMovie(12);
						runBossRoom(world);
						player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId._3032));
				}
				return null;
			}
		}
		else if (event.equalsIgnoreCase("Tele"))
		{
			player.teleToLocation(-89528, 216056, -7516);
			return null;
		}
		return htmltext;
	}
	
	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = getNoQuestMsg(player);
		QuestState st = player.getQuestState(getName());
		QuestState qs = player.getQuestState(Q00195_SevenSignsSecretRitualOfThePriests.class.getSimpleName());
		
		if (st == null)
			return htmltext;
		
		int cond = st.getInt("cond");
		switch (npc.getNpcId())
		{
			case HEINE:
				switch (st.getState())
				{
					case State.CREATED:
						if (cond == 0 && player.getLevel() >= 79 && qs.getState() == State.COMPLETED)
							return "30969-01.htm";
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
						return getAlreadyCompletedMsg(player);
				}
			case WOOD:
				if (cond == 6)
					return "32593-01.htm";
				else if (st.getState() == State.COMPLETED)
					return getAlreadyCompletedMsg(player);
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
					case 1:
					case 2:
						return null;
					case 3:
						enterInstance(player);
						return null;
					case 4:
						enterInstance(player);
						return null;
					case 5:
					case 6:
						return null;
				}
			case MAGICAN:
				switch (st.getInt("cond"))
				{
					case 4:
						if (!st.hasQuestItems(STAFF))
						{
							player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId._3040));
							return "32598-01.htm";
						}
						player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId._3040));
						return "32598-03.htm";
				}
			case SHUNAIMAN:
				switch (st.getInt("cond"))
				{
					case 3:
						return "32586-01.htm";
					case 4:
						if (!st.hasQuestItems(SWORD))
						{
							player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId._3031));
							player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId._3039));
							st.giveItems(SWORD, 1);
							return "32586-14.htm";
						}
						if (!st.hasQuestItems(WATER))
						{
							player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId._3031));
							player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId._3039));
							st.giveItems(WATER, 1);
							return "32586-14.htm";
						}
						if (_numAtk >= 4 && st.getQuestItemsCount(SEAL) >= 4)
							return "32586-08.htm";
						player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId._3031));
						player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId._3039));
						return "32586-07.htm";
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
						InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
						world.removeAllowed(player.getObjectId());
						exitInstance(player);
						return "32587-02.htm";
				}
		
		}
		return htmltext;
	}
	
	@Override
	public final String onKill(L2Npc npc, L2PcInstance player, boolean isPet)
	{
		QuestState st = player.getQuestState(getName());
		
		InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
		SIGNSWorld world;
		
		if (st == null)
			return null;
		
		if (tmpworld instanceof SIGNSWorld)
		{
			world = (SIGNSWorld)tmpworld;
			if (npc.getNpcId() == 27371)
			{
				npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.FOR_SHILEN));
			}
			else if (npc.getNpcId() == 27372)
			{
				npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.LORD_SHILEN_SOME_DAY_YOU_WILL_ACCOMPLISH_THIS_MISSION));
			}
			else if (npc.getNpcId() == 27373)
			{
				npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.WHY_ARE_YOU_GETTING_IN_OUR_WAY));
			}
			else if (npc.getNpcId() == 27377)
			{
				npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.FOR_SHILEN));
			}
			else if (npc.getNpcId() == 27378)
			{
				npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.LORD_SHILEN_SOME_DAY_YOU_WILL_ACCOMPLISH_THIS_MISSION));
			}
			else if (npc.getNpcId() == 27379)
			{
				npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.WHY_ARE_YOU_GETTING_IN_OUR_WAY));
			}
			
			if (world.getStatus() == 1)
			{
				if (checkKillProgress(npc, world.rooms.get("FirstRoom")))
				{
					runSecondRoom(world);
					openDoor(DOOR2, world.getInstanceId());
				}
			}
			else if (world.getStatus() == 2)
			{
				if (checkKillProgress(npc, world.rooms.get("SecondRoom")))
				{
					runThirdRoom(world);
					openDoor(DOOR4, world.getInstanceId());
				}
			}
			else if (world.getStatus() == 3)
			{
				if (checkKillProgress(npc, world.rooms.get("ThirdRoom")))
				{
					runForthRoom(world);
					openDoor(DOOR6, world.getInstanceId());
				}
			}
			else if (world.getStatus() == 4)
			{
				if (checkKillProgress(npc, world.rooms.get("ForthRoom")))
				{
					runFifthRoom(world);
					openDoor(DOOR8, world.getInstanceId());
				}
			}
			else if (world.getStatus() == 5)
			{
				if (checkKillProgress(npc, world.rooms.get("FifthRoom")))
				{
					openDoor(DOOR10, world.getInstanceId());
				}
			}
			else if (world.getStatus() == 6)
			{
				_numAtk++;
				if (npc.getNpcId() == SEALDEVICE)
				{
					if (_numAtk < 4)
					{
						player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId._3060));
						npc.setRHandId(15281);
						st.playSound("ItemSound.quest_itemget");
						st.giveItems(SEAL, 1);
					}
					else
					{
						player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId._3060));
						npc.setRHandId(15281);
						st.giveItems(SEAL, 1);
						st.playSound("ItemSound.quest_middle");
						runSDRoom(world);
						player.showQuestMovie(13);
						startQuestTimer("Tele", 26000, null, player);
					}
				}
			}
		}
		return null;
	}
	
	public Q00196_SevenSignsSealOfTheEmperor(int questId, String name, String descr)
	{
		super(questId, name, descr);
		
		addStartNpc(HEINE);
		addStartNpc(PROMICE_OF_MAMMON);
		
		addSkillSeeId(SEALDEVICE);
		addAttackId(SEALDEVICE);
		
		for (int i : NPCS)
			addTalkId(i);
		
		for (int mob : TOKILL )
			addKillId(mob);
		
		for (int mob1 : TOCHAT )
			addAggroRangeEnterId(mob1);
		
		questItemIds = new int[]
		{ SWORD, WATER, SEAL, STAFF };
	}
	
	public static void main(String[] args)
	{
		new Q00196_SevenSignsSealOfTheEmperor(196, Q00196_SevenSignsSealOfTheEmperor.class.getSimpleName(), "Seven Signs, Seal Of The Emperor");
	}
}