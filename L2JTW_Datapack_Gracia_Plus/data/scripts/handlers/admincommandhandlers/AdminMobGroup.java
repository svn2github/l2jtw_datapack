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
package handlers.admincommandhandlers;

import com.l2jserver.gameserver.datatables.NpcTable;
import com.l2jserver.gameserver.handler.IAdminCommandHandler;
import com.l2jserver.gameserver.model.L2World;
import com.l2jserver.gameserver.model.MobGroup;
import com.l2jserver.gameserver.model.MobGroupTable;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.MagicSkillUse;
import com.l2jserver.gameserver.network.serverpackets.SetupGauge;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;
import com.l2jserver.gameserver.templates.chars.L2NpcTemplate;
import com.l2jserver.gameserver.util.Broadcast;
import com.l2jserver.gameserver.datatables.MessageTable;
import com.l2jserver.gameserver.model.L2CoreMessage;

/**
 * @author littlecrow
 * Admin commands handler for controllable mobs
 */
public class AdminMobGroup implements IAdminCommandHandler
{
	private static final String[] ADMIN_COMMANDS =
	{
		"admin_mobmenu",
		"admin_mobgroup_list",
		"admin_mobgroup_create",
		"admin_mobgroup_remove",
		"admin_mobgroup_delete",
		"admin_mobgroup_spawn",
		"admin_mobgroup_unspawn",
		"admin_mobgroup_kill",
		"admin_mobgroup_idle",
		"admin_mobgroup_attack",
		"admin_mobgroup_rnd",
		"admin_mobgroup_return",
		"admin_mobgroup_follow",
		"admin_mobgroup_casting",
		"admin_mobgroup_nomove",
		"admin_mobgroup_attackgrp",
		"admin_mobgroup_invul"
	};
	
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		if (command.equals("admin_mobmenu"))
		{
			showMainPage(activeChar, command);
			return true;
		}
		else if (command.equals("admin_mobgroup_list"))
			showGroupList(activeChar);
		else if (command.startsWith("admin_mobgroup_create"))
			createGroup(command, activeChar);
		else if (command.startsWith("admin_mobgroup_delete") || command.startsWith("admin_mobgroup_remove"))
			removeGroup(command, activeChar);
		else if (command.startsWith("admin_mobgroup_spawn"))
			spawnGroup(command, activeChar);
		else if (command.startsWith("admin_mobgroup_unspawn"))
			unspawnGroup(command, activeChar);
		else if (command.startsWith("admin_mobgroup_kill"))
			killGroup(command, activeChar);
		else if (command.startsWith("admin_mobgroup_attackgrp"))
			attackGrp(command, activeChar);
		else if (command.startsWith("admin_mobgroup_attack"))
		{
			if (activeChar.getTarget() instanceof L2Character)
			{
				L2Character target = (L2Character) activeChar.getTarget();
				attack(command, activeChar, target);
			}
		}
		else if (command.startsWith("admin_mobgroup_rnd"))
			setNormal(command, activeChar);
		else if (command.startsWith("admin_mobgroup_idle"))
			idle(command, activeChar);
		else if (command.startsWith("admin_mobgroup_return"))
			returnToChar(command, activeChar);
		else if (command.startsWith("admin_mobgroup_follow"))
			follow(command, activeChar, activeChar);
		else if (command.startsWith("admin_mobgroup_casting"))
			setCasting(command, activeChar);
		else if (command.startsWith("admin_mobgroup_nomove"))
			noMove(command, activeChar);
		else if (command.startsWith("admin_mobgroup_invul"))
			invul(command, activeChar);
		else if (command.startsWith("admin_mobgroup_teleport"))
			teleportGroup(command, activeChar);
		showMainPage(activeChar, command);
		return true;
	}
	
	/**
	 * @param activeChar
	 */
	private void showMainPage(L2PcInstance activeChar, String command)
	{
		String filename = "mobgroup.htm";
		AdminHelpPage.showHelpPage(activeChar, filename);
	}
	
	private void returnToChar(String command, L2PcInstance activeChar)
	{
		int groupId;
		try
		{
			groupId = Integer.parseInt(command.split(" ")[1]);
		}
		catch (Exception e)
		{
			activeChar.sendMessage(150);
			return;
		}
		MobGroup group = MobGroupTable.getInstance().getGroup(groupId);
		if (group == null)
		{
			activeChar.sendMessage(164);
			return;
		}
		group.returnGroup(activeChar);
	}
	
	private void idle(String command, L2PcInstance activeChar)
	{
		int groupId;
		
		try
		{
			groupId = Integer.parseInt(command.split(" ")[1]);
		}
		catch (Exception e)
		{
			activeChar.sendMessage(150);
			return;
		}
		MobGroup group = MobGroupTable.getInstance().getGroup(groupId);
		if (group == null)
		{
			activeChar.sendMessage(164);
			return;
		}
		group.setIdleMode();
	}
	
	private void setNormal(String command, L2PcInstance activeChar)
	{
		int groupId;
		try
		{
			groupId = Integer.parseInt(command.split(" ")[1]);
		}
		catch (Exception e)
		{
			activeChar.sendMessage(150);
			return;
		}
		MobGroup group = MobGroupTable.getInstance().getGroup(groupId);
		if (group == null)
		{
			activeChar.sendMessage(164);
			return;
		}
		group.setAttackRandom();
	}
	
	private void attack(String command, L2PcInstance activeChar, L2Character target)
	{
		int groupId;
		try
		{
			groupId = Integer.parseInt(command.split(" ")[1]);
		}
		catch (Exception e)
		{
			activeChar.sendMessage(150);
			return;
		}
		MobGroup group = MobGroupTable.getInstance().getGroup(groupId);
		if (group == null)
		{
			activeChar.sendMessage(164);
			return;
		}
		group.setAttackTarget(target);
	}
	
	private void follow(String command, L2PcInstance activeChar, L2Character target)
	{
		int groupId;
		try
		{
			groupId = Integer.parseInt(command.split(" ")[1]);
		}
		catch (Exception e)
		{
			activeChar.sendMessage(150);
			return;
		}
		MobGroup group = MobGroupTable.getInstance().getGroup(groupId);
		if (group == null)
		{
			activeChar.sendMessage(164);
			return;
		}
		group.setFollowMode(target);
	}
	
	private void createGroup(String command, L2PcInstance activeChar)
	{
		int groupId;
		int templateId;
		int mobCount;
		
		try
		{
			String[] cmdParams = command.split(" ");
			
			groupId = Integer.parseInt(cmdParams[1]);
			templateId = Integer.parseInt(cmdParams[2]);
			mobCount = Integer.parseInt(cmdParams[3]);
		}
		catch (Exception e)
		{
			activeChar.sendMessage(403);
			return;
		}
		
		if (MobGroupTable.getInstance().getGroup(groupId) != null)
		{
			L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[198]);
			cm.addNumber(groupId);
			activeChar.sendMessage(cm.renderMsg());
			return;
		}
		
		L2NpcTemplate template = NpcTable.getInstance().getTemplate(templateId);
		
		if (template == null)
		{
			activeChar.sendMessage(158);
			return;
		}
		
		MobGroup group = new MobGroup(groupId, template, mobCount);
		MobGroupTable.getInstance().addGroup(groupId, group);
		
		L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[199]);
		cm.addNumber(groupId);
		activeChar.sendMessage(cm.renderMsg());
	}
	
	private void removeGroup(String command, L2PcInstance activeChar)
	{
		int groupId;
		
		try
		{
			groupId = Integer.parseInt(command.split(" ")[1]);
		}
		catch (Exception e)
		{
			activeChar.sendMessage(407);
			return;
		}
		
		MobGroup group = MobGroupTable.getInstance().getGroup(groupId);
		
		if (group == null)
		{
			activeChar.sendMessage(164);
			return;
		}
		
		doAnimation(activeChar);
		group.unspawnGroup();
		
		if (MobGroupTable.getInstance().removeGroup(groupId))
		{
			L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[201]);
			cm.addNumber(groupId);
			activeChar.sendMessage(cm.renderMsg());
		}
	}
	
	private void spawnGroup(String command, L2PcInstance activeChar)
	{
		int groupId;
		boolean topos = false;
		int posx = 0;
		int posy = 0;
		int posz = 0;
		
		try
		{
			String[] cmdParams = command.split(" ");
			groupId = Integer.parseInt(cmdParams[1]);
			
			try
			{ // we try to get a position
				posx = Integer.parseInt(cmdParams[2]);
				posy = Integer.parseInt(cmdParams[3]);
				posz = Integer.parseInt(cmdParams[4]);
				topos = true;
			}
			catch (Exception e)
			{
				// no position given
			}
		}
		catch (Exception e)
		{
			activeChar.sendMessage(408);
			return;
		}
		
		MobGroup group = MobGroupTable.getInstance().getGroup(groupId);
		
		if (group == null)
		{
			activeChar.sendMessage(164);
			return;
		}
		
		doAnimation(activeChar);
		
		if (topos)
			group.spawnGroup(posx, posy, posz);
		else
			group.spawnGroup(activeChar);
		
		L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[200]);
		cm.addNumber(groupId);
		activeChar.sendMessage(cm.renderMsg());
		
	}
	
	private void unspawnGroup(String command, L2PcInstance activeChar)
	{
		int groupId;
		
		try
		{
			groupId = Integer.parseInt(command.split(" ")[1]);
		}
		catch (Exception e)
		{
			activeChar.sendMessage(410);
			return;
		}
		
		MobGroup group = MobGroupTable.getInstance().getGroup(groupId);
		
		if (group == null)
		{
			activeChar.sendMessage(164);
			return;
		}
		
		doAnimation(activeChar);
		group.unspawnGroup();
		
		L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[202]);
		cm.addNumber(groupId);
		activeChar.sendMessage(cm.renderMsg());
	}
	
	private void killGroup(String command, L2PcInstance activeChar)
	{
		int groupId;
		
		try
		{
			groupId = Integer.parseInt(command.split(" ")[1]);
		}
		catch (Exception e)
		{
			activeChar.sendMessage(405);
			return;
		}
		
		MobGroup group = MobGroupTable.getInstance().getGroup(groupId);
		
		if (group == null)
		{
			activeChar.sendMessage(164);
			return;
		}
		
		doAnimation(activeChar);
		group.killGroup(activeChar);
	}
	
	private void setCasting(String command, L2PcInstance activeChar)
	{
		int groupId;
		
		try
		{
			groupId = Integer.parseInt(command.split(" ")[1]);
		}
		catch (Exception e)
		{
			activeChar.sendMessage(402);
			return;
		}
		
		MobGroup group = MobGroupTable.getInstance().getGroup(groupId);
		
		if (group == null)
		{
			activeChar.sendMessage(164);
			return;
		}
		
		group.setCastMode();
	}
	
	private void noMove(String command, L2PcInstance activeChar)
	{
		int groupId;
		String enabled;
		
		try
		{
			groupId = Integer.parseInt(command.split(" ")[1]);
			enabled = command.split(" ")[2];
		}
		catch (Exception e)
		{
			activeChar.sendMessage(406);
			return;
		}
		
		MobGroup group = MobGroupTable.getInstance().getGroup(groupId);
		
		if (group == null)
		{
			activeChar.sendMessage(164);
			return;
		}
		
		if (enabled.equalsIgnoreCase("on") || enabled.equalsIgnoreCase("true"))
			group.setNoMoveMode(true);
		else if (enabled.equalsIgnoreCase("off") || enabled.equalsIgnoreCase("false"))
			group.setNoMoveMode(false);
		else
			activeChar.sendMessage(150);
	}
	
	private void doAnimation(L2PcInstance activeChar)
	{
		Broadcast.toSelfAndKnownPlayersInRadius(activeChar, new MagicSkillUse(activeChar, 1008, 1, 4000, 0), 2250000/*1500*/);
		activeChar.sendPacket(new SetupGauge(0, 4000));
	}
	
	private void attackGrp(String command, L2PcInstance activeChar)
	{
		int groupId;
		int othGroupId;
		
		try
		{
			groupId = Integer.parseInt(command.split(" ")[1]);
			othGroupId = Integer.parseInt(command.split(" ")[2]);
		}
		catch (Exception e)
		{
			activeChar.sendMessage(401);
			return;
		}
		
		MobGroup group = MobGroupTable.getInstance().getGroup(groupId);
		
		if (group == null)
		{
			activeChar.sendMessage(164);
			return;
		}
		
		MobGroup othGroup = MobGroupTable.getInstance().getGroup(othGroupId);
		
		if (othGroup == null)
		{
			activeChar.sendMessage(155);
			return;
		}
		
		group.setAttackGroup(othGroup);
	}
	
	private void invul(String command, L2PcInstance activeChar)
	{
		int groupId;
		String enabled;
		
		try
		{
			groupId = Integer.parseInt(command.split(" ")[1]);
			enabled = command.split(" ")[2];
		}
		catch (Exception e)
		{
			activeChar.sendMessage(404);
			return;
		}
		
		MobGroup group = MobGroupTable.getInstance().getGroup(groupId);
		
		if (group == null)
		{
			activeChar.sendMessage(164);
			return;
		}
		
		if (enabled.equalsIgnoreCase("on") || enabled.equalsIgnoreCase("true"))
			group.setInvul(true);
		else if (enabled.equalsIgnoreCase("off") || enabled.equalsIgnoreCase("false"))
			group.setInvul(false);
		else
			activeChar.sendMessage(150);
	}
	
	private void teleportGroup(String command, L2PcInstance activeChar)
	{
		int groupId;
		String targetPlayerStr = null;
		L2PcInstance targetPlayer = null;
		
		try
		{
			groupId = Integer.parseInt(command.split(" ")[1]);
			targetPlayerStr = command.split(" ")[2];
			
			if (targetPlayerStr != null)
				targetPlayer = L2World.getInstance().getPlayer(targetPlayerStr);
			
			if (targetPlayer == null)
				targetPlayer = activeChar;
		}
		catch (Exception e)
		{
			activeChar.sendMessage(409);
			return;
		}
		
		MobGroup group = MobGroupTable.getInstance().getGroup(groupId);
		
		if (group == null)
		{
			activeChar.sendMessage(164);
			return;
		}
		
		group.teleportGroup(activeChar);
	}
	
	private void showGroupList(L2PcInstance activeChar)
	{
		MobGroup[] mobGroupList = MobGroupTable.getInstance().getGroups();
		
		activeChar.sendMessage(12);
		
		for (MobGroup mobGroup : mobGroupList)
			activeChar.sendMessage(mobGroup.getGroupId() + ": " + mobGroup.getActiveMobCount() + " alive out of " + mobGroup.getMaxMobCount() + " of NPC ID " + mobGroup.getTemplate().npcId + " (" + mobGroup.getStatus() + ")");
		
		activeChar.sendPacket(new SystemMessage(SystemMessageId.FRIEND_LIST_FOOTER));
	}
	
	public String[] getAdminCommandList()
	{
		return ADMIN_COMMANDS;
	}
}