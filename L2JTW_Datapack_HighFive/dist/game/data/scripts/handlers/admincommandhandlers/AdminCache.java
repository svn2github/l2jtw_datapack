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

import java.io.File;

import com.l2jserver.Config;
import com.l2jserver.gameserver.cache.CrestCache;
import com.l2jserver.gameserver.cache.HtmCache;
import com.l2jserver.gameserver.handler.IAdminCommandHandler;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.datatables.MessageTable;

/**
 * @author Layanere
 * 
 */
public class AdminCache implements IAdminCommandHandler
{
	private static final String[] ADMIN_COMMANDS =
	{
		"admin_cache_htm_rebuild",
		"admin_cache_htm_reload",
		"admin_cache_reload_path",
		"admin_cache_reload_file",
		"admin_cache_crest_rebuild",
		"admin_cache_crest_reload",
		"admin_cache_crest_fix"
	};
	
	public String[] getAdminCommandList()
	{
		return ADMIN_COMMANDS;
	}
	
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		
		if (command.startsWith("admin_cache_htm_rebuild") || command.equals("admin_cache_htm_reload"))
		{
			HtmCache.getInstance().reload(Config.DATAPACK_ROOT);
			activeChar.sendMessage(MessageTable.Messages[1465].getExtra(1) + HtmCache.getInstance().getMemoryUsage() + MessageTable.Messages[1465].getExtra(2) + HtmCache.getInstance().getLoadedFiles() + MessageTable.Messages[1465].getExtra(3));
		}
		else if (command.startsWith("admin_cache_reload_path "))
		{
			try
			{
				String path = command.split(" ")[1];
				HtmCache.getInstance().reloadPath(new File(Config.DATAPACK_ROOT, path));
				activeChar.sendMessage(MessageTable.Messages[1465].getExtra(1) + HtmCache.getInstance().getMemoryUsage() + MessageTable.Messages[1465].getExtra(2) + HtmCache.getInstance().getLoadedFiles() + MessageTable.Messages[1465].getExtra(3));
			}
			catch (Exception e)
			{
				activeChar.sendMessage("Usage: //cache_reload_path <path>");
			}
		}
		else if (command.startsWith("admin_cache_reload_file "))
		{
			try
			{
				String path = command.split(" ")[1];
				if (HtmCache.getInstance().loadFile(new File(Config.DATAPACK_ROOT, path)) != null)
				{
					activeChar.sendMessage(1466);
				}
				else
				{
					activeChar.sendMessage(1467);
				}
			}
			catch (Exception e)
			{
				activeChar.sendMessage("Usage: //cache_reload_file <relative_path/file>");
			}
		}
		else if (command.startsWith("admin_cache_crest_rebuild") || command.startsWith("admin_cache_crest_reload"))
		{
			CrestCache.getInstance().reload();
			activeChar.sendMessage(MessageTable.Messages[1468].getExtra(1) + String.format("%.3f", CrestCache.getInstance().getMemoryUsage()) + MessageTable.Messages[1468].getExtra(2) + CrestCache.getInstance().getLoadedFiles() + MessageTable.Messages[1468].getExtra(3));
		}
		else if (command.startsWith("admin_cache_crest_fix"))
		{
			CrestCache.getInstance().convertOldPedgeFiles();
			activeChar.sendMessage(1469);
		}
		return true;
	}
}
