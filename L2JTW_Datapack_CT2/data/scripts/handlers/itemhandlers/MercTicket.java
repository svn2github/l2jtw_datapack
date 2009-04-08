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
package handlers.itemhandlers;

import net.sf.l2j.gameserver.SevenSigns;
import net.sf.l2j.gameserver.handler.IItemHandler;
import net.sf.l2j.gameserver.instancemanager.CastleManager;
import net.sf.l2j.gameserver.instancemanager.MercTicketManager;
import net.sf.l2j.gameserver.model.L2ItemInstance;
import net.sf.l2j.gameserver.model.actor.L2Playable;
import net.sf.l2j.gameserver.model.actor.instance.L2PcInstance;
import net.sf.l2j.gameserver.model.entity.Castle;
import net.sf.l2j.gameserver.network.SystemMessageId;
import net.sf.l2j.gameserver.network.serverpackets.SystemMessage;
import net.sf.l2j.gameserver.datatables.MessageTable;
import net.sf.l2j.gameserver.model.L2CoreMessage;

public class MercTicket implements IItemHandler
{
	private static final String[] MESSAGES =
	{
		MessageTable.Messages[1206].getMessage(),
		MessageTable.Messages[1207].getMessage(),
		MessageTable.Messages[1208].getMessage()
	};
	
	/**
	 * handler for using mercenary tickets.  Things to do:
	 * 1) Check constraints:
	 * 1.a) Tickets may only be used in a castle
	 * 1.b) Only specific tickets may be used in each castle (different tickets for each castle)
	 * 1.c) only the owner of that castle may use them
	 * 1.d) tickets cannot be used during siege
	 * 1.e) Check if max number of tickets has been reached
	 * 1.f) Check if max number of tickets from this ticket's TYPE has been reached
	 * 2) If allowed, call the MercTicketManager to add the item and spawn in the world
	 * 3) Remove the item from the person's inventory
	 */
	public void useItem(L2Playable playable, L2ItemInstance item)
	{
		int itemId = item.getItemId();
		L2PcInstance activeChar = (L2PcInstance) playable;
		Castle castle = CastleManager.getInstance().getCastle(activeChar);
		int castleId = -1;
		if (castle != null)
			castleId = castle.getCastleId();

		//add check that certain tickets can only be placed in certain castles
		if (MercTicketManager.getInstance().getTicketCastleId(itemId) != castleId)
		{
			if (castleId == -1)
			{
				// player is not in a castle
				activeChar.sendMessage(195);
				return;  			
			}

			switch (MercTicketManager.getInstance().getTicketCastleId(itemId))
			{
				case 1:
					activeChar.sendMessage(328);
		     		return;
				case 2:
					activeChar.sendMessage(326);
					return;
				case 3:
					activeChar.sendMessage(327);
					return;
				case 4:
					activeChar.sendMessage(331);
					return;
				case 5:
					activeChar.sendMessage(325);
					return;
				case 6:
					activeChar.sendMessage(330);
					return;
				case 7:
					activeChar.sendMessage(329);
					return;
				case 8:
					activeChar.sendMessage(332);
					return;
				case 9:
					activeChar.sendMessage(333);
					return;
			}
		}
		
		if (!activeChar.isCastleLord(castleId))
		{
			activeChar.sendPacket(new SystemMessage(SystemMessageId.YOU_DO_NOT_HAVE_AUTHORITY_TO_POSITION_MERCENARIES));
			return;
		}
		
		if (castle.getSiege().getIsInProgress())
		{
			activeChar.sendPacket(new SystemMessage(SystemMessageId.CANNOT_POSITION_MERCS_DURING_SIEGE));
			return;
         }
 
        //Checking Seven Signs Quest Period
        if (SevenSigns.getInstance().getCurrentPeriod() != SevenSigns.PERIOD_SEAL_VALIDATION) 
        {
        	//_log.warning("Someone has tried to spawn a guardian during Quest Event Period of The Seven Signs.");       	
        	activeChar.sendPacket(new SystemMessage(SystemMessageId.MERC_CAN_BE_ASSIGNED));
        	return;
        }
        //Checking the Seal of Strife status
        switch (SevenSigns.getInstance().getSealOwner(SevenSigns.SEAL_STRIFE))
        {
        	case SevenSigns.CABAL_NULL:
        		if (SevenSigns.getInstance().CheckIsDawnPostingTicket(itemId))
        		{
                	//_log.warning("Someone has tried to spawn a Dawn Mercenary though the Seal of Strife is not controlled by anyone.");       	
                	activeChar.sendMessage(1164);        		
        			return;
        		}        			
        		break;
        	case SevenSigns.CABAL_DUSK:
        		if (!SevenSigns.getInstance().CheckIsRookiePostingTicket(itemId))
        		{
                	//_log.warning("Someone has tried to spawn a non-Rookie Mercenary though the Seal of Strife is controlled by Revolutionaries of Dusk.");       	
                	activeChar.sendPacket(new SystemMessage(SystemMessageId.MERC_CANT_BE_ASSIGNED_USING_STRIFE));        		
        			return;
        		}          		
        		break;
        	case SevenSigns.CABAL_DAWN:        	
        		break;
        }                
        
        if(MercTicketManager.getInstance().isAtCasleLimit(item.getItemId()))
        {
        	activeChar.sendMessage(485);
			return;
		}
		
		if (MercTicketManager.getInstance().isAtTypeLimit(item.getItemId()))
		{
			activeChar.sendPacket(new SystemMessage(SystemMessageId.THIS_MERCENARY_CANNOT_BE_POSITIONED_ANYMORE));
			return;
		}
		if (MercTicketManager.getInstance().isTooCloseToAnotherTicket(activeChar.getX(), activeChar.getY(), activeChar.getZ()))
		{
			activeChar.sendPacket(new SystemMessage(SystemMessageId.POSITIONING_CANNOT_BE_DONE_BECAUSE_DISTANCE_BETWEEN_MERCENARIES_TOO_SHORT));
			return;
		}
		
		int npcId = MercTicketManager.getInstance().addTicket(item.getItemId(), activeChar, MESSAGES);
		activeChar.destroyItem("Consume", item.getObjectId(), 1, null, false); // Remove item from char's inventory
		L2CoreMessage cm =  new L2CoreMessage (MessageTable.Messages[145]);
		cm.addNumber(itemId);
		cm.addNumber(npcId);
		cm.addNumber(activeChar.getX());
		cm.addNumber(activeChar.getY());
		cm.addNumber(activeChar.getZ());
		cm.addNumber(activeChar.getHeading());
		activeChar.sendMessage(cm.renderMsg());
	}
	
	/**
	 * 
	 * @see net.sf.l2j.gameserver.handler.IItemHandler#getItemIds()
	 */
	public int[] getItemIds()
	{
		return MercTicketManager.getInstance().getItemIds();
	}
}
