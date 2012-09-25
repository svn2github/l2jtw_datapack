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

/**
 * Dilios AI
 * @author JIV, Sephiroth, Apocalipce
 */
public class BasicTrainingCamp extends L2AttackableAIScript
{
	private static final int drillsergeantId = 33007;
	private static final int studentId = 33018;
	private static int _social;
	
	private final List<L2Npc> _drillsergeant = new ArrayList<>();
	private final List<L2Npc> _students = new ArrayList<>();
	
	public BasicTrainingCamp(int questId, String name, String descr)
	{
		super(questId, name, descr);
		findNpcs();
		if (_drillsergeant.isEmpty() || _students.isEmpty())
			throw new NullPointerException("Cannot find npcs!");
		startQuestTimer("basic_0", 60000, null, null);
	}
	
	public void findNpcs()
	{
		for (L2Spawn spawn : SpawnTable.getInstance().getSpawnTable())
			if (spawn != null)
				if (spawn.getNpcid() == drillsergeantId)
					_drillsergeant.add(spawn.getLastSpawn());
				else if (spawn.getNpcid() == studentId)
					_students.add(spawn.getLastSpawn());
	}
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		if (event.startsWith("basic_0"))
		{
			int value = Rnd.get(60);
			if (value < 3)
			{
				_social = 7;
				for (L2Npc drillsergeant : _drillsergeant)
				{
					drillsergeant.broadcastSocialAction(_social);
				}
				startQuestTimer("student_0", 4000, null, null);
			}
			else if (value < 10)
			{
				_social = 6;
				for (L2Npc drillsergeant : _drillsergeant)
				{
					drillsergeant.broadcastSocialAction(_social);
				}
				startQuestTimer("student_0", 4000, null, null);
			}
			else if (value < 40)
			{
				_social = 5;
				for (L2Npc drillsergeant : _drillsergeant)
				{
					drillsergeant.broadcastSocialAction(_social);
				}
				startQuestTimer("student_0", 2500, null, null);
			}
			else if (value < 55)
			{
				_social = Rnd.get(8,10);
				for (L2Npc drillsergeant : _drillsergeant)
				{
					drillsergeant.broadcastSocialAction(_social);
				}
				startQuestTimer("student_0", 4000, null, null);
			}
			else
			{
				startQuestTimer("basic_0", 3000, null, null);
			}
		}
		else if (event.startsWith("student_0"))
		{
			for (L2Npc student : _students)
			{
				student.broadcastSocialAction(_social);
			}
			startQuestTimer("basic_0", 5000, null, null);
		}
		return super.onAdvEvent(event, npc, player);
	}
	
	public static void main(String[] args)
	{
		new BasicTrainingCamp(-1, "BasicTrainingCamp", "ai");
	}
}
