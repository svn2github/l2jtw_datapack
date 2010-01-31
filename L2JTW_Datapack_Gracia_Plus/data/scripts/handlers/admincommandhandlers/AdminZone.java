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

import com.l2jserver.gameserver.cache.HtmCache;
import com.l2jserver.gameserver.datatables.MapRegionTable;
import com.l2jserver.gameserver.handler.IAdminCommandHandler;
import com.l2jserver.gameserver.instancemanager.ZoneManager;
import com.l2jserver.gameserver.model.Location;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.network.serverpackets.NpcHtmlMessage;
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
			final String htmContent = HtmCache.getInstance().getHtm("data/html/admin/zone.htm");
			NpcHtmlMessage adminReply = new NpcHtmlMessage(5);
			adminReply.setHtml(htmContent);			
			adminReply.replace("%PEACE%", (activeChar.isInsideZone(L2Character.ZONE_PEACE) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			adminReply.replace("%PVP%", (activeChar.isInsideZone(L2Character.ZONE_PVP) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			adminReply.replace("%SIEGE%", (activeChar.isInsideZone(L2Character.ZONE_SIEGE) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			adminReply.replace("%TOWN%", (activeChar.isInsideZone(L2Character.ZONE_TOWN) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			adminReply.replace("%CASTLE%", (activeChar.isInsideZone(L2Character.ZONE_CASTLE) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			adminReply.replace("%FORT%", (activeChar.isInsideZone(L2Character.ZONE_FORT) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			adminReply.replace("%NOHQ%", (activeChar.isInsideZone(L2Character.ZONE_NOHQ) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			adminReply.replace("%CLANHALL%", (activeChar.isInsideZone(L2Character.ZONE_CLANHALL) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			adminReply.replace("%LAND%", (activeChar.isInsideZone(L2Character.ZONE_LANDING) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			adminReply.replace("%NOLAND%", (activeChar.isInsideZone(L2Character.ZONE_NOLANDING) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			adminReply.replace("%NOSUMMON%", (activeChar.isInsideZone(L2Character.ZONE_NOSUMMONFRIEND) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			adminReply.replace("%WATER%", (activeChar.isInsideZone(L2Character.ZONE_WATER) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			adminReply.replace("%SWAMP%", (activeChar.isInsideZone(L2Character.ZONE_SWAMP) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			adminReply.replace("%DANGER%", (activeChar.isInsideZone(L2Character.ZONE_DANGERAREA) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			adminReply.replace("%NOSTORE%", (activeChar.isInsideZone(L2Character.ZONE_NOSTORE) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			adminReply.replace("%SCRIPT%", (activeChar.isInsideZone(L2Character.ZONE_SCRIPT) ? "<font color=\"LEVEL\">YES</font>" : "NO"));
			activeChar.sendPacket(adminReply);
			
			activeChar.sendMessage("MapRegion: x:" + MapRegionTable.getInstance().getMapRegionX(activeChar.getX()) + " y:" + MapRegionTable.getInstance().getMapRegionX(activeChar.getY()));
			
			activeChar.sendMessage("Closest Town: " + MapRegionTable.getInstance().getClosestTownName(activeChar));
			
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
