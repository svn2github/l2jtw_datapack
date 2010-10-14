/**
 * 
 */
package handlers.admincommandhandlers;

import com.l2jserver.gameserver.datatables.ClanTable;
import com.l2jserver.gameserver.handler.IAdminCommandHandler;
import com.l2jserver.gameserver.instancemanager.CHSiegeManager;
import com.l2jserver.gameserver.model.L2Clan;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;

import conquerablehalls.DevastatedCastle.DevastatedCastle;
import conquerablehalls.FortressOfResistance.FortressOfResistance;
import conquerablehalls.FortressOfTheDead.FortressOfTheDead;
import conquerablehalls.RainbowSpringsChateau.RainbowSpringsChateau;

/**
 * @author BiggBoss
 *
 */
public class AdminCHSiege implements IAdminCommandHandler
{
	private static final String[] COMMANDS =
	{
		"admin_chsiege_startSiege",			/* 	//chsiege_startSiege <chId> 					*/
		"admin_chsiege_endsSiege",			/* 	//chsiege_endsSiege <chId> 						*/
		"admin_chsiege_setSiegeDate",		/* 	//chsiege_setSiegeDate <chId> <unixTimeMillis> 	*/
		"admin_chsiege_addAttacker"			/*  //chsiege_addAttacker <chId> <clanId>			*/
	};
	
	/* (non-Javadoc)
	 * @see com.l2jserver.gameserver.handler.IAdminCommandHandler#getAdminCommandList()
	 */
	@Override
	public String[] getAdminCommandList()
	{
		return COMMANDS;
	}
	
	/* (non-Javadoc)
	 * @see com.l2jserver.gameserver.handler.IAdminCommandHandler#useAdminCommand(java.lang.String, com.l2jserver.gameserver.model.actor.instance.L2PcInstance)
	 */
	@Override
	public boolean useAdminCommand(String command, L2PcInstance activeChar)
	{
		final String[] split = command.split(" ");
		
		if(command.startsWith("admin_chsiege_startSiege"))
		{
			if(split.length < 2)
				activeChar.sendMessage("Usage: //chsiege_startSiege <clanhallId>");
			else
			{
				int ch = parseInt(split[1]);
				if(!CHSiegeManager.getInstance().isAttackableHall(ch))
				{
					activeChar.sendMessage("The requested clan hall isnt attackable!");
					return false;
				}
				else if(CHSiegeManager.getInstance().isHallInSiege(ch))
				{
					activeChar.sendMessage("The requested clan hall is alredy in siege!");
					return false;
				}
				else
				{
					switch(ch)
					{
						case 21: // Fortress of Resistance
							FortressOfResistance.launchSiege();
							break;
						case 34: // Devastated castle
							DevastatedCastle.launchSiege();
							break;
						case 64: // Fortress of the dead
							FortressOfTheDead.launchSiege();
							break;
						case 62: // Rainbow Springs Chateau
							RainbowSpringsChateau.launchSiege();
							break;
					}
				}
			}
		}
		else if(command.startsWith("admin_chsiege_endsSiege"))
		{
			if(split.length < 2)
				activeChar.sendMessage("Usage: //chsiege_endsSiege <clanhallId>");
			else
			{
				int ch = parseInt(split[1]);
				if(!CHSiegeManager.getInstance().isAttackableHall(ch))
				{
					activeChar.sendMessage("The requested clan hall isnt attackable!");
					return false;
				}
				else if(!CHSiegeManager.getInstance().isHallInSiege(ch))
				{
					activeChar.sendMessage("The requested clan hall isnt in siege!");
					return false;
				}
				else
				{
					switch(ch)
					{
						case 21: // Fortress of Resistance
							FortressOfResistance.endSiege();
							break;
						case 34: // Devastated castle
							DevastatedCastle.endSiege();
							break;
						case 64: // Fortress of the dead
							FortressOfTheDead.endSiege();
							break;
						case 62: // Rainbow Springs Chateau
							RainbowSpringsChateau.endSiege();
							break;
					}
				}
			}
		}
		else if(command.startsWith("admin_chsiege_setSiegeDate"))
		{
			if(split.length < 3)
				activeChar.sendMessage("Usage: //chsiege_setSiegeDate <clanhallId> <unixTimeInMillis>");
			else
			{
				int ch = parseInt(split[1]);
				if(!CHSiegeManager.getInstance().isAttackableHall(ch))
				{
					activeChar.sendMessage("The requested clan hall isnt attackable!");
					return false;
				}
				if(CHSiegeManager.getInstance().isHallInSiege(ch))
				{
					activeChar.sendMessage("The requested clan hall is in siege right now!");
					return false;
				}
				
				long date = Long.parseLong(split[2]);
				
				if(date == 0)
				{
					activeChar.sendMessage("Wrong date format, unparseable!");
					return false;
				}
				switch(ch)
				{
					case 21: // Fortress of Resistance
						FortressOfResistance.updateAdminDate(date);
						break;
					case 34: // Devastated castle
					DevastatedCastle.updateAdminDate(date);
						break;
					case 64: // Fortress of the dead
						FortressOfTheDead.updateAdminDate(date);
						break;
					case 62: // Rainbow Springs Chateau
						RainbowSpringsChateau.updateAdminDate(date);
						break;
				}
			}
		}
		else if(command.startsWith("admin_chsiege_addAttacker"))
		{
			if(split.length < 2)
			{
				activeChar.sendMessage("Usage: //chsiege_addAttacker <chId> <clanId>");
				return false;
			}
			
			int ch = parseInt(split[1]);
			if(ch == 0)
			{
				activeChar.sendMessage("Wrong clan hall id, unparseable id!");
				return false;
			}
			if(CHSiegeManager.getInstance().isHallInSiege(ch))
			{
				activeChar.sendMessage("The clan hall is in siege, cannot add attackers now.");
				return false;
			}
			int clanId = parseInt(split[2]);
			L2Clan clan = ClanTable.getInstance().getClan(clanId);
			if(clanId == 0 || clan == null)
			{
				activeChar.sendMessage("The passed clan does not exist!");
				return false;
			}
			CHSiegeManager.getInstance().addSiegeAttacker(ch, clan);
		}
		return false;
	}
	
	private int parseInt(String st)
	{
		int val = 0;
		try
		{
			val = Integer.parseInt(st);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return val;
	}
}
