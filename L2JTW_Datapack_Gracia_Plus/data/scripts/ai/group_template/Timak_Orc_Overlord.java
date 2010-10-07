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
 * 提瑪克獸人王
 */
public class Timak_Orc_Overlord extends L2AttackableAIScript
{
	private static final int Timak_Orc_Overlord = 20588;

	private static boolean _FirstAttacked;

	public Timak_Orc_Overlord(int questId, String name, String descr)
	{
		super(questId, name, descr);
		int[] mobs = {Timak_Orc_Overlord};
		registerMobs(mobs, QuestEventType.ON_ATTACK, QuestEventType.ON_KILL);
		_FirstAttacked = false;
	}

	public String onAttack (L2Npc npc, L2PcInstance attacker, int damage, boolean isPet)
	{
		if (npc.getNpcId() == Timak_Orc_Overlord)
		{
			if (_FirstAttacked)
			{
				if (Rnd.get(100) == 50)
				{
					npc.broadcastPacket(new NpcSay(npc.getObjectId(),0,npc.getNpcId(),"究極力量啊！！！！"));
				}
				if (Rnd.get(100) == 50)
				{
					npc.broadcastPacket(new NpcSay(npc.getObjectId(),0,npc.getNpcId(),"現在開始才是真正的決鬥！"));
				}
				if (Rnd.get(100) == 50)
				{
					npc.broadcastPacket(new NpcSay(npc.getObjectId(),0,npc.getNpcId(),"沒想到竟會對乳臭未乾的小子使用這招！"));
				}
			}
			_FirstAttacked = true;
		}
		return super.onAttack(npc, attacker, damage, isPet);
	}

	public String onKill(L2Npc npc, L2PcInstance killer, boolean isPet)
	{
		int npcId = npc.getNpcId();
		if (npcId == Timak_Orc_Overlord)
		{
			_FirstAttacked = false;
		}
		return super.onKill(npc,killer,isPet);
	}

	public static void main(String[] args)
	{
		new Timak_Orc_Overlord(-1, "Timak_Orc_Overlord", "ai");
	}
}