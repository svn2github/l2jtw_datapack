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
package ai.fantasy_isle;

import com.l2jserver.Config;
import com.l2jserver.gameserver.datatables.ItemTable;
import com.l2jserver.gameserver.instancemanager.HandysBlockCheckerManager;
import com.l2jserver.gameserver.instancemanager.HandysBlockCheckerManager.ArenaParticipantsHolder;
import com.l2jserver.gameserver.model.L2ItemInstance;
import com.l2jserver.gameserver.model.L2Object;
import com.l2jserver.gameserver.model.L2Skill;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.actor.instance.L2BlockInstance;
import com.l2jserver.gameserver.model.entity.BlockCheckerEngine;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.network.SystemMessageId2;
import com.l2jserver.gameserver.network.serverpackets.ExCubeGameChangePoints;
import com.l2jserver.gameserver.network.serverpackets.ExCubeGameChangeTimeToStart;
import com.l2jserver.gameserver.network.serverpackets.ExCubeGameExtendedChangePoints;
import com.l2jserver.gameserver.network.serverpackets.ExCubeGameRequestReady;
import com.l2jserver.gameserver.network.serverpackets.ExCubeGameTeamList;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;
import com.l2jserver.util.Rnd;

/**
 * @authors BiggBoss, Gigiikun
 */
public class HandysBlockCheckerEvent extends Quest 
{
	private static final String qn = "HandysBlockCheckerEvent";
	
	// Arena Managers
	private static final int A_MANAGER_1 = 32521;
	private static final int A_MANAGER_2 = 32522;
	private static final int A_MANAGER_3 = 32523;
	private static final int A_MANAGER_4 = 32524;
	// Block Id Used by retail
	private static final int BLOCK = 18672;
	
	@Override
	public String onFirstTalk(L2Npc npc, L2PcInstance player)
	{
		if (npc == null || player == null) return null;
		
		int npcId = npc.getNpcId();
		
		if(npcId == BLOCK) return null;
		
		int arena = -1;
		switch(npcId)
		{
		case A_MANAGER_1:
			arena = 0;
			break;
		case A_MANAGER_2:
			arena = 1;
			break;
		case A_MANAGER_3:
			arena = 2;
			break;
		case A_MANAGER_4:
			arena = 3;
			break;
		}
		
		if (arena != -1)
		{
			if (eventIsFull(arena))
			{
				player.sendPacket(new SystemMessage(SystemMessageId2.CANNOT_REGISTER_CAUSE_QUEUE_FULL));
				return null;
			}
			if (HandysBlockCheckerManager.getInstance().arenaIsBeingUsed(arena))
			{
				player.sendPacket(new SystemMessage(SystemMessageId2.MATCH_BEING_PREPARED_TRY_LATER));
				return null;
			}
			if(HandysBlockCheckerManager.getInstance().addPlayerToArena(player, arena))
			{
				ArenaParticipantsHolder holder = HandysBlockCheckerManager.getInstance().getHolder(arena);
				
				final ExCubeGameTeamList tl = new ExCubeGameTeamList(holder.getRedPlayers(), holder.getBluePlayers(), arena);
				
				player.sendPacket(tl);

				int countBlue = holder.getBlueTeamSize();
				int countRed = holder.getRedTeamSize();
				int minMembers = Config.MIN_BLOCK_CHECKER_TEAM_MEMBERS;
				
				if(countBlue >= minMembers && countRed >= minMembers)
				{
					holder.updateEvent();
					holder.broadCastPacketToTeam(new ExCubeGameRequestReady());
					holder.broadCastPacketToTeam(new ExCubeGameChangeTimeToStart(10));
				}
			}
		}
		return null;
	}
	
	@Override
	public final String onSkillSee(L2Npc npc, L2PcInstance player, L2Skill skill, L2Object[] targets, boolean isPet)
	{
		if(npc == null) return null;
		
		int arena = player.getBlockCheckerArena();
		if(arena == -1 || arena > 3) return null;
		
		if(npc instanceof L2BlockInstance && npc.getNpcId() == BLOCK && player.getTarget() == npc)
		{
			if(Math.sqrt(player.getPlanDistanceSq(npc)) > skill.getEffectRange())
				return null;
			
			if(skill.getId() == 5852 || skill.getId() == 5853)
			{
				L2BlockInstance block = (L2BlockInstance)npc;
				ArenaParticipantsHolder holder = HandysBlockCheckerManager.getInstance().getHolder(arena);
				
				if(holder.getPlayerTeam(player) == 0 && block.getColorEffect() == 0x00)
				{
					block.changeColor(player);
					increaseTeamPointsAndSend(player, holder.getEvent());
				}
				else if(holder.getPlayerTeam(player) == 1 && block.getColorEffect() == 0x53)
				{
					block.changeColor(player);
					increaseTeamPointsAndSend(player, holder.getEvent());
				}
				else
					return null;
				
				// 30% chance to drop the event items
				int random = Rnd.get(100);
				// Bond
				if(random > 69 && random <= 84)
					dropItem(block, 13787, holder.getEvent(), player);
				// Land Mine
				else if(random > 84)
					dropItem(block, 13788, holder.getEvent(), player);
			}
		}
		return null;
	}
	
	private void increaseTeamPointsAndSend(L2PcInstance player, BlockCheckerEngine eng)
	{
		int team = eng.getHolder().getPlayerTeam(player);
		eng.increasePlayerPoints(player, team);
		
		int timeLeft = (int)((eng.getStarterTime() - System.currentTimeMillis()) / 1000);
		boolean isRed = eng.getHolder().getRedPlayers().contains(player);
		
		ExCubeGameChangePoints changePoints = new ExCubeGameChangePoints(timeLeft, eng.getBluePoints(), eng.getRedPoints());
		ExCubeGameExtendedChangePoints secretPoints = new ExCubeGameExtendedChangePoints(timeLeft, eng.getBluePoints(), eng.getRedPoints(),
				isRed, player, eng.getPlayerPoints(player, isRed));
		
		eng.getHolder().broadCastPacketToTeam(changePoints);
		eng.getHolder().broadCastPacketToTeam(secretPoints);
	}
	
	private boolean eventIsFull(int arena)
	{
		if(HandysBlockCheckerManager.getInstance().getHolder(arena).getAllPlayers().size() == 12)
			return true;
		return false;
	}
	
	private void dropItem(L2BlockInstance block, int id, BlockCheckerEngine eng, L2PcInstance player)
	{
		L2ItemInstance drop = ItemTable.getInstance().createItem("Loot", id, 1, player, block);
		int x = block.getX() + Rnd.get(50);
		int y = block.getY() + Rnd.get(50);
		int z = block.getZ();
		
		drop.dropMe(block, x, y, z);
		
		eng.addNewDrop(drop);
	}
	
	public HandysBlockCheckerEvent(int questId, String name, String descr) 
	{
		super(questId, name, descr);
		addFirstTalkId(A_MANAGER_1);
		addFirstTalkId(A_MANAGER_2);
		addFirstTalkId(A_MANAGER_3);
		addFirstTalkId(A_MANAGER_4);
		addFirstTalkId(BLOCK);
		addSkillSeeId(BLOCK);
	}
	
	public static void main(String[] args)
	{
		if(!Config.ENABLE_BLOCK_CHECKER_EVENT)
		{
			_log.info("Handy's Block Checker Event is disabled");
			return;
		}
		
		new HandysBlockCheckerEvent(-1, qn, "Handy's Block Checker Event");
		HandysBlockCheckerManager.getInstance().startUpParticipantsQueue();
		_log.info("Handy's Block Checker Event is enabled");
	}
}