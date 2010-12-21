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
package ai.individual;

import java.util.ArrayList;
import java.util.List;

import ai.group_template.L2AttackableAIScript;

import com.l2jserver.gameserver.datatables.SpawnTable;
import com.l2jserver.gameserver.model.L2Spawn;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.network.serverpackets.NpcSay;
import com.l2jserver.gameserver.network.serverpackets.SocialAction;
import com.l2jserver.util.Rnd;

/**
 * Dilios AI
 * @author JIV, Sephiroth, Apocalipce
 * 將軍 狄里歐斯
 */
public class GeneralDilios extends L2AttackableAIScript
{
	private static final int generalId = 32549;
	private static final int guardId = 32619;
	
	private L2Npc _general;
	private List<L2Npc> _guards = new ArrayList<L2Npc>();
	
	private static final String[] diliosText =
	{
		"傳令，告知柯塞勒斯同盟聯合的夥伴們！目前我們正在募集勇猛的冒險家們，準備攻擊霸佔破滅之種的蒂雅特的龍馬團！",
		"傳令，告知柯塞勒斯同盟聯合的夥伴們！多虧勇猛的冒險家們，目前正在剷除散佈在不滅之種的苦痛棺室和侵蝕棺室的不死生物們。",
		"傳令，告知柯塞勒斯同盟聯合的夥伴們！目前破滅之種在同盟聯合的旗幟下維護得很安全！",
		"傳令，告知柯塞勒斯同盟聯合的夥伴們！目前已掃蕩不滅之種的種子心臟部，正在對伊卡姆士展開直接的攻擊！",
	};
	
	public GeneralDilios(int questId, String name, String descr)
	{
		super(questId, name, descr);
		findNpcs();
		if (_general == null || _guards.isEmpty())
			throw new NullPointerException("Cannot find npcs!");
		startQuestTimer("command_0", 60000, null, null);
	}
	
	public void findNpcs()
	{
		for (L2Spawn spawn : SpawnTable.getInstance().getSpawnTable())
			if (spawn != null)
				if (spawn.getNpcid() == generalId)
					_general = spawn.getLastSpawn();
				else if (spawn.getNpcid() == guardId)
					_guards.add(spawn.getLastSpawn());
	}
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		if (event.startsWith("command_"))
		{
			int value = Integer.parseInt(event.substring(8));
			if (value < 6)
			{
				_general.broadcastPacket(new NpcSay(_general.getObjectId(), 0, generalId, "實施3次刺擊！"));
				startQuestTimer("guard_animation_0", 3400, null, null);
			}
			else
			{
				value = -1;
				_general.broadcastPacket(new NpcSay(_general.getObjectId(), 1, generalId, diliosText[Rnd.get(diliosText.length)]));
			}
			startQuestTimer("command_"+(value+1), 60000, null, null);
		}
		else if (event.startsWith("guard_animation_"))
		{
			int value = Integer.parseInt(event.substring(16));
			for (L2Npc guard : _guards)
			{
				guard.broadcastPacket(new SocialAction(guard.getObjectId(), 4));
			}
			if (value < 2)
				startQuestTimer("guard_animation_"+(value+1), 1500, null, null);
		}
		return super.onAdvEvent(event, npc, player);
	}
	
	public static void main(String[] args)
	{
		new GeneralDilios(-1, "GeneralDilios", "ai");
	}
}