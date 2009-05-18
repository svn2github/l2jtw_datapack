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

import net.sf.l2j.gameserver.datatables.SkillTable;
import net.sf.l2j.gameserver.handler.IItemHandler;
import net.sf.l2j.gameserver.model.L2ItemInstance;
import net.sf.l2j.gameserver.model.L2Skill;
import net.sf.l2j.gameserver.model.actor.L2Playable;
import net.sf.l2j.gameserver.model.actor.instance.L2PcInstance;
import net.sf.l2j.gameserver.model.actor.instance.L2PetInstance;
import net.sf.l2j.gameserver.model.entity.TvTEvent;
import net.sf.l2j.gameserver.network.SystemMessageId;
import net.sf.l2j.gameserver.network.serverpackets.ActionFailed;
import net.sf.l2j.gameserver.network.serverpackets.MagicSkillUse;
import net.sf.l2j.gameserver.network.serverpackets.SystemMessage;

/**
* This class ...
*
* @version $Revision: 1.1.6.4 $ $Date: 2005/04/06 18:25:18 $
*/

public class Scrolls implements IItemHandler
{
	private static final int[] ITEM_IDS =
	{
		3926, 3927, 3928, 3929, 3930, 3931,
		3932, 3933, 3934, 3935, 4218, 5593,
		5594, 5595, 6037, 5703, 5803, 5804,
		5805, 5806, 5807, 8515, 8516, 8517,
		8518, 8519, 8520, 8594, 8595, 8596,
		8597, 8598, 8599, 8954, 8955, 8956,
		9146, 9147, 9148, 9149, 9150, 9151,
		9152, 9153, 9154, 9155, 9897, 10131,
		10132, 10133, 10134, 10135, 10136,
		10137, 10138, 10151, 10274, 13844, 13794, 13795, 13800, 13801, //Update by rocknow-Start
		13569,13570,13571,13572,13573,13574,13575,13576,13577,13578,
		13579,13580,13581,13582,13583,13584,13585,13586,13587,13588,
		13589,13590,13591,13592,13593,13594,13595,13596,13597,13598,
		13599,13600,13601,13602,13603,13604,13605,13606,13607,13608,
		13609,13610,13611,13612,13613,13614,13615,13616,13617,13618,
		13619,13620,13621,13622,13623,13624,13625,13626,13627,13628,
		13629,13630,13631,13632,13633,13634,13635,13636,13637,13638,
		13639,13640,13641,13642,13643,13644,13645,13646,13647,13648,
		13649,13650,13651,13652,13653,13654,13655,13656,13657,13658,
		13659,13660,13661,13662,13663,13664,13665,13666,13667,13668,
		13669,13670,13671,13672,13673,13674,13675,13676 //Update by rocknow-End
	};
	
	/**
	 * 
	 * @see net.sf.l2j.gameserver.handler.IItemHandler#useItem(net.sf.l2j.gameserver.model.actor.L2Playable, net.sf.l2j.gameserver.model.L2ItemInstance)
	 */
	public void useItem(L2Playable playable, L2ItemInstance item)
	{
		L2PcInstance activeChar;
		if (playable instanceof L2PcInstance)
			activeChar = (L2PcInstance) playable;
		else if (playable instanceof L2PetInstance)
			activeChar = ((L2PetInstance) playable).getOwner();
		else
			return;
		
		if (activeChar.isAllSkillsDisabled() || activeChar.isCastingNow())
		{
			activeChar.sendPacket(ActionFailed.STATIC_PACKET);
			return;
		}
		
		if (activeChar.isInOlympiadMode())
		{
			activeChar.sendPacket(new SystemMessage(SystemMessageId.THIS_ITEM_IS_NOT_AVAILABLE_FOR_THE_OLYMPIAD_EVENT));
			return;
		}
		
		if (!TvTEvent.onScrollUse(playable.getObjectId()))
		{
			playable.sendPacket(ActionFailed.STATIC_PACKET);
			return;
		}
		
		int itemId = item.getItemId();
		
		if (itemId == 13844)
		{
			useScroll(activeChar,2630,1);
			return;
		}
		if (itemId >= 8594 && itemId <= 8599) //Scrolls of recovery XML: 2286
		{
			if (!playable.destroyItem("Consume", item.getObjectId(), 1, null, false))
				return;
			activeChar.broadcastPacket(new MagicSkillUse(playable, playable, 2286, 1, 1, 0));
			activeChar.reduceDeathPenaltyBuffLevel();
			useScroll(activeChar, 2286, itemId - 8593);
			return;
		}
		else if (itemId == 5703 || itemId >= 5803 && itemId <= 5807)
		{
			byte expIndex = (byte) activeChar.getExpertiseIndex();
			if (!playable.destroyItem("Consume", item.getObjectId(), 1, null, false))
				return;
			activeChar.broadcastPacket(new MagicSkillUse(playable, playable, 2168, (expIndex > 5 ? 6 : expIndex + 1), 1, 0));
			useScroll(activeChar, 2168, (expIndex > 5 ? 6 : expIndex + 1));
			activeChar.setCharmOfLuck(true);
			return;
		}
		else if (itemId >= 8515 && itemId <= 8520) // Charm of Courage XML: 5041
		{
			if (!playable.destroyItem("Consume", item.getObjectId(), 1, null, false))
				return;
			activeChar.broadcastPacket(new MagicSkillUse(playable, playable, 5041, 1, 1, 0));
			useScroll(activeChar, 5041, 1);
			return;
		}
		else if (itemId == 9897 || itemId >= 10131 && itemId <= 10138 || itemId == 10151 || itemId == 10274 || itemId == 13794 || itemId == 13795 || itemId == 13800 || itemId == 13801) //Update by rocknow
		{
			if (activeChar.isMounted() || activeChar.getPet() != null || activeChar.isTransformed())
			{
				activeChar.sendPacket(new SystemMessage(SystemMessageId.S1_CANNOT_BE_USED).addItemName(item));
				return;
			}
		}
		else if (itemId >= 8954 && itemId <= 8956)
		{
			if (!playable.destroyItem("Consume", item.getObjectId(), 1, null, false))
				return;
			switch (itemId)
			{
				case 8954: // Blue Primeval Crystal XML: 2306
					activeChar.broadcastPacket(new MagicSkillUse(playable, playable, 2306, 1, 1, 0));
					useScroll(activeChar, 2306, 1);
					break;
				case 8955: // Green Primeval Crystal XML: 2306
					activeChar.broadcastPacket(new MagicSkillUse(playable, playable, 2306, 2, 1, 0));
					useScroll(activeChar, 2306, 2);
					break;
				case 8956: // Red Primeval Crystal XML: 2306
					activeChar.broadcastPacket(new MagicSkillUse(playable, playable, 2306, 3, 1, 0));
					useScroll(activeChar, 2306, 3);
					break;
				
				default:
					break;
			}
			return;
		}
		
		// for the rest, there are no extra conditions
		if (!playable.destroyItem("Consume", item.getObjectId(), 1, null, false))
			return;
		
		switch (itemId)
		{
			case 3926: // Scroll of Guidance XML:2050
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2050, 1, 1, 0));
				useScroll(activeChar, 2050, 1);
				break;
			case 3927: // Scroll of Death Whisper XML:2051
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2051, 1, 1, 0));
				useScroll(activeChar, 2051, 1);
				break;
			case 3928: // Scroll of Focus XML:2052
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2052, 1, 1, 0));
				useScroll(activeChar, 2052, 1);
				break;
			case 3929: // Scroll of Greater Acumen XML:2053
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2053, 1, 1, 0));
				useScroll(activeChar, 2053, 1);
				break;
			case 3930: // Scroll of Haste XML:2054
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2054, 1, 1, 0));
				useScroll(activeChar, 2054, 1);
				break;
			case 3931: // Scroll of Agility XML:2055
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2055, 1, 1, 0));
				useScroll(activeChar, 2055, 1);
				break;
			case 3932: // Scroll of Mystic Empower XML:2056
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2056, 1, 1, 0));
				useScroll(activeChar, 2056, 1);
				break;
			case 3933: // Scroll of Might XML:2057
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2057, 1, 1, 0));
				useScroll(activeChar, 2057, 1);
				break;
			case 3934: // Scroll of Wind Walk XML:2058
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2058, 1, 1, 0));
				useScroll(activeChar, 2058, 1);
				break;
			case 3935: // Scroll of Shield XML:2059
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2059, 1, 1, 0));
				useScroll(activeChar, 2059, 1);
				break;
			case 4218: // Scroll of Mana Regeneration XML:2064
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2064, 1, 1, 0));
				useScroll(activeChar, 2064, 1);
				break;
			case 5593: // SP Scroll Low Grade XML:2167
				activeChar.broadcastPacket(new MagicSkillUse(playable, playable, 2167, 1, 1, 0));
				useScroll(activeChar, 2167, 1);
				break;
			case 5594: // SP Scroll Medium Grade XML:2167
				activeChar.broadcastPacket(new MagicSkillUse(playable, playable, 2167, 2, 1, 0));
				useScroll(activeChar, 2167, 2);
				break;
			case 5595: // SP Scroll High Grade XML:2167
				activeChar.broadcastPacket(new MagicSkillUse(playable, playable, 2167, 3, 1, 0));
				useScroll(activeChar, 2167, 3);
				break;
			case 6037: // Scroll of Waking XML:2170
				activeChar.broadcastPacket(new MagicSkillUse(playable, playable, 2170, 1, 1, 0));
				useScroll(activeChar, 2170, 1);
				break;
			case 9146: // Scroll of Guidance - For Event XML:2050
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2050, 1, 1, 0));
				useScroll(activeChar, 2050, 1);
				break;
			case 9147: // Scroll of Death Whisper - For Event XML:2051
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2051, 1, 1, 0));
				useScroll(activeChar, 2051, 1);
				break;
			case 9148: // Scroll of Focus - For Event XML:2052
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2052, 1, 1, 0));
				useScroll(activeChar, 2052, 1);
				break;
			case 9149: // Scroll of Acumen - For Event XML:2053
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2053, 1, 1, 0));
				useScroll(activeChar, 2053, 1);
				break;
			case 9150: // Scroll of Haste - For Event XML:2054
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2054, 1, 1, 0));
				useScroll(activeChar, 2054, 1);
				break;
			case 9151: // Scroll of Agility - For Event XML:2055
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2055, 1, 1, 0));
				useScroll(activeChar, 2055, 1);
				break;
			case 9152: // Scroll of Empower - For Event XML:2056
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2056, 1, 1, 0));
				useScroll(activeChar, 2056, 1);
				break;
			case 9153: // Scroll of Might - For Event XML:2057
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2057, 1, 1, 0));
				useScroll(activeChar, 2057, 1);
				break;
			case 9154: // Scroll of Wind Walk - For Event XML:2058
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2058, 1, 1, 0));
				useScroll(activeChar, 2058, 1);
				break;
			case 9155: // Scroll of Shield - For Event XML:2059
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2059, 1, 1, 0));
				useScroll(activeChar, 2059, 1);
				break;
			case 9897:
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2370, 1, 1, 0));
				useScroll(activeChar, 2370, 1);
				break;
			case 9648:
			case 10131:
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2371, 1, 1, 0));
				useScroll(activeChar, 2371, 1);
				break;
			case 9649:
			case 10132:
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2372, 1, 1, 0));
				useScroll(activeChar, 2372, 1);
				break;
			case 9650:
			case 10133:
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2373, 1, 1, 0));
				useScroll(activeChar, 2373, 1);
				break;
			case 9651:
			case 10134:
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2374, 1, 1, 0));
				useScroll(activeChar, 2374, 1);
				break;
			case 9652:
			case 10135:
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2375, 1, 1, 0));
				useScroll(activeChar, 2375, 1);
				break;
			case 9653:
			case 10136:
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2376, 1, 1, 0));
				useScroll(activeChar, 2376, 1);
				break;
			case 9654:
			case 10137:
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2377, 1, 1, 0));
				useScroll(activeChar, 2377, 1);
				break;
			case 9655:
			case 10138:
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2378, 1, 1, 0));
				useScroll(activeChar, 2378, 1);
				break;
			case 10151:
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2394, 1, 1, 0));
				useScroll(activeChar, 2394, 1);
				break;
			case 10274:
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2428, 1, 1, 0));
				useScroll(activeChar, 2428, 1);
				break;
			case 13794://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2670, 1, 1, 0));
				useScroll(activeChar, 2670, 1);
				break;
			case 13795://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2671, 1, 1, 0));
				useScroll(activeChar, 2671, 1);
				break;
			case 13800://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2631, 1, 1, 0));
				useScroll(activeChar, 2631, 1);
				break;
			case 13801://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2632, 1, 1, 0));
				useScroll(activeChar, 2632, 1);
				break;
			case 13569://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2672, 1, 1, 0));
				useScroll(activeChar, 2672, 1);
				break;
			case 13570://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2673, 1, 1, 0));
				useScroll(activeChar, 2673, 1);
				break;
			case 13571://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2674, 1, 1, 0));
				useScroll(activeChar, 2674, 1);
				break;
			case 13572://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2675, 1, 1, 0));
				useScroll(activeChar, 2675, 1);
				break;
			case 13573://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2676, 1, 1, 0));
				useScroll(activeChar, 2676, 1);
				break;
			case 13574://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2677, 1, 1, 0));
				useScroll(activeChar, 2677, 1);
				break;
			case 13575://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2678, 1, 1, 0));
				useScroll(activeChar, 2678, 1);
				break;
			case 13576://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2679, 1, 1, 0));
				useScroll(activeChar, 2679, 1);
				break;
			case 13577://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2680, 1, 1, 0));
				useScroll(activeChar, 2680, 1);
				break;
			case 13578://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2681, 1, 1, 0));
				useScroll(activeChar, 2681, 1);
				break;
			case 13579://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2682, 1, 1, 0));
				useScroll(activeChar, 2682, 1);
				break;
			case 13580://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2683, 1, 1, 0));
				useScroll(activeChar, 2683, 1);
				break;
			case 13581://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2684, 1, 1, 0));
				useScroll(activeChar, 2684, 1);
				break;
			case 13582://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2685, 1, 1, 0));
				useScroll(activeChar, 2685, 1);
				break;
			case 13583://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2686, 1, 1, 0));
				useScroll(activeChar, 2686, 1);
				break;
			case 13584://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2687, 1, 1, 0));
				useScroll(activeChar, 2687, 1);
				break;
			case 13585://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2688, 1, 1, 0));
				useScroll(activeChar, 2688, 1);
				break;
			case 13586://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2689, 1, 1, 0));
				useScroll(activeChar, 2689, 1);
				break;
			case 13587://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2690, 1, 1, 0));
				useScroll(activeChar, 2690, 1);
				break;
			case 13588://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2691, 1, 1, 0));
				useScroll(activeChar, 2691, 1);
				break;
			case 13589://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2692, 1, 1, 0));
				useScroll(activeChar, 2692, 1);
				break;
			case 13590://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2693, 1, 1, 0));
				useScroll(activeChar, 2693, 1);
				break;
			case 13591://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2694, 1, 1, 0));
				useScroll(activeChar, 2694, 1);
				break;
			case 13592://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2695, 1, 1, 0));
				useScroll(activeChar, 2695, 1);
				break;
			case 13593://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2696, 1, 1, 0));
				useScroll(activeChar, 2696, 1);
				break;
			case 13594://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2697, 1, 1, 0));
				useScroll(activeChar, 2697, 1);
				break;
			case 13595://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2698, 1, 1, 0));
				useScroll(activeChar, 2698, 1);
				break;
			case 13596://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2699, 1, 1, 0));
				useScroll(activeChar, 2699, 1);
				break;
			case 13597://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2700, 1, 1, 0));
				useScroll(activeChar, 2700, 1);
				break;
			case 13598://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2701, 1, 1, 0));
				useScroll(activeChar, 2701, 1);
				break;
			case 13599://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2702, 1, 1, 0));
				useScroll(activeChar, 2702, 1);
				break;
			case 13600://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2703, 1, 1, 0));
				useScroll(activeChar, 2703, 1);
				break;
			case 13601://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2704, 1, 1, 0));
				useScroll(activeChar, 2704, 1);
				break;
			case 13602://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2705, 1, 1, 0));
				useScroll(activeChar, 2705, 1);
				break;
			case 13603://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2706, 1, 1, 0));
				useScroll(activeChar, 2706, 1);
				break;
			case 13604://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2707, 1, 1, 0));
				useScroll(activeChar, 2707, 1);
				break;
			case 13605://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2708, 1, 1, 0));
				useScroll(activeChar, 2708, 1);
				break;
			case 13606://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2709, 1, 1, 0));
				useScroll(activeChar, 2709, 1);
				break;
			case 13607://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2710, 1, 1, 0));
				useScroll(activeChar, 2710, 1);
				break;
			case 13608://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2711, 1, 1, 0));
				useScroll(activeChar, 2711, 1);
				break;
			case 13609://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2712, 1, 1, 0));
				useScroll(activeChar, 2712, 1);
				break;
			case 13610://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2713, 1, 1, 0));
				useScroll(activeChar, 2713, 1);
				break;
			case 13611://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2714, 1, 1, 0));
				useScroll(activeChar, 2714, 1);
				break;
			case 13612://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2715, 1, 1, 0));
				useScroll(activeChar, 2715, 1);
				break;
			case 13613://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2716, 1, 1, 0));
				useScroll(activeChar, 2716, 1);
				break;
			case 13614://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2717, 1, 1, 0));
				useScroll(activeChar, 2717, 1);
				break;
			case 13615://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2718, 1, 1, 0));
				useScroll(activeChar, 2718, 1);
				break;
			case 13616://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2719, 1, 1, 0));
				useScroll(activeChar, 2719, 1);
				break;
			case 13617://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2720, 1, 1, 0));
				useScroll(activeChar, 2720, 1);
				break;
			case 13618://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2721, 1, 1, 0));
				useScroll(activeChar, 2721, 1);
				break;
			case 13619://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2722, 1, 1, 0));
				useScroll(activeChar, 2722, 1);
				break;
			case 13620://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2723, 1, 1, 0));
				useScroll(activeChar, 2723, 1);
				break;
			case 13621://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2724, 1, 1, 0));
				useScroll(activeChar, 2724, 1);
				break;
			case 13622://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2725, 1, 1, 0));
				useScroll(activeChar, 2725, 1);
				break;
			case 13623://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2726, 1, 1, 0));
				useScroll(activeChar, 2726, 1);
				break;
			case 13624://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2727, 1, 1, 0));
				useScroll(activeChar, 2727, 1);
				break;
			case 13625://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2728, 1, 1, 0));
				useScroll(activeChar, 2728, 1);
				break;
			case 13626://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2729, 1, 1, 0));
				useScroll(activeChar, 2729, 1);
				break;
			case 13627://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2730, 1, 1, 0));
				useScroll(activeChar, 2730, 1);
				break;
			case 13628://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2731, 1, 1, 0));
				useScroll(activeChar, 2731, 1);
				break;
			case 13629://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2732, 1, 1, 0));
				useScroll(activeChar, 2732, 1);
				break;
			case 13630://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2733, 1, 1, 0));
				useScroll(activeChar, 2733, 1);
				break;
			case 13631://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2734, 1, 1, 0));
				useScroll(activeChar, 2734, 1);
				break;
			case 13632://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2735, 1, 1, 0));
				useScroll(activeChar, 2735, 1);
				break;
			case 13633://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2736, 1, 1, 0));
				useScroll(activeChar, 2736, 1);
				break;
			case 13634://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2737, 1, 1, 0));
				useScroll(activeChar, 2737, 1);
				break;
			case 13635://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2738, 1, 1, 0));
				useScroll(activeChar, 2738, 1);
				break;
			case 13636://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2739, 1, 1, 0));
				useScroll(activeChar, 2739, 1);
				break;
			case 13637://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2740, 1, 1, 0));
				useScroll(activeChar, 2740, 1);
				break;
			case 13638://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2741, 1, 1, 0));
				useScroll(activeChar, 2741, 1);
				break;
			case 13639://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2742, 1, 1, 0));
				useScroll(activeChar, 2742, 1);
				break;
			case 13640://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2743, 1, 1, 0));
				useScroll(activeChar, 2743, 1);
				break;
			case 13641://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2744, 1, 1, 0));
				useScroll(activeChar, 2744, 1);
				break;
			case 13642://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2745, 1, 1, 0));
				useScroll(activeChar, 2745, 1);
				break;
			case 13643://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2746, 1, 1, 0));
				useScroll(activeChar, 2746, 1);
				break;
			case 13644://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2747, 1, 1, 0));
				useScroll(activeChar, 2747, 1);
				break;
			case 13645://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2748, 1, 1, 0));
				useScroll(activeChar, 2748, 1);
				break;
			case 13646://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2749, 1, 1, 0));
				useScroll(activeChar, 2749, 1);
				break;
			case 13647://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2750, 1, 1, 0));
				useScroll(activeChar, 2750, 1);
				break;
			case 13648://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2751, 1, 1, 0));
				useScroll(activeChar, 2751, 1);
				break;
			case 13649://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2752, 1, 1, 0));
				useScroll(activeChar, 2752, 1);
				break;
			case 13650://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2753, 1, 1, 0));
				useScroll(activeChar, 2753, 1);
				break;
			case 13651://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2754, 1, 1, 0));
				useScroll(activeChar, 2754, 1);
				break;
			case 13652://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2755, 1, 1, 0));
				useScroll(activeChar, 2755, 1);
				break;
			case 13653://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2756, 1, 1, 0));
				useScroll(activeChar, 2756, 1);
				break;
			case 13654://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2757, 1, 1, 0));
				useScroll(activeChar, 2757, 1);
				break;
			case 13655://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2758, 1, 1, 0));
				useScroll(activeChar, 2758, 1);
				break;
			case 13656://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2759, 1, 1, 0));
				useScroll(activeChar, 2759, 1);
				break;
			case 13657://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2760, 1, 1, 0));
				useScroll(activeChar, 2760, 1);
				break;
			case 13658://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2761, 1, 1, 0));
				useScroll(activeChar, 2761, 1);
				break;
			case 13659://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2762, 1, 1, 0));
				useScroll(activeChar, 2762, 1);
				break;
			case 13660://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2763, 1, 1, 0));
				useScroll(activeChar, 2763, 1);
				break;
			case 13661://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2764, 1, 1, 0));
				useScroll(activeChar, 2764, 1);
				break;
			case 13662://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2765, 1, 1, 0));
				useScroll(activeChar, 2765, 1);
				break;
			case 13663://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2766, 1, 1, 0));
				useScroll(activeChar, 2766, 1);
				break;
			case 13664://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2767, 1, 1, 0));
				useScroll(activeChar, 2767, 1);
				break;
			case 13665://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2768, 1, 1, 0));
				useScroll(activeChar, 2768, 1);
				break;
			case 13666://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2769, 1, 1, 0));
				useScroll(activeChar, 2769, 1);
				break;
			case 13667://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2770, 1, 1, 0));
				useScroll(activeChar, 2770, 1);
				break;
			case 13668://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2771, 1, 1, 0));
				useScroll(activeChar, 2771, 1);
				break;
			case 13669://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2772, 1, 1, 0));
				useScroll(activeChar, 2772, 1);
				break;
			case 13670://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2773, 1, 1, 0));
				useScroll(activeChar, 2773, 1);
				break;
			case 13671://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2774, 1, 1, 0));
				useScroll(activeChar, 2774, 1);
				break;
			case 13672://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2775, 1, 1, 0));
				useScroll(activeChar, 2775, 1);
				break;
			case 13673://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2776, 1, 1, 0));
				useScroll(activeChar, 2776, 1);
				break;
			case 13674://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2777, 1, 1, 0));
				useScroll(activeChar, 2777, 1);
				break;
			case 13675://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2778, 1, 1, 0));
				useScroll(activeChar, 2778, 1);
				break;
			case 13676://Update by rocknow
				activeChar.broadcastPacket(new MagicSkillUse(playable, activeChar, 2779, 1, 1, 0));
				useScroll(activeChar, 2779, 1);
				break;
			default:
				break;
		}
	}
	
	/**
	 * 
	 * @param activeChar
	 * @param magicId
	 * @param level
	 */
	public void useScroll(L2PcInstance activeChar, int magicId, int level)
	{
		L2Skill skill = SkillTable.getInstance().getInfo(magicId, level);
		if (skill != null)
			activeChar.useMagic(skill, true, false);
	}
	
	/**
	 * 
	 * @see net.sf.l2j.gameserver.handler.IItemHandler#getItemIds()
	 */
	public int[] getItemIds()
	{
		return ITEM_IDS;
	}
}
