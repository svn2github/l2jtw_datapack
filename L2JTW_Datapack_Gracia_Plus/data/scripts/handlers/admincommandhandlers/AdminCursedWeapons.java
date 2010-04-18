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

import java.util.Collection;
import java.util.StringTokenizer;

import com.l2jserver.gameserver.handler.IAdminCommandHandler;
import com.l2jserver.gameserver.instancemanager.CursedWeaponsManager;
import com.l2jserver.gameserver.model.CursedWeapon;
import com.l2jserver.gameserver.model.L2Object;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.NpcHtmlMessage;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;
import com.l2jserver.util.StringUtil;
import com.l2jserver.gameserver.datatables.MessageTable;

/**
 * This class handles following admin commands:
 * - cw_info = displays cursed weapon status
 * - cw_remove = removes a cursed weapon from the world, item id or name must be provided
 * - cw_add = adds a cursed weapon into the world, item id or name must be provided. Target will be the weilder
 * - cw_goto = teleports GM to the specified cursed weapon
 * - cw_reload = reloads instance manager
 * @version $Revision: 1.1.6.3 $ $Date: 2007/07/31 10:06:06 $
 */
public class AdminCursedWeapons implements IAdminCommandHandler
{
	private static final String[] ADMIN_COMMANDS =
	{
		"admin_cw_info",
		"admin_cw_remove",
		"admin_cw_goto",
		"admin_cw_reload",
		"admin_cw_add",
		"admin_cw_info_menu"
	};
	
	private int itemId;
	
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		
		CursedWeaponsManager cwm = CursedWeaponsManager.getInstance();
		int id = 0;
		
		StringTokenizer st = new StringTokenizer(command);
		st.nextToken();
		
		if (command.startsWith("admin_cw_info"))
		{
			if (!command.contains("menu"))
			{
				activeChar.sendMessage(1491);
				for (CursedWeapon cw : cwm.getCursedWeapons())
				{
					activeChar.sendMessage("> " + cw.getName() + " (" + cw.getItemId() + ")");
					if (cw.isActivated())
					{
						L2PcInstance pl = cw.getPlayer();
						activeChar.sendMessage(MessageTable.Messages[1492].getExtra(1) + (pl == null ? MessageTable.Messages[1492].getExtra(2) : pl.getName()));
						activeChar.sendMessage(MessageTable.Messages[1493].getMessage() + cw.getPlayerKarma());
						activeChar.sendMessage(MessageTable.Messages[1494].getExtra(1) + (cw.getTimeLeft() / 60000) + MessageTable.Messages[1494].getExtra(2));
						activeChar.sendMessage(MessageTable.Messages[1495].getMessage() + cw.getNbKills());
					}
					else if (cw.isDropped())
					{
						activeChar.sendMessage(1496);
						activeChar.sendMessage(MessageTable.Messages[1494].getExtra(1) + (cw.getTimeLeft() / 60000) + MessageTable.Messages[1494].getExtra(2));
						activeChar.sendMessage(MessageTable.Messages[1495].getMessage() + cw.getNbKills());
					}
					else
					{
						activeChar.sendMessage(1497);
					}
					activeChar.sendPacket(new SystemMessage(SystemMessageId.FRIEND_LIST_FOOTER));
				}
			}
			else
			{
                            final Collection<CursedWeapon> cws = cwm.getCursedWeapons();
                            final StringBuilder replyMSG =
                                    new StringBuilder(cws.size() * 300);
                            NpcHtmlMessage adminReply = new NpcHtmlMessage(5);
                            adminReply.setFile(activeChar.getHtmlPrefix(), "data/html/admin/cwinfo.htm");
                            for (CursedWeapon cw : cwm.getCursedWeapons()) {
                                itemId = cw.getItemId();

                                StringUtil.append(replyMSG,
                                        "<table width=270><tr><td>"+MessageTable.Messages[1498].getMessage()+"</td><td>",
                                        cw.getName(),
                                        "</td></tr>");

                                if (cw.isActivated()) {
                                    L2PcInstance pl = cw.getPlayer();
                                    StringUtil.append(replyMSG,
                                            "<tr><td>"+MessageTable.Messages[1499].getMessage()+"</td><td>",
                                            (pl == null ? MessageTable.Messages[1500].getMessage() : pl.getName()),
                                            "</td></tr>" +
                                            "<tr><td>"+MessageTable.Messages[1501].getMessage()+"</td><td>",
                                            String.valueOf(cw.getPlayerKarma()),
                                            "</td></tr>" +
                                            "<tr><td>"+MessageTable.Messages[1502].getMessage()+"</td><td>",
                                            String.valueOf(cw.getPlayerPkKills()),
                                            "/",
                                            String.valueOf(cw.getNbKills()),
                                            "</td></tr>" +
                                            "<tr><td>"+MessageTable.Messages[1503].getMessage()+"</td><td>",
                                            String.valueOf(cw.getTimeLeft() / 60000),
                                            MessageTable.Messages[1504].getMessage()+"</td></tr>" +
                                            "<tr><td><button value=\""+MessageTable.Messages[1505].getMessage()+"\" action=\"bypass -h admin_cw_remove ",
                                            String.valueOf(itemId),
                                            "\" width=73 height=21 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td>" +
                                            "<td><button value=\""+MessageTable.Messages[1506].getMessage()+"\" action=\"bypass -h admin_cw_goto ",
                                            String.valueOf(itemId),
                                            "\" width=73 height=21 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>"
                                            );
                                }
                                else if (cw.isDropped()) {
                                    StringUtil.append(replyMSG,
                                            "<tr><td>"+MessageTable.Messages[1507].getMessage()+"</td><td>"+MessageTable.Messages[1508].getMessage()+"</td></tr>" +
                                            "<tr><td>"+MessageTable.Messages[1503].getMessage()+"</td><td>",
                                            String.valueOf(cw.getTimeLeft() / 60000),
                                            MessageTable.Messages[1504].getMessage()+"</td></tr>" +
                                            "<tr><td>"+MessageTable.Messages[1502].getMessage()+"</td><td>",
                                            String.valueOf(cw.getNbKills()),
                                            "</td></tr>" +
                                            "<tr><td><button value=\""+MessageTable.Messages[1505].getMessage()+"\" action=\"bypass -h admin_cw_remove ",
                                            String.valueOf(itemId),
                                            "\" width=73 height=21 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td>" +
                                            "<td><button value=\""+MessageTable.Messages[1506].getMessage()+"\" action=\"bypass -h admin_cw_goto ",
                                            String.valueOf(itemId),
                                            "\" width=73 height=21 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>"
                                            );
                                } else {
                                    StringUtil.append(replyMSG,
                                            "<tr><td>"+MessageTable.Messages[1507].getMessage()+"</td><td>"+MessageTable.Messages[1509].getMessage()+"</td></tr>" +
                                            "<tr><td><button value=\""+MessageTable.Messages[1510].getMessage()+"\" action=\"bypass -h admin_cw_add ",
                                            String.valueOf(itemId),
                                            "\" width=130 height=21 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td><td></td></tr>"
                                            );
                                }

                                replyMSG.append("</table><br>");
                            }
                            adminReply.replace("%cwinfo%", replyMSG.toString());
                            activeChar.sendPacket(adminReply);
			}
		}
		else if (command.startsWith("admin_cw_reload"))
		{
			cwm.reload();
		}
		else
		{
			CursedWeapon cw = null;
			try
			{
				String parameter = st.nextToken();
				if (parameter.matches("[0-9]*"))
					id = Integer.parseInt(parameter);
				else
				{
					parameter = parameter.replace('_', ' ');
					for (CursedWeapon cwp : cwm.getCursedWeapons())
					{
						if (cwp.getName().toLowerCase().contains(parameter.toLowerCase()))
						{
							id = cwp.getItemId();
							break;
						}
					}
				}
				cw = cwm.getCursedWeapon(id);
				if (cw == null)
				{
					activeChar.sendMessage(1511);
					return false;
				}
			}
			catch (Exception e)
			{
				activeChar.sendMessage("Usage: //cw_remove|//cw_goto|//cw_add <itemid|name>");
			}
			
			if (command.startsWith("admin_cw_remove "))
			{
				cw.endOfLife();
			}
			else if (command.startsWith("admin_cw_goto "))
			{
				cw.goTo(activeChar);
			}
			else if (command.startsWith("admin_cw_add"))
			{
				if (cw == null)
				{
					activeChar.sendMessage(1512);
					return false;
				}
				else if (cw.isActive())
					activeChar.sendMessage(1513);
				else
				{
					L2Object target = activeChar.getTarget();
					if (target instanceof L2PcInstance)
						((L2PcInstance) target).addItem("AdminCursedWeaponAdd", id, 1, target, true);
					else
						activeChar.addItem("AdminCursedWeaponAdd", id, 1, activeChar, true);
					cw.setEndTime(System.currentTimeMillis() + cw.getDuration() * 60000L);
					cw.reActivate();
					
				}
			}
			else
			{
				activeChar.sendMessage("Unknown command.");
			}
		}
		return true;
	}
	
	public String[] getAdminCommandList()
	{
		return ADMIN_COMMANDS;
	}
}