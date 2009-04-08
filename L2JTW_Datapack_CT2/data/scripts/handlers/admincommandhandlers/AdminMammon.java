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

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.sf.l2j.gameserver.SevenSigns;
import net.sf.l2j.gameserver.datatables.NpcTable;
import net.sf.l2j.gameserver.datatables.SpawnTable;
import net.sf.l2j.gameserver.handler.IAdminCommandHandler;
import net.sf.l2j.gameserver.model.AutoSpawnHandler;
import net.sf.l2j.gameserver.model.AutoSpawnHandler.AutoSpawnInstance;
import net.sf.l2j.gameserver.model.actor.L2Npc;
import net.sf.l2j.gameserver.model.actor.instance.L2PcInstance;
import net.sf.l2j.gameserver.network.serverpackets.SystemMessage;
import net.sf.l2j.gameserver.network.SystemMessageId;
import net.sf.l2j.gameserver.datatables.MessageTable;
import net.sf.l2j.gameserver.model.L2CoreMessage;

/**
 * Admin Command Handler for Mammon NPCs
 *
 * @author Tempy
 */
public class AdminMammon implements IAdminCommandHandler
{
	
	private static final String[] ADMIN_COMMANDS =
	{
		"admin_mammon_find",
		"admin_mammon_respawn",
		"admin_list_spawns",
		"admin_msg"
	};
	
	private boolean _isSealValidation = SevenSigns.getInstance().isSealValidationPeriod();
	
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		int npcId = 0;
		int teleportIndex = -1;
		AutoSpawnInstance blackSpawnInst = AutoSpawnHandler.getInstance().getAutoSpawnInstance(SevenSigns.MAMMON_BLACKSMITH_ID, false);
		AutoSpawnInstance merchSpawnInst = AutoSpawnHandler.getInstance().getAutoSpawnInstance(SevenSigns.MAMMON_MERCHANT_ID, false);
		
		if (command.startsWith("admin_mammon_find"))
		{
			try
			{
				if (command.length() > 17)
					teleportIndex = Integer.parseInt(command.substring(18));
			}
			catch (Exception NumberFormatException)
			{
				activeChar.sendMessage(400);
			}
			
			if (!_isSealValidation)
			{
				activeChar.sendPacket(new SystemMessage(SystemMessageId.QUEST_EVENT_PERIOD));
				return true;
			}
			if (blackSpawnInst != null)
			{
				L2Npc[] blackInst = blackSpawnInst.getNPCInstanceList();
				if (blackInst.length > 0)
				{
					int x1 = blackInst[0].getX(), y1 = blackInst[0].getY(), z1 = blackInst[0].getZ();
					
					L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[42]);
					cm.addNumber(x1);
					cm.addNumber(y1);
					cm.addNumber(z1);
					cm.sendMessage(activeChar);

					if (teleportIndex == 1)
						activeChar.teleToLocation(x1, y1, z1, true);
				}
			}
			else
				activeChar.sendMessage(41);
			if (merchSpawnInst != null)
			{
				L2Npc[] merchInst = merchSpawnInst.getNPCInstanceList();
				if (merchInst.length > 0)
				{
					int x2 = merchInst[0].getX(), y2 = merchInst[0].getY(), z2 = merchInst[0].getZ();
					L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[197]);
					cm.addNumber(x2);
					cm.addNumber(y2);
					cm.addNumber(z2);
					cm.sendMessage(activeChar);
					if (teleportIndex == 2)
						activeChar.teleToLocation(x2, y2, z2, true);
				}
			}
			else
				activeChar.sendMessage(196);
		}
		
		else if (command.startsWith("admin_mammon_respawn"))
		{
			if (!_isSealValidation)
			{
				activeChar.sendPacket(new SystemMessage(SystemMessageId.QUEST_EVENT_PERIOD));
				return true;
			}
			if (merchSpawnInst != null)
			{
				long merchRespawn = AutoSpawnHandler.getInstance().getTimeToNextSpawn(merchSpawnInst);
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[300]);
				cm.addNumber((merchRespawn / 60000));
				cm.sendMessage(activeChar);
			}
			else
				activeChar.sendMessage(196);
			if (blackSpawnInst != null)
			{
				long blackRespawn = AutoSpawnHandler.getInstance().getTimeToNextSpawn(blackSpawnInst);
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[299]);
				cm.addNumber((blackRespawn / 60000));
				cm.sendMessage(activeChar);
			}
			else
				activeChar.sendMessage(41);
		}
		
		else if (command.startsWith("admin_list_spawns"))
		{
			try
			{ // admin_list_spawns x[xxxx] x[xx]
				String[] params = command.split(" ");
				Pattern pattern = Pattern.compile("[0-9]*");
				Matcher regexp = pattern.matcher(params[1]);
				if (regexp.matches())
					npcId = Integer.parseInt(params[1]);
				else
				{
					params[1] = params[1].replace('_', ' ');
					npcId = NpcTable.getInstance().getTemplateByName(params[1]).npcId;
				}
				if (params.length > 2)
					teleportIndex = Integer.parseInt(params[2]);
			}
			catch (Exception e)
			{
				activeChar.sendMessage(86);
			}
			
			SpawnTable.getInstance().findNPCInstances(activeChar, npcId, teleportIndex);
		}
		
		// Used for testing SystemMessage IDs	- Use //msg <ID>
		else if (command.startsWith("admin_msg"))
		{
			int msgId = -1;
			
			try
			{
				msgId = Integer.parseInt(command.substring(10).trim());
			}
			catch (Exception e)
			{
				activeChar.sendMessage(88);
				return true;
			}
			activeChar.sendPacket(new SystemMessage(msgId));
		}
		
		return true;
	}
	
	public String[] getAdminCommandList()
	{
		return ADMIN_COMMANDS;
	}
}
