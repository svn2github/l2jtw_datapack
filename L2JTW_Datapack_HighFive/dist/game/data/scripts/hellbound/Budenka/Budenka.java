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
package hellbound.Budenka;

import com.l2jserver.gameserver.instancemanager.HellboundManager;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;

public class Budenka extends Quest
{
	private static final int BUDENKA       = 32294; //奇岩的商隊 布丹卡
	private static final int BASIC_CERT    = 9850;  //商隊初級認證書
	private static final int STANDART_CERT = 9851;  //商隊中級認證書
	private static final int PREMIUM_CERT  = 9852;  //商隊高級認證書
	
	@Override
	public final String onFirstTalk(L2Npc npc, L2PcInstance player)
	{
		QuestState st = player.getQuestState(getName());
		if (st == null)
			st = newQuestState(player);
		
		int hellboundLevel = HellboundManager.getInstance().getLevel();
		if (hellboundLevel < 2)
			return "32294.htm";
		else if (hellboundLevel >= 2)
			if (player.getInventory().getInventoryItemCount(BASIC_CERT, -1, false) > 0)
				return "32294-basic.htm";
			if (player.getInventory().getInventoryItemCount(PREMIUM_CERT, -1, false) > 0)
				return "32294-premium.htm";
			if (player.getInventory().getInventoryItemCount(STANDART_CERT, -1, false) > 0)
				return "32294-standart.htm";
		
		npc.showChatWindow(player);
		return null;
	}
	
	public Budenka(int questId, String name, String descr)
	{
		super(questId, name, descr);
		addFirstTalkId(BUDENKA);
	}
	
	public static void main(String[] args)
	{
		new Budenka(-1, Budenka.class.getSimpleName(), "hellbound");
	}
}
