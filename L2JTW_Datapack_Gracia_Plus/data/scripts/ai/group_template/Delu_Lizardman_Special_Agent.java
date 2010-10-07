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
package ai.group_template;

import ai.group_template.L2AttackableAIScript;

import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.network.serverpackets.NpcSay;
import com.l2jserver.util.Rnd;

/**
 * 德魯蜥蜴人高等戰士
 */
public class Delu_Lizardman_Special_Agent extends L2AttackableAIScript
{
	private static final int Delu_Lizardman_Special_Agent = 21105;

	private static boolean _FirstAttacked;

	public Delu_Lizardman_Special_Agent(int questId, String name, String descr)
	{
		super(questId, name, descr);
		int[] mobs = {Delu_Lizardman_Special_Agent};
		registerMobs(mobs, QuestEventType.ON_ATTACK, QuestEventType.ON_KILL);
		_FirstAttacked = false;
	}

	public String onAttack (L2Npc npc, L2PcInstance player, int damage, boolean isPet)
	{
		if (npc.getNpcId() == Delu_Lizardman_Special_Agent)
		{
			if (_FirstAttacked)
			{
				if (Rnd.get(100) == 50)
				{
					npc.broadcastPacket(new NpcSay(npc.getObjectId(),0,npc.getNpcId(),"竟敢妨礙神聖的決鬥！絕對饒不了你們！"));
				}
				if (Rnd.get(100) == 50)
				{
					npc.broadcastPacket(new NpcSay(npc.getObjectId(),0,npc.getNpcId(),player.getName()+"！竟敢妨礙我們比武！大家幫幫我！"));
				}
			}
			_FirstAttacked = true;
		}
		return super.onAttack(npc, player, damage, isPet);
	}

	public String onKill(L2Npc npc, L2PcInstance killer, boolean isPet)
	{
		int npcId = npc.getNpcId();
		if (npcId == Delu_Lizardman_Special_Agent)
		{
			_FirstAttacked = false;
		}
		return super.onKill(npc,killer,isPet);
	}

	public static void main(String[] args)
	{
		new Delu_Lizardman_Special_Agent(-1, "Delu_Lizardman_Special_Agent", "ai");
	}
}