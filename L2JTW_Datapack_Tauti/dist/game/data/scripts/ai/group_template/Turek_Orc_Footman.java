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
 * 土瑞克獸人步兵
 */
public class Turek_Orc_Footman extends L2AttackableAIScript
{
	private static final int Turek_Orc_Footman = 20499;

	private static boolean _FirstAttacked;

	private static String[] text =
	{
		"下次一定讓你下地獄！",
		"今天受到恥辱，下次一定奉還給你！"
	};
	
	private static String[] text1 =
	{
		"不要再打了！",
		"就算殺了我，你也得不到什麼。"
	};
	
	public Turek_Orc_Footman(int questId, String name, String descr)
	{
		super(questId, name, descr);
		int[] mobs = {Turek_Orc_Footman};
		registerMobs(mobs, QuestEventType.ON_ATTACK, QuestEventType.ON_KILL);
		_FirstAttacked = false;
	}

	@Override
	public String onAttack (L2Npc npc, L2PcInstance attacker, int damage, boolean isPet)
	{
		if (npc.getNpcId() == Turek_Orc_Footman)
		{
			if (_FirstAttacked)
			{
				if (Rnd.get(100) == 50)
				{
					npc.broadcastPacket(new NpcSay(npc.getObjectId(),0,npc.getNpcId(),text[Rnd.get(1)]));
				}
				if (Rnd.get(100) == 50)
				{
					npc.broadcastPacket(new NpcSay(npc.getObjectId(),0,npc.getNpcId(),text1[Rnd.get(1)]));
				}
			}
			_FirstAttacked = true;
		}
		return super.onAttack(npc, attacker, damage, isPet);
	}

	@Override
	public String onKill(L2Npc npc, L2PcInstance killer, boolean isPet)
	{
		int npcId = npc.getNpcId();
		if (npcId == Turek_Orc_Footman)
		{
			_FirstAttacked = false;
		}
		return super.onKill(npc,killer,isPet);
	}

	public static void main(String[] args)
	{
		new Turek_Orc_Footman(-1, "Turek_Orc_Footman", "ai");
	}
}