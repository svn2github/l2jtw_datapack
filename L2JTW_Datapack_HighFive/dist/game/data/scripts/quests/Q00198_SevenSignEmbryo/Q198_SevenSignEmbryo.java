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
package quests.Q00198_SevenSignEmbryo;

import com.l2jserver.gameserver.ai.CtrlIntention;
import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.instancemanager.InstanceManager;
import com.l2jserver.gameserver.instancemanager.InstanceManager.InstanceWorld;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2MonsterInstance;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.effects.L2Effect;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.model.quest.State;
import com.l2jserver.gameserver.model.skills.L2Skill;
import com.l2jserver.gameserver.network.NpcStringId;
import com.l2jserver.gameserver.network.serverpackets.NpcSay;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;

/**
 * @author Plim
 * InstanceWorld HideoutoftheDawn By knoxville OpenTeamFree 10.09.2010, Based on PTS Freya.
 * Update by pmq High Five 22-10-2011
 */

public class Q198_SevenSignEmbryo extends Quest
{
	private class HoDWorld extends InstanceWorld
	{
		public long[] storeTime = {0,0};
		public HoDWorld() {}
	}
	
	private static final int INSTANCEID = 113;
	
	private static final String qn = "198_SevenSignEmbryo";
	
	//NPCs
	private static final int WOOD = 32593;
	private static final int FRANZ = 32597;
	private static final int JAINA = 32617;
	
	//MOBS
	private static final int SHILENSEVIL1 = 27346;
	private static final int SHILENSEVIL2 = 27399;
	private static final int SHILENSEVIL3 = 27402;
	
	//ITEMS
	private static final int SCULPTURE = 14360;
	private static final int BRACELET = 15312;
	private static final int AA = 5575;
	
	//AA reward rate
	private static final int AARATE = 1;
	
	private boolean ShilensevilOnSpawn = false;
	
	protected static class teleCoord
	{
		int instanceId;
		int x;
		int y;
		int z;
	}
	
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
		if (player.getSummon() != null)
		{
			removeBuffs(player.getSummon());
		}
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
			if (!(world instanceof HoDWorld))
			{
				player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.ALREADY_ENTERED_ANOTHER_INSTANCE_CANT_ENTER));
				return 0;
			}
			teleto.instanceId = world.instanceId;
			teleportplayer(player,teleto);
			return instanceId;
		}
		instanceId = InstanceManager.getInstance().createDynamicInstance(template);
		world = new HoDWorld();
		world.instanceId = instanceId;
		world.templateId = INSTANCEID;
		world.status = 0;
		((HoDWorld)world).storeTime[0] = System.currentTimeMillis();
		InstanceManager.getInstance().addWorld(world);
		_log.info("HideoutoftheDawn started " + template + " Instance: " + instanceId + " created by player: " + player.getName());
		teleto.instanceId = instanceId;
		teleportplayer(player,teleto);
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
			if (event.equalsIgnoreCase("32593-02.htm"))
			{
				st.setState(State.STARTED);
				st.set("cond", "1");
				st.playSound("ItemSound.quest_accept");
			}
			else if (event.equalsIgnoreCase("32593-03.htm"))
			{
				teleCoord tele = new teleCoord();
				tele.x = -23769;
				tele.y = -8961;
				tele.z = -5392;
				enterInstance(player, "HideoutoftheDawn.xml", tele);
			}
		}
		
		else if (npc.getNpcId() == FRANZ)
		{
			if (event.equalsIgnoreCase("32597-05.htm"))
			{
				if (ShilensevilOnSpawn)
					htmltext = "32597-05a.htm";
				else
				{
					NpcSay packet = new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.S1_THAT_STRANGER_MUST_BE_DEFEATED_HERE_IS_THE_ULTIMATE_HELP);
					packet.addStringParameter(player.getName().toString());
					npc.broadcastPacket(packet);
					L2MonsterInstance monster = (L2MonsterInstance) addSpawn(SHILENSEVIL1, -23656, -9236, -5392, 0, false, 600000, true, npc.getInstanceId());
					monster.broadcastPacket(new NpcSay(monster.getObjectId(), 0, monster.getNpcId(), NpcStringId.YOU_ARE_NOT_THE_OWNER_OF_THAT_ITEM));
					monster.setRunning();
					monster.addDamageHate(player, 0, 999);
					monster.getAI().setIntention(CtrlIntention.AI_INTENTION_ATTACK, st.getPlayer());
					L2MonsterInstance monster1 = (L2MonsterInstance) addSpawn(SHILENSEVIL2, -23656, -9236, -5392, 0, false, 600000, true, npc.getInstanceId());
					monster1.setRunning();
					monster1.addDamageHate(player, 0, 999);
					monster1.getAI().setIntention(CtrlIntention.AI_INTENTION_ATTACK, st.getPlayer());
					L2MonsterInstance monster2 = (L2MonsterInstance) addSpawn(SHILENSEVIL3, -23656, -9236, -5392, 0, false, 600000, true, npc.getInstanceId());
					monster2.setRunning();
					monster2.addDamageHate(player, 0, 999);
					monster2.getAI().setIntention(CtrlIntention.AI_INTENTION_ATTACK, st.getPlayer());
					ShilensevilOnSpawn = true;
					startQuestTimer("aiplayer", 30000, npc, player);
				}
			}
			
			else if (event.equalsIgnoreCase("aiplayer"))
			{
				if (ShilensevilOnSpawn == true)
				{
					if (!npc.isInsideRadius(player, 600, true, true))
					{
						NpcSay packet = new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.LOOK_HERE_S1_DONT_FALL_TOO_FAR_BEHIND);
						packet.addStringParameter(player.getName().toString());
						npc.broadcastPacket(packet);
						startQuestTimer("aiplayer", 20000, npc, player);
						return null;
					}
					npc.setTarget(player);
					npc.doCast(SkillTable.getInstance().getInfo(1011, 18));  // Guess Skill
					startQuestTimer("aiplayer", 20000, npc, player);
					return null;
				}
				cancelQuestTimer("aiplayer", npc, player);
				return "";
			}
			
			else if (event.equalsIgnoreCase("32597-10.htm"))
			{
				st.set("cond", "3");
				npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.WE_WILL_BE_WITH_YOU_ALWAYS));
				st.takeItems(SCULPTURE, -1);
				st.playSound("ItemSound.quest_middle");
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
				tele.x = 147072;
				tele.y = 23743;
				tele.z = -1984;
				exitInstance(player,tele);
			}
		}
		
		return htmltext;
	}
	
	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>";
		QuestState st = player.getQuestState(qn);
		QuestState fifth = player.getQuestState("197_SevenSignTheSacredBookOfSeal");
		
		if (st == null)
			return htmltext;
		
		if (npc.getNpcId() == WOOD)
		{
			switch (st.getState())
			{
				case State.CREATED:
					if (fifth != null && fifth.getState() == State.COMPLETED && player.getLevel() >= 79)
						htmltext = "32593-01.htm";
					else
					{
						htmltext = "32593-00.htm";
						st.exitQuest(true);
					}
					break;
				
				case State.STARTED:
					if (st.getInt("cond") == 1 || st.getInt("cond") == 2)
						htmltext = "32593-02.htm";
					
					else if (st.getInt("cond") == 3)
					{
						htmltext = "32593-04.htm";
						st.giveItems(BRACELET, 1);
						st.giveItems(AA, 1500000*AARATE);
						st.addExpAndSp(150000000,15000000);
						st.unset("cond");
						st.setState(State.COMPLETED);
						st.exitQuest(false);
						st.playSound("ItemSound.quest_finish");
					}
					break;
			}
		}
		
		else if (npc.getNpcId() == FRANZ)
		{
			if (st.getState() == State.STARTED)
			{
				if (st.getInt("cond") == 1)
					htmltext = "32597-01.htm";
				
				else if (st.getInt("cond") == 2)
					htmltext = "32597-06.htm";
				
				else if (st.getInt("cond") == 3)
					htmltext = "32597-11.htm";
			}
		}
		
		else if (npc.getNpcId() == JAINA)
		{
			if (st.getState() == State.STARTED)
			{
				if (st.getInt("cond") >= 1)
					htmltext = "32617-01.htm";
			}
		}
		
		return htmltext;
	}
	
	@Override
	public String onKill(L2Npc npc, L2PcInstance player, boolean isPet)
	{
		QuestState st = player.getQuestState(qn);
		
		if (st == null)
			return super.onKill(npc, player, isPet);
		
		if (npc.getNpcId() == SHILENSEVIL1 && st.getInt("cond") == 1)
		{
			ShilensevilOnSpawn = false;
			NpcSay packet = new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.S1_YOU_MAY_HAVE_WON_THIS_TIME_BUT_NEXT_TIME_I_WILL_SURELY_CAPTURE_YOU);
			packet.addStringParameter(player.getName().toString());
			npc.broadcastPacket(packet);
			NpcSay packet1 = new NpcSay(FRANZ, 0, FRANZ, NpcStringId.WELL_DONE_S1_YOUR_HELP_IS_MUCH_APPRECIATED);
			packet1.addStringParameter(player.getName().toString());
			npc.broadcastPacket(packet1);
			st.giveItems(SCULPTURE, 1);
			st.set("cond", "2");
			player.showQuestMovie(14);
		}
		
		return super.onKill(npc, player, isPet);
	}
	
	public Q198_SevenSignEmbryo(int questId, String name, String descr)
	{
		super(questId, name, descr);
		
		addStartNpc(WOOD);
		addTalkId(WOOD);
		addTalkId(FRANZ);
		addTalkId(JAINA);
		addKillId(SHILENSEVIL1);
		addKillId(SHILENSEVIL2);
		addKillId(SHILENSEVIL3);
		
		questItemIds = new int[]
		{ SCULPTURE };
	}
	
	public static void main(String[] args)
	{
		new Q198_SevenSignEmbryo(198, qn, "七封印，胚胎");
	}
}
