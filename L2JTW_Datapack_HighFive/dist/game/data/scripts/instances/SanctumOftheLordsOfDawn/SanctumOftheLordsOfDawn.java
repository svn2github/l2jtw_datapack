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
package instances.SanctumOftheLordsOfDawn;

import java.util.ArrayList;
import java.util.Collection;

import com.l2jserver.gameserver.ai.CtrlIntention;
import com.l2jserver.gameserver.instancemanager.InstanceManager;
import com.l2jserver.gameserver.instancemanager.InstanceManager.InstanceWorld;
import com.l2jserver.gameserver.model.L2CharPosition;
import com.l2jserver.gameserver.model.actor.L2Attackable;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2DoorInstance;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.network.NpcStringId;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.*;

/**
 * @author lewzer
 * @author d0S. Fixs by Plim
 * update by pmq 20-05-2011
 */
public class SanctumOftheLordsOfDawn extends Quest
{
	private class HSWorld extends InstanceWorld
	{
		public long[] storeTime = { 0, 0 }; // 0: instance start, 1: finish time
		
		L2Npc NPC_1;
		L2Npc NPC_2;
		L2Npc NPC_3;
		L2Npc NPC_4;
		L2Npc NPC_5;
		L2Npc NPC_6;
		L2Npc NPC_7;
		L2Npc NPC_8;
		L2Npc NPC_9;
		L2Npc NPC_10;
		L2Npc NPC_11;
		L2Npc NPC_12;
		L2Npc NPC_13;
		L2Npc NPC_14;
		L2Npc NPC_15;
		L2Npc NPC_16;
		L2Npc NPC_17;
		L2Npc NPC_18;
		L2Npc NPC_19;
		L2Npc NPC_20;
		L2Npc NPC_21;
		L2Npc NPC_22;
		L2Npc NPC_23;
		L2Npc NPC_24;
		L2Npc NPC_25;
		L2Npc NPC_26;
		L2Npc NPC_27;
		L2Npc NPC_28;
		L2Npc NPC_29;
		L2Npc NPC_30;
		L2Npc NPC_31;
		L2Npc NPC_32;
		L2Npc NPC_33;
		L2Npc NPC_34;
		L2Npc NPC_35;
		L2Npc S_C_NPC_1;
		L2Npc S_C_NPC_2;
		L2Npc S_C_NPC_3;
		L2Npc S_C_NPC_4;
		L2Npc S_C_NPC_5;
		L2Npc S_C_NPC_6;
		
		public HSWorld() {}
	}
	
	private static final String qn = "SanctumOftheLordsOfDawn";
	private static final int INSTANCEID = 111; // this is the client number
	
	// Items
	private static final int SHUNAIMAN_CONTRACT = 13823;
	private static final int IDENTITY_CARD = 13822;
	
	// NPCs
	private static final int LIGHTOFDAWN = 32575;  // 傳送師 黎明之光
	private static final int PWDEVICE    = 32577;  // 暗號輸入裝置
	private static final int DEVICE      = 32578;  // 身份確認裝置
	private static final int BLACK       = 32579;  // 傳送師 黎明的黑暗
	private static final int SHELF       = 32580;  // 黎明的書櫃
	private static final int PRIESTS     = 18828;  // 黎明的上位祭司
	private static final int GUARD       = 18834;  // 黎明的警衛隊員
	private static final int WPRIEST     = 18835;  // 黎明的警衛隊員
	private static final int WGUARD      = 27351;  // 黎明的警衛隊員
	
	private static final int ONE         = 17240001;
	private static final int TWO         = 17240003;
	private static final int THREE       = 17240005;
	
	// TRANSFORM SKILL
	private static final int GUARD_AMBUSH = 963;
	
	// GUARD_SKILL
	private static final int GUARD_SKILL  = 5978;
	
	// WALK TIMERS
	private static final int SHORT        = 3500;
	private static final int MID          = 6000;
	private static final int MID2         = 7500;
	private static final int LONG         = 14000;
	private static final int HUGE         = 29000;
	
	// MOVE PATHS
	private static final L2CharPosition MOVE_TO_1_A  = new L2CharPosition(-75022, 212090, -7317, 0);
	private static final L2CharPosition MOVE_TO_1_B  = new L2CharPosition(-74876, 212091, -7317, 0);
	private static final L2CharPosition MOVE_TO_2_A  = new L2CharPosition(-75334, 212109, -7317, 0);
	private static final L2CharPosition MOVE_TO_2_B  = new L2CharPosition(-75661, 212109, -7319, 0);
	private static final L2CharPosition MOVE_TO_3_A  = new L2CharPosition(-74205, 212102, -7319, 0);
	private static final L2CharPosition MOVE_TO_3_B  = new L2CharPosition(-74576, 212102, -7319, 0);
	private static final L2CharPosition MOVE_TO_4_A  = new L2CharPosition(-75228, 211458, -7317, 0);
	private static final L2CharPosition MOVE_TO_4_B  = new L2CharPosition(-75233, 211125, -7319, 0);
	private static final L2CharPosition MOVE_TO_5_A  = new L2CharPosition(-74673, 211129, -7321, 0);
	private static final L2CharPosition MOVE_TO_5_B  = new L2CharPosition(-74686, 211494, -7321, 0);
	private static final L2CharPosition MOVE_TO_6_A  = new L2CharPosition(-75230, 210171, -7415, 0);
	private static final L2CharPosition MOVE_TO_6_B  = new L2CharPosition(-74689, 210157, -7418, 0);
	private static final L2CharPosition MOVE_TO_7_A  = new L2CharPosition(-74685, 209824, -7415, 0);
	private static final L2CharPosition MOVE_TO_7_B  = new L2CharPosition(-75215, 209817, -7415, 0);
	private static final L2CharPosition MOVE_TO_8_A  = new L2CharPosition(-75545, 207553, -7511, 0);
	private static final L2CharPosition MOVE_TO_8_B  = new L2CharPosition(-75558, 208834, -7514, 0);
	private static final L2CharPosition MOVE_TO_9_A  = new L2CharPosition(-75412, 207137, -7511, 0);
	private static final L2CharPosition MOVE_TO_9_B  = new L2CharPosition(-75691, 207140, -7511, 0);
	private static final L2CharPosition MOVE_TO_10_A = new L2CharPosition(-74512, 208266, -7511, 0);
	private static final L2CharPosition MOVE_TO_10_B = new L2CharPosition(-74197, 208271, -7511, 0);
	private static final L2CharPosition MOVE_TO_11_A = new L2CharPosition(-74515, 207060, -7509, 0);
	private static final L2CharPosition MOVE_TO_11_B = new L2CharPosition(-74196, 207061, -7509, 0);
	private static final L2CharPosition MOVE_TO_12_A = new L2CharPosition(-74241, 206518, -7511, 0);
	private static final L2CharPosition MOVE_TO_12_B = new L2CharPosition(-75654, 206518, -7511, 0);
	private static final L2CharPosition MOVE_TO_13_A = new L2CharPosition(-76632, 207850, -7607, 0);
	private static final L2CharPosition MOVE_TO_13_B = new L2CharPosition(-76374, 207850, -7607, 0);
	private static final L2CharPosition MOVE_TO_14_A = new L2CharPosition(-76374, 208206, -7606, 0);
	private static final L2CharPosition MOVE_TO_14_B = new L2CharPosition(-76632, 208205, -7606, 0);
	private static final L2CharPosition MOVE_TO_15_A = new L2CharPosition(-76371, 208853, -7606, 0);
	private static final L2CharPosition MOVE_TO_15_B = new L2CharPosition(-76638, 208854, -7606, 0);
	private static final L2CharPosition MOVE_TO_16_A = new L2CharPosition(-76930, 209445, -7606, 0);
	private static final L2CharPosition MOVE_TO_16_B = new L2CharPosition(-76930, 209199, -7606, 0);
	private static final L2CharPosition MOVE_TO_17_A = new L2CharPosition(-77180, 209436, -7607, 0);
	private static final L2CharPosition MOVE_TO_17_B = new L2CharPosition(-77180, 209197, -7607, 0);
	private static final L2CharPosition MOVE_TO_18_A = new L2CharPosition(-78038, 208470, -7706, 0);
	private static final L2CharPosition MOVE_TO_18_B = new L2CharPosition(-77390, 208470, -7704, 0);
	private static final L2CharPosition MOVE_TO_19_A = new L2CharPosition(-77691, 208131, -7704, 0);
	private static final L2CharPosition MOVE_TO_19_B = new L2CharPosition(-77702, 207454, -7678, 0);
	private static final L2CharPosition MOVE_TO_20_A = new L2CharPosition(-78102, 208037, -7701, 0);
	private static final L2CharPosition MOVE_TO_20_B = new L2CharPosition(-78453, 208037, -7703, 0);
	private static final L2CharPosition MOVE_TO_21_A = new L2CharPosition(-77287, 208041, -7701, 0);
	private static final L2CharPosition MOVE_TO_21_B = new L2CharPosition(-76955, 208030, -7703, 0);
	private static final L2CharPosition MOVE_TO_22_A = new L2CharPosition(-78925, 206091, -7893, 0);
	private static final L2CharPosition MOVE_TO_22_B = new L2CharPosition(-78713, 206295, -7893, 0);
	private static final L2CharPosition MOVE_TO_23_A = new L2CharPosition(-79361, 206329, -7893, 0);
	private static final L2CharPosition MOVE_TO_23_B = new L2CharPosition(-79355, 206670, -7893, 0);
	private static final L2CharPosition MOVE_TO_24_A = new L2CharPosition(-79078, 206234, -7893, 0);
	private static final L2CharPosition MOVE_TO_24_B = new L2CharPosition(-78866, 206446, -7893, 0);
	private static final L2CharPosition MOVE_TO_25_A = new L2CharPosition(-79646, 206245, -7893, 0);
	private static final L2CharPosition MOVE_TO_25_B = new L2CharPosition(-79839, 206452, -7893, 0);
	private static final L2CharPosition MOVE_TO_26_A = new L2CharPosition(-79789, 206100, -7893, 0);
	private static final L2CharPosition MOVE_TO_26_B = new L2CharPosition(-79993, 206309, -7893, 0);
	private static final L2CharPosition MOVE_TO_27_A = new L2CharPosition(-79782, 205610, -7893, 0);
	private static final L2CharPosition MOVE_TO_27_B = new L2CharPosition(-79993, 205402, -7893, 0);
	private static final L2CharPosition MOVE_TO_28_A = new L2CharPosition(-79657, 205469, -7893, 0);
	private static final L2CharPosition MOVE_TO_28_B = new L2CharPosition(-79862, 205266, -7893, 0);
	private static final L2CharPosition MOVE_TO_29_A = new L2CharPosition(-79362, 205383, -7893, 0);
	private static final L2CharPosition MOVE_TO_29_B = new L2CharPosition(-79361, 204984, -7893, 0);
	private static final L2CharPosition MOVE_TO_30_A = new L2CharPosition(-78984, 205568, -7893, 0);
	private static final L2CharPosition MOVE_TO_30_B = new L2CharPosition(-78769, 205351, -7893, 0);
	private static final L2CharPosition MOVE_TO_31_A = new L2CharPosition(-79118, 205436, -7893, 0);
	private static final L2CharPosition MOVE_TO_31_B = new L2CharPosition(-78905, 205223, -7893, 0);
	private static final L2CharPosition MOVE_TO_32_A = new L2CharPosition(-81948, 205857, -7989, 0);
	private static final L2CharPosition MOVE_TO_32_B = new L2CharPosition(-81250, 205857, -7989, 0);
	private static final L2CharPosition MOVE_TO_33_A = new L2CharPosition(-74948, 206370, -7514, 0);
	private static final L2CharPosition MOVE_TO_33_B = new L2CharPosition(-74950, 206681, -7514, 0);
	private static final L2CharPosition MOVE_TO_34_A = new L2CharPosition(-77053, 207113, -7703, 0);
	private static final L2CharPosition MOVE_TO_34_B = new L2CharPosition(-77259, 207353, -7710, 0);
	private static final L2CharPosition MOVE_TO_35_A = new L2CharPosition(-77048, 207800, -7709, 0);
	private static final L2CharPosition MOVE_TO_35_B = new L2CharPosition(-78324, 207800, -7709, 0);
	
	protected static class teleCoord
	{
		int instanceId;
		int x;
		int y;
		int z;
	}
	
	private void teleportplayer(L2PcInstance player, teleCoord teleto)
	{
		player.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
		player.setInstanceId(teleto.instanceId);
		player.teleToLocation(teleto.x, teleto.y, teleto.z);
		return;
	}
	
	protected void exitInstance(L2PcInstance player, teleCoord tele)
	{
		player.setInstanceId(0);
		player.teleToLocation(-12585, 122305, -2989);
	}
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		if (event.equalsIgnoreCase("Group_SHORT_B"))
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				world.NPC_1.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_1_B);
				startQuestTimer("Group_SHORT_A", SHORT, world.NPC_1, null);
			}
		}
		else if (event.equalsIgnoreCase("Group_SHORT_A"))
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				world.NPC_1.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_1_A);
				startQuestTimer("Group_SHORT_B", SHORT, world.NPC_1, null);
			}
		}
		if (event.equalsIgnoreCase("Group_MID_B"))
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				world.NPC_2.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_2_B);
				world.NPC_3.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_3_B);
				world.NPC_4.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_4_B);
				world.NPC_5.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_5_B);
				world.NPC_9.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_9_B);
				world.NPC_10.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_10_B);
				world.NPC_11.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_11_B);
				world.NPC_13.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_13_B);
				world.NPC_15.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_15_B);
				world.NPC_16.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_16_B);
				world.NPC_20.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_20_B);
				world.NPC_21.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_21_B);
				world.NPC_22.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_22_B);
				world.NPC_23.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_23_B);
				world.NPC_26.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_26_B);
				world.NPC_27.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_27_B);
				world.NPC_29.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_29_B);
				world.NPC_30.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_30_B);
				world.NPC_33.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_33_B);
				startQuestTimer("Group_MID_A", MID, world.NPC_2, null);
			}
		}
		else if (event.equalsIgnoreCase("Group_MID_A"))
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				world.NPC_2.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_2_A);
				world.NPC_3.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_3_A);
				world.NPC_4.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_4_A);
				world.NPC_5.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_5_A);
				world.NPC_9.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_9_A);
				world.NPC_10.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_10_A);
				world.NPC_11.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_11_A);
				world.NPC_13.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_13_A);
				world.NPC_15.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_15_A);
				world.NPC_16.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_16_A);
				world.NPC_20.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_20_A);
				world.NPC_21.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_21_A);
				world.NPC_22.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_22_A);
				world.NPC_23.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_23_A);
				world.NPC_26.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_26_A);
				world.NPC_27.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_27_A);
				world.NPC_29.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_29_A);
				world.NPC_30.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_30_A);
				world.NPC_33.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_33_A);
				startQuestTimer("Group_MID_B", MID, world.NPC_2, null);
			}
		}
		if (event.equalsIgnoreCase("Group_MID2_B"))
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				world.NPC_14.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_14_B);
				world.NPC_17.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_17_B);
				world.NPC_24.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_24_B);
				world.NPC_25.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_25_B);
				world.NPC_28.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_28_B);
				world.NPC_31.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_31_B);
				world.NPC_34.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_34_B);
				startQuestTimer("Group_MID2_A", MID2, world.NPC_14, null);
			}
		}
		else if (event.equalsIgnoreCase("Group_MID2_A"))
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				world.NPC_14.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_14_A);
				world.NPC_17.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_17_A);
				world.NPC_24.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_24_A);
				world.NPC_25.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_25_A);
				world.NPC_28.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_28_A);
				world.NPC_31.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_31_A);
				world.NPC_34.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_34_A);
				startQuestTimer("Group_MID2_B", MID2, world.NPC_14, null);
			}
		}
		if (event.equalsIgnoreCase("Group_LONG_B"))
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				world.NPC_6.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_6_B);
				world.NPC_7.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_7_B);
				world.NPC_18.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_18_B);
				world.NPC_19.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_19_B);
				world.NPC_32.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_32_B);
				startQuestTimer("Group_LONG_A", LONG, world.NPC_6, null);
			}
		}
		else if (event.equalsIgnoreCase("Group_LONG_A"))
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				world.NPC_6.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_6_A);
				world.NPC_7.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_7_A);
				world.NPC_18.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_18_A);
				world.NPC_19.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_19_A);
				world.NPC_32.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_32_A);
				startQuestTimer("Group_LONG_B", LONG, world.NPC_6, null);
			}
		}
		if (event.equalsIgnoreCase("Group_HUGE_A"))
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				world.NPC_12.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_12_A);
				world.NPC_8.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_8_A);
				world.NPC_35.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_35_A);
				startQuestTimer("Group_HUGE_B", HUGE, world.NPC_12, null);
			}
		}
		else if (event.equalsIgnoreCase("Group_HUGE_B"))
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				world.NPC_12.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_12_B);
				world.NPC_8.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_8_B);
				world.NPC_35.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO, MOVE_TO_35_B);
				startQuestTimer("Group_HUGE_A", HUGE, world.NPC_12, null);
			}
		}
		/*else if (event.equalsIgnoreCase("circle"))
		{
			InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmpworld instanceof HSWorld)
			{
				HSWorld world = (HSWorld) tmpworld;
				// STATIC NPCS IN CIRCLE
				world.S_C_NPC_1 = addSpawn(PRIESTS, -79225, 205933, -7908, 38276, false, 0, false, world.instanceId);
				world.S_C_NPC_1.setIsNoRndWalk(true);
				world.S_C_NPC_2 = addSpawn(PRIESTS, -79229, 205780, -7908, 27559, false, 0, false, world.instanceId);
				world.S_C_NPC_2.setIsNoRndWalk(true);
				world.S_C_NPC_3 = addSpawn(PRIESTS, -79360, 205705, -7908, 16383, false, 0, false, world.instanceId);
				world.S_C_NPC_3.setIsNoRndWalk(true);
				world.S_C_NPC_4 = addSpawn(PRIESTS, -79491, 205780, -7908, 5208, false, 0, false, world.instanceId);
				world.S_C_NPC_4.setIsNoRndWalk(true);
				world.S_C_NPC_5 = addSpawn(PRIESTS, -79488, 205929, -7908, 60699, false, 0, false, world.instanceId);
				world.S_C_NPC_5.setIsNoRndWalk(true);
				world.S_C_NPC_6 = addSpawn(PRIESTS, -79361, 206006, -7908, 48480, false, 0, false, world.instanceId);
				world.S_C_NPC_6.setIsNoRndWalk(true);
			}
		}*/
		else if (event.equalsIgnoreCase("password"))
		{
			InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
			openDoor(player, world.instanceId);
			return "32577-03.htm";
		}
		else if (event.equalsIgnoreCase("nopass"))
		{
			InstanceWorld tmworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
			if (tmworld instanceof HSWorld)
			{
				player.teleToLocation(-78198, 205852, -7865);
				return "32577-02.htm";
			}
		}
		else if (event.equalsIgnoreCase("sc2"))
		{
			return "32580-02.htm";
		}
		else if (event.equalsIgnoreCase("sc"))
		{
			QuestState st = player.getQuestState(qn);
			if (st == null)
				st = newQuestState(player);
			
			if (st.getQuestItemsCount(SHUNAIMAN_CONTRACT) == 0)
			{
				st.giveItems(SHUNAIMAN_CONTRACT,1);
				st.playSound("ItemSound.quest_itemget");
				return "32580-03.htm";
			}
			return "";
		}
		else if (event.equalsIgnoreCase("reTele"))
		{
			((L2Attackable) npc).clearAggroList();
			player.teleToLocation(-75711, 213421, -7125);
			//player.teleToLocation(-74959, 209294, -7459);
			//player.teleToLocation(-77705, 208898, -7647);
			return null;
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
				player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.ALREADY_ENTERED_ANOTHER_INSTANCE_CANT_ENTER));
				return 0;
			}
			teleto.instanceId = world.instanceId;
			teleportplayer(player, teleto);
			return instanceId;
		}
		//New instance
		instanceId = InstanceManager.getInstance().createDynamicInstance(template);
		world = new HSWorld();
		world.instanceId = instanceId;
		world.templateId = INSTANCEID;
		world.status = 0;
		((HSWorld) world).storeTime[0] = System.currentTimeMillis();
		InstanceManager.getInstance().addWorld(world);
		spawnState((HSWorld) world);
		_log.info("SevenSign 4th quest started " + template + " Instance: " + instanceId + " created by player: " + player.getName());
		// teleport players
		teleto.instanceId = instanceId;
		teleportplayer(player, teleto);
		world.allowed.add(player.getObjectId());
		return instanceId;
	}
	
	private void spawnState(HSWorld world)
	{
		// STATIC NPC's
		L2Npc S_NPC_0 = addSpawn(DEVICE, -75710, 213535, -7126, 0, false, 0, false, world.instanceId);
		S_NPC_0.setIsNoRndWalk(true);
		L2Npc S_NPC_1 = addSpawn(DEVICE, -78288, 205747, -7889, 0, false, 0, false, world.instanceId);
		S_NPC_1.setIsNoRndWalk(true);
		L2Npc S_NPC_2 = addSpawn(PWDEVICE, -80133, 205743, -7888, 0, false, 0, false, world.instanceId);
		S_NPC_2.setIsNoRndWalk(true);
		L2Npc S_NPC_3 = addSpawn(SHELF, -81386, 205562, -7992, 0, false, 0, false, world.instanceId);
		S_NPC_3.setIsNoRndWalk(true);
		L2Npc S_NPC_4 = addSpawn(BLACK, -76003, 213413, -7124, 0, false, 0, false, world.instanceId);
		S_NPC_4.setIsNoRndWalk(true);
		L2Npc S_NPC_5 = addSpawn(GUARD, -74921, 213450, -7222, 0, false, 0, false, world.instanceId);
		S_NPC_5.setIsNoRndWalk(true);
		L2Npc S_NPC_7 = addSpawn(WPRIEST, -74951, 211621, -7317, 0, false, 0, false, world.instanceId);
		S_NPC_7.setIsNoRndWalk(true);
		L2Npc S_NPC_8 = addSpawn(WGUARD, -75329, 209990, -7392, 0, false, 0, false, world.instanceId);
		S_NPC_8.setIsNoRndWalk(true);
		L2Npc S_NPC_9 = addSpawn(WGUARD, -74568, 209981, -7390, 0, false, 0, false, world.instanceId);
		S_NPC_9.setIsNoRndWalk(true);
		L2Npc S_NPC_10 = addSpawn(WPRIEST, -77167, 207637, -7703, 0, false, 0, false, world.instanceId);
		S_NPC_10.setIsNoRndWalk(true);
		L2Npc S_NPC_11 = addSpawn(WGUARD, -74276, 208794, -7486, 0, false, 0, false, world.instanceId);
		S_NPC_11.setIsNoRndWalk(true);
		L2Npc S_NPC_12 = addSpawn(GUARD, -74959, 207618, -7486, 0, false, 0, false, world.instanceId);
		S_NPC_12.setIsNoRndWalk(true);
		L2Npc S_NPC_13 = addSpawn(WGUARD, -77701, 208305, -7701, 0, false, 0, false, world.instanceId);
		S_NPC_13.setIsNoRndWalk(true);
		L2Npc S_NPC_14 = addSpawn(WGUARD, -77702, 207286, -7704, 0, false, 0, false, world.instanceId);
		S_NPC_14.setIsNoRndWalk(true);
		L2Npc S_NPC_15 = addSpawn(WPRIEST, -78338, 207149, -7703, 0, false, 0, false, world.instanceId);
		S_NPC_15.setIsNoRndWalk(true);
		L2Npc S_NPC_16 = addSpawn(WPRIEST, -78108, 207388, -7701, 0, false, 0, false, world.instanceId);
		S_NPC_16.setIsNoRndWalk(true);
		L2Npc S_NPC_17 = addSpawn(WPRIEST, -77548, 207131, -7703, 0, false, 0, false, world.instanceId);
		S_NPC_17.setIsNoRndWalk(true);
		L2Npc S_NPC_18 = addSpawn(WPRIEST, -77720, 207512, -7701, 0, false, 0, false, world.instanceId);
		S_NPC_18.setIsNoRndWalk(true);
		L2Npc S_NPC_19 = addSpawn(WGUARD, -78878, 206292, -7894, 0, false, 0, false, world.instanceId);
		S_NPC_19.setIsNoRndWalk(true);
		L2Npc S_NPC_20 = addSpawn(WGUARD, -79800, 206274, -7894, 0, false, 0, false, world.instanceId);
		S_NPC_20.setIsNoRndWalk(true);
		L2Npc S_NPC_21 = addSpawn(WGUARD, -79809, 205446, -7894, 0, false, 0, false, world.instanceId);
		S_NPC_21.setIsNoRndWalk(true);
		L2Npc S_NPC_22 = addSpawn(WGUARD, -78917, 205414, -7894, 0, false, 0, false, world.instanceId);
		S_NPC_22.setIsNoRndWalk(true);
		L2Npc S_NPC_23 = addSpawn(WGUARD, -74575, 206628, -7511, 0, false, 0, false, world.instanceId);
		S_NPC_23.setIsNoRndWalk(true);
		L2Npc S_NPC_24 = addSpawn(WGUARD, -75434, 206743, -7511, 0, false, 0, false, world.instanceId);
		S_NPC_24.setIsNoRndWalk(true);
		L2Npc S_NPC_25 = addSpawn(GUARD, -75448, 208164, -7510, 0, false, 0, false, world.instanceId);
		S_NPC_25.setIsNoRndWalk(true);
		L2Npc S_NPC_26 = addSpawn(GUARD, -75655, 208175, -7512, 0, false, 0, false, world.instanceId);
		S_NPC_26.setIsNoRndWalk(true);
		L2Npc S_NPC_27 = addSpawn(WGUARD, -81531, 205555, -7989, 0, false, 0, false, world.instanceId);
		S_NPC_27.setIsNoRndWalk(true);
		L2Npc S_NPC_28 = addSpawn(WGUARD, -81531, 206170, -7989, 0, false, 0, false, world.instanceId);
		S_NPC_28.setIsNoRndWalk(true);
		L2Npc S_NPC_29 = addSpawn(WPRIEST, -77239, 208298, -7710, 0, false, 0, false, world.instanceId);
		S_NPC_29.setIsNoRndWalk(true);
		
		// WALKING NPC's
		world.NPC_1 = addSpawn(WPRIEST, -75022, 212090, -7317, 0, false, 0, false, world.instanceId);
		world.NPC_2 = addSpawn(WPRIEST, -75334, 212109, -7317, 0, false, 0, false, world.instanceId);
		world.NPC_3 = addSpawn(WPRIEST, -74205, 212102, -7319, 0, false, 0, false, world.instanceId);
		world.NPC_4 = addSpawn(WPRIEST, -75228, 211458, -7319, 0, false, 0, false, world.instanceId);
		world.NPC_5 = addSpawn(WPRIEST, -74673, 211129, -7321, 0, false, 0, false, world.instanceId);
		world.NPC_6 = addSpawn(GUARD, -75215, 210171, -7415, 0, false, 0, false, world.instanceId);
		world.NPC_7 = addSpawn(GUARD, -74685, 209824, -7415, 0, false, 0, false, world.instanceId);
		world.NPC_8 = addSpawn(GUARD, -75545, 207553, -7511, 0, false, 0, false, world.instanceId);
		world.NPC_9 = addSpawn(GUARD, -75412, 207137, -7511, 0, false, 0, false, world.instanceId);
		world.NPC_10 = addSpawn(GUARD, -74512, 208266, -7511, 0, false, 0, false, world.instanceId);
		world.NPC_11 = addSpawn(GUARD, -74515, 207060, -7509, 0, false, 0, false, world.instanceId);
		world.NPC_12 = addSpawn(GUARD, -74241, 206518, -7511, 0, false, 0, false, world.instanceId);
		world.NPC_13 = addSpawn(GUARD, -76374, 207850, -7606, 0, false, 0, false, world.instanceId);
		world.NPC_14 = addSpawn(GUARD, -76374, 208206, -7606, 0, false, 0, false, world.instanceId);
		world.NPC_15 = addSpawn(GUARD, -76371, 208853, -7606, 0, false, 0, false, world.instanceId);
		world.NPC_16 = addSpawn(GUARD, -76930, 209445, -7606, 0, false, 0, false, world.instanceId);
		world.NPC_17 = addSpawn(GUARD, -77180, 209436, -7607, 0, false, 0, false, world.instanceId);
		world.NPC_18 = addSpawn(WPRIEST, -78038, 208470, -7706, 0, false, 0, false, world.instanceId);
		world.NPC_19 = addSpawn(WPRIEST, -77691, 208131, -7704, 0, false, 0, false, world.instanceId);
		world.NPC_20 = addSpawn(WPRIEST, -78102, 208037, -7701, 0, false, 0, false, world.instanceId);
		world.NPC_21 = addSpawn(WPRIEST, -77287, 208041, -7701, 0, false, 0, false, world.instanceId);
		world.NPC_22 = addSpawn(GUARD, -78925, 206091, -7893, 0, false, 0, false, world.instanceId);
		world.NPC_23 = addSpawn(GUARD, -79361, 206329, -7893, 0, false, 0, false, world.instanceId);
		world.NPC_24 = addSpawn(GUARD, -79078, 206234, -7893, 0, false, 0, false, world.instanceId);
		world.NPC_25 = addSpawn(GUARD, -79646, 206245, -7893, 0, false, 0, false, world.instanceId);
		world.NPC_26 = addSpawn(GUARD, -79789, 206100, -7893, 0, false, 0, false, world.instanceId);
		world.NPC_27 = addSpawn(GUARD, -79782, 205610, -7893, 0, false, 0, false, world.instanceId);
		world.NPC_28 = addSpawn(GUARD, -79657, 205469, -7893, 0, false, 0, false, world.instanceId);
		world.NPC_29 = addSpawn(GUARD, -79362, 205383, -7893, 0, false, 0, false, world.instanceId);
		world.NPC_30 = addSpawn(GUARD, -78984, 205568, -7893, 0, false, 0, false, world.instanceId);
		world.NPC_31 = addSpawn(GUARD, -79118, 205436, -7893, 0, false, 0, false, world.instanceId);
		world.NPC_32 = addSpawn(WGUARD, -81948, 205857, -7989, 0, false, 0, false, world.instanceId);
		world.NPC_33 = addSpawn(GUARD, -74948, 206370, -7514, 0, false, 0, false, world.instanceId);
		world.NPC_34 = addSpawn(WPRIEST, -77053, 207113, -7703, 0, false, 0, false, world.instanceId);
		world.NPC_35 = addSpawn(WPRIEST, -77048, 207800, -7709, 0, false, 0, false, world.instanceId);
		
		// STATIC NPCS IN CIRCLE
		world.S_C_NPC_1 = addSpawn(PRIESTS, -79225, 205933, -7908, 38276, false, 0, false, world.instanceId);
		world.S_C_NPC_1.setIsNoRndWalk(true);
		world.S_C_NPC_2 = addSpawn(PRIESTS, -79229, 205780, -7908, 27559, false, 0, false, world.instanceId);
		world.S_C_NPC_2.setIsNoRndWalk(true);
		world.S_C_NPC_3 = addSpawn(PRIESTS, -79360, 205705, -7908, 16383, false, 0, false, world.instanceId);
		world.S_C_NPC_3.setIsNoRndWalk(true);
		world.S_C_NPC_4 = addSpawn(PRIESTS, -79491, 205780, -7908, 5208, false, 0, false, world.instanceId);
		world.S_C_NPC_4.setIsNoRndWalk(true);
		world.S_C_NPC_5 = addSpawn(PRIESTS, -79488, 205929, -7908, 60699, false, 0, false, world.instanceId);
		world.S_C_NPC_5.setIsNoRndWalk(true);
		world.S_C_NPC_6 = addSpawn(PRIESTS, -79361, 206006, -7908, 48480, false, 0, false, world.instanceId);
		world.S_C_NPC_6.setIsNoRndWalk(true);
		
		// START TIMERS
		startQuestTimer("Group_SHORT_B", SHORT, world.NPC_1, null);
		startQuestTimer("Group_MID_B", MID, world.NPC_2, null);
		startQuestTimer("Group_MID2_B", MID2, world.NPC_2, null);
		startQuestTimer("Group_LONG_B", LONG, world.NPC_6, null);
		startQuestTimer("Group_HUGE_B", HUGE, world.NPC_12, null);
	}
	
	private synchronized void openDoor(L2PcInstance player, int instanceId)
	{
		final ArrayList<L2DoorInstance> doors = InstanceManager.getInstance().getInstance(instanceId).getDoors();
		for (L2DoorInstance door : doors)
		{
			switch (door.getDoorId())
			{
				case ONE:
					Collection<L2PcInstance> knows = door.getKnownList().getKnownPlayersInRadius(500);
					for (L2PcInstance pc : knows)
					{
						if (pc == player && !door.getOpen())
						{
							player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.USING_INVISIBLE_SKILL_SNEAK_IN));
							player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.MALE_GUARDS_CAN_DETECT_FEMALE_CANT));
							player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.FEMALE_GUARDS_NOTICE_FROM_FAR_AWAY_BEWARE));
							door.openMe();
						}
						else
						{
							player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.USING_INVISIBLE_SKILL_SNEAK_IN));
							player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.MALE_GUARDS_CAN_DETECT_FEMALE_CANT));
							player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.FEMALE_GUARDS_NOTICE_FROM_FAR_AWAY_BEWARE));
						}
					}
					break;
				case TWO:
					knows = door.getKnownList().getKnownPlayersInRadius(500);
					for (L2PcInstance pc : knows)
					{
						if (pc == player && !door.getOpen())
						{
							player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.DOOR_IS_ENTRANCE_APPROACH_DEVICE));
							door.openMe();
							player.showQuestMovie(11);
							//startQuestTimer("circle", 30000, null, null);
						}
						else
						{
							player.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.DOOR_IS_ENTRANCE_APPROACH_DEVICE));
							door.openMe();
							player.showQuestMovie(11);
						}
					}
					break;
				case THREE:
					knows = door.getKnownList().getKnownPlayersInRadius(500);
					for (L2PcInstance pc : knows)
					{
						if (pc == player && !door.getOpen())
							door.openMe();
					}
					break;
			}
		}
	}
	
	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		QuestState st = player.getQuestState(qn);
		if (st == null)
			st = newQuestState(player);
		
		switch (npc.getNpcId())
		{
			case LIGHTOFDAWN:
				if (player.getTransformationId() == 113 && st.hasQuestItems(IDENTITY_CARD))
				{
					teleCoord tele = new teleCoord();
					tele.x = -76156;
					tele.y = 213409;
					tele.z = -7120;
					enterInstance(player, "SanctumoftheLordsofDawn.xml", tele);
					return "32575-02.htm";
				}
				return "32575-01.htm";
			case DEVICE:
				if (player.getTransformationId() == 113 && st.hasQuestItems(IDENTITY_CARD))
				{
					InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
					openDoor(player, world.instanceId);
					return "32578-03.htm";
				}
				return null;
			case PWDEVICE:
				if (player.getTransformationId() == 113 && st.hasQuestItems(IDENTITY_CARD))
				{
					return "32577-01.htm";
				}
				return null;
			case BLACK:
				if (player.getTransformationId() == 113 && st.hasQuestItems(IDENTITY_CARD))
				{
					InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
					world.allowed.remove(world.allowed.indexOf(player.getObjectId()));
					teleCoord tele = new teleCoord();
					tele.instanceId = 0;
					exitInstance(player, tele);
					return "32579-01.htm";
				}
				return null;
			case SHELF:
				if (player.getTransformationId() == 113 && st.hasQuestItems(IDENTITY_CARD))
				{
					InstanceWorld world = InstanceManager.getInstance().getPlayerWorld(player);
					world.allowed.remove(world.allowed.indexOf(player.getObjectId()));
					teleCoord tele = new teleCoord();
					tele.instanceId = 0;
					exitInstance(player, tele);
					return "32580-04.htm";
				}
				return null;
		}
		return "";
	}
	
	@Override
	public String onAggroRangeEnter(L2Npc npc, L2PcInstance player, boolean isPet)
	{
		InstanceWorld tmpworld = InstanceManager.getInstance().getWorld(npc.getInstanceId());
		if (tmpworld instanceof HSWorld)
		{
			if (npc.getNpcId() == WGUARD)
			{
				if (player.getFirstEffect(GUARD_AMBUSH) == null)
				{
					((L2Attackable) npc).abortAttack();
					npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.WHO_ARE_YOU_A_NEW_FACE_LIKE_YOU_CANT_APPROACH_THIS_PLACE));
					npc.broadcastPacket(new MagicSkillUse(npc, player, GUARD_SKILL, 1, 2500, 1));
					npc.disableCoreAI(true);
					startQuestTimer("reTele", 3000, npc, player);
				}
			}
			if (npc.getNpcId() == WPRIEST)
			{
				((L2Attackable) npc).abortAttack();
				npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.HOW_DARE_YOU_INTRUDE_WITH_THAT_TRANSFORMATION_GET_LOST));
				npc.broadcastPacket(new MagicSkillUse(npc, player, GUARD_SKILL, 1, 2500, 1));
				npc.disableCoreAI(true);
				startQuestTimer("reTele", 3000, npc, player);
			}
			if (npc.getNpcId() == GUARD)
			{
				((L2Attackable) npc).abortAttack();
				npc.broadcastPacket(new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.INTRUDER_PROTECT_THE_PRIESTS_OF_DAWN));
				npc.broadcastPacket(new MagicSkillUse(npc, player, GUARD_SKILL, 1, 2500, 1));
				npc.disableCoreAI(true);
				startQuestTimer("reTele", 3000, npc, player);
			}
		}
		
		return null;
	}
	
	public SanctumOftheLordsOfDawn(int questId, String name, String descr)
	{
		super(questId, name, descr);
		
		addStartNpc(LIGHTOFDAWN);
		addTalkId(LIGHTOFDAWN);
		addTalkId(DEVICE);
		addTalkId(PWDEVICE);
		addTalkId(BLACK);
		addTalkId(SHELF);
		addAggroRangeEnterId(GUARD);
		addAggroRangeEnterId(WPRIEST);
		addAggroRangeEnterId(WGUARD);
	}
	
	public static void main(String[] args)
	{
		// now call the constructor (starts up the)
		new SanctumOftheLordsOfDawn(-1, qn, "instances");
	}
}