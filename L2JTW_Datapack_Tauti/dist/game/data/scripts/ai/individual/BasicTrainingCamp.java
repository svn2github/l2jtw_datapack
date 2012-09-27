/*
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU drillsergeant Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU drillsergeant Public License for more
 * details.
 * 
 * You should have received a copy of the GNU drillsergeant Public License along with
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
import com.l2jserver.util.Rnd;

public class BasicTrainingCamp extends L2AttackableAIScript
{
	private static final int drillsergeantId = 33007;
	private static final int studentId = 33018;
	private static final int soldierId = 33201;
	private static int _social;
	private static int _wrong;
	private static int _wait;
	
	private final List<L2Npc> _drillsergeant = new ArrayList<>();
	private final List<L2Npc> _students = new ArrayList<>();
	private final List<L2Npc> _soldiers = new ArrayList<>();
	
	public BasicTrainingCamp(int questId, String name, String descr)
	{
		super(questId, name, descr);
		findNpcs();
		if (_drillsergeant.isEmpty() || _students.isEmpty() || _soldiers.isEmpty())
			throw new NullPointerException("Cannot find npcs!");
		startQuestTimer("basic_0", 60000, null, null);
		startQuestTimer("training", 60000, null, null);
	}
	
	public void findNpcs()
	{
		for (L2Spawn spawn : SpawnTable.getInstance().getSpawnTable())
			if (spawn != null)
				if (spawn.getNpcid() == drillsergeantId)
					_drillsergeant.add(spawn.getLastSpawn());
				else if (spawn.getNpcid() == studentId)
					_students.add(spawn.getLastSpawn());
				else if (spawn.getNpcid() == soldierId)
					_soldiers.add(spawn.getLastSpawn());
	}
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		if (event.startsWith("basic_0"))
		{
			int value = Rnd.get(85);
			if (_wrong == 1)
			{
				for (L2Npc drillsergeant : _drillsergeant)
				{
					drillsergeant.broadcastSocialAction(1);
					_wrong = 0;
				}
				startQuestTimer("basic_0", 5800, null, null);
			}
			else if (value == 2)
			{
				for (L2Npc drillsergeant : _drillsergeant)
				{
					drillsergeant.broadcastSocialAction(2);
				}
				startQuestTimer("basic_0", 5800, null, null);
			}
			else if (value == 3)
			{
				for (L2Npc drillsergeant : _drillsergeant)
				{
					drillsergeant.broadcastSocialAction(3);
				}
				startQuestTimer("basic_0", 6200, null, null);
			}
			else if (value == 7)
			{
				for (L2Npc drillsergeant : _drillsergeant)
				{
					drillsergeant.broadcastSocialAction(7);
				}
				startQuestTimer("basic_0", 5800, null, null);
			}
			else if (value < 10)
			{
				_social = 6;
				_wait = 6100;
				for (L2Npc drillsergeant : _drillsergeant)
				{
					drillsergeant.broadcastSocialAction(_social);
				}
				startQuestTimer("student_0", _wait, null, null);
			}
			else if (value < 40)
			{
				_social = 5;
				_wait = 2500;
				for (L2Npc drillsergeant : _drillsergeant)
				{
					drillsergeant.broadcastSocialAction(_social);
				}
				startQuestTimer("student_0", _wait, null, null);
			}
			else if (value < 55)
			{
				_social = 8;
				_wait = 3200;
				for (L2Npc drillsergeant : _drillsergeant)
				{
					drillsergeant.broadcastSocialAction(_social);
				}
				startQuestTimer("student_0", _wait, null, null);
			}
			else if (value < 70)
			{
				_social = 9;
				_wait = 4400;
				for (L2Npc drillsergeant : _drillsergeant)
				{
					drillsergeant.broadcastSocialAction(_social);
				}
				startQuestTimer("student_0", _wait, null, null);
			}
			else if (value < 85)
			{
				_social = 10;
				_wait = 3100;
				for (L2Npc drillsergeant : _drillsergeant)
				{
					drillsergeant.broadcastSocialAction(_social);
				}
				startQuestTimer("student_0", _wait, null, null);
			}
			else
			{
				startQuestTimer("basic_0", 3000, null, null);
			}
		}
		else if (event.startsWith("student_0"))
		{
			int value = Rnd.get(200);
			if (value == 1)
			{
				for (L2Npc student : _students)
				{
					student.broadcastSocialAction(Rnd.get(8,10));
					_wrong = 1;
				}
				startQuestTimer("basic_0", 4000, null, null);
			}
			else
			{
				for (L2Npc student : _students)
				{
					student.broadcastSocialAction(_social);
				}
				startQuestTimer("basic_0", _wait+500, null, null);
			}
		}
		else if (event.startsWith("training"))
		{
			int value = Rnd.get(200);
			if (value == 0)
			{
				startQuestTimer("training", 2000, null, null);
			}
			else if (value == 1)
			{
				for (L2Npc soldier : _soldiers)
				{
					soldier.broadcastSocialAction(2);
				}
				startQuestTimer("training", 5700, null, null);
			}
			else
			{
				for (L2Npc soldier : _soldiers)
				{
					soldier.broadcastSocialAction(5);
				}
				startQuestTimer("training", 1800, null, null);
			}
		}
		return super.onAdvEvent(event, npc, player);
	}
	
	public static void main(String[] args)
	{
		new BasicTrainingCamp(-1, "BasicTrainingCamp", "ai");
	}
}
