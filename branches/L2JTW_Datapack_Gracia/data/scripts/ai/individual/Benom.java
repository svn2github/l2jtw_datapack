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

import com.l2jserver.gameserver.ai.CtrlEvent;
import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.model.L2Skill;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.network.serverpackets.CreatureSay;
import com.l2jserver.util.Rnd;

/**
 * «Ò¹p¼Ú°õ¬F©x ¨©¿Õ©i
 * @author Lunawang
 */
public class Benom extends L2AttackableAIScript
{
	private final static int BENOM = 29054;
	
	public Benom(int questId, String name, String descr)
	{
		super(questId, name, descr);
		int[] mobs = new int[] { BENOM };
		this.registerMobs(mobs);
	}
	
	@Override
	public String onAttack(L2Npc npc, L2PcInstance attacker, int damage, boolean isPet, L2Skill skill)
	{
		if (npc == null || attacker == null)
			return super.onAttack(npc, attacker, damage, isPet);
		if (npc.getNpcId() == 29054)
		{
			if (!npc.isCastingNow() && attacker.getClassId().isMage() && Rnd.get(1000) < 15)
			{
				SkillTable.getInstance().getInfo(4996, 1);
				npc.getAI().notifyEvent(CtrlEvent.EVT_AGGRESSION, attacker, 50000);
				npc.setTarget(attacker);
				npc.doCast(skill);
			}
		}
		return super.onAttack(npc, attacker, damage, isPet);
	}
	
	@Override
	public String onKill(L2Npc npc, L2PcInstance killer, boolean isPet)
	{
		if (npc != null && npc.getNpcId() == 29054)
		{
			npc.broadcastPacket(new CreatureSay(npc.getObjectId(), 0, "Benom", "I leave my house this time."));
			npc.broadcastPacket(new CreatureSay(npc.getObjectId(), 0, "Benom", "But you can not take it to paradise."));
		}
		return super.onKill(npc, killer, isPet);
	}
	
	public static void main(String[] args)
	{
		new Benom(-1, "benom", "ai");
	}
}