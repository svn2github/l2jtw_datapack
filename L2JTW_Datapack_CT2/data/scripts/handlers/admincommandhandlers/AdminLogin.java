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

import java.util.StringTokenizer;

import net.sf.l2j.Config;
import net.sf.l2j.gameserver.LoginServerThread;
import net.sf.l2j.gameserver.handler.IAdminCommandHandler;
import net.sf.l2j.gameserver.model.actor.instance.L2PcInstance;
import net.sf.l2j.gameserver.network.gameserverpackets.ServerStatus;
import net.sf.l2j.gameserver.network.serverpackets.NpcHtmlMessage;
import net.sf.l2j.gameserver.datatables.MessageTable;
import net.sf.l2j.gameserver.model.L2CoreMessage;

/**
 * This class handles the admin commands that acts on the login
 *
 * @version $Revision: 1.2.2.1.2.4 $ $Date: 2007/07/31 10:05:56 $
 */
public class AdminLogin implements IAdminCommandHandler
{
	private static final String[] ADMIN_COMMANDS =
	{
		"admin_server_gm_only",
		"admin_server_all",
		"admin_server_max_player",
		"admin_server_list_clock",
		"admin_server_login"
	};
	
	/**
	 * 
	 * @see net.sf.l2j.gameserver.handler.IAdminCommandHandler#useAdminCommand(java.lang.String, net.sf.l2j.gameserver.model.actor.instance.L2PcInstance)
	 */
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		if (command.equals("admin_server_gm_only"))
		{
			gmOnly();
			activeChar.sendMessage(270);
			showMainPage(activeChar);
		}
		else if (command.equals("admin_server_all"))
		{
			allowToAll();
			activeChar.sendMessage(269);
			showMainPage(activeChar);
		}
		else if (command.startsWith("admin_server_max_player"))
		{
			StringTokenizer st = new StringTokenizer(command);
			if (st.countTokens() > 1)
			{
				st.nextToken();
				String number = st.nextToken();
				try
				{

					LoginServerThread.getInstance().setMaxPlayer(Integer.parseInt(number));
					L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[651]);
					cm.addNumber(new Integer(number).intValue());
					cm.sendMessage(activeChar);
					showMainPage(activeChar);
				}
				catch (NumberFormatException e)
				{
					activeChar.sendMessage(193);
				}
			}
			else
			{
				activeChar.sendMessage(123);
			}
		}
		else if (command.startsWith("admin_server_list_clock"))
		{
			StringTokenizer st = new StringTokenizer(command);
			if (st.countTokens() > 1)
			{
				st.nextToken();
				String mode = st.nextToken();
				if (mode.equals("on"))
				{
					LoginServerThread.getInstance().sendServerStatus(ServerStatus.SERVER_LIST_CLOCK, ServerStatus.ON);
					activeChar.sendMessage(17);
					Config.SERVER_LIST_CLOCK = true;
					showMainPage(activeChar);
				}
				else if (mode.equals("off"))
				{
					LoginServerThread.getInstance().sendServerStatus(ServerStatus.SERVER_LIST_CLOCK, ServerStatus.OFF);
					Config.SERVER_LIST_CLOCK = false;
					activeChar.sendMessage(304);
					showMainPage(activeChar);
				}
				else
				{
					activeChar.sendMessage(122);
				}
			}
			else
			{
				activeChar.sendMessage(122);
			}
		}
		else if (command.equals("admin_server_login"))
		{
			showMainPage(activeChar);
		}
		return true;
	}
	
	/**
	 *
	 */
	private void showMainPage(L2PcInstance activeChar)
	{
		NpcHtmlMessage html = new NpcHtmlMessage(1);
		html.setFile("data/html/admin/login.htm");
		html.replace("%server_name%", LoginServerThread.getInstance().getServerName());
		html.replace("%status%", LoginServerThread.getInstance().getStatusString());
		html.replace("%clock%", String.valueOf(Config.SERVER_LIST_CLOCK));
		html.replace("%brackets%", String.valueOf(Config.SERVER_LIST_BRACKET));
		html.replace("%max_players%", String.valueOf(LoginServerThread.getInstance().getMaxPlayer()));
		activeChar.sendPacket(html);
	}
	
	/**
	 *
	 */
	private void allowToAll()
	{
		LoginServerThread.getInstance().setServerStatus(ServerStatus.STATUS_AUTO);
		Config.SERVER_GMONLY = false;
	}
	
	/**
	 *
	 */
	private void gmOnly()
	{
		LoginServerThread.getInstance().setServerStatus(ServerStatus.STATUS_GM_ONLY);
		Config.SERVER_GMONLY = true;
	}
	
	/**
	 * 
	 * @see net.sf.l2j.gameserver.handler.IAdminCommandHandler#getAdminCommandList()
	 */
	public String[] getAdminCommandList()
	{
		return ADMIN_COMMANDS;
	}
	
}
