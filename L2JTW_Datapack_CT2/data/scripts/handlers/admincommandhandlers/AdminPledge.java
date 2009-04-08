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

import net.sf.l2j.gameserver.datatables.ClanTable;
import net.sf.l2j.gameserver.handler.IAdminCommandHandler;
import net.sf.l2j.gameserver.model.L2Clan;
import net.sf.l2j.gameserver.model.L2Object;
import net.sf.l2j.gameserver.model.actor.instance.L2PcInstance;
import net.sf.l2j.gameserver.network.SystemMessageId;
import net.sf.l2j.gameserver.network.serverpackets.GMViewPledgeInfo;
import net.sf.l2j.gameserver.network.serverpackets.SystemMessage;
import net.sf.l2j.gameserver.datatables.MessageTable;
import net.sf.l2j.gameserver.model.L2CoreMessage;

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
			activeChar.sendPacket(new SystemMessage(SystemMessageId.INCORRECT_TARGET));
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
				{
					L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[81]);
					cm.addString(parameter);
					cm.addString(player.getName());
					cm.sendMessage(activeChar);
				}
				else
				{
					player.setClanCreateExpiryTime(cet);
					activeChar.sendPacket(new SystemMessage(SystemMessageId.FAILED_TO_CREATE_CLAN));
				}
			}
			else if (!player.isClanLeader())
			{
				activeChar.sendPacket(new SystemMessage(SystemMessageId.S1_IS_NOT_A_CLAN_LEADER).addString(name));
				showMainPage(activeChar);
				return false;
			}
			else if (action.equals("dismiss"))
			{
				ClanTable.getInstance().destroyClan(player.getClanId());
				L2Clan clan = player.getClan();
				if (clan == null)
					activeChar.sendMessage(82);
				else
					activeChar.sendMessage(320);
			}
			else if (action.equals("info"))
			{
				activeChar.sendPacket(new GMViewPledgeInfo(player.getClan(), player));
			}
			else if (parameter == null)
				activeChar.sendMessage(412);
			else if (action.equals("setlevel"))
			{
				int level = Integer.parseInt(parameter);
				if (level >= 0 && level < 11)
				{
					player.getClan().changeLevel(level);
					L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[596]);
					cm.addNumber(level);
					cm.addString(player.getClan().getName());
					cm.sendMessage(activeChar);
				}
				else
					activeChar.sendMessage(177);
			}
			else if (action.startsWith("rep"))
			{
				try
				{
					int points = Integer.parseInt(parameter);
					L2Clan clan = player.getClan();
					if (clan.getLevel() < 5)
					{
						activeChar.sendMessage(223);
						showMainPage(activeChar);
						return false;
					}
					clan.setReputationScore(clan.getReputationScore() + points, true);
					
					L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[693]);
					if(points > 0 )
					{
						cm.addExtra(1);
						cm.addExtra(3);
					}
					else
					{
						cm.addExtra(2);
						cm.addExtra(4);
					}
					cm.addNumber(Math.abs(points));
					cm.addString(clan.getName());
					cm.addNumber(clan.getReputationScore());
					cm.sendMessage(activeChar);
				}
				catch (Exception e)
				{
					activeChar.sendMessage(411);
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
