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

import java.util.NoSuchElementException;
import java.util.StringTokenizer;

import com.l2jserver.gameserver.datatables.ClanTable;
import com.l2jserver.gameserver.handler.IAdminCommandHandler;
import com.l2jserver.gameserver.model.L2Clan;
import com.l2jserver.gameserver.model.L2Object;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.GMViewPledgeInfo;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;
import com.l2jserver.gameserver.datatables.MessageTable;

/**
 * <B>Pledge Manipulation:</B><BR>
 * <LI>With target in a character without clan:<BR>
 * //pledge create clanname
 * <LI>With target in a clan leader:<BR>
 * //pledge info<BR>
 * //pledge dismiss<BR>
 * //pledge setlevel level<BR>
 * //pledge rep reputation_points<BR>
 */
public class AdminPledge implements IAdminCommandHandler
{
	private static final String[] ADMIN_COMMANDS =
	{
		"admin_pledge"
	};
	
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		L2Object target = activeChar.getTarget();
		L2PcInstance player = null;
		if (target instanceof L2PcInstance)
			player = (L2PcInstance) target;
		else
		{
			activeChar.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.INCORRECT_TARGET));
			showMainPage(activeChar);
			return false;
		}
		String name = player.getName();
		if (command.startsWith("admin_pledge"))
		{
			String action = null;
			String parameter = null;
			StringTokenizer st = new StringTokenizer(command);
			try
			{
				st.nextToken();
				action = st.nextToken(); // create|info|dismiss|setlevel|rep
				parameter = st.nextToken(); // clanname|nothing|nothing|level|rep_points
			}
			catch (NoSuchElementException nse)
			{
			}
			if (action.equals("create"))
			{
				long cet = player.getClanCreateExpiryTime();
				player.setClanCreateExpiryTime(0);
				L2Clan clan = ClanTable.getInstance().createClan(player, parameter);
				if (clan != null)
					activeChar.sendMessage(MessageTable.Messages[1790].getExtra(1) + parameter + MessageTable.Messages[1790].getExtra(2) + player.getName());
				else
				{
					player.setClanCreateExpiryTime(cet);
					activeChar.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.FAILED_TO_CREATE_CLAN));
				}
			}
			else if (!player.isClanLeader())
			{
				activeChar.sendPacket(SystemMessage.getSystemMessage(SystemMessageId.S1_IS_NOT_A_CLAN_LEADER).addString(name));
				showMainPage(activeChar);
				return false;
			}
			else if (action.equals("dismiss"))
			{
				ClanTable.getInstance().destroyClan(player.getClanId());
				L2Clan clan = player.getClan();
				if (clan == null)
					activeChar.sendMessage(1791);
				else
					activeChar.sendMessage(1792);
			}
			else if (action.equals("info"))
			{
				activeChar.sendPacket(new GMViewPledgeInfo(player.getClan(), player));
			}
			else if (parameter == null)
				activeChar.sendMessage("Usage: //pledge <setlevel|rep> <number>");
			else if (action.equals("setlevel"))
			{
				int level = Integer.parseInt(parameter);
				if (level >= 0 && level < 12)
				{
					player.getClan().changeLevel(level);
					activeChar.sendMessage(MessageTable.Messages[1793].getExtra(1) + level + MessageTable.Messages[1793].getExtra(2) + player.getClan().getName());
				}
				else
					activeChar.sendMessage(1794);
			}
			else if (action.startsWith("rep"))
			{
				try
				{
					int points = Integer.parseInt(parameter);
					L2Clan clan = player.getClan();
					if (clan.getLevel() < 5)
					{
						activeChar.sendMessage(1795);
						showMainPage(activeChar);
						return false;
					}
					clan.addReputationScore(points, true);
					activeChar.sendMessage(MessageTable.Messages[1796].getExtra(1) + (points > 0 ? MessageTable.Messages[1796].getExtra(2) : MessageTable.Messages[1796].getExtra(3)) + Math.abs(points) + MessageTable.Messages[1796].getExtra(4) + (points > 0 ? MessageTable.Messages[1796].getExtra(5) : MessageTable.Messages[1796].getExtra(6)) + clan.getName() + MessageTable.Messages[1796].getExtra(7) + clan.getReputationScore());
				}
				catch (Exception e)
				{
					activeChar.sendMessage("Usage: //pledge <rep> <number>");
				}
			}
		}
		showMainPage(activeChar);
		return true;
	}
	
	public String[] getAdminCommandList()
	{
		return ADMIN_COMMANDS;
	}
	
	private void showMainPage(L2PcInstance activeChar)
	{
		AdminHelpPage.showHelpPage(activeChar, "game_menu.htm");
	}
	
}
