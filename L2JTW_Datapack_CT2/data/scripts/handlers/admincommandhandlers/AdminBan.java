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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.StringTokenizer;

import net.sf.l2j.Config;
import net.sf.l2j.L2DatabaseFactory;
import net.sf.l2j.gameserver.LoginServerThread;
import net.sf.l2j.gameserver.communitybbs.Manager.RegionBBSManager;
import net.sf.l2j.gameserver.handler.IAdminCommandHandler;
import net.sf.l2j.gameserver.model.L2World;
import net.sf.l2j.gameserver.model.actor.instance.L2PcInstance;
import net.sf.l2j.gameserver.network.SystemMessageId;
import net.sf.l2j.gameserver.network.serverpackets.SystemMessage;
import net.sf.l2j.gameserver.datatables.MessageTable;
import net.sf.l2j.gameserver.model.L2CoreMessage;
import net.sf.l2j.gameserver.util.GMAudit;


/**
 * This class handles following admin commands:
 * - ban_acc <account_name> = changes account access level to -100 and logs him off. If no account is specified target's account is used.
 * - ban_char <char_name> = changes a characters access level to -100 and logs him off. If no character is specified target is used.
 * - ban_chat <char_name> <duration> = chat bans a character for the specified duration. If no name is specified the target is chat banned indefinitely.
 * - unban_acc <account_name> = changes account access level to 0.
 * - unban_char <char_name> = changes specified characters access level to 0.
 * - unban_chat <char_name> = lifts chat ban from specified player. If no player name is specified current target is used.
 * - jail charname [penalty_time] = jails character. Time specified in minutes. For ever if no time is specified.
 * - unjail charname = Unjails player, teleport him to Floran.
 *
 * @version $Revision: 1.1.6.3 $ $Date: 2005/04/11 10:06:06 $
 */
public class AdminBan implements IAdminCommandHandler {
	private static final String[] ADMIN_COMMANDS = 
	{
		"admin_ban", // returns ban commands
		"admin_ban_acc",
		"admin_ban_char",
		"admin_ban_chat",
		"admin_unban", // returns unban commands
		"admin_unban_acc",
		"admin_unban_char",
		"admin_unban_chat",
		"admin_jail",
		"admin_unjail"
	};

	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		StringTokenizer st = new StringTokenizer(command);
		st.nextToken();
		String player = "";
		int duration = -1;
		L2PcInstance targetPlayer = null;

		if (st.hasMoreTokens())
		{
			player = st.nextToken();
			targetPlayer = L2World.getInstance().getPlayer(player);

	        if (st.hasMoreTokens())
	        {
	            try
	            {
	                duration = Integer.parseInt(st.nextToken());
	            }
	            catch (NumberFormatException nfe)
	            {
	            	L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[312]);
	            	cm.addString(""+nfe);
	            	cm.sendMessage(activeChar);
	            	return false;
	            }
	        }
		}
		else
		{
			if (activeChar.getTarget() != null && activeChar.getTarget() instanceof L2PcInstance)
			{
				targetPlayer = (L2PcInstance)activeChar.getTarget();
			}
		}
		
		if (targetPlayer != null && targetPlayer.equals(activeChar))
		{
			activeChar.sendPacket(new SystemMessage(SystemMessageId.CANNOT_USE_ON_YOURSELF));
			return false;
		}
		
		if (command.startsWith("admin_ban ") || command.equalsIgnoreCase("admin_ban"))
		{
			activeChar.sendMessage(319);
			return false;
		}
		else if (command.startsWith("admin_ban_acc"))
		{
			// May need to check usage in admin_ban_menu as well.
			
			if (targetPlayer == null && player.equals(""))
			{
				activeChar.sendMessage(349);
				return false;
			}
			else if (targetPlayer == null)
			{
				LoginServerThread.getInstance().sendAccessLevel(player, -100);
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[353]);
				cm.addString(player);
				cm.sendMessage(activeChar);
				auditAction(command, activeChar, player);
			}
			else
			{
				targetPlayer.setAccountAccesslevel(-100);
				targetPlayer.logout();
				RegionBBSManager.getInstance().changeCommunityBoard();
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[21]);
				cm.addString(targetPlayer.getAccountName());
				cm.sendMessage(activeChar);
				auditAction(command, activeChar, targetPlayer.getAccountName());
			}
		}
		else if (command.startsWith("admin_ban_char"))
		{
			if (targetPlayer == null && player.equals(""))
			{
				activeChar.sendMessage(381);
				return false;
			}
			else
			{
				auditAction(command, activeChar, (targetPlayer == null ? player : targetPlayer.getName()));
				return changeCharAccessLevel(targetPlayer, player, activeChar, -100);
			}
		}
		else if (command.startsWith("admin_ban_chat"))
		{
			if (targetPlayer == null)
			{
				activeChar.sendMessage(354);
				return false;
			}
			else if (targetPlayer.getPunishLevel().value() > L2PcInstance.PunishLevel.CHAT.value())
			{
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[439]);
				cm.addString(targetPlayer.getName());
				cm.sendMessage(activeChar);
				return false;
			}
			
			L2CoreMessage cm = new L2CoreMessage(MessageTable.Messages[675]);
			cm.addString(targetPlayer.getName());

			targetPlayer.setPunishLevel(L2PcInstance.PunishLevel.CHAT, duration);
			if (duration > 0)
			{
				cm.addExtra(1);
				cm.addNumber(duration);
			}
			else
			{
				cm.addExtra(2);
			}
			cm.sendMessage(activeChar);
            auditAction(command, activeChar, targetPlayer.getName());
		}
		else if (command.startsWith("admin_unban ") || command.equalsIgnoreCase("admin_unban"))
		{
			activeChar.sendMessage(426);
			return false;
		}
		else if (command.startsWith("admin_unban_acc"))
		{
			// Need to check admin_unban_menu command as well in AdminMenu.java handler.
			
			if (targetPlayer != null)
			{
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[357]);
				cm.addString(targetPlayer.getName());
				cm.sendMessage(activeChar);
				return false;
			}
			else if (!player.equals(""))
			{
				LoginServerThread.getInstance().sendAccessLevel(player, 0);
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[73]);
				cm.addString(player);
				cm.sendMessage(activeChar);
				auditAction(command, activeChar, player);
			}
			else
			{
				activeChar.sendMessage(40);
				return false;
			}
		}
		else if (command.startsWith("admin_unban_char"))
		{
			if (targetPlayer == null && player.equals(""))
			{
				activeChar.sendMessage(398);
				return false;
			}
			else if (targetPlayer != null)
			{
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[357]);
				cm.addString(targetPlayer.getName());
				cm.sendMessage(activeChar);
				return false;
			}
			else
			{
				auditAction(command, activeChar, player);
				return changeCharAccessLevel(null, player, activeChar, 0);
			}
		}
		else if (command.startsWith("admin_unban_chat"))
		{
			if (targetPlayer == null)
			{
				activeChar.sendMessage(273);
				return false;
			}
			else if (targetPlayer.isChatBanned())
            {
            	targetPlayer.setPunishLevel(L2PcInstance.PunishLevel.NONE, 0);
            	L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[440]);
            	cm.addString(targetPlayer.getName());
            	cm.sendMessage(activeChar);
            	auditAction(command, activeChar, targetPlayer.getName());
            }
            else
            {
            	L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[450]);
            	cm.addString(targetPlayer.getName());
            	cm.sendMessage(activeChar);
            }
		}
		else if (command.startsWith("admin_jail"))
		{
			if (targetPlayer == null && player.equals(""))
			{
				activeChar.sendMessage(458);
				return false;
			}
			if (targetPlayer != null)
			{
				targetPlayer.setPunishLevel(L2PcInstance.PunishLevel.JAIL, duration);
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[72]);
				cm.addString(targetPlayer.getName());
				if (duration > 0)
					cm.addString(duration+cm.getExtra(1));
				else
					cm.addString(cm.getExtra(2));
				cm.sendMessage(activeChar);
				auditAction(command, activeChar, targetPlayer.getName());
			}
			else
			{
				jailOfflinePlayer(activeChar, player, duration);
				auditAction(command, activeChar, player);
			}
		}
		else if (command.startsWith("admin_unjail"))
		{
			if (targetPlayer == null && player.equals(""))
			{
				activeChar.sendMessage(463);
				return false;
			}
			else if (targetPlayer != null)
			{
				targetPlayer.setPunishLevel(L2PcInstance.PunishLevel.NONE, 0);
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[467]);
				cm.addString(targetPlayer.getName());
				cm.sendMessage(activeChar);
				auditAction(command, activeChar, targetPlayer.getName());
			}
			else
			{
				unjailOfflinePlayer(activeChar, player);
				auditAction(command, activeChar, player);
			}
		}
		return true;
	}
	
	private void auditAction(String fullCommand, L2PcInstance activeChar, String target)
	{
		if (!Config.GMAUDIT)
			return;
		
		String[] command = fullCommand.split(" ");
		
		GMAudit.auditGMAction(activeChar.getName()+" ["+activeChar.getObjectId()+"]", command[0], (target.equals("") ? "no-target" : target), (command.length > 2 ? command[2] : ""));
	}
	
	private void jailOfflinePlayer(L2PcInstance activeChar, String name, int delay)
	{
		Connection con = null;
		try
		{
			con = L2DatabaseFactory.getInstance().getConnection();

			PreparedStatement statement = con.prepareStatement("UPDATE characters SET x=?, y=?, z=?, punish_level=?, punish_timer=? WHERE char_name=?");
			statement.setInt(1, -114356);
			statement.setInt(2, -249645);
			statement.setInt(3, -2984);
			statement.setInt(4, L2PcInstance.PunishLevel.JAIL.value());
			statement.setLong(5, (delay > 0 ? delay * 60000L : 0));
			statement.setString(6, name);
			
			statement.execute();
			int count = statement.getUpdateCount();
			statement.close();
			
			if (count == 0)
				activeChar.sendMessage(78);
			else
			{
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[72]);
				cm.addString(name);
				if (delay > 0)
					cm.addString(delay+cm.getExtra(1));
				else
					cm.addString(cm.getExtra(2));
				cm.sendMessage(activeChar);
			}
		}
		catch (SQLException se)
		{
			activeChar.sendMessage(267);
			if (Config.DEBUG)
				se.printStackTrace();
		}
		finally
		{
			try
			{
				con.close();
			}
			catch (Exception e)
			{
				if (Config.DEBUG)
					e.printStackTrace();
			}
		}
	}
	
	private void unjailOfflinePlayer(L2PcInstance activeChar, String name)
	{
		Connection con = null;
		try
		{
			con = L2DatabaseFactory.getInstance().getConnection();
			PreparedStatement statement = con.prepareStatement("UPDATE characters SET x=?, y=?, z=?, punish_level=?, punish_timer=? WHERE char_name=?");
			statement.setInt(1, 17836);
			statement.setInt(2, 170178);
			statement.setInt(3, -3507);
			statement.setInt(4, 0);
			statement.setLong(5, 0);
			statement.setString(6, name);
			statement.execute();
			int count = statement.getUpdateCount();
			statement.close();
			if (count == 0)
				activeChar.sendMessage(78);
			else
			{
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[467]);
				cm.addString(name);
				cm.sendMessage(activeChar);
			}
		}
		catch (SQLException se)
		{
			activeChar.sendMessage(267);
			if (Config.DEBUG)
				se.printStackTrace();
		}
		finally
		{
			try
			{
				con.close();
			}
			catch (Exception e)
			{
				if (Config.DEBUG)
					e.printStackTrace();
			}
		}
	}
	
	private boolean changeCharAccessLevel(L2PcInstance targetPlayer, String player, L2PcInstance activeChar, int lvl)
	{
		if (targetPlayer != null)
		{
			targetPlayer.setAccessLevel(lvl);
			targetPlayer.sendMessage(473);
			targetPlayer.logout();
			RegionBBSManager.getInstance().changeCommunityBoard();
			L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[480]);
			cm.addString(targetPlayer.getName());
			cm.sendMessage(activeChar);
		}
		else
		{
			Connection con = null;
			try
			{
				con = L2DatabaseFactory.getInstance().getConnection();
				PreparedStatement statement = con.prepareStatement("UPDATE characters SET accesslevel=? WHERE char_name=?");
				statement.setInt(1, lvl);
				statement.setString(2, player);
				statement.execute();
				int count = statement.getUpdateCount();
				statement.close();
				if (count == 0)
				{
					activeChar.sendMessage(77);
					return false;
				}
				else
				{
					L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[272]);
					cm.addString(player);
					cm.addNumber(lvl);
					cm.sendMessage(activeChar);
				}
			}
			catch (SQLException se)
			{
				activeChar.sendMessage(267);
				if (Config.DEBUG)
					se.printStackTrace();
				return false;
			}
			finally
			{
				try
				{
					con.close();
				}
				catch (Exception e) {}
			}
		}
		return true;
	}

	public String[] getAdminCommandList() {
		return ADMIN_COMMANDS;
	}
}