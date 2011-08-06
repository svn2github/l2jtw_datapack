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

import com.l2jserver.gameserver.SevenSigns;
import com.l2jserver.gameserver.handler.IAdminCommandHandler;
import com.l2jserver.gameserver.model.AutoSpawnHandler;
import com.l2jserver.gameserver.model.AutoSpawnHandler.AutoSpawnInstance;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.datatables.MessageTable;

/**
 * Admin Command Handler for Mammon NPCs
 * @author Tempy, Zoey76
 */
public class AdminMammon implements IAdminCommandHandler
{
	private static final String[] ADMIN_COMMANDS = { "admin_mammon_find", "admin_mammon_respawn", };
	
	private boolean _isSealValidation = SevenSigns.getInstance().isSealValidationPeriod();
	
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		int teleportIndex = -1;
		final AutoSpawnInstance blackSpawnInst = AutoSpawnHandler.getInstance().getAutoSpawnInstance(SevenSigns.MAMMON_BLACKSMITH_ID, false);
		final AutoSpawnInstance merchSpawnInst = AutoSpawnHandler.getInstance().getAutoSpawnInstance(SevenSigns.MAMMON_MERCHANT_ID, false);
		
		if (command.startsWith("admin_mammon_find"))
		{
			try
			{
				if (command.length() > 17)
				{
					teleportIndex = Integer.parseInt(command.substring(18));
				}
			}
			catch (Exception NumberFormatException)
			{
				activeChar.sendMessage("Usage: //mammon_find [teleportIndex] (where 1 = Blacksmith, 2 = Merchant)");
				return false;
			}
			
			if (!_isSealValidation)
			{
				activeChar.sendPacket(SystemMessageId.SSQ_COMPETITION_UNDERWAY);
				//activeChar.sendMessage(1738);
				return false;
			}
			
			if (blackSpawnInst != null)
			{
				final L2Npc[] blackInst = blackSpawnInst.getNPCInstanceList();
				if (blackInst.length > 0)
				{
					final int x1 = blackInst[0].getX(), y1 = blackInst[0].getY(), z1 = blackInst[0].getZ();
					activeChar.sendMessage(MessageTable.Messages[1739].getMessage() + x1 + " " + y1 + " " + z1);
					if (teleportIndex == 1)
					{
						activeChar.teleToLocation(x1, y1, z1, true);
					}
				}
			}
			else
			{
				activeChar.sendMessage(1740);
			}
			
			if (merchSpawnInst != null)
			{
				final L2Npc[] merchInst = merchSpawnInst.getNPCInstanceList();
				if (merchInst.length > 0)
				{
					final int x2 = merchInst[0].getX(), y2 = merchInst[0].getY(), z2 = merchInst[0].getZ();
					activeChar.sendMessage(MessageTable.Messages[1741].getMessage() + x2 + " " + y2 + " " + z2);
					if (teleportIndex == 2)
					{
						activeChar.teleToLocation(x2, y2, z2, true);
					}
				}
			}
			else
			{
				activeChar.sendMessage(1742);
			}
		}
		else if (command.startsWith("admin_mammon_respawn"))
		{
			if (!_isSealValidation)
			{
				activeChar.sendPacket(SystemMessageId.SSQ_COMPETITION_UNDERWAY);
				//activeChar.sendMessage(1738);
				return true;
			}
			
			if (merchSpawnInst != null)
			{
				long merchRespawn = AutoSpawnHandler.getInstance().getTimeToNextSpawn(merchSpawnInst);
				activeChar.sendMessage(MessageTable.Messages[1743].getExtra(1) + (merchRespawn / 60000) + MessageTable.Messages[1743].getExtra(2));
			}
			else
			{
				activeChar.sendMessage(1742);
			}
			
			if (blackSpawnInst != null)
			{
				long blackRespawn = AutoSpawnHandler.getInstance().getTimeToNextSpawn(blackSpawnInst);
				activeChar.sendMessage(MessageTable.Messages[1744].getExtra(1) + (blackRespawn / 60000) + MessageTable.Messages[1744].getExtra(2));
			}
			else
			{
				activeChar.sendMessage(1740);
			}
		}
		return true;
	}
	
	public String[] getAdminCommandList()
	{
		return ADMIN_COMMANDS;
	}
}
