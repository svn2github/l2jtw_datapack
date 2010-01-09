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
import java.util.logging.Logger;

import com.l2jserver.Config;
import com.l2jserver.gameserver.GmListTable;
import com.l2jserver.gameserver.cache.HtmCache;
import com.l2jserver.gameserver.datatables.AccessLevels;
import com.l2jserver.gameserver.datatables.AdminCommandAccessRights;
import com.l2jserver.gameserver.datatables.ItemTable;
import com.l2jserver.gameserver.datatables.NpcTable;
import com.l2jserver.gameserver.datatables.NpcWalkerRoutesTable;
import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.datatables.TeleportLocationTable;
import com.l2jserver.gameserver.handler.IAdminCommandHandler;
import com.l2jserver.gameserver.instancemanager.Manager;
import com.l2jserver.gameserver.instancemanager.QuestManager;
import com.l2jserver.gameserver.model.L2Multisell;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.olympiad.Olympiad;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;
import com.l2jserver.gameserver.datatables.MessageTable;
import com.l2jserver.gameserver.model.L2CoreMessage;

/**
 * This class handles following admin commands:
 * - admin|admin1/admin2/admin3/admin4/admin5 = slots for the 5 starting admin menus
 * - gmliston/gmlistoff = includes/excludes active character from /gmlist results
 * - silence = toggles private messages acceptance mode
 * - diet = toggles weight penalty mode
 * - tradeoff = toggles trade acceptance mode
 * - reload = reloads specified component from multisell|skill|npc|htm|item|instancemanager
 * - set/set_menu/set_mod = alters specified server setting
 * - saveolymp = saves olympiad state manually
 * - manualhero = cycles olympiad and calculate new heroes.
 * @version $Revision: 1.3.2.1.2.4 $ $Date: 2007/07/28 10:06:06 $
 */
public class AdminAdmin implements IAdminCommandHandler
{
	private static Logger _log = Logger.getLogger(AdminAdmin.class.getName());
	
	private static final String[] ADMIN_COMMANDS =
	{
		"admin_admin",
		"admin_admin1",
		"admin_admin2",
		"admin_admin3",
		"admin_admin4",
		"admin_admin5",
		"admin_gmliston",
		"admin_gmlistoff",
		"admin_silence",
		"admin_diet",
		"admin_tradeoff",
		"admin_reload",
		"admin_set",
		"admin_set_menu",
		"admin_set_mod",
		"admin_saveolymp",
		"admin_manualhero",
		"admin_sethero",
		"admin_endolympiad"
	};
	
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		
		if (command.startsWith("admin_admin"))
		{
			showMainPage(activeChar, command);
		}
		else if (command.startsWith("admin_gmliston"))
		{
			GmListTable.getInstance().showGm(activeChar);
			activeChar.sendMessage(250);
		}
		else if (command.startsWith("admin_gmlistoff"))
		{
			GmListTable.getInstance().hideGm(activeChar);
			activeChar.sendMessage(256);
		}
		else if (command.startsWith("admin_silence"))
		{
			if (activeChar.isSilenceMode()) // already in message refusal mode
			{
				activeChar.setSilenceMode(false);
				activeChar.sendPacket(new SystemMessage(SystemMessageId.MESSAGE_ACCEPTANCE_MODE));
			}
			else
			{
				activeChar.setSilenceMode(true);
				activeChar.sendPacket(new SystemMessage(SystemMessageId.MESSAGE_REFUSAL_MODE));
			}
		}
		else if (command.startsWith("admin_saveolymp"))
		{
			Olympiad.getInstance().saveOlympiadStatus();
			activeChar.sendMessage(654);
		}
		else if (command.startsWith("admin_endolympiad"))
		{
			try
			{
				Olympiad.getInstance().manualSelectHeroes();
			}
			catch (Exception e)
			{
				_log.warning("An error occured while ending olympiad: " + e);
			}
			activeChar.sendMessage(144);
		}
		else if (command.startsWith("admin_manualhero") || command.startsWith("admin_sethero"))
		{
			L2PcInstance target = null;
			
			if (activeChar.getTarget() instanceof L2PcInstance)
			{
				target = (L2PcInstance) activeChar.getTarget();
				target.setHero(target.isHero() ? false : true);
			}
			else
			{
				target = activeChar;
				target.setHero(target.isHero() ? false : true);
			}
			target.broadcastUserInfo();
		}
		else if (command.startsWith("admin_diet"))
		{
			try
			{
				StringTokenizer st = new StringTokenizer(command);
				st.nextToken();
				if (st.nextToken().equalsIgnoreCase("on"))
				{
					activeChar.setDietMode(true);
					activeChar.sendMessage(102);
				}
				else if (st.nextToken().equalsIgnoreCase("off"))
				{
					activeChar.setDietMode(false);
					activeChar.sendMessage(101);
				}
			}
			catch (Exception ex)
			{
				if (activeChar.getDietMode())
				{
					activeChar.setDietMode(false);
					activeChar.sendMessage(101);
				}
				else
				{
					activeChar.setDietMode(true);
					activeChar.sendMessage(102);
				}
			}
			finally
			{
				activeChar.refreshOverloaded();
			}
		}
		else if (command.startsWith("admin_tradeoff"))
		{
			try
			{
				String mode = command.substring(15);
				if (mode.equalsIgnoreCase("on"))
				{
					activeChar.setTradeRefusal(true);
					activeChar.sendMessage(351);
				}
				else if (mode.equalsIgnoreCase("off"))
				{
					activeChar.setTradeRefusal(false);
					activeChar.sendMessage(350);
				}
			}
			catch (Exception ex)
			{
				if (activeChar.getTradeRefusal())
				{
					activeChar.setTradeRefusal(false);
					activeChar.sendMessage(350);
				}
				else
				{
					activeChar.setTradeRefusal(true);
					activeChar.sendMessage(351);
				}
			}
		}
		else if (command.startsWith("admin_reload"))
		{
			StringTokenizer st = new StringTokenizer(command);
			st.nextToken();
			String type = "";
			try
			{
				type = st.nextToken();
				if (type.equals("multisell"))
				{
					L2Multisell.getInstance().reload();
					activeChar.sendMessage(652);
				}
				else if (type.startsWith("teleport"))
				{
					TeleportLocationTable.getInstance().reloadAll();
					activeChar.sendMessage(657);
				}
				else if (type.startsWith("skill"))
				{
					SkillTable.getInstance().reload();
					activeChar.sendMessage(656);
				}
				else if (type.equals("npc"))
				{
					NpcTable.getInstance().reloadAllNpc();
					QuestManager.getInstance().reloadAllQuests();
					activeChar.sendMessage(653);
				}
				else if (type.startsWith("htm"))
				{
					HtmCache.getInstance().reload();
					L2CoreMessage cm = new L2CoreMessage (MessageTable.Messages[47]);
					cm.addNumber(HtmCache.getInstance().getMemoryUsage());
					cm.addNumber(HtmCache.getInstance().getLoadedFiles());
					cm.sendMessage(activeChar);
				}
				else if (type.startsWith("item"))
				{
					ItemTable.getInstance().reload();
					activeChar.sendMessage(172);
				}
				else if (type.startsWith("config"))
				{
					Config.load();
					activeChar.sendMessage(555);
				}
				else if (type.startsWith("instancemanager"))
				{
					Manager.reloadAll();
					activeChar.sendMessage(38);
				}
				else if (type.startsWith("npcwalkers"))
				{
					NpcWalkerRoutesTable.getInstance().load();
					activeChar.sendMessage(37);
				}
				else if (type.startsWith("access"))
				{
					AccessLevels.getInstance().reloadAccessLevels();
					AdminCommandAccessRights.getInstance().reloadAdminCommandAccessRights();
					activeChar.sendMessage(20);
				}
				else if (type.startsWith("quests"))
				{
					QuestManager.getInstance().reloadAllQuests();
					activeChar.sendMessage(516);
				}
				
				activeChar.sendMessage("WARNING: There are several known issues regarding this feature. Reloading server data during runtime is STRONGLY NOT RECOMMENDED for live servers, just for developing environments."); //TODO Insert MessabeTable Tiger 2010/01/09
				
			}
			catch (Exception e)
			{
				activeChar.sendMessage("An error occured while reloading " + type + " !");
				activeChar.sendMessage(369);
				_log.warning("An error occured while reloading " + type + ": " + e); //do not mask an exception here
			}
		}
		
		else if (command.startsWith("admin_set"))
		{
			StringTokenizer st = new StringTokenizer(command);
			String[] cmd = st.nextToken().split("_");
			try
			{
				String[] parameter = st.nextToken().split("=");
				String pName = parameter[0].trim();
				String pValue = parameter[1].trim();
				if (Config.setParameterValue(pName, pValue))
				{
					L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[655]);
					cm.addString(pName);
					cm.addString(pValue);
					cm.sendMessage(activeChar);
				}
				else
					activeChar.sendMessage(165);
			}
			catch (Exception e)
			{
				if (cmd.length == 2)
					activeChar.sendMessage(417);
			}
			finally
			{
				if (cmd.length == 3)
				{
					if (cmd[2].equalsIgnoreCase("menu"))
						AdminHelpPage.showHelpPage(activeChar, "settings.htm");
					else if (cmd[2].equalsIgnoreCase("mod"))
						AdminHelpPage.showHelpPage(activeChar, "mods_menu.htm");
				}
			}
		}
		return true;
	}
	
	public String[] getAdminCommandList()
	{
		return ADMIN_COMMANDS;
	}
	
	private void showMainPage(L2PcInstance activeChar, String command)
	{
		int mode = 0;
		String filename = null;
		try
		{
			mode = Integer.parseInt(command.substring(11));
		}
		catch (Exception e)
		{
		}
		switch (mode)
		{
			case 1:
				filename = "main";
				break;
			case 2:
				filename = "game";
				break;
			case 3:
				filename = "effects";
				break;
			case 4:
				filename = "server";
				break;
			case 5:
				filename = "mods";
				break;
			default:
				if (Config.GM_ADMIN_MENU_STYLE.equals("modern"))
					filename = "main";
				else
					filename = "classic";
				break;
		}
		AdminHelpPage.showHelpPage(activeChar, filename + "_menu.htm");
	}
}
