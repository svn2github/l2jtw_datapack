package handlers.admincommandhandlers;

import java.util.StringTokenizer;

import com.l2jserver.gameserver.handler.IAdminCommandHandler;
import com.l2jserver.gameserver.model.L2Effect;
import com.l2jserver.gameserver.model.L2World;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.NpcHtmlMessage;
import com.l2jserver.gameserver.util.GMAudit;
import com.l2jserver.util.StringUtil;
import com.l2jserver.gameserver.datatables.MessageTable;
import com.l2jserver.gameserver.model.L2CoreMessage;


public class AdminBuffs implements IAdminCommandHandler
{
	private final static int PAGE_LIMIT = 20;
	
	private static final String[] ADMIN_COMMANDS =
	{
		"admin_getbuffs",
		"admin_stopbuff",
		"admin_stopallbuffs",
		"admin_areacancel"
	};
	
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		
		if (command.startsWith("admin_getbuffs"))
		{
			StringTokenizer st = new StringTokenizer(command, " ");
			command = st.nextToken();
			
			if (st.hasMoreTokens())
			{
				L2PcInstance player = null;
				String playername = st.nextToken();
				
				try
				{
					player = L2World.getInstance().getPlayer(playername);
				}
				catch (Exception e)
				{
				}
				
				if (player != null)
				{
					int page = 1;
					if (st.hasMoreTokens())
						page = Integer.parseInt(st.nextToken());
					showBuffs(activeChar, player, page);
					return true;
				}
				else
				{
					L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[138]);
					cm.addString(playername);
					cm.sendMessage(activeChar);
					return false;
				}
			}
			else if ((activeChar.getTarget() != null) && (activeChar.getTarget() instanceof L2Character))
			{
				showBuffs(activeChar, (L2Character) activeChar.getTarget(), 1);
				return true;
			}
			else
			{
				activeChar.sendPacket(SystemMessageId.TARGET_IS_INCORRECT);
				return true;
			}
		}
		
		else if (command.startsWith("admin_stopbuff"))
		{
			try
			{
				StringTokenizer st = new StringTokenizer(command, " ");
				
				st.nextToken();
				int objectId = Integer.parseInt(st.nextToken());
				int skillId = Integer.parseInt(st.nextToken());
				
				removeBuff(activeChar, objectId, skillId);
				return true;
			}
			catch (Exception e)
			{
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[156]);
				cm.addString(e.getMessage());
				cm.sendMessage(activeChar);
				activeChar.sendMessage(157);
				return false;
			}
		}
		else if (command.startsWith("admin_stopallbuffs"))
		{
			try
			{
				StringTokenizer st = new StringTokenizer(command, " ");
				st.nextToken();
				int objectId = Integer.parseInt(st.nextToken());
				removeAllBuffs(activeChar, objectId);
				return true;
			}
			catch (Exception e) {
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[863]);
				cm.addString(e.getMessage());
				cm.sendMessage(activeChar);
				activeChar.sendMessage(855);
				return false;
			}
		}
		else if (command.startsWith("admin_areacancel"))
		{
			StringTokenizer st = new StringTokenizer(command, " ");
			st.nextToken();
			String val = st.nextToken();
			try
			{
				int radius = Integer.parseInt(val);
				
				for (L2Character knownChar : activeChar.getKnownList().getKnownCharactersInRadius(radius))
				{
					if ((knownChar instanceof L2PcInstance) && !(knownChar.equals(activeChar)))
						knownChar.stopAllEffects();
				}
				
				L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[159]);
				cm.addNumber(radius);
				cm.sendMessage(activeChar);
				return true;
			}
			catch (NumberFormatException e)
			{
				activeChar.sendMessage(176);
				return false;
			}
		}
		else
			return true;
		
	}
	
	public String[] getAdminCommandList()
	{
		return ADMIN_COMMANDS;
	}
	
	public void showBuffs(L2PcInstance activeChar, L2Character target, int page)
	{
		final L2Effect[] effects = target.getAllEffects();
		
		if (page > effects.length / PAGE_LIMIT + 1 || page < 1)
			return;
		
		int max = effects.length / PAGE_LIMIT;
		if (effects.length > PAGE_LIMIT * max)
			max++;
		
		final StringBuilder html = StringUtil.startAppend(500 + effects.length * 200, 
				"<html><table width=\"100%\"><tr><td width=45><button value=\""+MessageTable.Messages[592].getMessage()+"\" action=\"bypass -h admin_admin\" width=45 height=21 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td><td width=180><center><font color=\"LEVEL\">"+MessageTable.Messages[207].getMessage()+ target.getName(),
				"</font></td><td width=45><button value=\""+MessageTable.Messages[1077].getMessage()+"\" action=\"bypass -h admin_current_player\" width=45 height=21 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr></table><br><table width=\"100%\"><tr><td width=200>"+MessageTable.Messages[556].getMessage()+"</td><td width=30>"+MessageTable.Messages[879].getMessage()+"</td><td width=70>"+MessageTable.Messages[557].getMessage()+"</td></tr>");
		
		int start = ((page - 1) * PAGE_LIMIT);
		int end = Math.min(((page - 1) * PAGE_LIMIT) + PAGE_LIMIT, effects.length);
		
		for (int i = start; i < end; i++)
		{
			L2Effect e = effects[i];
			if (e != null)
			{
				StringUtil.append(html, 
						"<tr><td>", 
						e.getSkill().getName(), 
						"</td><td>", 
						e.getSkill().isToggle() ? "toggle" : e.getPeriod() - e.getTime() + "s",
						"</td><td><button value=\""+MessageTable.Messages[1176].getMessage()+"\" action=\"bypass -h admin_stopbuff ", 
						Integer.toString(target.getObjectId()), 
						" ", 
						String.valueOf(e.getSkill().getId()), 
						"\" width=60 height=21 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></td></tr>");
			}
		}
		
		html.append("</table><table width=300 bgcolor=444444><tr>");
		for (int x = 0; x < max; x++)
		{
			int pagenr = x + 1;
			if (page == pagenr)
			{
				html.append("<td>Page ");
				html.append(pagenr);
				html.append("</td>");
			}
			else
			{
				html.append("<td><a action=\"bypass -h admin_getbuffs ");
				html.append(target.getName());
				html.append(" ");
				html.append(x+1);
				html.append("\"> Page ");
				html.append(pagenr);
				html.append(" </a></td>");
			}
		}
		
		html.append("</tr></table>");
		
		StringUtil.append(html, "<br><center><button value=\""+MessageTable.Messages[212].getMessage()+"\" action=\"bypass -h admin_stopallbuffs ", 
				Integer.toString(target.getObjectId()),
				"\" width=80 height=21 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></html>");
		
		NpcHtmlMessage ms = new NpcHtmlMessage(1);
		ms.setHtml(html.toString());
		activeChar.sendPacket(ms);
		
		GMAudit.auditGMAction(activeChar.getName(), "getbuffs", target.getName() + " (" + Integer.toString(target.getObjectId()) + ")", "");
	}
	
	private void removeBuff(L2PcInstance activeChar, int objId, int skillId)
	{
		L2Character target = null;
		try
		{
			target = (L2Character) L2World.getInstance().findObject(objId);
		}
		catch (Exception e)
		{
		}
		
		if ((target != null) && (skillId > 0))
		{
			L2Effect[] effects = target.getAllEffects();
			
			for (L2Effect e : effects)
			{
				if ((e != null) && (e.getSkill().getId() == skillId))
				{
					e.exit();
					L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[213]);
					cm.addString(e.getSkill().getName());
					cm.addNumber(e.getSkill().getLevel());
					cm.addString(target.getName());
					cm.sendMessage(activeChar);
				}
			}
			showBuffs(activeChar, target, 1);
			GMAudit.auditGMAction(activeChar.getName(), "stopbuff", target.getName() + " (" + objId + ")", Integer.toString(skillId));
		}
	}
	
	private void removeAllBuffs(L2PcInstance activeChar, int objId)
	{
		L2Character target = null;
		try
		{
			target = (L2Character) L2World.getInstance().findObject(objId);
		}
		catch (Exception e)
		{
		}
		
		if (target != null)
		{
			target.stopAllEffects();
			L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[869]);
			cm.addString(target.getName());
			cm.addNumber(objId);
			cm.sendMessage(activeChar);
			GMAudit.auditGMAction(activeChar.getName(), "stopallbuffs", target.getName() + " (" + objId + ")", "");
			showBuffs(activeChar, target, 1);
		}
	}
	
}