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

import com.l2jserver.gameserver.ai.CtrlIntention;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.network.serverpackets.MagicSkillUse;

/**
 * ¬¼Ây­º»â ³Ò®w
 * @author RosT
 */
public class Ranku extends L2AttackableAIScript
{
	private static final int RANKU = 25542;
	private static final int RANKU_SCAGEPOAT = 32305;
	private static final int EIDOLON = 25543;
	
	public Ranku(int id, String name, String descr)
	{
		super(id, name, descr);
		addEventId(RANKU, Quest.QuestEventType.ON_SPAWN);
		addEventId(RANKU_SCAGEPOAT, Quest.QuestEventType.ON_SPAWN);
		addEventId(EIDOLON, Quest.QuestEventType.ON_SPAWN);
		addEventId(RANKU, Quest.QuestEventType.ON_KILL);
	}
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		if (npc != null)
		{
			if (event.equalsIgnoreCase("time_to_poison"))
			{
				npc.broadcastPacket(new MagicSkillUse(npc, npc, 2357, 1, 1000, 0)); //Just for animation of poison
				npc.reduceCurrentHp(300, npc, null); //reduce hp
				if (npc.getCurrentHp() < 300)
				{
					npc.doDie(npc); //die
					addSpawn(EIDOLON, npc.getX(), npc.getY(), npc.getZ(), 0, false, 0, false, npc.getInstanceId()); //spawn Eidolon
					return "";
				}
				this.startQuestTimer("time_to_poison", 15000, npc, null); //timer for reduce hp
			}
			else if (event.equalsIgnoreCase("time_to_more_eidolon"))
				addSpawn(EIDOLON, npc.getX(), npc.getY(), npc.getZ(), 0, false, 0, false, npc.getInstanceId()); //one more Eidolon
		}
		return "";
	}
	
	@Override
	public String onSpawn(L2Npc npc)
	{
		int npcId = npc.getNpcId();
		if (npcId == RANKU)
		{
			for (int i = 0; i < 3; i++) //3 npc
			{
				int radius = 300;
				int x = (int) (radius * Math.cos(i * 0.718));
				int y = (int) (radius * Math.sin(i * 0.718));
				L2Npc min = addSpawn(RANKU_SCAGEPOAT, npc.getX() + x, npc.getY() + y, npc.getZ(), 0, false, 0, false, npc.getInstanceId());
				min.getAI().setIntention(CtrlIntention.AI_INTENTION_FOLLOW, npc);
			}
		}
		else if (npcId == RANKU_SCAGEPOAT)
			this.startQuestTimer("time_to_poison", 15000, npc, null); //timer for reduce hp
		else if (npcId == EIDOLON)
			this.startQuestTimer("time_to_more_eidolon", 30000, npc, null); //timer for spawn more Edolon
		return "";
	}
	
	@Override
	public String onKill(L2Npc npc, L2PcInstance killer, boolean isPet)
	{
		if (npc.getNpcId() == RANKU)
		{
			cancelQuestTimers("time_to_more_eidolon");
			cancelQuestTimers("time_to_poison");
		}
		return "";
	}
	
	public static void main(String[] args)
	{
		// now call the constructor (starts up the ai)
		new Ranku(-1, "Ranku", "ai");
	}
}