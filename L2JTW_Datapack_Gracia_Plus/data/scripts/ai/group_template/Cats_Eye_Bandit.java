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

/**
 * 貓眼盜賊
 */
public class Cats_Eye_Bandit extends L2AttackableAIScript
{
	private static final int Cats_Eye_Bandit = 27038;

	private static boolean _FirstAttacked;
	private int _numAtk = 0;

	public Cats_Eye_Bandit(int questId, String name, String descr)
	{
		super(questId, name, descr);
		int[] mobs = {Cats_Eye_Bandit};
		registerMobs(mobs, QuestEventType.ON_ATTACK, QuestEventType.ON_KILL);
		_FirstAttacked = false;
	}

	public String onAttack (L2Npc npc, L2PcInstance attacker, int damage, boolean isPet)
	{
		if (npc.getNpcId() == Cats_Eye_Bandit)
		{
			if (_FirstAttacked)
			{
				if (_numAtk < 1) npc.broadcastPacket(new NpcSay(npc.getObjectId(),0,npc.getNpcId(),"你幼稚的傻瓜，你以為你能抓住我？"));
				_numAtk++;
			}
			_FirstAttacked = true;
		}
		return super.onAttack(npc, attacker, damage, isPet);
	}

	public String onKill(L2Npc npc, L2PcInstance killer, boolean isPet)
	{
		int npcId = npc.getNpcId();
		if (npcId == Cats_Eye_Bandit)
		{
			npc.broadcastPacket(new NpcSay(npc.getObjectId(),0,npc.getNpcId(),"我必須做一些對這種可恥的事件..."));
			_numAtk = 0;
			_FirstAttacked = false;
		}
		return super.onKill(npc,killer,isPet);
	}

	public static void main(String[] args)
	{
		new Cats_Eye_Bandit(-1, "Cats_Eye_Bandit", "ai");
	}
}