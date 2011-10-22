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
package handlers.voicedcommandhandlers;

import java.util.StringTokenizer;

import com.l2jserver.gameserver.datatables.AdminCommandAccessRights;
import com.l2jserver.gameserver.datatables.CharNameTable;
import com.l2jserver.gameserver.handler.IVoicedCommandHandler;
import com.l2jserver.gameserver.model.L2World;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.datatables.MessageTable;

public class ChatAdmin implements IVoicedCommandHandler
{
	private static final String[] VOICED_COMMANDS =
	{
		"banchat",
		"unbanchat"
	};
	
	/**
	 * 
	 * @see com.l2jserver.gameserver.handler.IVoicedCommandHandler#useVoicedCommand(java.lang.String, com.l2jserver.gameserver.model.actor.instance.L2PcInstance, java.lang.String)
	 */
	public boolean useVoicedCommand(String command, L2PcInstance activeChar, String params)
	{
		if (!AdminCommandAccessRights.getInstance().hasAccess(command, activeChar.getAccessLevel()))
			return false;
		
		if (command.equalsIgnoreCase(VOICED_COMMANDS[0])) // banchat
		{
			if (params == null)
			{
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
						activeChar.sendMessage(1188);
						return false;
					}
				}
				if (length < 0)
					length = 0;
				
				int objId = CharNameTable.getInstance().getIdByName(name);
				if (objId > 0)
				{
					L2PcInstance player = L2World.getInstance().getPlayer(objId);
					if (player == null || !player.isOnline())
					{
						activeChar.sendMessage(1189);
						return false;
					}
					if (player.getPunishLevel() != L2PcInstance.PunishLevel.NONE)
					{
						activeChar.sendMessage(1190);
						return false;
					}
					if (player == activeChar)
					{
						activeChar.sendMessage(1191);
						return false;
					}
					if (player.isGM())
					{
						activeChar.sendMessage(1192);
						return false;
					}
					if (AdminCommandAccessRights.getInstance().hasAccess(command, player.getAccessLevel()))
					{
						activeChar.sendMessage(1193);
						return false;
					}

					player.setPunishLevel(L2PcInstance.PunishLevel.CHAT, length);
					player.sendMessage(MessageTable.Messages[1194].getMessage() + activeChar.getName());

					if (length > 0)
						activeChar.sendMessage(MessageTable.Messages[1195].getExtra(1) + player.getName() + MessageTable.Messages[1195].getExtra(2) + length + MessageTable.Messages[1195].getExtra(3));
					else
						activeChar.sendMessage(MessageTable.Messages[1195].getExtra(1) + player.getName() + MessageTable.Messages[1195].getExtra(4));
				}
				else
				{
					activeChar.sendMessage(1196);
					return false;
				}
			}
		}
		else if (command.equalsIgnoreCase(VOICED_COMMANDS[1])) //unbanchat
		{
			if (params == null)
			{
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
					if (player == null || !player.isOnline())
					{
						activeChar.sendMessage(1198);
						return false;
					}
					if (player.getPunishLevel() != L2PcInstance.PunishLevel.CHAT)
					{
						activeChar.sendMessage(1199);
						return false;
					}
					
					player.setPunishLevel(L2PcInstance.PunishLevel.NONE, 0);

					activeChar.sendMessage(MessageTable.Messages[1195].getExtra(1) + player.getName() + MessageTable.Messages[1195].getExtra(5));
					player.sendMessage(MessageTable.Messages[1200].getMessage() + activeChar.getName());
				}
				else
				{
					activeChar.sendMessage(1196);
					return false;
				}
			}
		}
		return true;
	}
	
	/**
	 * 
	 * @see com.l2jserver.gameserver.handler.IVoicedCommandHandler#getVoicedCommandList()
	 */
	public String[] getVoicedCommandList()
	{
		return VOICED_COMMANDS;
	}
}
