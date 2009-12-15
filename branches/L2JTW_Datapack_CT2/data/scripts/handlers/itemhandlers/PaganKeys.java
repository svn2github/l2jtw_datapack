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

import net.sf.l2j.gameserver.datatables.DoorTable;
import net.sf.l2j.gameserver.handler.IItemHandler;
import net.sf.l2j.gameserver.model.L2ItemInstance;
import net.sf.l2j.gameserver.model.L2Object;
import net.sf.l2j.gameserver.model.actor.L2Playable;
import net.sf.l2j.gameserver.model.actor.instance.L2DoorInstance;
import net.sf.l2j.gameserver.model.actor.instance.L2PcInstance;
import net.sf.l2j.gameserver.network.SystemMessageId;
import net.sf.l2j.gameserver.network.serverpackets.ActionFailed;
import net.sf.l2j.gameserver.network.serverpackets.PlaySound;
import net.sf.l2j.gameserver.network.serverpackets.SocialAction;
import net.sf.l2j.gameserver.network.serverpackets.SystemMessage;
import net.sf.l2j.util.Rnd;

/**
 * @author  chris
 */
public class PaganKeys implements IItemHandler
{
	public static final int INTERACTION_DISTANCE = 100;
	
	/**
	 * 
	 * @see net.sf.l2j.gameserver.handler.IItemHandler#useItem(net.sf.l2j.gameserver.model.actor.L2Playable, net.sf.l2j.gameserver.model.L2ItemInstance)
	 */
	public void useItem(L2Playable playable, L2ItemInstance item)
	{
		int itemId = item.getItemId();
		if (!(playable instanceof L2PcInstance))
			return;
		L2PcInstance activeChar = (L2PcInstance) playable;
		L2Object target = activeChar.getTarget();
		
		if (!(target instanceof L2DoorInstance))
		{
			activeChar.sendPacket(new SystemMessage(SystemMessageId.INCORRECT_TARGET));
			activeChar.sendPacket(ActionFailed.STATIC_PACKET);
			return;
		}
		L2DoorInstance door = (L2DoorInstance) target;
		
		if (!(activeChar.isInsideRadius(door, INTERACTION_DISTANCE, false, false)))
		{
			activeChar.sendPacket(new SystemMessage(SystemMessageId.TARGET_TOO_FAR));
			activeChar.sendPacket(ActionFailed.STATIC_PACKET);
			return;
		}
		if (activeChar.getAbnormalEffect() > 0 || activeChar.isInCombat())
		{
			activeChar.sendMessage(500);
			activeChar.sendPacket(ActionFailed.STATIC_PACKET);
			return;
		}
		
		int openChance = 35;
		
		if (!playable.destroyItem("Consume", item.getObjectId(), 1, null, false))
			return;
		
		switch (itemId)
		{
			case 9698:
				if (door.getDoorId() == 24220020)
				{
					door.openMe(); //Update by rocknow
				}
				else
				{
					activeChar.sendMessage(148);
				}
				break;
			case 9699:
				if (door.getDoorId() == 24220022)
				{
					door.openMe(); //Update by rocknow
				}
				else
				{
					activeChar.sendMessage(148);
				}
				break;
			case 8056:
				if (door.getDoorId() == 23150004||door.getDoorId() == 23150003)
				{
					DoorTable.getInstance().getDoor(23150003).openMe();
					DoorTable.getInstance().getDoor(23150003).onOpen();
					DoorTable.getInstance().getDoor(23150004).openMe();
					DoorTable.getInstance().getDoor(23150004).onOpen();
				}
				else
				{
					activeChar.sendMessage(148);
				}
				break;
			case 8273: //AnteroomKey
				if (door.getDoorName().startsWith("Anteroom"))
				{
					if (Rnd.get(100) < openChance)
					{
						door.openMe();
						door.onOpen(); // Closes the door after 60sec
						activeChar.broadcastPacket(new SocialAction(activeChar.getObjectId(), 3));
					}
					else
					{
						//test with: activeChar.sendPacket(new SystemMessage(SystemMessage.FAILED_TO_UNLOCK_DOOR));
						activeChar.sendMessage(520);
						activeChar.broadcastPacket(new SocialAction(activeChar.getObjectId(), 13));
						PlaySound playSound = new PlaySound("interfacesound.system_close_01");
						activeChar.sendPacket(playSound);
					}
				}
				else
				{
					activeChar.sendMessage(148);
				}
				break;
			case 8274: //Chapel key
				if (door.getDoorId() == 19160010||door.getDoorId() == 19160011)
				{
					DoorTable.getInstance().getDoor(19160010).openMe();
					DoorTable.getInstance().getDoor(19160010).onOpen();
					DoorTable.getInstance().getDoor(19160011).openMe();
					DoorTable.getInstance().getDoor(19160011).onOpen();
				}
				else
				{
					activeChar.sendMessage(148);
				}
				break;
			case 8275: //Key of Darkness
				if (door.getDoorName().startsWith("Door_of_Darkness"))
				{
					if (Rnd.get(100) < openChance)
					{
						door.openMe();
						door.onOpen();
						activeChar.broadcastPacket(new SocialAction(activeChar.getObjectId(), 3));
					}
					else
					{
						activeChar.sendMessage(521);
						activeChar.broadcastPacket(new SocialAction(activeChar.getObjectId(), 13));
						PlaySound playSound = new PlaySound("interfacesound.system_close_01");
						activeChar.sendPacket(playSound);
					}
				}
				else
				{
					activeChar.sendMessage(148);
				}
				break;
			case 9694: //Update by rocknow
				if (door.getDoorId() == 24220001 || door.getDoorId() == 24220002 || door.getDoorId() == 24220003 || door.getDoorId() == 24220004 || door.getDoorId() == 24220007)
				{
					door.openMe();
				}
				else
				{
					activeChar.sendMessage(148);
				}
				break;
			case 10015: //Update by rocknow
				if (door.getDoorId() == 24220008 || door.getDoorId() == 2422009 || door.getDoorId() == 24220010 || door.getDoorId() == 24220011 || door.getDoorId() == 24220012 || door.getDoorId() == 24220014 || door.getDoorId() == 24220015 || door.getDoorId() == 24220016 || door.getDoorId() == 24220017 || door.getDoorId() == 24220019)
				{
					door.openMe();
				}
				else
				{
					activeChar.sendMessage(148);
				}
				break;
		}
	}
}
