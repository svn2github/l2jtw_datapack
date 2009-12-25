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

import com.l2jserver.Config;
import com.l2jserver.gameserver.GeoData;
import com.l2jserver.gameserver.handler.IAdminCommandHandler;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.datatables.MessageTable;
import com.l2jserver.gameserver.model.L2CoreMessage;

/**
 *
 * @author  -Nemesiss-
 */
public class AdminGeodata implements IAdminCommandHandler
{
	private static final String[] ADMIN_COMMANDS =
	{
		"admin_geo_z",
		"admin_geo_type",
		"admin_geo_nswe",
		"admin_geo_los",
		"admin_geo_position",
		"admin_geo_bug",
		"admin_geo_load",
		"admin_geo_unload"
	};
	
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		if (Config.GEODATA < 1)
		{
			activeChar.sendMessage(126);
			return true;
		}
		
		if (command.equals("admin_geo_z"))
			activeChar.sendMessage("GeoEngine: Geo_Z = " + GeoData.getInstance().getHeight(activeChar.getX(), activeChar.getY(), activeChar.getZ()) + " Loc_Z = " + activeChar.getZ());
		else if (command.equals("admin_geo_type"))
		{
			short type = GeoData.getInstance().getType(activeChar.getX(), activeChar.getY());
			activeChar.sendMessage("GeoEngine: Geo_Type = " + type);
			short height = GeoData.getInstance().getHeight(activeChar.getX(), activeChar.getY(), activeChar.getZ());
			activeChar.sendMessage("GeoEngine: height = " + height);
		}
		else if (command.equals("admin_geo_nswe"))
		{
			String result = "";
			short nswe = GeoData.getInstance().getNSWE(activeChar.getX(), activeChar.getY(), activeChar.getZ());
			if ((nswe & 8) == 0)
				result += " N";
			if ((nswe & 4) == 0)
				result += " S";
			if ((nswe & 2) == 0)
				result += " W";
			if ((nswe & 1) == 0)
				result += " E";
			activeChar.sendMessage("GeoEngine: Geo_NSWE -> " + nswe + "->" + result);
		}
		else if (command.equals("admin_geo_los"))
		{
			if (activeChar.getTarget() != null)
			{
				if (GeoData.getInstance().canSeeTargetDebug(activeChar, activeChar.getTarget()))
					activeChar.sendMessage(129);
				else
					activeChar.sendMessage(130);
				
			}
			else
				activeChar.sendMessage(209);
		}
		else if (command.equals("admin_geo_position"))
		{
			activeChar.sendMessage(137);
			L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[684]);
			cm.addNumber(activeChar.getX());
			cm.addNumber(activeChar.getY());
			cm.addNumber(activeChar.getZ());
			cm.sendMessage(activeChar);
			cm =  new L2CoreMessage (MessageTable.Messages[685]);
			cm.addString(GeoData.getInstance().geoPosition(activeChar.getX(), activeChar.getY()));
			cm.sendMessage(activeChar);
		}
		else if (command.startsWith("admin_geo_load"))
		{
			String[] v = command.substring(15).split(" ");
			if (v.length != 2)
				activeChar.sendMessage(378);
			else
			{
				try
				{
					byte rx = Byte.parseByte(v[0]);
					byte ry = Byte.parseByte(v[1]);
					
					boolean result = GeoData.loadGeodataFile(rx, ry);
					
					if (result)
					{
						L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[132]);
						cm.addNumber(rx);
						cm.addNumber(ry);
						cm.sendMessage(activeChar);
					}
					else
					{
						L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[131]);
						cm.addNumber(rx);
						cm.addNumber(ry);
						cm.sendMessage(activeChar);
					}
				}
				catch (Exception e)
				{
					activeChar.sendMessage(549);
				}
			}
		}
		else if (command.startsWith("admin_geo_unload"))
		{
			String[] v = command.substring(17).split(" ");
			if (v.length != 2)
				activeChar.sendMessage(379);
			else
			{
				try
				{
					byte rx = Byte.parseByte(v[0]);
					byte ry = Byte.parseByte(v[1]);
					
					GeoData.unloadGeodata(rx, ry);
					
					L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[133]);
					cm.addNumber(rx);
					cm.addNumber(ry);
					cm.sendMessage(activeChar);
				}
				catch (Exception e)
				{
					activeChar.sendMessage(549);
				}
			}
		}
		else if (command.startsWith("admin_geo_bug"))
		{
			try
			{
				String comment = command.substring(14);
				GeoData.getInstance().addGeoDataBug(activeChar, comment);
			}
			catch (StringIndexOutOfBoundsException e)
			{
				activeChar.sendMessage(377);
			}
		}
		return true;
	}
	
	public String[] getAdminCommandList()
	{
		return ADMIN_COMMANDS;
	}
}
