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
package teleports.SeparationOfTheSoul;

import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;

/**
 * @author pmq
 */
public class AntharasLairDeep extends Quest
{
	private static final int[] TELEPORTERS = {32864,32865,32866,32867,32868,32869,32870,32891};
	
	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = "";
		QuestState st = player.getQuestState(getName());
		
		if (st == null)
			return getNoQuestMsg(player);
		
		if (player.getLevel() >= 80)
			player.teleToLocation(148447,110582,-3944);
		else
			htmltext = "<html><body>分離的靈魂：<br>安塔瑞斯之爪只不過輕輕地蓋過了我的臉龐而已，但我的靈魂卻已支離破碎。<br>雖然分散各地的靈魂沒能聚集在一起，但我還是能感覺得到我們彼此相連著。如果你願意的話，我可以把你傳送到我那分離的靈魂所在之處。不過，看來你還沒有具備能結合我那些已被撕碎的靈魂的力量。<br>（若要移動到其他分離的靈魂，角色等級必須達到<font color=\"LEVEL\">等級80以上</font>。）</body></html>";
		
		return htmltext;
	}
	
	public AntharasLairDeep(int questId, String name, String descr)
	{
		super(questId, name, descr);
		
		for (int teleporters : TELEPORTERS)
		{
			addStartNpc(teleporters);
			addTalkId(teleporters);
		}
	}
	
	public static void main(String[] args)
	{
		new AntharasLairDeep(-1, AntharasLairDeep.class.getSimpleName(), "teleports");
	}
}
