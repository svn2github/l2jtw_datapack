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

import com.l2jserver.Config;
import com.l2jserver.gameserver.geoeditorcon.GeoEditorListener;
import com.l2jserver.gameserver.handler.IAdminCommandHandler;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.datatables.MessageTable;
import com.l2jserver.gameserver.model.L2CoreMessage;

/**
 * @author  Luno, Dezmond
 */
public class AdminGeoEditor implements IAdminCommandHandler
{
	private static final String[] ADMIN_COMMANDS =
	{
		"admin_ge_status",
		"admin_ge_mode",
		"admin_ge_join",
		"admin_ge_leave"
	};
	
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		if (!Config.ACCEPT_GEOEDITOR_CONN)
		{
			activeChar.sendMessage(268);
			return true;
		}
		if (command.startsWith("admin_ge_status"))
		{
			activeChar.sendMessage(GeoEditorListener.getInstance().getStatus());
		}
		else if (command.startsWith("admin_ge_mode"))
		{
			if (GeoEditorListener.getInstance().getThread() == null)
			{
				activeChar.sendMessage(140);
				return true;
			}
			try
			{
				String val = command.substring("admin_ge_mode".length());
				StringTokenizer st = new StringTokenizer(val);
				
				if (st.countTokens() < 1)
				{
					activeChar.sendMessage(395);
					activeChar.sendMessage(203);
					activeChar.sendMessage(204);
					activeChar.sendMessage(205);
					return true;
				}
				int m;
				m = Integer.parseInt(st.nextToken());
				GeoEditorListener.getInstance().getThread().setMode(m);
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[139]);
				cm.addNumber(m);
				cm.sendMessage(activeChar);
			}
			catch (Exception e)
			{
				activeChar.sendMessage(395);
				activeChar.sendMessage(203);
				activeChar.sendMessage(204);
				activeChar.sendMessage(205);
				e.printStackTrace();
			}
			return true;
		}
		else if (command.equals("admin_ge_join"))
		{
			if (GeoEditorListener.getInstance().getThread() == null)
			{
				activeChar.sendMessage(140);
				return true;
			}
			GeoEditorListener.getInstance().getThread().addGM(activeChar);
			activeChar.sendMessage(437);
		}
		else if (command.equals("admin_ge_leave"))
		{
			if (GeoEditorListener.getInstance().getThread() == null)
			{
				activeChar.sendMessage(140);
				return true;
			}
			GeoEditorListener.getInstance().getThread().removeGM(activeChar);
			activeChar.sendMessage(594);
		}
		return true;
	}
	
	public String[] getAdminCommandList()
	{
		return ADMIN_COMMANDS;
	}
}
