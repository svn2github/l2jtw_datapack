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
import java.sql.ResultSet;

import javolution.text.TextBuilder;

import com.l2jserver.L2DatabaseFactory;
import com.l2jserver.gameserver.handler.IAdminCommandHandler;
import com.l2jserver.gameserver.model.L2World;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.network.serverpackets.ExNotifyPremiumItem;
import com.l2jserver.gameserver.network.serverpackets.NpcHtmlMessage;

/**
 * @author  KKnD
 */
public class AdminVitaminItem implements IAdminCommandHandler
{
	private static final String[] ADMIN_COMMANDS =
	{
		"admin_vitaminitem",
		"admin_sendVitem"
	};
	
	@Override
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		if (command.equals("admin_vitaminitem"))
		{
			main_txt(activeChar);
		}
		else if (command.startsWith("admin_sendVitem"))
		{
			String[] args = command.split(" ");
			int itemId = Integer.parseInt(args[1]);
			long itemcount = Long.parseLong(args[2]);
			int online = 0;
			if (args[3].equals("online"))
				online = 1;
			
			add_vit_item(itemId, itemcount, online, activeChar);
			main_txt(activeChar);
		}
		return true;
	}
	
	@Override
	public String[] getAdminCommandList()
	{
		return ADMIN_COMMANDS;
	}
	
	public void main_txt(L2PcInstance player)
	{
		NpcHtmlMessage html = new NpcHtmlMessage(5);
		TextBuilder sb = new TextBuilder();
		sb.append("<html><title>維他命管理</title><body>");
		sb.append("<table width=270>");
		sb.append("<tr><td>請輸入您想創造的物品編號、及所需數量。<font color=\"LEVEL\">注意: 請勿創造多個無法堆疊的物品</font></td></tr>");
		sb.append("<tr><td>編號:</td></tr>");
		sb.append("<tr><td><td><edit width=120 var=\"tsId\"></td></tr>");
		sb.append("<tr><td</td></tr>");
		sb.append("<tr><td>數量:</td></tr>");
		sb.append("<tr><td><td><edit width=120 var=\"tsCnt\"></td></tr>");
		sb.append("<tr><td</td></tr>");
		sb.append("<tr><td>給予:</td></tr>");
		/* l2jtw start
		 * 3q overzero
		sb.append("<tr><td><td><combobox width=120 var=tsPpl list=全部玩家;全部線上玩家></td></tr>");
		 */
		sb.append("<tr><td><td><combobox width=120 var=tsPpl list=online;全部玩家></td></tr>");
		// l2jtw end
		sb.append("</table>");
		sb.append("<table width=270>");
		sb.append("<tr>");
		sb.append("<td><button value=\"送出物品\" width=80 action=\"bypass -h admin_sendVitem $tsId $tsCnt $tsPpl\" height=21 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td>");
		sb.append("</tr>");
		sb.append("</table></body></html>");
		html.setHtml(sb.toString());
		player.sendPacket(html);
	}
	
	public void add_vit_item(int id, long count, int online, L2PcInstance player)
	{
		Connection con = null;
		try
		{
			con = L2DatabaseFactory.getInstance().getConnection();
			PreparedStatement statement;
			if (online == 1)
				statement = con.prepareStatement("SELECT charId FROM characters WHERE online = 1 AND accesslevel > -1 AND deletetime = 0");
			else
				statement = con.prepareStatement("SELECT charId FROM characters WHERE accesslevel > -1 AND deletetime = 0");
			
			PreparedStatement statement2 = con.prepareStatement("SELECT itemNum FROM character_premium_items WHERE charId=? ORDER BY itemNum DESC");
			PreparedStatement statement3 = con.prepareStatement("INSERT INTO character_premium_items (charId, itemNum, itemId, itemCount, itemSender) VALUES (?,?,?,?,?)");
			
			ResultSet set = statement.executeQuery();
			
			while (set.next())
			{
				int charid = set.getInt("charId");
				int lastnum = getlastnum(statement2, charid);
				
				statement3.setInt(1, charid);
				statement3.setInt(2, lastnum+1);
				statement3.setInt(3, id);
				statement3.setLong(4, count);
				statement3.setString(5, "Server");
				statement3.execute();
			}
			statement.close();
			statement2.close();
			statement3.close();
			set.close();
			L2PcInstance[] pls = L2World.getInstance().getAllPlayersArray();
			for (L2PcInstance pc : pls)
			{
				pc.loadPremiumItemList();
				if (!pc.getPremiumItemList().isEmpty())
					pc.sendPacket(new ExNotifyPremiumItem());
			}
			player.sendMessage("物品已給玩家");
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			L2DatabaseFactory.close(con);
		}
	}
	
	public int getlastnum(PreparedStatement statement, int charid)
	{
		int i = 0;
		
		try
		{
			statement.setInt(1, charid);
			ResultSet set = statement.executeQuery();
			if (set.next())
			{
				i = set.getInt("itemNum");
			}
			set.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return i;
	}
}
