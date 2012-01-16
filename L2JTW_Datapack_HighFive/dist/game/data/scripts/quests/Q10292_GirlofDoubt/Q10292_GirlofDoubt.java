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
package quests.Q10292_GirlofDoubt;

import com.l2jserver.Config;
import com.l2jserver.gameserver.ai.CtrlIntention;
import com.l2jserver.gameserver.instancemanager.InstanceManager;
import com.l2jserver.gameserver.instancemanager.InstanceManager.InstanceWorld;
import com.l2jserver.gameserver.model.L2Effect;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2MonsterInstance;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.L2Skill;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.model.quest.State;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;
import com.l2jserver.gameserver.util.Util;

/**
 * (10292) Seven Signs, Girl of Doubt
 * @author pmq
 * High Five 29-09-2011
 */

public class Q10292_GirlofDoubt extends Quest
{
	private class GoDWorld extends InstanceWorld
	{
		public long[] storeTime = {0,0};
		public GoDWorld() {}
	}
	
	private static final int INSTANCEID = 146;
	private static final int INSTANCEID1 = 158;
	
	private static final String qn = "Q10292_GirlofDoubt";
	
	// NPCs
	private static final int HARDIN = 30832;
	private static final int WOOD = 32593;
	private static final int FRANZ = 32597;
	private static final int JAINA = 32617;
	private static final int ELCADIA = 32784;
	private static final int GRUFF_LOOKING_MAN = 32862;
	
	// MOBS
	private static final int SHILENSEVIL1 = 27422;
	private static final int SHILENSEVIL2 = 27424;
	private static final int[] GOLEM = {22801, 22802, 22803, 22804, 22805, 22806};
	
	// ITEMS
	private static final int E_MARK = 17226;
	
	// Drop Chance
	private static final double DROP_CHANCE = 80;
	
	private boolean ShilensevilOnSpawn = false;
	
	private int _numAtk = 0;
	
	private class teleCoord {int instanceId; int x; int y; int z;}
	
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
	
	private void teleportplayer(L2PcInstance player, teleCoord teleto)
	{
		ShilensevilOnSpawn = false;
		removeBuffs(player);
		if (player.getPet() != null)
		{
			removeBuffs(player.getPet());
		}
		player.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
		player.setInstanceId(teleto.instanceId);
		player.teleToLocation(teleto.x, teleto.y, teleto.z);
		return;
	}
	
	private void teleportplayer1(L2PcInstance player, teleCoord teleto)
	{
		_numAtk = 0;
		ShilensevilOnSpawn = false;
		player.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
		player.setInstanceId(teleto.instanceId);
		player.teleToLocation(teleto.x, teleto.y, teleto.z);
		return;
	}
	
	protected void exitInstance(L2PcInstance player, teleCoord tele)
	{
		player.setInstanceId(0);
		player.teleToLocation(tele.x, tele.y, tele.z);
	}
	
	protected int enterInstance(L2PcInstance player, String template, teleCoord teleto)
	{
		int instanceId = 0;
		InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
		if (world != null)
		{
			if (!(world instanceof GoDWorld))
			{
				player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.ALREADY_ENTERED_ANOTHER_INSTANCE_CANT_ENTER));
				return 0;
			}
			teleto.instanceId = world.instanceId;
			teleportplayer(player,teleto);
			return instanceId;
		}
		instanceId = InstanceManager.getInstance().createDynamicInstance(template);
		world = new GoDWorld();
		world.instanceId = instanceId;
		world.templateId = INSTANCEID;
		world.status = 0;
		((GoDWorld)world).storeTime[0] = System.currentTimeMillis();
		InstanceManager.getInstance().addWorld(world);
		_log.info("JiniaGuildHideout started " + template + " Instance: " + instanceId + " created by player: " + player.getName());
		teleto.instanceId = instanceId;
		teleportplayer(player,teleto);
		world.allowed.add(player.getObjectId());
		return instanceId;
	}
	
	protected int enterInstance1(L2PcInstance player, String template, teleCoord teleto)
	{
		int instanceId = 0;
		InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
		if (world != null)
		{
			if (!(world instanceof GoDWorld))
			{
				player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.ALREADY_ENTERED_ANOTHER_INSTANCE_CANT_ENTER));
				return 0;
			}
			teleto.instanceId = world.instanceId;
			teleportplayer1(player,teleto);
			return instanceId;
		}
		instanceId = InstanceManager.getInstance().createDynamicInstance(template);
		world = new GoDWorld();
		world.instanceId = instanceId;
		world.templateId = INSTANCEID1;
		world.status = 0;
		((GoDWorld)world).storeTime[0] = System.currentTimeMillis();
		InstanceManager.getInstance().addWorld(world);
		_log.info("ElcadiaTent started " + template + " Instance: " + instanceId + " created by player: " + player.getName());
		teleto.instanceId = instanceId;
		teleportplayer1(player,teleto);
		world.allowed.add(player.getObjectId());
		return instanceId;
	}
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		String htmltext = event;
		QuestState st = player.getQuestState(qn);
		
		if (st == null)
			return htmltext;
		
		if (npc.getNpcId() == WOOD)
		{
			if (event.equalsIgnoreCase("32593-04.htm"))
			{
				st.setState(State.STARTED);
				st.set("cond", "1");
				st.playSound("ItemSound.quest_accept");
			}
			
			else if (event.equalsIgnoreCase("32593-05.htm"))
			{
				teleCoord tele = new teleCoord();
				tele.x = -23748;
				tele.y = -8955;
				tele.z = -5384;
				enterInstance(player, "JiniaGuildHideout.xml", tele);
			}
		}
		
		else if (npc.getNpcId() == FRANZ)
		{
			if (event.equalsIgnoreCase("32597-04.htm"))
			{
				st.set("cond", "2");
				startQuestTimer("TimeOut", 1000, npc, player);
				st.playSound("ItemSound.quest_middle");
			}
			
			if (event.equalsIgnoreCase("TimeOut"))
			{
				InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
				world.allowed.remove(world.allowed.indexOf(player.getObjectId()));
				teleCoord tele = new teleCoord();
				tele.instanceId = 0;
				tele.x = 147052;
				tele.y = 23751;
				tele.z = -1984;
				exitInstance(player,tele);
				return null;
			}
		}
		
		else if (npc.getNpcId() == JAINA)
		{
			if (event.equalsIgnoreCase("32617-02.htm"))
			{
				InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
				world.allowed.remove(world.allowed.indexOf(player.getObjectId()));
				teleCoord tele = new teleCoord();
				tele.instanceId = 0;
				tele.x = 147052;
				tele.y = 23751;
				tele.z = -1984;
				exitInstance(player,tele);
			}
		}
		
		else if (npc.getNpcId() == ELCADIA)
		{
			if (event.equalsIgnoreCase("tele1"))
			{
				InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
				world.allowed.remove(world.allowed.indexOf(player.getObjectId()));
				teleCoord tele = new teleCoord();
				tele.instanceId = 0;
				tele.x = 43347;
				tele.y = -87923;
				tele.z = -2816;
				exitInstance(player,tele);
				return null;
			}
			
			else if (event.equalsIgnoreCase("spawn"))
			{
				if (ShilensevilOnSpawn)
					htmltext = "32784-07a.htm";
				else
				{
					L2MonsterInstance monster = (L2MonsterInstance) addSpawn(SHILENSEVIL1, 89430, -238011, -9640, 65188, false, 600000, true, npc.getInstanceId());
					monster.setIsNoRndWalk(true);
					L2MonsterInstance monster1 = (L2MonsterInstance) addSpawn(SHILENSEVIL2, 89539, -238125, -9640, 0, false, 600000, true, npc.getInstanceId());
					monster1.setIsNoRndWalk(true);
					ShilensevilOnSpawn = true;
					return null;
				}
			}
			
			else if (event.equalsIgnoreCase("END"))
			{
				htmltext = "32784-14.htm";
				st.addExpAndSp(100000000,10000000);
				st.unset("cond");
				st.setState(State.COMPLETED);
				st.exitQuest(false);
				st.playSound("ItemSound.quest_finish");
			}
			
			if (event.equalsIgnoreCase("32784-03.htm"))
			{
				st.set("cond", "3");
				st.playSound("ItemSound.quest_middle");
			}
			
			else if (event.equalsIgnoreCase("32784-07.htm"))
			{
				if (ShilensevilOnSpawn)
					htmltext = "32784-07a.htm";
				else
				{
					L2MonsterInstance monster = (L2MonsterInstance) addSpawn(SHILENSEVIL1, 89430, -238011, -9640, 65188, false, 600000, true, npc.getInstanceId());
					monster.setIsNoRndWalk(true);
					L2MonsterInstance monster1 = (L2MonsterInstance) addSpawn(SHILENSEVIL2, 89539, -238125, -9640, 0, false, 600000, true, npc.getInstanceId());
					monster1.setIsNoRndWalk(true);
					ShilensevilOnSpawn = true;
					startQuestTimer("tele1", 2000, npc, player);
				}
			}
			
			else if (event.equalsIgnoreCase("32784-12.htm"))
			{
				st.set("cond", "7");
				st.playSound("ItemSound.quest_middle");
			}
		}
		
		else if (npc.getNpcId() == GRUFF_LOOKING_MAN)
		{
			if (event.equalsIgnoreCase("tele"))
			{
				teleCoord tele = new teleCoord();
				tele.x = 89809;
				tele.y = -238066;
				tele.z = -9632;
				enterInstance1(player, "ElcadiaTent.xml", tele);
				return null;
			}
		}
		
		else if (npc.getNpcId() == HARDIN)
		{
			if (event.equalsIgnoreCase("30832-02.htm"))
			{
				st.set("cond", "8");
				st.playSound("ItemSound.quest_middle");
			}
		}
		return htmltext;
	}
	
	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>";
		QuestState st = player.getQuestState(qn);
		QuestState sse = player.getQuestState("198_SevenSignEmbryo");
		
		if (st == null)
			return htmltext;
		
		if (npc.getNpcId() == WOOD)
		{
			switch (st.getState())
			{
				case State.CREATED:
					if (sse != null && sse.getState() == State.COMPLETED && player.getLevel() >= 81)
						htmltext = "32593-01.htm";
					else
					{
						htmltext = "32593-00.htm";
						st.exitQuest(true);
					}
					break;
				
				case State.STARTED:
					if (st.getInt("cond") >= 1)
						htmltext = "32593-06.htm";
					
					break;
				case State.COMPLETED:
					htmltext = "<html><body>這是已經完成的任務。</body></html>";
			}
		}
		
		else if (npc.getNpcId() == FRANZ)
		{
			if (st.getInt("cond") == 1)
				htmltext = "32597-01.htm";
			
			else if (st.getInt("cond") == 2)
				htmltext = "32597-05.htm";
			
			else if (st.getInt("cond") == 3)
				htmltext = "32597-11.htm";
		}
		
		else if (npc.getNpcId() == JAINA)
		{
			if (st.getInt("cond") >= 1)
				htmltext = "32617-01.htm";
		}
		
		else if (npc.getNpcId() == ELCADIA)
		{
			if (st.getInt("cond") == 2)
				htmltext = "32784-01.htm";
			
			else if (st.getInt("cond") == 3)
				htmltext = "32784-04.htm";
			
			else if (st.getInt("cond") == 4)
			{
				htmltext = "32784-05.htm";
				st.takeItems(E_MARK, -1);
				st.set("cond", "5");
				st.playSound("ItemSound.quest_middle");
			}
			
			else if (st.getInt("cond") == 5)
				htmltext = "32784-08.htm";
			
			else if (st.getInt("cond") == 6)
				htmltext = "32784-09.htm";
			
			else if (st.getInt("cond") == 7)
				htmltext = "32784-12.htm";
			
			else if (st.getInt("cond") == 8)
				htmltext = "32784-13.htm";
		}
		
		else if (npc.getNpcId() == GRUFF_LOOKING_MAN)
		{
			if (st.getInt("cond") == 0 || st.getInt("cond") == 1)
			{
				htmltext = "32862-00.html";
				st.exitQuest(true);
			}
			else if (st.getInt("cond") >= 2)
				htmltext = "32862-01.htm";
		}
		
		else if (npc.getNpcId() == HARDIN)
		{
			if (st.getInt("cond") == 7)
				htmltext = "30832-01.htm";
			
			else if (st.getInt("cond") == 8)
				htmltext = "30832-03.htm";
		}
		
		return htmltext;
	}
	
	@Override
	public String onKill(L2Npc npc, L2PcInstance player, boolean isPet)
	{
		QuestState st = player.getQuestState(qn);
		if (st == null)
			return null;
		
		if (npc.getNpcId() == SHILENSEVIL1)
		{
			_numAtk++;
			if (_numAtk == 2 && st.getInt("cond") == 5)
			{
				st.set("cond", "6");
				st.playSound("ItemSound.quest_middle");
			}
		}
		
		else if (npc.getNpcId() == SHILENSEVIL2)
		{
			_numAtk++;
			if (_numAtk == 2 && st.getInt("cond") == 5)
			{
				st.set("cond", "6");
				st.playSound("ItemSound.quest_middle");
			}
		}
		
		else if (st.getState() == State.STARTED && st.getInt("cond") == 3 && Util.contains(GOLEM, npc.getNpcId()))
		{
			long count = st.getQuestItemsCount(E_MARK);
			int chance = (int)(Config.RATE_QUEST_DROP * DROP_CHANCE);
			int numItems = chance / 100;
			chance = chance % 100;
			if (st.getRandom(100) < chance)
				numItems++;
			if (numItems > 0)
			{
				if (count + numItems >= 10)
				{
					numItems = 10 - (int)count;
					st.set("cond", "4");
					st.playSound("ItemSound.quest_middle");
				}
				else
				{
					st.playSound("ItemSound.quest_itemget");
					st.giveItems(E_MARK, numItems);
				}
			}
		}
		return null;
	}
	
	public Q10292_GirlofDoubt(int questId, String name, String descr)
	{
		super(questId, name, descr);
		
		addStartNpc(WOOD);
		addStartNpc(GRUFF_LOOKING_MAN);
		addTalkId(WOOD);
		addTalkId(FRANZ);
		addTalkId(JAINA);
		addTalkId(ELCADIA);
		addTalkId(GRUFF_LOOKING_MAN);
		addTalkId(HARDIN);
		
		addKillId(SHILENSEVIL1);
		addKillId(SHILENSEVIL2);
		for (int i : GOLEM)
			addKillId(i);
		
		questItemIds = new int[]
		{ E_MARK };
	}
	
	public static void main(String[] args)
	{
		new Q10292_GirlofDoubt(10292, qn, "Seven Signs, Girl of Doubt");
	}
}
