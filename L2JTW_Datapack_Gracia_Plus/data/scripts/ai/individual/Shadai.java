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
 /** 傳說的鐵匠 夏代 */
package ai.individual;

import java.util.Calendar;

import ai.group_template.L2AttackableAIScript;
import com.l2jserver.gameserver.datatables.SpawnTable;
import com.l2jserver.gameserver.model.L2Spawn;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.network.serverpackets.NpcSay;
import com.l2jserver.util.Rnd;

public class Shadai extends L2AttackableAIScript
{
	private static final int shadai = 32347;

	private Calendar _date;

	public Shadai(int questId, String name, String descr)
	{
		super(questId, name, descr);

		shadaiSpawn();
	}

	private void shadaiSpawn()
	{
		_date = Calendar.getInstance();
		int newSecond = _date.get(Calendar.SECOND);
		int newMinute = _date.get(Calendar.MINUTE);
		int newHour = _date.get(Calendar.HOUR);

		int targetHour = (((24 - newHour) * 60) * 60) * 1000;
		int extraMinutesAndSeconds = (((60 - newMinute) * 60) + (60 - newSecond)) * 1000;
		int timerDuration = targetHour + extraMinutesAndSeconds;

		startQuestTimer("shadai_spawn", timerDuration, null, null);
	}

	private L2Npc findTemplate(int npcId)
	{
		L2Npc npc = null;
		for (L2Spawn spawn : SpawnTable.getInstance().getSpawnTable().values())
		{
			if (spawn != null && spawn.getNpcid() == npcId)
			{
				npc = spawn.getLastSpawn();
				break;
			}
		}
		return npc;
	}

	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		if (event.equalsIgnoreCase("shadai_spawn"))
		{
			if (Rnd.get(100) <= 40)
			{
				L2Npc shadaiSpawn = findTemplate(shadai);
				if (shadaiSpawn == null)
					addSpawn(shadai, 8962, 253278, -1932, 0, false, 3600000);
					npc.broadcastPacket(new NpcSay(npc.getObjectId(), 1, npc.getNpcId(), "誰會成為今晚的幸運兒呢？哈哈！真是好奇，真是好奇！"));
			}

			shadaiSpawn();
		}

		return null;
	}

	public static void main(String[] args)
	{
		new Shadai(-1, "Shadai", "ai");
	}
}