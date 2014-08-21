/*
 * Copyright (C) 2004-2014 L2J DataPack
 * 
 * This file is part of L2J DataPack.
 * 
 * L2J DataPack is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * L2J DataPack is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
package handlers.admincommandhandlers;

import com.l2jserver.Config;
import com.l2jserver.gameserver.handler.IAdminCommandHandler;
import com.l2jserver.gameserver.model.L2Object;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.entity.TvTEvent;
import com.l2jserver.gameserver.model.entity.TvTEventTeleporter;
import com.l2jserver.gameserver.model.entity.TvTManager;

/**
 * @author FBIagent
 */
public class AdminTvTEvent implements IAdminCommandHandler
{
	private static final String[] ADMIN_COMMANDS =
	{
		"admin_tvt_add",
		"admin_tvt_remove",
		"admin_tvt_advance"
	};
	
	@Override
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		if (command.equals("admin_tvt_add"))
		{
			L2Object target = activeChar.getTarget();
			
			if (!(target instanceof L2PcInstance))
			{
				/* MessageTable.Messages[1901]
				activeChar.sendMessage("You should select a player!");
				 */
				activeChar.sendMessage(1901);
				return true;
			}
			
			add(activeChar, (L2PcInstance) target);
		}
		else if (command.equals("admin_tvt_remove"))
		{
			L2Object target = activeChar.getTarget();
			
			if (!(target instanceof L2PcInstance))
			{
				/* MessageTable.Messages[1901]
				activeChar.sendMessage("You should select a player!");
				 */
				activeChar.sendMessage(1901);
				return true;
			}
			
			remove(activeChar, (L2PcInstance) target);
		}
		else if (command.equals("admin_tvt_advance"))
		{
			TvTManager.getInstance().skipDelay();
		}
		
		return true;
	}
	
	@Override
	public String[] getAdminCommandList()
	{
		return ADMIN_COMMANDS;
	}
	
	private void add(L2PcInstance activeChar, L2PcInstance playerInstance)
	{
		if (playerInstance.isOnEvent())
		{
			/* MessageTable.Messages[1902]
			activeChar.sendMessage("Player already participated in the event!");
			 */
			activeChar.sendMessage(1902);
			return;
		}
		
		if (!TvTEvent.addParticipant(playerInstance))
		{
			/* MessageTable.Messages[1903]
			activeChar.sendMessage("Player instance could not be added, it seems to be null!");
			 */
			activeChar.sendMessage(1903);
			return;
		}
		
		if (TvTEvent.isStarted())
		{
			new TvTEventTeleporter(playerInstance, TvTEvent.getParticipantTeamCoordinates(playerInstance.getObjectId()), true, false);
		}
	}
	
	private void remove(L2PcInstance activeChar, L2PcInstance playerInstance)
	{
		if (!TvTEvent.removeParticipant(playerInstance.getObjectId()))
		{
			/* MessageTable.Messages[1904]
			activeChar.sendMessage("Player is not part of the event!");
			 */
			activeChar.sendMessage(1904);
			return;
		}
		
		new TvTEventTeleporter(playerInstance, Config.TVT_EVENT_PARTICIPATION_NPC_COORDINATES, true, true);
	}
}