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

import java.util.NoSuchElementException;
import java.util.StringTokenizer;

import net.sf.l2j.Config;
import net.sf.l2j.gameserver.ThreadPoolManager;
import net.sf.l2j.gameserver.Universe;
import net.sf.l2j.gameserver.handler.IAdminCommandHandler;
import net.sf.l2j.gameserver.model.L2Object;
import net.sf.l2j.gameserver.model.actor.L2Character;
import net.sf.l2j.gameserver.model.actor.instance.L2PcInstance;
import net.sf.l2j.gameserver.network.serverpackets.MagicSkillUse;
import net.sf.l2j.gameserver.datatables.MessageTable;
import net.sf.l2j.gameserver.model.L2CoreMessage;

/**
 * This class ...
 *
 * @version $Revision: 1.2 $ $Date: 2004/06/27 08:12:59 $
 */

public class AdminTest implements IAdminCommandHandler
{
	private static final String[] ADMIN_COMMANDS =
	{
		"admin_test",
		"admin_stats",
		"admin_skill_test",
		"admin_st",
		"admin_mp",
		"admin_known"
	};
	
	/* (non-Javadoc)
	 * @see net.sf.l2j.gameserver.handler.IAdminCommandHandler#useAdminCommand(java.lang.String, net.sf.l2j.gameserver.model.L2PcInstance)
	 */
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		if (command.equals("admin_stats"))
		{
			for (String line : ThreadPoolManager.getInstance().getStats())
			{
				activeChar.sendMessage(line);
			}
		}
		else if (command.startsWith("admin_skill_test") || command.startsWith("admin_st"))
		{
			try
			{
				StringTokenizer st = new StringTokenizer(command);
				st.nextToken();
				int id = Integer.parseInt(st.nextToken());
				adminTestSkill(activeChar, id);
			}
			catch (NumberFormatException e)
			{
				activeChar.sendMessage(87);
			}
			catch (NoSuchElementException nsee)
			{
				activeChar.sendMessage(87);
			}
		}
		else if (command.startsWith("admin_test uni flush"))
		{
			Universe.getInstance().flush();
			activeChar.sendMessage(358);
		}
		else if (command.startsWith("admin_test uni"))
		{
			L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[359]);
			cm.addNumber(Universe.getInstance().size());
			cm.sendMessage(activeChar);
		}
		else if (command.equals("admin_mp on"))
		{
			//.startPacketMonitor();
			activeChar.sendMessage(648);
		}
		else if (command.equals("admin_mp off"))
		{
			//.stopPacketMonitor();
			activeChar.sendMessage(648);
		}
		else if (command.equals("admin_mp dump"))
		{
			//.dumpPacketHistory();
			activeChar.sendMessage(648);
		}
		else if (command.equals("admin_known on"))
		{
			Config.CHECK_KNOWN = true;
		}
		else if (command.equals("admin_known off"))
		{
			Config.CHECK_KNOWN = false;
		}
		return true;
	}
	
	/**
	 * @param activeChar
	 * @param id
	 */
	private void adminTestSkill(L2PcInstance activeChar, int id)
	{
		L2Character player;
		L2Object target = activeChar.getTarget();
		if (!(target instanceof L2Character))
			player = activeChar;
		else
			player = (L2Character) target;
		player.broadcastPacket(new MagicSkillUse(activeChar, player, id, 1, 1, 1));
		
	}
	
	/* (non-Javadoc)
	 * @see net.sf.l2j.gameserver.handler.IAdminCommandHandler#getAdminCommandList()
	 */
	public String[] getAdminCommandList()
	{
		return ADMIN_COMMANDS;
	}
	
}
