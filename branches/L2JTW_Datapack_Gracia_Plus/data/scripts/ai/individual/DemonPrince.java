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

import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;

/**
 * ¬¼Ây­º»â ´cÅ]¤½Àï
 * @author RosT
 */

public class DemonPrince extends L2AttackableAIScript
{
	private static final int PRINCE = 25540;
	private static final int PRINCE_MIN = 25541; //Don't attacks players if they didn't attacked him. After 20 sec - BOOM!
	
	public int princestatus;
	
	public DemonPrince(int id, String name, String descr)
	{
		super(id, name, descr);
		addEventId(PRINCE, Quest.QuestEventType.ON_SPAWN);
		addEventId(PRINCE_MIN, Quest.QuestEventType.ON_SPAWN);
		addEventId(PRINCE, Quest.QuestEventType.ON_ATTACK);
		
	}
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		if (npc != null)
		{
			if (event.equalsIgnoreCase("time_to_suicide"))
			{
				npc.doCast(SkillTable.getInstance().getInfo(4529, 1)); //Use BOOM skill
				this.startQuestTimer("suicide", 1700, npc, null);
			}
			else if (event.equalsIgnoreCase("suicide"))
				npc.doDie(npc); //die
		}
		return "";
	}
	
	@Override
	public String onSpawn(L2Npc npc)
	{
		int npcId = npc.getNpcId();
		if (npcId == PRINCE_MIN)
			this.startQuestTimer("time_to_suicide", 20000, npc, null); //timer for kamikadze
		else if (npcId == PRINCE)
			princestatus = 0;
		return "";
	}
	
	@Override
	public String onAttack(L2Npc npc, L2PcInstance attacker, int damage, boolean isPet)
	{
		int npcId = npc.getNpcId();
		if (npcId == PRINCE)
		{
			int maxHp = npc.getMaxHp();
			double nowHp = npc.getStatus().getCurrentHp();
			//When 55%, 35%, 15%, 5% hp, use Ultimate Defense and spawns Suicides mobs (boom after 20 sec)
			if (nowHp < maxHp * 0.55 && princestatus == 0)
			{
				princestatus = 1;
				npc.doCast(SkillTable.getInstance().getInfo(5044, 2));
				for (int i = 0; i < 3; i++) //3 mobs
				{
					int radius = 300;
					int x = (int) (radius * Math.cos(i * 0.518));
					int y = (int) (radius * Math.sin(i * 0.518));
					addSpawn(PRINCE_MIN, npc.getX() + x, npc.getY() + y, npc.getZ(), 0, false, 0, false, npc.getInstanceId());
				}
			}
			else if (nowHp < maxHp * 0.35 && princestatus == 1)
			{
				princestatus = 2;
				npc.doCast(SkillTable.getInstance().getInfo(5044, 2));
				for (int i = 0; i < 4; i++) //4 mobs
				{
					int radius = 300;
					int x = (int) (radius * Math.cos(i * 0.718));
					int y = (int) (radius * Math.sin(i * 0.718));
					addSpawn(PRINCE_MIN, npc.getX() + x, npc.getY() + y, npc.getZ(), 0, false, 0, false, npc.getInstanceId());
				}
			}
			else if (nowHp < maxHp * 0.15 && princestatus == 2)
			{
				princestatus = 3;
				npc.doCast(SkillTable.getInstance().getInfo(5044, 2));
				for (int i = 0; i < 5; i++) //5 mobs
				{
					int radius = 300;
					int x = (int) (radius * Math.cos(i * 0.918));
					int y = (int) (radius * Math.sin(i * 0.918));
					addSpawn(PRINCE_MIN, npc.getX() + x, npc.getY() + y, npc.getZ(), 0, false, 0, false, npc.getInstanceId());
				}
			}
			else if (nowHp < maxHp * 0.5 && princestatus == 3)
			{
				princestatus = 4;
				npc.doCast(SkillTable.getInstance().getInfo(5044, 2));
				for (int i = 0; i < 6; i++) //6 mobs
				{
					int radius = 300;
					int x = (int) (radius * Math.cos(i * 0.918));
					int y = (int) (radius * Math.sin(i * 0.918));
					addSpawn(PRINCE_MIN, npc.getX() + x, npc.getY() + y, npc.getZ(), 0, false, 0, false, npc.getInstanceId());
				}
			}
		}
		return "";
	}
	
	public static void main(String[] args)
	{
		// now call the constructor (starts up the ai)
		new DemonPrince(-1, "DemonPrince", "ai");
	}
}