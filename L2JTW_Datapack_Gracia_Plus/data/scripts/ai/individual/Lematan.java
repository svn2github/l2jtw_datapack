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

import ai.group_template.L2AttackableAIScript;

import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.L2Summon;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.network.serverpackets.MagicSkillUse;

/**
 * Lematan AI
 * 雷馬堂 / 雷馬堂的手下
 * @author RosT TODO: Minion's must healing Lematan.
 */
public class Lematan extends L2AttackableAIScript
{
	private static final int LEMATAN = 18633;
	private static final int MINION = 18634;
	public int status = 0;
	
	public Lematan(int id, String name, String descr)
	{
		super(id, name, descr);
		int[] mob = { LEMATAN, MINION };
		this.registerMobs(mob);
	}
	
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		if (npc != null)
		{
			if (event.equalsIgnoreCase("first_anim"))
				npc.broadcastPacket(new MagicSkillUse(npc, npc, 5756, 1, 2500, 0));
			else if (event.equalsIgnoreCase("lematanMinions"))
			{
				for (int i = 0; i < 6; i++)
				{
					int radius = 260;
					int x = (int) (radius * Math.cos(i * 0.918));
					int y = (int) (radius * Math.sin(i * 0.918));
					L2Npc mob = addSpawn(MINION, 84982 + x, -208690 + y, -3337, 0, false, 0);
					mob.setInstanceId(npc.getInstanceId());
				}
			}
			else if (event.equalsIgnoreCase("lematanMinions1"))
			{
				if (player.getInstanceId() != 0)
				{
					L2Npc mob = addSpawn(MINION, player.getX() + 50, player.getY() - 50, player.getZ(), 0, false, 0);
					mob.setInstanceId(npc.getInstanceId());
				}
				else
				{
					L2Npc mob = addSpawn(MINION, 84982, -208690, -3337, 0, false, 0);
					mob.setInstanceId(npc.getInstanceId());
				}
			}
		}
		return super.onAdvEvent(event, npc, player);
	}
	
	public String onAttack(L2Npc npc, L2PcInstance attacker, int damage, boolean isPet)
	{
		if (npc.getNpcId() == LEMATAN)
		{
			int maxHp = npc.getMaxHp();
			double nowHp = npc.getStatus().getCurrentHp();
			if (nowHp < maxHp * 0.5)
			{
				if (status == 0)
				{
					status = 1;
					attacker.teleToLocation(84570, -208327, -3337);
					L2Summon pet = attacker.getPet();
					if (pet != null)
						pet.teleToLocation(84570, -208327, -3337, true);
					npc.teleToLocation(84982, -208690, -3337);
					startQuestTimer("lematanMinions", 3000, npc, null);
				}
			}
		}
		return super.onAttack(npc, attacker, damage, isPet);
	}
	
	public String onKill(L2Npc npc, L2PcInstance killer, boolean isPet)
	{
		int npcId = npc.getNpcId();
		if (npcId == LEMATAN)
			status = 0;
		else if (npcId == MINION)
			if (status == 1)
				startQuestTimer("lematanMinions1", 10000, npc, killer);
		return super.onKill(npc, killer, isPet);
	}
	
	public String onSpawn(L2Npc npc)
	{
		int npcId = npc.getNpcId();
		if (npcId == MINION)
			startQuestTimer("first_anim", 1000, npc, null);
		return super.onSpawn(npc);
	}
	
	public static void main(String[] args)
	{
		// now call the constructor (starts up the ai)
		new Lematan(-1, "lematan", "ai");
	}
}