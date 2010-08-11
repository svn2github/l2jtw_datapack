/* This program is free software: you can redistribute it and/or modify it under
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
/** 大地奇美拉 / 黑暗奇美拉 / 風之奇美拉 / 火焰奇美拉 / 西爾德斯 奇美拉 */
package ai.individual;

import ai.group_template.L2AttackableAIScript;
import com.l2jserver.gameserver.datatables.ItemTable;
import com.l2jserver.gameserver.instancemanager.HellboundManager;
import com.l2jserver.gameserver.model.L2ItemInstance;
import com.l2jserver.gameserver.model.L2Object;
import com.l2jserver.gameserver.model.L2Skill;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.util.Rnd;

/**
 * @author theOne
 */
public class Chimeras extends L2AttackableAIScript
{
	private static final int[] npcIds = {
			22349, 22350, 22351, 22352
	};

	private static final int celtusId = 22353;

	private static final int[][] locs = {
			{
					4276, 237245, -3310
			}, {
					11437, 236788, -1949
			}, {
					7647, 235672, -1977
			}, {
					1882, 233520, -3315
			}
	};

	public Chimeras(int questId, String name, String descr)
	{
		super(questId, name, descr);
		for (int i : npcIds)
			addSkillSeeId(i);
		addSkillSeeId(celtusId);

		if (HellboundManager.getInstance().getLevel() >= 7)
		{
			int[] loc = locs[Rnd.get(locs.length)];
			int respawnTime = (18 + Rnd.get(36)) * 100;
			HellboundManager.getInstance().addSpawn(celtusId, loc[0], loc[1], loc[2], 0, respawnTime);
		}
	}

	private void dropItem(L2PcInstance player, L2Npc npc, int itemId, int count)
	{
		L2ItemInstance item = ItemTable.getInstance().createItem("Forces", itemId, count, player);
		item.dropMe(player, npc.getX(), npc.getY(), npc.getZ());
	}

	@Override
	public String onSkillSee(L2Npc npc, L2PcInstance player, L2Skill skill, L2Object[] targets, boolean isPet)
	{
		for (L2Object obj : targets)
		{
			if (npc != obj)
				return null;
		}

		int npcId = npc.getNpcId();
		int maxHp = npc.getMaxHp();
		double currentHp = npc.getStatus().getCurrentHp();

		if (HellboundManager.getInstance().getLevel() >= 7 && skill.getId() == 2359 && currentHp < maxHp * 0.1)
		{
			if (contains(npcIds, npc.getNpcId()))
			{
				if (Rnd.get(100) < 10)
					dropItem(player, npc, 9681, 1);

				dropItem(player, npc, 9680, 1);
				npc.onDecay();
			}
			else if (npcId == celtusId)
			{
				dropItem(player, npc, 9682, 1);
				npc.onDecay();
			}
		}

		return super.onSkillSee(npc, player, skill, targets, isPet);
	}

	public static void main(String[] args)
	{
		new Chimeras(-1, "Chimeras", "ai");
	}
}