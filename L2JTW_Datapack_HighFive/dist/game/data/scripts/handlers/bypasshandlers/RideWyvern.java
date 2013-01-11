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
package handlers.bypasshandlers;

import com.l2jserver.Config;
import com.l2jserver.gameserver.SevenSigns;
import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.handler.IBypassHandler;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.actor.instance.L2WyvernManagerInstance;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.util.Util;

public class RideWyvern implements IBypassHandler
{
	private static final String[] COMMANDS =
	{
		"RideWyvern"
	};
	
	private static final int[] STRIDERS =
	{
		12526,
		12527,
		12528,
		16038,
		16039,
		16040,
		16068,
		13197
	};
	
	@Override
	public boolean useBypass(String command, L2PcInstance activeChar, L2Character target)
	{
		if (!(target instanceof L2WyvernManagerInstance))
		{
			return false;
		}
		
		L2WyvernManagerInstance npc = (L2WyvernManagerInstance) target;
		if (!npc.isOwnerClan(activeChar))
		{
			return false;
		}
		
		if (!Config.ALLOW_WYVERN_DURING_SIEGE && (npc.isInSiege() || activeChar.isInSiege()))
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You cannot ride wyvern during siege.");
			*/
			activeChar.sendMessage(1050);
			return false;
		}
		
		if ((SevenSigns.getInstance().getSealOwner(SevenSigns.SEAL_STRIFE) == SevenSigns.CABAL_DUSK) && SevenSigns.getInstance().isSealValidationPeriod())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You cannot ride wyvern while Seal of Strife controlled by Dusk.");
			*/
			activeChar.sendMessage(1051);
			return false;
		}
		
		if (!activeChar.hasSummon())
		{
			if (activeChar.isMounted())
			{
				activeChar.sendPacket(SystemMessageId.YOU_ALREADY_HAVE_A_PET);
			}
			else
			{
				/* Move To MessageTable For L2JTW
				activeChar.sendMessage("Summon your Strider first.");
				*/
				activeChar.sendMessage(1053);
			}
		}
		else if (Util.contains(STRIDERS, activeChar.getSummon().getNpcId()))
		{
			if ((activeChar.getInventory().getItemByItemId(1460) != null) && (activeChar.getInventory().getItemByItemId(1460).getCount() >= 25))
			{
				if (activeChar.getSummon().getLevel() < 55)
				{
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Your Strider Has not reached the required level.");
					*/
					activeChar.sendMessage(1054);
				}
				else
				{
					activeChar.getSummon().unSummon(activeChar);
					if (activeChar.mount(12621, 0, true))
					{
						activeChar.getInventory().destroyItemByItemId("Wyvern", 1460, 25, activeChar, npc);
						activeChar.addSkill(SkillTable.FrequentSkill.WYVERN_BREATH.getSkill());
						/* Move To MessageTable For L2JTW
						activeChar.sendMessage("The Wyvern has been summoned successfully!");
						*/
						activeChar.sendMessage(1055);
					}
					return true;
				}
			}
			else
			{
				/* Move To MessageTable For L2JTW
				activeChar.sendMessage("You need 25 Crystals: B Grade.");
				*/
				activeChar.sendMessage(1056);
			}
		}
		else
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Unsummon your pet.");
			*/
			activeChar.sendMessage(1057);
		}
		
		return false;
	}
	
	@Override
	public String[] getBypassList()
	{
		return COMMANDS;
	}
}
