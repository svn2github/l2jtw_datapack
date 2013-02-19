/*
 * Copyright (C) 2004-2013 L2J DataPack
 * 
 * This file is part of L2J DataPack.
 * 
 * L2J DataPack is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * L2J DataPack is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
package handlers.admincommandhandlers;

import java.util.StringTokenizer;
import java.util.logging.Level;
import java.util.logging.Logger;

import javolution.text.TextBuilder;

import com.l2jserver.Config;
import com.l2jserver.gameserver.cache.HtmCache;
import com.l2jserver.gameserver.datatables.AdminTable;
import com.l2jserver.gameserver.datatables.DoorTable;
import com.l2jserver.gameserver.datatables.ItemTable;
import com.l2jserver.gameserver.datatables.MultiSell;
import com.l2jserver.gameserver.datatables.NpcTable;
import com.l2jserver.gameserver.datatables.NpcWalkerRoutesData;
import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.datatables.SpawnTable;
import com.l2jserver.gameserver.datatables.TeleportLocationTable;
import com.l2jserver.gameserver.handler.IAdminCommandHandler;
import com.l2jserver.gameserver.instancemanager.QuestManager;
import com.l2jserver.gameserver.model.L2Spawn;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.olympiad.Olympiad;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.NpcHtmlMessage;
import com.l2jserver.gameserver.datatables.MessageTable; // Add By L2JTW

/**
 * This class handles following admin commands: - admin|admin1/admin2/admin3/admin4/admin5 = slots for the 5 starting admin menus - gmliston/gmlistoff = includes/excludes active character from /gmlist results - silence = toggles private messages acceptance mode - diet = toggles weight penalty mode -
 * tradeoff = toggles trade acceptance mode - reload = reloads specified component from multisell|skill|npc|htm|item - set/set_menu/set_mod = alters specified server setting - saveolymp = saves olympiad state manually - manualhero = cycles olympiad and calculate new heroes.
 * @version $Revision: 1.3.2.1.2.4 $ $Date: 2007/07/28 10:06:06 $
 */
public class AdminAdmin implements IAdminCommandHandler
{
	private static final Logger _log = Logger.getLogger(AdminAdmin.class.getName());
	
	private static final String[] ADMIN_COMMANDS =
	{
		"admin_admin",
		"admin_admin1",
		"admin_admin2",
		"admin_admin3",
		"admin_admin4",
		"admin_admin5",
		"admin_admin6",
		"admin_admin7",
		"admin_admin8",
		"admin_gmliston",
		"admin_gmlistoff",
		"admin_silence",
		"admin_diet",
		"admin_tradeoff",
		"admin_reload",
		"admin_set",
		"admin_set_mod",
		"admin_saveolymp",
		"admin_manualhero",
		"admin_sethero",
		"admin_endolympiad",
		"admin_setconfig",
		"admin_config_server",
		"admin_gmon"
	};
	
	@Override
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		if (command.startsWith("admin_admin"))
		{
			showMainPage(activeChar, command);
		}
		else if (command.equals("admin_config_server"))
		{
			showConfigPage(activeChar);
		}
		else if (command.startsWith("admin_gmliston"))
		{
			AdminTable.getInstance().showGm(activeChar);
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Registered into gm list");
			*/
			activeChar.sendMessage(1370);
			AdminHelpPage.showHelpPage(activeChar, "gm_menu.htm");
		}
		else if (command.startsWith("admin_gmlistoff"))
		{
			AdminTable.getInstance().hideGm(activeChar);
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Removed from gm list");
			*/
			activeChar.sendMessage(1371);
			AdminHelpPage.showHelpPage(activeChar, "gm_menu.htm");
		}
		else if (command.startsWith("admin_silence"))
		{
			if (activeChar.isSilenceMode()) // already in message refusal mode
			{
				activeChar.setSilenceMode(false);
				activeChar.sendPacket(SystemMessageId.MESSAGE_ACCEPTANCE_MODE);
			}
			else
			{
				activeChar.setSilenceMode(true);
				activeChar.sendPacket(SystemMessageId.MESSAGE_REFUSAL_MODE);
			}
			AdminHelpPage.showHelpPage(activeChar, "gm_menu.htm");
		}
		else if (command.startsWith("admin_saveolymp"))
		{
			Olympiad.getInstance().saveOlympiadStatus();
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("olympiad system saved.");
			*/
			activeChar.sendMessage(1372);
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
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Heroes formed.");
			*/
			activeChar.sendMessage(1373);
		}
		else if (command.startsWith("admin_manualhero") || command.startsWith("admin_sethero"))
		{
			if (activeChar.getTarget() == null)
			{
				activeChar.sendPacket(SystemMessageId.INCORRECT_TARGET);
				return false;
			}
			
			final L2PcInstance target = activeChar.getTarget().isPlayer() ? activeChar.getTarget().getActingPlayer() : activeChar;
			target.setHero(!target.isHero());
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
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Diet mode on");
					*/
					activeChar.sendMessage(1374);
				}
				else if (st.nextToken().equalsIgnoreCase("off"))
				{
					activeChar.setDietMode(false);
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Diet mode off");
					*/
					activeChar.sendMessage(1375);
				}
			}
			catch (Exception ex)
			{
				if (activeChar.getDietMode())
				{
					activeChar.setDietMode(false);
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Diet mode off");
					*/
					activeChar.sendMessage(1375);
				}
				else
				{
					activeChar.setDietMode(true);
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Diet mode on");
					*/
					activeChar.sendMessage(1374);
				}
			}
			finally
			{
				activeChar.refreshOverloaded();
			}
			AdminHelpPage.showHelpPage(activeChar, "gm_menu.htm");
		}
		else if (command.startsWith("admin_tradeoff"))
		{
			try
			{
				String mode = command.substring(15);
				if (mode.equalsIgnoreCase("on"))
				{
					activeChar.setTradeRefusal(true);
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Trade refusal enabled");
					*/
					activeChar.sendMessage(1376);
				}
				else if (mode.equalsIgnoreCase("off"))
				{
					activeChar.setTradeRefusal(false);
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Trade refusal disabled");
					*/
					activeChar.sendMessage(1377);
				}
			}
			catch (Exception ex)
			{
				if (activeChar.getTradeRefusal())
				{
					activeChar.setTradeRefusal(false);
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Trade refusal disabled");
					*/
					activeChar.sendMessage(1377);
				}
				else
				{
					activeChar.setTradeRefusal(true);
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Trade refusal enabled");
					*/
					activeChar.sendMessage(1376);
				}
			}
			AdminHelpPage.showHelpPage(activeChar, "gm_menu.htm");
		}
		else if (command.startsWith("admin_reload"))
		{
			StringTokenizer st = new StringTokenizer(command);
			st.nextToken();
			if (!st.hasMoreTokens())
			{
				activeChar.sendMessage("You need to specify a type to reload!");
				activeChar.sendMessage("Usage: //reload <multisell|teleport|skill|npc|htm|item|config|npcwalkers|access|quests>");
				return false;
			}
			
			final String type = st.nextToken();
			try
			{
				if (type.equals("multisell"))
				{
					MultiSell.getInstance().reload();
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("All Multisells have been reloaded");
					*/
					activeChar.sendMessage(1378);
				}
				else if (type.startsWith("teleport"))
				{
					TeleportLocationTable.getInstance().reloadAll();
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Teleport Locations have been reloaded");
					*/
					activeChar.sendMessage(1379);
				}
				else if (type.startsWith("skill"))
				{
					SkillTable.getInstance().reload();
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("All Skills have been reloaded");
					*/
					activeChar.sendMessage(1380);
				}
				else if (type.startsWith("npcId"))
				{
					Integer npcId = Integer.parseInt(st.nextToken());
					if (npcId != null)
					{
						NpcTable.getInstance().reloadNpc(npcId);
						for (L2Spawn spawn : SpawnTable.getInstance().getSpawns(npcId))
						{
							if (spawn != null)
							{
								spawn.respawnNpc(spawn.getLastSpawn());
							}
						}
						
						activeChar.sendMessage("NPC " + npcId + " have been reloaded");
					}
				}
				else if (type.equals("npc"))
				{
					NpcTable.getInstance().reloadAllNpc();
					QuestManager.getInstance().reloadAllQuests();
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("All NPCs have been reloaded");
					*/
					activeChar.sendMessage(1381);
				}
				else if (type.startsWith("htm"))
				{
					HtmCache.getInstance().reload();
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Cache[HTML]: " + HtmCache.getInstance().getMemoryUsage() + " megabytes on " + HtmCache.getInstance().getLoadedFiles() + " files loaded");
					*/
					activeChar.sendMessage(MessageTable.Messages[1382].getExtra(1) + HtmCache.getInstance().getMemoryUsage() + MessageTable.Messages[1382].getExtra(2) + HtmCache.getInstance().getLoadedFiles() + MessageTable.Messages[1382].getExtra(3));
				}
				else if (type.startsWith("item"))
				{
					ItemTable.getInstance().reload();
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Item Templates have been reloaded");
					*/
					activeChar.sendMessage(1383);
				}
				else if (type.startsWith("config"))
				{
					Config.load();
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("All Config Settings have been reloaded");
					*/
					activeChar.sendMessage(1384);
				}
				else if (type.startsWith("npcwalkers"))
				{
					NpcWalkerRoutesData.getInstance().load();
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("NPC Walker Routes have been reloaded");
					*/
					activeChar.sendMessage(1386);
				}
				else if (type.startsWith("access"))
				{
					AdminTable.getInstance().load();
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Access Rights have been reloaded");
					*/
					activeChar.sendMessage(1387);
				}
				else if (type.startsWith("quests"))
				{
					QuestManager.getInstance().reloadAllQuests();
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("All Quests have been reloaded.");
					*/
					activeChar.sendMessage(1388);
				}
				else if (type.startsWith("door"))
				{
					DoorTable.getInstance().load();
					activeChar.sendMessage("All Doors have been reloaded");
				}
				/* Move To MessageTable For L2JTW
				activeChar.sendMessage("WARNING: There are several known issues regarding this feature. Reloading server data during runtime is STRONGLY NOT RECOMMENDED for live servers, just for developing environments.");
				*/
				activeChar.sendMessage(1389);
			}
			catch (Exception e)
			{
				activeChar.sendMessage("An error occured while reloading " + type + " !");
				activeChar.sendMessage("Usage: //reload <multisell|teleport|skill|npc|htm|item|config|npcwalkers|access|quests>");
				_log.log(Level.WARNING, "An error occured while reloading " + type + ": " + e, e);
			}
		}
		else if (command.startsWith("admin_setconfig"))
		{
			StringTokenizer st = new StringTokenizer(command);
			st.nextToken();
			try
			{
				String pName = st.nextToken();
				String pValue = st.nextToken();
				if (Config.setParameterValue(pName, pValue))
				{
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Config parameter " + pName + " set to " + pValue);
					*/
					activeChar.sendMessage(MessageTable.Messages[1390].getExtra(1) + pName + MessageTable.Messages[1390].getExtra(2) + pValue);
				}
				else
				{
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Invalid parameter!");
					*/
					activeChar.sendMessage(1391);
				}
			}
			catch (Exception e)
			{
				activeChar.sendMessage("Usage: //setconfig <parameter> <value>");
			}
			finally
			{
				showConfigPage(activeChar);
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
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("parameter " + pName + " succesfully set to " + pValue);
					*/
					activeChar.sendMessage(MessageTable.Messages[1392].getExtra(1) + pName + MessageTable.Messages[1392].getExtra(2) + pValue);
				}
				else
				{
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Invalid parameter!");
					*/
					activeChar.sendMessage(1391);
				}
			}
			catch (Exception e)
			{
				if (cmd.length == 2)
				{
					activeChar.sendMessage("Usage: //set parameter=value");
				}
			}
			finally
			{
				if (cmd.length == 3)
				{
					if (cmd[2].equalsIgnoreCase("mod"))
					{
						AdminHelpPage.showHelpPage(activeChar, "mods_menu.htm");
					}
				}
			}
		}
		else if (command.startsWith("admin_gmon"))
		{
			// nothing
		}
		return true;
	}
	
	@Override
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
			case 6:
				filename = "char";
				break;
			case 7:
				filename = "gm";
				break;
			case 8:
				filename = "old";
				break;
			default:
				if (Config.GM_ADMIN_MENU_STYLE.equals("modern"))
				{
					filename = "main";
				}
				else
				{
					filename = "classic";
				}
				break;
		}
		AdminHelpPage.showHelpPage(activeChar, filename + "_menu.htm");
	}
	
	public void showConfigPage(L2PcInstance activeChar)
	{
		NpcHtmlMessage adminReply = new NpcHtmlMessage(5);
		TextBuilder replyMSG = new TextBuilder("<html><title>L2JTW :: Config</title><body>"); // Update L2JTW
		/* Move To MessageTable For L2JTW
		replyMSG.append("<center><table width=270><tr><td width=60><button value=\"Main\" action=\"bypass -h admin_admin\" width=60 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td><td width=150>Config Server Panel</td><td width=60><button value=\"Back\" action=\"bypass -h admin_admin4\" width=60 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr></table></center><br>");
		*/
		replyMSG.append("<center><table width=270><tr><td width=60><button value=\""+ MessageTable.Messages[1393].getMessage() +"\" action=\"bypass -h admin_admin\" width=60 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td><td width=150>"+MessageTable.Messages[1394].getMessage()+"</td><td width=60><button value=\""+MessageTable.Messages[1395].getMessage()+"\" action=\"bypass -h admin_admin4\" width=60 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr></table></center><br>");
		replyMSG.append("<center><table width=260><tr><td width=140></td><td width=40></td><td width=40></td></tr>");
		/* Move To MessageTable For L2JTW
		replyMSG.append("<tr><td><font color=\"00AA00\">Drop:</font></td><td></td><td></td></tr>");
		*/
		replyMSG.append("<tr><td><font color=\"00AA00\">"+ MessageTable.Messages[1396].getMessage() +"</font></td><td></td><td></td></tr>");
		/* Move To MessageTable For L2JTW
		replyMSG.append("<tr><td><font color=\"LEVEL\">Rate EXP</font> = " + Config.RATE_XP + "</td><td><edit var=\"param1\" width=40 height=15></td><td><button value=\"Set\" action=\"bypass -h admin_setconfig RateXp $param1\" width=40 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>");
		*/
		replyMSG.append("<tr><td><font color=\"LEVEL\">"+ MessageTable.Messages[1397].getMessage() +"</font> = " + Config.RATE_XP + "</td><td><edit var=\"param1\" width=40 height=15></td><td><button value=\""+ MessageTable.Messages[1398].getMessage() +"\" action=\"bypass -h admin_setconfig RateXp $param1\" width=40 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>");
		/* Move To MessageTable For L2JTW
		replyMSG.append("<tr><td><font color=\"LEVEL\">Rate SP</font> = " + Config.RATE_SP + "</td><td><edit var=\"param2\" width=40 height=15></td><td><button value=\"Set\" action=\"bypass -h admin_setconfig RateSp $param2\" width=40 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>");
		*/
		replyMSG.append("<tr><td><font color=\"LEVEL\">"+ MessageTable.Messages[1399].getMessage() +"</font> = " + Config.RATE_SP + "</td><td><edit var=\"param2\" width=40 height=15></td><td><button value=\""+ MessageTable.Messages[1398].getMessage() +"\" action=\"bypass -h admin_setconfig RateSp $param2\" width=40 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>");
		/* Move To MessageTable For L2JTW
		replyMSG.append("<tr><td><font color=\"LEVEL\">Rate Drop Spoil</font> = " + Config.RATE_DROP_SPOIL + "</td><td><edit var=\"param4\" width=40 height=15></td><td><button value=\"Set\" action=\"bypass -h admin_setconfig RateDropSpoil $param4\" width=40 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>");
		*/
		replyMSG.append("<tr><td><font color=\"LEVEL\">"+ MessageTable.Messages[1400].getMessage() +"</font> = " + Config.RATE_DROP_SPOIL + "</td><td><edit var=\"param4\" width=40 height=15></td><td><button value=\""+ MessageTable.Messages[1398].getMessage() +"\" action=\"bypass -h admin_setconfig RateDropSpoil $param4\" width=40 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>");
		/* Move To MessageTable For L2JTW
		*/
		replyMSG.append("<tr><td width=140></td><td width=40></td><td width=40></td></tr>");
		/* Move To MessageTable For L2JTW
		replyMSG.append("<tr><td><font color=\"00AA00\">Enchant:</font></td><td></td><td></td></tr>");
		*/
		replyMSG.append("<tr><td><font color=\"00AA00\">"+ MessageTable.Messages[1401].getMessage() +"</font></td><td></td><td></td></tr>");
		/* Move To MessageTable For L2JTW
		replyMSG.append("<tr><td><font color=\"LEVEL\">Enchant Element Stone</font> = " + Config.ENCHANT_CHANCE_ELEMENT_STONE + "</td><td><edit var=\"param8\" width=40 height=15></td><td><button value=\"Set\" action=\"bypass -h admin_setconfig EnchantChanceElementStone $param8\" width=40 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>");
		*/
		replyMSG.append("<tr><td><font color=\"LEVEL\">"+ MessageTable.Messages[1402].getMessage() +"</font> = " + Config.ENCHANT_CHANCE_ELEMENT_STONE + "</td><td><edit var=\"param8\" width=40 height=15></td><td><button value=\""+ MessageTable.Messages[1398].getMessage() +"\" action=\"bypass -h admin_setconfig EnchantChanceElementStone $param8\" width=40 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>");
		/* Move To MessageTable For L2JTW
		replyMSG.append("<tr><td><font color=\"LEVEL\">Enchant Element Crystal</font> = " + Config.ENCHANT_CHANCE_ELEMENT_CRYSTAL + "</td><td><edit var=\"param9\" width=40 height=15></td><td><button value=\"Set\" action=\"bypass -h admin_setconfig EnchantChanceElementCrystal $param9\" width=40 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>");
		*/
		replyMSG.append("<tr><td><font color=\"LEVEL\">Enchant Element Crystal</font> = " + Config.ENCHANT_CHANCE_ELEMENT_CRYSTAL + "</td><td><edit var=\"param9\" width=40 height=15></td><td><button value=\""+ MessageTable.Messages[1398].getMessage() +"\" action=\"bypass -h admin_setconfig EnchantChanceElementCrystal $param9\" width=40 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>");
		/* Move To MessageTable For L2JTW
		replyMSG.append("<tr><td><font color=\"LEVEL\">Enchant Element Jewel</font> = " + Config.ENCHANT_CHANCE_ELEMENT_JEWEL + "</td><td><edit var=\"param10\" width=40 height=15></td><td><button value=\"Set\" action=\"bypass -h admin_setconfig EnchantChanceElementJewel $param10\" width=40 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>");
		*/
		replyMSG.append("<tr><td><font color=\"LEVEL\">Enchant Element Jewel</font> = " + Config.ENCHANT_CHANCE_ELEMENT_JEWEL + "</td><td><edit var=\"param10\" width=40 height=15></td><td><button value=\""+ MessageTable.Messages[1398].getMessage() +"\" action=\"bypass -h admin_setconfig EnchantChanceElementJewel $param10\" width=40 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>");
		/* Move To MessageTable For L2JTW
		replyMSG.append("<tr><td><font color=\"LEVEL\">Enchant Element Energy</font> = " + Config.ENCHANT_CHANCE_ELEMENT_ENERGY + "</td><td><edit var=\"param11\" width=40 height=15></td><td><button value=\"Set\" action=\"bypass -h admin_setconfig EnchantChanceElementEnergy $param11\" width=40 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>");
		*/
		replyMSG.append("<tr><td><font color=\"LEVEL\">Enchant Element Energy</font> = " + Config.ENCHANT_CHANCE_ELEMENT_ENERGY + "</td><td><edit var=\"param11\" width=40 height=15></td><td><button value=\""+ MessageTable.Messages[1398].getMessage() +"\" action=\"bypass -h admin_setconfig EnchantChanceElementEnergy $param11\" width=40 height=25 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>");
		
		replyMSG.append("</table></body></html>");
		adminReply.setHtml(replyMSG.toString());
		activeChar.sendPacket(adminReply);
	}
}
