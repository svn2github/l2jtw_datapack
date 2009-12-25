/*
 * $Header: AdminTest.java, 25/07/2005 17:15:21 luisantonioa Exp $
 *
 * $Author: luisantonioa $
 * $Date: 25/07/2005 17:15:21 $
 * $Revision: 1 $
 * $Log: AdminTest.java,v $
 * Revision 1  25/07/2005 17:15:21  luisantonioa
 * Added copyright notice
 *
 *
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

import com.l2jserver.gameserver.datatables.MapRegionTable;
import com.l2jserver.gameserver.handler.IAdminCommandHandler;
import com.l2jserver.gameserver.instancemanager.ZoneManager;
import com.l2jserver.gameserver.model.Location;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.datatables.MessageTable;
import com.l2jserver.gameserver.model.L2CoreMessage;

public class AdminZone implements IAdminCommandHandler
{
	private static final String[] ADMIN_COMMANDS =
	{
		"admin_zone_check",
		"admin_zone_reload"
	};
	
	/**
	 * 
	 * @see com.l2jserver.gameserver.handler.IAdminCommandHandler#useAdminCommand(java.lang.String, com.l2jserver.gameserver.model.actor.instance.L2PcInstance)
	 */
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		if (activeChar == null)
			return false;
		
		StringTokenizer st = new StringTokenizer(command, " ");
		String actualCommand = st.nextToken(); // Get actual command
		
		//String val = "";
		//if (st.countTokens() >= 1) {val = st.nextToken();}
		
		if (actualCommand.equalsIgnoreCase("admin_zone_check"))
		{
			if (activeChar.isInsideZone(L2Character.ZONE_PVP))
				activeChar.sendMessage(341);
			else
				activeChar.sendMessage(338);
			
			if (activeChar.isInsideZone(L2Character.ZONE_NOLANDING))
				activeChar.sendMessage(342);
			else
				activeChar.sendMessage(339);
			
			if (activeChar.isInsideZone(L2Character.ZONE_PEACE))
				activeChar.sendMessage(343);
			else
				activeChar.sendMessage(340);
			
			L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[192]);
			cm.addNumber(MapRegionTable.getInstance().getMapRegionX(activeChar.getX()));
			cm.addNumber(MapRegionTable.getInstance().getMapRegionX(activeChar.getY()));
			cm.sendMessage(activeChar);
			
			cm =  new L2CoreMessage (MessageTable.Messages[84]);
			cm.addString(MapRegionTable.getInstance().getClosestTownName(activeChar));
			cm.sendMessage(activeChar);
			
			Location loc;
			
			loc = MapRegionTable.getInstance().getTeleToLocation(activeChar, MapRegionTable.TeleportWhereType.Castle);			
			cm =  new L2CoreMessage (MessageTable.Messages[293]);
			cm.addNumber(loc.getX());
			cm.addNumber(loc.getY());
			cm.addNumber(loc.getZ());
			cm.sendMessage(activeChar);
			
			loc = MapRegionTable.getInstance().getTeleToLocation(activeChar, MapRegionTable.TeleportWhereType.ClanHall);
			cm =  new L2CoreMessage (MessageTable.Messages[294]);
			cm.addNumber(loc.getX());
			cm.addNumber(loc.getY());
			cm.addNumber(loc.getZ());
			cm.sendMessage(activeChar);
			
			loc = MapRegionTable.getInstance().getTeleToLocation(activeChar, MapRegionTable.TeleportWhereType.SiegeFlag);
			cm =  new L2CoreMessage (MessageTable.Messages[295]);
			cm.addNumber(loc.getX());
			cm.addNumber(loc.getY());
			cm.addNumber(loc.getZ());
			cm.sendMessage(activeChar);
			
			loc = MapRegionTable.getInstance().getTeleToLocation(activeChar, MapRegionTable.TeleportWhereType.Town);
			cm =  new L2CoreMessage (MessageTable.Messages[296]);
			cm.addNumber(loc.getX());
			cm.addNumber(loc.getY());
			cm.addNumber(loc.getZ());
			cm.sendMessage(activeChar);
			
		}
		else if (actualCommand.equalsIgnoreCase("admin_zone_reload"))
		{
			ZoneManager.getInstance().reload();
			activeChar.sendMessage(251);
		}
		return true;
	}
	
	/**
	 * 
	 * @see com.l2jserver.gameserver.handler.IAdminCommandHandler#getAdminCommandList()
	 */
	public String[] getAdminCommandList()
	{
		return ADMIN_COMMANDS;
	}
	
}
