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

import net.sf.l2j.Config;
import net.sf.l2j.gameserver.cache.CrestCache;
import net.sf.l2j.gameserver.cache.HtmCache;
import net.sf.l2j.gameserver.handler.IAdminCommandHandler;
import net.sf.l2j.gameserver.model.actor.instance.L2PcInstance;
import net.sf.l2j.gameserver.datatables.MessageTable;
import net.sf.l2j.gameserver.model.L2CoreMessage;

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
			L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[47]);
			cm.addNumber(HtmCache.getInstance().getMemoryUsage());
			cm.addNumber(HtmCache.getInstance().getLoadedFiles());
			cm.sendMessage(activeChar);
		}
		else if (command.startsWith("admin_cache_reload_path "))
		{
			try
			{
				String path = command.split(" ")[1];
				HtmCache.getInstance().reloadPath(new File(Config.DATAPACK_ROOT, path));
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[47]);
				cm.addNumber(HtmCache.getInstance().getMemoryUsage());
				cm.addNumber(HtmCache.getInstance().getLoadedFiles());
				cm.sendMessage(activeChar);
			}
			catch (Exception e)
			{
				activeChar.sendMessage(383);
			}
		}
		else if (command.startsWith("admin_cache_reload_file "))
		{
			try
			{
				String path = command.split(" ")[1];
				if (HtmCache.getInstance().loadFile(new File(Config.DATAPACK_ROOT, path)) != null)
				{
					activeChar.sendMessage(51);
				}
				else
				{
					activeChar.sendMessage(50);
				}
			}
			catch (Exception e)
			{
				activeChar.sendMessage(382);
			}
		}
		else if (command.startsWith("admin_cache_crest_rebuild") || command.startsWith("admin_cache_crest_reload"))
		{
			CrestCache.getInstance().reload();
			L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[45]);
			cm.addString(String.format("%.3f", CrestCache.getInstance().getMemoryUsage()));
			cm.addNumber(CrestCache.getInstance().getLoadedFiles());
			cm.sendMessage(activeChar);
		}
		else if (command.startsWith("admin_cache_crest_fix"))
		{
			CrestCache.getInstance().convertOldPedgeFiles();
			activeChar.sendMessage(46);
		}
		return true;
	}
}
