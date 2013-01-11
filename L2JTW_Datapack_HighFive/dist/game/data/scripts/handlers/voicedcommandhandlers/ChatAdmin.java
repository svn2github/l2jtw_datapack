/*
 * Copyright (C) 2004-2013 L2J DataPack
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
package handlers.voicedcommandhandlers;

import java.util.StringTokenizer;

import com.l2jserver.gameserver.datatables.AdminTable;
import com.l2jserver.gameserver.datatables.CharNameTable;
import com.l2jserver.gameserver.handler.IVoicedCommandHandler;
import com.l2jserver.gameserver.model.L2World;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.datatables.MessageTable; // Add By L2JTW

public class ChatAdmin implements IVoicedCommandHandler
{
	private static final String[] VOICED_COMMANDS =
	{
		"banchat",
		"unbanchat"
	};
	
	@Override
	public boolean useVoicedCommand(String command, L2PcInstance activeChar, String params)
	{
		if (!AdminTable.getInstance().hasAccess(command, activeChar.getAccessLevel()))
		{
			return false;
		}
		
		if (command.equals(VOICED_COMMANDS[0])) // banchat
		{
			if (params == null)
			{
				/* Move To MessageTable For L2JTW
				activeChar.sendMessage("Usage: .banchat name [minutes]");
				*/
				activeChar.sendMessage(1187);
				return true;
			}
			StringTokenizer st = new StringTokenizer(params);
			if (st.hasMoreTokens())
			{
				String name = st.nextToken();
				int length = 0;
				if (st.hasMoreTokens())
				{
					try
					{
						length = Integer.parseInt(st.nextToken());
					}
					catch (NumberFormatException e)
					{
						/* Move To MessageTable For L2JTW
						activeChar.sendMessage("Wrong ban length !");
						*/
						activeChar.sendMessage(1188);
						return false;
					}
				}
				if (length < 0)
				{
					length = 0;
				}
				
				int objId = CharNameTable.getInstance().getIdByName(name);
				if (objId > 0)
				{
					L2PcInstance player = L2World.getInstance().getPlayer(objId);
					if ((player == null) || !player.isOnline())
					{
						/* Move To MessageTable For L2JTW
						activeChar.sendMessage("Player not online !");
						*/
						activeChar.sendMessage(1189);
						return false;
					}
					if (player.getPunishLevel() != L2PcInstance.PunishLevel.NONE)
					{
						/* Move To MessageTable For L2JTW
						activeChar.sendMessage("Player is already punished !");
						*/
						activeChar.sendMessage(1190);
						return false;
					}
					if (player == activeChar)
					{
						/* Move To MessageTable For L2JTW
						activeChar.sendMessage("You can't ban yourself !");
						*/
						activeChar.sendMessage(1191);
						return false;
					}
					if (player.isGM())
					{
						/* Move To MessageTable For L2JTW
						activeChar.sendMessage("You can't ban GM !");
						*/
						activeChar.sendMessage(1192);
						return false;
					}
					if (AdminTable.getInstance().hasAccess(command, player.getAccessLevel()))
					{
						/* Move To MessageTable For L2JTW
						activeChar.sendMessage("You can't ban moderator !");
						*/
						activeChar.sendMessage(1193);
						return false;
					}
					
					player.setPunishLevel(L2PcInstance.PunishLevel.CHAT, length);
					/* Move To MessageTable For L2JTW
					player.sendMessage("Chat banned by moderator " + activeChar.getName());
					*/
					player.sendMessage(MessageTable.Messages[1194].getMessage() + activeChar.getName());
					
					if (length > 0)
					{
						/* Move To MessageTable For L2JTW
						activeChar.sendMessage("Player " + player.getName() + " chat banned for " + length + " minutes.");
						*/
						activeChar.sendMessage(MessageTable.Messages[1195].getExtra(1) + player.getName() + MessageTable.Messages[1195].getExtra(2) + length + MessageTable.Messages[1195].getExtra(3));
					}
					else
					{
						/* Move To MessageTable For L2JTW
						activeChar.sendMessage("Player " + player.getName() + " chat banned forever.");
						*/
						activeChar.sendMessage(MessageTable.Messages[1195].getExtra(1) + player.getName() + MessageTable.Messages[1195].getExtra(4));
					}
				}
				else
				{
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Player not found !");
					*/
					activeChar.sendMessage(1196);
					return false;
				}
			}
		}
		else if (command.equals(VOICED_COMMANDS[1])) // unbanchat
		{
			if (params == null)
			{
				/* Move To MessageTable For L2JTW
				activeChar.sendMessage("Usage: .unbanchat name");
				*/
				activeChar.sendMessage(1197);
				return true;
			}
			StringTokenizer st = new StringTokenizer(params);
			if (st.hasMoreTokens())
			{
				String name = st.nextToken();
				
				int objId = CharNameTable.getInstance().getIdByName(name);
				if (objId > 0)
				{
					L2PcInstance player = L2World.getInstance().getPlayer(objId);
					if ((player == null) || !player.isOnline())
					{
						/* Move To MessageTable For L2JTW
						activeChar.sendMessage("Player not online !");
						*/
						activeChar.sendMessage(1198);
						return false;
					}
					if (player.getPunishLevel() != L2PcInstance.PunishLevel.CHAT)
					{
						/* Move To MessageTable For L2JTW
						activeChar.sendMessage("Player is not chat banned !");
						*/
						activeChar.sendMessage(1199);
						return false;
					}
					
					player.setPunishLevel(L2PcInstance.PunishLevel.NONE, 0);
					
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Player " + player.getName() + " chat unbanned.");
					*/
					activeChar.sendMessage(MessageTable.Messages[1195].getExtra(1) + player.getName() + MessageTable.Messages[1195].getExtra(5));
					/* Move To MessageTable For L2JTW
					player.sendMessage("Chat unbanned by moderator " + activeChar.getName());
					*/
					player.sendMessage(MessageTable.Messages[1200].getMessage() + activeChar.getName());
				}
				else
				{
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Player not found !");
					*/
					activeChar.sendMessage(1196);
					return false;
				}
			}
		}
		return true;
	}
	
	@Override
	public String[] getVoicedCommandList()
	{
		return VOICED_COMMANDS;
	}
}
